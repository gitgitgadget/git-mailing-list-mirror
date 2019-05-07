Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92A8C1F45F
	for <e@80x24.org>; Tue,  7 May 2019 10:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfEGKyu (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 06:54:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35189 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfEGKyr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 06:54:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so19363821wmd.0
        for <git@vger.kernel.org>; Tue, 07 May 2019 03:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9YjbxlRSIwcJGXUOpanoKvWt+EBS29cR2Xu/Zxg6Usg=;
        b=a+fxVVHd2hNzhq09igFBD96bBoDPTWHYOrtKY9N6BcU+U5CkJaOXBY1zmlwtIzWJ9e
         iFjWqh5DKnwFkU5d9J0xHdHNFUrpMAe/09yovShY24pSn1ZWO3bKzUNqv3yzGZGO5yhx
         JxdZBdi/uXG3aDRx7gUTXiAKWjmYgi+oi6HQSImEK+KjvLxYOmCgJ30X12vKciMyL7fT
         jI/4uv9jGZeoXlW5xvm8YAaykegqgFsqXTd8PMrxrhUrzAvjwjxbLfo4HsWCn+CexjAr
         6R683x9krkdPWgwGrsPGLFvN3Zf4cv+Wytc2t67djaBB/4w11hksZNNcQhXDLz8Vt4vf
         bKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9YjbxlRSIwcJGXUOpanoKvWt+EBS29cR2Xu/Zxg6Usg=;
        b=VPzzu1DZZulSJabqdZIaUQcl32HF5HabN+AEcPNUaPIzhhE3pLccq5nOTg1LZmb0/F
         KnWBNIDup+lLI/TMnn1IlrUTs9ONDvA098aiXhGRhQMx4TW5lnASJrJ911Af5SVxNme2
         fEvTDg0MUQ4Rz04ULEZ7BQsYz1ZMqr9MGX3b3Ync1OjVd9712bb2mRsMio2IvPM2R5SI
         wg+puMvrnxUblvdyAAo5ULKBcMKLVT8OttjnbWglBSR5bqh9TuSpgaBO6V+1rDp3V2/z
         Dc4vq031t0tk91AGF0ksbjTHuDoGwzONldcT+PqdPx++vWZfSVKWzJMr/F1+K4dSFsh+
         R96Q==
X-Gm-Message-State: APjAAAVxImM+7i1rwZakuACx3DYRw4/lJ9eksaIV2JtxBwE3vyeMNqPA
        1pZ5TV7cvEqORh9m9tW0fBMNi3PAW8M=
X-Google-Smtp-Source: APXvYqwCjZWyxCFjI+0BghefpAy83UrhN09vZ8mRtp5WrpvJjoAfCZnIhBPt1u8RQgMZy9PXGszvvw==
X-Received: by 2002:a05:600c:21d2:: with SMTP id x18mr6326297wmj.81.1557226485456;
        Tue, 07 May 2019 03:54:45 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm11029573wmb.12.2019.05.07.03.54.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 03:54:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/6] perf README: correct docs for 3c8f12c96c regression
Date:   Tue,  7 May 2019 12:54:29 +0200
Message-Id: <20190507105434.9600-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <20190506232309.28538-1-avarab@gmail.com>
References: <20190506232309.28538-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 3c8f12c96c ("test-lib: reorder and include GIT-BUILD-OPTIONS a
lot earlier", 2012-06-24) the suggested advice of overriding
GIT_BUILD_DIR has not worked. We've printed a hard error like this
given e.g. GIT_BUILD_DIR=/home/avar/g/git:

    /bin-wrappers/git is not executable; using GIT_EXEC_PATH
    error: You haven't built things yet, have you?

Let's just suggest that the user run other gits via the "run"
script. That'll do the right thing for setting the path to the other
git, and running the "aggregate.perl" scripts afterwards will work.

As an aside, if setting GIT_BUILD_DIR had still worked, then the
MODERN_GIT feature/fix added in 1a0962dee5 ("t/perf: fix regression in
testing older versions of git", 2016-06-22) would have broke.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/README b/t/perf/README
index be12090c38..c7b70e2d28 100644
--- a/t/perf/README
+++ b/t/perf/README
@@ -45,7 +45,7 @@ call the aggregation script to summarize the results:
 
     $ ./p0001-rev-list.sh
     [...]
-    $ GIT_BUILD_DIR=/path/to/other/git ./p0001-rev-list.sh
+    $ ./run /path/to/other/git -- ./p0001-rev-list.sh
     [...]
     $ ./aggregate.perl . /path/to/other/git ./p0001-rev-list.sh
 
-- 
2.21.0.593.g511ec345e18

