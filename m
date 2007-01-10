From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/3] Don't save the commit buffer in git-describe.
Date: Wed, 10 Jan 2007 06:36:29 -0500
Message-ID: <20070110113629.GA25251@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 12:36:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4bkz-0000qz-76
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 12:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbXAJLge (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 06:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbXAJLge
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 06:36:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53327 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964862AbXAJLgd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 06:36:33 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4bkr-00044i-A2; Wed, 10 Jan 2007 06:36:29 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6380620FBAE; Wed, 10 Jan 2007 06:36:30 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36499>

The commit buffer (message of the commit) is not actually
used by the git-describe process.  We can save some memory
by not keeping it around.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 describe.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/describe.c b/describe.c
index f4029ee..3c2df03 100644
--- a/describe.c
+++ b/describe.c
@@ -162,6 +162,7 @@ int main(int argc, char **argv)
 	}
 
 	setup_git_directory();
+	save_commit_buffer = 0;
 
 	if (argc <= i)
 		describe("HEAD", 1);
-- 
1.4.4.4.gf027-dirty
