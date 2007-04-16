From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] display the subject of the commit just made
Date: Sun, 15 Apr 2007 23:17:12 -0700
Message-ID: <7vejmkx2qf.fsf@assigned-by-dhcp.cox.net>
References: <20070322104021.GJ29341@mellanox.co.il>
	<7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
	<20070404060213.GB31984@mellanox.co.il>
	<7v7iss8xo6.fsf@assigned-by-dhcp.cox.net>
	<20070404070135.GF31984@mellanox.co.il>
	<7vps6k7gez.fsf@assigned-by-dhcp.cox.net>
	<20070415223909.GG15208@mellanox.co.il>
	<7vy7kt1bij.fsf@assigned-by-dhcp.cox.net>
	<20070416035325.GA20304@mellanox.co.il>
	<7vwt0cx5jr.fsf@assigned-by-dhcp.cox.net>
	<20070416054059.GB23255@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon Apr 16 08:17:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdKWp-00074a-C3
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 08:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbXDPGRO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 02:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbXDPGRN
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 02:17:13 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:52403 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140AbXDPGRN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 02:17:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416061712.ROTP1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 16 Apr 2007 02:17:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id niHC1W00S1kojtg0000000; Mon, 16 Apr 2007 02:17:12 -0400
In-Reply-To: <20070416054059.GB23255@mellanox.co.il> (Michael S. Tsirkin's
	message of "Mon, 16 Apr 2007 08:40:59 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44587>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

> BTW, a couple of questions:
> 1. do we really need the shortstat info?

I am between neutral to slightly negative, so I won't miss it if
it is removed, but I'll let people who wanted it to defend it.

> 2. why is there "--" at the end do in the original version?

Blame is always your friend.

	$ git blame -L'/^git-diff-tree .*--$/,1' git-commit.sh

finds that it came from this commit:

commit 521f9c4def9430526bfdfffdb8ed4c2f4166bece
Author: Michael Loeffler <zvpunry@zvpunry.de>
Date:   Mon Jan 8 20:23:13 2007 +0100

    git-commit: do not fail to print the diffstat even if there is a file named HEAD
    
    Signed-off-by: Michael Loeffler <zvpunry@zvpunry.de>
    Signed-off-by: Junio C Hamano <junkio@cox.net>

diff --git a/git-commit.sh b/git-commit.sh
index 04aad5e..c2beb76 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -628,7 +628,7 @@ then
 	if test -z "$quiet"
 	then
 		echo "Created${initial_commit:+ initial} commit $commit"
-		git-diff-tree --shortstat --summary --root --no-commit-id HEAD
+		git-diff-tree --shortstat --summary --root --no-commit-id HEAD --
 	fi
 fi
