Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9130A2018B
	for <e@80x24.org>; Mon, 27 Jun 2016 18:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbcF0SZw (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35178 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbcF0SZo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id a66so26933861wme.2
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e+hejxlibFPecMU+zdx+FG4PJl3Kp6F7oiW8Hk60ULU=;
        b=BnoLuJBPbWNxWxrWvsArTkkHJ+MY1h5tVR8vabqrO4JNPpi7rW9jAAR+n2NM4GdGyj
         Yc2KfuZ5507at5QxiErifTHSw9Idd1CQVHBxRcAbLabqA3keZ/Ml19YPuadIk+rD2aZ2
         IF8Dpfo7EsUN6Z4FTKo8nwuM27Hxv4FiLqg8XeDNgagAj04MxL3vCAyKq7J+U3Hw+L3J
         CJ+sipJ3rvnJhtEfPWeB8X1S7PStfefEWmlIxTE9n1+3OFiSSZQn4kO6qLbuLZpcgmzq
         6CHu7hfChwCrl94dQVDtycOSAqVaUbHjDqQwh8YxDzmCnTR5zFI3HBi7r7r1Lhkhn3r5
         QxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e+hejxlibFPecMU+zdx+FG4PJl3Kp6F7oiW8Hk60ULU=;
        b=EA1UfxomvndyyKvqMGqKAoLlSexcvqYgmdWM8uyBsX+XtLXoUDNmwWDaH0AFlvec/W
         paTu4GjJaRcZaE7NoaWIONsgnyz1E5mQ6Mu2iHtrWLZorY+Zm3cNDCnJHY6dNXVFwmai
         DZdFcpGY3vK9dtbxg4EIurU3TfQGLGraZh0iDMXnsaFkAYhqq/BbI21fI8yEKDLwyaxJ
         e+ewJWQoaQMahk6Q920pdcCenilUZWy+/p7qwj34cHpaZmpmi4n+TOrU8MYjOfJBBpfU
         09hbLjHmBsUoDl6XFaDivdpwVxAigs8B+v9TTBstII25S3ddb8yPaZ6KUbe5OkiUZmnz
         yzNg==
X-Gm-Message-State: ALyK8tJOJ0c5PqmAh7tBpD7F4rp7cSlej1KRYOEeOY4XBqP7dbHGLJOChLqJ6S2ZzLDEcA==
X-Received: by 10.28.188.137 with SMTP id m131mr11662584wmf.4.1467051943135;
        Mon, 27 Jun 2016 11:25:43 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:42 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 32/41] environment: add set_index_file()
Date:	Mon, 27 Jun 2016 20:24:20 +0200
Message-Id: <20160627182429.31550-33-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Introduce set_index_file() to be able to temporarily change the index file.

It should be used like this:

    /* Save current index file */
    old_index_file = get_index_file();
    set_index_file((char *)tmp_index_file);

    /* Do stuff that will use tmp_index_file as the index file */
    ...

    /* When finished reset the index file */
    set_index_file(old_index_file);

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h       |  1 +
 environment.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/cache.h b/cache.h
index c73becb..8854365 100644
--- a/cache.h
+++ b/cache.h
@@ -461,6 +461,7 @@ extern int is_inside_work_tree(void);
 extern const char *get_git_dir(void);
 extern const char *get_git_common_dir(void);
 extern char *get_object_directory(void);
+extern void set_index_file(char *index_file);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
diff --git a/environment.c b/environment.c
index ca72464..7a53799 100644
--- a/environment.c
+++ b/environment.c
@@ -292,6 +292,16 @@ int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1)
 	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
 }
 
+/*
+ * Temporarily change the index file.
+ * Please save the current index file using get_index_file() before changing
+ * the index file. And when finished, reset it to the saved value.
+ */
+void set_index_file(char *index_file)
+{
+	git_index_file = index_file;
+}
+
 char *get_index_file(void)
 {
 	if (!git_index_file)
-- 
2.9.0.172.gfb57a78

