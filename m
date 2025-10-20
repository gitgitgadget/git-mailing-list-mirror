Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344CF334C23
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 22:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761001007; cv=none; b=Hsqu5yKVbY5zPhxGlftdCiEhjN6W+w0Ta3Nwm4etdZ2OJqB8paP9Rga8lrYZXgrwT5/Dznh+NL2ExDFVCGldHVWKM4MzLCSCdoFms1PdXYQL5EIQrJnfXDK00ZGgBYCutza3113/bcNwMZHVwqgWlPBSQSxDnsh/V19aofbOTlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761001007; c=relaxed/simple;
	bh=WhdSopeNqTv7QIO8Uybr+qHzEDtzqa1TBAI9G2YcM9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9Urii/WM2gcYQql5ZP2+nO5ng3xWJUsrspHfEET2DE3m9HpCZdyKp5ffp8AlTe67EAjql2r18lHEIATqfCguchIbQF5qm4JQJJYAz3RXJPNEWjWKxftN6ylWxMZxAU7OL1HFeFMLkdfIHXEiZ0vKY7yXEOjr2kGMi04yb8kN8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRLDEOnA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRLDEOnA"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46b303f755aso51395265e9.1
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 15:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761001003; x=1761605803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzu9r3Y89bzZZS5CR7KB/VrvNrEwnVYuw/owydMsuKg=;
        b=gRLDEOnAZlSwhu/mm9d4teZ/4grHewZFCYG4s8FHWyGDZHA7E3UrCPsMRD0MdNTtVh
         WCD+4l7yWFt0BvC1Kaj3Va5Yqqul7cQ3QKaNgj1GZDM9Fvbxw96HyHoLe/sYTN79w3SQ
         CzowYp0Y7kOt6eUXdZjRXg5Ca377S0dRtZON9EWw83KjmkXxLgAkV1dMZGKah5Nm83MF
         oFClbyVZ8jILkg59vpuhU0prO9ji6YNWgJC0oQthTIPZRcP2s9/zpxSeF6TwW9y2Wotv
         UFKuODzrDTq796tx9Y5S+HH3yzGZxqRIPW3+LqHPlgzWtVKsd7loR23zLSU88ZN7CNAT
         tmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761001003; x=1761605803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzu9r3Y89bzZZS5CR7KB/VrvNrEwnVYuw/owydMsuKg=;
        b=KBTFxaytTGbgO4JJk7IgM3md7k0hydrUNI1tYBSa8a0MBRtFrQSI6P4UjiqpszdKcJ
         fqYi5qf/qm8d9FAYZlUjBeKQaHkRXWcVGLhq2Y0SQg45K+LSzIRKqwf/hnA3ijeFabGB
         oWoZmc8EjHJAOvgXbXXh9VW6WoyoGUMWTVlM3YuLalWmJiz9m7+qIehjI8QgjVwHDBGF
         B30jLtl6q+1mDpQHpmUOoF5AGY3dw1XV87az/OTLGJ7glldctPFFyObq8ofp8vTzG9at
         GYVgkRceaMS9V5EFqACTdm4jhd87hhTx+Q9THkrF6os4CIAIJMFYQC6chYuPIlUb/vYx
         tVxw==
X-Gm-Message-State: AOJu0YxLm994VAi6P6VpmGrxsfqizAqoWUCcEg7/QFIoaMgJdeELEDRC
	X7j0MIiHPLRiSzO8dw44wnx6927oFEGGyyWQ3M/FO1uZOCLAXVZOkK/+
X-Gm-Gg: ASbGncvfigtEsWLUPpYgLXOC2bQhONAf6PaQSl+GA8EJzr4jwih9Jgb/9zA8ztdCkDM
	yUeMyrfLQeXJYv8Vp7yG/lNte+wrEXkRrR0nIRDyZ1awoSEGRBXMHBvmn3ck3arLadvz9rLQk3q
	3bQ28xxJc7O74E5+qo9dkgkLKnq2gsXizfe+ktenr89zFJ+uQeoxYd7U5HHcVKXeicBXjeV61G4
	akJh/4oVcQhX2p5LOq9iNNyQSXYVb1zGV8s2MjMNXkBRaey79AxDltguQPryCetXf48/+8MEoge
	yjkfcmLgy2CVnJwa9O1Mop8b+fZkaw/MoG/Ci8ORZWHlyFE6g77RXtMepNJGqUnEEjoIxgcFDiJ
	d6ShW+Beu/W+lcvSuxv1dC/+FDG8iPjpkqBLMKU9IMwdziOTX7H/LbOU=
X-Google-Smtp-Source: AGHT+IHtsIXzCNIKWyCkMA/uzexm5qVxfyeCW5kJX9f19Qwu+XQ+uqayvFE/XsQQshTsKwoDaRDWMQ==
X-Received: by 2002:a05:600c:548c:b0:46d:5189:3583 with SMTP id 5b1f17b1804b1-471177bad0dmr102946535e9.0.1761001003400;
        Mon, 20 Oct 2025 15:56:43 -0700 (PDT)
Received: from ubuntu ([105.117.8.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3acfsm17178044f8f.14.2025.10.20.15.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:56:42 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v4 1/2] gpg-interface: do not use misdesigned strbuf_split*()
Date: Mon, 20 Oct 2025 22:55:20 +0000
Message-ID: <2879d9be3659a9c1ea554fff7814507caae24b65.1760997183.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.51.0.463.g79cf913ea9
In-Reply-To: <cover.1760997183.git.belkid98@gmail.com>
References: <cover.1760997183.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In get_ssh_finger_print(), the output of the `ssh-keygen` command is
put into `fingerprint_stdout` strbuf.

The string in fingerprint_stdout is then split into up to 3 strbufs using
strbuf_split_max(), however they are not modified after the split thereby
not making use of the strbuf API as the fingerprint token is merely
returned as a char * and not a strbuf, hence they do not need to be
strbufs.

Simplify the process of retrieving and returning the desired token by
using strchr() to isolate the token and xmemdupz() to return a copy of the
token.
This removes the roundabout way of splitting the string into strbufs, just
to return the token.

Reported-by: Junio Hamano <gitster@pobox.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Junio Hamano <gitster@pobox.com>
Helped-by: Krisoffer Haughsbakk
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 gpg-interface.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 2f4f0e32cb..1d793a56d2 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -821,8 +821,7 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
 	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
 	int ret = -1;
 	struct strbuf fingerprint_stdout = STRBUF_INIT;
-	struct strbuf **fingerprint;
-	char *fingerprint_ret;
+	char *fingerprint_ret, *begin, *delim;
 	const char *literal_key = NULL;
 
 	/*
@@ -845,13 +844,17 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
 		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
 			  signing_key);
 
-	fingerprint = strbuf_split_max(&fingerprint_stdout, ' ', 3);
-	if (!fingerprint[1])
-		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
+	begin = fingerprint_stdout.buf;
+	delim = strchr(fingerprint_stdout.buf, ' ');
+	if (!delim)
+		die_errno(_("failed to get the ssh fingerprint for key %s"),
 			  signing_key);
-
-	fingerprint_ret = strbuf_detach(fingerprint[1], NULL);
-	strbuf_list_free(fingerprint);
+	begin = delim + 1;
+	delim = strchr(begin, ' ');
+	if (!delim)
+	    die_errno(_("failed to get the ssh fingerprint for key %s"),
+			  signing_key);
+	fingerprint_ret = xmemdupz(begin, delim - begin);
 	strbuf_release(&fingerprint_stdout);
 	return fingerprint_ret;
 }
-- 
2.51.0.463.g79cf913ea9

