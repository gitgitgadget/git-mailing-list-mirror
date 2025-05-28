Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C87E222584
	for <git@vger.kernel.org>; Wed, 28 May 2025 23:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748474426; cv=none; b=T0J4KVYO/BJTLXNLlKyJ4bwi0j51GVT3pjUdf9XUUXcM7+kEp8s0jsvSHdJqgqE7ypVy/OyqcRDUGyfE3aTbDf8fBpqzLdB/j5SZpOjqYdwkBg+P/gC3LqW0nN6bxkRZTNLa3xcljRwRBhWCoFPwKxgz72cv5rpGaXGaqCERJZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748474426; c=relaxed/simple;
	bh=j3B8iZVfste5/ccjBpGYkJvgX9g68aTpFrS7CfXHke0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImyUf3JTeUJh7ItbeWAdiC6zYUqWfHg5GQ1UQAACU4iz8O+tn/3OKxkMvMKkUXYacgFBLQbgfhms4MthdXFNcDszl5zTzu4vmYvDwZnn6/ib4ZQpcr3QVIvsaQI3fo2iC0n8tOwDrV8C9qKpCOg1ECrix/2TNJWNKQ0YShSfTzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=kUouNwo2; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kUouNwo2"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70e5e6ab7b8so3704377b3.1
        for <git@vger.kernel.org>; Wed, 28 May 2025 16:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748474423; x=1749079223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eOWcTUquREXYo009ZitiwzthZ7OWukgBc/oiwwrz9dU=;
        b=kUouNwo2F1IF4w2/yBGjq7sTO89ipWV70VGJuHx7toBlR/kbsKaDb1jaQ4rhKvmzAR
         7lqMlrFdSRQzZU2vRfyNPSY66kpX6O3Vv8L9rSlfg2JAjmWLuSyrJ5Dx86Jb3bLS7zup
         MYyydUgLi4twZkUYQAmpOPUHdjB9i7OI9saP9GTMecCQEIXiNXhsvewv4TNwwXLcjhFs
         CKR6sOMke4ME6DX7gjmT7XFq097F5tyxb/a74cfTrVHBgewpPPSHOLQGz14km7U/6vYq
         b0btmtTEn07bEnAdX0Dd4elBU226xt+jEDqekVgIPK5SBart2RnTEEwSCPtp6kHkEG6l
         vFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748474423; x=1749079223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOWcTUquREXYo009ZitiwzthZ7OWukgBc/oiwwrz9dU=;
        b=dUEFIUrxssu+qzTVwqSKLNg9FVHBCoqtFgz5yPKfJedBPKQ1aF0LyA6s5Fj3iooGTw
         Hrjljp4Mzj3Z+ZS47YBZ/E8S7lJJZVFEt9l6gXyEX+EfR6D1QTtbx/gT6EtLT45SjwFh
         R7HMag8cQ7zHLLJEMWwyMdac70bZpduMdIJY9outEYPJSdQiyZVw+lVIdiXOyDMdIsdt
         hO/zNIwXZEtSPqIwnMRWALdKUkcldyWjEP+2iS4hfM1GAOJVyR5/pr6zXrlkJkM0pFbZ
         leK0brZSDI971o6jQSD9TpFsSoLWLYnxOsvB2RdfRS2up/TIAqzqSfs5bPZ9JbHEMdWR
         dGVw==
X-Gm-Message-State: AOJu0Yx0Bf3N7Mg3C6X8ga/TLFPHfSwdOwzZErwxritxTaC7HQOpmZDX
	/BKQWUSFUBL1qxkBGClglFowKPp8vhTacLjI5OevPaX6teZaqkeshy9hRKmHZpngkI/GvittDk2
	VPOEM
X-Gm-Gg: ASbGncuhvqrq9Cau/mHbwrO5aBbxodN87KrUW6RGlyuWCGpxCWoKJzRuaVhfrd9WSpW
	P58ZVkExM6aj+pHQRET7YRhECnuIwfvOIJIoPVxGE4s9iclMLvUGn0VuQQJcLXJI/AcVjOwAf3Y
	FDnYIr5IM2F+MMqvPRNMhpGhmp/Nj0kzo0UV1K0JlRzh6HYvjd0/dj9B5QVA1q6SpEhz2JLn7xp
	8SCdCugRmMumR78QknqIR1cMpXELJlwjOJOuYGtxUDACQD7hR2CZX2zHWxELlFV10DMuGL8TjQT
	Rt8yLBXwbQYxeX9+rB0LAVGJL3t1ngxlTk2TwBbacFBJ1md0SU972lPg/cRlNssjVtf/NaE9oqc
	p2IQQf2pZKzdPFzvouzEoD00=
X-Google-Smtp-Source: AGHT+IG93V1Fae8G2Acy5xTqWjgzJfm9IBIrP9pb2qM9I/LgXg7UosIcgdkC+bHzgCVpRy+fLhDJFw==
X-Received: by 2002:a05:690c:6204:b0:70c:b221:adee with SMTP id 00721157ae682-70f3125945amr68014737b3.1.1748474423481;
        Wed, 28 May 2025 16:20:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-70f8abced9bsm399427b3.19.2025.05.28.16.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 16:20:23 -0700 (PDT)
Date: Wed, 28 May 2025 19:20:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 5/9] pack-objects: perform name-hash traversal for
 unpacked objects
Message-ID: <29bf05633a45cf2fe439f540c675a75b5b3cf690.1748473890.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1748473889.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1748473889.git.me@ttaylorr.com>

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
index 88071b4d8c..359f0c3c30 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3644,7 +3644,7 @@ static void read_packs_list_from_stdin(struct rev_info *revs)
 	string_list_clear(&exclude_packs, 0);
 }
 
-static void add_unreachable_loose_objects(void);
+static void add_unreachable_loose_objects(struct rev_info *revs);
 
 static void read_stdin_packs(int rev_list_unpacked)
 {
@@ -3671,7 +3671,7 @@ static void read_stdin_packs(int rev_list_unpacked)
 	ignore_packed_keep_in_core = 1;
 	read_packs_list_from_stdin(&revs);
 	if (rev_list_unpacked)
-		add_unreachable_loose_objects();
+		add_unreachable_loose_objects(&revs);
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
@@ -3790,7 +3790,7 @@ static void enumerate_cruft_objects(void)
 						_("Enumerating cruft objects"), 0);
 
 	add_objects_in_unpacked_packs();
-	add_unreachable_loose_objects();
+	add_unreachable_loose_objects(NULL);
 
 	stop_progress(&progress_state);
 }
@@ -4068,8 +4068,9 @@ static void add_objects_in_unpacked_packs(void)
 }
 
 static int add_loose_object(const struct object_id *oid, const char *path,
-			    void *data UNUSED)
+			    void *data)
 {
+	struct rev_info *revs = data;
 	enum object_type type = oid_object_info(the_repository, oid, NULL);
 
 	if (type < 0) {
@@ -4090,6 +4091,10 @@ static int add_loose_object(const struct object_id *oid, const char *path,
 	} else {
 		add_object_entry(oid, type, "", 0);
 	}
+
+	if (revs && type == OBJ_COMMIT)
+		add_pending_oid(revs, NULL, oid, 0);
+
 	return 0;
 }
 
@@ -4098,11 +4103,10 @@ static int add_loose_object(const struct object_id *oid, const char *path,
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
@@ -4358,7 +4362,7 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
 	if (keep_unreachable)
 		add_objects_in_unpacked_packs();
 	if (pack_loose_unreachable)
-		add_unreachable_loose_objects();
+		add_unreachable_loose_objects(NULL);
 	if (unpack_unreachable)
 		loosen_unused_packed_objects();
 
-- 
2.49.0.640.ga4de40e6a8

