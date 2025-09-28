Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9924288500
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097439; cv=none; b=es1zPt4gUlhzBjOM49pre91D+06YnjODRURtBmXyzG426FWFjSI4zv7nChv4zyClarVmfLI9eEa37BRUXYxgN1KYVAsWoQghzmYNpwUlAfbOY3PBa82OtIlwrBJTatfW1rjmv7da9wKVAx1QHFJH+zem4QatpoTjCdhW8ci0WhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097439; c=relaxed/simple;
	bh=oHCYZNYmJnzUbkG4RaJFCbg/E0vmzvb5lMgqP6BV5oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4fSkinTaazNsJYSs9Av8kmyefOZciBHdGkR7FNsJXa7VHY+ZHWELluALH3/1HI/2z090FvImtP4Tj2SSsDLNvOY7IczrPVSmOM60FGKhvp3g8v64fIaX8qXw8PAbFk/0J4oo59WoDOElSvv3lH+bPyZTS2sZ0FyOInmiKOs5OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=haQ7pmr7; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="haQ7pmr7"
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-633bca5451cso2871650d50.1
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097437; x=1759702237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9b7QvSnRoRYi6+Zdq5Ij7NIpwv1sHaJRMnk3c2+aogQ=;
        b=haQ7pmr7zWjU7Lb+XzkDO9mkFQuz2ov7JM66HNEra2mIsqzFYS5ngMl5qwJtna41EY
         TkImIB1fb6p8bRg+HLoINa4zlVY6Q79MStuLYDItZ7/WA8SpH4xAB1rWR0IxhPIUddXK
         Irize80AAve1knqakBEjnoHu/KFX7cmEC575R9IuTt911LjjKxvhxR3DAxB2PMBRbJqE
         HE5c1jz1JdpKHGD5qyEpICT9F/t9dZpyjDkHzaXiDikMXCQ20boAyOZ8ZJkoPQo2mSaQ
         DNFS5sWt3SWBYNYUU/XHI0EVwPD9LvGS7NeogRxEsRNrW1s9jr6GttrpJW771912Uqg1
         JQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097437; x=1759702237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9b7QvSnRoRYi6+Zdq5Ij7NIpwv1sHaJRMnk3c2+aogQ=;
        b=j2zs3G/geHWFCNOAm+69Fu1mL8caCWF6XrhyV7iB7k5NmJWKQtAPcIwV1XY0vzfKSR
         ZeNmrEOHs2kfydfXuVoAjCH1FrVhbWnOKs0yYm+0hoBc/cI0puPSyk+rem76N7YJkhIn
         ZgWUvMcYxBVCUNLgbEnyV8EYodT3HL7WS+iW83Gi3R8pNbzGRiHFqi1Sllu30mulWuF+
         iDsbLXFBe918thtwzK6ulur3kGxd+AkFlDVKhUQ/ejAByVFWjU9RAEjmPvnfsZYMDXeb
         nq9RlRLfYX7IxyZKcV3OcDWfqfj+0UTzv6mNJ6h/I2HkDrwiducPW7WdAS3tKMAGRLAW
         AXSw==
X-Gm-Message-State: AOJu0Yydwd/0IUgT0CuQCh5UWBvcuK3NacwHhfroJb2OoHHzDODbVvfQ
	rH0QlPLRv9HwTwfmGwts9eDOvZnkZOXZkK9EdQ83/d4O+Lx0nClz07XwQ9uFi+k6LAuMud0olCl
	fvT7LcNzmoWFj
X-Gm-Gg: ASbGncuZfuNX4OdddfSPXr93Df2nEuFOR7TmaUohZVY0zlJd3UaIMyCSGeicaR/w8pY
	ExyEfhlDMr17k79830rfrFpmFneiXA/wYHdr6kHYBZvi/YqRrZiUvaA+1hdJ6EbBrONqkauMsKn
	lyJSahsBiWXU4+5dehspFlxO0xh9Hs8mnYnLVctRXV/aoCCUiFV/4rv/6M8OZmEANv0wzAB4STu
	tiqTe9qHQ2DAWi2R+nZE/p0X/NlitCzqKt9Geek1ErJxgpcv4hXstN5Gn97kyXvrAmZ70cXG7yr
	8tBM+uxUQTOxqCihUhd0d9yye7wjcl5IXqC02t+/QUtgEw1nTtU1qS0FtbcRdO9YuQ/peM+vw0/
	SPV+v7MF7QuCwy1Vf9keXo3GHq2VcC84hRjAODBFdMp60TO5l3wSD6uxGwws0j1MeJnquzlK2j5
	BlmGfaWhT+vcIxaJSIC989b/StVoxuHtBRfy0n
X-Google-Smtp-Source: AGHT+IENWnrZmvefzRKviRASzf+hts/FE1kZNzpla3g7GAr42ErwqPeIEb3yIt8VoIRNyo5Ht60VVw==
X-Received: by 2002:a05:690e:2411:b0:635:4ecd:5fd1 with SMTP id 956f58d0204a3-6361a89b63fmr11732876d50.46.1759097436788;
        Sun, 28 Sep 2025 15:10:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-eb383850bd7sm2999137276.5.2025.09.28.15.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:10:36 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:10:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 48/49] repack: move `write_cruft_pack()` out of the builtin
Message-ID: <4c6ec504e39e17f6114f4deb2e86c6a4f4f4109a.1759097191.git.me@ttaylorr.com>
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

In an identical fashion as the previous commit, move the function
`write_cruft_pack()` into its own compilation unit, and make the
function visible through the repack.h API.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Makefile         |  1 +
 builtin/repack.c | 94 ---------------------------------------------
 meson.build      |  1 +
 repack-cruft.c   | 99 ++++++++++++++++++++++++++++++++++++++++++++++++
 repack.h         |  6 +++
 5 files changed, 107 insertions(+), 94 deletions(-)
 create mode 100644 repack-cruft.c

diff --git a/Makefile b/Makefile
index 1e2c09da07..72d7a4686f 100644
--- a/Makefile
+++ b/Makefile
@@ -1137,6 +1137,7 @@ LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += refspec.o
 LIB_OBJS += remote.o
 LIB_OBJS += repack.o
+LIB_OBJS += repack-cruft.o
 LIB_OBJS += repack-filtered.o
 LIB_OBJS += repack-geometry.o
 LIB_OBJS += repack-midx.o
diff --git a/builtin/repack.c b/builtin/repack.c
index a9fc09a24d..9171ca66a7 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -106,100 +106,6 @@ static int repack_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
-static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_below_size,
-				      struct existing_packs *existing)
-{
-	struct packfile_store *packs = existing->repo->objects->packfiles;
-	struct packed_git *p;
-	struct strbuf buf = STRBUF_INIT;
-	size_t i;
-
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
-		if (!(p->is_cruft && p->pack_local))
-			continue;
-
-		strbuf_reset(&buf);
-		strbuf_addstr(&buf, pack_basename(p));
-		strbuf_strip_suffix(&buf, ".pack");
-
-		if (!string_list_has_string(&existing->cruft_packs, buf.buf))
-			continue;
-
-		if (p->pack_size < combine_cruft_below_size) {
-			fprintf(in, "-%s\n", pack_basename(p));
-		} else {
-			existing_packs_retain_cruft(existing, p);
-			fprintf(in, "%s\n", pack_basename(p));
-		}
-	}
-
-	for (i = 0; i < existing->non_kept_packs.nr; i++)
-		fprintf(in, "-%s.pack\n",
-			existing->non_kept_packs.items[i].string);
-
-	strbuf_release(&buf);
-}
-
-static int write_cruft_pack(struct write_pack_opts *opts,
-			    const char *cruft_expiration,
-			    unsigned long combine_cruft_below_size,
-			    struct string_list *names,
-			    struct existing_packs *existing)
-{
-	struct child_process cmd = CHILD_PROCESS_INIT;
-	struct string_list_item *item;
-	FILE *in;
-	int ret;
-	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
-
-	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
-
-	strvec_push(&cmd.args, "--cruft");
-	if (cruft_expiration)
-		strvec_pushf(&cmd.args, "--cruft-expiration=%s",
-			     cruft_expiration);
-
-	strvec_push(&cmd.args, "--non-empty");
-
-	cmd.in = -1;
-
-	ret = start_command(&cmd);
-	if (ret)
-		return ret;
-
-	/*
-	 * names has a confusing double use: it both provides the list
-	 * of just-written new packs, and accepts the name of the cruft
-	 * pack we are writing.
-	 *
-	 * By the time it is read here, it contains only the pack(s)
-	 * that were just written, which is exactly the set of packs we
-	 * want to consider kept.
-	 *
-	 * If `--expire-to` is given, the double-use served by `names`
-	 * ensures that the pack written to `--expire-to` excludes any
-	 * objects contained in the cruft pack.
-	 */
-	in = xfdopen(cmd.in, "w");
-	for_each_string_list_item(item, names)
-		fprintf(in, "%s-%s.pack\n", pack_prefix, item->string);
-	if (combine_cruft_below_size && !cruft_expiration) {
-		combine_small_cruft_packs(in, combine_cruft_below_size,
-					  existing);
-	} else {
-		for_each_string_list_item(item, &existing->non_kept_packs)
-			fprintf(in, "-%s.pack\n", item->string);
-		for_each_string_list_item(item, &existing->cruft_packs)
-			fprintf(in, "-%s.pack\n", item->string);
-	}
-	for_each_string_list_item(item, &existing->kept_packs)
-		fprintf(in, "%s.pack\n", item->string);
-	fclose(in);
-
-	return finish_pack_objects_cmd(existing->repo->hash_algo, opts, &cmd,
-				       names);
-}
-
 int cmd_repack(int argc,
 	       const char **argv,
 	       const char *prefix,
diff --git a/meson.build b/meson.build
index 4c60e016c3..2993b767dc 100644
--- a/meson.build
+++ b/meson.build
@@ -463,6 +463,7 @@ libgit_sources = [
   'reftable/writer.c',
   'remote.c',
   'repack.c',
+  'repack-cruft.c',
   'repack-filtered.c',
   'repack-geometry.c',
   'repack-midx.c',
diff --git a/repack-cruft.c b/repack-cruft.c
new file mode 100644
index 0000000000..accb98bcdb
--- /dev/null
+++ b/repack-cruft.c
@@ -0,0 +1,99 @@
+#include "git-compat-util.h"
+#include "repack.h"
+#include "packfile.h"
+#include "repository.h"
+#include "run-command.h"
+
+static void combine_small_cruft_packs(FILE *in, off_t combine_cruft_below_size,
+				      struct existing_packs *existing)
+{
+	struct packfile_store *packs = existing->repo->objects->packfiles;
+	struct packed_git *p;
+	struct strbuf buf = STRBUF_INIT;
+	size_t i;
+
+	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+		if (!(p->is_cruft && p->pack_local))
+			continue;
+
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, pack_basename(p));
+		strbuf_strip_suffix(&buf, ".pack");
+
+		if (!string_list_has_string(&existing->cruft_packs, buf.buf))
+			continue;
+
+		if (p->pack_size < combine_cruft_below_size) {
+			fprintf(in, "-%s\n", pack_basename(p));
+		} else {
+			existing_packs_retain_cruft(existing, p);
+			fprintf(in, "%s\n", pack_basename(p));
+		}
+	}
+
+	for (i = 0; i < existing->non_kept_packs.nr; i++)
+		fprintf(in, "-%s.pack\n",
+			existing->non_kept_packs.items[i].string);
+
+	strbuf_release(&buf);
+}
+
+int write_cruft_pack(struct write_pack_opts *opts,
+		     const char *cruft_expiration,
+		     unsigned long combine_cruft_below_size,
+		     struct string_list *names,
+		     struct existing_packs *existing)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct string_list_item *item;
+	FILE *in;
+	int ret;
+	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
+
+	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
+
+	strvec_push(&cmd.args, "--cruft");
+	if (cruft_expiration)
+		strvec_pushf(&cmd.args, "--cruft-expiration=%s",
+			     cruft_expiration);
+
+	strvec_push(&cmd.args, "--non-empty");
+
+	cmd.in = -1;
+
+	ret = start_command(&cmd);
+	if (ret)
+		return ret;
+
+	/*
+	 * names has a confusing double use: it both provides the list
+	 * of just-written new packs, and accepts the name of the cruft
+	 * pack we are writing.
+	 *
+	 * By the time it is read here, it contains only the pack(s)
+	 * that were just written, which is exactly the set of packs we
+	 * want to consider kept.
+	 *
+	 * If `--expire-to` is given, the double-use served by `names`
+	 * ensures that the pack written to `--expire-to` excludes any
+	 * objects contained in the cruft pack.
+	 */
+	in = xfdopen(cmd.in, "w");
+	for_each_string_list_item(item, names)
+		fprintf(in, "%s-%s.pack\n", pack_prefix, item->string);
+	if (combine_cruft_below_size && !cruft_expiration) {
+		combine_small_cruft_packs(in, combine_cruft_below_size,
+					  existing);
+	} else {
+		for_each_string_list_item(item, &existing->non_kept_packs)
+			fprintf(in, "-%s.pack\n", item->string);
+		for_each_string_list_item(item, &existing->cruft_packs)
+			fprintf(in, "-%s.pack\n", item->string);
+	}
+	for_each_string_list_item(item, &existing->kept_packs)
+		fprintf(in, "%s.pack\n", item->string);
+	fclose(in);
+
+	return finish_pack_objects_cmd(existing->repo->hash_algo, opts, &cmd,
+				       names);
+}
diff --git a/repack.h b/repack.h
index a7ddbe784b..15886c3488 100644
--- a/repack.h
+++ b/repack.h
@@ -137,4 +137,10 @@ int write_filtered_pack(struct write_pack_opts *opts,
 			struct existing_packs *existing,
 			struct string_list *names);
 
+int write_cruft_pack(struct write_pack_opts *opts,
+		     const char *cruft_expiration,
+		     unsigned long combine_cruft_below_size,
+		     struct string_list *names,
+		     struct existing_packs *existing);
+
 #endif /* REPACK_H */
-- 
2.51.0.243.g16eca91f2c0

