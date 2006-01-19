From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cygwin-latest: compile errors related to sockaddr_storage,
 dirent->d_type and dirent->d_ino
Date: Thu, 19 Jan 2006 13:44:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601191334390.3240@g5.osdl.org>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
 <20060119052914.GC8121@trixie.casa.cgf.cx> <7vlkxciodu.fsf@assigned-by-dhcp.cox.net>
 <20060119161000.GA27888@trixie.casa.cgf.cx> <20060119203428.GA5090@trixie.casa.cgf.cx>
 <Pine.LNX.4.64.0601191309130.3240@g5.osdl.org> <20060119212856.GA6317@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 22:46:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzhbI-0003vY-2Y
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 22:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161425AbWASVpo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 16:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161437AbWASVpo
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 16:45:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60545 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161425AbWASVpo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 16:45:44 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0JLj1DZ014577
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 Jan 2006 13:45:42 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0JLiwUg029339;
	Thu, 19 Jan 2006 13:45:00 -0800
To: Christopher Faylor <me@cgf.cx>
In-Reply-To: <20060119212856.GA6317@trixie.casa.cgf.cx>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.66__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14936>



On Thu, 19 Jan 2006, Christopher Faylor wrote:
> 
> The only thing that would speed up process creation in cygwin now is
> the use of the windows spawn* family of function calls.  Those could be
> used instead of fork/exec but I have a personal aversion to using them
> since they are so non-UNIX.  If performance is an issue, however, that
> could be something to investigate.

What about posix_spawn()? I don't know the windows spawn things, but I 
assume posix_spawn() is basically trying to be them.. Does it work with 
cygwin if we try to convert some of the more obvious users?

Some of the git users should be easy to convert to posix_spawn()..

		Linus
