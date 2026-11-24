Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795536806;
	b=LTqPB3yQeMgOZ7rNLZlcZfL75WiCLK28pKd6sazqhTDL00wZOAeYbLhICQol+VcSE9E3
	 4n4NGfF/CycXi1KzepBe3yzG7FZ23VJmbz6QaLJ6Fa4XDcWFwGU5FiAtoenCy8TtEyhGy
	 nIqh5lGLJzFVh88VDLzzi7/cBEl4rOLDA3Ge054ez4UYZtiScv2mM/C2oprkU15hcGiRY
	 1uMHt5+Pp+pgEawfpMk3g2nJcD7lEcX6MHbUFRUyP4BhFgeJ45AKIt/0jBtw5EsHOshYB
	 7Y/G9y5Hzc7oWf5sa10Iw9iaE+BC6ISJdvdOMtI8612Dk9bFVvkw9NfSWCZCX4XjS2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xFEgFJCLkhqDnHxeIYsSFOv/y/oat2ldu84bTi9SLd0=;
	b=mYg6+wbtpnuU4+03L+0AmmgPIo1kCrdAhhy4lmccLNbtTp+BySuadjte9M8jHcJ5zZaB
	 2k2cJ65ffYMQGj2w1dLAODY30nzLkRUdxoJx57/PjFydlplQAmdOam72376QExBYL/leI
	 yQ7JrEDwEcciMPuomvNI2joD5p6AcI32pI1K85FTkoAA2EaeK4Cn8icLR0mNZbrLBN7Dt
	 NiuhY0snCDmLofHfDN+d8Rz4bX80nN7a5I9RYBsZm4744v44voTrJHCironySVr10g5mA
	 dqY06z6ntp4I4TlISaPxpfKVc64Az3PtNB1y4yKvZLrZPeIjUlZmP/4fw4IJnFNt2bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fx+NljvC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E1606A321
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 16:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E50E1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fx+NljvC
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67db35e7953so4852304d50.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 08:13:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795536805; cv=none;
        d=google.com; s=arc-20260327;
        b=INRs1FeCHj8Ag+WBkoGEhcBlce/vXXuGQJkWLQyZQXKgg88utZgBQs023cF1PMAhDd
         /R++Gf7GIOl7NVafqO2aeZ0D2zQ0hG/dVUrz8YnqUwMZFWbHb9lPfVJ9QDSNwehhKlNA
         n4J6dSvxNRRfcFRt5mbtnCdCVm1FeHw8mqIw3BqDZVIF2HvruyfD+f2dEJfLc9jL3Laa
         L2P5jzMQrLoHa/TyPjATaKmAvHvkYzUIcz/tMPdibneRdAC/kygcQBpUjm6bXFo8sqsx
         uKwyKIK3X5Kjzy7vJEE4egEfuLC8mgQXYfkAquy2tZNY4BOpunutyYd8CgZp534lZHuF
         GYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xFEgFJCLkhqDnHxeIYsSFOv/y/oat2ldu84bTi9SLd0=;
        fh=cJCXurRSZzlTE4BxroFU87ZbMnK6VtskUbjiTpuPIYw=;
        b=TD5tx0Td3EKqxz2sOJ/QFWmit5GND/oHDGMLhxaE6ECS4tC3VBkmPHDy5bgEiwwPHe
         yN6lMVvo2UxEd6w43zH8NMkBwRGF5c9oAvzRzG68t9ow1QVv9YJ0Hh2DDyFKT9SBdUeB
         sWqw2QQfpJZNRiQeqgE3W19XQ5+VkngBsU8Djq9GzN57PFy2bdzDiYRK0ViQKy+SZex3
         PFP1atqBw8HEJZey33ztLzgZNnYsdOzZJu8QA8pVQPDXPgwOXBrZkDJ7ZO9O2I1CkM7N
         yJfAKbXgPGb8Cbspqj9YUcexh+9ue6XJjrn744B8yvwK6JIrysUeMGB/66qPKFnDJ9Wh
         5kGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795536805; x=1796141605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xFEgFJCLkhqDnHxeIYsSFOv/y/oat2ldu84bTi9SLd0=;
        b=fx+NljvCu8sItAsFrwgdMG4TczYISo0b39C1bKOod7f62zY2cRisdYI7qTWQjH+Cph
         XshYFAQ48iEQDKoPQIyhpSyWHgkOqL1/hU3XGKfeiMXp7G2+BQf5fY1z5P5K/2d3HNXu
         TTkf9iBQ4eMOdUVsz4uiUbq25WkVb+MNqBnjf97N0hV+a7BrIs1Lcz5D9ZYDzDAfLsIv
         gjmS4/4Aiks4Rt2yS0B+mDPI7iEUgnW+Cgyry/nPeAkgkcQKh/Qlyyqhh1dAh8DU72DO
         Pl4CP5ZJLKwIlJo4GS/x+7NSrzDw36S5D6jUWykm1RyKPj/pLuHGuActwTz0tbd5eetB
         6ZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795536805; x=1796141605;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xFEgFJCLkhqDnHxeIYsSFOv/y/oat2ldu84bTi9SLd0=;
        b=IoaasCv8gmr/6WcoRyn2wCdkP/G6TVyUGWAIRYXD45bEEhi8gmnCDFx2kHsK8OLGnM
         w7ecUmbAdEj51SyZYY+NT+nhO2mQGFTKcPFTOBGIBPXHaWxEISuwh5p5PQqNKzrPF1A3
         EzaWjnUI8KoElfH4gpePzFFTmPShBM0bRXN0DnNPHaQqkswsU79oJ6RvpWA+pU/nF04t
         iX4ahhwEuK2WWYs4vdls3PV4/ZEkZ/XcJ2z8M6zYdSjjJ867ei+DbX8iGyuRrWOLb5C9
         +hZGnJ8JM0WObY156dVNrZ+dGbpswZhjpf6OC7Yd3H6Z3M75uEPq+ceg3Uh7sNA8sx25
         B2Mg==
X-Forwarded-Encrypted: i=1; AL+hErHGpeoRiBrywdX+KAreUiRr8QENYjsvKoIMoVoy4TsbT/hgVq9lcWIZuZwHtV3kR8BCCag=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QxdnKzvV3vlHpvSuzKpdW1m7F7xPJza6jA428xv82A9uSg1+n
	9rDGB2EFzZI9B+pfXPelC13r4OSGicpYPn5porSq/VDgAzwOvMM65uPM1e0Pvfuh4VvNRkOs/J0
	a4ROax6pfA2sEMpuVh4eaNFbBScizM+M=
X-Gm-Gg: AZFdTZcHPGRtQxZbDx5fTd38bJ0zpXfpG139EwmhUtzuc0vtVW6BBDUUKwHHuB71F7P
	e1nOsgxYekne7qduCOXt0wsQy2i4PPRyYUlSRFCLVhbJD5NmZdc2l+LfnTmlihqfk16h2rw1V3p
	trW/WZvtR+C3oYR5yUXU9x9v7xBiD1RJwWPsupYaKzZ2uBYag9dE/gbQWI3G08tM9LXOeVYYeDe
	fZZVCtoLGPEhTTSgwWsGCz3weFSyO88chhZtlYwP7J/mElc6Jl+jlDiUCk9dgjcbZRFhwwVH10U
	+OknUrM5EHWImI3DLiVLQzaEzXHdQYMsT0mLeYEDa67u+MWCn561YyVDepQbWgISMWKMd6tpVC2
	sAUHwfWv6AErjA6AjDkQlRbDfXuEbQYcN55rKg1pw0lGsNPE7r5amuWIFfldt3CMYqErxcKWOjP
	8rGk9fgS8eZb4Kz+1i0E2iVulsoN9UsfeIbP3kjgb2mrbORR5FRx5K6BP9YrffXnQe8MNYUklQL
	4He8xSLfmDj7R6Cg1PJg6DVB+Cnuxs5uOaRA2ZRCugyXkQsRHsii7tli459
X-Received: by 2002:a05:690e:488a:b0:67c:2b34:31a5 with SMTP id
 956f58d0204a3-67df447a9cfmr2824201d50.56.1795536804850; Tue, 24 Nov 2026
 08:13:24 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <xmqq1p8zw49g.fsf@gitster.g> <20261105203344.48513-1-okhuomonajayi54@gmail.com>
 <20261105203344.48513-6-okhuomonajayi54@gmail.com> <avGP6txIm0tK377H@pks.im>
 <CAFpMFfBA-O+BqXzCo3sG28hh63G-N4HpSr0zv7tfUhBAN_57+w@mail.gmail.com> <CAP8UFD0b612_d6SEVerqs0GzSTOQzx9RaSvVDxAYORMKRWbQrw@mail.gmail.com>
In-Reply-To: <CAP8UFD0b612_d6SEVerqs0GzSTOQzx9RaSvVDxAYORMKRWbQrw@mail.gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Tue, 24 Nov 2026 17:13:13 +0100
X-Gm-Features: Aa3M54pnQHKBm4sL_W11A4fCzeSt3MrkAMeIt8eFQXq73jP3jFjaJxNaDEWD3sY
Message-ID: <CAFpMFfBjjEEabuZ7F=PSKG9E+xw5T8nLLy9=b5gCHhB0M1eCRg@mail.gmail.com>
Subject: Re: [Outreachy PATCH 5/6] notes: pass the repository to the
 combine_notes callbacks
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, usmanakinyemi202@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com, gitster@pobox.com, 
	karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 4:28 PM Christian Couder
<christian.couder@gmail.com> wrote:
> I think it might be more coherent and easier to move forward if this
> series was limited to its first 5 patches and if the cover letter said
> right away that it's only a preparatory series. [...] The cover letter
> could also list what is left to do in "notes.c", "notes-utils.[c,h]"
> and "notes-merge.[c,h]" and why, and then say that it can be addressed
> by future series.

That makes sense, thanks. I'll send a v2 limited to the first 5 patches
and say in the cover letter that it's a preparatory series: it does the
bulk of the work in notes.[c,h] and its callers but intentionally
doesn't finish the subsystem.

I'll also list in the cover letter what's left to do in notes.c,
notes-utils.[c,h] and notes-merge.[c,h], including the hash-size helpers
still on the global that are reached through create_notes_commit() ->
write_notes_tree(), and note that it can be handled by future series.

Thanks again for the detailed review.

Okhuomon

On Tue, Nov 24, 2026 at 4:28=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Mon, Nov 9, 2026 at 11:12=E2=80=AFAM Okhuomon Ajayi
> <okhuomonajayi54@gmail.com> wrote:
> >
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > Hmm. I was hoping that at the end of this series we'd also get rid of
> > > `USE_THE_REPOSITORY_VARIABLE` in "notes.c". Any reason why you decide=
d
> > > to not go all the way?
> >
> > I limited the series to code that already has a notes tree. The
> > rest needs more than that, the display notes code keeps its state
> > in globals, and log, format-patch, diff-tree and format-rev are
> > given a repository but do not pass it on. format_note() falls
> > back to the global default_notes_tree, where I wasn't sure which
> > direction to take, and expand_loose_notes_ref() only takes a
> > strbuf. The hash-size helpers are simpler, I just left them on
> > the global.
>
> I understand that this series was started after discussing a previous
> patch focused on "notes-utils.[c,h]", but it's a bit strange that the
> changes it makes in "notes.c" are limited in some ways, while
> USE_THE_REPOSITORY_VARIABLE is removed from "notes-utils.[c,h]" in
> patch 6/6.
>
> For example, the hash-size helpers you left on the global are reached
> from code in "notes-utils.c", like create_notes_commit() through
> write_notes_tree().
>
> I think it might be more coherent and easier to move forward if this
> series was limited to its first 5 patches and if the cover letter said
> right away that it's only a preparatory series. It does a big part of
> the work in "notes.[c,h]" and its callers (and does it quite well),
> but it doesn't go all the way in the notes subsystem. The cover letter
> could also list what is left to do in "notes.c", "notes-utils.[c,h]"
> and "notes-merge.[c,h]" and why, and then say that it can be addressed
> by future series.
>
> So I would encourage you to send a v2 taking into account the changes
> suggested by the reviewers but limited to the first 5 patches.
>
> Thanks.
