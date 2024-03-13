Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3AF53E3C
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710364215; cv=none; b=hCPvvpBGvtcJH2x3Yzzabx1kHmmgIt02ZPnZNB0eRYJONcwsvpnbTAbKqhwZKHzP37BcaKUJ76IJ+xZuu/xBKBmM3Ip1S8B296IptEtGmyHMDrYqIGyqoqxCcZl3lea/gEPuVZMrfA+B6fczDJrd022PlvS1HTp4ZYiMMIxrklQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710364215; c=relaxed/simple;
	bh=ISzHl/wgMrPhdhwC+D2PiIvrT+7U1q4rPwfaG3Igeb8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SJV7MdqGt5o9ID8iQbnhXNDxk/hwAlJT4sUw62g9ZroRsGGqf40J0ILD/Bn+vTOCFAreD6DzmcGPA/fmOiyUqU+OW7NntUP9RFXExHcgccsuRn6qExap7Ps9DCuEz+30JXTVMYsSZUk0qSC6TjVxoI9+6NPllw/EW741++32T2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSJ+eMiv; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSJ+eMiv"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5131316693cso417224e87.0
        for <git@vger.kernel.org>; Wed, 13 Mar 2024 14:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710364211; x=1710969011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ISzHl/wgMrPhdhwC+D2PiIvrT+7U1q4rPwfaG3Igeb8=;
        b=iSJ+eMivS5EEDwXDmvwy8V4hdEwfK+UKsoMqmCgD+nAvoAsuQhpyfh35d37Wp2Vvhc
         rwL5U5aIioEShw4EZFJDh1hLOnvEZBaG4wWSNdtOaNCTWUf/UAwdTpn//NZ2UKRN3ZpE
         MgeUP+xi9YaYLSQbxDi5QRQ+vA/ljlN1GKf3662mqFXdE27bC6G2cXURCdkRP5/atb5y
         zoTV2hdy9IUoJmq/vkaLjdKj77W0NYPvts/sq3L06VWA22xU3Clwr8rGFSJ4kdNuHlLL
         MqqUVxxySnIiF0xmQARQznA3soWvNpcj+cq8Lg2OK6gpzSurSABxc1rzbpQD0arpt0hk
         oEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710364211; x=1710969011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISzHl/wgMrPhdhwC+D2PiIvrT+7U1q4rPwfaG3Igeb8=;
        b=wsoEPWTdA0u2h954eGV+ZqfhpKOTWP8ESMw4xgEs/VUKw3fn7NuXbVi+kuVxYoq6Wb
         n+xZoKlqwnUZO+hVPl2dTds8Ikc7fpEDLaLdXm1hswDWL4T/uu3f8g9ZSAZ+MU8+8x/9
         PwSTnQGxUkHNIvqJbejuOuqXI+Oi2yFAFNwC0N6IFUNro2OIvegfFsiKDtn0taNgsdbD
         OdxQQCDgVFC3vgj7LE0zAYi4OpplyV56OmkUKdK5NRITMEPHkJyYyad513zCINqVjxZD
         8J6k9UxpWf1g116J6sadeFUPza9r2Eh3MPmo8GHTwXuoSAs8B8Ua8y8GR9G0HCvAPg7X
         77nA==
X-Gm-Message-State: AOJu0YzJshh0nrDtevT09+iyy5TqyWUG7ePdKeYE/tiJiWsavhxhAcXj
	2KUmv3cZKNQxA1hner5T4RRI3PbO1W+Yrb0OwRw+oW8JtTuuyMD76fs6TZdAU9VzUX+Y7DVM/8C
	flq6yMK9TUfAAhiTROdi2joe+CoUzV0Rabe1ciJZe
X-Google-Smtp-Source: AGHT+IG7mKvTwACpHXQO0/aGJ96+C7o17tkdSF63mZLZTHqR7b6NyXGkiY5dMUlfDIDj4Gd3WOb6gZaQYHiNuRkOkPA=
X-Received: by 2002:a19:4359:0:b0:513:ca36:11f6 with SMTP id
 m25-20020a194359000000b00513ca3611f6mr1651035lfj.34.1710364210757; Wed, 13
 Mar 2024 14:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aryan Gupta <garyan447@gmail.com>
Date: Wed, 13 Mar 2024 22:09:59 +0100
Message-ID: <CAMbn=B7MtohTm=J+XL8iwx_CuWo47jM-v=e=p+k6hY2CKWX+Og@mail.gmail.com>
Subject: =?UTF-8?Q?=5BGSoC=5D_Discuss=3A_Implement_support_for_reftables_in_?=
	=?UTF-8?Q?=E2=80=98dumb=E2=80=99_HTTP_transport?=
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, "Patrick Steinhardt [ ]" <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone.

I hope you are doing well. I am brainstorming on the problem
statement "Implement support for reftables in =E2=80=98dumb=E2=80=99 HTTP t=
ransport"
where I encountered some doubts which I wanted to discuss with you.

Problem statement link: https://git.github.io/SoC-2024-Ideas/ (Last one)

1. Do we just need support to know about the default branch or the
entire reftable?

2. As far as I am able to understand, I just need to add support for
these reftable files to transfer through the backend incase of dumb
http protocol, is this correct or am I missing something? In simple
words what I understand is I just need to add support for the server
side nothing is to be done for the client side.

I am sorry if these sound absolutely basic but I'm genuinely eager to
learn and implement them.

Thank you.

Regards
Aryan Gupta
