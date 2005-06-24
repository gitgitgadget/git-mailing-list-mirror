From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Fri, 24 Jun 2005 15:16:13 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.24.13.16.10.406827@smurf.noris.de>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 15:12:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlnzA-0006vk-Gc
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 15:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbVFXNSu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 09:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVFXNSu
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 09:18:50 -0400
Received: from main.gmane.org ([80.91.229.2]:63975 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262496AbVFXNRq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 09:17:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DlnwX-0006Ma-Ba
	for git@vger.kernel.org; Fri, 24 Jun 2005 15:10:01 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Jun 2005 15:10:01 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Jun 2005 15:10:01 +0200
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

> Switching branches in place will be supported soon (although I have
> doubts about its usefulness).

Well, I don't. Main reason: It's simply a lot faster to create+switch to a
branch locally for doing independent work, than to hardlink the whole
Linux directory tree into a clone tree.

Having one tree also simpifies the "what do I have that's not merged yet"
question -- just call "gitk $(cat .git/refs/heads/*)". ;-)

The only problem I have with it is that "git-read-tree -m -u"
doesn't delete files yet. To repeat my question from last week:
>> Would it be safe to add all files for which
>> read_tree.c:merge_cache:fn() returns zero to a "delete me" list?
(files on which which then actually get deleted, of course, if g-r-t
doesn't find any problems.)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Politics -- the gentle art of getting votes from the poor and campaign
funds from the rich by promising to protect each from the other.
		-- Oscar Ameringer


