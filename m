Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC8A28B7ED
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649531; cv=none; b=rq1Hywo5+EAg1l/dH7qGutF7VOyBoQ0pmKW3YjG3zDj/TomF8oFD0n9eiDJiROP5bie2HMhUXXgFh7Wzo0ZIKR5l7fjWV/b+2e3pVBt27sB9Di5WcbDCTemYmrWcM7fTwjzNjuQHpo/t5ifzk1FEE5EoKx7BgyEIMKjj5wTlb4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649531; c=relaxed/simple;
	bh=PGb67q1AvQZu0+6IyjRnQWzHEJlS9rULCf1FQvyRmj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QY+i5vLGuaIjjNgem6PoZDxW4vM8r6+97bhr/dFOMeKutZlxKVjtas7qt3DqesV8EZ8/1u41cRrRuYO5YGSgLP8sGDJWIWxHql6a1Gyw+YpqR3heRdIOSlF1vg5GZmh4EjD7qvkpBieAU7gqzZ837SBmB8gfe2wLuQmousurLiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3Mtw9HY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3Mtw9HY"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so83415945e9.1
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 06:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749649527; x=1750254327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KXmwVJa6kbG7sGdsGP3cgp0yo2nrjLFuRKfzldk0+E=;
        b=a3Mtw9HYe2viTpgM36Xce+2PQhWEEBDvO/CUOCfuB6JcA6RFRsfC8mf8WZfq1haPxO
         M2sihGGDWZhPg/XNQw2c5zkqXeGL9F+MdZmDSlv2LpWlTgN/R/ZVS/nuXMFBUdK0xlKv
         HjQr2y5ENLZZCpVmNH0MqnRKdTxnAXFemMgf4+i5P+cjjasxVYG+PVMO7JFoceHaC0QQ
         XYk5Qxs0UQejYHgZnFjFFUygg0wC7ER9M8Blr9bxw2qy7f55i1EUNnDXyZo1qba051hp
         gXsB/BRsjzZX57wWZsOVHozFLg231QxUfYCKphggmLza4VkS104r5XfhUOVhXS0wPk/G
         oK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749649527; x=1750254327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KXmwVJa6kbG7sGdsGP3cgp0yo2nrjLFuRKfzldk0+E=;
        b=wowslXnZTgQFNS9EooPYwBEfBmCrEGfLqz6vGQwYvZqwXgIpB/1oB9ESDFV5SZfYP9
         wqT3ZlrOpQJjtX7mxu/LWbKSZeopLveF1KdbKbuKL8FqX/aehqEaUsfORHbCt7W+cyfT
         R6uTRuqj8vZ5Vo13G/iEZ8kBX9CrdP/WMsVqkcJMX0mOUJO9uS6TllVLw15Hs+AS0YR6
         otEj7x5VR5iD7VMF8Q6d+Is9F/HGwFcNx04OdJfbMDYnmev1i2T96GhoPhpii7d5hJ0E
         X3WwhAFqG7EBaofZ1A9GeDji0o8I2bkh5t5H19+XeBWGR6gQHX46pmpKlWup9FvwyUI1
         tqsg==
X-Gm-Message-State: AOJu0YxmoIGfbb5E5x9++Koa4tDi31SKH8qcsCzP/vJLyf+nnodgRQii
	6S9uxHRCHvHgx83wqvW25p9jI+t9Yh3GATluWluGSsS/wHFgr4wAcjgziJ9QHw==
X-Gm-Gg: ASbGncurnr1SWyIqDp9A26oszcWbT8tBlsA6QgA8JnrqS73bHTr9zbx97uuVMYQTsQ6
	JlBIRnPge4wa+jpKnd6UcXj+krAjBW6rb1iBLz2IMiOiIgbL6T/iDMPEN35wOu+XkqMl4yHh9oo
	GaeLIuzLlJShbo++LqMIei/TtQddwy01+uTE1MQRNoQuvFqP9r2HDdV+J5vSKWctEp936UAP8xX
	1g4KJDOT5mh1AGjW8sGcQXd5pqX8ISxLepzyuLj9mquzCUNI/e9PoScNL2TvTgQN7rnCna+uePW
	FJ3YFk1jLiEWOrQCxgXmT6/bF5yQIYHWj2NWEd6zEWHCxvCoLnGvdbGgiBkYFo1mm6WvhLYSVGe
	PgMesy6rYRDVfcIqBn3pTY5EG3fL99/5bkcw+vmKkX7QY
X-Google-Smtp-Source: AGHT+IFeSyE+cJ/UD6sCwkujKBrmnofQn+vqlEYMdMMvyX7NRlrYfcNPp7M7qQWsWpI0jJnwFzf6nQ==
X-Received: by 2002:a05:600c:64c3:b0:43c:e7a7:aea0 with SMTP id 5b1f17b1804b1-453248cc0a2mr29604475e9.26.1749649526381;
        Wed, 11 Jun 2025 06:45:26 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453252450d4sm21513205e9.9.2025.06.11.06.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 06:45:25 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 3/5] promisor-remote: refactor how we parse advertised fields
Date: Wed, 11 Jun 2025 15:45:04 +0200
Message-ID: <20250611134506.2975856-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.0.rc2.5.ge8efe62b7f
In-Reply-To: <20250611134506.2975856-1-christian.couder@gmail.com>
References: <20250519141259.3061550-1-christian.couder@gmail.com>
 <20250611134506.2975856-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a follow up commit we are going to parse more fields, like a filter
and a token, coming from the server when it advertises promisor remotes
using the "promisor-remote" capability.

To prepare for this, let's refactor the code that parses the advertised
fields coming from the server into a new parse_one_advertised_remote()
function that will populate a `struct promisor_info` with the content
of the fields it parsed.

While at it, let's also pass this `struct promisor_info` to the
should_accept_remote() function, instead of passing it the parsed name
and url.

These changes will make it simpler to both parse more fields and access
the content of these parsed fields in follow up commits.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 91 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 29 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index ec7f4dd2de..e291a00a73 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -398,16 +398,20 @@ struct promisor_info {
 	const char *token;
 };
 
+static void promisor_info_free(struct promisor_info *p)
+{
+	free((char *)p->name);
+	free((char *)p->url);
+	free((char *)p->filter);
+	free((char *)p->token);
+	free(p);
+}
+
 static void promisor_info_list_clear(struct string_list *list)
 {
-	for (size_t i = 0; i < list->nr; i++) {
-		struct promisor_info *p = list->items[i].util;
-		free((char *)p->name);
-		free((char *)p->url);
-		free((char *)p->filter);
-		free((char *)p->token);
-	}
-	string_list_clear(list, 1);
+	for (size_t i = 0; i < list->nr; i++)
+		promisor_info_free(list->items[i].util);
+	string_list_clear(list, 0);
 }
 
 static void set_one_field(struct promisor_info *p,
@@ -524,11 +528,13 @@ enum accept_promisor {
 };
 
 static int should_accept_remote(enum accept_promisor accept,
-				const char *remote_name, const char *remote_url,
+				struct promisor_info *advertised,
 				struct string_list *config_info)
 {
 	struct promisor_info *p;
 	struct string_list_item *item;
+	const char *remote_name = advertised->name;
+	const char *remote_url = advertised->url;
 
 	if (accept == ACCEPT_ALL)
 		return 1;
@@ -566,6 +572,46 @@ static int should_accept_remote(enum accept_promisor accept,
 	return 0;
 }
 
+static struct promisor_info *parse_one_advertised_remote(struct strbuf *remote_info)
+{
+	struct promisor_info *info = xcalloc(1, sizeof(*info));
+	struct strbuf **elems = strbuf_split(remote_info, ',');
+
+	for (size_t i = 0; elems[i]; i++) {
+		char *elem = elems[i]->buf;
+		char *value;
+		char *p = strchr(elem, '=');
+
+		strbuf_strip_suffix(elems[i], ",");
+
+		if (!p) {
+			warning(_("invalid element '%s' from remote info"), elem);
+			continue;
+		}
+
+		*p = '\0';
+		value = url_percent_decode(p + 1);
+
+		if (!strcmp(elem, "name"))
+			info->name = value;
+		else if (!strcmp(elem, "url"))
+			info->url = value;
+		else
+			free(value);
+	}
+
+	strbuf_list_free(elems);
+
+	if (!info->name || !info->url) {
+		warning(_("server advertised a promisor remote without a name or URL: %s"),
+			remote_info->buf);
+		promisor_info_free(info);
+		return NULL;
+	}
+
+	return info;
+}
+
 static void filter_promisor_remote(struct repository *repo,
 				   struct strvec *accepted,
 				   const char *info)
@@ -602,32 +648,19 @@ static void filter_promisor_remote(struct repository *repo,
 	remotes = strbuf_split_str(info, ';', 0);
 
 	for (size_t i = 0; remotes[i]; i++) {
-		struct strbuf **elems;
-		const char *remote_name = NULL;
-		const char *remote_url = NULL;
-		char *decoded_name = NULL;
-		char *decoded_url = NULL;
+		struct promisor_info *advertised;
 
 		strbuf_strip_suffix(remotes[i], ";");
-		elems = strbuf_split(remotes[i], ',');
 
-		for (size_t j = 0; elems[j]; j++) {
-			strbuf_strip_suffix(elems[j], ",");
-			if (!skip_prefix(elems[j]->buf, "name=", &remote_name))
-				skip_prefix(elems[j]->buf, "url=", &remote_url);
-		}
+		advertised = parse_one_advertised_remote(remotes[i]);
 
-		if (remote_name)
-			decoded_name = url_percent_decode(remote_name);
-		if (remote_url)
-			decoded_url = url_percent_decode(remote_url);
+		if (!advertised)
+			continue;
 
-		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, &config_info))
-			strvec_push(accepted, decoded_name);
+		if (should_accept_remote(accept, advertised, &config_info))
+			strvec_push(accepted, advertised->name);
 
-		strbuf_list_free(elems);
-		free(decoded_name);
-		free(decoded_url);
+		promisor_info_free(advertised);
 	}
 
 	promisor_info_list_clear(&config_info);
-- 
2.50.0.rc2.5.ge8efe62b7f

