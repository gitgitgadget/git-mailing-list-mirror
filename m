From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/4] read-cache: trivial style cleanups
Date: Thu, 30 May 2013 08:56:19 -0500
Message-ID: <1369922181-31016-3-git-send-email-felipe.contreras@gmail.com>
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
	id 1Ui3N2-0007EF-Qv
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 15:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296Ab3E3N6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 09:58:16 -0400
Received: from mail-ye0-f178.google.com ([209.85.213.178]:54464 "EHLO
	mail-ye0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932244Ab3E3N6N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 09:58:13 -0400
Received: by mail-ye0-f178.google.com with SMTP id m2so53810yen.23
        for <git@vger.kernel.org>; Thu, 30 May 2013 06:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pNZ5lhQC2XrOdNy929IOyYtlnGyY2S+cFBrreRUoVyg=;
        b=zLcoJd4n+7V+EJZUC6RZ26ZPB7ODxYYEt1ZBnPaEAJ1R3REeP/3179BYdO00F2nBvJ
         heiaaWdBUnKUaMprmzLorUY2v/eYCfRjfUtOazGA6gvPn5zQPO7QemrKK8qBrdUPWJqi
         j97oZVxFLsjTHKFNSlN8qety+Q5SrQ0BrZpKn8bK6GyCX5V81stHoWziFomDJXLqS76I
         JirXVyMeoxMhthJIGIWIRS7fYPmlmtpCK4CzuYlaaGY95m+o6g3ATCFBSZR/kTXd3r3q
         ttVExI2LEC0Cs2mwYVAW3LlG8TuehMLSAfTYL1Gn7ANWITykIGQPhceNLQBWYDO135c0
         AVDQ==
X-Received: by 10.236.22.230 with SMTP id t66mr3706035yht.70.1369922293062;
        Thu, 30 May 2013 06:58:13 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id f19sm59235095yhj.3.2013.05.30.06.58.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 06:58:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369922181-31016-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225998>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 read-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 5253ec5..7040e79 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -979,7 +979,7 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
 	if (istate->cache_nr == istate->cache_alloc) {
 		istate->cache_alloc = alloc_nr(istate->cache_alloc);
 		istate->cache = xrealloc(istate->cache,
-					istate->cache_alloc * sizeof(struct cache_entry *));
+					istate->cache_alloc * sizeof(*istate->cache));
 	}
 
 	/* Add it in.. */
@@ -1449,7 +1449,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	istate->version = ntohl(hdr->hdr_version);
 	istate->cache_nr = ntohl(hdr->hdr_entries);
 	istate->cache_alloc = alloc_nr(istate->cache_nr);
-	istate->cache = xcalloc(istate->cache_alloc, sizeof(struct cache_entry *));
+	istate->cache = xcalloc(istate->cache_alloc, sizeof(*istate->cache));
 	istate->initialized = 1;
 
 	if (istate->version == 4)
-- 
1.8.3.rc3.312.g47657de
