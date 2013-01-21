From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetools: Add tortoisegitmerge helper
Date: Sun, 20 Jan 2013 16:43:59 -0800
Message-ID: <7v4nibjrg0.fsf@alter.siamese.dyndns.org>
References: <50FBD4AD.2060208@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>,
	davvid@gmail.com, Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Mon Jan 21 01:44:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx5V0-0004un-Gg
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 01:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582Ab3AUAoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 19:44:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55802 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752495Ab3AUAoG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 19:44:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4A87BDE3;
	Sun, 20 Jan 2013 19:44:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B2pahR8YItzhBr03Uc3Pl4pZX1I=; b=pzfMxr
	PNLzTVQf7Xb1U1kZ7TP0Q2mYpLpDvQvYmpyLzNafI9uS79CgiHV2b3uj7Fz+Nch7
	RqqDMYMCPyW1+sQRZE3XhSQDetjqdJiihumRFgP5sfPkL9WXQRgiGGPGq4BJE5+Q
	BPscDZPCGTRPMwZ2Teg5NXSosBci33Oye1nFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hkd58UTNxZzeCq2K6jbKOxSvPInbwWZB
	+BfxQ+AzT9oP3lCXNV8b+IhZf2tPv4wuIRMHRlsrzqVX2ZB5ALA88NkZ4wNLJs+w
	QjwEc2kalsNwrUlK4C0TCuMOuGvp4Dk21Eyumvi6plbrOZfqEMqCLj3jblkvmcWQ
	wEboxL2jFT8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11BE1BDE2;
	Sun, 20 Jan 2013 19:44:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25E81BDDC; Sun, 20 Jan 2013
 19:44:02 -0500 (EST)
In-Reply-To: <50FBD4AD.2060208@tu-clausthal.de> (Sven Strickroth's message of
 "Sun, 20 Jan 2013 12:27:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A68C0A0E-6363-11E2-8F97-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214062>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> - The TortoiseGit team renamed TortoiseMerge.exe to TortoiseGitMerge.exe
>   (starting with 1.8.0) in order to make clear that this one has special
>   support for git and prevent confusion with the TortoiseSVN TortoiseMerge
>   version.
> - The tortoisemerge mergetool does not work with filenames which have
>   a space in it. Fixing this required changes in git and also in
>   TortoiseGitMerge; see https://github.com/msysgit/msysgit/issues/57.
>
> The new tortoisegitmerge helper was added so that people can still use
> TortoiseMerge from TortoiseSVN (and older TortoiseGit versions).
>
> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> Reported-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---

Applying: mergetools: Add tortoisegitmerge helper
fatal: corrupt patch at line 56

That comes from here:

> diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
> index 9bb4956..a047646 100644
> --- a/Documentation/merge-config.txt
> +++ b/Documentation/merge-config.txt
> @@ -55,9 +55,9 @@ merge.tool::
>  	Controls which merge resolution program is used by
>  	linkgit:git-mergetool[1].  Valid built-in values are: "araxis",
>  	"bc3", "diffuse", "ecmerge", "emerge", "gvimdiff", "kdiff3", "meld",
> -	"opendiff", "p4merge", "tkdiff", "tortoisemerge", "vimdiff"
> -	and "xxdiff".  Any other value is treated is custom merge tool
> -	and there must be a corresponding mergetool.<tool>.cmd option.
> +	"opendiff", "p4merge", "tkdiff", "tortoisegitmerge", "tortoisemerge",
> +	"vimdiff" and "xxdiff".  Any other value is treated is custom merge
> +	tool and there must be a corresponding mergetool.<tool>.cmd option.
>   merge.verbosity::
>  	Controls the amount of output shown by the recursive merge
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash

Notice that we have three pre-context lines but only two
post-context lines for this hunk.  There is one context line missing
at the end of this hunk.

I'd usually try to queue a corrupt patch by manually fixing up when
it is a trivial corruption, but a corruption that _loses_ lines is
too dangerous to be handled that way.  There may be additions in
other hunks you wanted to make that were lost for the same reason
why the post-context line was lost here, and my fix-up would end up
committing a wrong patch.

Please investigate how this happened, and re-send after hearing
reviews from others.

Thanks.
