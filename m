Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792867845;
	b=D2CHXwF0534G/0To2WE6zOAzW+eZRiT8VFB7tBC7gPPqpZCrQbJsdJ/jEcP77X8cONBQ
	 aA0UQnH3wZyXsY65gmo7eS8t8kGeCrcEcZJp3S5yS+nFhAk+4GXN2LjStkQ1H2i2jd0Se
	 wUojnT/0EdV2oxXD2yxOdVu4DvfgNcEgz2H7ljhrX9SeRb64XbbSkDopJ3sHzkzmHOMCB
	 sgUMDzFTmQK7MM5CIbrdIBwzLHuXJCyWVw5Zbu6ZFI7gHi3KP7LZR6YfUYdoLsicm3nJd
	 06V5oLSikROSkLqQ7KAapMebE6A6ZEZGESl0SaOnr2cYFpEjKerGyU1BIkQ8FC67vAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792867845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=BDpshgSx53KKaQoIrCET1FJMCybRAKGLVTv30ob/Tw4=;
	b=uB4KcD38kof7nrIn3HbW+DymPJSxIzBLRAGiR/ptIht1YWaNGJBQplMw9en5kqLcx2IA
	 rRPTcLkdMgbMWg/NxakzOsH8Lrm8VHDTYprXWM73s0NVqkk2z7hHIGkHyVvpxZ8rfFIiU
	 LlqeY6sqpUz/MUlIOI15ZryDw3aN8bQyvHGbcOyA6IpuJBFpaa18COpyBluUygt5wBbUs
	 sfD7auQSsBRlNJgKvFoWuQvlCqYOQgkqMV5SaB/E45mJ9MKBZPbPGAvwhXtSNLqJlQv/1
	 YkBVzq7XTvwu6jAC4xt9JLCfoiLtPXU2ONyX+GD+oKA3fYRP9DLatQKCuXd6n2LrEug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=theorem.dev;
	spf=pass smtp.mailfrom=theorem.dev;
	dkim=pass header.d=theorem-dev.20251104.gappssmtp.com header.i=@theorem-dev.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=hMhzY9ZK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD52606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 18:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCD52606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theorem.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theorem.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=theorem-dev.20251104.gappssmtp.com header.i=@theorem-dev.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=hMhzY9ZK
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b3dd83e779so3010971a12.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 11:50:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792867843; cv=none;
        d=google.com; s=arc-20260327;
        b=oAHpthRYb55jDYzEhrah6TzgvI94r2mTZkf4pDzgcLqcx5yfeMVrrBAWeZiiEy6JJ9
         oYzqcNrqyJEBk+h/UcroI1aHueXvMQ+SEpKeA29Db75k3L2BCkUgG84S9lYL4mUqbLr7
         dMWeTEa7oUV+IKgEiAxcXQAHcVcsfr6sTq6Ayjj3OoOgRQuXB4H4SM2RRdMtyIJESoIE
         ufjhSsAhJL1lFXlw8dxcCUn+yiEfpewwgiKTVCXFn6gy+b4cGk0QGmNM/hRL6uTnUqh2
         yJ4x80vg0fB/09JzEfhWiKZjgaEFHMN/ytpJ76k1jvGRK8DIwoCnMxeCE1aqEegpwE2t
         7JmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=BDpshgSx53KKaQoIrCET1FJMCybRAKGLVTv30ob/Tw4=;
        fh=IlMV9CQq8DWBqhDig09zJ3PiWmDt6zcudgxfCnKlaR0=;
        b=if3XdZPnHCw4LEmcZoFuCyNFBFQ55tVy7l2ONnWdyf6JIImOH0MbbsqBLDIJwri4YF
         0X8Ux8iGJZ8+ze9J34O1y8Xb+7GQ3fD9P2qcqPDpcS07Dh6U3PSrc9V+c7ilXGnGsjux
         ndiUZQq4Dius495CQZCj9AqhxA/cuTtUX3WQ8jw/6Of5tBbh7M/LTgPmacfb+eE8ZESE
         PdaMQi5WaWreh/MBWZBIdYfwzwtyMYKn3/XeewyKiHeW3yB9ci5qhhWe1P1vKilYxwlH
         4cuJBuoK7ag/VwjbZKXt5qbewCHYFEK7igfSxZiWz9AloyGEQ+H+TfHqnxi7HhpPT1h7
         ma3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theorem-dev.20251104.gappssmtp.com; s=20251104; t=1792867843; x=1793472643; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BDpshgSx53KKaQoIrCET1FJMCybRAKGLVTv30ob/Tw4=;
        b=hMhzY9ZKsjgdxucdmgsZD6j+4QY13qnIuUrHcSTNTm+IqIjLnDTDXGVNA7ovRU0QtT
         KNH2PIsQNYHEAhngKbiRUUKxaqF0cr2t+0L5TOCJaVV1P+3EvuPpSYQ0XNdkfsFYCXX7
         D2DPmATcfcC7ENd3zkUYnB2/wiYYNX+llCMy+7QU1h5EfuAf414kGi/c51ngEqBngj/N
         oqnft2ydxxhdvp5PwWnQfTFrzgw2PVb73Sj2qhaRJNNP1MWV2dxIbZ0nbYSZnHi/D+gm
         gwq55nDUiSeSxb0N1K6X+X9MqgdCcug3mbkwwLyIk9OWYMvLAF61LGFEGD3RZ30tdcAE
         rWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792867843; x=1793472643;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BDpshgSx53KKaQoIrCET1FJMCybRAKGLVTv30ob/Tw4=;
        b=0QF+QBc3RvDjcBwFfN2Mx+DAPIfWrH9Shv9qACwflQAjK124Sik2115xCyMOvMXdP9
         kE/le9uJymggoq1y1AQ36RLXDPyXRlKiqZJOJFU3Bb0r3UbcEP5mGME57IXNvyTmXB73
         4fyrVQ3ti9nqy4JzxePDIrPxQTwxq3D2FXxJGL6WuJt4DgoNvKVWJW5+2LwH+IF7Rmbu
         sBRHZhGElHl5LJFBqhDP+oLV8dv5C3ZWsnMNw6sZomnngdqkCtCR5rDR69MephMuXlK8
         E0nIzSfRmW1YlDb9ZECIedZiOEoFa1YoaIGiAU80le1B/5pjKbk0QMb2tu3YlBpHu5Gv
         981g==
X-Gm-Message-State: AFq9FYJ20Lu8YyzOy1HgODwwUyf80lWZrsDTZpp18Ey4zhkCoAkhGBUt
	F6e16ryx5sWuNsHkZ1ey+kwTRtxb/EYgCRlz1A2QiyAd0ArAfg4yQG0CwOIFmr1bloN8TYfO3Fy
	wVzOlpxgExLQVHbCGjLUTbmpfcIZ2jeCNOYIqfGHJUJuwnjmVZ0JK0yQ=
X-Gm-Gg: AYBFou1CenQaIzO+HeGWyrj1/LrMdCjFk409rhrXmeHVrEtspEzmlSoSFH4LYwG8ilb
	exuiqwNBpXS907ZdDxO7lpAwkk+20EPyGqXH1mvjQtkPjCzZQMiZbP3yvO3H/uOxBxBljkdWVrg
	4UfQ+0MENunc0GE6LHFlmJMgbnOunYVkLkt4Mmu3OBVeecXmzL9ju7Q2Vn+aTkbTA4E4aTfd14i
	sTmUZwAuL+F/8iX5W2E8Ahx8VwwT42CSTZTsBzVQYdv0Q/jke5pRU6QqR3hl75uFoTpM6BfJ0lF
	lhwZpvqk0+HLs3EVoMmY6NVGI89lEwoayM9l5qjXb9dDW/IQy/QxbXbxX+Jp2/8TgwSyU1MXTNU
	0ekxyXFkfyyRgpfXP154jYeRZ8Ngdqh+cqBphGiy/kByP03ZNWP3oqJGFpA==
X-Received: by 2002:a17:906:9c86:b0:c40:dfec:50c6 with SMTP id
 a640c23a62f3a-c46bde12b55mr314764266b.21.1792867843160; Sat, 24 Oct 2026
 11:50:43 -0700 (PDT)
Received: from 410317164191 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 11:50:42 -0700
Received: from 410317164191 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 11:50:42 -0700
From: Sami Jawhar <sami@theorem.dev>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sat, 24 Oct 2026 11:50:42 -0700
X-Gm-Features: AclHuK9fGDQJkhjl6dHJz4IGo9p6ufg9nAm1WF6hwIurg92q_TQeqDocS7VvDUk
Message-ID: <CAOJ8FdeyJp4ZOfp99DBSp4brWzngdqzrkSY36ByEh=4UPw28Mg@mail.gmail.com>
Subject: [PATCH] oss-fuzz: set a gitdir in the commit-graph fuzzer
To: git@vger.kernel.org
Cc: ps@pks.im
Content-Type: text/plain; charset="UTF-8"

Since f1141b4391 (commit-graph: refactor `parse_commit_graph()` to take
a repository, 2025-08-15), parse_commit_graph() calls
prepare_repo_settings().

The fuzzer sets settings.initialized, so that git reads no
configuration. But prepare_repo_settings() checks for a gitdir before
it reads that flag, and the repository of the fuzzer has no gitdir.
Thus each input that passes the header and the three required chunks
stops at

    BUG: repo-settings.c:40: Cannot add settings for uninitialized repository

The fuzzer never reaches the code that reads the optional chunks:
generation data and changed-path Bloom filters.

Set a placeholder gitdir, as test-path-utils does.
prepare_repo_settings() checks only that the gitdir is not NULL. It
then returns, because the fuzzer marks the settings as initialized.
repo_clear() frees the gitdir, and no code opens a file under it.

Signed-off-by: Sami Jawhar <sami@theorem.dev>
---
 oss-fuzz/fuzz-commit-graph.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
index 59bbb84..9a226eb 100644
--- a/oss-fuzz/fuzz-commit-graph.c
+++ b/oss-fuzz/fuzz-commit-graph.c
@@ -20,6 +20,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	 * possible.
 	 */
 	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+	the_repository->gitdir = xstrdup(".git");
 	the_repository->settings.initialized = 1;
 	the_repository->settings.commit_graph_generation_version = 2;
 	the_repository->settings.commit_graph_changed_paths_version = 1;
