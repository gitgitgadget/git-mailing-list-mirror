From: Nicolas Pitre <nico@cam.org>
Subject: Re: repack: handling of .keep files
Date: Fri, 04 May 2007 15:40:32 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705041539250.24220@xanadu.home>
References: <81b0412b0705040225p26679dbib6a1261a1a43ee67@mail.gmail.com>
 <7vy7k4ud3d.fsf@assigned-by-dhcp.cox.net>
 <81b0412b0705040342p4fed3a4bnee92cce6b5fb6b9@mail.gmail.com>
 <7vslacttij.fsf@assigned-by-dhcp.cox.net>
 <81b0412b0705041024i43d7fc5ah1967d6a6192dc6ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 21:40:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk3dv-0004oZ-Eu
	for gcvg-git@gmane.org; Fri, 04 May 2007 21:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161907AbXEDTkg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 15:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161911AbXEDTkg
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 15:40:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40240 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161912AbXEDTkf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 15:40:35 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHJ00LU47ZKP7N0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 04 May 2007 15:40:33 -0400 (EDT)
In-reply-to: <81b0412b0705041024i43d7fc5ah1967d6a6192dc6ee@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46206>

On Fri, 4 May 2007, Alex Riesen wrote:

> On 5/4/07, Junio C Hamano <junkio@cox.net> wrote:
> > "Alex Riesen" <raa.lkml@gmail.com> writes:
> > 
> > > Still, git-log shouldn't crash (nothing should, of course).
> > 
> > Honestly, I think that's borderline.  If you "dd if=/dev/random
> > of=/dev/hda", should the kernel keep going, perhaps gracefully
> > declining access to the filesystem on that drive?
> 
> e2fsck has a test somewhere which randomly corrupts a partition
> and then lets the program fix it.
> All kind of corruptions happen, we will have to deal with them.
> Especially if this crash is so simple to reproduce.
> 
> > case of temporary pack I do not think there would be a risk of
> > filename collisions, I think it makes sense to use either
> > GIT_DIR or GIT_OBJECT_DIRECTORY instead of the working tree.
> > 
> > I do not know pros-and-cons between .git/ and .git/objects/;
> 
> These are settable separately, so theoretically you can end
> up with .git and .git/objects being on different filesystems.
> Atomic rename wont be possible than.

Other temporary pack/object creation instances already use 
GIT_OBJECT_DIRECTORY.


Nicolas
