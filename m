Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423728;
	b=F61z78AbYgXZ3Ohkv0LNruVYGr53lRf6mpwtMMD2Z8qtEv3stbi4L1DtUeSHfBnQli6q
	 UUIfijrNt+x+XCcFszDnDo8eENHPd7N/mFfMZaoCThvAG7Jxtmz20+gToAgOfEv1VEP75
	 G2AjLyS1oT6YwHujV11pDw6TwCl3YeJQgijQRK7n+XTvMq7jEbqnkh+3FqRxFvBjR4+16
	 TG/dD5Xm3HnS0ucrveFYFgIL7mt+UAF1NUndWjL55Whq5A5WNJzE2XqLrONeTYpDuG3XC
	 pA9Ri0h+qXskzUvKmNOvYpMO3iRS8g9+zOtnz81c8BcMCDBfpi+xCsW5QY6sHLepduQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zCKi6xUyD2D4qxGfur84u2/CQj4hAOnXqGAzzrfg+uA=;
	b=HLRsphrNRv161zO7ahuZFMOILLlf3ecxIJQ2uC51ztz5sHfqLY08ONzXnWnp+C8145tU
	 +760UeX3yYQQrpIsK30hEa8KmIXTZwmnXRFY0ZGbeadaYtwv4p2Mugk9WOul6i59CkUrI
	 vjfjpnCFOX/AKCGHYgxS/YSt0ciOKybJrpKGlY4AJZlJwbNtNPJFA0O4FhZqApIA/JiBC
	 QTw9L8enwuUhkARQVVXQ1cQ6I9GgLzOsJU9XVTmJ08P76kNUiBy6nd0hyrAWp78TM4TNF
	 5UkBhz8lYeSzaLyIct7YTipu92XTOJFlEqTHVcQ3hSq1EoB4d7RlyzysVOidwTXiyow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fV7xbC2s;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541C460882BD
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 15:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 541C460882BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fV7xbC2s
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48df54150dfso1738775f8f.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792423726; x=1793028526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zCKi6xUyD2D4qxGfur84u2/CQj4hAOnXqGAzzrfg+uA=;
        b=fV7xbC2sDa5vTh5YLWjfjlirIKF2xspVsxwhOD5mu825ZAjTgiITEjJPfMs90tY0uM
         EG07dw3zFFB/7MSVOt5hEHtayCpXtiFJSwFPAA8HNCG0sKD6+VF7b/ik6FZwJ8M9+aAC
         wIQHMUQk5uqPYCLrX2KsyITEAyTKxYrWTc9N3Y5WC4jDawwI3tIT6j5EiwoMQS6ToYIi
         4P9Tnfk/9cMoLZznwCQT5tCMpmqLGNnd9F34K1rKiN20sshUzRLKr6iJDHDumrBkhzTS
         ZKhoetFEpuQASs9oV7mxGCppr72ZUc03Psce+gdmXEarGTtjgNsF1WA3txtDwh3ed1nz
         37hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792423726; x=1793028526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zCKi6xUyD2D4qxGfur84u2/CQj4hAOnXqGAzzrfg+uA=;
        b=KLm/Vz/MBOU3xVPD5ehR2z1rPOAf2Kh7LsKceMVcY9sSNTaBLmlKPI+4HJdKBphUuQ
         QR9vjxVTnJIFJCiJYTOd686jNuOfHTCB7IIX3NrGKch/9/b+p14jsFyHBk6gbDQN6USc
         aZoKxpPSEF6ecwL2gnnN4SQP/jzDICD/zIO0lrfaG8MzoQHKOZqdSVGWpIypGJTNr8m4
         zIVu48jYZQuZlzMKIU7PU3+vqjA2D0sFroqtYrmJd/LZ5kpwb1PlayKKUEa/4KppnX2G
         2SHuWR4vwzDI/y1orUTtMUYIcDbNBgghi/jEqlKVSdQxdZxyHOr6cawAMN1QeXJ51Kvi
         Bysg==
X-Gm-Message-State: AFq9FYLGTLVv9JZy7Rf8Ez7nVcHFCTbFJRheqT3KyyR5d/PK4wKBhFNn
	3/10jqDMuK73Z1rk78u3rLGlPUbA3vA2SKTjKDAYKkIlydj8SVDyS0KbAmY+1hzb
X-Gm-Gg: AYBFou0ZjadiB2ByL30g3Rq74tTtKpHTSoePBurFcsRc4/FhZJlg2ddSFKht9g9w6/r
	Ylhbt26NRCQ/enUJh/rto5DB/r+OVpnhYbK2KeIlWcGw+XuVSs6I06lYS2Y9z3Gfr083745cgzI
	UyefpGUMuiwL4devh8NzYbaupDHXETF15M11Y5ti00UFC8wfQ+iI+cjdIGPkNrYLLfAh03K+PWG
	VMOZMc/8KChvbwXneXEHQur5Hj8BSbW+GNRFhsMo1xAiKw8wmRY68STq0Zq73auothQj3g6kBo+
	OJofvCv4WkDh+yjSDMnbTqpW9YhGbp0YPo7OBIsXF307zDY0CJNYxhGFTddJpR3V5+eTvZQbj/6
	x4zp5PkoE2nTcDctQ+1pAk6aq8NWxyFfjRVQzJP9i+lH7pGNFQSrQ9EzJlRZV3CfB7wO44mGSwr
	QOTRiaDYw4Sed1jekGii+NpoZCHEM/TjIpXpxk6+bMtMtqtbb1r/Zmh0mZdAiN1EzALgbZa6HeT
	GIATchxngUsFE6bSXn0JLhYMRwHMaCumw==
X-Received: by 2002:a05:6000:2287:b0:487:40d:af29 with SMTP id ffacd0b85a97d-48e07bc4aa7mr17275617f8f.36.1792423726194;
        Mon, 19 Oct 2026 08:28:46 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8bb6sm25560521f8f.34.2026.10.19.08.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 08:28:44 -0700 (PDT)
From: kerylefondji7@gmail.com
To: git@vger.kernel.org
Cc: phillipwood123@gmail.com,
	gitster@pobox.com,
	christiancouder@gmail.com,
	siddharthasthana31@gmail.com,
	Keryle Fondji <kerylefondji7@gmail.com>
Subject: [PATCH v2] archive-zip: refactor 'path too long' error message to use Q_()
Date: Mon, 19 Oct 2026 16:27:24 +0100
Message-ID: <20261019152725.714-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1a15474a4114ba8b>
References: <1a15474a4114ba8b>
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

From: Keryle Fondji <kerylefondji7@gmail.com>

Replace _() with Q_() in the 'path too long' error message. Although
pathlen is always greater than 0xffff when this error is hit, Q_() is
required to support correct translation for languages that require
different plural forms depending on the count.

Signed-off-by: Keryle Fondji <kerylefondji7@gmail.com>
---
 archive-zip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/archive-zip.c b/archive-zip.c
index 6f73ca6d58..e4f8ef5a36 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -328,7 +328,7 @@ static int write_zip_entry(struct archiver_args *args,
 	}
 
 	if (pathlen > 0xffff) {
-		return error(_("path too long (%d chars, SHA1: %s): %s"),
+		return error(Q_("path too long (%d char, SHA1: %s): %s", "path too long (%d chars, SHA1: %s): %s", pathlen),
 				(int)pathlen, oid_to_hex(oid), path);
 	}
 
-- 
2.53.0

