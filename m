Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E04283C90
	for <git@vger.kernel.org>; Mon, 19 May 2025 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664007; cv=none; b=ODr487p9fdFBUfyYSThYTlM5Zsx4GlWL1QElD9OCMPKqAXCGrlqB3RyBLLXyftLIPQOjqpXDOMP3ZjuQItT3Ft9HNS0vkFrekA6u6BXNyNFrR6IWyTa9owkLgd713FR3T2nJGkbMh3b4EJOjhtOShQHCmkrZlwb1NE/t2C2NBzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664007; c=relaxed/simple;
	bh=jmTd7EntruV1+1CrGnXeeTamrkXQMXoSNK9TEIcyR1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chb/bVWMmxNNksJF22Sy5ONTmVNYkeOiRZMAbpuJs2tCYr9v4Mp7yLa1ear1oY9yaqaMiM1+jbJbNDoRc0pXhuDorg+djyTDiYyUH4WVifOGfGDjX5gueEgfk9DFl2toUg/w03biAN0Ue7Qbwr9Kzqw5nfKw/9DbPMhhFWu+MZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRygoP1V; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRygoP1V"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a376da332aso290073f8f.3
        for <git@vger.kernel.org>; Mon, 19 May 2025 07:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747664002; x=1748268802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHn6exsSrV6Yuo8+4jSG7amgBVOkQ7NtE7N5Yy9FPPU=;
        b=jRygoP1VbXnUF7jcQZjX4W5AwU8ps7K4IwsLoYnv96/24tX7sgkNe5q8SxZ7jM81g0
         V7GM4GSbTo/kx77eys+ZPhNvXIaBevUQthQ+B/C6iL99F4EfhF5d1wTjllfnW9EAIKkv
         rTBluGtNiDvwqWVt3TqKZDwpHEY0mW4AOEctp8mo6cKraH6ioWvkzx2baFBWF70wTlcG
         nHI4WoJws+X9fBhY1A/UHIszoVrdUbYmTlUAbXCEzRtbu0QSRL/LnvyeCaSub/jnIqtI
         +7eR6qYCelZUTG2Ebzh2LJW72p3HZ4tv5QXgGAzRZvlACKVm7g9wJa6ZjbDroQ1EiCPs
         WpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747664002; x=1748268802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHn6exsSrV6Yuo8+4jSG7amgBVOkQ7NtE7N5Yy9FPPU=;
        b=mIxg12DSjaNPdYznIeHuGf3GSudWNsCQznCsbFKiNYoZ4fDqgiMpXD/Vex56/19DW5
         UZsCWu7sVhNbwJINn7GUtgwHrgNSDAHIhRVsnjOzcyazUVRdvdhm0PT1QnCUVYSAaqSv
         2rmmVSlRiw6dLequPAuDeXieP2wffd9yAoIrzKKggiudShdrej4FfOiMC0F6Y/tUc7zH
         4O4xprOdioW+npbCxvN5S5KUJWD8biISgXJ0ndM3gu0e7CpMQIFw8L9SbA22fNFqVCLq
         xHozl5YJWsiFp00tolD3x4gKWZThtVL8EtUR4eMfis9KBiVdBlvPtjz5ycTALALdxFHo
         pNcw==
X-Gm-Message-State: AOJu0Yyg72iW0Tns0SGMzdTRQQddZQ73WmWy9DnCYlqMsbO/iqNxGgkO
	X5o89Eklsg14ITfdUVOEXm0O/wU0l0GFrbH2+E81aBDyv7kuF98s+dV4Jqi6UuKq
X-Gm-Gg: ASbGncvaGyT9t0an7XNH/Uoq9Z3Xhu8jXrkquoQOfNrPo1R9zpin5cjj7PrmxMeenCY
	RXcuja2et90NAHKV5LhWjUT/IcslDMoSaPPZC1+LmpQZnQ2GC0zlcGAkzX3JgQLimvGYSbNhcBk
	/1nwRyCCxnRXhKjDYvGEW0ZSY+Rg/dnSdLwqQB41JN82GE8Pk+cjuvXQpMSLldhHObGqZk6Xmou
	pceNTbLcHdgmJn1o1m0Jpw+X8bUXaO9tmI/fXOpYNXPzTM2yOmWfSGqmm4vYPk5gdDUQi4oSInP
	nFTFu71mgPkbxPp+Xz3tQ/L40iPF1wjjL7WzPbHvgtCGCZhmCYwtNuuGMbHYFaa9U2s3mQUTTY3
	S1LvQu6NFH9LQRbdIjZDi4M1/660KwN1iHdRu
X-Google-Smtp-Source: AGHT+IEWQX69YiJyvybsemzVmatBM3fDwa3q6oMSk3hsI1rVtXf/vIbnOxZn2TqG15EpmGhP9oIGxg==
X-Received: by 2002:a05:6000:40e0:b0:39e:e75b:5cc with SMTP id ffacd0b85a97d-3a35fe67678mr9959026f8f.16.1747664002140;
        Mon, 19 May 2025 07:13:22 -0700 (PDT)
Received: from christian--20230123--2G7D3.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fa3e2ce5sm160372405e9.13.2025.05.19.07.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:13:20 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/5] promisor-remote: refactor how we parse advertised fields
Date: Mon, 19 May 2025 16:12:57 +0200
Message-ID: <20250519141259.3061550-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.596.g707f6eb7a2.dirty
In-Reply-To: <20250519141259.3061550-1-christian.couder@gmail.com>
References: <20250429145243.992252-1-christian.couder@gmail.com>
 <20250519141259.3061550-1-christian.couder@gmail.com>
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
 promisor-remote.c | 71 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index cde4079d8c..13bfa817c3 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -538,10 +538,12 @@ enum accept_promisor {
 };
 
 static int should_accept_remote(enum accept_promisor accept,
-				const char *remote_name, const char *remote_url,
+				struct promisor_info *advertised,
 				struct promisor_info *config_info)
 {
 	struct promisor_info *p;
+	const char *remote_name = advertised->name;
+	const char *remote_url = advertised->url;
 
 	if (accept == ACCEPT_ALL)
 		return 1;
@@ -576,6 +578,46 @@ static int should_accept_remote(enum accept_promisor accept,
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
+		promisor_info_list_free(info);
+		return NULL;
+	}
+
+	return info;
+}
+
 static void filter_promisor_remote(struct repository *repo,
 				   struct strvec *accepted,
 				   const char *info)
@@ -610,32 +652,19 @@ static void filter_promisor_remote(struct repository *repo,
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
 
-		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, config_info))
-			strvec_push(accepted, decoded_name);
+		if (should_accept_remote(accept, advertised, config_info))
+			strvec_push(accepted, advertised->name);
 
-		strbuf_list_free(elems);
-		free(decoded_name);
-		free(decoded_url);
+		promisor_info_list_free(advertised);
 	}
 
 	promisor_info_list_free(config_info);
-- 
2.49.0.596.g707f6eb7a2.dirty

