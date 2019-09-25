Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC6341F463
	for <e@80x24.org>; Wed, 25 Sep 2019 10:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389768AbfIYK1H (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 06:27:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39823 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389749AbfIYK1G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 06:27:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so2954609pgi.6
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 03:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pRRMBXRaRxDDfb3yQU2gXfOsDvB+o0/XpPKN0ZCfP88=;
        b=BketmYyKYRC6UA7I/D9DGo0c1d6gF2jKQX0+/LiQ8SJJ0lR9rRgjK8S3rPZa52T6eH
         BEiou3VRi6hZJXQWPUimKLumg44CDyyPA1DCd/Iu3FHCKJApKdEXKyBPGUWIE8Xhd33f
         XEzU5mP+L7XqCbtjIxij0B4xoRjQT/UcsiDTDhLVm6aIg079IXPiL29YSrSUBuvgdYXf
         FBXMZwPatBqfhwCr3lxk0bvs9Pt7X8Nb0W80gkO4eVMyUKXGlU8qsYCEeJd559dYcK1o
         1apJWZiPiwFSj3ZVno9YNBZBY77nCobGqFd/jLMpI71ioVbhxPk/xobezltfZdxCtI9W
         vouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pRRMBXRaRxDDfb3yQU2gXfOsDvB+o0/XpPKN0ZCfP88=;
        b=DK7GkkQhCrjZMBerN0Fe27T4P2bGtjZlFaEDUj5E7TMoPfOTjjr5uOV7Cq40PTuiMm
         kyoDlgiYNFARy0tMlG735hAulXfODtA9VDtJRrBolr2yXojZ0AYolubDKN1S/sRBfGJO
         tjdzE4BuTnv6WkixDYxB4ih2sGBBbfKZKuC1DtQMjVkw5+Pxjw6cfax0gGuzAKDuBO/u
         uSDWh5L6NJVAwqWkilTyar7Ac9or0SSPqr3vKkYpGY7Y3dFJc/z53xw9l0jb7B+upn3j
         SMHMAP7X/cohhZX7vXblwAnYypuB+PioUGyEx4fqBY1eSO3pBbeNyT9VIjOPJeEpZZMy
         DvHg==
X-Gm-Message-State: APjAAAU2OPYwwxG/m1Q5CECQHffgE38QrLGW456uAyjybSCoH9AQcV+z
        wPk0UcOVz87pa0/CLuj6Xe6m1Mmb
X-Google-Smtp-Source: APXvYqy2FoZdbMP3MlyZBei/mdIRMsEtV+f+coU/wg1cnkaOsBpzXbJlIp4Pl4ex9y1gLfrAncXE7A==
X-Received: by 2002:a62:7c47:: with SMTP id x68mr9000637pfc.178.1569407225294;
        Wed, 25 Sep 2019 03:27:05 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id 8sm4357377pgd.87.2019.09.25.03.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 03:27:04 -0700 (PDT)
Date:   Wed, 25 Sep 2019 03:27:03 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Allan Caffee <allan.caffee@gmail.com>,
        Noam Postavsky <npostavs@users.sourceforge.net>
Subject: [BUG/PATCH 2/5] t4214: use test_merge
Message-ID: <4a93deb3f62088b9bdb615adfb126581659914b4.1569407150.git.liu.denton@gmail.com>
References: <cover.1569407150.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1569407150.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous commit, we extended test_merge() so that it could
perform octopus merges. Now that the restriction is lifted, use
test_merge() to perform the octopus merge instead of manually
duplicating test_merge() functionality.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4214-log-graph-octopus.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index dab96c89aa..f6e22ec825 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -41,8 +41,7 @@ test_expect_success 'set up merge history' '
 		test_commit $i $i $i tag$i || return $?
 	done &&
 	git checkout 1 -b merge &&
-	test_tick &&
-	git merge -m octopus-merge 1 2 3 4 &&
+	test_merge octopus-merge 1 2 3 4 &&
 	git checkout 1 -b L &&
 	test_commit left
 '
-- 
2.23.0.248.g3a9dd8fb08

