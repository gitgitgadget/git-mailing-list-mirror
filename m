Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B24C32095B
	for <e@80x24.org>; Tue, 21 Mar 2017 13:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757473AbdCUNBP (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 09:01:15 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37277 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757095AbdCUNAv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 09:00:51 -0400
Received: by mail-wm0-f43.google.com with SMTP id n11so11828988wma.0
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jZQ9EnPrJxLVxOIZln/9aaWXxOpw4zBUMsN8qH8TARk=;
        b=OHIO7sd/wVlMkpe8ptfAzUjPsX1FAgMIDf/dItMSDEVOjY3Z0tX2ySwUq7YESv5HtP
         sP0LsMf1+tidC2wqPP4tjVn9IIKaC3SkTpmn9jD6K0BYsb+mhJNS7fR0XlAZl+hf+lkA
         Vg+P78uW4iIXtgZBjOpcgRBf6ItwqcLCDBC7QdsL9KBeWZOLQHZ0jdePmuIQ5KkKoz1l
         /ldkZLKBnMjgDBiy5DM30e13caGy2NRqW27Ou0kBTbtcnzMkYcbNatUwdiz8bA+OU6Rb
         uwOUpyL3Y+g68I9nKaXyf84DzxTCA/QiD24N0xqGcWqf7509mycao0XQELiFbUovV4fl
         1I4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jZQ9EnPrJxLVxOIZln/9aaWXxOpw4zBUMsN8qH8TARk=;
        b=YWdmAzUqL3aKf8IDonzGHG3/ayVGwOMsLfGJ0wvUjNHe7pnmlFndY6lgZhr8j78NeC
         U7Q4YCNLFBg2YlOvDN64B+oe/zisYtUuXuu0U1vqLGMkwEXooMf0huEzlj6A+PZcRKk2
         hWXEUU7Gwc1lMp3L05Ey95lXOe45IcOqqyuHU/Y6djsWOt8GKOca1dksxKdm9jdXpN13
         PceFRSEsWZFS0v3wnsJn175SrNzYrr980nLJFUJ2yp2yQsxROonbUXjMkULXN4Ka5aMA
         IT+MAEoGVAXtn0sUzmeQpURJb635suwlJaWXEGdFhKjXuccXMGk+3G41CK3Am0ouoIyu
         eYAg==
X-Gm-Message-State: AFeK/H2qoGWWKSn1mxw+14v0mc5KcqVxXP8P9IdaA6l1RCofH90VkhGY41m8FFE5aQFGYw==
X-Received: by 10.28.129.212 with SMTP id c203mr2647974wmd.19.1490101211126;
        Tue, 21 Mar 2017 06:00:11 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 63sm17555072wmg.22.2017.03.21.06.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 06:00:10 -0700 (PDT)
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
Subject: [PATCH v2 06/16] tag: remove a TODO item from the test suite
Date:   Tue, 21 Mar 2017 12:58:51 +0000
Message-Id: <20170321125901.10652-7-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170321125901.10652-1-avarab@gmail.com>
References: <20170321125901.10652-1-avarab@gmail.com>
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

