Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7B913D297
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730073036; cv=none; b=UqzD2TMeWeoQCN566azDBgzh5g0tD//OEfxkIQpH6zk0+dPs7++aJiXFm8442EI7k509Kc16ziNDnqwQStCqqJYflznS+zNdDy74wgxDv7rwzgSZeOZuh8zvusEF5BjM67KBvWlK7Q2QCVyPqLUUmzzZTo3IwcuYKjgWuWAr0yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730073036; c=relaxed/simple;
	bh=7nXaYzo4QZFpgKVxzqjZfnsXwxtxnkCjObBSU2aD1do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s26FN38EOyVqDe3poQz3vKYx7B+T+Ed8qUVaU+6gAgcaxEkKnwtSgBcqLPnuhloOIo7tjr7RpLu/JEdBNoYBW3KmFuKKcus1QUxKf+to1AS2p7d/EIODnqHKmDRGmFqq+OwHz4j7K62SqCa+vDCuIjbGiZB683udEqTWYKNBj7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cHzhQ2oG; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cHzhQ2oG"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e291f1d659aso4052667276.3
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 16:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730073033; x=1730677833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FO9w3UdAAuyG1GfEAF/KO5d0zW+mDNUtTbYnGHh97ag=;
        b=cHzhQ2oGVbJXjJuWt5iUSwCcO0hGJm2AA5yaLyLFACXZ7J1qyFI9gNMLu6BVqMWF6E
         s3yeDvN0jh1FzPiLuDpCUgoR6so7Zl9xra6jJTvvp0FNM/tlqD4pg1rBmsZPEzCrqmRY
         ygIPamDjRuIP1r7xoMxnjjReAnUHpDX0LRRAPlPoQQkMw0G3wfE2sGjs4ROFofHGzrlJ
         ITBjcfY2EYnboYJu0Rf3WE9jl7ocQHYvsFxZAoDSY+zoVC1HI+xh/HgTi3JI83Gld1ik
         KpMaHtHlPE9w1kTxWxcNpnbwwkPQmYSvMJzqHS3HBANFRtFDzbajuNrTF4N+BlIaA7ta
         gerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730073033; x=1730677833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FO9w3UdAAuyG1GfEAF/KO5d0zW+mDNUtTbYnGHh97ag=;
        b=StpfTEWwIS9HRIDEazU3R01c0/xrS+JbxJGuiMKCIL7b/NkDdrmgkdx2jDG3CPUG+o
         ga8Uv6xppize/Q1+BkPVCGhI1OR3xF5IxN8LtdYsb6Rhbg91NFqpJG6nTavMEt6FybQP
         stlWATm8uIbRsRqjgheIFKuF3vhQuG+X4wTJqVf9qFGmey8rHD+Xecmb0se+hqnUM5O+
         5sndJ3PiVWQhyaYoxMjZUyur15WoiT4H+GXG+3iFv6fWJzcai+8eyP6xjWEJlHtacYs7
         bnWcU2KQETIPPf5RuwUJz0FAZ2A+pnTwDCS3nU1IvFJ1EI0eIQEnZdxdilkWV6EBP7JF
         GquA==
X-Forwarded-Encrypted: i=1; AJvYcCWSvaLT41GFiR8N6ZPzW02IUKDLMUQ2in0sGY7aUfnaAIicv/a1DwzHd6jmqAFeyKj2uWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+68e5UevAziTbBDU+6sR8Ecrk1yZI0o/63mrdhDZgDKbCmlyu
	XYmm+gJWmG2ruCirncfWtN2ld7vqQ0reucSzW/XWry7svMShPG7vR45Wv+tw2Pw=
X-Google-Smtp-Source: AGHT+IFfzsF+j2D+WOd6oSdivD/xfj21Uv9jb8jyrLhdZ1mYZ7aKjHG/0O1O4+zmh+nAq/2K9fnOVw==
X-Received: by 2002:a05:6902:18cf:b0:e17:d0a9:56e8 with SMTP id 3f1490d57ef6-e3087b82083mr5525948276.28.1730073033595;
        Sun, 27 Oct 2024 16:50:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e307a01fae9sm1183262276.42.2024.10.27.16.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 16:50:33 -0700 (PDT)
Date: Sun, 27 Oct 2024 19:50:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 3/3] compat/mingw: support POSIX semantics for atomic
 renames
Message-ID: <Zx7Rxz0ZG+Gqwf03@nand.local>
References: <cover.1729695349.git.ps@pks.im>
 <cover.1729770140.git.ps@pks.im>
 <ee1e92e593e35f3888e3e47b6f603c04a1652ec6.1729770140.git.ps@pks.im>
 <542b306a-523d-424b-bc9f-c63bb7040beb@kdbg.org>
 <Zx5eg2SkHMmNhQRh@pks.im>
 <49619b52-0fea-4179-a829-7ec4a6945055@kdbg.org>
 <Zx54B6FdGprtH0HV@pks.im>
 <c044ea3c-2f8c-45c1-99cf-17d9dad5b55f@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c044ea3c-2f8c-45c1-99cf-17d9dad5b55f@kdbg.org>

On Sun, Oct 27, 2024 at 10:36:55PM +0100, Johannes Sixt wrote:
> >> Ah, I was confused twice here. First, the documentation that you cite[*]
> >> mentions FILE_RENAME_POSIX_SEMANTICS, but the name does not exist at
> >> all. There does exist FILE_RENAME_FLAG_POSIX_SEMANTICS. The
> >> documentation is just wrong. And in my earlier comment I copied the
> >> inexistent flag name.
> >>
> >> But I meant to cite this flag: FILE_FLAG_POSIX_SEMANTICS (no "RENAME").
> >> It exists and is for CreateFileW().
> >>
> >> Perhaps you also meant cite the latter one as the flag that "is not for
> >> use with `SetFileInformationByHandle()`"?
> >>
> >> At any rate, the paragraph as written isn't correct.
> >
> > I think I'm missing something. That's what the paragraph says:
> >
> >     Careful readers might have noticed that [1] does not mention the above
> >     flag, but instead mentions `FILE_RENAME_POSIX_SEMANTICS`. This flag is
> >     not for use with `SetFileInformationByHandle()` though, which is what we
> >     use. And while the `FILE_RENAME_FLAG_POSIX_SEMANTICS` flag exists, it is
> >     not documented on [2] or anywhere else as far as I can tell.
> >
> > And I'd claim it is correct.
> >
> > [snip]
> >
> > [1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/ntifs/ns-ntifs-_file_rename_information
> > [2]: https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/fltkernel/nf-fltkernel-fltsetinformationfile
>
> OK, then let's leave the text as it is.

Thanks, both, for vetting it carefully.

Thanks,
Taylor
