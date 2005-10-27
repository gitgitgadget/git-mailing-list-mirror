From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] Avoid using dc in git-count-objects
Date: Thu, 27 Oct 2005 10:50:00 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.10.27.08.49.59.849081@smurf.noris.de>
References: <Pine.LNX.4.63.0510260120260.28994@wbgn013.biozentrum.uni-wuerzburg.de> <7vd5ltcf05.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510261031400.7424@wbgn013.biozentrum.uni-wuerzburg.de> <20051026083658.GE30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Oct 27 10:55:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EV3Vd-0005Kj-Jz
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 10:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbVJ0IxO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 04:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbVJ0IxO
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 04:53:14 -0400
Received: from main.gmane.org ([80.91.229.2]:5866 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965005AbVJ0IxN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2005 04:53:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EV3U7-0004vG-8H
	for git@vger.kernel.org; Thu, 27 Oct 2005 10:51:43 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Oct 2005 10:51:43 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Oct 2005 10:51:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10702>

Hi, Petr Baudis wrote:

> Dear diary, on Wed, Oct 26, 2005 at 10:33:33AM CEST, I got a letter
> where Johannes Schindelin <Johannes.Schindelin@gmx.de> told me that...
>> Aargh! I had the impression "expr" was a builtin... Just forget about the 
>> patch, okay?
> 
> I think that builtin or not, $() will always spawn a subshell. ...?

It'll fork a subshell, but if the $() is a builtin, it won't exec.

(My built-in dictionary says: "spawn"=="fork+exec"; sorry if that
disagrees with yours.)

That being said, "echo $((1 + 2 + $((3 + 4))))" will not even fork.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Prunes give you a run for your money.
