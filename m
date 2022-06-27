Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD230C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 23:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbiF0XUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 19:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241766AbiF0XUX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 19:20:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5598A24091
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 16:20:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e28so9951770wra.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 16:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BxY3LF83wgNGjpK2zPazu4z9IGR7cWNHVrVfQfTF7Ek=;
        b=f3lDwZkQ/n7ogYzMY0iXAlHl3+dBVF/CZhIgAuUJ74PNxede1B8DM4N12N07qjXVwe
         tvuOUbUrxM/PPW6v/BHMSe45iGf67CuweSkgnkzWLAjxxs5Ow+4ZIyhqTnO5xjYuzPvN
         xd+HnMw+Wwuupc0irWWV+qSsSXN1G8sFMeNb+CZB2/4BdAJ2KwO6cDRYnDo5SOFYtKLf
         L3RfOwZJwUftqcsPVArBQJrAiIraPn410EMFo8qzH4lA4ZrpkfYVt3n2+J9LWPLFXBP6
         Sd9JMx3L4Tp/NK+5nJVJHyCiCIAkZvdGSfIZb/zfTTGpi/B2Vzgd6MExHGnIAeYzrJ41
         prSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BxY3LF83wgNGjpK2zPazu4z9IGR7cWNHVrVfQfTF7Ek=;
        b=CTVulnTg038UWmA1iZyxtsYMqw/xgdwBsBadPajY+xybejwTz2DIzZp+kZtpFXRqeX
         QZ0/QWbhHv50Nj8FlrOv+o70FvHM1T6YuU+RT53RgzTutxb8zwGX0S7+3EFbsseus2LO
         FQhtZ+/rq4yGN6FKjIg8d9HHs23su+ZO6pEE1azJAQDlYPbaLkegaDY3h/x9gCLeEOJd
         IHwBAyu0Oj1x8t2N6yX+S9k0aWVXbR+62/w/BDiSyZfHxOgar7eg/RW7ZQgy9b8eN7r3
         jot9zVPrfYmn2w9rrrbR5r/OXi6pj7XUERWl9DzDDJisLbzFDt8qKKdjpAjkAJe1eWEi
         pYMw==
X-Gm-Message-State: AJIora8rWpdKJh8ftSCjajbPjLghu9NyQJkt+iv7rMnq+8HslEakYJf2
        Xi0vgaDvGp9U2tQZRjOzsrs0WHxzMVFztw==
X-Google-Smtp-Source: AGRyM1uLHJ0ql4ckorqIKWpRiGcyo2XYZuGrqqKBBRUdGT43m2srFIihE0kwcWrLnzm7RLMqAJZqSA==
X-Received: by 2002:a5d:52cb:0:b0:21a:3cc5:f5f4 with SMTP id r11-20020a5d52cb000000b0021a3cc5f5f4mr14728682wrv.367.1656372020660;
        Mon, 27 Jun 2022 16:20:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bs30-20020a056000071e00b0021bb9071374sm10242991wrb.53.2022.06.27.16.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:20:20 -0700 (PDT)
Message-Id: <618053730e1f0732fa5a56ffbaa123129eaa17ca.1656372017.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 23:20:14 +0000
Subject: [PATCH 2/5] submodule--helper: don't recreate recursive prefix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

update_submodule() uses duplicated code to compute
update_data->displaypath and next.recursive_prefix. The latter is just
the former with "/" appended to it, and since update_data->displaypath
not changed outside of this statement, we can just reuse the already
computed result.

We can go one step further and remove the reference to
next.recursive_prefix altogether. Since it is only used in
update_data_to_args() (to compute the "--recursive-prefix" flag for the
recursive update child process) we can just use the already computed
.displaypath value of there.

Delete the duplicated code, and remove the unnecessary reference to
next.recursive_prefix. As a bonus, this fixes a memory leak where
prefixed_path was never freed (this leak was first reported in [1]).

[1] https://lore.kernel.org/git/877a45867ae368bf9e053caedcb6cf421e02344d.1655336146.git.gitgitgadget@gmail.com

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 63c661b26a6..7a963a967b8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2401,9 +2401,9 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 {
 	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
 	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
-	if (update_data->recursive_prefix)
-		strvec_pushl(args, "--recursive-prefix",
-			     update_data->recursive_prefix, NULL);
+	if (update_data->displaypath)
+		strvec_pushf(args, "--recursive-prefix=%s/",
+			     update_data->displaypath);
 	if (update_data->quiet)
 		strvec_push(args, "--quiet");
 	if (update_data->force)
@@ -2497,14 +2497,6 @@ static int update_submodule(struct update_data *update_data)
 		struct update_data next = *update_data;
 		int res;
 
-		if (update_data->recursive_prefix)
-			prefixed_path = xstrfmt("%s%s/", update_data->recursive_prefix,
-						update_data->sm_path);
-		else
-			prefixed_path = xstrfmt("%s/", update_data->sm_path);
-
-		next.recursive_prefix = get_submodule_displaypath(prefixed_path,
-								  update_data->prefix);
 		next.prefix = NULL;
 		oidcpy(&next.oid, null_oid());
 		oidcpy(&next.suboid, null_oid());
-- 
gitgitgadget

