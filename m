Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B0D38E130
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 23:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382603; cv=none; b=DTUSJK8t+rCaHvSMA6xpYv+Q3rM0y7bdpIF/HXA9D00rN/ygz11Indk3+bhhbUk/J2N/USTxUDgKYfzfBWwwZiPgjAXt2o5Km+VgRmA3HCNYBMYAeQ8V9dJQLmK0iAa6k0F1OwGu/leGH9bWvvcjDlH5cJF1Mb0sJCtJLmdxlzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382603; c=relaxed/simple;
	bh=U7F9ateDqgdPO8aHoR5C3iOlYZmYVzaKVg77a12rfH4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PdRNdoWOvhPpOJ1C4DDKcDvcT+PT/SEXUo82Dphq/Vbr5HSYqYEJZSobTiIfZ6Z1tBMyeX3dCFVpQsDwNJantjB8/EA939sXURIdQX3oFZVkEw9xBrNoIZy0hDfU3tZGDvLE32hXrHsdmFMoMcb9koR/glDdVyB/jkFgCoRrfZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcbSGrEw; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcbSGrEw"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c7212836bso286326c88.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 16:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776382597; x=1776987397; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npC8LbTfQYCEEU1gl/i2Y9GPhI7vdqlqGgWFMYg3XoI=;
        b=NcbSGrEwJ1Gc1Rc01FRGVBClcvHKoYsEZs/s2sedsK9lGK84lC2yNf7zu6tti1HASG
         X+8g+dWp0wSiHRo9Syzm6gMhTLjJdg27BKT+g0qUIfCPWT/XODlwba5U339X2qQnMdEy
         fvjz751GDEo7D+SLdsZ28Zz2xZAN1KBahB0mvJdpyGlWonR9b4er++3vh9ejmDzo10mT
         p9PkFvc896STeCCnlHR7uCc4IVFiphy3oACWQT7F8rPGcDEWupxlSoB4DqrZI2llGhE/
         4ANjg/PA7QJwNsB8o6EN7pBsyZhK7zFsJG3vIyvU4FnYIPpFQeAGi4Fc6sY0Qu1qwxOA
         lQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776382597; x=1776987397;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=npC8LbTfQYCEEU1gl/i2Y9GPhI7vdqlqGgWFMYg3XoI=;
        b=nQnqL0vUPwnFcKVYO+Pngk6Q6/SrpCsflRAYLZaNesq2GOSf+YFSshwAYOY6xAGGx/
         rFXoJWx2qfSUA5O9+hCRhSnKLdieab2rudeedVrG1VObZqvfCDTeL+lI9BFXmlQrgumt
         Ko+zGMxWtUx6JJYsw/u2CoLKFyPfnm4vwWap8shovO4u/viKA8szgOU7gt8+CuYjKDdR
         t+boFaoW5wPhcpwDYukP9pdi8s1FBBGmoL2ZV3U6MZsez8721kJKYKXuLty1aOVSswFy
         c9OZrgrxlWPEd4erO5xhY9WPyqQQFypLKWgyiafNex4tkAWRj2oNKPeoEaXycoUErXde
         /slw==
X-Gm-Message-State: AOJu0Yxv6iNK6VCJBu1YTCIujBu0cM07RptErOyHIelDdLsTG88hfrDD
	MLR2getEi9ThFDP9+VR3wjZtfW2wyJvfiq2FjxpYyRylxaaxmOmZA8vOYjZ8Mg==
X-Gm-Gg: AeBDieu37OQi/gnhQb2SWGiAZQxIErVm3HDcwMhsm42ICeABNRvMfV41m5tAPGlBUpV
	Q6/9LdsnZjW+QF7gBFcPPflnLTDhGFRnWKvpsAJ4eYuvcG90sEx/sg7QweZLbmTi4bXBNVsyXHA
	iMmzHlNPLFo7JbNA1Qibrs1p7A0GyY9g9rLep7ae1STiTSJCg9kAtq702r17sTjnHy9aSn2dtG1
	Ydy4VJ/DO8hkdDG7Am69zm6ylObkaZgBTe77+RV+RX/Ho050jN5nope48dod1WH75sZo45QU32Q
	hClR7o0icjKfpuaQrVu6w5abRv9oRkWvHN796PkvtVzOsBITZAqO1oLqAjeNQ7yb5L1gt7ZDdT7
	hq4dMfwoImjJPILyMpPxyGtJxfXyRCFk2C8cBsHTGTrIJcyfJP8ZWK9e6lTzXDI9fzQiDJopfTA
	zF/pwdboJ/jxTrlWNfMwr3tqObTRAWAkGHcFA=
X-Received: by 2002:a05:7022:50d:b0:121:dea2:d54d with SMTP id a92af1059eb24-12c73f996bemr196092c88.20.1776382597167;
        Thu, 16 Apr 2026 16:36:37 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.51.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e4c434ab95sm197825eec.10.2026.04.16.16.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 16:36:36 -0700 (PDT)
Message-Id: <01c2470fc72f9299e8a2954d99d19010a96fee2b.1776382591.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2092.git.1776382591.gitgitgadget@gmail.com>
References: <pull.2092.git.1776382591.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Apr 2026 23:36:28 +0000
Subject: [PATCH 3/6] doc: fix self-referential config in
 sendemail.smtpSSLClientKey
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

a8215a205141 (send-email: add client certificate options, 2026-03-02)
added documentation for sendemail.smtpSSLClientKey that says it works
"in conjunction with `sendemail.smtpSSLClientKey`" -- referring to
itself.  It appears that `sendemail.smtpSSLClientCert` was the intended
reference; fix it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/sendemail.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/sendemail.adoc b/Documentation/config/sendemail.adoc
index 6560ecc5ab..1d700559b4 100644
--- a/Documentation/config/sendemail.adoc
+++ b/Documentation/config/sendemail.adoc
@@ -22,7 +22,7 @@ sendemail.smtpSSLClientCert::
 sendemail.smtpSSLClientKey::
 	Path to the client private key file that corresponds to the client
 	certificate. To avoid misconfiguration, this configuration must be used
-	in conjunction with `sendemail.smtpSSLClientKey` or the
+	in conjunction with `sendemail.smtpSSLClientCert` or the
 	`--smtp-ssl-client-cert` option. If the client key is included in the
 	client certificate, the choice of private key depends on the format of
 	the certificate. Visit https://metacpan.org/pod/IO::Socket::SSL for more
-- 
gitgitgadget

