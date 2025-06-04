Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E449614A4F9
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 03:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749006479; cv=none; b=fXmyovJ291sWyj3t7yfr0KOK4p04EShQAM5HTrPc6Lzb4wdVsAMx8W0D39hg/jhoPotd5665sO86eW8qnd+04X/EYXzbG43dJ8ufNumpYOapu0dPpJdemcs9p2v2WCTfJT6l4Si1HuQJSXrYMwDVbCJxKMkn7ezTrCGcdycSMyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749006479; c=relaxed/simple;
	bh=T6vF9VsW7ObLneOXbBxTSCjuLLaNidFDy7ZLaNMd1WE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=gJpz0VjaWmNn+Xc9dV1csBb9WgPdgkUKNS6CkFFLww/oD/VAaq7Hm8XMEji6Ae/D+NLdnyy+iu8Fe5I5QCLGph0eEJ8hJtEGmtig/RKAAVTONZEMPiliD2axy/DNgkSc8uupoB3HET6tCx3OGK6XOeWAIn0FDRMPiJjZjqTnqII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGhlE8AY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGhlE8AY"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451e24dfe1aso18303045e9.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 20:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749006476; x=1749611276; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W6wxLgjMAW3s/SGM4YjXzdg+VWXAFk8hBs4Dt228P+I=;
        b=QGhlE8AYaNO4ZIkwfAnYIMhmu4gi3oTYquGcYmJKiJReHz6j12SlNi6Ql0rMSEcxRR
         HPREdc26AgJZxnNMygew2SO1cGCTqpnjbL4nK0YC7C8jzc/xDkPHhoD8Ynau5PwfmX+j
         ren+DXJY9T38AmHoCi75Bn4GzZAs3IOPocRbAnVlGN4AXX6uuBSwXCq+YKauLl46CBiy
         jLcAUX5iPepXr1fsp1wG4IFduapFUTtOp/uSmWrPIIGDn8HW2MnhbWGIDL/lDUs46mro
         l7aOjO12SYhD1aSKd+4n9kS5by9Cl2R1FrFkOFuYZ2vevZaBPG/HcGChQxJKpVnTI1QI
         jMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749006476; x=1749611276;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6wxLgjMAW3s/SGM4YjXzdg+VWXAFk8hBs4Dt228P+I=;
        b=nRfZq2kqrJ0MgJ84yf/yGALa5DNG2VExoi8OqN9u2hLEVUvxLQtZ7/+LV8T+xDuWhA
         CvZ1B4Qn2TA8UUBUm0mFiyVpveVf8ntsokkKgf3+hlUkFJOPJj6v927UUHJH9chgp4cv
         Yoru8W6EA3lesHFR22Jye5WpbODlpiEVVJ0olgyd/k2Qu5z7WiAxRh2VAdgpR0fJ+9K6
         PoZWDrf5TRtqYiEZkEHDcGLEFNrD9vJ+MmTi6o/sIA5BswGKbeOrcI81DMB/z0PPllnH
         tYm9a66w8+uGZN2wzlamLjOrhGx0Gf8sp9peFRL8y9NhVdDhoy6JCdk6kGRizHz04ICn
         ayIg==
X-Gm-Message-State: AOJu0YxeuloyFyaySdbBRaXkzCNnNYbSch046aD9j0Ql+dN2X1EbUgzc
	S1Xffwc5tGXsi6NSI/PJf3kXuN5UjrHQt+USyK9NAejTQgqu5Uid0CKnm9A1ew==
X-Gm-Gg: ASbGncvjp750725TYMnIhPaXAV4mQaVfgKEixdlVWHLi0tdPqOH+hmcwnYg3qCAPLzE
	GrzkS/qUnfexx7uw1rDsZsgujofu8fpE/OOl/uIwlcxOl80kWSDwlzYzpCOqH31hdKJhJQABt5P
	uXCbSCJUNl6Smkh8UtjAtCBuWs62im53kBA9oal51RU1FYGuDFloEsPIzLUbM+0IR2GvqF1OqMX
	R1wepGnnl8IiIkkGevzt7kx2bZEbDJG1SZVLESAhL1jp0uNUaxkjQhcE36HX9eBnSzbVCq/9zqP
	UEUlhd26hRdjoNTpgYM5egDpreoRg56dFFemdr4MgdlK6CF+jfyl
X-Google-Smtp-Source: AGHT+IF+PbAf7D8KesS9P7a69aF6pv9Eq0y4uDS7MjKfgbWCCt28haUpNT6nyTMIiEJy59p8Nlwq3w==
X-Received: by 2002:a05:6000:26cf:b0:3a4:d64a:3df0 with SMTP id ffacd0b85a97d-3a51dbb611cmr559899f8f.4.1749006475763;
        Tue, 03 Jun 2025 20:07:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f0097539sm20632524f8f.63.2025.06.03.20.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 20:07:55 -0700 (PDT)
Message-Id: <pull.1990.git.git.1749006474694.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Jun 2025 03:07:54 +0000
Subject: [PATCH] builtin/fetch-pack: cleanup before return error
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In builtin/fetch-pack.c:cmd_fetch_pack(), if finish_connect() failed,
it returns error code without cleanup which cause memory leak. Add
cleanup label before frees in the end of cmd_fetch_pack(), and add
`goto cleanup` if finish_connect() failed.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    builtin/fetch-pack: cleanup before return error
    
    In builtin/fetch-pack.c:cmd_fetch_pack(), if finish_connect() failed, it
    returns error code without cleanup which cause memory leak. Add cleanup
    label before frees in the end of cmd_fetch_pack(), and add goto cleanup
    if finish_connect() failed.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1990%2Fbrandb97%2Ffix-cmd-fetch-pack-leak-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1990/brandb97/fix-cmd-fetch-pack-leak-v1
Pull-Request: https://github.com/git/git/pull/1990

 builtin/fetch-pack.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index d07eec9e555..d9e42bad584 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -274,8 +274,10 @@ int cmd_fetch_pack(int argc,
 	}
 	close(fd[0]);
 	close(fd[1]);
-	if (finish_connect(conn))
-		return 1;
+	if (finish_connect(conn)) {
+		ret = 1;
+		goto cleanup;
+	}
 
 	ret = !fetched_refs;
 
@@ -291,6 +293,7 @@ int cmd_fetch_pack(int argc,
 		printf("%s %s\n",
 		       oid_to_hex(&ref->old_oid), ref->name);
 
+cleanup:
 	for (size_t i = 0; i < nr_sought; i++)
 		free_one_ref(sought_to_free[i]);
 	free(sought_to_free);

base-commit: 7014b55638da979331baf8dc31c4e1d697cf2d67
-- 
gitgitgadget
