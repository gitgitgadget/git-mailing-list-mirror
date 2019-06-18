Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 998011F462
	for <e@80x24.org>; Tue, 18 Jun 2019 23:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfFRX3b (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 19:29:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34788 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRX3b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 19:29:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id m29so17704811qtu.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 16:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7VvYjbUk4xO+XEtU2tDr9QV4gBrLPLujUfwSSr9xw4=;
        b=tmJdhZwVWAsoKvr8DXerLLstJzZHsxWCmVt6AvMCtVVWsiYjo2HcCQO7ZKMowSQf4m
         aGtBx1afGcqLC7wxGE4SLL5TahRWL0Wh20n0JcJbO2w65Xe0CLiGLHz83jB/NN8sUMrI
         kj83tgUnzJkKcGwjobK6doactoUAfcnQh/vEOUxnlHHZXwkXX/o9YBpNZ9dddxuJP4CF
         +XiVdJXKHSrlRKUNShttXQAcjOmCxIzn31bJaM6k9mTeAEybZruqoqhkvl7V1FeQQD4d
         XUBQF4eKsU6gYXFoNtj2EzKfGrVoxlVHDJfedtb+euqMj93l5f8KZP0tcUIpph8uP7zJ
         N1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7VvYjbUk4xO+XEtU2tDr9QV4gBrLPLujUfwSSr9xw4=;
        b=tlrdRXJgtXyOpmJvR8FTu0JFe+sg2EhrqGLwkFoAKoSnSO9cYwNQWKn0cCJDKWF5tA
         VoABctVdOYvr0kVpQzPMcG9DtbGAYmJ6TqrhNopZ8fdkhoQ4n7w7HQj5fDjW2sJ0nZFI
         t4kzcrPmEXoTfuOrqHYXTBJkHpaRUGBQ0QPXY1GlftZ1/Y5TabbDLOPBDbBC9icTMK5C
         r0RG2i3m/rdWoqrohm9PhvF90gdFZwdQPA0ZiOkRE1flzBDtlsyHOdFbf7SdVgq+ajOU
         3FnVIOQPKO9FMw3vPUvtwOpqAYwcJkbExu1qlvcHO+1VZPu/RdP9dxnZOzeYpjT0/nLZ
         /aBQ==
X-Gm-Message-State: APjAAAW8uAgqa7+pT0uxGZJCM48nnTWQG7adugzDakvgdo+X74KuB7/R
        b8mXEgFrtAlOtKMb63Fpg0oOZdnB4a4=
X-Google-Smtp-Source: APXvYqw/ryL+OBrOIERDZ84UBAT0De5rlYBCX38hFfwjk/udEpOLfk9fsWEw09EYBBpxd0YaVQ/1gg==
X-Received: by 2002:ac8:c0e:: with SMTP id k14mr59681480qti.72.1560900570454;
        Tue, 18 Jun 2019 16:29:30 -0700 (PDT)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e18sm4828997qkm.49.2019.06.18.16.29.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 16:29:30 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH v7 07/10] clone: copy hidden paths at local clone
Date:   Tue, 18 Jun 2019 20:27:44 -0300
Message-Id: <5dc1cb8f840dcb01692d54183356b5c9c8ae169f.1560898723.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560898723.git.matheus.bernardino@usp.br>
References: <cover.1560898723.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the copy_or_link_directory function no longer skip hidden
directories. This function, used to copy .git/objects, currently skips
all hidden directories but not hidden files, which is an odd behaviour.
The reason for that could be unintentional: probably the intention was
to skip '.' and '..' only but it ended up accidentally skipping all
directories starting with '.'. Besides being more natural, the new
behaviour is more permissive to the user.

Also adjust tests to reflect this behaviour change.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Co-authored-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c            | 2 +-
 t/t5604-clone-reference.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 4a0a2455a7..9dd083e34d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -430,7 +430,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 			continue;
 		}
 		if (S_ISDIR(buf.st_mode)) {
-			if (de->d_name[0] != '.')
+			if (!is_dot_or_dotdot(de->d_name))
 				copy_or_link_directory(src, dest,
 						       src_repo, src_baselen);
 			continue;
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 0800c3853f..c3998f2f9e 100755
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
2.22.0

