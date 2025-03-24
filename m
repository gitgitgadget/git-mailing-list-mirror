Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6096241C85
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832488; cv=none; b=rR+rhLyiTgY1+L6PXWEy1sejZDfwV696RmQ7vEH3SMcRht+I6fuuOXxRV7kCSS+hCUbCBlGTnnhhBeNPAGBAh9N/OIRJexVZM+3Ow00aAxuNMN7mK5m60nOxbLb6bI9Y/5H6nTo3LI0RILmOW/eFopy8h1SFsof3GZLjJvTpcgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832488; c=relaxed/simple;
	bh=P3WGrEUh1vr1A34knmR8WkVk6Xfm7Mq5QJ+OKbkm8V0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbSrjTMtsc+mwes65WQj2bnuNZQvre9t+UROFk59otcO4IA0NOulYBJ4YBq8HdSgKOeYLYVFactBnEGt3SwHAWTL40cAs7uQ+qI/MveLepyxqsHmgBNt1uIhGbdpwynlqsh7qQpcI91adVFN7QBSsW+nS6A85guPNzLGYZ2OLFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e4231ae149so5984446d6.2
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 09:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742832485; x=1743437285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpsUXqRlSSMMT2tJflImpx4/hL0Qu2dP2LhDOfavyoM=;
        b=VKog9ytcnTX/lpczgvsrW5arxxtiUv+Nfd2GkatEkTDsvcBPREqhxkfO0yF6loPpBZ
         cxpLcZrblZCzSPMInuasD3jOSCYH6jueYfhKhoSXJtcTWhKQUvitsNpBZ9gZm0+WdZc7
         ZCD9R5QpzpIbCIy7A0jNnSenahzu7iNRA0bXhyHu8qOsGfiD5LZuFLoEK41jgJ9t56kw
         Tc22JujFM6xwC8i0ZwRSgz6x98cq4TbDbeH8JaxNg2wEfRdTUp/WkJAxI0xWeHoX3uNQ
         6nAwocMHqzj+Gl9F0OouARZ5qbPRE1MGIAsVIiKYxckMSAp+jMrh4+qM6hpuCKt7L5p3
         x3aQ==
X-Gm-Message-State: AOJu0YxzRx1kbjAyySl3B8iyBz1Wtxn5wfzhUfZbrKP9RfUnN4Q9wxOV
	M4Y2Rdhcfk0bGr/oUwQFszwiYOXRHs1ecicddIjPwH1ZtpYo9qwgbIhcKgHp0YRprL90fZC6wb/
	Ozc4r2nf+lINSv/Ea70cvk+tIJRrSqA==
X-Gm-Gg: ASbGncsw5Hm+gfZBdHDnkeGQ+Fy+2V7rLDiQ4eMXw292zqGDcm9rki3I3H/imXH4ewM
	8mQbjRMIbRdtmFnz6dHI90GKm6RIXzqb6hp4xuHnuLaTUVLtsmBtaQ+ip38/PkEBEc/68mldSVN
	KibLgr6nkKt46ZJyoLkp+RoWGoNYq0JsNWKj8=
X-Google-Smtp-Source: AGHT+IGwbeAj0NBwItZWR2FT21b2rXIKCUtBpa3Ca2Kw/12ExJrI5wk6gzNrOc+CDC31YUjJN+T6c0VKBHHZVijNng0=
X-Received: by 2002:ad4:5bab:0:b0:6e8:fd2b:1801 with SMTP id
 6a1803df08f44-6eb3f26fd23mr63375316d6.2.1742832484877; Mon, 24 Mar 2025
 09:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
 <20250320-b4-pks-t-perlless-v1-13-b1eefe27ac55@pks.im> <CAPig+cQdoZwY3u-xr49Jb8aaQmE69p4i4RUdy=cRv-V7VoWENg@mail.gmail.com>
 <Z-FUEhraLaDODbmO@pks.im>
In-Reply-To: <Z-FUEhraLaDODbmO@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 24 Mar 2025 12:07:52 -0400
X-Gm-Features: AQ5f1JqhoHnJNF-Izu8azCCs_1EnuTrhKGjlTpVFJQD0xV1PLZV-yAaWW_hJPAE
Message-ID: <CAPig+cSN5hU=XP1Gd8z=5XyvSEqJcTBiWhgyJxYNBPJWAi3yLw@mail.gmail.com>
Subject: Re: [PATCH 13/20] t: refactor tests depending on Perl for textconv scripts
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 8:46=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> On Thu, Mar 20, 2025 at 03:37:08PM -0400, Eric Sunshine wrote:
> > On Thu, Mar 20, 2025 at 5:37=E2=80=AFAM Patrick Steinhardt <ps@pks.im> =
wrote:
> > > -test_expect_success PERL_TEST_HELPERS 'rewrite diff respects textcon=
v' '
> > > +test_expect_success 'rewrite diff respects textconv' '
> > >         git diff -B >diff &&
> > > -       grep "dissimilarity index" diff &&
> > > -       grep "^-61" diff &&
> > > -       grep "^-0" diff
> > > +       test_grep "dissimilarity index" diff &&
> > > +       test_grep "^-3d 0a 00" diff &&
> > > +       test_grep "^+3d 0a 01" diff
> > >  '
> >
> > This change seems unrelated to the stated purpose (`textconv`) of this =
patch(?).
>
> Not quite. The test previously didn't run because it depends on the
> Perl-based textconv script. Now that this textconv script was adapted
> to use shell scripting instead it can run, but as explained in the
> commit message the output of the textconv script changed. We don't
> really care for the exact output at all, we only care that textconv did
> its thing. But we do have to adapt the test accordingly.

Okay, I see that now that I have read your response and examined the
change more closely. The unrelated `grep` to `test_grep` change
visually overwhelms the diff, so much so that I overlooked the other
smaller necessary changes. Perhaps it would make sense to mention the
unrelated change in the commit message but is not itself worth a
reroll.
