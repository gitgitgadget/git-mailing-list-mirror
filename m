Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC5101F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 09:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732515AbeKNTEU (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 14:04:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38169 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeKNTET (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 14:04:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id e3-v6so16373130wrs.5
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 01:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5vpYjf3mWQqIG4rpk+sPSgEFt3ht4ld8/fxCdgSgQLY=;
        b=BJM+JLIzPnQ7/H7zNVQYTTHMCCWlz7/qpCj0ncvP7oTjQ/pWBxi/2GyoN23Kr4PRec
         XvVw3cRhc5L7fK6ThbLafQCmrDp6nuWH0dwBRZZ6JmGUDgIxlWcdEs8VtYN6C9U67GDY
         jInAbUqRwYmR+6qULKSfl2GOw03A6rXexB1pkPwRRwAPuw6uh/Jnqz6C5ZfSilg1lq2e
         f/RClS9LeDLSOOFNyeMIR21owPUMU5eoRY0839TuM+1YTQszgAiI1BKUamzIm6HLLag5
         b4u63W/N8qGpM35DDx/AapluDaZbevfnEiX1M6bH6zK21j+SV2nrdegjgyQxIOBCozWx
         J7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5vpYjf3mWQqIG4rpk+sPSgEFt3ht4ld8/fxCdgSgQLY=;
        b=V4etC0bRQX5IHHl1bVTXw/lpLphbLEpAeJUtuiOu1koIzOpFz9OjI2TGR/4zCOiBZd
         QUsYBHQXbj14vmEp226RNc/92/OgRe6eEKsJ/mq0JAmnervpGKg5Xs+1rSgkcHouMLOw
         DLSVX8l1hN4WDRGHdyBZJvo1hPdhFTCoVPYZ2OE6ScxEBhdLEgZPWvBlxG3H07vYdwop
         Nc1WSQEUa+drTLwnYEF+AN1UvL34POwAhx/zZsble9anACLFjWZHE+CRT+8ZJe2yJjpA
         IElN4XXNRKgOuMoSL4tuLdTfXdCLCuRXRcGa5zGh4nclRO6zEf0KcwuBFD+m+J9HJNuz
         lYXw==
X-Gm-Message-State: AGRZ1gK1d7ZdRCwhJf492Qj7aFWPAJPL64sikGZZGdxziOi4nlK7QThw
        zuRLYwBeG+arVxjXs6iBI5f43+060+o=
X-Google-Smtp-Source: AJdET5epTWfr4bXqrFSEhg+0O9Hv5sfWfjD7jQJpJPJhN0AeDf8NGE6zQlMQlBXro77woIuODehh5g==
X-Received: by 2002:adf:f5d1:: with SMTP id k17mr986728wrp.59.1542186117843;
        Wed, 14 Nov 2018 01:01:57 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e10-v6sm28782471wrp.56.2018.11.14.01.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 01:01:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitgitgadget@gmail.com, Pratik Karki <predatoramigo@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] tests: add a special setup where rebase.useBuiltin is off
Date:   Wed, 14 Nov 2018 09:01:44 +0000
Message-Id: <20181114090144.31412-3-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <CAGZ79kYX4vNMYgzitY1D8Bu7o=2oY6Aiq0d7KQdCTaC5eu=RYg@mail.gmail.com>
References: <CAGZ79kYX4vNMYgzitY1D8Bu7o=2oY6Aiq0d7KQdCTaC5eu=RYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a GIT_TEST_REBASE_USE_BUILTIN=false test mode which is equivalent
to running with rebase.useBuiltin=false. This is needed to spot that
we're not introducing any regressions in the legacy rebase version
while we're carrying both it and the new builtin version.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 5 ++++-
 t/README         | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0ee06aa363..68ad8c1149 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -48,7 +48,10 @@ static int use_builtin_rebase(void)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf out = STRBUF_INIT;
-	int ret;
+	int ret, env = git_env_bool("GIT_TEST_REBASE_USE_BUILTIN", -1);
+
+	if (env != -1)
+		return env;
 
 	argv_array_pushl(&cp.args,
 			 "config", "--bool", "rebase.usebuiltin", NULL);
diff --git a/t/README b/t/README
index 242497455f..c719e08414 100644
--- a/t/README
+++ b/t/README
@@ -348,6 +348,9 @@ GIT_TEST_MULTI_PACK_INDEX=<boolean>, when true, forces the multi-pack-
 index to be written after every 'git repack' command, and overrides the
 'core.multiPackIndex' setting to true.
 
+GIT_TEST_REBASE_USE_BUILTIN<boolean>, when false, disables the builtin
+version of git-rebase. See 'rebase.useBuiltin' in git-config(1).
+
 Naming Tests
 ------------
 
-- 
2.19.1.1182.g4ecb1133ce

