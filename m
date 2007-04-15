From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: [PATCH] display shortlog after git-commit
Date: Mon, 16 Apr 2007 01:39:09 +0300
Message-ID: <20070415223909.GG15208@mellanox.co.il>
References: <20070322104021.GJ29341@mellanox.co.il>
	<7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
	<20070404060213.GB31984@mellanox.co.il>
	<7v7iss8xo6.fsf@assigned-by-dhcp.cox.net>
	<20070404070135.GF31984@mellanox.co.il>
	<7vps6k7gez.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 00:39:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdDNJ-0002oK-4n
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 00:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031AbXDOWjJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 18:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754032AbXDOWjJ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 18:39:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:37923 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031AbXDOWjI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 18:39:08 -0400
Received: by ug-out-1314.google.com with SMTP id 44so973134uga
        for <git@vger.kernel.org>; Sun, 15 Apr 2007 15:39:06 -0700 (PDT)
Received: by 10.67.95.3 with SMTP id x3mr3142888ugl.1176676746510;
        Sun, 15 Apr 2007 15:39:06 -0700 (PDT)
Received: from ?127.0.0.1? ( [89.138.119.177])
        by mx.google.com with ESMTP id j2sm5845179ugf.2007.04.15.15.39.04;
        Sun, 15 Apr 2007 15:39:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vps6k7gez.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44535>

Display the subject of the commit just made.

Signed-off-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>

---

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] display shortlog after git-commit
> 
> Too noisy for a default.

So maybe the following isn't too bad?
This results in:
$ ./git-commit.sh --amend
Created commit 5633ddde0e35210f607bde063bcbf709e4d20a8d
Display the subject of the commit just made.
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 9e0959a..b2b90f0 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -650,7 +650,7 @@ then
 	if test -z "$quiet"
 	then
 		echo "Created${initial_commit:+ initial} commit $commit"
-		git-diff-tree --shortstat --summary --root --no-commit-id HEAD --
+		git-diff-tree --shortstat --pretty="format:%s" --summary --root --no-commit-id HEAD --
 	fi
 fi
 


-- 
MST
