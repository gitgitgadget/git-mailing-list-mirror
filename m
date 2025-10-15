Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAD3186E40
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760494803; cv=none; b=aNPoV70GsEOhGNx/ahcwcnGWaEnTF27d98Q8G229Mx+VWXoE+Jk4+5RjB0reHqcMCJaTlytnQCrWDxd/IGNbbO4bjaNHDaJQs9VMnLO3vz+y6QTVu+5O9aS/eIbrBz4AjhEXXnOCr145hnUC1do2/YKeuht0Zz2/I44vT8AwcsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760494803; c=relaxed/simple;
	bh=zf/HsrGy1J02SHU1NgkLKTw5eiiGD7oAgz/oD0+g0/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dja2nMXz200yV9tm2E9ZSP4wk3XGRRsM+g2+HMYBmlIt8BJeAMbVdal1WtUaQfp7kAdwm9idMZYIjc2cS8fhyuIp2uWbz2Tsso+jDZGUAuiCs033raMaX+PhgqTjK7D0xuiMaXKDakT3X2EvuX+Y2HFtJiKxNm8WifnUxuhxj3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaEkJ3Cx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaEkJ3Cx"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e504975dbso35767885e9.1
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 19:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760494798; x=1761099598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHAtIW1DOdV9Ug1SoR/NQ+ghrmkRCgAMtkd1XiEeqxY=;
        b=iaEkJ3CxDXcNjcXEf/1q5oHBYew0Z9WGeTR+0l8GR7aDiuvybJQJ7teTbyu9oZTq/V
         UN19hnoFBcgq/T921MvS71akaqVw5JepoUgVrpi0G237LtbZ+0gi5L7NgpM0anGbulht
         Onl87L6PqgtW+mbGgw2vAV7vLVqf8vxQAnxKHQkx2T215XjZ7DaOc+Pjcj87xDSGQSvA
         lkH9fUn1JfSO8VADTlBiqxmVlLv1ALcBLpUrcR6JnhvXmyLBbbMHGPXiod44KQB3DePZ
         0BCTesjM6S0myiOKbg5lJmTjnvRWeQ3smWYnTRBR90VHgCm+CGAGdMrkkbuaBHPM9QW3
         06zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760494798; x=1761099598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHAtIW1DOdV9Ug1SoR/NQ+ghrmkRCgAMtkd1XiEeqxY=;
        b=r9eriyl5278Yvuhl7vw1Ii3aeM3dQ21CS8YoKnxlUMCgBIZizoU0JZvd7Ams9WUcm3
         36ffxhlCyoI0KO2WeU4Fw8cui+9OvyIMfQzKe6tRFOSobZN3V4+tVCB1baXx+ysJvtd9
         tZrqHYfr6dZzDeBYijGPDPveJQKWsiwaZaD0JfeddpFtmvz8nCav734HbRDEqaoh3jTf
         fUBxZZAl/h9LLnczrANB5NVgWpX+eL7wDYXTA/DoV0G+mdu2+kjLvZh7HP4fncexNTjK
         m3cqUUGsMZUDi+x4aUNTDC/5xKtgQhXd8abXSXwL/tjhD2vi3/GT0HJ8cVMsS/bfcTuj
         tnjA==
X-Gm-Message-State: AOJu0YzaspmRmQvlP4q5A3ceMMO5XfOMk1ybAekiaBAzrqX73aFbk2Fo
	9fyaiueeKsB75U8cWdcTxgthfxz5TTy6GeGEs7HH3l1YpZIUdNRnhhOh
X-Gm-Gg: ASbGncv6Iy1Xj5qlkQ5Ekt3z5dDoBSxq6H4TiksdIZa/lAXwFwUSVCdHL7h+6/frDDy
	rTCXvJOuA3in8q+sHVAGVmm07bLxiQReqy+zgU6UwiDoj/cR8vpO3Xt/eof328KNJoeHSc2vt4C
	PH/V42kE2QRzZoBRvQdK1x/gg/iHrP9XLXAJBybhi/AiJUe8gfWxBO0VQdrAxjM9sQixdfZdC+3
	P+LVMsDZBQ+megaLZE1jgCjoYiNwkz0yGshlj6j4JwWp9SfSXpHJQDA+kR8b2c2Te3u+4buzWMP
	HST0zH+IQo8GeCvfTFXCf3MKvMQAXDj3BhBmv539lv5BsPFYFd1UISYI5EZlITeI1FgLGtJZ+cz
	rUbz2FisHiCnKBTWMb0P61leF78iUAx4R+WzOcg==
X-Google-Smtp-Source: AGHT+IFTPmr/5knFy5Y1RZYkh00hW9vKVSSUSQJPwP396G4H8Gjqnpg8PqV1i/9ddZIF9dInxdGukw==
X-Received: by 2002:a05:600c:1e28:b0:45b:47e1:ef6d with SMTP id 5b1f17b1804b1-46fa9b11746mr196624075e9.36.1760494798095;
        Tue, 14 Oct 2025 19:19:58 -0700 (PDT)
Received: from ubuntu ([105.112.225.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582b39sm26042259f8f.15.2025.10.14.19.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 19:19:57 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH 2/2] [Outreachy] gpg-interface: use string_list_split instead of strbuf_split
Date: Wed, 15 Oct 2025 02:19:43 +0000
Message-ID: <d1c20c911637870c3cacfedf763ce508a641710f.1760490943.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.51.0.463.g79cf913ea9
In-Reply-To: <cover.1760490943.git.belkid98@gmail.com>
References: <cover.1760490943.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_default_ssh_signing_key() gets the signing key via the pipe_command and
stores the output in key_stdout.
The output string is then split using strbuf_split_max into two tokens at a
new line and the first token is returned. This makes the function lack the
use of strbuf API as no edits was performed on the split tokens.

Replace strbuf_split_max with string_list_split for simplicity.

Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 gpg-interface.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 043a808577..7a78cbd8b2 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -862,7 +862,7 @@ static char *get_default_ssh_signing_key(void)
 	struct child_process ssh_default_key = CHILD_PROCESS_INIT;
 	int ret = -1;
 	struct strbuf key_stdout = STRBUF_INIT, key_stderr = STRBUF_INIT;
-	struct strbuf **keys;
+	struct string_list keys = STRING_LIST_INIT_DUP;
 	char *key_command = NULL;
 	const char **argv;
 	int n;
@@ -884,19 +884,15 @@ static char *get_default_ssh_signing_key(void)
 			   &key_stderr, 0);
 
 	if (!ret) {
-		keys = strbuf_split_max(&key_stdout, '\n', 2);
-		if (keys[0] && is_literal_ssh_key(keys[0]->buf, &literal_key)) {
-			/*
-			 * We only use `is_literal_ssh_key` here to check validity
-			 * The prefix will be stripped when the key is used.
-			 */
-			default_key = strbuf_detach(keys[0], NULL);
+		if (string_list_split(&keys, key_stdout.buf, "\n", 1) > 0 &&
+			is_literal_ssh_key(keys.items[0].string, &literal_key)) {
+				default_key = xstrdup(keys.items[0].string);
 		} else {
 			warning(_("gpg.ssh.defaultKeyCommand succeeded but returned no keys: %s %s"),
 				key_stderr.buf, key_stdout.buf);
 		}
 
-		strbuf_list_free(keys);
+		string_list_clear(&keys, 0);
 	} else {
 		warning(_("gpg.ssh.defaultKeyCommand failed: %s %s"),
 			key_stderr.buf, key_stdout.buf);
-- 
2.51.0.463.g79cf913ea9

