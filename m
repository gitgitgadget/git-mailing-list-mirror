Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA00C1F462
	for <e@80x24.org>; Fri, 24 May 2019 09:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390137AbfEXJZG (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 05:25:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41818 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390120AbfEXJZG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 05:25:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id f12so3929244plt.8
        for <git@vger.kernel.org>; Fri, 24 May 2019 02:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C7hX91qz3vqJ6SvsPoUxKHsJMUdb/xZv58Ut8nEe1vU=;
        b=vPWp2GFwtdeerOSRZSZ6M8685vxPdHRj5FCPHfjmhQQNo9Xu9wOP/IwAHdJawIjZ1m
         YWy0Tksj1n/MFvG6MlHja7/mWBLAq8XMPnU2kyNuWiaXSPtjSznNOsKrQ/VxOGkw68H+
         cgr4A6hBU+3Fkp35c403Mfurrkghv0uBljl+nUiOgotGjZS4y3X8EkisA90c/6vHH9fU
         CvKgj1Th+sJAgdkorBEQ5boNy/xEL+KmSTJfr/T0SnUkaSNNIm9CgOZvO+S3Ot/GAPw+
         hEzFJ7c87AFH9/ZnxaY9TNTMHluR1ZnP5Zjm+Ae0iLh/57cpFyZd9zWqM+bgP+nntN7I
         Q6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C7hX91qz3vqJ6SvsPoUxKHsJMUdb/xZv58Ut8nEe1vU=;
        b=B70IlxxkJQDMm5xRvOwOK+cAHSbyEMNWqlFUJYUgpkx6N0snu1lo/6y4KEKp3uP4In
         Yd8UYtPyeNLEnVWVjP/d/LYID2/4k2M7UxcQwj32PkYaimUUuKaVJUK+jc1lOX0KJg1P
         JX1oy4H7CuWzBqxvYnGrTDCyynSoft4+AKMVVhOWc+W1RYJNB6YuOVNBPf7sc+x5mFiA
         8iupN8t5/yjBkzlU85px+NQxYshuJP3Z4yfrjsDWLYIzyEdo3UZLNJAJyC2xosjAL+jY
         Ea64sr9jtrhpILOajgpA9EmJGnEtBkFmBREYO2vHwlqzYVXo3fA9EoKysYhiqCEIFHnJ
         4pFA==
X-Gm-Message-State: APjAAAUYSMVKYVMwbtWz7Nrv3keGinatuDCvDPDzWJFIkbp/yluu//ln
        PpZ7gFlAzpA8hKhuA4ZOm0YHexlu
X-Google-Smtp-Source: APXvYqzTabwpvc/IP1fZjpq2zUI0kSjKrrysWRXJMumt3gm6gXZlAv9qJjNPwq3xsihXcCiK2vNvhw==
X-Received: by 2002:a17:902:b606:: with SMTP id b6mr106560990pls.100.1558689905557;
        Fri, 24 May 2019 02:25:05 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id h62sm1819671pgc.77.2019.05.24.02.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 02:25:04 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 24 May 2019 16:25:00 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, bturner@atlassian.com, tmz@pobox.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/3] parse-options: check empty value in OPT_INTEGER and OPT_ABBREV
Date:   Fri, 24 May 2019 16:24:42 +0700
Message-Id: <20190524092442.701-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190524092442.701-1-pclouds@gmail.com>
References: <20190524092442.701-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing the argument for OPT_INTEGER and OPT_ABBREV, we check if we
can parse the entire argument to a number with "if (*s)". There is one
missing check: if "arg" is empty to begin with, we fail to notice.

This could happen with long option by writing like

  git diff --inter-hunk-context= blah blah

Before 16ed6c97cc (diff-parseopt: convert --inter-hunk-context,
2019-03-24), --inter-hunk-context is handled by a custom parser
opt_arg() and does detect this correctly.

This restores the bahvior for --inter-hunk-context and make sure all
other integer options are handled the same (sane) way. For OPT_ABBREV
this is new behavior. But it makes it consistent with the rest.

PS. OPT_MAGNITUDE has similar code but git_parse_ulong() does detect
empty "arg". So it's good to go.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options-cb.c | 3 +++
 parse-options.c    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index 4b95d04a37..a3de795c58 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -16,6 +16,9 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
 	if (!arg) {
 		v = unset ? 0 : DEFAULT_ABBREV;
 	} else {
+		if (!*arg)
+			return error(_("option `%s' expects a numerical value"),
+				     opt->long_name);
 		v = strtol(arg, (char **)&arg, 10);
 		if (*arg)
 			return error(_("option `%s' expects a numerical value"),
diff --git a/parse-options.c b/parse-options.c
index 987e27cb91..87b26a1d92 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -195,6 +195,9 @@ static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
 		}
 		if (get_arg(p, opt, flags, &arg))
 			return -1;
+		if (!*arg)
+			return error(_("%s expects a numerical value"),
+				     optname(opt, flags));
 		*(int *)opt->value = strtol(arg, (char **)&s, 10);
 		if (*s)
 			return error(_("%s expects a numerical value"),
-- 
2.22.0.rc0.322.g2b0371e29a

