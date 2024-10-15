Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763ED166F1B
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 05:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728969073; cv=none; b=IfPBQ5q9RDygtnA4SkoMXu6vn5h0tuNI4TrYQpNzjKq5FTPlxufljJa4Z20H/Vn0rBmjLps7vMGraOciu9lqLyjHng3gH9GJjIoPbAgG4c/dg+Yre+JTXBBiVr9QJlfkCvEvukS8ju6nneCZlDYMLlIHcI0skHBN1RAEjB+PqBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728969073; c=relaxed/simple;
	bh=ulzEcJKMWb27lNTGhK+4uesmPzsQhGGAhbiy3aAZMoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEyL3zZ5eqCnDq5kC0PC3GSIpSDEX1ofM965+6/+ocg/XY5OoGoaRHa7b0I7Y3L4dowVrCntNg00KYUFPYjpFXm0opV+WgkNsai/2dmlc3FckAVvEZdjhjvvAT9V8ihL6sHRSjpCbNbtd16mwso8U7RZZEuTCYBKbXZu0u5C1Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbf113dc8dso6845716d6.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 22:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728969070; x=1729573870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulzEcJKMWb27lNTGhK+4uesmPzsQhGGAhbiy3aAZMoo=;
        b=QfWvODJG2pdesO8pyw1z/Xqt0jF276XFS3hrxWlYVTl92FrVEOg1S1nYBL/kzjr9do
         welIe/AnwsRi1AL6SOzLZWsk70k266KhUfn+U5SKgRilmdIWzUja71dM4/TjMWR2ElCG
         iQrvxsx9NF48cDpzQMuhNC+j3TRjbOTsCT85NL1zLXELK5WXgzciQnYJ98IM30idV4R5
         M0k5YajruAoq94MGwupSGtkRD00U9zaU8Oj9akMxDrOM4SZwCb/eQd7PWVRTeBFYX05T
         wN5b4FzYOkFbEgQbT3I0VK2BFo+MXCb9KnodwFBzUXPo+R28hwXhgFOlDBFyUkRfsPsh
         zE5w==
X-Forwarded-Encrypted: i=1; AJvYcCWHEkSlUgZDmQHfN5XLSj2TVBIWnFMQBAEj8BVU+RTMXvL3vdqjc0Bbzz6eu2Sub+eZ5NY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw07ovmjumyufrUKdaibToFokYLbxBcRekpFcEWmLAem6wjflv3
	9OrFANU5PXc3OIxKILijv0sjS8ign3+bKPzbBJN1RzeStWXtk7Y534m7VXbPO3sin19FCKBMI2t
	uxf1sfRA4j9+FI+icBTAu1X/p6rQ=
X-Google-Smtp-Source: AGHT+IGWbfi0bxAP7qNcEDpSOf1VNZJO0i+vwONRlN8gHC2QetVsQ+smZUn6gqDVG0tqQQxrZsr9wv2OFvOgE/l6FLI=
X-Received: by 2002:a05:6214:400a:b0:6cb:31b8:43d4 with SMTP id
 6a1803df08f44-6cbefe29d06mr91461096d6.0.1728969070281; Mon, 14 Oct 2024
 22:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728629612.git.ps@pks.im> <cover.1728910726.git.ps@pks.im>
 <0ddc8c0c896a006e4cc094390125efcec0b3cdff.1728910727.git.ps@pks.im>
 <Zw2cjxpDf6MowCP+@nand.local> <Zw3xhwLFlznU_JvK@pks.im>
In-Reply-To: <Zw3xhwLFlznU_JvK@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 15 Oct 2024 01:10:59 -0400
Message-ID: <CAPig+cSXJaETg4Sq3Zw8=37M15CdLEUkdMb2U2X4NPSOAFwmyw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] reftable/basics: provide new `reftable_buf` interface
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, 
	Edward Thomson <ethomson@edwardthomson.com>, karthik nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 12:38=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> On Mon, Oct 14, 2024 at 06:34:55PM -0400, Taylor Blau wrote:
> > On Mon, Oct 14, 2024 at 03:02:24PM +0200, Patrick Steinhardt wrote:
> > > +/*
> > > + * Add the given bytes to the buffer. Returns 0 on success,
> > > + * REFTABLE_OUT_OF_MEMORY_ERROR on allocation failure.
> > > + */
> > > +int reftable_buf_add(struct reftable_buf *buf, const void *data, siz=
e_t len);
> >
> > Is there a reason that data is a void-pointer here and not a const char
> > *?
>
> Only that it emulates `strbuf_add()`, which also uses a void pointer.

The reason for that is because strbuf is a generic byte-array which
may contain embedded NULs, and the `const void *` plus `len`
emphasizes this property, whereas `const char *` would imply a
C-string with no embedded NULs.

(strbuf also happens to ensure that the contained byte-array ends with
NUL so that the .buf member can be used safely with any function
accepting a C-string, but that is a convenience for the common case
when it does not contain embedded NULs, not a promise that there won't
be embedded NULs, hence `const void *` rather than `cont char *`.)
