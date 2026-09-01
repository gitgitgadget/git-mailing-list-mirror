Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FD627FD4F
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262285; cv=pass; b=R22BZbmuVv5IwvfitrWF8MTKufvyDrpUIRq+RinOtAJXl4xmStVE6z5310NnfqtXKWDTYrl9F1ZGeMmCkEhGIFlCQ52eztxUy1DBBZdl+xWZtprPjLxvDYKwg8jxK0RqrCp2zkl3eF0hIE9A2RlA3CS/1UBLv9rU8RVXO6gs8WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262285; c=relaxed/simple;
	bh=Uwl2K8aNo2EriX+KuXYL08omWyX+inHueZN7p2PcdbU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=pd7r/bGLKJmMvMZCwDvIlFi4Q6oJuD0BP2I7Q+KbvrnZCaajkUbhmrE2RPd3qkCLKyB0nC40ZCqcY7Bya26KVoUz3gOc3dg7Dac63FEGPYBGX1PnwCOecIXW7cqotDiohPIWYJTIgkWrrPR2DeDOBHlDaq2Aivg6oqqR+BHT1EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jY0YIO0m; arc=pass smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY0YIO0m"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-97e986f1996so635076241.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 04:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788262282; cv=none;
        d=google.com; s=arc-20260327;
        b=PkBJeZfpzCGVakZE75Hl2qH0sNOxw3bRbxwnkwbKkH6oTJWAdX9tBqJqAJGzHl07/x
         5PACrOWvri6IYFsZNbWhYdbXYNPM8S9Cp9Kl7kUaQp4KHCrXedbKx/YdCDoLkmzyQpf7
         +1OZG4Asl26iCI2USQJILZt8gNdO7vpOFBX+ARQ33Sj4L664HDuqlNEfOeikAlxZ9sIL
         9lgf8p44i4wqeociP03x8MqgnvfNiQ4zzsfTjnfwuJ2SEqGFTnb5/Z4E4tEIU9gRgFcC
         Xmp6zQFGcIgXZE47Lrnmz4R4pUjPaKkI45DIAfeK5TeWxwbF7LsrSOD1dF9K5AbuOcSJ
         /t/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=Uwl2K8aNo2EriX+KuXYL08omWyX+inHueZN7p2PcdbU=;
        fh=MEC/KRBNqxly1VteQZngGf6v6gPgjBnNinLdbcbDOo0=;
        b=qAxkoSUC2qoJtYow7Axmoh4qLW8EOuq0sb/PAk5FfY833BQhR09ny1VlKuSPtGLy2o
         EJA2quGvIRvWBsGf8yC97p3lIcOdlgmFlsAwAmV4EOtK/Iq9tGAT1Yk/8KMev9QNEWor
         Q9odfyIfIjUU7Zol5sxEFwTLGCfDj4IOKOqiguBacR1icHaoCVEphqr4mZ8jkTiW/xcw
         CKtLXAigxdAWUTMtpQrTi4+cll49ESWATGXGo4xsxCAYDp8lsabD7zmYtpIcRytItOew
         iD9Bei0gOBopGMeDr2E1mPkIL+c7v9dzJbzeM3LQxb7JjGjoE2qtpNAO73PlS0aQVeOH
         iRxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788262282; x=1788867082; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uwl2K8aNo2EriX+KuXYL08omWyX+inHueZN7p2PcdbU=;
        b=jY0YIO0mYK9ZEKIwQhJaGhX6aaHabYW9JyvHYFnvUK90T6ZGipQPe9w8+88Ln049kw
         GDarQrjH7InNcvVwOTCaUQbYNfP24it3ZluQxxDt3474Dqgv0AVIuuBmfVJbhY3f6mCi
         KFYaBdZoJfKwM5cDD2LLCIxlvrl9Y9amIs/UY8sxtwrQ1IjQezMMTccHwSqGk9u58ZGE
         RPMpw66LU9pLiVKQEFUOiuAs/l9+gsEq/ew6dnfOs8w3YbszGByqT1ZSXRVYXEJ61hWb
         KClGyEm6G/N9MWqZCIH7p/jODyner9iIWEgZ17mFMS/7oF6HIj/RWCwDDI83aTtTY1jT
         guBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788262282; x=1788867082;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uwl2K8aNo2EriX+KuXYL08omWyX+inHueZN7p2PcdbU=;
        b=sTL9Xt9qPvOJ6lEtEs1++VjucD4PKIjJnI2wO1qgMpi+5+CrkJrPo5CsefVz2l8HA4
         tosbp3AkCJz4c7/+IR2wmiXaC3gNhhkmhOJzSfThsaFdjhJZlBV1rl8pAc2EjEBV2FuD
         KBxWs8NgaHdXAacbyW7jHf4loBDJ7jc5epjA1e6x2NGGLCkGUa+aeTa635tTfsw/taEN
         v2xKZLMcmduojJcGhpd3XQBuX7EPJSY/tVqhrk8ObNYlEc1quA/6pjuSNI1qyrSj7OJm
         ulph3TZljryuM6pX75y+5lUkK5MunIWO/UyNk+6gYeENoP0Jxp4D4fo9kJD5k5nYT3XO
         yIQQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro0+0qUHimAaR+qGe4ldNJBrYfUmFuZKKUwgY+SZcsA1ShW81JevE3rysGKt+wUGmN4vUo=@vger.kernel.org
X-Gm-Message-State: AFuF++nEPZNDCTdmbOKUizihiK1ImWKTYrIfZDfCFoQZe/HIOmUVeaea
	Wy1JdnSO4qJ5FZOATetRpcZRiAiVQ1xLYNRJID6dJR0JHHRlIdFDN+CmHbkq7GCplSU1KugMoZF
	VGMqhe4JfgELy2Qzqn8tlO3dRuGnIdmU=
X-Gm-Gg: AR+sD123QjwDyfYCkwvkHPYrsupZ51jxW07FhuH/AEJ0NQxiF3rPTNHAYzu83hCALFx
	+swXcJFZEwakKjJiHGjvGPqIL8oUDed6cl23lK3ddLQWkncATYi8AObWn6xypbntYeBtoITNBaL
	MjjnHLi/0ndqGDgdMdbaf0bDXvbTeDf8DrGkGoJ1THG9l9TtKLz/3eysV7+Zov0L+fBpDlB+WTl
	gJwhFDcoY0BSbZA+vKxE2eNOmgrmK9XjUQgW6fMf/2G9xcfeuAcBmxhtXP5NE+9fQyv+WoxkxMR
	7sE+4HfRv6xPHMb24vM9V17PDDs2sqE02quFcxUI/a6rV1JWfeGSOkQQRNSGeazlqQpWhcXtm/K
	3cT0BgQXbxRa+FH16dGWeO+JNa0tLQwENO/Q=
X-Received: by 2002:a05:6102:f8b:b0:785:35cb:e64a with SMTP id
 ada2fe7eead31-789fc18ec37mr2753120137.3.1788262282330; Tue, 01 Sep 2026
 04:31:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 04:31:21 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 04:31:21 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260830204835.1040408-2-gitster@pobox.com>
References: <20260828225206.310500-1-gitster@pobox.com> <20260830204835.1040408-1-gitster@pobox.com>
 <20260830204835.1040408-2-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 1 Sep 2026 04:31:21 -0700
X-Gm-Features: AcwNN1Xe_aTWsn4mjyxiSBKFzaowrs-lmgJ9q15_KkbdFTM6_DqzqkGLYCRW3s8
Message-ID: <CAOLa=ZS7seJs9bt4DiSzD=hDXNTnB9qO261Er39PG2sDbj9=MA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] checkout: pass cb_option explicitly to branch name parsers
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001a9ef8065a6a4243"

--0000000000001a9ef8065a6a4243
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> The file-scope static variable 'cb_option' is used to record whether
> a new branch is being created via '-b' (in 'git checkout') or '-c'
> (in 'git switch'), primarily for error reporting and advice messages
> in parse_remote_branch().
>
> Global mutable state makes the code harder to reason about and refactor.
>
> Pass 'cb_option' explicitly as a parameter to parse_remote_branch()
> and parse_branchname_arg(), removing the file-scope static variable.
>

I was wondering why we couldn't simply get rid of 'cb_option' entirely?
The only usecase for it is for printing user facing messages in
`checkout_main()`, where we already have access to `enum
checkout_command`. Wouldn't it be better to simply only keep the enum
and drop this?

[snip]

--0000000000001a9ef8065a6a4243
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7864ada570f832f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xV3Q0WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNFlPQy85YUhhRjhGQzRmWjlWNTFZZisrNGo4eUxaVQovaFIwZkc2bXZD
OGJJemRyc3lsbEVzbncyQUphQkF5QnN0b0NaUnlhd2cxN2hkNEVvdjFiUTlFc1RlTHprcit1Cita
Qjk1d3VXWTdvQ1lYQjl5K1NHNEd1dm15VC8zQjl3QmQvMUhOc1RXb3VleXU3WGs1dXF6OWQvOTZa
bHF3TTMKNjlDWHhSS2ZJemF2VHNmb3h5bW5XdEhXbCt2aWR3NkpFSSsrOXZRNEJHMHdxYi96bUov
aWU1aUJpRU51M0QweApJTmRCeWJEYXhZMDN1TStMSmJPSGh2cXZrejBvT3R2VXFzbzZramJvYmVa
cXVKaTc4ODZBOXZkMW95TjREVjRxClVOcFdMZEVpREl3d0xyZzZ3Y3kyQ0JZQlAzRGRTQllDRStu
V2NNbkxaQXZZWFhRYkVtOUVXemhaRXljc1FzNVAKODlDNGdIbHlLcFYwanhnbTRrNlhXNm9DOW9a
NklwN0ZOOEhqTkpubm1wVjRnRWZ5MUlLaU5kRCtvZktnRTloSQpKMWdGY2gxZ0tYQTdGVTJMTG8z
VVpFcFFERjNlczROYWRlekdrS0RCVHpLLzB2YThmeHZpelExWmE5ZURoSVdmCmJWVVFxb3lxL1VO
bDFoWFRQMEdrODBPSnFZUmtBc3lUbFNxMEFIQT0KPUlFSXkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001a9ef8065a6a4243--
