Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B528DF29
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 23:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375824; cv=none; b=m6cGt2bgLmisgkvd9/ZQVm9FYc5ov2rSxb8o9n2sGbPUFYqFk7x1yyM9gKYeav8rc8eQgILm/skb0+jeVA2ZiqcRT0Lonlf9Wm1fr6pEAjHZK4DacfBk9qTAlSJW79u3CGyf97ocv/pRFO5QP9/XwiJ0ZyV5dg0X5iYVU1jS/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375824; c=relaxed/simple;
	bh=bzrdUGwez1TaF3BQJiDwJbMtmzGQ/wL+P1+w6eLRw14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxWwPBEa7SNK2FUAsAV0HcJptXLhSVAHKcXel9pO3znZn2cMYDIK8BIo78zrvvyFEFagX98aeqH4fcxgfWmXaTfShY/Gi8McK8oEEArZK9hxJTI+Xgr/aIsXqY7+5F1e8DiOw+g8OO2UZefhZmN4aIGhQKLELRnr6K6VeKPzdjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=pbMCYxjf; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="pbMCYxjf"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e8276224c65so1444995276.0
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 16:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750375818; x=1750980618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aVnpmItYLllFFy138PLD2cyy+PUyzUiuBLrPdunaXDk=;
        b=pbMCYxjfbU1yTOdlZiO3tg5gZsMu8xFKJ12RCBtdyWmD3pwnP9wrwlvVmprfVUKsPN
         hAyFctuvquS6NL0MZzX387w9N4skLFtJh5T1p6brbMZ7Y0V96sBoK8ghVc6027uccpAq
         4E+vcCEggXvjYVQN56s8FbAZnXolzuuETDi2VOqX/X2eXArZBVL8syqW/iOzpF6tdF9w
         uNJPV/KJfPTQ7tcV4X/dFepy3nQXUzCX+McSkbvcv7z/k37vIzx+3N9/WosCGN7Fn5hX
         eUmRogtqjFHU5EZxawBxCKIXq0BzEhAH3l5hLyfhiVc5MbBNJo6ZYkXNy2gyxYfDTSoR
         Qnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750375818; x=1750980618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVnpmItYLllFFy138PLD2cyy+PUyzUiuBLrPdunaXDk=;
        b=Bk++BVJX3NO8Hy5HJ9M/0GdogdF3ZJ7utV080gNw/nqwDcmqVPF9GzY6z1bRLjIntM
         XGkR++ztrEoM+wO/eCFv/cpqwzR6uVHs+WlkzK0mcnNuv2mKBfLd8akXbXtG5ldY77RB
         vUyUy6v5+P/obRrtdpKhaJ82zcWX5B5kBjShydFV4NarESQf+F6zpa3lTzOZpXWHXz5F
         IQ3Dn1Hvt4RfwohTuY0ya54380PIAFWMvIuVdcNC7CBQiFW2V2EGLeODg8IzcOerA5as
         H1FlOFEzUyGdzWld05LZQ6LRjjFrERuSs7tprmxJ7apzok96s961CRfkiq/Xw9OjXstB
         Uamg==
X-Gm-Message-State: AOJu0Yzz813iS4Zd1YGPKswahn8V98GzGZ81JoO36Oi7UHpD6SmiDxwn
	pgAFfnNXVRbQFh6vWq8Zf9Q6u1nsTnbYS0/d3YmPD5CBAG6WXAFr/B11GjhC7Fl+vy+smg5hTLV
	TRUbM
X-Gm-Gg: ASbGncuxkQgytR6wTKOFquK3jAnJX1NYs+QzVac8+hkz2k0pe0D4AimCf1hcsezCLEQ
	SDTc+yJxG6UZ/Xo4uxf/2sxYLqo6bATpmHQvIO7z9KcSYrsWqyKnLTKvHXo72323qNHGLIqjaKW
	Ka2/fA3haK3Aa1ciZbwtWRB6ky/MLk93k5ZfCHF6ZPr3iGYwcjDOi+mBzmM8HO8iJk1VxtxuIML
	KAhoQ5YNdyc/ERAzO3gBhH1KrVcl4hNi5jxzzdlpHUVhTMheUOjOzAYWY1bXMc4KhMF13BZb6Zk
	bOl8FBEXr6/lAS7oLuRoHTdzrzoNsCYwTyTgUyvIe7j/7LsJ0J1MPIhHMLMSKRRGS5EjyzyAmEX
	Suhm9181HXusqouOOs/+hXU5hHYhRZh0rJA==
X-Google-Smtp-Source: AGHT+IGJqlE4BRVZMbLwN8CkSZG8+k5xCfa5IZGWQ9AP6fgMDdKWS6ZsMWYCOsZ6CeUWshGipCVVCA==
X-Received: by 2002:a05:6902:168b:b0:e7d:c87a:6264 with SMTP id 3f1490d57ef6-e842bc6d6b7mr1451005276.6.1750375818586;
        Thu, 19 Jun 2025 16:30:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e842aababafsm302609276.12.2025.06.19.16.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 16:30:18 -0700 (PDT)
Date: Thu, 19 Jun 2025 19:30:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 4/9] pack-objects: declare 'rev_info' for '--stdin-packs'
 earlier
Message-ID: <3d5d3b78b2e56e111a80dc29d247af40f03ce245.1750375803.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750375803.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1750375803.git.me@ttaylorr.com>

Once 'read_packs_list_from_stdin()' has called for_each_object_in_pack()
on each of the input packs, we do a reachability traversal to discover
names for any objects we picked up so we can generate name hash values
and hopefully get higher quality deltas as a result.

A future commit will change the purpose of this reachability traversal
to find and pack objects which are reachable from commits in the input
packs, but are packed in an unknown (not included nor excluded) pack.

Extract the code which initializes and performs the reachability
traversal to take place in the caller, not the callee, which prepares us
to share this code for the '--unpacked' case (see the function
add_unreachable_loose_objects() for more details).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 71 +++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7ce04b71dd..4258ac1792 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3793,7 +3793,7 @@ static int pack_mtime_cmp(const void *_a, const void *_b)
 		return 0;
 }
 
-static void read_packs_list_from_stdin(void)
+static void read_packs_list_from_stdin(struct rev_info *revs)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list include_packs = STRING_LIST_INIT_DUP;
@@ -3801,24 +3801,6 @@ static void read_packs_list_from_stdin(void)
 	struct string_list_item *item = NULL;
 
 	struct packed_git *p;
-	struct rev_info revs;
-
-	repo_init_revisions(the_repository, &revs, NULL);
-	/*
-	 * Use a revision walk to fill in the namehash of objects in the include
-	 * packs. To save time, we'll avoid traversing through objects that are
-	 * in excluded packs.
-	 *
-	 * That may cause us to avoid populating all of the namehash fields of
-	 * all included objects, but our goal is best-effort, since this is only
-	 * an optimization during delta selection.
-	 */
-	revs.no_kept_objects = 1;
-	revs.keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
-	revs.blob_objects = 1;
-	revs.tree_objects = 1;
-	revs.tag_objects = 1;
-	revs.ignore_missing_links = 1;
 
 	while (strbuf_getline(&buf, stdin) != EOF) {
 		if (!buf.len)
@@ -3888,10 +3870,44 @@ static void read_packs_list_from_stdin(void)
 		struct packed_git *p = item->util;
 		for_each_object_in_pack(p,
 					add_object_entry_from_pack,
-					&revs,
+					revs,
 					FOR_EACH_OBJECT_PACK_ORDER);
 	}
 
+	strbuf_release(&buf);
+	string_list_clear(&include_packs, 0);
+	string_list_clear(&exclude_packs, 0);
+}
+
+static void add_unreachable_loose_objects(void);
+
+static void read_stdin_packs(int rev_list_unpacked)
+{
+	struct rev_info revs;
+
+	repo_init_revisions(the_repository, &revs, NULL);
+	/*
+	 * Use a revision walk to fill in the namehash of objects in the include
+	 * packs. To save time, we'll avoid traversing through objects that are
+	 * in excluded packs.
+	 *
+	 * That may cause us to avoid populating all of the namehash fields of
+	 * all included objects, but our goal is best-effort, since this is only
+	 * an optimization during delta selection.
+	 */
+	revs.no_kept_objects = 1;
+	revs.keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
+	revs.blob_objects = 1;
+	revs.tree_objects = 1;
+	revs.tag_objects = 1;
+	revs.ignore_missing_links = 1;
+
+	/* avoids adding objects in excluded packs */
+	ignore_packed_keep_in_core = 1;
+	read_packs_list_from_stdin(&revs);
+	if (rev_list_unpacked)
+		add_unreachable_loose_objects();
+
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 	traverse_commit_list(&revs,
@@ -3903,21 +3919,6 @@ static void read_packs_list_from_stdin(void)
 			   stdin_packs_found_nr);
 	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_hints",
 			   stdin_packs_hints_nr);
-
-	strbuf_release(&buf);
-	string_list_clear(&include_packs, 0);
-	string_list_clear(&exclude_packs, 0);
-}
-
-static void add_unreachable_loose_objects(void);
-
-static void read_stdin_packs(int rev_list_unpacked)
-{
-	/* avoids adding objects in excluded packs */
-	ignore_packed_keep_in_core = 1;
-	read_packs_list_from_stdin();
-	if (rev_list_unpacked)
-		add_unreachable_loose_objects();
 }
 
 static void add_cruft_object_entry(const struct object_id *oid, enum object_type type,
-- 
2.50.0.61.gf819b10624.dirty

