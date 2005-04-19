From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: SCSI trees, merges and git status
Date: Tue, 19 Apr 2005 10:10:54 +1000
Message-ID: <1113869456.3579.12.camel@localhost.localdomain>
References: <1113856118.4998.70.camel@mulgrave>
	 <Pine.LNX.4.58.0504181429570.15725@ppc970.osdl.org>
	 <1113866092.4998.92.camel@mulgrave>
	 <Pine.LNX.4.58.0504181651241.15725@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: James Bottomley <James.Bottomley@SteelEye.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 02:07:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNgGr-000242-PF
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 02:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVDSALT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 20:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVDSALT
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 20:11:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19168 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261198AbVDSALR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 20:11:17 -0400
Received: from [150.203.247.9] (helo=[172.24.3.18])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DNgKg-0000gX-IO; Tue, 19 Apr 2005 01:11:16 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504181651241.15725@ppc970.osdl.org>
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-04-18 at 17:03 -0700, Linus Torvalds wrote:
> Git does work like BK in the way that you cannot remove history when you
> have distributed it. Once it's there, it's there.

But older history can be pruned, and there's really no reason why an
http-based 'git pull' couldn't simply refrain from fetching commits
older than a certain threshold.

However, we can't _add_ the history if the current commits don't refer
to it. I really think we should take the imported git history and make
our 'current' tree refer to it -- even if just by having an appropriate
'parent' record in what is currently the oldest changeset in our tree;
the 2.6.12-rc2 import.

It doesn't matter that our oldest commit object refers to a nonexistent
parent, but that does allow us to import historical data if we _want_
to, and have it all work properly.

We should have the full historical git repo available within a day or
so, I believe. It would be really useful if we could make the current
trees refer back to that, instead of starting at 2.6.12-rc2.

-- 
dwmw2

