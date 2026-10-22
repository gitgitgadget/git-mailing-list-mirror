Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652192;
	b=vjWq2tEHkJwSfpjPZ3UP40Jlvpf41AABnepNrjULfUyHd1iZuBPBFkT4svW6a+XEuOVt
	 glKEDDubIncyAGAtqcneXdagEHPshoiL4+/tx7oJABs4DMTcas3cUlcYmQZX+CSiZxVaH
	 R/FYz2raLM4cNSMH+nHjmp/bsCUoG/T2eqexxL8g861o5IXK4VGnw1xGAoThXVos+fwKG
	 0pK1eviVcuQIwhxKjmbr1ttG68FQkANEJcEmAbAGsU58Pehsd/SvsnLA+mPu6TCkvB0Kv
	 YA+KSTDVODTgbapBUpR60aFbS9AqVSzhj7iGcHHjD/5WnTPPCj6HgxZNgbFxcDIqy/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=RdGeeypAr3MGPD+Sd08JBsuxF71OmSpfDJjTm8fnlSg=;
	b=JbhP7Pm/Tln7mENtGHs1mJu7VAgZUIJd1z/KTYSd17xGYYOUGbPTXu0HmU3eoMQEB4UW
	 fN4xe3rL+q0TtMcO4BQMc4qiiXBEVdznKoPDdeWt4To9JG+yOH+PtMdj5F/CBDJXkSN6w
	 bYPICCl5GOh8TCn24L875bXxnLopig8sAhUTB1W6MrhBVC7Dle15I5bEop39EaSpj9vqm
	 lRUBciTuyeUfW+m10CDoptnkYrAoJq/6obFZMhNzw0S7FrFxQnh44buzbWXXUoXdpw4D2
	 HteyIN+ymicilVSSHfZXBO+2wbcdbMdyIYvSjemB6QRxw0noUNiRXNnTkY4o8juUzHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WsoPICnA;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4B9606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 06:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B4B9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WsoPICnA
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f20b304c0so177980285a.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 23:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792652191; x=1793256991; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RdGeeypAr3MGPD+Sd08JBsuxF71OmSpfDJjTm8fnlSg=;
        b=WsoPICnAeOphmWundjG96UpYlMe33oXXKCwFzD5CLAxSXXZRkhICY2AJmtGVcV2aJf
         OQ5luT4IipB6BevHQZW7z0oKodjwvQjshdU4jupFuYMEHMDdlvx7qeNZmlxswv0v/RDQ
         qUzpncP8dYRwbhKivNkLc70oxGSG5d26mtYsXCOibrAkDh+SR7w3du45srpartlDk+yO
         WkHe04BgY3ZIYvrmT+sEcvwEVR8td1R9xnLVr1gy/bkfeIAWsXOP0sjbMHwKUrmMJ7mS
         nIy1V76E6H/Oanwo1keONsMb8RW35TpUuUBy2OXaeOGEsC+Vp9gpzQa0ZBQxFoWk24cg
         5A3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792652191; x=1793256991;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RdGeeypAr3MGPD+Sd08JBsuxF71OmSpfDJjTm8fnlSg=;
        b=appc1Apyg2i6jqqU5wOh9RcJlk1gx0wyGuaLPsqP1/s3zOmpQ4YzOHK3EsTljloyXg
         T+6wCP+IzUaH8s1CJ4vXzxBk43MeYn/VWS/tnctoM+dF19UF5FiCQyDqyX7YzRLfOLaz
         zoVulzeHoK2hPZsXhan+9lk9xrUeJzr1+NkgsfQHqfTFpSRCB69U2Wq/Zqxk32AEGztP
         whhIyAZXY+l0R5c+NYWzb4tkxRmjYR/soaEziRWL+QXTNo8OlgpZ9cUpMfJrVax4EUxc
         Cg0JEDTn3ErRB74R1sBSVxhnbIHr7zcORBeRZLHznEXFbfmMMIMZvoTl7X80aK5aS2jx
         OQyw==
X-Gm-Message-State: AFq9FYICljXGxtauTM9zfVpmTIJww9h2TlRjTcvz/pOtn5m+03B7x1sk
	jNDnlHztDBCHguw6JaiVFvMN1KjepMZ81wjNY4EUSCaJ63uU+3kSrJzHgl0heV0r
X-Gm-Gg: AYBFou1ab1AsxrhgIb6eBTRDY3+Y4j0O4CVfB0wqV2naJ8u5Pnwf+bQ4kz51JqXxy7E
	30CSZsDzOCMIcRB/1k1Z226xHSq8SCvZNENb1+QmGNM05cBoGxN89szWrAMD860lhvHPmZyz6Or
	Gcxj7GzaixtMFULTqfnrb+gubKlU3dJCnLT9Pm5NHLzMrfU7elFCCw9blvwJet6WR5uzlcP33MC
	99F4HPA+iYu4exef6Liqqhd0yYx7T5AINoP/uXy9t0ntSKMF20qNETdUzCIzT8bV53YAPRxLYR9
	vz8qMTrl59NvaafGTKqN5lItFkQ5L7YZphYy6157KCjYpg6tFbE6LX6mIse1iLxMju352nN9B+l
	nBmglmrF3xuUyZtR1HQGgpjD0B2E1f0/oz4EKXAeKu6HV7beilJkSA12C34TUyax2LQoeNj/q3k
	XZEqCoDxlFtWRa7D7PdUzkon9ad4NeCb3tYawwtyr08w2i+Wx/jruHAi/Pb1RHZJsIY/hvNyfNn
	9tKjBm7rFun1km3GdX8afCyXI4BdiB2Qk7lhFSDUOkNpEdn93UlXqt4Wx0=
X-Received: by 2002:a05:620a:44d5:b0:93e:4dd3:bbb1 with SMTP id af79cd13be357-93f57f05931mr820343385a.19.1792652191213;
        Wed, 21 Oct 2026 23:56:31 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.173.122])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56c6f15asm444220785a.6.2026.10.21.23.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 23:56:30 -0700 (PDT)
Message-Id: <01add80af28d6a23e44a1d3149e2c2a875c00c84.1792652185.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.v3.git.git.1792652185.gitgitgadget@gmail.com>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
	<pull.2456.v3.git.git.1792652185.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Oct 2026 06:56:25 +0000
Subject: [PATCH v3 4/4] imap-send: match header names case insensitively
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
 imap-send.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 1091825dfb..21e20d7720 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1461,11 +1461,11 @@ static bool has_required_headers(const char *line)
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
-- 
gitgitgadget
