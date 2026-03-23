Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED04929D266
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253161; cv=none; b=YnAhTZ24uo4q5jjqZ+icO6zidPPie+yoJdyYXBgHIYhKzXX2erEhnTAote+g7G908PuDzuHJEMX8KWwxzPnhXwr5VjXyc007nhbXEkbuZpRbf6CWqMRCkgmAbPvztyvyHW1gfpQo/EUhgcofcUrzypinWaCia9y8qwFAkyAHeFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253161; c=relaxed/simple;
	bh=nGj0wiFkaPfRIMCWobY6AnPcqpUJbm3bm8oKq/GkowI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmKRnXGttnikSQBEHlqGHdBprUgSSZW0LUgILLDPlVFI6dAvrlPcn0MvoX9+TIxpuWmagVYvjocu/29S5QAGYXgeCdrFbt9A5agunV5CaKtwDsTiyi+qbwWFaJ+kSw5D1qb3fujmTyKyQxVczfLosbbJt0/b8x3XZQ/XPuXAUEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0bhK+XY; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0bhK+XY"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b49819938so1459449f8f.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774253158; x=1774857958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnBi2XEXbGaqa17+keX7z5rMdqkzOou27ajJF439+EE=;
        b=Z0bhK+XYflrtFRw3XL0P3fZhbILYtFJuFrjrsSby6zbA39deIq02PJv46JpCQZtF+n
         kaKVyt7oUhimyZU+Jh0uqQllJQymL6x+VW3CrANJZciR786vFfQgKwGc6qVLMXHKf3il
         a6pmMDBdMx1jBrJJQSQnckx/uCCf8uiScTebmAs01m5ESmsvESmP32MxS1CZXmRXOrgb
         7YH4vQacEuOiPENsqBBXkrzHhOPX4o29CON+oRUINk7NHpfvXtgju9uQZ4lJYa865CU0
         dDcteL8p5/UNarxcMB00AFstfKujM7AFwTgz7zxTXi9oG+ec7Ytm1wcXLjbJ63fX4OHe
         oFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253158; x=1774857958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wnBi2XEXbGaqa17+keX7z5rMdqkzOou27ajJF439+EE=;
        b=DhrUZ4Ws41HNk81+QFCvshxl40S6zck0OWxaQOFLnPfFx273+8yXy+ARXq/5P0BG6y
         ljouhq7+/iArZwaVhvHWE9fRmxCGNtuj4oRY8ZSME25c5RTKhXuwlL6oQbn3qH5EIeDl
         VpQuSOluD6Kg45vUsEKEdUHme7aIU3Pt07RT2BKQctu6rBS7c/NFc9taG7tIB66F/iVG
         tdpqaL0SK9IaXAKzyUhsIgi85Qe00EMOXuTdsYS+/2Ac+K3BK1S865jCG01PtFxgPtTH
         YLAHeB2Ppt9tV8kgtkjSrY1T9ppBNPfXuExzWuF3QO7K0dRycrfrGAYJ3Ju/e6YW10hE
         c1cA==
X-Gm-Message-State: AOJu0YxMQbCFscEleCTbs/E55pfDfx2rPAy7Mhy2jTS4Ve2KAvnSeV7I
	P2YNPl01f0vrCqtXCOp2Bb2E7EYZerEp3+OMWON1qWKerrKaSB+Fjys1FZxeLg==
X-Gm-Gg: ATEYQzwkZ7oyis+T8drfpP4b3AXDuT/n5wkuooewo7rShW+QcM1qWbKnSFcc73VlrBM
	qFLeg24CONf4ZaLMsxWDd/G6etMUIjc3J4A/6ITjykDRD9sr/uddA/Xeq9PmJmzD6eKE6oEG4ce
	KgfBXJIkVTLvz9rmCmRs5nuRFbVs8HUYMIqM3RzLYsuqLeDZhWfdO1EaCEstyr4bzulBRomaQsP
	9JL7RR6EGrv0GHbv4XuROI4JfW211CxQdeGStbDlCi6ibqkkzR7gC0UX8y7Wn5FmulF1AUj2SOP
	L2VWtTEpVz12c9mza1Uezoj4LJeXiswTCMAKE6BoQKEsQ5OcUr+Iron3Qc72mVpqnz8ylxvRd0x
	IDJAaRD5Z5JnYgluqxB0tJsM5qkYtw8qxkz6fztHrvu4H054VZOQSekKKSpexKKAg8GQEbJt7QB
	TKPsIKGEW75BXpbUeWUgR29t9JOzAwLv1fZeJA8IA/TiAZgFPn+sVK7RE5t0+aIz6v+71AMFJFH
	fnyU++5EZMQswh0TSbzoMOq3B4z9REfR+KkEhU=
X-Received: by 2002:a05:6000:24c9:b0:43b:5192:ebfe with SMTP id ffacd0b85a97d-43b64277cbemr17282655f8f.35.1774253157902;
        Mon, 23 Mar 2026 01:05:57 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm27834067f8f.20.2026.03.23.01.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:05:57 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 16/16] doc: promisor: improve acceptFromServer entry
Date: Mon, 23 Mar 2026 09:05:19 +0100
Message-ID: <20260323080520.887550-17-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.625.g20f70b52bb
In-Reply-To: <20260323080520.887550-1-christian.couder@gmail.com>
References: <20260323080520.887550-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The entry for the `promisor.acceptFromServer` in
"Documentation/config/promisor.adoc" has a number of issues:

- it's not clear if new remotes and URLs can be created,
- it looks like a big block of text,
- it's not easy to see all the options,
- it's not easy to see which option is the default one,
- for "knownName", it says "advertised by the client" instead of
  "advertised by the server",
- it doesn't refer to the new related `acceptFromServerUrl`
  option.

Let's address all these issues by rewording large parts of it
and using bullet points for the different options.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.adoc | 53 ++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index d8e5f4a6dc..1d64e7f1d4 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -32,24 +32,41 @@ variable is set to "true", and the "name" and "url" fields are always
 advertised regardless of this setting.
 
 promisor.acceptFromServer::
-	If set to "all", a client will accept all the promisor remotes
-	a server might advertise using the "promisor-remote"
-	capability. If set to "knownName" the client will accept
-	promisor remotes which are already configured on the client
-	and have the same name as those advertised by the client. This
-	is not very secure, but could be used in a corporate setup
-	where servers and clients are trusted to not switch name and
-	URLs. If set to "knownUrl", the client will accept promisor
-	remotes which have both the same name and the same URL
-	configured on the client as the name and URL advertised by the
-	server. This is more secure than "all" or "knownName", so it
-	should be used if possible instead of those options. Default
-	is "none", which means no promisor remote advertised by a
-	server will be accepted. By accepting a promisor remote, the
-	client agrees that the server might omit objects that are
-	lazily fetchable from this promisor remote from its responses
-	to "fetch" and "clone" requests from the client. Name and URL
-	comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
+	Controls which promisor remotes advertised by a server (using the
+	"promisor-remote" protocol capability) a client will accept. By
+	accepting a promisor remote, the client agrees that the server
+	might omit objects that are lazily fetchable from this promisor
+	remote from its responses to "fetch" and "clone" requests.
++
+Note that this option does not cause new remotes to be automatically
+created in the client's configuration. It only allows remotes which
+are somehow already configured to be trusted for the current
+operation, or their fields to be updated (if `promisor.storeFields` is
+set and the remote already exists locally). To allow Git to
+automatically create and persist new remotes from server
+advertisements, use `promisor.acceptFromServerUrl`.
++
+The available options are:
++
+* `none` (default): No promisor remote advertised by a server will be
+  accepted.
++
+* `knownUrl`: The client will accept promisor remotes that are already
+  configured on the client and have both the same name and the same URL
+  as advertised by the server. This is more secure than `all` or
+  `knownName`, and should be used if possible instead of those options.
++
+* `knownName`: The client will accept promisor remotes that are already
+  configured on the client and have the same name as those advertised
+  by the server. This is not very secure, but could be used in a corporate
+  setup where servers and clients are trusted to not switch names and URLs.
++
+* `all`: The client will accept all the promisor remotes a server might
+  advertise. This is the least secure option and should only be used in
+  fully trusted environments.
++
+Name and URL comparisons are case-sensitive. See linkgit:gitprotocol-v2[5]
+for protocol details.
 
 promisor.acceptFromServerUrl::
 	A glob pattern to specify which URLs advertised by a server
-- 
2.53.0.625.g20f70b52bb

