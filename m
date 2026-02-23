Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7154927FD43
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856474; cv=none; b=UjSbB0LKx86H45nAdQ+HJdnPpUDpwsUFhUR4zgtVYTDYfHosFdQidiJhSNMbJBJf6s29lJYv2TV0/LGMQz+rrMdFoypTYw6MGabnyPKgIFvSm85zwOHjBHlcs2GYDirR2FU1WlKFv3DgAgABHNs4PvhjjgXsxVw2CZ0zcIsGyEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856474; c=relaxed/simple;
	bh=Br9fh4xYZp/0+MMbJVSZzLA+hlTvy+PAmwgycQT9I3I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IT2zzPfzSTV+cJPwcIb1fBNcZm3Z7YfXl66R3oeoKJbGiu6UpbFSs6fVd1OoXcZdoJjU/UgTjvtfXOjYHGBnw9+3aUuZiIqPgX8X0RRpbwyZDF6ResIwC6a+VYEh3EP5Hee596nJBnAn0z3HyDz+FLUogX2r1X5YMA/PhV+UcDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/2DImD1; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/2DImD1"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb4097794dso446846585a.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 06:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771856472; x=1772461272; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyHey4t4KqYE+27pGtOhB2Kz5WT8ieoG1Bb3LiW+6fE=;
        b=G/2DImD1tOlY/Pn2EbAi/yMzDny3ZVPqlOofEEckBmJ/FUanuyhnoBu0RMay+ZRKwr
         TtxisQ5yV3CF6PnJt7qo7ClXxb5IkQv2FZWb4jlAejHZ1ty7QRrY90LQbif30Zbqjof3
         4YzzQ9vo0P7JcAgfdJfb9WYACV0GNBzIECHiE9V8cvJZSloFwN781aBU4cSy+PLyor2t
         2FwL5ynzzydiLAe59cXi7UQuwM2S8vdeiFRUKcfUfv61BsPWeqLrbwqYGmIIez2cT9Om
         +NsqpxRZru+4uM+r8p/JUK7WZisfvrNZmoBMqGn0dM2Lkm4BwNdymWwpI3HBw8fOvxI4
         cQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856472; x=1772461272;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dyHey4t4KqYE+27pGtOhB2Kz5WT8ieoG1Bb3LiW+6fE=;
        b=gOTjLTY49dXT2aFCEaM5wJN4Vm6DILL1J5U8LfM4MKkEbpNMIkN/R+qTeYE9ATMIh4
         8W3+28s8Zda9jv1kIeiEEn6f4ExcWd8Ce26JULOYd0Q79XjkBOX6cpeqa/wfHzDPmtCX
         XCsNyXDlZVEHtg3/fX2BZpu0AoixvUJ1FELDExtFtjg74hHMhTORhGAucsxr9dp8Ip0s
         My75pqk1zGrxCCXrUsEYJT9XeggDFdxGPDC9eRvgpJ0c+UwN7EM2edzcS6HZX6FFYBlV
         iS6CRK3MLaJJSgJ+yfFpGBDmf2/kTLlZ6Y7AsZL2phgebN726BRmJbKOY4YmlZfSklpp
         YyZw==
X-Gm-Message-State: AOJu0YzX7mlBXhxga6qPVnAEUJ7n8QmvJZc/M0Fz8OHrQgo8RJThYdU8
	o/h/+G5ag7xhCJaVy5Cnw0zibC4J+CCpjc/YdponYIm+H0uq7phhp9rUROmDcw==
X-Gm-Gg: AZuq6aKZeekzdqywolyXR9mjWsq5D+kK5co2GgzETB43nNBhE69dndAKKMSNWRs3uZZ
	oA5uCDUNnz519wwFxuUtO6bTx2Dt5OalAHOq6Mhve48V9Vgn2EDzl11vU6zliFc+BHLma8Qqqij
	4jlDwj1i5OaiZZLAEKSQoZn95WLAd68LU4bpAl0pXBeQfGVc68hxBbIog7aQXm9kJrcfpu3fhRy
	Zal5yADcSffpHucxQ5Y1z8qsgAjquZRZ7fQpO3ReCQFKZhUOfUKl4HpuxqfSFAxI/g/jYdfO1pY
	2v/C2Ra101QkHymxxlY1pEFfnIigsnstQpXq9wKSwiA2Dt+B8mFbwrfsMXMyRPNNzfNLgjI5Ip7
	t0MPw3hX5j7dNxcpr3R5ETEpODieJ38qjNknGjETmBeVa8RCl2RIjfeHrMzWXnUsXeOvwIHjw6p
	lQKiQg/klVPAV5ipVxsYPXkog=
X-Received: by 2002:a05:620a:4505:b0:8c6:a5aa:465c with SMTP id af79cd13be357-8cb8ca8202cmr1063350885a.55.1771856471954;
        Mon, 23 Feb 2026 06:21:11 -0800 (PST)
Received: from [127.0.0.1] ([20.55.15.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d044016sm724397085a.7.2026.02.23.06.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:21:11 -0800 (PST)
Message-Id: <99c8058298d403508ab2a23ed06c36b8707989d0.1771856469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
References: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com>
	<pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 14:21:01 +0000
Subject: [PATCH v2 1/9] repo: teach info context and category keys
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

