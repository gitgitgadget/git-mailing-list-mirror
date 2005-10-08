From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: First cut at git port to Cygwin
Date: Sat, 8 Oct 2005 20:49:25 +0200
Message-ID: <20051008184925.GA6347@steel.home>
References: <81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com> <81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com> <81b0412b0510070544v3e7cf0b4n521db8ff7e4e335a@mail.gmail.com> <Pine.LNX.4.64.0510070828270.31407@g5.osdl.org> <20051007205450.GA14827@steel.home> <20051007212250.GA1423@steel.home> <4346E8AC.5030503@citi.umich.edu> <20051007213952.GA8821@steel.home> <Pine.LNX.4.64.0510080900510.31407@g5.osdl.org> <Pine.LNX.4.63.0510082023130.25971@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Chuck Lever <cel@citi.umich.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Christopher Faylor <me@cgf.cx>,
	"H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sat Oct 08 20:51:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOJlQ-0002LC-NE
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 20:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbVJHStm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 14:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbVJHStm
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 14:49:42 -0400
Received: from devrace.com ([198.63.210.113]:64012 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1750964AbVJHStl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Oct 2005 14:49:41 -0400
Received: from tigra.home (p54A0E160.dip.t-dialin.net [84.160.225.96])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id j98J1vXa092305;
	Sat, 8 Oct 2005 14:01:58 -0500 (CDT)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EOJl8-0005HJ-00; Sat, 08 Oct 2005 20:49:26 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EOJl7-0001fI-LM; Sat, 08 Oct 2005 20:49:25 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510082023130.25971@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=0.6 required=4.5 tests=AWL,BAYES_20,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9850>

Johannes Schindelin, Sat, Oct 08, 2005 20:27:06 +0200:
> > I really think that you should just get rid of the mmap.
> > 
> > As it is, you're just slowing the code down on sane architectures. That's 
> > not good.
> > 
> > So I'd suggest something like this instead.
> > 
> > Totally untested, of course.
> 
> Am I missing something? I don't see where the changes are written back to 
> the fd. After all, mmap() is called with PROT_WRITE...

It's just becase the file is open for reading only.
Also, it is not an mmap/unmap implementation. Just reading cache in.
