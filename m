Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750B7C04A95
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 18:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiIWSzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiIWSzb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 14:55:31 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF7A107582
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:55:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id y5so1337158wrh.3
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=tQxBWPWflkWS44dRHvnk1VbOleVWaGQKFc7Rjod28Hw=;
        b=Id6/s3oWJEW9fF2TU2a7CqfSCY1SVMlXARVIiz8Vlr8nJY1OQsh43pfrW+iHEG1BxE
         vKNToyEyLr/A7aob302jPnb+fvDBF979sczrQzdaSntZDNihp7E9mUN3WSpKAQRsnCHT
         YqrNgzvJ5Oj8XdgFqtRxLkxjGUPakDYp+lKGgy1VgTxKCI9svdat9zDs/OTOK/lZ3n5M
         4yiYBkT+D1GUQazjMrUSM2s2FRIvIoxfLpuk1bceVT11EkAnk2a6BBBfPEHLHlrfQaE4
         XMlJpg3pL9+e2qdaHFid7baWZyi7QVcbwQ9z0kqeiV93o41RcnXkEBy9AxJhDtMJBP/g
         yDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tQxBWPWflkWS44dRHvnk1VbOleVWaGQKFc7Rjod28Hw=;
        b=QZKmGoHiR4CnQObsitModNMI+McXYuAq2tt9Y7yocRRmF/DvlYHunjJ0xy7iTIjYeG
         SeCip7ECp67N+nvx+2kyJfAwyl2ymAWKrpsLZ3xt1kytXlA5WrLIl2ibXdtYKXOgLObe
         ohAcNXWPkmcxBeCQAilo96Gpz8Dcf8QQmbYWa+7kxtG0R74wFP4qdNUG/R0pU1qVM5vH
         jXP3NogKhmm2+BMs//HQjFk4X+OjdgxGilLlACrcJjrn4yUHzhqozW1WF065JZ5TFnta
         JCAcDJnOkppspFKRvxJtPs2cFBg4ZMt9mIaPNsjhLE0DJZ5jhb1NdK2vfXJHN0VzbffH
         OSHg==
X-Gm-Message-State: ACrzQf11zJVq0rD4RRtc6x0CIABVrf+CYgb/8x6wW+TO2qEY8rChiSiT
        iaQ+SR4M2QJ3KnccnO6WZQL1AK/mQMw=
X-Google-Smtp-Source: AMsMyM67LOBXQzjUnYDpUk5fw8FG+0pC9yQbsq0vqx/ydFEeN1roPNIzVVxbty01OWQGghxiN2NJlw==
X-Received: by 2002:a5d:4571:0:b0:22a:bc4c:3c24 with SMTP id a17-20020a5d4571000000b0022abc4c3c24mr6207498wrc.254.1663959328582;
        Fri, 23 Sep 2022 11:55:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c5444000000b003a5c7a942edsm3218876wmi.28.2022.09.23.11.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 11:55:28 -0700 (PDT)
Message-Id: <54e559967df55ca314e629b65927a88c7f804a98.1663959324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
From:   "Chris Poucet via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Sep 2022 18:55:17 +0000
Subject: [PATCH 03/10] ref-filter: add the metas namespace to ref-filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christophe Poucet <christophe.poucet@gmail.com>,
        Chris Poucet <poucet@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chris Poucet <poucet@google.com>

The metas namespace will contain refs for changes in progress. Add
support for searching this namespace.

Signed-off-by: Chris Poucet <poucet@google.com>
---
 ref-filter.c | 8 ++++++--
 ref-filter.h | 4 +++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index fd1cb14b0f1..6a1789c623f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2200,7 +2200,8 @@ static int ref_kind_from_refname(const char *refname)
 	} ref_kind[] = {
 		{ "refs/heads/" , FILTER_REFS_BRANCHES },
 		{ "refs/remotes/" , FILTER_REFS_REMOTES },
-		{ "refs/tags/", FILTER_REFS_TAGS}
+		{ "refs/tags/", FILTER_REFS_TAGS},
+		{ "refs/metas/", FILTER_REFS_CHANGES }
 	};
 
 	if (!strcmp(refname, "HEAD"))
@@ -2218,7 +2219,8 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 {
 	if (filter->kind == FILTER_REFS_BRANCHES ||
 	    filter->kind == FILTER_REFS_REMOTES ||
-	    filter->kind == FILTER_REFS_TAGS)
+	    filter->kind == FILTER_REFS_TAGS ||
+	    filter->kind == FILTER_REFS_CHANGES)
 		return filter->kind;
 	return ref_kind_from_refname(refname);
 }
@@ -2435,6 +2437,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 			ret = for_each_fullref_in("refs/remotes/", ref_filter_handler, &ref_cbdata);
 		else if (filter->kind == FILTER_REFS_TAGS)
 			ret = for_each_fullref_in("refs/tags/", ref_filter_handler, &ref_cbdata);
+		else if (filter->kind == FILTER_REFS_CHANGES)
+			ret = for_each_fullref_in("refs/metas/", ref_filter_handler, &ref_cbdata);
 		else if (filter->kind & FILTER_REFS_ALL)
 			ret = for_each_fullref_in_pattern(filter, ref_filter_handler, &ref_cbdata);
 		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
diff --git a/ref-filter.h b/ref-filter.h
index aa0eea4ecf5..064fbef8e50 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -17,8 +17,10 @@
 #define FILTER_REFS_BRANCHES       0x0004
 #define FILTER_REFS_REMOTES        0x0008
 #define FILTER_REFS_OTHERS         0x0010
+#define FILTER_REFS_CHANGES        0x0040
 #define FILTER_REFS_ALL            (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
-				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
+				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS | \
+				    FILTER_REFS_CHANGES)
 #define FILTER_REFS_DETACHED_HEAD  0x0020
 #define FILTER_REFS_KIND_MASK      (FILTER_REFS_ALL | FILTER_REFS_DETACHED_HEAD)
 
-- 
gitgitgadget

