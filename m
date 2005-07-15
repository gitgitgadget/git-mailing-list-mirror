From: Jeff Garzik <jgarzik@pobox.com>
Subject: Kernel Hacker's guide to git (updated)
Date: Fri, 15 Jul 2005 13:36:21 -0400
Message-ID: <42D7F415.30609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Dave Jones <davej@redhat.com>
X-From: git-owner@vger.kernel.org Fri Jul 15 19:37:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtU76-0001Bk-71
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 19:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263347AbVGORgb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jul 2005 13:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbVGORgb
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jul 2005 13:36:31 -0400
Received: from mail.dvmed.net ([216.237.124.58]:29149 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S263340AbVGORg3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2005 13:36:29 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DtU6q-0002tK-8s; Fri, 15 Jul 2005 17:36:24 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linux Kernel <linux-kernel@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I've updated my git quickstart guide at

	http://linux.yyz.us/git-howto.html

It now points to DaveJ's daily snapshots for the initial bootstrap 
tarball, is reorganized for better navigation, and other things.


Also, a bonus recipe:  how to import Linus's pack files (it's easy).

This recipe presumes that you have a vanilla-Linus repo 
(/repo/linux-2.6) and your own repo (/repo/myrepo-2.6).

$ cd /repo/myrepo-2.6
$ git-fsck-cache		# fsck, make sure we're OK
$ git pull /repo/linux-2.6/.git	# make sure we're up-to-date
$ cp -al ../linux-2.6/.git/objects/pack .git/objects
$ cp ../linux-2.6/.git/refs/tags/* .git/refs/tags
$ git-prune-packed
$ git-fsck-cache		# fsck #2, make sure we're OK

This recipe reduced my kernel.org sync from ~50,000 files to ~5,000 files.

	Jeff
