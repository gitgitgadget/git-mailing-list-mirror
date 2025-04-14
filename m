Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAEB1D932F
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661192; cv=none; b=BMRliCMxjPo/Jo9lLJxbIfx1V9rPCDlqXBQ0UzXnzlTqdnPGI7bnhVO8yWRWbHwkBT7OkrJFkP2zRJtk7erL3dlyg3hYLsUqyU7THEdd98iO3iPCtOhKG9rMQv8Xdl6aVo5ud9ymnXKrGH7svD8e4KG2iI8rOMqpngfimvjofns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661192; c=relaxed/simple;
	bh=lUjEijBrz6eFNy3rTnXqcceqZ1J11Uio3zKaneWn4q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFhxFS3GDmNpPS/d5PYU+7s3xwS4Gj+HzstGoFZUeBNUqFV3nraMMDYMUhNIHHHV0objitsMPV0Hgxw4O6jn0G0REsk7cteFrThANIIzIRO1g2zSejZv64xJAOz3l0sbTsnLuYjmsGERt6y6Z91ayBMfKe0+zElPWK6bFW1EBg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=L3Fou75+; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="L3Fou75+"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476b4c9faa2so59875051cf.3
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 13:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744661189; x=1745265989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ta68wrHQJWlsItQAJMkpI6v6R+QCHjrjWbFQE5386g=;
        b=L3Fou75++c4TSCx9/sFjCZZ8DYI86Rvbq5kfqF4egddo9YgBzFtS4QzzOOAJbwsAkp
         JdqsGP2FAnWJoBjPcz7xve5L0TOy7CzTsBTORSLD/EfNzYjUSWKFcxdOXbcyQHLqdK4R
         uXrEhG7fVQS7BgSIN0Y/C0DSV+mjYLFk+h33/9zO9WXckE7PdUplkbCv0FdiYr4lURS4
         Teti4GHNoimilWBGhSFC3xPSMTcbdu/lCFNKTkrQ0LRj487xQ1O0ZLlHkBIx7MbG7bHU
         YM6MCBliF1ixiup+UgbxV7Nls6nADn83uMg/aWiazg3ypSCScQIoJODhD15/3pnc8ilp
         YV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744661189; x=1745265989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ta68wrHQJWlsItQAJMkpI6v6R+QCHjrjWbFQE5386g=;
        b=ihOBTxnYR9tEKh4K+cTBgk9oY4T83RVg43BZxwQBmwBFWEJz4bqiMRtUEQfHQ7XWXT
         ADtVdfCrpiY/HyMd10ySMTEhmyd6ljqnxaDorD0YrfSlmWDCuXryLA3B7++OijiW03Vk
         RJmRqtl1C6UDi9OxKQb2B+NvwVO8I0FNez84gmIohPx9NL+nWyt12ul48JJ36wd/UMf8
         ClUIyZz1eA9cSujMBlnm/un+BPQ4HNS+L+kMHWEyVC4zFPYtjXCpQSkmosPVfGKHVW4K
         Extwsw9MFyPGWhpx0GZa3eFYbWxiI33Gs0wpM++RvMZAs4P1KouTTO9YmkP60H/G/WSz
         83Aw==
X-Gm-Message-State: AOJu0Yz4YYkpOItV30BDykc3v5JPoGagyDJdC4r1penATYNsSXBomfEX
	6WSPYEowpd6Jr9tUwEZ/QZwDvTFmfO833co/MK8kCU+PMllH+RydkWgBdEXQEF/iM+YpGOHc3tr
	n9l0=
X-Gm-Gg: ASbGncvKUz3PG6P+O+mb3w3mJyW200/H1wfVCIKTgyh6GtLhWkp9q3Sp40YbygeEl5T
	0rjXADwpUIKZJEUM2+WZnekIgFj/nsbtOKIR7jKspqGFudxM3rdTTvIIQ31OS0VdzWyGuwB9SJW
	EPP1pB21smdmDi+Vl57PvftWea08TA6phuyhTAz8C+lVYYaCWHGJoOQX0lccXX/ji/stWFyuXCh
	Gl1u+x/S5W1YlOoC6yIfM1f4F6Bs0Z/MaTfq/wUMVtTHWsSZYcJgiV08NRjJh59fnDadqd2R1K4
	nR/O5uSlm3isunUZbrtOVYnNFC43lKouE0Dor4of7W2hhNOgvgDMIAoDXLREr4W/vRl8J8cagyB
	AYckJeAWoNYgSwYr+0ZYkFzA=
X-Google-Smtp-Source: AGHT+IEsmnugAbCyVUqLK5ApjBjFmWDGL+THqEhe9aUzpn8UZ+Kxs+hXDZgt70Zuadr5bIcRwZHyZg==
X-Received: by 2002:a05:622a:1897:b0:477:e78:5a14 with SMTP id d75a77b69052e-47977516f33mr186894231cf.3.1744661188678;
        Mon, 14 Apr 2025 13:06:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4796eb15cd8sm80344691cf.26.2025.04.14.13.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:06:28 -0700 (PDT)
Date: Mon, 14 Apr 2025 16:06:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/8] pack-objects: perform name-hash traversal for
 unpacked objects
Message-ID: <0bc2183dc39a949d7eef08d282994231543d4c26.1744661167.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744661167.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744661167.git.me@ttaylorr.com>

With '--unpacked', pack-objects adds loose objects (which don't appear
in any of the excluded packs from '--stdin-packs') to the output pack
without considering them as reachability tips for the name-hash
traversal.

This was an oversight in the original implementation of '--stdin-packs',
since the code which enumerates and adds loose objects to the output
pack (`add_unreachable_loose_objects()`) did not have access to the
'rev_info' struct found in `read_packs_list_from_stdin()`.

Excluding unpacked objects from that traversal doesn't effect the
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
index 1689cddd3a..2aa12da4af 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3642,7 +3642,7 @@ static void read_packs_list_from_stdin(struct rev_info *revs)
 	string_list_clear(&exclude_packs, 0);
 }
 
-static void add_unreachable_loose_objects(void);
+static void add_unreachable_loose_objects(struct rev_info *revs);
 
 static void read_stdin_packs(int rev_list_unpacked)
 {
@@ -3669,7 +3669,7 @@ static void read_stdin_packs(int rev_list_unpacked)
 	ignore_packed_keep_in_core = 1;
 	read_packs_list_from_stdin(&revs);
 	if (rev_list_unpacked)
-		add_unreachable_loose_objects();
+		add_unreachable_loose_objects(&revs);
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
@@ -3788,7 +3788,7 @@ static void enumerate_cruft_objects(void)
 						_("Enumerating cruft objects"), 0);
 
 	add_objects_in_unpacked_packs();
-	add_unreachable_loose_objects();
+	add_unreachable_loose_objects(NULL);
 
 	stop_progress(&progress_state);
 }
@@ -4066,8 +4066,9 @@ static void add_objects_in_unpacked_packs(void)
 }
 
 static int add_loose_object(const struct object_id *oid, const char *path,
-			    void *data UNUSED)
+			    void *data)
 {
+	struct rev_info *revs = data;
 	enum object_type type = oid_object_info(the_repository, oid, NULL);
 
 	if (type < 0) {
@@ -4088,6 +4089,10 @@ static int add_loose_object(const struct object_id *oid, const char *path,
 	} else {
 		add_object_entry(oid, type, "", 0);
 	}
+
+	if (revs && type == OBJ_COMMIT)
+		add_pending_oid(revs, NULL, oid, 0);
+
 	return 0;
 }
 
@@ -4096,11 +4101,10 @@ static int add_loose_object(const struct object_id *oid, const char *path,
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
@@ -4356,7 +4360,7 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
 	if (keep_unreachable)
 		add_objects_in_unpacked_packs();
 	if (pack_loose_unreachable)
-		add_unreachable_loose_objects();
+		add_unreachable_loose_objects(NULL);
 	if (unpack_unreachable)
 		loosen_unused_packed_objects();
 
-- 
2.49.0.229.gc267761125.dirty

