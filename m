From: Junio C Hamano <junkio@cox.net>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 13:40:17 -0800
Message-ID: <7v7j7xr54u.fsf@assigned-by-dhcp.cox.net>
References: <43F20532.5000609@iaglans.de>
	<Pine.LNX.4.64.0602141026570.3691@g5.osdl.org>
	<87fymlvgzv.wl%cworth@cworth.org>
	<200602142230.11442.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 22:40:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F97uK-0006kh-3N
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 22:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422811AbWBNVkV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 16:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422813AbWBNVkU
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 16:40:20 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:24287 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1422811AbWBNVkT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 16:40:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214213750.WMUI17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Feb 2006 16:37:50 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200602142230.11442.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Tue, 14 Feb 2006 22:30:11 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16180>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> Why not allow something like
>
> 	git-checkout master~5
>
> which implicitly does create a read-only branch "seek-point"?

Now what does "git-checkout branch" mean?  Does it switch to the
branch, or does it force tip of seek-point to be the tip of
branch and switch to seek-point branch?  More interestingly,
what does "git-checkout seek-point" mean? 

If we _were_ to do something like cg-seek where an implicit
throw-away branch is used, you at least need a way to
disambiguate these cases, and "git seek" originally suggested is
far clearer than what you said above.

Having said that, I am not convinced in either way, though.

> A branch could be marked readonly by above command with
>
> 	chmod a-w .git/refs/heads/seek

I do not think that would work.  Have you tried it?

> And git-commit should refuse to commit on a readonly ref, telling
> the user to create a writable branch before with "git-branch new".

Now, read-only ref does not interest me, but "do not commit on
top of this yourself, only fast-forward from somewhere else is
allowed" may be useful, for the reason why you mentioned
"origin".
