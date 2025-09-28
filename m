Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2551FB3
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097363; cv=none; b=X7e/gqbEtaWZNX9eAZqig9Yc4lmwrIjHDCjpg27LefxTOER9XDxC96WfNDD3tCMVrokt7BznCOJYgaUDLJm3RrpsbIIyVdvsgAh6UJzKfMbqIOr3Q/FtHX0z1GryCqwtAmoKvpryeatPYoaiXsSp1sOOFU13J0pQBTzJCo9VS3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097363; c=relaxed/simple;
	bh=NmPOSf/vBH1fLRYPKp/0GZdBTbMOkibgWlyGfhTNWUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSQG4QKKpyfm7fArQjT3G4TZgX7Lo6V6myqFXb/slgX0Nu6+mKaE9ssxIMXj4WtVtEcc11UfluFB3vjc1/RWei3kJfE+2w05mjbv0eaKAAXajr1wzv2+QBg0L5wQkIWH/qQPAoaXCnAq4BAVOoLH/69kT1t+U7WgKDLo/b1WEWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=JVRjRjEI; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="JVRjRjEI"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-73b4e3d0756so49653727b3.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097360; x=1759702160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+4AOilyK1dDKxXW65qPSDNAS3mZSHqWeEPhluMYExLI=;
        b=JVRjRjEI3ehraSh82rWUV9onrDV5urOip2bEbd2ty/ApD8FesdwZMIQMNw7R1CIYDt
         bEyX8TUvcRAe3rz3RHYEtThkAnL2e27vTO5MzKTjeSwk3lFeoORxdyvmpHQcQqAydNxO
         eeucv6ZTHwGCxdgXjMaLuyyI4L2LNyJCDczAWiVbfksDzjkSe+vzg9+z0BiGCIrjdT2q
         +163DKCVNSIrLi6xAe5fsZZZKKe+ZOGmqxRUnsimfev3NLpnl0KMyOuT8RaSLpj31kc7
         cJ8rpwS+NXqbGSzKEiHUC4QIY/NhN3ag9hrx9DkGNpjwum4hylvRLcoTn9nHsjHSvzIt
         GmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097360; x=1759702160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4AOilyK1dDKxXW65qPSDNAS3mZSHqWeEPhluMYExLI=;
        b=qcn7BbUaaKBEmEiM9CiH9n5YtuQ/XPsP62UCXbeIzk0pzDFKBr736GCgyAyK9LWlN3
         tex56gDqSwaWxeJy+taNJwhvAapuOKUtccYEzWBlDcNPYtebWmmsAikYmJc7Y+6HOZFC
         hp/ejKJWl70Lfud9a1ygCPuuCBjgBEcSMB1Vd3MzWpJX7wBHgqB4TuvrgrX9WX0uhDzy
         Hdg/Xj6rDldsGvGv/paz0cP+OLFi1mYyyv4qT7u82P5wkrATFZUpPHWWgXl+ddt6ccSR
         C5LNU7gGi5+OrVcB9pgZvxgWgoD+s6R1tbNdujwwJ6fjIUrQ+GreH6POnYMwcCLfOCLM
         UKMA==
X-Gm-Message-State: AOJu0YxXNP7tp2E7hHB0whQAWAIW0Hxkg4cVryN9vP+01BZwNV7yqxKg
	PE/eIiPT5hM8J1kCIw23kfbsfiv1W4AVrKdadka5DPVF33SjtXTjMZVCRvmO3ijUVD5/OYmIEkd
	VYORcqGXTow==
X-Gm-Gg: ASbGncurgxI9SlaNF2UisLJ5lU0o3s4p5ngGKUIbPz33lDG63lMZPO9dAYyzmiL4XeU
	2jr94Np0oynkaaZfiZbbd12Bxs2Tq3Jljqm99M8/Xsd2OjzRuSR/ZLxvGQy87D15jbGYxg0acas
	hibI7tEcHRHcVod2JQamgk1LyLxFGfB0QEna6rzUzlziSw6hNihgpMtqBgz+I16W/XeNjxdi9dA
	VOnqbxrj60oqhvPJXv2kcKxQMP89iVQtAazBktxFBgVsAD2IMSoJ3XQXxDaINdvRRH4QkcXenRC
	7vXmU3tg9JhUojNbytAx8ix7PkWZU+7fL8UejN8WDmzlCBfGKqPQ5BZ18OY8cI7AaFdbgUqbXcL
	EDGkHrHqK5rY3yV+yPcQh/P8wW62suGP3X6eYv0j5yn2JxrcbYD7aSBslv3FAgVsgx/lu7Haxhw
	S6Gh4t19WGJR8DIsxb861crMGXaG82/CIRDWef
X-Google-Smtp-Source: AGHT+IEtHmU2VZ/G3ljxGu8Daf1Jh/wydkpYBq7Is5qP+allFfJrJAd4Oa1Mq7KIN6g0ePgj3FV6bw==
X-Received: by 2002:a05:690c:3681:b0:749:1904:d4ce with SMTP id 00721157ae682-764077699a0mr168396817b3.44.1759097360227;
        Sun, 28 Sep 2025 15:09:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-765be76d928sm22680627b3.31.2025.09.28.15.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:09:19 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:09:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 33/49] builtin/repack.c: use a string_list for
 'midx_pack_names'
Message-ID: <88445297596acff18e6427400a4a0e5a049dd923.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

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
index e4b8aa2c6f..8ae56b05e9 100644
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
2.51.0.243.g16eca91f2c0

