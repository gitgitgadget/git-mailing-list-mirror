Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6277B2DC35D
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581353; cv=none; b=hGXkNRYHFgyLLSWeOLPHEjI13KL7an3bjh+zfzLTC7cieP5oAaQCV8lAvxCBZbE/vz+8afTf6xHS/2SaH3KS5G0vynraD/yNZtUCiLEj1TQFsTBdM/VnXF9oGIxofGPPr1kfSKHaP7rlPtt8mZRZ/PeC3+EL+0vbSSbgg5rTNjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581353; c=relaxed/simple;
	bh=QFn0v0wF6qqesiHTfTNm3qkpO/PJwlMBHEeyjEPxsJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvV3xd7VWnimMKTS68S13sKTGlxuf4XiBGJWO9/lM3wM87y0mReATQg28eXs/tNSps+x4OCLm2KSzstJgqJaOzG2HgSYyF3uLFTqJJc+HaXp3PPfPg6JX33uHMAQQ1woZ4pnXIjkbumwL6X+/t0GkfRAfPA3XXTkj4pjk7kiXEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/rQA620; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/rQA620"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45629702e52so2390805e9.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 05:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752581349; x=1753186149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNRflczCvtCI7oaHj6+d9U1HGy+MPfdMsvfsym2AHd0=;
        b=O/rQA620nrDVQjqrQTNOgB6e0cIzb+lzJXZOkv7y1ehr4NdVHTxDavrSuKzHgXlQGQ
         K0Sz24n5xrGapaHkcB8dId0XTGAN6voTf+/c31R1ZkhZMsAqOLfRyYEaVKxBW3EW0Q0O
         bmNjwLRUX+ZKi/mBjLzqWOcU18NHvWTzalMSZXyd90GJuVrKQoii+5rm9QZAjE3i3fg6
         V7Pw6iIzh6vDLAxBp0BV00K56mMv0ZxhB7UMz8chKgrKi5UXoNNvze0VztC6EVCcCCo7
         4Pt/69IpHN1aGCjh9qB9HxJsgKs8WcYI50dN6EKRdplXLYG+kQXF1iQX1Hx46XDpv4AW
         FzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752581349; x=1753186149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNRflczCvtCI7oaHj6+d9U1HGy+MPfdMsvfsym2AHd0=;
        b=QsfBd6kwVo17A35UGDFDR7Hk4EMS260notfOdmS+OYnb6ben8Pzm5ZzIS8Lq8dJg3E
         wv49rUCIqheYL2m+dcIvYt1+wZgOGM7ZkdIBJfQK5Y/tAfxV5bi18p4U3FkHiMA5XXO1
         gAtilnnvHns5U7KBR0OHYUjtW+4igYEX9WBGlxLdqWd3eJV5fuC+Aa5C3Ng9K16SF0uJ
         ArCYMNOlKIRxj5p4Nl59IZtt4zQ4CedDf2OabcFLMSRzrmLGyoOy8SsbfnpEWxb39SKk
         cgwF8BuC2zDdnILPwLk8j9x5Mvv7u4Z/qxRtC3jHaOkvk5hENbHC/WJg93YufWl04H42
         3/4w==
X-Forwarded-Encrypted: i=1; AJvYcCXP+HaLQ5UTTYs823WUTQaAulVic7P3xrHAuzfxH+kCZlecjX/nlwjc8QDpouXeNWVHAz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJN0i1pM5aJisfMU8POFq6+F6zUx85HuzacM7DdOW75QKSuoti
	62VBZMVUBn5onJncQ6WvFulxiKVrTN5PQjJ81oGCcubJw2VpY0xlMKCqlWhf0SNa85JHw2tELai
	ZFOE8HBQ9qMN2tn+a+qKRW1pGF2E1Xz8=
X-Gm-Gg: ASbGncufMHiSQF2gaqcflJOdvbTpGAjYWZJyOtF6PyF2/nRHzrjX5mmyFBoHeKWyC/p
	nK/bHsJf6fGcMoj8Fwa3lcs0ysHYlmkK9NgVp1DPVRNNcFCptSBIAikkU+0wLfaLac7IL4KkiVt
	sT4AC1JJxaJmRJ7pGsGXftBWb7ULj1IJ2Aj94RWiSEkmWU5xgVc+ziK+w+Yk2I1C/DUtc6YLoq0
	Pq00OftdCu2HBPwW7P2Q/72P9nnSIf9N9n+Uho=
X-Google-Smtp-Source: AGHT+IESfTqOAD1s4TJ9pTgNGGiP/hEm+Hy4hb0nXmpNhr+GbYWXRqMn19HY9f8pW9yTcMGd+xeZ+Wn5ewXoTC3zedg=
X-Received: by 2002:a5d:64ec:0:b0:3b4:6577:eed5 with SMTP id
 ffacd0b85a97d-3b5f2db1739mr13108226f8f.12.1752581349468; Tue, 15 Jul 2025
 05:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713122341.17976-1-carenas@gmail.com> <20250713174807.32444-1-carenas@gmail.com>
 <2414b962-e843-4ac0-814f-bb4bc7aacda7@gentoo.org> <aHYVdMii_rP5-ywa@pks.im>
 <CAPUEspi2VJ5OYTFvsdZSn9_+rqN=x_o=Uwchw1fJeipvDF3LSw@mail.gmail.com> <aHYuS0OgW_mPE34d@pks.im>
In-Reply-To: <aHYuS0OgW_mPE34d@pks.im>
From: Carlo Arenas <carenas@gmail.com>
Date: Tue, 15 Jul 2025 05:08:56 -0700
X-Gm-Features: Ac12FXwMVO9tDP0iUU9eDu1L59loOe_fam0_Atm6ScxrNeHFdRa3Nbd3AvOcSh8
Message-ID: <CAPUEsphA-XadsPU1mkdTQM7qjMKtZP8gJXWwZ8WmFutj8WS_rg@mail.gmail.com>
Subject: Re: [PATCH v3] meson: disable PCRE2 dependency by default in macOS
To: Patrick Steinhardt <ps@pks.im>
Cc: Eli Schwartz <eschwartz@gentoo.org>, git@vger.kernel.org, gitster@pobox.com, 
	sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 3:32=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Jul 15, 2025 at 01:56:44AM -0700, Carlo Arenas wrote:
> > On Tue, Jul 15, 2025 at 1:46=E2=80=AFAM Patrick Steinhardt <ps@pks.im> =
wrote:
> > > On Mon, Jul 14, 2025 at 09:55:27PM -0400, Eli Schwartz wrote:
> > > > On 7/13/25 1:48 PM, Carlo Marcelo Arenas B
> > > > > diff --git a/meson_options.txt b/meson_options.txt
> > > > > index e7f768df24..f63ff32556 100644
> > > > > --- a/meson_options.txt
> > > > > +++ b/meson_options.txt
> > > > > @@ -45,7 +45,7 @@ option('gitweb', type: 'feature', value: 'auto'=
,
> > > > >    description: 'Build Git web interface. Requires Perl.')
> > > > >  option('iconv', type: 'feature', value: 'auto',
> > > > >    description: 'Support reencoding strings with different encodi=
ngs.')
> > > > > -option('pcre2', type: 'feature', value: 'enabled',
> > > > > +option('pcre2', type: 'feature', value: 'auto',
> > > >
> > > > This part is fine. We shouldn't default-fail if it isn't found, whe=
n we
> > > > can't expect it to be universally available.
> > >
> > > Agreed. I guess tha only reason why I picked "enabled" here is becaus=
e
> > > we also got a wrapper in "subprojects/". But with this new workaround=
 in
> > > place I agree that it is sensible to switch to "auto".
> >
> > AFAIK the "wrapper" fallback still kicks in when the feature is "auto"
>
> It does, yes. But with 'auto' as default it means that we're free to
> disable PCRE2 if we have detected a broken PCRE2 dependency.

My bad, I was mistaken and indeed auto doesn't fallback to the wrap, so
this will likely regress in windows if it is not invoked with `-Dpcre2=3Den=
abled`

Carlo
