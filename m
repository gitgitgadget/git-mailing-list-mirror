From: David Barr <davidbarr@google.com>
Subject: [PATCH v2 6/6] vcs-svn: drop no-op reset methods
Date: Fri,  1 Jun 2012 00:41:30 +1000
Message-ID: <1338475290-22644-7-git-send-email-davidbarr@google.com>
References: <1338475290-22644-1-git-send-email-davidbarr@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 31 16:42:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa6aP-000404-Mp
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 16:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454Ab2EaOmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 10:42:35 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50238 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932389Ab2EaOmd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 10:42:33 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1551829pbb.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 07:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8xm/vPlW5dd3JC3SG39jhemsQh3jtqFlb2Qe1tVG3Ao=;
        b=Zmlj9lRgNzeD041GmWsvEaoluuqSz2LIrj0x0a/ujbWVd4IRvl7ooShMe7aOlCpLBV
         JUXM2d6h3DVA2W+fyKgPH82xUkMMlUhOV/fAS1NJckhn8x6sVOTATkQmqimho9lhimRr
         ccmpEPaUbRkIWrdwCMyf2GqtidtvxPX5yQSrFi0fCh5F91E5/UAqDNoBGu4kezJiw1IW
         Ae7l03WfdVj7zNENGOg8S8DJ1h8jXpKBqz4jG29MrLtN2Bm83BiDxeDLog+mfJ9sMebd
         gZPIZa1t0TsNK8VlAbc2zNSK70R8Kul3AS14gB+TZ1tGn1TNL16KG4LIJ93x5/cGArEO
         +30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=8xm/vPlW5dd3JC3SG39jhemsQh3jtqFlb2Qe1tVG3Ao=;
        b=cg7U2fWZrHNGi5qmXB5YMelICds8MqDet/8S4OpnjrZVep+PvvxpytTb1oByLnW1jT
         Lwc4ukuLRIts2nTqsavF3UaGCDCkePu8qMIjz/hndZVZrfmgbLsILqyiD9ZemOlfPQhR
         IwcJmSv8779yrHa43mpFYkhu2n5Bb5tidAWfWB10USQXeuu8mcOXd6viGHeG/19NC+Qr
         xwzUBd3nRtsRvT8oH7atpOC0GGqM67ktvGbsqNTQR4R/ISuAK78F4RN7FecZ6hTm7hu7
         Ghg5HRGdXDDYPrwT2ZOcQrH1HUj/9n4l6YWj2tHa2/Z4A/ClhRFs/Uz0rStTXsxStLGp
         M2BA==
Received: by 10.68.226.99 with SMTP id rr3mr492633pbc.48.1338475352874;
        Thu, 31 May 2012 07:42:32 -0700 (PDT)
Received: by 10.68.226.99 with SMTP id rr3mr492616pbc.48.1338475352732;
        Thu, 31 May 2012 07:42:32 -0700 (PDT)
Received: from localhost.localdomain (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id og6sm4376720pbb.42.2012.05.31.07.42.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 07:42:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1338475290-22644-1-git-send-email-davidbarr@google.com>
X-Gm-Message-State: ALoCoQm+8x+VSmMJfCRS9Ryaps1xclwAw48j8Lj970F4wN4IU6zG+QiDRlgUPBxth7FC8yXdG15zcHmOM7Fq02gX28vlzDukeHhqTkHecKbLwKAgCIZskOHU5Y8drMoe8RJq+Wc4kusfB3JbuVI/Ff5y7es4YqM3JN1z7VEp2MOBwKD6QDKB1og=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198915>

Since v1.7.5~42^2~6 (vcs-svn: remove buffer_read_string)
buffer_reset() does nothing thus fast_export_reset() also.

Signed-off-by: David Barr <davidbarr@google.com>
---
 vcs-svn/fast_export.c |    5 -----
 vcs-svn/fast_export.h |    1 -
 vcs-svn/line_buffer.c |    4 ----
 vcs-svn/line_buffer.h |    1 -
 vcs-svn/svndump.c     |    2 --
 5 files changed, 13 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 6ded98b..1f04697 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -42,11 +42,6 @@ void fast_export_deinit(void)
 		die_errno("error closing fast-import feedback stream");
 }
 
-void fast_export_reset(void)
-{
-	buffer_reset(&report_buffer);
-}
-
 void fast_export_delete(const char *path)
 {
 	putchar('D');
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index aa629f5..8823aca 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -6,7 +6,6 @@ struct line_buffer;
 
 void fast_export_init(int fd);
 void fast_export_deinit(void);
-void fast_export_reset(void);
 
 void fast_export_delete(const char *path);
 void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 01fcb84..57cc1ce 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -124,7 +124,3 @@ off_t buffer_skip_bytes(struct line_buffer *buf, off_t nbytes)
 	}
 	return done;
 }
-
-void buffer_reset(struct line_buffer *buf)
-{
-}
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index 8901f21..ee23b4f 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -14,7 +14,6 @@ struct line_buffer {
 int buffer_init(struct line_buffer *buf, const char *filename);
 int buffer_fdinit(struct line_buffer *buf, int fd);
 int buffer_deinit(struct line_buffer *buf);
-void buffer_reset(struct line_buffer *buf);
 
 int buffer_tmpfile_init(struct line_buffer *buf);
 FILE *buffer_tmpfile_rewind(struct line_buffer *buf);	/* prepare to write. */
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 6d1e3cd..f1705f3 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -499,8 +499,6 @@ void svndump_deinit(void)
 
 void svndump_reset(void)
 {
-	fast_export_reset();
-	buffer_reset(&input);
 	strbuf_release(&dump_ctx.uuid);
 	strbuf_release(&dump_ctx.url);
 	strbuf_release(&rev_ctx.log);
-- 
1.7.10.2
