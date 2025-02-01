Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89805BA34
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738392170; cv=none; b=WggWt9iMOaBAqLQDo443Hn//c6wXJ5iBZavfPIUCwQLtDnYu5rbrAUe0zBBOjnrhMSZJ30c2c9b6mg7qCijRZVM5BJRaoM8Hm44mWqN6cgMkBcKpDuZHnAJmjsQ/oF7s/mWDeFfb8QSGbYG7xpyUXpUyD4jHozU9BP4GfVgHcR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738392170; c=relaxed/simple;
	bh=M+ZyVYSBVPxPQXNw8GRFPvnS9/7hRNvMyX2F+ofKHPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PEbtXpJsu1udlam5E3cwp+hgp1PFj3n/2tjPQoE4RM32mFJ9BgVRayB8FF8UAfGorfKYBme6XrOehfwFGRZejnncacvYzerSqzKSPZJa9GKVy4Qro+zCRMnhOJLpQ8K4D3Exh198cpVtp5vqHLdBBR58ND6MsJrhWacGGm459T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ar9YBO/V; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar9YBO/V"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2165cb60719so50597995ad.0
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 22:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738392167; x=1738996967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPs+pVBrIP21zpkuhISs9jJHORFBB6K5p8XwuYzdVgw=;
        b=ar9YBO/VHJR7moFIPmUCP/aFIaeoptPTPY2vmbROtYGsw/cnYG7ND0L7KWhHProlLS
         6GZxFzYhxxPPccjaO41yjE7agQaQ3huweC/xQPnU5uR4v9P/iHZrXpyCxcF1d7S48zxY
         0fqkvs7EGZ+nhwxiBuuYlJUbFU0YV2Ny5bb6qJoTG0tqzUu7bTCnqqER0UgtjlSufTQA
         7MY/tNtBC4MHbFUKFMMpRoqG8FWEHpo7KWjpiTfHdQP1dZiZ+wRufUW//GD2rKukle2H
         yo/V2zvb6PQownMjB/GyitJXQFkcliD/RTY0m0UnJt4fvJUD0jLI4zsfmhWRZ75Fzyp6
         m0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738392167; x=1738996967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPs+pVBrIP21zpkuhISs9jJHORFBB6K5p8XwuYzdVgw=;
        b=r8soY4sYxRhxFkcm889vBPA/dAbNZHpsdVNS2QOO7dDhUt+Hj/v207txF98LydvwVE
         9L5drvcGyx9/ADy+BuEemxR5uYvFmebRXmRoz5j7wXTiOC0JNUxdLn/2Kpvmo0y9psyO
         8QdOwV5kMXQj3kQsZDvTFg8rRuQrG2pz5eMcxYwqsPzA8oB/t8NfNEnm5aZJVo6b2E0R
         AJAQyyiFwuwbay7Rlahl7iP4GiRNdJ2IPG71CABxmsGlqTTcTeZagxmRVjqF5KgC1iJP
         mPhms4Py6H4mEA6KmOsGaBcjVmKPkUfvBmnOk1pgxzY6Y/ktnm4QYwMpMFSGhl3ycwSL
         kVGQ==
X-Gm-Message-State: AOJu0YxRPO8FHspYWDEacsrOlEDg1SKzENcCU4NfgeBAOdmOh5OlfNHq
	QteJCw/4mXr/OaJcjqxQKBxLcaxkjhuo+iifkM8sucLqcA/W8ckDdTVi/tgT
X-Gm-Gg: ASbGncvwUD+KThnx4L9ttpcdILNIDWoKVfw+HAF+TQCYhTnUb07QaaNDwdNFC9q2OcL
	HvhweNkm4wQdgu65nKGrajJ92cRlGYm/An5xoEgtjCU+JTzwlt60sL4jg/1DD0UoCFNF90uuM7J
	y8rK4SioXUdGho7IMCF5EQV5gJkx8VETYubgz9q2biYYz5LbK0kzwT0Hc59mNwXcXC4ZCnEvEAV
	5dVMy2vM9aQSuNUq2ubk0Wt8xaKj7hdBDNSFa8c6PhLmEzdcFBwpJWe+69YHHk8PCTkOHxU04rA
	kJbmkQU7KKNhRA==
X-Google-Smtp-Source: AGHT+IG3N729kM+Hxm8jE5uJPtPDfvP32gpGbfpLcnjAsfm1FOxMdWDhXa0LZ+GJf60DMyQzxvOZGA==
X-Received: by 2002:a05:6a21:7101:b0:1e2:88b:4f1b with SMTP id adf61e73a8af0-1ed7a62497cmr21607089637.39.1738392167262;
        Fri, 31 Jan 2025 22:42:47 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec0e8ef61sm4058592a12.78.2025.01.31.22.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 22:42:46 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Jeff King <peff@peff.net>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Matthew Rogers <mattr94@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Pavel Rappo <pavel.rappo@gmail.com>
Subject: [PATCH v3 1/5] refactor(remote): rename function omit_name_by_refspec
Date: Sat,  1 Feb 2025 12:11:58 +0530
Message-Id: <20250201064202.76116-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201064202.76116-1-meetsoni3017@gmail.com>
References: <20250127103644.36627-1-meetsoni3017@gmail.com>
 <20250201064202.76116-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the function `omit_name_by_refspec()` to
`refname_matches_negative_refspec_item()` to provide clearer intent.
The previous function name was vague and did not accurately describe its
purpose. By using `refname_matches_negative_refspec_item`, make the
function's purpose more intuitive, clarifying that it checks if a
reference name matches any negative refspec.

Rename function parameters for consistency with existing naming
conventions. Use `refname` instead of `name` to align with terminology
in `refs.h`.

Remove the redundant doc comment since the function name is now
self-explanatory.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 builtin/remote.c | 2 +-
 remote.c         | 8 ++++----
 remote.h         | 6 +-----
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 0435963286..258b8895cd 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -383,7 +383,7 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 				states->remote->fetch.items[i].raw);
 
 	for (ref = fetch_map; ref; ref = ref->next) {
-		if (omit_name_by_refspec(ref->name, &states->remote->fetch))
+		if (refname_matches_negative_refspec_item(ref->name, &states->remote->fetch))
 			string_list_append(&states->skipped, abbrev_branch(ref->name));
 		else if (!ref->peer_ref || !refs_ref_exists(get_main_ref_store(the_repository), ref->peer_ref->name))
 			string_list_append(&states->new_refs, abbrev_branch(ref->name));
diff --git a/remote.c b/remote.c
index 0f6fba8562..cb70ce6f3b 100644
--- a/remote.c
+++ b/remote.c
@@ -944,12 +944,12 @@ static int refspec_match(const struct refspec_item *refspec,
 	return !strcmp(refspec->src, name);
 }
 
-int omit_name_by_refspec(const char *name, struct refspec *rs)
+int refname_matches_negative_refspec_item(const char *refname, struct refspec *rs)
 {
 	int i;
 
 	for (i = 0; i < rs->nr; i++) {
-		if (rs->items[i].negative && refspec_match(&rs->items[i], name))
+		if (rs->items[i].negative && refspec_match(&rs->items[i], refname))
 			return 1;
 	}
 	return 0;
@@ -962,7 +962,7 @@ struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
 	for (tail = &ref_map; *tail; ) {
 		struct ref *ref = *tail;
 
-		if (omit_name_by_refspec(ref->name, rs)) {
+		if (refname_matches_negative_refspec_item(ref->name, rs)) {
 			*tail = ref->next;
 			free(ref->peer_ref);
 			free(ref);
@@ -1021,7 +1021,7 @@ static int query_matches_negative_refspec(struct refspec *rs, struct refspec_ite
 	}
 
 	for (i = 0; !matched_negative && i < reversed.nr; i++) {
-		if (omit_name_by_refspec(reversed.items[i].string, rs))
+		if (refname_matches_negative_refspec_item(reversed.items[i].string, rs))
 			matched_negative = 1;
 	}
 
diff --git a/remote.h b/remote.h
index bda10dd5c8..66ee53411d 100644
--- a/remote.h
+++ b/remote.h
@@ -261,11 +261,7 @@ int resolve_remote_symref(struct ref *ref, struct ref *list);
  */
 struct ref *ref_remove_duplicates(struct ref *ref_map);
 
-/*
- * Check whether a name matches any negative refspec in rs. Returns 1 if the
- * name matches at least one negative refspec, and 0 otherwise.
- */
-int omit_name_by_refspec(const char *name, struct refspec *rs);
+int refname_matches_negative_refspec_item(const char *refname, struct refspec *rs);
 
 /*
  * Remove all entries in the input list which match any negative refspec in
-- 
2.34.1

