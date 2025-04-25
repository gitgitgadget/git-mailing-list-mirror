Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220C124DFF4
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585518; cv=none; b=lfTtWpI6Lo/fZX7VBtCWB7ygj5y8de+K15M3DSv7BbIogJszCZaB8pXEQ7avrw6S53n/fzMaMtMkM/6lHoAPrjyida3xhWN3BpkSni99ZohdFp2E1j/6LxFa3RIyFVRmU05wI2sSqnRXjO38zWAMVvQrPMJje2cG2WAfozsxu00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585518; c=relaxed/simple;
	bh=InJedEMdKrTuce4WfhHoONT8tmXXX2/1cQwWXRyfdZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEXQyUlcq7VHWkqGr3iZ7F98J4Z7Jghi8LN3Rk20BOjGdTr4jxA4xgTlt9EwXYrhMxopJqmZc7NMJO0yiff75kYBFfwZu/VWi/3pkr/50/903/CvpY6NMV2B3MXBBFD0IoL+LqxlGmOEs56/ocFmr6mlrtskvj82YEX6LToj2VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8YeZLRs; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8YeZLRs"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so354044566b.1
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 05:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745585515; x=1746190315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puueVrmAURWG3NvpG9LfwmJqjx7tQIqtYli1L6RCCYE=;
        b=a8YeZLRsul8NctHyFwza/0MJOxnoZtLjY2cRj0KLny2qmD6jjE+2yb5zXuw7xy2Qqg
         eMOWaX6UubKlGdNQde8Ggt8im6Vo4sTY28WGp8Hsget2YzF5902RnLm0T82BpwJznrb2
         sNIpHsF/WtD+9ifaLifAzuuhDd3Jpm3UD2dg1jUfrVoaxhOkuvdNdAIibh/d+S7GEd33
         zixYKe3OYoMLCXUZSL5TPWDLAVWWNGjAwyLoipTd/0aLKiY1k9/WDNAt+i1N4mep3T9b
         wYi5dqDuh1Z+2GdekFMZtxN/ExPYshCZVGq0oIoFWOdIaEJU3co1iMN2nTJ7ev3IUFhq
         R2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745585515; x=1746190315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puueVrmAURWG3NvpG9LfwmJqjx7tQIqtYli1L6RCCYE=;
        b=biiF+KjsaEBdTX9ddZe1rvLjh2bDmDYig60ErDEChwHOonlSEIYYDwzxfa7u9dgKo6
         Wyg5dtZgWQyVbPJil+1NE/gmlMnDf0E5MMMvj3sFC6NJ/97LoABuWEfGPmYPudFKlt9z
         e2hHfY48UV45BC6nQNPT9CuW1eFzY0mQ2pqzI1WK+EB3zjRWg9sgxiTqQNXUFuzhXN2f
         6hc8EWhMPEGynaSEyhWOdubUuhvUggiyYNicTUK6FBMQUpRNExHXgIxGuDNzVtMBwO47
         o4nOjqVOtAR3RfmUXhHwUNo8ZGrYMbZ3SLce9SDwDILqFlfHhLrof+35zs+3kVreg05W
         robw==
X-Forwarded-Encrypted: i=1; AJvYcCUW8nbbTgvHQoWZ6bF2Qr0Gixtfaxvau5nUmFWDXTxdF/2rtWRO6WHFELA9IDBR88MCp+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVPYIwNsxPM8729YGbqGQhpP5DpWq3XXoshkTpA2+6TA227KO5
	76zx8XuA+t+2jLi92AKWaJSO6mDYDFHHluiKV/EwEPy9Y2tx1d/YpxmHb9fXg5790MLiwAfWyYV
	HV/TlFR6fgjG2LiYUcwXoiirHSho=
X-Gm-Gg: ASbGncvx/ecLW2s2pproMP0jgSQ2CvaCrAh9HOJiUv0c++3BFAnrHRG/U8CPUiqp21O
	KrtUiR4PwlCaCGCk/T2v+H18agG/kp5c8yzO9GfBaQskNOsP5vyQac20v+bRFTyd31jgydT5TPi
	53gQzT6y9gcLny4NKu6kkyGFM3izIpFEFC5G8URpZzXQFJx15gTrNSNuax96ikAEPmIBY=
X-Google-Smtp-Source: AGHT+IH9RsE6aVAg6BVpaIwON9LT/meQjak8Yw77cHms7/XnytK3pO5FhHAXrfxXh2uq7LPYn8jZpkJ877EmpGxdHPg=
X-Received: by 2002:a17:906:3d6:b0:ac7:cfe0:3014 with SMTP id
 a640c23a62f3a-ace71106e10mr173068966b.25.1745585515061; Fri, 25 Apr 2025
 05:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422213133.18685-1-lucasseikioshiro@gmail.com> <xmqqcyd33kba.fsf@gitster.g>
In-Reply-To: <xmqqcyd33kba.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 25 Apr 2025 08:51:44 -0400
X-Gm-Features: ATxdqUFc3PeEVbTLj1HKtcEkgXyiZ136U7m5_YwSa9aDeOGyeSgjwslR42fd4nI
Message-ID: <CALnO6CBw0asD2a1iK5UCDX4KXdr1+ua757nt6kEH9fdED2Apvw@mail.gmail.com>
Subject: Re: [GSoC PATCH v2] revision: remove log_reencode field from rev_info
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 6:26=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:
>
> > Remove the log_reencode field from struct rev-info, as it is not used.
> > This field was introduced in 52883fb, but it hasn't been used since its
> > introduction.
>
> "52883fbd (Teach log family --encoding, 2006-12-25)" is how you
> would refer to existing commit in the history.  I'll tweak that part
> of the proposed log message before applying so there is no need to
> resend.

With the usual "git show -s --format=3Dreference", in case a reader didn't =
know :)

--=20
D. Ben Knoble
