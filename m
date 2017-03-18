Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34A622095D
	for <e@80x24.org>; Sat, 18 Mar 2017 02:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbdCRCFf (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 22:05:35 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34867 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbdCRCFc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 22:05:32 -0400
Received: by mail-pg0-f67.google.com with SMTP id g2so12082838pge.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 19:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=75ifD3I8XZrKANG8OXRFlZyZ0hPXIkavDTLAAgIOMg0=;
        b=RvOuvWBAJKq2oXjSEYOqQzXYRRVFCP49r3AyNpr9ykz1hln0byUAtrLvd4DEHtpTYP
         G1NO20w692Ri68iZOX9LvNsxh0Ts6NGouIWTyBGjFgYD3P8LWqhk1GOvIe702VfweNZ0
         O6Si1Uf+MND7DbPUdH72wxa9Kt29x87JcZXL3DqNNtTasDXWNCZq2IZJXfbSzRh8p2co
         y/ai+YKJT9Pv6KPAP+TY8jZXwaEWm90PCsizlPUhPduOXvUYY+g1eXXedNZBEEVbt4yG
         3lQPyxqWHzFlw4mxZAQZBy7H+pnBtT2S9LmjsPO6/mDJVkyCrzzaw9hKFxSAEsTCf2Yi
         KsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75ifD3I8XZrKANG8OXRFlZyZ0hPXIkavDTLAAgIOMg0=;
        b=P6ovY8BUqgbP/84kEmDdDFRgiYSwixcf+Re3UCLbGHbKq6rnU72rXmSbnrKEMPQ95d
         aKckZcpwqXLK3WdhsZfEqMIvVP4VGp9w0XxhaPROItQKlfYTBzsOOds1qkUcKwNuIMsq
         FXKWV3gP8u8vGEVp9feJt4NNZsFruMcgBd06FNjzxOgM0/j1PwGJNvTqG0TYV7DOuw5q
         Yc2J8PBUQ9Kdw86sdqCfisJOVFzA6VdFnyjPeqv6n2blqBc+OQNTs/gOxf/QZRXDTOYB
         d+PZVp1mJtEUPwqa2Zwc7O/n+F9Wg15le60cMQKcfaMUzdzDQNGwjDU2HpjAD10gLLlU
         ltRQ==
X-Gm-Message-State: AFeK/H04qGAbMsKMb8GAqrsPFDI98PPpfem1Xtk2YyzXEkcbdYTpiPsVNH9Y2Lwjl7iCZg==
X-Received: by 10.84.238.134 with SMTP id v6mr23750049plk.168.1489802685317;
        Fri, 17 Mar 2017 19:04:45 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id y5sm19098817pfd.33.2017.03.17.19.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 19:04:44 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 09:04:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v6 07/27] files-backend: move "logs/" out of TMP_RENAMED_LOG
Date:   Sat, 18 Mar 2017 09:03:17 +0700
Message-Id: <20170318020337.22767-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318020337.22767-1-pclouds@gmail.com>
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes reflog path building consistent, always in the form of

    strbuf_git_path(sb, "logs/%s", refname);

It reduces the mental workload a bit in the next patch when that
function call is converted.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 54e698dcea..6a84e56db8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2513,7 +2513,7 @@ static int files_delete_refs(struct ref_store *ref_store,
  * IOW, to avoid cross device rename errors, the temporary renamed log must
  * live into logs/refs.
  */
-#define TMP_RENAMED_LOG  "logs/refs/.tmp-renamed-log"
+#define TMP_RENAMED_LOG  "refs/.tmp-renamed-log"
 
 struct rename_cb {
 	const char *tmp_renamed_log;
@@ -2549,7 +2549,7 @@ static int rename_tmp_log(const char *newrefname)
 	int ret;
 
 	strbuf_git_path(&path, "logs/%s", newrefname);
-	strbuf_git_path(&tmp, TMP_RENAMED_LOG);
+	strbuf_git_path(&tmp, "logs/%s", TMP_RENAMED_LOG);
 	cb.tmp_renamed_log = tmp.buf;
 	ret = raceproof_create_file(path.buf, rename_tmp_log_callback, &cb);
 	if (ret) {
@@ -2611,7 +2611,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 
 	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
 	strbuf_git_path(&sb_newref, "logs/%s", newrefname);
-	strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
+	strbuf_git_path(&tmp_renamed_log, "logs/%s", TMP_RENAMED_LOG);
 
 	log = !lstat(sb_oldref.buf, &loginfo);
 	if (log && S_ISLNK(loginfo.st_mode)) {
@@ -2636,7 +2636,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 	}
 
 	if (log && rename(sb_oldref.buf, tmp_renamed_log.buf)) {
-		ret = error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
+		ret = error("unable to move logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
 			    oldrefname, strerror(errno));
 		goto out;
 	}
@@ -2722,7 +2722,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 			oldrefname, newrefname, strerror(errno));
 	if (!logmoved && log &&
 	    rename(tmp_renamed_log.buf, sb_oldref.buf))
-		error("unable to restore logfile %s from "TMP_RENAMED_LOG": %s",
+		error("unable to restore logfile %s from logs/"TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
 	ret = 1;
  out:
-- 
2.11.0.157.gd943d85

