From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] stgit: allow spaces in filenames
Date: Wed, 13 Jul 2005 18:54:18 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.13.16.54.18.709929@smurf.noris.de>
References: <20050713083805.18461.87079.sendpatchset@bryan-larsens-ibook-g4.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Jul 13 19:04:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dskec-0007wI-MB
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 19:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVGMRDj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 13:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVGMRBm
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 13:01:42 -0400
Received: from main.gmane.org ([80.91.229.2]:35018 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261293AbVGMRBc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2005 13:01:32 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DskbO-0007Os-GU
	for git@vger.kernel.org; Wed, 13 Jul 2005 19:00:54 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jul 2005 19:00:54 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jul 2005 19:00:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Bryan Larsen wrote:

> +	r=os.spawnvp(os.P_WAIT, args_l[0], args_l + args[i:min(i+1000, len(args))])

The max length for argv is 32k IIRC, so 1000 is 28-byte file names.
That's probably not enough. I't suggest using chunks of 100.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Don't you feel more like you do now than you did when you came in?
