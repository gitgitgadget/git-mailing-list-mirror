From: Peter Osterlund <petero2@telia.com>
Subject: git bisect idea: Asymmetric split points
Date: 09 Oct 2006 01:43:08 +0200
Message-ID: <m38xjqfk6r.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 09 01:43:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWiIi-0004yC-MB
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 01:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWJHXnL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 19:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWJHXnL
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 19:43:11 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:20982 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932112AbWJHXnK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Oct 2006 19:43:10 -0400
Received: from p4.localdomain (81.232.170.121) by pne-smtpout1-sn1.fre.skanova.net (7.2.076)
        id 4523CB57000F61C4 for git@vger.kernel.org; Mon, 9 Oct 2006 01:43:09 +0200
Received: from p4.localdomain (p4.localdomain [127.0.0.1])
	by p4.localdomain (8.13.7/8.13.7) with ESMTP id k98Nh8ij002131
	for <git@vger.kernel.org>; Mon, 9 Oct 2006 01:43:08 +0200
Received: (from petero@localhost)
	by p4.localdomain (8.13.7/8.13.7/Submit) id k98Nh8D9002126;
	Mon, 9 Oct 2006 01:43:08 +0200
X-Authentication-Warning: p4.localdomain: petero set sender to petero2@telia.com using -f
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28553>

I was using git bisect today when trying to track down a random kernel
hang during boot. Since the hang is random, ie it only hangs during
some boots, identifying a bad version is easier than identifying a
good version. If it hangs during one boot, the kernel is clearly bad,
but if it doesn't hang I can't be sure if it's good or bad. I have to
test several times to be reasonably sure that a kernel is good.

In this scenario identifying a bad kernel is easier than identifying a
good kernel. This means that if I want to find the guilty commit as
fast as possible the best strategy is not to split the remaining
commit list in half. In this case it would be better to split closer
to a known bad commit.

You can also imagine cases where identifying a bad version is more
costly than identifying a good one. One example would be if a bad
kernel has nasty side effects, such as file system corruption, that
you have to fix up before you can continue bisecting.

To handle these cases more efficiently, I think it would be nice to be
able to tell git bisect where the bisection point is wanted, for
example by specifying a percentage.

Does this sound like a good idea? Would it be hard to implement?

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
