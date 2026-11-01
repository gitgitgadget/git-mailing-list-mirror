Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793524771;
	b=roWzYNwuwtXehNMw9eL4FNnXXTYZi60jaKeYnxVLI8gQF360qzuiDPd9dQzCD//MNYrq
	 SorSkyl5xB0CDkYpDQT/lm1ql9sxCi9mwzwiWq7Ow+H1LpZj1nxcLUUMe0sCPbXxEYxBt
	 XKta77ff4OrhRElw3ma2Pr+DALtYCUaCDs3qQ7RsrtMn8U0QzuHr+Fu1bq77/RTvpBfgS
	 6ONHNM8LqshQN1vjESHRv5NTt8nn5wLF+S9GQj89EIzfWW4rgwIdmSVR5NeDs9BoF6oEA
	 BGIRPo1v6BRQ2L1R2v5WSH5MKKRi1ISA1l/5ch7HLdcN0iofys7PRcel077BpCgQe/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793524771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Tf+7LDm0ihjWav7y82Lc2wWffdOEEVCcDXfkaIM9n3k=;
	b=ai+zSkulChkRg0pv8VV9S8qiUn9vau4e9msA8tOwPvKAsptcI+djchw+edaueQyLGvUK
	 O5MFDkaLqbURQmohx6XImMiMYVMsW4eRn/aYtkGvIprx045613UwdcST+yJVCssnCAcdB
	 XiH8FcfZG0ooZQsSLQUcG2rKhn+QxtM40kHPYjJR9CQH94084oCPIgMqti4aXvkyMtRi3
	 errdGABwv1U215w67/VQwub9aUtoBhDbk8j2NaFUtfFJ0uwiscRLDmxIlB1uBGD/+LY2o
	 qU6T3uNfO3qLrxz1tZeb4Iv3GrEecVpCnNwgJ8/S1D1Zj516+s0lHqtdoMUdtf9Wy4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UH63SA2A;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362A606A334
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 09:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C362A606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UH63SA2A
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a4dc547987so10304875e9.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 01:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793524769; x=1794129569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tf+7LDm0ihjWav7y82Lc2wWffdOEEVCcDXfkaIM9n3k=;
        b=UH63SA2AxkS7lQRNsQbVwxlRKfx90SAjJlH3ObTcX8l+KGl960br62RcLS+W/xa8dx
         JnEeQX+331pO4r9+tYQNi0CVK9f9g1b9elSoekYACZ/kIWOC4B9fvDkPhTaAwC7khvSZ
         Co7hIn6RUAbnUrAt8w6UOUUJlRagwLZkQRZgSHCHCDs1uOz3NWFuxcka146k47yZoZj0
         /3zF8CHiGUFMzj9WvMRQYFN6cpQQtEwuN4y+4OtzUsBOH1C1COy8AeV8GDttRZB/D2rc
         zzx98slOsPZcSKXh9CucnHAUa5rMw3Z+1FChhPNSz1kEIzk3onYRTl7cwqJLsitGMBLC
         vsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793524769; x=1794129569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tf+7LDm0ihjWav7y82Lc2wWffdOEEVCcDXfkaIM9n3k=;
        b=sw8t0CT8LuzMCAgRROL5C3G9WNQWfYlN1xW2EAAl1irxWt+g89dT5gam3bhVam1Jns
         oPuI6CUzrrdTxSUiGL2IH7TizsGyX7AHl1/JxryovREdJS+nZ1ehjRCFyI2A3j/jGxPW
         WTFKrZM3UJWK4ak4xAcB6mqaV4zzBd9BVWbomsaDfgpRR7nTpjMK94aEqK90og4iPLU6
         kE193v9YKciQQiO0nIYx0ehJY2HwydYQpL1Gq2OWHfWPIP4QbBU/UuuoLmRoGcFI2SEU
         +G64VsKBRtZ5duP3mLNVY8M1uClcii9mExq9GvKxcnJXFlaE77AoOEHYmMgofHrxTunJ
         9OQA==
X-Gm-Message-State: AFq9FYLll3CIs7kWX2J5HaZL/WlDtzxAkp01rUrXBqlfHGMtwLPPDRF2
	SNFjhLXi/FswxZY6szQUCdofQGkqx8sJZCZNfvllJgb0al0CJfyOWriBUG92ghYu
X-Gm-Gg: AYBFou3wMvcP94Ca7bdARDIeInt9HeAWF0/v+FyZBYreu5bFyyJR1BhUxBJPV8H3Kpz
	JWsJ+n3uDYlaUfqO2hrdsBWm/+rm8rKztngyyY4f9ceqfPShetDF9a4NsKS8Pm6ntQrZ4TSECXC
	eSH5ZWVVb2PZtBtbEtpany8qSY7L96XvmRtvU98KKuJwBGPrWbQ8brFOwDUA9pc18602KbVRGsL
	8XwgbRS+j3/VFucStn0exGv+rfSZZwn539J5ZKe+tC+cHslSsujDEQldZiHKKOxuzqy8PiYhZps
	uCMxRtuFENtVt+HZZZmV6ddn1P0Qoiq+V+IuGG9rYVRgeP0WvRPmbgm8vRPeXhTli8K+Domuves
	x5dX8AkjYrnVb3YzzB4wIX7M/cvqLoCKaaE/cGJm1VcyM0morq8SF2aebRmI5msuIqFeadxtDaO
	12KFKdgwadBLaAJOsF4fjanzTIs3bBbkVAlgjgdJs766ycxp9c725Q/uWQOBVa+GWwPnZM8sTO7
	hAUv9hQm0na0OdfZqCERY+HWD+Znn8UfcOxNCBokxDIOVNLKyVGOyFF1yQiw2L0KnSK/70sDA6/
	j7RBz5iUHfh6uiLFDnMyL4ZQ72aYMlOWNWEXJkJ3jSfSxNgsZyga/5GoF6nrJG8=
X-Received: by 2002:a05:600c:3f06:b0:4a1:e672:5721 with SMTP id 5b1f17b1804b1-4ac181e75c2mr160473545e9.13.1793524769030;
        Sun, 01 Nov 2026 01:19:29 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8011csm14859390f8f.31.2026.11.01.01.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:19:28 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 2/2] apply: use size_t for the size of the result written out
Date: Sun,  1 Nov 2026 10:19:23 +0100
Message-ID: <6446c73595b4d2d9360a25f816b5d42ee66b5393.1793524457.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793524457.git.gitter.spiros@gmail.com>
References: <cover.1793524457.git.gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While "git apply" limits the patch size, the result size is stored as
size_t but passed to functions using "unsigned long size".

On platforms where "long" is 32 bits but size_t is 64 bits, such as
64-bit Windows, applying a patch to a file of 4GiB or more causes the
result to be written out truncated with exit 0, silently losing data;
this also affects "git am" and "git apply --index", which writes the
truncated content to the index.

This was verified using a 16-bit simulation, where "git apply" left
a 7901-line file truncated to 2859 lines.

Use size_t in create_file(), create_one_file(), try_create_file(), and
add_index_file(). add_index_file() passes the size on to
odb_write_object(), which takes a size_t with the "use size_t for a few
more object and buffer sizes" series.

Triggering this requires processing a file of 4GiB or more on a platform
where "long" is 32 bits but size_t is 64 bits, so no test is added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 apply.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index a0b7119c63..02d6791ad7 100644
--- a/apply.c
+++ b/apply.c
@@ -4458,7 +4458,7 @@ static int add_index_file(struct apply_state *state,
 			  const char *path,
 			  unsigned mode,
 			  void *buf,
-			  unsigned long size)
+			  size_t size)
 {
 	struct stat st;
 	struct cache_entry *ce;
@@ -4513,7 +4513,7 @@ static int add_index_file(struct apply_state *state,
  */
 static int try_create_file(struct apply_state *state, const char *path,
 			   unsigned int mode, const char *buf,
-			   unsigned long size)
+			   size_t size)
 {
 	int fd, res;
 	struct strbuf nbuf = STRBUF_INIT;
@@ -4564,7 +4564,7 @@ static int create_one_file(struct apply_state *state,
 			   char *path,
 			   unsigned mode,
 			   const char *buf,
-			   unsigned long size)
+			   size_t size)
 {
 	char *newpath = NULL;
 	int res;
@@ -4686,7 +4686,7 @@ static int create_file(struct apply_state *state, struct patch *patch)
 {
 	char *path = patch->new_name;
 	unsigned mode = patch->new_mode;
-	unsigned long size = patch->resultsize;
+	size_t size = patch->resultsize;
 	char *buf = patch->result;
 
 	if (!mode)
-- 
2.53.0

