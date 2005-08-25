From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [RFC] Looking at multiple ancestors in merge
Date: Thu, 25 Aug 2005 08:56:25 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.25.06.56.22.883900@smurf.noris.de>
References: <Pine.LNX.4.63.0508242249030.23242@iabervon.org> <430D4B75.6060102@gmail.com> <Pine.LNX.4.63.0508250108100.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Aug 25 09:00:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8Big-0008EW-7j
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 09:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbVHYG7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 02:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbVHYG7J
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 02:59:09 -0400
Received: from main.gmane.org ([80.91.229.2]:7649 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751549AbVHYG7I (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2005 02:59:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E8BgN-0007dj-GU
	for git@vger.kernel.org; Thu, 25 Aug 2005 08:57:51 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Aug 2005 08:57:51 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Aug 2005 08:57:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7747>

Hi, Daniel Barkalow wrote:

> My proposal is actually to detect when a merge is ambiguous. In order to
> determine that, however, you have to evaluate multiple potential outcomes
> and see if they are actually different. I'm working on an efficient way to
> do that.

Good.

There's also a related problem which I've hit last month or so, where one
view has the same file (or at least one with the same name) added to both
sides of the branch, but the other view doesn't.

Unfortunately, that can happen to both branches independently, so you
really need to choose a merge base per file instead of globally. I suspect
that many of the problem cases simply go away when you do that.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Jones' Second Law:
	The man who smiles when things go wrong has thought of someone
	to blame it on.
