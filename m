Received: from sender4-pp-e103.zoho.com (sender4-pp-e103.zoho.com [136.143.188.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853902556E
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226449; cv=pass; b=YyH73MHAosdlceoEisKxBK0rZdvAkfmrAcPfRuZn1+yEV0T85rqHVstbhGNuZt52u4De7rVi6akjvQyrO0jAWBrSa8U8IglGXydJXmfbpVzDDCdfz9kIGjrVA0qwMJH0PP5Npb2uv7iPUbu/f0l4zvuXDmwGkz5Uva2yTtqpM9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226449; c=relaxed/simple;
	bh=/bmIlBcVPBrX41D+tPLK4MlHso7va3ciTT4QmZeJ5G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLqRDRWAFp0yn1MQcMdNNGW1PUGUYSVwcUh/gKvSwqEowSuLylosOSk6sxLCkdD+XShJSvb3/AaerDILkH5Q2A9ubPrOGpyr9pJKJq0fj4KHFOXNeYW0Sb+i/smuSNJdMY/bQlDd+r6Gos9IsJbkGhYjDaBGKG7PadoTzP37+Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=J+AX3RKb; arc=pass smtp.client-ip=136.143.188.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="J+AX3RKb"
ARC-Seal: i=1; a=rsa-sha256; t=1770226437; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nje9/Ume4kfkYIatESmI48WlOt0qr5YuDR9NQvuFqCO1z9e91VJEEQBN6KBpcTuGUoyExh+vFizhogdzj91tkhquju4xFR6jhY2zhIyu4s8lYuEJeCG+rDdjWTp/MDDAXT8IcUUnuiIOF4ltNV7FoEH6wwSl2+C2znY2OFlmhNY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770226437; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dO6189WO0w4EhCEklrbCrOEiyieC93PHcUA3oMsW1qs=; 
	b=k15gdgjJ6NHTf357s+eilIYBXp9SQG+qksAb5eNBh5iJcaUqJOKI04VXuXcIFvwu8o78o2aGxOlTrvRjCh+8setIxREIALlgTycLOx1to0L5W7bsZLP5vyrYl2mZm06l9Mq3Vg336pMzUXCEHQur3zdgCtQ2NFXYWiaB3PGZMFE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770226437;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=dO6189WO0w4EhCEklrbCrOEiyieC93PHcUA3oMsW1qs=;
	b=J+AX3RKb4vlQ5zIF/NAyoc9Zr5LOFg2uKsZ9USAO7cBR3V/6pijGK07acCohL0s6
	oRl0W9uav+GuhIQBFl+S8pWhqNnzxllFg/uY5T7f1Jx+7S8OIrYv7XyjlaqFEIq8E8H
	p2GhsBM7/1Pba+KfJp5nr1cUmJhLAELZ0ffWyQFk=
Received: by mx.zohomail.com with SMTPS id 1770226434399662.1586795234689;
	Wed, 4 Feb 2026 09:33:54 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 1/4] config: add a repo_config_get_uint() helper
Date: Wed,  4 Feb 2026 19:33:25 +0200
Message-ID: <20260204173328.1601807-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Next commit adds a 'hook.jobs' config option of type 'unsigned int',
so add a helper to parse it since the API only supports int and ulong.

An alternative is to make 'hook.jobs' an 'int' or parse it as an 'int'
then cast it to unsigned, however it's better to use proper helpers for
the type. Using 'ulong' is another option which already has helpers, but
it's a bit excessive in size for just the jobs number.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 config.c | 28 ++++++++++++++++++++++++++++
 config.h | 13 +++++++++++++
 parse.c  |  9 +++++++++
 parse.h  |  1 +
 4 files changed, 51 insertions(+)

diff --git a/config.c b/config.c
index 7f6d53b473..f842c31798 100644
--- a/config.c
+++ b/config.c
@@ -1212,6 +1212,15 @@ int git_config_int(const char *name, const char *value,
 	return ret;
 }
 
+unsigned int git_config_uint(const char *name, const char *value,
+			     const struct key_value_info *kvi)
+{
+	unsigned int ret;
+	if (!git_parse_uint(value, &ret))
+		die_bad_number(name, value, kvi);
+	return ret;
+}
+
 int64_t git_config_int64(const char *name, const char *value,
 			 const struct key_value_info *kvi)
 {
@@ -1907,6 +1916,18 @@ int git_configset_get_int(struct config_set *set, const char *key, int *dest)
 		return 1;
 }
 
+int git_configset_get_uint(struct config_set *set, const char *key, unsigned int *dest)
+{
+	const char *value;
+	struct key_value_info kvi;
+
+	if (!git_configset_get_value(set, key, &value, &kvi)) {
+		*dest = git_config_uint(key, value, &kvi);
+		return 0;
+	} else
+		return 1;
+}
+
 int git_configset_get_ulong(struct config_set *set, const char *key, unsigned long *dest)
 {
 	const char *value;
@@ -2356,6 +2377,13 @@ int repo_config_get_int(struct repository *repo,
 	return git_configset_get_int(repo->config, key, dest);
 }
 
+int repo_config_get_uint(struct repository *repo,
+			 const char *key, unsigned int *dest)
+{
+	git_config_check_init(repo);
+	return git_configset_get_uint(repo->config, key, dest);
+}
+
 int repo_config_get_ulong(struct repository *repo,
 			  const char *key, unsigned long *dest)
 {
diff --git a/config.h b/config.h
index ba426a960a..bf47fb3afc 100644
--- a/config.h
+++ b/config.h
@@ -267,6 +267,12 @@ int git_config_int(const char *, const char *, const struct key_value_info *);
 int64_t git_config_int64(const char *, const char *,
 			 const struct key_value_info *);
 
+/**
+ * Identical to `git_config_int`, but for unsigned ints.
+ */
+unsigned int git_config_uint(const char *, const char *,
+			     const struct key_value_info *);
+
 /**
  * Identical to `git_config_int`, but for unsigned longs.
  */
@@ -560,6 +566,7 @@ int git_configset_get_value(struct config_set *cs, const char *key,
 
 int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
 int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
+int git_configset_get_uint(struct config_set *cs, const char *key, unsigned int *dest);
 int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest);
 int git_configset_get_bool(struct config_set *cs, const char *key, int *dest);
 int git_configset_get_bool_or_int(struct config_set *cs, const char *key, int *is_bool, int *dest);
@@ -650,6 +657,12 @@ int repo_config_get_string_tmp(struct repository *r,
  */
 int repo_config_get_int(struct repository *r, const char *key, int *dest);
 
+/**
+ * Similar to `repo_config_get_int` but for unsigned ints.
+ */
+int repo_config_get_uint(struct repository *r,
+			 const char *key, unsigned int *dest);
+
 /**
  * Similar to `repo_config_get_int` but for unsigned longs.
  */
diff --git a/parse.c b/parse.c
index 48313571aa..d77f28046a 100644
--- a/parse.c
+++ b/parse.c
@@ -107,6 +107,15 @@ int git_parse_int64(const char *value, int64_t *ret)
 	return 1;
 }
 
+int git_parse_uint(const char *value, unsigned int *ret)
+{
+	uintmax_t tmp;
+	if (!git_parse_unsigned(value, &tmp, maximum_unsigned_value_of_type(unsigned int)))
+		return 0;
+	*ret = tmp;
+	return 1;
+}
+
 int git_parse_ulong(const char *value, unsigned long *ret)
 {
 	uintmax_t tmp;
diff --git a/parse.h b/parse.h
index ea32de9a91..a6dd37c4cb 100644
--- a/parse.h
+++ b/parse.h
@@ -5,6 +5,7 @@ int git_parse_signed(const char *value, intmax_t *ret, intmax_t max);
 int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max);
 int git_parse_ssize_t(const char *, ssize_t *);
 int git_parse_ulong(const char *, unsigned long *);
+int git_parse_uint(const char *value, unsigned int *ret);
 int git_parse_int(const char *value, int *ret);
 int git_parse_int64(const char *value, int64_t *ret);
 int git_parse_double(const char *value, double *ret);
-- 
2.52.0.732.gb351b5166d.dirty

