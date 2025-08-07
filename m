Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1055F3208
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754587189; cv=none; b=V2Bc9zJxjhvi+hMymqMOVTPGhw6375Unc6UEambKXqgEHeNMYtRW9WGfaNKU5PWbV6e+wNbzEaN4mDn3AubkC97EkUFpFI0TxPZJQqRbAeZsDA/JvnatDZAN0SfaBnYoz6vPb/91cpXjMrc2pxr3wKMq32U6dGk2gAkaYdEZqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754587189; c=relaxed/simple;
	bh=Y1D5bhLLkfBj0Y7/zlkqUqbrIddG+rUVCIyAGKCxjl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBaxzaGv3DwFfMcV80NVXIbl1MxNn+1jA4THWz2w/pn5Uk1sbxvmMP1w9DBJSu8evWID19Jxr0pMI9Qz7aIvf5cEHoxjX1XhMq/K43SrWV0skCkw74Ckfp33cGaFlqOeACrzDv03GwfWLuNLtYJMUA2gFfqW/nnp0L/HI12WcTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-709626ed5b0so1602246d6.0
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 10:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754587186; x=1755191986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1D5bhLLkfBj0Y7/zlkqUqbrIddG+rUVCIyAGKCxjl8=;
        b=uMfGbXXA08Fl47d9LSrbLC1Xj38l437QtwwjoIRgmaCBfq9XNu7Fayqkkt7SrjoCHl
         RRT0jT7aTX256S5c17k06Mfu2Q5kea1aYXW+MvKZYbMiTmTFOyUFMi+tKdepbjpvSi2k
         RFdPBdOdJbDdeu8WrAXtBleQPBsODkWsROEZFS1UpqKbEyPHPPulGsTso9yRapTCZjRe
         kDh5KVUpC7O7LoQKkROywbnwvETLdbi8WF5pcDGc1PWXSN3VRFantrs/kYo48gJ4odbb
         9xEkoM1rEHB8NpWf+8cnBs8+gJiS+OX8jtKI+xPREm/6gw6PLlYwAIZjad/g5kWG8sDX
         nkvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTBtkURAzDfZLxR71PsGzK/kxkQTBaemPAdUhN3RjsrPEGiATR7BDnRtOBjuFikGzJyM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyze7xxY2XhB0eUnLpVyps862P4lOXf/j3A0eRlTkIYvf1ZCDrH
	kHFnzUADyM081oFesxV09cP/28XWIAsjsEYiTspuhz082BRDtc7FbNPXswu3EohgfE3miOhxhOt
	iOWc+CTyXlldvH3OZdEVHjFNeDWp1Uqc=
X-Gm-Gg: ASbGncuQ1X5I3J/tYR1hA9Bp55+SSyVMMdd4dQCl0YXD9OAfh9kZAUKvI8WYhadk+au
	qZ0aIQXJyOfSfUQx9YucJ8dw97N0fuy52MowHvv0UzJtbtnkt1oiDYaOrk2eR3FUf2GF9xTsVU+
	YdzBauEQOi+qGxXxn5iiddfN989AwMBFVAjp/Zmf1rWX1utkiGXDl2XSmdI/ZnIz4wbpkOHpzFW
	qDzc5D5gJuw2XI1hOthK8UFOGDcs2yJ5YHh8lAf
X-Google-Smtp-Source: AGHT+IFOMRSh1OCv3QIZQb+48zDE9qxz8Y4oBIvGiTXAgDHNV2SrvAz/9wwlyoFF5NLbJsGaTkn6IpbmqQttZUWh368=
X-Received: by 2002:ad4:5ce9:0:b0:707:48a3:f833 with SMTP id
 6a1803df08f44-7099a2825e8mr479466d6.1.1754587185655; Thu, 07 Aug 2025
 10:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <54a16614e2a38117f533ede3321b4d8ee2eabe8c.1754558302.git.liu.denton@gmail.com>
 <F3252723-7E5E-4E84-94E4-5FC00298BAB2@gmail.com>
In-Reply-To: <F3252723-7E5E-4E84-94E4-5FC00298BAB2@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 7 Aug 2025 13:19:34 -0400
X-Gm-Features: Ac12FXwtWUkMiqv6qEEEargMdPWaT-5YCc1Zs2VSrvTwQRQ8iCC51io78ntdvNU
Message-ID: <CAPig+cQW2t+PC6R7YKaBTPHr96oyBerXv5UwCUhGpXYUqn-HgA@mail.gmail.com>
Subject: Re: [PATCH v2] remote.c: convert if-else tower to switch
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Denton Liu <liu.denton@gmail.com>, Git Mailing List <git@vger.kernel.org>, 
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 8:35=E2=80=AFAM Ben Knoble <ben.knoble@gmail.com> wr=
ote:
> > Le 7 ao=C3=BBt 2025 =C3=A0 05:20, Denton Liu <liu.denton@gmail.com> a =
=C3=A9crit :
> > =EF=BB=BFFor better readability, convert the if-else tower into a switc=
h
> > statement.
> >
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> > diff --git a/remote.c b/remote.c
> > index 465e0ea0eb..029b1fa93b 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -1171,7 +1171,6 @@ static void show_push_unqualified_ref_name_error(=
const char *dst_value,
> >
> > Range-diff against v1:
>
> Don=E2=80=99t we normally put single-patch notes like a range-diff right =
after the triple dash? I have a feeling this format breaks git-am on the re=
ceiving side, though I haven=E2=80=99t actually tried it.

Not since 2fa04cebfb (format-patch: move range/inter diff at the end
of a single patch output, 2024-05-24).
