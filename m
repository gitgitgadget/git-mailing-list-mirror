Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55D021D58F
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 05:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738733960; cv=none; b=N6HqQL2yaQaJAINF6+faNPrl5tNh75xiydor5Og2C3Cb3kcqp2Pvm7Z0s9cOWR5RZg9c/XbzfADA/wkj4mwhly0BuARef3khKXRVnSpTuvym4yDKJspBuRlel545rvpi+JMFjDxVCa+4KPYD1InAW6LOqoVqyVm4ZcHuvyY1iQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738733960; c=relaxed/simple;
	bh=2nRAqPf0LjPMVHMhbuck/2USexo1pRfX/GomQRnSqKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J/R+NHrzXdyQbtj76YsHZb/PtXnVk77gfq0EaATh9iLVQ3HeKqkLVniteN38mWGTwqX7bSJfJEZ+FaYdQFCMCu5bnCKvUD+/yjcmRJkJ96q+ca4tTszqa6yLmZaAA+ZZturTjLyblICsmeLkTNk0gYXC/OVJLq+cKFNGzgHBBM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=emailcarter.com; spf=none smtp.mailfrom=carter.tools; dkim=pass (2048-bit key) header.d=carter-tools.20230601.gappssmtp.com header.i=@carter-tools.20230601.gappssmtp.com header.b=CWtlAMOa; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=emailcarter.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=carter.tools
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=carter-tools.20230601.gappssmtp.com header.i=@carter-tools.20230601.gappssmtp.com header.b="CWtlAMOa"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5fc0c7b391fso1542552eaf.3
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 21:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=carter-tools.20230601.gappssmtp.com; s=20230601; t=1738733957; x=1739338757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lD5QorgCZVSP3f2EYlQ2BPcAg4IzYtpYSoC/525BQ0Q=;
        b=CWtlAMOauS7XxnQVNJ0RE+8Lie0L0uVmAB9NjR7WDEzrluivFSXI1UUKHhDqAjE7Df
         ezm/xDoSr1AznigyMrndODoz3KYABXn+ROKGQjIImKhwRW5KG99vp9Zl9SHSbTs3Qo/Y
         7EIx8Q7p6KjiI+oHMWrmKptNcDnJMYKFLfOuPJV9RuHgH28aWB955NIQryeCVflckIqy
         lUHEu8FBXRJDeKRKGjDxmj34cwOUL9A4DIX7QVIYiFkXM+hygAl7QzuOXii///z06EJ3
         ksMBiS6UgPySo3exw0QPIMAj6KeK8y7nkUi2/0fh8Tdt5D3aRGiG1bQZqH6nkaqB4yUX
         Q+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738733957; x=1739338757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lD5QorgCZVSP3f2EYlQ2BPcAg4IzYtpYSoC/525BQ0Q=;
        b=KGVurV6Biu/3ZVxfogEPRaKIGCQMFDJmV/cndhG2lRj3rNqjsPmhZNSLh5dAmkJXZI
         ZOmCOmNMePG/gHV2ILmN9wPVK2ijHbTKRVzW0JtA64ZsxN7m5zFSDmrti0k78xJnVWFF
         WXk/kORaL32N9RvMzEGqJvU4Bzh5L4Sp6gn/pEIZ33CPeIWu+UyO2QSwm6k6VYfOGcxm
         n0GUCz1S5231Z1k1avuECPDDpmvDEuJ9UleTlzqQGZVebOwbTCDu08G+aZZjSRSZeXDO
         Sskxj2caJXps8chcdjUArq2V3HCPK8NVnQ1r759qbhwY0vpUAh2/Unn7aeONvWNirsAd
         pyhw==
X-Gm-Message-State: AOJu0Yy9t+pTOoiLI7tuu4pZ6JnnDZ8RyquRLZhbWLjr+O2obC9mAHtk
	lAzf/BniByr2fa8fyxOpcGOtw7zFEP+SUsHaBmunsGus4a517v5bD1hi1d6n2Y2a6g5f7vXPNXI
	/yW9/nV/A
X-Gm-Gg: ASbGncvYBY/FYQVW2cJzFX90Ptx2PGYXTe6vnBpCLxzGjxR5A00EY8rSA/B/EZOfTy5
	uK3Ki6krAAV66SJx6MyIiszMauEGczhZH99O5ClDIIQ6tj7fdya7R62wBj4i3qttkOm47GREbi5
	BppX6zwGHZ/HPH0pk0JDrD7Cs4fvNAFLsd4XkZXE51ZGKtE+JdDmhRQPiNORLppp6axHZ11Njzp
	NsDOg1K9DjDLZ56jrnhERwMrXKfFn/eGV0jSgQN30CANEk7CaYjJm5CFXSBb28OKZHwxe5YFywG
	oAFdYpj/8ixCps7AcZUwWk51YRahnw4hZQ4=
X-Google-Smtp-Source: AGHT+IHE/pukvQ6L1kmWYdbFugU7RK17ZUcXa4E7MOMkNIScgtby5eVD2KqBw7dCEbGf5fUFWpb3Dg==
X-Received: by 2002:a05:6820:618:b0:5f9:b840:6bb0 with SMTP id 006d021491bc7-5fc479d82b7mr1057762eaf.6.1738733956783;
        Tue, 04 Feb 2025 21:39:16 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:a5d6:1800::19af])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc104b31aesm3566947eaf.5.2025.02.04.21.39.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Feb 2025 21:39:15 -0800 (PST)
From: Andrew Carter <andrew@emailcarter.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Andrew Carter <andrew@emailcarter.com>
Subject: [PATCH v2] docs: indicate http.sslCertType and sslKeyType
Date: Tue,  4 Feb 2025 23:38:56 -0600
Message-Id: <20250205053856.72723-1-andrew@emailcarter.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <pull.1854.git.1737591366672.gitgitgadget@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

0a01d41ee4 (http: add support for different sslcert and sslkey types.,
2023-03-20) added useful SSL config options, but did not document them.

Signed-off-by: Andrew Carter <andrew@emailcarter.com>
---
 Documentation/config/http.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index a14371b5c9..22a8803dea 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -216,6 +216,21 @@ http.sslBackend::
 	This option is ignored if cURL lacks support for choosing the SSL
 	backend at runtime.
 
+http.sslCertType::
+	Type of client certificate used when fetching or pushing over HTTPS.
+	"PEM", "DER" are supported when using openssl or gnutls backends. "P12"
+	is supported on "openssl", "schannel", "securetransport", and gnutls 8.11+.
+	See also libcurl `CURLOPT_SSLCERTTYPE`. Can be overridden by the
+	`GIT_SSL_CERT_TYPE` environment variable.
+
+http.sslKeyType::
+	Type of client private key used when fetching or pushing over HTTPS. (e.g.
+	"PEM", "DER", or "ENG"). Only applicable when using "openssl" backend. "DER"
+	is not supported with openssl. Particularly useful when set to "ENG" for
+	authenticating with PKCS#11 tokens, with a PKCS#11 URL in sslCert option.
+	See also libcurl `CURLOPT_SSLKEYTYPE`. Can be overridden by the
+	`GIT_SSL_KEY_TYPE` environment variable.
+
 http.schannelCheckRevoke::
 	Used to enforce or disable certificate revocation checks in cURL
 	when http.sslBackend is set to "schannel". Defaults to `true` if
-- 
2.39.5 (Apple Git-154)

