From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: Document the "--[no-]recurse-submodules"
 options
Date: Mon, 07 Feb 2011 13:42:31 -0800
Message-ID: <7vsjvzttbs.fsf@alter.siamese.dyndns.org>
References: <4D4C5EBC.2090100@web.de> <201102042326.08607.j6t@kdbg.org>
 <4D4D33E7.4000303@web.de> <7vipwwx56r.fsf@alter.siamese.dyndns.org>
 <4D4F19D0.2000408@web.de> <20110206220939.GC17210@elie>
 <4D4F273C.8030003@web.de> <20110207074157.GA2736@elie>
 <4D5047BD.6030304@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 07 22:42:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmYrH-0007Yc-UC
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 22:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754958Ab1BGVms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 16:42:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40930 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab1BGVmr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 16:42:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 881B547D4;
	Mon,  7 Feb 2011 16:43:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sl8fJ7sSdP4RPWUYaGyWawz4zTo=; b=EWaCxy
	mYCzl8B/4Retx/B3lSZFHNjsc2NBxLp4NInGGKydmNdEPHsLqw6cJ3xmo7wa25LF
	Lt9sPdRLi+kuiQYIjF86hshJ7qswhEE6Y9wfdQxGZDI2Sj79+ygEp+6ALeWSrjQ8
	94G3sFLhB00zomrLO5MNV3ftJ+YsGyPllZJ84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tZPmMUVPW82/FS3FEWZxGOylKHKVryMK
	O2IIlushC5M0B4sQT8cyb6ME3XzkmNT9XloQ7Yei7b0ceae8V7LJt7PzXQQmmpAr
	hckK8ZY3bnDV1Nut3ez0EKbZfeTffk9Al2JlySktISSA/EsDYOB28oY8nJPQJLXM
	zGk6CaFWBGM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 43B2647CE;
	Mon,  7 Feb 2011 16:43:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 71E5E47CA; Mon,  7 Feb 2011
 16:43:31 -0500 (EST)
In-Reply-To: <4D5047BD.6030304@web.de> (Jens Lehmann's message of "Mon\, 07
 Feb 2011 20\:27\:57 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 51DA697A-3303-11E0-88C3-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166301>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index 695696d..ab0dbfc 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -64,11 +64,11 @@ ifndef::git-pull[]
>  	downloaded. The default behavior for a remote may be
>  	specified with the remote.<name>.tagopt setting. See
>  	linkgit:git-config[1].
> -endif::git-pull[]
>
>  --[no-]recurse-submodules::
>  	This option controls if new commits of all populated submodules should
>  	be fetched too (see linkgit:git-config[1] and linkgit:gitmodules[5]).
> +endif::git-pull[]
>
>  ifndef::git-pull[]
>  --submodule-prefix=<path>::

Hmph, why not enclose the three of them inside a single ifndef here?

> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index 3046691..b33e6be 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -84,6 +84,15 @@ must be given before the options meant for 'git fetch'.
>  --verbose::
>  	Pass --verbose to git-fetch and git-merge.
>
> +--[no-]recurse-submodules::
> +	This option controls if new commits of all populated submodules should
> +	be fetched too (see linkgit:git-config[1] and linkgit:gitmodules[5]).
> +	That might be necessary to get the data needed for merging submodule
> +	commits, a feature git learned in 1.7.3. Notice that the result of a
> +	merge will not be checked out in the submodule, "git submodule update"
> +	has to be called afterwards to bring the work tree up to date with the
> +	merge result.

Ok.
