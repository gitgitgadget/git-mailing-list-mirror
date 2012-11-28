From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule update: document exisiting -r form for
 --rebase
Date: Wed, 28 Nov 2012 11:02:45 -0800
Message-ID: <7vboehv9d6.fsf@alter.siamese.dyndns.org>
References: <0450c75cbab3119ea830e8e8e3484649062377d8.1354127227.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Wed Nov 28 20:03:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdmuW-00010z-75
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 20:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753750Ab2K1TCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 14:02:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60353 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807Ab2K1TCs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 14:02:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C23388F46;
	Wed, 28 Nov 2012 14:02:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ibP5Q2QnXnjAfycx3LfVcAiVA7U=; b=IZRko8
	1xXIfqD3YTVk/z+D9l2KThCKosor4LHlOVJ2UCSlWS+pcE13h/qYR8aVx62gCNEP
	56hFJs4D0FD6gBFa4h7jayd7v22q8RrvdhWINQcuYS4AGBGixqnnDxEfbKYiKNP+
	Wi4LEL+jPJWsRfsb2WyC1oI2Dsi9+y+HO/FeY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vH62X+QPeur/HnhLBYMiPMpobRkz9o2D
	RjWWHzf9npZMHzhxcnZZb4YJvrNj5XGUiulk8iuT7bwpcr/l2TobC9V3BfWj2mqM
	tCDL/jehtSkqO1tBAjRgmo3qkSR8AgOxN3mDMIqEJGeRUqBSARrYd5/RoyII6uhX
	fLRtwmI/ruU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF1598F45;
	Wed, 28 Nov 2012 14:02:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 147B58F44; Wed, 28 Nov 2012
 14:02:46 -0500 (EST)
In-Reply-To: <0450c75cbab3119ea830e8e8e3484649062377d8.1354127227.git.wking@tremily.us>
 (W. Trevor King's message of "Wed, 28 Nov 2012 13:28:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 328F0812-398E-11E2-B692-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210760>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  Documentation/git-submodule.txt | 3 ++-
>  git-submodule.sh                | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Hmm, I wonder why I have this funny feeling that this was proposed
and rejected already...

As the command takes other options whose names begin with 'r', I
thought the longer term plan was to stop letting "--rebase" squat on
short and sweet "-r" and leaving it undocumented (even though the
short one was added by mistake) was meant to be the first step in
that process.

But maybe I am confusing an undocumented single-letter option from
some other subcommand.  Anybody remembers?

> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index b4683bb..ec78fa7 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>  	      [--reference <repository>] [--] <repository> [<path>]
>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] init [--] [<path>...]
> -'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
> +'git submodule' [--quiet] update [--init] [-N|--no-fetch] [-r|--rebase]
>  	      [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
>  	      [commit] [--] [<path>...]
> @@ -251,6 +251,7 @@ OPTIONS
>  	If the key `submodule.$name.update` is set to `merge`, this option is
>  	implicit.
>  
> +-r::
>  --rebase::
>  	This option is only valid for the update command.
>  	Rebase the current branch onto the commit recorded in the
> diff --git a/git-submodule.sh b/git-submodule.sh
> index ab6b110..f2e8026 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -8,7 +8,7 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
>  USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <repository> [<path>]
>     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] init [--] [<path>...]
> -   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
> +   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [-r|--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
>     or: $dashless [--quiet] foreach [--recursive] <command>
>     or: $dashless [--quiet] sync [--] [<path>...]"
