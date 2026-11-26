Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795694290;
	b=JdWL0Dghcg2j8CgkmHBf5hoQqKj580nC1+nftYE/YeyFxIaAmnPTIXPB17lQkV5fjwOY
	 v8QN2IbvjyVXcu26raFddtOsXJGL1FM6lJ3XWYZw8Du16OJ9azsOjaiv99IZcYjpth4Sl
	 Zj3ZTcbCKvsG0mjbKfnNKIPSe1KwapZKa8tDVyqzquWM7u9Okpn17LOjL30kmFiBP92sh
	 XvehVlq6hHCkU/DdcBe7kpxjgy+kHPFJEw5theM4DnmGJdRn+A6SctqCG+7wSnTy/HVuQ
	 cWVsFIJHIcmS4g2RLDUZ2B1+m1YVpISsmaDUSx0ptottJAPfWLdlCtJMNvjCzYnYlfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795694290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VlYq6aVz4xTFeCYW1QTl4Dy+Qhxrn2UHuFATYw3+Ek4=;
	b=CJvnI5XqQpEPsL/GnOwaCRNYvPkUaDVaFRVOprCVo8Ws3xzPz9rtuDHAorwscnmeVrs2
	 X8vCejRxuseESu6WdSRyc/+LZTQcsFr2WmTKRXf3N0iFO0/bT/Pe2QRDhTHMxolPHJ4bb
	 U9tVx3JgMzF/F+Sf6LhKlPFEWTKOOn4Tjvjhr4mYRc+bIWcrAaTwQsudhVs0hNm7pzFL2
	 AaAeC4raodzmn2jdR+gAFnPPeNkWWDuinoPHE2aVkncdWdJqb12uDbIkW0WLSwu8bs45l
	 LZ7hqzKOEhjXnWpK+HSS+b4rDaczw3QelQ9p5TbCv//VZeQ8yjXzZM/9EjQU9QfBfRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0dYxuTYh;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C802606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 11:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C802606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0dYxuTYh
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3863db981d4so9760831eec.0
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 03:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795694289; x=1796299089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VlYq6aVz4xTFeCYW1QTl4Dy+Qhxrn2UHuFATYw3+Ek4=;
        b=0dYxuTYhoK1W+FiSZ5rLaNkPSGOzX3wWa6ILtFARD43Nr4yqKOpmi5mv24Cj+v7QLc
         ThMdhiF1dE7//BRrVvVD+u4PvlyDPqhLjQTz6EomZdy/vlHjrTSGDNGewV77sX0Py45E
         GWh+qkQkCgM0pXErkm43Nnn5+9wXDDRaI/WIzewzAy5+WHUKUWANiYHrYl928EF830SI
         u0XTju8yyqM4dWym9NBS3QYAf8EX7/GH1bCd0jdJsqjrri3YdSv1sa/KI5c5itX32kSq
         hvu2XjSwjkIuueTjI3ONEa2zyHou5VKfuVWg9bAQyuMhUdJm6DWIHuURhsFb+8Dg8OS2
         YUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795694289; x=1796299089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VlYq6aVz4xTFeCYW1QTl4Dy+Qhxrn2UHuFATYw3+Ek4=;
        b=jo/o8tISHCcTMATNmgJ9P5L56aJCS4pKg3ePcHXJPUFNBLuulvjc+A0+LwRChIZNSP
         Og2inIj+QQiOE9drPdJRoMnv6qbusslHer9jKxt5YKkAlkTLiBFvFyhKsS/4m1o2KHMs
         zZbqomcUeUmtHazspcB3d1ixjojLDOy/5/xSo/ffIw79EoNcLZleWVOiHrRSGlXE/f5u
         IYpRGWZ4b8j185a+9G5hAuv4rcPIlxMueE5W2QguHKc6nhQaUG0D5Irtaa2Bqsg1+Nvb
         kIufbDKdq4kfPkf7jIFm9L4s+rt0usz8gvqC8CeOJ8tKOOQo4Zku2lnZJ+hrj+Y1anHY
         hDTg==
X-Gm-Message-State: APuU4Z+qNnH6NHlFS3G6eILfgKELtWYruwW8I/m1YEIGWqrrS0ZnM6rd
	/WtTS5x8RtbhJvjlUa7M3H6MvsWFFVPodDxtQCg6hrfmVL1GR7lK8uaflvZfaWAp
X-Gm-Gg: AZFdTZdTXj4MepY6UyCuTzcaEKN10biIR62lf1zWBEUyStY5RN8SdXrgNYbZmGqu+DZ
	/q0TTyUOo6Z8nI338jKgiJ4coVk5PGpGRxGH4o2X6X70CoAV4Q0otF7nBczEaNzb3TUeVl5wQmt
	UCqNSXbthe679R/R+8d/5V8rUhVhIAwsobN0yKADAw4kVAoZMVFVbBiy4Mz0MDuLuLjkR3F6RA8
	ikqm+nulzOFhvrCyI/8977/JgdojHR3PVbO+hXmnFBQpqz9lHCXqnpeHc+dX9/k52eA7my7O/b1
	tuwQD28cBtXqyuL9MdH2cMo0iyi4nJcc9sTcIeVrhcmpX0FPrFbtFC+qFvT0iE0ZtRT8j1KQnx/
	x2IVsPZ8ZhWQwY/HbOUdvZMOaIgcDV8rEquJfB394WYe/4+tnXwtrfEZouYS0iy6b+YYx46dDXx
	kgFT12oRM022OwN7xoFKlX585QgqTIMXDT5Ay1q4m9KdY1NH6fi3XucCIrhVObmRHJCi3ewF11d
	cpRPt45EvaAPVvvIq3B2uXZW8jGTqQHH+2OUsoe/nP7rS2QsSrQscvQbnLI/pvtm/8dfuD06etF
	al+kOyQF3Wp+/h2t1hDBuSr3ndEcfGOGG8qvRmrS57GZEZ5Eyv5lEoXhI4nXB/IGcYxdUdTb1vo
	WZ7SMdErTVOoVT0ndkVN4SdY=
X-Received: by 2002:a05:7300:430a:b0:379:7bb6:9c4b with SMTP id 5a478bee46e88-385717083eamr26274580eec.39.1795694289090;
        Thu, 26 Nov 2026 03:58:09 -0800 (PST)
Received: from localhost.localdomain ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aa203267sm33614470eec.0.2026.11.26.03.58.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 03:58:08 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 0/3] bundle-uri: do not die on unresolvable relative URIs
Date: Thu, 26 Nov 2026 17:28:00 +0530
Message-ID: <20261126115803.30015-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105152842.566318-1-aniketgupta3001@gmail.com>
References: <20261105152842.566318-1-aniketgupta3001@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bundle list can contain a relative URI that cannot be resolved and
one such entry can result in the entire clone dying. This series lets
the bundle code report it and the clone carry on.

Changes in v5:

 * Patch 3: drop the bundle from the list when its URI cannot be
   resolved. A list that a server advertises no longer reports that
   bundle a second time as having no uri (Junio). Added a clone test
   for it.

Changes in v4:

 * Patch 2: dropped the part that hides credentials as Stolee was not
   convinced it is needed. The part that names the URL that was passed
   in stays, as Patrick wanted. The patch has a new title and its test
   no longer uses a password.

 * Patch 3: fixed the commit message. Previously it said that the
   clone carries on with the other bundles. That is true only for the
   bundles before the bad entry, in a list that a server advertises. A
   list given to --bundle-uri is rejected as a whole. In both cases,
   the clone fetches the rest from the remote. No code change.

Aniket Gupta (3):
  remote: add relative_url_gently()
  remote: name the original URL when relative_url() fails
  bundle-uri: do not die on unresolvable relative URIs

 bundle-uri.c                | 13 ++++++++++++-
 remote.c                    | 34 ++++++++++++++++++++++++++++------
 remote.h                    |  8 ++++++++
 t/t0060-path-utils.sh       |  9 +++++++++
 t/t5558-clone-bundle-uri.sh | 16 ++++++++++++++++
 t/t5750-bundle-uri-parse.sh | 15 +++++++--------
 6 files changed, 80 insertions(+), 15 deletions(-)

-- 
2.54.0 (Apple Git-157)

