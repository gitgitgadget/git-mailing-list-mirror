Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0121310623
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567371; cv=none; b=GCUyHYYHjVnf172rLqU3MKkJBtfg53oBvAPSG4mQyxsgDfYMS1H2H3Ml8w+QJJZKOMGSEbxNdwipcrxxBAp2n90L+1rebbEhdhNubucnCeswChUbCSDPUu8SKjTnRosbI4Um6Ra8ScsVgOrgAaZWVS0BZGj4/COWG7X1A2awN6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567371; c=relaxed/simple;
	bh=Yo5MVxWbJMo9p0/j4dtOmrlCalN/I9wqEMnlxooZekg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GV3CxvKKf27vqXHuiEpCwyiy9gx44DI9NXAUDJwTWWs17Utfsoaz0Y9aA/J7XC7bi6ONZ5jLOuuWcgyvo8B516PPvZx5c5JUzUHjovDiKZrnzOBDhs/KYB8dr4FdFfaiWVf6vNqAMeqxObXNy3G+5HnM8R9z9Aa+GPOBHJOSbCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=gJ6kG7sb; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="gJ6kG7sb"
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-635380a4a67so129254d50.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567369; x=1761172169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EjPeePNjOnq3iZWUZk5C29hTgailCZwHsyiN5WNGghk=;
        b=gJ6kG7sbNpqD5h8hU19sk1jeox6Q8pFV4NrFfD43Hh+NwJrXYwBqwzALEoIKL2pp4O
         gLcOGCDsInOcgB6xTtmVml01JYoIHH0+Ldrxv10dMCfd88Ta4qzyTJdWB7qGvaAnOztj
         emaW71s1lw5Hr1XhHxuisn43P4l4fEsOpEm5KQhEv8n/dfTVFDhdmO5W488WHCCYW3dV
         BUqvR7DPe5PfGxpJ7re4vAN27DginHBB8Ah903QPq8IBrBlPT+OSegM8/Ra6x54PyR7D
         OzlCUusrXkXb86Wpx+6eFLh7DcccjBeYYlBnv6yybGgWh9rCodqh50L6/9kAPH2eD2WG
         oCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567369; x=1761172169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjPeePNjOnq3iZWUZk5C29hTgailCZwHsyiN5WNGghk=;
        b=itMVXOM9gfXKwDKgOeP7haNa0XP+oHrnstsTZ9gPdlRYXlwu/B7IDkwz2n6POcNDK3
         8XrN9uPOWFTyi6Mm3N2XmTpuzT4PPOVvV90lNdXNiHlouK+FbDfg/1Kxhf2fomN11LXb
         CdjEfzhQZ68gNIRHVnv6jZe/LJHSEAh6ufmg9Hpf0CfUonr7eY6Knz6t1nYAxhkJywyS
         GHfxUQZLI12py7xDxhsxHxInjNUA+Jsn77OUKO/mTRhkHHd6Fcrb1MNfkpxqazCvYceR
         s6Fkit7ydznqxKISekh4J/mw3iEIif8q5LoVpD4HSRAiXsBQANm5AyU19YPmjPWj8NBR
         evsg==
X-Gm-Message-State: AOJu0Yx0dXfvkwjUJX1f0rYKDWqswthB5eQvDNs/NJuR2uSoHHHr15BX
	GNRCY0CEeIBUWwJS+1CjEKfFm4Wp9guq5ZIRcpchoVYmaSO91q1b67J3O14qlKGjVjjb2Ttqyl2
	OEFaKLNTV+0U/
X-Gm-Gg: ASbGncvoBXay4/1G/EWpjR42BS5iZewl+OiZOIlPOZ4yQsocufQabsD4x1fh62+LniP
	g+3V/tYBrWJUMtq0oHprpyuzUUoH6IE0VpPkRaIw2LCU6idm+mHKTU4jEjrRL1Be2GC5E4I+duF
	AKR0dG0yFk2iP4TrhUcINHUypPfrXwat8TRSY/oKajwETnHJ5PpgLZpMLkXkWUdUGghltAW3OwI
	OInUpCevP8yD5V+H5cZkG3PPFTNjfOtq+/hOjUFPYfRqLNwUk57ww50xQTRU7pMl19MMxkNeimd
	KN7hhSYB+W+cmpGWdrR6UHRBK9o1kv2aH+bcgaLEZmVeicKwTRh3fq4umgoETyhgVEl1aacrGvM
	KI+PjRB3XzsOTcs9cciBGX8+Mru0oHfdkmL8FAivpICr5M6h6t33+ZePCgeHFoGgeaQZ8wq2LnW
	a1ZviTYQkk8yFhH+xPHbaml0FVK/1u4Z8J6OnSvCeoJn1dHT8KwwMYWj4TqXNPHNWNu+NK/0N80
	7liUoq0MbJuHZC6Dg==
X-Google-Smtp-Source: AGHT+IGJGeLnQ3NdQyalO1iNvYXFtyfrMVPJAFB5BLCuEENEYS+i/VnjmWV4cPMW+29Pk0UF1shXLQ==
X-Received: by 2002:a53:cb8c:0:b0:63c:f5a7:3e8 with SMTP id 956f58d0204a3-63cf5a708bbmr10549601d50.68.1760567368696;
        Wed, 15 Oct 2025 15:29:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63cd95160eesm6038601d50.3.2025.10.15.15.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:29:28 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:29:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 44/49] builtin/repack.c: pass `write_pack_opts` to
 `finish_pack_objects_cmd()`
Message-ID: <fcbe44d8bb815e87d21589299499681f9aa990de.1760567210.git.me@ttaylorr.com>
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

To prepare to move the `finish_pack_objects_cmd()` function out of the
builtin and into the repack.h API, there are a couple of things we need
to do first:

 - First, let's take advantage of `write_pack_opts_is_local()` function
   introduced in the previous commit instead of passing "local"
   explicitly.

 - Let's also avoid referring to the static 'packtmp' field within
   builtin/repack.c by instead accessing it through the write_pack_opts
   argument.

There are three callers which need to adjust themselves in order to
account for this change. The callers which reside in write_cruft_pack()
and write_filtered_pack() both already have an "opts" in scope, so they
can pass it through transparently.

The other call (at the bottom of `cmd_repack()`) needs to initialize its
own write_pack_opts to pass the necessary fields over to the direct call
to `finish_pack_objects_cmd()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index d1449cfe13..5f382aaf19 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -108,11 +108,12 @@ static int repack_config(const char *var, const char *value,
 }
 
 static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
+				   const struct write_pack_opts *opts,
 				   struct child_process *cmd,
-				   struct string_list *names,
-				   int local)
+				   struct string_list *names)
 {
 	FILE *out;
+	bool local = write_pack_opts_is_local(opts);
 	struct strbuf line = STRBUF_INIT;
 
 	out = xfdopen(cmd->out, "r");
@@ -128,7 +129,8 @@ static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
 		 */
 		if (local) {
 			item = string_list_append(names, line.buf);
-			item->util = generated_pack_populate(line.buf, packtmp);
+			item->util = generated_pack_populate(line.buf,
+							     opts->packtmp);
 		}
 	}
 	fclose(out);
@@ -147,7 +149,6 @@ static int write_filtered_pack(const struct write_pack_opts *opts,
 	FILE *in;
 	int ret;
 	const char *caret;
-	bool local = write_pack_opts_is_local(opts);
 	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
 
 	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
@@ -183,8 +184,8 @@ static int write_filtered_pack(const struct write_pack_opts *opts,
 		fprintf(in, "%s%s.pack\n", caret, item->string);
 	fclose(in);
 
-	return finish_pack_objects_cmd(existing->repo->hash_algo, &cmd, names,
-				       local);
+	return finish_pack_objects_cmd(existing->repo->hash_algo, opts, &cmd,
+				       names);
 }
 
 static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_below_size,
@@ -231,7 +232,6 @@ static int write_cruft_pack(const struct write_pack_opts *opts,
 	struct string_list_item *item;
 	FILE *in;
 	int ret;
-	bool local = write_pack_opts_is_local(opts);
 	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
 
 	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
@@ -279,8 +279,8 @@ static int write_cruft_pack(const struct write_pack_opts *opts,
 		fprintf(in, "%s.pack\n", item->string);
 	fclose(in);
 
-	return finish_pack_objects_cmd(existing->repo->hash_algo, &cmd, names,
-				       local);
+	return finish_pack_objects_cmd(existing->repo->hash_algo, opts, &cmd,
+				       names);
 }
 
 int cmd_repack(int argc,
@@ -560,9 +560,17 @@ int cmd_repack(int argc,
 		fclose(in);
 	}
 
-	ret = finish_pack_objects_cmd(repo->hash_algo, &cmd, &names, 1);
-	if (ret)
-		goto cleanup;
+	{
+		struct write_pack_opts opts = {
+			.packdir = packdir,
+			.destination = packdir,
+			.packtmp = packtmp,
+		};
+		ret = finish_pack_objects_cmd(repo->hash_algo, &opts, &cmd,
+					      &names);
+		if (ret)
+			goto cleanup;
+	}
 
 	if (!names.nr) {
 		if (!po_args.quiet)
-- 
2.51.0.540.ga7423965ad8

