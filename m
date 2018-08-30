Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A5841F404
	for <e@80x24.org>; Thu, 30 Aug 2018 20:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeHaAQu (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 20:16:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40217 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeHaAQu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 20:16:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id 207-v6so3221430wme.5
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 13:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iyGsuOUXB6Kwdc8uF5NUCsu+HB+pqs4AvzsS3xgO/ks=;
        b=R9JnW/2NFx1/w3imIlKnt3NO9vKHlFeoZOWpC/OcGvMGPgyO6T4BdtZZMdUyAe5IUY
         VIBhPpa2U9jSarQGxXK5qc7G3VVjpcXHt7xrv28Sn2PmKjmvTR5vPK9dj+wrkKHcC5+J
         rwCsZT0eGkPqzjT2l20gqfJPFM2US98ahxbIJziX4U0LUVvaGDpMxJRsecXmN1kxTYGM
         LO5uLHckKT6/hls0xWhwynmrFtRO2o4Kd9FB8/KltBf+t7BnP2CC226Xc5IUKFb7b135
         HOZtHP/Rk4TTcx7irv8GPqOFP+bLQpQlUwBx0t/5al+15/kitXEvDu+cuIicEaWrdn6J
         oYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iyGsuOUXB6Kwdc8uF5NUCsu+HB+pqs4AvzsS3xgO/ks=;
        b=QpVlp7k5+jzY5xLH8wai5rlUNYfvGYW2mCZcQnYa4rgAylkS7sPYxJkgpOpG91gIlh
         JwPVK/Eu98A4IzZ3L2C/peUPGX6CfMIjJXVC3OrJnep4GeamvR9toPhMxpqNnUnoMRxm
         MfW23qXmUV22g5vk696S1zLbvg99kvo0P51iux8QvHUij+tFJ/5KNXOAmugqksdVmK+O
         RohUCnttqqZVMzKfjZRVsgGSEjesZYquSffxbkqiskLZK4CcWi8sYWVLLoH9ikqPxeVS
         ua8UoTeE4qjoSM7Loxoeijs917E4RLrss2liwVAmKGf0qzL4XxOJSr+bTtrt7rfT8SeY
         0Y2A==
X-Gm-Message-State: APzg51BUzrIxNc0hNDSibTp5RQmIHBJZPxYszGU54+y2oE6cXiCU4r/1
        kREZSU6h+ZZaAWcdJIqeVP6utqln
X-Google-Smtp-Source: ANB0VdYKQcJ+8uVX0SASak91NgBYk24+ZafATjFY+/0Q6PNDnrxzWrJ/uFpbgAw4JN2c14BRosj3NA==
X-Received: by 2002:a1c:7d51:: with SMTP id y78-v6mr2706992wmc.37.1535659975968;
        Thu, 30 Aug 2018 13:12:55 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b10-v6sm4903639wrr.88.2018.08.30.13.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 13:12:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/6] fetch: change "branch" to "reference" in --force -h output
Date:   Thu, 30 Aug 2018 20:12:39 +0000
Message-Id: <20180830201244.25759-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180813192249.27585-1-avarab@gmail.com>
References: <20180813192249.27585-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The -h output has been referring to the --force command as forcing the
overwriting of local branches, but since "fetch" more generally
fetches all sorts of references in all refs/ namespaces, let's talk
about forcing the update of a a "reference" instead.

This wording was initially introduced in 8320199873 ("Rewrite
builtin-fetch option parsing to use parse_options().", 2007-12-04).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 61bec5d213..b0706b3803 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -114,7 +114,7 @@ static struct option builtin_fetch_options[] = {
 		 N_("append to .git/FETCH_HEAD instead of overwriting")),
 	OPT_STRING(0, "upload-pack", &upload_pack, N_("path"),
 		   N_("path to upload pack on remote end")),
-	OPT__FORCE(&force, N_("force overwrite of local branch"), 0),
+	OPT__FORCE(&force, N_("force overwrite of local reference"), 0),
 	OPT_BOOL('m', "multiple", &multiple,
 		 N_("fetch from multiple remotes")),
 	OPT_SET_INT('t', "tags", &tags,
-- 
2.19.0.rc1.350.ge57e33dbd1

