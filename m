Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B6C1F453
	for <e@80x24.org>; Sun, 28 Oct 2018 22:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeJ2Hgk (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 03:36:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46603 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeJ2Hgj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 03:36:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id i4-v6so6646442wrr.13
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 15:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wSjop+8hcC+JtDzDYckrp/r9aAESQSkG2B3jsfhiVFs=;
        b=ktF2+zDSHM0JrybeQo9sXT44g2ejeh3PszBHvDBOkxeIVELGUElUWyP999Lu2shPac
         4N+2ZUYa2rWmaxCS4QKwtCTj6VsCwX966UCxzr0MGy1Uuk+2bLgFxmd75XgZMw8ctIAj
         AaPpea6XsQgV9/WxkQFjZKQMI6OdUoX1fUHCDPj5V8A7j2yYoQoSVOh5fHkjqHM9ER8F
         yy/os7HRbrR8ywBBXaoc94taWhqCIzB8l4chHgLGMGUOStOgo+zbObQ10tXJ462/QsYA
         1k1YSD6rhliid7NBJfAbv2o2br7o/Q1TCM61HThLqUIxNwQ7yRVQB62uBeyK1ik02Xky
         PBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSjop+8hcC+JtDzDYckrp/r9aAESQSkG2B3jsfhiVFs=;
        b=RseS5l3MQSJ8yKI3WgCgVbnKN/HkHBZqS3yCgypmgA/JcI97YyvMeSo7x5HayvOAgo
         ko2HVth2owcvetISMohEaZ2nrbEiaoQjdlBMRO2MLwqLNb9tDTeLb5q441+rGa3d8V+V
         +F5yKYvebQbDYYszhrCvjhQu1Hu0k5PoCXy5lLjr0VT+golxFiDoRp7F6Vl1h+iM07mf
         D1u90zMO/2ibeR+OgmBjFn0sZUCqCNHy8kidvL3qo0cBJKkTxf9VVKoyao6JxV8bkoKK
         KmRfvU4acx7y6W/YHuzA6VdKC3W5lcOgWIuv904sCY/dxv2o4fEIRNPFdTXAnHH28XzQ
         8Obw==
X-Gm-Message-State: AGRZ1gKxLdl8tszq/lKD7q7sDGq/mCGZpsgoKFpg5u/pPdItKbR7HKGP
        n3FrDlHohnQ29dcJmHgDpR2Rvgw/0uA=
X-Google-Smtp-Source: AJdET5e1Ve41NJ8EtXWCChXXTuNT8ZLzCQOp/fLOLfx43NUUgTnojZQAv8ERM+n9OyFZsJfpUJERPA==
X-Received: by 2002:a5d:64c1:: with SMTP id y1-v6mr11902612wrv.92.1540767035011;
        Sun, 28 Oct 2018 15:50:35 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p3-v6sm2709681wre.47.2018.10.28.15.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 15:50:34 -0700 (PDT)
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
Subject: [PATCH 3/4] index-pack tests: don't leave test repo dirty at end
Date:   Sun, 28 Oct 2018 22:50:22 +0000
Message-Id: <20181028225023.26427-4-avarab@gmail.com>
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

Change a test added in 51054177b3 ("index-pack: detect local
corruption in collision check", 2017-04-01) so that the repository
isn't left dirty at the end.

Due to the caveats explained in 720dae5a19 ("config doc: elaborate on
fetch.fsckObjects security", 2018-07-27) even a "fetch" that fails
will write to the local object store, so let's copy the bit-error test
directory before running this test.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1060-object-corruption.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index ac1f189fd2..4feb65157d 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -117,8 +117,10 @@ test_expect_failure 'clone --local detects misnamed objects' '
 '
 
 test_expect_success 'fetch into corrupted repo with index-pack' '
+	cp -R bit-error bit-error-cp &&
+	test_when_finished "rm -rf bit-error-cp" &&
 	(
-		cd bit-error &&
+		cd bit-error-cp &&
 		test_must_fail git -c transfer.unpackLimit=1 \
 			fetch ../no-bit-error 2>stderr &&
 		test_i18ngrep ! -i collision stderr
-- 
2.19.1.759.g500967bb5e

