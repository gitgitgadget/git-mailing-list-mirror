Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA0A346E64
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280203; cv=pass; b=UqPT8CN1nUg92c7ThsGOKjynpSvbOjRU+FIJCqyj54lf+YSq0v7FnlubP7iOn93jOouVdL/RNSyrLlBSKS7CD+vSup7VfsK70aYKKmnAWw44XTwcYDx7Jibr8p82lq6U1xXdN1sgBmy3R99E+n1/678JQPu3ItyLGvMPODH9l7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280203; c=relaxed/simple;
	bh=tvCdvxiOdbHOCZ35VRwzwWS1S/lV4VNispGXX4b2ylU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpMw8IFBlGcTST/YgwkWqJ8/Nq60HbtVnXrU3GncEveR+GqHDzhk9PPeKZePx2Znn6gch0laaTmFc9EUd/+rOvo0uLXRDRmW4GRjRyUx9OsXF6OC99hRvrqoNlALyrsxfwY53UXre6FEYKxINxTZNxmOMPddYA/js2BXkshCowc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awC0SKim; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awC0SKim"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56adf76631cso2983247e0c.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 12:10:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776280201; cv=none;
        d=google.com; s=arc-20240605;
        b=Zm0345jUCnIOjbuYSObVb+nv/3dqGwsO4zNaC9TdJpuOOn+oH80h8uUV+WZCXUbmnU
         eZf9wSsU6rKzSqFzwrCRKt8A0aXWohnsFVf8zF5ar+dsWziwrJvHxk5wXHyM0kv6gT6N
         gBl8XMAkh/ZeUZWbt16+g8a0ELU+4LojOqDJNf/4TcyFynXUCxHn8P1XJlQOkRPGnB4H
         a1+dG1VStW258/2f3qwEW+0M8Em5znI0OeHHf3vhNymqo4iav0i9o3Cmp1I72F+MnQT6
         0t1OQFItDZdajEXbO9U9LKlGBv4hc2KQ7i72ZryH/cV79K029VISUIshjtojvKNu0pW1
         GrrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=mxwdDs/SBHO6/MH8vUQtTvIl8N8O0gsds9LY9B5ZBjI=;
        fh=JtEgnkpgU76aet8zrpCGnxyQsRsvcoWD7RZPbFi1HIY=;
        b=Y4sQgc1ufRAeLd0J7x7JZ50vB0w+YHeVFbnMDSHFbksttVciiFCInEfLNfG1ZEMCXa
         sVZR/HdAZ1ZCUQqNGLW8RT26y8Z1VTXcc2rnjAgxpwJQww9omrCOzi47ZC5XGq6ZAJvE
         hE+yFhxWb4O3c+GILtquY1epQsLifjF/KJWZEmL6EbruwUwjnvXi2P9D2lgi4Iq4ww7E
         2IqFUqbyJc5qz2YMDXTO85eIdJa+fDo0Aavh1w027/5XDSqhrCBB6RL0knOfeAykY++N
         HGiPqytWyACfXMSHRTlOWAs6qApNueaQoUoK3dw1DceXgMPThXhHE78ABK85FwnVNyrI
         COJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776280201; x=1776885001; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mxwdDs/SBHO6/MH8vUQtTvIl8N8O0gsds9LY9B5ZBjI=;
        b=awC0SKimWDza15CsoQ0a/gHWXZavyJ2kP8fQahwQp0RM7FEQWDq5V9PAv+90+KvpLv
         vcBGUzmE8BS3PnbeR347YGh0euYxR6RS+fTqDyY3K0rUXJKZjjvfmSd7/pFmZljT1WFc
         fvb8TgzZJsH9d7br7sHIVHS8W9ihKNbk19U4NvWRJezQln/MH6tn+PA1Xyq4YA1B1OJg
         Z62ahLshV8WepyZMIJDx87wgHh5Z0P7z/pzui52VBM6o6MdgIN5xuSqtfKThe1PHXSdq
         QbOSH+voKUPpOq0gEooYUiXifSUdAIuzIHvugJrisEnG8qJwZLUgC4vXWaqYE73PHym/
         KMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776280201; x=1776885001;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxwdDs/SBHO6/MH8vUQtTvIl8N8O0gsds9LY9B5ZBjI=;
        b=hG6q8Rb1a/b4P1Rk3Is8flenJJyEzdXEseUbT8WVKuISR4Kr9c3PJAwMZu60loe3ZB
         wEdtTGn8DTKuFUohZaGmvoRcBwxGlrOAlVjOuTwbubxEgZOd/6qDgUEHynU7jdlVoYAy
         NLFssegkGgTUqjFxiSmIAkvl34BXBGfGYBThKXuvhn8EyLbhMapiedo4oaUOVnjW776w
         Q344oTd1vfyeRVe7ta1aHjh0gHAi0VBrF385dIUdIlHR5PY0aZ8NAdQ32JuX9um88nqf
         iRfvkkp5xVe+2hEFNUGJJvJvujGf0tqngYxT6fXJ0YunYERe2LU6HHC7181/igBLjH9i
         6Ypw==
X-Forwarded-Encrypted: i=1; AFNElJ8gcNqVdZWiPXoKV+FGx7lyA2Fu0rnxx6ZNMn3kx+hjk4M5sw4edob63uNwn09no31BeZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6NMWoxl2UtC0QXiP+91i2SybIv0sG1wfA73f6lwbnJO0iW5lt
	rjiKFh3Y7UPU0Hs6vS4LynU8OQZlDx6Ua/uK7mhaUS5WhHIJtQt+FATgDDkXjDJ9h2oJINXDtV5
	WCirMnkOjEUOGyHovDaSPE4tQJEXho1RX4g==
X-Gm-Gg: AeBDiesc9G1UtLHSCrghENlhovukw5MLbvjwU72n778TlvqsfhFzZWSAxmsAUSWLRHq
	PEKi4Jy6O7Zy/FENiqju9eGTyihPz7aLUVWwlZzuwivL+riTu2N27tLU09gQvWpYKe4Xt+9Sv3d
	Y8janpHrlXhq4s3fBPq78GBRWxHndrnX5vyejmH0O/GljNOY8H/P570AEdyLXGrSQui0d36Y/S7
	skk+QDRkHXnnvjxo1j/kKa+20h2ZekXN5lg58FoGmYj7+Wl2mX0Jrumkynh8c0D8Yq01Wn0PXZ7
	evuiEP/m2sXtUB/U28QK7myLH6cuaqvtvNl8ob1g59B6zEf5UGvADmNcXDq0AZE=
X-Received: by 2002:a05:6102:1512:b0:608:a960:c858 with SMTP id
 ada2fe7eead31-609ff0c0bbamr8841760137.8.1776280201172; Wed, 15 Apr 2026
 12:10:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Apr 2026 15:09:59 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Apr 2026 15:09:59 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq5x5s8brc.fsf@gitster.g>
References: <20260324123750.157143-1-belkid98@gmail.com> <20260324123750.157143-2-belkid98@gmail.com>
 <CAOLa=ZTD+qqgyB4Pn4bcOfP+Ks8Zch+AWZkzhrRRbk-eJvS-mg@mail.gmail.com>
 <53f43b85-b274-4352-938b-d40f942bfb2d@gmail.com> <CAOLa=ZT8H3xLXjact9it9jveviztL4Q72KNMk5nxW_ouq0T0=A@mail.gmail.com>
 <xmqq5x5s8brc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Apr 2026 15:09:59 -0400
X-Gm-Features: AQROBzBzjFoHd9oaQ3PXXzCOt4C4jRgv1PwyRt0PM0hCZxDpmfe16mXansfkBeg
Message-ID: <CAOLa=ZS+br-gP=HqnMeib0yuFQr9=wVNFZC-vz1dT5ZVB6kJqQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] environment: move "trust_ctime" into `struct repo_config_values`
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org, 
	christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	kaartic.sivaraam@gmail.com, me@ttaylorr.com
Content-Type: multipart/mixed; boundary="00000000000069ba6e064f847666"

--00000000000069ba6e064f847666
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>>>> Store it instead in `repo_config_values`, so the value is tied to the
>>>>> repository from which it was read. This preserves existing behavior
>>>>> while avoiding cross-repository state leakage and continues the effort
>>>>> to reduce reliance on global configuration state.
>>>>>
>>>>> Update all references to use repo_config_values().
>>>>>
>>>>
>>>> Nit: I was hoping you'd also shed light on why this can go into
>>>> `repo_config_values()`. Does it need to be eagerly parsed? If so, why?
>>>
>>> If trust_ctime was lazily parsed where it is used we'd end up dying in
>>> match_stat_data() which would be quite unexpected, make it very hard to
>>> reason about the code, and hamper the libification efforts. I'd much
>>> rather we put the onus on patch authors to justify any conversion from
>>> eager parsing to lazy parsing rather than forcing them to justify
>>> continuing to parse settings eagerly.
>>>
>>
>> Agreed. A note in the commit message that this belongs in
>> `repo_config_values()` because it's eagerly parsed would be enough.
>
> I see "preserves existing behavior" above.   Wouldn't it be enough?

Though "preserves existing behavior" implicitly covers this, it would be
cleaner to explicitly mention that eager parsing is the reason it
belongs in `repo_config_values()`. That said, I'm happy with it as is
too.

--00000000000069ba6e064f847666
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ef1f45ffe562f3d6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uZjRvVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOFZYQy85OUxOcHUrNy84c2Z5Q2s0UkhWbkc4eStEbQpibFhKOE1iVE1E
VnFWazhUY094aWVzaDZGSjU3b3JMQU94c2tvdGN2d2ZUWjFlNUJwcitjUUNEWThSOG4yRW01CnFj
U2RnRVRFV0ozK3puRHdrSjdyRXczTmFBa1ptUGluWlV6elZqMStuR1JnWHROdGVZdVM1Skpac2RU
cXFlbG4KamRpMHpRNXNYeHRjZG52Mk9TcStzZmUwMC9GRFBvQVFVMk1YQVphTFVpSzVkaHpoOElm
VkhudEJheTVOTGZJYQpneG9YY01yRml5Qy8za2JsVStESktpTGEybWQwMy85bE40elZ6U1hsWHdY
TFRMU2NwUVV5N3Q4b0YrbWFFd0p5CllMQytramh0bnZWeFhMdkxCdzUybHljQWJIWTB2ZElwWnRE
eXNOS3VJVUFPRTBqRE43ZVAzTXpubkJ1Mmt1M2gKUzBoeXRWNk1Nc28zWEVmN2t5NUtOM2R3aXQz
YzBpVDV4blVqREROYnZ1VkhKTXR2TUZTWk9MaXlPUndWVDRpTQpYTHM0L1d0TXhKZGZuMjllM3Zv
d0ZKUGhhTGM1QkY0dWlTNmlrME5yK29UU2s1UklzM0p1bVhlaFVPTzdwZ1ZSCmMxY2NnaUFUNGRT
VFhFUEVOZ2huWllmckhTS0dmWFdaUlBya3I5bz0KPVhmM24KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000069ba6e064f847666--
