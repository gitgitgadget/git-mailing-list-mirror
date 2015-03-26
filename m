From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: Clarify what git-rebase's "--preserve-merges" does
Date: Thu, 26 Mar 2015 11:18:48 -0700
Message-ID: <xmqqd23vzkon.fsf@gitster.dls.corp.google.com>
References: <CAHGBnuO5Y=ejJLxktk0GsnXx8h2LwPW1i7TqDePhfZ_zLR_X9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 19:19:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbCMr-0008Hw-ID
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 19:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbbCZSSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 14:18:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752086AbbCZSSv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 14:18:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F4081C05B;
	Thu, 26 Mar 2015 14:18:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HwO3ZCeVLLBTEyCuNtjmo9HCsCE=; b=fnpduo
	GSzquU+HPlMeTVs8jf/VEcCflqW3UvuOjZjmi3fNX67lsinVBMGT6Revro3K4BjE
	rVEKkQOhiQUvt5eRzuOfwiXTZ39IuQTr1oQRALeOZ5tA9opR/pvT6x3+lfM+Vh98
	86fQLnEqsMOlSRAFmRPd0rg/ITggryzbUqqJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aYmLC/nRqHGw37+zV9IcPh/LNUvu7xmY
	h5Si9NOjJbLWIaceBzAE2pBJuOdOUvE55Sjq1b8tM4SJqr4MR4lJKg3Nh8LwL21F
	OVECiCxq6gFsgT2uVPpMrAClFDtMH7B5hUdPP/UTeSBguDUBbJLYeKI5LlLWGtPC
	j3RBcBVzBC4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9776C1C05A;
	Thu, 26 Mar 2015 14:18:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17FC51C059;
	Thu, 26 Mar 2015 14:18:50 -0400 (EDT)
In-Reply-To: <CAHGBnuO5Y=ejJLxktk0GsnXx8h2LwPW1i7TqDePhfZ_zLR_X9A@mail.gmail.com>
	(Sebastian Schuberth's message of "Thu, 26 Mar 2015 14:04:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8D182050-D3E4-11E4-B5AE-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266340>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Also, do not say that merge commits are *tried* to be recreated.

Good point.  "We will try but it might fail" is better left unsaid
as that is true almost everywhere.


> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  Documentation/git-rebase.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index d728030..3a6d139 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -362,7 +362,7 @@ default is `--no-fork-point`, otherwise the
> default is `--fork-point`.
>
>  -p::
>  --preserve-merges::
> -    Instead of ignoring merges, try to recreate them.
> +    Recreate merge commits instead of replaying commits a merge
> commit introduces.

Hmm, is this line-wrapped?

Although I fully agree that the new text is better than the original,
I think the new text fails to point out one major aspect by not
mentioning "linear" or "flatten" anywhere.  The point of "git rebase"
without "-p" is not just to replay but to flatten

	Instead of flattening the history by replaying each
	non-merge commit to be rebased, preserve the shape of the
	rebased history by recreating merge commits as well.

or something along that line, perhaps?

This reminds me a related tangent discussion we had long time ago (I
thought j6t was involved hence a new Cc:, but my apologies to j6t if
I am misremembering), about what exactly is "recreate merges instead
of replaying commits".

I think the current preserve-merges considers everything between
<upstream> and <branch> as "commits to be rebased", and recreate
merges across these rebased tips of branches that are merged.  There
however were repeated wishes (or wishful misunderstandings ;-) that
there were a mode to rebuild the trunk, considering only the commits
on the first-parent chain as "commits to be rebased", recreating the
history by replaying the merge commits (whose first parent might be
rewritten during the rebase, but the tips of side branches these
merges bring into the history are kept intact).

Surely there is no such mode right now, but I am fairly sure that I
wouldn't have any objection against a patch to implement such a
feature (perhaps "--first-parent --preserve-merges"?), and with or
without such a feature in the system, I would be happier if we made
sure that the description we are discussing to update makes it clear
that the current behaviour is "everything between <upstream> and
<branch>", and cannot be misread as "do not touch side branches
instead of dropping merged commits".

>  +
>  This uses the `--interactive` machinery internally, but combining it
>  with the `--interactive` option explicitly is generally not a good
