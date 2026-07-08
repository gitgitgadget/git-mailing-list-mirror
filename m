Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E072642087F
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 03:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783481646; cv=none; b=FZ3+6ii/zbiu1ZEvi5mjEno5O5XS4XWTCqbYjodDxUJCzr0lj1BA/30BL9uaG3FbvCon6pTLsz+w3Ubhq3cwVIWfJ0k7xbbHpxWtHzupOrW0GsbMaCtmqNYdPDrE4I3FnAyEi1kjwimbA8P6x5mbejcmi965NiCc4TZmPEkifRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783481646; c=relaxed/simple;
	bh=p7ACcegywY3Typ95ysXDMi0di/88NNCR3Cx7OvkOVgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jJEFNc4+RJtS39qHMu04Bs3L1pTOy4iEg9nt0/CYZM5+WsCIC63WBGTOzTqZQNQgCIdeEvdOOPIuHDpOyFt/k8awkAYls2G6pAbBmu4Um67Cmodj3K0LT5HeR74DW96UjvSmesyxkzde2wywYF+36q/u6a7soGtTW9Moh/tQanM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=WmzVXU4d; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=Y7YIvsTM; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="WmzVXU4d";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="Y7YIvsTM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1783481638;
	bh=p7ACcegywY3Typ95ysXDMi0di/88NNCR3Cx7OvkOVgc=;
	h=From:Date:Subject:To:Cc:From;
	b=WmzVXU4dxet/EXxF/pO6+eZ1fKInG7ASsz/HN5V+74f/Xl2/Pwiw/XMUYEtxgmUV2
	 fKeCcZEbnVgD5vu+/hktXQz0ode7wEJ0+3Yqm33VTZ+O+biZjHXpyUEhrgbchvqwAM
	 uqXi9dBiYapfgQPUKIUaPo3l0Gel8KVu97i8esJV1xgVD9jlFAzrua8PlRoMYbMyX7
	 U19EA79NUokGl2A0EtlawiQzhJbJZk8OWqsk0iz1Si7z3BWPiyKBZ4dkdnGDQOyuY3
	 Gxb31VH7pu74B3E2J84UBBG8s/Iiui8CAajmLOg/h5fhjMJY9jrI9y7FlLRlS0D6MI
	 gHa/78CMT+cfg==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 4627A2D
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 12:33:58 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=Y7YIvsTM;
	dkim-atps=neutral
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 7A8884CD
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 12:33:57 +0900 (JST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc5faecf01so7356225ad.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 20:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1783481636; x=1784086436; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t84OJGBcqdaWqq5z0Ly5VKP8WNzMC5HnfVigIBAXItY=;
        b=Y7YIvsTM521yV3emEIFXsHe8l3DZ2/WGDfsWoxCcZ6kXSfwpPgkk6Do9ePRnqf6tOe
         c1Ri5TzUSET3FxmUbP4BAk9P/olIBJE14Yssgk6uUFTqW8vqQ941n/546qkzQyoBKhXj
         9NTleRHharE1iKkpd/czlsDXT9Z1+pzR6ZaPY3JSHX+lXilP1/SNFFDOPWdQ/zpN+ddT
         PGI/St4vGBL0tWEEnEiCpjsQSichykBSsVI6SJQGRiiSIedgrEYm2lXZrDM3yb+/sYkS
         wRx6qwxf4ZMUZnertqrXIZt6dDh1frZNXn0mhtS5OfAhGJm3pgArUzZYzupyRqL4BTX/
         GDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783481636; x=1784086436;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t84OJGBcqdaWqq5z0Ly5VKP8WNzMC5HnfVigIBAXItY=;
        b=Z/t/aPfxlIsQOQD139Mavs7JzindjNh3pWDVFAvSOYmTnexeHKIgrJEf2WlhkdrlfC
         8dN8N55xGK13yu+XX2CM5pHVwEUYANamUDz0U6CKSfUQ162vNvg5XxSJac+LLrBWEdcl
         Zt9uwvea+wY/Za/tru+6pC/buBurJlrgU7WwpNpUYyNzMrurukffzeSdpFWd4HuW0a5f
         2sZX3p9cE9BApAPgf+Q7x45PbxRSMLVswN9vxgtWqAyXZEWsIZHJFVKeNi5hFkkk1u2g
         FPTK8S6YwzErF4fsJtkRbhj7X/k29pJNEFF536n1TEfXgPzfKvO3Takp1zYnwJAL3nm1
         bF+Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr6Oan9A349DUg7+A7uRzDOPMjHd3q0BqRa/E8bvCW+u6SukRNNK416YfhLI/YX3LHG/ME=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq/yxQ/m953ozX5yaCO2u5+t4HcuuRl08O1vK9IOqarhwYUf+I
	F5U0AGsY4SXBknjvgSZN768xGNTdkCiw6FQUbhiTndXo+5hql5uR5L0ifjkaRhvg2Qq5wWvQeC0
	aHg0GxeZfKpfCJIE3ye9k6EjMRW4yihQVnn5mfvqucDa9m4eumeH+6pQ=
X-Gm-Gg: AfdE7cmYS33Qms++tjQSsVHRIXd3q7iOEaNBaxNT9vLB49aEb6MxTcYi1aUWn0SCcGD
	QxUDdB4teXTi2nZj/9rrcxb4UqafvsT3h7osCkJde0WPrb6x0HqFpVC/yLS1xrB9sG+QTl5XKXJ
	38+ngIBBaDjotOU9x2H9GpeUj77j6gRjfY8JZxjb2hmlwb/BEUaDhpkWM9Vcl+pQ4DBstv1lkUI
	qvJhlKowJu3ZUbxYF6aSY6RtUExGLd+1mLC6ZvlhRYw17Gjoa6LhO1xKHcSdaIp/Lfhx+QQUqh3
	r/xZPqLU+0hre9jp7COfhBvtMTLz4rcu1QV7iZiqSePjpeojm3gXoQFMHQft3RLtEawjN0BxEns
	7Sa1T7rb/AaBXPY7Bqpv5bg/a50FPjEmZIuHdVk78eEL7+LEYJM9ubClgZ6I=
X-Received: by 2002:a17:90b:3f4d:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-3893fe5b9b7mr719423a91.6.1783481636448;
        Tue, 07 Jul 2026 20:33:56 -0700 (PDT)
X-Received: by 2002:a17:90b:3f4d:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-3893fe5b9b7mr719401a91.6.1783481636011;
        Tue, 07 Jul 2026 20:33:56 -0700 (PDT)
Received: from localhost (sodcd-04p2-40.ppp11.odn.ad.jp. [203.139.65.40])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-387d17e9ff3sm1994865a91.7.2026.07.07.20.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:33:55 -0700 (PDT)
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
Date: Wed, 08 Jul 2026 03:33:42 +0000
Subject: [PATCH] submodule--helper: accept '-i' shorthand for update --init
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-submodule-init-v1-1-719456077262@atmark-techno.com>
X-B4-Tracking: v=1; b=H4sIABXFTWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwML3eLSpNz8lNIcoEReZoluWmKyhalhommKiUWaElBTQVFqWmYF2MD
 oWAgfqCMrNbkEZIpSbS0AN+BLgnIAAAA=
X-Change-ID: 20260708-submodule-init-fac851a5d48f
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Glen Choo <glencbz@gmail.com>, 
 Atharva Raykar <raykar.ath@gmail.com>
Cc: Roy Eldar <royeldar0@gmail.com>, git@vger.kernel.org, 
 Dominique Martinet <dominique.martinet@atmark-techno.com>
X-Mailer: b4 0.16-dev-a9e92
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518;
 i=dominique.martinet@atmark-techno.com; h=from:subject:message-id;
 bh=p7ACcegywY3Typ95ysXDMi0di/88NNCR3Cx7OvkOVgc=;
 b=owEBbQKS/ZANAwAKAfKKYH/WjHEHAcsmYgBqTcUiL9Dbuyh2ndkBQXO82NXer/tjR0TDFklbW
 DAYKRGhgQeJAjMEAAEKAB0WIQQoFSiLMD+txr0veJbyimB/1oxxBwUCak3FIgAKCRDyimB/1oxx
 B7ZXEACbEqiNWLBRfYAfl4l5MyVjCtgqMdr7q+DBDWnO+vjSp6SiexiZj0PSTGBrh9NjlX3IU+D
 VFBDu8zuw+sLRzVyuk+B1v3HbmNw9ag+mEp9kAhC7/977nEua8XDuXyedC6tc7A+PrUNXA2e/XD
 iJWh3Lgw5ofXuSBomMUvkkjl4U1h7UHNiNLMWdwuB/43JucjWrZLB7osB3yUUFPJLx6MJmbcEhH
 O5UBWgqsePo23NWiNnujNrYWpGYmYabIKpk+TNLgz9CYIePN9A3grfZjmuoiuPSK7rB7PpaGNHU
 htjwBs/7J5CSeMe1stFUzDGfHR9hzSkRa01iZPiEj5v2EEJ45aw2/cHuJb7USOHA8g26i/yRIip
 PBEPQbWr07xFiOf1vFC0BPj5QS3kC3FXaceu0PhGXNR9GS4jRJV90u5u9IF6HNidGKKcEE+gfOU
 ftlwezunKQhVaeTri/vOj5UYw/SgKWTMBVd0Cre8x3R1sYkYRS9TuT/XIMhvHcioVdD2jLCY4tL
 C9EGDOOJUsacMZ5KeAldzZ+nnBzftLYNL9Upo5jAi5g3oMwwQIHv/QOSkjE3Upu4/DRqfHJJZRp
 IMFAJV/f9+YtIhPK9+k0hszZFHXKDL0hxT97cgE0yViJ87pRqZOOi+RHFcqEk2g14odOXY8D2aK
 1MLd8UYp4an+HRg==
X-Developer-Key: i=dominique.martinet@atmark-techno.com; a=openpgp;
 fpr=2815288B303FADC6BD2F7896F28A607FD68C7107

commit 3ad0ba722744 ("git-submodule.sh: improve variables readability")
made `git submodules update -i` pass `-i` as is to submodule--helper,
but it fails with `error: unknown switch `i'` because the helper does
not accept the short option.

All other short options supported by git-submodule.sh are properly
handle in the helper, so also add the alias for --init

Fixes: 3ad0ba722744 ("git-submodule.sh: improve variables readability")
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
This apparently can't be used much because it's been broken since v2.49,
and it's not in the help, but I guess we might as well fix this since it
used to work?

Thanks!
---
 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1cc82a134db2..3ec8bf50532e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2990,7 +2990,7 @@ static int module_update(int argc, const char **argv, const char *prefix,
 	struct option module_update_options[] = {
 		OPT__SUPER_PREFIX(&opt.super_prefix),
 		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
-		OPT_BOOL(0, "init", &opt.init,
+		OPT_BOOL('i', "init", &opt.init,
 			 N_("initialize uninitialized submodules before update")),
 		OPT_BOOL(0, "remote", &opt.remote,
 			 N_("use SHA-1 of submodule's remote tracking branch")),

---
base-commit: 11320dd2066f2139870e36987240abc981cb493c


