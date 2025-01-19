Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FDE1D4335
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737285583; cv=none; b=cBIyMsoibrzKGvVYDRasJCdbX4zj4sFRhyNe5T05QBTs3ZxHTzoz/bkda1C1KQzLjXKFRFZherRSRnlMcWks3jq8J8vGXoCata3jXb3X7Le5wnwhqTvJUxUs172E5xfDpspB0bAr/Fdqb2wrCTqy15pIR43RoNZRwDH39pyyNa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737285583; c=relaxed/simple;
	bh=l/H1BXfgAsAT3JAZNzifnzOj2hY96z0VAYY5k4ZBJcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lUU5Gx2s+zFTQh6V9M3cWgW6apN8BVcPAUOqU40qmIyi6TLjbTgjL4c7ZU2g7G0TAkLHBpbTzhzjUnUOXBgJ57OBfHq+U2mVHiXEbLHAFpZmwyMyFgXzWbred5FxRZYg82TXVgs48eBTNruCuOOttauk0gAcGl2pxH4LTnomRMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4KLjBe2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4KLjBe2"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21c2f1b610dso55589795ad.0
        for <git@vger.kernel.org>; Sun, 19 Jan 2025 03:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737285581; x=1737890381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpLuD5hTj+VGAyHqFcU6pyOaq44t+mr+iV+5XBO0Q/I=;
        b=Z4KLjBe25fxRusLLTX8DC64quxtml4FKiYWiBDxmWJJKOUehFCVfU9rOi+a0Vksjvs
         NsXfipzcVHrvNFNb2hAQaWK3WTvmqeP1Szy/fFkgC6tVzHK0txo1nA4lR2f/3wf3v4KA
         Se4PATD++GLDd1DJKmYOe7LQwYVE7yHZxNwrCaq3BQGoHifcGpr5RJyFCUBV6Bqr808D
         HlTJlW2liO3qbh6VOKYn5zuxwCGAVRZ85LDr2n7AXYQv4FZkBey1Lw07jQTpfl8ApSOZ
         dcexVBYIx+Sawm/QqQ9AbJOfO58MxisrMXMC+zpvLRRMx/2ktNWTzs94YFIN4eUywTcH
         IZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737285581; x=1737890381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpLuD5hTj+VGAyHqFcU6pyOaq44t+mr+iV+5XBO0Q/I=;
        b=FwV+3vts7zwdgidm6F0n6A678sTcwVtgKS6bPPuqfMSOjQOGzytAdo4m3obAahWmwZ
         zS9EjDIMDNNqBl/nc+IgoFxUWODBUotTP6EI5Tk5sdNo0QVr5j6WnFJSLP8ZVPdjnw8T
         nN1/bo+lTNT5fmNqAD6JldanwoTTzypchGhJhBndiDUBM0pD5a2bNAdd3QQHzvRF/S5X
         kADH+7usaG5woM2eiwCtelwLEkdBp5q6nuOaQRcGj+oflO+vs5MKwuV1XP7wkj9BVjKG
         dYFR3KA9FIcXMcxporBliUACqYiIxd3a1As0MEvpanhccdTlJIerd+7wg1IJW73uXu4j
         V8vw==
X-Gm-Message-State: AOJu0YykQP9euHB8MR05jXRSdbJkP61jB271/K5hqtosyisK5SRd31m+
	pZtRfsdf10ixCAoP+BQzL7pryMkVySwa5tcmhmNJmme8nTm0X0Ci
X-Gm-Gg: ASbGncsmK5Nr9RvsMnJj4LS52ezkHsp0r4Bu88mWq6yL3UVmDaTsZk5G5uegGrpCOcO
	06fwUAkGuUE24MRRJo8sGna1PrjZvShVIoerq7npQub+4VGBicdGwjNwzmaiw5gV6jRHaAwQ0sj
	uBfuvWmeR9aVxbmJT3/GYZn1M0YXOoxfBmBVDzMdRDwXRn9CSaq+QtZmwz4iSrqv278iIVZIj4D
	ApY+0yRQ/N3lLbpBLmsvV9uPCcaQn4isbZVhuI3F5ia/3vutjKmihpNaxf3x8/iUPMGu+jl
X-Google-Smtp-Source: AGHT+IEUQjRCb5wP0coQL0Ze+rVHd2LuogJmfEzs7X4VpKyruTctN2AzGR5lgleJo1TG8RaXVxtmIw==
X-Received: by 2002:a17:902:e802:b0:212:615f:c1 with SMTP id d9443c01a7336-21c3540a0admr155277545ad.14.1737285581307;
        Sun, 19 Jan 2025 03:19:41 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cfbd01fsm43031415ad.104.2025.01.19.03.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 03:19:41 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 19 Jan 2025 12:19:27 +0100
Subject: [PATCH v3 2/5] pack-write: pass repository to
 `index_pack_lockfile()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250119-kn-the-repo-cleanup-v3-2-a495fce08d71@gmail.com>
References: <20250119-kn-the-repo-cleanup-v3-0-a495fce08d71@gmail.com>
In-Reply-To: <20250119-kn-the-repo-cleanup-v3-0-a495fce08d71@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 toon@iotcl.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3496; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=l/H1BXfgAsAT3JAZNzifnzOj2hY96z0VAYY5k4ZBJcI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeM38RPvK6AeZfgDGNsBAzsNu0zJXfMj5Ecw
 CimO3srrpWRIYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnjN/EAAoJED7VnySO
 Rox/+q0L/R8CsPk79SR39HMNblqNym/DTLN/+mbDKrmy1z+HLNDtJZauxfsif+lsM0OqPBSaIvK
 mJaX/hAyFU7P/crYKT5LPTO1FyoMMJy8rCpbVMlYmANy7VP19X/nJvec4Ik9VuxRl1/U04fGVop
 4I+zZ7gB3OzVTVes3FvzDOYQiwy7gVCMRKSW6Wt2PWWYdT1fxqGA+G12yGQdaWy9+de3BShbUbo
 +1dIJVKgN9xZWRbUTO8UMl1grYRsKfmWrMbqydJKQsrQMarAJ0N/UGuE6fOFoS6lcJQSlVWyy3B
 BKFgH0QbQs9kS3iuUui2768ILwi8q3h6AF10PM6poI6mJUSzczBP4FI9Q2ZSHmQm4CuOGO5IMYm
 VJTxQrBMQTvo5V1zuUMQC47rfNMJlnwUq8/O2IxsWY/c/Su7t+gD6R+yhU+Hg7wou00FgE+0YCz
 s+sc/6x7vbeHeDVf6lsCE6qQxLQtBHrOICHyjm3yjIjlu2Pcg5dfbe+DmnthTiui+UW3/KpSK65
 zw=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `index_pack_lockfile()` function uses the global `the_repository`
variable to access the repository. To avoid global variable usage, pass
the repository from the layers above.

Altough the layers above could have access to the repository internally,
simply pass in `the_repository`. This avoids any compatibility issues
and bubbles up global variable usage to upper layers which can be
eventually resolved.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c | 2 +-
 fetch-pack.c           | 4 +++-
 pack-write.c           | 6 +++---
 pack.h                 | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 56347a79633505efe8dc05acf1583b4c9995eefe..b83abe5d220cefd3707b701409dc5e6b67566599 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2304,7 +2304,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (status)
 			return "index-pack fork failed";
 
-		lockfile = index_pack_lockfile(child.out, NULL);
+		lockfile = index_pack_lockfile(the_repository, child.out, NULL);
 		if (lockfile) {
 			pack_lockfile = register_tempfile(lockfile);
 			free(lockfile);
diff --git a/fetch-pack.c b/fetch-pack.c
index 3a227721ed0935d1f9c40584c57f54043354c032..824f56ecbca11cd9e4da6a3e4c450c6b2e7078ab 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1036,7 +1036,9 @@ static int get_pack(struct fetch_pack_args *args,
 		die(_("fetch-pack: unable to fork off %s"), cmd_name);
 	if (do_keep && (pack_lockfiles || fsck_objects)) {
 		int is_well_formed;
-		char *pack_lockfile = index_pack_lockfile(cmd.out, &is_well_formed);
+		char *pack_lockfile = index_pack_lockfile(the_repository,
+							  cmd.out,
+							  &is_well_formed);
 
 		if (!is_well_formed)
 			die(_("fetch-pack: invalid index-pack output"));
diff --git a/pack-write.c b/pack-write.c
index fc887850dfb9789132b8642733c6472944dbe32d..0cd75d2e55419362a61cf981fc11117ea7a1d88a 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -460,10 +460,10 @@ void fixup_pack_header_footer(const struct git_hash_algo *hash_algo,
 	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
 }
 
-char *index_pack_lockfile(int ip_out, int *is_well_formed)
+char *index_pack_lockfile(struct repository *r, int ip_out, int *is_well_formed)
 {
 	char packname[GIT_MAX_HEXSZ + 6];
-	const int len = the_hash_algo->hexsz + 6;
+	const int len = r->hash_algo->hexsz + 6;
 
 	/*
 	 * The first thing we expect from index-pack's output
@@ -480,7 +480,7 @@ char *index_pack_lockfile(int ip_out, int *is_well_formed)
 		packname[len-1] = 0;
 		if (skip_prefix(packname, "keep\t", &name))
 			return xstrfmt("%s/pack/pack-%s.keep",
-				       repo_get_object_directory(the_repository), name);
+				       repo_get_object_directory(r), name);
 		return NULL;
 	}
 	if (is_well_formed)
diff --git a/pack.h b/pack.h
index 6d9d477adc83e83d9e9175ccf699c100b4c147c6..46d85e5bec787c90af69700fd4b328b1ebf1d606 100644
--- a/pack.h
+++ b/pack.h
@@ -94,7 +94,7 @@ off_t write_pack_header(struct hashfile *f, uint32_t);
 void fixup_pack_header_footer(const struct git_hash_algo *, int,
 			      unsigned char *, const char *, uint32_t,
 			      unsigned char *, off_t);
-char *index_pack_lockfile(int fd, int *is_well_formed);
+char *index_pack_lockfile(struct repository *r, int fd, int *is_well_formed);
 
 struct ref;
 

-- 
2.47.0

