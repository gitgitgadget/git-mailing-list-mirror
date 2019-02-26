Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E739B20248
	for <e@80x24.org>; Tue, 26 Feb 2019 12:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfBZM26 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 07:28:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34996 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBZM26 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 07:28:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id t18so13750894wrx.2
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 04:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VbDm5+bHEtPhXjcORKbhEYNKIz/czC/GSHmLUzoWrB8=;
        b=gNoRkv3q1qeZA7/w0tPUaGSVx7evB491yzs3EaH+hDrLA0fLMmIakQmEDn4clBDuSE
         wACa04k6j+/ybDrFKPe5jLDX6nXavyoJW44YY5BaEg9HbkDzUrwtE3kGhCWYt+gzfjTl
         p/D6b8skJ0s2wD7M2XfCDXJmCuz023RIlyH8F+3geVZ0ndF7QXZU/lVOhtZFEnhxkgwD
         mz0fmKtDlU7KCJV7mHiKaY2hKwj7BWBGTtgbI7saq+2gDN3veIxBVKnA3DuzqGadi7If
         XJ/0TDoKTGNR9v2Ao9/BcOpOgRibzw2JAEjQgEDuiSKWsEIxoLABA/uQPMSXgcAt7KC2
         EunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VbDm5+bHEtPhXjcORKbhEYNKIz/czC/GSHmLUzoWrB8=;
        b=HeahpSJepXqRMdLrpO1DlqR583rDM4FLExmxy4whnjQp7ATBSMhAR9hURCb7gcqR7R
         Eb65FvWatJ/TfYrJ8wp/QMmpEcA3e22hcSL4y9ODlyBltM5JdOC8SkrHH/KIX1neXvg3
         wZhNXJRWHjzcndCI8lrvq5eOMLbG4sJ8hvvF/gOKA2yQaRN3wVLIyS4aR5AHtMgfqNSi
         wZEiLz/zvKMODFHyZN30lIuvzMgfSE9N6xj7uDlhFiunatCib+8y3LNI6CHMIHjJv9PV
         83aUGhTVnfLg0fJnxyzpc2ScD+JvP1zEN1DhWNbE8xOdM9TDYNBAqQlH24ioUnQZ8Zzt
         fOtQ==
X-Gm-Message-State: AHQUAubgJ8wK61DEZgI9ZZfHgtZhSW9U9KCSKAnXX+K+FbL3EM42xIjz
        C/S2YWJNvLd4If9S4juLTsIg/oD0zeU=
X-Google-Smtp-Source: AHgI3IZRdrURyXhj0AIiOsZM1rS0q3oFfIjcbm06jNczORl0ofxwUzcNYGHAi61+yRSCCi2HA+GHXw==
X-Received: by 2002:adf:e58f:: with SMTP id l15mr15168550wrm.309.1551184135498;
        Tue, 26 Feb 2019 04:28:55 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6sm2733165wme.24.2019.02.26.04.28.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Feb 2019 04:28:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Matheus Tavares <matheus.bernardino@usp.br>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v3 3/5] clone: copy hidden paths at local clone
Date:   Tue, 26 Feb 2019 13:28:27 +0100
Message-Id: <20190226122829.19178-4-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b
In-Reply-To: <20190226051804.10631-1-matheus.bernardino@usp.br>
References: <20190226051804.10631-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matheus Tavares <matheus.bernardino@usp.br>

Make the copy_or_link_directory function no longer skip hidden paths.
This function, used to copy .git/objects, currently skips all hidden
directories but not hidden files, which is an odd behaviour. The reason
for that could be unintentional: probably the intention was to skip '.'
and '..' only but it ended up accidentally skipping all directories
starting with '.'. Besides being more natural, the new behaviour is more
permissive to the user.

Also adjusted tests to reflect this change.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c            | 2 +-
 t/t5604-clone-reference.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..cae069f03b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -428,7 +428,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 			continue;
 		}
 		if (S_ISDIR(buf.st_mode)) {
-			if (de->d_name[0] != '.')
+			if (!is_dot_or_dotdot(de->d_name))
 				copy_or_link_directory(src, dest,
 						       src_repo, src_baselen);
 			continue;
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index cb0dc22d14..d650f67ca5 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -247,16 +247,25 @@ test_expect_success 'clone a repo with garbage in objects/*' '
 	done &&
 	find S-* -name "*some*" | sort >actual &&
 	cat >expected <<-EOF &&
+	S--dissociate/.git/objects/.some-hidden-dir
+	S--dissociate/.git/objects/.some-hidden-dir/.some-dot-file
+	S--dissociate/.git/objects/.some-hidden-dir/some-file
 	S--dissociate/.git/objects/.some-hidden-file
 	S--dissociate/.git/objects/some-dir
 	S--dissociate/.git/objects/some-dir/.some-dot-file
 	S--dissociate/.git/objects/some-dir/some-file
 	S--dissociate/.git/objects/some-file
+	S--local/.git/objects/.some-hidden-dir
+	S--local/.git/objects/.some-hidden-dir/.some-dot-file
+	S--local/.git/objects/.some-hidden-dir/some-file
 	S--local/.git/objects/.some-hidden-file
 	S--local/.git/objects/some-dir
 	S--local/.git/objects/some-dir/.some-dot-file
 	S--local/.git/objects/some-dir/some-file
 	S--local/.git/objects/some-file
+	S--no-hardlinks/.git/objects/.some-hidden-dir
+	S--no-hardlinks/.git/objects/.some-hidden-dir/.some-dot-file
+	S--no-hardlinks/.git/objects/.some-hidden-dir/some-file
 	S--no-hardlinks/.git/objects/.some-hidden-file
 	S--no-hardlinks/.git/objects/some-dir
 	S--no-hardlinks/.git/objects/some-dir/.some-dot-file
-- 
2.21.0.rc2.261.ga7da99ff1b

