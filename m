Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6109035CBD6
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253144; cv=none; b=Q0+HTyeyLD2gByoxDjIewjWNgdNoNjp5DWkDIgjA62kdPWSo1Rm3WIawNQSzuLjFKDAIb4bsfTcp4cF70+mMGuTgthmuEEc9wUnEl/lS9oah7dC/NQk366ENQ9c9FjjhmbiYW7TOYctGvOXDzJtsubemWOIJHpLkFbWBtgVNJCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253144; c=relaxed/simple;
	bh=RKheJBfsWhzsyLhjG1RAsmk3WRGXPLYl1dK5tDBc64c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfiHzCGW8vcErXwhGwEGXNLGNZFvhHm3YFpnzFBuH2CcN/XaBxhL+oIS0PuSIOjO/SmpvE++atzkwuAjlZnmYaxeXNsZCOJdKH8qK4oiCUoubCcY7VRtzc/+IHlWr8cjVB4qWdW6PDEVSvOV3TV/SqUE1+PUggqytT41vDe0AQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3v+by0N; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3v+by0N"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439bcec8613so1643397f8f.3
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774253141; x=1774857941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PtWX1u0vN7KZ1t0RDgBXhgnT8aVfZzckt96y0l6HCM=;
        b=D3v+by0NE0uYZqOH+8IUNn8W+cB57XRvEsaU5d90RfoQIQ4FrusCrUYnwmB3lEPsZy
         1fG4uYRzm7UDtAiW/GdCGfrhIDM3IGOtCc72pxHb7TXTco1wzkyLK+UfRC1Fo7uOgGkE
         j9+e+Xnnh7RTgJPH0AyH5d3l9/PUfG5lORgljEd7t5ouyIg6D19NWcIN0Dv+luWpgeMr
         Y8MSDXa3YrZYf/mVM+/rsujujrMugWiWMZkWnko4RuNUtxyZoVWpdIZ1OG93zFKf5LQM
         aHB2U9rEQ0p/z4H73tQRUgdfinvO7UDX0lTqIvLKYOIaUpV0du5KNgRxTVfbf71DigYY
         1ZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253141; x=1774857941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3PtWX1u0vN7KZ1t0RDgBXhgnT8aVfZzckt96y0l6HCM=;
        b=DdkKCo57rqZukNOhyzs0H2U6tJT308m5upR8Uo+nvwPNB1pRJjkRh4BwEnR8LuHc3x
         QINZ4esJIAY6aX0mXLsMz/n9dNhz3QXWNFR1/MCHk0f4kMKCA2Emd7Hx7qLbc7uenFk+
         NBR+TpeQGuvLzmZPMgjCjAmIbU+xXEKfCfkYLWz1b8O8bF/jrxjuHzXlgpZBxxAip05k
         Gs7MpTKA7OV0DEaCnMbP2S9YCKkObUzKOqjYsUJsjYq1IXWeFpcdwdayXp9ndP142wmI
         4sCf6Kd9LgbiX6tgB5WaoWm4TW+oVnU2uJjhXwJc6WqpxKW8wGGR6f7NiSKWGmeLAjgj
         tPnQ==
X-Gm-Message-State: AOJu0YzzgREl5+l4d28jqe2Xh4Jl5sr7vrAeOizpP0qbqcksui2twqgP
	Wn2LKX+yH2ROZHyfT1VDJI7tzxTx3QCnqdQdkLOaTY+Hm87yFEq6uqOoF/BNzg==
X-Gm-Gg: ATEYQzyJm7gABF0ZTPpV9DkIQ4hiuSUfy3hfrWMqHGXva+iEMxbUirQwk99LrOkDGz1
	Zix74LqNlmM2JTw/cWAKl9fQg9rQsZEf6EDU/T0N6exRP3amHzXvZxrjubFJmS15XyngOxRksjz
	+qmk1tyGKgQwLux2i6au2j2W/CCZH65wZhYjDxdQti7d34fD8Uqvp7mmhJnTOZGJyB+K81xs+23
	VJWnE/QQslnRyKeI3my76qhBA3hSIzD7P125GLzl2juBC02Xi6dc0yHsX/yxIux2ZO2U26LUHW/
	h46VZoKVgLuM5ZEdYc2kG2muVUfmFymbRrZcW8Q4bBPspGhwdtHdneXQeeJwdhcOrPOGifCBCiv
	Z16PenKP8MRyUUaDI53DUz8021oerMFMC/myNLsgd/PSqlqtmZrQXj+qUiqs4Q6GMZ7oSfFvh/d
	eTUj1P6ojSgzffD49rJsX/iSICDfXE6p0fPgzgTbcqG78OlTUL2uKvMTI1SoLcIujVOkYK4FALh
	ZMNaNlC9H627RQlGzhDr/wPT4bR8BqgW7LGECY=
X-Received: by 2002:a5d:5c84:0:b0:436:3707:2bf0 with SMTP id ffacd0b85a97d-43b6427d662mr16908071f8f.35.1774253141201;
        Mon, 23 Mar 2026 01:05:41 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm27834067f8f.20.2026.03.23.01.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:05:40 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 01/16] promisor-remote: try accepted remotes before others in get_direct()
Date: Mon, 23 Mar 2026 09:05:04 +0100
Message-ID: <20260323080520.887550-2-christian.couder@gmail.com>
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

When a server advertises promisor remotes and the client accepts some
of them, those remotes carry the server's intent: 'fetch missing
objects preferably from here', and the client agrees with that for the
remotes it accepts.

However promisor_remote_get_direct() actually iterates over all
promisor remotes in list order, which is the order they appear in the
config files (except perhaps for the one appearing in the
`extensions.partialClone` config variable which is tried last).

This means an existing, but not accepted, promisor remote, could be
tried before the accepted ones, which does not reflect the intent of
the agreement between client and server.

If the client doesn't care about what the server suggests, it should
accept nothing and rely on its remotes as they are already configured.

To better reflect the agreement between client and server, let's make
promisor_remote_get_direct() try the accepted promisor remotes before
the non-accepted ones.

Concretely, let's extract a try_promisor_remotes() helper and call it
twice from promisor_remote_get_direct():

- first with an `accepted_only=true` argument to try only the accepted
  remotes,
- then with `accepted_only=false` to fall back to any remaining remote.

Ensuring that accepted remotes are preferred will be even more
important if in the future a mechanism is developed to allow the
client to auto-configure remotes that the server advertises. This will
in particular avoid fetching from the server (which is already
configured as a promisor remote) before trying the auto-configured
remotes, as these new remotes would likely appear at the end of the
config file, and as the server might not appear in the
`extensions.partialClone` config variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 46 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 96fa215b06..3f8aeee787 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -268,11 +268,37 @@ static int remove_fetched_oids(struct repository *repo,
 	return remaining_nr;
 }
 
+static int try_promisor_remotes(struct repository *repo,
+				struct object_id **remaining_oids,
+				int *remaining_nr, int *to_free,
+				bool accepted_only)
+{
+	struct promisor_remote *r = repo->promisor_remote_config->promisors;
+
+	for (; r; r = r->next) {
+		if (accepted_only && !r->accepted)
+			continue;
+		if (!accepted_only && r->accepted)
+			continue;
+		if (fetch_objects(repo, r->name, *remaining_oids, *remaining_nr) < 0) {
+			if (*remaining_nr == 1)
+				continue;
+			*remaining_nr = remove_fetched_oids(repo, remaining_oids,
+							    *remaining_nr, *to_free);
+			if (*remaining_nr) {
+				*to_free = 1;
+				continue;
+			}
+		}
+		return 1; /* all fetched */
+	}
+	return 0;
+}
+
 void promisor_remote_get_direct(struct repository *repo,
 				const struct object_id *oids,
 				int oid_nr)
 {
-	struct promisor_remote *r;
 	struct object_id *remaining_oids = (struct object_id *)oids;
 	int remaining_nr = oid_nr;
 	int to_free = 0;
@@ -283,19 +309,13 @@ void promisor_remote_get_direct(struct repository *repo,
 
 	promisor_remote_init(repo);
 
-	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
-		if (fetch_objects(repo, r->name, remaining_oids, remaining_nr) < 0) {
-			if (remaining_nr == 1)
-				continue;
-			remaining_nr = remove_fetched_oids(repo, &remaining_oids,
-							 remaining_nr, to_free);
-			if (remaining_nr) {
-				to_free = 1;
-				continue;
-			}
-		}
+	/* Try accepted remotes first (those the server told us to use) */
+	if (try_promisor_remotes(repo, &remaining_oids, &remaining_nr,
+				 &to_free, true))
+		goto all_fetched;
+	if (try_promisor_remotes(repo, &remaining_oids, &remaining_nr,
+				 &to_free, false))
 		goto all_fetched;
-	}
 
 	for (i = 0; i < remaining_nr; i++) {
 		if (is_promisor_object(repo, &remaining_oids[i]))
-- 
2.53.0.625.g20f70b52bb

