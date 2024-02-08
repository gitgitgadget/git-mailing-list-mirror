Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E167640A
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400976; cv=none; b=m/OWdXjQWLMiQXnPR3RNGbvx2My2NuYf3OQQqLIxW7zzdV2WpGXWLe42xe9TtRThXpQuuH1whtch2uXzBWRiYDruj462gA38C6O3UvVq+/GpXZhleVSgFXloCEjw+1ye5MRUBoLVHUPhX5Fob2YkrT936A6uxNF944P/M6nwwPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400976; c=relaxed/simple;
	bh=l36M3cAg7Rz7iouTgP8FWyIgnh2pdPrIWaaUAzlqyso=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hZWCmoIizJaE18aiK7JP06f9c4CZ++gU0R3zM9VhFyTUn3NuSZ64ikn4B4kakG55UgHeYGvxOFhD7gVmwPnf3bDe3o7VlIkC2uMg2CCEy6NRhkR9nTcisTf8fANlGRHAoeKjyEwOIhKDgLwnSoZHNZ8ZYPKpevLY9WkbAEiDkRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzCuc9Bf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzCuc9Bf"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d94323d547so16874185ad.3
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 06:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707400974; x=1708005774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D730zYArsmcvliquW19u+XyC+D8TBFeTib4csrY9tWg=;
        b=kzCuc9BfMFcWnBIDUpXY6H3AvIedoBMXIgjM9q7VRdtgG7NRuDlZEw3TmvtHHatwFe
         n4j4P6AWhfeuowkEgwHA252GONF2GUh+U9xiF/qt2b7jeZrNJuEyweTXlIe2DgBkEd93
         jX+/qWUc2VW5iddIiy1kHeuu/FIcItO6SenUXQnREl5V0MuBMsXBbwPA8gCjWxZN0yjU
         hreTUzISEizsarypKWUBDJH7mtCfDYYnkpsBkp+GooROQ+ZwakV6ixxxC7CVoMzb1OM2
         1GoAoYFU0mcP4h7A74lDNIUvcXrNxaibYVG+XvAuNLnnhIfZfgwCZ4GwQ3cdMUdx6GxP
         qWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707400974; x=1708005774;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D730zYArsmcvliquW19u+XyC+D8TBFeTib4csrY9tWg=;
        b=gEBBdcSDJekLRyERIL2yhzCor1pbpzBrcA1fVcM9RTj/MWWueBRBHi+ycHmakUMrIh
         pQZsxGaiLj0dRHqhl7lIF5p5vNYLQAkXF/pt/bjWxvhMy3xw/LkckQU2cPRvzqY1e/K0
         /4rRy111kMYfGnsDa9O5sz0zri+Hiqj6NBc9yU0NpmCVMy3i770XZVgUI+PB7wMWttdc
         8f7rZxF1cKRGLJP/5oMHZkqY1nDND31Xmicq+HG+BNg4cBAoShJ5Ztc+xZOKWOaVOnjQ
         hvzR8eyxJ4ETCEHmi0jzshJ5JpI2s0Af0DItVPIEgGmeUI5BPkSihzvy4wd/uckZOnVq
         z/jA==
X-Gm-Message-State: AOJu0Yy1PChqpXcrTPAvc9lp6Pl82CsJx/enYmkZFsASCSjheUnAZ/ah
	ycFRchNcrl+LB8kLKXbi+HYuVAnik3xfxYouwkmLXVSPY35cvDV2
X-Google-Smtp-Source: AGHT+IEepn78FRGXtWR/poU90cKa7QhM1GI9N9BatlNt0mKdERR1hGBkLEKV75a62ncyDBlEaRXU5Q==
X-Received: by 2002:a17:90b:90a:b0:296:4177:fc4f with SMTP id bo10-20020a17090b090a00b002964177fc4fmr6147485pjb.30.1707400973657;
        Thu, 08 Feb 2024 06:02:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNUAg3kRJ/1+qorr0YCr3qbPbsX1ONyioHhoNfiQDSXHobNaxDPfQRi53Mb2ZzJJFrBSB+uwcjzJMCJcbw55mAaee6t3pjzMIfWPieEztdC2dDcHHnQ7jTKNvLz+mtqLiTx2Sr3oUbjK5FbX4HZ9bZjsPaj7/ZyQrhPssrmKLUBiPYbdGA
Received: from ?IPv6:::1? ([2401:4900:4dd3:c82:d365:e557:c43e:89b3])
        by smtp.gmail.com with ESMTPSA id w13-20020a17090ad60d00b00296a23e407csm1591238pju.7.2024.02.08.06.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 06:02:53 -0800 (PST)
Date: Thu, 08 Feb 2024 19:32:50 +0530
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Christian Couder <christian.couder@gmail.com>, Patrick Steinhardt <ps@pks.im>
CC: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
 Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] Add ideas for GSoC 2024
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP8UFD2yFr1uOjKOnMjznjR6BEzGqq=R7K85z2Jz4i=sG0CLJA@mail.gmail.com>
References: <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com> <106b8e7be9ddc2d24670b01d54347dfcf9aef196.1707122040.git.ps@pks.im> <CAP8UFD3F95TzytdpKO=LLf6Y_ejxwh9QtgAxRNKgMXW-72hjgQ@mail.gmail.com> <e1c04f67-5981-4393-8a8e-a28cc53858eb@gmail.com> <ZcHIxcrKbgyhdyWn@tanuki> <CAP8UFD2yFr1uOjKOnMjznjR6BEzGqq=R7K85z2Jz4i=sG0CLJA@mail.gmail.com>
Message-ID: <F2684AB9-C4F3-43C3-91F2-A6D7D71F4927@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Patrick amd Christian,


On 6 February 2024 1:43:02 pm IST, Christian Couder <christian=2Ecouder@gm=
ail=2Ecom> wrote:
>On Tue, Feb 6, 2024 at 6:51=E2=80=AFAM Patrick Steinhardt <ps@pks=2Eim> w=
rote:
>> On Tue, Feb 06, 2024 at 12:25:31AM +0530, Kaartic Sivaraam wrote:
>
>> I don't quite mind either way=2E I think overall we have enough tests t=
hat
>> can be converted even if both projects got picked up separately=2E And =
the
>> reftable unit tests are a bit more involved than the other tests given
>> that their coding style doesn't fit at all into the Git project=2E So i=
t's
>> not like they can just be copied over, they definitely need some specia=
l
>> care=2E
>>
>> Also, the technical complexity of the "reftable" backend is rather high=
,
>> which is another hurdle to take=2E
>>
>> Which overall makes me lean more towards keeping this as a separate
>> project now that I think about it=2E

Makes sense=2E  I suppose we need to capture the distinction more clearly =
in the ideas page=2E

I've tweaked the doc for the same=2E Do check it out and feel free to sugg=
est any corrections=2E

Ideas page: https://git=2Egithub=2Eio/SoC-2024-Ideas/

>Ok, for me=2E If we have a contributor working on each of these 2
>projects, we just need to be clear that the contributors should not
>work together on the 2 projects as I think the GSoC forbids that=2E
>

Indeed=2E We must make sure to communicate this to selected contributors i=
f we end up choosing two of them for the unit test migration projects=2E

On a related note, I think I could help as a co-mentor the non-reftable un=
it tests migration project if we don't find any other willing volunteer=2E =
:-)=20

I'm hoping I should be of some help on guiding the contributor as a co-men=
tor=2E Feel free to let me correct me if I might potentially lack required =
knowledge=2E

>> > That said, how helpful would it be to link the following doc in the u=
nit
>> > testing related ideas?
>> >
>> > https://github=2Ecom/git/git/blob/master/Documentation/technical/unit=
-tests=2Etxt
>>
>> Makes sense to me=2E
>
>To me too=2E
>
>> > Would it worth linking the reftable technical doc for the above ideas=
?
>> >
>> > https://git-scm=2Ecom/docs/reftable
>> >
>> > I could see it goes into a lot of detail=2E I'm just wondering if lin=
k to it
>> > would help someone who's looking to learn about reftable=2E
>>
>> Definitely doesn't hurt=2E
>
>I agree=2E
>

Thanks for the feedback=2E Included both of these links in relevant ideas =
too=2E Feel free to cross-check them!

--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
