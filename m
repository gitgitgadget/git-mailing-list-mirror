Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BD119C540
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097285; cv=none; b=eQ9qziks8ijyfWjqDoXMxW55hvnPZ2WeObtTqv42on9bbktrTVQxIRX1Df/IY74AYRFxb2WRzGXf933Gp+zqEaqsOD4KlzBZdSK26uuxPBJci0cACNnk3k210qu8sxP9W1VJeHR4ogN5SOqUOdyLVS3xu0eZwM+ZA+VEKEfGn/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097285; c=relaxed/simple;
	bh=ZczB+MDCoyH8b9dxwRApHrjp96+lF2H4faL/Q/a4kGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NthxGWm4V1YihMWN1i9XwxPXYgsyU5x8rOaT0J8sNeme4Za6x8KlzxczA8xyugqOaCFvSWMlxdL6wz6ECMzYAuh/hs7YgbTC/EG08MwAB/hfmdjvgU+8Mk+4AbRPSQZW88mOgnKPG4IDp/3nPLh5KPKWwK88+gEsbUQKaygXYn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=eKvcX5+t; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="eKvcX5+t"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-635349b6fe6so2188506d50.2
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097283; x=1759702083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1dw8S3wrxJ8mH+C02NMLO5snv53lEuPv3/5U9SFimQM=;
        b=eKvcX5+tx+STpBqAm4VrAz/3p3tr0lB7kDQc8oG0TEZxHtmOBUHqBi3HDwvA9WrudJ
         ynyqOv2hcGSbl41E/broNFakVTX9jFa5Y50rtrTnCqRPyHoAbjQsiHt5ATjEhaLW2fYg
         Dj62AWORTxcCgdJtDgtrkhDLB8F9Ls2z3j7FuZy/uNZcFcMq6aOPPROUU2p38lcrJ0fh
         ISFl7m3m9dAeMERd4tmZEBTl9QJxTSfZcZ/c48iPhUibu5y2vMCe67tWEjwb17Sk4m40
         EjlEvU73GrzHrMOd9KcaZ9/QtvwhqfPBUr/+9sbV5o0Pi6FvRGqZ810zr7ySC/X0jRPH
         A6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097283; x=1759702083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dw8S3wrxJ8mH+C02NMLO5snv53lEuPv3/5U9SFimQM=;
        b=rSWPxGEH6F+DpEpIpaLtW7sz8TKzdxQaEjKcCxLZNSmKZC95qtA3+N2q1l9NOnY4wv
         UU7PRpjeJW0oDlljQstXyrb9y2PqN77MnCoF/pC7pAWg1i+wmKf0P9ssguW4BHU9xo83
         JS5f+lE496OkgDy90EOdynlUAtJOdlJ86k19UMveDghKNuTzOeO47ugnI2WzyW4HqbAS
         ckQGj/0bAkmgtBiIk2BL5oQczOKawMFIjOj3oQzcJzdvBxiWV4EKWEUO1XVWkYI+QRyJ
         aTUGytNkK7OHHvpIqfobCwq7dcDgk71to0FDbllIm8dtNtXAi2Vq0wxseWgrpmio6v4g
         xfwg==
X-Gm-Message-State: AOJu0YwFWWsrU5evvZmFQrhoB5SKp5pv7gNHoOyHzY/jOHuwqW5XyUYK
	o2afY0Lbk65m1KWKIKvv7X5STKTu6e0JoGJpcPxQ8/2WrTdxXZsZZrr/d7DHWqnEtmrBuU0Q91q
	6TbWD17A=
X-Gm-Gg: ASbGnct2udkJtkRyi9B3Gxzx6vH2PjnFx/oMobdwJygy0VTTVsW7xesKKnwXAGbt6Ng
	A7CNCAUqzdmlxzhc5ctTN2lDbYoUdnITe/EHENnhHpoj/j4KA+e2M8oBrsHuEgxoSIV+rvVvaA9
	eCpl7sKDe79yhc+tGnuwSD87gQ4FmulmEimO47v8IaImLJEquK0dXFLWuZqDFu8E4XjuepfmK3a
	XnOMBztS+KnE6qFnL5HavTPx1AzJoGK6evE8VAel2XotkMZgRzrBTVsnHNeoTugTlMQuVnoNUPl
	HaIVFunA28hCliA7WikC797ap9fwoprLJQqihCFAoDN/MGEYhJJ5x/hZykRU6dziValhOWVro6T
	KpIHIPZm0j0SBGQAGUB7ocFCpgpc2QH0k9F+2wYTsjtHWDMsVK/x7z7kF8NPdrsfbmPjrR32/us
	dG8QswotwvV0ZAMPipYmX0+iYJcQ==
X-Google-Smtp-Source: AGHT+IHMumnBJLUhw0CwUbrcYcWWs3dvAfytEshretlEU+r86136oo/v9fOrY8Otf+HR+RYmkvnY1A==
X-Received: by 2002:a53:ed11:0:b0:633:ab16:f82c with SMTP id 956f58d0204a3-6361a7bf340mr13717187d50.18.1759097282642;
        Sun, 28 Sep 2025 15:08:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-eb38393ced8sm2938724276.28.2025.09.28.15.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:08:02 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:08:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 13/49] repack: move 'delta_base_offset' to 'struct
 pack_objects_args'
Message-ID: <06347b6ab23d5ab1d9a7945da67473b5b9e02ad1.1759097191.git.me@ttaylorr.com>
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

The static variable 'delta_base_offset' determines whether or not we
pass the "--delta-base-offset" command-line argument when spawning
pack-objects as a child process. Its introduction dates back to when
repack was rewritten in C, all the way back in a1bbc6c017 (repack:
rewrite the shell script in C, 2013-09-15).

'struct pack_objects_args' was introduced much later on in 4571324b99
(builtin/repack.c: allow configuring cruft pack generation, 2022-05-20),
but did not move the 'delta_base_offset' variable.

Since the 'delta_base_offset' is a property of an individual
pack-objects command, re-introduce that variable as a member of 'struct
pack_objects_args', which will enable further code movement in the
subsequent commits.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 11 ++++++-----
 repack.h         |  3 +++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index af6de8d77a..f4af830353 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -34,7 +34,6 @@
 #define RETAIN_PACK 2
 
 static int pack_everything;
-static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
 static int write_bitmaps = -1;
 static int use_delta_islands;
@@ -63,9 +62,10 @@ static int repack_config(const char *var, const char *value,
 			 const struct config_context *ctx, void *cb)
 {
 	struct repack_config_ctx *repack_ctx = cb;
+	struct pack_objects_args *po_args = repack_ctx->po_args;
 	struct pack_objects_args *cruft_po_args = repack_ctx->cruft_po_args;
 	if (!strcmp(var, "repack.usedeltabaseoffset")) {
-		delta_base_offset = git_config_bool(var, value);
+		po_args->delta_base_offset = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "repack.packkeptobjects")) {
@@ -315,7 +315,7 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_push(&cmd->args,  "--local");
 	if (args->quiet)
 		strvec_push(&cmd->args,  "--quiet");
-	if (delta_base_offset)
+	if (args->delta_base_offset)
 		strvec_push(&cmd->args,  "--delta-base-offset");
 	strvec_push(&cmd->args, out);
 	cmd->git_cmd = 1;
@@ -1271,8 +1271,8 @@ int cmd_repack(int argc,
 	const char *unpack_unreachable = NULL;
 	int keep_unreachable = 0;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
-	struct pack_objects_args po_args = { 0 };
-	struct pack_objects_args cruft_po_args = { 0 };
+	struct pack_objects_args po_args = PACK_OBJECTS_ARGS_INIT;
+	struct pack_objects_args cruft_po_args = PACK_OBJECTS_ARGS_INIT;
 	int write_midx = 0;
 	const char *cruft_expiration = NULL;
 	const char *expire_to = NULL;
@@ -1567,6 +1567,7 @@ int cmd_repack(int argc,
 
 		cruft_po_args.local = po_args.local;
 		cruft_po_args.quiet = po_args.quiet;
+		cruft_po_args.delta_base_offset = po_args.delta_base_offset;
 
 		ret = write_cruft_pack(&cruft_po_args, packtmp, pack_prefix,
 				       cruft_expiration,
diff --git a/repack.h b/repack.h
index 421d439d5a..12632d7fec 100644
--- a/repack.h
+++ b/repack.h
@@ -15,9 +15,12 @@ struct pack_objects_args {
 	int local;
 	int name_hash_version;
 	int path_walk;
+	int delta_base_offset;
 	struct list_objects_filter_options filter_options;
 };
 
+#define PACK_OBJECTS_ARGS_INIT { .delta_base_offset = 1 }
+
 void pack_objects_args_release(struct pack_objects_args *args);
 
 #endif /* REPACK_H */
-- 
2.51.0.243.g16eca91f2c0

