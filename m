From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-pull.txt: Add picture to --rebase option
Date: Fri, 03 Dec 2010 11:35:38 -0800
Message-ID: <7v62vaps39.fsf@alter.siamese.dyndns.org>
References: <1291365669-10439-1-git-send-email-jari.aalto@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jari.aalto@cante.net
X-From: git-owner@vger.kernel.org Fri Dec 03 20:35:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PObQC-0006yQ-0A
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 20:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853Ab0LCTfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 14:35:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40718 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab0LCTfr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 14:35:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DAD77280A;
	Fri,  3 Dec 2010 14:36:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sU7OT2m5snXj5GwITY5X+L8r6Gs=; b=xO3Jpz
	qzic/wHNvOCZTy6mhlKwAJA66OohH8voEaSSpsONvAJflqQ2Dk6OdD+PMS8lLvAd
	IVvh2D/dzJKsc4QEhNlQKtYFqa3sPWHI3Rh7rC/sxmJAX0hfu6yvYJR8j+vzD33j
	8N2eiq7f02j0GmtDXLSXBjwUmIsugz5A1f1Hs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SrvXglJO3U5rKRramLlGLqG0aki2L0Y5
	5WRqI7zWq8tzJdO2QoC2pLOlxt8UFSiFnucPP3mmY60LyZ53AxtDFhLoh2UenIHC
	zu4VoMhzatWaFEKjp/p/6aFQYpps2xZXh7zDergWqoBh8lUcR4+R+RKgBjjC7m6U
	KjM2fU5hboY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B81022809;
	Fri,  3 Dec 2010 14:36:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A0EB82807; Fri,  3 Dec 2010
 14:36:00 -0500 (EST)
In-Reply-To: <1291365669-10439-1-git-send-email-jari.aalto@cante.net> (jari
 aalto's message of "Fri\,  3 Dec 2010 10\:41\:09 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 90BD4400-FF14-11DF-97A0-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162837>

jari.aalto@cante.net writes:

> From: Jari Aalto <jari.aalto@cante.net>
>
> Illustrate what are the effects of the the option.
>
> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> ---
>  Documentation/git-pull.txt |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index e47361f..25eb6de 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -106,6 +106,18 @@ This is a potentially _dangerous_ mode of operation.
>  It rewrites history, which does not bode well when you
>  published that history already.  Do *not* use this option
>  unless you have read linkgit:git-rebase[1] carefully.
> ++
> +The effects of this option are:
> +------------
> +    [initial]
> +    o---o---o---A--B   Your work in commit A and B
> +
> +    [git pull --rebase]
> +    o---o---o---*---*--A--B
> +                |   |
> +                New updates merged in. Your work is rebased
> +                on top of them.
> +------------

While I think it is a good idea to have an illustration for pull-rebase, I
am not happy with the above drawing.

An obvious nit is the wording "merged in", but more importantly, the
reader won't be told three important facts about what you are trying to
illustrate:

 - how these two '*' originally happened;
 - how they are preserved across the operation; as opposed to
 - how your own A and B are rewritten.

Also I do not think it is necessary to introduce an initial state separate
from the one we already have established earlier in the documentation;
it will reduce the mental burden of the readers if we set the stage only
once, and show two different outcomes starting from that same state.

It would be better to add something like the following after the first
illustration on the page that shows how the default `git pull`
consolidates the histories by creating a merge commit `H`, immediately
after "See linkgit:git-merge[1] for details,...".

    [NOTE] 
    The command can also be told to consolidate your work on top of what
    the other side did by rebasing, instead of merging, with `git pull
    --rebase`.  Starting from the same state as illustrated above, it
    would create a new history like the following picture by rewriting
    your commits F and G to sit on top of the history the other side
    created:

              A---B---C master on origin
             /         \
        D---E---F---G   F'--G' master

    Your original commits F and G are abandoned to be garbage collected,
    and your `master` branch will point at the tip of the rewritten
    history.

Note that I did *NOT* run AsciiDoc on the above---this is not a suggestion
on formatting, but on the contents.
