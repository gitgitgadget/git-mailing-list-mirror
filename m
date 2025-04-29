Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340852192E1
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938400; cv=none; b=YMbz7LbzKVfjwsoMqgxF1EdpQ1nJuk/SVwybLORm9iPAOfZ96OvLGuZ/cNVzTl/Vp29fSZrG0SdzLWnCz+XPLnI3JiDNAwLvgeTJ2e3WiiaEatNdwaB2XHA1AIJ0ZlFyEiOLhGjtduZDQO4wM1COikiWldMXnhdjedXQpfRrsqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938400; c=relaxed/simple;
	bh=SqARHAzyRimca/OO8TAoI+ocxc0aoXx1eWj2K49D8Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHojYi5Og1M8CsoqfWnAr8mEVjINjfGa5dg5VJRygIQ1+lpcZ1QzwZwkYMl6IrLf+Jy3gw87Fja5zrdhoED18W9KHNmQhKCjL3mPZ1KtV6ZilnxhD3DN6Z2ibrPbkeDUeoUaBOwziWsODWi7wTBBNm1bQ0LRRtKUOGV7BsZ0glM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaQUZElQ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaQUZElQ"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5f7ec0e4978so5297215a12.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 07:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745938395; x=1746543195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kr7P/OyV/+tJMI6O0Ds9VgvRXR8+fG8ypT3IlHeAr0E=;
        b=UaQUZElQY8nvWJWuIqRzPZQwEMN9DXm8qRNGmyU35ZF+xkEi9xquFVFTT/oN/PAxQ7
         8dd7/h++wxOWBc2hVh+KZvAu8fLW+N3Z3setFE8OV41s5uK75t+mJtH4y+CyVXMzctNh
         jHuI8+9RE8H0ep6ydxa+3z7ska6QaArd2K8aj/cO8lZIlYjf72WdeUoBKkADk8ACFvsZ
         BFFFG0sFlsteuQTkeLy1kwhdYfHRQG0WPP3F3KdGQsZBd9Jqj/xtnW9d3jMF4TWmFa+9
         UYuubXkIZDVUgGaAcI/dze5sYYJIha8LU5CIRAT8YErqDLh8ZEpPVs7WHor7tVc8jJhY
         0kMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745938395; x=1746543195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kr7P/OyV/+tJMI6O0Ds9VgvRXR8+fG8ypT3IlHeAr0E=;
        b=Gg66Iqv4II5gaVeI/Acn/c63GXoE4YdP/dWmiv6WlEyBR7p17aP4f0ZH3zsd80PF8L
         e2hgnAs7ehrVZJBjdZGcHRhetLe2fZ/pNV0TgGJJrenh7wOYBSUmdc0vb6a8vuBMmsb1
         uJurigGysv9MJEX2wWaf0xW+OeXBP8vObwwC492U+ruuWVHDWtoWoUoQO3p1wGZavde2
         J6iuiFD+BTK73QsUzqvavATAvbsgzI5yCpBl98l0C9ndcgKIzJxmEc4E4TVttpJsmLWg
         MlYvd5lgzOvygXbjvFrSIPIzxwRvjlS0xH4ldJZFyxD1HlGP1J0ImKk7XzQXc+YnmuCL
         IHwQ==
X-Gm-Message-State: AOJu0YwHgjT1pkbmAlZdRedm8BE/QJYVihdCfV/h+OkXBI3b1C33swrD
	Jsz98HiHkf8h16SZ/J5ZMZiEDAjyUCeeHUx2RDNHF53xTUB0G8wi+0ejfg==
X-Gm-Gg: ASbGncvrb9Mp0ZRvjb2FDb5XRQVT+5mF84HCvaRZAt6CJ9FsYUU0gYZpK36/GJ2fbT0
	6yNmaIYnEqlOD6PIPj9det3SO+Z/lSnzoamxdRt1tDskuGvbXQaOnI4HxteKWsxGE5I2fgaViRZ
	mh0z5sYwoEoaCzAlM0XrV+uBtr11WUJ+Eco3s/l5u34IOx6ABf4Omh5PoNDUgjTkbCJYKhM83VO
	VuomIdsDmVtBXaCzTsfBdUVgiOIa6pI8TdG+7FGPvp7koafo6DEwgImb38j6J07i7b7Vwv0ZOO6
	DSN+HucdonsX1+ykJi75S4IkzKeoSIjHOoqiklYqMkL5haeK7hXiI5zgiu6UriQBOqUz/YRSsZp
	O
X-Google-Smtp-Source: AGHT+IGIygyYeokGi841yryad2t+iMQnAEN5Zt61ADYDiHtY0AW+mh3blix/+4JT1k1borQdKmQHnA==
X-Received: by 2002:a17:907:970b:b0:ac6:e327:8de7 with SMTP id a640c23a62f3a-acec87586acmr235164866b.42.1745938394505;
        Tue, 29 Apr 2025 07:53:14 -0700 (PDT)
Received: from christian--20230123--2G7D3.lan ([2001:861:3f04:7ca0:9d50:3329:cd00:6e2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed6aed0sm791432666b.135.2025.04.29.07.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 07:53:13 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/3] promisor-remote: refactor to get rid of 'struct strvec'
Date: Tue, 29 Apr 2025 16:52:41 +0200
Message-ID: <20250429145243.992252-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.157.g09af0369a6
In-Reply-To: <20250429145243.992252-1-christian.couder@gmail.com>
References: <20250414160343.2216312-1-christian.couder@gmail.com>
 <20250429145243.992252-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit, we will use the new 'promisor-remote' protocol
capability introduced by d460267613 (Add 'promisor-remote' capability
to protocol v2, 2025-02-18) to pass and process more information
about promisor remotes than just their name and url.

For that purpose, we will need to store information about other
fields, especially information that might or might not be available
for different promisor remotes. Unfortunately using 'struct strvec',
as we currently do, to store information about the promisor remotes
with one 'struct strvec' for each field like "name" or "url" does not
scale easily in that case.

Let's refactor this and introduce a new 'struct promisor_info' linked
list that contains a 'struct string_list fields'. This string_list
stores the field names, like "name" and "url", in the 'string' member
of its items, and the field values in the 'util' member of its items.

Except for "name", each "<field_name>/<field_value>" pair should
correspond to a "remote.<name>.<field_name>" config variable set to
<field_value> where "<name>" is a promisor remote name.

Previously in Git, the part after the last dot in a configuration
variable key, for example "c" for "a.b.c", was called the "variable
name part" of a configuration key. It would be very confusing to use
"variable name part" or some similar terms in the context of the
'promisor-remote' protocol though, so let's forget about it, and just
use "field", "field name" and "field value" instead.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 142 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 105 insertions(+), 37 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 5801ebfd9b..24d0e70132 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -314,10 +314,51 @@ static int allow_unsanitized(char ch)
 	return ch > 32 && ch < 127;
 }
 
-static void promisor_info_vecs(struct repository *repo,
-			       struct strvec *names,
-			       struct strvec *urls)
+/*
+ * Linked list for promisor remotes involved in the "promisor-remote"
+ * protocol capability.
+ *
+ * 'fields' contains a defined set of field name/value pairs for
+ * each promisor remote. Field names are stored in the 'string'
+ * member, and values in the 'util' member.
+ *
+ * Currently supported field names:
+ * - "name": The name of the promisor remote.
+ * - "url": The URL of the promisor remote.
+ *
+ * Except for "name", each "<field_name>/<field_value>" pair should
+ * correspond to a "remote.<name>.<field_name>" config variable set to
+ * <field_value> where "<name>" is a promisor remote name.
+ *
+ * 'fields' should not be sorted, as we will rely on the order we put
+ * things into it. So, for example, 'string_list_append()' should be
+ * used instead of 'string_list_insert()'.
+ */
+struct promisor_info {
+	struct promisor_info *next;
+	struct string_list fields;
+};
+
+static void promisor_info_list_free(struct promisor_info *p)
+{
+	struct promisor_info *next;
+
+	for (; p; p = next) {
+		next = p->next;
+		string_list_clear(&p->fields, 0);
+		free(p);
+	}
+}
+
+/*
+ * Prepare a 'struct promisor_info' linked list of promisor
+ * remotes. For each promisor remote, some of its fields, starting
+ * with "name" and "url", are put in the 'fields' string_list.
+ */
+static struct promisor_info *promisor_info_list(struct repository *repo)
 {
+	struct promisor_info *infos = NULL;
+	struct promisor_info **last_info = &infos;
 	struct promisor_remote *r;
 
 	promisor_remote_init(repo);
@@ -328,57 +369,78 @@ static void promisor_info_vecs(struct repository *repo,
 
 		/* Only add remotes with a non empty URL */
 		if (!git_config_get_string_tmp(url_key, &url) && *url) {
-			strvec_push(names, r->name);
-			strvec_push(urls, url);
+			struct promisor_info *new_info = xcalloc(1, sizeof(*new_info));
+
+			string_list_init_dup(&new_info->fields);
+			new_info->fields.cmp = strcasecmp;
+
+			string_list_append(&new_info->fields, "name")->util = (char *)r->name;
+			string_list_append(&new_info->fields, "url")->util = (char *)url;
+
+			*last_info = new_info;
+			last_info = &new_info->next;
 		}
 
 		free(url_key);
 	}
+
+	return infos;
 }
 
 char *promisor_remote_info(struct repository *repo)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int advertise_promisors = 0;
-	struct strvec names = STRVEC_INIT;
-	struct strvec urls = STRVEC_INIT;
+	struct promisor_info *info_list;
+	struct promisor_info *r;
 
 	git_config_get_bool("promisor.advertise", &advertise_promisors);
 
 	if (!advertise_promisors)
 		return NULL;
 
-	promisor_info_vecs(repo, &names, &urls);
+	info_list = promisor_info_list(repo);
 
-	if (!names.nr)
+	if (!info_list)
 		return NULL;
 
-	for (size_t i = 0; i < names.nr; i++) {
-		if (i)
+	for (r = info_list; r; r = r->next) {
+		struct string_list_item *item;
+		int first = 1;
+
+		if (r != info_list)
 			strbuf_addch(&sb, ';');
-		strbuf_addstr(&sb, "name=");
-		strbuf_addstr_urlencode(&sb, names.v[i], allow_unsanitized);
-		strbuf_addstr(&sb, ",url=");
-		strbuf_addstr_urlencode(&sb, urls.v[i], allow_unsanitized);
+
+		for_each_string_list_item(item, &r->fields) {
+			if (first)
+				first = 0;
+			else
+				strbuf_addch(&sb, ',');
+			strbuf_addf(&sb, "%s=", item->string);
+			strbuf_addstr_urlencode(&sb, (char *)item->util, allow_unsanitized);
+		}
 	}
 
-	strvec_clear(&names);
-	strvec_clear(&urls);
+	promisor_info_list_free(info_list);
 
 	return strbuf_detach(&sb, NULL);
 }
 
 /*
- * Find first index of 'nicks' where there is 'nick'. 'nick' is
- * compared case sensitively to the strings in 'nicks'. If not found
- * 'nicks->nr' is returned.
+ * Find first element of 'p' where the 'name' field is 'nick'. 'nick'
+ * is compared case sensitively to the strings in 'p'. If not found
+ * NULL is returned.
  */
-static size_t remote_nick_find(struct strvec *nicks, const char *nick)
+static struct promisor_info *remote_nick_find(struct promisor_info *p, const char *nick)
 {
-	for (size_t i = 0; i < nicks->nr; i++)
-		if (!strcmp(nicks->v[i], nick))
-			return i;
-	return nicks->nr;
+	for (; p; p = p->next) {
+		if (strcmp(p->fields.items[0].string, "name"))
+			BUG("First field of promisor info should be 'name', but was '%s'.",
+			    p->fields.items[0].string);
+		if (!strcmp(p->fields.items[0].util, nick))
+			return p;
+	}
+	return NULL;
 }
 
 enum accept_promisor {
@@ -390,16 +452,17 @@ enum accept_promisor {
 
 static int should_accept_remote(enum accept_promisor accept,
 				const char *remote_name, const char *remote_url,
-				struct strvec *names, struct strvec *urls)
+				struct promisor_info *info_list)
 {
-	size_t i;
+	struct promisor_info *p;
+	const char *local_url;
 
 	if (accept == ACCEPT_ALL)
 		return 1;
 
-	i = remote_nick_find(names, remote_name);
+	p = remote_nick_find(info_list, remote_name);
 
-	if (i >= names->nr)
+	if (!p)
 		/* We don't know about that remote */
 		return 0;
 
@@ -414,11 +477,18 @@ static int should_accept_remote(enum accept_promisor accept,
 		return 0;
 	}
 
-	if (!strcmp(urls->v[i], remote_url))
+	if (strcmp(p->fields.items[1].string, "url"))
+		BUG("Bad info_list for remote '%s'.\n"
+		    "Second field of promisor info should be 'url', but was '%s'.",
+		    remote_name, p->fields.items[1].string);
+
+	local_url = p->fields.items[1].util;
+
+	if (!strcmp(local_url, remote_url))
 		return 1;
 
 	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
-		remote_name, urls->v[i], remote_url);
+		remote_name, local_url, remote_url);
 
 	return 0;
 }
@@ -430,8 +500,7 @@ static void filter_promisor_remote(struct repository *repo,
 	struct strbuf **remotes;
 	const char *accept_str;
 	enum accept_promisor accept = ACCEPT_NONE;
-	struct strvec names = STRVEC_INIT;
-	struct strvec urls = STRVEC_INIT;
+	struct promisor_info *info_list = NULL;
 
 	if (!git_config_get_string_tmp("promisor.acceptfromserver", &accept_str)) {
 		if (!*accept_str || !strcasecmp("None", accept_str))
@@ -451,7 +520,7 @@ static void filter_promisor_remote(struct repository *repo,
 		return;
 
 	if (accept != ACCEPT_ALL)
-		promisor_info_vecs(repo, &names, &urls);
+		info_list = promisor_info_list(repo);
 
 	/* Parse remote info received */
 
@@ -482,7 +551,7 @@ static void filter_promisor_remote(struct repository *repo,
 		if (remote_url)
 			decoded_url = url_percent_decode(remote_url);
 
-		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, &names, &urls))
+		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, info_list))
 			strvec_push(accepted, decoded_name);
 
 		strbuf_list_free(elems);
@@ -490,8 +559,7 @@ static void filter_promisor_remote(struct repository *repo,
 		free(decoded_url);
 	}
 
-	strvec_clear(&names);
-	strvec_clear(&urls);
+	promisor_info_list_free(info_list);
 	strbuf_list_free(remotes);
 }
 
-- 
2.49.0.157.g09af0369a6

