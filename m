Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B012D191F
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457365; cv=none; b=Zhh7jp/hJ/3EZqykJ0JFO2ywpjbK4wqgB4h/LOVVCaFQyM54aVOh5bt4m19kn0y4zlOYJnN1zPsEDCd0O35UHO5b4f66sDyOpO8xTDUIvqnnNRjpzOppQcqcrG8EwzZOcrIm2+MyQA/S29h8nzT8o5rjtSuIH707ybqynGrW894=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457365; c=relaxed/simple;
	bh=WievjsEiKuQ9DD3dDP/ub6fqEJb2OwAOVSAOx2U7Evw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I9AXheyDF8EY1Tghnsu8fqLbFxk7jqrqQUXfq4FX3QpDBAFpl3YJRnRV5SU9r7LK0r/XkkFjdoiqVYFK/EIjKWzn7tCyaLRM8Y3ThNTEVnnIW4jry8vkmJpUe3FDuKMEvHVpU7zL+lOI6Mqv26vLm1eQSISCDAT7Hp0UNZPHqWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQ1PIXaO; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ1PIXaO"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-89737fcb219so293028639f.3
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 05:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758457363; x=1759062163; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEc3rxYDq10oAMd6uJ2BT+X6N3JMt5C6iV97+5f0dkY=;
        b=iQ1PIXaO426zyl8ZLKn8UYAWTDHgYTLI9DELSo7vOPsNq5nvhDj/KrWKQjQO97r6au
         Guew8rW5/CzjvX0MUQmfvCbDrvIpkMVGMzk2UwscAZ9IHMm31atS1ra1fQ1nUVlr76zi
         vy3ubVrQTHNsnVSLRmoLAJEUSgtQ5JLJrkrz4yAfHv0wEWsMRhfF2GNVFkU4xY/rzEGf
         t/U8eH59oAH0fOJEVfL0zBh9/oO0t67wfXYdgHvpLTLQB4U0eIvjLjGnlakeQyntGZEf
         Z4vuiSFKtEcm0gHC6izHMq4ZlDAaBPq9raVvazY8swF1d1JL6+W4kEnPPLoAwzheuFBf
         gK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758457363; x=1759062163;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEc3rxYDq10oAMd6uJ2BT+X6N3JMt5C6iV97+5f0dkY=;
        b=nZRyWcCjghHIrKn0jPsLXgqGCykax1TYWT+MbuIEBl7UK/w97G5/9CpOOhlWFzmZnG
         60TNoVqIgFYB2umpFgZHb5sgyPip1f39dT2AfRWJQvFNGhOecEwAOlX3mXBi0yQSYlcW
         ej8qakmvxZLnVcOWOyXQJkeAMooks3OUkx1OcxU1kgZcj1SULtAmf/fPsIqwD+LTzFHq
         XZp+m/zNYJoN/pR2vKvvvL1/1oLNUjizDeGCTG5PF8piAFtYhwtFkUbx9XBbFnd5GkJ+
         LRwfaMlRTpJq/f+DjHYcFAyMtj6ZdBxUhDXoku7EymwcIjpydUIxZeHzhskYsLxb2tDr
         hWTw==
X-Gm-Message-State: AOJu0Yx/PqikIQynpa0SzdsUucDZVRB6M22qBVuFc1dr0EgB7W7L1TwC
	e9hoHiLmdGCaNWZUiZi1vW4QnoBh30cxwepyXYRWsKL9s7qRDEI0MLhQ6NlxGltH
X-Gm-Gg: ASbGncvj2nnZaiFsSSIKNn13C3ppS1rFH+ilxh6HFWyceyaQan9NDm0jqJXpUjijwRo
	2loHYFJ57wATDMzyErA9q1CTG/zGpkAkd6z2N4fhfu3JVWS5R1KsL1zdFk0m6p+7a1QQlbUYZmh
	jvCeE7rqXQ2E+XHmrQwB3/DHf4T+ixXBtIqf9fadtbyWiwZZIZMuDwlX6/8CJiIlyOAdUOW4VW/
	LB9FZ8xRpxpFD1vW0EcMOoN9FFBeal0hHm9/wYxYLwTXXjH0GUpO2333lFF1OJxU+nMKQxHuyx6
	2vYVTTdFOJrEmYgE3epJZoba8sn+fP7Nn6dxxkcUu3+d2nPvvGLq0+CUsF7LQ1k/h1CLhfWiZKv
	fp5wEogaSuvvWjxUKBOxzpWzG
X-Google-Smtp-Source: AGHT+IH93LedAO7o+DWhX7EU/uRPfBPDM+et3j5qFf5mYPiCvAvpe9ldRXCX1tAN2SZUAFrl8fNLNw==
X-Received: by 2002:a05:6e02:1d8d:b0:423:fb73:315f with SMTP id e9e14a558f8ab-424818f7ff9mr151259175ab.6.1758457363088;
        Sun, 21 Sep 2025 05:22:43 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.35.114])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244a36ad61sm46881805ab.6.2025.09.21.05.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 05:22:41 -0700 (PDT)
Message-Id: <e1d5a85f70c514749304fe87efde271e9ed5a92c.1758457356.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1974.git.1758457356.gitgitgadget@gmail.com>
References: <pull.1974.git.1758457356.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 21 Sep 2025 12:22:35 +0000
Subject: [PATCH 2/3] imap-send: be more careful when casting to `curl_off_t`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When casting a `size_t` to `curl_off_t`, there is a currently uncommon
chance that the value can be cut off (`curl_off_t` is supposed to be
guaranteed to be 64-bit).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 4bd5b8aa0d..26dda7f328 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1721,7 +1721,7 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 		lf_to_crlf(&msgbuf.buf);
 
 		curl_easy_setopt(curl, CURLOPT_INFILESIZE_LARGE,
-				 (curl_off_t)(msgbuf.buf.len-prev_len));
+				 cast_size_t_to_curl_off_t(msgbuf.buf.len-prev_len));
 
 		res = curl_easy_perform(curl);
 
-- 
gitgitgadget

