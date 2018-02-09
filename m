Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 585EE1F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeBILEJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:04:09 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34020 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeBILEI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:04:08 -0500
Received: by mail-pg0-f66.google.com with SMTP id s73so3400019pgc.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=61uHN6ld7HDCaXPSDtbnoz/Rb3VpCXE63TdFUu9tj3M=;
        b=p484S8JytKqlRX0pUgpqIGp6KJM2oU4XIVWoGqYbuf2CunLP+VqSmFFat+wzOrZXsk
         KAsDHOLk2aAftbyZTWOP5ewD8XncG6vCAcEn9FGO2lHCorzqkVnOuLGRCve1e7fh+ALK
         hBLLhNAd139Wpc4bku/xbZR+8dE5+UEZPNcYtsfbn7ploxahETOB2RUU6SYyi1Dax3wZ
         fiOzPrUKpZXQ1pS/4eVEEaodDvwmxNl73rLxmrJmO5gIb2xIHsplgILVig7ZolwsWiOd
         tg8SyyByzZ64LlhJDBntP2L/4KUbQ/ISNhj+qieTigyLqy2hCWbdMPjFWBq/n7qm2dEf
         kCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=61uHN6ld7HDCaXPSDtbnoz/Rb3VpCXE63TdFUu9tj3M=;
        b=rew02SzoRAmdMj5TMfP3/Py8EX1MjQggXth68lVAQ57My5uvp6TAZ7lf2yPLvj1EIx
         Sad1uKC22xb0pJRgdS7bpWQfi+w56WaaG6EoLMvY0RPZr44XbdWjDcGJdWTNf9Ixds6L
         PSHxidX2bg29fdF7Nwda4ceWi5SZejW00QCUjDxvZph4sIN/SjgbNMRmEh2WnK7AG2P8
         4QC/b5Xsf095i2SzGvPTOGSmpxi7phGdRfoKxuKQT0Q8IhifORWPQ19zxh4wGXxE1Q+P
         8RKrnNxbbBtLh2VISKZRhdAfyiu/MvMA+o+BPdcg+XTCv3qBcFmjcJg/Qrk36LcCxywQ
         qJ4g==
X-Gm-Message-State: APf1xPBVpn/WhnDxNrI4FOZ5jjfvC7X3B+hNsviIrMq+oQ7hTwS5LTAU
        +ilHB1+Cy6XWfzLkPDyhmOlx0g==
X-Google-Smtp-Source: AH8x224MLkpirXnEOPFZO0ynwe3l/jOPnt3K+Dre/RqLCNKUVFJLLM3g9cN0NiUmzlSirz64edFnPA==
X-Received: by 10.101.91.66 with SMTP id y2mr2132419pgr.11.1518174248058;
        Fri, 09 Feb 2018 03:04:08 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id j25sm8878500pfk.38.2018.02.09.03.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:04:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:04:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 17/42] completion: use __gitcomp_builtin in _git_fetch
Date:   Fri,  9 Feb 2018 18:01:56 +0700
Message-Id: <20180209110221.27224-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <20180209110221.27224-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
 <20180209110221.27224-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

New completable options:

--deepen=
--ipv4
--ipv6
--jobs=
--multiple
--progress
--refmap=
--shallow-exclude=
--shallow-since=
--update-head-ok

Since _git_pull() needs fetch options too, $__git_fetch_options
remains. This variable will soon be gone after _git_pull() is updated.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7763f88347..4275307c3d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1462,7 +1462,7 @@ _git_fetch ()
 		return
 		;;
 	--*)
-		__gitcomp "$__git_fetch_options"
+		__gitcomp_builtin fetch "--no-tags"
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

