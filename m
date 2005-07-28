From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Thu, 28 Jul 2005 23:13:38 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.28.21.13.35.458701@smurf.noris.de>
References: <200507271458.43063.Josef.Weidendorfer@gmx.de> <7vll3rlnqm.fsf@assigned-by-dhcp.cox.net> <200507271458.43063.Josef.Weidendorfer@gmx.de> <20050728120806.GA2391@pasky.ji.cz> <Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728153506.GL14229@pasky.ji.cz> <Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728161815.GC17952@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Jul 28 23:19:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyFmj-000269-6X
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 23:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVG1VSl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 17:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVG1VQh
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 17:16:37 -0400
Received: from main.gmane.org ([80.91.229.2]:35764 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262286AbVG1VO4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 17:14:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DyFhy-0001Zv-0s
	for git@vger.kernel.org; Thu, 28 Jul 2005 23:14:26 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Jul 2005 23:14:26 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Jul 2005 23:14:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Petr Baudis wrote:

> If you fear making mistakes, better use something which attempts to do
> some babysitting for you, like Cogito. ;-)

Some babysitting needs to be part of the core push protocol; anything else
would be prone to race conditions in a multiuser setting, esp. when people
use different porcelains.

At minimum, you'd send the old branch head with the new one, and let the
server not overwrite it if it changed in the meantime.

Then, you'd kill porcelain writers who don't verify that the old head is
a(n indirect) parent of the new one. ;-)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Madness takes its toll. Please have exact change.
