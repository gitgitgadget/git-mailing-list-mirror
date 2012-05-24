From: David Barr <davidbarr@google.com>
Subject: [PATCH 4/7] vcs-svn: drop no-op reset methods
Date: Fri, 25 May 2012 00:04:16 +1000
Message-ID: <1337868259-45626-5-git-send-email-davidbarr@google.com>
References: <1337868259-45626-1-git-send-email-davidbarr@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 24 16:05:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXYfa-0003mX-Dv
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 16:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756315Ab2EXOFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 10:05:36 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50024 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339Ab2EXOFe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 10:05:34 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so11360466dad.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 07:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=sh51h7ilTeI2NKnilGneYf7sta7xhm6IiGyYeMS/86M=;
        b=QJzRuvWOJS2PohV+uzCywKewT3x83VpWvWc2zXVr5Imlnjeh8VRsAXAcjiVgIReyom
         MDDb4FJniy9G9AKR48hvtSdnuvuXiUL8uu8y97f6DF4LpXMFO9lPC8Rn3CakG2nJjZh8
         lG1qTEIvQyFd1xVWupwxt3olJy4rdrYmIxcNOqVC8lalGDgVuEpIM9OfhBlzx2VM8PCD
         X2Bfkh/bNvUlOfRdiZ170nNFa3dwc8rqjikPge8mtll6t3MpAV0BWID4E5XGHkSIHj+q
         bsFVCQHaUA/39pOHDUsfpAXhP0YA9+P1FwgWscC74znDCcHaIIIM9f0l7SA55P/qgnjT
         rBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=sh51h7ilTeI2NKnilGneYf7sta7xhm6IiGyYeMS/86M=;
        b=gg8cZFzBN58+BxGkRpUKWbTk3sY0zu0oQN65yLfNvG/sOahbI7mU+lHH4ct9LoK34k
         5TZGtMjLB3NrWhorbdbViTTcMOlPJDcFpdjnRK9040nNsmk9kVNWIBGbbie5zEKSxbkO
         pv6FkAQOM9cvOJzxisry0glRXiLrsPddB36LSfPYN1uyfyk0/Q8go4Dc3yhdYg6J2LU5
         +qvh+KLF0RGFpJ4++IPL/MOjf7H0+RGI4IEqsatIOh0VauIQzVwzVT4T90kA/j9ymcgc
         bjEoNOovGjjjax1vGKieYrpvX9edggKOSUNBuWykxIkgK6p8El2PpjDXN5FVKXSlkDTN
         j/0g==
Received: by 10.68.200.193 with SMTP id ju1mr21755394pbc.90.1337868334438;
        Thu, 24 May 2012 07:05:34 -0700 (PDT)
Received: by 10.68.200.193 with SMTP id ju1mr21755378pbc.90.1337868334288;
        Thu, 24 May 2012 07:05:34 -0700 (PDT)
Received: from localhost.localdomain (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id rv8sm5565332pbc.64.2012.05.24.07.05.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 May 2012 07:05:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1337868259-45626-1-git-send-email-davidbarr@google.com>
X-Gm-Message-State: ALoCoQmxYzdlperUCQ8KKksmoimyp/lNuqp441uJJPqNm2/3m1zBpgGHb156VwG8tVVDx2n293HE+Jdd56eVRkpuk1bWXYj9NCT2ZA+uIDfnbDivfesLFMzZcqFw1glMpJd7F+xBrV96gF8vL+sapu6wtLvqFUp0acaBR8aemkDoPAbbWJPEPTA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198380>

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
index 7396a91..0b2b7b9 100644
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
index b4104af..89f5dc2 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -123,7 +123,3 @@ off_t buffer_skip_bytes(struct line_buffer *buf, off_t nbytes)
 	}
 	return done;
 }
-
-void buffer_reset(struct line_buffer *buf)
-{
-}
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index bf9a053..bbe20ad 100644
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
index 73706ae..dd55cb7 100644
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
