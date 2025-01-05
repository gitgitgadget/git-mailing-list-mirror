Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617D8144D1A
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736085018; cv=none; b=XdtBNCnkWHHpWpLR42CaLwoGHgpQqnA1x260aHP7kMdb1WYXIC0+8y6fM3I0Vjw7BvQuMea9eO+ew+Z5XMa1UZiVD9ZLx9K0M9KhIFpznMRmPh/qddNC2Br+w0B6C6Qs0hSKLdVnJH4T8NEEakAIaG51UG9rlZ7ZOeIMz1NZfIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736085018; c=relaxed/simple;
	bh=/1wk9FVuDhAceWUi1iD+Cb6+KsC98czVFNF7l8Xiiok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSPYd6/aNWeAU4kuG4ccrMICq43VFPhru5bwX7BrNlBhr/qkrSf+nm/kLgGcW7+vmGpEMDJg77Fh98ouk+lpeLWSOy9UhGRxXhd7JcWzw8xg9NXtHkefyOIGWGWGZk0Ky+SS9eyncgxUJRmVsvH835w3VhIzVBHVlzRcQSVLWcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ag7zefcX; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag7zefcX"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso19491904a91.0
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 05:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736085015; x=1736689815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmTV6X5dSaUAm3v/sYENUmrKOuFogU3fE/8gcUcu23w=;
        b=ag7zefcXzl0vTrQSu0gkYZOgSgiYcYqBfBbWr4NJgX+bgRx/IP9xLQXNuAXPp8HDxL
         2YjijhpEAYmo5dkDly+qc86mkJBX0r0x5YTA6aqEDPIz4iR4VE9qZ5Tkn3N2ixpKx+7Y
         W9WyZ7Eif28EYqxUidE6w1Dm+iVqKSVNkbTdtTGuGOh/P7nIBDlztLifCviMSkQjgmYB
         GtkzEFVaWfBeeYkiG8MPOGUPbE3iF37SiL5om7e2x02+bHhicdH3x6ZWbsrcHMTKqlvD
         azKRGbXbI6W7axRbVLARqfEkGfuFfrYAiJurGJ/BN8OvfDcKCXqSepZUxlLP5bpr6/sw
         MMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736085015; x=1736689815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmTV6X5dSaUAm3v/sYENUmrKOuFogU3fE/8gcUcu23w=;
        b=RRuIBpcXcPMwjwvzIkgxSOAVmOw7JsHWBO43gcGByPR6OacRvulhTKuRA01RNLHCKx
         v8wPPWDUV6Ta5oAsKVHdld08YZac11eHpi3LuAb19+jOTYRcDZKVuvyZ5jgOxyOxA/yQ
         l6m+hnRTgetuEPjlROyS827IisRegcleOBK0V1oUZf4aU9nG+w2kY5wmlk5jQoCq4BOP
         1M3kIQXJ6dwsbhQXFOtRrnvATnM4nxjRA3Y8fBR4Y4v91BXr4Mmi/1xYsVDOYeo5CY16
         J+i8znSgcYMsPNF9IbszyStygOeWGhT7wjMH3MdC90qC/Y+Ti0woAkaKi3x2PRM3MEOQ
         gsZQ==
X-Gm-Message-State: AOJu0YymBh4mCbnVwafa2hgvhg64lvrsdHgl7gzS5sIT7kxlT07FHpQ0
	EbcfGZtweE9q8vl1DSEbeSSIfY0SvcHu++sPID6wR4lN5rVzP9KVTcAYVA==
X-Gm-Gg: ASbGncvA44Y7s7VS6ojbqGdt/alCujJca0h2XlJNBPK2xO8AdnkfwqlaBl2hr9+21GK
	rpyTj+jHxWTb70g8Zee+2zK3VYQkotURoNMUFZLs7dYu9emy/5Yw489vIBYXfueO8EEd33OsSaa
	G1E4Tlo9hgiFPlKAzbk6kizodF9Ri8TgwoZVZ9+thqtPrK26v2Asjr065+4dFNbip/AAgg19c5R
	vg6CUJh85aiMl1M6T9dJAVeYEv0XE4Cnho=
X-Google-Smtp-Source: AGHT+IHGhVhi68Kx7tSPgLohZiXveClTvFeBfDAT4B6s+usxt3o77iXCXVC6/qVedsLZkGBCq/tOgw==
X-Received: by 2002:a17:90b:2e4a:b0:2ee:fa0c:cebc with SMTP id 98e67ed59e1d1-2f452e38d0emr85734856a91.20.1736085014871;
        Sun, 05 Jan 2025 05:50:14 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962e0csm275631005ad.22.2025.01.05.05.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 05:50:14 -0800 (PST)
Date: Sun, 5 Jan 2025 21:50:10 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/10] packed-backend: create "fsck_packed_ref_entry" to
 store parsing info
Message-ID: <Z3qOEvyeoc7vOW73@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3qNUizvHJLgMx1y@ArchLinux>

We have already check whether the oid hash is correct by using
`parse_oid_hex_algop`. However, we doesn't check whether the object
exists. It may seem that we could do this when we are parsing the raw
"packed-refs" file. But this is impossible. Let's analysis why.

We will use "parse_object" function to get the "struct object". However,
this function will eventually call the "create_snapshot" and
"next_record" function in "packed-backend.c". If there is anything
wrong, it will die the program. And we don't want to die the program
during the check.

So, we should store the information in the parsing process. And if there
is nothing wrong in the parsing process, we could continue to check
things. So, create "fsck_packed_ref_entry" to do this.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c | 56 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 6e521a9f87..7386e6bfce 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1768,6 +1768,29 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
 	return empty_ref_iterator_begin();
 }
 
+struct fsck_packed_ref_entry {
+	int line_number;
+
+	int has_peeled;
+	struct object_id oid;
+	struct object_id peeled;
+};
+
+static struct fsck_packed_ref_entry *create_fsck_packed_ref_entry(int line_number)
+{
+	struct fsck_packed_ref_entry *entry = xcalloc(1, sizeof(*entry));
+	entry->line_number = line_number;
+	entry->has_peeled = 0;
+	return entry;
+}
+
+static void free_fsck_packed_ref_entries(struct fsck_packed_ref_entry **entries, int nr)
+{
+	for (int i = 0; i < nr; i++)
+		free(entries[i]);
+	free(entries);
+}
+
 static int packed_fsck_ref_next_line(struct fsck_options *o,
 				     int line_number, const char *start,
 				     const char *eof, const char **eol)
@@ -1823,20 +1846,20 @@ static int packed_fsck_ref_header(struct fsck_options *o, const char *start, con
 }
 
 static int packed_fsck_ref_peeled_line(struct fsck_options *o,
-				       struct ref_store *ref_store, int line_number,
+				       struct ref_store *ref_store,
+				       struct fsck_packed_ref_entry *entry,
 				       const char *start, const char *eol)
 {
 	struct strbuf peeled_entry = STRBUF_INIT;
 	struct fsck_ref_report report = { 0 };
-	struct object_id peeled;
 	const char *p;
 	int ret = 0;
 
-	strbuf_addf(&peeled_entry, "packed-refs line %d", line_number);
+	strbuf_addf(&peeled_entry, "packed-refs line %d", entry->line_number + 1);
 	report.path = peeled_entry.buf;
 
 	start++;
-	if (parse_oid_hex_algop(start, &peeled, &p, ref_store->repo->hash_algo)) {
+	if (parse_oid_hex_algop(start, &entry->peeled, &p, ref_store->repo->hash_algo)) {
 		ret |= fsck_report_ref(o, &report,
 				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
 				       "'%.*s' has invalid peeled oid",
@@ -1858,20 +1881,20 @@ static int packed_fsck_ref_peeled_line(struct fsck_options *o,
 }
 
 static int packed_fsck_ref_main_line(struct fsck_options *o,
-				     struct ref_store *ref_store, int line_number,
+				     struct ref_store *ref_store,
+				     struct fsck_packed_ref_entry *entry,
 				     const char *start, const char *eol)
 {
 	struct strbuf packed_entry = STRBUF_INIT;
 	struct fsck_ref_report report = { 0 };
 	struct strbuf refname = STRBUF_INIT;
-	struct object_id oid;
 	const char *p;
 	int ret = 0;
 
-	strbuf_addf(&packed_entry, "packed-refs line %d", line_number);
+	strbuf_addf(&packed_entry, "packed-refs line %d", entry->line_number);
 	report.path = packed_entry.buf;
 
-	if (parse_oid_hex_algop(start, &oid, &p, ref_store->repo->hash_algo)) {
+	if (parse_oid_hex_algop(start, &entry->oid, &p, ref_store->repo->hash_algo)) {
 		ret |= fsck_report_ref(o, &report,
 				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
 				       "'%.*s' has invalid oid",
@@ -1883,7 +1906,7 @@ static int packed_fsck_ref_main_line(struct fsck_options *o,
 		ret |= fsck_report_ref(o, &report,
 				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
 				       "has no space after oid '%s' but with '%.*s'",
-				       oid_to_hex(&oid), (int)(eol - p), p);
+				       oid_to_hex(&entry->oid), (int)(eol - p), p);
 		goto cleanup;
 	}
 
@@ -1914,7 +1937,10 @@ static int packed_fsck_ref_content(struct fsck_options *o,
 				   struct ref_store *ref_store,
 				   const char *start, const char *eof)
 {
+	struct fsck_packed_ref_entry **entries;
+	int entry_alloc = 20;
 	int line_number = 1;
+	int entry_nr = 0;
 	const char *eol;
 	int ret = 0;
 
@@ -1933,14 +1959,21 @@ static int packed_fsck_ref_content(struct fsck_options *o,
 				       "missing header line");
 	}
 
+	ALLOC_ARRAY(entries, entry_alloc);
 	while (start < eof) {
+		struct fsck_packed_ref_entry *entry
+			= create_fsck_packed_ref_entry(line_number);
+		ALLOC_GROW(entries, entry_nr + 1, entry_alloc);
+		entries[entry_nr++] = entry;
+
 		ret |= packed_fsck_ref_next_line(o, line_number, start, eof, &eol);
-		ret |= packed_fsck_ref_main_line(o, ref_store, line_number, start, eol);
+		ret |= packed_fsck_ref_main_line(o, ref_store, entry, start, eol);
 		start = eol + 1;
 		line_number++;
 		if (start < eof && *start == '^') {
+			entry->has_peeled = 1;
 			ret |= packed_fsck_ref_next_line(o, line_number, start, eof, &eol);
-			ret |= packed_fsck_ref_peeled_line(o, ref_store, line_number,
+			ret |= packed_fsck_ref_peeled_line(o, ref_store, entry,
 							   start, eol);
 			start = eol + 1;
 			line_number++;
@@ -1955,6 +1988,7 @@ static int packed_fsck_ref_content(struct fsck_options *o,
 		o->safe_object_check = 0;
 
 
+	free_fsck_packed_ref_entries(entries, entry_nr);
 	return ret;
 }
 
-- 
2.47.1

