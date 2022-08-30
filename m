Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA98ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 18:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiH3Svb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiH3Suy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 14:50:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545CA52828
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bu22so15070973wrb.3
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=hsJ3WIRvkFCFc2sMpRSLvnIrzJJH4+C7f78sk3taGXM=;
        b=aUElGv+zLbDwRXcFKQ77W/vrokOBhKzYBnntcxSBtF3TUob7ClodkjMjtqkksXJdaM
         blHoxgYpHG7yIKJstQXhMG2Mpnm+LTaSSTRqlebo4b9gCDKnVvKH3OGEuBk/HXjHCnpx
         J+xwKi+GgOvSPPdaXtZcvBWwebmL5CNumjltUaiX1CXKw14R4DRXAs0o+8jPBndB0Hnt
         xVzqVXLTX/3Qm12fO8TfFDtT9TgMdx3/YpePc4Ba3kGmZ1sVS1QwEvfkIs+OD6/7ZP3r
         IsDRlS2r70vsbfvPrVk96K5Vhdk7the8aCD0+IDmIqI6GI6zhC2kekM5ZJdPwuTDzc+L
         7nVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=hsJ3WIRvkFCFc2sMpRSLvnIrzJJH4+C7f78sk3taGXM=;
        b=Z24obHJNQiRDo/iuE/LROmPV39Pz/G+kNaCqlSEXufCKlmpj6Gl+XPUS+3hXXeQJlS
         jJ8DTdnG1IH7muF/ISgr3xRlJjF37rnW/YRDucC9crajLWoAQwoiFUYFUlHm3tyjF4sE
         3jSEbRBXRP9maNHVCY5QdoRHgjsrhqrIYNAaYHZOaUqIaANz2JlaVusTnuxJyh+0fydi
         9KIe94I7MwC3Gz17rQxYlG3xvPA5Mngv3gLhLwnadr0PxK/QsPz1Z9f/gBmZQ8DEzePC
         8+fSJ2twOVpMdrCde4wBJkFxnIHX/vlvscqgHO/kILJ8ysjeA43jBcYiMZdWfZjpPr7t
         CvxQ==
X-Gm-Message-State: ACgBeo1/7fz2G8fO9s3w+iTJKuxXS5p+TjPNruDU5NHzXPmgn3sfUdqw
        cR0FpzhPacsaDb37eFwFbGOg0P23AJ8=
X-Google-Smtp-Source: AA6agR7CQP8odHMyZhCKXKK8IA3ACf6YPEGsFCFbNU7m8BoXN7JZD2DSiHydE6eCWj78DjDBNgNUrg==
X-Received: by 2002:a5d:64a9:0:b0:225:66ef:be9d with SMTP id m9-20020a5d64a9000000b0022566efbe9dmr9789393wrp.604.1661885438421;
        Tue, 30 Aug 2022 11:50:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k35-20020a05600c1ca300b003a5f3de6fddsm14464496wms.25.2022.08.30.11.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:50:37 -0700 (PDT)
Message-Id: <f2132b61ff7d7959fd8efcd9d416736b154718f0.1661885419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
References: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 18:50:18 +0000
Subject: [PATCH v6 15/16] bisect: remove Cogito-related code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Once upon a time, there was this idea that Git would not actually be a
single coherent program, but rather a set of low-level programs that
users cobble together via shell scripts, or develop high-level user
interfaces for Git, or both.

Cogito was such a high-level user interface, incidentally implemented
via shell scripts that cobble together Git calls.

It did turn out relatively quickly that Git would much rather provide a
useful high-level user interface itself.

As of April 19th, 2007, Cogito was therefore discontinued (see
https://lore.kernel.org/git/20070419124648.GL4489@pasky.or.cz/).

Nevertheless, for almost 15 years after that announcement, Git carried
special code in `git bisect` to accommodate Cogito.

Since it is beyond doubt that there are no more Cogito users, let's
remove the last remnant of Cogito-accommodating code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 46b65c91738..a8deabf9eb1 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -15,7 +15,6 @@ static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
 static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
-static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
@@ -880,13 +879,6 @@ static int cmd_bisect_start(int argc, const char **argv, const char *prefix)
 			strbuf_addstr(&start_head, oid_to_hex(&head_oid));
 		} else if (!get_oid(head, &head_oid) &&
 			   skip_prefix(head, "refs/heads/", &head)) {
-			/*
-			 * This error message should only be triggered by
-			 * cogito usage, and cogito users should understand
-			 * it relates to cg-seek.
-			 */
-			if (!is_empty_or_missing_file(git_path_head_name()))
-				return error(_("won't bisect on cg-seek'ed tree"));
 			strbuf_addstr(&start_head, head);
 		} else {
 			return error(_("bad HEAD - strange symbolic ref"));
-- 
gitgitgadget

