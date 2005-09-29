From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fetch-pack should not ask for a ref which is already there
Date: Thu, 29 Sep 2005 00:22:51 -0700
Message-ID: <7vll1gl4ms.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509290149230.19126@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 09:25:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKslH-0002Fy-NA
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 09:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVI2HWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 03:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbVI2HWy
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 03:22:54 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:22170 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932143AbVI2HWx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 03:22:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050929072251.VSVF9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Sep 2005 03:22:51 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0509290149230.19126@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 29 Sep 2005 01:49:47 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9473>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> With this patch, instead of blindly asking for every remote ref, fetch-pack
> first looks in the local repository if that ref is already there.

This patch breaks things.  git-fetch-pack is supposed to report
the resulting SHA1 and refs on its standard output.  If you are
up to date with this patch you would lose that.
