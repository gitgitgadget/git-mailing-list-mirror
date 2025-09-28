Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329CB19FA93
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097316; cv=none; b=EJnnu6YQJAv//+TSf+9+HaiDVHcngXXrcqa4UHX0y85TOGTGLRlJpFLwgaJzCHRLcLlG6MJynBz1FzY5ZG2JMYo6IhFKxjz/cEhbE4pgsIqgeiGyNDbXIW+f/ls+ZeAp+IR1EKOWc0pFteO9elPtiGBE+k4UlmtqH87yPObpjoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097316; c=relaxed/simple;
	bh=oQKLQ7ogaozpv6qzZh+5unkC3kp+OspytGd0xeOTa1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AE23wlCX10c+GL7KanR67l7LHiOFfmII7uivKsWhVocqfGo9v7pbGXLRozWhnA3xKPM7NFygVAgF1IRZcKMLRox8s/Uz3QidjqoydUvAgYMPDKzKYGDmkX3kUF67xQ1qlDG6JanUenYnaGQFH1/YZlr3TSJXDJdQNca8rBbSe/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=PoQitCK1; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="PoQitCK1"
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-6354a4b4871so3536364d50.2
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097314; x=1759702114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LqIz6OzC6O4VGsHq3XVXFfT187D1Z7EcHYwW67+UtPc=;
        b=PoQitCK1aM3cg7a9HjeZGCymIobKJ33bUrFkKSZv8bmZWWvqpTKn5H9PMQBUHJeJWd
         kpp7i0Lts1viLhbPxdsNReMUKF8yG1FqL0GfzpaajpVGLbDFxFw01b4xeL4vgffGnKdo
         1Qlk+88KwuPm0K+SoYwc1wDKjc8k6oZONX2B5wWyY7S9VuH6m5cL4Y0iWhs4ttBX/yzM
         aTa5JX7iY2ClTLASKnPEBTwUtnG4oDbh+vD11P6SC9907uSHQ8bz1iu5VVbpa/3yPAT0
         NBEhonXbGh2eBQcfJkR8BcPvSTSiVhppJuah38oPedJYZJPhdlmGelpUOBhAYNHJIHDb
         uVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097314; x=1759702114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqIz6OzC6O4VGsHq3XVXFfT187D1Z7EcHYwW67+UtPc=;
        b=aDbEMpUu0z225X4Q+I+sTVVwlXdaFBCkVZ7IbU3cQzlV1KldYbHm3mADhNtF92D3f3
         nmId4kvS5UvDN00NzLInd1nz3opZ+opM8CUZlbAOSkHoQ8Vgyn0lyL8Q2bY7PeprDvDy
         yUCPrJaO1XGNJ1//Q6esjNolJZsNQIunYVuX3eegcaRsa1pQefYHD6LwFWI1vpW74ric
         uHB/xL/rn8Uk/l27tUU9phclHOHVu4x4NsOKJgYTyq19hToGEcAHWx3sTagydjN6uFsV
         9z4TkRqlZrXwvgIHTDJsFqdsuC81/otlPpzZKenADD4RvGfyW2A5rPHpNbEhE604bIzJ
         fVuw==
X-Gm-Message-State: AOJu0YxDvl/FHWvOVBKdE4KelEYJjVjP2fvzN4vh6YxBjMeQNDBu+9na
	yfjqIl6mB0TL6d+yhO/k2k6X5oJTJP+/nStx5S58M303j6YSE5+HPz4CHQ63bNz9O7YfA8KDaPy
	p+7rizJQaVTjZ
X-Gm-Gg: ASbGnctPnZkdjWgojxd0f4Ew3SbqKW5YtuHFV1ymlSeSvRYb8fokCwEcVYyVrOgw96S
	gf8Yzzx0/t0i/hZc6zM7SdENJ2dMey0BtNRk/hjyP0UEK0fHagGbWYbGTHvxbsjRMuUmphRkXT7
	XPIq6LdNOdcGedOC9LvM0dwTNxEGVTXRudvFLt+yBzXg5MSKXlEqK9xVykTypGMyVDreUhPK3iO
	SMmGS2LIZ3yVwjedtXevGMpZqH3Z0RXtmqnd297VfoZfoH63DnVb6TaMB1k+0/f8D8pUT4/v0hg
	5K81IFoiqqQOvHAVvObiyIqKBl3iJOFpmMaVFYLI7XcwpsguQCONiVFqk3KANLJ6RBcBNbV/DaU
	QmCh1RAhnpOfSzUjeZJ+Y0Chyxfamy/njYut7eIbyVWveohNZYiSWIYDRc/EfyAjzWY8vv8eoll
	UXQUh8vHHdIh10UDaepCVadPCmCXH2OVbjrQWq
X-Google-Smtp-Source: AGHT+IHsSRisz6yh5VvuRQtlB8QVAK9/CbJQbppH+Bu5MK6HK+ciY67gX3Bd2JDPZ2ceZCsx+GRyBw==
X-Received: by 2002:a05:690e:150b:b0:633:ac5d:29e9 with SMTP id 956f58d0204a3-6361a7195ffmr14619585d50.6.1759097313965;
        Sun, 28 Sep 2025 15:08:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-eb383929b93sm2942326276.21.2025.09.28.15.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:08:33 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:08:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 21/49] builtin/repack.c: factor our "generated_pack_install"
Message-ID: <96d27261e75fd2ae46d9633b3d4eff243dbcc187.1759097191.git.me@ttaylorr.com>
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
 builtin/repack.c | 66 ++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a4d80b6b04..8c3a5f4f80 100644
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
@@ -1434,35 +1466,9 @@ int cmd_repack(int argc,
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
+		generated_pack_install((struct generated_pack *)item->util,
+				       item->string);
 	/* End of pack replacement. */
 
 	if (delete_redundant && pack_everything & ALL_INTO_ONE)
-- 
2.51.0.243.g16eca91f2c0

