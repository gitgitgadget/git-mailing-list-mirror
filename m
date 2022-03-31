Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F0EC433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 18:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbiCaSwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 14:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237130AbiCaSvy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 14:51:54 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4582C16E7CD
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 11:50:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i4so1041599wrb.5
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 11:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=s/5sKTsNwfsMmBsHaFDfuEBmde29MN+fEcM7qT9Uqp4=;
        b=SP4Q8cm7Z02JeBRWT6rfbGILbELEu2OcIKZUPh8af06y1LCk/0piPLc01v4bHLjRH6
         e0qwoiyss13KA56583W9A+7ji5lhDOJbySThAHRQ7PylZK3IAMRca0tQckOW7re8ykOx
         7RiDGZ9E32xz4aFZfhX8MgTi8a4LoIEDumKZGDhSH0iq5rD7O4LddJmWaJmp9SeX92lJ
         SYrTeU71kRzaoB1uCKHSsDAM7Ed6wviYPzeJdaZb0wcKJNHRN83QD7NEPROk0Qph4mh3
         LjQi/TLCRMYnuLULz9z2gBtDeX5wwtBMAV/E/KSa/+BqQtN8rzqTfJdtG6SGiw10/fHP
         vEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=s/5sKTsNwfsMmBsHaFDfuEBmde29MN+fEcM7qT9Uqp4=;
        b=vqundBJpPnqbJDs+FO/ZweDQrfeOXfbGwIM5CgBDD4mb3qtSgUYI1oa3zHS3/VIME+
         ZSmO3O6LL/Mrjjl9v3pL9E+mgg7iFr77evJNc+dLiQWnt9H/PCH+lfR8EC3m8L7elIjk
         y9QZHjYLbWbgIotI73La+aA4HLtkrXcpbbbUKcORjJ0nO0PhVVRlfud2xz4kb5YHycvg
         iPAhONPxgaWYl/P6AnA0m1EwJImTbWFR9a1X1deZIyuTmJ1SkPxVrFXK/WQ+8dOFq6qb
         fub9lUbk8wLUupBzlfLV1filBkt4Hjbn2WbKJzRL+QJ4hcI4GcRzrQMJxtfuppRm84eT
         AJfg==
X-Gm-Message-State: AOAM530Yp5p++1JrV7qFyk3APKbNFs1CHoSpoAxdz7CxLroNVbgANUIC
        +Mt9MLGAfbhpwXfqgss1qFDq4qfNFUI=
X-Google-Smtp-Source: ABdhPJyk7Ag4PknY4TG1tYCxAZgscaPE0swWGJquGAgTXGL/mGuiqCmQMYtN2IOy03LmDLtKRuZmOQ==
X-Received: by 2002:a5d:66ca:0:b0:203:fb72:a223 with SMTP id k10-20020a5d66ca000000b00203fb72a223mr4982587wrw.12.1648752605606;
        Thu, 31 Mar 2022 11:50:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5-20020adfef85000000b00205b3945fdasm172279wro.92.2022.03.31.11.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 11:50:05 -0700 (PDT)
Message-Id: <64d9b8e0f444a7191c83a69b943c95631270ff5b.1648752601.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1190.v2.git.1648752601.gitgitgadget@gmail.com>
References: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
        <pull.1190.v2.git.1648752601.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 31 Mar 2022 18:50:00 +0000
Subject: [PATCH v2 3/4] branch --set-upstream-to: be consistent when advising
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

"git branch --set-upstream-to" behaves differently when advice is
enabled/disabled:

|                 | error prefix | exit code |
|-----------------+--------------+-----------|
| advice enabled  | error:       |         1 |
| advice disabled | fatal:       |       128 |

Make both cases consistent by using die_message() when advice is
enabled (this was first proposed in [1]).

[1] https://lore.kernel.org/git/211210.86ee6ldwlc.gmgdl@evledraar.gmail.com

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 branch.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/branch.c b/branch.c
index 1252b17b980..ca7f0c3adf8 100644
--- a/branch.c
+++ b/branch.c
@@ -388,12 +388,10 @@ static void dwim_branch_start(struct repository *r, const char *start_name,
 	real_ref = NULL;
 	if (get_oid_mb(start_name, &oid)) {
 		if (explicit_tracking) {
-			if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
-				error(_(upstream_missing), start_name);
-				advise(_(upstream_advice));
-				exit(1);
-			}
-			die(_(upstream_missing), start_name);
+			int code = die_message(_(upstream_missing), start_name);
+			advise_if_enabled(ADVICE_SET_UPSTREAM_FAILURE,
+					  _(upstream_advice));
+			exit(code);
 		}
 		die(_("not a valid object name: '%s'"), start_name);
 	}
-- 
gitgitgadget

