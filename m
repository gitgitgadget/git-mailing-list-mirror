From: Ingo Molnar <mingo@elte.hu>
Subject: Re: q: git-fetch a tad slow?
Date: Thu, 31 Jul 2008 23:03:07 +0200
Message-ID: <20080731210307.GF25138@elte.hu>
References: <20080728160138.GA12777@elte.hu> <20080729055014.GE11947@spearce.org> <20080729090802.GA11373@elte.hu> <20080730044855.GA7225@spearce.org> <20080730190657.GC26389@elte.hu> <20080731044531.GB1860@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 23:04:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOfJr-0002wO-Aq
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 23:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbYGaVDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 17:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbYGaVDR
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 17:03:17 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:49832 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753823AbYGaVDR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 17:03:17 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KOfIi-0002km-0Y
	from <mingo@elte.hu>; Thu, 31 Jul 2008 23:03:14 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 294DF3E2191; Thu, 31 Jul 2008 23:03:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080731044531.GB1860@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90991>


* Shawn O. Pearce <spearce@spearce.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> > alas, fetching still seems to be slow:
> > 
> >   titan:~/tip> time git-fetch origin
> > 
> >   real    0m5.112s
> >   user    0m0.972s
> >   sys     0m3.380s
> 
> What version of git are dealing with on the client side?

the client side on titan has:

 titan:~> git version
 git version 1.5.2.2

oldish but not outrageously old, right?

 server side has:

 earth4:~> git version
 git version 1.5.6.1.108.g660379

> 
> fetch times of ~472 ms over git:// to your -tip.git tree and ~128 ms 
> for strictly local fetch.  If your SSH overhead is ~300 ms this is 
> only a ~700 ms real time for `git fetch origin`, not 5100 ms.
> 
> Is your git-fetch a shell script?  Or a compiled binary?  The port 
> into C made it go _much_ faster, even though it is still a naive 
> O(N^2) matching algorithm.  Yea, we still should fix that, but I think 
> an upgrade to 1.5.4 or later would make the client side improve 
> consideribly.

ah, it is a shell script indeed! I'll upgrade to latest.

	Ingo
