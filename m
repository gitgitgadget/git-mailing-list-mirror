From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: [PATCH] remove shortlog from git-commit output
Date: Mon, 16 Apr 2007 17:40:38 +0300
Message-ID: <20070416144038.GA32515@mellanox.co.il>
References: <20070322104021.GJ29341@mellanox.co.il>
	<7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
	<20070404060213.GB31984@mellanox.co.il>
	<7v7iss8xo6.fsf@assigned-by-dhcp.cox.net>
	<20070404070135.GF31984@mellanox.co.il>
	<7vps6k7gez.fsf@assigned-by-dhcp.cox.net>
	<20070415223909.GG15208@mellanox.co.il>
	<7vy7kt1bij.fsf@assigned-by-dhcp.cox.net>
	<20070416053435.GA23255@mellanox.co.il>
	<7vk5wcx3cd.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 16:40:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdSNq-0007ip-GY
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 16:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030672AbXDPOkn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 10:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030682AbXDPOkm
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 10:40:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:40878 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030672AbXDPOkl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 10:40:41 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1126823uga
        for <git@vger.kernel.org>; Mon, 16 Apr 2007 07:40:39 -0700 (PDT)
Received: by 10.66.225.1 with SMTP id x1mr4370102ugg.1176734439329;
        Mon, 16 Apr 2007 07:40:39 -0700 (PDT)
Received: from ?127.0.0.1? ( [194.90.237.34])
        by mx.google.com with ESMTP id 39sm6434013ugb.2007.04.16.07.40.34;
        Mon, 16 Apr 2007 07:40:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vk5wcx3cd.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44646>

Make git-commit only display --summary since addition/deletion
are notable events that do not happen with every commit.

Signed-off-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>

---

> > BTW, Junio, why does git-commit need to display the diffstat?
> > You just made the commit ...
> 
> Don't ask me.  It was not my idea.
> 
> We only had --summary per popular list request, and it made
> certain amount of sense since addition/deletion are notable
> events that do not happen with _every_ commit.

So how about this?

diff --git a/git-commit.sh b/git-commit.sh
index f28fc24..3e6866c 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -649,7 +649,7 @@ then
 	fi
 	if test -z "$quiet"
 	then
-		commit=`git-diff-tree --always --shortstat --pretty="format:%h: %s"\
+		commit=`git-diff-tree --always --pretty="format:%h: %s"\
 		       --summary --root HEAD --`
 		echo "Created${initial_commit:+ initial} commit $commit"
 	fi

-- 
MST
