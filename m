Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0F330E857
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567302; cv=none; b=EleVVnZAvN9lWdVR78utMBQGEl5+MNvnyvSY/9xyqMiyxnTpxKFM7upX2Q8vm804otwPdALIkkRnveD+7EhBlG3OHg3DApDmIkPn7nsRZs2f6VlI05oUq1K1Rk+XHBNK5b+0RiAunkgtiYuAXRIClEqWT6Obfs8IrGl7PzSD+uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567302; c=relaxed/simple;
	bh=/Z27rciKmklJ2HI5ttRq/uxLL/ModlNwbZeqzjnTklg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWnW2IPFz6Sfm4ks8KuQJmWWQY60+ZpnTpIFjRd9wnZV7/xCG0bEvsg7mdiEtci7S92bDbcEV5VnP61+8C5kAHcJ0o8stdVsxTmT6sUqQOwPEXBq3iIZzlIZ8g+taSDgsAJpnFQzlXZ6OZnsYZL5AJRHdNGleIQYZIeuE7qKd8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=AxwJgV1V; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="AxwJgV1V"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-71d60157747so1005907b3.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567299; x=1761172099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OHRp70MMkidvJ9wfAkO5WC9N1axCP0gT28ixc4mOPEo=;
        b=AxwJgV1VDX7Vr4QaPLGlbMxaQtKm1IAvNBMOBsyY4LZbxmmGfrF0c56d0SaXX8txDM
         o/SkO792GVCkfEjKrX1zovxMVjdeTMgCqSpNfvkDiZ4XPAn1JKcrEG9rCwbvtrQH7+PZ
         cI/DKorbY8Fvxu+tRBtg/CvzfnD4ndNbD9Ehh7G0O6ych1kBKxgTESI7udGryzkldkDh
         7PURI5KUGv8mmTupjqBkrDsXk1elkzT4U943r66DBFKZf/XnIlQrVRtU9SuMboVHohHN
         MQ+n7iGLMbO2m0DNnY6Rt4TrzNqpjr7yXc/fuYSI/fJUKURXUebbFlj2cCSKxzrhrNJJ
         KYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567299; x=1761172099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHRp70MMkidvJ9wfAkO5WC9N1axCP0gT28ixc4mOPEo=;
        b=stPPsTT/a1S1AnkRxzsUZJOkzgqvXXvW/VC6sTXf4hKuAz916t4J1Ha5x4Vi7uk0VP
         9KmH2AJxflMQnIhenM52sOOPv1Qr6nIEHuyNRh4Ay3Jtpkd++v0AJWw5DEfhuVJhxey6
         +JPC0dbarqbR0ifYOJ2lFm4NY/QNz4SLXfRqXsJu42laXhvgqpZjym7ignrBWmLaeKE1
         5PvYfwJb+I78on2OgWr7NRG3n2e5k7CUlk4C5fDeXIYrjd/I+IRN0SfktvleF0Sg30Mr
         xV8fSXRwJ5S1YPcoW2mu8pfOpohxbendMLMs9XUU7nCfodQatMjUbJgbJG3MD9ExRR4T
         5Qbw==
X-Gm-Message-State: AOJu0YyM51A5eC9fXG2b0xLhBFhRCJr6CxZK4FeotyFjLdC5rWjPt5RA
	Nm68/U2d4HnUhc5UZbXuBRqwlHFCoubbfrviEAGQV+vx6FQzxJFht/LuxsUowCLoSh+9eoBgOn6
	tOsw016pwOgzU
X-Gm-Gg: ASbGncvze4sbbloSQc3C5ir+uFDgq/AOZN/Y/0g6Vs6Lb7qwfTFNDp8NP8LRmL3/JPP
	LLuCfAITMlHgOYQLneYUiOrY9S9pkA2x7o7m0xXfqEPhciFozomwCf8/3NDdDqIhAgQpkWx2Ypa
	KFSyjr2FquKePnq2gPkyKRi6wbAvbMmW9j7GUSE54PGBjWaNqaq/dmZEBIVObqG8nfJM+TsMQBP
	JPoj3zTkPE/VHGoKMi84oXs1TgObQ8MvwJ1k6ouFBLOGiL3TxnmEJasLUaP5FkBPO0Bf++cSk9a
	cSEaO7J73UKxWZBPjjZf6l+PqnokI6fymYq3jVhyh5ijCpsijY53GgaI1ioyTb3mKJePedzifJO
	FNhO9zUTgsi8i7tpS9P4RW0XNrne8Stl5U/fdnKIw2TW2q+NuXQrJv7IHmL4X4dwONQhDhQRCkk
	pzApm3I6S3FkrUc7RpNmx+yE/29CikEBHOtyKtY4LvaQ3LoN6wAU5GsrouYBRd6pIuMy3UV/oHd
	k/MWdEsXlt8sO20kQ==
X-Google-Smtp-Source: AGHT+IF8idEhdQxVeRTTld5hMcYrNeD2qA8n/5EnhKhFXiThWwPjrXzj2jmW6+DCz5AqyKtgBOydtQ==
X-Received: by 2002:a05:690c:504a:b0:780:f93e:39b5 with SMTP id 00721157ae682-780f93e4298mr202477977b3.19.1760567299477;
        Wed, 15 Oct 2025 15:28:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7828d3c2dd3sm2760647b3.19.2025.10.15.15.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:28:19 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:28:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 20/49] builtin/repack.c: rename "struct
 generated_pack_data"
Message-ID: <53d5b1053f2075b788804c71771d3123b6158cd3.1760567210.git.me@ttaylorr.com>
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

The name "generated_pack_data" is somewhat redundant, since the contents
of the struct *is* the data associated with the generated pack.

Rename the structure to just "generated_pack", resulting in less awkward
function names, like "generated_pack_has_ext()" which is preferable to
"generated_pack_data_has_ext()".

Rename a few related functions to align with the convention that
functions to do with a struct "S" should be prefixed with "S_".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a168c88791..a4d80b6b04 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -146,15 +146,15 @@ static struct {
 	{".idx"},
 };
 
-struct generated_pack_data {
+struct generated_pack {
 	struct tempfile *tempfiles[ARRAY_SIZE(exts)];
 };
 
-static struct generated_pack_data *populate_pack_exts(const char *name)
+static struct generated_pack *generated_pack_populate(const char *name)
 {
 	struct stat statbuf;
 	struct strbuf path = STRBUF_INIT;
-	struct generated_pack_data *data = xcalloc(1, sizeof(*data));
+	struct generated_pack *pack = xcalloc(1, sizeof(*pack));
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(exts); i++) {
@@ -164,21 +164,21 @@ static struct generated_pack_data *populate_pack_exts(const char *name)
 		if (stat(path.buf, &statbuf))
 			continue;
 
-		data->tempfiles[i] = register_tempfile(path.buf);
+		pack->tempfiles[i] = register_tempfile(path.buf);
 	}
 
 	strbuf_release(&path);
-	return data;
+	return pack;
 }
 
-static int has_pack_ext(const struct generated_pack_data *data,
-			const char *ext)
+static int generated_pack_has_ext(const struct generated_pack *pack,
+				  const char *ext)
 {
 	int i;
 	for (i = 0; i < ARRAY_SIZE(exts); i++) {
 		if (strcmp(exts[i].name, ext))
 			continue;
-		return !!data->tempfiles[i];
+		return !!pack->tempfiles[i];
 	}
 	BUG("unknown pack extension: '%s'", ext);
 }
@@ -239,7 +239,7 @@ static void repack_promisor_objects(struct repository *repo,
 					  line.buf);
 		write_promisor_file(promisor_name, NULL, 0);
 
-		item->util = populate_pack_exts(item->string);
+		item->util = generated_pack_populate(item->string);
 
 		free(promisor_name);
 	}
@@ -780,8 +780,8 @@ static int write_midx_included_packs(struct string_list *include,
 		 * will suffice, so pick the first one.)
 		 */
 		for_each_string_list_item(item, names) {
-			struct generated_pack_data *data = item->util;
-			if (has_pack_ext(data, ".mtimes"))
+			struct generated_pack *pack = item->util;
+			if (generated_pack_has_ext(pack, ".mtimes"))
 				continue;
 
 			strvec_pushf(&cmd.args, "--preferred-pack=pack-%s.pack",
@@ -864,7 +864,7 @@ static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
 		 */
 		if (local) {
 			item = string_list_append(names, line.buf);
-			item->util = populate_pack_exts(line.buf);
+			item->util = generated_pack_populate(line.buf);
 		}
 	}
 	fclose(out);
@@ -1435,7 +1435,7 @@ int cmd_repack(int argc,
 	 * Ok we have prepared all new packfiles.
 	 */
 	for_each_string_list_item(item, &names) {
-		struct generated_pack_data *data = item->util;
+		struct generated_pack *pack = item->util;
 
 		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
 			char *fname;
@@ -1443,8 +1443,8 @@ int cmd_repack(int argc,
 			fname = mkpathdup("%s/pack-%s%s",
 					packdir, item->string, exts[ext].name);
 
-			if (data->tempfiles[ext]) {
-				const char *fname_old = get_tempfile_path(data->tempfiles[ext]);
+			if (pack->tempfiles[ext]) {
+				const char *fname_old = get_tempfile_path(pack->tempfiles[ext]);
 				struct stat statbuffer;
 
 				if (!stat(fname_old, &statbuffer)) {
@@ -1452,7 +1452,7 @@ int cmd_repack(int argc,
 					chmod(fname_old, statbuffer.st_mode);
 				}
 
-				if (rename_tempfile(&data->tempfiles[ext], fname))
+				if (rename_tempfile(&pack->tempfiles[ext], fname))
 					die_errno(_("renaming pack to '%s' failed"), fname);
 			} else if (!exts[ext].optional)
 				die(_("pack-objects did not write a '%s' file for pack %s-%s"),
-- 
2.51.0.540.ga7423965ad8

