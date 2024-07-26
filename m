Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017872C9A
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 06:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721976372; cv=none; b=eaeHcE4fJnEGT48Tpye2xS13iziJ0oluMxs4COcHwE9vBWyssh2lB/XJiJWtGEZI7XqN8/A+YrMMepaIEp1sxu0h+tsPkTDa8rQiPFctMVvq/v+bmGF5AJ5gWhJ5+wu/1Y57qRFyQo5eogznY3dVT/nb7FbsDuUKmXHpRa1PoNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721976372; c=relaxed/simple;
	bh=+jvhYGIUHf1n10ruOpOcrh57Jt8tUmP48g/ZPEWEcso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7qg37ZwMX/xM75cjx5R2Rl5/BvR+TS6CypyaFKDvuTFOFuISrq3635C0jq9KjzKXn/+nYYyNNJuZ0PyKbUyK2fCN5pH1AAEe3Np3I5wy0qQlX6VV6GzAcA7bFadrB5hSSpsvtIp77fEP70p3iiLa6rQl1eWjYlnCB5y06nVKa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b5f46191b5so1756986d6.3
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 23:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721976370; x=1722581170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUe6IvGxGXczqaSy2ZOMuQwb3q8AyQ9UpK3rL6naNCI=;
        b=Lpu940wYDBtgMG1I5nsZQVRsb0KEkrKUBna9sGdKEwjswXPxe0aOA4T2QPMJIQ6792
         bMvIzBI0TK30gWPPt8cC7sclikN7nuCh73ZR1gOnrSGcZ8aRrsE1I9bSGq0+9ZGjISXp
         VvbztBLejBS6LzN1PvKM2fSL19TPQtnErV3H2ryftx+00U1Rqwnf0CSVLTlUrNJaEphW
         dh06qGBtqgXjaQFqwQypxV2dHmYhxyleALiuXke+pbxGjvAr7+wpXqiiGEz6325zbNP9
         WEK7ibyD/CdrQYgU/BmXR1koGqHJyw2lrsCzk/eVOeHmzlhAadzAYs7cYBjOkrg/Jmw3
         gslQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPmAeX/Z3HslBOwCW6/fhlCfDC4aQ3THINBq3tlFYvCK2aYqxU6Q5fa6d9M4mXhczZGHTLmZsyEhgTD6SoY+Og+vt1
X-Gm-Message-State: AOJu0Yz9QxhThMNil5FGAcfDt+kA5Z8HcZ3cR0YgLpgCFTxeibwKwMm7
	h7WMA98JRTCNEoEMEh5EdLHfhA2dqzPa15/beEI4sPRMpL6bdCX4+NMwkfQ4NHUubWHE2HKSjJS
	+WI2uUVGzDqJiVFlZaxvm8xXCNEg=
X-Google-Smtp-Source: AGHT+IGz8iXoac0q64EvN0LgI6JzzhJfEpu8U9l8q6ugRygAZesyI/q+lGI35s9ndXxto59GPjCLupCK5c5foSevHp4=
X-Received: by 2002:a05:6214:e8c:b0:6b5:e0b7:2fed with SMTP id
 6a1803df08f44-6bb3caf3e57mr69129076d6.47.1721976369827; Thu, 25 Jul 2024
 23:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722065915.80760-1-ericsunshine@charter.net>
 <20240722065915.80760-4-ericsunshine@charter.net> <8c6559cd-d18b-442d-b692-f1611f1907f4@gmail.com>
In-Reply-To: <8c6559cd-d18b-442d-b692-f1611f1907f4@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 26 Jul 2024 02:45:59 -0400
Message-ID: <CAPig+cRH+mVgCf3UMQmiG6QueELCrAKGMikc6OtZMK845QDccA@mail.gmail.com>
Subject: Re: [PATCH 3/4] check-non-portable-shell: improve `VAR=val
 shell-func` detection
To: =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 10:46=E2=80=AFAM Rub=C3=A9n Justo <rjusto@gmail.com=
> wrote:
> On Mon, Jul 22, 2024 at 02:59:13AM -0400, Eric Sunshine wrote:
> > -     /^\s*([A-Z0-9_]+=3D(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{=
$4}) and
> > +     /\b([A-Z0-9_]+=3D(\w*|(["']).*?\3)\s+)+(\w+)/ and !/test_env.+=3D=
/ and exists($func{$4}) and
>
> Losing "^\s*" means we'll cause false positives, such as:
>
>     # VAR=3DVAL shell-func
>     echo VAR=3DVAL shell-func

True, though, considering that "shell-func" in these examples must
match the name of a function actually defined in one of the input
files, one would expect (or at least hope) that this sort of
false-positive will be exceedingly rare. Indeed, there are no such
false-positives in the existing test scripts. Of course, we can always
tighten the regex later if it proves to be problematic.

> Regardless of that, the regex will continue to pose problems with:
>
>   VAR=3D$OTHER_VALUE shell-func
>   VAR=3D$(cmd) shell-func
>   VAR=3DVAL\ UE shell-func
>   VAR=3D"\"val\" shell-func UE" non-shell-func
>
> Which, of course, should be cases that should be written in a more
> orthodox way.

Yes, it can be difficult to be thorough when "linting" a programming
language merely via regular-expressions, and this particular
expression is already almost unreadable. The effort involved in trying
to make it perfect may very well outweigh the potential gain in
coverage.

> But we will start to detect errors like the ones mentioned in the
> message, which are more likely to happen.

Indeed.
