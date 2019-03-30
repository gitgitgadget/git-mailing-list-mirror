Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B78A220248
	for <e@80x24.org>; Sat, 30 Mar 2019 22:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbfC3Wtb (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 18:49:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35655 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbfC3Wtb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 18:49:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id h39so6776594qte.2
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 15:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Uafob/Eu9R+Z8DOetI66hIuGTZQtXfWUgDBF3o4DcM=;
        b=ziqm0eJV15Mkzbh14TYwJUCZAqcQXnwZ8kxK9WBd7BP6+nuBv7IyG6hlvkehjJRe8w
         v/xJ4D3De6BOGo3++HeaUcJwlDydeRjEC5Jo6wUK/mN0b295mZ7GnJlhmqUWw0BOjaHu
         L2Alj+HwG5E/TGG6wwvWkoDhe9ygmhBGUo6/ysH8M494ieIa4AD0ZajZV9jOG5ykyGg4
         /ZYZZIvaCIoajc3hYvQ7l3P+T0SxRI4gRU2pAMTmAl2o6hhk7rBICHakR2YPmM156YD4
         zZKcxMmtSRBmSqkhl3aQ1B2MnGH5XNvBVY/ddwCDFD2yjBJ0J7AJ9aU1as+pO34odCZN
         AHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Uafob/Eu9R+Z8DOetI66hIuGTZQtXfWUgDBF3o4DcM=;
        b=kMWluy3v+wcm5dJHOFyUpsaVY/YKiKbPxLEjYZVrTU4TVGxBsQJjJmTbJCg5xyQnyv
         MY3bncWKo8y9vYQ6Ffv6NPeCMHdM6YI6o9cNvR2GLUBX6xjukomeQIBOjAu/VWhdy4xu
         CBCZLS4iNoTl5i1QyWTRIZcTELjTTAQM9nMKhRf4bboEMJ0tDrS7GBMKjpeE3HcG/T+g
         iTU1Qmhulu7AZLnuW+8uxs55V6YqBv3QBsofSsn3MDQnLTE87y6Ozcq5AJ/nd1BuckEm
         83JbBRQJ2Ctz5BF3P9izp3L32+ewmh0mG+Ffpuba2ZMH0Z6yGAbEuxcF8hIpOaYbe3hY
         DzwA==
X-Gm-Message-State: APjAAAUlynEVt7ncrvvYh3DnRJwqnBTVEWWxm1+OJBdj1D9Qn6q/KuLS
        DXk2BOqCzL80jcWhTBxLdylKsw==
X-Google-Smtp-Source: APXvYqyF7X8jsyAT+9ZFuwI2G+h2BgRPmiGz75ep0+zYn0UQ5xQu8MPHM/+WZmLQpYyvuGeOHoeH5w==
X-Received: by 2002:ac8:2949:: with SMTP id z9mr47051466qtz.302.1553986170383;
        Sat, 30 Mar 2019 15:49:30 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::4])
        by smtp.gmail.com with ESMTPSA id x191sm3139943qka.78.2019.03.30.15.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 15:49:29 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        kernel-usp@googlegroups.com
Subject: [GSoC][PATCH v5 4/7] clone: copy hidden paths at local clone
Date:   Sat, 30 Mar 2019 19:49:04 -0300
Message-Id: <20190330224907.3277-5-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190330224907.3277-1-matheus.bernardino@usp.br>
References: <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190330224907.3277-1-matheus.bernardino@usp.br>
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
index f975b509f1..81e1a39c61 100644
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
2.20.1

