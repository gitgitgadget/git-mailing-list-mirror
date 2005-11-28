From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: git-mv: fully detect 'directory moved into itself'
Date: Mon, 28 Nov 2005 07:54:34 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.11.28.06.54.32.809941@smurf.noris.de>
References: <200511272206.43113.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Nov 28 08:30:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgdOy-00030r-Ke
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 08:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVK1HZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 02:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVK1HZ5
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 02:25:57 -0500
Received: from main.gmane.org ([80.91.229.2]:35737 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751209AbVK1HZ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 02:25:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EgdIU-0001YE-3I
	for git@vger.kernel.org; Mon, 28 Nov 2005 08:19:36 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Nov 2005 08:19:33 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Nov 2005 08:19:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12856>

Hi, Josef Weidendorfer wrote:

> +    if (($bad eq "") && ($dst =~ /^$src\//)) {

That should be

> +    if (($bad eq "") && ($dst =~ /^\Q$src\E\//)) {

otherwise you will mistakenly match "foo-bar" with "foo.bar".

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
If people drank ink instead of Schlitz, they'd be better off.
		-- Edward E. Hippensteel

[What brand of ink?  Ed.]
