From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Don't crash during repack of a reflog with pruned commits.
Date: Thu, 21 Dec 2006 16:52:04 -0800
Message-ID: <7vmz5g92h7.fsf@assigned-by-dhcp.cox.net>
References: <be6b1443171482e1930bd7744a0218db0c03d611.1166748450.git.spearce@spearce.org>
	<20061222004906.GC14789@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 01:52:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxYdz-0003N0-T2
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 01:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423143AbWLVAwN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 19:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423167AbWLVAwN
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 19:52:13 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:50646 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423143AbWLVAwM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 19:52:12 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222005205.HGPT9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Thu, 21 Dec 2006 19:52:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1csH1W00T1kojtg0000000; Thu, 21 Dec 2006 19:52:18 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20061222004906.GC14789@spearce.org> (Shawn O. Pearce's message
	of "Thu, 21 Dec 2006 19:49:06 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35103>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> If the user has been using reflog for a long time (e.g. since its
> introduction) then it is very likely that an existing branch's
> reflog may still mention commits which have long since been pruned
> out of the repository.

I've thought about this issue when I did the repack/prune; my
take on this was you should prune reflog first then repack.
