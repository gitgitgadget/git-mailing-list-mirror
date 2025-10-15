Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A8E30E83B
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567355; cv=none; b=hdtF3ZMWHYVdrYdARDt/z+RWxmDBjuBwfdhgA6x+rWeh8iH4U7CICvevk1+Bm8/wLMGlwR8uFUj4vF9gwEVlQicJyLFIQjqnrQkz54fmYEQSKt3Nzqi+GdtWdicKY6i+jxBO/iwtRE6AfpyVr5GiWdxHni9V4q0MqgZMtzC7xSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567355; c=relaxed/simple;
	bh=+LNvKo0wFxNlfgCWL/AcBP8gBnSnQfUvOyzAnxl2KXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/tnJbd+9ekyox6ENTKeoX8dqYLEVziBnsOzcZbBmUKb53/tfOYtBfzd/PLF8dRcU8GN+bhpRtRv9+eKwx34jvKPQ7iQjDNvouihxW9GbGXbLkpetetf4NWTSPr12AhhT3f25Aa7cg/NbmjyTTLpa6HqEbUR6jSjaS8CA4lEomA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=PUi8IE/Y; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="PUi8IE/Y"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-77fac63ba26so753187b3.3
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567352; x=1761172152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cPY349WmxLkKZXkA/2foEKdnT8p611QX2o65Ek1eHbs=;
        b=PUi8IE/Y9tIikXkFHf/sRItl5TGR5u/qUgrycmg3uKIcxQbiuq3jtYNwRi6SGLyM/+
         eBfXdygkq2mAVzW0ygkQTSk7b67fziDRYwmHrPsxBwPwuE+VKE42vaIRl4kuZ78Q/Y5M
         2gUQgig0veagmNUWY3HN1ArfCBTbECKmhFRR40Pf3GLO32Fi83JSv+J+s6fkcs3CV65z
         39HtJJBrG9aMk0pQsJGNYNm24sXR8IGH27thRXsarzI0EjW+vGJAZcu6WeNE8pPfVphC
         oS5C4tZ2STVP9uE4X0gFyGkcz5/ilx/aB3kdu+b67CFMRopQu8RXliTWb9DvmAb7/F9F
         V+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567352; x=1761172152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPY349WmxLkKZXkA/2foEKdnT8p611QX2o65Ek1eHbs=;
        b=d51Nacd0YtVjLi8xdKmQ7Ohg4FXgkxbsaJNtRfzb1fNSbV/WVguAZ4g6ygTZH120ML
         +lbgmkWqauVT4TYNM19hejsg33cU8EyCfnJzD7Yfnwh4yIVQ/59knfv9Odwpigd6olsF
         X7/O5FKCzAE4ytHHZqZEqKUunUEuxI8yV0yvYFDKCEwGZJhm6ace6QrXoT7lWDpLMU1S
         zLshtU4Kz/ANBgonnmrv8XOQ8CLD4W3ZSKb98AJE0pn9uxmdfSEl/EKqKm7SHKiTRJ5l
         btzWuPGS4AgV2mCD2/YjZzm1I7t+Bb6eMKS0rhtQUfDBheKHM12ehF2XGil3udQSLMVp
         rEKQ==
X-Gm-Message-State: AOJu0Yz1R5bLulIPKuhiR4ZysvbunkkQrz/AI7e6bZ2NJxRcdft3kCrA
	Meka5cZExfdtk0X9LwUV9mStsFiR1K9BxpRhU1mE7DbKn3Ll75YQA3oFIjUm7hl2yd3yB4w2kAL
	z8R9goQswZxgs
X-Gm-Gg: ASbGncszHH2Mss5gG/jprquiYYPDJA08wAUGt9aziL5KfWVjwlaKvMXlgRWv+zipsup
	MuNiQOoz4nz5uh3VgCWhNLDPa1pK08q1NwlIvkZpWmiz2Rw3ATF9u6CeYoR3na4SooaxfexsI+b
	riT3e05hMB+WezcbWht13wErADiYu4KTGTIvEOrJuRHjupttvd33Z8WsupgDpgG1X6E2ThI+gYv
	+WRFWesaROfpOU6V+0AhIhkbnKsNn96bVAcTrlOLHE4KedGLcbojc/FdvRa1cDVcV7xC7wMV3Jm
	zN5/3sJDDQDbENNgf0QKpeoAQbIfTYEr3HDHi9NyLGbi0xViVPZbCSRVnRHvjVlj5FqGflJyTDJ
	UNSLo4ZRiY9qUd33EWLlQ7bWOcBYo8z5myZv8pvXxN/+s+VWbdME+jQdYi67NL+USgrSQURtRuc
	v7XmFcjovgZoi6OY3MI7EPY1bQhO2hFJuIIruzSk6a+n8AekxbKT2+lS8hbJgECZ+rXmCQRmIlo
	41847RwN/IMxjvpCQ==
X-Google-Smtp-Source: AGHT+IHoicO4UMS1Ux43WzQgjeeCudqX077Zy6SdtMXGQlbCKBxoB7ngFikz3h/E/WCu8I4T3b0T8Q==
X-Received: by 2002:a05:690c:67c6:b0:781:44f0:5ef with SMTP id 00721157ae682-78144ff544amr85267277b3.51.1760567352171;
        Wed, 15 Oct 2025 15:29:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7828d4c5209sm2751597b3.24.2025.10.15.15.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:29:11 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:29:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 38/49] builtin/repack.c: inline packs within
 `write_midx_included_packs()`
Message-ID: <5bd43e96f29038f1a5fe5064ce40053997125cd9.1760567210.git.me@ttaylorr.com>
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

To write a MIDX at the end of a repack operation, 'git repack' presently
computes the set of packs to write into the MIDX, before invoking
`write_midx_included_packs()` with a `string_list` containing those
packs.

The logic for computing which packs are supposed to appear in the
resulting MIDX is within `midx_included_packs()`, where it is aware of
details like which cruft pack(s) were written/combined, if/how we did a
geometric repack, etc.

Computing this list ourselves before providing it to the sole function
to make use of that list `write_midx_included_packs()` is somewhat
awkward. In the future, repack will learn how to write incremental
MIDXs, which will use a very different pack selection routine.

Instead of doing something like:

    struct string_list included_packs = STRING_LIST_INIT_DUP;
    if (incremental) {
        midx_incremental_included_packs(&included_packs, ...):
        write_midx_incremental_included_packs(&included_packs, ...);
    } else {
        midx_included_packs(&included_packs, ...):
        write_midx_included_packs(&included_packs, ...);
    }

in the future, let's have each function that writes a MIDX be
responsible for itself computing the list of included packs. Inline the
declaration and initialization of `included_packs` into the
`write_midx_included_packs()` function itself, and repeat that pattern
in the future when we introduce new ways to write MIDXs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a518a2b2f3..fad10be42a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -109,7 +109,6 @@ static int repack_config(const char *var, const char *value,
 
 struct repack_write_midx_opts {
 	struct existing_packs *existing;
-	struct string_list *include;
 	struct pack_geometry *geometry;
 	struct string_list *names;
 	const char *refs_snapshot;
@@ -330,12 +329,14 @@ static void remove_redundant_bitmaps(struct string_list *include,
 static int write_midx_included_packs(struct repack_write_midx_opts *opts)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct string_list include = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
 	struct packed_git *preferred = pack_geometry_preferred_pack(opts->geometry);
 	FILE *in;
 	int ret = 0;
 
-	if (!opts->include->nr)
+	midx_included_packs(&include, opts);
+	if (!include.nr)
 		goto done;
 
 	cmd.in = -1;
@@ -397,14 +398,17 @@ static int write_midx_included_packs(struct repack_write_midx_opts *opts)
 		goto done;
 
 	in = xfdopen(cmd.in, "w");
-	for_each_string_list_item(item, opts->include)
+	for_each_string_list_item(item, &include)
 		fprintf(in, "%s\n", item->string);
 	fclose(in);
 
 	ret = finish_command(&cmd);
 done:
 	if (!ret && opts->write_bitmaps)
-		remove_redundant_bitmaps(opts->include, opts->packdir);
+		remove_redundant_bitmaps(&include, opts->packdir);
+
+	string_list_clear(&include, 0);
+
 	return ret;
 }
 
@@ -994,10 +998,8 @@ int cmd_repack(int argc,
 		existing_packs_mark_for_deletion(&existing, &names);
 
 	if (write_midx) {
-		struct string_list include = STRING_LIST_INIT_DUP;
 		struct repack_write_midx_opts opts = {
 			.existing = &existing,
-			.include = &include,
 			.geometry = &geometry,
 			.names = &names,
 			.refs_snapshot = refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
@@ -1006,12 +1008,9 @@ int cmd_repack(int argc,
 			.write_bitmaps = write_bitmaps > 0,
 			.midx_must_contain_cruft = midx_must_contain_cruft
 		};
-		midx_included_packs(&include, &opts);
 
 		ret = write_midx_included_packs(&opts);
 
-		string_list_clear(&include, 0);
-
 		if (ret)
 			goto cleanup;
 	}
-- 
2.51.0.540.ga7423965ad8

