Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4908271470
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271499; cv=none; b=qXe6c0nXJR79qjIW+sE+NSlo+EH7eDoBFjhTMdbXXZ6IKjQS0zAMI6Gz/FAZnrccBG8/LwMc6M2PjeV7bj1HLqPJDwMEHS4L+On7R+xPlczWFd+tHg4d/LJbvrtzsUTuWJke1JO5ZD3Ed9id7qc5GChrLXYWZxpJIPKoZvxTSyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271499; c=relaxed/simple;
	bh=xTosYBig1aZH4jRVZXg1eVX4F2DYEn4VC1JYora4Y5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OdfWAXDSXuj+AoNf76AC7WiDIv7pZ9zhh0na4UKHUapQgulMGdOoFOiuW2B5cBZFiE0Xuvc7CO1d/7c5oiJiAH1mBuGpU3wxZHwwTkXPohXAJHqkToYQ7zyhmxxui7NvC3YiMT8EppIQtO7AFrraxk51nZxefvt4HtemTDxDYkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g31zJeLi; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g31zJeLi"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-475db4ad7e4so22364075e9.3
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 07:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762271496; x=1762876296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IMIHrAXL2ylBfcPTfYsPcsixqf7W6b7YPrTAoD8zeYo=;
        b=g31zJeLiWz6fZHrER2mEIDbmh3XshJcme2OnQ0OySHLHI+KWjuyAvzXjeP3lBMcVsL
         IFsnFrEv3Jk9k50y8GKf40VXdbBuLKcnbBnI4AP5ydyowQtIaujocbrCUOmPCS2jnhsk
         Yu0d+VnoMd2/V3BUozf6+VyfEsafmK70DXgXl9VT37YXXV4tuG5Hd4g8y/3K8/3ITjZP
         90RTDIkinUpllS2qnmO1a6MBn1/rGA/ujMMKtJgVZFUvwHU08ksI10QQrYBoq1XetV0k
         p2lszkZ+1gpxM4+nXisQCYArO3dBfrJweugSLqHGWnJsGdEs5PfYYxjujHMHIYLVFe1b
         PRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762271496; x=1762876296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMIHrAXL2ylBfcPTfYsPcsixqf7W6b7YPrTAoD8zeYo=;
        b=ehigZ/bxAChyMFCr3nAT93IP4k0fgWX24b3Rn5EoY2uXXUWiUBCoQvc2KFzpXIxmJV
         sJipgWxBntByGl4vFN7XmVy/XVvDn1iy0qx/MYhfRCceQeUlG99o/Kj+k22He0mA//r2
         bKuXdVDgC76Twg2bR8B7XRJx3oguV54oZvXNiQt7sH4FiUiMUGANrc7Q7+DZ9uJcYFqU
         +6WLr2QS84u32oT0G8UEw/FVcFNTBsSi5ugMRua4BiIF54EscCUo/JdVtMAE8VXOHHFt
         U35pQY8OWmH87sG9JN9VwFczhRB8gJvN0B43NWZI8wb7ytEtN0gCKwz+nCH1JUGqOyh8
         OntQ==
X-Gm-Message-State: AOJu0YzX/dYHx2C64q1GBMI2grOFeESS65TkiKYC7daoSMMCAswF6XOB
	9grCAXWzAGrTDxIpYMVqp9WCRIJXsHqAOeYsTztOGiit3+sDrmhaWy465YpkWePn
X-Gm-Gg: ASbGncvVlB+QcxEgeVlUog0w3lWwM3CjE6dHQIv76q8WyTfS1ojMg0mAfMdWTX/FD+z
	ZEWDSlb519NiQ9bG3AWYU+obUvIGakIpaqW+EgEsoV0+t9JYk1z4t82rMTDwsNdDkL7HBrBSkxk
	oylqV5Uqz4R/RRGBSu74kE43fNzwGPsMpJaVYH7f29KeRFN3/VD0J0MQ4UL8KACpaixI/Gy0j1d
	TQTijBiwZqfCF+gSxMYE2G2Sq/1eBXRwLqntU1oe/I6wBeU2KEuKLCOiud/bFSIbkdq+7dJxD8U
	OQOCj6VUdNl98AlYV8Qqlxz/vCunBkeH5/xIcolM/edYVHVqK0rmCzL/NUsrWYeB7nUAQb/35nk
	bfAWg/pcB7Dey8kQQn0v9FUJBvLzYNAM1LP8raKB7LG8Dcv4DuzBmWsYLbH4c/OWA7WQusjc26v
	ChC/Z5uz0DHRv9ixB58pDDsoT/wQ==
X-Google-Smtp-Source: AGHT+IEiGVg1xwMFROuDh1MVexXqyTvKW+pSnvv0WoWYC4KTdkl0JBarRrKROzc6grFkC52OUuJOjw==
X-Received: by 2002:a05:600c:8b32:b0:46e:37af:f90e with SMTP id 5b1f17b1804b1-4773bfd5c53mr134351085e9.6.1762271495828;
        Tue, 04 Nov 2025 07:51:35 -0800 (PST)
Received: from QueenJ-PC ([105.113.64.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47755932134sm20158045e9.14.2025.11.04.07.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 07:51:35 -0800 (PST)
From: Queen Ediri Jessa <qjessa662@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi@gmail.com.com,
	Queen Ediri Jessa <qjessa662@gmail.com>
Subject: [PATCH v3] doc: clarify server behavior for invalid 'want' lines in HTTP protocol
Date: Tue,  4 Nov 2025 16:51:27 +0100
Message-ID: <20251104155127.1079-1-qjessa662@gmail.com>
X-Mailer: git-send-email 2.51.0.573.gb660e2dcb9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update the documentation to clearly describe how the server responds when a
client sends an invalid or malformed `want` line during the HTTP protocol
exchange. This improves understanding of Git’s behavior when handling
incorrect object requests and helps developers detect and handle such
protocol issues accurately.

Signed-off-by: Queen Ediri Jessa <qjessa662@gmail.com>

---

Changes since v1:
- Rephrased the explanation to be more concise and aligned with reviewer
  feedback.
- Clarified that the server includes the offending object name in its error
  message.
- Adjusted tone to describe the expected behavior rather than prescribing
  implementation-specific messages.
- Improved readability and technical consistency of the section.

 Documentation/gitprotocol-http.adoc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitprotocol-http.adoc b/Documentation/gitprotocol-http.adoc
index d024010414..f3f48d3f35 100644
--- a/Documentation/gitprotocol-http.adoc
+++ b/Documentation/gitprotocol-http.adoc
@@ -443,7 +443,10 @@ If no "want" objects are received, send an error:
 TODO: Define error if no "want" lines are requested.
 
 If any "want" object is not reachable, send an error:
-TODO: Define error if an invalid "want" is requested.
+When a Git server receives an invalid or malformed `want` line, it
+responds with an error message that includes the offending object name.
+This clarifies the expected behavior for Git implementations and helps
+clients detect protocol issues accurately during fetch operations.
 
 Create an empty list, `s_common`.
 
-- 
2.51.0.573.gb660e2dcb9

