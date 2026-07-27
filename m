Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D095837E2E9
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785135883; cv=none; b=pBHT6bYe1RDYXE6mQlFvnklIPyhqyDusDLZfDwXEauQFpxpPqVczlrcsPwdR8ReIXsvj5PjoSMOcMfRnNjgPUp8l8QiSEYawmArqEDMT7ymp3tF1IdR7ZYu7x4u8jypSdCTbPbX+jFLqLUpQsnJ3jsZgTwqGxa5GxHX2DxgVTt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785135883; c=relaxed/simple;
	bh=PjRq7M7a0zm0XqX27aIAd1f3XZBtvP2TOM/JKUq/lms=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=S9wjOsRr1hpwrHKl0AD3rqytK9T0UTnW+zT7r7L+t1xm0xL7JWloHQiVlAptp6141aSvkDvQm7LiRnd80YCO5d8o7RuROhA7I/iWb6MAZebaHZsXRZJhUGbKBERUwJ4PcCTWSGSggkvkc6ALg453yb/9+OwfOc9ICGcATsagt2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Casjvgg6; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Casjvgg6"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e08baf860so2413470a91.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2026 00:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785135880; x=1785740680; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PjRq7M7a0zm0XqX27aIAd1f3XZBtvP2TOM/JKUq/lms=;
        b=Casjvgg6pGeYQX+pQs0urVl7LTfTl4qQeZvzWUAGOf+iOWqwQW9Cl/gKRjb+QJJGxc
         DI6Yy7s19xBAG/9oETzzdv+LSxiNhmQx8MZtEOH/13QtmB+5c0KobtX0Fgc8Y5U6YJtS
         VMoumgfjsCWa3Gyl+qhCmL1Kz2GrdWjugXqEAhs2kJ5pKIGWww9JPeI4erykGejkRrKb
         vIOiqrHZWgOEZ5lB2R75cuPn2PqWEPRUPJXxq0MBf6MJLmfKOBvdp0DvZgu7uMrBYWlD
         idF6hLZ6Tw/C3OXt+/QTEhJy6ZIWTMaApVxj66G+roM9iwq+a0MrdGK9Fu3QtRQFHEvV
         g6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785135880; x=1785740680;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PjRq7M7a0zm0XqX27aIAd1f3XZBtvP2TOM/JKUq/lms=;
        b=fHfOHTcCzYYP8+PLBMaKOaBRkokIMnq3A0zNipaCWskpKUyOXG7KIhrGmJPvGJ58zQ
         pQq7kWNm+gWbcBXg1drptylrsGJd6U0p4aOFRbdQpF2BZvkk2sYv2T/L0WD4N1unZMNk
         iYnP6+4MWt6mVcSV4fhuxkW2YGmzK+nkrlUIl0l6F7ULf7DixrjNrXje7alFWT8Jl6YJ
         oYOBuSIMdvdZ2Hso2hsanMQneZqKhAkI/7Hi0dv092Psjivh2qDeo4ytBHt5mSbao9/5
         qQ4el5nWcAfHCxujBu+qhLmmNcgovlKlz+0if8fdKk5x+si4P06QZ3fY70KPovTuewTM
         W1/A==
X-Forwarded-Encrypted: i=1; AHgh+RqXilQYgPxSCyM49LeVaSbBLb3D6Bv81n59rgiLNJCNLPx7ubDxk31zC8/+sWV+ifeMRbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNhHJxEOMty/xjJ6gIsHIq9JfYJ2z2Pvur7vxoYwl0HX8yVRKL
	awMDMQh/sLt2bGZGN1sQDfDG6Qr3uDHya624lGMAT9hvreiRbzrVd4cS
X-Gm-Gg: AR+sD12Lfa0CGEFxWeAvxuzu9sYLKAmLMDzkkZNt2k9ZVJKqfO3uVrvH1lg5F147S2R
	fZoekoyII8joQgFP5IYF8hvo/mWf7pd94mPbpI5MKO3pN+4RGotsa3rbp9bwJc8nF5AKMAxODo0
	91UuGsu1598m2GUYFerHP9s42NUuYJLsW8vlU75Nmp7WmmmLNPc72kdF4Bb3nBXihAFdn4+eRK8
	KaFpuKxEOSjuMyFzxol7m89XlH6ud+Kkd9cA1W//EOGStqstcRZI5Ch4vtsIOd0uUW870nQ62h5
	zGPgLaAJhNm34pzGlL4a/5sBXc3+vKHjQC/C0G74lMkQzD7zMdxXeBREuEMLiv1/rYnuJ/5mMt7
	T9D4zeioEgbb2NxJIc3a8Q8TBGSdq/HJeft7RObvifWRGS6w8dHmx5OGniM68O++I9EHj3orcDg
	==
X-Received: by 2002:a17:90b:1e0d:b0:38e:dc4:3f64 with SMTP id 98e67ed59e1d1-38f29784460mr6374168a91.38.1785135880199;
        Mon, 27 Jul 2026 00:04:40 -0700 (PDT)
Received: from localhost ([220.158.183.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc57ae17sm25026413eec.22.2026.07.27.00.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 00:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 12:34:34 +0530
Message-Id: <DK95URJHRRGR.88DI7EGK5OMO@gmail.com>
Subject: Re: [PATCH v3] utf8: make utf8_strwidth() and utf8_strnwidth()
 return size_t
From: "Hardik Kumar" <hardikxk@gmail.com>
To: "Hardik Kumar" <hardikxk@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260726123427.173877-1-hardikxk@gmail.com>
 <20260727065917.469738-1-hardikxk@gmail.com>
In-Reply-To: <20260727065917.469738-1-hardikxk@gmail.com>

Changes in v3:
- resolve all signed unsigned warnings.
- cast returns of `utf8_strwidth` where necessary.
- update maxwidth() return type to size_t in wt-status.c
- improve commit message.
