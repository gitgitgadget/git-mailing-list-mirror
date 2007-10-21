From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH-resent] gitk: fix in procedure drawcommits
Date: Sun, 21 Oct 2007 13:01:20 +1000
Message-ID: <18202.49408.264600.839673@cargo.ozlabs.ibm.com>
References: <20071019052823.GI14735@spearce.org>
	<200710191544.22228.barra_cuda@katamail.com>
	<18201.54648.707559.480169@cargo.ozlabs.ibm.com>
	<200710201802.48111.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	pdmef@gmx.net
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 05:01:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjR4W-0004wV-FM
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 05:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbXJUDBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 23:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbXJUDBe
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 23:01:34 -0400
Received: from ozlabs.org ([203.10.76.45]:41760 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885AbXJUDBe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 23:01:34 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id A42D9DDE46; Sun, 21 Oct 2007 13:01:32 +1000 (EST)
In-Reply-To: <200710201802.48111.barra_cuda@katamail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61869>

Michele Ballabio writes:

> This commit (and many others) has two parents, but the two parents
> have the same hash. So gitk tries to unset the same variable twice,
> hence the error. At this point, the fix for gitk should be either to
> check if the parents have the same hash when reading the commit or
> avoiding to unset two times the same variable.

Actually, there is a commit like that in the kernel tree, and with
this clue, I have managed to reproduce the problem on the kernel tree
with the command

	gitk v2.6.12-rc2..13e652800d1644dfedcd0d59ac95ef0beb7f3165

I have just pushed out a fix to my gitk.git tree.

Paul.
