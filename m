From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Finding what change broke ARM
Followup-To: gmane.linux.kernel
Date: Fri, 24 Jun 2005 10:19:51 +0100
Message-ID: <20050624101951.B23185@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jun 24 11:17:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlkJH-00018T-31
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 11:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbVFXJXD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 05:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263180AbVFXJXC
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 05:23:02 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63243 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263171AbVFXJT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2005 05:19:56 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DlkLp-0001DD-6E; Fri, 24 Jun 2005 10:19:53 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DlkLo-0006bh-3h; Fri, 24 Jun 2005 10:19:52 +0100
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When building current git for ARM, I see:

  CC      arch/arm/mm/consistent.o
arch/arm/mm/consistent.c: In function `dma_free_coherent':
arch/arm/mm/consistent.c:357: error: `mem_map' undeclared (first use in this function)
arch/arm/mm/consistent.c:357: error: (Each undeclared identifier is reported only once
arch/arm/mm/consistent.c:357: error: for each function it appears in.)
make[2]: *** [arch/arm/mm/consistent.o] Error 1

How can I find what change elsewhere in the kernel tree caused this
breakage?

With bk, you could ask for a per-file revision history of the likely
candidates, and then find the changeset to view the other related
changes.

With git... ?  We don't have per-file revision history so...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
