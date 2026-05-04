Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F10BA45
	for <git@vger.kernel.org>; Mon,  4 May 2026 00:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777853481; cv=none; b=Adxj0wOUcih/NgWpvnOYkOFRC4CJjkKgYmOlhxbf5wyCEFiU6XJEIuw7dr2VNft5gnWI0LIO0GOE/Ek6ClzEINDpL2PCvD9iJ/2MNBWlQXmuGZa1MtulwUW3fE0kHEX4FObgbp5lUr8RNxSDg5bWo+IWMpB/Qdp4zcjNgzsA6oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777853481; c=relaxed/simple;
	bh=9Dj4XGZVfygvC6L3lZzq3pBJTu4v0ZA7rX0PKjjzFl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkC7jairRjnNvHZGbmrd6AosT3EK4RdBv7X2UFb+7Jrgz0Gkakwaz4Kf5JuhAQ1/I38RXEuTr0cIx2FPclkVQ+lJIT4pQKO8rQCwTTs6TcIHEjqCrURHwCo4Caj9OnKX83UnLZn+nBrLSM7cV4Y8f3FH2TwfKZ0pxik7+XOZY54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=qr80aKlG; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="qr80aKlG"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7982c3b7da9so31131937b3.1
        for <git@vger.kernel.org>; Sun, 03 May 2026 17:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777853479; x=1778458279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bpz18eggRKVXLxO0gXoR17chf5Xj4WI6V1JlAoljYts=;
        b=qr80aKlGCG18mwa1r4e7aBe8xYYj74gBCJiDX2RspM/2u+FvawjspzYVRs1Ua/1Guv
         DayZLW3DMiqC+NhzKq5y/82WTI/t7itdMU7QQUopERr+eRFpGZxT5/sO2eR+aPGbp296
         IchiUeXdWEKHiMZKvXRR9/EH1ko7ehc0dYz/3Dofm+39zJOBhio7lFRKbHHJfEOrFo3I
         OIbDOFHISYWxw98DgiY0xAtyX2uacSzYM+52OHAYjqjD2SIOjUefokXovBRaObKLEQ7h
         MXn/N81SQAJcGeKIQ3o86+mEn3r+wEZNITHWT8+KwVNrNNeflG0ucoALyOhyEGlqLbnb
         MPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777853479; x=1778458279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpz18eggRKVXLxO0gXoR17chf5Xj4WI6V1JlAoljYts=;
        b=sUaCcJLpnTXTjOgis/lCIwdSYN03EuyQZx3pE06J8hUnJk5BSkniYK4GOcMDIIPkYk
         IeEsBcNxZvVLyqKAWWjNsWDsdIMnHPHhg1X5VDYqu4tLCz5QLAi0n/IZ+XSSgFBiNxxD
         SllaEXIYcP63nzolfolFzp9fGBTktsZm69kmf29iAhft1JtBI7G0X7Ddmg44T2xrZLnU
         RzcJTze2jIBDr96cXKjoz9wtm8p22FPrQPmchxF6HDsd6SAglO8o6ck6lddtwzaFFSMM
         ROJ8dcF/3P3YgUF2Af/CChGH7z7tfPAH8atHs1yXLOtxGjej0tXyIvSj5H0VWL40+FvL
         H9Vw==
X-Gm-Message-State: AOJu0Yw704l/7PRrxbmV+GsXdDnaAE08N1cSIon3kOg7K6zbfWJMqD1X
	j67YazaroEWqOBhZp15aS1ch1CMgJaDICPkn1YbQfVVg9H0WJP2dW7NhLnqUbMm+PdK52NUjS4P
	QqypdvqePSQ==
X-Gm-Gg: AeBDieuuifvB684xlSyWi9NLFHCiL0zEOHxZxKQQSvTCss75/c70Dt3rPjjuEdNelwo
	ExKtBUNaA7uhussJU6KtzOR6GHs/2XScWN0vjoufVewerQt1xT3dA8IXpiX954txwAg1NeZtMBI
	9k+7W/AO1UoPl+hA4ayKNn8mBjrpQeTFCLU0htcdtqA3uxMDqVwQtySUgBWwXbWqZ9j6PiddXOQ
	VRqmPSPmM7eiE5/uM6YwZxduIKbbTNjIrR3J33QoJjTzuSosV+Ry19lKxnFbpb6Fx6vlxPXyVF4
	zXg41EAI3fRAVZwcZDMQdITAYaEx79IkQfZrL8EMZh7mc1VTCeYpiS3OI4Zj/+YTcegpxeK9wv/
	Gw6pk5ue7GlKAqQ39MJ4PFkYVqBdarekx0HOy87BWep+JLUOSYWw5UVIY6fJBjiG5Ah0qMjs5AS
	+qqrzv4DU0kCZANhUcIU9Cm/xrbPP+s06zngNFEPrh8lOMKsEvZS9VuVPyyFFGqq5nkVz93u+9w
	AkCOaIrSvA2njaez4AeDzSqmtuh1xkivQoap2ncIGdLtSFx6UDEpkq3Kdi9mO03lF8yMTqVmHdR
	FBOG+sk4Ufx0FuAFbEFiOH4e5UQ=
X-Received: by 2002:a05:690c:e3c3:b0:79a:b9cc:2100 with SMTP id 00721157ae682-7bd7711d40cmr78834307b3.35.1777853479078;
        Sun, 03 May 2026 17:11:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66837927sm41824617b3.32.2026.05.03.17.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 17:11:18 -0700 (PDT)
Date: Sun, 3 May 2026 20:11:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 1/7] pack-objects: update `--path-walk`'s existing
 incompatibilities
Message-ID: <babe1596161365209c226d374db70a1bdc284a1c.1777853408.git.me@ttaylorr.com>
References: <cover.1777853408.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1777853408.git.me@ttaylorr.com>

The documentation in git-pack-objects(1) claims that `--path-walk` is
incompatible with `-shallow`. However, commit c178b02e29f (pack-objects:
allow --shallow and --path-walk, 2025-05-16) resolves this
incompatibility, leaving the documentation stale.

Likewise, this documentation claims that `--filter` is incompatible, but
`blob:none`, `blob:limit=<n>`, and `sparse:oid=<blob>` already work via
path-walk.

List the supported `--filter` forms explicitly and note that other forms
fall back to the regular object traversal. Also remove the
incompatibility notice with `--shallow`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.adoc | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index b78175fbe1b..8dea8259787 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -402,9 +402,11 @@ will be automatically changed to version `1`.
 	of filenames that cause collisions in Git's default name-hash
 	algorithm.
 +
-Incompatible with `--delta-islands`, `--shallow`, or `--filter`. The
-`--use-bitmap-index` option will be ignored in the presence of
-`--path-walk.`
+Incompatible with `--delta-islands`. Path-walk supports the
+`--filter=<spec>` forms `blob:none`, `blob:limit=<n>`, and
+`sparse:oid=<blob>`. Other filter forms fall back to the regular object
+traversal. The `--use-bitmap-index` option will be ignored in the
+presence of `--path-walk`.
 
 
 DELTA ISLANDS
-- 
2.54.0.4.g6aa0d38a4ec

