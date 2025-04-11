Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEBF2BD5A0
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744413998; cv=none; b=iWZp/vShQvJAcZekBVbynEURc0aZPGR+Je8jfTvy0B5J6+bZuwgfJoQ06oYacZGMMiQIr3Kidek7PXzh2OCq/LQx9huRdy+cpV9GGI+97GycuxyQhKUfk1BEVqrZSDirkqUqGpmaHj+PfqOBDYtWQRXVNRLQ4qui5bS8LV2w1vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744413998; c=relaxed/simple;
	bh=03m2k/L/wccVCoTux+ddNl66+4qbLVpJXlgNog235u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZyqtAaYBvDroNxATgJJsfKQbKgNVGQ/4c5AULM2g13hULaiaEt/1n4dsuvLMExhOVQnqJkkQKauAWVTyAV6ib7tGffCNPEOvff+PLmNMKYDos3N1vjLNfFQLCUcr2DqrVjn2R9gUeFMVnCMzz2X/syl1rXB5/iOpT/aEml48ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=DkzsdWaz; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DkzsdWaz"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5b2472969so258522185a.1
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 16:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744413994; x=1745018794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=52sRGsH+u5pDHgJMEAlwVbs/+v0K18dKhSGwVtF+xyU=;
        b=DkzsdWazTe3sWVb0wYvBZnZEsXEYXLeQ/euAbe+qtmglrFub2X1oxQrWONiHbNiEg/
         7htJEbGF7m3Nl+g4N+mkDoF7sOgUkYSPp24fDjpBWiLbzS/R7TpenQBTuFLyCPhn/gwr
         Kw4qt8EG40MbKz8V5/ALBqbeuOp+fyx+RmhQCAghaczCKLvbeWuvkDfyLodd90bCPLxf
         ua8Wdv14m4kP8UPDiYcAOPDrFbe2ge/ukoCrX26TchuZkkU6eItpLutcNzBpT4N0SmxL
         jZiwZ/hpgAaFskcMp+UjW0zA7MrwMW67aIphpM+vpyLjhKHPWUoDtHeIdfLlNd7cEutZ
         qJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744413994; x=1745018794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52sRGsH+u5pDHgJMEAlwVbs/+v0K18dKhSGwVtF+xyU=;
        b=fLX+b0pzRtGXUtKnTGGFIiWfR9k3xeaZMF/60xAH7vcbEnlztEXAyyDO9kANPXqIVs
         LxLs0CGHr3JtCnbzA0aMlA9Uks0U0bQn/SvfGKEj/oozjSDsrS3y1LShaPDXsa6u8hCW
         f3E0nTN0oJKAQ9gHGWF6Nj7+UHfRF5gA0NBE3rFEqvwQEySz9ZgedsXiviXRfcsu8ywq
         QO1K3UamyfF6R9v2fMPROCQ3c6VEJZ8HGTalVabhxL+c+3vR1mxe6Z8q7z7Tw7OX5lIq
         nWyVW0IfSSnZzbjaLhdAdGsChkDkTUjKg0V3JtgztZt9xHy4SBpwmquRuzlVCPQiWLyd
         sTgA==
X-Gm-Message-State: AOJu0YwHq0ybZGlnGu3pvdoI9xQEbmzg5B4EV7YmemP74Ad/TsMwlRjY
	egevjQHdnA8DDR49ejxpRo6Wgal9ZZQSA+ERNyIxFOmDQSuHmIlHpBdxJSAiCSpPHXdTObFHQ9k
	x1hE=
X-Gm-Gg: ASbGnct3Y/kl7UDfW7/qQbCW8Ly6S25LlGTgOzaany8scLrpE1sol2+ucJGOuSDFvP7
	ai1LKnBpzV+NXa5aKSwABu5AMUsa1Xw+i0iI/azZ0x+nYD/IA5dy9zWsiEJA3cId9Z4sKuDCI09
	FfRdnApQ83ae8t7rN4D8nblyM0CxhHkMD0LXVA2PLhxGoT4Yk7xZD0U5OuixVm4AyUf6X33hsVb
	qMxumc2dUrqFL26H3JW50Esj5RI6c22RQja6KSMAPmAoBXwd0R++EsDZlTZEcFT2sncd6FMvnd7
	gmmYZOlde7Jhw3ewWQu0XZ5KtScbpiajWd3troDf1ujgrGYLAJXW7YyS//Aayo3t+cVt6jo7wTh
	3NdlBF16uGxAl
X-Google-Smtp-Source: AGHT+IGXkCD/IDkF6Eg2JEnGu5+phsatASwdmstwYpAEra1cZOx2gBP+Ml4yQcm4tLQqj3gMgYo3pQ==
X-Received: by 2002:a05:620a:2806:b0:7c5:4b91:6a41 with SMTP id af79cd13be357-7c7af1f41f7mr620280485a.42.1744413993748;
        Fri, 11 Apr 2025 16:26:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a8a0e5efsm328457485a.108.2025.04.11.16.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 16:26:33 -0700 (PDT)
Date: Fri, 11 Apr 2025 19:26:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 5/8] pack-objects: perform name-hash traversal for
 unpacked objects
Message-ID: <241f7c87e52c4123d0e00d75f5af201bd37fcfd4.1744413969.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744413969.git.me@ttaylorr.com>

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
2.49.0.229.g19b69c1246

