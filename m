From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-branch a builtin
Date: Mon, 23 Oct 2006 23:43:35 -0700
Message-ID: <7vy7r6qkmg.fsf@assigned-by-dhcp.cox.net>
References: <11616396262982-git-send-email-hjemli@gmail.com>
	<20061023215506.GB8344@spearce.org>
	<7vfydewqbb.fsf@assigned-by-dhcp.cox.net>
	<20061024054408.GA9724@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 08:44:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcG0y-0003Bx-Qq
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 08:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbWJXGnh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 02:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbWJXGnh
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 02:43:37 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:3510 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1752066AbWJXGng (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 02:43:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061024064336.SKYH16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Tue, 24 Oct 2006 02:43:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id e6jf1V00k1kojtg0000000
	Tue, 24 Oct 2006 02:43:40 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061024054408.GA9724@spearce.org> (Shawn Pearce's message of
	"Tue, 24 Oct 2006 01:44:08 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29934>

Shawn Pearce <spearce@spearce.org> writes:

>> > Wouldn't it make more sense to just include the full SHA1 of the
>> > file we are deleting rather than the entire 131 line negative diff?
>> 
>> How would you do "git apply -R" on something like that?
>
> Uh, you have the full SHA1 in the index line.  So you just have to
> reattach that blob to the named path...  pretty simple actually.

Bzzzt; wrong answer.

Think of a future when you can shallowly clone near the tip of
git repository that does not have shell-script git-branch.sh
anymore.  You cannot expect to already have the preimage of the
patch in such a case.  You would still want to be able to revert
the change with "git apply -R".
