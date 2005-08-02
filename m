From: barkalow@iabervon.org
Subject: [PATCH 0/3] Parallel pull for SSH
Date: Tue, 2 Aug 2005 19:45:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0508021939320.23721@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 01:43:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E06Ot-0005Ji-J2
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 01:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVHBXmQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Aug 2005 19:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVHBXmQ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Aug 2005 19:42:16 -0400
Received: from iabervon.org ([66.92.72.58]:3851 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261875AbVHBXmP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2005 19:42:15 -0400
Received: (qmail 5070 invoked by uid 1000); 2 Aug 2005 19:45:12 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Aug 2005 19:45:12 -0400
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This series pipelines pulling by ssh; objects are requested as soon as 
possible, and read once as many hashes as possible have been stuffed in 
the queue. This seems to be a major improvement in throughput, although it 
doesn't do any packing, so the total data transferred is higher than it 
could be.

 1: Object library additions
 2: Parallel pull algorithm
 3: Pipelined SSH support

It replaces these commits from -pu:
 9d469633827c3ac9736ff5cca620db0491ecb200
 7e11bade2166d11e3ce0b8635eb9f61716cddcd6

	-Daniel
*This .sig left intentionally blank*
