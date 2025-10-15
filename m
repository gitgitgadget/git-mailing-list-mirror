Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19BD30BB9E
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567305; cv=none; b=iewUpp1TYRfkJBkkP3Bxf6bxnClat2q3zSn0vviid7agLSeQjZIt/GR5Fx1x3puEZy7ieHzi4naJzejRrjPYscon2AOhG5BF5BXI+U8rSgUrYlM72MRn/CX+z5YAUqIT7c0pFE4y/dmSkn4mZKhdoPy79PrB9sAS9XpY/Dx6brs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567305; c=relaxed/simple;
	bh=DoBOcmG4Y+7v/Uw7pgepOZuUUza/0Khw18cwlItrhtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB+7CJVZ4zFMRSpn7GXB37qa7XecjXIAGIrQnX2xNotudjx4T2srfaka96uiK/8Xwit/O3Y/XhnkXiAOTE88HPu6uSAXnUTzjVYiuuGNDH6s+M405IIM7bCJeS+3i0wfkMsKUTKGdCe4ti8B2XvQaNxIzdRSwhWBmxD0jNBT9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=GiCGyMm/; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="GiCGyMm/"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-781014f4e12so962457b3.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567302; x=1761172102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WtAcdP7r2Jf31rDHfyu2xmwOQwge56RChs8bs7zlU9c=;
        b=GiCGyMm/fZNrxcU9vqqLQE//nOrxinWpt9orVyWzdfDyokmWwRb3sTKJI5hOmvx8uw
         cNeC8AfsbW5MDYozmqbOdir8s+teNsbWgWBzBe53ghb0hHjYXptpNNVVMqa9fK5m7Oy3
         jDy5BQq07WbbiDnor/cEgIobO/F0wKsh3TcP+E1zj1/0AF8VFqp92bwkd6TCnECA0tHB
         eaEhGMCJ5ISuoT7dNqtlP4IDgsegnVNXnHb3oeqUMxN89915Cth4KeX+qUhyGLJX62ng
         WODrKd/jPEb9EAq0HaDq59k3wVF7KEMI1QvkLOsug0ePSBsp7zm+Ss8MCGvEUhKRQ4z3
         No0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567302; x=1761172102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtAcdP7r2Jf31rDHfyu2xmwOQwge56RChs8bs7zlU9c=;
        b=bz3Okzcu71IfTTWszgAjxS2fvOkoJqZMGxKX8naAVcROKD0cF/gVzsd2obtbxlqixn
         RRQgXyrQApT++egvW6nCfzfpJgxgYcWbWMySDkiKLY3gF/8mQpj+BWa3ctRNO/nJYjHW
         r9X8wt+NLkP10uwDQ1aR2AJrqeJt8ZITHDuMnnQsWz3mcBVANmf95qI3LXdzz/TIjYKJ
         HTNGx6Fuuu3Wen54yiGGGFj6rWLYnykTWpw+vAQdePTwr9x79FKZu/pprzQTN7stCcJ4
         YMK12Gr9uflPDrzp0K/v70UwEpMXhi0NjWPOuEeNA0//CMqxojC4tsFzbBP6zshZCyob
         0SxA==
X-Gm-Message-State: AOJu0Yzsryjnj+dI64aYhf2OqlQ1XYqfJzPNQ9Mn7wKK9p3ojAFP+ZIh
	BBafa+TWsZhzFlLzLOUfPnNFupl77ZE7fQ96xaW5Isu7MSRus+QlhCBQo9YIeloAxOIdECu9jUP
	HeOfF3qVOczrV
X-Gm-Gg: ASbGncvrfA+/zi0pK6Wnn9fxc8Kwo/fpXEy7JjIT05LDVfWwYw7KqyB5Js9MBJ8g0lT
	+EIw8YRahCROYRwmzAYyoNs/ys0pMy4Xh4lz5r6ZzFozdJr6pJTc0ObAezsNChhcfHzqCnefNE6
	CZMsCTcKtkWtwkFVEUkRN52nGEO2xwDTN/0APG4sTRTIdCOVRf7MsNHZaf52nRIRNJEutJr06T3
	o4Ec6gB5m2oSmn1Oz2mFxhskKZhtjDMXHOYB8Mno8hAHjL41XlPicn17nKxN9K0Y6FZiDTBdQm0
	MucTegMbHIDOOl39OsUL6haB3FrVUeAFFlPgNdAYV3mS7y0N1PRySZKjLuTt9fd8Z6HL7O2OL9h
	UfwuJtLa49n3TTaL1SVJOP/Wo8ffrhfcKloEsMP8NNTQ2t0eT8xmDq2Xu/rmG4JInI6q0P5mnv5
	MR4LZjLTB3qKURiU5u/ZoiJEKvDa3y+V9Pevvg0ExMD8ytAKGZiZ3erB7UkmJ3nF5S9Yy4WtuZK
	UpvET/dJEuku+oK7Q==
X-Google-Smtp-Source: AGHT+IGOBTrb7e+LQO7YhJby/UKCQlP5XgNVp5lAt+j5KGS+YkY3cyA9Hi934EgVvJCCnPoxXFkjTA==
X-Received: by 2002:a05:690e:164b:b0:636:13ab:b5b6 with SMTP id 956f58d0204a3-63ccb85e78cmr21242799d50.13.1760567302341;
        Wed, 15 Oct 2025 15:28:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-782935f913csm2580857b3.56.2025.10.15.15.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:28:22 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:28:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 21/49] builtin/repack.c: factor out
 "generated_pack_install"
Message-ID: <196b92d05253150e9cf69d83cf64cc74fd1bf523.1760567210.git.me@ttaylorr.com>
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

Once all new packs are known to exist, 'repack' installs their contents
from their temporary location into their permanent one. This is a
semi-involved procedure for each pack, since for each extension (e.g.,
".idx", ".pack", ".mtimes", and so on) we have to either:

 - adjust the filemode of the temporary file before renaming it into
   place, or

 - die() if we are missing a non-optional extension, or

 - unlink() any existing file for extensions that we did not generate
   (e.g., if a non-cruft pack we generated was identical to, say, a
   cruft pack which existed at the beginning of the process, we have to
   remove the ".mtimes" file).

Extract this procedure into its own function, and call it
"generated_pack_install"(). This will set us up for pulling this
function out of the builtin entirely and making it part of the repack.h
API, which will be done in a future commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 65 ++++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a4d80b6b04..bf413a6ee2 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -183,6 +183,38 @@ static int generated_pack_has_ext(const struct generated_pack *pack,
 	BUG("unknown pack extension: '%s'", ext);
 }
 
+static void generated_pack_install(struct generated_pack *pack,
+				   const char *name)
+{
+	int ext;
+	for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
+		char *fname;
+
+		fname = mkpathdup("%s/pack-%s%s", packdir, name,
+				  exts[ext].name);
+
+		if (pack->tempfiles[ext]) {
+			const char *fname_old = get_tempfile_path(pack->tempfiles[ext]);
+			struct stat statbuffer;
+
+			if (!stat(fname_old, &statbuffer)) {
+				statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
+				chmod(fname_old, statbuffer.st_mode);
+			}
+
+			if (rename_tempfile(&pack->tempfiles[ext], fname))
+				die_errno(_("renaming pack to '%s' failed"),
+					  fname);
+		} else if (!exts[ext].optional)
+			die(_("pack-objects did not write a '%s' file for pack %s-%s"),
+			    exts[ext].name, packtmp, name);
+		else if (unlink(fname) < 0 && errno != ENOENT)
+			die_errno(_("could not unlink: %s"), fname);
+
+		free(fname);
+	}
+}
+
 static void repack_promisor_objects(struct repository *repo,
 				    const struct pack_objects_args *args,
 				    struct string_list *names)
@@ -1045,7 +1077,7 @@ int cmd_repack(int argc,
 	struct existing_packs existing = EXISTING_PACKS_INIT;
 	struct pack_geometry geometry = { 0 };
 	struct tempfile *refs_snapshot = NULL;
-	int i, ext, ret;
+	int i, ret;
 	int show_progress;
 	char **midx_pack_names = NULL;
 	size_t midx_pack_names_nr = 0;
@@ -1434,35 +1466,8 @@ int cmd_repack(int argc,
 	/*
 	 * Ok we have prepared all new packfiles.
 	 */
-	for_each_string_list_item(item, &names) {
-		struct generated_pack *pack = item->util;
-
-		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
-			char *fname;
-
-			fname = mkpathdup("%s/pack-%s%s",
-					packdir, item->string, exts[ext].name);
-
-			if (pack->tempfiles[ext]) {
-				const char *fname_old = get_tempfile_path(pack->tempfiles[ext]);
-				struct stat statbuffer;
-
-				if (!stat(fname_old, &statbuffer)) {
-					statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
-					chmod(fname_old, statbuffer.st_mode);
-				}
-
-				if (rename_tempfile(&pack->tempfiles[ext], fname))
-					die_errno(_("renaming pack to '%s' failed"), fname);
-			} else if (!exts[ext].optional)
-				die(_("pack-objects did not write a '%s' file for pack %s-%s"),
-				    exts[ext].name, packtmp, item->string);
-			else if (unlink(fname) < 0 && errno != ENOENT)
-				die_errno(_("could not unlink: %s"), fname);
-
-			free(fname);
-		}
-	}
+	for_each_string_list_item(item, &names)
+		generated_pack_install(item->util, item->string);
 	/* End of pack replacement. */
 
 	if (delete_redundant && pack_everything & ALL_INTO_ONE)
-- 
2.51.0.540.ga7423965ad8

