Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6FA3F8883
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484744; cv=pass; b=UOnFAWsK8kTqk/55J1bzNSlAdf1OUiYviU61rGrUPkdJ/ombHrGYEVzwOWnJ+OhrHv8IABqgksuEMMKXypgjifylNOJDElYOmWXF54oJZ0tL/D1TY7AhbPMqGB3xn98QkluXn3CJgS1AG+6DO7ZrgSqysn/pl5th/y+TXTwjRGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484744; c=relaxed/simple;
	bh=LHKp9Otf1MEV5FHsQx3o0jiuz8yHSVgb2V1aFoXBfsQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwZbrGKvFdeh7GOzV7KnXaYhMZ6sEbzsTtZpjTUnDUkMUpnfrdl3K1rGVKdqAvuP2yQmoXFGD18AkS1+OplJkEHP6VfM/Sj7sHJvTj/ACg7jVop0gESSqPryPYrCoFfYA3JEJ8RGET0hU6Xxkol/7vEAOO+o5aOpJfovnwQHWzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssH3ZeHY; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssH3ZeHY"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-734ebf7ff13so783192137.3
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 07:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782484742; cv=none;
        d=google.com; s=arc-20260327;
        b=l9GCzOr4ulG7wYyTDVNq1oJgJMoJc/PWa3zA/21ek9HnflRqgSvNoup28mf401h/wN
         IBDIzx2XIBB+S7hGJ1jMEwHJ2TXQDOYlRUhwR7sxp8lsphoIdUAHieEYSpkTZ5/vwML9
         Tp4/80BxvV4jSNoL34p92PI27eQc7hELKDx1c7/aNg0jl8+h6LcEfIBQaCi64My5o9IJ
         XJzTty3f6+TuhJtwSS1NdnC24weUi1z55dwKnf5C7KJGPjOjjbTUYMwgd+DIUSQkVqsq
         X9q1nhh6TwjojRHQIJOCR3PIJNr+SxiM9O+kqe1sC6z8RKKFiGUbYhXy/HHN5MYm2NGS
         VJtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=364+y4CbWbwgZeStwrqaoc6utSxOxqU+7zT1eJLy6uk=;
        fh=5mx653fmzi9aVJvUgHzICdmLIHAu98huxeMMA7vQ4DU=;
        b=geiTBfQiMmOZfDu7uWqgoNX1b+vWZt5ep7EikjbK24SCL9XPWr7Dz2cr9QonCo+YjV
         ukfU+qLDlq3v30s/GzCR7Kz9osZvdfZUmZOpGYnTIVuPqeCxFO7tBiSzURvYSFvibxJt
         MOeUcRb2R3RMc2ub2pMudpbEqBhQjYLvgpmrk2lORb8yHONKyaA3hcYP9pJ4pFRDTCUT
         UYZtWmk6MZDztMGS0LjyFDMOBFfW5568hXjphzlLkhK+ZzkvrdOIG3+JKbv5LZ3vWa1w
         GV/kioalFH2dDXPJy+IOXMbTfTxPQbk3WxSmaEPhm2qPc8L2Ba39giTIu2n6UYG0oUHl
         29Ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782484742; x=1783089542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=364+y4CbWbwgZeStwrqaoc6utSxOxqU+7zT1eJLy6uk=;
        b=ssH3ZeHY4Jts9wpZzS5sMMyjy8gqQiZbLWIcza0aBW9ICFyOyq36oMbxD/UowuwlFg
         xXldGC4vi7UKC/4iXWk8G+gbWhZmpFNL6iL+8FQFfEVMOIv1u7wLvLVb4mmT650K+xBE
         9G8C6qm4P2w7f2AlkkChUNt3ZIevPVdN0ME5BGHRvA/CGc4/x3fWE3gIKV5Eed6E0Luy
         SS/C51vQs2IkVxy16sWlKBy0VXzVlPWBuWggLcspWERySO4WM4IGagqsdO52NaEipgYj
         t3u8MhIhn8gh/bH+C/BRt2Pf86S+i5nxpaXEVgyzN0MNaqdYc3Io5RfQZycOeVgFS2qX
         vb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782484742; x=1783089542;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=364+y4CbWbwgZeStwrqaoc6utSxOxqU+7zT1eJLy6uk=;
        b=IfDP0ttHt9ye51U8TWeXMQw/Ie/OBmASNKW+pXYzmLPFWJAOq2wkaCakMiedWAJuHY
         aE4f13UjNpdp/PT+teiZobDuRbthl7H/LwXDazpXjkjKf9QvmMwTCvnnGheXjSsPjwMR
         3vwBa2VzNxqZLqC292uwtDjX0vUMoY7/Q8t8BD0cUEJy6tmgFkHjio8ZDo6NH+bjzXM1
         vl7nzgtrlMVozZpr/CQ3sY84aeCIhArnuzgtA2yEGsRWjiOTsiAM9A/qLuYjSoGcNATO
         rm45YZWNXAbw1JhifHheWo3w24mIzCxXssqZpf3buRXm64BMnT+dUTeav4w7cWfDyeC+
         Rg/g==
X-Forwarded-Encrypted: i=1; AHgh+RpA2G6E6mVVnVWtE/QWSIXSt1JiDrgG/ElA+dMQo8yY+yXMjOnF5l3r6NvHqwYfLaPWUNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPQfyCfsoHuFUdzyN5EdmoVpL27HQHMI8zVmrhpm6S1Gd+NnkY
	+xL2D/jWSq+ksIQhIreoRIQd/d5Ty971uqIkl7SYx2cA6ayFVycBXpM01FwlhdpNbFPLwQX1xmR
	Flj15WrqJ20gKjK0SbDu88nIVYRxe1RY=
X-Gm-Gg: AfdE7cnLbEfwNrdpDw13ZsRZlDPrsM0eSIOSeKQGGzNkPW0cS9Rh7mcity3XoMWCObZ
	es+/LX4q4R82mpZv5NLnEKQdtN1YMcQc012hXnNiAJdEZMWFZ3NQ7/GbtE/f6xRKkoTMezIpGS5
	5b/2ivAdO4ObwLmyF0WJFyEW2WLPJQcFjBXQoJHjILwX9crGldM14LKWY/H8TTfB1Y4NUkfXLYo
	4R01Gs0DMHXS0IF1wM6o7/KyxX3W+UkKPWWIGwg8ojdCFzQODcUzF8/bM/B57GHaS0uxkElUjcC
	+mgrsfHcaNqiPUeSqp8YGPwyedzQ5qXQ5CkdFeJH4Ctr8nu3+gvaCSb+s5SCmc/LuYBTjsiVxg=
	=
X-Received: by 2002:a05:6102:1623:b0:6c4:5bdb:5e34 with SMTP id
 ada2fe7eead31-73430c8d95bmr3914805137.0.1782484741924; Fri, 26 Jun 2026
 07:39:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jun 2026 07:39:01 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jun 2026 07:39:01 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqpl1fhesc.fsf@gitster.g>
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260619-ps-eric-work-rebase-v13-6-3d4c7315d2f8@gmail.com>
 <CAOLa=ZSvxXuf_bSzKMvViNQ5MuDAqxnQdo4asF9vfMhJaDQcVw@mail.gmail.com> <xmqqpl1fhesc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Jun 2026 07:39:01 -0700
X-Gm-Features: AVVi8CcY0b6nbYpUlCqLlKwgypmysnHBHT1OY4nF5mNgREC8zpr8Pln6N-lTUP8
Message-ID: <CAOLa=ZRR8w2Uaxive8zYyb6fk46rnLuTb-91d2yf=5=Nijzc8g@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v13 06/12] connect: refactor packet writing
To: Junio C Hamano <gitster@pobox.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, peff@peff.net, eric.peijian@gmail.com, 
	chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com, 
	toon@iotcl.com, chandrapratap3519@gmail.com, 
	Jonathan Tan <jonathantanmy@google.com>, Calvin Wan <calvinwan@google.com>
Content-Type: multipart/mixed; boundary="000000000000dc537906552911a6"

--000000000000dc537906552911a6
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> +/*
>>> + * Writes a command along with the requested server capabilities/features into a
>>> + * request buffer.
>>> + */
>>>  struct string_list;
>>
>> The comment should be above the function and not the forward
>> declaration.
>>
>> While we're here, why not `#include "string-list.h"` and remove the
>> forward declaration, is there a circular dependency?
>
> Isn't it to avoid unnecessary include?  When the header itself only
> needs to know about the presence of the type, and not the concrete
> shape of the type (e.g., because it only uses a pointer to that
> type), it may be overkill to include the entire header file.

Indeed that seems to be it. Makes sense to me.

--000000000000dc537906552911a6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c4f59ae2f6c9b36e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vK2p3SVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMjB5REFDQzJTS21kdm5uZ0xTQVduc0E3QmE4VW0wNgpNTGpGY2Ztc1da
VUtITFRndytwc2J1SHBHdTU0UlRoWUZWcS9pVEMyT2hLNUI2R3B5NmJJQlo1K3N0N2g4WWNDCk1i
R3lDRjRER3loTDFkcEF4QjA5U3FoU1dHbzBiR3pmcWJRamtyR1BpcVFGZWsreWFTelY3YXRUWSsv
aHZscVUKRmhQSVU4QmV3RmRFZWtjMlErbkJmREFtdTB2N25ObWhCQ0ErMWcxU2ErS2RseEE1aDV0
a0hhTDRxNlpCdy93VAo0aDU3SUdGbWJTMm5Jdk1BcnFTalhUTjhVV0VrWkxmaUxkcWhKSkhlQ0xl
WmxYTzFMVFdjeCtnY1hvYWJUU1hDCkFJN3UxbUxoUU9odlBHQ00veHZtdjg3QWxGcTNibGtIcUZo
bE5RTHd4ZEM0djhkTVR0QUVHMFdDdjZPd1A1c0oKUkVnNlRmdnpPZXZCMmMzT1d5cllHSzZBcFdT
Z3NCOFZLVEhJZkI0NlZFSVA1eW40a0FDemtySkZQeUlQNmFWSApBZ0U1VVFrcjVURnhmVmxUVGZG
aDBEOC9Jc29rQU40dm5najBuOHhJNjVVR2hHL0tkaXJ5T0pzS01PckJwcnF4CmdxZkNLZlNoNVZO
UnhJR2VUc0c2U1c2aElTVGhPNTF1allqZ3o4VT0KPXJ4djYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000dc537906552911a6--
