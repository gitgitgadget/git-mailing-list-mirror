Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B948323AB8D
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 19:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875819; cv=none; b=cnz+v7hckY+F8fqmo9hHOSdNa09hboO8PyoiAz7Lf+ECahFrc50i2Wre/gi7IU8b7HEW0BXx0Vp/GpoPbF/jTYNxBaYe8cD+AQpOkGgFV9X5HLs/8zoD3fmAu348lVOmeL42CjpznKDaSXDvcb8yoL0xGhYdH8kp9XrrhoHRtds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875819; c=relaxed/simple;
	bh=Br9fh4xYZp/0+MMbJVSZzLA+hlTvy+PAmwgycQT9I3I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QKFcJ13rxy1n3tw75THIotfPbbMEedfkppATftyLbo3s3P5+Nmeqy/cw+SpHyG0XIN/RnPz/HyA91QynCb164+PK4Vs4oHRqOQR7hNEQ6B/1S+vKENhIZhGuJweYcaakL5gCKyspCAwKiAKAWg8LqJbqCcU8ni5AxwFVN6byp5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klQXfLuQ; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klQXfLuQ"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-896f44dc48dso43156636d6.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771875816; x=1772480616; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyHey4t4KqYE+27pGtOhB2Kz5WT8ieoG1Bb3LiW+6fE=;
        b=klQXfLuQhrLHdfYNyoJXFb7HD0k6uSip2r0u+cNfWBTzFSLo1cyTmbvWbtypHN+Xgv
         0WmcFk2gyAzeNlVJ4HD3tem6w+fskC4+5mn3RrbmCv4e2MFsyPnz/CPfZRfdHrM4Oh5r
         NnDs/9mK6Wj+7oZV0CVR1UtPiiPrOcoqrDyWoOsjN4h54S4vbOl3lzygJ8KhH7BsGEeC
         lBKskZ0qcYegL27PU/7fBjGiUvh2xSRleaEkAfFvgjhpMeP+cFb5spgc3h7FsN6r3P+M
         euClu2GeJF6rtCNVkgd05SgPdAgUQjCwM22A7P0U1yAsmgA3jKpyFqNeMSl+Wrx+0r72
         XlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771875816; x=1772480616;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dyHey4t4KqYE+27pGtOhB2Kz5WT8ieoG1Bb3LiW+6fE=;
        b=Gfb9cvvJNUx2DBl169nHjbmdu3JTXNgj1QKsr8IJfc4+FlUSf0zL36EJ45rhwgDatc
         hJh+UzuNaJYjzYAF5N3XSwHGPi/VdU9Zb6JSubl8c7JXZC/EF+dLygv9W6Cj3VGn8oXB
         qbBnV+OjYBBF/WnNgBeRy474dogOg8jrFx3ejT0AJ1ysi3lxZt/DnJFh8Hvuwrcdxl+t
         9w5bhPyKx6SeWqs65MJOPOvLwAanBT5sCRCSDjzTKbmBBVCyjkjXfTDuL+6TlSrwIzjZ
         dupTSCrNa1cjFMXemzOpxvLwLWIamgJ7doO/ctvVnA7T9dniNDnN+LLFhlWtbOp4V3cA
         KX4A==
X-Gm-Message-State: AOJu0YwDV9JLaOySIVZnC5WUQYeQn3iyCOerhhP3hZhoyDVWWGa69iYI
	j3SWj5G0JcCFGDtleeBaW1PQC9cE2QomJ8eZq1wSIlQv3FNKKIWU7M0K0EgtCA==
X-Gm-Gg: ATEYQzy2qBEGn/sx58xliolVLW4rNlRkAuOwKhBTYvkz19utsLWk4riacXWFBCZ3sTv
	0IarJoRSZ9GOBiEiL+gs7dryx75vjIWxaAzbhd1LI5Rp7Whv7nSPX9wJ6kaGl332ZG5ZYxCZBns
	m33YUKc9CSGNq38PHKdB91wH4a+9n4M7PzSHqGFM/2OPFDM73uAjcwKx/b/Pz2luxZY/DZ5RvCl
	2lRtGdor+Q40/g6y5X/dprd7M3LVcrP4GBYc+dpF288+VntcrGOqar3atAwPyMq+q0ZNpgmIwv/
	0yeDe4SGru8XLjTfS6ZiF5qMF/VHDkan2FUdYfRP2BkVFh+zkPNbFrB3+kMUfC4B5HLKKBYXCpd
	uH0ZRLbPtthpjOJ4WvttIxui6o2Qz203HzdBdM6p91DTQ0LXTQ8MUaH5t9x2s7Kb73FYuERURc6
	8nF+DStgHRhfS12nLF3dIdtzyygem6mNqO39M5ug==
X-Received: by 2002:a05:6214:f02:b0:892:6efb:95e3 with SMTP id 6a1803df08f44-89979c3be25mr146688646d6.3.1771875816256;
        Mon, 23 Feb 2026 11:43:36 -0800 (PST)
Received: from [127.0.0.1] ([135.232.224.163])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e77cddfsm86478236d6.52.2026.02.23.11.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:43:35 -0800 (PST)
Message-Id: <e9ea572e52efe8e406c56b8690bb798aeef956e1.1771875812.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
References: <pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
	<pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 19:43:28 +0000
Subject: [PATCH v3 1/5] repo: teach info context and category keys
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Introduce an explicit repo_info context for the repo info codepath
and thread it through value lookups and field printing.

This removes direct coupling from these helpers to ad-hoc
repository globals and makes key retrieval logic easier to extend
safely.

Also teach git repo info to accept category names (for example,
layout) and expand them to matching key.* entries in request
order.

This improves script ergonomics while preserving existing behavior
for explicit keys and clear errors for unknown names.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 builtin/repo.c | 70 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 15 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 0ea045abc1..e34914a9a7 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -22,7 +22,12 @@ static const char *const repo_usage[] = {
 	NULL
 };
 
-typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
+struct repo_info {
+	struct repository *repo;
+	const char *prefix;
+};
+
+typedef int get_value_fn(struct repo_info *info, struct strbuf *buf);
 
 enum output_format {
 	FORMAT_TABLE,
@@ -35,27 +40,30 @@ struct field {
 	get_value_fn *get_value;
 };
 
-static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
+static int get_layout_bare(struct repo_info *info UNUSED, struct strbuf *buf)
 {
 	strbuf_addstr(buf, is_bare_repository() ? "true" : "false");
 	return 0;
 }
 
-static int get_layout_shallow(struct repository *repo, struct strbuf *buf)
+static int get_layout_shallow(struct repo_info *info, struct strbuf *buf)
 {
+	struct repository *repo = info->repo;
 	strbuf_addstr(buf,
 		      is_repository_shallow(repo) ? "true" : "false");
 	return 0;
 }
 
-static int get_object_format(struct repository *repo, struct strbuf *buf)
+static int get_object_format(struct repo_info *info, struct strbuf *buf)
 {
+	struct repository *repo = info->repo;
 	strbuf_addstr(buf, repo->hash_algo->name);
 	return 0;
 }
 
-static int get_references_format(struct repository *repo, struct strbuf *buf)
+static int get_references_format(struct repo_info *info, struct strbuf *buf)
 {
+	struct repository *repo = info->repo;
 	strbuf_addstr(buf,
 		      ref_storage_format_to_name(repo->ref_storage_format));
 	return 0;
@@ -87,6 +95,33 @@ static get_value_fn *get_value_fn_for_key(const char *key)
 	return found ? found->get_value : NULL;
 }
 
+static void print_field(enum output_format format, const char *key,
+			const char *value);
+
+static int print_category_fields(const char *category,
+				 struct repo_info *info,
+				 enum output_format format,
+				 struct strbuf *valbuf)
+{
+	int found = 0;
+	size_t category_len = strlen(category);
+
+	for (size_t i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
+		const struct field *field = &repo_info_fields[i];
+
+		if (!starts_with(field->key, category) ||
+		    field->key[category_len] != '.')
+			continue;
+
+		strbuf_reset(valbuf);
+		field->get_value(info, valbuf);
+		print_field(format, field->key, valbuf->buf);
+		found = 1;
+	}
+
+	return found;
+}
+
 static void print_field(enum output_format format, const char *key,
 			const char *value)
 {
@@ -105,7 +140,7 @@ static void print_field(enum output_format format, const char *key,
 }
 
 static int print_fields(int argc, const char **argv,
-			struct repository *repo,
+			struct repo_info *info,
 			enum output_format format)
 {
 	int ret = 0;
@@ -117,21 +152,22 @@ static int print_fields(int argc, const char **argv,
 
 		get_value = get_value_fn_for_key(key);
 
-		if (!get_value) {
-			ret = error(_("key '%s' not found"), key);
+		if (get_value) {
+			strbuf_reset(&valbuf);
+			get_value(info, &valbuf);
+			print_field(format, key, valbuf.buf);
 			continue;
 		}
 
-		strbuf_reset(&valbuf);
-		get_value(repo, &valbuf);
-		print_field(format, key, valbuf.buf);
+		if (!print_category_fields(key, info, format, &valbuf))
+			ret = error(_("key '%s' not found"), key);
 	}
 
 	strbuf_release(&valbuf);
 	return ret;
 }
 
-static int print_all_fields(struct repository *repo,
+static int print_all_fields(struct repo_info *info,
 			    enum output_format format)
 {
 	struct strbuf valbuf = STRBUF_INIT;
@@ -140,7 +176,7 @@ static int print_all_fields(struct repository *repo,
 		const struct field *field = &repo_info_fields[i];
 
 		strbuf_reset(&valbuf);
-		field->get_value(repo, &valbuf);
+		field->get_value(info, &valbuf);
 		print_field(format, field->key, valbuf.buf);
 	}
 
@@ -171,6 +207,10 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			 struct repository *repo)
 {
 	enum output_format format = FORMAT_KEYVALUE;
+	struct repo_info info = {
+		.repo = repo,
+		.prefix = prefix,
+	};
 	int all_keys = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
@@ -192,9 +232,9 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 		die(_("--all and <key> cannot be used together"));
 
 	if (all_keys)
-		return print_all_fields(repo, format);
+		return print_all_fields(&info, format);
 	else
-		return print_fields(argc, argv, repo, format);
+		return print_fields(argc, argv, &info, format);
 }
 
 struct ref_stats {
-- 
gitgitgadget

