Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A2E84039
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767555619; cv=none; b=Xm1wFr3Ah7ohSAttvaZe8SndNBE0/8157VjJrGbt2HwcQTDZTxZTfE9YotKmxeqnfl1/ySYaELu83irlFnv4dhTb7ebDVXeLolbFJBFkbl4Aa8CZ8b9Ah5oukkSX7w5sF/8hExG1QHRPtbVShPNa87XiHNN+7ZWTzMrRqWOr2KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767555619; c=relaxed/simple;
	bh=AM7QXDxOQkrCsc0U70/iR7hmAUkLISBD6RCclN1xROI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkDROPMPGeIWnYU2tZPkAzwL/QoeiYA2B1VKl2JH0FowgRKgbuRjKHHJ09M4KieQ5xdTV7rvc+05g13ILxNS0+lrm8rvG1qJxILeJOYgWqCn3yxtp0NWK8iLRdhvLO6+zgLCU/hRTuEjhY7jVo8VewR02ODHhMQZ17q2RJqB8PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwxHR4MN; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwxHR4MN"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-787d5555274so122537467b3.1
        for <git@vger.kernel.org>; Sun, 04 Jan 2026 11:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767555617; x=1768160417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM7QXDxOQkrCsc0U70/iR7hmAUkLISBD6RCclN1xROI=;
        b=iwxHR4MNfUjAD053pYCZttlRQWy2u2AxYTmlYZDcBwOgXm2MZNrO5/aeSxO/HDbfLj
         Cn+YowA8hJBCkPVB0r7M/DfZ6uNNHw/w+FWdti/HYWv0UnFih0DJhAjk0HEn52WGdW5A
         xmFHQs2RLE9fYKixfLDkohkMivI4e9ZuG3TlOxKfMq2qQm9iC5Q4LJFz+0++/zUKeHXI
         jib11+piAO5DBUq7Yj39enlNloFHBJ3wbFWQgXITOHxP32wV80qEgvtv/21NUxxY16dA
         rKUMuvW/eJiOqgXZlMskghRgfJJ/hToUUPZZQB1OjAll2ERkUcT+L+vrr1EXUXbWlFa2
         92HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767555617; x=1768160417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AM7QXDxOQkrCsc0U70/iR7hmAUkLISBD6RCclN1xROI=;
        b=NSG7menfDTaGRHLo9zTs9/oAmehEHLB0NsRfxM/gLaZVQeGOhXa1UwRPs5Bip6o/zc
         C/DzFXu9g3t7dCRIv7g1T6LNF5Eror4in3dWK3ClHZdRRfphQI6DSoQ31TESX8Q+TRZy
         wqn5M3fs8XcYTEf2L11USw6of6ECdKiv7OMpzbZQF3OM3PH6KWjAjIaZbWLXqL+ns23l
         eF/Vdhb5eoCdGS1Cs0MvA+tKmRgKyjyQMsoW1FxM+ppziFrJaKLiZUEL6k4o+mV+UEaH
         6pRYxju7MUpo3uwWSCxu3txGI/i3984zoYFeuUV7lWAI8CX+97PRgTuiNihqKYO8Yzr0
         MQVA==
X-Gm-Message-State: AOJu0YzDH5xYP653dphfPBBxxKb62zPhG43lVobUtcPJ001B3/URpDCK
	ffIyGTHj2thm8OShta4ZHJi41CasmucAY/PWtolawYQXNqxQQ4u9Wg24xW7RWe074yhvJI0xmLl
	271e+vCuoVY4QqYt/I8GDmLx27mqo5C0=
X-Gm-Gg: AY/fxX4JekS7MftncMV33in7QteaWLOFK01Pvg8jb26rU+exNl3alA/+zQB0+J/qXWd
	goZIPr7PRILEzyrSeaLzsneJ6UuD/xJdeS8qTs6O+sij3O2xVhJnEIMAAMmkSs38lWpUYwqQKmP
	oDg6+mY9FYJBtRq6NdWQLfs2sXUTTujVR47BAj/E9uXFQIbPKUi7vblddBf2Ti51Z2crKAxWaF/
	RMGj+BZ+mzhfolxNCuJhvNdLxnbv97N7q2mt8XxR1MOPqjpkeW0wNb1CWuYD0ktW+OvQvA=
X-Google-Smtp-Source: AGHT+IHKUFcBGqodelsV2uTBLZkU4AqC83GeEi/S5ZIFFW6NR/+OAMZFmXY6fL/df0GmZ4XiN94WmXti+b7/ffUCi/0=
X-Received: by 2002:a05:690e:1881:b0:646:7da0:3a96 with SMTP id
 956f58d0204a3-6467da03affmr34507338d50.50.1767555617149; Sun, 04 Jan 2026
 11:40:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104124255.15609-1-pushkarkumarsingh1970@gmail.com> <aVqIjHIi6aKvFYXg@Adekunles-MacBook-Air.local>
In-Reply-To: <aVqIjHIi6aKvFYXg@Adekunles-MacBook-Air.local>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Mon, 5 Jan 2026 01:10:05 +0530
X-Gm-Features: AQt7F2oXdPDdwDu6k5euF6VbDNS8ZiK_6lvQWFvEKKNWTic1feZw-dIOyzhx5w8
Message-ID: <CALE2CrQoXZjkpd+Lswd=qME9nkmUGu3HK8XacZ+Xz6Y2w+=t3A@mail.gmail.com>
Subject: Re: [PATCH v3] t1300: use test helpers instead of test builtins
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Abraham,

Thanks for pointing that out.

Understood. I should keep the commit message itself focused on the change,
and describe what was updated between versions under the `---` section.

I will send a v4 with the commit message adjusted accordingly and include a
"Changes in v4" note below the separator.

Thanks for the clarification.
Pushkar

On Sun, Jan 4, 2026 at 9:04=E2=80=AFPM Abraham Samuel Adekunle
<abrahamadekunle50@gmail.com> wrote:
>
> >This version updates the commit message to avoid calling `test` a shell
> >primitive, as suggested.
>
> >Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
> >---
>
> Hello Pushkar,
>
> I think the right approach to send an updated version after modifying you=
r commit
> message is to modify your commit message to INCLUDE the recommendation, n=
ot change
> the commit message to the recommendation alone.
> Then under these three dashes after the 'Signed-off-by:', (---), which is=
 here,
> where I am currently replying to you, you state what you changed in the n=
ew version
> compared to the previous version.
>
> e.g
>
> Changes in v3:
> - Modified commit message to ...
> - Modified subject to use builtin instead of primitive
>
>
> Thanks
> Abraham.
