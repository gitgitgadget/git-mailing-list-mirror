Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2DD61F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 01:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfJ3BzV (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 21:55:21 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39994 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfJ3BzU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 21:55:20 -0400
Received: by mail-io1-f66.google.com with SMTP id p6so648896iod.7
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 18:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UJyFd90ranVPeka7a8NP+MpVxtScItxGbo210Tre3qw=;
        b=soFTUgl4Dx+E24ipxQmjn04kfZueVaw++uZze0UxJCpo0tpn3WdgYtlC5cD70fIk9H
         E8HYkp3StoACmrMI08c07BB+QH42oq3xLW+eQ854HHdkaeWfXu5iqKVffj8XseYUEgPV
         a31Kzl9qwhVENgeMV1NfmWR4tlO6YVZnkbKPqjRbWCwREl/D2j1pWbf4czLRK5tb9LgZ
         tle7Yfud+nhnrE8ULGEMvsv6Am6nkvB3tw8ECaL9OqGXao2jxh+/D7HoRGXWzoCN9D6L
         JTuBStIwlpP+0R3HK29TpaUnzeomFqUsEu3GhygIdtnfHBNPN7uLPY95Gd0nwSj0MSDM
         LPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UJyFd90ranVPeka7a8NP+MpVxtScItxGbo210Tre3qw=;
        b=YQ4FfSw2Qb7IOq35I+8I/vzTPKgzOW+41+u7mOPo024r6GaGNMwDKk3W2m+TBQ9eVc
         WBLplJpUABc4Vy/FjmDQlVszCHGo4Tgi+DK/yD7OeOD+RVS9vFv8PnSStGzcjGnCzniZ
         B4pkZRSluwz7ichyImsK3IiV0zVoJNE0DK5VG/EZPPIfzj3dXUJ9QxlxdJDki2vNUU6e
         YTUiPZfV4nwPj305BPrQd1JSt+w+QRCahl1WZZoSrr6vQn74sEQXVq4KRR4b6IalbTcv
         bb+0zlsP3kuPaFSqZlkuhuNt9KPdozDTLtyXAh4EcHMRvYzeAL8d56AY9umaLmR9To10
         JIBQ==
X-Gm-Message-State: APjAAAU6CyTRML4VzagAbfLM6BCBD+1mRSCpVQW5oLAv5/A+3pnEUXeC
        xkFZAZl8Pfu8GGlHvhTkE1D0PwXFSVE=
X-Google-Smtp-Source: APXvYqz8nnRVSe8sDa8AGDRfqt+kWalYGziXutl/6R4rKnBVHdVeznDGbdjve3Ye66lQQf32L10w/g==
X-Received: by 2002:a5e:9b13:: with SMTP id j19mr7079998iok.169.1572400519409;
        Tue, 29 Oct 2019 18:55:19 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:4100:375e:3837:c90c:13fa:5c01])
        by smtp.gmail.com with ESMTPSA id d2sm77814iob.22.2019.10.29.18.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 18:55:18 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, chrisadr@gentoo.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] apply: clarify that index information is embedded, not the index itself
Date:   Tue, 29 Oct 2019 19:55:03 -0600
Message-Id: <20191030015503.156441-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
The Spanish translation got this wrong.
---
 Documentation/git-apply.txt | 2 +-
 apply.c                     | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index b9aa39000f..474be244ca 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -92,7 +92,7 @@ OPTIONS
 	with the `--reject` and the `--cached` options.
 
 --build-fake-ancestor=<file>::
-	Newer 'git diff' output has embedded 'index information'
+	Newer 'git diff' output has 'index information' embedded
 	for each blob to help identify the original version that
 	the patch applies to.  When this flag is given, and if
 	the original versions of the blobs are available locally,
diff --git a/apply.c b/apply.c
index f8a046a6a5..86f7cb3d88 100644
--- a/apply.c
+++ b/apply.c
@@ -4987,6 +4987,10 @@ int apply_parse_options(int argc, const char **argv,
 		OPT_BOOL('3', "3way", &state->threeway,
 			 N_( "attempt three-way merge if a patch does not apply")),
 		OPT_FILENAME(0, "build-fake-ancestor", &state->fake_ancestor,
+			/*
+			 * TRANSLATORS: Information about the index is embedded, not the
+			 * index itself.
+			 */
 			N_("build a temporary index based on embedded index information")),
 		/* Think twice before adding "--nul" synonym to this */
 		OPT_SET_INT('z', NULL, &state->line_termination,
-- 
2.23.0

