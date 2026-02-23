Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D9E35C1B4
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848014; cv=none; b=Vw9aEEqXj8rl+iu8vjsJxt3NslnNiX9qzo3aJkVTiSqbHeGMJV7DnB46zBNg44xYaigyGx7yAPvLxagSE/6byZgO3A6Lny6QYMg4D+StEmWIBlpNvaw/rTobeab/OSECwXnlhM0VMblNEBwCZz678rvDWEPdXDw8N7athD/LtV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848014; c=relaxed/simple;
	bh=y/R6T81npBe7vEvS9zpX3KO13ykYfTwr+dAXWWnUP+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o/kjCgck+XSxR5jLpqWwAUxG70jO1FUD8LnTOAcjiyV1hZBEAFZu2mcJhGF+HY2KGOA+A51vvMtLckOODb0z015C0QtT/Dr0moLOcaTw4Ce2D26kietz+GClFY4RdfHLc0S5CGUltWUvE90pmBkLbgkwyFaBJ5SCxmExcPLjIFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XwhhSd1Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cFIBQCDr; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XwhhSd1Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cFIBQCDr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DF58AEC05BD;
	Mon, 23 Feb 2026 07:00:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 23 Feb 2026 07:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771848011;
	 x=1771934411; bh=RKvhJtgaBqBlZ0GorG+8uie5zUruQSTGUfzxsSUzsiw=; b=
	XwhhSd1YTZpdsFHqUUeWtj3Q9EAeSGnO/PniBeW2kXa1m0GjoxXTUZXyPtp++rpt
	JoXuPHhWt7mI94fFJr8vqUgR3KgwHXR1oLZJ23THbXSnE6GQDmFPzrezoKTPyL2x
	EFiG+i8lxPHXPjRM5NRuoem8UXeMpBMhR5YbA5djhrs+bCyBNHtygsE3yB4Gu5S6
	V04rJy+6dpLcUI670/lVTVgm8cCs/7/+x6sQ49QPaCSVutVkxNkf48HYI2Eajdce
	uBBlbvFTPNsvL6HjJQS1zGWReiqlaTu0zHd1XijVfN+LthunRvnbCdqY9FyM6LCU
	kMZSz+aw793sX5C9GDcDPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771848011; x=
	1771934411; bh=RKvhJtgaBqBlZ0GorG+8uie5zUruQSTGUfzxsSUzsiw=; b=c
	FIBQCDrcorDDYUVzbnIaAlQ6RbYr/AT2YPtmgRESpkR3N1VOw02B5sqqDvrCPqi8
	NIZCR34e3XcBhpgKfarGucJX+VnJc/wA9QCarF2JE4lbQiUvvCGDpmo9TYUXqNNN
	VMWgfcnis0pPyV0vglEe1iAVJcPVysvm/2KZXIWAcn16T+K/haYtPK8/y/hGWYLt
	183JRwKckXSrG/KPlOJe9Uoy5/T2xWLDBfLKGP8s0OCyFekuq2dc8R+S8PlZBd8k
	GbWuWMo3ok+v30UUG0J5xbL70RFIxScf1KuDwRuzfu4y+nAV7hXMAGw0ZhRTHW+6
	wnm3IKH422CelWlkVeyCw==
X-ME-Sender: <xms:S0GcafzFjD7IzWZa_UZzBdOsaHo_bgR3y1VdwxeARbdO55dZt2QVWA>
    <xme:S0Gcaeur8tkKwuYAoXceGTb8dR3B9SxqY67fcd6lfWL8OUd3ta1VQ_4llk50tdIA1
    td4981jSQ0I-o_Nqc9bdWZYX7R-DWWUPwzrqm038YRECv0go3R1GQ>
X-ME-Received: <xmr:S0GcaWtd6k1OdoDwEOkfqe_T4iLWXHa_GEAIp29La8GpUJxNh5UXdWrifznEeg5wkWdWxyLqNX3yVWq3lZEd86icJJoCzoT6HylPfHfa3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehoshifrghlugdrsghuuggu
    vghnhhgrghgvnhesghhmgidruggv
X-ME-Proxy: <xmx:S0GcaTNsJo6kYvo-RhtHFo3RcTlPTrgN-OC1pbAWtOCFgR5Cqw7Fag>
    <xmx:S0GcaU1f924HN6L0-SPMYPlChrHD_J7osMYIZEANdkMmRqHDcZIcuQ>
    <xmx:S0GcafNCgCrUNIowomdhaFXfA_WW-UJ5NcA_hsupIl_YTraxechHTw>
    <xmx:S0GcaU3dmTQASPNhp1bEuKdY0-R1NUgnA1jZN_mSU2SB0T-tqypbhw>
    <xmx:S0Gcac0NLdRpDV3fYJczlJ1329Vxjw-5SEymeVFenoO98i_mDIJ1lrsI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 07:00:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e7dc0f77 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 12:00:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 12:59:45 +0100
Subject: [PATCH v2 11/17] refs: replace `refs_for_each_ref_in()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-refs-for-each-unification-v2-11-515d48c8087b@pks.im>
References: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
In-Reply-To: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
X-Mailer: b4 0.14.3

Replace calls to `refs_for_each_ref_in()` with the newly introduced
`refs_for_each_ref_ext()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c                  |  8 ++++++--
 builtin/rev-parse.c       | 13 +++++++++----
 pack-bitmap.c             | 13 +++++++------
 refs.c                    | 34 ++++++++++++++++++----------------
 refs.h                    |  2 --
 t/helper/test-ref-store.c |  7 +++++--
 6 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/bisect.c b/bisect.c
index 2bdad4ee42..296836c154 100644
--- a/bisect.c
+++ b/bisect.c
@@ -473,8 +473,12 @@ static int register_ref(const struct reference *ref, void *cb_data UNUSED)
 
 static int read_bisect_refs(void)
 {
-	return refs_for_each_ref_in(get_main_ref_store(the_repository),
-				    "refs/bisect/", register_ref, NULL);
+	struct refs_for_each_ref_options opts = {
+		.prefix = "refs/bisect/",
+		.trim_prefix = strlen("refs/bisect/"),
+	};
+	return refs_for_each_ref_ext(get_main_ref_store(the_repository),
+				     register_ref, NULL, &opts);
 }
 
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 9032cc6327..02703f2fb8 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -613,13 +613,18 @@ static int opt_with_value(const char *arg, const char *opt, const char **value)
 
 static void handle_ref_opt(const char *pattern, const char *prefix)
 {
-	if (pattern)
+	if (pattern) {
 		refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
 					  show_reference, pattern, prefix,
 					  NULL);
-	else
-		refs_for_each_ref_in(get_main_ref_store(the_repository),
-				     prefix, show_reference, NULL);
+	} else {
+		struct refs_for_each_ref_options opts = {
+			.prefix = prefix,
+			.trim_prefix = strlen(prefix),
+		};
+		refs_for_each_ref_ext(get_main_ref_store(the_repository),
+				      show_reference, NULL, &opts);
+	}
 	clear_ref_exclusions(&ref_excludes);
 }
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index efef7081e6..22419bfb33 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -3326,6 +3326,7 @@ static const struct string_list *bitmap_preferred_tips(struct repository *r)
 void for_each_preferred_bitmap_tip(struct repository *repo,
 				   refs_for_each_cb cb, void *cb_data)
 {
+	struct refs_for_each_ref_options opts = { 0 };
 	struct string_list_item *item;
 	const struct string_list *preferred_tips;
 	struct strbuf buf = STRBUF_INIT;
@@ -3335,16 +3336,16 @@ void for_each_preferred_bitmap_tip(struct repository *repo,
 		return;
 
 	for_each_string_list_item(item, preferred_tips) {
-		const char *pattern = item->string;
+		opts.prefix = item->string;
 
-		if (!ends_with(pattern, "/")) {
+		if (!ends_with(opts.prefix, "/")) {
 			strbuf_reset(&buf);
-			strbuf_addf(&buf, "%s/", pattern);
-			pattern = buf.buf;
+			strbuf_addf(&buf, "%s/", opts.prefix);
+			opts.prefix = buf.buf;
 		}
 
-		refs_for_each_ref_in(get_main_ref_store(repo),
-				     pattern, cb, cb_data);
+		refs_for_each_ref_ext(get_main_ref_store(repo),
+				      cb, cb_data, &opts);
 	}
 
 	strbuf_release(&buf);
diff --git a/refs.c b/refs.c
index a57eafd6de..7b1ef769c0 100644
--- a/refs.c
+++ b/refs.c
@@ -529,19 +529,31 @@ void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
 	refs_for_each_rawref(refs, warn_if_dangling_symref, &data);
 }
 
-int refs_for_each_tag_ref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
+int refs_for_each_tag_ref(struct ref_store *refs, refs_for_each_cb cb, void *cb_data)
 {
-	return refs_for_each_ref_in(refs, "refs/tags/", fn, cb_data);
+	struct refs_for_each_ref_options opts = {
+		.prefix = "refs/tags/",
+		.trim_prefix = strlen("refs/tags/"),
+	};
+	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
-int refs_for_each_branch_ref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
+int refs_for_each_branch_ref(struct ref_store *refs, refs_for_each_cb cb, void *cb_data)
 {
-	return refs_for_each_ref_in(refs, "refs/heads/", fn, cb_data);
+	struct refs_for_each_ref_options opts = {
+		.prefix = "refs/heads/",
+		.trim_prefix = strlen("refs/heads/"),
+	};
+	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
-int refs_for_each_remote_ref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
+int refs_for_each_remote_ref(struct ref_store *refs, refs_for_each_cb cb, void *cb_data)
 {
-	return refs_for_each_ref_in(refs, "refs/remotes/", fn, cb_data);
+	struct refs_for_each_ref_options opts = {
+		.prefix = "refs/remotes/",
+		.trim_prefix = strlen("refs/remotes/"),
+	};
+	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
 int refs_head_ref_namespaced(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
@@ -1934,16 +1946,6 @@ int refs_for_each_ref(struct ref_store *refs, refs_for_each_cb cb, void *cb_data
 	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
-int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
-			 refs_for_each_cb cb, void *cb_data)
-{
-	struct refs_for_each_ref_options opts = {
-		.prefix = prefix,
-		.trim_prefix = strlen(prefix),
-	};
-	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
-}
-
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 			     const char **exclude_patterns,
 			     refs_for_each_cb cb, void *cb_data)
diff --git a/refs.h b/refs.h
index faed63aa81..7a3bc9e5b7 100644
--- a/refs.h
+++ b/refs.h
@@ -501,8 +501,6 @@ int refs_for_each_ref(struct ref_store *refs,
 int refs_for_each_ref_ext(struct ref_store *refs,
 			  refs_for_each_cb cb, void *cb_data,
 			  const struct refs_for_each_ref_options *opts);
-int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
-			 refs_for_each_cb fn, void *cb_data);
 int refs_for_each_tag_ref(struct ref_store *refs,
 			  refs_for_each_cb fn, void *cb_data);
 int refs_for_each_branch_ref(struct ref_store *refs,
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index b1215947c5..a2ef1b6949 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -163,8 +163,11 @@ static int each_ref(const struct reference *ref, void *cb_data UNUSED)
 static int cmd_for_each_ref(struct ref_store *refs, const char **argv)
 {
 	const char *prefix = notnull(*argv++, "prefix");
-
-	return refs_for_each_ref_in(refs, prefix, each_ref, NULL);
+	struct refs_for_each_ref_options opts = {
+		.prefix = prefix,
+		.trim_prefix = strlen(prefix),
+	};
+	return refs_for_each_ref_ext(refs, each_ref, NULL, &opts);
 }
 
 static int cmd_for_each_ref__exclude(struct ref_store *refs, const char **argv)

-- 
2.53.0.536.g309c995771.dirty

