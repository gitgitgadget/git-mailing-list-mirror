Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7969237717
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743593290; cv=none; b=oBSgipnU4J60qixomVzWgCOCbfcHA+YgdH9WEzRA5dwkL4GcOEnJFvkPM9SdLJ07WgpRi/lc/dhAuQ/+p+HMlpFfcv1g+wnlfn3gSqG2v8+kZAp7gfYz8Z6GLqpCoFhnWxQCFlf3Bg/qyuvCL1tD2yxevkriMnoxZhRkobBD2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743593290; c=relaxed/simple;
	bh=GP54gVg7ol2J+lyMYVpklsODnJJQqo7Wn7uwWhCp+Us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bf0VK0GfJ4XDC5ZrPwmK0ISCpXUGIf8RHdQo/wfKFyP77YUKfHikM+5YBsdY8pSfJl5y5HgYa+M1DAUEvGLTQRUtkyXbZ4IDB5vrk4vpvlbX0cRQyB3SVmwdbl4KqEF6KX22MG6fz5CMUs/u3KKzK8iPvXkvx3fR6dfAmZ9UPWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPBVTz6U; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPBVTz6U"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e686d39ba2so7800148a12.2
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 04:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743593287; x=1744198087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhO8mH2JNvqgdHJjKC2juwLi5Xxzt2vxZ7uHBVIKC0w=;
        b=jPBVTz6UYvk5L/6fZL6nLL8axaxIPz7ucfQoELolWUdsVn4fCkfvbTahlTmta8YKW2
         KZYXMicNtVFHKd+ROnlYdNlBKd/w6B4iAaPBJ+94TK7TSTv+nNMQ4XOCceYn3gTDWS1p
         5Paif1I/+61IXDF1i8DF/MDF9XTaks+JZ99uPnCWvK6nTb1h7Voo+gym35Pz3j/18kfj
         Ls7fQMFinSJIxVGfAY8rZOIZALpT7rASc3vWNssvu8J49jXcHzJ70mHt3+EtM9dbzY7Y
         Hg6OFiD3C3msMGeTB2TWm+Kbwy2OOwqD0Uz2VHikiSE7dgVjzFFcd+xSJv/bFwV8IvXD
         iLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743593287; x=1744198087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhO8mH2JNvqgdHJjKC2juwLi5Xxzt2vxZ7uHBVIKC0w=;
        b=v44Ohqj/NnpHD4BYm+S/HmacsellzKBYFSHw4jPQ84NPM95x+5vSSb43Gyc3RP5twr
         /67ITK8vV7xo44f/5cmOFWQLZZ6lpy0l84V8ByRIfe4a/MbGTocuWKpx+M4gyMZzeffL
         v+dMRjoXRkOVKhz/MTRU7bmbR/QplPdkp7BjNBVc3arAmGoAXY+vJvNDu2hy7dyjSq/e
         XdNWcOFB9TpWAoj3qSbZnF0JLy5jp5/ON/pvhscIGJVCeHSKPnME7UP0LLvjBa2C7rrb
         x4M5LOkCGem3/wzPUY9+IEiGoA+Ny+bOaQH1rj2CKz4JWovswOzaO1Sa0KuiNxnA1o8Y
         hCqw==
X-Forwarded-Encrypted: i=1; AJvYcCW921e5u5HdA6dRg0IRVhEX+GVRdtemuZc5QjHqaSExBziA4G3r2S1ELLqbsxtPraLWndI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz2Cz4XQFWmYBCzsuH6bQVmaFn1Si0gfzcDpN2sY1pBcW25D7l
	xhnylNT+Bjdu0iPzyCOPGVgEQLkpGG6PQWMv1L1U2lAdlWnHcIkr2YVo2p232/oStAVrGKiVEGt
	TseuPYBFOL9LY9h+tdCuhgUnN7d6Ds65i
X-Gm-Gg: ASbGncuzUx/vlXYSN6BgxXOysR5GqjdqAvlnr/e8Sa8VJyYBWZO0UWh4zIzDJiF5cv7
	yPTBjzIRupl4gnQyc9YQpqSDmfG+J10Wu5530Aqw+rzXwmZVmmVZT4dHIKEpvRrwpu6VdtHAKB+
	UfOWr1TeUodSW2Ko4nn8AtNon3EnCVPvYdd2goS8Q=
X-Google-Smtp-Source: AGHT+IE5Xj1wpVzx/OEEsTohiIGL3zogFmxbl1qyZ3fdwvsL28QNEobsRUXkZHm6A9JlLmNoPcn9QawfSQ+4TD7Lvmk=
X-Received: by 2002:a05:6402:3486:b0:5ec:cba6:7d82 with SMTP id
 4fb4d7f45d1cf-5f02b195f52mr6810120a12.3.1743593286511; Wed, 02 Apr 2025
 04:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328170121.157563-1-jltobler@gmail.com> <20250401203630.285451-1-jltobler@gmail.com>
 <20250401203630.285451-2-jltobler@gmail.com> <Z-zpY3D01Fg4q0Je@pks.im> <CAP8UFD2UpEpqBYxqeo=vkDHwWdoO9v2RPVtnUBSOUS5MOK6n0Q@mail.gmail.com>
In-Reply-To: <CAP8UFD2UpEpqBYxqeo=vkDHwWdoO9v2RPVtnUBSOUS5MOK6n0Q@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 2 Apr 2025 13:27:54 +0200
X-Gm-Features: AQ5f1JpaYTsTK4jqbf6FREsI3ZRf64EQlLiUluG4rkz0XPcH5-7ncdNnGH17jyE
Message-ID: <CAP8UFD3dgjzj-B4iY9AfnYnZFA2v_MQW+bWG-DXrweZDKb=N9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] help: include SHA implementation in version info
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 1:26=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Apr 2, 2025 at 9:38=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> >
> > On Tue, Apr 01, 2025 at 03:36:29PM -0500, Justin Tobler wrote:
> > > diff --git a/Documentation/git-version.adoc b/Documentation/git-versi=
on.adoc
> > > index 80fa7754a6..f06758a7cf 100644
> > > --- a/Documentation/git-version.adoc
> > > +++ b/Documentation/git-version.adoc
> > > @@ -22,6 +22,9 @@ OPTIONS
> > >  --build-options::
> > >       Include additional information about how git was built for diag=
nostic
> > >       purposes.
> > > ++
> > > +Note that the SHA1 options `SHA1_APPLE`, `SHA1_OPENSSL`, and `SHA1_B=
LK` do not
> > > +have collision detection.
> >
> > I think this note is somewhat funny for an unsuspecting reader. On the
> > one hand they're going to be puzzled why you're talking about SHA1 in
> > the first place because it isn't mentioned at all beforehand. And on th=
e
> > other hand they will wonder what collision detection even is in the
> > first place.
> >
> > So I would either drop this paragraph completely or expand it to give a
> > bit more context.
>
> Yeah, I think it's worth giving more information, like perhaps:
>
> "For the libraries used to implement the SHA-1 and SHA-2 algorithms

s/SHA-2/SHA-256/

> only symbolic information, like `SHA-1: SHA1_APPLE` or `SHA-256:
> SHA256_NETTLE` is displayed. Note that the SHA1 options `SHA1_APPLE`,
> `SHA1_OPENSSL`, and `SHA1_BLK` mean that no collision detection
> algorithm is used, so known SHA-1 attacks might be possible, see
> https://en.wikipedia.org/wiki/SHA-1."
