From: Petr Baudis <pasky@suse.cz>
Subject: Re: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 13:14:46 +0200
Message-ID: <20080731111446.GO32184@machine.or.cz>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com> <20080731105727.GF7008@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cte <cestreich@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 13:15:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOW8L-0004Fy-G9
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 13:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbYGaLOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 07:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbYGaLOt
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 07:14:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43192 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609AbYGaLOs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 07:14:48 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 72FBB393A530; Thu, 31 Jul 2008 13:14:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080731105727.GF7008@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90928>

On Thu, Jul 31, 2008 at 02:57:27PM +0400, Dmitry Potapov wrote:
> On Thu, Jul 31, 2008 at 02:53:37AM -0700, cte wrote:
> > I'm writing a git gui for OS X using cocoa/Objective-C++, and rather
> > than being lame and parsing the output the various git commands, I'm
> > using libgit.a to provide all of the needed functionality for my app.
> 
> Don't do that! libgit.a is an internal library used solely to build
> git binaries. It means that its interface can be cahnged at any time.

I don't think this is that big a problem; there are applications that
are doing this already, e.g. cgit, and if you tie your application to
a particular git version by for example making git a submodule of your
source, this is pretty safe; it will just mean that you will have to
do some non-trivial porting of your code to the new interface each time
you update - but I think large changes in the interface are pretty rare
in practice by now, and there shouldn't be much on the horizon either(?).

> > However, the git source uses a few reserved C++ keywords; namely
> > 'typename', and 'new'.
> 
> Because this source code are meant to be compiled by C and not by C++!
> Even if we will have real git library for other applications to use,
> it still be compiled only by C. Thus, C++ keywords are not issue.

What would be the reason to disallow C++ users? The costs aren't that
high, and (modulo, say, extern "C" { }) there should be no C-C++
compatibility issues, right?

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
