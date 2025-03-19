Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E785F290F
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 02:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742349766; cv=none; b=Qc0bYcPcws68AoAORS5CS4idv15hw1qQcdq7xwYsknswHyaXlVjmLZMWY2GQWDpzLdkeHUYumWajoNTGj7zuPFUaLZk88DlKH2EB+O7bdxELI4TWpeRFIpAwXrrVucfNzAMUK2L+/RcznEQHulBNBXc6kQZJmZLpWsgOT4MnPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742349766; c=relaxed/simple;
	bh=q7PL0H7tI1S1p8RzFucmHSB50Y37UxDTW+Az1mLnZt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vr6Ue/wKYQX3aDDZRCcEIQ52LiK7vnOX1cnxkr93sGPWPOrNXb0H/yXMMctGhQHwdzJu6YVKmBYx8rURZUMmIJUUn9AtaGCrXPso01IMten+cLjkPcxnkfA7rfmAa6WLRHVwOWzutWCD/JD541UwqdyVcXCGuHX8lT338ezaN+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cC7SqGN1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cC7SqGN1"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223f4c06e9fso3641445ad.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 19:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742349764; x=1742954564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mOA1YZhOX2eTonvPGr8pvWi++Ajpg7zb3WxIat1feM=;
        b=cC7SqGN1WEzDLZ7kR7HknFnKI4CguZIap65hY6RuE4c+GmiaKtdBaI/6+D7DphVo3W
         DrtXgqMNQS2trNUOJdF8QRtOTK1o39TGR1nqZtbMJoIuup4JEuCiwxgiAaKqzhFpmFdM
         9IxJAWVC7JGoUbCCR32nKpJAdS3eKkPhtg7HYpBppVccOavELTmRTVsJGNy1b0MEoswt
         vK2WPlPck4m8nmAAowizz/2KSbneuUVYPCj6DSzjbFFcbsI0SPIRgs/yuoz2vsv9aczJ
         UtvAVnHH6ljSUK7vEiaEBGUpYWhYw64K2WYy5l+NnUe8HXaZgjwOeISZjZGf3q0nf8Nf
         llkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742349764; x=1742954564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mOA1YZhOX2eTonvPGr8pvWi++Ajpg7zb3WxIat1feM=;
        b=jxhnYz6xJDwOKe6x8lyrekOcwQ+Kn2yVwTyJYFtGPdIXvDaFUqMvtVlN8Rks5TgsIQ
         G3NoVZSAi561ZUqu1hCu2SJGYVfoPy34CDuPvX0XNM4oeFxqJRHwGDmH/kVRBOHz9Oq7
         7OTyCr/j7yxBxI69oQeP96lOkEkvtBk1I63+LgGSxjhl1mOROxqCvYNtL3XWakkU3rTZ
         aCjpwzWImm+boC8aqHqdYLh0MkM77kmxyJnqlKHu20eaevG3VeYK3HtTITbIP7Gf8tm2
         MpBv2U+WqZJBytr4UiKwDIEzx3K2kRXTRlFfZpqSPnV7fvf9AathHm9VukAztj0VInar
         ywmw==
X-Gm-Message-State: AOJu0YyhyXzYYkagxLZEv9GrYRam6sygMzcy8ql+La5PgSwzNKV2F1sn
	PnWaV0bxLMaV3olc1IGjzHJGErD0mh/VTXgbbIZsQob0meu4P/sYe2sLxUcB
X-Gm-Gg: ASbGnctzHNLkcOMRSmPvxbC4oKS2d/w2n6K/igr4QYffCqNThNi9X92jVsOxY5SvCZr
	nejtdNAl2hr5eJfbrmOpo0z95Au97P+Ya9FxqHgVHG3YCkK4Ic4VkBdxxtEIGlbXbxrglVVeETe
	xo9vNizHAR5yV6ttGUmfFbsqfm/yyBgEIIz393FrPB57UzCuu4HSr3CPld0rCOBMFNnxGhXrO51
	2AAtjD+ry99XAu3ZefBOTwE1ebnP5fcCxBNFVjXNCNOfvr8WGbJAwZJNkU0IArwP/E81AIyum7n
	aMU4HR9gCUQO2P7jyiSXSd67+VgrTgz9y9McnA0bZ7MsgLl1jxJL
X-Google-Smtp-Source: AGHT+IExlMyisLc+91lj97p6vRU3eBJyiK/8KiepIx8Jhqx0NZIx7+ql3vMJmnKi64Zs55RvvHslWQ==
X-Received: by 2002:a17:903:2b0e:b0:21f:98fc:8414 with SMTP id d9443c01a7336-2262cc83f46mr91079245ad.26.1742349764086;
        Tue, 18 Mar 2025 19:02:44 -0700 (PDT)
Received: from localhost.localdomain ([39.184.60.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68aa616sm102516965ad.93.2025.03.18.19.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 19:02:43 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: 05zyt30@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v5 2/2] sendemail: finer-grained SMTP error handling
Date: Wed, 19 Mar 2025 10:02:21 +0800
Message-ID: <20250319020221.2160371-3-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319020221.2160371-1-05ZYT30@gmail.com>
References: <20250316050920.3264895-1-05ZYT30@gmail.com>
 <20250319020221.2160371-1-05ZYT30@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Code captured errors but did not process them further.
This treated all failures the same without distinguishing SMTP status.

Add a regex to extract status codes as defined in RFC 5321:

- For 4yz (temporary errors), return 1 and allow retries.
- For 5yz (permanent errors), return 0 as failure.
- For unrecognized codes, treat as permanent errors.
- If no error occurs, return the authentication result.

Signed-off-by: Zheng Yuting <05ZYT30@gmail.com>
---
 git-send-email.perl | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 8feb43e9f7..69ba328653 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1454,9 +1454,30 @@ sub smtp_auth_maybe {
 			$error = $@ || 'Unknown error';
 		};

-		# NOTE: SMTP status code handling will be added in a subsequent commit
-		return $result ? 1 : 0;
-	}
+		# check if an error was captured
+		if ($error) {
+			# parse SMTP status code from error message in:
+			# https://www.rfc-editor.org/rfc/rfc5321.html
+			if ($error =~ /\b(\d{3})\b/) {
+				my $status_code = $1;
+				if ($status_code =~ /^4/) {
+					# 4yz: Transient Negative Completion reply
+					warn "SMTP temporary error (status code $status_code): $error";
+					return 1;
+				} elsif ($status_code =~ /^5/) {
+					# 5yz: Permanent Negative Completion reply
+					warn "SMTP permanent error (status code $status_code): $error";
+					return 0;
+				}
+				# if no recognized status code is found, treat as permanent error
+				warn "SMTP unknown error: $error";
+				return 0;
+			}
+			return $result ? 1 : 0;
+		} else {
+			return $result ? 1 : 0;
+		}
+}

 sub ssl_verify_params {
 	eval {
--
2.48.1
