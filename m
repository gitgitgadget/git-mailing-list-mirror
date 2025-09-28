Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770A71FB3
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097367; cv=none; b=ghWbLNGxTC+V17TJcjhQNdJZDeOhD456vwpejjutbnh8ffK3VgRAVduXIMIrbAD5vTZv2rs/e2/P4fAQjRGnFDZI+jOVNPcBCPbmC2YcY9/LiG1iV0ISs7KJxz+pDGh23qeX8gQJDkdwXtE4GOg39au5xVcR81X7RLcX+LkTYP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097367; c=relaxed/simple;
	bh=eLLmufFbPCWxiJNE9dNw50CEHIX8nStXlv5F9lPlwlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNSobgVlFGYXM26qnYijJ3Gw5A5PhF6lHi5yV0er7pLdY8y49fgreU9j7HLBbSQKPPrzszad0pBM4tXtnjXcedmDkaldba8FgMYkBUFZdtTLRXVZGGACXmUwnmV/zkC7AvBj9IBD5n2JahyvDq2gVH2x44TVLgw9xIIYTfPPDR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=CendmTal; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="CendmTal"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-633b6595287so2781873d50.1
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097364; x=1759702164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2DBpzDsj7HCvFLn2XKxWEcCOmtARkhJudlvmZ6E+/RE=;
        b=CendmTal51+nYpZNmRMDGVjY6fS5rbwqAn7qjL/IkwddMQROLAze0dSQWLKLjuqKlU
         ebGdzbDbHYXXjeR8doWErHwmP+/g5mgiC3V/cTz6BMzYG7yTNGZZYjCeLfJidaMCIhId
         AO93MxI9yraRH/AZ4kke2qdguHDzAAv658de1MAIm4tIfW8iyo5CyhfXASMq1PPOaV1i
         LWHrGesc3+XOb0uKCQUc+e1/f2sohYuJgSCvKNGBBdpgHpN/j3NabwgMuJO3xz6B/Jik
         dZ7NPap+rkvmPvumOezzp5RJ8+2CvSn/BmI6nxfhLjjhTnTUtRJj1cwbZsChtPECuE7T
         r9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097364; x=1759702164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DBpzDsj7HCvFLn2XKxWEcCOmtARkhJudlvmZ6E+/RE=;
        b=KDQJG/afh4bBrPtKXyOKJTNQ9dweBvsmKihR5/qNtiRXPIV07FP4sWMYPEbCHx7646
         HwHEaZmgALMmGls6h6fHaIgfyNNHXtB50aUEsnWhfnepQErj6529GoEPhClqi2lGKZDk
         UBPQacVcwTUwvi6MtghIGvwmUAidIj2VeMxc9vt5moElWNpscQg1G+HtB7KlDBhME7T1
         U8HtvaBuHjgO1VkNIu6xXrXqwm73mw5Mgdbx5aGHfePoIDUWzO7MI5t/sJEjfEiBG+dJ
         RY9hp3SdMhjgXoWsWZN4ZqeyhzcH9xHlOcfMgmf/44wvLtbL8YSAZlluAoQ5qdicAt5c
         ky+g==
X-Gm-Message-State: AOJu0YwwN8AGXUlyUGoytywbAXz8hA0ebaVrfu2uz5D4RwBUV22Tr0n2
	UppWFUN+Fm/Kqnp88sPAdQF4jcbzkmij7e5lP6AZBalfAbNx5yk8wGf8zhHxr87+HlwaC/3M6+P
	QxwEHS8Fd5A==
X-Gm-Gg: ASbGncvgQVwmVvI6C/QlszvpPtaw3NjFZaSsclKKY8dsR+62szO13H5B1/yVI7JOsK5
	Yfoban4unQXGGYrLYiUdaaubINiEkttkgrK1hQ7mbAw0O3k+fxaLyKQQn3P/XzX9azSLUHWbcSi
	JYLjIko0xrRIi4oC76dnQyF2uAGr7rTlt+49oDO1y2zu9RT3dVZme5MnPMkKJy4KsBVBQwitwAV
	HvKM3hSqnUTTe7tMu6p1f/6aoYBZXOSvXTXYwJJx469BOFPloGNOfGC02qU4LSgZ6bC2xBp+eZg
	3xHPCVNeqKz/bJS1LMoVQd4qgyh3hWmQr3j1OtfuiiR7PNb4k3A7m1C5wXtn2cEGU9NL0nJTFqk
	gchzg+lBgDhwCCgo2p+8Vl7/XBd6VUHFsCMRHs73hjcA1a0dSheQQfqjRWRoHRKL0/GPar0yUd6
	44e5oSW/8o69YGqH2nCOQMqLmhmQ==
X-Google-Smtp-Source: AGHT+IHM6hXgjAESIla7qK5PHL9nIF09+0DftX3a0EgjD6R9QEsRZtqoypSCxNLy5TsHGeNjJYmC7A==
X-Received: by 2002:a53:ea42:0:b0:63a:183:ffda with SMTP id 956f58d0204a3-63a01a28749mr1241916d50.26.1759097364206;
        Sun, 28 Sep 2025 15:09:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-eb629895fdesm167867276.18.2025.09.28.15.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:09:23 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:09:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 34/49] repack: keep track of MIDX pack names using
 existing_packs
Message-ID: <ccf2c6a517c4e03ef55a4277e1c9b1459c8d5c41.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

Instead of storing the list of MIDX pack names separately, let's inline
it into the existing_packs struct, further reducing the number of
parameters we have to pass around.

This amounts to adding a new string_list to the existing_packs struct,
and populating it via `existing_packs_collect()`. This is fairly
straightforward to do, since we are already looping over all packs, all
we need to do is:

    if (p->multi_pack_index)
        string_list_append(&existing->midx_packs, pack_basename(p));

Note, however, that this check *must* come before other conditions where
we discard and do not keep track of a pack, including the condition "if
(!p->pack_local)" immediately below. This is because the existing
routine which collects MIDX pack names does so blindly, and does not
discard, for example, non-local packs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 26 ++++----------------------
 repack.c         |  5 +++++
 repack.h         |  1 +
 3 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 8ae56b05e9..251dd08b0a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -118,8 +118,7 @@ struct repack_write_midx_opts {
 	int midx_must_contain_cruft;
 };
 
-static int midx_has_unknown_packs(struct string_list *midx_pack_names,
-				  struct string_list *include,
+static int midx_has_unknown_packs(struct string_list *include,
 				  struct pack_geometry *geometry,
 				  struct existing_packs *existing)
 {
@@ -127,7 +126,7 @@ static int midx_has_unknown_packs(struct string_list *midx_pack_names,
 
 	string_list_sort(include);
 
-	for_each_string_list_item(item, midx_pack_names) {
+	for_each_string_list_item(item, &existing->midx_packs) {
 		const char *pack_name = item->string;
 
 		/*
@@ -190,7 +189,6 @@ static int midx_has_unknown_packs(struct string_list *midx_pack_names,
 
 static void midx_included_packs(struct string_list *include,
 				struct existing_packs *existing,
-				struct string_list *midx_pack_names,
 				struct string_list *names,
 				struct pack_geometry *geometry)
 {
@@ -245,8 +243,7 @@ static void midx_included_packs(struct string_list *include,
 	}
 
 	if (midx_must_contain_cruft ||
-	    midx_has_unknown_packs(midx_pack_names, include, geometry,
-				   existing)) {
+	    midx_has_unknown_packs(include, geometry, existing)) {
 		/*
 		 * If there are one or more unknown pack(s) present (see
 		 * midx_has_unknown_packs() for what makes a pack
@@ -604,7 +601,6 @@ int cmd_repack(int argc,
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
 	struct string_list names = STRING_LIST_INIT_DUP;
-	struct string_list midx_pack_names = STRING_LIST_INIT_DUP;
 	struct existing_packs existing = EXISTING_PACKS_INIT;
 	struct pack_geometry geometry = { 0 };
 	struct tempfile *refs_snapshot = NULL;
@@ -978,18 +974,6 @@ int cmd_repack(int argc,
 
 	string_list_sort(&names);
 
-	if (get_multi_pack_index(repo->objects->sources)) {
-		struct multi_pack_index *m =
-			get_multi_pack_index(repo->objects->sources);
-
-		for (; m; m = m->base_midx) {
-			for (uint32_t i = 0; i < m->num_packs; i++) {
-				string_list_append(&midx_pack_names,
-						   m->pack_names[i]);
-			}
-		}
-	}
-
 	close_object_store(repo->objects);
 
 	/*
@@ -1015,8 +999,7 @@ int cmd_repack(int argc,
 			.write_bitmaps = write_bitmaps > 0,
 			.midx_must_contain_cruft = midx_must_contain_cruft
 		};
-		midx_included_packs(&include, &existing, &midx_pack_names,
-				    &names, &geometry);
+		midx_included_packs(&include, &existing, &names, &geometry);
 
 		ret = write_midx_included_packs(&opts);
 
@@ -1063,7 +1046,6 @@ int cmd_repack(int argc,
 cleanup:
 	string_list_clear(&keep_pack_list, 0);
 	string_list_clear(&names, 1);
-	string_list_clear(&midx_pack_names, 0);
 	existing_packs_release(&existing);
 	pack_geometry_release(&geometry);
 	pack_objects_args_release(&po_args);
diff --git a/repack.c b/repack.c
index d8afdd352d..1d485e0112 100644
--- a/repack.c
+++ b/repack.c
@@ -80,6 +80,9 @@ void existing_packs_collect(struct existing_packs *existing,
 		size_t i;
 		const char *base;
 
+		if (p->multi_pack_index)
+			string_list_append(&existing->midx_packs,
+					    pack_basename(p));
 		if (!p->pack_local)
 			continue;
 
@@ -104,6 +107,7 @@ void existing_packs_collect(struct existing_packs *existing,
 	string_list_sort(&existing->kept_packs);
 	string_list_sort(&existing->non_kept_packs);
 	string_list_sort(&existing->cruft_packs);
+	string_list_sort(&existing->midx_packs);
 	strbuf_release(&buf);
 }
 
@@ -220,6 +224,7 @@ void existing_packs_release(struct existing_packs *existing)
 	string_list_clear(&existing->kept_packs, 0);
 	string_list_clear(&existing->non_kept_packs, 0);
 	string_list_clear(&existing->cruft_packs, 0);
+	string_list_clear(&existing->midx_packs, 0);
 }
 
 static struct {
diff --git a/repack.h b/repack.h
index 803e129224..6aa5b4e0f0 100644
--- a/repack.h
+++ b/repack.h
@@ -40,6 +40,7 @@ struct existing_packs {
 	struct string_list kept_packs;
 	struct string_list non_kept_packs;
 	struct string_list cruft_packs;
+	struct string_list midx_packs;
 };
 
 #define EXISTING_PACKS_INIT { \
-- 
2.51.0.243.g16eca91f2c0

