Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA34EAC6
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295843; cv=none; b=sOar/GJaoH9uQQQ6E+NO0vnK71cO2pyaMhBmR6kZFi5YTLBS1xCPTufWzEpNcS4qOEuBuRpsYz/Dm+0+GMErkU+c0S13YsGoT3x21hUrdHWRXUvriXjKxchJ7kMQwAZgwtfBDWa4swjvtnpU6va/eOgbvnfvxpMhCrpYTBzgbKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295843; c=relaxed/simple;
	bh=YPLcxVTAXv4QW79SZRLm64otoFBA3YsbPJWvCP3ZWSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVCGZ5acMThambO+bv4kmzO3f47dfrqs6WaAVzNiiyeZwmKhzRaOHr60gb+xWNp4eNEQ89V4UlqlEbqs8V1bbH0OlE1HXQsY/fU1U7BCTK/PA/+0VwoDZW/5YV+ABzdSBr+odCRUnGGJTLdZHwqrxW1ffeZYq1Jxa/CYOWsb7wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4t8p8AF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4t8p8AF"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac25313ea37so1083343866b.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742295840; x=1742900640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qusvidBYR0uB1hccuwbX1wIyCIoI0ov3zmt8HQtK9g=;
        b=C4t8p8AFsLbplWGjdcH74AY6MwfLe4hBQtWON/HoVOU6KXMGzEPnq/a4kO/K/mcnJH
         IWGsOQRagnkPPK19aJ34YKW3iDEZxFpa7JcLX2mZNSoJ1GHJA5xpsiIx9CnKGA9oY26P
         VFOtLIuS66DRMPn3X7gEDFLhyPIJJ8nXHYF3M6PA5jrq7fk32NgwQTMFmYQou8smvcys
         CRgXiPnTjhpTBgGRyNOdm6clVs/Ql3T1RNTsBr9uvSS/QLu2UGtVKOT868Tp/dy8WGsE
         JUPi20sRuHktlxo+hg9K/RdVf1kw+gxzD46pJp5whzCuoFT3kyLR3n0KD++Gr27fLbCO
         4X9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742295840; x=1742900640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qusvidBYR0uB1hccuwbX1wIyCIoI0ov3zmt8HQtK9g=;
        b=rJ3GtOemB4sH+KuQX2tvsKO04jFl87iQjTqQ/y+QdCa1ncko4hmVHhS+RzuGmpD1Ss
         +SMDtf9fMeoxZZP01zUhltmBfEEU4kHu4nXyU8VwYRWK8sGRX6qLQtGLA34xlTiy0SAj
         lbwKmB9hKHV9y28klZUPTveqstARza7to2xxSphBBEbd2XMXUrRluBEYDR7GtiX2BxTd
         ldsEQuE2qL7oCaxyxwN7Arz6XSqog7ncz2rqGkZYIiBaAMHJC5VaBQMVloSIAN6o1uCY
         YHK+pui76n1VNhPbZ3PKu+pJ5OWcxBkuMERHso1CLmgGeqAgCz/nMt9e6Ga6Y0FTKKvk
         hGBQ==
X-Gm-Message-State: AOJu0YynCL+WWNgcu4w1Yrgit2o3uNmWCZa8itK6CCr6ANOU+sFxp4E8
	3QGWSzP73puuUVgt+9Xwx6iaEFTV4gril51Xc/ht+cLgZwUsbV3HDCRNy9dNfxwYiGPeH9GCrNz
	+/Fsk8l6anc/IHhKchSpULIjSnR4=
X-Gm-Gg: ASbGncuIZFvfBnipH2oUcnAfy2vrxnukP8ptNACB1ZnKa2CGuWiEtLKrLn02/rVuuh6
	4VMxTnuRP11cgAtN6qoXmJd2RCulLV/BvnAigrbwyNPhlw+3p1Q+lxdZ9/C+o/5CTqCpORu2Ar0
	/dlDDvnv5lrEmtlW+7WS90849+XTEbjJ5Fc7otitjALTMxelZJEAvHzV6CkUNF
X-Google-Smtp-Source: AGHT+IFHIggDQKVaa7Az24Pn8qqPNsHmI55jp3zcex5L4H5rKxrSF1lfIZXbYwJgc/2ZrE4AahVIvzq/S3c40meXdkM=
X-Received: by 2002:a17:907:60d5:b0:ac1:df33:25b9 with SMTP id
 a640c23a62f3a-ac3303ab8f3mr1827885266b.40.1742295839644; Tue, 18 Mar 2025
 04:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313103859.817127-1-christian.couder@gmail.com>
 <20250314141203.2548803-1-christian.couder@gmail.com> <20250314141203.2548803-2-christian.couder@gmail.com>
 <xmqqecyzfnfr.fsf@gitster.g>
In-Reply-To: <xmqqecyzfnfr.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 18 Mar 2025 12:03:46 +0100
X-Gm-Features: AQ5f1JoCnUuU88RT9TUarlr3WMDO7DSJ7lbEMkOfAcB0Zf0X7KBOpABeI7QuWUE
Message-ID: <CAP8UFD0XhqF79HHBOdseSgdQdy5y_LNLB3yhayNnwA+Bk6GyHQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] promisor-remote: fix segfault when remote URL is missing
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Karthik Nayak <karthik.188@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	"Randall S . Becker" <rsbecker@nexbridge.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 7:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> > +test_expect_success "clone with 'KnownName' and missing URL in the con=
fig" '
> > +     git -C server config promisor.advertise true &&
> > +
> > +     # Clone from server to create a client
> > +     # Lazy fetching by the client from the LOP will fail because of t=
he
> > +     # missing URL in the client config, so the server will have to la=
zy
> > +     # fetch from the LOP.
> > +     GIT_NO_LAZY_FETCH=3D0 git clone -c remote.lop.promisor=3Dtrue \
> > +             -c promisor.acceptfromserver=3DKnownName \
> > +             --no-local --filter=3D"blob:limit=3D5k" server client &&
> > +     test_when_finished "rm -rf client" &&
>
> These are the other way around.  When 'clone' fails, test_when_finished
> is not run, so nobody arranges the new directory 'client' to be removed.
> "git clone" does try to remove in such a case, but we are protecting
> against a failing "clone", so swapping them around, i.e. arrange to
> remove it and then try to create it, would make more sense.

Yeah, right. I made this change in the next version.

I also think it would make more sense for all the tests in this test
script to arrange to remove it before cloning in case the clone fails
in weird ways. So I am adding a preparatory patch to do that in the
next version then.

> > +test_expect_success "clone with 'KnownUrl' and url not configured on t=
he server" '
> > +     git -C server config promisor.advertise true &&
> > +
> > +     git -C server config unset remote.lop.url &&
> > +     test_when_finished "git -C server config set remote.lop.url \"fil=
e://$(pwd)/lop\"" &&
>
> Probably the same principle applies here, but the case where "git
> config" fails, it is likely that the file is not touched at all, or
> it gets so corrupt beyond salvaging with another "config set", so it
> matters much less than the previous one.

I agree it would be a bit better, so, in the next version, I moved the
"test_when_finished ..." line above the other one. I did that for the
"clone with 'KnownUrl' and empty url, so not advertised" test below
too.

While at it, I think it's also a bit better to add `test_when_finished
"rm -rf client"` to these 2 tests, to protect the following test in
case the clone actually succeeds. So I have added that in the next
version.

Thanks.
