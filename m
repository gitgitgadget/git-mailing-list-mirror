Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 952F120248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfCUNTX (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:19:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45696 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfCUNTX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:19:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so4157753pgk.12
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZCwYhcwHp56n/ZwwHefjtOSYHLWFePFlPcIiMGSq9M=;
        b=oO+lS98Nk73K9Wvxz1/dC0d+eE1Rkqw2lncLb+UqWlaOviCQ3TzZFKCoFizPBynwBX
         Cbr/wMEBC9c21VjvSC7XJAMGWku6VqmyJHleIOdWNq7JZ0S4/WejeafHLXHkGhpdrQP2
         WdCO1e+Wsm2G6vg4tk5nHRVCvEGzKwkZdBDUCWCRUtme3YCAVCmGqInxtTKBt9eEYiFK
         QVQ26kWFaHQuDucAOgMUj8R6FTR3fPq7P4h2e0eW1vFj4cqxRp3apIBRRBd4m1qaGlwi
         vJms47K6NUxBfDh8X4SlglDm5W6uk54php2A6R/6NNORZfG+b8mgJfK3dOcikap/eM12
         3gWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZCwYhcwHp56n/ZwwHefjtOSYHLWFePFlPcIiMGSq9M=;
        b=XayO15Y5z6M6vGXIRyQnc43LmxlnT/GoNvSk2Y8TKsSVoxjJHUj52kYK5HVcY6HPZG
         Dv7NKps/tBwC4xDs3PBf+al+0rx3LJdcmnuxmwDfTrWHG7KEH4xj+cRNDdUpKN67vwQQ
         XXfTAsV9Xv3tQPn/hRW3HuaTrxSpf4xRDPU/MIVBl/UBhVKbCu7pcBOkpss1IDgIuTXG
         FsqHw8T4IXcWS2tVu4OXD3CON87Ff62r9V/pJkxtShhG8gDZsYV6LKdFBSNMG2sAkgAi
         XSC3pIM4mPyJG2kECAs2ZMz/IqhH8owYWT9eW8FiBer5AUm/p4ZUkbeAsbe44IEBlk8n
         E5vg==
X-Gm-Message-State: APjAAAVs8yik4wlo/2eGHu1uN4PL+QiuGVRu9ecHXelX0zrZVuHvGkYD
        YtyZbrfHIDTB757tzxXfr6s=
X-Google-Smtp-Source: APXvYqzC4zHodSQs5g4DhqqChWx8SZhvc7wMYKoVMmKH4pUH+ocEWEBPG4ZEYQ5ZMcSFMRt7ZzE0RA==
X-Received: by 2002:a62:1647:: with SMTP id 68mr3289423pfw.113.1553174362610;
        Thu, 21 Mar 2019 06:19:22 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id b18sm4135112pff.25.2019.03.21.06.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:19:21 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:19:16 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 19/26] switch: add short option for --detach
Date:   Thu, 21 Mar 2019 20:16:48 +0700
Message-Id: <20190321131655.15249-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190321131655.15249-1-pclouds@gmail.com>
References: <20190317124926.17137-1-pclouds@gmail.com>
 <20190321131655.15249-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git checkout" automatically detaches branches and --detach is not
that useful (--no-detach is more likely). But for "switch", you
may want to use it more often once you're used to detached HEAD. This
of course adds -d to git-checkout but it does not harm (yet?) to do it.
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d72e28aabb..a14133b474 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1423,7 +1423,7 @@ static struct option *add_common_switch_branch_options(
 	struct checkout_opts *opts, struct option *prevopts)
 {
 	struct option options[] = {
-		OPT_BOOL(0, "detach", &opts->force_detach, N_("detach HEAD at named commit")),
+		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
 		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
-- 
2.21.0.548.gd3c7d92dc2

