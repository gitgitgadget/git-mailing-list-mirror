Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801D07F
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 03:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711940958; cv=none; b=R4i+ZIC5gsYy7yzDZEkDs71x2VnhI5H9U7Z4DI3SiXvyFFTjtpw0vTNempTNNbP+PxWI+gayYkbWL1HjnP2AjR0mXFq8YSe8XjME3QnFFfPUXr6tJhDLg/LJ/U4gMV2ZBqRV1kLT1t57Cs6Yu4laQFsuB7oNv2mK7WhNXgcbS1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711940958; c=relaxed/simple;
	bh=C5LqtT97XRKkukXX0TUy+/qR3n2j3ISV3e9ZN0/rODw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cavdOmOEPptkVnotqLMqhIb4UWU0mRxTMMs49kwA5Qaez3m/HLh3a3duRjfee//nv3aHsQcOA6uN/PCyBow8DLwaGDvglslC9fvwsbRcBTujjBXNAqxOiL5ENgBgVvnjHbLYSDxlCSvU6ilPkrnLI9lcZ41cIQlolfTl0KDWLB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7e307f172efso926477241.1
        for <git@vger.kernel.org>; Sun, 31 Mar 2024 20:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711940955; x=1712545755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YhIrpjKY3wPTFxXF9CZdXfX7b1M2Sr5TM2AAyH0vQM=;
        b=S3vxoK0AgSEa0Wbc4dB3ZKqmC/ACumlnEPMRIQY4GRZ8MQ0ndnjiqhwLxhBbPv3ELe
         uqU0dBSwnIfHUzu46fhd1mv6fXELz1Z7Lzp4nSBGhANvsdLCXVycg/FnbedkTG2gCBHH
         TRaIZmXT7+m51qR4/RTLUcwO62vy8ynQGBnVx0y/gTt99ubzxAkyIdT8LBngOOb667LU
         fS7OZmHQV5LuneCkyJJInbOPkmodBoOoKxYqIeBn/W5q3l4dblIcPNLQ6+R16I9qNLf2
         /O5xYE9vPlXEOm0KtF7HSjMgp2psqwv4ZsRyGKKxlgKheukPqxgeoMu+CGvo17bnIk+W
         boRg==
X-Gm-Message-State: AOJu0Yx0vgkwFhx70rtdG8W6FoRbgvo6aXzdGLFm+Ijr/0CU4YEPRiy5
	1WXS11n99qy7TV6JNAk8pcEVRWw5FpjUky2bzT23CVCfree3z7JHHnvZkrC82POvhTIJ2NfejiP
	wWqi4CZpQVl4/GZyUs8aHAp/jdPo=
X-Google-Smtp-Source: AGHT+IFwIjMA9W8laFOMiNljyxmUyzoRF1OwAIU96DePcv0ODjpPA7Xu6SxUKbM3lWGlGXREubysI4Ouyw3tUw4xMV0=
X-Received: by 2002:a05:6122:3c4b:b0:4d8:df31:6b34 with SMTP id
 fv11-20020a0561223c4b00b004d8df316b34mr1256055vkb.8.1711940954002; Sun, 31
 Mar 2024 20:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <35de2d76-a03e-4a36-9bb7-6b6ffa4ea123@gmail.com> <4f179986-6aca-405a-a122-d0dc058c60d8@gmail.com>
In-Reply-To: <4f179986-6aca-405a-a122-d0dc058c60d8@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 31 Mar 2024 23:09:02 -0400
Message-ID: <CAPig+cRFqddMqTxCENnknv3Agcq3_bxGmB1sQTmJNb=xNYg1aw@mail.gmail.com>
Subject: Re: [PATCH 0/2] improve bugreports
To: =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 3:04=E2=80=AFAM Rub=C3=A9n Justo <rjusto@gmail.com>=
 wrote:
> On Sat, Mar 23, 2024 at 06:32:35PM +0100, Rub=C3=A9n Justo wrote:
> > Let's try to improve the readability of the bug reports we receive.
>
> This series received no response.  One option may be because it went
> unnoticed, another because it may not add value.  I'm going to give it
> another try and I'll quietly :-) take silence as confirmation of the
> second option.
>
> I'll try to increase the chances of getting a "looks good" by CC'ing
> some folks involved in the bugreport tool.

For what it's worth, when I read the cover letter of this series, I
thought it was going to clean up the list of questions to eliminate
redundancy. In particular, of the three questions:

   What did you expect to happen?
   What happened instead?
   What's different between what you expected
        and what actually happened?

the final one seems to repeat what the first two ask, and it is common
when answering the third question for people to simply repeat what was
said in response to an earlier question.
