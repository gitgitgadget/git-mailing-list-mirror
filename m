Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 993191FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935994AbdCXSll (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:41:41 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36764 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935964AbdCXSlb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:41:31 -0400
Received: by mail-wr0-f196.google.com with SMTP id u1so1657514wra.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jZQ9EnPrJxLVxOIZln/9aaWXxOpw4zBUMsN8qH8TARk=;
        b=MOfxnULfsMJjL93TStIcwdn6ZnscOfAO3ibY4cDFiaFOVjcoAhzzfLjJ96iAivbcZe
         0jRrWgpbzYJ/lONm1RYtVEIPf1o4CRrHSfv4Ckn6uOC60L43NsnfHWmMjapMys3Og90c
         bCseWubwBfZBkfTkmE8gCC4OEeEt/cMlu/UJ82ZhUjItDGAV4ilU4Cdp8SHHljqkmw9L
         MgUrLTtfJFQTFXmt8ihvBse5TVQ29MiG2UAicxCqUa8mHPa9ffi5YziAPApKtNsiA4XL
         gey78xylbTZWdMdtqJVceshsPSPIJGt/P/E23g0NwvELAq5ci4B407a2LHgitysJz192
         YUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jZQ9EnPrJxLVxOIZln/9aaWXxOpw4zBUMsN8qH8TARk=;
        b=oxnxMUVqARuJhzYr94DIh20W73FwZorQwBSJlzZkjMZTwdZnzW1olmbqzNhwYTRiMG
         fSD6cQ9ewyKwKTnQ15WkUvlyPGJPYayCuDAFU9CU8PGlCqPi/RqYQWbaGDz4OuuArvuj
         gbccV2wa/XjWr97iYdOT/IiO/IILLHQJRnyhIZr6aEZ7xwxNL0klqsuvWFH2lMTAZhQ9
         vgb58lFj9YYqG+vdxhX8t3DL9sT5d7zDBXzw37Tsj89gso1y0MMvg4bokwlXpB+qGIty
         hkHPeqXqhlMZcEx/7BUzAcJny7HupIxFvlSbcZ/fPQd8syinDBGNH5bvXcJO5pg2krWS
         61YQ==
X-Gm-Message-State: AFeK/H0VJ7y16yIKrDrrOEgHgbKmE3tdXXQQgkO/rp63hrau5WHsxRRBjh/98dblkqDCCw==
X-Received: by 10.223.183.6 with SMTP id l6mr7268799wre.192.1490380889911;
        Fri, 24 Mar 2017 11:41:29 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j77sm3440560wmj.3.2017.03.24.11.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 11:41:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 06/16] tag: remove a TODO item from the test suite
Date:   Fri, 24 Mar 2017 18:40:49 +0000
Message-Id: <20170324184059.5374-7-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170324184059.5374-1-avarab@gmail.com>
References: <20170324184059.5374-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the test for "git tag -l" to not have an associated TODO
comment saying that it should return non-zero if there's no tags.

This was added in commit ef5a6fb597 ("Add test-script for git-tag",
2007-06-28) when the tests for "tag" were initially added, but at this
point changing this would be inconsistent with how "git tag" is a
synonym for "git tag -l", and would needlessly break external code
that relies on this porcelain command.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7004-tag.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 3439913488..830eff948e 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -16,7 +16,6 @@ tag_exists () {
 	git show-ref --quiet --verify refs/tags/"$1"
 }
 
-# todo: git tag -l now returns always zero, when fixed, change this test
 test_expect_success 'listing all tags in an empty tree should succeed' '
 	git tag -l &&
 	git tag
@@ -136,7 +135,6 @@ test_expect_success \
 	'listing a tag using a matching pattern should output that tag' \
 	'test $(git tag -l mytag) = mytag'
 
-# todo: git tag -l now returns always zero, when fixed, change this test
 test_expect_success \
 	'listing tags using a non-matching pattern should suceed' \
 	'git tag -l xxx'
-- 
2.11.0

