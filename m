Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9940820248
	for <e@80x24.org>; Sat,  2 Mar 2019 21:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfCBVTr (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 16:19:47 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:39722 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfCBVTq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 16:19:46 -0500
Received: by mail-ed1-f44.google.com with SMTP id p27so1183672edc.6
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 13:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ntsLNcW7Qdan+vF2vNzKouwZL6fi0k4ECtHeLvKgyUg=;
        b=oX1omNWkofi/Sb7gkC5u1Hyg6gBaNuDjbkWRHLuE3DHSeYrVNh83GFay6CRRZgQRid
         0orXqBMHmasivHZoSZU85a3ttP3lkABPwsrYu/xRsfXlwH8DNvnOg/NstsxlC5+2vFZH
         gqAlS/Wm+zMsFRw9AvvMUypBit37geoKzggmtpvi4Yo1FLxkkj7PQKB0a+Zyw/1XWyOO
         f3+1I67BdAmgaz8mei1Opb4jbwoWOX0szsTRMJxSV/9XYGNvKIXwMbJKNW7pxUluAS39
         44LP5PhGw4WcqMHQgGTqE32c5ovszWNj5NBfI3fmi6z/h2iOQexw4Sv4MKeZuSsJoeOr
         UKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ntsLNcW7Qdan+vF2vNzKouwZL6fi0k4ECtHeLvKgyUg=;
        b=tOPgqgmNiLXxcEuZCcw2QqeCQnvjpCT/t5fhfsglzboPxwt0ChivtN+k+aOcDtu8xi
         QatE0Se5ajCP5/byRn8YULmLfhakr2S4+0s/70BKTXKcM4dwFwTAjRETQsjU4S6HkMtn
         zQld5qWtIweBmhQnejNyqHCpKajYcqSyK3A5RGMg6fQ+W3SNH1reE1lcSlX32S9lAirq
         qK+MG136iZKORQdlhJc6RKkcDxzjTsEBfU3US4R+7Xb3M3Hzr6FL0uSM3kd94G064MuZ
         Oxq3aOnpgcP+vQ9QNEFOuNpMc/BXg+lfsAcvIcyOuEkVVmhiuElCw3zeAeSzyeM6SSO3
         p66Q==
X-Gm-Message-State: APjAAAXCcQp33fRIsru45bkf1LwzRhdPitbxPGYFIMOOszCuCSUYF9Ph
        KogtOf5cQSTupl5n4WWprnXBYIvC
X-Google-Smtp-Source: APXvYqzuZEVT59ldG5aLLmuDs3GnWog1r+fyNGkQceS6Z4XAa2n3Gx70BXZh1mJRd8vsyS5DKxNdaw==
X-Received: by 2002:a50:9714:: with SMTP id c20mr9228543edb.211.1551561584150;
        Sat, 02 Mar 2019 13:19:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x34sm644469edm.70.2019.03.02.13.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 13:19:43 -0800 (PST)
Date:   Sat, 02 Mar 2019 13:19:43 -0800 (PST)
X-Google-Original-Date: Sat, 02 Mar 2019 21:19:41 GMT
Message-Id: <16c6508c4b38933945126ffe27445c999aa3e59e.1551561582.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.155.git.gitgitgadget@gmail.com>
References: <pull.155.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] tests: let --stress-limit=<N> imply --stress
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It does not make much sense that running a test with
--stress-limit=<N> seemingly ignores that option because it does not
stress test at all.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4e7cb52b57..ab7f27ec6a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -153,6 +153,7 @@ do
 		esac
 		;;
 	--stress-limit=*)
+		stress=t;
 		stress_limit=${opt#--*=}
 		case "$stress_limit" in
 		*[!0-9]*|0*|"")
-- 
gitgitgadget

