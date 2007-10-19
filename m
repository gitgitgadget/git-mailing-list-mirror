From: Andreas Ericsson <ae@op5.se>
Subject: Re: Qgit performance and maintain CVS environment with GIT repository
Date: Fri, 19 Oct 2007 09:14:18 +0200
Message-ID: <4718594A.2070407@op5.se>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>	 <47159779.6010502@bluelane.com>	 <e5bfff550710170030y7778e96ax146acea7a0e57a67@mail.gmail.com>	 <200710171800.37345.robin.rosenberg.lists@dewire.com> <e5bfff550710171626h733228aw7a251746d2b43c63@mail.gmail.com> <4717EF40.6000509@bluelane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	piet.delaney@gmail.piet.net,
	Linus Torvalds <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org,
	piet.delaney@gmail.com, Piet Delaney <pdelaney@bluelane.com>
To: pete@bluelane.com
X-From: git-owner@vger.kernel.org Fri Oct 19 09:15:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iim52-0005Df-S4
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 09:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755609AbXJSHPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 03:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755344AbXJSHPX
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 03:15:23 -0400
Received: from mail.op5.se ([193.201.96.20]:55855 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754152AbXJSHPW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 03:15:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 974201730663;
	Fri, 19 Oct 2007 09:15:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CDlXF+-VOSRm; Fri, 19 Oct 2007 09:15:18 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 235A017305AC;
	Fri, 19 Oct 2007 09:14:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <4717EF40.6000509@bluelane.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61660>

Pete/Piet Delaney wrote:
> Johannes:
>   I read somewhere in the past week that it was possible to maintain
>   our existing CVS environment with git. I though it was a separate
>   package to export git back to cvs but I just noticed a git-cvsserver
>   and as a std part of git and was wondering about using that.
> 
>   We have a number of build machines with flamebox perl scripts pulling
>   out CVS branches for builds. I was wondering what is the best way to
>   use git and it's nicer pull/push model and merge facility and possibly
>   maintain CVS exports for scripts doing builds if possible the cvsweb
>   and bonsai (CVS Query Form) that a number of engineers are currently
>   using. I started looking over out flamebox scripts with the intent
>   up converting them over to git but I mentioned the git to cvs
>   coexistence and we are wondering if that's a better route than
>   upgrading the flamebox scripts. Having our existing cvsweb, bonsai,
>   and gitweb along with the git utilities seems at least desirable.
>   Any thoughts or suggestions?
> 

If you do convert them to git, you can fairly easily do an automatic
bisect on build-errors, and the developer can (after some time) get
an email of what machines they broke the code on and what the bad
commit was.

Besides that, it's not a black-and-white scenario. If I were you I'd set
up git-cvsserver and make sure that works for all the scripts, and then
pick one or two auto-build things to convert to git. Preferrably on a
separate machine, so everything keeps working the same as always while
you're fiddling with the auto-build stuff.

Just my two cents.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
