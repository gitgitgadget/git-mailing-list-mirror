Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329A63382D9
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771330599; cv=pass; b=GTiM/80QgEdVORmLeHfYKXseC9PRTvNssUMKESl/7SQMoEYqjDTHKk5K1FirO1yQfeYiUvo1g1YptMEobQHShrwbxGTJ/Uy7rE9e09Sdqfvlc5D1qNbeJti3yG2YUahSEITds7g5mBm2CQQs4lEBj7jGNurjFUvEuCGW0zklqLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771330599; c=relaxed/simple;
	bh=XgBrEuABczmTktcARVwE6yc2XKvTvMSSVIk1a55FZA0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=si9RIhmcVDl69wYXD8SgvAvK/elZd8i6jDXBlI3vMdV+BCuNgzYyuDBb21rgXnCxkoGi+ogjZFYge71MHD+lfoKhd6BDprdz2CLpjuL9f/2koyz1feKfY9YfStYSBtyn66k9BcCiSLLamE6YXouLlIwlbwkZ1M08iBFVGA7zfNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+fBUPyX; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+fBUPyX"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-94ac8cbf3feso2313093241.0
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 04:16:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771330597; cv=none;
        d=google.com; s=arc-20240605;
        b=Tp9kWt9oig+pqMg1jaNSA5T/+VAT/UZb90HbEtIf2Zw+vv17eM9VCI5PInIQLlos1R
         HI6ZG5SDdJ+67DbL0WdHdPsxtrCFbMyDRJI183KKwR6zZXJwoXIXe81k8AuuR41q7gGV
         14SqLJCsTNQNbhe7k1IPeWZ1YNRy4pi2lYeSXNBMGqpdgsGwlieivtE4XnLscKP7NIzu
         eP2AoOxefEKeSPcJEXvQ/aMNf21MrCXUQQ6clUGHF3pxxtyvAP7AeE3nMp6OT1qszBnP
         GbWM/mVoUgY6x9prNTGV/EXvf+e1y31WKO5v6I2fQjniI6SG6KzBfAU0hM05oSXEeid3
         8Jtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=XgBrEuABczmTktcARVwE6yc2XKvTvMSSVIk1a55FZA0=;
        fh=y9k48zSfJIWg+7uPFwtdmCt9BZdbcWQZGpaF84bYR2U=;
        b=SasJlnQljmIT3Vax8Ov03fwl0Ri7ETfFQVwMhTM3QTLWMzUo8ubcsdW23hzmLxcply
         QuQiNlYQIzHQ4kIkxclmLfXqzDJ7oUbE+6yxvz/iQeGXrhzsGrHbnECWizIDfbOAJ+nk
         Z+twkcbQozxAEGN9IJFeVCcGTtk1qgkK2EAz9SzS/JxrhYnbLgd0ktggXOd6TdtJJa/I
         lD0xuCqbTW+L25WJGJkkxQORk9/XWpugQtJl3gDXQ+03IsdheYUed44GwWxsa+o0pV5W
         ywIH6G22Vf0wq+7AnXdGCp7HGVPJ8ApLA3b52YhvED5zhOqpbOA3j+CCKBx/OrFZOLTF
         xgEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771330597; x=1771935397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XgBrEuABczmTktcARVwE6yc2XKvTvMSSVIk1a55FZA0=;
        b=T+fBUPyXLyxycI6afJOyjJkVvtKuzNxLEXhdY+als9GTxaj6gDvHco2S+wWXhcwgRi
         3G7HmLi6vj0W+aWEND/HYlyDWzaKh3dQBsqIRifST7oA5KCRvPnQJuFhAoKtHup1EfAq
         /JWU7GRsMAQbPDAxKuZSTgFQqXMhP6936sinMZ/TSztEs5MYQ6erg1ZM8rtbJ04Js1LV
         0iHnfHmqxgzbxEd7fFWKx5dRDN1DYuAGJaBJoVr9OlEdUR+6MrJyIMeiRUDTxizNLaTg
         kzWNbiPWSPEbohNP7q9V44Z2629n4b24swnnGBhh4pbs92xsiKnbt+yvJdKXItrCdI/1
         KC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771330597; x=1771935397;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XgBrEuABczmTktcARVwE6yc2XKvTvMSSVIk1a55FZA0=;
        b=gHrVKT0uey9zXyJo69zTAvmbq/38YfUnQPe3DWrtIjij6lRoQBStFdd8J3XCLPkLlz
         znhinjdRroSU3RSQ53Th4daXt/ng6WzHb+uVyDluf6DIDkBl+n1udS4c56ZqJAHQw1EX
         NwE77R6QpKZm12EUG6AOkCj6kMKWTZRaMZy7nSR7cRcryk2+noGq1f6lqDLM+2CGHXxX
         1DueTwiKDMWJcKZvKeM6Az2lkXjkvMWRSlRXgoank/GV3B6q25RIOlN/E00tZ5roHVAq
         JVG76Txg7AuPA9TkJC8/UlgY4Y40z2wT3VJ7WasaIH/+KiUN9kD3eI/6bdIPryhPNsKt
         csIg==
X-Gm-Message-State: AOJu0YwZ1CJ8T1gh+rMIcbDELTlwxdN/JyFyv91hQrlnaqdi1CkOUqRC
	00D3DpiyJCqzFkNOl/1WztrqbnoK35RJt4KhSGtjHDG4T8/zxmyKYmoYdaVBgOyw/qAjaIpEf+S
	/3GCSCyzaY10aTgRQ+KENLEYr0H0i7Uo=
X-Gm-Gg: AZuq6aLROmPPjVccu8RY0ky3jsJU9NSlX/mNRhDR9p8bABGglrGdp3tDANIfYYohq6d
	GiW8u/Qliy4aHxXOhxrrI1qt3zpadJvLVWz91wY835+oYb29XJQBBb3tRYSQfphRgBZRuWlwvCe
	glBZMek7HTIUTj1onvEBNLvMqmBZ4slnwMuFrxwS3BbeP8xQW8KGKT7SjR8XABgYSsMN/titz4X
	t/DOEqwoUg+fmM2bl2UvfwPgCDgsXm8MN6OutfZf6n1B0Wi0+WZwNr3gAjH/XGKakicyqxreWOn
	p3YU++VuamX00/yGVRj6PnErbYm84llJRIUdTLpUuT6KG9WYvx4=
X-Received: by 2002:a05:6102:942:b0:5ee:a8c4:18d4 with SMTP id
 ada2fe7eead31-5fe1ae9be72mr5204073137.35.1771330597188; Tue, 17 Feb 2026
 04:16:37 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 04:16:36 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 04:16:36 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <7a95b0f4-8242-4418-bc54-22e81cf40019@gmail.com>
References: <7a95b0f4-8242-4418-bc54-22e81cf40019@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Feb 2026 04:16:36 -0800
X-Gm-Features: AaiRm50VGOTd_EivJxgjCc5zGCOZcqi15q59ib_T9W5jYbCneEIoZZVBTa4GlA0
Message-ID: <CAOLa=ZQr_+fx1-j_dEbWJS=2BDUaFZ7ky6M-rLkBAWLVyd_d5g@mail.gmail.com>
Subject: Re: [GSoC 2026 Inquiry] Refactoring global state
To: Tian Yuchen <a3205153416@gmail.com>, Christian Couder <christian.couder@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000069899064b040bac"

--000000000000069899064b040bac
Content-Type: text/plain; charset="UTF-8"

Tian Yuchen <a3205153416@gmail.com> writes:

> Hi Christian, Karthik, Justin.. and Git community,
>
> My name is Tian Yuchen. I am an undergraduate year 1 student who's new
> to the Git community. I've been hanging around the community for over a
> month now, contributing almost every day. I really love the vibe here!
>

Hello Tian,

> I'm quite interested in applying for the GSoC project "Refactoring in
> order to reduce Git's global state":

Happy to hear that.

>
> Coincidentally, just as the new idea list for this year was released
> these past few days, I've been working on a patch that has some
> connections to this project. (setup.c: handling named pipes/FIFOs during
> git directory discovery, currently in v4). Indeed, based on my
> experience, this requires tremendous patience, but I'm more than willing
> to give it a try.
>
> I understand that removing global state is a massive, multi-year effort.
> I assume the goal of the GSoC project is not to finish everything, but
> to pick a specific area or a set of related modules and migrate them to
> use 'struct repository' explicitly.

Yup, that's correct, this was also a project a contributor worked on,
last year.

>
> My Question:
>
> Do you have a specific module or subsystem in mind that you would like
> to prioritize for this summer?
>
> For example, would focusing on 'environment.c' (as mentioned in the idea
> list) be the primary target, or are there other areas (like 'config.c'
> or 'setup.c') that are currently blocking other major features?
>

AFAIK We don't have any specific subsystem to focus, albeit some
subsystems are tightly coupled and hence can be more complex (e.g.
'setup.c'). So my advice would be to find a good balance, you could also
take tips from the patches submitted from the previous year.

> I would love to align my proposal with the community's current
> priorities. Thanks for your time!
>

Thanks for checking in, perhaps others on the list have more to say.

> Regards,
>
> Yuchen

Karthik

--000000000000069899064b040bac
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 66e3fb0eba3bd742_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tVVhDSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mempnREFDZTcrbUJKejF3ZmpNUlI4UUVuVS9qSndTbQp0aE5LOXM3ck8z
dnNld1ZBbkdmOTVNbFRseWRSb1hSTTQ3SE5ib2JiUER4NGx0bzA2dnVoTnZYQzVQaVVycmc2CmFj
ODVYM1c0aThxZ09iWG4rT0JQa1dOOUJmUERFUDNUSnRSbW0xdnErYU0vZTBMNXFJdVlHeEV1K2Ny
VWZLdTMKd3F1amtoRkpHcm9kRXhmQ0FNM1h4WUQwb3N6SzJleWprczVLd3RFVnExWDBjWWNoNFAy
QUhsK3NxT2F1R2J1bApFSWhhU2FtNGd2QzJRaXh4UFRydzlnc1VwTm96aWRCS1BjNE5mbFRuYmNL
R2ZDT2NQTE93Rjl0RkRwcWsrS0FDClpSdCtZcDE5TmJBTCtRaUh2QmdxNUdkRWJ6MlRnTjhrMmFh
M2pDb2JXZEVMM1EybVZ6YU9Da3Bwa3R5bHcvcTgKWEhQOFF6akRvV2pTTDYwVUVWWmM1YWJ0VXdn
MDhmeXpjVHBzVG5XUm5vb1dYMU9WSzU5bVRtcnhvVzhWK2pkcAowQTgrSnUzdkE4YlBxWjJxblF5
RUxxRlNTRVhvemp0NmxlVHpybk91c3gxZWdsanpZa2F2aFk1Q2FLbGhubHdQCmVnYWp1TStEeGFX
VFFHR2tNQUlWZzdZM204Tit0b2JMMDhQREIxQT0KPWd0bXQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000069899064b040bac--
