From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Tue, 21 Feb 2006 17:38:08 -0500
Message-ID: <20060221223808.GC20744@spearce.org>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de> <20060220191011.GA18085@hand.yhbt.net> <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net> <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com> <43FB79E2.1040307@vilain.net> <20060221215742.GA5948@steel.home> <Pine.LNX.4.63.0602212315400.12634@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 23:38:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBg99-0001JF-9t
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 23:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWBUWiM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 17:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWBUWiM
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 17:38:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:30115 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750736AbWBUWiM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 17:38:12 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FBg8w-0005tZ-Gl; Tue, 21 Feb 2006 17:38:02 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id D79B520FBA0; Tue, 21 Feb 2006 17:38:08 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0602212315400.12634@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16568>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Maybe I am stating the obvious, but it seems that
> 
> 	open (F, "git-blabla -option |");
> 
> would be more portable.

Yes but that gets broken up and processed according to your shell.
Which could be ugly if you try to include shell meta-characters.
On the other hand if the entire string passed to open is a constant
in the script then there's really no danger and it would be more
portable.
 
> P.S.: Eric, we rely on fork() anyway. Most of git's programs just don't 
> work without a fork().

Which is why GIT requires Cygwin on Windows.  So why not use
the Cygwin perl when using GIT?  I think that uses Cygwin's fork
emulation to implement fork, rather than the ActiveState emulation
of fork.

Of course fork on Cygwin is painfully slow.  :-|

-- 
Shawn.
