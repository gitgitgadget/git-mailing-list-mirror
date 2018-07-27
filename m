Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 673391F597
	for <e@80x24.org>; Fri, 27 Jul 2018 14:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388410AbeG0QAA (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 12:00:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38754 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732267AbeG0P77 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 11:59:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14-v6so5293177wro.5
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 07:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kb2aiA9/N8NTRsJzd3af52sWodm0EesuQzgV3tMYAsI=;
        b=WCCKfYaPknV/NUIyhnhyhWI/+WYYfABGNB9Gb5W+PJO7l7ACv6XGaxsrpc/YaR0be9
         NLLpqb61n8AgQW51ERUl2hZaaIiauYCpe9MMRMdldAx/PQ8Pi+9jxXFFjDdCE6YH5ge3
         iaXENQQn6DQ8wB7sDWYiSSWD2RWVOhMVtfmG2OtJdeE0aom8kAGV/LAfxMhRfC3J9gNT
         5OggO/92YzVlL8yJt7AFgiw96MGB14SovjAF1tL/BpuZeNGrKz47VclKxEJk9dUumICt
         X43qV5ZEsEEoQL7/qPg0g9bcpZYsRHaky2IoJ1aiWAf6er0cofLhusie/d9QkOpLMRxe
         3ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kb2aiA9/N8NTRsJzd3af52sWodm0EesuQzgV3tMYAsI=;
        b=ntS0W/n5CASadMec+pn2+pPqPcLsOgpVIeph9YcIOCCVn3pJR9puN1O+h4lpmw6UE4
         hUkuYbH3EoeUyQo7XFJjhxX8qtEa1uS4MT6I6f3tnzwRX/ahhRQmSa3CcXWH0DEX1god
         prPs+uvwQSgXfjRX9aJw2kCS/MJy8VPKbilxkaKvN9OXaLNZRWqNd+Gd3tksRCk5AbpZ
         dkn9VA0Njs0lWbMSQ9fZ00d3e8mphk5n6VcYtSdl0aSoPlGVGmwayMVa9wLUjaY+fDh7
         9K2pq4MHI9l32Z/nQXDtcH0iV/w4iTgdjPLBCtfa3bULejpVgHa9+wn/EKZZgFYAkIDO
         z1lQ==
X-Gm-Message-State: AOUpUlHG+DTCq0JFhz4hMzS3PfTRAvCJQ+1FVpHpVOEdjwGBJugoORH8
        PZWgAqDm1BrOV82rqfcyf3oziuCFGRo=
X-Google-Smtp-Source: AAOMgpfQ+WVe197lfbHh3SI1LWSkRGdf5VD+tsGFIT93QT6h+ykUKaknDHP3Wgl4hI/19fkMcZtBjA==
X-Received: by 2002:adf:fac1:: with SMTP id a1-v6mr4775110wrs.74.1532702265796;
        Fri, 27 Jul 2018 07:37:45 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j16-v6sm3005479wme.8.2018.07.27.07.37.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 07:37:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/10] transfer.fsckObjects tests: untangle confusing setup
Date:   Fri, 27 Jul 2018 14:37:16 +0000
Message-Id: <20180727143720.14948-7-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180525192811.25680-1-avarab@gmail.com>
References: <20180525192811.25680-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests for transfer.fsckObjects have grown organically over time to
not make much sense.

Initially when these were added in b10a53583f ("test: fetch/receive
with fsckobjects", 2011-09-04) they were only testing the "corrupt or
missing object" case, but later on in 70a4ae73d8 ("fsck: add a simple
test for receive.fsck.<msg-id>", 2015-06-22) they were expanded to
check for the fsck.<msg-id> feature.

The problem was that we still kept the same corrupt test repo, making
it harder to add new tests that check the entirety of the repository
between operations via "git fsck" to see whether only known issues
that can be ignored with fsck.<msg-id> have occurred.

The tests only did the right thing because such a full "git fsck" was
never done after a certain point, and instead we were only
manipulating specific refs. This makes it harder to add new tests, and
none of the fsck.<msg-id> tests relied on this.

So let's not confuse the two and repair the corrupt repository before
we run the fsck.<msg-id> tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5504-fetch-receive-strict.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index e1f8768094..57ff78c201 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -3,13 +3,16 @@
 test_description='fetch/receive strict mode'
 . ./test-lib.sh
 
-test_expect_success setup '
+test_expect_success 'setup and inject "corrupt or missing" object' '
 	echo hello >greetings &&
 	git add greetings &&
 	git commit -m greetings &&
 
 	S=$(git rev-parse :greetings | sed -e "s|^..|&/|") &&
 	X=$(echo bye | git hash-object -w --stdin | sed -e "s|^..|&/|") &&
+	echo $S >S &&
+	echo $X >X &&
+	cp .git/objects/$S .git/objects/$S.back &&
 	mv -f .git/objects/$X .git/objects/$S &&
 
 	test_must_fail git fsck
@@ -115,6 +118,13 @@ test_expect_success 'push with transfer.fsckobjects' '
 	test_cmp exp act
 '
 
+test_expect_success 'repair the "corrupt or missing" object' '
+	mv -f .git/objects/$(cat S) .git/objects/$(cat X) &&
+	mv .git/objects/$(cat S).back .git/objects/$(cat S) &&
+	rm -rf .git/objects/$(cat X) &&
+	git fsck
+'
+
 cat >bogus-commit <<EOF
 tree $EMPTY_TREE
 author Bugs Bunny 1234567890 +0000
-- 
2.18.0.345.g5c9ce644c3

