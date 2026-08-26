Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D010635E952
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787760286; cv=pass; b=iQQq3xF3btgYM+XizelMAtRvZ0M27RY0yHzYzPg2iib/YBfOyPAzgwVD1Cfez+wBrS8F0KcuIwSoixE4kHIh/waN8WmfRQYQi+j2R+jYVaPcLzZN6JDNVIFeKnl1yHb1josWRSEuuP7j60hUyMVzy/wLkTFcrhdR2Sh3lU26Wl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787760286; c=relaxed/simple;
	bh=C3gh0gMaJIfmHsgFXpJjwLGd4feevfMF61RpGTMlrjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAHAEO84of9FBqAT0m3JH3Pyu6CSwf2AmPJUwJHCyjQbsMzWcjhUyGmpNfsoM9B5177oKRURtp6rhtWWj6H/Q6go4rXI8Rt1+PDFDhomGi7mC8NvMnJCxQcJmR4xv+59EQRduCCIsWTUDC3JWt17YJuM7gLJ/kqSTlN2pneJZDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jp4kq+Ka; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp4kq+Ka"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4650773fa99so853423fac.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 09:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787760283; cv=none;
        d=google.com; s=arc-20260327;
        b=kn+TYoRkOvxGBzm7UR3Fl2OInZaKE3M6Qm+/stztq0uJjs9bwf2EFKUFc22tsZsMfw
         Cb1ceyfNuOAAXOqVp/g68AwNgyZq/+enfwecHhxxlnXUmDQXtxxruCob3+fTGYNRgs1n
         UatFpEkMJtIVwtxAqJG5XCgbTPWCXttIuCvWD4yjbMadxUwpQyReJm2eFeCxTEsh+XAr
         3vuVx2HJRfjDZXglHbg88pRvUWayXyeDrQlDc6QpP6W077kVkG8+fakpin5XVyD9CNn+
         Jou/GJ9CvESYJs3HsiwMQP/C1JZZz3K0rFJHHyV23B5lwq5NdmQfz1z0yWn8aGJaCAtZ
         6boA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G/xEPkGPwyr4oeIPpK/jgIBsWZ+ERe3Jq9UHqhQT5xs=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=ATRf7fQzmIA6yGEvV9uZNOKZkeyFajn5ics1vnbMv/e7wabs/WYXjA3iK1FQhkJeLl
         Y7B2Ccyj4OMgHajd/AveqsI8EoTxCss71sy3ney0QJQE9230VS4ZDES1pLxn3ctq6uF3
         df2IL8JWs2WXkZOjxBNhvbRDAWVctn3hsJSWLmN7DS6L1D5vB4RuA42xN4iCxp/EWm1D
         Xfiad/98YuAQcRMd2zusEKd/XkUspi0ZZJXDaYCzejJnMXrt3NZtSm37rT2QngQUP5VA
         AGapThvS4eG1pr6xw2T9PU/RwjDyGxrI1uUtwNqFo7b8n329jiSxr27FT2eYJNnaNT+w
         Nkjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787760283; x=1788365083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G/xEPkGPwyr4oeIPpK/jgIBsWZ+ERe3Jq9UHqhQT5xs=;
        b=Jp4kq+Ka/i+1X95sW55s44bTGTeEwUfZl1B3OtaRuUgcmqnqOsmuEG5MN3XJKdj2uM
         CHzEVvtNXZFrDhhSHbaV6l+s376tR9+nyxlPUwyKGgCcLEsDaPCbTMXbOwoiaRZu4i2C
         biDZ4H1qxybaf15+n0iK0bdMkoAPzF65HfGgcPEUQWWj3SxGc3uB8zdjUzzxwDKcVjRM
         JS6eoEfYLp/x+ONWSXOIj8i3Muz5oBKyuLN0YvWVC2m5pogWxuE82/ZgYNr1hGCfyg0K
         m5Ewmtxh3uAXmXNPJnYuDCPiWQKzb94oTdRqJ5sjgZwnE4g2UBU2m/e+mt5YWtBfqSjV
         x6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787760283; x=1788365083;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G/xEPkGPwyr4oeIPpK/jgIBsWZ+ERe3Jq9UHqhQT5xs=;
        b=MbTJ2oNRvmvH/l4pBM5U0HPtothBbn1/gZpx9JrMVpPxp8S7/OOISDTBLVPHFKUlKq
         p0aj4alrD+Y19cDTreyFkGlsiH/eQLIJ9snp6fpBKiUjnwcETINLZfeH/kCafqsadiPR
         rb1C8oRiHPADZgXSalfREXZqRcCR6c7coHch8ZXrP6BwYoYA793Npw/k6ZrlYK5aFKqD
         9MBkTe2GuKJYfNKDLF9rlfKBHpuwc9blt6iNJtP8CGVKQx3peW/zsFxPcrnipjAyD86v
         LxS75AOMgigRTtEOOxQmg5tzwsuWSsuzceFI9XXqwILfwFm1vO1MwZrzxfFsv4H5JY9O
         JZtg==
X-Gm-Message-State: AFuF++lGvICHzST+BfVjdZh1VhkLDjt7n3yX/CLgISCjlelikBGLdbjt
	pi2tK5r8yt6fyfeCDcK2IYQbtqs6j/HiX/dcZviNclp9xkgWCt5HSP1ARf7LF6TLI0d2uUBsQRz
	VgN0IgUZdPZi0HiUPwvXOIaPLSey9Bz7mGQ==
X-Gm-Gg: AR+sD11SanfCzD+cq1gc4zNywSJ1qDOiYLzQrjdT1Ahqiy8Q+iC1UFk1nmOnZ9A4UpG
	PX1w3Wb4TUNU9a3K7lNd/Y7Us4cWpf7NumnXUz04nZ6gK8PTm14onpjaTI+LipCS71MHnOQAovV
	WcbrF1Eq5FvP/hK+GKnvpKk+p/eHz5ZzmuuD5gLucbA2kLTOYbt2LA+T0w8dVD4MPaouLQs0/G/
	PENsLo1HdR7NfPFiJvlEOmzOp0pN2cYre9nZG+7yP4nzKxRDQiaWbm/+yIQ5gOetyc0vsS92aZa
	LLCzwRpzmexL3c0IDQ69t0Zgl9j6UXSYauEsEosCPf5tstilIUm3lHA01Xju8TZjlYYcynQcV5I
	+EFpx54jZpe0C/ZOyaYz65ldBzgbsR6MBbA+0CM6ba+ZW9vl89eBteIRnWNfk7cxBOh85PvTbPw
	==
X-Received: by 2002:a05:6870:b28a:b0:428:27a4:ada with SMTP id
 586e51a60fabf-46599a1944dmr7203828fac.10.1787760283566; Wed, 26 Aug 2026
 09:04:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqo6epj6is.fsf@gitster.g>
In-Reply-To: <xmqqo6epj6is.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Wed, 26 Aug 2026 09:04:31 -0700
X-Gm-Features: AcwNN1Vp33YS4I6ThVTYDP167dSZwK9vb12vlNttDnxF4bUFblxCDSgZHRLcMeA
Message-ID: <CAC2QwmJ_fjNw9z+8an9Doq6Mx_29R5mcGXT1=NnVvu-g71QByA@mail.gmail.com>
Subject: Re: [PATCH] you_still_use_that(): reword the instructions
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 7:33=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> The message is overly long and may mislead readers into thinking
> there is recourse other than adopting the new workflow.  Clarify
> that it merely helps them find a replacement, rather than offering
> to reconsider a decision that has already taken effect.
>

I think this change makes sense.

> +                 "- Send an email to <git@vger.kernel.org> asking for he=
lp, only if\n"
> +                 "  suggestions by others do not work for you.\n"

Maybe a slight reword to reinforce the idea that the command is not coming
back:

  "Send an email... asking for help, only if suggested replacements
    for the [now?] deprecated command do not work for you."

Other than that suggestion, I think the change looks good.
