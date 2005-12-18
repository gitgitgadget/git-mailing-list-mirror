From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] git-grep: convert from bash to sh
Date: Sun, 18 Dec 2005 22:18:00 +0200
Message-ID: <20051218221800.744e4565.tihirvon@gmail.com>
References: <20051218152639.5c14bc26.tihirvon@gmail.com>
 <Pine.LNX.4.64.0512181155360.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 18 21:20:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eo4z9-0002gj-Lv
	for gcvg-git@gmane.org; Sun, 18 Dec 2005 21:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965265AbVLRUSQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Dec 2005 15:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965266AbVLRUSQ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Dec 2005 15:18:16 -0500
Received: from marski.suomi.net ([212.50.131.142]:39372 "EHLO marski.suomi.net")
	by vger.kernel.org with ESMTP id S965265AbVLRUSQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Dec 2005 15:18:16 -0500
Received: from spartak.suomi.net (spartak.suomi.net [212.50.140.227])
 by marski.suomi.net (Sun Java System Messaging Server 6.2 (built Dec  2 2004))
 with ESMTP id <0IRP00EU1N2EZ260@marski.suomi.net> for git@vger.kernel.org;
 Sun, 18 Dec 2005 22:18:15 +0200 (EET)
Received: from spam1.suomi.net (spam1.suomi.net [212.50.131.165])
 by mailstore.suomi.net
 (Sun Java System Messaging Server 6.2-3.04 (built Jul 15 2005))
 with ESMTP id <0IRP007R7N8ELQC0@mailstore.suomi.net>; Sun,
 18 Dec 2005 22:21:51 +0200 (EET)
Received: from garlic.home.net (addr-82-128-203-211.suomi.net [82.128.203.211])
	by spam1.suomi.net (Postfix) with SMTP id 42EF41ACAA4; Sun,
 18 Dec 2005 22:18:00 +0200 (EET)
In-reply-to: <Pine.LNX.4.64.0512181155360.4827@g5.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i686-pc-linux-gnu)
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.362,	required 5,
 autolearn=not spam, AWL 0.24, BAYES_00 -2.60)
X-OPOY-MailScanner-From: tihirvon@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13802>

On Sun, 18 Dec 2005 11:57:26 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> On Sun, 18 Dec 2005, Timo Hirvonen wrote:
> > 
> > sh does not support arrays so we have to use eval instead.
> 
> This seems horribly broken.
> 
> If I'm not mistaken, this breaks
> 
> 	git grep "it's a happy coincidence"
> 
> badly. I didn't test, just looking at the patch.

Actually it works:

/usr/src/linux-2.6: git grep "it's a"
Documentation/Changes:debugfs.  Obviously, it's a good idea to upgrade.
Documentation/CodingStyle:and NOT read it.  Burn them, it's a great
symbolic gesture.


but it doesn't work with backslashes.  Need to use \\

/usr/src/linux-2.6: git grep 'e.\\n"'
Documentation/DMA-mapping.txt:		       "mydev: No suitable DMA
available.\n");
Documentation/DMA-mapping.txt:		       "mydev: No suitable DMA
available.\n");

-- 
http://onion.dynserv.net/~timo/
