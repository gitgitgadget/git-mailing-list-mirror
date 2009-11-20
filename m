From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] user-manual: Document that "git merge" doesn't like
 uncommited changes.
Date: Fri, 20 Nov 2009 12:19:40 -0800
Message-ID: <7vk4xlvtib.fsf@alter.siamese.dyndns.org>
References: <1258732767-12741-1-git-send-email-Matthieu.Moy@imag.fr>
 <1258732767-12741-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Nov 20 21:20:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBZxV-00056s-Gn
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 21:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215AbZKTUTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 15:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754160AbZKTUTm
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 15:19:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61771 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724AbZKTUTl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 15:19:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 523D3815A6;
	Fri, 20 Nov 2009 15:19:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8UDy9EOeO7E8zntF1VvSEl8IYMU=; b=m+hn7d
	zzfO9Wc0IMTC5dIHOaNAptkkeM+dDiUBUPBoEV9MnUQoyeTz3lx8I4N7WVJv4qNP
	JoaSi6DfHuKWiXTzdRW3nQNy/DPxR1HQUUc1ojdm1UnnTYJDAdQZexCBRhqcP5H8
	1cBcXZEOzByG0bw/lBAdQTbQzNfNE+Xl1CJso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jVPoeNC4gLZ0AXPSRgRL7jCgB61aINV5
	vidxcB2lFbCmxEIqQTKBcM+DKYtRjPPvVHCqDQkJwILNndAfONN/VTwzUW9nBNuA
	MJ9Ily8vM33msTMmCRewI8GgaPbNM2FWLgRE7FtRftPNRDH6tiujqFvLR1ZVxxgt
	Z/ozvQee6Q8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 07822815A5;
	Fri, 20 Nov 2009 15:19:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34A98815A2; Fri, 20 Nov
 2009 15:19:42 -0500 (EST)
In-Reply-To: <1258732767-12741-3-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri\, 20 Nov 2009 16\:59\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0AFF06FE-D612-11DE-A9D2-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133374>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> We explain the user why uncommited changes can be problematic with merge,
> and point to "commit" and "stash" for the solution.

It is a shame that our existing documentation did not address this, and
the patch certainly takes us in the right direction.

I haven't seen a clear description of distinction between two vastly
different modes of failure from "git merge"---one that stops before even
touching anything, and one that results in conflicts to be resolved---and
how to tell them apart.  As the course of action after these two modes are
quite different, it helps users to teach it early.

I attempted to summarize it some time ago:

    http://gitster.livejournal.com/25801.html
    (Completing a merge)

    http://gitster.livejournal.com/29060.html
    (Fun with keeping local changes around)

I am not very satisfied with them, but it might be a good start.

>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  Documentation/user-manual.txt |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 269ec47..6b4a037 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1176,14 +1176,22 @@ How to merge
>  ------------
>  
>  You can rejoin two diverging branches of development using
> -linkgit:git-merge[1]:
> +linkgit:git-merge[1].
>  
>  -------------------------------------------------
>  $ git merge branchname
>  -------------------------------------------------
>  
>  merges the development in the branch "branchname" into the current
> -branch.  If there are conflicts--for example, if the same file is
> +branch.  Note that Git merges committed changes, but not the working
> +tree itself.  Therefore, if you have uncommitted changes touching the
> +same files as the ones impacted by the merge, Git will refuse to
> +proceed.

"but not the working tree itself" is not incorrect per-se, but misses the
point.  How about...

	A merge is made by combining the changes made in "branchname" and
        the changes made up to the latest commit in your current branch
        since their histories forke.  The work tree is overwritten by the
        result of the merge when this combining is done cleanly, or
        overwritten by a half-merged results when this combining results
        in conflicts.  Therefore, ...

> +proceed.  Most of the time, you will want to commit your changes before
> +you can merge, and if you don't, then linkgit:git-stash[1] can take
> +these changes away while you're doing the merge, and reapply them
> +afterwards.
> +
> +If there are conflicts--for example, if the same file is
>  modified in two different ways in the remote branch and the local
>  branch--then you are warned; the output may look something like this:
>  
> @@ -1679,7 +1687,7 @@ Sharing development with others
>  Getting updates with git pull
>  -----------------------------
>  
> -After you clone a repository and make a few changes of your own, you
> +After you clone a repository and commit a few changes of your own, you
>  may wish to check the original repository for updates and merge them
>  into your own work.
>  
> -- 
> 1.6.5.3.435.g5f2e3.dirty
