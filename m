From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 21:42:14 +0200
Message-ID: <20071015194214.GC15541@steel.home>
References: <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net> <Pine.LNX.4.64.0710150217120.25221@racer.site> <20071015175606.GE2966@steel.home> <4713B367.52CEC7E2@dessent.net> <Pine.LNX.4.64.0710151938300.25221@racer.site> <4713BA89.633B86F2@dessent.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Eli Zaretskii <eliz@gnu.org>, ae@op5.se,
	tsuna@lrde.epita.fr
To: Brian Dessent <brian@dessent.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 22:40:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhVpc-0007PZ-ML
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 21:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757632AbXJOTmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 15:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756500AbXJOTmR
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 15:42:17 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:47179 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757185AbXJOTmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 15:42:16 -0400
Received: from tigra.home (Fca67.f.strato-dslnet.de [195.4.202.103])
	by post.webmailer.de (mrclete mo14) (RZmta 13.4)
	with ESMTP id d00b80j9FFGitc ; Mon, 15 Oct 2007 21:42:14 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 577CD277AE;
	Mon, 15 Oct 2007 21:42:14 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 4277956D22; Mon, 15 Oct 2007 21:42:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4713BA89.633B86F2@dessent.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTv2MPo=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61034>

Brian Dessent, Mon, Oct 15, 2007 21:07:53 +0200:
> Johannes Schindelin wrote:
> > My bigger concerns are the performance and stability.  For example, I had
> > a very annoying problem on one of the machines I am testing msysGit on.
> > The problem was _only_ fixable by deactivating component of Logitech's
> > WebCam driver!  Now, if a user-installable 3rd party program can make my
> > regular git crash, I am scared what more it can do.
> 
> That is because the MSYS runtime is based on an old version of Cygwin,
> and it uses the same dirty tricks to emulate fork.  These tricks rely on
> having a repeatably consistent memory layout for a process each time it
> is started, and when third party tools add hooks that affect the load
> order or otherwise screw with the layout, the fork emulation fails. 
> This is also why it is sometimes necessary to assign unique base
> addresses to all libraries (rebaseall) in order to get fork emulation
> working again.

Hmm... Could the allocation of large contiguous blocks also lock the
system hard? For instance, I avoid starting the test suite on my XP
workstation at work: it locks up hard every time. W2k works.
The system has nothing unusual in it. Well, it has an antivirus
program (which hopefully stopped working after a series of crashes,
which is just as well), an NVidia card with native driver (which is
broken in its own usual ways). Maybe that's enough
