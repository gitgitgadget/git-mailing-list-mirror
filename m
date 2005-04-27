From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Finding file revisions
Date: Wed, 27 Apr 2005 20:41:08 +0200
Message-ID: <1114627268.20916.8.camel@tglx.tec.linutronix.de>
References: <200504271251.00635.mason@suse.com>
	 <Pine.LNX.4.58.0504271027460.18901@ppc970.osdl.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Chris Mason <mason@suse.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 12:30:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR6HE-0007gx-Nb
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 12:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVD1Ke6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 06:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVD1Ke5
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 06:34:57 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:22716
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262010AbVD1Keq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 06:34:46 -0400
Received: from mail.tec.linutronix.de (213-239-205-147.clients.your-server.de [213.239.205.147])
	by mail.tglx.de (Postfix) with ESMTP id A2D2E65C065;
	Thu, 28 Apr 2005 12:32:49 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 3ADF0281D9;
	Wed, 27 Apr 2005 19:41:10 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504271027460.18901@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-04-27 at 10:34 -0700, Linus Torvalds wrote:

> > This will scale pretty badly as the tree grows, but 
> > I usually only want to search back a few months in the history.  So, it 
> > might make sense to limit the results by date or commit/tag.
> 
> With more history, "rev-list" should do basically the right thing: it will
> be constant-time for _recent_ commits, and it is linear time in how far
> back you want to go. Which seems quite reasonable.

Which is quite horrible, if you have a 500k+ blobs repo.

I know you are database allergic, but there a database is the correct
solution. Having stored all the relations of those file/tree/commit
blobs in a database it takes <20ms to have a list of all those file
blobs in historical order with some context information retrieved. Thats
not on a monster machine, its on an ordinary wallmart pc

tglx


