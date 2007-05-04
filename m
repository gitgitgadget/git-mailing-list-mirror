From: Junio C Hamano <junkio@cox.net>
Subject: Re: repack: handling of .keep files
Date: Fri, 04 May 2007 12:20:21 -0700
Message-ID: <7v6478tmyy.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0705040225p26679dbib6a1261a1a43ee67@mail.gmail.com>
	<7vy7k4ud3d.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0705040342p4fed3a4bnee92cce6b5fb6b9@mail.gmail.com>
	<7vslacttij.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0705041024i43d7fc5ah1967d6a6192dc6ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 21:20:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk3KN-0000ln-U1
	for gcvg-git@gmane.org; Fri, 04 May 2007 21:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422926AbXEDTUY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 15:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423019AbXEDTUY
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 15:20:24 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:51197 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422926AbXEDTUW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 15:20:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070504192023.SHBJ13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 4 May 2007 15:20:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id v7LM1W00g1kojtg0000000; Fri, 04 May 2007 15:20:22 -0400
In-Reply-To: <81b0412b0705041024i43d7fc5ah1967d6a6192dc6ee@mail.gmail.com>
	(Alex Riesen's message of "Fri, 4 May 2007 19:24:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46202>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 5/4/07, Junio C Hamano <junkio@cox.net> wrote:
> ...
>> I do not know pros-and-cons between .git/ and .git/objects/;
>
> These are settable separately, so theoretically you can end
> up with .git and .git/objects being on different filesystems.
> Atomic rename wont be possible than.

Fair enough.

As we've lived without trouble long enough creating the new pack
tempfile in $GIT_DIR, I do not think it is urgent; but feel free
to propose moving it to GIT_OBJECT_DIRECTORY.  We _might_ need
to teach fsck to take notice of such leftover temporary files
from an earlier, aborted run if we do this -- I haven't looked.
