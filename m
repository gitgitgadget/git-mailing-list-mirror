From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Maint-only commits
Date: Sun, 18 Sep 2011 21:11:20 +0200
Message-ID: <20110918191120.GA6334@nibiru.local>
References: <10397477.30610.1305580263246.JavaMail.root@mail.hq.genarts.com> <6416457.30612.1305580526325.JavaMail.root@mail.hq.genarts.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 21:19:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5Mtc-0006Rf-0z
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 21:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594Ab1IRTTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 15:19:13 -0400
Received: from caprica.metux.de ([82.165.128.25]:44609 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755856Ab1IRTTN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2011 15:19:13 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Sep 2011 15:19:12 EDT
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id p8IJ6DR5018935
	for <git@vger.kernel.org>; Sun, 18 Sep 2011 21:06:14 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id p8IJ61Sq018822
	for git@vger.kernel.org; Sun, 18 Sep 2011 21:06:01 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id p8IJBKCo004549
	for git@vger.kernel.org; Sun, 18 Sep 2011 21:11:20 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <6416457.30612.1305580526325.JavaMail.root@mail.hq.genarts.com>
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181627>

* Stephen Bash <bash@genarts.com> wrote:
> Hi all-
> 
> In my office we've recently run into three separate fixes 
> required on our maintenance branch that should not be 
> included in master (our normal workflow is to make changes 
> on maint, tag, release, and then merge to master).  Normally 
> these "maint only" fixes are interspersed with commits that 
> should go back into master.  In the past the "maint only" 
> commits were rare, so I'd carefully use "merge -s ours" 
> to avoid including the "maint only" changes in master.  
> But now I'm wondering if there's a better process/workflow? 

Of course, there is: use topic branches and rebase.


Assuming you've found a bug in maint, which is also still
in master.

#1: for off a topic branch (for that bug) from maint
#2: fix the bug there
#3: rebase to latest maint (if changed meanwhile) and test carefully
#4: (ff-)merge your bugfix branch to maint
#5: rebase bugfix branch to master (maybe incremental, if they
    went too far away from another) and test carefully
#6: (ff-)merge bugfix branch to master
#7: drop that topic branch, as you're done now.


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
