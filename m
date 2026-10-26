Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029571;
	b=LOE9aluAxtebufPdJfY+XimQFBMUpWwmotqTE/f0qvJ2Q2pW1Lmo62pgwfZOnF0TNAJI
	 nHyUPYHX9wpUWI07FH4rM0xhGx+kgcTgzagy3wkthGCqGrHHKetUhEzAt5/56NNgrZ7nD
	 2BP6/205yJknBJPnjU1d3Ni9csel84c13NvSPk1O2YKyqZgN/jO7jS0XBMKeEjL2SEjVa
	 gijYrQLDTJ/1jA6l//fsLs1O9Zda340IIRhokR3XtZ7U6KNWnU0ZNK613+X4N1maTEo3m
	 UaclY2mSKe7HQnvKpDpl4tIIYuFFzCQhjdnevhtPO9eELjEWOY8yN+OGxYYJ7BIQHJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=RNpsgjEF5umzUbHJqsyIufok3BU3v57Xv+ZDC+OYa/o=;
	b=fuT3HyocrVjIy7s6HYArLh3Nb3Z8ZXVbQy/2ERIF6Dd4Uh+xPcLjZghjqG2O38f0kmDc
	 bRAQWjjrkHpiJiwQK4DIF6KIQr+C7nrUaxMsPbaEs8HEDi5tMfGVvi8YeuQd+vEtEKe76
	 rY0qqcy5pYc2OQ85+YDlWib8OX6dcx7KfU5Nc6ebT3k15nFafS4+uPjxn0LnyEcTBj0ix
	 ike6cG50V8/B8Hv8FQGelIqz6zgg4H4dax/g77PaX8ANjtTgJsN6BDWwQVGdNblg86KNx
	 myNeH2WaUH76RLh5UssqxqUWviaNubvbKaScAHvVtUP/FRUKO/x1eQdsEaJNLCIugPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q1XlGpWV;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8905E606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 15:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8905E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q1XlGpWV
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1448861b3a.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793029571; x=1793634371; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RNpsgjEF5umzUbHJqsyIufok3BU3v57Xv+ZDC+OYa/o=;
        b=q1XlGpWVOoC2yRziuAsb07Pl/x66dqt4f6RxZ/440vVgSOO2/ZkWQHgYeqZmE1J6hV
         xZFBSmA8wLqCMft/ZPMDZY/x0lOEy47ZDy2z2bRDveQI+r7tygGc0rLOxmtkDxCJDLCh
         KBBcDYE5buWKZ3HlvTrrjf1pxH8TlPn7nNtB0teVYdDEPBe0QxO2X85UwuBRTg15rwAM
         8+rmr5trtpJVY2Yeg69VGSscbaBrZLyL5u1PmNAyGqGYQDuEabUyDWvTgSJqlnDgRbFe
         SCFVyI5c+MlA6+fujmVzCdDkhq3IqBzia8yDCq/nM8dZIltKumqjGIHSK9/kaId87Pj8
         IaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793029571; x=1793634371;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RNpsgjEF5umzUbHJqsyIufok3BU3v57Xv+ZDC+OYa/o=;
        b=XLvYf4z9nJntUjmeANUkN8k1DzSJQVpSLORUmpSyVTt1vWn6eYGICSK1saBuEqY2Qm
         yj/RZ6qVK4tDFRSo8QPAZIXAaxynQKvjw1UXF1pGEYmggB+0lPcsAGG12h5CRj60bSXL
         4JqmvwjPglbNcbEZUj3J7N4/bLJCAOaRetSTXs6GjVa39VD8Ef/sA5LzBatwUWTyRmQM
         RrDM226aOlEN+9XQ1BNN+IciiOSgG+pUDCFnLyFAzsyRKVY8bnA9YKDqBUmcXtRf4BBE
         QjUmQQFzMOWb9ZjDQeSV42U8+SK3MGsTAVvSzOHU9/nbWc09pdzsbUXuX7KUw5og5lbg
         DbmA==
X-Gm-Message-State: AFq9FYI3P/6WfDeJx1NDKkgDOXXdMg8NxO006K26v5BKX3FJV7CQeGYg
	ZA5dfBvG5t4VdqVZPv1+wZzpDIRGaIJ3MaqoDaA6Je3YjqQjAKMh9uTWyNJDx/6K
X-Gm-Gg: AYBFou36gHRolFCPvE92fGjjgu5xVBj2DfANwix0PL2Ket87//AbXDazzVZb7M/fv7M
	GVaAwrbJJ8g4hWztz16lkyucY+dbn+LKjjWnshqqkDTQH2auuZej4vsoUehFrScDWtMp4RJqHvE
	qb2T06HguI1eIWBpUEmPVvSeJCDKzMjSZdA+02OSiFDG0W0KCu3Dql3qIbJVTV5fZsovVcfP9LN
	BcDPVYtvcC6mbvdChnNJSn++GraicS4epb9fWq20TLZ7PhBisrAHOw+5th3j5wqrNeBMyVdVTkJ
	Ge//DstRZFWjHtHFRFDOyRk8AOVZiGVKwpsNGgywPf9VuwsF6b7W7XhhGJLr6JQDiESApQhiV69
	MnuScs9C8WuXs+dHJKPvBfd9ATUeuIg4784EymMFYOK568v1lmgODC2ICucDt/n/fBFF5PGzTUr
	hT0E41fXz0LJ9iBmHTVxs3Xk7/7pNXHqJIBsHcd1pnXHpuy15bRveXTCAe5CwFwmZE/zA5xQLlW
	gow+i6DKRsIwZ0q5ZFmGFXDTlorxlVsdgl+5KeP++EXyo7dnpR1Wflq0jda6kzhnROD33fiF7en
	Zux98CAnjm+RE9TEM9++sn+4mSEKtLg=
X-Received: by 2002:a05:6a00:4506:b0:89f:129a:9590 with SMTP id d2e1a72fcca58-8a368e7f9d5mr5869739b3a.48.1793029570582;
        Mon, 26 Oct 2026 08:46:10 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.34.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36bb2968esm1493321b3a.35.2026.10.26.08.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:46:10 -0700 (PDT)
Message-Id: <e13f12640853643e14288107ee03f99fc00bb0f1.1793029565.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.git.1793029565.gitgitgadget@gmail.com>
References: <pull.2281.git.1793029565.gitgitgadget@gmail.com>
From: "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 15:46:05 +0000
Subject: [PATCH 3/3] send-pack: avoid resending unchanged blobs after rebasing
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Marc Strapetz <marc.strapetz@syntevo.com>,
    Marc Strapetz <marc.strapetz@syntevo.com>

From: Marc Strapetz <marc.strapetz@syntevo.com>

Rebasing a pushed branch can put its old tip outside the boundary
traversed by pack-objects. Even with that tip among the negative
revisions, unchanged blobs may then be sent again.

For forced non-fast-forward branch updates, pass locally available
advertised old tips as haves_to_inspect. Limit this to refs selected
for sending; leave fast-forward and rejected updates out. Restrict
the hints to branches, which name commits, and skip shallow
repositories, whose thin-pack pushes already inspect negative tips
with --objects-edge-aggressive.

Update the rebase tests to expect two packed objects instead of
three: the rebased commit and its tree. The unchanged blob is
already present on the receiver.

Assisted-by: GPT-6 Astra, GPT-6.1 Sol
Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
---
 send-pack.c           | 30 ++++++++++++++++++++++++------
 t/t5516-fetch-push.sh |  2 +-
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index f20460fbf4..de6d33cf75 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -42,17 +42,18 @@ int option_parse_push_signed(const struct option *opt,
 	die("bad %s argument: %s", opt->long_name, arg);
 }
 
-static void append_negative_object(struct repository *r,
-				   struct oid_array *haves,
-				   const struct object_id *oid)
+static int append_negative_object(struct repository *r,
+				  struct oid_array *haves,
+				  const struct object_id *oid)
 {
 	/*
 	 * The remote end may have advertised objects that we do not have in
 	 * our object database. Skip those, as we cannot use them as boundary.
 	 */
 	if (!odb_has_object(r->objects, oid, 0))
-		return;
+		return 0;
 	oid_array_append(haves, oid);
+	return 1;
 }
 
 /*
@@ -89,8 +90,25 @@ static int pack_objects(struct repository *r,
 		append_negative_object(r, &opts.haves, &negotiated->oid[i]);
 
 	while (refs) {
-		if (!is_null_oid(&refs->old_oid))
-			append_negative_object(r, &opts.haves, &refs->old_oid);
+		if (!is_null_oid(&refs->old_oid)) {
+			int added = append_negative_object(r, &opts.haves,
+							   &refs->old_oid);
+
+			/*
+			 * For forced pushes, inspect the old tip's tree to
+			 * avoid sending objects the receiver already has.
+			 * Shallow thin-pack pushes already inspect negative
+			 * tips via --objects-edge-aggressive. Limit this
+			 * optimization to branches because --inspect-have
+			 * requires commits, while other refs may legitimately
+			 * point to trees or blobs.
+			 */
+			if (added && refs->forced_update && !opts.shallow &&
+			    starts_with(refs->name, "refs/heads/") &&
+			    (refs->status == REF_STATUS_OK ||
+			     refs->status == REF_STATUS_EXPECTING_REPORT))
+				oid_array_append(&opts.haves_to_inspect, &refs->old_oid);
+		}
 		if (!is_null_oid(&refs->new_oid))
 			oid_array_append(&opts.wants, &refs->new_oid);
 		refs = refs->next;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index a46ba91ba0..067b4ddc16 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -216,7 +216,7 @@ do
 			GIT_TRACE2_EVENT="$D/rebased-push-event" \
 			git -c push.useBitmaps=false push $push_args
 		) &&
-		grep_wrote 3 rebased-push-event # 1 commit, 1 tree, 1 blob
+		grep_wrote 2 rebased-push-event # 1 commit, 1 tree
 	'
 done
 
-- 
gitgitgadget
