Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FB021F453
	for <e@80x24.org>; Sun, 28 Oct 2018 22:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeJ2Hgg (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 03:36:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39695 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeJ2Hgg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 03:36:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id r10-v6so6677669wrv.6
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 15:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GYh9HEYyZ+VVC6q3QQfV81QCN38ViA4hcfoQ/DwMSuQ=;
        b=mDWZvJRdsLmYxiuMRV1V9KS0tKBHMN/ttguTOonJezMpf6i7VvMRpTdRN+tFcm1G+p
         1e+BCbaamYfGAOvAbO0nj4JjFE74fMb2ZfUtN3z34jWhx1pyNT8giucH67akWaSHp7rz
         BY86uXoLN0jqgk6C0RX+Cbi/fIpdBQJSG60IOHWEAz4+rUWtEShkLpcHy+hH6F+t3/3m
         +rNav+m8iOy2hiNQbJZJ3QhdAbzjvaw5WW271oNfJMljw+23iHcb6vxgopU/8ZMuPLZI
         qVpw4TFdz+venEOY2xGm39WbVHW1xsaImvLNekmuyWT5f1lPV+0c0MoHJW5iDeiIAXNc
         G1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GYh9HEYyZ+VVC6q3QQfV81QCN38ViA4hcfoQ/DwMSuQ=;
        b=cTBdaaPE2KyyY+/+F3QCCHpKIOj29tX6gXNBf8N3sexbCFaju/k0lhk5b8pGmsSaxe
         mFyVEqRbqiC3UNhwcTZFOP48xuwuiitnShOVsk55sCq2XH7NGKjQAIw3A5+O2evkTeD7
         uS44JE+RhCta9t8WCqe0shB5OrxaPUPDvwNZlUiibYYQu0KOtjbwArwyAotUyV/2UMqP
         rD0p+IDLz8oabYNpeQkzSymKFACCi6bg0jBhIbJs8eQLDIkJtZVokY9TGqwgaacU/hiH
         JL6is4gbW4FGMtUywGeM2rQBJEsFQPPqrSKtwEdl34OSuERz91BC1QwoLiTT9U6zTkgs
         ck/g==
X-Gm-Message-State: AGRZ1gKNX6qR6XUwTnOu79n2Z4WrabV3d2vmjE44ciFVEXyqhr/YbDKQ
        FQlJbu5qTUNL+qivTFUURqFO9sBrVno=
X-Google-Smtp-Source: AJdET5czWSvx4G1d+4iJIPiD9szmf2V1iFT3tbpfHdbQj7ZSph7LBJUW5fXUsXIbrhrxCmEBs7YHAw==
X-Received: by 2002:adf:bf10:: with SMTP id p16-v6mr12004883wrh.235.1540767031366;
        Sun, 28 Oct 2018 15:50:31 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p3-v6sm2709681wre.47.2018.10.28.15.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 15:50:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Geert Jansen <gerardu@amazon.com>,
        Christian Couder <christian.couder@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Baudis <pasky@ucw.cz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] pack-objects test: modernize style
Date:   Sun, 28 Oct 2018 22:50:20 +0000
Message-Id: <20181028225023.26427-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
In-Reply-To: <87lg6jljmf.fsf@evledraar.gmail.com>
References: <87lg6jljmf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modernize the quoting and indentation style of two tests added in
8685da4256 ("don't ever allow SHA1 collisions to exist by fetching a
pack", 2007-03-20), and of a subsequent one added in
4614043c8f ("index-pack: use streaming interface for collision test on
large blobs", 2012-05-24) which had copied the style of the first two.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5300-pack-object.sh | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 6c620cd540..a0309e4bab 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -475,22 +475,22 @@ test_expect_success 'pack-objects in too-many-packs mode' '
 # two tests at the end of this file.
 #
 
-test_expect_success \
-    'fake a SHA1 hash collision' \
-    'long_a=$(git hash-object a | sed -e "s!^..!&/!") &&
-     long_b=$(git hash-object b | sed -e "s!^..!&/!") &&
-     test -f	.git/objects/$long_b &&
-     cp -f	.git/objects/$long_a \
-		.git/objects/$long_b'
+test_expect_success 'fake a SHA1 hash collision' '
+	long_a=$(git hash-object a | sed -e "s!^..!&/!") &&
+	long_b=$(git hash-object b | sed -e "s!^..!&/!") &&
+	test -f	.git/objects/$long_b &&
+	cp -f	.git/objects/$long_a \
+		.git/objects/$long_b
+'
 
-test_expect_success \
-    'make sure index-pack detects the SHA1 collision' \
-    'test_must_fail git index-pack -o bad.idx test-3.pack 2>msg &&
-     test_i18ngrep "SHA1 COLLISION FOUND" msg'
+test_expect_success 'make sure index-pack detects the SHA1 collision' '
+	test_must_fail git index-pack -o bad.idx test-3.pack 2>msg &&
+	test_i18ngrep "SHA1 COLLISION FOUND" msg
+'
 
-test_expect_success \
-    'make sure index-pack detects the SHA1 collision (large blobs)' \
-    'test_must_fail git -c core.bigfilethreshold=1 index-pack -o bad.idx test-3.pack 2>msg &&
-     test_i18ngrep "SHA1 COLLISION FOUND" msg'
+test_expect_success 'make sure index-pack detects the SHA1 collision (large blobs)' '
+	test_must_fail git -c core.bigfilethreshold=1 index-pack -o bad.idx test-3.pack 2>msg &&
+	test_i18ngrep "SHA1 COLLISION FOUND" msg
+'
 
 test_done
-- 
2.19.1.759.g500967bb5e

