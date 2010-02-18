From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] Documentation/git-pull.txt: mention --quiet and
 --verbose for fetching
Date: Thu, 18 Feb 2010 13:11:55 -0800
Message-ID: <7vhbpe5jvo.fsf@alter.siamese.dyndns.org>
References: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
 <1266496631-3980-2-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	"Jeff King" <peff@peff.net>, "Sebastian Thiel" <byronimo@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 22:12:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiDfU-0006UM-Lz
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 22:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618Ab0BRVML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 16:12:11 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34418 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab0BRVMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 16:12:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D8D39A0AD;
	Thu, 18 Feb 2010 16:12:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hzSF2GrbDA5VYYXieushepS1hx0=; b=n/KX/2
	3fVj3a8nCB2iNyxjoxL8rfWD9/Hf2q8EjSbynTyWczViHBxicBf6qUgq/8Aowrwv
	6Ai+/une/UIWZ43k/nfWxkfSh1KCymxErl7uAaIP2DJOKiB9v46EKWXAGQ45lgCV
	lxednVJ9rUSQ6DWUxUhdsZA/B7O2kR2fF3/5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gOkW9Pau1urLZ1oOb2Oik96/pyCb4l7+
	DRVfsFpIBiX3sLiO/kNg8zlkSyPmjGlAOvDcGmhcy/zqKvbwAXTLHlxAH/Jx3wYW
	+ED+W9/rStnvhaEJ/B1O9gfF10CzDIoy4ZSLLcnk8ChE4P3N3Bu2VBnhwO25/vRU
	M5+w7odaPTM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CF6E9A0A9;
	Thu, 18 Feb 2010 16:12:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 307529A0A2; Thu, 18 Feb
 2010 16:11:56 -0500 (EST)
In-Reply-To: <1266496631-3980-2-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Thu\, 18 Feb 2010 20\:37\:02 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4291A5E8-1CD2-11DF-8755-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140381>

Tay Ray Chuan <rctay89@gmail.com> writes:

> This reverts 90e4311 (git-pull: do not mention --quiet and --verbose
> twice, Mon Sep 7 2009).
>
> Then, the subtitles "Options related to merging" and "Options related to
> fetching" weren't present, and the options for git-merge and git-fetch
> options were in a monolithic block.
>
> After 3f7a9b5 (Documentation/git-pull.txt: Add subtitles above included
> option files, Thu Oct 22 2009), it is ok to repeat options in the
> same document, since they are distinguished between those for git-merge
> and git-fetch.
>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

As the result of the change history, currently we mention -q/-v as if it
only applies to the invocation of merge, giving an incorrect impression
that they won't affect the invocation of fetch.

While I agree that is a valid issue to address, I am not sure if repeating
these in two sections is a good solution.  A reader will start scanning
the OPTIONS section, finds -q (or -v) and notices it is listed in the
"related to merging" subsection, and would stop there.  This change would
not help such a reader.

It may make more sense to list the options that affects both fetch and
merge at the beginning of the OPTIONS section before the merge/fetch
subsections.  IOW, instead of removing ifndef::git-pull[] like your patch
did, it would add ifndef::git-pull[] in the list of options on the merge
side, and add pull specific description (e.g. "this is passed to both
underlying fetch to squelch progress output of transfer, and underlying
merge to squelch the output during the merging") in git-pull.txt.

>  Documentation/fetch-options.txt |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index fe716b2..83606f4 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -74,7 +74,6 @@ endif::git-pull[]
>  	the command to specify non-default path for the command
>  	run on the other end.
>  
> -ifndef::git-pull[]
>  -q::
>  --quiet::
>  	Pass --quiet to git-fetch-pack and silence any other internally
> @@ -83,4 +82,3 @@ ifndef::git-pull[]
>  -v::
>  --verbose::
>  	Be verbose.
> -endif::git-pull[]
> -- 
> 1.7.0.27.g5d71b
