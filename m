Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F8F46B8
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 00:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737591373; cv=none; b=P/SF868PvIBZHUZRLpvZ6OC2D/a/H1IzNWEJiZA03guJnL1LJEiSZBTiDrhxk4J9AnVS8S3fTJUikVrY6q8A/LWzqxOGX77vh4jOuGxF89Y11BGzM5LR8UBRHgkyc1/SFlW6HCC7nYgUWCUli1Fb4g97TBeQ09rwrtrsdVqE/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737591373; c=relaxed/simple;
	bh=zjhvasR/+XIxE6NDBmPO7cm6yR7/LtZbDqHMWP7gzyU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=nqYNuFUJWsBBb19P6oHJYycrCW94Bxzj2ab2JVyzWejlzi6mdipcg3QPbmOjH5sECKYODQeFRdXjVfAtb4a8RSK3zcQ8u+rXDWPfMQ0+bB2eM0iorowyaLwhuc6nIos/gwHv59bbRzJwf5CXwCWDk264JG+TqD5ovC4Y/MOvoU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4qUHcCZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4qUHcCZ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso3476315e9.0
        for <git@vger.kernel.org>; Wed, 22 Jan 2025 16:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737591368; x=1738196168; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LfIBtNHl0UPmK18wMAnckwi/ErdryzjMPnWqNWGNt7U=;
        b=f4qUHcCZHf5r/vsMq4buGdKLPrSTNZzD5RhuCNrENPl++fSDXvRZajo8zfB+NiZ9Xx
         k49PREfnsYfuQbGUakDdWz2SQi6YBP0U8hiVuhOm+Yp4q32bmiEgPkTjP4xaBJ8+KL2i
         bzLQiBVhP7VGQqeAhtz3znItEETMHxoQhzV4RbFcRs7x3Yfymqm9fghm7sEcqYn4QMkh
         EhY6A4FN172fzTXczme5AAuL53k5OVt5iiNLQ4YXT5jpSzFRorheTidgGOK7HYCdAMxx
         Ybd422nzY/AtOY6oLiB8igHDhfods1gsrvJBQ7D2+9o32F9CnMJrNhm9zZ8RrlActZD7
         NWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737591368; x=1738196168;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfIBtNHl0UPmK18wMAnckwi/ErdryzjMPnWqNWGNt7U=;
        b=W1Xn5Pj26Xle8O45keOyPBQiD8OjUUmaSMxFyZihpgsCKjZC9wZrtk1WZwttFGM0GH
         CNIhbuokBraw29LSaLS/txZXPLlZfLhKWWGGoPoiV/Zqkh7DXIX8+cmmg+V/2Ow9jgnL
         IJGoMgEVikrB24qyFUjwrkAOb8uWOR6ndG748fUtIWwO1pRVS51kUVe/QhK11tdpENsj
         FfAKgixrVfAM+Z9qI45c2OvLxP4+LwmtNGyOuVvYYNki1mnFJ+63be+DQOXc5hycaZTk
         7EnKdRjzomBPNayhYxUtimQvZEaE7nkmk/P3rDad7b+VzvWEK0K50sDZiKvYSRfZJvGk
         /j3g==
X-Gm-Message-State: AOJu0YwZ2uWCEX9bLe0hLRp8z++kmf0sJM+cVkSXbX/7pi3p2oVknm3p
	dx4Jfyp5nLKCGvjFuS08KlSMRklVz0LeNN5wApr1wm77qfts12rLPtZc4Q==
X-Gm-Gg: ASbGncsVnGQV3ZyBfVfqKgpWY1qapv/cekWrgn5A3z9yAkQ2BvBO9ci5qglnIP1x7Rh
	NtR6fNGxWx8qO4bOYKn5ZbliAKZcR/6geQS4Z6Vv7NJeddZYF5QoXOy74ylBauQvijJY/TQU6eD
	qjEOBYghjwK3a1bFane0wMFWISJOlzz4szt9mXvkhCI+wiv5YAvXc0JmHnyyaTSX6JxC7uonrd1
	+mf0szBsvkIEbNZ7EIdhL4D+CEXpc7/EWEm8L9bxvosx8Pypdlaj1XnCdcdda+ABDp7rBk=
X-Google-Smtp-Source: AGHT+IFH0zf/uCxu4ua/Y6yMLqkBUUwE3Jh1bE05HZaWRI9yRlv7SC/2pGQj9CHN0pMlM7iEtMUFUg==
X-Received: by 2002:a05:600c:1c16:b0:435:32e:8270 with SMTP id 5b1f17b1804b1-438913de562mr232232065e9.14.1737591368026;
        Wed, 22 Jan 2025 16:16:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b319e2e4sm42086605e9.9.2025.01.22.16.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 16:16:07 -0800 (PST)
Message-Id: <pull.1854.git.1737591366672.gitgitgadget@gmail.com>
From: "Andrew Carter via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 23 Jan 2025 00:16:06 +0000
Subject: [PATCH] docs: indicate http.sslCertType and sslKeyType
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
Cc: Andrew Carter <andrew@emailcarter.com>,
    Andrew Carter <andrew@emailcarter.com>

From: Andrew Carter <andrew@emailcarter.com>

These useful config options were added in 0a01d41ee4c but lacked
documentation.

Signed-off-by: Andrew Carter <andrew@emailcarter.com>
---
    document http.sslCertType and sslKeyType

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1854%2Fplentydone%2Fcurl-cert-options-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1854/plentydone/curl-cert-options-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1854

 Documentation/config/http.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index a14371b5c96..cd39e182527 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -216,6 +216,18 @@ http.sslBackend::
 	This option is ignored if cURL lacks support for choosing the SSL
 	backend at runtime.
 
+http.sslCertType::
+	Type of client certificate used when fetching or pushing over HTTPS.
+	(e.g. "PEM", "DER", or "P12"). See also libcurl `CURLOPT_SSLCERTTYPE`
+	Can be overridden by the `GIT_SSL_CERT_TYPE` environment variable.
+
+http.sslKeyType::
+	Type of client private key used when fetching or pushing over HTTPS.
+	(e.g. "PEM", "DER", or "ENG"). Particularly useful when set to "ENG"
+	for authenticating with PKCS#11 tokens. See also libcurl
+	`CURLOPT_SSLCERTTYPE` . Can be overridden by the `GIT_SSL_KEY_TYPE`
+	environment variable.
+
 http.schannelCheckRevoke::
 	Used to enforce or disable certificate revocation checks in cURL
 	when http.sslBackend is set to "schannel". Defaults to `true` if

base-commit: 4e746b1a31f9f0036032b6f94279cf16fb363203
-- 
gitgitgadget
