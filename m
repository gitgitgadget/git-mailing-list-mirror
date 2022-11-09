Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F08C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 14:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiKIOQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 09:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiKIOQg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 09:16:36 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19596C18
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 06:16:35 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id z14so25969325wrn.7
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 06:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ar2ius42hMnj0wa8u3LL7berpF/Wo7TyfRAAaZ+ODs=;
        b=G6CiZgtutSfhcHXnIJwTtUAPgDVZ77yEisAVDDAb0nZ9sruAgJfqQ06to8cmSPtEdz
         Cbfz1v15wx6NKJTbSeN/txdr8IIH+fsSiWnWfJEo8pE/zf2WpkQJ+aJ4hWs1T7d9QTd9
         bSslBO4XY7L9GtvxiMG4gvSRSATeL+9ZpuxL6BGXsXS8kRDa67WXs57VCDEYdSrdK2Ov
         2PElQGd/byjBVoKMtyvqf7DJoBGyNMG/NxJtFVT7SpzWSlOGyDjUoxYSgAnt8WnRcLcs
         stVkn174t3U3BcZTmWr6+9X8wsciFFMdx2/7RC73Fe0zaJbgwj/QkbVXIvfbAYJivS0u
         ERtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ar2ius42hMnj0wa8u3LL7berpF/Wo7TyfRAAaZ+ODs=;
        b=5sC2Miq4DQ8iARLhz1z0dzBJRIthmNqrjj7D2K9H9oatYBHoqz2Te5gKQhUCShwBzX
         rNwvLi7SvY/dAxpp6qhrAru7+RCkSPmtDEC2BI97/wODLkjeRvjjnYoBCvpMR13dW4iO
         N7ulsdcCZfSKvjNOFmRcbbeyu2kUC++gr7B5xr7dICrsow4uZO1S8qAotHMTZmcRYE/K
         K2lnLBh2tNOsPp2QA1Vlvosdwln4QtcRWuS9hNxdslf54kaN2sIdNcfAytkOtMweZqrg
         cc+Yv0889EakMYuiJ8SHES4oYOUc9qDM8bocMtNktp0joHpNrPjOouicm6uJ9pkBK9/V
         el4Q==
X-Gm-Message-State: ACrzQf0BfrqFU+G3p8CDpQsU0XDL7iYgXju75AjsssyOXjBQl+6IUE9L
        414Og3bkusbv/5ytCawVPLf9yeMOiWY=
X-Google-Smtp-Source: AMsMyM7FSUNNVrFLWKou6Jw22aPESS8Tvq/05Tdvj9nc8NMPxRYFRA48L74W9xdW50JQrCJG6oyBlQ==
X-Received: by 2002:adf:e609:0:b0:235:f4e6:c7c1 with SMTP id p9-20020adfe609000000b00235f4e6c7c1mr39211847wrm.217.1668003393370;
        Wed, 09 Nov 2022 06:16:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c029a00b003cf5ec79bf9sm1818034wmk.40.2022.11.09.06.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 06:16:32 -0800 (PST)
Message-Id: <d1ac79909b9e777cae40a6a301e5cfd988c5f9d7.1668003388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1389.v2.git.1668003388.gitgitgadget@gmail.com>
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
        <pull.1389.v2.git.1668003388.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Nov 2022 14:16:26 +0000
Subject: [PATCH v2 1/3] git_parse_unsigned: reject negative values
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

git_parse_unsigned() relies on strtoumax() which unfortunately parses
negative values as large positive integers. Fix this by rejecting any
string that contains '-' as we do in strtoul_ui(). I've chosen to treat
negative numbers as invalid input and set errno to EINVAL rather than
ERANGE one the basis that they are never acceptable if we're looking for
a unsigned integer. This is also consistent with the existing behavior
of rejecting "1–2" with EINVAL.

As we do not have unit tests for this function it is tested indirectly
by checking that negative values of reject for core.bigFileThreshold are
rejected. As this function is also used by OPT_MAGNITUDE() a test is
added to check that rejects negative values too.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 config.c                 | 5 +++++
 t/t0040-parse-options.sh | 5 +++++
 t/t1050-large.sh         | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/config.c b/config.c
index cbb5a3bab74..d5069d4f01d 100644
--- a/config.c
+++ b/config.c
@@ -1193,6 +1193,11 @@ static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
 		uintmax_t val;
 		uintmax_t factor;
 
+		/* negative values would be accepted by strtoumax */
+		if (strchr(value, '-')) {
+			errno = EINVAL;
+			return 0;
+		}
 		errno = 0;
 		val = strtoumax(value, &end, 0);
 		if (errno == ERANGE)
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 5cc62306e39..64d2327b744 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -709,4 +709,9 @@ test_expect_success 'subcommands are incompatible with KEEP_DASHDASH unless in c
 	grep ^BUG err
 '
 
+test_expect_success 'negative magnitude' '
+	test_must_fail test-tool parse-options --magnitude -1 >out 2>err &&
+	grep "non-negative integer" err &&
+	test_must_be_empty out
+'
 test_done
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 4f3aa17c994..c71932b0242 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -5,6 +5,12 @@ test_description='adding and checking out large blobs'
 
 . ./test-lib.sh
 
+test_expect_success 'core.bigFileThreshold must be non-negative' '
+	test_must_fail git -c core.bigFileThreshold=-1 rev-parse >out 2>err &&
+	grep "bad numeric config value" err &&
+	test_must_be_empty out
+'
+
 test_expect_success setup '
 	# clone does not allow us to pass core.bigfilethreshold to
 	# new repos, so set core.bigfilethreshold globally
-- 
gitgitgadget

