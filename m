Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 725BB1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162565AbeBNTCf (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:02:35 -0500
Received: from mail-qt0-f201.google.com ([209.85.216.201]:37811 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162579AbeBNTCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:02:09 -0500
Received: by mail-qt0-f201.google.com with SMTP id f34so5944241qtb.4
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=dsUmgdXueHTGks43sem5ffdUCieZph0kCnrA4lzeEp4=;
        b=CCYcxlnAb+e4MVWsY0PGa1vR4banW3f1u1AJ8KvDEMbn2QZufHWqoKRr1jvDW4/N2k
         s94nqJ3/uA3k8gC27df6o/M/L0Sht2Iz1a+XnnHGqiv+4010c0R9p/JCi0KTCPWieA+4
         M0iLLPg6k5Dmlnl3JnHerkn+sriG0MKa9d6vVUKwJ/DOozGKLfnIl2k+6mFD5/E/q3Bf
         xCA900273TeXe75PrD02r22JL06rr3s4u+OcSrmPXgGK72GrDxQDwwq9B3LZ9XTFm2ND
         Bc6yhJf/zjdg4tpefrCMwXYspTQkrJnJn7Cl0s9RlyxPMVCC6wTG1eNy21Kn8BxFHYAT
         pCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=dsUmgdXueHTGks43sem5ffdUCieZph0kCnrA4lzeEp4=;
        b=K7pMDSv9/p6W0EIHrNcJ3EoRUHZHzHOxVtPM6aZZY+5uLxv0vxl2GxFsO3jIqIQz+i
         g9l6Ad26a9MNiIITs8hT/kInHpsdPRgRv58NqqZQ68fMoq3Xj95/MDHTzuPh7d7JbDqL
         wsgOsp5qrwPaXK698UMu7EF5wpQU14apZ0qJN1JUQsVvyEKBhMT6OSHYebW2BtI3xfaT
         z1c7V7KUxAcv4arLSQr3HGAxYHJ/drTI523q5pHfHx819iOWZeNaoflDNNYu2703iu92
         YvNuaEkyjIDgp3Fmk80d4kawS+z0+DhR7eAeFvfxgsj1CCIVE6u+pUi36OjeGp7ajAPs
         Jn+A==
X-Gm-Message-State: APf1xPCA9nRYjxWkvomwmjcOnxulI8NtPUmV9q7OXD/VM+mnvaqKEUD2
        3OjeQo+QwWeymO/OjDA7xhXW0cY27I4lSY3upKpABy+ukeYiyHa2KB82fkMqn7bRUZLx3nBwpIq
        lSY6Z//FkqHXmUHGLp/IwgjVKqogCp2an+A7ADXTxpmGxHhFVXzAagSOc/w==
X-Google-Smtp-Source: AH8x22675V5k/EHPeWizxlYqj+s6HkrniY+ceFYzFMkrefPM9WjuFlxYrdVH94lSDyI0Jh955bCBa7CtrUk=
MIME-Version: 1.0
X-Received: by 10.55.225.10 with SMTP id c10mr60211qkm.12.1518634928357; Wed,
 14 Feb 2018 11:02:08 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:54 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-33-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 32/37] diff: rename 'template' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 diff.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 2de9c5ed2..5e46502cd 100644
--- a/diff.c
+++ b/diff.c
@@ -3660,15 +3660,15 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 			   int mode)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct strbuf template = STRBUF_INIT;
+	struct strbuf tempfile = STRBUF_INIT;
 	char *path_dup = xstrdup(path);
 	const char *base = basename(path_dup);
 
 	/* Generate "XXXXXX_basename.ext" */
-	strbuf_addstr(&template, "XXXXXX_");
-	strbuf_addstr(&template, base);
+	strbuf_addstr(&tempfile, "XXXXXX_");
+	strbuf_addstr(&tempfile, base);
 
-	temp->tempfile = mks_tempfile_ts(template.buf, strlen(base) + 1);
+	temp->tempfile = mks_tempfile_ts(tempfile.buf, strlen(base) + 1);
 	if (!temp->tempfile)
 		die_errno("unable to create temp-file");
 	if (convert_to_working_tree(path,
@@ -3683,7 +3683,7 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 	oid_to_hex_r(temp->hex, oid);
 	xsnprintf(temp->mode, sizeof(temp->mode), "%06o", mode);
 	strbuf_release(&buf);
-	strbuf_release(&template);
+	strbuf_release(&tempfile);
 	free(path_dup);
 }
 
-- 
2.16.1.291.g4437f3f132-goog

