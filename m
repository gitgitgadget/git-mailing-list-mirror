From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: What broke snapshots now?
Date: Sun, 10 Jul 2005 15:39:38 +0100
Message-ID: <1121006378.23706.65.camel@baythorne.infradead.org>
References: <1120907336.8058.293.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0507090908490.17536@g5.osdl.org>
	 <1120952292.23706.49.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 16:39:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Drcy8-0004YD-OR
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 16:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVGJOjk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 10:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVGJOjk
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 10:39:40 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:4051 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261949AbVGJOjk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 10:39:40 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by baythorne.infradead.org with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1Drcy3-0000QX-59; Sun, 10 Jul 2005 15:39:39 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1120952292.23706.49.camel@baythorne.infradead.org>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-07-10 at 00:38 +0100, David Woodhouse wrote:
> Doh. I thought I'd already done that, but in fact that was for the
> scripts which feed the mailing list, while the snapshot script kept
> using my copy. 

Ok, the snapshot script starts working again if I change a few
environment variables to match what the tools now expect.

Now the mailing list feed isn't happy though -- it stopped being able to
pull from your tree at around 0600 UTC (which I think is then the last
DRM fix was added). I got this when trying to update...

Tree change: 0109fd37046de64e8459f8c4f4706df9ac7cc82c:f179bc77d09b9087bfc559d0368bba350342ac76
error: cannot read sha1_file for ce68a60e5c503aaef0a98f8d754effb6c7d9ee99
fatal: unable to read destination tree (ce68a60e5c503aaef0a98f8d754effb6c7d9ee99)

Applying changes...
Fast-forwarding 0109fd37046de64e8459f8c4f4706df9ac7cc82c -> f179bc77d09b9087bfc559d0368bba350342ac76
        on top of 0109fd37046de64e8459f8c4f4706df9ac7cc82c...
error: cannot read sha1_file for ce68a60e5c503aaef0a98f8d754effb6c7d9ee99
fatal: failed to unpack tree object f179bc77d09b9087bfc559d0368bba350342ac76

Since it's just a fast-forward, I just copied the 'origin' tag into the
'master' to move it forward. But it's still not happy:

hera /home/dwmw2/git/mail-2.6 $ cg-diff -r 0109fd37046de64e8459f8c4f4706df9ac7cc82c:f179bc77d09b9087bfc559d0368bba350342ac76
error: cannot read sha1_file for ce68a60e5c503aaef0a98f8d754effb6c7d9ee99
fatal: unable to read destination tree (ce68a60e5c503aaef0a98f8d754effb6c7d9ee99)

-- 
dwmw2
