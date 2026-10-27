Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089888;
	b=3ZP5x39dG1hS8JnKuyNl754eYn+OLgnRANUZvgL+4FuuNaV1y/j+001kbhixKh6BvL5k
	 YKq1lPswOTGt0piNf+KY6+7C8A3WjVjOEfalcqjm5tqGQ3Dy1a7sXL/dv+Am4843NQ/hf
	 nA7mjhuTHqIvkojnHJq6+sU3MZSF8IXrhNcwsefPKqecsQgZG3p7KGHzwS9hJ/W5P04Bs
	 InVFlAyWb+Vgt8STJewMfyhyZ5ant5HIyWwf4zyLTvvSh3fOgZ3vGYRg/1ElX1oBWB9B+
	 D2+UaSBvBJsbKKcibd5+OD+cml737ORfsxVKf0yLOpXAfYEfURAsFdjlBrQ6xy5FSrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=jU/nP533VMbrGNpkGuII8mjWHKbkpOrDNt1F8Rz0ilI=;
	b=d+SojCpXBQkYUo3ays19Yp6uqv74j9hsByYh3bBVzmckbnpN3GwGStYP5/BicaZbW3nq
	 6hW/FdbY1hcS26F71lT1tCWmIm5cLpvlrt36nCZ9+DB67inb1ZALqfMgfSiRYeAwCcboZ
	 whseefDfbolyz3rdQMaPAw0VrTYBCDMmf1sDN0Ii6a4B7IEFwz0x/qX2jiWhgdm6l28RF
	 Eud6u7EwwwHk3BjPNxcRjHtWkdsxpQlsxpd3y8PL6FKAEqrAuaN2amR2YGEIZMT/utAed
	 lM5ofPystw8uMHH7Q1vzmCJ7TS/LbliGN+zQBsfR8tYx+hpXZw54iUhWmk9VkSUYtRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HvITHCeP;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99512606A31D
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99512606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HvITHCeP
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so6193983eec.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 01:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793089887; x=1793694687; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jU/nP533VMbrGNpkGuII8mjWHKbkpOrDNt1F8Rz0ilI=;
        b=HvITHCePpHSpKKzLemJo3ZEjk0r3jO607nZFjs1vbblXF6hEovJTzL7Z/M4/gdZ9Gw
         ckjXiVtk+YHE/Nso1H9qKwCPpij/Wxy5YF4bOand5H6LxF8xObOgE/H/gdF7EIgz7M6G
         VECMkUVs0N/0b5xLmHbbw86CsoMoDopjscUwLiEMSgngI8s/SJstggXQUMNUbY8xcNHJ
         mPd8DFVaHGcvuoDGbnlPb54zKJIAniNQW8XEYYe/3ldDe/zTOGnMzzakWp4mDCcTdVUL
         bJ93U+AcnJ3c0ArbvYJKwUCFTa9l8Sn/iFyk8PxnPqoTQ5iLkcpeZnKueS15L2EKV9wa
         NcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793089887; x=1793694687;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jU/nP533VMbrGNpkGuII8mjWHKbkpOrDNt1F8Rz0ilI=;
        b=Dkypc/aWlKjJjTHk4sbq0fRo0O3wo4tKHBzS0mtHsrgHxDZP5R6QMK0uaeXL3fur7G
         OayTK7NwNajQVfP0+YQqKB/26f7v0aW95LU2NK/xCX3dD/v8R0faz7n8fIh/Tz3BThPp
         JSjyv9DKAg0MI6BjQY8v5CRgbtogHDztzA+H1+gIAbu9cBv4drD9k+fhVpsAn6mPpu+b
         /o8p1JiyamSot3Dz2UrbVLkzt3xnF3HKDB7aj/eFlVlQ8aTWn60m83dzoiAel3vPaaKY
         iF/kyQaTUAO23QbJjfzUO1GFXDW2IZyB+Ct8x2/UrxKOSksRNm71a7p7BvO/l9dTk7mt
         Y6tA==
X-Gm-Message-State: AFq9FYJuo8c688mptZrM8k0lA89BjPRoPAXKfbF+6hMKgPEAGCH5EsTM
	wU/ddQqZwBt8GqLpSAS+sPUg1VUakbyj7c0pPYT7vGknE8LWiypNPMMtoJoS+WJd
X-Gm-Gg: AYBFou29k2PcQvQTNAnol81yA8a5P1wZ6V+WmtBCc4Ck4MfWQ/ivY4LnBlBtc2Vd85u
	kX07Bhf5WMCcbxEEVOW/go2jc8gkZW/AiUiJa55AIHI2M9++/EUp37F8ACNPYn+3fM7M97Zgs2D
	9Cd78s94dD6dmGbTpNAU28fepxX9w4vxlyJpyujQMM6Lg6F9G+rMqdJbV7tmq/kog1CMGxdiX3o
	AVzi038atK9Ue1W1Ymwk6XSHEKO8z/49G42POxA5+rLv+wGZSrHCbHrFg3SgJw8l9514MCvulP5
	3wXPx1oiIpC4OJRZ7ygvCleITCW57GBZ6T13sHQpZAqmCINtF4lXLCXW4ivJaZgsU39lfiVfLlw
	dTWq8bwzF9d5UdUtT/pb1hDvZ9XeJyem9ooH/u5qaU9K/ElHxY6j9omhHxxRfyVbLSreVe0su0C
	Pb/mhNt9Dd24JcRREuo/K6rJDzYqNQ62RgPHa1tZ3hYYtNSJ9oPPxJG3qdYhZ7clxsf1EqMqCFe
	LkmxiO3tOkPAF0QC6IqxVXUKamHGkRWOWTUVnCsxp2DegcO8/PS/qIdTQ==
X-Received: by 2002:a05:7301:3a9c:b0:367:50ee:f7e0 with SMTP id 5a478bee46e88-369e86148fcmr12717865eec.39.1793089886409;
        Tue, 27 Oct 2026 01:31:26 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.77.163])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a01fa4c58sm37948476eec.21.2026.10.27.01.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:31:25 -0700 (PDT)
Message-Id: <5b4a08bbdadac95a84f9c865e697584f45bd67af.1793089879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.v4.git.git.1793089879.gitgitgadget@gmail.com>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
	<pull.2456.v4.git.git.1793089879.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 08:31:19 +0000
Subject: [PATCH v4 4/4] imap-send: match header names case insensitively
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

imap-send says "no messages found to send" for a message whose headers
are spelled "from:", "date:" or "subject:", although RFC 5322 treats
header field names as case insensitive. Match the three names in any
case.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 imap-send.c           |  6 +++---
 t/t9001-send-email.sh | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 706c517e51..b8dac92c70 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1462,11 +1462,11 @@ static bool has_required_headers(const char *line)
 	bool from = false, date = false, subject = false;
 
 	while ((line = strchr(line, '\n')) && *++line != '\n') {
-		if (starts_with(line, "From: "))
+		if (istarts_with(line, "From: "))
 			from = true;
-		else if (starts_with(line, "Date: "))
+		else if (istarts_with(line, "Date: "))
 			date = true;
-		else if (starts_with(line, "Subject: "))
+		else if (istarts_with(line, "Subject: "))
 			subject = true;
 	}
 	return from && date && subject;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 1f77c14315..897473e786 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2898,4 +2898,19 @@ test_expect_success $PREREQ '--imap-sent-folder stores a copy of the sent patch'
 	test_grep "(1/1) done" err
 '
 
+test_expect_success $PREREQ 'imap-send matches header names in any case' '
+	test_config imap.tunnel ./fake-imap-server &&
+	cat >lowercase.mbox <<-\EOF &&
+	From mboxrd@z Thu Jan  1 00:00:00 1970
+	from: Example <from@example.com>
+	date: Thu, 1 Jan 1970 00:00:00 +0000
+	subject: [PATCH] lowercase headers
+
+	body
+	EOF
+	git imap-send --folder=INBOX <lowercase.mbox 2>err &&
+	test_grep "^Sending 1 message to INBOX folder" err &&
+	test_grep "(1/1) done" err
+'
+
 test_done
-- 
gitgitgadget
