From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] write-tree performance problems
Date: Wed, 20 Apr 2005 11:07:20 -0700
Message-ID: <20050420110720.0ff887b4.davem@davemloft.net>
References: <200504191250.10286.mason@suse.com>
	<200504201122.35448.mason@suse.com>
	<Pine.LNX.4.58.0504200833580.6467@ppc970.osdl.org>
	<200504201237.38374.mason@suse.com>
	<Pine.LNX.4.58.0504200957030.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: mason@suse.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 20:10:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOJdw-0003gY-K5
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 20:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVDTSOA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 14:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVDTSOA
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 14:14:00 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:30367
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261709AbVDTSN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 14:13:59 -0400
Received: from localhost
	([127.0.0.1] helo=cheetah.davemloft.net ident=davem)
	by cheetah.davemloft.net with smtp (Exim 3.36 #1 (Debian))
	id 1DOJbc-0000SD-00; Wed, 20 Apr 2005 11:07:20 -0700
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504200957030.6467@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Apr 2005 10:06:15 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> I bet your SHA1 implementation is done with hand-optimized and scheduled
> x86 MMX code or something, while my poor G5 is probably using some slow
> generic routine. As a result, it only improved by 33% for me since the
> compression was just part of the picture, but with your cheap SHA1 the
> compression costs really dominated, and so it's almost four times faster
> for you.

The openssl tree has a i586 optimized SHA1 implementation.
A quick scan of the 0.9.7e tree I happen to have lying around
shows there aren't optimized for other cpus in there, just i586.
