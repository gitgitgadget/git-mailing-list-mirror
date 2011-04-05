From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: rebase autosquash doesn't recognise a chain of fixups
Date: Tue, 5 Apr 2011 17:41:00 +0200
Message-ID: <20110405154100.GC16031@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 17:41:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q78NT-0006CL-MF
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 17:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126Ab1DEPlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 11:41:06 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:38430 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753889Ab1DEPlD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 11:41:03 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id E228C46124
	for <git@vger.kernel.org>; Tue,  5 Apr 2011 17:40:50 +0200 (CEST)
Received: (nullmailer pid 20156 invoked by uid 1000);
	Tue, 05 Apr 2011 15:41:00 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170883>

Hello,

 Say I have the following commits:

    5154127 fixup! fixup! one
    0d130d8 fixup! one
    0869d30 one

because I keep executing `git commit -a --fixup HEAD`. When I want to
squash them all into 0869d30, I do `git rebase -i --autosquash
0869d30^` and I get

    pick 0869d30 one
    fixup 0d130d8 fixup! one
    pick 5154127 fixup! fixup! one

when I was hoping for

    pick 0869d30 one
    fixup 0d130d8 fixup! one
    fixup 5154127 fixup! fixup! one

Changing the options to the latter one works (as in, the patches
apply). Is this expected? Am I just too lazy and should look up the
commit I want to fixup?

   cmn
