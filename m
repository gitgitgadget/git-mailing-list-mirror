Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241293C08A
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964292; cv=none; b=MmlhoCoGFOmGUvCLGPQ2hpaijhhRK+MGJF3deqNOnCJJ51lCeZh922c2uqkDYJSEZUje6w26HTDK7ROxOeAAXzTMzMikG4lYdS8yGLWvtljqlPS7epmnv6E+k4YRODFn1L2/ZeWw98TTA5kJZ3F5buFspdeVbZ3nNWCtANi3qeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964292; c=relaxed/simple;
	bh=JRtcQdw5R951Lya14oV+iBm0UjNl7tqdCxAlyqOSO44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6gb+Rn1vW6ZU4DxL0kg6bUV8RV+/U1iNgUnOnveYPRZ+dKDoP0Fur0OX5IOtmNvSJr9+zWo25U95mLF8yJdxOpVJTgaYRbIZAl7A2myxjv/P3LZwb2xqSqkNzyG8YHpik/iAkQjD/gOzqJsVIIHJz1hmUD8p2KDMidFiyN/xwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b78c980981so4751626d6.2
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 10:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722964289; x=1723569089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agO4yqC/gXeIv4fYD/0jsP3I1/wS4LVb8qaE1cSL8oQ=;
        b=oD7M9jjVqfIB2RLzO1HJsHmpk96LZmVqG6N4aF7VJe1/DqaDznMcu7j4aqE/VcQayZ
         tbfVX//4y96zyK/kDYXHijt2nC+v6Lcrp0jSeIS+TYryC8D5DV+RIBWf+bsq0YI8jrFM
         ZNtbDSW46yFAL9YoCM6BF8jw+6wNUieEnQw7CfH9Y7l+79YDzurjhTWmDQtoaG40xrKR
         osYLtuBpy/4MXSpbIADw/lKjVDphoKAgnw+NUAhwd93SQ/kwVQ/tlm8hBmsg1Djsog38
         ZHvZIBtf7T30QIGF9ONrCkbUd4TBg19I7PkA77spr/xyRIzYz0voaafIG7aSkUyiOo6o
         4zBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcwV4ALBPaZKwYbyKAJq3B2FLa3jWHW3X9Eu0o9Os5uSPIGxDEy1DcxK2xCDhlxeV4VzdPR/zXQylZTbD3h/b5FtlI
X-Gm-Message-State: AOJu0Yw7JXgTrhU5E4jGo10H6Tfow4VHrlEmX2qJoAV+UrPlIX7s9T0I
	ji+vFSmshjQIvh/aopqymzEhIlzwkSW/NHFsWDsUsx6QvoMrb03GAVzTGfYwayHBKeSeAwpZnxr
	WQbJrWhShC62o+ujf7zw1oRzzc10=
X-Google-Smtp-Source: AGHT+IEj8sdpUssep1g1EfCzya27Q8bPSUOVn9ru3jDZGrmS8c6CksD7rGdBysZeZPAcT8a7qRPixJV83XJUaj/0KlY=
X-Received: by 2002:a05:6214:5d04:b0:6b5:e3ee:f804 with SMTP id
 6a1803df08f44-6bb9839e496mr203501926d6.16.1722964289040; Tue, 06 Aug 2024
 10:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805235917.190699-1-abdobngad@gmail.com> <20240805235917.190699-9-abdobngad@gmail.com>
 <CAPig+cSzq+6bua=T7w0M-+7+2zbzfD6ihXLkWfondZ8NbqUG4A@mail.gmail.com> <xmqqo765vcbu.fsf@gitster.g>
In-Reply-To: <xmqqo765vcbu.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 6 Aug 2024 13:11:17 -0400
Message-ID: <CAPig+cSrwb42EphyaDbV_bt=GjxTfq4rYzGf7DA86Z1=2Nqycw@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] [Newcomer] t7004: Use single quotes instead of
 double quotes
To: Junio C Hamano <gitster@pobox.com>
Cc: AbdAlRahman Gad <abdobngad@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 12:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > As a practical example, consider a test with a body like this:
> >
> >     echo nothing >nothing &&
> >     git add nothing &&
> >     git commit -m nothing &&
> >     hash=3D$(git rev-parse HEAD) &&
> >     ...
> >
> > If this body is inside a double-quoted string, then `$(git rev-parse
> > HEAD)` will be evaluated and its value assigned to `hash` _before_
> > test_expect_success() is called,
>
> I know it is just your finger slipping, but the variable "hash" is
> not assigned to before test_expect_success is called even with the
> body inside dq.

Ugh, you're quite correct, of course. The "and its value assigned to
`hash`" part was one of those last-moment-edits which come back to
haunt the author. That's not so much a finger slip as an outright
bungle. Thanks for catching and correcting this.

> What happens is that the value of HEAD is expanded in the string
> that will be evaled by test_expect_success so the 4th line in the
> above becomes "hash=3D3469a23659d8197190d2765cf9f31dec5ab602fa &&";
> as the resulting string is then eval'ed by test_expect_success,
> the end result is as you descirbed, i.e., ...
> ... $hash does not get the name of the commit object resulting from
> the "git commit" command before it.

Including an actual example of the resulting string, as you did here,
does a much better job of illustrating the issue than my bungled
last-moment-edit.
