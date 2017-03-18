Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F275C20323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751397AbdCRKeQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:34:16 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33949 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdCRKeN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:34:13 -0400
Received: by mail-wm0-f46.google.com with SMTP id 196so12064368wmm.1
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FZuKUr0gyJ9WAe0bvaZ46ks8bP5WyeT2NNDuVk7h56A=;
        b=Y4/4Yx4yuWlno84G6W3bXjo1leHvUq1JgYqTdqgMa6c07ymvg+C2qYdNo9JoElkZC2
         aodaGYBcat6BJcKhaQjiharVzhLh63DZXTbQuLHyV8NmaDq48V45nIA3HeMoA12Ivkkj
         vQEhdU86Bb0L1LhdWcY9CvuB06xZGzTXvQcgtOpQrhNJMLOMp5WdRsvqfc6tYbDvl9nE
         KvKuNmyZfHMrowty/1e1mhGKPMPwtKPwlFp2aouyqYr2400+D6tijDRn1C9FzjBaa1ZJ
         WxE+Dks+GySnt43MtWNYN5X4df769DdNVbENmlQihNeJ/5sZZb4nCP6mSaZeTJVlfLRd
         w9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FZuKUr0gyJ9WAe0bvaZ46ks8bP5WyeT2NNDuVk7h56A=;
        b=UzJTOKPttMt63RehHVVZJO/24H9JgZBpyDVOPwfkLc4q1Tr+psyH3T3O69hizUwTAv
         x99/ZfwiBniSzZdf9khoFHv8LYDlfEB7G6q2N14jmQ5Qirz71njQsKBgNkLYZujaikJV
         ZI9Jy6mc+ou/f4wBriTB7RvxtT8M01oGb7AheELhsVkHV7IDNiy+wNEdc0zwKDMXCvJl
         x6vn9qlE5or0ys9oHOf0JVN5JpJERLQHxRIVhIn11fThMdXPBRGGHU/BJ1rMrk9zWoF2
         P89D1UTm0tR+Z4fpDUNMH7af5drcKFqPiPjgGnjOe9D2oeKtkMRxhwWnTnLMb91PH56H
         tr7A==
X-Gm-Message-State: AFeK/H085rRZeqYOVdeKs4dAMg5wEEeFUsVtW5RhBMiOtLj7J52Nn2kulcc6b6XxQUTFrg==
X-Received: by 10.28.216.208 with SMTP id p199mr2114257wmg.44.1489833201110;
        Sat, 18 Mar 2017 03:33:21 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j34sm13007928wre.7.2017.03.18.03.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Mar 2017 03:33:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/8] tag: Remove a TODO item from the test suite
Date:   Sat, 18 Mar 2017 10:32:49 +0000
Message-Id: <20170318103256.27141-2-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170318103256.27141-1-avarab@gmail.com>
References: <20170318103256.27141-1-avarab@gmail.com>
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
index b4698ab5f5..876ccfc830 100755
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

