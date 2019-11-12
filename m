Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0519E1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 10:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKLKih (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 05:38:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35637 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfKLKig (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 05:38:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id 8so2396490wmo.0
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 02:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u2AEGP1QPKiIhkCklSJxe5J+zHiFnypcWdV0DyTM6+8=;
        b=dI3pGwTqRxOsAAvPhy7+WOJC8LoqX5pefEV0V8YutRo/B32mLS4Vf22Lrko+IKOEZP
         DDt1sgURV+e6n10sORMCIuLsvN8vHsRdpLl2UEzGATvtVJQ/TJEAOqg0zIBTIw+6rRzd
         kjInC1pgzC3Mx6M8mwQ5+vJd5rWb3xQfDozJ77NytyuUP1MpbZLvERjgqZwUiyZCIqyX
         jpYNJ4Qf58hpqw8cRrNNhek6Lac1U8ScnNgaGyxEN3WkhkKulAv2lMbAsHG3zH3mTQXT
         Zy5n1AxX8J8nDHUnFMPex5MezlR3/AXk/zqYLDIEPEJdHyP36zLISTbaAry0tt2ksTsP
         NfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u2AEGP1QPKiIhkCklSJxe5J+zHiFnypcWdV0DyTM6+8=;
        b=SRbfGnikpuNa7pDA3T516sXdimOwk6Sr72MNGkMdDCdzhJICmvzsK6iKF/2MX+C/r5
         R5UTIfGNtuOKf/JhLeYoOWxxbUDSS3SshPYSvYcD+LJIJ+rS+rEuyqpkrfe8ZnSrHQ6y
         3AKNz9oMCzWZv8OdILDly7d2wzJJ2Ee1e/1Bgl/BNFLsgAHDsFzpeF8GU158wjf65NtV
         vkk2IB2V3BmSdHAtaXy6mRB2Npxd0wZndjmyO1lQFD/8Up4830aG0etf7+CIE7ESzgsb
         ZzBzpIgZskBCnPwnXkhap+UbtdXzxHSJt/SUvjfv//PUD4VupNuCz1VH9YCOAfxbHU28
         iNXw==
X-Gm-Message-State: APjAAAWrv2QAsgSs+2M7qlOBKbKCsy4rhDorRKiPRQhNSHqvP7v6MU6J
        Xqy0IfkMnNZXi7HmwQInZG8=
X-Google-Smtp-Source: APXvYqzpTCVSZQQZJF7WDyuog8apbcXSoHYe865cHHiQerESHhx+YZobvTUoTOCG3v6kjQ8nMNxdwA==
X-Received: by 2002:a1c:113:: with SMTP id 19mr3486612wmb.42.1573555114365;
        Tue, 12 Nov 2019 02:38:34 -0800 (PST)
Received: from localhost.localdomain (x4d0c65ae.dyn.telefonica.de. [77.12.101.174])
        by smtp.gmail.com with ESMTPSA id f24sm2313759wmb.37.2019.11.12.02.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Nov 2019 02:38:33 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 04/13] name-rev: avoid unnecessary cast in name_ref()
Date:   Tue, 12 Nov 2019 11:38:12 +0100
Message-Id: <20191112103821.30265-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.388.gde53c094ea
In-Reply-To: <20191112103821.30265-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20191112103821.30265-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Casting a 'struct object' to 'struct commit' is unnecessary there,
because it's already available in the local 'commit' variable.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 15919adbdb..e40f51c2b4 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -271,9 +271,9 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 		struct commit *commit = (struct commit *)o;
 		int from_tag = starts_with(path, "refs/tags/");
 
 		if (taggerdate == TIME_MAX)
-			taggerdate = ((struct commit *)o)->date;
+			taggerdate = commit->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
 		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
 			 from_tag, deref);
 	}
-- 
2.24.0.388.gde53c094ea

