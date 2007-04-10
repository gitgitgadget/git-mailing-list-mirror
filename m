From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/6] Initial subproject support (RFC?)
Date: Tue, 10 Apr 2007 14:27:36 -0700
Message-ID: <7vfy77vs1j.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org>
	<81b0412b0704100604x2841d96aq194d3dedd303c588@mail.gmail.com>
	<Pine.LNX.4.64.0704100758430.6730@woody.linux-foundation.org>
	<81b0412b0704100848n69c99f55xa7cc96087cad7e31@mail.gmail.com>
	<Pine.LNX.4.64.0704100852550.6730@woody.linux-foundation.org>
	<7v6484vxd5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704101302480.6730@woody.linux-foundation.org>
	<7vk5wkuf35.fsf@assigned-by-dhcp.cox.net>
	<20070410210207.GA20955@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 04:23:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbNsz-0004Ev-0P
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 23:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030691AbXDJV1j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 17:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030715AbXDJV1j
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 17:27:39 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:63800 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030691AbXDJV1i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 17:27:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070410212738.KSHW1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Apr 2007 17:27:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lZTc1W00o1kojtg0000000; Tue, 10 Apr 2007 17:27:37 -0400
In-Reply-To: <20070410210207.GA20955@uranus.ravnborg.org> (Sam Ravnborg's
	message of "Tue, 10 Apr 2007 23:02:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44163>

Sam Ravnborg <sam@ravnborg.org> writes:

> On Tue, Apr 10, 2007 at 01:52:46PM -0700, Junio C Hamano wrote:
>> 
>> People occasionally ask "how would I make a small fix to a
>> commit that is buried in the history", so let me take a moment
>> to give them a recipe.
>
> That recipe looks ummm complicated...
> What I usually do is:
>
> git format-patch HEAD~4..HEAD
> git reset --hard HAED~4
> patch -p1 < 0004*
> ...edit...
> delete diff from 0004*
> git diff >> 0004*
> git reset --hard
> git am 000*
>
>
> Maybe this is as complicated as your example but this
> is very simple to deal with.
> And I do not destroy history or anything.
>
> But that said I do not use topic brances but simply
> clone my local repository as needed.
> And I always deal with a linear history.
>
>
> [I post this mostly to check if this is insane
> and I need to understand the way you propose to do stuff]

It's really the same.  You keep 000* file, I keep them in the
original branch and have "git rebase" take care of the details.
