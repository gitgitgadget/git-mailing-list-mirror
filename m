Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C9572683
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884687; cv=pass; b=KBBF/rHa+ZmzrKjlxQAoXa0d/usGj019UHSPUgPmf8Oqd9xX6iKqGK+VAA/SlyzkzuK0w9KRFmUuiqSxftXpjkKbeyVNzNqPO71mLEXEKpK2AD4TaZ8eiB8ajAf7bm10rFJ9kxNw6UVFKod7WjTZkRRn6EGJiTS3AyqDlxke3Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884687; c=relaxed/simple;
	bh=7iA4XdzMt1KM1dYDj5nqmi8EB//PvfO2xk8Nv8Qe+ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1b2HMiBMEETqeme0Ry/1A5smZECumPVmrEI8hbdO7zYcpiLSCxcPbmT8UsYvYUbg09zazYfIlN6ltNBTcclZSKq4v2QDoJqzU396gYdVaQi9gJjQLwT1e4a22xFpPuPrKQ1Sck01xiA2IoK+mWb41smd7DaER7gQufA6NPORso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2kGPHai; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2kGPHai"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1c8d4a959so3234184a12.3
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 09:24:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788884685; cv=none;
        d=google.com; s=arc-20260327;
        b=CShXEDvRnyg2MkHLua9Mkz/14wdG65R5AZF+pHADrhqHg8w82CyRxQLbhXV7JWhcst
         BICrWGMSRNEM7J+1Eh+WbPW/34GzrnQl3MjT58YJA6l+5QFek6Sciv6yCAzru7djmyvY
         p7nkPQUeR+5pqfx0PVPPF+EwTXA0n0f5+mPFgHrBIWN9ZiQdgOZ/OWFeCWSoxq8rZAK7
         6USr8N7koF/KbeoJZ+qJrjN5iosnBoU3d5CckfvM1ws+9TvN0iIkjku4OEP2XUS8NEho
         7o5jQsGR0TnFK/wYOXw2FyFU6OYuDkYqO1Cd2hyJNeR1HqdxvNhdCqBYUZV6b0qkVC7M
         eetQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7iA4XdzMt1KM1dYDj5nqmi8EB//PvfO2xk8Nv8Qe+ww=;
        fh=693jtoZSsGxcO3g2vCZOFI2EHkMwHfMiK15qwxBZI74=;
        b=ODjhsW9c+b4MBpj/XUk82hs2nVDXeCE1z8VaCUuHXrQJKSmGi5ATa0OwM2jhWuefow
         glx1aGD1+a50AGE69vONyZpsKV0Gtoj17yLqrRocnSGCNZKxNQI0PE3rW+9UgDOztYWN
         /OEpgR9zEEwUj5Sxy621cNYpa+tdCgOUsSD/UsG8jKLidbG65xG9X2SjvVKRBMu6+lnn
         7C47d++VEptjIOEQp+rwUWrdpJr+FDuwbBUBVdOs1U0hmxJEbcMlnL/y9F4M6RySlskC
         JItGKrKvWALeS9dGbPAT8EKZ+HeEidUkKKI/DQ9Ks6MQzuu25/3UuL3Rz/H8T5+0Gb9F
         McbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788884685; x=1789489485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7iA4XdzMt1KM1dYDj5nqmi8EB//PvfO2xk8Nv8Qe+ww=;
        b=V2kGPHaiiqvxh7P5bKiJQq/+mrx7H1I/7DTl5R6cFCe9ckAAp6CsspBZAG3K5xmNlF
         6mZyPgJImhMbC/W7tz40p5kRn7TomGhzMsCLAnCe4qyPtRuCIi/L/GPB7HLVZheeudi4
         y6SCGeoN36cng6G32HC2vhKBQDDv1WxcovOIuabtLxZ4+2C56nOS4ve1Y5T5QFop7Cgc
         x9Ee3Vh8a+O6O2lm/psyELGOtYikQwtp9wFZvo5ksjbnKf3sT2TWskUpnQXO20JUchuf
         VrJAsnkm1X8kMLgfq18CqNpKHD0CrZ7imOR7EITrxR9LQ6EJjMXndnU7ElURZzhUlrnK
         EQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788884685; x=1789489485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7iA4XdzMt1KM1dYDj5nqmi8EB//PvfO2xk8Nv8Qe+ww=;
        b=nTBZqL/ODw6TIp7FbAw+WMHk5DzSvlWvfRyQC02EztB2EVAJfIw2AvCA0kWpG9HEGf
         WMe3vlTuRcsyLmJMqzuQRIgZGGbeJvgPD+35MPbcVbkYoUgOBvaUepeI40fGeVN81zng
         LSgd+mfJe+sWEhHlmY8gcFtTq9Fj1+mTCHA+zqiN2P5GQ2T1FTWy2QSVoyFkm0C7FCCn
         Qn3qtyy+a552Of3P6VT2+PEw0zc6ayUz8Ji1qlgbISLSDvzimNBGDhKQzQ3yVUdnqxqW
         fVxu46zCnasgHW2quDmM0HdTGSaP1Z7nKOQetGgcjU1Rp1ewi1CT+E68b+ftwpHqYDoh
         YPaQ==
X-Gm-Message-State: AFuF++myqHeGdLDAzoRoZ2lKMhp+7DLSRnODbiyKdZw+JlUMkbQAtJVj
	89lbO54GTPXtfOGYfWqI0wxn695rYPwatToXPTbIV3Qs3+aFWe5L8iUtk7xa3AKu05h/MkXaDC3
	jkLItkkglqV0oopcEKkOKyNfv/qx+9lbwFA==
X-Gm-Gg: AYBFou3l/2WHNjdpubt3yv2eKPpvzF/CEcabQWMOw5aSRJPtzYT8ELZFWJtEbMrMBE5
	kan/pCQjI7PT91gqcKPWRIlsdzXzugLxrC0rocOYkydazYEFEcKysWf2TSSbLT8nY3FG5kzW+99
	zGLWjVidspocJvcmQVOmG7DNameQ7ZapCqKoAbjjzHn+ibGrYmGfr0LCZcJh8rmarRD0Y3ssJT+
	t+f6QV+f1w1c+Z+Mcyw+gjq/Cz/0vCi8TpmXtE1FGsj5xtXiZKf7HlVvqMInYqZuwwqBy0hT2QM
	DP169Y5QwfgqINZaYuC0vDl857XZAa+3NPFd3kNiXoKDbPtKxaOY3KaRtSwXZ1DbBKzAyXcXcFD
	rT0wRCv/9VamneTR9YCMe6QwJWExQiAnHEiDVtUL6uapSOo1vpgNaMMMgDVj8Ml267B5q/lcrgk
	slP9V6JoVACS73JJTmgLc=
X-Received: by 2002:a05:6a21:2291:b0:3d0:88f5:f812 with SMTP id
 adf61e73a8af0-3da39d147e0mr44284581637.10.1788884684857; Tue, 08 Sep 2026
 09:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908185653.34702-1-ub4nal@mail.ru> <7D54AA3C-0724-4C8A-9CB8-64150CD3A051@gmail.com>
 <7a77ce52-b7d4-4818-9b9b-052d5922db2f@mail.ru>
In-Reply-To: <7a77ce52-b7d4-4818-9b9b-052d5922db2f@mail.ru>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 8 Sep 2026 12:24:33 -0400
X-Gm-Features: AcwNN1U6wzWTg_OcKe_fFFsl--SPPvCkUAzOr3_j0_ddP2oGxcqANiLsxAKYFYU
Message-ID: <CALnO6CAHZXT5rZtwTTXwCFvBELRjzxUmRW3pB6KVyE7ERFJqHg@mail.gmail.com>
Subject: Re: [PATCH] advice: use global config for default branch name
To: R4NC <ub4nal@mail.ru>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 11:59=E2=80=AFAM R4NC <ub4nal@mail.ru> wrote:
>
> > PS it is normal here to bottom-post and quote at least the
> > relevant parts of the message to which you reply =F0=9F=98=89

[snip]

> By the way, is my reply formatting correct this time?

I think so, anyway :)

Thanks again!

--=20
D. Ben Knoble
