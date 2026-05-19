Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2BE33A6EB
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205122; cv=none; b=V7wXdMDWADepYOxDlzUp2VtTvIAAlMHWbJi4xAWzlxIL0UuJq0rfX2gjRcGnEMeGI3EhW4qPRpoQRtVt3ztNzfPkksARQpOERiSydaudWckt1q87dSnkgLmlYSS5hAo0HZuOOdcwBiEeat6qe+FWFQXnQTsT+h1H1wZOhgD3taU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205122; c=relaxed/simple;
	bh=ANYNnWre68OZ0Qbr1+Og+Jb+7Vl4AiDtPYd2eGJ9lLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3srogW6lkEPSG8GXTVwh16/ffswK9ybeJyB+FXO6ogVkkEx6yRbkfqML02JFbdT2nwKhW5+urx24a+rgPxCr7sISirWP7/7maPUpqRVazC9HEfA+7TC1KlZ3J8crIUPlS39ayKbQlBrj8GxtRpWN72s4BGrl4qvNrmSUbq75Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiZsHEEe; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiZsHEEe"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8f9568e074so846611166b.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779205119; x=1779809919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Dq4Y0hEQzJ/chMPcq1+DGn0bZCJU5kLofLoBVAXAP0=;
        b=GiZsHEEeaQt6uuVv4PWVy5t5HF75DZ1rIJadFVdLbb4yJuVppYkWPT8c+D1LXsNg5S
         NVVtkUuOh/ytwktAhqgr+NXoi6hdgXnNBRceE6Rg7j9VWz01AiS4s6bVwSqx2GijBVpi
         BKmOEzVGDiNGFW5AM94fE0o5ZaaEbFqgcqrFTfmQ1E0xu6+yovCNriwfk5a5g0hBu14/
         td5FPSvF370hsZTnofXw2XOnBsBXkUOrkxPQW6i4ZcsKdIZ/o/9QxKRN/u2syjlMYLeu
         afnp+znHPYfVljySIjDlES1IbIQYOuFcZI67A01pUEFmr5/b7nAP/zr5Pt3yjGNzbVrB
         dh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205119; x=1779809919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Dq4Y0hEQzJ/chMPcq1+DGn0bZCJU5kLofLoBVAXAP0=;
        b=JflfdYNlzQmdpoZPH+9CkAFd6FX1CJRYxNFo4eEizrzH3pXpKVLWEiuKgkj6HQFbsS
         8TEO7ySpXwT2t1KWNFfbFslYtxgjHnQpr3KLtRD6S01yRKxL+uBQ56B8eNHnXm/ePaDC
         syp3wP6QFvY4EVfjBe7XvQkETusN6DI280Rs9+HiUI7GhR++LvVVdfJ1Rh62bSK4CEZv
         qGGfA4r0lwEiHDR0uZt/FHxrE9RwU4u5rWkWamFyatiFj3IQr5rVTvxkS9OFOQt68pvg
         S7ZcYzMfMqxzUmnEGJXp8Gg54rZ/M60Rrwjfs3cj7G/dmLj+WMuZUmVepceZIYoDkcwl
         9CLg==
X-Gm-Message-State: AOJu0YzgXbmbCeIRc24n11eQQcwsl+PkUYrbovV1LAlZaE/ILD6fL6J1
	fOsfyW4lu+ITETs462/c0T80G1cPPdMiq5+Ppi5sZCV/0ZX1ATuIe3zIrXO8Bg==
X-Gm-Gg: Acq92OGrWNvFBbabTODzaqRr2OtV354qUoNnsC4P+R6+aZQfH5Lqb7aB8lCa2+oQNlV
	XAHMt/01FPxKDlTuxZ7uTu1PUy7zSVLLWHEbsoY/dUE0BVeLXwGHQv/bC3y/ExKblBNz6OC3bCv
	ck+8jY+3TWzDe0AaSTRCwvydr7xD8TwoV6udqyrcI57xCBq7/TPB2eLOyHnbzfy02oscizhv6OS
	9S6Ojg7JC4jHA2sPwPbQo57xRr3Eso36t0CkqXTw7409zltISreJ+kSZJMaRWzjzZfsCliEtnEV
	/9zyCXsxHrtsUDx9o3CizpCaUn0rABMV4i5hvB1mFujHaWc2e7Uf8iNsqm41DJqlpToGPXYRsGM
	/RYJEPO7rTrSTq+EhnoUAuOa0NXC+f9BxaT8+JoxhcJspXSfWzDukvQOl4DYT0IzbR4s185t3gI
	BrbxgxQcMQ4cXsAAxvVRGzAEbOu78QUS3yRFzNCm9JViVyV7b+M2VTPja5UjKrs41hzZpYuNt/0
	zbhFm+JF7L0Tdb/WvFveJrrS0DkD4uDysrAUsE=
X-Received: by 2002:a17:907:3944:b0:b9d:8697:73b8 with SMTP id a640c23a62f3a-bd5178c7d45mr1087056866b.22.1779205118845;
        Tue, 19 May 2026 08:38:38 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd7bbae7a93sm281403766b.22.2026.05.19.08.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:38:37 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 8/8] doc: promisor: improve acceptFromServer entry
Date: Tue, 19 May 2026 17:38:08 +0200
Message-ID: <20260519153808.494105-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.136.g92075d88d8
In-Reply-To: <20260519153808.494105-1-christian.couder@gmail.com>
References: <20260427124108.3524129-1-christian.couder@gmail.com>
 <20260519153808.494105-1-christian.couder@gmail.com>
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
index 11b5716294..cc728bb0b5 100644
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
 	A glob pattern to specify which server-advertised URLs a
-- 
2.54.0.134.gbbe8e27878.dirty

