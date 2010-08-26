From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 4/8] tree-walk: Correct bitrotted comment about tree_entry()
Date: Thu, 26 Aug 2010 00:21:47 -0600
Message-ID: <1282803711-10253-5-git-send-email-newren@gmail.com>
References: <1282803711-10253-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 26 08:21:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoVpV-0002cj-5x
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 08:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422Ab0HZGUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 02:20:34 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56443 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357Ab0HZGUb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 02:20:31 -0400
Received: by mail-gw0-f46.google.com with SMTP id 17so532360gwj.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 23:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KCCWdoA3MAFlfeyxeyjVdJd6BfE177cjkSxak/1HFIs=;
        b=waYzlumQNNDDNVtEFZIi3jLRiWxdlgcV4XMZnhXrs/c1w54aFXiv3YHPIUHfC/p687
         AH8MiNJZRCisPjYq+I185QvX63KdyCqodQvm7cgs32bYRIKDWtAlCRLm4NGvwuCZOAGl
         QFNq2P8+F9nUVrIRJajqi8OrnkugSeXogv3fw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SI652XV9tfe/P2Rdw5bRf8rCOoV8KTPZKmVcKWLndBQWMLHujQt0pCDwVw/dSc7cgi
         gGv3HyBIXd+xWMgeX3HQx5yYOJPq9wRiyyUyisopLF5p0SYdkwcNURuffuCcXMjZk+bk
         12nUz57cVdH3/+flp3GIrWHP+p9qQA6c1P+5M=
Received: by 10.150.73.29 with SMTP id v29mr9697001yba.222.1282803631046;
        Wed, 25 Aug 2010 23:20:31 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id t20sm7160156ybm.5.2010.08.25.23.20.28
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 23:20:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.45.ga60f
In-Reply-To: <1282803711-10253-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154523>

There was a code comment that referred to the "above two functions" but
over time the functions immediately preceding the comment have changed.
Just mention the relevant functions by name.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 tree-walk.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/tree-walk.h b/tree-walk.h
index 42110a4..a5175fa 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -28,7 +28,9 @@ static inline int tree_entry_len(const char *name, const unsigned char *sha1)
 void update_tree_entry(struct tree_desc *);
 void init_tree_desc(struct tree_desc *desc, const void *buf, unsigned long size);
 
-/* Helper function that does both of the above and returns true for success */
+/* Helper function that does both tree_entry_extract() and update_tree_entry()
+ * and returns true for success
+ */
 int tree_entry(struct tree_desc *, struct name_entry *);
 
 void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1);
-- 
1.7.2.2.45.ga60f
