From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Amend git-push refspec documentation
Date: Mon, 21 Apr 2008 22:48:49 -0700
Message-ID: <7vk5iq5tj2.fsf@gitster.siamese.dyndns.org>
References: <1208748684-28253-1-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: guillaume@catalyst.net.nz, git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Apr 22 07:49:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoBNz-0001fh-KA
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 07:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbYDVFtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 01:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752850AbYDVFtA
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 01:49:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40107 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbYDVFs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 01:48:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6038B2DC1;
	Tue, 22 Apr 2008 01:48:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7AE4D2DC0; Tue, 22 Apr 2008 01:48:51 -0400 (EDT)
In-Reply-To: <1208748684-28253-1-git-send-email-sam.vilain@catalyst.net.nz>
 (Sam Vilain's message of "Mon, 21 Apr 2008 15:31:24 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80061>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> These paragraphs are a little confusing.  Also, make it clearer when
> you have to specify the full name for <dst>
>
> Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
> ---
>  Documentation/git-push.txt |   22 ++++++++++++----------
>  1 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 3128170..b3d164e 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -35,14 +35,14 @@ OPTIONS
>  	by the source ref, followed by a colon `:`, followed by
>  	the destination ref.
>  +
> -The <src> side can be an
> -arbitrary "SHA1 expression" that can be used as an
> -argument to `git-cat-file -t`.  E.g. `master~4` (push
> -four parents before the current master head).
> +The <src> side represents the source branch (or arbitrary
> +"SHA1 expression"; see linkgit:git-rev-parse[1]) that you want to
> +push.  The <dst> side represents the destination location.
>  +

Hmm.  We lost an example but refer to a more authoritative information,
which is probably Ok.

>  The local ref that matches <src> is used
> -to fast forward the remote ref that matches <dst>.  If
> -the optional plus `+` is used, the remote ref is updated
> +to fast forward the remote ref that matches <dst> (or, if no <dst> was
> +specified, the same ref that <src> referred to locally).  If
> +the optional leading plus `+` is used, the remote ref is updated
>  even if it does not result in a fast forward update.
>  +

That's an improvement.

> @@ -179,9 +180,10 @@ git push origin master:satellite/master::
>  
>  git push origin master:refs/heads/experimental::
>  	Create the branch `experimental` in the `origin` repository
> -	by copying the current `master` branch.  This form is usually
> -	needed to create a new branch in the remote repository as
> -	there is no `experimental` branch to match.
> +	by copying the current `master` branch.  This form is only
> +	needed to create a new branch in the remote repository when
> +	the local name and the remote name are different; otherwise,
> +	the branch name on its own will work.

Note that writing "refs/tags/xprm" instead would allow you to create a
lightweight tag over there.
