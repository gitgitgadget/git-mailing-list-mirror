Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366315437D4
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872123; cv=pass; b=r6BhDMWX5cFbmN/HkNOLeo3dSza9G4yIi3Qre+W5IFvVYyLHcfXr32+zv0Vat8OzlWxDYlHZaloWOR3F2dKQyAIz/9njZrSOqHQNGXI/alGCR5Ryz4Mofj+/9+VEcOcWrLw3knn1dfk0FOu7I2gwAkPmrN2HV1lY/pn2Ap7yaG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872123; c=relaxed/simple;
	bh=rNaNMeGa+X5MZ2n8Wu650+LASOPLst3TSDgTjWD7JH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+WhnN1B2k26E0My/AmHvKoTneMsUsRnzU4m6BcX5PSvRSIASY4HIJYww3VgsH0n3qRVptnXlTcXNc3Q0L9TIfBXZXytwiFvavrV1j3OshOY56t0zdCAqw1s/8RAO3Hitq0E3VfGlOaO4TgtPkm1evcj3CMYD+N2j7QsxRKdO/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbZJIHoY; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbZJIHoY"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b4ab4b4179so4070728e87.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 05:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788872119; cv=none;
        d=google.com; s=arc-20260327;
        b=TW74odE7c/sH3+K+cwkx9ly7m0e8gyfVXFZ8flw0iP8Ot9d2o/HTPuEais84gRdiY7
         soSdr/zd81F5Rn84NIKSPh3F3LXvEzDALcYV6d7xaH+IBj3MpK3anpHfkpAid9G3mlFd
         Dwxlw2xXZ9OrbOMHfMdnlp/ab9gGwLMz585QNvR4zXRvWmO6XvAXJOlvT/arAs9B4ibf
         rnunGiHXwSBsO3O7RtEcGS4AY5L7s4ws16I6UHvp5f2ZzQ741nMHGok2858GlQ2Kl1uS
         yoAC88LXBiQjoLWRMkspzJDu03gUHFWX1DSPz9u8ExTHT0GSm+J2IvlsmEDOo4+MbZ+r
         J2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SVkp2eXr9W7SCjomMY953QCdTjSZwDnoOtMbDiOsf7Q=;
        fh=diyFg91FudXXNK3GPBRs9n1fxKsSscfcDeyFJxhgvj4=;
        b=hVvdOD8eI2SCZxybtVABm4v/VfNL+AcM6U92Iux6SU9kjnx4MGNB45IHM2J5nXjfGg
         Obo7kl9I3jInNbUpU7yDjYWw6maeOH82PayabRaAfiPkkSjTJcVmi+QNbJ77E1muL3n2
         WhGc1aAdF1C5wmhyvFelCtPodoobilAFkLl2JpdhCkhlWfU6VaIJVPya//xZfoMXQ8wE
         n2kPGqNKpa0NlgHwXFcoaA4juDJUh81Ncn91IiWbYesN7UjxJnEPiBju/JkhBSPmE5md
         R/O7F0OFr+VSwbZTFGd1vPKPSyFxS2PeNbFIN/Us1PXzkj0oLQX8+DskII2r5Uw8dAA2
         ni2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788872119; x=1789476919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SVkp2eXr9W7SCjomMY953QCdTjSZwDnoOtMbDiOsf7Q=;
        b=WbZJIHoYIvFEU3XeTcE7YWNGUDV5P3cnFZZ0xM/fw92Yoh9XcBC9F2xBbVUxoMQLCA
         ZtDYNKoiwmJT2VdzmLhRPgSGHQtOe7RHTq0ayAFmZZWSVPJQH1/0OkK5BNc59kgXxywj
         ZTsjg5yipppY4Z/ercypAIFE8s72HouAXwBzFerqfvPoNGwpsk06Qc8NxrdYVEyOTBV3
         xKlWQkOcyEX+X6w38uCjFQexmJnIJSuhbOMsewnMMbn8YlNjwgK7JL9fZpvvVpzv8a62
         mWzHWNMrT21spMPBqki99xyBnnkz1HXtkI/BgXboyW1e57ykVKTPMyp1IP3ky/sqMkJI
         gWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788872119; x=1789476919;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SVkp2eXr9W7SCjomMY953QCdTjSZwDnoOtMbDiOsf7Q=;
        b=ZYytd2Yz1BXYHLBrYRdpbcCb90TCrertMnuy81Hs/H9QEOK5IvcVaXEstjksMvAQkR
         UXAn8ONt6YvFBWXYA91GtSWuRHMpIOuQl+2q/Se6kkcm7MEpjAHgmP9FlGOLmS6ewDNc
         ASP/kJCzyolGX3AipdGi7hAlsjZYtVdPqNf9Te2mdCK5nJlYcrxCqLhWVM5gifisvIat
         eMZt0sseAu6qCOP+We6JUMR1hCqRU+YwQCNZDbiYAYO7kbta6hRQ5K3fpyDjPGJe2bYj
         08XR1lp1UpVdJE4e3VnWnpVOC5vzcT080ehpaARLpoA0RLE/H/zlMbObEJbVxUxwam4+
         FUmA==
X-Forwarded-Encrypted: i=1; AKwUvBzXaKC2CaDc+EdE4men638PuDtgvelko8C0KH5Hb3C+Lv9a4xJIkhJPMaapU8DTtINjwDI=@vger.kernel.org
X-Gm-Message-State: AFuF++ntw5iCyPE/S+AjqXDDjkEHHaSJM2khfuurFqx2PxS7wXeJTCft
	zhwYV+MeeTpYhmbydFAxGfhDbOxiqqbQfHTPmfu6WVt0IYcB49lmJrNFe3prHOfsN7/5J2CMt4W
	jkY9YC5KAeqQmq3nhPArw7be8ONplOlHeLiAH
X-Gm-Gg: AYBFou2QlQcO3QH/psTmHoW4DzD2JIf124mOr73MBjMPZrNCsgkL6cE9GKIkf9NtMJ6
	baEAhQKaNST/pInYp42rR4uEmLHSrLJxlKXpVqkhhXGuj+/d/RiL/TIaYupnXJem5WKx6QOMDyT
	GCoKo2eGZp1AcROeFaOG1az2+0c+mlZRlrWIdtIc3/V35DkPHT7QWe0A/fa9PWjLGVVJ/Hbr/7R
	9c9aB/08EYQadbFG1/5a8aWbXoalZIjJTytoeUEJJtP9V/cv6o977uwRc0QnBqLC/7HpSHR405y
	9GA3XReT3ITvNbSJQM171TR0KyhXwjN+WrSTejFhL3ZLlsbeHP8GOl43nEMOcRN18ZVN9l4L1dE
	u1Ps=
X-Received: by 2002:a05:6512:3a8d:b0:5b6:7fa:e96b with SMTP id
 2adb3069b0e04-5b616f075bdmr9923749e87.14.1788872118629; Tue, 08 Sep 2026
 05:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqmruqt36l.fsf@gitster.g> <20260818214858.65122-1-ggordon@gitlab.com>
 <xmqqpkz4czhu.fsf@gitster.g> <CALgUfNjd_y-e-zTKJ31o8_bQuRw8wFWe=sdsf2KJ7LOmmO21aQ@mail.gmail.com>
 <xmqqld9q40ww.fsf@gitster.g> <apUlqvXgChMeCUkp@pks.im> <xmqqik4qz86h.fsf@gitster.g>
 <apWOuGbOErZt9jo8@pks.im> <xmqqecfez7ie.fsf@gitster.g>
In-Reply-To: <xmqqecfez7ie.fsf@gitster.g>
From: Grayson Gordon <graysongordon1@gmail.com>
Date: Tue, 8 Sep 2026 08:55:06 -0400
X-Gm-Features: AcwNN1WE8bkRsLrGq1tD05jNU4SEVtFMbo4GB2-yp2ILmiSyug-ktNp8Uj3V6Ec
Message-ID: <CALgUfNgMzn=enM_vYkn=X9swkZwHovwf00YTXbc0EVN0u6u=HA@mail.gmail.com>
Subject: Re: [PATCH v6] http: add http.sslVerifyStatus to check stapled OCSP responses
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, peff@peff.net, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello all,

Sorry I've been away awhile. I'll put together the combined patch and
shoot it over.

- Grayson

On Mon, Aug 31, 2026 at 10:31=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > On Mon, Aug 31, 2026 at 07:16:54AM -0700, Junio C Hamano wrote:
> >> Patrick Steinhardt <ps@pks.im> writes:
> >>
> >> >> They do look involved but seem to cover the situations we do care
> >> >> about, except we seem not to test when the server does not explicit=
ly
> >> >> say "this is still good", or am I not reading the tests correctly?
> >> >
> >> > Isn't the following test covering that scenario? Or am I misreading?
> >> >
> >> >     test_expect_success SSL_VERIFYSTATUS 'fetch succeeds with staple=
d "good" OCSP response'
> >> >            with_ssl_verification git -c http.sslVerifyStatus=3Dtrue =
\
> >> >                    ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
> >> >            test_line_count -gt 0 actual
> >> >     '
> >>
> >> Probably I misstated.  What I meant was a reaction to "fail close"
> >> floated earlier.  A server does not explicitly give stapled good,
> >> and the client says "this is not known-good" and not talking to it.
> >> I.e. 'fetch fails without stapled "good"'
> >
> > Ah, I think you're correct, my tests didn't include that. But Grayson's
> > already did as it doesn't require any setup, so that's why I didn't
> > include it specifically.
>
> Ah, I missed that.  So a combined patch taking the best parts from
> both sides is what we want.  Thanks for helping move the topic
> forward.
