From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: git-read-tree -m -u doesn't delete files: ?
Date: Mon, 20 Jun 2005 15:46:26 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.20.13.46.23.833207@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Jun 20 15:45:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkMYb-0007Co-8Q
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 15:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVFTNs6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 09:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFTNs6
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 09:48:58 -0400
Received: from main.gmane.org ([80.91.229.2]:51925 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261245AbVFTNsp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2005 09:48:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DkMWI-0006Bg-HE
	for git@vger.kernel.org; Mon, 20 Jun 2005 15:40:58 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Jun 2005 15:40:58 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Jun 2005 15:40:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Documentation/git-read-tree.txt states:

     10 yes   yes   N/A     exists   nothing  remove path from cache

and 

  -u::
    After a successful merge, update the files in the work
    tree with the result of the merge.

... which suggests that the file in question should be deleted.
In fcat, if I have a clean tree A, and I do "git-read-tree -m -u A B",
I'd assume that I should have a clean tree B afterwards.

Would it be safe to add all files for which read_tree.c:merge_cache:fn()
returns zero to a "delete me" list?

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
The greatest productive force is human selfishness.


