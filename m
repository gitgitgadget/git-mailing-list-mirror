From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 3/3] am: rename "struct tree_desc t" to "desc" for readability
Date: Fri, 21 Aug 2015 01:02:31 -0700
Message-ID: <1440144151-24026-3-git-send-email-davvid@gmail.com>
References: <1440144151-24026-1-git-send-email-davvid@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 10:06:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZShL8-0007v8-FE
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 10:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbbHUICq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 04:02:46 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35154 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbbHUICg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 04:02:36 -0400
Received: by pdob1 with SMTP id b1so23978877pdo.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 01:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=39M9LGeSYfSdrMIZUycqmVwCk1KRPZD5ho3DkputF8I=;
        b=usHtaDxEpVnEgF4ZPXLEBOuU6oiJC6/WXEnd1Xoeg6q1ocwLDAAuGD3xoK5Rhym5TP
         UbMzjhn0EnKLpDcI/RsZkt2Ndvtc6nCaCJbQKNdXgO3N+uXcvRXpRuOGKhswE5nRHmsk
         b8IXVxYfee5X0GqBWNYAQ/NhiGehnxEbujB3I95W7eC03aGReAXW1tsccdnYfYdEJc8G
         XyaGnYi/Q7W1SM2xB6JB8Ifhz3UkwDX/gjtPHQzH1JBuhS3lpq1ZlVLTvzjBiCROuvcd
         Hx8TQUNG3TH6QRX6zliK+BxRorJndCWg1yw0Mmvzyg35qA0ktB1x8i5/+2/SHLAYUbJp
         k30A==
X-Received: by 10.70.129.79 with SMTP id nu15mr14633640pdb.15.1440144156257;
        Fri, 21 Aug 2015 01:02:36 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id ng13sm488238pdb.21.2015.08.21.01.02.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Aug 2015 01:02:35 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.403.gd17121e
In-Reply-To: <1440144151-24026-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276281>

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 builtin/am.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 9db1b34..7e6860d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1907,7 +1907,7 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 {
 	struct lock_file *lock_file;
 	struct unpack_trees_options opts;
-	struct tree_desc t[2];
+	struct tree_desc desc[2];
 
 	if (parse_tree(head) || parse_tree(remote))
 		return -1;
@@ -1925,10 +1925,10 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 	opts.merge = 1;
 	opts.reset = reset;
 	opts.fn = twoway_merge;
-	init_tree_desc(&t[0], head->buffer, head->size);
-	init_tree_desc(&t[1], remote->buffer, remote->size);
+	init_tree_desc(&desc[0], head->buffer, head->size);
+	init_tree_desc(&desc[1], remote->buffer, remote->size);
 
-	if (unpack_trees(2, t, &opts)) {
+	if (unpack_trees(2, desc, &opts)) {
 		rollback_lock_file(lock_file);
 		return -1;
 	}
-- 
2.5.0.403.gd17121e
