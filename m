Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A5F30BB83
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567360; cv=none; b=nTsAAk+4jqxwAoVhNb2SQQFS8tNgsNsZz7MGXeCuB2onUL356Ly4c1DF5bIcsYSNcWNf3/ukE0hpxqPM1U1vPgpmXuJGq2rj8O+4Ni7sbxdpZ64us4zn0n97TqzZhPTO1d+o9ZxkJwL6hrBbxPYsmdXtqg/p2ausHT8eCDmKLi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567360; c=relaxed/simple;
	bh=OV+sN1CkBYTsMZx9kNjxfuc9c6HDhYvIA7ncOwxfm8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPSoca6vrgjtFQJ7wLS5KA1jOKxkJWfQqRG5KtS/V3IgUDhxMhvEU+p0Nuw+XrUsly8laujjRqbkb1/GFPQlQJsFUPB0PO225qKIJdIdrsrUkAPuENj9XRxoyMdXA9/K+1jzG/QVPeCP2MRZ93MiEqbbCg09YJNO6/g4STcwMNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=oKfBqgKI; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="oKfBqgKI"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-781da6c1a37so931547b3.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567358; x=1761172158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oiwylKNPFdgtdm2edLcfDFOPWhFZDJWf3w5UANh/d8Q=;
        b=oKfBqgKIWzXuBsCj/kcXKdY9elmaSHV21G6b04Il5oh2bliN7yHQsG/nlxUh1h25hN
         wD6/juLC27yiWbmpAEXOBJQZgBmYIbvkndFsx6pFaes/BTmjho4AcfJLTYINB+Oh6XZQ
         mqq7GGbCebymEudwnHFV1wnpdOGvcShaqiXEFSTqXPk5O0SECLKWEBfwxlPR1j+nfBB/
         jgtWF4fydkzzko8+8R5jUVz7tOO1WC9P6RqNUt3PBK+2oayGTanfzRN0ZF/QdPokkTtR
         GTqbKXDXui1+1Z+eSuc1A+uAbeazbfgvlvxk/2RU+9cFqMS6ymG91yhHh6kwlkHau9FD
         2/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567358; x=1761172158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiwylKNPFdgtdm2edLcfDFOPWhFZDJWf3w5UANh/d8Q=;
        b=XnmfGyKyG/OUxlTpQaBQ77mAeK7LlYyHmNWzqfT7sJyFIH+pWyi/LvuWMPTwzRT0gc
         TUClv6Di2Ee+uraG7iRrDFK8c8jYB6k3w/5U7ZpviOAgPypaFjfgAl+7+XinKFnynY4a
         /wWQaBCsPhG3943fglIJ/cRb8cnmWpvxWwc9jSYXyZNzOq6/ztb4pd7jvNpuJAc7LrCH
         ERp3sW7vMVFe5deXbVYjkzTD/HYbLSl1mZJ8wMZoY2W3p+7Sc9KsJvks07v0G0Rn0cJt
         Nh1EXNn1SEt6n4SARR8W6G+N3nwSqnpgLM9IuV+Zy5paBek+fdZPMTZVVbEF8ZSdj+Y9
         33rw==
X-Gm-Message-State: AOJu0YwaGRN2CA67+GjLSeqm/2+KTNxZBcRbFqdMAJzf0s1gYkM8Ij63
	wsQRjmDYne+6hT4LGSyRgyrTsgtSUFRR0LEjk6sngkQoQjAnFfGylqr+6tZzA6RSsrEFlTTeO2I
	e2O0dkHDEapy2
X-Gm-Gg: ASbGncvSU4mc1JiWZZ8MK8oqy1zHTqQl4PB1iEtfx+jZ/L6hS4rWoz6VZQSlxuhXrES
	Pv3azGzNuIDak8hO1PkMiaFeInh5rEonrcLHcx2GeUfEviybWhXHJnUWVaWiCMYguQ4wOtfJSfn
	01idwut5PdREBOQde9NEqjuPQ/SWmxORmgQb9rVpgcbgCv3nPNSjUh6bWjXbdJHO7TTo4CFccxX
	xVAVW7dbAWEJlHWUttejjcgrIlqKDM0QQqGYWMDCClw2FZLAvC/Eh2SsTLw5Q+Td4VDGyLQBOvP
	dn9wTvWIOTBhddHYcJSUnDaFKORoEveyqU7nE6zOaNwDxxd2GT0QP1Rx1TiGOUJZA/PmqdWqcAA
	07KD7iVm/Vb0tu9/yEBRd0yiXzHaPc/29qLyb4jtXpAFFF1UOLD50HqA0JM9hpf61uYeydS8169
	PgGNvuWQyI1JF4C71V/MU+T1axf/gxVN6//wiGWb227Ni738HQhqcmc8AcNXalgWfy4f8K+OWTy
	H4zi7Y=
X-Google-Smtp-Source: AGHT+IEDPDMJC1cuXHfWkt5amN87qu/xa5IdHQXVu2J3CaUIwoeaRb0vEglkm9c+hSJwpwIWzYKPtw==
X-Received: by 2002:a05:690c:c96:b0:781:4717:bf66 with SMTP id 00721157ae682-7814717ea84mr90878287b3.24.1760567357771;
        Wed, 15 Oct 2025 15:29:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-782935fdacasm2577107b3.57.2025.10.15.15.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:29:17 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:29:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 40/49] builtin/repack.c: introduce `struct write_pack_opts`
Message-ID: <0cb6e78856c8e365668e21f7cd8ad6de5f5b3922.1760567210.git.me@ttaylorr.com>
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

There are various functions within the 'repack' builtin which are
responsible for writing different kinds of packs. They include:

 - `static int write_filtered_pack(...)`
 - `static int write_cruft_pack(...)`

as well as the function `finish_pack_objects_cmd()`, which is
responsible for finalizing a new pack write, and recording the checksum
of its contents in the 'names' list.

Both of these `write_` functions have a few things in common. They both
take a pointer to the 'pack_objects_args' struct, as well as a pair of
character pointers for `destination` and `pack_prefix`.

Instead of repeating those arguments for each function, let's extract an
options struct called "write_pack_opts" which has these three parameters
as member fields. While we're at it, add fields for "packdir," and
"packtmp", both of which are static variables within the builtin, and
need to be read from within these two functions.

This will shorten the list of parameters that callers have to provide to
`write_filtered_pack()`, avoid ambiguity when passing multiple variables
of the same type, and provide a unified interface for the two functions
mentioned earlier.

(Note that "pack_prefix" can be derived on the fly as a function of
"packdir" and "packtmp", making it unnecessary to store "pack_prefix"
explicitly. This commit ignores that potential cleanup in the name of
doing as few things as possible, but a later commit will make that
change.)

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 28 +++++++++++++++-------------
 repack.h         |  8 ++++++++
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 2f49a18283..45ce469898 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -138,9 +138,7 @@ static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
 	return finish_command(cmd);
 }
 
-static int write_filtered_pack(const struct pack_objects_args *args,
-			       const char *destination,
-			       const char *pack_prefix,
+static int write_filtered_pack(const struct write_pack_opts *opts,
 			       struct existing_packs *existing,
 			       struct string_list *names)
 {
@@ -150,9 +148,9 @@ static int write_filtered_pack(const struct pack_objects_args *args,
 	int ret;
 	const char *caret;
 	const char *scratch;
-	int local = skip_prefix(destination, packdir, &scratch);
+	int local = skip_prefix(opts->destination, opts->packdir, &scratch);
 
-	prepare_pack_objects(&cmd, args, destination);
+	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
 
 	strvec_push(&cmd.args, "--stdin-packs");
 
@@ -175,7 +173,7 @@ static int write_filtered_pack(const struct pack_objects_args *args,
 	 */
 	in = xfdopen(cmd.in, "w");
 	for_each_string_list_item(item, names)
-		fprintf(in, "^%s-%s.pack\n", pack_prefix, item->string);
+		fprintf(in, "^%s-%s.pack\n", opts->pack_prefix, item->string);
 	for_each_string_list_item(item, &existing->non_kept_packs)
 		fprintf(in, "%s.pack\n", item->string);
 	for_each_string_list_item(item, &existing->cruft_packs)
@@ -665,14 +663,18 @@ int cmd_repack(int argc,
 	}
 
 	if (po_args.filter_options.choice) {
-		if (!filter_to)
-			filter_to = packtmp;
+		struct write_pack_opts opts = {
+			.po_args = &po_args,
+			.destination = filter_to,
+			.pack_prefix = find_pack_prefix(packdir, packtmp),
+			.packdir = packdir,
+			.packtmp = packtmp,
+		};
 
-		ret = write_filtered_pack(&po_args,
-					  filter_to,
-					  find_pack_prefix(packdir, packtmp),
-					  &existing,
-					  &names);
+		if (!opts.destination)
+			opts.destination = packtmp;
+
+		ret = write_filtered_pack(&opts, &existing, &names);
 		if (ret)
 			goto cleanup;
 	}
diff --git a/repack.h b/repack.h
index 25a31ac0a0..6ef503f623 100644
--- a/repack.h
+++ b/repack.h
@@ -32,6 +32,14 @@ void pack_objects_args_release(struct pack_objects_args *args);
 void repack_remove_redundant_pack(struct repository *repo, const char *dir_name,
 				  const char *base_name);
 
+struct write_pack_opts {
+	struct pack_objects_args *po_args;
+	const char *destination;
+	const char *pack_prefix;
+	const char *packdir;
+	const char *packtmp;
+};
+
 struct repository;
 struct packed_git;
 
-- 
2.51.0.540.ga7423965ad8

