Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6626E1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 09:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeH1NnZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 09:43:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40856 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbeH1NnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 09:43:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id n2-v6so954480wrw.7
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 02:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rvRMbLUKocGeBQ7ERohVq1PSFQLi+rDviHwHAycDy8Q=;
        b=emd55GMsEqfBZvAmejr0P7s2+0UITQ5549OMKLim+YBCcqcTsan6m61FcSOjRmZLBk
         xjPqHHcVMYUp0P0GRKBViVPhZbztjS33dpkUCI++sCUT2oW5jQ74e3n5+s/a4d7rHkr8
         Bxfh40BWET0Q/eT2X10UTDVSpuKiZZ66dhGDZK4EpqCzfoKBhl3XEG6JZBtpqa7uYvxa
         ShgpNCHUJ6qlYEkwx2NqKR7+NcqBZHZgWKYvoVx17iXs7sXq/MGhyPFRjHDYl+Mdw6fg
         O80GRxkgN/NJVpVdl3YIP9QaDEffxEeXCBhUV3nqw+afHjPeCptVrph/IHQ3QF1A+j9r
         f0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rvRMbLUKocGeBQ7ERohVq1PSFQLi+rDviHwHAycDy8Q=;
        b=PWbgHSdhxxlyyJqXj66dh8124FOQQB6AGL9qkMSl0hMhOn5MMmlXk3CWT9fAWiI13j
         pljlZHbxEaTeLNggE1mJ8UvonTdgEo0ATPmoeTBLd7+s6HJhKxSMMgoWeujFxo9XUhR6
         gKenGGQhTfUAK81ss+epiV4xKhPlytm3KpOTW3uYxq5BKvaa+6uEHzXwTrNHvzlSditj
         msHPqHISXCF6lJOidYkQjTIwhxefZw1YoKHF3mEzCi8FJGFn1BqvGbnrq0328UxC5xbE
         jsGy0wUENBVXuSYwinLBpkmkFMophmltX6T2ONsbU7/VKZa2SUpM8pvCBf6KWqTY87Kh
         +MZQ==
X-Gm-Message-State: APzg51DFFLgbEzoYjhWSEb/wIGkidIKohRBeaMSqzn0ar8zqyrd4LXOV
        9Zoe7RbUVj1k/rYqaXXgGSCQQQbKhuI=
X-Google-Smtp-Source: ANB0VdY7lPkoz48IvsU9ZlyOzUe98C8Lkv5nYkV/eS/WA+sXQLlOsbX38RRIgDu6ahlZUoZYGw7C0A==
X-Received: by 2002:adf:b519:: with SMTP id a25-v6mr623443wrd.273.1535449952867;
        Tue, 28 Aug 2018 02:52:32 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a37-v6sm1572238wrc.21.2018.08.28.02.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 02:52:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/8] fsck tests: setup of bogus commit object
Date:   Tue, 28 Aug 2018 09:52:12 +0000
Message-Id: <20180828095219.23296-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <87lg8refcr.fsf@evledraar.gmail.com>
References: <87lg8refcr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several fsck tests used the exact same git-hash-object output, but had
copy/pasted that part of the setup code. Let's instead do that setup
once and use it in subsequent tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5504-fetch-receive-strict.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 62f3569891..6d268f3327 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -133,6 +133,10 @@ committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
 This commit object intentionally broken
 EOF
 
+test_expect_success 'setup bogus commit' '
+	commit="$(git hash-object -t commit -w --stdin <bogus-commit)"
+'
+
 test_expect_success 'fsck with invalid or bogus skipList input' '
 	git -c fsck.skipList=/dev/null -c fsck.missingEmail=ignore fsck &&
 	test_must_fail git -c fsck.skipList=does-not-exist -c fsck.missingEmail=ignore fsck 2>err &&
@@ -142,7 +146,6 @@ test_expect_success 'fsck with invalid or bogus skipList input' '
 '
 
 test_expect_success 'push with receive.fsck.skipList' '
-	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
 	git init dst &&
@@ -169,7 +172,6 @@ test_expect_success 'push with receive.fsck.skipList' '
 '
 
 test_expect_success 'fetch with fetch.fsck.skipList' '
-	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
 	refspec=refs/heads/bogus:refs/heads/bogus &&
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
@@ -204,7 +206,6 @@ test_expect_success 'fsck.<unknownmsg-id> dies' '
 '
 
 test_expect_success 'push with receive.fsck.missingEmail=warn' '
-	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
 	git init dst &&
@@ -232,7 +233,6 @@ test_expect_success 'push with receive.fsck.missingEmail=warn' '
 '
 
 test_expect_success 'fetch with fetch.fsck.missingEmail=warn' '
-	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
 	refspec=refs/heads/bogus:refs/heads/bogus &&
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
-- 
2.19.0.rc0.228.g281dcd1b4d0

