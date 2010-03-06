From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 2/7] builtin/merge: make checkout_fast_forward() non static
Date: Sat, 06 Mar 2010 21:34:41 +0100
Message-ID: <20100306203447.2960.60379.chriscool@tuxfamily.org>
References: <20100306203250.2960.30309.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 03:28:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No6E9-0003Eu-Qu
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 03:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455Ab0CGC1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 21:27:53 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:45479 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754375Ab0CGC1s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 21:27:48 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 2B22781808F;
	Sun,  7 Mar 2010 03:27:38 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E2E1F818054;
	Sun,  7 Mar 2010 03:27:35 +0100 (CET)
X-git-sha1: 4d20c4d59f3e71bd45c97683fe50d00a17342872 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100306203250.2960.30309.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141639>

From: Junio C Hamano <gitster@pobox.com>

and also export it in "cache.h".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/merge.c |    2 +-
 cache.h         |    3 +++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 3aaec7b..c043066 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -667,7 +667,7 @@ static int count_unmerged_entries(void)
 	return ret;
 }
 
-static int checkout_fast_forward(unsigned char *head, unsigned char *remote)
+int checkout_fast_forward(const unsigned char *head, const unsigned char *remote)
 {
 	struct tree *trees[MAX_UNPACK_TREES];
 	struct unpack_trees_options opts;
diff --git a/cache.h b/cache.h
index 89f6a40..0608b55 100644
--- a/cache.h
+++ b/cache.h
@@ -1054,4 +1054,7 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix);
 char *alias_lookup(const char *alias);
 int split_cmdline(char *cmdline, const char ***argv);
 
+/* builtin/merge.c */
+int checkout_fast_forward(const unsigned char *from, const unsigned char *to);
+
 #endif /* CACHE_H */
-- 
1.7.0.1.307.g861f4
