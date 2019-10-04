Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 593D81F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 00:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbfJDAXT (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 20:23:19 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:43445 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730969AbfJDAXS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 20:23:18 -0400
Received: by mail-pf1-f180.google.com with SMTP id a2so2764116pfo.10
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 17:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b2RmC2PkD4Im0MCF+4cgGaFqakeWJWmLQHLLk/go0Jc=;
        b=iCcuxosyMxqMqqpytPM9hG8lMXsxalpLHbVvHUT9fUyoccpLv1vEEqDK/5298oN7IU
         PmXIpwjWUJV04WV0h7RksuihZdpM58vsp4meapi6VdydeHzS0/XCR2cpm9EQAn76xmrX
         AL5mSyGJyajh8s5MNDP668V2Tw8oinxmmEeyjRwJCLFxnJ3gyE3WKx9x/pPMnLcyfILW
         Lod7mY/df7ksxurGmew03iBVJ+QrpCUsXeD5XTAcWS1lvFP4N+wwT/+o0Kh+wVWw0Agd
         ICpvRh8LKZbtZEruOHPCMX5t3iNi+9unkWSTeTOqj4B9SMMfcNZRmW4zC+SoIM16Hj6u
         ebeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b2RmC2PkD4Im0MCF+4cgGaFqakeWJWmLQHLLk/go0Jc=;
        b=F/2xslU7v4qqd5kIu5I3V8b6UYgPspFHMneqWcj4w9EhX/13aeDiiJ5IYpqM5L8pGG
         8O4qHPW9s437VETFMnfWU5OHwGP3jGW3chyz93q6E1Cc/elhLt3pPKXJBc8/ZDXgG2w5
         5IhXH/1HCrd7ryoobno4ZMiNhD3QpO0IZYpSB5IzLduwgBLWoUcD4EuaLAEiMqkD3/ve
         NchFgh1MnP+ejsFMo6gP5u57cYvyQKsUzO0F7zt55X7Wgjy/cGcok7JcgDYyP3TBxaO2
         a0MLbhY9PlUtI+u/WDXAGrPeV8jiLD2IVJARWLbgbVlLbF0JRU5tzb3hjAqSesD1qJk+
         PGTQ==
X-Gm-Message-State: APjAAAU66W4k7GZcLheUu8MPHoPXdF8R+ct7R0tZfeuPeMuzOExNebzA
        dZ9nfuqQeg8guCL8ry3P6khbm/mZ
X-Google-Smtp-Source: APXvYqzOiOskjFOlo2SqBV8/ltJ8sTpqizei6TM7gbJo3TLpuRXAIWqRRcq6Ix6vvOVlA9UpywUQsA==
X-Received: by 2002:a63:2647:: with SMTP id m68mr12210920pgm.338.1570148597491;
        Thu, 03 Oct 2019 17:23:17 -0700 (PDT)
Received: from generichostname ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id u5sm5449010pfl.25.2019.10.03.17.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 17:23:16 -0700 (PDT)
Date:   Thu, 3 Oct 2019 17:23:15 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Allan Caffee <allan.caffee@gmail.com>,
        Noam Postavsky <npostavs@users.sourceforge.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/5] t4214: use test_merge
Message-ID: <4a93deb3f62088b9bdb615adfb126581659914b4.1570148053.git.liu.denton@gmail.com>
References: <cover.1569407150.git.liu.denton@gmail.com>
 <cover.1570148053.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570148053.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
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
2.23.0.565.g1cc52d20df

