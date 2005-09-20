From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Joining cg-*-id
Date: Tue, 20 Sep 2005 17:13:24 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.20.15.13.21.656923@smurf.noris.de>
References: <1127166049.26772.26.camel@dv> <20050919215608.GA13845@pasky.or.cz> <Pine.LNX.4.58.0509191505470.2553@g5.osdl.org> <20050919225422.GG18320@pasky.or.cz> <Pine.LNX.4.58.0509191746130.2553@g5.osdl.org> <20050920135735.GC1884@pasky.or.cz> <Pine.LNX.4.58.0509200734440.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Sep 20 17:23:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHjtr-0007Hn-1L
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 17:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbVITPTM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 11:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbVITPTM
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 11:19:12 -0400
Received: from main.gmane.org ([80.91.229.2]:11984 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965029AbVITPTL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 11:19:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EHjoS-0005o6-Fy
	for git@vger.kernel.org; Tue, 20 Sep 2005 17:13:40 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Sep 2005 17:13:40 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Sep 2005 17:13:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9001>

Hi, Linus Torvalds wrote:

> And if you select one of them at random (or by deciding which parent is
> the "primary" one), then
> 
> 	git diff yesterday..
> 
> will show not the changes since yesterday, but _all_ the changes that came
> in through the merge.

IMHO the way out is to realize that you did the same thing yesterday,
so presumably, if we teach git to remember what yesterday's head was,
there's no problem.

So let's do a "git diff-since yesterday" which simply forks a
"git diff since/yesterday..HEAD", and then copies .git/HEAD to
.git/refs/since/yesterday.

Just don't call it "yesterday" in the documentation ;-)  and print a nice
error message instead of an ugly one if the user hasn't run the program
before. (But still do the copy.)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
What if everything is an illusion and nothing exists?  In that case, I
definitely overpaid for my carpet.
		-- Woody Allen, "Without Feathers"
