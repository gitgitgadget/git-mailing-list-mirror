Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B659389105
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776521834; cv=none; b=ajLMgRX8BJkHPO/zEui4HfKVjNmsWTF9cINl6H72IU/2nJpHEW/lP6q+df38CdDlDPq1aDTjLCYwl+tVEcvrlq69/x3S3/opvriY0KYYcbOYdvsb9UdKFshYenaiMTCrsUrXht1BXwAs+qY2W70uC1qz7taAbXjkzb0d/cf2MAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776521834; c=relaxed/simple;
	bh=gYvI2aE3Gm7CLuQU1HrXcN0nPYpcEL1EQiHfYFwj0Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pby+mQZVx5Lwd6cAHIFvIfXHCN6rRmkBUwefdkIHVWR8Z29GVutD5oXGCYFvmZyqsfcS9Qd16qiNpz+Z1+ytSHhgJiTCv6GTKi1HopsMXAfH5vEt9J+XaiX1CT0gzVtzHwc2hDeYIbLOyM/kgOVgtknIbhQpg4jiDj+fqG6/d8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bc7pGtBD; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc7pGtBD"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so1008641f8f.0
        for <git@vger.kernel.org>; Sat, 18 Apr 2026 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776521831; x=1777126631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E7MEpeTu7wiOL5PDZZPJ55U51RczMYxu2xZu6D1imTM=;
        b=bc7pGtBD3ULwfRgQrb24mfISO5lbFnmwcTV7qrBbbGLRbCczCpDezeutWjG+2Hp2yb
         74SNVRA2lFD4kYeMb0APlUN8hTtL464y6EvEQSNnz7AYV8IDek+7pStcR45bMaROXz0n
         UlKKufTtZ0lzhzwR5pScrq4OTTWzIn/r5f0FlZPbuEm1yuEe0fe1VRErYFL7r3NumYqw
         F7eca3yU1kNFJV/OZ8NpmwllOR4OC6ql5fDe4sYKjGJGCr0pMWaL92gMKFiozDJgecIz
         g+51Bqz+CJpo3CHVwNg4UrYjcL7d8U/hwUDvOnCxq2zT/ZK7LoqWpDKEAhfJCI/tEOU3
         rMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776521831; x=1777126631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7MEpeTu7wiOL5PDZZPJ55U51RczMYxu2xZu6D1imTM=;
        b=LpQVpHYD8hQk4LtiNsjQYpbqcwyuUE/7KP+WLMDwnd9L85aASlppno7LwzT0d6X2/G
         M+Y+/BIb8UUomIJAu8rIwk2Qsk7JUN2RWkMzzjotUug8By82qvMmj+zfi0TtrH8roe3Z
         0Puc8g7MT/6TLSg2moo1c3lTSk1fMKKzHdWhleK2bpmUDjHwuo+0jBTA8lcg0sVmOuRD
         3VlOl/FvNhiNTuczDFHRaTV79PpBpC9skwPOKDkOvlBIsB8H274UjT4L4xyIAKuPGbnU
         iGHsYfjIh+omaUO1yGG10I7H1kWNc3kfGqc2SVoHe8r0967TccZPjLNajzvl1r4Oftuj
         VJXQ==
X-Gm-Message-State: AOJu0YxvNAhKJ9hXy+bXGjsmaXWqPGu+BLcLrZHaBnJGHVADfJRENg5x
	U2ETAisywaxEugxZzSaQj2psbDQiKScAlxY6X6ssDnt4t6rxJd8Qdzl338wblA==
X-Gm-Gg: AeBDieubWoMubCYmrA1zxM1Ny3ef5kbHvTrqFAz5HuCdZNPPRAvFwkAPaW9nRcaytD+
	ILxgNU2LB1MFpFXgL3CMFCTyH32SN6H//eCpC3yG1Cb2cM87kJYWtOrei+nMAPdZIh32861/Fld
	bbPrZmX8PNBuShYLbfoHPR1pugWsFwHMNgNc1zvQ3CYWdPRxDGjFzj08A+/cr8MPXJUvUFRqv8j
	zfr9AWnxcqTPXvZ7IDsFfxhVjXK7F77WAlukMWYzF/xFqY0UDKFDvimrIsArx0S87+uLQ39dztx
	M3trDkdhsa2UI8bun+tCcIaKLfSR+35T9oO9z2VrzabmNd1o97J/qbOCGHDNUXqJNPrE1i8Ez0t
	qf3DHZbVzRCZMGcNHq7LtHMm4nvBeeyukxkDFNZbtoyTlE0Husc9F6+9cLIAoFvo8yPcIQAypiE
	g7UXgj3NPSg/HHm0IQveaPtdwYPmoDsPMmThtw3tHZ7BHf4iPqY15wIbSij83NzYMJexnHwMTpj
	jo2lcR5rzVeZEW7iW4=
X-Received: by 2002:a5d:64c3:0:b0:43d:7e5b:928c with SMTP id ffacd0b85a97d-43fe3e20b27mr10528969f8f.47.1776521831187;
        Sat, 18 Apr 2026 07:17:11 -0700 (PDT)
Received: from lorenzo-VM (host-79-19-37-238.retail.telecomitalia.it. [79.19.37.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d112sm14844554f8f.29.2026.04.18.07.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:17:10 -0700 (PDT)
Date: Sat, 18 Apr 2026 16:17:08 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: [GSoC PATCH v6 3/6] repack-promisor: preserve content of promisor
 files after repack
Message-ID: <cfa3fe43b027306805e7fcb5e7517d7dcbb473a8.1776384902.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
 <cover.1776384902.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776384902.git.lorenzo.pegorari2002@gmail.com>

When a `repack` involving promisor packfiles happens, the new ".promisor"
file is created empty, losing all the debug info that might be present
inside the ".promisor" files before the `repack`.

Use the previously created "write_promisor_file_after_repack()" function
to preserve the contents of all ".promisor" files inside the ".promisor"
files created by the `repack`.

For geometric repacking, we have to create a `strset` that contains the
basenames of all excluded packs. For "normal" repacking this is not
necessary, since there should be no excluded packs.

Also, update the documentation accordingly.

Helped-by: Tian Yuchen <cat@malon.dev>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 Documentation/git-repack.adoc |  4 ++--
 repack-promisor.c             | 39 ++++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index 673ce91083..33d3c8afbd 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -45,8 +45,8 @@ other objects in that pack they already have locally.
 +
 Promisor packfiles are repacked separately: if there are packfiles that
 have an associated ".promisor" file, these packfiles will be repacked
-into another separate pack, and an empty ".promisor" file corresponding
-to the new separate pack will be written.
+into another separate pack, and a ".promisor" file corresponding to the
+new separate pack will be written (with arbitrary contents).
 
 -A::
 	Same as `-a`, unless `-d` is used.  Then any unreachable
diff --git a/repack-promisor.c b/repack-promisor.c
index 8fc541d2cf..06393ef06e 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -186,7 +186,8 @@ static void write_promisor_file_after_repack(struct repository *repo,
 static void finish_repacking_promisor_objects(struct repository *repo,
 					      struct child_process *cmd,
 					      struct string_list *names,
-					      const char *packtmp)
+					      const char *packtmp,
+					      struct strset *not_repacked_basenames)
 {
 	struct strbuf line = STRBUF_INIT;
 	FILE *out;
@@ -196,7 +197,6 @@ static void finish_repacking_promisor_objects(struct repository *repo,
 	out = xfdopen(cmd->out, "r");
 	while (strbuf_getline_lf(&line, out) != EOF) {
 		struct string_list_item *item;
-		char *promisor_name;
 
 		if (line.len != repo->hash_algo->hexsz)
 			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
@@ -204,22 +204,16 @@ static void finish_repacking_promisor_objects(struct repository *repo,
 
 		/*
 		 * pack-objects creates the .pack and .idx files, but not the
-		 * .promisor file. Create the .promisor file, which is empty.
-		 *
-		 * NEEDSWORK: fetch-pack sometimes generates non-empty
-		 * .promisor files containing the ref names and associated
-		 * hashes at the point of generation of the corresponding
-		 * packfile, but this would not preserve their contents. Maybe
-		 * concatenate the contents of all .promisor files instead of
-		 * just creating a new empty file.
+		 * ".promisor" file. To create the "".promisor" file, we don't use the
+		 * helper function write_promisor_file(), but instead we use the
+		 * specific function write_promisor_file_after_repack(), which creates
+		 * the file and appropriately fills it with the content of the
+		 * ".promisor" files used for the repack.
 		 */
-		promisor_name = mkpathdup("%s-%s.promisor", packtmp,
-					  line.buf);
-		write_promisor_file(promisor_name, NULL, 0);
+		write_promisor_file_after_repack(repo, line.buf, packtmp,
+						not_repacked_basenames);
 
 		item->util = generated_pack_populate(item->string, packtmp);
-
-		free(promisor_name);
 	}
 
 	fclose(out);
@@ -256,7 +250,7 @@ void repack_promisor_objects(struct repository *repo,
 		return;
 	}
 
-	finish_repacking_promisor_objects(repo, &cmd, names, packtmp);
+	finish_repacking_promisor_objects(repo, &cmd, names, packtmp, NULL);
 }
 
 void pack_geometry_repack_promisors(struct repository *repo,
@@ -267,6 +261,7 @@ void pack_geometry_repack_promisors(struct repository *repo,
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	FILE *in;
+	struct strset not_repacked_basenames = STRSET_INIT;
 
 	if (!geometry->promisor_split)
 		return;
@@ -280,9 +275,15 @@ void pack_geometry_repack_promisors(struct repository *repo,
 	in = xfdopen(cmd.in, "w");
 	for (size_t i = 0; i < geometry->promisor_split; i++)
 		fprintf(in, "%s\n", pack_basename(geometry->promisor_pack[i]));
-	for (size_t i = geometry->promisor_split; i < geometry->promisor_pack_nr; i++)
-		fprintf(in, "^%s\n", pack_basename(geometry->promisor_pack[i]));
+	for (size_t i = geometry->promisor_split; i < geometry->promisor_pack_nr; i++) {
+		const char *name = pack_basename(geometry->promisor_pack[i]);
+		fprintf(in, "^%s\n", name);
+		strset_add(&not_repacked_basenames, name);
+	}
 	fclose(in);
 
-	finish_repacking_promisor_objects(repo, &cmd, names, packtmp);
+	finish_repacking_promisor_objects(repo, &cmd, names, packtmp,
+			strset_get_size(&not_repacked_basenames) ? &not_repacked_basenames : NULL);
+
+	strset_clear(&not_repacked_basenames);
 }
-- 
2.53.0.584.g6b87e8e9dd

