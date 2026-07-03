Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF6B22B8AB
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097261; cv=none; b=eCKz/uoBDwA6Mxk7+IdB28hCZ5nZZ3VQpumHvfRdeqR4crp2CSKZ1cGX7juL7u2/VlU6GZow0UO37Sh20BfreH34iwa/wQsKrBFcfDaEZk72HzyOgc8F6zaAgwdQ85nqYoWA78Aa6bV3iFY+dTCHdzYiI/Jiu+U9tjytDpYsQu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097261; c=relaxed/simple;
	bh=ctSrD5lRKUZ9IMsU9aZcTsMp0p7ddbYCyD30A1aAcII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cVhEFUFXCsToAycjhPv4nE0ZWm4TwIqBvkVUZYZIWy6tUqrriNJP4ndu5ESStfll3mK1zSrd6HjHFxQXiJvuDS5rt36y4/Z1ozPMOgL+5/4QxCF4iU9e/vjNk913lSuzPQehQXo2Q1LNkkeG6D7Cjgij+pv8xPqVG7iN5LHr7Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADk5Zq+s; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADk5Zq+s"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c96cb024ee0so527459a12.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2026 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783097259; x=1783702059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BW5xp2ZKIuQSwrwHInu7B4EXIA+UBqmf/MadfVoXKyA=;
        b=ADk5Zq+s05nmoNJwmxIOATrR2cL6ABZZ2hPpKLY9P3aM/sgElju7mJuZGdqfs0DJ4V
         MfsmJZwCALkqprCpcteZpWosMn59dlGuO/Kvmiv2QPaFEQYBauz48uWf4bABNNfxtX/v
         frJDt7MnExAmpuxsfoRjxXMY0SSmWLdOVol9CasPuT9BenobMiRhWkXe5jgGpuFUBFX2
         W2gazwPuxh3LEN6QUYpwED/4fnMFlPa2WM+41bHevHDV9Fj7kYNE4W8hVVGcJZZftM+6
         TFsqJWl/iIwDxcBeWZnIVfUlRr/+b4Ut1RfltnQiK5vbmF2kUkK5WiDMl+y7lnm/UfFO
         O4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783097259; x=1783702059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BW5xp2ZKIuQSwrwHInu7B4EXIA+UBqmf/MadfVoXKyA=;
        b=cQFRgMtciLKvze2n6SjjjT+1KbaYQHonOBYH/1Nd076tWZYgBadrOxJFf97AFW8EU6
         iRTyhqr0w+IaEuTLzUobNiEpWghVB1UlNQQjfc/kNuVjKfwKsOWyGFzNvuypYO5M0CPx
         NDUnZFGMxw92+7Xjx/20414VKHRTkeLcEulWR2jGdqNlb4/xmFbuBcFwAxpikxz6rUzv
         ocWUEw9vKnobbZgJmNGjHq74xzIyx7JuC4xOTImuICpZxrrpPZJikMWo5hV/U1yNatof
         lkzRH64UxY2VAiCO3BY0bmHbVYcTh7i10yt4M/1FyEkGbO5w4G99essXGOwY5SN2Xpd4
         z6FQ==
X-Gm-Message-State: AOJu0Yyi/U3da3z36hKZeJ3x2b2C3dcLechjLalNxFL5Rk2yduhpmbXK
	jyncyP45G7CcsG2n+lpcnjB9+dcKjtQMYYLHpXON1z2RAgAqQTNEVTkiS9PlGQ==
X-Gm-Gg: AfdE7cnuyx8bJOfeajlEyh3QjXTtSffl0PifQScKeCB5UP8o0Tv2Ib8IPiiV3XVK6CD
	+Pqd59ACfguiCVk1YaCH7HxH5Mc6PKYlol97z3DcP0Sla0jlDVVmKR1cbYZvYZXK7Y0gDpfGwB+
	n68bLcPc6pVH76TnyrIqBW0SLXjej0fkvaOo9cS+SQwSWz3wLcxnpRKuwsHmCkjnS/y/EB868HQ
	/BimvPhsZZ4bvLjyebPPL4Sd3na4DWouPs+AuSQigT1fvXBgKhi8ABc5Nn3AGVs0liuiYndbaDb
	jZgbHZ8NSbU0B67ETuqrguO1uX71NW+hIxXl/wF49Tp+vVVliCkn168Y0ai8tWGt8pC/yUayNEV
	TIxrXWlnkiNQn+ROe3sZ9HwnvW+ml3nwBlP0DwUokdaSSbLLDa96cLmj0/RZsRC8Q2xEcAP9I0r
	03upR15J1NDXk6fuE+s8F++eZdg0/jxfbZUtd0CJklOZ2tgfzqak9Pg7jFVEN5LAfeBF4twNbBP
	TzIs25FEjbiEjREs8ySGbw=
X-Received: by 2002:a05:6a21:485:b0:3bf:a638:4376 with SMTP id adf61e73a8af0-3c03e20ca42mr207927637.21.1783097258847;
        Fri, 03 Jul 2026 09:47:38 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa33asm22609757c88.5.2026.07.03.09.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 09:47:38 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch] repo: support category-based prefix querying for info keys
Date: Fri,  3 Jul 2026 22:17:09 +0530
Message-ID: <20260703164709.22723-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.0-rc1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, git repo info relies on an all-or-nothing query model
where users must either know the exact, fully-qualified key name or use
the --all flag to dump the entire repository state.
As the number of supported keys expands, dumping all metadata and
relying on external filters like grep becomes an inefficient bottleneck
for a plumbing command.

Enable category-based prefix querying so users can request
entire groups of related keys natively

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
Hi!

This patch adds category-based prefix querying to
`git repo info` as part of my GSoC project.
A quick note on the implementation: I replaced the `bsearch` with
a linear search to find the initial prefix match.
I discussed this with my mentors, and we decided to fall back
to a linear search because the overhead of a custom binary search
(to find the *first* match in a block) wasn't justified given
the currently small size of the `repo_info_field` array.

Since the array is strictly sorted alphabetically,
the loop safely short-circuits via `strncmp`
once it steps outside the matching prefix block.

Looking forward to feedback!

 Documentation/git-repo.adoc | 12 ++++++++
 builtin/repo.c              | 58 +++++++++++++++++++++++--------------
 t/t1900-repo-info.sh        | 16 ++++++++++
 3 files changed, 64 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 42262c1983..3e840d6323 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -25,6 +25,12 @@ COMMANDS
 	the requested data will be returned based on their keys (see "INFO KEYS"
 	section below).
 +
+If a `<key>` argument matches a category prefix (i.e. a namespace that ends at
+a `.` boundary), all keys within that namespace are returned. For example,
+`layout` returns both `layout.bare` and `layout.shallow`. The prefix must
+align with a namespace boundary; partial prefixes that do not end at a `.`
+separator (e.g. `lay`) are treated as unknown keys and will produce an error.
++
 The values are returned in the same order in which their respective keys were
 requested. The `--all` flag requests the values for all the available keys.
 +
@@ -126,6 +132,12 @@ using the `nul` format:
 git repo info --format=nul layout.bare layout.shallow
 ------------
 
+* Retrieves all keys under the `layout` category prefix:
++
+------------
+git repo info layout
+------------
+
 SEE ALSO
 --------
 linkgit:git-rev-parse[1]
diff --git a/builtin/repo.c b/builtin/repo.c
index 71a5c1c29c..91ea5b5459 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -90,24 +90,27 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "references.format", get_references_format },
 };
 
-static int repo_info_field_cmp(const void *va, const void *vb)
+static int is_valid_prefix_match(const char *key, const char *prefix)
 {
-	const struct repo_info_field *a = va;
-	const struct repo_info_field *b = vb;
+	size_t prefix_len = strlen(prefix);
 
-	return strcmp(a->key, b->key);
+	if (!prefix_len)
+		return 0;
+
+	if (strncmp(key, prefix, prefix_len))
+		return 0;
+
+	return key[prefix_len] == '\0' || prefix[prefix_len - 1] == '.' || key[prefix_len] == '.';
 }
 
-static const struct repo_info_field *get_repo_info_field(const char *key)
+static size_t find_first_repo_info_field_match(const char *prefix)
 {
-	const struct repo_info_field search_key = { key, NULL };
-	const struct repo_info_field *found = bsearch(&search_key,
-						      repo_info_field,
-						      ARRAY_SIZE(repo_info_field),
-						      sizeof(*found),
-						      repo_info_field_cmp);
-
-	return found;
+	for (size_t i = 0; i < ARRAY_SIZE(repo_info_field); i++) {
+		if (is_valid_prefix_match(repo_info_field[i].key, prefix)) {
+			return i;
+		}
+	}
+	return SIZE_MAX;
 }
 
 static void print_field(enum output_format format, const char *key,
@@ -135,17 +138,28 @@ static int print_fields(int argc, const char **argv,
 	struct strbuf valbuf = STRBUF_INIT;
 
 	for (int i = 0; i < argc; i++) {
-		const char *key = argv[i];
-		const struct repo_info_field *field = get_repo_info_field(key);
-
-		if (!field) {
-			ret = error(_("key '%s' not found"), key);
-			continue;
+		const char *prefix = argv[i];
+		size_t prefix_len = strlen(prefix);
+		size_t idx = find_first_repo_info_field_match(prefix);
+		int found = 0;
+
+		for (; idx < ARRAY_SIZE(repo_info_field); idx++) {
+			const struct repo_info_field *field = &repo_info_field[idx];
+
+			if (strncmp(field->key, prefix, prefix_len))
+				break;
+
+			if (is_valid_prefix_match(field->key, prefix)) {
+				strbuf_reset(&valbuf);
+				field->get_value(repo, &valbuf);
+				print_field(format, field->key, valbuf.buf);
+				found = 1;
+			}
 		}
 
-		strbuf_reset(&valbuf);
-		field->get_value(repo, &valbuf);
-		print_field(format, key, valbuf.buf);
+		if (!found) {
+			ret = error(_("key '%s' not found"), prefix);
+		}
 	}
 
 	strbuf_release(&valbuf);
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 39bb77dda0..80ae8f8396 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -149,6 +149,22 @@ test_expect_success 'git repo info --keys uses lines as its default output forma
 	test_cmp expect actual
 '
 
+test_expect_success 'git repo info with category prefix returns all keys in namespace' '
+	cat >expect <<-\EOF &&
+	layout.bare=false
+	layout.shallow=false
+	EOF
+	git init prefix-repo &&
+	git -C prefix-repo repo info layout >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git repo info with invalid partial boundary fails' '
+	echo "error: key ${SQ}lay${SQ} not found" >expect &&
+	test_must_fail git -C prefix-repo repo info lay 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git repo info -h shows only repo info usage' '
 	test_must_fail git repo info -h >actual &&
 	test_grep "git repo info" actual &&
-- 
2.55.0-rc1
