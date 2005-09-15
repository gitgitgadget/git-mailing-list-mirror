From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-diff-tree rename detection bug
Date: Thu, 15 Sep 2005 16:57:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509151647380.31877@localhost.localdomain>
References: <59a6e583050914094777c4fe96@mail.gmail.com>
 <7vwtljjzc3.fsf@assigned-by-dhcp.cox.net>
 <59a6e583050914114054b1564d@mail.gmail.com>
 <Pine.LNX.4.58.0509141321180.26803@g5.osdl.org>
 <17192.56103.803096.526568@cargo.ozlabs.ibm.com> <43290DA0.3030402@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Paul Mackerras <paulus@samba.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Wayne Scott <wsc9tt@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 22:58:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG0nP-0004PB-Cr
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 22:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbVIOU5Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 16:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbVIOU5Y
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 16:57:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22408 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932598AbVIOU5Y
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 16:57:24 -0400
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IMV005RMM7JWE10@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Sep 2005 16:57:19 -0400 (EDT)
In-reply-to: <43290DA0.3030402@zytor.com>
X-X-Sender: nico@localhost.localdomain
To: "H. Peter Anvin" <hpa@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8640>

On Wed, 14 Sep 2005, H. Peter Anvin wrote:

> Paul Mackerras wrote:
> > 
> > I assume you're compiling git as 32-bit executables on your G5.  I
> > don't see any reason why the git binaries would need to be 64-bit.
> > 
> 
> Well, git seems to assume it can mmap() the entirety of any file under its
> control, so a 64-bit git could handle larger files.

But beware that the delta code would break since it currently won't cope 
with any file offset larger than 32 bits.  I reserved the zero byte to 
prefix any extended encoding but felt it wasn't really needed yet and I 
just didn't bother coding it.


Nicolas
