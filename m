Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195AF229B2A
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717939; cv=none; b=mXOAw+kffXrY5b8iCrmZDODak2q8e/ccRyvdqtxuuRyA7oeDnzUr78i2HNxZ/9y5tl78qTIG35NVFBhqiVR9ZULOEW2Lo8XENPvT/XQQ1k4OGvS+Vy7G8ZEyoEBl+k5TiWZn8LDgfz7zfEzPMZBMXWmKUEaGEQ+0vc2zpO0S3Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717939; c=relaxed/simple;
	bh=xFR2wBiM+LEq+A5OFoolSOH69V906fy005GO6mTQRXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFO1shvz55M948OKzrhNpryVwgzPBF8lgtouaKWy9GZoOA5IljaXbcgKdmBqBve8aG7APU9ODiD7JhrAYw5au+wpMi3s1Z76PtYq9NmtA6Ne3UgN9QsC+HY82Mt9i4daelPT+yuNQC09YeSh4uQPdBPbcFkGSGjV2czWnZ+Q8J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=gjy8cO1G; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="gjy8cO1G"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e85e06a7f63so1209087276.1
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 15:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750717937; x=1751322737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/aZ5P/u5vVaTpDDTLouu/7i92BgaWXbsBJ8Y/5wiPQ0=;
        b=gjy8cO1GX7aocLfzVilnOq6Se0uS2Gs5vpVRv+QIJ4QrLBPBcrSMyn51SM+Ep9zppU
         q/4yli0aiGTeHRqB3+3FD2IJuYO8uBETrfBmDVSZBLKHxkj2Yy7mXd8O7/aPKVVVemYf
         H1EAZqd8OxZC8abZcI/Bs6E0c/d+4DWm/N4OzM8eEIQtOIIj6XIo4Lu4bRtCGLCLiHb8
         bZTvDkdtMp8+CWbhoJhw36Ta8D3ql79UNemMijiX76Ei/FppEs/syXUnJorXbtVyouQx
         9ipswBFmpj27XrJn5gOPA6MCnHKqAhm8ifyKxXoyOAm6e0kajToRNkT4kltE8LOhHU19
         HYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750717937; x=1751322737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aZ5P/u5vVaTpDDTLouu/7i92BgaWXbsBJ8Y/5wiPQ0=;
        b=aZddqho+TATeuL+YQWetmOdRsjThj/x1rJosOiTjffAJG5il8VhyIeXR/Isd4VJ0xS
         4lS8uLLyrAykMJXSwf+gDNFMzA3/1JwkKSFyxNN3/u1c88CQ9F8bQwtUQ+D7qNj4TaTd
         ki8E/oivtu032i1TAlhfThY+ZA4fAXdglVqKc4ngNlNIWRkjRVo9AxRDF+WJjbK5ppp3
         N5SD13SJIoS6JGpCyBKFT6aqVewb2WIXsiIwWu8AiZdLtf4WS4+4hvJsHB7jlbDGrQcw
         fDjZd0yebhtSJyGMs1i0LX9m/OI1tXP7qDT+Zm3yNEV54e3vNN5ShOO4cumnooY7ixrn
         YwUw==
X-Gm-Message-State: AOJu0Yx6KV75C4HEat0aH9BjE58SJT4IKDLUfLDK2ELl6+twgzZ0xkJQ
	Nkvmeyt+1QIvKPmkdltWCBFcX/UgD3d9qNdIsoOlWJWCZgQKkLRBj5qT2PCLfsfMEbg/pccNSrK
	lQ8Sc
X-Gm-Gg: ASbGnctySjHH9TOddDG5ksOZUArHkuNz7e2DztVCI8a5vtAXU7ezVY4/mCp+fL/JXwg
	MAD++N6PfMmAFuv5f1iNBwDTFjrjxcBZR8zVhT85hZsFRWDy9hwgZ0h7KZvhshl+yY63QFiv4OG
	Ox8PQBQsp0Z2xZQXgAc0zdvXPRD7kOE0vK/ASsKbvlY9jLUC8E28EPKxrZmEWT+WM6IDyYqftiM
	+UQ2c4xonAHZU5X78MFd6RpGTGbLqQh36iWHwSqf1YxTwuXS4aUcRA7cOt0p4cD10UWMDdN27gu
	phHui6czDWKLap2gBUeI1/jFeONUwpMRo1k0qoGfvhAYgOSV4t1+OMa8Mh/jL0ssgR+2ioDE60h
	FFOWBvhGwalct12ouxpnlfTCtfrQuFmQbpg==
X-Google-Smtp-Source: AGHT+IFM4VKezSJiHpLptPjs2XPeb/cPhMrRClUA8FBjSHNW62/A6hPWQb0MqHPnBGNk56QIX20dZA==
X-Received: by 2002:a05:6902:2781:b0:e85:ec37:797c with SMTP id 3f1490d57ef6-e85ec377a56mr4017796276.27.1750717936893;
        Mon, 23 Jun 2025 15:32:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e842ac684e2sm2700054276.32.2025.06.23.15.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 15:32:16 -0700 (PDT)
Date: Mon, 23 Jun 2025 18:32:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 3/9] pack-objects: factor out handling '--stdin-packs'
Message-ID: <19e8c789e93a9e87e5a1799bc56d2d5b0ca4ff7e.1750717921.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750717921.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1750717921.git.me@ttaylorr.com>

At the bottom of cmd_pack_objects() we check which mode the command is
running in (e.g., generating a cruft pack, handling '--stdin-packs',
using the internal rev-list, etc.) and handle the mode appropriately.

The '--stdin-packs' case is handled inline (dating back to its
introduction in 339bce27f4 (builtin/pack-objects.c: add '--stdin-packs'
option, 2021-02-22)) since it is relatively short. Extract the body of
"if (stdin_packs)" into its own function to prepare for the
implementation to become lengthier in a following commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d04a36a6bf..7ce04b71dd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3909,6 +3909,17 @@ static void read_packs_list_from_stdin(void)
 	string_list_clear(&exclude_packs, 0);
 }
 
+static void add_unreachable_loose_objects(void);
+
+static void read_stdin_packs(int rev_list_unpacked)
+{
+	/* avoids adding objects in excluded packs */
+	ignore_packed_keep_in_core = 1;
+	read_packs_list_from_stdin();
+	if (rev_list_unpacked)
+		add_unreachable_loose_objects();
+}
+
 static void add_cruft_object_entry(const struct object_id *oid, enum object_type type,
 				   struct packed_git *pack, off_t offset,
 				   const char *name, uint32_t mtime)
@@ -4004,7 +4015,6 @@ static void mark_pack_kept_in_core(struct string_list *packs, unsigned keep)
 	}
 }
 
-static void add_unreachable_loose_objects(void);
 static void add_objects_in_unpacked_packs(void);
 
 static void enumerate_cruft_objects(void)
@@ -5135,11 +5145,7 @@ int cmd_pack_objects(int argc,
 		progress_state = start_progress(the_repository,
 						_("Enumerating objects"), 0);
 	if (stdin_packs) {
-		/* avoids adding objects in excluded packs */
-		ignore_packed_keep_in_core = 1;
-		read_packs_list_from_stdin();
-		if (rev_list_unpacked)
-			add_unreachable_loose_objects();
+		read_stdin_packs(rev_list_unpacked);
 	} else if (cruft) {
 		read_cruft_objects();
 	} else if (!use_internal_rev_list) {
-- 
2.50.0.61.g1981e40f2d

