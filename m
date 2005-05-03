From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: cogito cg-update fails
Date: Tue, 03 May 2005 13:19:34 +1000
Message-ID: <1115090374.6030.50.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue May 03 05:17:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSnud-0005Yl-Pm
	for gcvg-git@gmane.org; Tue, 03 May 2005 05:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVECDWs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 23:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVECDWs
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 23:22:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:53418 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261339AbVECDVh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 23:21:37 -0400
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j433FmgJ003720
	for <git@vger.kernel.org>; Mon, 2 May 2005 22:15:49 -0500
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Folks !

I have something weird happening with cogito. What I did is:

 - d/l & install 0.8 archive
 - cg-init <rync path>
 - built & install that, removed 0.8 files
 - a bit later: cg-update origin to check for new stuffs

The last one fails with:

benh@pogo:~/cogito$ cg-update origin
MOTD:
MOTD:   .../.. stripped kernel.org legal blurb

receiving file list ... done
.git/refs/heads/origin

sent 119 bytes  received 857 bytes  390.40 bytes/sec
total size is 41  speedup is 0.04
rsync: link_stat "/home/benh/cogito/origin/objects/." failed: No such file or directory (2)
building file list ... done
rsync error: some files could not be transferred (code 23) at main.c(702)

sent 17 bytes  received 20 bytes  74.00 bytes/sec
total size is 0  speedup is 0.00
cg-pull: objects pull failed

So it looks like it's trying to rsync to a bogus destination ...

Ben.


