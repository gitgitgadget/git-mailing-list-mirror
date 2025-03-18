Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31B9155753
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742336494; cv=none; b=N1by24HvD2P3tbocDaqrP4cDggFuxlTlya75pSAOtHOPp92Xsxi5d1/f8IZf2E51KryGb6r0zb7K9UYRQCgHznwvSyqXNC5zW97yML8o0iR5YCZ1qmuTbdMH87ncplOeK9qvXTYrnNww4zylqYxCRQIh+Vp4NJyfM9+lP/sR3sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742336494; c=relaxed/simple;
	bh=GZFcJ7ViXOmq8TWeDe5LLoBTEqL8HQSaZfRHpsH0wNE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bt+pa1mNe49m69OApHWljV9MgoR+VEEjxIGwfQYe/oozgBEBx4jqGCLGiLdQuCkSZ2yI+J/wNvCiDMfnu4dbzyoOqy/NCe1ztGYKa3cjJ4DD0Es54UmtZoJFVm+Bz/xiDmdakIuqxpvqiK0qrdk0L7ZKAs8Veh6G6YySDLF+74M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=yj8+LtUV; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="yj8+LtUV"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8f916e75fso1197396d6.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742336491; x=1742941291; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rx6IjZaV4kTuzwO/KU1Rq+0d0qJoBirEHXfrbFrKAFI=;
        b=yj8+LtUVcmEuIhy5RsN2JiKObErwZO0dIf/hkADBG/1mOVD/8iO4QfU28hdRCjEfba
         CScoji+L22eXhzEWHX9dLdapoqQZ4inMFIxem9bJgGor5WqL3U4aBJixAHDlOVmTa5CO
         y9A6+3Ibtw8m8GnoBIp4e5Jw93yWYkuRKbJt88J9FlmiRt3JGK1RImpAFzGjByGh5pUN
         Kn1QLXvQik9P74MZtqgZBg/GyazbfpkpTBXx+iD+bPg53f02AEHYxElobMfUWueX+6cD
         g2WaqKUotjc7f2qaYUX6bkVKb7quyV+2pSnQcBKsx8d08NlW/Jd51iwWFAuLY8iTA1ba
         a5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742336491; x=1742941291;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx6IjZaV4kTuzwO/KU1Rq+0d0qJoBirEHXfrbFrKAFI=;
        b=JGCDRSTKglJegf57jvkNTQP+wE5OkVrD/NLAg3JdwWKTcMLgw2E1cgeriEeNfDAd/b
         HE719EJTR/4vxRh6TAtY5UyLRTtdRqYukFd9aXB4rUBXoucfCovI5FwKqBi2MVZMDaZQ
         O2amacPCpnUaf2hjRAenEE9cQYuFbsLj06+3iWjVdo+tUFPUJRpPtVGxFZwysdB4/VQ4
         89uZ9W7F7xxHShr3NDjDmljnuJ5glLTHI4dJ03Q0ylplEAt0FVPsMjgN9rD1X4vaduvh
         jESNl3a/5Ce5Xk7DEFUdLJMT7ie8N1ZVtgS/wYq2DaUR7t9R/xwbfZZ1o49iTONvjfqR
         ZUyA==
X-Gm-Message-State: AOJu0Yx78Yh3B2MFbMAgHrU4jE+Fn9YlkOGnJAnoG4LW4/2ZBfYHItJG
	d80wqw2FtTmOqPxSHCF490BKBkgW6UqIbC/g6h3yH2a116oFOHEA24sGBjA5NRf//ZnokW7EA3W
	XUx0=
X-Gm-Gg: ASbGncucsR1B78PhL7To6ZLHXxbiIfyVa+4ky5jh/cen/7OgC40C7vMu+DJBa6ukOL0
	IzuRXuPg/yYSXmaQArVUEFI/J+nMkoxHEVwAR8hqN2LBhOn2TTLYJ/zRpDbZZxGsosEdj9ZN3mI
	ygpNmoEtBz8cCFfLMkXH7pzF7nxjxjUTnJD/NyooDm/MSC4O4upEMfjxUHBUt17Q3kF5w3Ci1q+
	NZYk+kQ3I0T2dOgMvW/QXrxaD4T40PdPD5G94ps6Il2xNRdsHoQBOENFRH/tEvGi19QCwLsQdG+
	k70z8626vNBE5k+R1CjCTQavAsxElpndgt7IMrcTsxUmG0xuOJDWpWh10hSb5wFGUKWP6AbMBdA
	S4t+bmm+5c85FoH9o
X-Google-Smtp-Source: AGHT+IFSEuWv4sGyuv9IGKKePbkoeaBNFcfcDj0dXKuy2qGIS0MpSw3BcdsVzx1rvUqJXX5LFutYLQ==
X-Received: by 2002:a05:6214:508c:b0:6e8:fb11:e2c7 with SMTP id 6a1803df08f44-6eb2976c455mr7356506d6.8.1742336491445;
        Tue, 18 Mar 2025 15:21:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade0dd630sm72455946d6.0.2025.03.18.15.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:21:31 -0700 (PDT)
Date: Tue, 18 Mar 2025 18:21:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/3] http: support fine-tuning curl's keepalive behavior
Message-ID: <cover.1742336481.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This short series introduces a few new http.* configuration options to
control curl's behavior around TCP keepalive packets. The details are
spelled out in the final patch, but the gist is:

  - http.keepAliveIdle specifies how long in seconds to wait on an idle
    connection before beginning to send keepalive packets.

  - http.keepAliveInterval does the same but controls the interval
    between successive keepalive packets.

  - http.keepAliveCount specifies how many keepalive packets to send
    before closing down the connection.

The first two commits of the series are general code clean-up of a
couple of small things I noticed while reading through the http.c code,
and the final patch implements these new options.

I couldn't think of a great way to test these new configuration
settings, and given the simplicity of the final patch I opted for no
tests there. But if someone has a good idea of how to test this
behavior, please let me know.

In either case, thanks in advance for your review!

Taylor Blau (3):
  http.c: introduce `set_long_from_env()` for convenience
  http.c: inline `set_curl_keepalive()`
  http.c: allow custom TCP keepalive behavior via config

 Documentation/config/http.adoc | 18 ++++++++++++
 http.c                         | 54 +++++++++++++++++++++++++---------
 2 files changed, 58 insertions(+), 14 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.49.0.3.gbb7a4a684c.dirty
