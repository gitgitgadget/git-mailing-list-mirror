Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EDFC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 08:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiGUIQs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 04:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiGUIQh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 04:16:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A917D1F9
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 01:16:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d16so1113594wrv.10
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UJOy9RRNI32Tpa2zF9+YdiUGBIaJj9d1+SEvkhyYRPQ=;
        b=MlJycEPxdi1t69H3GUDhsP2xcCLVGkWIkmW3cE2hh1uZd47APkSf+U212sbfHZJ8yw
         inxyP91QncSLx+JUk4XXKb6fULaip6eeXtcsHvffC4FCoALgnqWBSoqEaf5q1x95b4c1
         XjptQ9wVsc1HNrIUbM7ZHAtJif0XXXYR9mda9QVoYsvs36iMYFOBxavavS/5LdJViDjs
         aqyDGDCdnpx4ARiF8y8oPcl2984rnY5cODwWNa7SJnlvzBz+dcWcohfUCmgAeLnYjDq2
         4ArM7O1Ujebq67mGdtI+dOV/GL5l8uqAcsPW3xZ9MhEWol7mgm5+gox30jFlQylzVmu4
         VzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UJOy9RRNI32Tpa2zF9+YdiUGBIaJj9d1+SEvkhyYRPQ=;
        b=oDDDVUee11Kmdwa78wvtQ4QTEQmIb6Dz2nEWM8hqegGxRTcpUjeaSfp9gy3jxdB62K
         gXbGs7wb/tmrOAsZMFDUp/2zWTnwEqpqhcnJzQe7mpGHvaVIJDw6dyhWs+ABAwIjQ94B
         zjvXlxS1dZ/VqsdeTvyF0MeV+Rd7xTUud9ukTiqudq1xTbJ4X9Xb8n0tum6m9plq3HQ1
         MtnxTXFYju/LkPCj/XQp6YOZFttXt6aMy3p68rFnjHUhK8eqHdyrHpESejsjgufp86NV
         YhiTgA1vkANXDlqY4yjz1JSDcw8OAgD+EDe8n5vQOvv6HaKtiyTsCEu6a/KV0peTpvhv
         NJyA==
X-Gm-Message-State: AJIora+ZaMSMK1EEvwc4GvzlSpLwpzAnDQmGaunwdLR1FqhZYAdENHev
        WombeRuot9bvpldO4tuDPrlpjChYoE8=
X-Google-Smtp-Source: AGRyM1swvItQvWpjdmcAmzujK4aErbucPRSHgzTrvIUWKXCjMqrYAY5KJohjcSuGDebhOB/TvrgHEw==
X-Received: by 2002:a05:6000:1049:b0:21e:584f:3574 with SMTP id c9-20020a056000104900b0021e584f3574mr378405wrx.274.1658391394330;
        Thu, 21 Jul 2022 01:16:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k7-20020a7bc407000000b003a32251c3f0sm1077432wmi.33.2022.07.21.01.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 01:16:33 -0700 (PDT)
Message-Id: <e39b2e15ece14ba2b1118ae95e0d90ed60589b41.1658391391.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
        <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Jul 2022 08:16:25 +0000
Subject: [PATCH v3 1/7] merge-ort-wrappers: make printed message match the one
 from recursive
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When the index does not match HEAD, the merge strategies are responsible
to detect that condition and abort.  The merge-ort-wrappers had code to
implement this and meant to copy the error message from merge-recursive
but deviated in two ways, both due to the message in merge-recursive
being processed by another function that made additional changes:
  * It added an implicit "error: " prefix
  * It added an implicit trailing newline

Add these things, but do so in a couple extra steps to avoid having
translators need to translate another not-quite-identical string.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort-wrappers.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
index ad041061695..d2c416bb5c0 100644
--- a/merge-ort-wrappers.c
+++ b/merge-ort-wrappers.c
@@ -10,8 +10,13 @@ static int unclean(struct merge_options *opt, struct tree *head)
 	struct strbuf sb = STRBUF_INIT;
 
 	if (head && repo_index_has_changes(opt->repo, head, &sb)) {
-		fprintf(stderr, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
+		struct strbuf err = STRBUF_INIT;
+		strbuf_addstr(&err, "error: ");
+		strbuf_addf(&err, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
 		    sb.buf);
+		strbuf_addch(&err, '\n');
+		fputs(err.buf, stderr);
+		strbuf_release(&err);
 		strbuf_release(&sb);
 		return -1;
 	}
-- 
gitgitgadget

