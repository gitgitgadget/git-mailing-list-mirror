From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/13] Use "git merge" instead of "git pull ."
Date: Sat, 24 Aug 2013 20:17:40 -0700
Message-ID: <xmqqvc2umpbf.fsf@gitster.dls.corp.google.com>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
	<694030462.1090937.1377329263413.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, wking@tremily.us
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Aug 25 05:18:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDQqO-0005vH-U1
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 05:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150Ab3HYDRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 23:17:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52980 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754894Ab3HYDRn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 23:17:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2F642AD96;
	Sun, 25 Aug 2013 03:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HG2NScIyO8V2exaqY7OOycbC/5A=; b=KX+57T
	vFAZBe91N05Q9ecNb2TK2jLO2bLLjX/RB5kUEMMR/E/gKpNhdxtEWWT5IH3ptaRM
	prEusUt3+61aQ5CRJcvbICq542y6ibnIteCkdfqlEymTD2iXLB2ChF+2ZXHfdGzU
	IVJh4zCSTp9kTrkW1e9PYrDoeAXKtLbb5Cd/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BGf4fZYTSNxUU9oN2/K1wlnNoKBVFKo+
	ZCQ/Gxx8Gf38Vfuwy3j7PQXKHNt7ol0gKlnRaPF11D18nNNWUq8zJQE/w1vrsd98
	XawG5Pz3t7huNv8OiTP2yHA/6kHY/yeMOvU708Q1u4POQRvh+Rs1DuXtKdmX9RmC
	pN6QYXmNXpA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D89F52AD94;
	Sun, 25 Aug 2013 03:17:42 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B3782AD93;
	Sun, 25 Aug 2013 03:17:42 +0000 (UTC)
In-Reply-To: <694030462.1090937.1377329263413.JavaMail.ngmail@webmail08.arcor-online.net>
	(Thomas Ackermann's message of "Sat, 24 Aug 2013 09:27:43 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E76A0EBA-0D34-11E3-AE79-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232898>

Thomas Ackermann <th.acker@arcor.de> writes:

> "git pull ." works, but "git merge" is the recommended
> way for new users to do things. (The old description 
> also should have read "The former is actually *not* very
> commonly used".)

I think it is probably a good idea to replace "pull ." in the two
later hunks with "merge", but the flow of the explanation reads
better if you did not touch the first hunk at all.  The section
introduced how fully-spelled "git pull origin master" works, how its
parameters can be omitted in a common case of integrating with the
branch at a remote repository you usually integrate with, and then
the hunk that you touched transitions to the local use, hinting that
your local repository is not all that special.  It is very commonly
used among people who grok that fact, and of course it still works
because we do want to support that usage ;-).

On the other hand, these later two hunks are not about explaining
"pull"; using "git merge" in the examples is more appropriate.

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/user-manual.txt | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index b450980..8a1a441 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1784,17 +1784,6 @@ repository that you pulled from.
>  <<fast-forwards,fast-forward>>; instead, your branch will just be
>  updated to point to the latest commit from the upstream branch.)
>  
> -The `git pull` command can also be given `.` as the "remote" repository,
> -in which case it just merges in a branch from the current repository; so
> -the commands
> -
> --------------------------------------------------
> -$ git pull . branch
> -$ git merge branch
> --------------------------------------------------
> -
> -are roughly equivalent.  The former is actually very commonly used.
> -
>  [[submitting-patches]]
>  Submitting patches to a project
>  -------------------------------
> @@ -2259,7 +2248,7 @@ When you are happy with the state of this change, you can pull it into the
>  "test" branch in preparation to make it public:
>  
>  -------------------------------------------------
> -$ git checkout test && git pull . speed-up-spinlocks
> +$ git checkout test && git merge speed-up-spinlocks
>  -------------------------------------------------
>  
>  It is unlikely that you would have any conflicts here ... but you might if you
> @@ -2271,7 +2260,7 @@ see the value of keeping each patch (or patch series) in its own branch.  It
>  means that the patches can be moved into the `release` tree in any order.
>  
>  -------------------------------------------------
> -$ git checkout release && git pull . speed-up-spinlocks
> +$ git checkout release && git merge speed-up-spinlocks
>  -------------------------------------------------
>  
>  After a while, you will have a number of branches, and despite the
