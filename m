Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124F31E2858
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 07:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753946666; cv=none; b=ZaCjEqeZynmoGSbyI9L7wQ9l8qp8r6ft99CYL6MasNijz65St5BCFYAwA/yca8BGhZFoGhYfqdHgoV44E3YyHNBoxJYBthaYBp2sZMyK/qosXARpVfljnw4OwmAvyeK7fRUXImrny8ri/elB97JYHhRKG76SWMHRLffEynEN+x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753946666; c=relaxed/simple;
	bh=vZOnQnwbmEPnIW/nIfy6dQsnZ6+V3/eXlodB87fA4DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixRvRscIYGnzoAbgSSst3AL63o3T9Xv1C6HwvTEUe1dR7sJtNlfsidTlzLblD0qF1zx0ho6+Jc6/HTly2ywKK+owl6qEJZGFcTPvSOWoCr47GBRJQuiH8Yf9rvVB6bGjQyjNy5dYOip9eaNnJBMfEOrS29ojGWYhp0WED624x2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tky0hDXC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tky0hDXC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-454f428038eso694495e9.2
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 00:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753946663; x=1754551463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/g/D6HjVaXz72/XSZ8I0e+qnuWsz7+bzZNCkwnHupFY=;
        b=Tky0hDXCjH0vCW2zoxExWWOQxaJcd3QwAOIAl9GFyLkaRQIkouFFtgWAdR0wqpQRmf
         kSUSR5+H5KpzDhdXbfs0sRjWfJKzQP0eGdvPwJ7qHXSY9flm71L3tj/lSPFjki94qJDd
         hAjoOVLZPP1z8AJ/CR3sFLLeajAsbJhgJT8dza6JJ59PJWkoA9nUSeFOHsdJNGfnA0RN
         STENIduCCixpsS2uwuem4Fw8Mx9F4ZHkQnemdUQ9qyUzJi1yqw23LcxMzi/dgMbG7SBl
         xCD7mqSheVsoypjHbneq44pO+CzlZTLMgZuTgYytxAULRFsBDoczfolsI0uKjXqBPsVg
         eVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753946663; x=1754551463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/g/D6HjVaXz72/XSZ8I0e+qnuWsz7+bzZNCkwnHupFY=;
        b=l1G43W19M09LBXmKnl8ORTRXUsHK7ZrjPfTAabZdTpSrqBxOAYLRceZfoQJvC52LIO
         DKksq4iL4wPPeY5GoNYw281k6VywF+qedvNakKB0yBun1bp25oEgpE5NYUJG4dIPRv92
         WgwBfSAuo3KQ9HIkMZyn1ImQEW2f6Pvu3XQrzdH2erplj6x9azSSlXft6kgf1WT+twBb
         LiIZZPCKsDRviVH0tsfrs6bILurbvrr1CahTBw4wGPQsktraoraz8TPpZc9zsgkU9RX5
         xbjF/M3zitYWUgeQpF70oQ1Sy7Vu5HKoX+kQLYIqNPHT98OcYZlKnIbrcLc4Umseo12h
         FZKg==
X-Gm-Message-State: AOJu0YxaZ/NzqAbCWMJ4oQ3W+9NCvoAD0CTC7jzQWFK3+YGMVW+nLXT+
	F7Xx8LrD8mqjxfK6iO6Rw5uXTkoCShCiXhKDwuVuKwf8RMS2W9r3Q6cv+21pYw==
X-Gm-Gg: ASbGncsG+pPRD+8ns+6dTNMmHShl4BJGvq8Xl9jj5fiDrSjdkWWXq8DYG7CyZQUsijP
	nE75FW2oSGq/df05PM1wisqsptvOlArGQlnXaTdxISZYNXkxwn82oEy2gX0MIG6b3ubFZVsnq4L
	RRD3H5yUngbAxAnBrAGf6y0UuhXRXUs/ipDAnS08OgIP7pnfR/BdLxJIkx82gpaVMSK91MJxYHs
	3iHyhh+VEmq5+dSJOejvdh6sbP5xxd5O7ucmXsuuUc9sqUoLfjpfNAddY4wQGvmj/XvLrk5ztg7
	bJMXC8dnti4itbm4HFt+sDLH24DIq8sLJEN7h6UlmTkngpqZ3XUsixBms+1/TrQl3XrcCWf1iem
	NroX9RjHMdQb79iL0t/bIpY2/T/FPAFKdbuMSpb8Oc2XEvrr9lm8+5lSifOJwheW+s7OIj7IDUz
	xgA6gC
X-Google-Smtp-Source: AGHT+IE5I2TZb0RLU+hNxg5w14qyU26eAPy5Zp7qVbHK30efSrYNOxOjfmQaqVvmAgBMgFyj8SaWIw==
X-Received: by 2002:a05:600c:4f14:b0:455:fc16:9ed8 with SMTP id 5b1f17b1804b1-458981d0a3bmr44476255e9.30.1753946662840;
        Thu, 31 Jul 2025 00:24:22 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953f8e02sm52495175e9.32.2025.07.31.00.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 00:24:21 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Jean-Noel Avila <jn.avila@free.fr>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 3/5] promisor-remote: refactor how we parse advertised fields
Date: Thu, 31 Jul 2025 09:23:55 +0200
Message-ID: <20250731072401.3817074-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.1.323.g4e0625aa69.dirty
In-Reply-To: <20250731072401.3817074-1-christian.couder@gmail.com>
References: <20250721141056.2283349-1-christian.couder@gmail.com>
 <20250731072401.3817074-1-christian.couder@gmail.com>
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
 promisor-remote.c | 92 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 63 insertions(+), 29 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 620133c2ec..2ea069ff6b 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -404,16 +404,20 @@ struct promisor_info {
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
@@ -530,11 +534,13 @@ enum accept_promisor {
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
@@ -568,6 +574,47 @@ static int should_accept_remote(enum accept_promisor accept,
 	return 0;
 }
 
+static struct promisor_info *parse_one_advertised_remote(struct strbuf *remote_info)
+{
+	struct promisor_info *info = xcalloc(1, sizeof(*info));
+	struct string_list elem_list = STRING_LIST_INIT_NODUP;
+	struct string_list_item *item;
+
+	string_list_split_in_place(&elem_list, remote_info->buf, ",", -1);
+
+	for_each_string_list_item(item, &elem_list) {
+		char *elem = item->string;
+		char *value;
+		char *p = strchr(elem, '=');
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
+	string_list_clear(&elem_list, 0);
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
@@ -604,32 +651,19 @@ static void filter_promisor_remote(struct repository *repo,
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
2.50.1.323.g4e0625aa69.dirty

