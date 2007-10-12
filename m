From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: RCS keyword expansion
Date: Fri, 12 Oct 2007 10:44:37 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710121041220.6887@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se>
 <86fy0hvgbh.fsf@blue.stonehenge.com> <Pine.LNX.4.62.0710111953460.7441@perkele.intern.softwolves.pp.se>
 <20071011192103.GD2804@steel.home> <Pine.LNX.4.62.0710120726470.11771@perkele.intern.softwolves.pp.se>
 <m3y7e8jmbm.fsf@barry_fishman.acm.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Barry Fishman <barry_fishman@acm.org>
X-From: git-owner@vger.kernel.org Fri Oct 12 19:49:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgOZf-0005CL-W1
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 19:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbXJLRpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 13:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755592AbXJLRpM
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 13:45:12 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57438 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750845AbXJLRpK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Oct 2007 13:45:10 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9CHibKj023483
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Oct 2007 10:44:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9CHibIg028823;
	Fri, 12 Oct 2007 10:44:37 -0700
In-Reply-To: <m3y7e8jmbm.fsf@barry_fishman.acm.org>
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60700>



On Fri, 12 Oct 2007, Barry Fishman wrote:
> 
> I changed my editor (Emacs) to convert RCS Ids to timestamps when I
> opened a file for reading.  This would fix old files.  When i wrote out
> files I would update the timestamp before writing them (via emacs's
> timestamp package).  I didn't have to think about it as my RCS Id
> stamped files slowly evolve into my editor stamped ones.  I'm sure I
> could do something similar in VIM, or with a script encapsulating
> another editor.

I think it might also be potentially interesting to make this just be a 
pre-commit hook - although your point that doing it in the editor is to 
some degree even nicer, because it also means that it shows up in diffs 
even *before* you commit.

But if you want to explore the pre-commit hook approach, what it would 
basically boild down to is that at that point you have a list of all files 
that have changed, and then you could run some script on them to change 
them even further.

I'm sure you'd find some problems with the approach, and I think it 
absolutely sucks for merging (ie trivially you'll have all the merge 
problems people *always* have with RCS Id's, and now you need to teach the 
auto-merger to hide them from you), but it's probably better than trying 
to do it at some "core level" (which screws up things like switching 
branches etc).

			Linus
