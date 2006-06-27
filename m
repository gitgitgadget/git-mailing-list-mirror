From: Martin Hicks <mort@bork.org>
Subject: bisect help
Date: Tue, 27 Jun 2006 16:13:02 -0400
Message-ID: <20060627201302.GA16658@bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jun 27 22:13:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvJvt-0001f2-Qv
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 22:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161259AbWF0UNH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 16:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161266AbWF0UNG
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 16:13:06 -0400
Received: from galileo.bork.org ([134.117.69.57]:1181 "EHLO galileo.bork.org")
	by vger.kernel.org with ESMTP id S1161259AbWF0UND (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 16:13:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by galileo.bork.org (Postfix) with ESMTP id DC81D4105
	for <git@vger.kernel.org>; Tue, 27 Jun 2006 16:13:02 -0400 (EDT)
Received: from galileo.bork.org ([127.0.0.1])
	by localhost (galileo.bork.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 18955-03 for <git@vger.kernel.org>;
	Tue, 27 Jun 2006 16:13:02 -0400 (EDT)
Received: by galileo.bork.org (Postfix, from userid 1000)
	id C4D2D4198; Tue, 27 Jun 2006 16:13:02 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at bork.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22752>


I've got a use-case that I can't figure out.  The problem:

- I have a tree with 2.6.17 + changes to make my target board work.
- SATA works as of 2.6.17, but stops working in the libata dev tree.

I want to do a bisect on this to figure out why.  I think the problem is
that the common ancestor between the two trees is 2.6.17, and when I
bisect I don't have any of my arch-specific changes still in the tree
(so the kernel doesn't boot, but not for SATA reasons)

I have my tree in "master", Jeff's SATA tree in "satadev".  I've tried a
few things like:

git checkout -b garbage master
git pull . satadev			# to get all the sata changes
git bisect start
git bisect bad
git bisect good master

but it seems like this causes the bisect to happen between the common
ancestor (v2.6.17) and the merge of master & satadev.

help!
thanks
mh

-- 
Martin Hicks || mort@bork.org || PGP/GnuPG: 0x4C7F2BEE
