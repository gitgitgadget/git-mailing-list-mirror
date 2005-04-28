From: Dave Jones <davej@redhat.com>
Subject: Re: diff against a tag ?
Date: Thu, 28 Apr 2005 19:44:51 -0400
Message-ID: <20050428234451.GB1730@redhat.com>
References: <20050428200953.GD8514@redhat.com> <7vpswe7hvj.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504281358060.18901@ppc970.osdl.org> <20050428220626.GC15706@redhat.com> <Pine.LNX.4.58.0504281518100.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 01:40:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRIba-0000VB-3g
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 01:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVD1XpF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 19:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVD1XpE
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 19:45:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56759 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262284AbVD1Xo5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 19:44:57 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j3SNiqrq014120;
	Thu, 28 Apr 2005 19:44:52 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j3SNiqO11654;
	Thu, 28 Apr 2005 19:44:52 -0400
Received: from devserv.devel.redhat.com (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j3SNiqLR015976;
	Thu, 28 Apr 2005 19:44:52 -0400
Received: (from davej@localhost)
	by devserv.devel.redhat.com (8.12.11/8.12.11/Submit) id j3SNiplA015962;
	Thu, 28 Apr 2005 19:44:51 -0400
X-Authentication-Warning: devserv.devel.redhat.com: davej set sender to davej@redhat.com using -f
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504281518100.18901@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 28, 2005 at 03:22:21PM -0700, Linus Torvalds wrote:

 > > Hmm, in a fresh rsync from your kernel tree, I get this..
 > > tagged commit a2755a80f40e5794ddc20e00f781af9d6320fafb (v2.6.12-rc3) in 0397236d43e48e821cce5bbe6a80a1a56bb7cc3a
 > > tagged commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 (v2.6.12-rc2) in 9e734775f7c22d2f89943ad6c745571f1930105f
 > > expect dangling commits - potential heads - due to lack of head information
 > > dangling tag 0397236d43e48e821cce5bbe6a80a1a56bb7cc3a
 > > dangling commit 9acf6597c533f3d5c991f730c6a1be296679018e
 > > dangling tag 9e734775f7c22d2f89943ad6c745571f1930105f
 > > 
 > > Is that last part to be expected ?
 > It even says so: "expect dangling commits".

heh, I was hex-blinded.
 
 > The tags will always be dangling, since nothing refers to them. Once you 
 > have them listed in your tag database (ie you've created files that 
 > mention them in .git/refs/tags or something), you can tell fsck about 
 > them, and fsck won't complain. 
 > 
 > Something like
 > 
 > 	fsck-cache --unreachable $(cat .git/refs/*/*)
 > 
 > would do it (and depending on exactly how cogito ends up recording them).

great.

		Dave

