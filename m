Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A8F4C901B
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321300; cv=pass; b=uDg2n+f4LbVIkj7qvvrwoLVA8GMUn8gruz3519NElkPhbFR827A1yGpkm4RgCnsUW3wBbpWuONMLYOhRty2vF3vWrkrZCsSI1EClQqu5EbMJ3VwEzU60KptJI7cGw+KSYDXQ7TDGidxhdyh7gQzzjoMB6kGdt+2pCO+VCWtweZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321300; c=relaxed/simple;
	bh=YMOQkKqf46sxi+GSEja1k31p7Mr/KmwivEQYu22+HP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVQOU6baPtbZE0nc7bi607SyOTyxSbuYBzCPEtq7DoCz5o/H+PC/oVquAGBjb9xzjZRBEIa3WINTkz8b0wtIeVSgxJmiGgCUIp8CeeEf7v/H5ADqJ5n/MWSGpUdOIvR9iu6gQTye72cZsMWgSwWqcG8FPiZXE5Mqd2VEdbn909s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7DQbRTx; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7DQbRTx"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-45ee4251389so680045fac.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 07:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787321298; cv=none;
        d=google.com; s=arc-20260327;
        b=cmP+hrUocejDjK2s+j6prT5ToiEkokB8JYbOLNmoYmiTwFX1pA9DHE/lnr2/Lf7orW
         hMQ4pCeS5hJW6/qjaiiiFilASgBWC8/7CvmwQOVAWZS8iwH9r/8Vgd6bOeU1tnrKyCQI
         GPjwD6zCI62HcRd6igUHQHXNSbpKSpmgk+y1z+FR/+e9vc+TCUsU0gso0y6Mk2izmHiX
         VE9hrKHochkAQc/X+cAT5VQYNI22r8WsEPpWiYg09Q5gL0MhxPvZsvLt9DIrNuEDBfUg
         P2o1zjmMiMnu8LE8bELEHaPZYhSxjxfiDSh1r+d4yn6QXM/w1L+dnVd6vdTLcj6nZBtJ
         EBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1h18y7ekKaML/xTNWUbmFMHMXG2s0RgGPr/NA+/Y0HI=;
        fh=9rin/SoXzXxZ5bIMvkZPBxOizid1fJV4lAITPMcwYE8=;
        b=ACavaNXciPWu+grj8XJJiTesnPL8f/ZFyk1ShU1G0fWD5h7ztImY99xFcp+EyKyZDq
         XqlbLi1ZfIzFFOKX3ZaN41u2qSIsVJhGYjqp1AluHxVjPWIr8SmXyQdtxtcmVhnvWNXu
         23UFR6qQJEHIGNwIMQ2bKoiY9WfMtJNo/kGLGYIrVJSRZ4Vdok6RrOtUfHUcmlSTCqUE
         jz8SY2A5f31XVBv25geoGxoKgVnMERXTe6scbQRSseln+mbdIHIoOZD6Ut0d439HIQWi
         VL4WZFw59w/7Q3rXYIFWGCvPzqsz0iohmBupjkhmj9cbnhVB/fmZaJ2fvrijXzVOH7xv
         U+xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787321298; x=1787926098; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1h18y7ekKaML/xTNWUbmFMHMXG2s0RgGPr/NA+/Y0HI=;
        b=s7DQbRTxM91vlfXvGXPGVbNc6/wzJBPJ0nT+lAkODVk/mVu2llv16mWeoue7n9RXFA
         hwzQ/ireb8fdfKAfFS39RxGUslhNp1DuFr/2oOzXuK4cfkSTWeOby4Q3CWo7k3z2tIU4
         zkkmMU+tHDOb31Qq0UWssoTOWO/0X2zNIH9XgiKDfxCGj77iloYaloSrTvxe7idqLXxc
         vi2ToW731JeuSoOL2Z8LAakZNbDyp177xuAK2irDwJfYAByBj+QCBAJVUKU8SFxDNjNW
         000dQHqToW8SpFYwizSwmatQNqfwL52YEVjOuwvXLwSz5KIggmEXj+jFK5taUW/99cAQ
         Z8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787321298; x=1787926098;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1h18y7ekKaML/xTNWUbmFMHMXG2s0RgGPr/NA+/Y0HI=;
        b=nh74yqEXRTF8x4LjgstOQvZdoTyWTkpsq/bOz1+xpdNwBGQFQCUJn5hjAK38ERsp6n
         nRxon3mXUzQNFnx6e9SPjnYpqH+BUD6Yy4ZE9cYhgSBhOLNI4e761RdLRiUYGe48hwWx
         t3fEPkg88baPMkmJrreU8/cA7grMIRGdeeagcahgXg39qxo+4XSsmMpNkVdk5biBAibH
         iFkVBn09Ap9VesHyPIPlT/O6sCgwFLdExEtkouB7OwKk+QB5CQQoQux37R7VUiUPuwiA
         c0Mnqd9A/7IVNO0ntaSWJJu+2Nw2v7sQTDQVyWwY8awDj5JWAjk8mJoy0lu3XdDKTe6U
         +DTw==
X-Forwarded-Encrypted: i=1; AHgh+RoqGVexzCG2If7hAwJw+KKXMw/8E4wNKN3YVrlJQUgZhF5yLABR5NZ8Ly/Y+4LJQXlA20M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvXWCQxErIINBuv/jt7fyWrCyLnW2NfHJXVDkIB/PrLKygXqVI
	5VXRbEf4jhjuJLAAOPu6DUy9h4dnKrGAJt82ahDuKNOOJ8IEVM3erezZ6IIJaFphNHDaqDpev1h
	y0sNHxvp3HSVJKFPAcUyxtN2UzvRwclY=
X-Gm-Gg: AR+sD12rojyaln/ldjm8K1szGcWlsEjbuo+wMegwL/c0ODQeXi3zb9At+E9/OZlkDLY
	qUvqCGjkROzfHDlpkUitl9CJjmpxOo8RDNejEqI9XPUOCaye8lv/DD1ZucO5H807/j/UEe11Ey7
	iXh5JcUmQgWMfgFxt9uOVNXZDWCcr0QrxiRIgWeuMkX7M2jcC0gpP8+++Y8Rvej/XBK6axBr+bY
	hxKSE+rHu288Y9xEY7nC3r25adNikRyhiRBWfOeWnRFeqetS/4uGxy/aFb+8LeJp+spi1+XQ2z9
	8juVTe/ASkiE1BwmWHONN5YDoWTATBNukrictaCq2ALjrRftCv2lcHxllb1UvWgJaNXLKzl/S18
	Vxz7CYS5g6Oiq/J+LiTwysVyydJ9VeZS7yne/fbyN/PDKJt/myJcj+tB1bhmLRsJyUTvuy1Xtbs
	4=
X-Received: by 2002:a05:6808:2f07:b0:485:48da:133d with SMTP id
 5614622812f47-4b2ef328ca8mr7046436b6e.10.1787321297851; Fri, 21 Aug 2026
 07:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260806101556.162940-1-jayatheerthkulkarni2005@gmail.com>
 <20260806101556.162940-7-jayatheerthkulkarni2005@gmail.com>
 <6E2B0ADE-2101-47AC-B11B-315897AC2AF9@gmail.com> <CA+rGoLfPJb_Pxjm_Bkqd2Ni0BA1vT2LEObwj4EjUaSRRNyRv-Q@mail.gmail.com>
 <xmqqlda3z773.fsf@gitster.g>
In-Reply-To: <xmqqlda3z773.fsf@gitster.g>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Fri, 21 Aug 2026 19:38:07 +0530
X-Gm-Features: AcwNN1XJu_tf-F_xNc2Ia4bfPe_xbfUpS3DPF2S8V6PuS7unjcQRebJ4yW9HuNU
Message-ID: <CA+rGoLcFojrG4yfFG2OB+p-qJie==-Xz89Cysjz1mTLw8Xzukw@mail.gmail.com>
Subject: Re: [GSoC PATCH v4 6/7] repo: add path.git-prefix
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 10:39=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
> > On Sun, Aug 16, 2026 at 6:24=E2=80=AFAM Lucas Seiki Oshiro
> > <lucasseikioshiro@gmail.com> wrote:
> >>
> >>
> >> > Scripts sometimes need the path from the repository's working tree r=
oot
> >> > to the current working directory. While this information can be deri=
ved
> >> > through existing Git commands, `git repo info` does not currently ex=
pose
> >> > it as a scriptable key.
> >>
> >> Even though I understand that this is a relevant info, it seems
> >> to me that it's a little bit out of place here... This is
> >> a "current directory information", not a "repository information".
> >
> > I agree that path.git-prefix is technically current-directory informati=
on
> > rather than repository information.
>
> The same thing can be said about "git rev-parse --show-cdup"; you
> can complain that it is about the current working directory, but in
> reality it is about how to get to the root of the working tree you
> are currently working in, which means that it is very much about
> repository information, only given as a relative path.  Nobody would
> complain that you have 'path.commondir.relative' when you already
> offer its '.absolute' counterpart, saying that '.relative' is about
> your current working directory and not about the repository, right?
>

Very true, I agree with you. I believe cdup and git-prefix complement
each other well, so it makes sense to expose both.

> The same story holds for 'path.git-prefix', I would think.  View it,
> and "git rev-parse --show-prefix", as the inverse version of a
> 'path.root-of-the-working-tree.relative' (aka 'path.cdup') rather
> than as being about the "current directory".
>
> Oh, and if you are offering git-prefix, you should offer cdup as
> well.
>

Sure, I will add cdup in the next version and send it.

Thank you!

- K Jayatheerth
