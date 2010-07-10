From: Enrico Weigelt <weigelt@metux.de>
Subject: Cutting history
Date: Sat, 10 Jul 2010 05:25:53 +0200
Message-ID: <20100710032553.GB554@nibiru.local>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 10 05:36:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXQr9-0005Sx-SV
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 05:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701Ab0GJDfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 23:35:55 -0400
Received: from forum.psychotherapie.org ([217.160.22.205]:38785 "EHLO
	s15216962.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753420Ab0GJDfy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jul 2010 23:35:54 -0400
Received: (from uucp@localhost)
	by s15216962.onlinehome-server.info (8.13.3/8.13.3) with UUCP id o6A3Zp1G023693
	for git@vger.kernel.org; Sat, 10 Jul 2010 05:35:51 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o6A3Psj0011070
	for git@vger.kernel.org; Sat, 10 Jul 2010 05:25:54 +0200
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150708>


Hi folks,


I'm using git for automatic backups (eg. database dumps). This 
works quite well, but as time goes, the history (and so the repo)
gets larger and larger. It would be really nice to allow cutting
off old stuff (eg. after N commits in the past). 

Maybe that could be done by introducing "stopper" tags: commits
that have an stopper-tag may have missing parents, and git-gc
can be told to ignore those parents and throw away everything
behind the stopper (if not referenced otherwise).

A probably cleaner, but more invasive way could be making refs
to vectors, which may contain stop points (multiple ones in case
of merges) additionally to the start point. Remote transmits only
contain the commits within this range, and GC also just scans
the range (instead of following all parents).


What do you think about this ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
