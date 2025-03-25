Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6000253B66
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899115; cv=none; b=uYjlGw/5fWyDzx5w4a1v4eOtnLPvi+M0rqFhjL8zf5ab1O6Pmt1eSLFsiw42ia6Hfis2CmYkR+8XzMtVqX4rthkNIVr/lLqSgFnIbiAbXOfNvtsYAQPpDTa2gJgDbmpJ44EOCaCxoUe+UZ3txgC2g9x1OLHiRpx2+/+7GtOg0yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899115; c=relaxed/simple;
	bh=pfzEq0BrneX8YhoPvVOXUZqvoydPRYWUYD9HRJCM1sE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=LBo70GxRooamdt+yWwi3H3q+5dC5XRcp8renqa+XjmORBtWFywn5l+/b3NEghlFgsBKmZM90/zZEn+qkRUTDSJE5INIlGxuM0cH6iYXy4Cy/Q5BITXJfpsp/ObpO2Qq1V2iolGhP71WtYZznSr17A/L/+EFQUTAU4CqdwToVXm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxIl8wAS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxIl8wAS"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so49303275e9.0
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 03:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742899112; x=1743503912; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z1z6XmBryIdJaikX09l8WTJhfcUNiyQ2ANNn2F0JUyE=;
        b=VxIl8wASk+ABPQtEPVBpvK/1dOVvFudJ3J2nvttVRkQHKfSN9z4SIcUzFAkmqaOoy8
         WcZAd5UZTvBVzv9GE7R1Rl0Cy+wCactAPaUqQj4xZViTSc0O7dH+F5aqSChPhYoZrqMi
         ejpndXxwqGqxeohx1aoqz0SNeF5c2+HZ98zt5fGtuR1xdTAZo8sp4lRToatLqczyc7ib
         t44CGpVLGpOeVX8bHGdCAu/dy47P3owu9LyKLi6LzGF2waHR4SK/UY0lH8+hEaiN7axu
         x7xKNyDlMzid0iZGM76Vb8FzVVl9FKYolpm5ROpeClL2B6IcK+Kvx77MZ8kJ/PUzDDNV
         oNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742899112; x=1743503912;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1z6XmBryIdJaikX09l8WTJhfcUNiyQ2ANNn2F0JUyE=;
        b=GTXIm0Zl+f5aEidtggQ7OlPY1rzJB2M6yO2neHB80GSlo/9HVzRxYED2SMBYU7VtLX
         fUdWpaP0mU/EbMIH2HvK8XPJ+KBL/f6r+zlcmVqwNYdKo0ALBNXiRsOOOGWbucLo9to1
         6zetK5mlkQSDP9YtIt1zn5ZRuK3Tk5aHwJuKeK6O0sxHB48EAJsvfcpAD7PvZ4VCXvmJ
         1F04B0i1R30Y6lGYcmYj/iAl3i0tjHa8yqkeUg+43odGJrcn4h42GOaQuSG52llvTfz3
         iLoIM3zFeXGna9N1oqs1BeFZSaHGohHfUYeYCI2GzPLLZsePlsu3RQoVV2UYAihvtUHB
         IeYA==
X-Gm-Message-State: AOJu0YyYhXb1TfnaJPV+d1RnvCNCNMYkA9HnsKcUJizJn2jqx66hmBI6
	MWMeiSOA71mVsq/LnZn/NQGJ4olPInaMxya7O1nS7j6zF1d/8+hCkaSoHQ==
X-Gm-Gg: ASbGncsIZVlZvIOG+Qnq18SFqu802PSVySmSM3/aBezzOc95Mg70qSFx0sl90Sxp8VW
	9r2EnBabKx/cyx9qxxBv6Pi/qrTTWzvwdr+VUylg+a8OlfpchKtu7M8kXAS++z1v4TbNTrR4mvU
	BpNGjxdkhssx7r3jDd76LHSfiTH7qq1YPrcX25/6hsZdcDwvRNYcrAJZMPiVg7+JEcNX2EWk7Ci
	pUYyZI0bsKX3Fq/4SsVDWSQHmLb3XSeUGBCoPtwso9Nr2ZVt0LQrzoif2AOyNmM9GBvZfpx8HfH
	imB49i3pHsL6OEFeKOkYUaNOikNPvfrVexg6ofDOWWIqNw==
X-Google-Smtp-Source: AGHT+IEYs6ZFh9vHpeCt5q2P9WkN59/L3+BT6/YkBihKy2c8N+HnE2ch/C0oOyGO6QZhX7x8izzIEA==
X-Received: by 2002:a05:600c:4512:b0:43c:f87c:24ce with SMTP id 5b1f17b1804b1-43d50a3781amr110431335e9.21.1742899111285;
        Tue, 25 Mar 2025 03:38:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a345fsm13215940f8f.24.2025.03.25.03.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:38:30 -0700 (PDT)
Message-Id: <pull.1893.git.1742899110.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Mar 2025 10:38:28 +0000
Subject: [PATCH 0/2] mingw: special-case administrators even more
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, a file created by a process running in elevated mode is owned by
the Administrators group (not by the user's account who would otherwise be
able to modify or delete the file in non-elevated mode). Let's adjust the
"safe directory" feature accordingly.

Naturally, this patch series does not add a regression test (because it
can't, you cannot automate elevating processes).

This patch series is a companion of
https://github.com/microsoft/git/pull/712.

Johannes Schindelin (2):
  mingw: special-case administrators even more
  test-tool path-utils: support debugging "dubious ownership" issues

 compat/mingw.c             | 39 +++++++++++++++++++++++++++-----------
 t/helper/test-path-utils.c | 19 +++++++++++++++++++
 2 files changed, 47 insertions(+), 11 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1893%2Fdscho%2Fadmins-are-admins-on-windows-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1893/dscho/admins-are-admins-on-windows-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1893
-- 
gitgitgadget
