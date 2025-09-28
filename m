Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107C219C540
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097386; cv=none; b=mP3yatDfeK0nieIGqOOFOyBZTXZX+nz1WmUQjIX3GEi/IyPdTQWxRyjdLAVqMXPe2Q4g6cgH5PnvZUelsAYqsJ5TyR0t/DXuKWJH71IOkLFCPHkRVk9BAwJWZCfr9UH6EW+UmBqYty6qOnSGWYE0Y7sRVYx1rGbPMJfeiIOIuDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097386; c=relaxed/simple;
	bh=liDai/g4peIeXTHKjiO2bi/eFkpvlchARTAHWgWwTcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssrxmBVtooU+ic0ah6BV8pLW5gq5mvgM81AW+4yDKwSF5G0uUtP4ZjgDVw+cs9EBlipk4J0ME1C7jPAAGyQmDroNhPwrs/11mzt+5Zlx+VhhLLc2ubD/WuzuNMLQKnq06KIjboraoF3AWuegKKiL4M478lUzka+6Bchos3W1uyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Lyqn7oBt; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Lyqn7oBt"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d6083cc69so45973837b3.2
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097384; x=1759702184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=94R0rcKES4LFaI7K5Nj6V1akzetvWTX22NiQnu1/CwM=;
        b=Lyqn7oBtdm71NdrjAps2xGS/zc404u+R2joNmpWAE4pbtsTqyYGD6ARB+S7nHwRzlf
         LZBTEafKaREtQJhW6nkjaA9DP5p2i86dodHLBZefVnhYA1rs5oXFiTKKFKdLZMHD2LDL
         qnoCDEb/vsJm/oLJ2sVieaqBsEoCjocR0YFqN6x/A468Hrf4Rgi5Wr+8vd5hVS6ye4mM
         Dm5oT9fxXplVTYulyMScjlgNGkKTNkyc2hPuIxxPLGgQeVAXyQS9WXwBc5xdgZcNnauJ
         fGGf0WBsnWpfls0Fut8tEzFW0f6/Mya0vhsLc0YbRSYH2paBrJqYyxLYL2NO+P96+/Ma
         3E2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097384; x=1759702184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94R0rcKES4LFaI7K5Nj6V1akzetvWTX22NiQnu1/CwM=;
        b=CNwzc5yLhGdqZBCV3Pgp3ZSKIlNlDvrkzkkI+n8jTDDE2CpYtmLjV9rlRVNXg+BsiJ
         n5NJ6z+CF7ERH+KEok0LSXsGYsVxoss/HRc3MkAVLqKlattBMGkHT9f0bDczWgB553qe
         rOjrrWtjU9JMqB6rcjzkVBQeUM9YHd/2kRSjlWd5nvlfwHYIRSbvnxOn1bIKMtC9MIzw
         ZE6eMPWsOUH3mNrRYE5Xmp2URr4NfT3+wUq/SnbMtObFUlyiU9H7uYvap9aDvW1Vh7WG
         V50rU5NHoWtaMTSHTGSKBUhDV9lBugCI8E4qnU0tnS3728TrvjJlqRt/bvI9OmSQ2Z8O
         rAKw==
X-Gm-Message-State: AOJu0YwvF5ZommeupErBkxLUE9jQDZWnGyLfncqza20MS80hIYh9Y8as
	3k11Qy4P+7RE0iUEbHf5KYowNZOo9Xb1baUYKOfzF/FaAgW1QM9E+SWaq+1XaGNoXzZ9jXP33bs
	MTtz+u+A=
X-Gm-Gg: ASbGncsc+yujVaDZEYADxquO5HVbSwg06af6VAgiHdGLFmjNKFV9QdUp+U4f7GgGxYP
	TISVepGzHW9KQuaIaxcyXkvxsP+H+CBTwsNW9CmYF4MuSwvoWY79cFkiCzqCO8Eg2KIC/gbn1Oy
	YwOzoRCelhwY2BDSraclYaqHwsJaatTXBqOBKqImNqJ3b+g9aQ9gmU9DpWYqQKOfyeMDLL+EVBF
	zHwgpLQL7kAYRhIO/nFZqRBwlipPPd9PY0FiECLOcRhjwPc7uuiusdINOhrmEUPNu2fD+YSeVGt
	gohvwSTM0deOCV5l8PjN5lgFHk5gspPEoDXNacKMpSfqzLPBdRSTo/LA/nc8dQ4nthPdV8GNhwb
	lXG4nn7YJVwhwPF6DKcr1GyPc43x6tuBSPfGRBVmjKTlF/XuTEw90w35vrrTxsUwBqe1nsX43Cz
	OBUsGACncGpNtaVt24Ktr7EYbM/w==
X-Google-Smtp-Source: AGHT+IGOgP2z3/sRJhVsPk+dYl8GQvw1YDBquEguCUtnFXUcgC/Vg78DI6/0wDffl0uSfNHS7G9pbA==
X-Received: by 2002:a05:690c:6281:b0:74d:15c3:f16f with SMTP id 00721157ae682-763fe286934mr178778497b3.22.1759097383911;
        Sun, 28 Sep 2025 15:09:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-636d5b1d960sm1983205d50.31.2025.09.28.15.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:09:43 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:09:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 38/49] builtin/repack.c: inline packs within
 `write_midx_included_packs()`
Message-ID: <c2c7ca9f9e917392de3819ffffffcf78622972b4.1759097191.git.me@ttaylorr.com>
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

in the future, let's have each function which writes a MIDX be
responsible for itself computing the list of included packs. Inline the
declaration and initialization of `included_packs` into the
`write_midx_included_packs()` function itself, and repeat that pattern
in the future when we introduce new ways to write MIDXs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index bd3034a4f0..e2acba6312 100644
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
2.51.0.243.g16eca91f2c0

