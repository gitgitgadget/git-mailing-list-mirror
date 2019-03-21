Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EFBC20248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfCUNS5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:18:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42779 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfCUNS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:18:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id r15so4264470pfn.9
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ZQQRHn9XK8rrnoxSr4h+Ki5RAY/Pc5VbFRPJCzdYuY=;
        b=G9mPlMT0I0huu3fQkdx+oMWCVbtg/wl3OcOyOmmP59jU6yIdPV8Zja3+vIGA8UkJaY
         TzGfIO8oKTPiLgZU6spUHDixA1yH2gNjBBlo8pj1X7VPSwj5iE3bhICcBLcPn9wxcKD7
         In1BRYTm+elBCly/1NdVw/7X5WSVy5H/Ui8CC4Xy5l31yEMlExePJSZ/I54HRreZirkJ
         pczJ+mo55KnJKL4LED1dorObE9hNZqm2Kjdl3VdKfkAomMOZxSp4Wob7Ap868KZJqRkR
         xtXwaurV+1N1mOHJ6ltLbgr7dxMbnAR3Dz8bCIEEmqG9a3DFfhYCMee5ViKsW4nh6k0y
         ooKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ZQQRHn9XK8rrnoxSr4h+Ki5RAY/Pc5VbFRPJCzdYuY=;
        b=fkKrF1GuoF9CjYLvCtMHtjCxr6MisyV1nVsBML6CI/iMjbht2jYx2yo9eL85DC8l0V
         tKTT2CS2qpW7ExFXkfIoq57NCMLTYyuFbJALeHzWr5ZvyA0IIeCjwrr/C63+8J77DzEe
         UQrCUHwqhnOO6Fmt/bfNMP2AfIjVliFROtPmsqHR4z9vZUhpiWAk9RN6c1VUinW8la7L
         A4qjXcVT0ETkFsI1iykRC+qLrrWElapuzh1vkR3M3frRpsRYL/CxoUmjK9N9jIegBUbx
         i3acGkvCs3hc3oft0XWk4KopjlHTuDlvZtL/mxACjmw0/WWsKRHfnVcPnahr32W+26C4
         wDkw==
X-Gm-Message-State: APjAAAWbhmvzFi1My7JRtKHjJqYATqh+FFWmk2wvzLWtMkQVRiU6dOqT
        NViyWcoBmMHU/YGYqw9nkNc=
X-Google-Smtp-Source: APXvYqx1Axm3Edn0rhQ2v9Pg176nKI1JmKQU3KoMNy8+LF9U+hZ2UtLpTjL5L2ZGPOvtPe819li0pw==
X-Received: by 2002:a17:902:758f:: with SMTP id j15mr3525447pll.211.1553174336086;
        Thu, 21 Mar 2019 06:18:56 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id k3sm14671761pfc.59.2019.03.21.06.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:18:54 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:18:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 15/26] switch: remove -l
Date:   Thu, 21 Mar 2019 20:16:44 +0700
Message-Id: <20190321131655.15249-16-pclouds@gmail.com>
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

This option is ancient. Nowadays reflog is enabled by default and
automatically created for new branches. Keep it in git-checkout only.
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index bd94b04303..85fc60f5f2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1376,7 +1376,6 @@ static struct option *add_common_switch_branch_options(
 	struct checkout_opts *opts, struct option *prevopts)
 {
 	struct option options[] = {
-		OPT_BOOL('l', NULL, &opts->new_branch_log, N_("create reflog for new branch")),
 		OPT_BOOL(0, "detach", &opts->force_detach, N_("detach HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
@@ -1579,6 +1578,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			   N_("create and checkout a new branch")),
 		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
 			   N_("create/reset and checkout a branch")),
+		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
 		OPT_END()
 	};
 	int ret;
-- 
2.21.0.548.gd3c7d92dc2

