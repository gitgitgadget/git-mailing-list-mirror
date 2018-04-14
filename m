Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E174A1F404
	for <e@80x24.org>; Sat, 14 Apr 2018 19:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751614AbeDNTUW (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 15:20:22 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43055 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbeDNTUT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 15:20:19 -0400
Received: by mail-wr0-f194.google.com with SMTP id y7so15831010wrh.10
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 12:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ShuPcDMdomn3bd9lBc0jq2oOwrDIi7SVI3POWSUzPlY=;
        b=GKsTuq5AMOBY/ibqfyx4OJ01kUfjWkkD0+EeJ1dFI2L8QEtLdJwdj2S6g5KYCnfIY+
         YFScP08Hn4B61lGEGfMyL8alN1jo85/C6Y5xYoHJhil4F+Gwbb5UIRuQ8TG4wbkdPyqI
         TpbXR2LEXxndE/fhrJNnvHkt8a4bviiZE49+7FeJaY6gWl9mSiBlmuT1AvX1oijK5DqZ
         hXxL6Gw8VELI47ZwS5CuRbw4okTfM5RggqbT9NB5yqtA9bdy+mnfPbzlX7bDs9jJGZ/R
         z00xI8qH8yyiGsPW4JhvluatPHfFSEyCTePziZvkCKdj3/coawm9ly3QjNP8yRf3BiWE
         Y/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ShuPcDMdomn3bd9lBc0jq2oOwrDIi7SVI3POWSUzPlY=;
        b=kL/ZIpCbDw5vCqQ8OmTHsaCrbRsMHOlE0c5BreP1KHs+01WRxxOjvwWpnXuwCKHLc7
         LsZPtJnYcRLN6/AvvqoCMfBRQo410FD2ysdQVQSNyYI3xD1pNfxAqdAJiEmY3FDG8ENe
         ahZ1XZbsKujYOxAHLyDoiZvzvmgpFhTjLMpFnEGJ6Bj8CJq4LBDGsWNCCEbU+ZZOJG9G
         l2uiFL2y242uC79JaCCvGrpP8lw0OmGUlLqUUCeXMmqIwYeEID7sEpSE4HZ4XyCDBktp
         xkI5vMrdlgr+HrJr1dT9Zega4R021G1h32tY7h7sYLAa25PsXNZ9go3LRvPPWL44dmmc
         dUfg==
X-Gm-Message-State: ALQs6tAecfg0Wfwg6XD6cBJQJKdTmz9jXVOHcLzDz6CxKNz+PeoM+iES
        tT12jCG36T3FoT0+Ny501a8JZeEs
X-Google-Smtp-Source: AIpwx49AjzTFOse2DOEEnVBuPTlKdY1Xdp8N9kefaG1wlrbdCH5kPi4meO7F76lU9GjBfm3kmU7r0A==
X-Received: by 10.28.139.5 with SMTP id n5mr6574934wmd.85.1523733617869;
        Sat, 14 Apr 2018 12:20:17 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 31sm8610644wrm.68.2018.04.14.12.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 12:20:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>, larsxschneider@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/4] Makefile: add a DEVOPTS to get all of -Wextra
Date:   Sat, 14 Apr 2018 19:19:46 +0000
Message-Id: <20180414191946.30674-5-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180414191946.30674-1-avarab@gmail.com>
References: <20180414191946.30674-1-avarab@gmail.com>
In-Reply-To: <20180329150322.10722-1-pclouds@gmail.com>
References: <20180329150322.10722-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change DEVOPTS to understand a "extra-all" option. When the DEVELOPER
flag is enabled we turn on -Wextra, but manually switch some of the
warnings it turns on off.

This is because we have many existing occurrences of them in the code
base. This mode will stop the suppression, let the developer see and
decide whether to  fix them.

This change is a slight alteration of Nguyễn Thái Ngọc Duy
EAGER_DEVELOPER mode patch[1]

1. "[PATCH v3 3/3] Makefile: add EAGER_DEVELOPER
    mode" (<20180329150322.10722-4-pclouds@gmail.com>;
    https://public-inbox.org/git/20180329150322.10722-4-pclouds@gmail.com/)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile       | 6 ++++++
 config.mak.dev | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index 9a57495fae..47ddc85aae 100644
--- a/Makefile
+++ b/Makefile
@@ -455,6 +455,12 @@ all::
 #        suppresses the -Werror that implicitly comes with
 #        DEVELOPER=1. Useful for getting the full set of errors
 #        without immediately dying, or for logging them.
+#
+#    extra-all:
+#
+#        The DEVELOPER mode enables -Wextra with a few exceptions. By
+#        setting this flag the exceptions are removed, and all of
+#        -Wextra is used.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
diff --git a/config.mak.dev b/config.mak.dev
index 7a54426d78..2d244ca470 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -23,6 +23,7 @@ CFLAGS += -Wextra
 # if a function is public, there should be a prototype and the right
 # header file should be included. If not, it should be static.
 CFLAGS += -Wmissing-prototypes
+ifeq ($(filter extra-all,$(DEVOPTS)),)
 # These are disabled because we have these all over the place.
 CFLAGS += -Wno-empty-body
 CFLAGS += -Wno-missing-field-initializers
@@ -30,6 +31,7 @@ CFLAGS += -Wno-sign-compare
 CFLAGS += -Wno-unused-function
 CFLAGS += -Wno-unused-parameter
 endif
+endif
 
 # uninitialized warnings on gcc 4.9.2 in xdiff/xdiffi.c and config.c
 # not worth fixing since newer compilers correctly stop complaining
-- 
2.17.0.290.gded63e768a

