Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADF3331237
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771257220; cv=none; b=f8lE5ZUpfN+JNnK7GL3FPb5GF2NX4hB0ZMGvdj0G5xuX/vyXpYk37DzmqjymawLGkAdgClmXGO7Kewf9xrROn5HFx31vvhkez/09TlzFFq0XTWDk7PlzaTKptLYryHtn6KMRqEgk2ShhnUJicXU8dIhBdvUpj7aIOvcdpv9Kvcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771257220; c=relaxed/simple;
	bh=ndr3xHkqBez4kwxy2WSQ4O1om0sSEiT0h6WNvdJMcPY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eWCeDdcdIFKN30P0JkGHPPeE3pCu0PY852HzvwAt15Bg/suoj9afBPalcisZFeadd0zVpbjkZqXbt877/zqgpIAQJSS3mU3dODlANCneH49aeRArJvVGZ0dFpFg0meYPChqoeF90aNHrN97Ra77Byu5yqeCn5c/S7nt9eSBGUZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRX/X2Qk; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRX/X2Qk"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb3bae8d3eso351731585a.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 07:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771257218; x=1771862018; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9rI8igKX+WZoEeKkUIonFKMmUgzHFdeD4LVEzLlsbU=;
        b=gRX/X2Qk4rrXNH8D+21M8ftrxsZoJz513B+bqG3H+yFs4BEm1tJRLnk+n7sCJ67/dP
         tTDXRreNQAH1c/mZ9SmVJcmsJI1bn+7AVVR25QaFhDF98W8NFSudoic3dV7FLCTCoYgC
         ktrAqSr7Zo3aaGuMchjO7hyLFJqE6MHhj/61A7fXaG2N+kMTGTPOV/SQ000jkOQe13Qr
         Q/nBTdJL+hPD3IfPqrc/DQU3zr1wzEBP9rg0Vdh9/g9d2MVDZLUhuFV1XYYGJ2n1vKzy
         eEWYn8xyW8p93xjjoshUHjNa/0MFpq6VzaLNGpIVQju1jvwUEDkJcV5JILDms3EBILeG
         AbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771257218; x=1771862018;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n9rI8igKX+WZoEeKkUIonFKMmUgzHFdeD4LVEzLlsbU=;
        b=W8G28ekLjbeTQPC1Yd/YALbrHhyZl8igVl5TFZUYehNjAIlPqM7Om7QcueXc5MQUJJ
         hcbcORdleovaiUycVZRqrOZI2Zvlh11wtkCvqKAbkZ+qkdY19WUuUP69wPebofDYMpHL
         s+XWXTCwv40y8K8oYytImKB3C0jkldCQ25U7yAZu0sLXvPoe56o8KYJf5wmDrkP0ZN3c
         ES/dSn70HQPhQsIkfAgQ3w96PEY5M84ihv9RaKFJ12X3O8RSg9jD8STKNYl8/l+40Sng
         v1UtK11A1Bo+eSC1wc3aBnLoZHIMrVY44w6+r5/t/xCI6Fb1I3huvZx6P+ahJmhoO5hi
         Z1wQ==
X-Gm-Message-State: AOJu0Yx+63csP4CeGBei4XuF2sfn2giNVI6Jm5bs+bVW9Mz36ndaZzEu
	Pt76iyl5/P17KJywVP1XsFJsh3+u41mJb6QLLcj54K1mItVwImBvtu0X9z9UBg==
X-Gm-Gg: AZuq6aL2K9qMqoZJwLUSnDsHODwYC2k9OGZ/nr52HatM7kOpzahYGnIITCLFjeDlZTX
	qX65vrjQWxyUmuaBwSZZ1JHBDXCGqQjyirJ69VPz7hr/bN14g/0xWbRG1aZVbY0NjGxtlc0MJZL
	U22GgOVCNPOhfKGQeeNKh1To4z/U5ksS9sAOKXB9Ay+fDt1S3k6996GrQI6KnmAF6SvaMkadXta
	praBHYLhgmweGtLmZ+MPdpB/4mHT4kh9pwx+dzD8AsiUMiulIzkA6FS9GrcqsKqMvwvwERg7pfa
	1H0im1Ej7R0cnBmeAY1oW8M27RsPznM8pqnz7WtlSlzYCxnWwjc16TNCalERg2xyMpBHbRVTJ4K
	/fKNO6H1eCPt+MkmyTsEwIg3hQlHeMXXwLSKJoIS68JQG2HzZWO9qMgTA1vceo6rZKSlcm3mKds
	WsB1zrCYkhHPB7i16bdDALTBXKUZo=
X-Received: by 2002:a05:620a:191d:b0:8bb:a037:fd94 with SMTP id af79cd13be357-8cb4087f085mr1287445885a.38.1771257217677;
        Mon, 16 Feb 2026 07:53:37 -0800 (PST)
Received: from [127.0.0.1] ([135.119.238.192])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb3d7650c3sm994979185a.43.2026.02.16.07.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 07:53:37 -0800 (PST)
Message-Id: <bbc94eee8dadef6d590c97a89b223751de0731c9.1771257211.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.1771257211.gitgitgadget@gmail.com>
References: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
	<pull.2043.v2.git.1771257211.gitgitgadget@gmail.com>
From: "Rito Rhymes via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 16 Feb 2026 15:53:30 +0000
Subject: [PATCH v2 4/5] gitweb: fix mobile footer overflow by wrapping text
 and clearing floats
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Rito <rito@ritovision.com>,
    Rito Rhymes <rito@ritovision.com>

From: Rito Rhymes <rito@ritovision.com>

On narrow screens, footer text can wrap, but the fixed 22px footer height
and floated footer blocks can cause overflow.

Switch to min-height and add a clearfix on the footer container so it grows
to contain wrapped float content cleanly.

Signed-off-by: Rito Rhymes <rito@ritovision.com>
---
 gitweb/static/gitweb.css | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 135590b64c..8247646063 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -73,11 +73,17 @@ div.page_path {
 }
 
 div.page_footer {
-	height: 22px;
+	min-height: 22px;
 	padding: 4px 8px;
 	background-color: #d9d8d1;
 }
 
+div.page_footer::after {
+	content: "";
+	display: table;
+	clear: both;
+}
+
 div.page_footer_text {
 	line-height: 22px;
 	float: left;
-- 
gitgitgadget

