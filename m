Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792527368;
	b=QZpLZl7r/WQwOg9ZrkmKaWAYSCMp63wH6TQqX9iqi4kBKBgr+xjze7b5wla+RN90m+eb
	 t8UQPa1tMdYpE7iq9skBNp/cM7XWWp1CEr2ChL4aGJmUv3sayZhESllS4zSy0gD8xEWZ8
	 tMG68Jz2brFJziBvKkBGt8i6tZCqWVJ1/4NWXAdu+T0QqhBnQnd48YdWd42rTs4SySCxi
	 QrY9N3lpXHB5zvMwGsiaYw3EcvhXQz52LZNENUkZGqgFdk2g4uOVsX7yIjut9orjkH14e
	 t8E6dPYrN42BbYVB+lMhfgHO64fluqscaT/WjrCtYXa9H7EX8vB7r/03dxLmpLCtpuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type:Content-Transfer-Encoding;
	bh=lZjC1fPoC4SkqP5YKqznkr6llA8hF5INixDUXlLOflY=;
	b=XgwXJTFlcLpSUdjveYxtNnae7FTaUeyX/QzdXe/hKSQ1NYHLamNGtTrp/mBNtMkTFf2n
	 JqZKWevf2h4oIfGtH7WavnyhQGjCz1hsv3IlNSz/K58Y8dcEgxxKHhyOD0gJYr9hPoASI
	 9Dwc3744JvY5CDFG6Vwy1LwHsWlg9RdsLN6xC3SLpS5t4YOM22pE6gupDbuSQATJ+Qkda
	 JdcIm3dewkJZsdDLmsh9UNBxXdbBIWgsK2O+7CBfX0qDw7byO31xkrXuLep4mdFXu3aG8
	 KcmsUa6qfrl5N1hkeMhItYIpIX4sDlHnViUmCwDTwVKYxMM+M9GDWQUaPxbktVPyyTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kfsvbvoY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.67
Received: from mail-vs1-f67.google.com (mail-vs1-f67.google.com [209.85.217.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D24C606A31D
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 20:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D24C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kfsvbvoY
Received: by mail-vs1-f67.google.com with SMTP id ada2fe7eead31-7c4818e4165so40709137.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792527367; cv=none;
        d=google.com; s=arc-20260327;
        b=hvqb6ldfSuca52iMZ7hZcAoJqAcXJcjw2pDz1gC8iGTjnkogX1vM5IAkJIu+xmS1Vv
         IMSwAgv5hL7glqI97AX6IMwrsfcvkBoDPYzNG3C/9tAw/JkK0+3YV3iAeXcg3plJl2Ai
         s4squWebtxVbbdZHW4bztZRNqJihI+w2NY6ia+jZ8YcykUtqf8dd1ZqZBmAJ/jIp0jLR
         5l+38rehCaV7OIW5lZRUa0jOG1yKTXvl86xXaossvmMaTU1Z/1VqSdzAn7/YoNrdDj4U
         PcUqit5NZkJOH8iw7sE8VVTfteP60zwtlUC7cNv1LLkRn7v4i+EYXZVzhrNWLqYin0+V
         wdvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lZjC1fPoC4SkqP5YKqznkr6llA8hF5INixDUXlLOflY=;
        fh=+gztBBVrw9S89UeGWpGWYqiqLt2feVwDB8xdgd7oLF8=;
        b=IOxsaZ/IUe1s83ABN1eWQg2GHt5MOaKXhFUIFAAaSoLNdwY9PQLtt89n0HNX/RmMK5
         2WzagobUvMgvp/qu73riS7qNeXL1+37OArEMvY193WzrsH5fVvh+0aH+0AYMUptP71pf
         LqqmUCh+RweLdT1ZXgpbSBzoQAl3bhcDx07Pd9aQq8jhYdj/TF5Lq+dMCYVFAVDQrUM5
         An3pZb7bYEV6SKBdoTcKGMilfM+Jfmirq9NfiEO945dSvX6mzoVpz/IUICyru/q+OhNL
         aOc4ckTC+y2fCTvnC7DBPNvY8sTa5a+zLjwamFEVJIlzJG4m2uNrEmn4rTAuYlcR427y
         9wiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792527367; x=1793132167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lZjC1fPoC4SkqP5YKqznkr6llA8hF5INixDUXlLOflY=;
        b=kfsvbvoYaAY7d5gW+EgVWm1y2t8qJsKN0EDMqwzAml1R2Bwxgh2JOxP5IAS6OD1uQ4
         uW0oHY+y727fNZ9T/fFSMpR2qYGYA0drVk/wSX2pniZKhoArf+ZDydnZLCxuiaXOZyzX
         4SFTmbBls2tTw3wAKbS2qjFvD+ADx8WfdGJlvDiTZYgL5VN4+KsqDjYDiSr1eU/6AeII
         hlNIOa6K5KbdAnjaW9sEb6g2xL7EG+eyGC+O3Rey39U58wEBhHv25o9b+PvvFZX1tO2K
         fvjb8UGrE/YnY0lW1vjbsuWNNBW613t4lt1sPvCEoxfquBUBh1l+Q4EzNKVYtvmFXDyn
         2W/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792527367; x=1793132167;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lZjC1fPoC4SkqP5YKqznkr6llA8hF5INixDUXlLOflY=;
        b=PRqX3whvaBCFhHHpVjoFX5yI1by98e8hQTXKyHxEeX18IbY/o3APeT2CKr8OviGz8M
         JvsAezd8ay8Aj+GQzYpoiVuWYFIeVCvq6YOaHuhlHzCTORKaDhZuyeXuF+PWac9iAWm0
         jKA1OekQuf/dlhczkNI3D6+ZiAr60xrG3k20G3AysTvVlhRFyBNI7bnh2XyinbbnCIUP
         ZgVeQJ4dlGMQoI5Y2n2MbjlvmcZHvr9ln2pDDJDfMGsRHVcLwcpIG7J/dQnP925h4Hk2
         rmFntBTlo/LJxdHW8vCj7FEc4fRSrHAoHWMqKlHoppC/Ft8xvb+l0QorAZUizQ65j2XM
         Hwlw==
X-Forwarded-Encrypted: i=1; AKwUvBwCq64he83A+ytBg+xMsxhIWJK5/824Mp60OZKf2+Ri1r+RCKCyyMhGZflxqa4wB40P6Mc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKntzQok5JOfIrzXv9Pj9oMPlnQRk8lZt3/0FW4uslroAwZJM3U
	Sk0wG//0Vds14vINm7V3TGkdFbYX/1L0Vso3tsHljqvo28PsYen+MhSBHj9H6ApU34u8GPQrSeY
	/2xKAq3Gg/UiaOUTa7Dm1/AOczWU+w2A=
X-Gm-Gg: AYBFou0oyu7LdbiSKtDUBi/byde/ndVw7f692A5iG5KWOXL5JSelATG7sIelG8yXNsF
	cu3SagQFFf4th2lgHTOPgrkOj9Yod/IXZKFRuRkWbCh4T7ufbpuJ5r4pO2/8KhEcGB75xjdQNBM
	Q9CAQ+vqv2iF/k1gYm+2YR1u/tpUq5O0TVFRAuetveLtKGZdarnrWY9hq5EuFI0Jd7DW0VaDAAr
	9p+0ms7rKYIOuVZhuGM7uQjEC2FvYe7CcaNipX5SLJXTTrJKMILRDdBbuLGSVmLdbohsDUh7xcR
	AdX8BiwedaUuWuIjAi1psj5AWX1nXv1ifb/iXGu+AeQxCBE8jxQWzqRH0kfuJzUQbHxugdGiC65
	evNY/JRWxaZI=
X-Received: by 2002:a05:6102:41c6:b0:7ca:7226:b414 with SMTP id
 ada2fe7eead31-7cc7bc184d6mr584163137.19.1792527367085; Tue, 20 Oct 2026
 13:16:07 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKA8Uu1oLhdhNC9hGwMvQSC1+jzJqXnnWPGHLZUm5ZBdPkEM0A@mail.gmail.com>
 <CAPSxiM_5J-LzAx6pkMrH1L08QX2hP5KgqWbmc6b1Oa2thboZBw@mail.gmail.com>
 <CAKA8Uu1P0Mtbf8GciaqN3g-9ttyKn7Gh-3Aa8F2hV1PCbGrvWA@mail.gmail.com>
 <CAPSxiM_GysceRRyEukVkUNhzvhsXcCKYsQXYmOyqa9kZO7kx-Q@mail.gmail.com> <CAKA8Uu1R5dUi0OLHA5CWVS40iE7yfkJFN8hbBuAMoYa8eQ7Usw@mail.gmail.com>
In-Reply-To: <CAKA8Uu1R5dUi0OLHA5CWVS40iE7yfkJFN8hbBuAMoYa8eQ7Usw@mail.gmail.com>
From: Joy <cryptocurrencydiva@gmail.com>
Date: Tue, 20 Oct 2026 21:15:24 +0100
X-Gm-Features: AclHuK-7aiwwCkgWcAxXG8Y12zkoHUoM4CQziF2NHNyNEliG4AwmB_lCGJVcEVE
Message-ID: <CAKA8Uu2WZQ4J8+eaW3EJFQumRuhx25OFVsD1UCkRE6ouVDGBFQ@mail.gmail.com>
Subject: Re: Outreachy: request for a focused global-state migration task
To: Usman Akinyemi <usmanakinyemi202@gmail.com>, christian.couder@gmail.com, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Usman,

Thanks for clarifying!

I submitted my pack.packsizelimit patch through GitGitGadget. Here=E2=80=99=
s
the mailing-list thread:
https://lore.kernel.org/git/pull.2271.git.1792522587065.gitgitgadget@gmail.=
com

It moves the pack size limit into the repository configuration as part
of my work on the global-state project.

Would this count towards the microproject requirement, or would you
suggest I work on a separate, smaller microproject first?

I=E2=80=99ll wait for your advice before making any changes to the test-hel=
per
idea, as I noticed there=E2=80=99s already related work on the mailing list=
.

Thanks again for your help!

Best,
Joy


On Tue, Oct 20, 2026 at 9:10=E2=80=AFPM Joy <cryptocurrencydiva@gmail.com> =
wrote:
>
> Hi Usman,
>
> Thanks for clarifying!
>
> I submitted my pack.packsizelimit patch through GitGitGadget. Here=E2=80=
=99s the mailing-list thread: https://lore.kernel.org/git/pull.2271.git.179=
2522587065.gitgitgadget@gmail.com
>
> It moves the pack size limit into the repository configuration as part of=
 my work on the global-state project.
>
> Would this count towards the microproject requirement, or would you sugge=
st I work on a separate, smaller microproject first?
>
> I=E2=80=99ll wait for your advice before making any changes to the test-h=
elper idea, as I noticed there=E2=80=99s already related work on the mailin=
g list.
>
> Thanks again for your help!
>
> Best,
> Joy
>
>
> On Tue, Oct 20, 2026 at 8:57=E2=80=AFPM Usman Akinyemi <usmanakinyemi202@=
gmail.com> wrote:
>>
>> >
>> > Quick question about microprojects
>> >
>> > Hi Usman,
>> Hello,
>> >
>> > Thanks again for your earlier guidance.
>> >
>> > I=E2=80=99ve submitted my patch to move pack.packsizelimit into the re=
pository configuration as part of my work on the global-state project.
>> I cannot find such a patch in the mailing list.
>> >
>> > I wanted to check whether this would count towards the microproject re=
quirement, or if you=E2=80=99d recommend taking on a separate microproject =
as well.
>> >
>> > If a separate task would be helpful, I noticed a couple of file and di=
rectory checks in t/t0200-gettext-basic.sh that might be worth converting t=
o Git=E2=80=99s test helpers. I haven=E2=80=99t made any changes yet, so I=
=E2=80=99d appreciate your thoughts on whether that would be a good task to=
 pursue.
>>
>> Generally, one microproject is what we requested for. But, previous
>> successful applicants
>> do send more patches after their microproject. Git is an opensource
>> project, you can always send
>> your patch.
>>
>> >
>> > Thanks for your time!
>> >
>> Thanks.
>> > Best,
>> > Joy
>> >
