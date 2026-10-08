Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F1E42050
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481598; cv=pass; b=gJdi4c3SAVJuBb79tbDzQJI/e468qenqR/cP+kgnhdpg8lWhECth3HSvedPapj8DLbD2FBlF54ViTZkt6p4tvnn+eXyCwSmVIUP83UmF1kP4BBAuItrJAZPO7MqUFbl+1sf9Vk/I4myKBptByk5XOUY9Ye4rzotE//vvbRpLHjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481598; c=relaxed/simple;
	bh=duOL+mwptXqYMfNa/mKTsXdFZuWjaPtnHqbnJyzlMCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzoVTj+K+iQEH17qd212Y8eceum0w/7rP1huEyN74izoEa1ABiwlw2LKFpnnCGR5Lbi/hwv1NutzZERDRsqMg9yHc3WRgMVcWYCTOQBrRprObrbtVHU4IRjn5cUnwmCA2YD8iY3df+lRmkQ4dMCR9Y4Bqj0U9Hd1fgUiJ3NOR0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pHNMz4yt; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHNMz4yt"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ccc6b11a19aso1912096a12.0
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 10:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791481597; cv=none;
        d=google.com; s=arc-20260327;
        b=YYV3bqYUAxdjyRFaR23wrUzVB94ZQFeRRvk2xjswCi5s0Skg0i7D6h1QfpiKpQpbfO
         gFCteYILGpdevkJtw1CS8QFrbS2ibaoYmVy9NCiLIwRqTQSprdrJXFc4EOzkcYl51RBa
         9fG9ju/1toVhEhgHdEWJjbMuMp9NT3tNZA2YV/J/QRTN60e6H8jDTkeQ0B7X+QD4VF9Y
         pTUQxTZwlJz055nN88zoDBN2Ng7Zir+YYDZ4qWc6ZbOcXGUBkTqGAXz8XRGxOPQoD6zd
         CbOp5tEK9v5MSTMNo9DJK9RmzHYdgGPTqcWnCQ9kAXFRk+6nKwpE4Kyy0aXWDtEtwqCf
         SB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=duOL+mwptXqYMfNa/mKTsXdFZuWjaPtnHqbnJyzlMCc=;
        fh=06CT0CqfSxAqTJxa1ls/La6m6lSWgw1DvXGZzSeBAh0=;
        b=oibn+XiamVMhYZzNjtTtiUdiAD0SdBgpsai6LCSua3SQvVyziDPX/7bKh1oNHJ2Pfm
         x4azv2K8vtakUiIWyXdKNuCTFVwfPBpWkSSdFFn8OsM2B3QLzWpzzCsZYYJbo8kidiyH
         /nf+Vfwixpd+yCKXHC5wNNmR6aOBCJ96HOUS9D+j7OL3v8pKHw3029oukIYUZtRfdkG/
         9xNCW526nUUT7fCbetzTKDKtpDbeCH90H4jSGNMRaIth/rMJUFbkLlqWQHpR+OfqAckH
         zanMeL+bcFAK2jBAzNx8shJZCf9+sRcq4f4ATOhKMSqnnn4zMoErwzTQ4oz/lI/s30fq
         QIPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791481597; x=1792086397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=duOL+mwptXqYMfNa/mKTsXdFZuWjaPtnHqbnJyzlMCc=;
        b=pHNMz4ytuLfqowl5l8BbtiXFTL0GV53Pq0TvfM+9fKX0Yxr8u4wrJfr823sD8g3nsw
         cLUd3vZek7IcwEhjqlJSsIy+HvyNOyudNUVQOURXYEqA1dN+9o90TbZdXOpgRTPTYQVx
         zznbp1+Ya7DGlRDNMve5t1m3NTG/1qX7Wj4gA88zhc/A9p1jfhgfJdEeaYWAG26XjNn6
         8PMlXXM0KOGqHvHG/uxtm9VIjQXKZCL7mMy8qM7ncx3xGPHBerEG4wzZpq93WlK6JmMD
         qrHa2nmJe9DYFbae4NdykgXTP9MrxxQQrwsIQK3AaHCi01xXYARC7FWAoIh7izpIbUpG
         LJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791481597; x=1792086397;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=duOL+mwptXqYMfNa/mKTsXdFZuWjaPtnHqbnJyzlMCc=;
        b=YhCk5WpIZtzeQp8ja8hJMdOhwdfLCBzZVEiYe2GybJmkXmdE0Qj9Hh7YBBUDbSARhV
         FRMBwhxl2xVXM1A+2ag3na8l/U6e++E7HB7bI8EVnC1R3mXQ2PagueiC/BtXUiyLRI0R
         lcEmcDQ5EsmwaLHGzJtkZOZOvreekDVxpYcOLLJdLybI7dmDuTRtfLr6IxMv4iFaKJSE
         uCpKkbGDFzdzcRaRajGrD7aAs1eAhkPvCE+xKTTj0PscUtcSNZZp0zZRzr8juYETZHYN
         ++mJ1nsa9GRjeQ/nO0gH2v9BYQuboRaG53jPs/375rf5zQGOW4JNQ3PwrwnBZY3Q/+iv
         CdEg==
X-Forwarded-Encrypted: i=1; AKwUvBwsStSZiXquqIt1LlqTbS4BM4DBpDkgHgiUhXCHbP3Qe+kWvCBc+prIAXGrBwfbynjWUpM=@vger.kernel.org
X-Gm-Message-State: AFuF++kX0PRUdAvhBuEBe4bfJ/Y+KIoWjVGDvrnWB28A9FfwPBz8WyAT
	TU2SdpstX825hdSlvpTdADdW30S5d/JaU+XFOguMGZnhydqd25Khcso7fLQPn/PKtZ8P+qyRjAQ
	cCHCoB25Z9qqO87MHDKCKuHV0P3pqP+Y=
X-Gm-Gg: AYBFou3/Dc9Fn2FR/3vSM1zA0gP5ALDDaYxfCmToOvgc+po+WCWs8CBFfow12BMjaRa
	IrkVLUDw3mEfvOESszvISt8aGuMoClsMO8QEFOtgPkK2zI0UbYI1+1gHe5d7/aZYo4qV3VoIdlI
	8/6oZeuSnFvor9Hxx4af/itxmsJrJ3iTngxxO0qe0ZQuX8sGu85TG9369vBl5kTsEQsc2NuXEBo
	qkWvt2+OxZLYNcixQhX4hQTBOq6jpQqC7cFZxdngIqdsB1GSajrWFb6BJ2HRI623iqCJPrYxGMS
	cd2QPD/eoA2seMNvWQfonwOH0OdAyChmtnmxUawlBq/XFR1K/2f3WtvERiG0b4/Dqrspfqt1bKa
	chGl73qnHsE1tvaoeOGu4HDv6zWJevKDfi547aRL+8C97XrqVZ3wmVO13KY0GUiilpXAYUbtz2f
	JW1gkKfzZTilr4tPiTbHuiBpfNHnESsg==
X-Received: by 2002:a05:6a20:d4c:b0:3de:7bd5:fb47 with SMTP id
 adf61e73a8af0-3e164cffc74mr47306637.39.1791481596609; Thu, 08 Oct 2026
 10:46:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929112544.86511-1-scott@gitbutler.net> <xmqq5wzda0h6.fsf@gitster.g>
 <CAP2yMaL51H1OAG25nQ0NuLQLb0wevd4CicCG1_ezsJfrZDqfUA@mail.gmail.com>
 <79ae606b-cf99-4867-9db3-bcd7ff03626d@icloud.com> <CA+Te0V+-O3avrvH353KfCDjAEzMa=_H57G4OmiJ8+d1dDzZ6aA@mail.gmail.com>
 <CALnO6CBbtKomawqc81MPV5Ngtc9J3M1ej4enGD3ZUzWnPSfsgw@mail.gmail.com> <xmqqece015k1.fsf@gitster.g>
In-Reply-To: <xmqqece015k1.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 8 Oct 2026 13:46:24 -0400
X-Gm-Features: AclHuK9Yz9UhIrk2hT_Fx_bWBlZGwuMj0kq4ua9pT6nPaKCy8KRI_a8MsXXPMD8
Message-ID: <CALnO6CDNm2cRNqBU6GKNK4axn2ij5uDgKnAm_itj36oFECfPQw@mail.gmail.com>
Subject: Re: [PATCH 0/4] faster SHA-1 collision detection
To: Junio C Hamano <gitster@pobox.com>
Cc: Sam Reis <sam@opencanopy.dev>, Sebastian Thiel <sebastian.thiel@icloud.com>, 
	Scott Chacon <schacon@gmail.com>, Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 1:10=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > but I didn't see a discussion of licensing at that time. Perhaps the
> > idea is that we are clear that such code carries a different license
> > from Git?
>
> We are GPL-2 only, which means we can incorporate BSD-licensed
> software as long as we satisfy its license and copyright notice
> requirements.
>
> The above is not an AI-bot-supplied answer, but what one learns when
> talking to copyright lawyers or reading books on software licensing.

Thanks, that's good to know---but in this case I thought we were
talking about the MIT license?

Assuming a similar analysis applies (not clear to me, but not
implausible either), that might also answer my question about Gentoo's
license descriptor. The product is GPL-2 even if one input was MIT
(though it feels strange to effectively "re-license" someone else's
code this way).

--=20
D. Ben Knoble
