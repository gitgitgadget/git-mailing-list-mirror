Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CDC2DA779
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107080; cv=none; b=eqqryvQC5CDaM8w54s5bgQfCGXBizS/Otov2/gJSSfvIcUIz8LIFWuks5mi/+ulSEKfOLKF+dtXtbfHQDuHslNghuV0vb/NgTlyrGw8uPqFMBJ14wFfHwKbxng287hFvMGQ2jMj8wuyciNFeg4HTNM0NuCdYs/UDWMV+AhwyIN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107080; c=relaxed/simple;
	bh=eCPB2T3QNzxdQXeJAZmiKxPG8f703CqKHp27TOK2jIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKwRckbaVN/8i2zJ7gO6ZwBbntOBWA8Ap/wprRuKGhPawYoCmPEFdtHUyEgGNeT5d11A8/dx5vm8Qbb+YHmRNdOLOqdAFp44QxtrUcSEx+MnhL6QTU2hfp0NTaXwT4zlq/QbER2Rhm95MxsdNrZD7jiY4vt6Fxnxx3ML+K7FWXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egHoslxx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egHoslxx"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-456108bf94bso30800875e9.0
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 07:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753107076; x=1753711876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4IycGnt+8SJgZdknNw5WQIeWHMIYrP5rf48oAawfXU=;
        b=egHoslxxXfPIqlsWg8tn2IsVGv+LLbBhu405chw1fvqAMAPgySwuFxdYd+hl3TRrPF
         sQgFRQFXXHsEkzDjF93LeqgsVGXrhxKlOVPM06gLo4serr1/YOJz5hR/ESdIciuFERKh
         LEa2VsR2ObWx55mSha3vFI2t8MMtJUuIo84DVdb84AZ5hfA/QSCRoHb8g5EM7udPhj5/
         7ka74IU3ISkya/fR6JCao6JwIjxx5KmgDhoxoOt0Rb9rUFT9KHsJvcRQ0V/dCAdCB4Hr
         fSMII5+e0NPPaAJMstnlAZRm7Z/ObH5wKv1E1GGfXV3t07wrHhR2F/GjhA34ArjD8s77
         M/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753107076; x=1753711876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4IycGnt+8SJgZdknNw5WQIeWHMIYrP5rf48oAawfXU=;
        b=ZEeCiftbIYW39e8/JX4/65kUjl6PDi7BMnUbsNKMyTDfuZMLPocrFx6B7EJodpYIwB
         OUdCdprEER4z4v2yaydgNb1T0VNcOOvkAA3+n0dlxhtCLfgQoEIgQhaD4ABb6votB9ZH
         qpHVrCYOacVphfjPNUJMZxhEbRRYxTA59dSiM/dOG3JjEXYpGLrONglbTOOd0LWyy/pl
         wrHwy4v1eytkplE5r5b4R8Q1aCiVJ3qrqSB+5sNa+8pKmpqUGQ4UJSJMLIVtn9R6Qa6p
         gZ0rcK1S6gkkOsYwiMYGJK4KLPV4OjbvpE8UteNOZQUdOmrZ7OaOFmrMFkghYzr+6+kb
         tNqQ==
X-Gm-Message-State: AOJu0Yw83lU16oufp2Rrc5bOgYhB0DLvEUlAEWUHZTkQFtNr+fo7WKpF
	K8q5myszOn6Hnha6SIYus61NnUYgrQRpIdBOBx3I/QcGVeUT6g0TESlGlimzQA==
X-Gm-Gg: ASbGncv0iWaOmWzYdaTRwQdVXtM0j5XdVJNYMBOvOMVuuV1x6QIUxHtQgo/GGkNmGRf
	t8NAD4nnvxNxaiWuEqrQ0XAU64GN8pPBFU68P/9ajo7NHSI4FzD3C2aX8e0Ztfcws06+9wqbFJP
	MhCVgsaepQh46BwEKGYjrnnya1GU1SFS8yf96b+u3z7oDGiQa4dWsD2jeaj9gkvQnf2lpcHqE6F
	AwkssCO5shymNrVIb4idnu6bONZ6BscSyNXyohVqw798bBz4rZMm1ptoylu6FX7XeJvox7gpFvi
	i/atb3FTY/uIzxPaNJK1EpQ9pWeWMO6Ywcrj9QG81XFyDDrQUKzU7LYmul3nCrb26y/yEEJOoMK
	6D4jFiuFeUVkcpPgMIgwdGpRUKj1Mw5RfNMpKnKHjgeilVi90zhZUE4sGPKUgWBiDgUHPth/8bU
	9q/2DU
X-Google-Smtp-Source: AGHT+IFFTjUrT4z+k3AMdplftqD65AsfzKhbYv24mPNbiex8DuOIJBeKqyGeXW+X2qISZmCPOOfz7Q==
X-Received: by 2002:a05:600c:1ca2:b0:455:f6cd:8703 with SMTP id 5b1f17b1804b1-4562e39b29bmr225579815e9.31.1753107075519;
        Mon, 21 Jul 2025 07:11:15 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2e68sm160885585e9.1.2025.07.21.07.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 07:11:13 -0700 (PDT)
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
Subject: [PATCH v6 3/5] promisor-remote: refactor how we parse advertised fields
Date: Mon, 21 Jul 2025 16:10:21 +0200
Message-ID: <20250721141056.2283349-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.1.324.gc7d7c83534
In-Reply-To: <20250721141056.2283349-1-christian.couder@gmail.com>
References: <20250625125055.1375596-1-christian.couder@gmail.com>
 <20250721141056.2283349-1-christian.couder@gmail.com>
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
index 3420ccae63..ae2c49a0a0 100644
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
@@ -568,6 +574,46 @@ static int should_accept_remote(enum accept_promisor accept,
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
@@ -604,32 +650,19 @@ static void filter_promisor_remote(struct repository *repo,
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
2.50.1.324.gc7d7c83534

