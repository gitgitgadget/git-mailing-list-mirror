Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521589;
	b=Z1kdJwzxTflAWSQ3N0mrA1Gg8JbwC5ZD2gbNA3629VoBz2MgRhyL4KfyyB5slghOR+tm
	 x0mjhkHwUdNDvqc4pxMqNE3uiKWa5HAkoGyQtwHJxCaFA3oYftFguqOUxSoq50GO/96Fo
	 Ot2FKgXiUQJ/Bjn8fb3KjHhwEuSfG/ciFJ1A3iP9eL6by7yVI/Mk2slVqNGfhM6JXbMhI
	 3prvT6KEiWoH1VIc6yaje3CNYAT7vK8zK1l1ZhTul8VBRLoNjNGiX4Hv9/1Q7DDxRlMgC
	 NG18B7FJQ8xUZcBHXTSdRhhLSCaJGtl0OEijnKfLltzsZIZdUfrkQ7tQnIu1BY9a3uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ujZmZ+nmTyRcTPaOwaZaTUesb9LlxzXphYK0gkqV+h0=;
	b=vaVs7eqC1fKMEHo4J4F2R7hdAqmfjfsdmLfjW1Nul1mG/ERkHb63RzrTG9YY5ObgElxH
	 jlfyIeM78AuwCf4Y4NUw1JeZ9IA3Ig2QpDooTfNsYTbwBtGZjUzVJU7olBaqFZaWakv69
	 DGVqFTKegleVisc5+HvBDNwwJdyA+NL/aq7i9wZdbPrH3R4LsxQ3HKSEp/ulAumuZxcxq
	 806KBVS7k/BthEyr6AD4wz4Is/pGf35R/eoODJEk7LHm2cXsVRI6f5B4837j3/cPb9anv
	 Zug+p2IFrbj1stuMuVPUKGP9Z3gdFNv4bi3Pd6TfbClff9iprEPUyPhshxWmO/+2GJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=or6fQPXz;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD7D606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 18:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AD7D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=or6fQPXz
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so24698005e9.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 11:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792521588; x=1793126388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ujZmZ+nmTyRcTPaOwaZaTUesb9LlxzXphYK0gkqV+h0=;
        b=or6fQPXzzd3tg3+6ajMgUBK33oIlo/AZyjMlgzldque0P4Pb/0pmLZYShh3h8oKyJ8
         3gsHPCG4sxxmF9+nBUGLBOn1r4bhmCHOzbosyO+FR5LaDp/QLwdT6xwfBPxfzmaFjIV+
         l05H6cqbjKl0Kbkt+maz18/XDcs1r7Esx7lrhQdKOAyWA74wudYSHSZQqeF9ZILGzp+E
         RJn9xm0DFpGL51G5foVAMY4C8Mkoj+jVTdCas3WQje7mGpdH1Ym6oJHz8FJ6uRzdZcza
         VrDtQCO4PZHml15zS+gtjoKP0mk/2oAHVVtgx61Gt3toNu7hWqdLZcbu0Xusl+m8dXzC
         FFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792521588; x=1793126388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ujZmZ+nmTyRcTPaOwaZaTUesb9LlxzXphYK0gkqV+h0=;
        b=FDkAVtKZEJEN8r/C0AHM8iwikWnqPy2eXm+zfZ9foyERTRUDWPQpZ3eRMizsSK1RXy
         ed6yQBFCtnMH6bAWxArfXLz3FW3vhf8zAwdpMITzXAD39aMsVfKq5IydbrbkklZE0byc
         as3bPsnDqybk2kVwzS0P8hkok889CW1Np+xqUOi+RBeHoWeipQcQkfSQtDeY5uVMt0iD
         CzD7Z70ysXqtcIZn/WnwxCoy9VO5Kdvl4eZQEYExV9m/qrFkXE4iA1Iyk0V0rJfUEwqC
         9UOxQf6U3J/GJriXcLtbOjCi6Q5mIjX8hat1jmFIJ9+qubUYcKlIGPBmH4nmJ053zRlo
         P12Q==
X-Gm-Message-State: AFq9FYJXFQuWE2SBVI2JXR4D2XZ9Kg3ylx8wzYk0auRpSgKKJKLBaT3Y
	4AVNPBvlQGPG8M2dLWNNDkkBzqIyzd/eyQ9GT19PwEI/XgfVS8vpvTiP
X-Gm-Gg: AYBFou03Sw2f+yH2sAPPsZ7QNidPrHz1ibpvnbiIEz7UnZO3kVO/d3dXot1242ExRnw
	v5mC0k7vFTnDt0QhCtjrkXpXgc79VAE80gJHJpDe+t9Hkfn+c51a620NtMvEgrAKfQ/ldS3+aJR
	lCu2uQUxp3KSKlCJ1VfurekkTlgFBB6BSPRqmO1RuGRjEPvqF86MkA2ImOefQwqlCuinYEZ4MuL
	OvunqH1qDg1807F/JQTpv2xf/xIHp//FYwAS4kqpBcgYhtjyJWMsHi0ha/zK4RzMIl8fnWap/Sd
	tuI8kgz4fqozBv+B/dt5Svthok6Hd3e0wd93xP+x5uezeNEkaKUcek0F0CiN2ncLh+VXzdM/o59
	4ZjRH77ALxXsgc4M38pU6Qrb/1kXYpSHg8po5sQ3C7hdDtKZe/bXawdVIJI/dZs/v6tLbVttSnV
	rdZsDEA0Ue2Iiu2n4VSbTN3KBEEDKptWz86RewDmLql5zdC+NZfR6zNUMepfnfRyQcyG45rl3n3
	hgZernt+cAff1kcFfXwhfXHIiv8n0jQlA==
X-Received: by 2002:a05:600c:4505:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4a1fa27df9emr37730895e9.34.1792521587816;
        Tue, 20 Oct 2026 11:39:47 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fc0aef8fsm6578835e9.0.2026.10.20.11.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:39:47 -0700 (PDT)
From: kerylefondji7@gmail.com
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	Keryle Fondji <kerylefondji7@gmail.com>
Subject: [PATCH v4 1/1] archive-zip: refactor 'path too long' error message to use Q_()
Date: Tue, 20 Oct 2026 19:39:08 +0100
Message-ID: <20261020183908.861-2-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020183908.861-1-kerylefondji7@gmail.com>
References: <xmqqmrs92y4c.fsf@gitster.g>
 <20261020183908.861-1-kerylefondji7@gmail.com>
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
 archive-zip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 6f73ca6d58..5ab3ba786f 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -328,8 +328,10 @@ static int write_zip_entry(struct archiver_args *args,
 	}
 
 	if (pathlen > 0xffff) {
-		return error(_("path too long (%d chars, SHA1: %s): %s"),
-				(int)pathlen, oid_to_hex(oid), path);
+	 return error(Q_("path too long (%d char, SHA1: %s): %s",
+	  "path too long (%d chars, SHA1: %s): %s",
+	 pathlen),
+		(int)pathlen, oid_to_hex(oid), path);
 	}
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
-- 
2.53.0

