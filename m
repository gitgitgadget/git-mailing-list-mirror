From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule update: document the '--checkout' option
Date: Fri, 28 Feb 2014 13:39:32 -0800
Message-ID: <xmqqbnxqudbf.fsf@gitster.dls.corp.google.com>
References: <20140225110316.GU11566@login.drsnuggles.stderr.nl>
	<530FB5C4.8080400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthijs Kooijman <matthijs@stdin.nl>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Feb 28 22:39:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJV9s-00045H-La
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 22:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbaB1Vjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 16:39:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34875 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729AbaB1Vjr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 16:39:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8D206E30E;
	Fri, 28 Feb 2014 16:39:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BOKndEqbOqccvy99pwmgA9Lcib0=; b=gzCemD
	sy0J8MuzwVcPgLLzGtL2RL586hnh1ERdF6yaVSEZu3il5Q9TJLWSh5s1uT/staYE
	B9NGDMkzOtmJvuCmhMfNtXA4mPdEOvTPkCSGCFRgjBfJMZF6wrXHoFOA9sirwBxf
	LcAj6wGVpfdkLcdxMgQVPSnNaaSGeXmSymv/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A1awBGaR3EDGWGRFibKQLSpwh3AuC3n4
	lh1E6nDQqLA6op/c8nynzFxGZ1nM1efWCbZSSOBdSMX4PhNBFpIMDvdaHw5fvrnM
	KRWNIrNF/8SvHC5HVSEp3HV+xpTfmfyB08QgcVQZnwl23u2zPZ/Sv8/vyemmEn6X
	1SIvNKIO2fo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52F0D6E30A;
	Fri, 28 Feb 2014 16:39:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A9BF6E304;
	Fri, 28 Feb 2014 16:39:41 -0500 (EST)
In-Reply-To: <530FB5C4.8080400@web.de> (Jens Lehmann's message of "Thu, 27 Feb
	2014 22:01:40 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D4CFACCC-A0C0-11E3-8ADE-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243019>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Good point. What about this?
>
>
>  Documentation/git-submodule.txt | 13 +++++++++++--
>  git-submodule.sh                |  2 +-
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index bfef8a0..9054217 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -15,8 +15,8 @@ SYNOPSIS
>  'git submodule' [--quiet] init [--] [<path>...]
>  'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
>  'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
> -	      [-f|--force] [--rebase] [--reference <repository>] [--depth <depth>]
> -	      [--merge] [--recursive] [--] [<path>...]
> +	      [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>]
> +	      [--depth <depth>] [--recursive] [--] [<path>...]

This has already been done by 23d25e48 (submodule: explicit local
branch creation in module_clone, 2014-01-26).  That commit also adds
some text to the description of 'update' subcommand, but not a
separate entry for '--checkout' mode.

Does the result of applying this patch except for this particular
hunk still make sense as a whole?  It appears to me that it does,
but just to double check...

Thanks.

>  'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
>  	      [commit] [--] [<path>...]
>  'git submodule' [--quiet] foreach [--recursive] <command>
> @@ -287,6 +287,15 @@ SHA-1.  If you don't want to fetch, you should use `submodule update
>  	This option is only valid for the update command.
>  	Don't fetch new objects from the remote site.
>
> +--checkout::
> +	This option is only valid for the update command.
> +	Checkout the commit recorded in the superproject on a detached HEAD
> +	in the submodule. This is the default behavior, the main use of
> +	this option is to override `submodule.$name.update` when set to
> +	`merge`, `rebase` or `none`.
> +	If the key `submodule.$name.update` is either not explicitly set or
> +	set to `checkout`, this option is implicit.
> +
>  --merge::
>  	This option is only valid for the update command.
>  	Merge the commit recorded in the superproject into the current branch
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 4a30087..65cf963 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -9,7 +9,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
>     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] init [--] [<path>...]
>     or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
> -   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
> +   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
>     or: $dashless [--quiet] foreach [--recursive] <command>
>     or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
