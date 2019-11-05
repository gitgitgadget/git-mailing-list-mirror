Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58E831F454
	for <e@80x24.org>; Tue,  5 Nov 2019 19:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390946AbfKET0Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 14:26:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35072 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390783AbfKET0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 14:26:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id l10so22838326wrb.2
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 11:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J64/3+RHnkScbf8jA5PLMRJdNIxxRcwTluq8LaMiSss=;
        b=FOVY9e8PCUSjEdU6lDOX0UXRCe+mGstbbUoOfFLDk0EJB3opBplJOf8tja2POD4Piv
         g3w8FkiHD30kWmF6zBC4kxOLTACvR1yfS5OegbvBRgec5UHwLd4Aj7v4G4fygZMDEIfJ
         x2ZTSrDGIIOOJqJ7HeB6O7kiJpfFcc3oKCijfOxI1FiYNpVS1REjNxA6M2BmxVq+ydTk
         T+1+eEduCOG2FUyoXwpoHJk4L/3EqRpqjp8eNs3fVNsl3iPXzo/I7TLJTrt8tpKWMwl8
         0DE8GfWocEeQKRZ+zAyyTlsGqFF1gHRhCTckk9GHtvMKJfmTvPScDsnJA+k2TAMSOc+G
         rJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J64/3+RHnkScbf8jA5PLMRJdNIxxRcwTluq8LaMiSss=;
        b=B0Gc/M4RTPpWjk62vAttyiUOl5HC2OlycfXbjspYwm383XisrGb0rG6sxDe8lonTE9
         tEHeBjPv1BWU6Mi42C42OpKlRpZ24il/CNEwabJbzFhGJVbcERjCYu8YZn3Yv+L7X4Wj
         5ILde5N3GVmc1aXH1kZBrlgeRkC/+kYYE191WLcPRd42m9L6dbcObEwxF1En370/3cIU
         maC3xfIX3viHyO+8pHhwSUpiTeObJ7evY2OxSvtDa8DpDdIp7P0ZyzeOSFi7vV83+kym
         Oq5cU1jSXsljykzqa9k8UDfZK1Zt+IPuUNy3DMlQiA4jg5nAUyFCsn8FQdXnfM29I8iQ
         m61g==
X-Gm-Message-State: APjAAAU5ogW0W9vm0xd486RpPorJW9RK7Bl3A2csHTMN5uiVliLIxGHt
        dkFkA414GxvtbQJuzyttSIxRT9Cn
X-Google-Smtp-Source: APXvYqytBli9LfomCVA0qB+Cy1jv+6dxexU5sHtC/atGO437GQVU9q4mJBMVwE6xsObB/D1keD55XQ==
X-Received: by 2002:a5d:4c4e:: with SMTP id n14mr26017618wrt.260.1572981982889;
        Tue, 05 Nov 2019 11:26:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b8sm14692682wrt.39.2019.11.05.11.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 11:26:22 -0800 (PST)
Message-Id: <4fdbb9f504ee59e508b7df520f7890e29fbca7df.1572981981.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.451.git.1572981981.gitgitgadget@gmail.com>
References: <pull.451.git.1572981981.gitgitgadget@gmail.com>
From:   "Erik Chen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 19:26:20 +0000
Subject: [PATCH 1/1] fetch: add trace2 instrumentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Erik Chen <erikchen@chromium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Erik Chen <erikchen@chromium.org>

Add trace2 regions to fetch-pack.c to better track time spent in the various
phases of a fetch:

    * matching common remote and local refs
    * marking local refs as complete (part of the matching process)

Both of these stages can be slow for repositories with many refs.

Signed-off-by: Erik Chen <erikchen@chromium.org>
---
 fetch-pack.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 0130b44112..f2f3365bbe 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -666,9 +666,10 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 	struct ref *ref;
 	int old_save_commit_buffer = save_commit_buffer;
 	timestamp_t cutoff = 0;
-
 	save_commit_buffer = 0;
 
+	trace2_region_enter("fetch-pack", "mark_complete_and_common_ref", NULL);
+
 	for (ref = *refs; ref; ref = ref->next) {
 		struct object *o;
 
@@ -690,6 +691,10 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 		}
 	}
 
+	/* This block marks all local refs as COMPLETE, and then recursively marks all
+	 * parents of those refs as COMPLETE.
+	 */
+	trace2_region_enter("fetch-pack", "mark_complete_local_refs", NULL);
 	if (!args->deepen) {
 		for_each_ref(mark_complete_oid, NULL);
 		for_each_cached_alternate(NULL, mark_alternate_complete);
@@ -697,6 +702,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 		if (cutoff)
 			mark_recent_complete_commits(args, cutoff);
 	}
+	trace2_region_leave("fetch-pack", "mark_complete_local_refs", NULL);
 
 	/*
 	 * Mark all complete remote refs as common refs.
@@ -716,6 +722,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 	}
 
 	save_commit_buffer = old_save_commit_buffer;
+	trace2_region_leave("fetch-pack", "mark_complete_and_common_ref", NULL);
 }
 
 /*
-- 
gitgitgadget
