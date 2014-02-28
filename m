From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: proposed command missing leading dash
Date: Fri, 28 Feb 2014 15:31:32 -0800
Message-ID: <xmqq38j2u84r.fsf@gitster.dls.corp.google.com>
References: <1393620766-17582-1-git-send-email-sandy.carter@savoirfairelinux.com>
	<20140228214140.GP7855@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sandy Carter <sandy.carter@savoirfairelinux.com>,
	git@vger.kernel.org, jn.avila@free.fr,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 00:31:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJWu5-0002zz-Cj
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 00:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbaB1Xbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 18:31:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38248 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787AbaB1Xbh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 18:31:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A84806ED7B;
	Fri, 28 Feb 2014 18:31:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QHiE7r+p0qx/eYF1cvrpBVVCqDM=; b=TUtzOU
	tlROEoqNmUTTCvGjBcv9b4zi/iyhu2tdiypxhQLMtPFbWiQoDFi0EpPyBLe745KF
	QwtbqWsU+Jxbr896WzL48//CQ1r1ykdJiz74khRVVDllAiYxxZYgXWCTrILvc391
	AoEl64DJ14e3hG1XgoLXFj3mdddBU8vlSM4Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qAmyCDepwfsHQx3SB+4/DFpvt4+AJ+qm
	zGChwAqgWaWdqWhLmG7ow/XXAnmFLt64tXD9jaS9slSkP/VjIsF/bNukcufnunWs
	70Y7zHkbc6otsyTkMiqpoJILAdp0ALkXPAT7d5SBwa6M0dy6V7tVI89Z1QTT9zdZ
	KvF8666x2tU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F6F66ED7A;
	Fri, 28 Feb 2014 18:31:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3B476ED76;
	Fri, 28 Feb 2014 18:31:35 -0500 (EST)
In-Reply-To: <20140228214140.GP7855@google.com> (Jonathan Nieder's message of
	"Fri, 28 Feb 2014 13:41:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 76D9B620-A0D0-11E3-857B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243028>

Jonathan Nieder <jrnieder@gmail.com> writes:

> To make life saner for translators, this should be either
> untranslatable or a single multi-line string, I suspect:
>
> diff --git i/builtin/branch.c w/builtin/branch.c
> index b4d7716..972040c 100644
> --- i/builtin/branch.c
> +++ w/builtin/branch.c
> @@ -1022,11 +1022,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		 */
>  		if (argc == 1 && track == BRANCH_TRACK_OVERRIDE &&
>  		    !branch_existed && remote_tracking) {
> -			fprintf(stderr, _("\nIf you wanted to make '%s' track '%s', do this:\n\n"), head, branch->name);
> -			fprintf(stderr, _("    git branch -d %s\n"), branch->name);
> -			fprintf(stderr, _("    git branch --set-upstream-to %s\n"), branch->name);
> +			fprintf(stderr, "\n");
> +			fprintf(stderr, _("If you wanted to make '%s' track '%s', do this:\n\n"
> +					  "    git branch -d %s\n"
> +					  "    git branch --set-upstream-to %s"),
> +					head, branch->name, branch->name, branch->name);
> +			fprintf(stderr, "\n");
>  		}
> -
>  	} else
>  		usage_with_options(builtin_branch_usage, options);
>  
> What do you think?

Yes, I think it is sensible to make sure that the command examples
are not corrupted by the _() process.
