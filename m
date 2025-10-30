Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F71299950
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827994; cv=none; b=Zy2qYxmRIHXrRowtipZLBOxghSCTBWMykbzWzvzbzUqhLd/YrUqwxun4k8CI+EOSkr2DxFg/iOWDsIpFK2dx3TROMuyGnmdF4Ub7NRfyEfSGXiWFbCYLNTwGs2KdwO5DvaUzNpxm9qGz7fDSNr9Jbx3X052RJiaR9RNtPen+GYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827994; c=relaxed/simple;
	bh=Ko/1GnE9PrQoFqagKTLhFYo5HUIldx9AXXnFT+Mr3zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8/PYy3MTHNbcJZFo270Oi1ZeV/ljqvPp9KnzLrie581+T4n/Y2W5kVT/SvH3+eXPWdaxoJI6Ob6UbaH0ulh7vB7TtOQKnHIFXwfxjcQKRebAeAbtEyZr2pwAldiAJU3RrLKIGv/Sczjim7KPENqSErJserxVJA28ia8VUmHxKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmUhdRSz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmUhdRSz"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso1699229a12.0
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 05:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761827991; x=1762432791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6W0oFA5r8QOA1AvfU/V6EvVoh/yfc+P5SM43d2Fn5n8=;
        b=FmUhdRSzYpAK8oEqRKfNDIan0c9jjepuv7H6X+cyr2ynoUmuLbyh/3ceHkCYwtYizU
         XgckUUVBeWab1I86sHYQ7QHoSnhV5ZLMaK2m5eka+JaNi7GuTgfhMnmIiZcq6ifN7Kgz
         osWG/k21jT8QfFW8QMwhSXSy2amkq29SrvO3R8sSRMjDHBlpgg4TlqLgdyrKF3AojNZf
         JbdudoTIa5TRrxtxIvt0uOF4e4EqDIoi1612VXbGwR+AlOmfvPbc2/eP8aCRw387AcV2
         Qv5T3tCN4U0x5vmHkbFOmYVTPH8sVNNVm/4+WZdYA9qc+i3Z5CvpxF1eQ002M2t+hAZm
         HSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761827991; x=1762432791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6W0oFA5r8QOA1AvfU/V6EvVoh/yfc+P5SM43d2Fn5n8=;
        b=W4NSyxl6mKhEzsUVnQSVRkYnLZHbHBw6ekIFPf2qsPMWKGYy3xZroYgVYONlhi2/7o
         rTzAeoXxjUQRgw414RxeZwj3idOTkESPWoiBF6Am09HoB3lCa1cYzw+cq3iskEOvsXP/
         8oc9A6QbCnRaD2XqpKBuE25YRsXqkwRBUJl06d1GlpTBQ0OlbaQ3/pEn97/jcaDPNcag
         fM4jLpaeEQSeRVa3YC/aQBVS4HmsDM+rLq+1NkJZwis6/uUUxgRuiC7PNd6GskcX4OfJ
         u5lUDwUFLK4SSNaAJ8cjF/DcwQXPb6vbz6LEJxkEuEAIe31I5TIXYUoXPkYSX/JFxrit
         +Trw==
X-Gm-Message-State: AOJu0YyNbhzlpbqIlCMM0uzN70Zr3x1S8Dg8cp463yFWyxtmcVy76nT9
	F7bNa4P2WBknFGyajmPBuqmt3SeCfj2vWjYzT3BpE37M7u/VgBP16JprmpTqqtz3vZ9iUo6heHt
	AcBbWFjhs2A3x2WesWxK5gip+hQ7ZqeIDSJ36
X-Gm-Gg: ASbGncvlR3aG1qgM6SXbJZ6vLa3C4BGedd+O2BhwJttpfx5sE3dGEfeDVtToTol9xZQ
	5br67tD8gkYCeRJTlKh3yfdNu5iRh8N6eqFeQkv6laE6zutm64sesYAIGwT0Gglv12Cjtn1C067
	j/E23tQGY00wndmsRfabVq9NUA5DCb/8tmvSKWS62jk19sVLemNNRMnYBro2c84jIiSUo6Hsd1D
	nnoYWYCapCLAXRqQinFaBmRHBK6/rDSUUuM6wa9JxHWAwuBzJluFci6BL9kf87xSsiwBW+0iU85
	NbFpoZUSklx5jDVR07D19IFexC8y
X-Google-Smtp-Source: AGHT+IEcC1LkaKxcTiqdtoqwNZHuPFDttQlojK/oeIFGFWvL9jWVd4caEU51H6MYgo8n6ep2GjUasX4uAYe3QsdzqQ8=
X-Received: by 2002:a05:6402:a0ce:b0:63e:155c:3ae with SMTP id
 4fb4d7f45d1cf-64044188b93mr5627202a12.6.1761827991190; Thu, 30 Oct 2025
 05:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028081232.3068147-1-christian.couder@gmail.com>
 <20251028081232.3068147-4-christian.couder@gmail.com> <xmqqv7jzdtvl.fsf@gitster.g>
 <CAP8UFD3S1s3_p3m-ZzRO=B7nQwJvbYMBew8_MZWJwSJEm4oFTA@mail.gmail.com> <xmqqv7jxadq6.fsf@gitster.g>
In-Reply-To: <xmqqv7jxadq6.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 30 Oct 2025 13:39:38 +0100
X-Gm-Features: AWmQ_bmzMl6djIYRGzNMdcf6iTKRs5n0T4VXdSCCv0r-k57CJ6R3eAgGXma6A4Y
Message-ID: <CAP8UFD0oOLnvk3wKROeKEWWFcQPVB-x9JUjpeE=8nWsWZYUnrw@mail.gmail.com>
Subject: Re: [PATCH 3/5] fast-export: mark strings for translation
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 5:12=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > On Tue, Oct 28, 2025 at 2:43=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:

> >> Makes sense.  Should we also downcase some Unknown and Unexpected?
> >
> > I am fine with doing it as part of this series, but I wonder if it
> > should be part of this patch or in a separate patch.
> >
> > If it's in a separate patch, each patch might be easier to review
> > independently, but a number of lines will be changed several times in
> > this series. So not sure what's the best practice.
>
> Rephrasing the messages may need more careful thinking while
> reviewing, but if you limit your changes to only downcasing the
> first letter, I would think it would fall in the same bucket as
> "While at it, improve code indentation".

I did it in the same patches in the v2 I just sent, but an issue I
faced was that some tests in "t9300-fast-import.sh" check for some
error messages in a case sensitive way, so I had to make changes in
those tests.
