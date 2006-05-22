From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: irc usage..
Date: Sun, 21 May 2006 20:59:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>
 <20060520203911.GI6535@nowhere.earth> <446F95A2.6040909@gentoo.org>
 <Pine.LNX.4.64.0605201543260.3649@g5.osdl.org> <446FA262.7080900@gentoo.org>
 <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 22 06:00:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi1aT-0004cq-RF
	for gcvg-git@gmane.org; Mon, 22 May 2006 06:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbWEVD7v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 23:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbWEVD7u
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 23:59:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58597 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751569AbWEVD72 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 May 2006 23:59:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4M3xOtH015671
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 21 May 2006 20:59:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4M3xNxI014956;
	Sun, 21 May 2006 20:59:24 -0700
To: Donnie Berkholz <spyderous@gentoo.org>
In-Reply-To: <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20477>



On Sun, 21 May 2006, Linus Torvalds wrote:
> 
> Ok. It's still converting (that's a big archive), but it has passed the 
> cvsps stage without errors for me, and the conversion so far seems ok. But 
> it has only gotten to 
> 
> 	Author: vapier <vapier>  2002-09-23 12:32:42
> 	Changed GPL to GPL-2 in LICENSE and updated SRC_URI to use mirror:
> 
> so it has converted only slightly more than the first two years of 
> history in the roughly 30 minutes I've let it run. So it will take several 
> hours.

Btw, trying this import (which got interrupted by a thunderstorm and one 
of our first power failures in a long time - just a few seconds, but 
enough to power off everything but my laptops) it became very obvious that 
"git cvsimport" really _really_ should re-pack the archive every once in a 
while.

The old "repack every month or so" approach doesn't work that well when 
you try to import several years of history in a few hours.

Now, you can just repack after the whole thing is done (it will probably 
take no more than ~15 minutes or so), but it would probably be best if the 
import script itself decided to repack every once in a while just to avoid 
wasting a lot of diskspace _during_ the import itself.

So this isn't so much a correctness issue as a "avoid wasting time and 
space" issue, but still..

			Linus
