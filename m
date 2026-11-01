Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521306;
	b=eRz3Oy5L9OsWZJECPZP2ZcGCKU8LAD6IWufHsbG0e4KHULQBz9SqldS8oP2GW5evAER7
	 tHkemXQ0yOWtUqzF3ns2BA1u6eezPX9jso47PMhzxD3/feSdpwROYGHz9WiyVn8ej/y0i
	 5G88ncT1Sjsmj9mURaWsNLysl9uFqukKORn0qkp5oxLv9pDZ1I76rVyx+mtYRRs/fSLqv
	 5rXCYToqFl/KKsI9NFAB9JsmcynICisdfqPZ4hAzxrJriZH3UuiQZFR2NZv84vIQ4LdpD
	 bVrV3tsCa5VKWHCy1Xnv+FByvFK2Y/uhQWJ87ilxrNBxJYSIP333yQ6KNXBSVPvkqNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=pZTjFhM2hxk9HNhewIoIX8MX5pK0oHnCtTJJPji8Rpw=;
	b=0M7xEoNkXUqymcdBHulnx0DMh0E+BV2+YCERHYxKTuz/sZrEVQ6228Y/sPOShPYgqH5M
	 O1kCRd9h6wENQbn0U6KTrG2di7KqQNjVcfaJjxapUntNEhoq5mFvrSaMEeUJuWRcebZD1
	 c6DsriVcWREt1iGLIOAtRXnDZqeumW/xmNNTnjoBLKUvmcLfpdYh2ji3UtRWYAUFuyQJZ
	 KlVIN1ZZGILPP4hxRxxhQZrheXO7Manok/pYIwHcwjhW/bfN6/YKI7XrzW9jTGnDbE0W3
	 l9+SzCUSxnLhzeRESyOrH1L8yt97owAzwn+MbOpJCjf7uTa+KnWxdeBzT+rWov7Qd4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T2pzoDBF;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDE4606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 08:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DDE4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T2pzoDBF
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53664b4860bso24091371cf.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 01:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793521305; x=1794126105; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pZTjFhM2hxk9HNhewIoIX8MX5pK0oHnCtTJJPji8Rpw=;
        b=T2pzoDBF8uL9v7/raRfPAEbAzTVKzOOMCIemz5Y/VncmjOYfQnqMVL3iiANgKygmP5
         EUc6gQjuQm59SFFS2K7nEElFw1+6lk+w+W0szRHwS2H6biOERpndKBxy+zFWpCIAUclA
         TLFBGL4ZGbhYkqn758JQpCN9TQad1rsqyrJbRJcMYu+mr1RgJJNHmnEMeR+Nl6SHKJ7x
         h+wmW1vDcIomuWyj2RnhCKNwaX/ZrQ/cJN+QbcqM2MiRyflEMO+YVXqlQA3gfLxWtV/k
         Ed3mOdnn8Vim7nFe1P1K70tcaQGjtZWkNxph5c3aOO0Rsaenauci99eBg10evnGZlNTJ
         f4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793521305; x=1794126105;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pZTjFhM2hxk9HNhewIoIX8MX5pK0oHnCtTJJPji8Rpw=;
        b=EJQ2edo3iqDmyT1gSdMar+f1dpBz6tOLNMfqqyc4UFk3lCqExEVpFJE7xVcoGeQ6PQ
         ibitFiLGds81l4BaEVLKG4AcpoBZRIQyFW0d/Pz/C1c6QdD54tO0JV7ZsVUKjCanlqIB
         a+uFZAXKx2w9V+O8x4bTSDM6DXPT7Uq2/JMsG1TFkeWmtiq/4OLXv8pFft+9YeN3oKuw
         kBZcKFW2ATqhRIpMSA3ncMKDpTHhYgj5ocBxSxbbMS2Co96J0yPjjrZM4jRous8ALLHZ
         tLCjSu+OG5D6xBISlAT5NWmmjs1TfIacfI2groIpVZbPb/zkKgoLLELQQeDC1c9WVDDK
         QlWg==
X-Gm-Message-State: AFq9FYK6qoGWBh+7oC28jB/jVYdFneInpGl7ydVc3GjdtTff1GJCF8qX
	cgdFlEDm18MFtYK5zFZlJRie8dv5eMSYNNIX+OM6w83fgFqB9pEAHQPXMKIsnMTvQEk=
X-Gm-Gg: AYBFou1CMLKYdJO/wtevWVkP9OGqYBbMfhngkfMwFsvz2xTUO/zXWXnUx2cE3xGWyr7
	L3KxUsgvlJbnQitWOcbB/LSxGivky4TGizTZqW3T5ZCtB872E1C6YHUOxYlPOpTitVM09L1hWHx
	aVuv4C9WKCPqss9hR44aaGZh7n1n5GTm4O5UP2+4DCFosDFM1X1WWtHJk1ZERzbMNf5TI8MNNuw
	y8lCprP3YGkfGo/6AaRU5KHC/VTz8qLXAEhvuPDCPkIyRrxcodT4R7NHM6Ft/D4Oe3FZCwer2V4
	whmYqS8eGIw7DWELMG/vQIARsPK0Jj5kLsIDkdCnR4wNInEpMOAkRmBfKRdbVSMlUNfFdeQ6Y49
	uPbS7hEMfjY7Rgamv2OS6MphQ+1UXmBvos+VHMDOIRuTUdoLlIdrjg4C8lHZNLfpzYuWKwPpH+7
	iistRBkrlsNfzunaWwhxin2nlhU4btNL62HoroUOEGppQoVYLDIQFH83GG9szXCk9FYeLHm8dgK
	0sW9PJNchD2hAU3Z8l01lDVEgGcD9ygO12GD4B2mfuGtvo4pMew/uIJqqtPMCjGW3mZuwjR5C2w
	GpogourmlIheerbi+OAcseYEgg5xfWcD
X-Received: by 2002:a05:622a:4d08:b0:535:d4d8:eec2 with SMTP id d75a77b69052e-542b405b776mr111840341cf.4.1793521305537;
        Sun, 01 Nov 2026 01:21:45 -0700 (PDT)
Received: from [127.0.0.1] ([20.119.79.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54312b52eacsm56300211cf.26.2026.11.01.01.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:21:44 -0700 (PDT)
Message-Id: <e7d1d7cd72563a8109f94137236cab3d0157d39f.1793521297.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.v5.git.git.1793521297.gitgitgadget@gmail.com>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
	<pull.2456.v5.git.git.1793521297.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 01 Nov 2026 08:21:37 +0000
Subject: [PATCH v5 4/4] imap-send: match header names case insensitively
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
index d7172078c3..1b5850a80e 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1463,11 +1463,11 @@ static bool has_required_headers(const char *line)
 
 	while ((line = strchr(line, '\n')) &&
 	       *++line != '\n' && !starts_with(line, "\r\n")) {
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
index 5e03b350c1..37d21424c9 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2914,4 +2914,19 @@ test_expect_success $PREREQ '--imap-sent-folder stores a copy of the sent patch'
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
