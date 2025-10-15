Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB03230E0E1
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567340; cv=none; b=lurSFXld9m1lPD7UkKowGjXoSrMtFelI1fKrQmfgnZP0rtNu6Qd3JQguDZbZ7/7x0LHXhEyYoOkgjXRL5VPyvdv3h8FmW3j7a4eXy6rt425rKQ3J/aOhWtjo5e/EHnFGmEtECT5l7Y6Ek1Ejne1qXAbVmeL549kfQ4xZmWtNE6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567340; c=relaxed/simple;
	bh=WV0xTLJbZvfkvlKLpdl9S/BV3JAXrwTU2OLLsocA4xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJ9/cdH8u6/nv1VDn+wG7KpZNXEfjmUDo9a7VmUw8G/JNkgGQiNHKtBK7swbfllH3qD3FS3I+5XPm9myrLr6Frz3gXNTCxM+/mUljOaBY8M49nhsdUT13F46k7Lef4XlLyXMZfjcp1kABUeEmNyCSLWuFVJ+uhurhxWdA6mCzJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=k4b5m893; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="k4b5m893"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7829fc3b7deso446497b3.3
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567337; x=1761172137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i7PNajavtiYzolCCh5MKIBQbgiFYtO1kvxEe/csaw3g=;
        b=k4b5m893ETfdRZ/RpGg75x/AiMbl7tam/RVsC+pZ5S3Qlf578THb4Ziu9x4qYEdjEg
         hMNWyxZbUIU0uGEieEOxhw0lsNEFlC8ii0fPoR9/b6ZfqBv1nTtnzZB56dnn/pHvT/0n
         1ZaeOzLiYOr3JGtv0/Idz7OpqoR0LyUUQRxWNmuYdV78b8mvG8sYkGXtdklHszo/UJbS
         qBc9gg9mcvk7aVudd1WOYU/IByA4cL1515eps3nzoHORPNMLr8AX9CFNrprMQj6iWIgR
         DAoyg+H4Jl2BM9zqNKGuzgyfy7bfPQMOuc60zBtCgs8kC17JbHguwuIEPeR1yTwf6j3x
         PneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567338; x=1761172138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7PNajavtiYzolCCh5MKIBQbgiFYtO1kvxEe/csaw3g=;
        b=qxJVj9XV6eqfyluSEpK2tyh+C4EwdvOiflDkF/OHkEFhdVZB79ga5BXrSYHzvmsuJu
         8Raq+UPxAS0uODDultgerFeD/RRNlcwGMAA56Lj5H1LXadHQLJv0T5dVLYmkNYqOe3QY
         AnLj2JDljIs2euvqDvXJkExq2/3EakC2gqwr6zM6ZXmVS7ryjLLTpjXznsLw3mLCGCm6
         Pyj2FkPdyqtnjSHKI80Uo0abcLdWYkGxjV4S4eAJxvkiyCPzaoPBYXVJlpHPHo9cV7Us
         ikEet/qZKGkKGJeOKkVfI2zgaacSNR62hZZpvuiLQIQxBWA2Yw8tGTjH/sbl4lXywJSq
         dTaw==
X-Gm-Message-State: AOJu0YyhLtueF5rWSBML9TB03JaJSIcjo9HR6/Zutnt22gwhEd4rShF2
	mexwpHHDGp9nYPXaaISpmJMEd/4aGNZmMS28sdeYC+yYFp5Trsf3GpNdZmbMsl/IW82eHEhmVY5
	O0e74jNdD9w==
X-Gm-Gg: ASbGnctAeVT2gKjBkzkuhU+EkOYp6PTsqf4mWFSB4uRzWyltkRUmqun8d0It8izviZb
	Zqxqv1Wf1Crvr68FBg0xBEJ/+e5k3OLXWebvbZGHse6+oq/EipRB+ZnE6Ai+HqhC0hk0/yI/tEh
	XZJbLU/KI7WtFULL3843Bpxfr1daMK9wSWL9iAoaIwBjGjLidOlQeEz3y20GO+P3S3StwFphLm7
	VLk36Qk1b6kcitxt2alwy6849UDsizLJmQrqUB8FkLKq11Aag4tavmGdCFE1pw3LVkjuER4XT1x
	KV+d2kgS3f5vNXlj/HE5mxa95QN1C9CXgTiJbH0Jcy5aUs2CNn8FhdOVhd3R1w30Hd/F8PmnLlL
	cZ+mipoCowvPSuYV4iZsTYW+fD99wc2LtYO9j/pLE0wcM5O7YQ/fgQmAdVj1oUwswej4j1z2xE0
	VNELWQ6+AW+ce/GNPNCdjjEcu8ZGZoTjS3fmOBg+DFGsCgox21gM7YI0hfLfnsiozugzt5ZIURx
	VRS+FVWsRoXH2fmLQ==
X-Google-Smtp-Source: AGHT+IFJz3EeWb0VFbWictxAriwT9BQVzfIKpCDZzpSKciucwXXP853+nm8V/DhoVEkK8rKdRLyFrQ==
X-Received: by 2002:a05:690c:f0f:b0:75f:725f:a345 with SMTP id 00721157ae682-780e16d6f59mr308280897b3.34.1760567337570;
        Wed, 15 Oct 2025 15:28:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-782930fdf1asm2582107b3.44.2025.10.15.15.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:28:57 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:28:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 33/49] builtin/repack.c: use a string_list for
 'midx_pack_names'
Message-ID: <40ce496de234c432f8fe0c322b837d721ac7607d.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

When writing a new MIDX, repack must determine whether or not there are
any packs in the MIDX it is replacing (if one exists) that are not
somehow represented in the new MIDX (e.g., either by preserving the pack
verbatim, or rolling it up as part of a geometric repack, etc.).

In order to do this, it keeps track of a list of pack names from the
MIDX present in the repository at the start of the repack operation.
Since we manipulate and close the object store, we cannot rely on the
repository's in-core representation of the MIDX, since this is subject
to change and/or go away.

When this behavior was introduced in 5ee86c273b (repack: exclude cruft
pack(s) from the MIDX where possible, 2025-06-23), we maintained an
array of character pointers instead of using a convenience API, such as
string-list.h.

Store the list of MIDX pack names in a string_list, thereby reducing the
number of parameters we have to pass to `midx_has_unknown_packs()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 1a79d1d834..dda533f171 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -118,18 +118,17 @@ struct repack_write_midx_opts {
 	int midx_must_contain_cruft;
 };
 
-static int midx_has_unknown_packs(char **midx_pack_names,
-				  size_t midx_pack_names_nr,
+static int midx_has_unknown_packs(struct string_list *midx_pack_names,
 				  struct string_list *include,
 				  struct pack_geometry *geometry,
 				  struct existing_packs *existing)
 {
-	size_t i;
+	struct string_list_item *item;
 
 	string_list_sort(include);
 
-	for (i = 0; i < midx_pack_names_nr; i++) {
-		const char *pack_name = midx_pack_names[i];
+	for_each_string_list_item(item, midx_pack_names) {
+		const char *pack_name = item->string;
 
 		/*
 		 * Determine whether or not each MIDX'd pack from the existing
@@ -191,8 +190,7 @@ static int midx_has_unknown_packs(char **midx_pack_names,
 
 static void midx_included_packs(struct string_list *include,
 				struct existing_packs *existing,
-				char **midx_pack_names,
-				size_t midx_pack_names_nr,
+				struct string_list *midx_pack_names,
 				struct string_list *names,
 				struct pack_geometry *geometry)
 {
@@ -247,8 +245,8 @@ static void midx_included_packs(struct string_list *include,
 	}
 
 	if (midx_must_contain_cruft ||
-	    midx_has_unknown_packs(midx_pack_names, midx_pack_names_nr,
-				   include, geometry, existing)) {
+	    midx_has_unknown_packs(midx_pack_names, include, geometry,
+				   existing)) {
 		/*
 		 * If there are one or more unknown pack(s) present (see
 		 * midx_has_unknown_packs() for what makes a pack
@@ -606,13 +604,12 @@ int cmd_repack(int argc,
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
 	struct string_list names = STRING_LIST_INIT_DUP;
+	struct string_list midx_pack_names = STRING_LIST_INIT_DUP;
 	struct existing_packs existing = EXISTING_PACKS_INIT;
 	struct pack_geometry geometry = { 0 };
 	struct tempfile *refs_snapshot = NULL;
 	int i, ret;
 	int show_progress;
-	char **midx_pack_names = NULL;
-	size_t midx_pack_names_nr = 0;
 
 	/* variables to be filled by option parsing */
 	struct repack_config_ctx config_ctx;
@@ -985,13 +982,12 @@ int cmd_repack(int argc,
 		struct multi_pack_index *m =
 			get_multi_pack_index(repo->objects->sources);
 
-		ALLOC_ARRAY(midx_pack_names,
-			    m->num_packs + m->num_packs_in_base);
-
-		for (; m; m = m->base_midx)
-			for (uint32_t i = 0; i < m->num_packs; i++)
-				midx_pack_names[midx_pack_names_nr++] =
-					xstrdup(m->pack_names[i]);
+		for (; m; m = m->base_midx) {
+			for (uint32_t i = 0; i < m->num_packs; i++) {
+				string_list_append(&midx_pack_names,
+						   m->pack_names[i]);
+			}
+		}
 	}
 
 	close_object_store(repo->objects);
@@ -1019,8 +1015,8 @@ int cmd_repack(int argc,
 			.write_bitmaps = write_bitmaps > 0,
 			.midx_must_contain_cruft = midx_must_contain_cruft
 		};
-		midx_included_packs(&include, &existing, midx_pack_names,
-				    midx_pack_names_nr, &names, &geometry);
+		midx_included_packs(&include, &existing, &midx_pack_names,
+				    &names, &geometry);
 
 		ret = write_midx_included_packs(&opts);
 
@@ -1067,11 +1063,9 @@ int cmd_repack(int argc,
 cleanup:
 	string_list_clear(&keep_pack_list, 0);
 	string_list_clear(&names, 1);
+	string_list_clear(&midx_pack_names, 0);
 	existing_packs_release(&existing);
 	pack_geometry_release(&geometry);
-	for (size_t i = 0; i < midx_pack_names_nr; i++)
-		free(midx_pack_names[i]);
-	free(midx_pack_names);
 	pack_objects_args_release(&po_args);
 	pack_objects_args_release(&cruft_po_args);
 
-- 
2.51.0.540.ga7423965ad8

