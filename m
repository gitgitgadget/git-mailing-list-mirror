From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 3/7] tree-walk: Correct bitrotted comment about tree_entry()
Date: Tue, 24 Aug 2010 20:53:11 -0600
Message-ID: <1282704795-29661-4-git-send-email-newren@gmail.com>
References: <1282704795-29661-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 04:52:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo66M-0008G6-6J
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 04:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756489Ab0HYCwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 22:52:01 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33622 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756408Ab0HYCvv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 22:51:51 -0400
Received: by mail-vw0-f46.google.com with SMTP id 3so180848vws.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 19:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=H9TP5zZpgBbLSiv8Wk7gZUlkDJGQ4leptW/FbpI3dJg=;
        b=lAHO5Dr7776dVc7m9/1NAvKM/KOHCTmx+E/+oGaGnVXzFHnIbwkpp2qSa/nfSPFzhz
         yrs5BcG7NckpSZMNDmZ68sT9jN44peu6hjZzLgC3nt+warTNOVWwlZRVRhDPo+iu+gqD
         Y6qQymNKvFyqEqFrdCfcVSFaeSijXfHDIWKkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VpvQbuJlAf96a6hxZ84h//117FNjFQ5reOvY9cDegJFOvZYzP2xoqmNPdMoNpm3i/p
         2Z6E0UVp6qaWmYPS44p6m6AO4y4lKtfA2kOSW15dZeGNpoy8nxmkjEGfS9jcRVi0T9r2
         xITjn6XyykF62M5B+Pf2XG3LC4RGy6tPYP1mQ=
Received: by 10.220.60.204 with SMTP id q12mr4943176vch.20.1282704710991;
        Tue, 24 Aug 2010 19:51:50 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id v11sm577473vbb.3.2010.08.24.19.51.48
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 19:51:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.39.gf7e23
In-Reply-To: <1282704795-29661-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154397>

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
1.7.2.2.39.gf7e23
