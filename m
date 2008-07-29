From: Ingo Molnar <mingo@elte.hu>
Subject: Re: q: git-fetch a tad slow?
Date: Tue, 29 Jul 2008 11:08:02 +0200
Message-ID: <20080729090802.GA11373@elte.hu>
References: <20080728160138.GA12777@elte.hu> <20080729055014.GE11947@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 11:09:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNlCl-0001JM-7a
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 11:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089AbYG2JIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 05:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbYG2JIO
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 05:08:14 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:52748 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964AbYG2JIO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 05:08:14 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KNlBb-0001ul-Qz
	from <mingo@elte.hu>; Tue, 29 Jul 2008 11:08:12 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 226BF3E21AB; Tue, 29 Jul 2008 11:07:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080729055014.GE11947@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90607>


* Shawn O. Pearce <spearce@spearce.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > Setup/background: distributed kernel testing cluster, [...]
> > 
> > Problem: i noticed that git-fetch is a tad slow:
> > 
> >   titan:~/tip> time git-fetch
> >   real    0m2.372s

> Also, I wonder if you really need to fetch over SSH.  Doing a fetch 
> over git:// is much quicker, as there is no SSH session setup 
> overheads.

note that titan is a very beefy box, almost 3 GHz Core2Duo:

   model name      : Intel(R) Core(TM)2 CPU         E6800  @ 2.93GHz
   stepping        : 5
   cpu MHz         : 2933.331

server is 3 GHz. So if we have a quadratic overhead on number of 
branches, that's going to be quite a PITA.

> I wonder if git-pack-refs + fetching only a single branch will get you 
> closer to the tip-fetch time.

should i pack on both repos? I dont explicitly pack anything, but on the 
server it goes into regular gc runs. (which will pack most stuff, 
right?)

	Ingo
