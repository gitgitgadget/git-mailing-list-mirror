Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD361A7273
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472155; cv=none; b=PTpeZP2deOp9H/wZ509NsXIygc9dgE4P8HT+32ossN+g7vtVZDTyk6hd+rjwXJULkX3g5VtjiUZfwsPE/UkOcPOU/ukI3IwFNHEnkVDLbGea/keqYAeM52r/zEH/DkJ0yTQmzEFKWbnaFwjLhATHJ19Y3e2r2f/L548KzKiezbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472155; c=relaxed/simple;
	bh=aEzQN641hpB+maOUdSspnH0iKT/Bfjq7XWlRPvMtPMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDxX7s7mcCpIqF9o887988eK4Dma774X+l2AVHh0T5OxCMIQNGzd+jSHADnTWZcUus6e3JYjL5wqV8ZiGOvB821rcAILM2dHfJ+rfnHLguz+xsoIX5pHWPO8j1+gfwgRWJVaGLMHyK8W7ZzLKfPjlQrFH8Hf2strSm3mNPzcsNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ILoifKWs; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ILoifKWs"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e330b7752cso21616057b3.1
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 07:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730472152; x=1731076952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qrVMj64JQq0Xw/xuUC8DvQTecyxIvftjlt9o82FyNXs=;
        b=ILoifKWskpiAMAW9LEnQMl8PH1VBneiZHfS2AvrYIFKKL41B7dT77wO2wvu2YbbU/g
         iXCXbB6CpPXNf0zIhHrF/YTaOlAa9f/vOaAdSpfG5gsFRMRMcnNIoeh8f0nDs5/uSXGQ
         tm4qDQIUU0Zxq0I6biEhz2cNVH9wv9g/tF944eHEhpCbhOdfbnY5x4KZO3Q9sTqG4l/r
         YvifrPGMZS4gnae68dDlQwy3f1ILHBk9Vp40nlY0vd6s7Hc10q+yvsKsyfgP6JzEKSMf
         k2wIE7//cTBRQ+F/S52VQcn9E3zB/orlMDb3ke+wsXWCYCS8HHbDN2iAFYpH77gOX5nO
         3isA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730472152; x=1731076952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrVMj64JQq0Xw/xuUC8DvQTecyxIvftjlt9o82FyNXs=;
        b=EhuquuVvBY7T/yEoJkxK3PzZDHS2KgtrZyjVN9BLATy6Wiwb5l65KEN5TjadP+JkmV
         PN0aUs1gbuskUKR7dDNrfR2lo/2yJs/kXWkkEUFnKizuBVh3umOxOoMthxDnqgfeNIAK
         Ow/zTREbtU6IojYXblVbDbOtAO5L8cHSSOOeiPhUxJ76G2Bar4qk5VmtqstmzdpN4CV/
         85Ghq7gV4tK7j3xN+fCWIfYNUW9c+xHk2irXsRgWH6SpUNT39FRdVD4z6Pqs4iGPlCis
         UfupojFOpsTjVGqzCEjma8bwnJSGbp2cfDkI/lYJqOFXIDiUMadSjbP7ux+Z5fBXnJFk
         vCoQ==
X-Gm-Message-State: AOJu0YzvxNtyYIw2kiGKWbZqS8zaJNGV5UMhbAHLUCiSZsC053lCQH/l
	ppS4TbaOvscPNOc9qy2OHA2Q03FYEPf1UhCk4Oif8YP5ZoSGsAW8m7FAlpHNm/vAOVv1FM3oH3w
	4a7Y=
X-Google-Smtp-Source: AGHT+IEdEa8T2PIfgQ7LKKwL7NFBNEMk2hV0bAEOFhkZgwWuViDD2gxAWjw8VBp2gEzsCts9PkHVXA==
X-Received: by 2002:a05:690c:7281:b0:6e3:6a76:ce45 with SMTP id 00721157ae682-6ea643283e4mr31522857b3.13.1730472152180;
        Fri, 01 Nov 2024 07:42:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55cd398esm6993847b3.139.2024.11.01.07.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 07:42:31 -0700 (PDT)
Date: Fri, 1 Nov 2024 10:42:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Seyi Chamber <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, phillip.wood@dunelm.org.uk,
	kristofferhaugsbakk@fastmail.com
Subject: Re: [PATCH] t9101: Refactor test_expect_success format
Message-ID: <ZyTo1lQaEVvZ1Eor@nand.local>
References: <20241031094554.68916-1-kuforiji98@gmail.com>
 <ZyPlYkwsFrxH+JwE@nand.local>
 <CAGedMteyi0_C4PhfCXcD5gHe38px_g4hbxuG63o8tCSHdLcfGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGedMteyi0_C4PhfCXcD5gHe38px_g4hbxuG63o8tCSHdLcfGg@mail.gmail.com>

On Fri, Nov 01, 2024 at 08:51:11AM +0100, Seyi Chamber wrote:
> On Thu, 31 Oct 2024 at 21:15, Taylor Blau <me@ttaylorr.com> wrote:
> >
> > On Thu, Oct 31, 2024 at 10:45:53AM +0100, Seyi Kuforiji wrote:
> > > The current script uses an outdated formatting style for
> > > test_expect_success blocks, where each argument is separated by a
> > > backslash and newline. This style can lead to readability issues and
> > > makes it harder to maintain the script.
> > >
> > > The modern style consolidates
> > > the multi-line command arguments into a single quoted block, which
> >
> > Strange line wrapping?
> >
>
> That error probably occurred while I was editing the message. Should I
> edit and send an updated patch?

Please do so, thanks.

> > > improves readability, maintainability, and aligns the code with current
> > > coding standards.
> > >
> > > Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> > > ---
> > >  t/t9101-git-svn-props.sh | 48 ++++++++++++++++++++++------------------
> > >  1 file changed, 26 insertions(+), 22 deletions(-)
> >
> > This does not apply cleanly on 'master', so I assume that you wanted it
> > based on sk/t9101-cleanup. That's fine, but please let me know in the
> > future in case it's every less obvious :-).
> >
> > The changes themselves all look quite sensible, though.
> >
> > Thanks,
> > Taylor
>
> Thanks, Taylor for pointing out this issue. I have rebased my change
> onto the latest master branch and resolved the conflicts for future
> updates.

There is no specific need to rebase on top of current 'master' unless
failing to do so will cause the maintainer to see a conflicted state
when applying.

Unless told otherwise, I will apply new rounds of existing patch series
onto top of their original base.

Thanks,
Taylor
