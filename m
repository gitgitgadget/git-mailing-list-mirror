Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7774CB5B
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083202; cv=pass; b=ef9A/yFcBablioNFc0yBY6zYMNo/DjMhjyBqZUjzaOQz0s9XUpFzY9U6Ik2uMWlRHsX2eHo2g5V5tpOidHlXQe5VYZTn1D7deLauN64uXsSTucJ9y6frDEn0x6pF82Rx7I9R6gdlkIu5Gm14yGMr+wvSyxqFzBAW3s3AKMYRbv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083202; c=relaxed/simple;
	bh=202Udm+1ufHUVRzfEvzn2+qpPJ/D1sdRDlUfy1vtAGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAM+udTjFrxEpen/b0/4kqJb5dxwBk/E2f9vTBlrXVPo01jYonEYckCWje+KgOOU56XNvRLTqA6fDCW6u692BcYmfFXV9F27cyzyhj+Ss3Xh80OJZYEMqsubIYXsXYkjwmw0D+grhT4HbQDpdLclb/Vqj+FPpGAGt+DPZm7VHGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9z0Vd95; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9z0Vd95"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59dea72099eso6678098e87.0
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 12:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773083198; cv=none;
        d=google.com; s=arc-20240605;
        b=lj/kMxtqIJIynFYe/KPLw6IPLL+NuLmDLqNQKmRebt4C0bXYqdj5IcdgWH8Vv6lzvO
         s7g4PK/qYh4Zlw7dd8FcQEo3eWDNNJflbOXAvtyCYEf1NzCCetOLkJW2q9dfeGhhz9yB
         1bWLYAZoCjQvHRbisBWV2URo7EgQRQuzJNBDAtLnQWhiiVOfvqgTYVuqKt4KPVbu2880
         4wEOScepwUkXH3bCzDEFGpSbaBsGXRUCaP0f1sk9CFk+KPn0xK5K9U4OxSpLnKCBdpvK
         c0uUgW8MmbR8tHB2Ov9S4ZZ9/mIwZwV05SKWCt8ZRjfFdGJQIZMTgScCNeaQbpBwnhP0
         3kbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WDw7f5t4/nW6Zvg+03yG5eapB2hC0y8652oSdDf2fhU=;
        fh=/KbF3blna99f92j2uzmZ7Fv8LrZ1rK4qObUTyG8qel8=;
        b=CRotzYuui6+YRVm4nG25cv8yzJvHjE6DC7o2P720kvxKldpyX5ukcmejACj9B+TRKX
         O47ECNDdNMd4OtOdZxOsVq5onB95RFg0xOqlojxMrcojmAaJnCXmFiJjZpGRpTbufpC4
         w9Phod7T7hc3WTEDkClboW2UND96oYCzBTeOcD9QO6RjyH4GWWmyvjvpVk9f004nVqED
         9vmZop/ciUToZiNjjUvxs1avyHrx8sKmvRzQkYLY4MxQOr5MbG5SsrR/w+EUvg1EbdGP
         bOmIKEnSD4mRTGBJvCMAh9g6EHAepWUEFXJicyj3ixuZNSsbjkQsg1C9uXBJ1ybEIrKL
         lXKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773083198; x=1773687998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDw7f5t4/nW6Zvg+03yG5eapB2hC0y8652oSdDf2fhU=;
        b=D9z0Vd95qAiz1lBrMapp7xT1zGy+K79tj9b1wJFs4tSeg6HxmTMEtkRWDcDg/ZXnKR
         96k34RZjRN1C8NesYmDmsHN1MoecOcKi/7vlpAX4wriQ4x6Hgf2NuZYzNeERUq57JuXF
         ftM3Z00W8+py+8t1mujtTJcgBEuFA9Zv17L3iXxdZl+ZO4TIbJSJ8P5CK0Fh7mot6TYJ
         zLE7Z0EReT4/whjz/kJ6qzqLs/tHdUDd3x8LHKKz56s/JW5iwcXQcOWZx8y9eDXbToEJ
         qlmnYde7gBRFe98wMM4HqHctFRZ0fwFWpiZu3XDTWXfK9oawKcNPqe0t9z1zMolhGIoX
         qNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773083198; x=1773687998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WDw7f5t4/nW6Zvg+03yG5eapB2hC0y8652oSdDf2fhU=;
        b=LL9IehVEZPh59gP62dNWG4o5kI7UP10OlIfSOW/Drf1aOxUXYAlbqATZnrFHEbVGim
         YJ2rJhFvHCpgBxdXL2UtkvHfHrfMaHRo/YK35ItvI0PsrVow+DYTTLhmzEf/NpxXg5du
         SvMsCMWTkruOyAyUqfc3DkEZJ6Itxg605sn5hOOSH3IFJTs0C0lu1FFxwnqjPdLzd/qo
         mDyUrEzef71Zm9HDrEzSRdxm03ixXOv33u1sZq9Qb6+S4zYb12mDKajjZr/gfXoUf7ne
         cQRGms/Xbsg9qMHDHGE67CoIecj5vkMkKyYscc3VvhdIYoo3qcwKfQ4SsaUG6VFgjWla
         fTrw==
X-Forwarded-Encrypted: i=1; AJvYcCUJluFb1J4rQb21st4ibe1Jew3cofhkm8VpfGJ7rsKmzGr3xWElnRoyYYE/ZfcwyAJ8A5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXURkMU61reuq27eiCrdbAZDoSwRiG8j1UNUx0wpepmfP0TnWv
	opK4dpviFcdISuEjMUvkajhcnLLnVNPqQgaUSXwbFzceiG/RNSTArssNfN5w7qt2Y6YDAGBvfl+
	j80+z5Zfyt2jzQpfrXZKoNdi+CKHDmck9greT
X-Gm-Gg: ATEYQzxFp+xlX9j0s1j6wXO97M7qAPzGscgL75NOm0e8qoutpRHOjRNEBNDs8V/njrI
	Mv+/P0iQDFTpudKR3+YHuHNqm9PLcCd10qXw8Zk0Lcmz9h+MtsXxRKkYmiQ+tW9jSW9bTQICOBK
	ZgVL2leSP2YcBvXtkOFgwSLBcNeoc4919ZpBGpJw21xSTJhU9xrtYZSZSlXCOZijhcJ1RLHtSvB
	bYA8x0hYVHuYgOquh8/RJVY6i6D5TN8uryspjI24VXRzrktY43FK2Qo+6dEDoKmwFB3ftApDBVW
	980ibcU=
X-Received: by 2002:ac2:5584:0:b0:5a1:3134:923f with SMTP id
 2adb3069b0e04-5a13ccfba8cmr2875031e87.40.1773083198187; Mon, 09 Mar 2026
 12:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com> <xmqqy0k4wogg.fsf@gitster.g>
In-Reply-To: <xmqqy0k4wogg.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 9 Mar 2026 13:06:26 -0600
X-Gm-Features: AaiRm521s2oR82p7W7DYy1ISms-G8qJw12TeFzkMM7yYnBXsONOdhglZ_cneM6o
Message-ID: <CAH=ZcbBVSqUG89n65MBpN+HMCmmjzmADGaVnuEJn_cYN0SYknw@mail.gmail.com>
Subject: Re: [PATCH 00/10] Xdiff cleanup part 3
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 4:03=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Patch series summary:
> >
> >  * patch 1: Introduce the ivec type
> >  * patch 2: Create the function xdl_do_classic_diff()
> >  * patches 3-4: generic cleanup
> >  * patches 5-8: convert from dstart/dend (in xdfile_t) to
> >    delta_start/delta_end (in xdfenv_t)
> >  * patches 9-10: move xdl_cleanup_records(), and related, from xprepare=
.c to
> >    xdiffi.c
>
> Is this topic still viable?
>
> We had to stop merging this series to the integration branches as
> another topic <cover.1769424529.git.phillip.wood@dunelm.org.uk> with
> smaller footprint was making conflicting clean-up.  Since the other
> topic was merged at 5465d368 (Merge branch 'pw/xdiff-cleanups',
> 2026-02-20) a few weeks ago, we may want to resurrect this topic by
> rebasing on top of a more recent 'master' branch.
>
> Thanks.

I plan on rebasing on top of master with lots of changes. v2 will be
quite different from v1.
