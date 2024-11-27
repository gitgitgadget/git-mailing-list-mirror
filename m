Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F8D200BB2
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724938; cv=none; b=PQNfK7khUZ/ljL9Ltfy2lOqH+2qLLANFZHZnQguMq9gP79npVOAjeGrvxbd7014dJibo0z4ZSMgLSF4qm7rdFL5qcs8UAHnEfTNkpuaTWxtZ5Waw+a6VAashGdIHGAEzaQ7bmAgvut3yiVNUeWeeYlxPUhHzUG++G3CxCwScg2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724938; c=relaxed/simple;
	bh=ALtIPsVKuN24FpmdBtyyIxZBuI8AmmwfyzoSJDxXdZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o6iPpVjFKRtFYToSVRas6D9mbz4xFnMeGPo3r3elHx8nWfsCHerJMAfS3t5f/zcC71J6OUofzkwL/IUZn8omZR0zDgNNMkokkP3UXajF3axeRMIUiU0gAJA83kMCSLVajSMnafgog7r0ZZgM33xHZaPlDYeM2e0wVPIkr8GqaC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cztQmisG; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cztQmisG"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffa3e8e917so71939891fa.3
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 08:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732724935; x=1733329735; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+o8hu8d5M0kbQgCi7Axhk0NHXksch1V1MaEESJHbew=;
        b=cztQmisGPx8JNEW4Ijc3v+f2uAGT8VUsqJpK1R7t6HtuUCMb8C1fzuwqHLqnmo4JFJ
         O05oX8dNhv+GXRqoy83aufKjByJYoR+e7O+HwJVgDZxWppQK3ubZhmPrkfrHKShCc9GJ
         4uY/1UhtG1mI5uaBgWPe2FPiTDQQYP7lMW+Oyk86zcqg5fFnOMIpY4nrryORPQN4T8vP
         +PqKoHrq+IwmabaXAnUQKZeUfx1SGUHeQLnOnz3eV+vuT/fyk6ZqRchjbjdWnM/AXn86
         Ir8o2gILr9+cGLyBItnPmKeKLSVB2BAJpRe9vdzwJSjL1TDQkT8MEpG1pij5zk5EWeV7
         1qJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732724935; x=1733329735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+o8hu8d5M0kbQgCi7Axhk0NHXksch1V1MaEESJHbew=;
        b=sqqLC+MvS84bC81zz4CvvLlIaDO9ECr8veRAlO5d3cwlnShvi1AyOsQ/9ZTUZCrmfN
         HqeLCMl2TFTQkcFmenX8JoXRA49mSiwJgYjVlZYvsutviKlfdxfEdZO7kVcusjdYiEqz
         1NzOBFh4EZ6R6lnRbOc31QTk9tdKdi12rJ9Rkqw+5dLxICAgmCKuWHD4d97zvTjOmVj+
         xmboCVnWxHXGopCNml3/xlML4kdDxJatVeiRtxZawq9qLQ8Kpk2E3+ohkzNhe98EZgKJ
         0fME7R1Jp4s/kFMvVZuxzNlbVJN30aRRdJUhl5Y/uneaDXQA5pg49Ge2BlmbeUFCC0DA
         HZOQ==
X-Gm-Message-State: AOJu0Yxj7ujXrex7SjHgu+61Qnl5v10pjx8t5fn3tsuwR3A9RM6CgWBW
	+8PHdMXHbdb3E+14LqQEkLgSGZ6Wg/O9hxAHM5+zUdLoh2oTzJg2
X-Gm-Gg: ASbGncuSxfvyXpvizKy9XT6mCh8NvcQyAqmrukY9gEghzfkjO1gqVdY8FYEcGUD79Ek
	yRarhG8HPZ32LWPDI60PXp63Dvn2fzeBLPSvtSTIJRRHHyIhFZp0PGpDfyFH1iZ2zhoc3m3TjBe
	ZwhUfwBxMJShxsFyS/BqwdXTP972cQ2ENJACpT+qaz/k7DKho6dyLnoQEIt34TOuauC4TWbzP1g
	CWcD5BsWHWmgpMYyr2Bl01H8yGtgV2ncTuU+kBUB2dIjzFwf4mE/+lHXFX2vw==
X-Google-Smtp-Source: AGHT+IErZ9mMnAq0suNqYPgtT2Ol1Vp7jC4DqduFY9b/K5vGYFd14KKwqhHP5f9hf8B3LZFdIU3B9A==
X-Received: by 2002:a05:6512:3a8e:b0:53d:ed21:eeaf with SMTP id 2adb3069b0e04-53df00ff1a7mr2476368e87.44.1732724934878;
        Wed, 27 Nov 2024 08:28:54 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:825d:6a00:5640:4a6:5555:68ae])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa54e15c169sm420042366b.67.2024.11.27.08.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:28:54 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 27 Nov 2024 17:28:33 +0100
Subject: [PATCH v3 8/8] midx: inline the `MIDX_MIN_SIZE` definition
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-8-c5a99f85009b@gmail.com>
References: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
In-Reply-To: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, me@ttaylorr.com, 
 shejialuo@gmail.com, gitster@pobox.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1381; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ALtIPsVKuN24FpmdBtyyIxZBuI8AmmwfyzoSJDxXdZM=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnR0i9ZircOyhzPNu6sztIy4NrzVu3h3h8oUyli
 NmZZ6D/hM6JAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ0dIvQAKCRA+1Z8kjkaM
 f9AzC/90LE8kX/NLbA0YYXCXqZiMR0iXJVH0Q1If2miIKh0ZdSZoGsExFb0XXfb+UTxOK0iI4uZ
 YktHQqOTRyhTDS0emTWaB1senFehoy9lB7yaI4Oa4Bkdtp9Hz+XWO3VmUO1GcQNYr1IyBD6dMph
 PQVLFpx8jxj/qx4NBeJbYXfrT+5xi52BrZMK5mRR4Q03SG62ESGs00UNb95wayA3ibOoozKpX0i
 /EhrKQJe9U/FTCBeQU6rbdiDumVG9vzEWgqtwg99tscsQy+pEqPE6t9q9rRwpRiaWl8bQcGQoJH
 ofitVH/bqAS6Ho+DG4CYM/RQVoU7d6VmY4X160CeY1gvValJ0Su0Ba2xXPZ/nbljPt317KwonbQ
 oWM5O3+KiCWkFutl7fBUgywuem74DvZV+2jHaTVSIRsqg819+LVi7RvkEd+vZ6dqR7gzQNOWWks
 /bL870S5dyuO3iUhWH9b4Vd3GaOTCbbaCEBEEssTzNaMsePe/tMvJQVdCPUiL+EzkkB/g=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `MIDX_MIN_SIZE` definition is used to check the midx_size in
`local_multi_pack_index_one`. This definition relies on the
`the_hash_algo` global variable. Inline this and remove the global
variable usage.

With this, remove `USE_THE_REPOSITORY_VARIABLE` usage from `midx.c`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 midx.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/midx.c b/midx.c
index f45ea842cd6eda23d2eadc9deaae43839aef24c1..e0eae1c25ec91f7db5670ff9bacdf0e195c35795 100644
--- a/midx.c
+++ b/midx.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "config.h"
 #include "dir.h"
@@ -94,8 +92,6 @@ static int midx_read_object_offsets(const unsigned char *chunk_start,
 	return 0;
 }
 
-#define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + the_hash_algo->rawsz)
-
 static struct multi_pack_index *load_multi_pack_index_one(struct repository *r,
 							  const char *object_dir,
 							  const char *midx_name,
@@ -122,7 +118,7 @@ static struct multi_pack_index *load_multi_pack_index_one(struct repository *r,
 
 	midx_size = xsize_t(st.st_size);
 
-	if (midx_size < MIDX_MIN_SIZE) {
+	if (midx_size < (MIDX_HEADER_SIZE + r->hash_algo->rawsz)) {
 		error(_("multi-pack-index file %s is too small"), midx_name);
 		goto cleanup_fail;
 	}

-- 
2.47.1

