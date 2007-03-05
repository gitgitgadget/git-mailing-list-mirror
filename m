From: Bill Lear <rael@zopyra.com>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 5 Mar 2007 17:38:07 -0600
Message-ID: <17900.43487.947400.649777@lisa.zopyra.com>
References: <17895.18265.710811.536526@lisa.zopyra.com>
	<20070302091426.GA2605@diana.vm.bytemark.co.uk>
	<17896.9631.316001.869157@lisa.zopyra.com>
	<Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070302162136.GA9593@diana.vm.bytemark.co.uk>
	<Pine.LNX.4.63.0703022018190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070305072323.GA31169@diana.vm.bytemark.co.uk>
	<Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.27067.247950.419438@lisa.zopyra.com>
	<Pine.LNX.4.63.0703052014020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.30394.172067.743310@lisa.zopyra.com>
	<Pine.LNX.4.63.0703052143120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.36569.805689.922989@lisa.zopyra.com>
	<Pine.LNX.4.64.0703051347490.3998@woody.linux-foundation.org>
	<17900.39124.763603.695942@lisa.zopyra.com>
	<Pine.LNX.4.64.0703051431130.3998@woody.linux-foundation.org>
	<17900.42415.750335.329874@lisa.zopyra.com>
	<Pine.LNX.4.63.0703060026340.13683@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 06 00:38:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOMlC-00025N-I1
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 00:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbXCEXiX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 18:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752622AbXCEXiX
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 18:38:23 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60378 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568AbXCEXiW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 18:38:22 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l25NcKQ13232;
	Mon, 5 Mar 2007 17:38:20 -0600
In-Reply-To: <Pine.LNX.4.63.0703060026340.13683@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41506>

On Tuesday, March 6, 2007 at 00:32:28 (+0100) Johannes Schindelin writes:
>...
>Bill, maybe you don't want to hear it, but for all those following this 
>thread, here is why you are wrong:

An actual demonstration of my stupidity is much, much preferable
to a mere assertion of it, so I read the following with relish.

>"make" does _not_ match the time stamps of xyz.c and xyz.o. After you 
>"make", the only thing which is guaranteed is that if xyz.c is _newer_ 
>than xyz.o, the compiler is started.
>
>Example:
>
>00:05 you pull upstream into your master branch, which has a newer xzy.c
>00:07 you type make. xyz.o is built, because make sees that xyz.c is 
>      newer than xyz.o
>00:12 you checkout your side branch, xyz.c is updated.
>00:13 you type make, and again xzy.o is built, because xyz.c is newer than 
>      xyz.o
>00:25 you switch back to your master branch.
>
>Now, if your wish would be granted, and xyz.c has the same timestamp as 
>before, then it _still_ is older than xyz.o. So make will not rebuild it.
>
>BUT xyz.o is actually compiled from the side branch's version of xyz.c!

No, I think you missed my point.  There are two xyz.o's:

One in .master/xyz.o, and one in .branchX/xyz.o.  So, you're example
becomes:

00:05 you pull upstream into your master branch, which has a newer xzy.c
00:07 you type make. .master/xyz.o is built, because make sees that xyz.c is 
      newer than .master/xyz.o
00:12 you checkout your side branch, xyz.c is updated.
00:13 you type make, and .branchX/xzy.o is built, because xyz.c is newer than 
      .branchX/xyz.o
00:25 you switch back to your master branch.
00:26 you type make, and nothing happens, as it should not.  You are
      happy, and thank the git community for all of their heroic efforts.

Now, I'm really going to go: the family is hungry and I've got
dinner to prepare, so if you want to flame me for opening my mouth
further, feel free.


Bill
