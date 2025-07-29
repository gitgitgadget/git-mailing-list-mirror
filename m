Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9982D2F24
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 00:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753748880; cv=none; b=UIqmNQRcQjLLtiUVxKzyzhMOBPGeLW3tZwVzpy38lKk3EW578E+s1OqG9etpNgxuaW85b4LqFEoiIQBPIz8a9XwKiQawVSmEJUgV573d5g30DJ/bOg4rDAsCIt208yV71pRXadooUMqv+wHUuG6pfCvX5MZrHezuWFJtJtlqmuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753748880; c=relaxed/simple;
	bh=gd1DVUSLNoEnzHwOfU9+4GvjC08qTQrE9gAauSGK6kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFEMoEzncd4+k4UyHvZhRfwN2J3GJqiEeROIu+wV3KsAV04Vn2jOTbekhe2Gf+miYnQGyySmi49HB+ZjF+owbTUTB5XN/7jd/Fli02KlzVP8qtdOXUiXZODa+YF3Su9/zUADt1Uq8OtGDLihqjNCltkIGyCwyKvZPhQm8mFhK4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e0dea2c58bso57453285a.3
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 17:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753748877; x=1754353677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06JIXfCNIH0CzOt/CK/ZoniMb7bKJ4EYsp93v0zf4GU=;
        b=wuNUPiqTFB1chkWlZDO/upB3ldMFcuk1UcQZlJUrLmMpfhMulaUun3QI9T9bjjcwW0
         FJuXUDoW4nzfCYWVxWVqorXKWZvXpdii0oxZb/n2GwJhSwoI/5RN6ogs8dsdro5Fn8fN
         ire6jsjPsQ9XxykGnQGj6xMLPMAGyqTKLzRY7YNsMrjTZ3oS5dr6RfznZC1YoRSwyBht
         7eRm7oaLnJ6S+TxFnkZUG6JrKRP345T9oKTUAPmlV1xad/4hnq28osB26dtx2zIdEw1A
         b851iJ8KYNkRkYSrPYWHxag/AjMJALGIGFIekrH7Uhzu/6yQDuzokeOkGehtDqArS4zg
         VLYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgeXT/Clp3GnwdNMm6piHiQf9dNVNrPqG4kURPz1XBJXoRXNPzPklQHTA5B0B26L8nk/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxETgAfU/RZIBYdO9H3HAtNIuhpTh+xli8ToROFcRA8N35K/Zzy
	+uQ9fMKveWTQxyKceE30CWYVDG86lfzDtdc3Y0KAWj4XC/9PPbrDU/h5WmzRlMOZDQqxWbQ/R0c
	sghpLz80o2Qjt0KwPCt+OQFUjG+/qYSY=
X-Gm-Gg: ASbGncvQqMzd5yr6pKrzDL5Riy8HQ7Rvn3zORUV+tV/zsovDlfgAAYFsbnjSQoFk9Km
	op9mlZF7WxwagpZY3EtTWNG6uIUcRK9MTjVm5v12ITWab0+H6kKUNIWsO34/9yrfL6X0189gF37
	IiXqFVjkno0S8JSsSyoALsG5wxm79QR6QkNCHNTHMmSxceXG+p/k1O8780xGLYtiG5JMpjUozuL
	LnHX3pCd+PPurkttouPgCxWqjrnlb0G2BWi546C
X-Google-Smtp-Source: AGHT+IEnRiqA6y7T1vpM4aom0T8gI9sYsguPo8qDSL0WrD5uaRbW0ht1bVvB5uuoVl/0r09RJMd/7Aht1PJcvRgXPVQ=
X-Received: by 2002:a05:6214:e64:b0:707:4daf:62f with SMTP id
 6a1803df08f44-7074daf087bmr23332276d6.7.1753748877364; Mon, 28 Jul 2025
 17:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPig+cQn7c5+k06yHOD2jxYTGnny7is=fbo4tOw26eD+4zX-Jw@mail.gmail.com>
 <CF7744F0-394B-415D-BECC-9D7CD477B78C@gmail.com>
In-Reply-To: <CF7744F0-394B-415D-BECC-9D7CD477B78C@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 28 Jul 2025 20:27:46 -0400
X-Gm-Features: Ac12FXxpxL2iZpFEusb4X59hKdQ79mcEuIvgA-HVEC1B97nFLh3_NtqbFWUauds
Message-ID: <CAPig+cSUnejuxYHvk3hzb_nM6bdEPydBsKgD2FkOX5sfQ2FUAA@mail.gmail.com>
Subject: Re: [GSoC PATCH v5 5/5] repo: add the --format flag
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, 
	oswald.buddenhagen@gmx.de, ps@pks.im, karthik.188@gmail.com, 
	gitster@pobox.com, phillip.wood@dunelm.org.uk, jltobler@gmail.com, 
	jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 8:15=E2=80=AFPM Ben Knoble <ben.knoble@gmail.com> w=
rote:
> > Le 27 juil. 2025 =C3=A0 18:02, Eric Sunshine <sunshine@sunshineco.com> =
a =C3=A9crit :
> > Simpler:
> >    printf "$expected_value\0" >expected &&
>
> (Below as well): the shell linter I use does prefer to see
>
>     printf %s\\0 "$var"
>
> to avoid issues with the variable containing format specifiers.

That's a very good point about using "%s"; I should have suggested
that myself. Thanks for the correction.

> (Backslash has to be quoted in double-quotes, too, I think? So I left out=
 the quotes here.)

No, backslash does not need to be escaped in double-quotes. The
literal form `printf "%s\0"` is common enough in Git test scripts, so,
for consistency, that should be the form we recommend in reviews, not
the form lacking quotes, I'd think.

Taking the above into consideration, the recommendation for Lucas
would, therefore, be:

    printf "%s\0" $expected_value >expected &&
