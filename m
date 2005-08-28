From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/9] Fix git patch header processing in git-apply.
Date: Sun, 28 Aug 2005 16:39:12 -0700
Message-ID: <7vslwtein3.fsf@assigned-by-dhcp.cox.net>
References: <11252426672473-git-send-email-robfitz@273k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 01:40:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9WkB-0007j4-TD
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 01:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbVH1XjP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 19:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbVH1XjP
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 19:39:15 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:40657 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750954AbVH1XjO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 19:39:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050828233912.PPLP3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 28 Aug 2005 19:39:12 -0400
To: Robert Fitzsimons <robfitz@273k.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7890>

Thanks for "apply" patches.  I have merged some of them and
pushed out.

I further wanted to apply the following to the proposed updates
branch, but even with only the first one applied, it fails its
own test, t4104-apply-complex.sh:

* Fix processing of a patch file which modifies the same file in git-apply.
* Fix the processing of multiple patch files with --check in git-apply.
* New option --ignore-whitespace for git-apply.
* New option --ignore-applied for git-apply.

*** t4104-apply-complex.sh ***
* FAIL 5: S = Nx Px1
	cat Nx Px1 | git-apply -
* FAIL 6: S = Nx Px1 Px2
	cat Nx Px1 Px2 | git-apply -
* FAIL 7: S = Nx Px1 Px2 Px3
	cat Nx Px1 Px2 Px3 | git-apply -
* FAIL 8: S = Nx Px1 Px2 Px3 Dx
	cat Nx Px1 Px2 Px3 Dx | git-apply -
* FAIL 13: S = Ny Ryx Px1 Px2 Cxy Px3 Dx
	cat Ny Ryx Px1 Px2 Cxy Px3 Dx | git-apply -
* FAIL 14: S = Ny Ryx Px1 Px2 Cxy Px3 Dx Cyx
	cat Ny Ryx Px1 Px2 Cxy Px3 Dx Cyx | git-apply -
* FAIL 15: S = Ny Cyx Px1 Px2 Px3 Dy Cxy Dx Cyx Dy Rxy Dy
	cat Ny Cyx Px1 Px2 Px3 Dy Cxy Dx Cyx Dy Rxy Dy| git-apply -
