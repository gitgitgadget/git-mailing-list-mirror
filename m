From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Article about "git bisect run" on LWN
Date: Fri, 6 Feb 2009 02:52:15 +0100
Message-ID: <20090206015215.GA6261@elte.hu>
References: <200902050747.50100.chriscool@tuxfamily.org> <20090205141336.GA28443@elte.hu> <alpine.DEB.1.10.0902051838180.5340@asgard.lang.hm> <20090206014655.GA26807@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Jeff Garzik <jeff@garzik.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Feb 06 02:53:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVFun-0002Sy-AW
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 02:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbZBFBwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 20:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbZBFBwb
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 20:52:31 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48435 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885AbZBFBwa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 20:52:30 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1LVFtC-0000xN-Ov
	from <mingo@elte.hu>; Fri, 06 Feb 2009 02:52:21 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 360263E21B0; Fri,  6 Feb 2009 02:52:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090206014655.GA26807@elte.hu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108648>


* Ingo Molnar <mingo@elte.hu> wrote:

> The idea would be to insert 30% redunancy into my bisections automatically 
> - so that i could trust _all_ bisections more - not just the ones i 
> suspect to be non-deterministic. Hence the suggestion to enable lower 
> levels of redundancy like 30%. (but even 10% or 20% might be enough to 
> weed out the most obvious cases)

the other advantage of redundancy that i forgot to mention:

- Sometimes the non-determinism is inserted by a _human_. It happened not
  once that i accidentally mis-judged a testpoint, and the bisection ran
  afoul. Only 4-5 steps later do i suspect that something is wrong: that i 
  get an unlikely series of good,good,good,good,good or bad,bad,bad,bad,bad 
  testpoint qualities.

So for manual bisection, redundancy can be a big time-saver. If i mess up a 
bisection point then say 50% redundancy can still point out my stupidity 
with a high likelyhood.

In fact if Git sees an unlikely series of same-quality bisection points, it 
could artificially insert a test to around the last-different test point, to 
test the theory of a messed up bisection.

	Ingo
