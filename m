Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54213299959
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097313; cv=none; b=iQ5gUIvS4RD3oSCStTjMqK06K/qW8AVkLtV0Avumd96b/VidWazzyAZtLJubiEoTBE9ydDL9SkyumZ8nyhnX6dfGF0LHRdBSg89aziNoOcXeCud8TVwv/gNb27Ldd9mcnaODbRlKr4qF7rluQHm7Q2fCWCdwOwjh4m0mMaVLLTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097313; c=relaxed/simple;
	bh=z6lkt7qzsEtz0JFzrtF6DABPIGnRev995UxJTd/MMhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADbQDsOaXxlthBfZtZs7PjXg7+VYDSzltvULutjn9nQs9FQbJiUiJfdxggQVUBrXMRXhOvrHTlXS8XN9dCfL2V/CbzVqlkEaT2KFcoDVqz5zukRmLDKZKARi9PV3B/MvS6jFIWbnjtmjWeKJsPZ9Fewd2iBb7nFKzcQu/KIbmb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=jrM1ubqj; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="jrM1ubqj"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-72e565bf2feso40646467b3.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097310; x=1759702110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h7yeX0E2KG4PCItyIPGAf6YjEPu/Es+cbYWidB7rQ0Y=;
        b=jrM1ubqj8I2yN9zOC2GqT/HF6DvatUjSIjqK/kXr7tSnU13vts0z912qcIoFkz8DbO
         cI8IbF3BXXn6O1E5nkNZp/N7h4XdIcoyY9SPZFQyXqm99LWUuqnMYrZrajDHWlhzs7DR
         BiUAzDtIzmYANtIeT85Zigat65Qg2QeO+QSVobrpSs7SikfgTSnsMp6ah0uIxZILmu3c
         3D9Xwq6IRMwf1oOzAlkx033o/uICF3gJpJ9wobAWFD+vvnPju3lHEbfse6+zu5i1Ax9P
         F+5r2vsvGufZ/UXJqZQOlx/gp1/kGbRXQ3FrqaZ3kXTyS6xEq3OrOk/0udP2rE3k80jS
         C8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097310; x=1759702110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7yeX0E2KG4PCItyIPGAf6YjEPu/Es+cbYWidB7rQ0Y=;
        b=rS+7qx0iDNiVoVernmRCv1Sqq8n8zadqSXYFZPriXkf59DNhf/EU65zfX6Z4Uwbm54
         GePAk7f4KtxKRBfxo3IkO8YY4iyiQ34FxgDRfzEPROClQScNQ2yifkQXny/Csvp7WH4S
         4MsAQOY77jizxVldP7uwqBs6dlBZGiRwcX0fyeEkyLQrrhR7i3xhGKlTq+4pHJoDG1uO
         K8BJTzImFbcjnPD8OiJAeDnji725YGI35XjO9LbMeuGnhIjlGyXl4lLcIBxi3ke8eDWL
         ZxIt3eNFSdATzjcoWrZiV07h1+pTg1dNfVTWbCW+oGkLNulTvGH1Qyyj+krgwWwYiQWV
         02Ow==
X-Gm-Message-State: AOJu0YyLACc5PxQ7LdrfH7Ny6JQ1/OJNse7+q08A+4zplvKPReXKjR2C
	0GzTmyQJCXfTDMmVGQvydvB1ifCVTSCf4owlSrN0sn29Ew+9UwdsZ3iOb28Gn7t9AT2oa4PRtII
	4dGWtdKE=
X-Gm-Gg: ASbGncuOw2V1cK3J40nSIyMXeFwUFessOI+nHchO84/SaCLjgp8IgUryG/Fz9o1E+ud
	xs3VNNWHe+gBYn1zZVwuCulyewvnJ4HjerkqgdQA5tyi5vgHsHxiB5Kw9TlXGvghz4pw9beeZQ7
	7EacD5gpBSik7EjNdt9n4xB5I4ByBDuFQShDZVUSH4AamCQ36dbUOr3RP4Qy4fRepsAlR9o2Z0H
	mm04Sno582wwo8NdocI22B/a2FnRF4xqvbF8ViR1cALS6mJWHot3MltvyS1PlilM2pbRqorESCb
	d5spd5SXNjpiL5gqfXwbTMQlTdqvjIZnGLWJX3CiJyYUbGhIOHAJ/LMbdtepg/R43DKkraRaSC2
	MgvVCZ/1aV2rGNcyCO03EjzehMBEitMsB1txz+FbvB1bmmIXbGCPiJFC4LHYfG/S8/WnSutCzFK
	Pyv09FvJQKmQnzMOR+3Vda9t+WX0LX6oDOMXRB
X-Google-Smtp-Source: AGHT+IGRfh2g/xvTcotAQoxaPqeqdv+HLyBluAfcorX8H6hRAUKORIKVBR8lbS/Aji/qWkEWIHgE6w==
X-Received: by 2002:a05:690c:4c0e:b0:771:36c9:241e with SMTP id 00721157ae682-77136c9291fmr94006307b3.4.1759097310046;
        Sun, 28 Sep 2025 15:08:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-636d5b1d98csm1969837d50.15.2025.09.28.15.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:08:29 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:08:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 20/49] builtin/repack.c: rename "struct generated_pack_data"
Message-ID: <ee3e1233f5b64dc059aea42bf4e3859c72bfd534.1759097191.git.me@ttaylorr.com>
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
2.51.0.243.g16eca91f2c0

