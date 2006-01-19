From: Christopher Faylor <me@cgf.cx>
Subject: Re: cygwin-latest: compile errors related to sockaddr_storage, dirent->d_type and dirent->d_ino
Date: Thu, 19 Jan 2006 16:51:46 -0500
Message-ID: <20060119215146.GC5090@trixie.casa.cgf.cx>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com> <20060119052914.GC8121@trixie.casa.cgf.cx> <7vlkxciodu.fsf@assigned-by-dhcp.cox.net> <20060119161000.GA27888@trixie.casa.cgf.cx> <20060119203428.GA5090@trixie.casa.cgf.cx> <Pine.LNX.4.64.0601191309130.3240@g5.osdl.org> <20060119212856.GA6317@trixie.casa.cgf.cx> <Pine.LNX.4.64.0601191334390.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 19 22:52:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzhhV-0005RV-SZ
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 22:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161443AbWASVvs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 16:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161444AbWASVvs
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 16:51:48 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:40591 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1161443AbWASVvq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 16:51:46 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 30A074A84D6; Thu, 19 Jan 2006 16:51:46 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601191334390.3240@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14937>

On Thu, Jan 19, 2006 at 01:44:58PM -0800, Linus Torvalds wrote:
>
>On Thu, 19 Jan 2006, Christopher Faylor wrote:
>> 
>> The only thing that would speed up process creation in cygwin now is
>> the use of the windows spawn* family of function calls.  Those could be
>> used instead of fork/exec but I have a personal aversion to using them
>> since they are so non-UNIX.  If performance is an issue, however, that
>> could be something to investigate.
>
>What about posix_spawn()? I don't know the windows spawn things, but I 
>assume posix_spawn() is basically trying to be them.. Does it work with 
>cygwin if we try to convert some of the more obvious users?

You know, I couldn't remember what the name of the spawn that was
introduced for posix.  I was going to mention it in my email and I
forgot.  Obviously it was because the name so obscure that no one could
possibly remember it.  :-)

We don't emulate posix_spawn currently but we could and should.  I'll
put it on the todo list.

cgf
