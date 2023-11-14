Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B4326AE9
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXtSLmkD"
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4350C107
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:54:08 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7788f727dd7so365931185a.1
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699991647; x=1700596447; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AG46S1jgdc9M9daQ26TOOGr5yuGxoXVZ/FvR7gcs3AA=;
        b=mXtSLmkDxNlesBeV+OvjecIH8Hok5mvr1wkxeouiwCrPAT3j6nlhoqAyex/RCa8TYv
         mzug8Vb1VQGa5nazt+Mpj4oweSegtUud4XNATozEqbqH9xw1vjTr+qWGdxRA1x233Oyg
         c6x62SG8M+2wJe1Iujv+DnPSvZKjegCXpjPyMZAqeG/T/6jb3RJWSrnAMQA7uiJpILMu
         2tk46rg8icVZ/NX4sOrGEzThZ2HoDZtKts8eTCdxGwuHGULWLOZ4ulZURGcSZ51W7xbB
         LRGm+6JTvf6rhIehjl7MUuhsMESHxXDSE3crKRh/3HFHW+I+w/MRJmd2KD0tksia+pSf
         Hi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699991647; x=1700596447;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AG46S1jgdc9M9daQ26TOOGr5yuGxoXVZ/FvR7gcs3AA=;
        b=F/2Ea5joQCAxaBM7OineGy50x1wbJqz3BzDIAGmc0WlSLToVMH00t1ouspkE2xf77l
         LEaxOrpKpwTCBWUpNOUUI3xt9Yu1p0/n2f1EJSM44iIxYZFnpKbkdHY15YEzJX9eKPs1
         Ahatq2TFIHCuSffd8DroMukjRADOM+JeeIzPkQCxm2H5slsGSlt0l88JLoAmPnIzDEfn
         xkZgORbnBz4+gl3PR8i8XmA9b4Rdjz6cMeVwMHCzMfnlGolw8pIGDrEcaVWIe3x0Xys1
         am9LmN2/akxSIg7t8Lib5Br3ARCVWqlZUiMyMH6wFI1WuEucOQCzUWQKd+v51p7+cKdH
         lmdg==
X-Gm-Message-State: AOJu0YyLpeInrpjJYrbdQDoGKDlz1OqMmqL/q+7XFek/QZkuCqwUbvsn
	SfUBSh5MsE8+8Np/VPJ8+KJv03CrxB8=
X-Google-Smtp-Source: AGHT+IGXWLbCY0ZI8BHB6Ygr2LIw//lFtLVwb1V9PzU74Mhvd9uBdi4W3j11aKQRHj2SFwzYIAjnug==
X-Received: by 2002:a05:6214:5c5:b0:66d:b8bf:d9e8 with SMTP id t5-20020a05621405c500b0066db8bfd9e8mr3450715qvz.4.1699991647120;
        Tue, 14 Nov 2023 11:54:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ff18-20020a0562140bd200b00675497e5bf3sm3172880qvb.30.2023.11.14.11.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 11:54:06 -0800 (PST)
Message-ID: <f44c4b42c93983a8755dcc6da5146205c11ef422.1699991638.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
	<pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Nov 2023 19:53:51 +0000
Subject: [PATCH v2 03/10] ref-filter.h: move contains caches into filter
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Move the 'contains_cache' and 'no_contains_cache' used in filter_refs into
an 'internal' struct of the 'struct ref_filter'. In later patches, the
'struct ref_filter *' will be a common data structure across multiple
filtering functions. These caches are part of the common functionality the
filter struct will support, so they are updated to be internally accessible
wherever the filter is used.

The design used here mirrors what was introduced in 576de3d956
(unpack_trees: start splitting internal fields from public API, 2023-02-27)
for 'unpack_trees_options'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 ref-filter.c | 14 ++++++--------
 ref-filter.h |  6 ++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 7250089b7c6..5129b6986c9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2764,8 +2764,6 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 struct ref_filter_cbdata {
 	struct ref_array *array;
 	struct ref_filter *filter;
-	struct contains_cache contains_cache;
-	struct contains_cache no_contains_cache;
 };
 
 /*
@@ -2816,11 +2814,11 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 			return 0;
 		/* We perform the filtering for the '--contains' option... */
 		if (filter->with_commit &&
-		    !commit_contains(filter, commit, filter->with_commit, &ref_cbdata->contains_cache))
+		    !commit_contains(filter, commit, filter->with_commit, &filter->internal.contains_cache))
 			return 0;
 		/* ...or for the `--no-contains' option */
 		if (filter->no_commit &&
-		    commit_contains(filter, commit, filter->no_commit, &ref_cbdata->no_contains_cache))
+		    commit_contains(filter, commit, filter->no_commit, &filter->internal.no_contains_cache))
 			return 0;
 	}
 
@@ -2989,8 +2987,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	save_commit_buffer_orig = save_commit_buffer;
 	save_commit_buffer = 0;
 
-	init_contains_cache(&ref_cbdata.contains_cache);
-	init_contains_cache(&ref_cbdata.no_contains_cache);
+	init_contains_cache(&filter->internal.contains_cache);
+	init_contains_cache(&filter->internal.no_contains_cache);
 
 	/*  Simple per-ref filtering */
 	if (!filter->kind)
@@ -3014,8 +3012,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 			head_ref(ref_filter_handler, &ref_cbdata);
 	}
 
-	clear_contains_cache(&ref_cbdata.contains_cache);
-	clear_contains_cache(&ref_cbdata.no_contains_cache);
+	clear_contains_cache(&filter->internal.contains_cache);
+	clear_contains_cache(&filter->internal.no_contains_cache);
 
 	/*  Filters that need revision walking */
 	reach_filter(array, &filter->reachable_from, INCLUDE_REACHED);
diff --git a/ref-filter.h b/ref-filter.h
index d87d61238b7..0db3ff52889 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -7,6 +7,7 @@
 #include "commit.h"
 #include "string-list.h"
 #include "strvec.h"
+#include "commit-reach.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -75,6 +76,11 @@ struct ref_filter {
 		lines;
 	int abbrev,
 		verbose;
+
+	struct {
+		struct contains_cache contains_cache;
+		struct contains_cache no_contains_cache;
+	} internal;
 };
 
 struct ref_format {
-- 
gitgitgadget

