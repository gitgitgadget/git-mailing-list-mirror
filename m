Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE763BB117
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782500544; cv=none; b=Nxc7vrMYfm2BhxMg1EIMRJvgJ6jkBzCa+B+UfUktp34CMw3AGoLBmYfKi1oZ+1LTPDyaRTIhvg9GsVU+ZA06WmOsIV0g85PE/RSYhr0NN0zDNWJvNH7S3GgtCUsX8pQ3iqBcqDyIng9CgT6H4rv+IDaSZgum4QBNq8EfWo3O/Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782500544; c=relaxed/simple;
	bh=haYy0RICsYgqGANuB+GzjSc9d0r4EYUjXGEpGidG84g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3LhF8z+ac4bOHHMKEZBU/DyHXaYWf+l9OZ0bf5PdQ39hBitTXOOBerV/NNN/RgFXXprRDeOXktSv6NanxUyHN4/q2mpKshsOwoPWLP4aOOv5rSXBIFxxIDQ0AT/qWbOnnFUcPqg7ek53HS1PD4DJy3DK2aTB5cLRXpNAcDEis4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=TSmGy+7P; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="TSmGy+7P"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-80b0cd40dafso15203207b3.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 12:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1782500542; x=1783105342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0wrvome6GnuWpUTRC/xdklxOTgsUrelRoW8pg/BiJRM=;
        b=TSmGy+7PoqS4PsPvdFPGJ2mZfFA6dZhhSHhOUzbOKca/N8kkfyPXuIIbZ1fcoUSbpP
         5XAAB8zYtPPMBS8Dj27JzNFZoc1TsyNTElIxbAqM6cF5UuJ1wWJ3+MXla5fZFUdMK6xN
         cENSUwjZ1wBHPsDF8mgQZ5hn8loJGx2PJATkTnzyQefkKREtMFiW4Q2BcfaE97FUKszL
         0grolUCtlxNWIFgDwRqdb6o59CUI4QwODUb2RcapatAb2Bf3GUgEgTHDQbSdFh6+Z7Tl
         gXBn+T6rmzHXkf7jlIJ09RU4qTr9L0bR+svQKuKZAiUcdcJJip1t/eaeXgfVDH/ZjAwT
         w6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782500542; x=1783105342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wrvome6GnuWpUTRC/xdklxOTgsUrelRoW8pg/BiJRM=;
        b=XAb7wRSuIdMSvY0Qb+p8v5bAVjU3TLrWXoTlh/w5tKRZVee6+DMfjP3W5Rz0/QY3Y3
         ORNva+Q6hUU4GjzKzljrRnlQ2Ajg7UGZqHuwe/igTP+hROFcehmdZ89Dd0RnU7o6uwt2
         8xTdl/Vmnrf1DUmvd+5H7bAvtRdss02urAdqUiTXuTS/tqH8iem1Jfvn11MzgQzp79U8
         fAyf3tZHTKgqa3plGEsFm3YREn/R9VYCPyLQ5PqYZJKNeat6AfnOv72bGbZ1HPWYOypw
         HB/nv+QFIJQdfDjrIWRypYVvlXdxpQRIB++fUq7Qh9epDQ850wzmPrkWhSAO4xcdNR/Y
         hWtw==
X-Gm-Message-State: AOJu0YzsEZc+5hHhQ60aZM2VpnL+nETNeQvsp1KwWQLkuJhap2Kbqo8U
	uI0qDPvwl+SCgHGfdHgvSbEjzE8H8AapRgRM4HO8sDiZZ7XHMi+gIKuQBqADDU6YDcjtNHXxK4C
	NGZAJIgZihQ==
X-Gm-Gg: AfdE7cn66UULcC274Jm0LSZgMFhx4JInsVqGxqTx5NMckrNHesq73sh2ifQ2PYBZ04B
	XdfrWpAoqNPQsgUI2QgmhdSDoHaCGe8f7M7WIymat73zMZWneZYZToyZoehVDG1ckVjBygFTJmX
	fgEhpaxyZWbnDF2kJHFpUvNJv2kg6a2LR2mbR9UjMc6FBjsIVXiniFAv7f50tkoIVQ4rYSIBcpe
	I4Y9SQjgBM5F/gI7P/LrJpqgFBWXWHIC9dF7SQF7eWzWBWjYZBe9GC8EGULoMrAON2LGqOofKJa
	l5EaNN9kLIDy1OjOpTEZok9v8jBYuNOcaR3Rin8aWTuriKNvMHroPnYw3Dwj15jcYmCETulv2Un
	nkkczOeqo6pocn+PoH8AB2GdVcDCaCpr3F+n+L71ht/bHmXAiim2i4qSk2knRZZ/wj0TkoR95L/
	efHUqbEzvq9gt+Fxe6TtU/GsPSic5gXsrRDXOuFs5HqZf/qtHysAqI4HDYLJnZSTEWEEkbgI0Sy
	M0oZ1K2AzF6uCe5QyCONqf2IB/dwulGNgho9ULvTttfQq2W0CVylmCfUEKp4XdieDh+48tfyIRC
	0Plm5w==
X-Received: by 2002:a05:690c:7203:b0:80c:88b8:2dd6 with SMTP id 00721157ae682-80c88b82f25mr14723547b3.32.1782500542135;
        Fri, 26 Jun 2026 12:02:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025c970321sm87187637b3.2.2026.06.26.12.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 12:02:21 -0700 (PDT)
Date: Fri, 26 Jun 2026 15:02:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [RFC PATCH 03/10] repack: mark geometric progression of packs as
 retained
Message-ID: <b0cf30444a64de190d0bbfc0eb5d01f88a0ed49b.1782500507.git.me@ttaylorr.com>
References: <cover.1782500507.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1782500507.git.me@ttaylorr.com>

In non-geometric repacks, any packs which repack wishes to delete are
handled via the `existing_packs` struct, which has a mechanism to retain
would-be-deleted packs (e.g., if we happened to write a new pack
identical to one otherwise marked for deletion).

In geometric repacks, repack removes any rewritten packs (alternatively,
any packs which were combined in order to restore a geometric
progression) by enumerating them via `pack_geometry_remove_redundant()`.

Prepare to use the `existing_packs` deletion machinery for geometric
repacks by marking any non-kept packs above the geometric split line as
retained. Do the same for promisor packs, which have their own split
point.

This commit only records which packs the later deletion pass must keep;
it does not change which packs are written or removed.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c |  2 ++
 repack.c         | 27 +++++++++++++++++++++++++++
 repack.h         |  3 +++
 3 files changed, 32 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index 1524a9c13ad..ce979d86d96 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -325,6 +325,8 @@ int cmd_repack(int argc,
 		}
 		pack_geometry_init(&geometry, &existing, &po_args);
 		pack_geometry_split(&geometry);
+
+		existing_packs_retain_from_geometry(&existing, &geometry);
 	}
 
 	prepare_pack_objects(&cmd, &po_args, packtmp);
diff --git a/repack.c b/repack.c
index 986c74ac7e8..9b3cb425431 100644
--- a/repack.c
+++ b/repack.c
@@ -254,6 +254,33 @@ void existing_packs_retain_cruft(struct existing_packs *existing,
 	existing_packs_mark_retained(item);
 }
 
+static void existing_packs_retain_non_kept(struct existing_packs *existing,
+					   struct packed_git *p)
+{
+	struct string_list_item *item;
+
+	if (!p->pack_local)
+		return;
+
+	item = locate_existing_pack(&existing->non_kept_packs, p);
+	if (!item)
+		BUG("could not find non-kept pack '%s'", pack_basename(p));
+
+	existing_packs_mark_retained(item);
+}
+
+void existing_packs_retain_from_geometry(struct existing_packs *existing,
+					 const struct pack_geometry *geometry)
+{
+	uint32_t i;
+
+	for (i = geometry->split; i < geometry->pack_nr; i++)
+		existing_packs_retain_non_kept(existing, geometry->pack[i]);
+	for (i = geometry->promisor_split; i < geometry->promisor_pack_nr; i++)
+		existing_packs_retain_non_kept(existing,
+					       geometry->promisor_pack[i]);
+}
+
 void existing_packs_mark_for_deletion(struct existing_packs *existing,
 				      struct string_list *names)
 
diff --git a/repack.h b/repack.h
index f9fbc895f02..bb4c944d0cb 100644
--- a/repack.h
+++ b/repack.h
@@ -54,6 +54,7 @@ int finish_pack_objects_cmd(const struct git_hash_algo *algop,
 
 struct repository;
 struct packed_git;
+struct pack_geometry;
 
 struct existing_packs {
 	struct repository *repo;
@@ -82,6 +83,8 @@ int existing_packs_has_non_kept(const struct existing_packs *existing);
 int existing_pack_is_marked_for_deletion(struct string_list_item *item);
 void existing_packs_retain_cruft(struct existing_packs *existing,
 				 struct packed_git *cruft);
+void existing_packs_retain_from_geometry(struct existing_packs *existing,
+					 const struct pack_geometry *geometry);
 void existing_packs_mark_for_deletion(struct existing_packs *existing,
 				      struct string_list *names);
 void existing_packs_retain_midx_packs(struct existing_packs *existing);
-- 
2.55.0.rc2.10.g29e31820dce

