From: Petr Baudis <pasky@ucw.cz>
Subject: [PATCH] Fix git-merge-cache -q
Date: Fri, 5 Aug 2005 00:31:12 +0200
Message-ID: <20050804223112.GG24479@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 05 00:35:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0oI0-0006vu-2W
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 00:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbVHDWdk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 18:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbVHDWdb
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 18:33:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:9741 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262759AbVHDWbO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 18:31:14 -0400
Received: (qmail 30496 invoked by uid 2001); 4 Aug 2005 22:31:12 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I'm totally stupid and got it backwards, sorry about that.
git-merge-cache -q would mean it's noisy and quiet without any
parameters.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

---
commit 1d86b5cb68dd47b4fced8343945c8860946df5d2
tree 25c4f9cabd6db8c92ab1b0313093d898c03b2b7a
parent 04c23173a8120f3bd2ae8af545e7e4f62c505ef0
author Petr Baudis <pasky@suse.cz> Sat, 30 Jul 2005 13:07:03 +0200
committer Petr Baudis <xpasky@machine.sinus.cz> Sat, 30 Jul 2005 13:07:03 +0200

 merge-cache.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-cache.c b/merge-cache.c
--- a/merge-cache.c
+++ b/merge-cache.c
@@ -30,7 +30,7 @@ static void run_program(void)
 		if (one_shot) {
 			err++;
 		} else {
-			if (quiet)
+			if (!quiet)
 				die("merge program failed");
 			exit(1);
 		}
@@ -129,7 +129,7 @@ int main(int argc, char **argv)
 		}
 		merge_file(arg);
 	}
-	if (err && quiet)
+	if (err && !quiet)
 		die("merge program failed");
 	return err;
 }
