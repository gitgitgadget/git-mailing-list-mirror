Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E968A306D52
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567251; cv=none; b=aVQQz1/JJIRr/iHClk1QGI6iQglhAxTqmYxXV1RCo2EJJMZbFiwwnp7ZO4QqeRN9NBJ2YvA9atg0/79oMNZeOblz1i4EXZxXsTKOxpV2++wp0V2MhYFvZgyDtXjIv4lDJ4cpjiUKKJgsg+zDjgF0Eii6WFUzLxoSRoOCYxYWSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567251; c=relaxed/simple;
	bh=fLrlJueHXw6lT+6BQZoaO3Vzd92qwHf9kh7ZA0Qz4Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0T7DOLy2A+6Nvky8V2LUpM4t3lDxRKuJPIRSXpu3fkyai0YK28aMNjza0lveCF6sctIvMEuAnzTnnDblvuztHKDHTzeRQEIvEqEfIlc9dVRpHxAccZAsXm3y2F04RRC/e1/wgwcQunxy0nbG8SncEQSSsl3m1FvnM/XtEDisM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=nyPxtAFh; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="nyPxtAFh"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-780fe73e339so511667b3.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567249; x=1761172049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XsN9L7zj0vwycCJJ/h1RnhVhfzkjmzsQfwj+xyP3QVQ=;
        b=nyPxtAFhK6nZm2+FM0mMmioUe7GJzBgeXe+SHtJ5Ik4SYJO4AsAcv8czo561dm+WA9
         4ibY1HlfpoECvymzaUyFx6aV9GCQKS5tI6MjnFEV8f764pTjLn5G0QaMgQQfaARcjH1M
         nUGEqtPXvSgzPEdUFKfe9VKfUFFDtEnRFc9KRSfKaLxHnVwY/pc5DLI7be5ddB+2wxFj
         2cb36rNAgWs6JNKTMdJlKq1OfPYOF9xHa+xGpkPq2OdYhI1tRteCQhHd9P1V7/SJFZCv
         yaIhG/IoRfKbEzb4X+uk9rxSxKFBNBxfJ4+iWc9HB2IZGtXTrtqpHoMw2lUTSV/f7WHH
         gogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567249; x=1761172049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsN9L7zj0vwycCJJ/h1RnhVhfzkjmzsQfwj+xyP3QVQ=;
        b=XP+Bjbz2Aw/xavQlT+nMfIUB7CkZgJWZeETDilZx/sPju+pXoEO3YPQICiNvbazWXk
         i9uTKuNwR6TiDADelvO2uyJZdwF1nkI63NI3QZOnQEVfHNV96xjYbHkRL+L/oCBW7VBe
         vPJYbllYa9xv5hYnV0IHaJt0tMCc44ZbQEkTd1HPnVLGOAzSnjR/mx3LVvz+VOUSvQIZ
         NxFIu+TXQUz1k8iNrE7wfzxOq/l+ghFuP+ENJVX+8iah8UrA8wyL9679vIylFWDakRLj
         U1xohI/qUVvwMqRNO+s91fRxOdgT/VALaR6kbOxD0YwxVZayLy2r4a11fBJjX+D/sZNJ
         3rLA==
X-Gm-Message-State: AOJu0Ywc4aozG/BflyDlqdND8QY45uwukSndNw9dtolD4D1ROnZZs3+i
	ZR56c7pPatpAGaaIApAqdHufC0eTEhkpwa910FGFZRrMAjsAmukeZqr51qW774E1qQq2C3tPPQ3
	MX3WNljMf5Q==
X-Gm-Gg: ASbGncs4em9jlsWPSZMkMd1XgpxeJoBuSV8J7S6iM+cWtIkxQVuIwULhBjI5FyJ3uvA
	NygHsD27RZZq7xF5L6QkXsEALtKli+w/X4J5RKCCuoQ5kWG/ozJQibNuvohOMOUa0JkwNOw3tTP
	i4lSEqS1o78fJTdR6B8YXI70L+4WWSoUqiqzOkkv12jyOyoFHQWK3U3HabpaA026EAI9d8Dmx4Q
	B+OrV1JrDgW2s9UXUJbUeQYr+OU4Zl1aoMXwN/mgk2Sf1RuV1MwFHkw1mI2M+2YTUotdlM+JkWe
	GJvDS6+oRNgvoXnyh9GV1beBuI3Qx7M5QcEU0xSZmVUsQ84AZOSv+Lc+kMSrTy8tVn5pjZb1kAS
	TXl04IjBaNBN15M3zBLsvimkbv3ynZZHb5C2hHBfqYHXAtpE4QjETeNqYQYL/bxjtSf6kaE3YBW
	F1peKYVytg3kyAB9jHccxSYReTu0hjM+kifnYYQ1oB3aEVCdBIgWNGyq1kfqbMk9uzgjCT4A5f8
	j9kHi8=
X-Google-Smtp-Source: AGHT+IHinsC/amT4M/XnGQd/n5RNYaXi+9h1GPhfre3KHlQdC0KjRAyKI4uQ0qKhWRtNPRjrc0ih0A==
X-Received: by 2002:a05:690c:8689:20b0:780:f7eb:fbe with SMTP id 00721157ae682-78269f906c5mr14370927b3.19.1760567248714;
        Wed, 15 Oct 2025 15:27:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78292c0cde8sm2604707b3.34.2025.10.15.15.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:27:28 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:27:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 04/49] builtin/repack.c: avoid "the_repository" when
 removing packs
Message-ID: <75f23ba211bcdd236fc5040c0732eb880867ec4b.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

The 'remove_redundant_pack()' function uses "the_repository" to obtain,
and optionally remove, the repository's MIDX. Instead of relying on
"the_repository", pass around a "struct repository *" parameter through
its callers, and use that instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 113f5fc67f..93802531e1 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -221,33 +221,35 @@ static void mark_packs_for_deletion(struct existing_packs *existing,
 	mark_packs_for_deletion_1(names, &existing->cruft_packs);
 }
 
-static void remove_redundant_pack(const char *dir_name, const char *base_name)
+static void remove_redundant_pack(struct repository *repo,
+				  const char *dir_name, const char *base_name)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct odb_source *source = the_repository->objects->sources;
+	struct odb_source *source = repo->objects->sources;
 	struct multi_pack_index *m = get_multi_pack_index(source);
 	strbuf_addf(&buf, "%s.pack", base_name);
 	if (m && source->local && midx_contains_pack(m, buf.buf))
-		clear_midx_file(the_repository);
+		clear_midx_file(repo);
 	strbuf_insertf(&buf, 0, "%s/", dir_name);
 	unlink_pack_path(buf.buf, 1);
 	strbuf_release(&buf);
 }
 
-static void remove_redundant_packs_1(struct string_list *packs)
+static void remove_redundant_packs_1(struct repository *repo,
+				     struct string_list *packs)
 {
 	struct string_list_item *item;
 	for_each_string_list_item(item, packs) {
 		if (!pack_is_marked_for_deletion(item))
 			continue;
-		remove_redundant_pack(packdir, item->string);
+		remove_redundant_pack(repo, packdir, item->string);
 	}
 }
 
 static void remove_redundant_existing_packs(struct existing_packs *existing)
 {
-	remove_redundant_packs_1(&existing->non_kept_packs);
-	remove_redundant_packs_1(&existing->cruft_packs);
+	remove_redundant_packs_1(existing->repo, &existing->non_kept_packs);
+	remove_redundant_packs_1(existing->repo, &existing->cruft_packs);
 }
 
 static void existing_packs_release(struct existing_packs *existing)
@@ -685,7 +687,7 @@ static void geometry_remove_redundant_packs(struct pack_geometry *geometry,
 		    (string_list_has_string(&existing->kept_packs, buf.buf)))
 			continue;
 
-		remove_redundant_pack(packdir, buf.buf);
+		remove_redundant_pack(existing->repo, packdir, buf.buf);
 	}
 
 	strbuf_release(&buf);
-- 
2.51.0.540.ga7423965ad8

