From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH] strbuf: describe the return value of strbuf_read_file()
Date: Tue, 14 Jun 2016 01:53:46 +0530
Message-ID: <20160613202346.6473-1-pranit.bauva@gmail.com>
Cc: larsxschneider@gmail.com, chriscool@tuxfamily.org,
	christian.couder@gmail.com, Pranit Bauva <pranit.bauva@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 22:24:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCYPP-0006lO-MM
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 22:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422832AbcFMUY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 16:24:27 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36551 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161183AbcFMUY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 16:24:26 -0400
Received: by mail-pf0-f193.google.com with SMTP id 62so11259022pfd.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 13:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=OlRs/0zZjh9pmtNZOL6qaoVzrDtBDDxIoD1GvapempY=;
        b=B1n49AXsZTxu7iMnfTnEY7vIrQtzoHTsW+/cQ9AZ2fojwEzTBcOvlTEL6jPNY9SMD0
         Hh0Qa8TFrQovdBmLFPtjNh4isC7xnkzy6OWTnulua4hbgC3pq3/wtAj1Ob4NwdOddlaE
         05+gXXKUWRNeLYXW90ZhpeiIzNo9VB1l3oHyU+PsRLs+xTM1l0u9+insRkw+nF0lwNuU
         FU2yFFI/q7ypRM5bqC5tdCdkP4rrmVcuHZDcdmgJpyRNCzPUXcwSMLCxKzR2EfncNiJG
         dQMhEE+oCiE52W9KieqVas8Sus9/DTqP9riA/EgezYRDyeeBRwbyWAAG7paO4y6AUmHM
         qsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OlRs/0zZjh9pmtNZOL6qaoVzrDtBDDxIoD1GvapempY=;
        b=TjdajZon9ju9AML5jcSyyTxqHSnKRHiI7aqPQqesyIaWfJ140awzk/D4NhiiwO/EPM
         +wbVuoklSdRVqggCwpx7ChRDKIXVo1MLmCgSHJzFc/7oa+pF0fe+lbaYQ8EinjVG0QV2
         +N/DFvVLp08J7nON8H2wYxPlrCYuPIlXy/GVSfz5jGnEL6p1UdYwhsqqaQjNe3LfM5NW
         WPFCf7mpJZDiDqQqNPKVY6u5MV2nOjX19ENqAGeh8uc1wYDHuc8hWEYA4+I5k3JW+YgY
         jbxIZMDMHyWXczlzsI14XB4HTLPNk1WYqRM3D/JtzKr0fJFd6EV1NxX2I+ExtG26sf0F
         HnZQ==
X-Gm-Message-State: ALyK8tJHkKh8F312H++bcQGMoO035ln7/pExO55BnC/nzejBG8Q8Dy15bv17XbwEdj99ng==
X-Received: by 10.98.87.138 with SMTP id i10mr9463143pfj.1.1465849466056;
        Mon, 13 Jun 2016 13:24:26 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id b71sm7428766pfc.51.2016.06.13.13.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 13:24:25 -0700 (PDT)
X-Mailer: git-send-email 2.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297243>

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
It is easy to be misguided on the return value of the function
strbuf_read_file(). It does follow the pattern of other standard functions
for reading files but its better to explicitly specify it.

 strbuf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/strbuf.h b/strbuf.h
index 7987405..4b487f7 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -377,6 +377,8 @@ extern ssize_t strbuf_read_once(struct strbuf *, int fd, size_t hint);
 /**
  * Read the contents of a file, specified by its path. The third argument
  * can be used to give a hint about the file size, to avoid reallocs.
+ * Return the number of bytes read or -1 if some error occurred while
+ * opening or reading the file.
  */
 extern ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
 
-- 
2.8.4
