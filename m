Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316167;
	b=BQeBtHIAllFsjYvSM3cLWRP9X5uEIyd+nHhgWGwr/5H1UGaQV8zQkJ1Q+AqF6X/oeEfa
	 ckODAr0xXMtSlhmfN2UsHuBWJKHvXI3xBJV0dbd2IU7ugCc9OeU4uqRfQFbxx9rmQzAeg
	 ml3Aj1MY//afrelphRNEsAUdrHRm3pqgluXEPVprzPWx2B5hcNiR22zjR+Bm3VV3ocAmb
	 q+7HjxI5zeJvBTnRAvUrO8KPbi+of44sCG3yDLp5awUcPltF5JF/p/xuALgmNF6kdgcOT
	 MPtWLd6ph+myqw/1okvq6CoIzw8F8C0tCpkp11dIhkOLEhH2nqGMijiGdveUYnKdlWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=47/Z9OU9fXJNFo8CAl76rZuuH3pd8VoOkv+ELwsU5Yk=;
	b=DCXp2RhRCBswj2hSZJr0gNbNABJn/h8j+MiCSecv1iThsBEFEKcku1MCRHD46Os2TR3l
	 K+qCvuHBgXmu1ChjH2fJy2BYT2NYBGd4Kczlu54FmCwpAUPo4DG2QEfvzuQg8+pYO4ElV
	 8tXaRDC/ojU36hTmuxjmuMLpbjue886SCTN2zR5bmfuNIXCVSZIeQMfx7V7j7lkAc3Pdj
	 rhKDXpg6w67RZuSf4imZwBTEEVBJlQwSMu39A6aX0i3+0369Tv6H1cLSavG87EI2QpSVN
	 KGCV5XerO5JYFvon+AR1GoBYMEVWTXYNCaf5i373SOXFLl1sCohz7i53aCQhrI57O6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OGnAN3Ao;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB7606A320
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 23:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1FB7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OGnAN3Ao
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-843cf077f10so232413a34.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 16:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793316166; x=1793920966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=47/Z9OU9fXJNFo8CAl76rZuuH3pd8VoOkv+ELwsU5Yk=;
        b=OGnAN3AoP+W7mosjdV8gRPw3oWAcMD2JzeirPpahPdkpT9Wma/z4EGsLLMiHF7BZVA
         /3KYKneM62uyJolJnviApcEMUcrnqGwL2NVFwxEdTEt/9uC8PFwa3XbcNOl4sDfGn89E
         HfPgQvi3+mLzk0aNrBsGztwz0waoka6iBt5CzdEj7MZy4/IOwxlpJ+zabkoo7fnmvj+a
         YQ9SprWnY9Abxho//Py/Q5kYO0/KM7CBZps32ROGuzzmuJGkya9eNenPfWOG7bIqPeow
         zcQgaSQOe96spJlDCoUDsAD3Gt5JNKWcdZ7mGZMaOIXoTHSgmvIUq7ajvt9Gx3lYXGpW
         GcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793316166; x=1793920966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=47/Z9OU9fXJNFo8CAl76rZuuH3pd8VoOkv+ELwsU5Yk=;
        b=FwXwxMcWEhpHL+r4a1AwUbYk5oQg75MTbATDBjaji8SRNBo9lYq+1OEda3aNKdF2/T
         aNoQH1jY5d6eB9Wyga/4e43AUOkYSpMxEj+z+iQeIq6zt17dQALvhGamD4Q8W7DyOldD
         jkEHg/8TsRh3CjU2EulyWcuJHOe+uKmBW8geCiJuSkN/D4BIwT9a2cX8qudbAjzonlsp
         6sBuxFBdScLjY3kUOI8CF9zgARfvod5NsPdAdal8Gjc9VPdLNQfbvdvS/2sHf2IbMmL9
         NB5HfJKeNlhRsT0myp02/D1EJl0e8WGXS4/iiNdQzZp1YcIh+atudrQ3zIlSBc0EY+Ah
         8oNA==
X-Gm-Message-State: AFq9FYJifDgVNrUZuZLtSpm6UgjGIoI7zq06vo0bXVm2UCduAr+qQtJl
	NQppdiiJfNU03zzwsGYH6wVbwF46D1n6xMuwpk15UXS/mxzQ5sAssJMJrVjQhQ==
X-Gm-Gg: AYBFou0UJLCPR7wNSzIYmZyDP/sSWdsa95inKSRnlMhuXpfdRjWkqldRbeRiQoHXyB5
	Y/Y/qduQWUhU8rxSW0ba8akdLVVo6qSHinaVinZ5ZfPQrW7wYI45lnxJYULhQJhhX0D9ZNgVOVp
	yzoh2Y2S9xyRTVcP3fds3V8SC6WUXi2XpFS8FolAEfsMYeGdXUntd1iUgoNI2mEOuSoCKvE4uoC
	sbajc9IQqbhmr5/foqG1f9KgF7lsdHsOTEXyY93W8u7tx65QkbfXZpMzeu5YD6EP0t6iPr195Em
	RB0f61W844fhr1BIhbJIcOQ5K90T1I9WyRXyI81T8fTztKhnNKviVpNRb5ii6uoKdbrk1P7/HDq
	3wx69zD/TZybCq4yemk1frdfbcxBp7OJeuJNlQS21hcY4/XAes1KvTqUrTJkafLeFKHcjpuC+8Y
	wBHeulBpJLz1Ng4hYojXq2Hl0UTGK06KQK+nMlw7ZiEwEipZIZ0hvkB17vB55BIuRSGGtRQCNbO
	x8OvVzz0CxmJKRBokpFqm6wl2q41GHlOw22OwFUcx4OPSf8FlQHBKHU2CkaA00rOQ1iitmiyZBl
	XakOFs+6luP5c/NpU/UwvkixkneZ81I22ui5bRZ0i3ZffludiuoE0ipnfS7HYNtgdG15
X-Received: by 2002:a05:6830:44a0:b0:81f:af5f:84ba with SMTP id 46e09a7af769-85d36533c12mr586360a34.16.1793316165656;
        Thu, 29 Oct 2026 16:22:45 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354d05e0sm694924a34.15.2026.10.29.16.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:22:45 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 1/4] loose: use finite timeout when locking "loose-object-idx" file
Date: Thu, 29 Oct 2026 18:22:17 -0500
Message-ID: <20261029232220.1245827-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261029232220.1245827-1-jltobler@gmail.com>
References: <20261029002413.3291184-1-jltobler@gmail.com>
 <20261029232220.1245827-1-jltobler@gmail.com>
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

Loose object index file writers first attempt to acquire a lock via
`repo_hold_lock_file_for_update_timeout()` and specify a timeout value
of -1. With a negative timeout value, the lock acquisition retries
indefinitely while the lockfile still exists. If a process dies while
holding the lock and leaves a stale lockfile behind, every subsequent
writer of the mapping file hangs forever instead of reporting an error.

Introduce LOOSE_OBJECT_IDX_LOCK_TIMEOUT_MS to set the timeout to 1000ms
and use it for all callers that lock a "loose-object-idx" file. A value
of 1000ms matches the default timeout used for "core.packedRefsTimeout"
and should provide concurrent writers sufficient time to acquire the
lock.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 loose.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/loose.c b/loose.c
index d6a2bb5ba3..c6f4ee0ec6 100644
--- a/loose.c
+++ b/loose.c
@@ -14,6 +14,8 @@
 
 static const char *loose_object_header = "# loose-object-idx\n";
 
+#define LOOSE_OBJECT_IDX_LOCK_TIMEOUT_MS 1000
+
 static inline int should_use_loose_object_map(struct repository *repo)
 {
 	return repo->compat_hash_algo && repo->gitdir;
@@ -137,7 +139,8 @@ int repo_write_loose_object_map(struct repository *repo)
 
 	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
 	fd = repo_hold_lock_file_for_update_timeout(repo, &lock, path.buf,
-						    LOCK_DIE_ON_ERROR, -1);
+						    LOCK_DIE_ON_ERROR,
+						    LOOSE_OBJECT_IDX_LOCK_TIMEOUT_MS);
 	iter = kh_begin(map);
 	if (write_in_full(fd, loose_object_header, strlen(loose_object_header)) < 0)
 		goto errout;
@@ -180,7 +183,8 @@ static int write_one_object(struct odb_source_loose *loose,
 
 	strbuf_addf(&path, "%s/loose-object-idx", loose->base.path);
 	repo_hold_lock_file_for_update_timeout(loose->base.odb->repo, &lock,
-					       path.buf, LOCK_DIE_ON_ERROR, -1);
+					       path.buf, LOCK_DIE_ON_ERROR,
+					       LOOSE_OBJECT_IDX_LOCK_TIMEOUT_MS);
 
 	fd = open(path.buf, O_WRONLY | O_CREAT | O_APPEND, 0666);
 	if (fd < 0)
-- 
2.56.0.173.gf57c9a7388

