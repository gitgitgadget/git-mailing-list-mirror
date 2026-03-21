Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1241339B1
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774086937; cv=pass; b=PnxXKNcz1YDPwUGbImi8C0H4phbHAVB/WHNedoF3L6rwDPQWbmPNiGMkrTy2u9u+Xo8vYC29JeQD4qPoOVclcZzyLTtexhD0lWUO3SES1UpW2HxbTrgyNbZvySCaL9SWgs4pJR2uFFJZw3OF068B0ZTw86nVJXEkGlVh8XMURM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774086937; c=relaxed/simple;
	bh=2aZ5rm90Byk1O33xZcoeprJeVslFVChLAWx7+9ehVfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oColystcRwo82oZ4VGDZCo/j/VemrHFO3W2dCf9zSmeH3RTDO6NoXC4JQktKPmOehyXB4zu7w3nD1lu+sb92n8t1Ip3G0FZK7jzBp7IbA+W+i8WrXk/q8Xw8qcEe7eNK8Sd9YC+Fl/IW3gYywYqqQf8Lb1NJUhHz897vnLdZkLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEpf2nlv; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEpf2nlv"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so1971354fac.2
        for <git@vger.kernel.org>; Sat, 21 Mar 2026 02:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774086935; cv=none;
        d=google.com; s=arc-20240605;
        b=aZRAkbRWJgDaAwX4uZgkHSS98mDzwkWVSGdp4NeCpF/wv/p59p2/6nzTaAFS0tY/W/
         DmzXZaq10ZxRm39/DNmmaun5fHVguafY6Qk280FpDagUrjuSTi19BBA6V+y3Cv1bDnGz
         /yBBaks/DbaOh02YooMA2QgZNxtz4v7wIxWR5HE0feBWVjjeA9ehdOAJjpXeZyDI8zsm
         XGiCbqzjF6kYQ75NxIZYexN0sWooV/ChyGSdixqaYEd+zJudBIhVgnAjkAqwSifWGZx3
         WGaKu/KQ0JX7TbMBxPma32rM85eVPGT7OdEX/TvnPGGqCMBf4JPuJkLN246uTw9Hi+TT
         eTDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2aZ5rm90Byk1O33xZcoeprJeVslFVChLAWx7+9ehVfE=;
        fh=mj6T99UGYf5ATxqLYRdC5N0LEgNtR7936RaN1StMZtE=;
        b=NIHhZ1lPCY57Ig5mKdQ8JHwuWUdtCU0cAbgmYfivrcHQbv7GQI8MWqNWd9c/Mv+zfe
         LoBs/4m08G9i7wXYOfsYdXwShDikApHdzwBM3ULm1ijeSDVT+dnl7vTaeGa0rP66phN5
         wWGpv++d8EZwp/I10J2r3DxT/Abcbd7DMBt48Qzj9MIMBYEhw4C/XBdUj/DPzFLTZEzE
         WBhmWMQCtXXxmZ9aiNJNu70asnS0rAn6r3JtUgBlRK+a8v4f0DLfhNh14peId4aKFnP6
         0rewdyj1WvSPJRNBw/JYoMBUV/TUJM6tCY7att4hkKZrysi1lg7M1aexYBj0NKT3MZ+1
         jSAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774086935; x=1774691735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aZ5rm90Byk1O33xZcoeprJeVslFVChLAWx7+9ehVfE=;
        b=PEpf2nlviRssMzjH6eVKgx3Xusjv73OzUNOIbURVJRQgAiMxjfPsGyQNpnI8WhOX0t
         bYQCAQZTcIm+9Q5+V+EgCIn6b95n8ev+GTdW91cGC6Q5B1so84HsELKpYk9TI+wed8eS
         zrsFx+YpTT135tzCDUPAg+qUCtokgwaOeAx4qqdSsXr5VPUaXuI5D9paPKh0dmZzlBCl
         TkiD/8/Im5mI9AF/cBcRCavrg8n3Jyw66ZeYjDnYH0A7KluHBxctbG/6e+UN5KW7nDM/
         kdzayrkXq1b1sz+Aot/VjItaIZKwZV2oytf8KyKczsViPhGPcFEM3iN+YUey67ya0Dps
         dICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774086935; x=1774691735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2aZ5rm90Byk1O33xZcoeprJeVslFVChLAWx7+9ehVfE=;
        b=lTWBbxcbfHEDehvAmBJSNCBpG7SWTQ6l9cKmn5rwoK+cWzpL5gFB+VsAPxCIcOlSSH
         2rDFWvUhK+1Js2jWoqqjWzcVAIcDLWjrf+06u+2Q6rX2bwN58sLPQlEK94PTcLiY6+2o
         viaQwE41pStPkH764B0IJJypCgG5xAiaG7La0ca16/T2/ofierUzUlWMGeBSEGFmNS+H
         HBBu82KB7HrmMYmIuOpLG5wrqqfuTakAEvQ0UMnkug5pRngiod1oERW9w3sPHurPRGn/
         Qdby7zxCWRRMmPHlG4TTLhOYDY+Ih1V27Rjvc7Y0cIzGxhaXa9KBNPoK381dcfW+MoDP
         M36g==
X-Gm-Message-State: AOJu0YxNLqIlgRcmLWjTWGeWanwcDsW+Nrd1m1aQ3F0L3vxmTH603tlt
	/rlbZDz7rmHzwf7uB3uTHRgxQ+V0fuFOoqsoxwrU3silcov3nW4YZymexE89/bRzKeImn7I2B7/
	WXY/3P3O9WcwEajZyiAiL0YX/L/OdQ5c=
X-Gm-Gg: ATEYQzzCXIU/omTj9znFyE1vX6se/pJbxEFxJNRX68gKTK9DnaelJyC7H4TJ8PvfpUT
	rBy+nfv5Wv7yjxUgTmVNSieZs4LXS7pdFr9sQG/A5UJhQ+TqsR7D/2BKQ+prDsp6hpvalSgCcFp
	elaaOPg1Q8fQV8Ch2lPSzIhWapVXwzyuz2Bpfc+cj/dQhFGr6R2OaTubqWM0CiYxVZ0YHn2IzmZ
	gO157tKnKXMzTKSYpBilyTmwRwOzrG+hST5ITJq3OHHF3gTPc3d2xSQ3V/k2IIAzuC4k1jTX69E
	Gjr6r5+IG+0lE3f9SCdYx3+oC7+6GW2eIgzlkUMcQ4SJcdtoCHExh0nUp7dPZqYDqT6m
X-Received: by 2002:a05:6871:28a4:b0:409:6227:d313 with SMTP id
 586e51a60fabf-41c112c694cmr3861119fac.35.1774086935077; Sat, 21 Mar 2026
 02:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP6n+1WC=DUodcESf1aTn0THXDBZWkxCKwJ0PyHinyrFghivCw@mail.gmail.com>
In-Reply-To: <CAP6n+1WC=DUodcESf1aTn0THXDBZWkxCKwJ0PyHinyrFghivCw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 21 Mar 2026 10:55:22 +0100
X-Gm-Features: AaiRm51ocghsV_aTxzZoJOmwW1LZMx-Gg45Z2UooZXHSJNuK83DjuTMkZsnTrRk
Message-ID: <CAP8UFD0dSEbbJHQFDb5q2BKjzyF4DBGUv9Dshk_4BTpVfBPo1g@mail.gmail.com>
Subject: Re: [GSoC] Introduction - Aditya
To: Aditya Indora <adityabnw07@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aditya,

On Wed, Mar 18, 2026 at 6:00=E2=80=AFPM Aditya Indora <adityabnw07@gmail.co=
m> wrote:
>
> Hi,
>
> My name is Aditya. I am a student interested in applying to
> the Git project for GSoC 2026. I know C and have been
> exploring the Git codebase.
>
> I have cloned the repository, built it from source, and read
> the General Application and Microproject Information pages.
>
> I am working on the "Modernize Test Path Checking" microproject,
> specifically replacing '! test -f' with 'test_path_is_missing'
> in t2107-update-index-basic.sh. I will send the patch shortly.

Thanks for your interest in the Git project.

Best,
Christian
