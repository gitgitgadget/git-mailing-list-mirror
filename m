Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B242139D7
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076396; cv=none; b=OQ8z+RUFlxq4qwui5SHrmtdiuaMG0h3Fe0E5VfXHh8MMosk93CZp5MJWlWTP3w5VWni+J0agikVN/8GCcjwTuNu6DHM2FzmE/S1ybzwsYc/iojQeqQOzuLyZwc+IBZ2MP9s1H3247vzcierF4rTmjMaAhr60UnDGSKZybEYiYNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076396; c=relaxed/simple;
	bh=UnXNRspU9eB4OeaUVhxWV41tbChd/sruv5t/H4/wmRU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FgBuXhkUnpicNOZmT7cJPsHjV2rbOGOpH1QD77s/oXRC3QmTnwWhpO3XORyxos7qAKpgL7bSpAk0CreuXcodWGYDqEk6ZpFgJgegnXiEwLO60lyFe4zwV8MZqg1Zn6Q7Zlj3IwxN65M5kXweOczw9mrq/2iMDYxZFQjC7jnDwZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYSITHzH; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYSITHzH"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso669966f8f.2
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743076393; x=1743681193; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9QhoQyPe8/uSUH1mfJ5cMvHBXJOoPnyoQErg4/BjAc=;
        b=hYSITHzHxamk3ZkgQ3GqD3mKq/ICEQjIaW+EO/N7fI/tszoQ9Y7kZli+WyIa5ddFIS
         EVH4D3Z1WU9+rcE6YQYc8HQBW+ovyVxwaG4AqI5gdyy4rHKI3y64J1rgJaheQKThaD9t
         enIDdFxkb+GHc5pAp3/J8+H7wtPa/nHwCFrSw0WRIffHTSdmVTJ7L3InNm2WPL8ncEUh
         6Z1HGw2Or8EQ6v53hoIWZr9K4WJwxzcZ644/ktsAL5/SUp5Q72TSk99TiKBk9rcj16az
         c2/AmVYL3EFEIirDvI2yzDSYSDbZ9Hvc9ja7c439IJwvj2B6bOPlt4xGfAXO+8xpeusm
         yZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743076393; x=1743681193;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9QhoQyPe8/uSUH1mfJ5cMvHBXJOoPnyoQErg4/BjAc=;
        b=EqRrwrfcpwAGJtWR2qeovKO/iAbx88m3WXH20FbsyYwayUCtlGfNGPWZtGPeVyuVeG
         tExqBdNc/EwyRLAMCxft1MacLeUuPH6TyNX3FUBqRMkzDb5jCCcQ2E+b2oK52VvP3abr
         imVswQl5y+eKpEtusX6FlGv+2hty1LSjyKmyFtVrkUhgU+hrlx8D9ms7y/XJnAI+cQ8s
         wgFaD7c9hiEjbOwG2woqnESEsxgTtMdcjosgNMBu920Dd6ZNVydSx3uvG8dCZuDxJd5X
         tWWmtvLQ3eUNTqzcweLq1sagW6n19nLaz1WjOvLzHCf1Z2D7RPjRaWjsy1doTDR70c64
         K7hQ==
X-Gm-Message-State: AOJu0Ywkh/7cC4c7yZ8lCzKPLcinZ23H7Ne+VHZq3441K+pyeGyChs5c
	Rj9WQjHwAJ/kIxoa8Ok066xHZzatyB1WO5xS89Yt7oEpkPXXeK3mWx54Uw==
X-Gm-Gg: ASbGnct65uobMkSrjkaAQmTn156GGWRCtfs62atF6TTu4KCkFDk4CWxKqhADkvbR1EQ
	vm5jGiQvhoRX/jGDqezbb85wN/sVTWnsl7n9BbJrTNJ4QkAcJ7diz/4d6S3ieq2iTclbx90lR3h
	gJnDGGKL+XPikVxGSXVqDzxHTv40X9uKYeQf2Rfmmu4ASjpCDqRUnMO+q1YaRSivzBYORSHdrfb
	aRSiEfF02u/AczCYhiv7Uwg9e0sXSlPrmCr+B0J10sl5hEuq2g56UYqOA+Jm+GCw5NHJIrBfhUI
	U7jB0dr8EwoOyvESpSoJhUcItUkYGjDS6BYXGM0qKoaDMw==
X-Google-Smtp-Source: AGHT+IESsgNvR445/Jq40bpKRWzIZMCVgS/qutzfv5wc2bU0K0OFXhjaKgTdCDlBKB63TOsNIT3FoA==
X-Received: by 2002:a5d:5f52:0:b0:391:22e2:cd21 with SMTP id ffacd0b85a97d-39ad1775436mr2611132f8f.36.1743076392517;
        Thu, 27 Mar 2025 04:53:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82dede98sm35493235e9.6.2025.03.27.04.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:53:12 -0700 (PDT)
Message-Id: <045d695d73e059ac9d56570c9a2e1176b9c0c1d7.1743076383.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
References: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
	<pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 11:52:59 +0000
Subject: [PATCH v3 06/10] diff-delta: avoid using the comma operator
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
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Chris Torek <chris.torek@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The comma operator is a somewhat obscure C feature that is often used by
mistake and can even cause unintentional code flow. That is why the
`-Wcomma` option of clang was introduced: To identify unintentional uses
of the comma operator.

Intentional uses include situations where one wants to avoid curly
brackets around multiple statements that need to be guarded by a
condition. This is the case here, as the repetitive nature of the
statements is easier to see for a human reader this way. At least in my
opinion.

However, opinions on this differ wildly, take 10 people and you have 10
different preferences.

On the Git mailing list, it seems that the consensus is to use the long
form instead, so let's do just that.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff-delta.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index a4faf73829b..71d37368d68 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -438,19 +438,31 @@ create_delta(const struct delta_index *index,
 			op = out + outpos++;
 			i = 0x80;
 
-			if (moff & 0x000000ff)
-				out[outpos++] = moff >> 0,  i |= 0x01;
-			if (moff & 0x0000ff00)
-				out[outpos++] = moff >> 8,  i |= 0x02;
-			if (moff & 0x00ff0000)
-				out[outpos++] = moff >> 16, i |= 0x04;
-			if (moff & 0xff000000)
-				out[outpos++] = moff >> 24, i |= 0x08;
-
-			if (msize & 0x00ff)
-				out[outpos++] = msize >> 0, i |= 0x10;
-			if (msize & 0xff00)
-				out[outpos++] = msize >> 8, i |= 0x20;
+			if (moff & 0x000000ff) {
+				out[outpos++] = moff >> 0;
+				i |= 0x01;
+			}
+			if (moff & 0x0000ff00) {
+				out[outpos++] = moff >> 8;
+				i |= 0x02;
+			}
+			if (moff & 0x00ff0000) {
+				out[outpos++] = moff >> 16;
+				i |= 0x04;
+			}
+			if (moff & 0xff000000) {
+				out[outpos++] = moff >> 24;
+				i |= 0x08;
+			}
+
+			if (msize & 0x00ff) {
+				out[outpos++] = msize >> 0;
+				i |= 0x10;
+			}
+			if (msize & 0xff00) {
+				out[outpos++] = msize >> 8;
+				i |= 0x20;
+			}
 
 			*op = i;
 
-- 
gitgitgadget

