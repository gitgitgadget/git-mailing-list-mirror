Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AAC26FD99
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375824; cv=none; b=ZbZM3TzpIjHtHKMc5sB4eQ6UMDE6JqevsxNxa1dYB59gan1K7MU4ZdBQ2WGjdUCLLwHC6x1bdJ7XLRp232z8b3QKlk7WMwVxiOQxt4ON28WkNp3uTfjcaOn6R59J+7tn70F0VkxAQICFOrbaiX7ugpCF+Ed5n+TeE5FxHGxLmR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375824; c=relaxed/simple;
	bh=qE8CzP0T/Or+iU+ig4VFfRCph9L26q2SFXnQRaY8B5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zoi6KWFXSM2DxgTPtupGdkEtJSl4gsQYWuh7kw/TV92FFw52y5FRbkYP8HlUoaRbqwra6Bk/JtkMt74VehK2J4EnaA0q5RcaPem4ukfu9u7Pmf21n/WUVcCS2u/rTDH69u9M563uk6afN4hzh8gRY6HRi1rDSW4ROH/sg/XedbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=i2YBgecC; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="i2YBgecC"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-712be7e034cso9388847b3.0
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 16:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750375821; x=1750980621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8tjsZTP9c6/fhyQYQET/qipFgxXyvG46sCzU0dmd+HY=;
        b=i2YBgecC++/LsN+C9np2lohcqcgUsAUggk8oNPbYsDOLVE8j8Mh8ouKJ9iLwbkHrm9
         a7eSEQKRWwyR+Q9DZaZtWswc/L9cWoV03n2jp38mCLqg3VLhsiAbYzhzDCze/i6iF0+K
         meRWdXJ54/rjAtoZe2PmGtyffHMgR2ntYy5ArTzPQMIoF7AyxrN7XHIsclM3bO8YLYwr
         xoPzhGzhyHSSFh5LEnE8esiImBFGqEr1Yn/16C0WeLvJYDP6UzKuq5uLkmV1Ko7g1WUL
         1LejQs0Aqr8XuOjR9H7rkE6waHTJFqXkLrR0QlmRsoYcN720zeZsilR5g+bwKMTjnskn
         kY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750375821; x=1750980621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tjsZTP9c6/fhyQYQET/qipFgxXyvG46sCzU0dmd+HY=;
        b=svYSRs6UEh82eoPKWUwdh244nHKTFCtu+kCsoWcBYFhK5QeROA9jOkGwWb+VUnhOyn
         imvMjnSwHXGdwW/F9DS6ycmrIFmjaSPaRl5rXBoYEPyzBaCrYE8f0JXleMw2m0w9zvCa
         gq2Cq4zwV0zOgMuMPi58IuF8cMZl7sJRZUWp0yozhf4LuiBqkwF9oEejuiEFe/184L6V
         5mnGnaT38gq0V1hZWWt5awhQcq5R3wMdYmvyXVjNBoDIzw8d+UoOTIh2Q1/oLhGAzRzy
         EPA/yscr5HV8bxSlmgev5Vb5Q5eokpPxQTBSRECFk0r037A36KYfs4kl+xbtbQTffjWr
         D7pg==
X-Gm-Message-State: AOJu0YzvlZkKUCRp3ZlQWHYpjww/O3uDtLzFtU51c48EQ6YoOUFwf2E1
	j0AQA+5oUyB0voSoIymHf3sRx0Dir5YGPXoQZPk3v4V/mr4AFcb69tCtvTnA4cbORIEV2v0bm8n
	SEyyt
X-Gm-Gg: ASbGncsV+7/53ukBiHe7llQ8hjfCvS8VSAC3WYwaj9a1VOsyPRKpfHi6sczfcAgOzAJ
	/8EjeS3qi4VCF5HDL9qAiHLspJZZbUOes8AIgSPE8N1fIpKTjzEYuwS65JBl6ytD468Nw8CWxNk
	RbwmICP38GNcoqZhqVCRUrF0MNPw3VEDD7xKDt47FT1efh3UygzvTNlJp7aftxVzLl2KYm9UbFg
	z2Mb0uxS+AKZdK22isQvwTOgIzcn3cTTRyJNjpdnPqKFr5k+/KEyrB5NeyYDZHcm6cmZ5LSTASM
	o1rRgqLJVLmnVYKDd8OnnQ9K0zT6qhbR0mhVDEF0UZB4hP2YCd7GcT4vMUZ8mOPR9cmLMiSxnCq
	bcZ2Psi6yrovhkYcEmLUX6fn3939N0T5lQw==
X-Google-Smtp-Source: AGHT+IGDvKnLiBCQ9J+lPLCCUOyy1fYfGU1h+vmDAfCKRhKwobtF0gcQYMbgI0GH7Lf7Shn5o/nS7g==
X-Received: by 2002:a05:690c:6:b0:70e:a1e:d9f8 with SMTP id 00721157ae682-712c64f520amr13687487b3.22.1750375821608;
        Thu, 19 Jun 2025 16:30:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c4c212c3sm2006227b3.117.2025.06.19.16.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 16:30:21 -0700 (PDT)
Date: Thu, 19 Jun 2025 19:30:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 5/9] pack-objects: perform name-hash traversal for
 unpacked objects
Message-ID: <2a3676cb86a778ced0e24efb8a07dbd8222ea64d.1750375803.git.me@ttaylorr.com>
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

With '--unpacked', pack-objects adds loose objects (which don't appear
in any of the excluded packs from '--stdin-packs') to the output pack
without considering them as reachability tips for the name-hash
traversal.

This was an oversight in the original implementation of '--stdin-packs',
since the code which enumerates and adds loose objects to the output
pack (`add_unreachable_loose_objects()`) did not have access to the
'rev_info' struct found in `read_packs_list_from_stdin()`.

Excluding unpacked objects from that traversal doesn't affect the
correctness of the resulting pack, but it does make it harder to
discover good deltas for loose objects.

Now that the 'rev_info' struct is declared outside of
`read_packs_list_from_stdin()`, we can pass it to
`add_objects_in_unpacked_packs()` and add any loose objects as tips to
the above-mentioned traversal, in theory producing slightly tighter
packs as a result.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4258ac1792..3437dbd7f1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3879,7 +3879,7 @@ static void read_packs_list_from_stdin(struct rev_info *revs)
 	string_list_clear(&exclude_packs, 0);
 }
 
-static void add_unreachable_loose_objects(void);
+static void add_unreachable_loose_objects(struct rev_info *revs);
 
 static void read_stdin_packs(int rev_list_unpacked)
 {
@@ -3906,7 +3906,7 @@ static void read_stdin_packs(int rev_list_unpacked)
 	ignore_packed_keep_in_core = 1;
 	read_packs_list_from_stdin(&revs);
 	if (rev_list_unpacked)
-		add_unreachable_loose_objects();
+		add_unreachable_loose_objects(&revs);
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
@@ -4025,7 +4025,7 @@ static void enumerate_cruft_objects(void)
 						_("Enumerating cruft objects"), 0);
 
 	add_objects_in_unpacked_packs();
-	add_unreachable_loose_objects();
+	add_unreachable_loose_objects(NULL);
 
 	stop_progress(&progress_state);
 }
@@ -4303,8 +4303,9 @@ static void add_objects_in_unpacked_packs(void)
 }
 
 static int add_loose_object(const struct object_id *oid, const char *path,
-			    void *data UNUSED)
+			    void *data)
 {
+	struct rev_info *revs = data;
 	enum object_type type = oid_object_info(the_repository, oid, NULL);
 
 	if (type < 0) {
@@ -4325,6 +4326,10 @@ static int add_loose_object(const struct object_id *oid, const char *path,
 	} else {
 		add_object_entry(oid, type, "", 0);
 	}
+
+	if (revs && type == OBJ_COMMIT)
+		add_pending_oid(revs, NULL, oid, 0);
+
 	return 0;
 }
 
@@ -4333,11 +4338,10 @@ static int add_loose_object(const struct object_id *oid, const char *path,
  * add_object_entry will weed out duplicates, so we just add every
  * loose object we find.
  */
-static void add_unreachable_loose_objects(void)
+static void add_unreachable_loose_objects(struct rev_info *revs)
 {
 	for_each_loose_file_in_objdir(repo_get_object_directory(the_repository),
-				      add_loose_object,
-				      NULL, NULL, NULL);
+				      add_loose_object, NULL, NULL, revs);
 }
 
 static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
@@ -4684,7 +4688,7 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
 	if (keep_unreachable)
 		add_objects_in_unpacked_packs();
 	if (pack_loose_unreachable)
-		add_unreachable_loose_objects();
+		add_unreachable_loose_objects(NULL);
 	if (unpack_unreachable)
 		loosen_unused_packed_objects();
 
-- 
2.50.0.61.gf819b10624.dirty

