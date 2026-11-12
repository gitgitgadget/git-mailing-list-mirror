Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794511920;
	b=qk+lBBTQE/IkvuNaTJIrP+3DiPinE58ko8LzBrRKAl8Kn8ENnFUaqt/5kJkV49Slm1ir
	 AJa3jlAYOk9ZMuIZQRWClOkid5TuMgvqlmvNth0e9vtg0EuBZNSjBCR3gqfMM/jFejBAP
	 vu5Q3oYUaXmf8mcLjuIM8Lvxu9AY6wR3qwGp8fYRmAd6D/a64t7IZzL92sPlXsvoCdaSF
	 aq4gLYLvJnRE4rjYWvZhAwHJdYTw7Rslsw4D69KYbBbSQRl5Gj3wTmVte+19azfhCJ1Km
	 c7CXKsgfPO32xy4jvTAE6bz0ZER8iHfJkTy/auvuCrqJqyloyYEMiPHafGMw9AyKIig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=/vHIl43/M1pJrCOfZR0zR7WICwjR68w+Hl4mQEPkNcg=;
	b=y/HBLYN9V3SysIi5lJxLscrwwmUFrlwrwsGdLBrKrWG8pw/Ekubkek9RvQQFV0EWUece
	 EU0SOuTerkareSIlKwDKpYHxjiaoDxgcrFug0TpQO42EOrKRRaqRVJtSUDELMp75FE1JM
	 AwzLQgvBxklC6XdA4hPXyJhhSNF4dIVBB7jRjoLiz2d8r0R0TZs1Ivjy9rD6syhPEWGcw
	 n8ooHLgwZuQ7I72jrEJIqO5ppBJA1sr0CP+hVfmai0uKmZWI0VtfEgEMhSw1nuHCzIBJF
	 BQ+NypagLMVEAa5cRbWVK/D6jDaAgCtzRY1j4DBzKDADXjKaBhCstc9L+ITBFSPKWYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UEsgkP7a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.172
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0484606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 19:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0484606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UEsgkP7a
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a49a022221so926241fa.3
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 11:31:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794511918; cv=none;
        d=google.com; s=arc-20260327;
        b=BNAIKRCdLv9SXX4kQYaUI6xC0fwksKypBFdeKJQkGDoL/SIjLKklpO6BjTVqN05xT/
         tXvO2SyO+Ps4FbQLs5g089zziVMdWQetBOH4g/YUX7oioHgexYKWpv5yIb6xAkMidSeV
         aq2sNQCbo6Xxp7q1W5vhczehqTysHvmzNSrfN9z8avlrBwdInPQrmsh5a7I//gaSecPY
         sApOXnNM0RHW3Hkdb8ORgJ64sEoEEt4oHk/DCREoUj4Wp2o4siX6uyjXgziFkCrxKY1H
         pPxPrgXdp89K4BJ8hYlTlGELNoUXMgMTKLRyH05vOib0P2dabOWMWUthoPmflXxYHFdy
         XZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/vHIl43/M1pJrCOfZR0zR7WICwjR68w+Hl4mQEPkNcg=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=WQ6VpgAVfWShPOLIz/5EmIZ3cmDarEbr3Edb+W1aXdEdH0NNlhkFXEUFSPM8wJqiSC
         R79WzSQq5gQlgoGYclK3IeZeLsWZC3uwmoubDGEOmimaqE8SnAFX5DwuFvr2Xl0e/5ju
         FQbUpYEGDqDLpvr7vWyO5Ka5s63ZM+uTQphTo40ccd/ck8wnLcf1OBWdyWGYnYKVRgbA
         HBeZI7v30BvW7STcvoCj+wV6pMPNGClMhIBUnNRDgsWKnTEZU0IM+WtNJFX8F2GhVAt2
         yHPShD3Fq7l4jBiac/7RBCrmBv/XKe8UkBYVfIHixQtmfge/wxhGFlcKMMeiVEVNj5+3
         N2/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794511918; x=1795116718; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/vHIl43/M1pJrCOfZR0zR7WICwjR68w+Hl4mQEPkNcg=;
        b=UEsgkP7asD6OJU6/VqPEYWqCHBPNLEi81p0QPM4p3fenXf3LmJT8XgREDqdhqMtuoZ
         O2G35Q1UuMb/B7u05MGPKPhoDxdCV3hh/bc0aiilC8Y+vvhe3FgkX3gKDtIeOlyxgtdU
         VSGMNg1rpLnqiVTeM7/M/zshL8DgONB8llB54rK+fLwhcFnra316B2kex5c/ZtwDqfxO
         eOA633hyLUJuVvU/2GV1ALZrHMaJUpt0dSPP4GFbSXenufQ5/F/Ntvuf50/rpS8IBA26
         BAHV/00i5YxvxkjES3fUQ9we7d3TxWY4iHS5ZswL6TK95lGvx1/XX6VRWip1xcwY0Eua
         Q+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511918; x=1795116718;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vHIl43/M1pJrCOfZR0zR7WICwjR68w+Hl4mQEPkNcg=;
        b=SuzIC7D0H4NKDyh/TlNr2uGTSLoc3wy+gGqefJ3je6dArvbNeBD2Ui8OZIBGxqbfSj
         eQmuClpfQMDXJojm9eqwCiRghKCJ3GFtA8oPvJFojfH+vmuvkwE/zzQN6ygMCBXPB5Cq
         GUlXuPJaM2i4ptmp048mImK4IQueryssg6bINx5Mh1ApnC0PBnRbbqNbfkDhX4k15QLF
         Njm7ZN+URs928gW5+npW2k62IH980iBmbyHR9CiJOhr+EOIR8o18hYULGHP3adF9vL6s
         wHXBcYjAY8mYmWXCwaG2PydzW42hp222lbT+hxEpH5SyurNb4YVWd6VTjUr5QHKch3E+
         RzUw==
X-Gm-Message-State: APuU4Z/a+PHyxfMp1QrfjnrRYg7nb7O9nsEPnxw30uZPkmzAZrMDKseT
	aM8V68aIBl/hySEnxs6+VZ1sFh7uurbSUdDszZoaLM25gPi2zhZveWEXUmGN0yoDUAditXDrFfh
	d+wOIJlXWxi5Eas9fhScif/jWn0ntmDEC7Q==
X-Gm-Gg: AYBFou2QPttVx4CzJIaevRLT4ylrj+5Qkn9HqpQZtANoQF+S2gwa9pxlZeWlnP99AJT
	t7G4iIFWbsy5DTWV9OCFxGRSEbQaOrpNEJiGk+pyhQ9p+a9YzhTTCtxfpOoIbXmc6yuVI67fDWo
	Wzf6+Zk4lGGuJqn8/3flBZk27GM+xDQKdvBIH1X809D0KxhVnEZgVhJSYeneQyHONPidIGKFefz
	32Yl1W4Odq47vNYOaJh79BopS06VY8nXhW92ufNbA96vubfd+y6Owec1cwZoj7klteZRyUhlnHN
	5v7CaJvQE35kmv2S8oINZovWr1hPEJYFhWLTpMTJsdrUmX6h6cdOOknoxyEVPS5K7k2o2iKq9Jz
	5kasq5E7kiNlqkFAcTQzyjgWGSrTWhKKt5uavteW8FbrcfEwgPnvKpZ2a
X-Received: by 2002:ac2:51c7:0:b0:5c1:56f5:45c4 with SMTP id
 2adb3069b0e04-5c170b7ba7emr129641e87.63.1794511917841; Thu, 12 Nov 2026
 11:31:57 -0800 (PST)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Nov 2026 11:31:57 -0800
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: GEN-Z <duke2nuke4109@gmail.com>
Date: Thu, 12 Nov 2026 11:31:57 -0800
X-Gm-Features: AclHuK_Uhr8JQrCQnXNvjskqqzMwHEoM4Kkg5_gH3314WnNziKK3ncrFU_al8P0
Message-ID: <CAOaM9kds7LPvMgHkQoOwg0r9AmQyn41TptJKZ9ZECOJfc1mWzA@mail.gmail.com>
Subject: [GSoC] Microproject: t4150 exit-code fix, is this instance still free?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm Aarambh Maan Shrestha, a 3rd-year B.Tech CSE (AI/ML) student at
SRM Institute of Science and Technology, India. I use Git daily, and
I've also re-implemented some of its plumbing (hashing, objects) in
Python as a learning project, so I'd like to apply to Git for GSoC
2027.

For my microproject I picked "Avoid suppressing git's exit code in
test scripts", the instance in t/t4150-am.sh, in the test 'am works
with multi-line in-body headers', where 'git cat-file commit HEAD' is
piped directly to grep (lines 1097-1098 on master). My plan is the
usual fix from t8003: redirect the output to a temporary file first
and use test_grep on it. I have the change ready locally and t4150
passes (87/87).

Before I send it: I searched the archive and found Trieu Huynh's 28
March 2026 series covering these same lines, which Junio asked to be
dropped as a 16-patch series. The fix itself was never merged. Would a
fresh single-file patch for just this t4150 instance still be welcome,
or should I pick a different test script instead?

Thanks,
Aarambh Maan Shrestha
GitHub: Duke2nuke
