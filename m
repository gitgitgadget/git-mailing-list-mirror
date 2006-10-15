From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: use of version 3 delta is now optional.
Date: Sun, 15 Oct 2006 11:10:29 -0700
Message-ID: <7vac3xzbze.fsf@assigned-by-dhcp.cox.net>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net>
	<7virim10rb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610151135110.17085@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Oct 15 20:10:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZARe-0003cl-Nc
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 20:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422676AbWJOSKb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 14:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422679AbWJOSKb
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 14:10:31 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:40648 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1422676AbWJOSKa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 14:10:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061015181029.RHZQ28934.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Oct 2006 14:10:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aiAY1V00b1kojtg0000000
	Sun, 15 Oct 2006 14:10:33 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0610151135110.17085@xanadu.home> (Nicolas Pitre's
	message of "Sun, 15 Oct 2006 11:53:35 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28921>

Nicolas Pitre <nico@cam.org> writes:

> On Sun, 15 Oct 2006, Junio C Hamano wrote:
>
>> This introduces a new configuration item, pack.deltaversion, to
>> control whether pack-objects is allowed to use version 3 delta.
>> By default, we keep generating version 2 delta (and version 2
>> packfile format) to be compatible with git earlier than v1.2.0.
>...
> I'd suggest to drop this altogether.  See my previous email for my 
> reasoning on this issue.  I think this should be done another way.

I'll think about it a bit.

> If anything, maybe this patch can be added before v1.4.3 is released:
>...
> This way pack v3 could be fed to GIT v1.4.3 and above whenever we add 
> back pack v3 generation, and a pack converted to v2 from any v3 on the 
> fly when that capability is not present.

I think that is sensible.  I also was thinking that we should
call the current one packv3 and the one with delta-base-offset
packv4.
