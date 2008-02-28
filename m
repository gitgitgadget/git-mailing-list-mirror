From: Jeff Garzik <jeff@garzik.org>
Subject: 'git gc' always run, on old kernel repo?
Date: Thu, 28 Feb 2008 14:57:39 -0500
Message-ID: <47C71233.4050705@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 20:59:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUou3-0005sU-15
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 20:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765172AbYB1T5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 14:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765167AbYB1T5n
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 14:57:43 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:37431 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765080AbYB1T5l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 14:57:41 -0500
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.66 #1 (Red Hat Linux))
	id 1JUost-0006YY-U8; Thu, 28 Feb 2008 19:57:40 +0000
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75438>

In order to apply a kernel patch diff'd against an older kernel, I ran

	git checkout -b tmp v2.6.23
	git-am --signoff --utf8 /g/tmp/mbox

The patch applied successfully, but each time I run this, it starts an 
automated 'git gc' run...  even if there is nothing useful to gc:

> [jgarzik@pretzel netdev-2.6]$ git-am --signoff --utf8 /g/tmp/mbox 
> Applying Add support for HT1100 SATA controller - sent from evolution
> Auto packing your repository for optimum performance. You may also
> run "git gc" manually. See "git help gc" for more information.
> Counting objects: 1, done.
> Writing objects: 100% (1/1), done.
> Total 1 (delta 0), reused 0 (delta 0)
> warning: There are too many unreachable loose objects; run 'git prune' to remove them.

IMO there is a broken hueristic in there somewhere...  I regularly run 
'git gc' on my repos...

	Jeff


