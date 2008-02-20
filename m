From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: Submodules and rewind
Date: Tue, 19 Feb 2008 17:13:01 -0800
Organization: Vyatta
Message-ID: <20080219171301.53893f2c@extreme>
References: <20080219140604.04afc91f@extreme>
	<20080219223201.GE4703MdfPADPa@greensroom.kotnet.org>
	<20080219152357.5ab397cf@extreme>
	<alpine.LSU.1.00.0802200033530.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<20080219161517.34fd5878@extreme>
	<alpine.LSU.1.00.0802200203440.8333@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: skimo@liacs.nl, skimo@kotnet.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 20 02:13:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRdWw-0001me-UU
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 02:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757042AbYBTBNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 20:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760042AbYBTBNJ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 20:13:09 -0500
Received: from mail.vyatta.com ([216.93.170.194]:47096 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755462AbYBTBNH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 20:13:07 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.vyatta.com (Postfix) with ESMTP id DD6F04F8051;
	Tue, 19 Feb 2008 17:13:04 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -1.884
X-Spam-Level: 
X-Spam-Status: No, score=-1.884 tagged_above=-10 required=5 tests=[AWL=-0.290,
	BAYES_00=-2.599, RCVD_IN_PBL=0.905, RDNS_DYNAMIC=0.1]
Received: from mail.vyatta.com ([127.0.0.1])
	by localhost (mail.vyatta.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9kDSiryYcSzU; Tue, 19 Feb 2008 17:13:03 -0800 (PST)
Received: from extreme (75-175-36-117.ptld.qwest.net [75.175.36.117])
	by mail.vyatta.com (Postfix) with ESMTP id 069D04F804D;
	Tue, 19 Feb 2008 17:13:02 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802200203440.8333@wbgn129.biozentrum.uni-wuerzburg.de>
X-Mailer: Claws Mail 3.3.0 (GTK+ 2.12.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74494>

On Wed, 20 Feb 2008 02:06:36 +0100 (CET)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> On Tue, 19 Feb 2008, Stephen Hemminger wrote:
> 
> > On Wed, 20 Feb 2008 00:35:33 +0100 (CET)
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > > On Tue, 19 Feb 2008, Stephen Hemminger wrote:
> > > 
> > > > On Tue, 19 Feb 2008 23:32:01 +0100
> > > > Sven Verdoolaege <skimo@kotnet.org> wrote:
> > > > 
> > > > > On Tue, Feb 19, 2008 at 02:06:04PM -0800, Stephen Hemminger wrote:
> > > > > > Because of a bone headed merge, I had to rewind one project back 
> > > > > > to a known good state, but the sub module stuff is now wedged 
> > > > > > and brain stuck on the old commit id.
> > > > > > 
> > > > > > Isn't there some simple way to do 'git sub-module remove' 
> > > > > > followed by 'git sub-module add' to reset the internal index?
> > > > > 
> > > > > Why doesn't "git submodule update" work for you?
> > > > > 
> > > > 
> > > > It didn't fix it, but recloning did.
> > > 
> > > That does not make sense.  But with your reluctance with regards to 
> > > revealing details, it is really impossible to tell what is going on.
> > > 
> > > For example, you did not even once give us the output of "git 
> > > submodule", let alone "git diff <submodule>".
> > > 
> > > Helpless,
> > > Dscho
> > 
> > Don't be stupid,
> 
> Thanks, I'm trying, I'm trying.
> 
> BTW that "Helpless" was meant as "I cannot help you".
> 
> > $ git-submodule init
> > Submodule 'pkgs/linux-image-2.6.23-1-486-vyatta' (http://git.vyatta.com/linux-vyatta.git) registered for path 'pkgs/linux-image-2.6.23-1-486-vyatta'
> 
> AFAICT this is your problem.  Your urls are http:// url, and do not end in 
> a slash.
> 
> Yes, there was a fix recently, but apparently it was not enough.  With 
> the slash, it should even work on older git.
> 

That is a different issue.  It worked before my messing around with the vyatta-iproute.git
repository.
