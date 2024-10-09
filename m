Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296F5198E9E
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478726; cv=none; b=LpgXT+h/7yMI4R6VyMjO+v9+/nYnWVOgaumKcEZ3wLLJGS39YIPmE1BqYh6wbvwk4/deVnCJS+7DNLMET1w0uKuzDbLudHYxV6P10RGFaTJ6iScS9ZK7zO6gbRHRK2H3cTPtVvA9yk52emR7BFnWiTtfPIgzHQi/JszDcumkgAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478726; c=relaxed/simple;
	bh=ilq7EnfezLI88UAfFtiKoVZ+EyorvN4ZUGVDCOB3clo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=PLNI6XxnyhLBwIe/6mB7D9YSGTL6WKHgrBGQUOP2ZZe4JlKI763zEK6uaHAkX7q1mO00KyyqcZBSVX2xCv8lPYCWXAOsaGcEdUeout12ritIgUpauyV7jLT18fg0LwsPJQKR0d28/ncEIWSrZ2uJ9rGUqcW1Bu51+mPZpzy3EyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XF5Ca6B2; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XF5Ca6B2"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-509fc9d2074so1963414e0c.3
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 05:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728478724; x=1729083524; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ilq7EnfezLI88UAfFtiKoVZ+EyorvN4ZUGVDCOB3clo=;
        b=XF5Ca6B2mhVqmykrBa69JW4en/nDAginFffmmS9CRrN3tevtCC2Fnp0MwfS8QkIHY9
         Jyip5EfGminfz0wCvtk5XvWtWs4NfKnUCdrND56oSNxeK5INAfoiH9e+d8e7l8j63du4
         Kte9aKCrID0/B2/xQO8vMRKy8uC5CZWQTn7kYBqKg8GP5UdHoa1exxwo07EQi/pJW9RF
         bZ/8aW2zCLZyIG8Bvsvs2CSSM8fImwUkEsTuNm/r7rAG38+XFqvl7N0vwzrWuwX6omiV
         mvEUXh3RWT9Uxt/5Iij6VmbHeZDYyz6ZqwYLDGaMtEemBOiPxWHxFhZ7x5oXG2Sd5GAG
         U2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728478724; x=1729083524;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilq7EnfezLI88UAfFtiKoVZ+EyorvN4ZUGVDCOB3clo=;
        b=sttwuuGG5+sIF4KoL7FseE8ynkmR6BLuc99iRRc786XpsmHdVUlMwPcK/Q/ODtQdMj
         CswV2BvTCIsFeEUMmwys7z+kz1tjeJ+aCYvvhgPF2/pHLEAQJny+3Lmu8QGNGX9HYeMc
         4D6uPi1+W8b4NYehOxhPxZa3l7vark076hlMsfzA7EjH4e3fxMmbQbsnEaCYnqwDubZK
         oo3ROSReWRqLIlPRu9KwCL4MpUQ98Zh/fxrI3xy6OZ4fkzyYPhmIbV1577JOb+pwEWHs
         UyOIpDrOjwsIMKVO0X4T4srDe1BUFpH9bGyxi4ZHwHLWGyOdd0woAJgOqDMvoj5NasMt
         l8Ig==
X-Gm-Message-State: AOJu0Yzz3UKxdouFTehwhXmK35OAS5q6esxLVHX5yBlX+Urt44OYydWA
	seMZztyZypg+khCk4N2lpQAHIne/hNrKCQ9hzvcFNOaFR+RZxaTmn4jTMezoon86eMfbI6OlE5+
	SniSohSx+g9Ef252YSDJmPw2M+Zcz7ELL
X-Google-Smtp-Source: AGHT+IHS0dmzPd8mGdAFjgkCQMyKQEx9DmQoUiNr6EQTXdEjuENHc7QZNoMLqyRrGOC8k2O4S2fa4BjmLqXEv+yfcKk=
X-Received: by 2002:a05:6122:3087:b0:4f5:abe4:50e2 with SMTP id
 71dfb90a1353d-50cf099feebmr1229418e0c.6.1728478723972; Wed, 09 Oct 2024
 05:58:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Oct 2024 08:58:43 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZQrCxU_tUcFsrAjTxq2ufCNk=zox-fsa_KMenyCJr5gUg@mail.gmail.com>
References: <20241009125109.24422-1-karthik.188@gmail.com> <CAOLa=ZQrCxU_tUcFsrAjTxq2ufCNk=zox-fsa_KMenyCJr5gUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 9 Oct 2024 08:58:43 -0400
Message-ID: <CAOLa=ZTY+XYQE8GRz9qigDqiu=oJUhSqEGhXevkuW_tqaoHyxA@mail.gmail.com>
Subject: Re: [PATCH 1/3] clang-format: don't enforce the column limit
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000058458106240ad0af"

--00000000000058458106240ad0af
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> The current value for the column limit is set to 80. While this is as
> expected, we often prefer readability over this strict limit. This means
> it is common to find code which extends over 80 characters. So let's
> change the column limit to be 0 instead. This ensures that the formatter
> doesn't complain about code strictly not following the column limit.
>

Seems like this mail got double posted, please ignore. The original
thread [1] has the full set of patches.

[1]: https://lore.kernel.org/git/CAOLa=ZRvFBhageS65uE5enzLBz7H_CAvvnEcPsi_QAi0exRx2w@mail.gmail.com/#r

--00000000000058458106240ad0af
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 42b4e67cd72215e1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jR2ZnSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mME1iQy85TUdYVlh0RFM4eTNtcHgxY0RSZHZUNzY0MQpNK1lrTVIxWjRo
N3U2aVoyZzJlNVlWWTZHby9XNm5Yd2NxeFg1OGJNMGpiWlc4M0ZnTE8vZVVwanNrOGFLL3FYCi9G
QnlLaGtTZSt5ZDZ2N2lSZkFNU3pTeDkxemUrZ1JMK0x4ZytZTWFvRmp3elVSZ2hMRjNLamlnMVlj
U3pBTUsKcmxuQXdFYXdtQkVneldtYkRDaC94eGlwUFZFN1BWZGZhaWVpTHlUU0VQdjJjT0ptUWE5
dFVVNUJvMnUybzN6UAp0bEhjM0JMQlZIajdvK2t6Znl0ZVdrYVlDRGQ3OUFrSlNLR1l4YlB0eSts
K0N0MCs0OUJRTlVKdS9IUmx6d1YrCnNDVSthQ2VkZDhkWms4RmtBTW5aaEFVZXpWSWxwZnNrUXlU
akpSUVI2N1FPQTZlU0hod3hXUDgwZGtzLzJhajEKYTZmbFhUQVhySlV4bXNLOC9nbzVycHd3b3Vu
bHVhQWpWUVhVbTFKRC9BVUhlVXk2RlJPbU1tT3pGRjYrZHFqWgowbDhlcTRscEw1Y3VtN0dQdk1v
M2pDZkNRc2s2ZnRFaWVYb3U1ZG5kNTRwSlUyL1lnZHZxY3h4ZzM4ZU5xVkE2CkNyQkEwOWw5QzMw
VGQ4d3BjelMzd05TUmlka0NRdVdPb01VZURiND0KPVVYcW8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000058458106240ad0af--
