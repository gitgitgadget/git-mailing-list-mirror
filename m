Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8D830CD85
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218048; cv=none; b=KajEKm72ZbllqG5S2GPnLidju6e0nxcYZsQiKbnk/bOg7+S7Fx8u9ZGND4C0tC+pzN5p2ATVop7U6yhVBhJCQbbrx8i6/TG1K40+6oNO+1pDkOQ1/Z8guI81Kc5uM1vm38Dm8pX1SBJZk6Ojhb9oZ2XuYxRs+jAlo7/FC6rtj60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218048; c=relaxed/simple;
	bh=ublAlDb+sFV8TWRsPOTPbqdY1jAw2i6QC2sRkK2i3gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDZavvUZd+/cGgShF3RWygUxmWYkeNj1LXnjoocm3IXI7U3Y01IP+qjUYgWipkS5rEvBEm2oakoakgErpuOKx2KTzhHOyytUkEkCEFZC8S6CHdDFQrZ8bVdTCKXTiNRJF8/dUm8QL9AVdGii4oLSmVXd64yeCenY4rIzzD8iFDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQwjYoDb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQwjYoDb"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-471131d6121so5112415e9.1
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 04:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761218043; x=1761822843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYpBnise/6Ip1vtY6yc5ltoCezYlP+lw1b421XNreBU=;
        b=aQwjYoDbmO1Yur/BLRgMmrCqyFGu9OCTjeR4MjFnOSpgX3K1YUko9pxPXduDlsrIX/
         vKpAkB8RCy6Y9ttdXkkJdeJpD3god+fYuA/dcBpp6f11BwxnpQQtylcxTaC72IhACQ5t
         gMRPZLrwNCyelEMEDJgroBcNi56Vm0bQApgD8opS883zvIdNKpf2Iv7KoMZ1YPltjQt1
         4Y92EurOo120DDOcQpX9h2na4Wu9+NkBuR1jZGxCKsjWvAn9UaFk+bPaaW6yj1iIYq8D
         AniS336OC2f4VYjt4U19xg5rJd1nFhAP15RtYZ12DfU4UK+k+/1/0CzVF+ff7JwWObQA
         +Oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218043; x=1761822843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYpBnise/6Ip1vtY6yc5ltoCezYlP+lw1b421XNreBU=;
        b=qiXQyn8kzE25GhD2z0DMTcqXNb5G2j3y6jcev1d1Aa0dh+cwixj+eQWaM2Uqv6CuBi
         m2BIKbJbBqhbOiGXm2nsTP4Flb6XOLA9LFtjSwuXE+UV+CyZYK76PT30g2Q0lMX/lQtl
         Px5r0sjl51ZUuQryBdnss9ZGmOjVv9a0cE2Rib9tVw5O49xdSFFCASaiPP6O4PnB2CbP
         3PzeasyBAoWQHsgAsnIo9xpI7xZoxj7isEllbGmWi2pluFjk2PKmxs/y5odbuxuQR125
         DWzFj+yFbfgQXZcyRLnBzXyVZVlimX5AZ09aB5egqyBLuokESaP3EcOBLivp5jveZUkD
         pG/Q==
X-Gm-Message-State: AOJu0YwuRB0ORhsh3r/9OdYUAdEHEsStOD49Be7p4NjubwgI/y53zi6/
	+5v2ziNlUBU4qXSyzTc4VM6STpUn3cbo6km8MatPMW1SjlNXpyBhNU/k
X-Gm-Gg: ASbGncsSy3xbHIfdjsZdnsFMcw5CTcDItSTE0eFCkiMvZVI3p2TQ7dK3YMeV+qb9s17
	N4v2jrdPIOyOG1kKF3CT1DsnaKp+o73UjzWhxgDCCMwWjH7aUx0UlwLAPwGwTzlLh3d+Q01NEr9
	cKHznwcgV5xqVYj+hx2/BnFJGo9s1Yd/K9NWDGbqgeFcwy9wJppryjg7GDmdroPiz9ZqtJXQuLo
	DqlbxmmCnSKwNSFEfTBZnkeFXUtBihRrWr18v4pH/EK/ahL61euzD1c3kvq/BXhwwVx32X3FTLV
	EUyzRQAPL5FlMEKjIAfQExfiD9LfDIw+ry0tvdQ9Ds4GcVPC3iOL+h50Gd3e22E1sjtBH2H9YH0
	lL1TLWXcpnUpa45mWOt/77a32s1qK3FkbmE6qfaUSOLB+cGtMH9cAZ3uaPFbO7nHJ3d8+9Evvsq
	tauW8=
X-Google-Smtp-Source: AGHT+IGFPOcP8pAQNB9S7D/6CFTMW399Hg93HCuf2Wlsx7q+NZhwN+AfOW2U5+Zi0hTz3DqdrltfXA==
X-Received: by 2002:a05:600c:37cd:b0:46f:d682:3c3d with SMTP id 5b1f17b1804b1-471178774dfmr134316395e9.13.1761218042677;
        Thu, 23 Oct 2025 04:14:02 -0700 (PDT)
Received: from ubuntu ([105.117.6.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428dafesm89079505e9.6.2025.10.23.04.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:14:02 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v6 2/2] gpg-interface: do not use misdesigned strbuf_split*()
Date: Thu, 23 Oct 2025 11:13:47 +0000
Message-ID: <e52855242c8f297f709bb3e5998c25ce9c4f3ac6.1761217100.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.51.0.463.g79cf913ea9
In-Reply-To: <cover.1761217100.git.belkid98@gmail.com>
References: <cover.1761217100.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In get_default_ssh_signing_key(), the default ssh signing key is
retrieved in `key_stdout` buf, which is then split using
strbuf_split_max() into up to two strbufs at a new line and the first
strbuf is returned as a `char *`and not a strbuf.
This makes the function lack the use of strbuf API as no edits are
performed on the split tokens.

Simplify the process of retrieving and returning the desired line by
using strchr() to isolate the line and xmemdupz() to return a copy of the
line. This removes the roundabout way of splitting the string into
strbufs, just to return the line.

Reported-by: Junio Hamano <gitster@pobox.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 gpg-interface.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 917081abac..d1e88da8c1 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -865,12 +865,12 @@ static char *get_default_ssh_signing_key(void)
 	struct child_process ssh_default_key = CHILD_PROCESS_INIT;
 	int ret = -1;
 	struct strbuf key_stdout = STRBUF_INIT, key_stderr = STRBUF_INIT;
-	struct strbuf **keys;
 	char *key_command = NULL;
 	const char **argv;
 	int n;
 	char *default_key = NULL;
 	const char *literal_key = NULL;
+	char *begin, *new_line, *first_line;
 
 	if (!ssh_default_key_command)
 		die(_("either user.signingkey or gpg.ssh.defaultKeyCommand needs to be configured"));
@@ -887,19 +887,24 @@ static char *get_default_ssh_signing_key(void)
 			   &key_stderr, 0);
 
 	if (!ret) {
-		keys = strbuf_split_max(&key_stdout, '\n', 2);
-		if (keys[0] && is_literal_ssh_key(keys[0]->buf, &literal_key)) {
+		begin = key_stdout.buf;
+		new_line = strchr(begin, '\n');
+		if (new_line)
+			first_line = xmemdupz(begin, new_line - begin);
+		else
+			first_line = xstrdup(begin);
+		if (is_literal_ssh_key(first_line, &literal_key)) {
 			/*
 			 * We only use `is_literal_ssh_key` here to check validity
 			 * The prefix will be stripped when the key is used.
 			 */
-			default_key = strbuf_detach(keys[0], NULL);
+			default_key = first_line;
 		} else {
+			free(first_line);
 			warning(_("gpg.ssh.defaultKeyCommand succeeded but returned no keys: %s %s"),
 				key_stderr.buf, key_stdout.buf);
 		}
 
-		strbuf_list_free(keys);
 	} else {
 		warning(_("gpg.ssh.defaultKeyCommand failed: %s %s"),
 			key_stderr.buf, key_stdout.buf);
-- 
2.51.0.463.g79cf913ea9

