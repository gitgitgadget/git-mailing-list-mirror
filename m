From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: don't mark options of recurse-submodules for translation
Date: Tue, 22 Dec 2015 14:14:47 -0800
Message-ID: <xmqqfuyuceqw.fsf@gitster.mtv.corp.google.com>
References: <1450806780-16822-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, worldhello.net@gmail.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 23:14:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBVCs-0001pY-Qr
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 23:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147AbbLVWOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 17:14:52 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53832 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755105AbbLVWOu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 17:14:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2C050374A9;
	Tue, 22 Dec 2015 17:14:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HqfMppEcAHDUptbdeh3Ob82AOrE=; b=EUOBCX
	KSKmRdgycD2s/MVhuZLzVm1gzE1rfAMheOzQiX04KEcEC+SSBp9MoWDvI10SPaeo
	5ssS8hVtMV0vT5toNF7mfcEZBetG2RiZ+Ji45/vlmbtBD2cUTdEG4pR44kXfNg6/
	yNN08lqB9wh4YPHRR21HzeTjwGS7nQSIqYHXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=inxN33VWjaCEtRzgRFQ/2W2VS8/Nv5la
	E/LF0uxQc0znkwAuTfC02HrUyPGk16SxZO4FUNcoPMINnGUmH2LXTqyix2AIGu7W
	xGAw5Cyjwrz3u6d9y1NKdmMuYxUG/TUpaPa9F+t2BGAyOVT7TUbWx/LhzRMmwNTD
	4hWQbNX0QOU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 23187374A8;
	Tue, 22 Dec 2015 17:14:49 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9BAEF374A6;
	Tue, 22 Dec 2015 17:14:48 -0500 (EST)
In-Reply-To: <1450806780-16822-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Tue, 22 Dec 2015 18:53:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6A2FD5B6-A8F9-11E5-889F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282913>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  builtin/push.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index cc29277..8963dbd 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -547,7 +547,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  		  0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
>  		  N_("require old value of ref to be at this value"),
>  		  PARSE_OPT_OPTARG, parseopt_push_cas_option },
> -		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, N_("check|on-demand|no"),
> +		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, "check|on-demand|no",
>  			N_("control recursive pushing of submodules"),
>  			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
>  		OPT_BOOL( 0 , "thin", &thin, N_("use thin pack")),

Makes sense.  I should redo the -rc2 with this patch in.

Thanks.
