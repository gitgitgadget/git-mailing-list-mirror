From: Ari Entlich <atrigent@ccs.neu.edu>
Subject: Help with sparse checkouts
Date: Mon, 12 Aug 2013 14:27:51 -0400 (EDT)
Message-ID: <6658365.507831376332071042.JavaMail.root@zimbra>
References: <7159505.507781376331946615.JavaMail.root@zimbra>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 12 21:05:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8xQM-0001PX-9H
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 21:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609Ab3HLTE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 15:04:57 -0400
Received: from amber.ccs.neu.edu ([129.10.116.51]:51821 "EHLO
	amber.ccs.neu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab3HLTE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 15:04:56 -0400
X-Greylist: delayed 2211 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Aug 2013 15:04:56 EDT
Received: from zimbra.ccs.neu.edu ([129.10.116.59])
	by amber.ccs.neu.edu with esmtp (Exim 4.69)
	(envelope-from <atrigent@ccs.neu.edu>)
	id 1V8wqT-0007Nr-CI
	for git@vger.kernel.org; Mon, 12 Aug 2013 14:28:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.ccs.neu.edu (Postfix) with ESMTP id 4E93DF5C015
	for <git@vger.kernel.org>; Mon, 12 Aug 2013 14:27:57 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zimbra.ccs.neu.edu
Received: from zimbra.ccs.neu.edu ([127.0.0.1])
	by localhost (zimbra.ccs.neu.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 39QPkRDXcab0 for <git@vger.kernel.org>;
	Mon, 12 Aug 2013 14:27:51 -0400 (EDT)
Received: from zimbra.ccs.neu.edu (zimbra.ccs.neu.edu [129.10.116.59])
	by zimbra.ccs.neu.edu (Postfix) with ESMTP id 2CD39F5C019
	for <git@vger.kernel.org>; Mon, 12 Aug 2013 14:27:51 -0400 (EDT)
In-Reply-To: <7159505.507781376331946615.JavaMail.root@zimbra>
X-Originating-IP: [134.174.110.8]
X-Mailer: Zimbra 5.0.22_GA_3210.UBUNTU6 (ZimbraWebClient - FF3.0 (Mac)/5.0.22_GA_3210.UBUNTU6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232203>

Hello all!

At my current workplace, I have a git-svn repository which has an extremely large working directory. I did not use the --stdlayout option in this clone, so I have a number of branches in my working directory which duplicate large amounts of trunk. There is a particularly large subdirectory which has now been copied to branches four times (and hence shows up in my working directory 5 times). This directory and its copies are making up the vast majority of the files and storage space in my working directory. Furthermore, I do not need or want to have access to the data in these particular directories. Hence, I would like to use the sparse checkouts feature to exclude them from my working directory.

Let's say that these directories are all called "thedir". What I would like to do with the sparse checkouts feature is to simply ignore directories with this name anywhere in the working tree. Intuitively, it seems like I should be able to put:

!thedir

or possibly

!thedir/

in the sparse-checkout file, but these don't seem to work. I've tried a number of other things, but I always seem to either get the "sparse checkout leaves no entry on working directory" error or no effect at all. In the end, I basically just don't really understand how this file is supposed to work, so I'd rather get some expert help here rather than thrashing about randomly. I realize that sparse checkouts is usually used to select a specific directory rather than what I'm trying to do, so I accept that what I want may simply not be possible with the current implementation. I've asked on IRC, but I wanted to ask here also since it seemed that most of the people I talked to weren't that familiar with the sparse checkouts feature.

Note that, while using --stdlayout would mitigate the massive working directory somewhat, I would still probably want to exclude this directory from my worktree. I will probably do a reclone at some point and use --stdlayout, but I will still want to exclude this particular directory even at that point. I had a lot of people on IRC telling me to just use --stdlayout, which was a good suggestion, but didn't fully fulfill my needs.

Thanks!

Ari
