From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/7] remote: expose get_ref_match()
Date: Thu, 23 May 2013 20:42:48 +0530
Message-ID: <1369321970-7759-6-git-send-email-artagnon@gmail.com>
References: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 23 17:11:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfXB4-0003im-5V
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 17:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759279Ab3EWPLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 11:11:20 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34823 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759247Ab3EWPLS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 11:11:18 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so3011465pbb.33
        for <git@vger.kernel.org>; Thu, 23 May 2013 08:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7/TT2d8HU4/z8Iu5VQNGR54RhlH2tTeeOHLnjn8ybzw=;
        b=dBWTd+0SLxoks0bdAE0jQtFSiUElVfEsORcg0Clvo1oecYBhWMLd/vathRNbngh7cb
         PACXuLJN7pq2awWpL5F1rHBBvNpY8sgtzakI2kJK27uUWQVPFmupTB9Hksgtf8PO6jd3
         o05Z47yZwUSuuNTMkUWKpX0jGW0eucHPJu2zMgMCkVYbcp7E+IMrGZTmWN4BMMWPrEWc
         Iaq/ntz8jPHPQmtqLH4XyuHrPZM5xkODXC+65G14R/s66fAbHQUinm7c3qNHZqgVhICi
         ea8VIyvtd+lKu1pijXihp+GNUtJU5wqPbIKHRq55nEOzyiDM4mmD/SSUiN9E+2LlsOag
         DArQ==
X-Received: by 10.69.0.132 with SMTP id ay4mr13364326pbd.62.1369321878105;
        Thu, 23 May 2013 08:11:18 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vb8sm12099173pbc.11.2013.05.23.08.11.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 23 May 2013 08:11:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.17.gd95ec6c.dirty
In-Reply-To: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225257>

We need it.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 remote.c | 2 +-
 remote.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 99c44da..9ae1fc5 100644
--- a/remote.c
+++ b/remote.c
@@ -1168,7 +1168,7 @@ static int match_explicit_refs(struct ref *src, struct ref *dst,
 	return errs;
 }
 
-static char *get_ref_match(const struct refspec *rs, int rs_nr, const struct ref *ref,
+char *get_ref_match(const struct refspec *rs, int rs_nr, const struct ref *ref,
 		int send_mirror, int direction, const struct refspec **ret_pat)
 {
 	const struct refspec *pat;
diff --git a/remote.h b/remote.h
index 2497b93..5671fe0 100644
--- a/remote.h
+++ b/remote.h
@@ -173,4 +173,7 @@ struct ref *guess_remote_head(const struct ref *head,
 /* Return refs which no longer exist on remote */
 struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fetch_map);
 
+char *get_ref_match(const struct refspec *rs, int rs_nr, const struct ref *ref,
+		int send_mirror, int direction, const struct refspec **ret_pat);
+
 #endif
-- 
1.8.3.rc3.17.gd95ec6c.dirty
