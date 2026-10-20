Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792481365;
	b=gN9BwqVttKeGhhelHkTzGMbV6ol99WSaEtQ7zUhQAFYq2mwduoEXoBrVsdcTGVxqDBoB
	 GM60m93Tkye58f/+g1lTdIa/xP35L8QBhdIcUOVAmEnY2wvjG6fmcAUs3bctqAYQPdp8k
	 mOK4GL8/S9C2zIa1wTNXjaoV4jkkE9QOlTy0v5nRoGgmET2xVU+XpgMVVYR1iOWYbv+xQ
	 0vaG/bwETvTXDl51wJPgCUqTNlQmRwzpZB8zMlUoO5mMZIykLixpAKAECZKcCteBJi7df
	 C2g7QGPGhhEQsd4vkSXd6fc6Jp+esuF/Ips8PHu3REN53zAKXX0+3a7WM4x4eaI3ovA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=zXxYSA1fp7uc/616la1Mko6BMnK8o11/PpBSN0VRISE=;
	b=Lx5a/TIiaBLRMt6TEyuQvTyxgG58lhY5BsR1fhy5MqOLI2XMToOo6s2ROUNABpqCquz4
	 7A4cOETsrJWcLKUn0P628yQsFBKCT5fjBCs1otE8eYtr+uJJoWUF6Erw6X0VW1Sq2Wevp
	 YMWiI9DpvBxAW4J9b2wu80QtUCVJNMGDJotEah7xAAJatgIwINjVgxoPz9uXkLqUNZs4Z
	 RfWVDlsAxooTj/KdWGtcFKRBWLtORwrLJO9Iq8p1c70x1W97Seec41jZ3QUsizkAJyxEG
	 U1XUstMQ7WqiO6BrvbfdYkNa8eCxGYp2esTkhj+hXFr6AhB8R5d01SeyvIMHuKGhBFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kLGRz03u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3863606A31C
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 07:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3863606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kLGRz03u
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6acb57c2b88so3317104a12.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 00:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792481363; cv=none;
        d=google.com; s=arc-20260327;
        b=LdEQZk8gPIsL6xtngVxoaN0/lO8BILsS57nCmrTlqOG4Ve7+t1BWGt1/o/pa+zUuVj
         dH1BDtzS6k4a59Q/bSTPs6GTEEQA0fyWDx3cfnboKcjTOA82vlISz5Y1KcJ7L3EGgIVf
         Aza7y4hoiE8cL//4Z6GnGViCNkiDWO8nYadtLVgxhoSX1ZN1kDapV2XOH0rid7nXyO9e
         DMBfP8AnXx9ERSRR8+Af/qoxMP+10DbjdssWZSV3NPMGM4j8C0E3a7aQXKnRA0HQZD0y
         NLe3d4NQg22efOXHipIoPIE2uxvZ4UvsuHcN5tcdMGzoTl/0hXf6/PXCNvSuhNHQxbG7
         OOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zXxYSA1fp7uc/616la1Mko6BMnK8o11/PpBSN0VRISE=;
        fh=yMIJmv5yEaDfyEz1PIU3q2cE1Yt6I6rBE6VZMeKHlUw=;
        b=c7HNnImmZYawvnDEHCT/GHM63XXk5X0AGiChVOQjDrNQsNXOxXwYYEzUrEGRbUmzk6
         ldgbMPOUkQPwMJlSrfh7FoCWQSo3yXrCfHhF8G4DT2hQG1b8/XRq3Y4xHj1ZxDWN7VNO
         psaeS+wsZXQewiuH5wroGvb/z3ZJPDXQmbK+DQKG35ozcVfXeEwjTQwJlmVISMVj3JKI
         03B7RIooQBMLpk0NeMLkr34uMU02U9ySZtMKYrjbSG8CJEKpeid3LeXNiFlaQZCdRNgX
         VhTwvPUFVzLFnZaSEgwouvE6yzQ5tAiFSvOfp9biivNKCi2JxYQ5HU/ZpUnJHr3RI6Yt
         VapA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792481363; x=1793086163; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zXxYSA1fp7uc/616la1Mko6BMnK8o11/PpBSN0VRISE=;
        b=kLGRz03urta+I4ClkG2wgOfugkGVOtx2sbuoJ9ZD8iHMOoLkmVHaqteYmBlxQaD0c6
         +TW0KmhBCOItQZQyWps7WAjSgcZ3VGrkh0iok693fcXGQnMrRuAp+KQ8NQ1950TlRQjt
         na2y5rzgrVPGRo0pQ4JLRkvSwHI9fyMR94EX/IgfDZBRHg6WTVN7EC2A6IPJHTP5xT/5
         cjPgBVajElv9VS/1bYQUBSoIc5TW4UyQZvNj6kuWGvqhtEx/ecijBw5C4Lo+kMThNrr/
         FN8ECG+n6eXFwBHZ0Kjmxn6TpRHUzpmSxhW4nGLCiILDenzaRmf7A9VhMiOnGLCM4Cn+
         CYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481363; x=1793086163;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zXxYSA1fp7uc/616la1Mko6BMnK8o11/PpBSN0VRISE=;
        b=RjC9T306ieKyOs6tO84xhf2uceDOXJOVXb59RT63FIxvQDfTHXbel+9paTLj7UPE4V
         o5g6zxhicQKuvwcINgbdf/OjfLzCvartq68lhWBC3gejhm857oz3qQ+wjW+M1/izpNPU
         DbkCMnEYaQxHniOWzc/PVeGi8cqm1jHdpT23sOTLsJKtbvD9us4GAQ1N5xf2tXWXHign
         K6RBe+sVuLHKlan2T1/MWBo4wwc4OGzqXsdbiy8asQcKXGhKNOyUgett8fHrsJKaqFWl
         3nJj29pUf9Bvt+MqtVhAx1D/TBCNTc0Qae87TrKimO3GXwlHexjD7709H0JWAo59RkIR
         bJgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZ2DINpLqXt5BsooFcfT02iwL85T03f0zJUhUmxiIlQrsmDrsmI2qxYFcBEtvorC3l2yA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1RK8NtefHj6drGN5fFk6k1fbrEWDTzEvJVpmN3vbZ48KbJRY6
	o/Vi2/BcyxXN7ApBzaWM7cLrVcp0Wuuvj8LzoRRZzzPqzOZNZBQyWbGw7ET+dydo5tuIaaPIAT0
	5251tTsZfs0Mq+CtTSnTaN7jy+EnCiaQ=
X-Gm-Gg: AYBFou3d18988ru4l2vpVgqplQrAdvYa/3nrXyfxkOh67K+7ZrhRLhxqUQnRgE2mRIc
	3EfRTg8WgV9kW5roUhw7tIEM+G1zY7uSp4Q1swX6iuj3XwVCNEFpdlivF8HLoTNgEPbOlF7qN9h
	0AIWs9qZdoLSR2ktQSa+pryHrnDW1IxX6hW6ZOwADUChL54UPCQakUzxnSKWFy5NAwDW5rDAv0V
	tGYGVRHMtaU2E4VxvnPjZeFCo8IXYaJ6W66lkDgDoUQdXVRQmnBlhHju3nB+RIvvBNzKXpzuI2P
	gsOkQhgVj+vynhUUC005j+z8sY/l+B4foTe7TrvHcSILZyIyC1ftHc4vOpbCgXB0tA==
X-Received: by 2002:a05:6402:c47:b0:6ac:688a:fe2 with SMTP id
 4fb4d7f45d1cf-6b3df7a706emr2355686a12.41.1792481362843; Tue, 20 Oct 2026
 00:29:22 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
 <94129fb718c0fd961df78550f6633752d474f825.1792437558.git.gitgitgadget@gmail.com>
 <xmqqse211hck.fsf@gitster.g>
In-Reply-To: <xmqqse211hck.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 20 Oct 2026 09:28:46 +0200
X-Gm-Features: AclHuK8fqLn_FHLbe7RyvsTSRiMVuUth1KKi9z18Lg26D7TJxh2S9kPj-JvpOdQ
Message-ID: <CAHwyqnXfP=RrDj_5H=sR59TGD3dFGRk4SXDU6d08QZkOh_GL7A@mail.gmail.com>
Subject: Re: [PATCH 2/2] imap-send: accept messages with Subject before Date
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> RFC 822/2822/5322 specifies these headers as case insensitive, so
> you'd want to use istarts_with() instead, though.  I can see that
> the original did not get it right, but we are making the wrongs in
> the original right, so ...

Thanks!

Would you like to see a test for case insensitive? Personally, I would
skip it since I trust 'istarts_with'.


Harald
