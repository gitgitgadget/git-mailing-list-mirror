From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: Handling large files with GIT
Date: Thu, 16 Feb 2006 21:32:11 +0100
Message-ID: <20060216203211.GA14408@c165.ib.student.liu.se>
References: <43F113A5.2080506@f2s.com> <Pine.LNX.4.63.0602141953000.22451@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0602141108050.3691@g5.osdl.org> <43F249F7.5060008@vilain.net> <Pine.LNX.4.64.0602141357300.3691@g5.osdl.org> <7vy80dpo9g.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602141741210.3691@g5.osdl.org> <Pine.LNX.4.64.0602141811050.3691@g5.osdl.org> <Pine.LNX.4.64.0602141829080.3691@g5.osdl.org> <Pine.LNX.4.64.0602141953081.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 16 21:32:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9pnc-0006RO-RE
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 21:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWBPUcV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 15:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWBPUcU
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 15:32:20 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:29636 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S932357AbWBPUcU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 15:32:20 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 386D940FD; Thu, 16 Feb 2006 21:46:32 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1F9pnP-000495-00; Thu, 16 Feb 2006 21:32:11 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602141953081.3691@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16312>

On Tue, Feb 14, 2006 at 07:58:03PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 14 Feb 2006, Linus Torvalds wrote:
> > 
> > So in case people want to try, here's a third patch. Oh, and it's against 
> > my _original_ path, not incremental to the middle one (ie both patches two 
> > and three are against patch #1, it's not a nice series).
> > 
> > Now I'm really done, and won't be sending out any more patches today. 
> 
> Still true. I've just been thinking about the last state.
> 
> As far as I can tell, the output from git-merge-tree with that fix to only 
> simplify subdirectories that match exactly in all of base/branch1/branch2 
> is precisely the output that git-merge-recursive actually wants.
> 
> Rather than doing a three-way merge with "git-read-tree", and then doing 
> "git-ls-files --unmerged", I think this gives the same result much more 
> efficiently.
> 
> That said, I can't follow the python code, so maybe I'm missing something. 
> Fredrik cc'd, in case he can put me right.
> 

I don't think you miss anything. I _think_ (I haven't looked at this
too close yet) that it shouldn't be too much work to make
git-merge-recursive make use of the git-merge-tree thing.

- Fredrik
