From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/4] unpack-trees: trivial cleanup
Date: Thu, 30 May 2013 08:56:20 -0500
Message-ID: <1369922181-31016-4-git-send-email-felipe.contreras@gmail.com>
References: <1369922181-31016-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 15:58:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui3N3-0007EF-Ct
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 15:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306Ab3E3N6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 09:58:18 -0400
Received: from mail-ye0-f169.google.com ([209.85.213.169]:42891 "EHLO
	mail-ye0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932288Ab3E3N6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 09:58:16 -0400
Received: by mail-ye0-f169.google.com with SMTP id m9so53895yen.14
        for <git@vger.kernel.org>; Thu, 30 May 2013 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pCN8PIU1v5Zc+U6HS2CEcYGL1mePFWxxkgPnlsXpG4w=;
        b=LDNsZq4MSMr4sZPEzJtmSjH+Dx3hSnt+EF7sXrqw6GpiT0lx87JAzRLElDKXKzEAkp
         42Mu0CTHa8Lc/tAn9d1hCWEvMhUDElGxyL+7/pqezEkuj8HEIQ5obUzdi3D595KOSQkT
         zS2ZejQlORdhvZQskAbV3kjzQO4sHtvCWWYFpbslxazbt5MFzjfFaER5ODeeIB77iwkV
         k+zbeBlvfDys+Mf/ee0xCOFo1jGiy/184kFc94BsQP4IIGZEenuaryys8VMI5ukkG6+B
         vDO9AktSA+34mcjMc90wnIwxUULdgcLhzjLYYKE4AOc+Hv7yH2+dE3Bwy/85cXaEPG0V
         InSw==
X-Received: by 10.236.18.233 with SMTP id l69mr3669605yhl.201.1369922295772;
        Thu, 30 May 2013 06:58:15 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id m47sm12980492yhb.11.2013.05.30.06.58.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 06:58:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369922181-31016-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225999>

dfc has not been initialized at this point.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 unpack-trees.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index ede4299..36f4ff7 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1040,8 +1040,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (!o->skip_sparse_checkout)
 		mark_new_skip_worktree(o->el, o->src_index, 0, CE_NEW_SKIP_WORKTREE);
 
-	if (!dfc)
-		dfc = xcalloc(1, cache_entry_size(0));
+	dfc = xcalloc(1, cache_entry_size(0));
 	o->df_conflict_entry = dfc;
 
 	if (len) {
-- 
1.8.3.rc3.312.g47657de
