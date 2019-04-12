Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 398FF20248
	for <e@80x24.org>; Fri, 12 Apr 2019 12:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfDLMAj (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 08:00:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32962 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbfDLMAi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 08:00:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id d55so7302885ede.0
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 05:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HPcFO45vxtPULRTBA3PXeRbOkzEFzKMHoMsROfDBHok=;
        b=rvi0BZ2aJBAmOWUg9FR4D5rLbLIb0paLCnMcm+eXKOjAUUp1kRhzayKeFxgyml4FPX
         VU5i6mT3XbUasy3dAXFtBqqrqA4irsBA0yhn8HptX81nWouerscJlkaMLEozKmaEQRGT
         03/O7Zk0dnLrfwRiV80QjzKD/fZ7VTO7chJu8oonjZ7nuAs1PApKqwAoucQpEs/EWTFo
         gq0KNxxYUuc53WKdZdXruLwlIrkuFeuyqfdTTZQXLsyvnJONq6V7n8+HMMcoPXNLxaFl
         a/NiMK/HtHTJWYSNypA3b2lEg9+E7mvWJgNhI/sgiK05CyueKMFmY5YJN7FEyjowEGfS
         WQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HPcFO45vxtPULRTBA3PXeRbOkzEFzKMHoMsROfDBHok=;
        b=F6FBvcvemOjsRIEYn8urCvLqHnlQHWlnTR8kWN13SDi/ROJrSk70stokysKVxc5dws
         Ukuk//KLRQaYdX6PnXFFU6Ndn5g8atYmvi2iLm+8OmXLIGr8pQgXu9QPephD+VmPly3G
         AyI6VibnhsQglhb4LKeoHnHCVFXTb7FdRk6W+bbVMBwf3Y/D2Pbw6WDZBdV/C36gFzzg
         D68RY4PKb/QUOI+Q3obLHMWFd5NC4pV6xmjDnPsnmz9JQbApnQHB04RSkGibXLVjO42q
         dLSftPFa5levfV2m5mjWVWPeepBx990DsHifkur+bmwr4UxFgisrOfEzm8d9EJ73guxZ
         CdcA==
X-Gm-Message-State: APjAAAVN3CO2Cv3yEvtmsM4DIgxc9IZyYoox1A53YYRdErOvzJxXT/Di
        N+FhLCi6HFGK/FUqbI6H8TxbUIC4
X-Google-Smtp-Source: APXvYqwSUfPXpX5N6Wgo7NUYhCCrQ9b45ntNzqYwHMoE/LZitLjToiEfSB35Jk6J3T8IUo2g2dPlng==
X-Received: by 2002:a17:906:708d:: with SMTP id b13mr31438627ejk.120.1555070436062;
        Fri, 12 Apr 2019 05:00:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l26sm5049789ejr.82.2019.04.12.05.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 05:00:35 -0700 (PDT)
Date:   Fri, 12 Apr 2019 05:00:35 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 12:00:28 GMT
Message-Id: <fb3daa6427595b1df24d3664212a704da171c95e.1555070430.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.168.git.gitgitgadget@gmail.com>
References: <pull.168.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 5/7] check-docs: do not bother checking for legacy scripts'
 documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the recent years, there has been a big push to convert more and more
of Git's commands that are implemented as scripts to built-ins written
in pure, portable C, for robustness, speed and portability.

One strategy that served us well is to convert those scripts
incrementally, starting by renaming the scripts to
`git-legacy-<command>`, then introducing a built-in that does nothing
else at first than checking the config setting `<command>.useBuiltin`
(which defaults to `false` at the outset) and handing off to the legacy
script if so asked.

Obviously, those `git-legacy-<command>` commands share the documentation
with the built-in `git-<command>`, and are not intended to be called
directly anyway. So let's not try to ensure that they are documented
separately from their built-in versions.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a5212c64bf..caa20923a4 100644
--- a/Makefile
+++ b/Makefile
@@ -3074,7 +3074,7 @@ check-docs:: Documentation/GIT-EXCLUDED-PROGRAMS
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
 		git-merge-resolve | git-merge-subtree | \
 		git-fsck-objects | git-init-db | \
-		git-remote-* | git-stage | \
+		git-remote-* | git-stage | git-legacy-* | \
 		git-?*--?* ) continue ;; \
 		esac ; \
 		test -f "Documentation/$$v.txt" || \
-- 
gitgitgadget

