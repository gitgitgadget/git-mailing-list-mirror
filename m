Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3351DE4FB
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758988322; cv=none; b=R1MLFpYrfYXz0YdZkRDU7pOXhem+rDIOqM+D7RkZJH+jkpfyaQuDlpNKJIgL1FVZEqxy7dTZN4HGcITDyh7iIzb+Xz2SStbOMtxNwPZyz/K/j5f49BufrNMeXE+c1olKKYUONiGRC24Atc4+lU6BErqWOTTAZhk6CdAnITN3Bug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758988322; c=relaxed/simple;
	bh=/NU3abL40QzzEOyrzzSryNxNgYvt4nr5ufPWTD6arWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMFCDHli8nVvDlQXwosyzhAZrt0iaS22jB0HNr2E19KT1HwN0nbWXHe7fYX39MX5QR7sbK1Ho2dFq+yFs717iLmW+Se7RcoPZ0B8tJpiS6uK2L6/gtGkzQ7UY2LOp7bj129Wk4/qA4QXlY88N7W83PjuMGBv4nDQfbCEsax/j0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5LGpp6e; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5LGpp6e"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3729f8eaa10so548383fac.3
        for <git@vger.kernel.org>; Sat, 27 Sep 2025 08:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758988320; x=1759593120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbLH5i51ExSZFmPDZXdbH10Lw7k7QKEfuohYMN2dVI4=;
        b=Z5LGpp6ezT9u27+c/auF0Mz3kUT2gt+8ZxTAOR93KKQxChdE0LLMHqt/WopAgte+Jb
         vTzZFyEymMtpfXA4rHPbz6LxJrweqxREsY+WAurx1H+CTzEaQyzwkUUkq8ibWh+uaZ1i
         03zamFIwOlA3HmScECew9ZyS1ZphzMYWAJVQ0/fHf3OHzHOy6bVsr7/XTRQwsLp8NAei
         nwx2kjih22BM1C1wcocvmRhhCVFV0Shrq7dNlrvHTTp8+8rThtCv3bib/BWcfPvIpDMJ
         wRMNx2tT3EYktdWlBJV2d596Z4GdSO73Czj3d1kCErESmHBDvbnw7mUwpaWIlDYPDnX7
         KQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758988320; x=1759593120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbLH5i51ExSZFmPDZXdbH10Lw7k7QKEfuohYMN2dVI4=;
        b=T5FTeriyPFPJ7HpskdjXTuaITEJ26BCDot2XfPvoGHS8uhOx7orpr4+LEcpzlKeIT5
         hM/hqdywrMeWHqhNOpVG0GEN/InXwCDzeNQ7qojRIomM+LuZ3miuK3Xz/raamJ/kqjv4
         1JludK7EqdEyaxkOVrKw/B2r7vkxYU+vKe5/iVrY/QOZc9JIFg3XcDi3gU9zX0ct4A5F
         AmtSYbMJB2/2TGs3YK84IFMbEVRJeBetBUUMRMfZ8px9BAHtTDfYAJfw+xx8fYK5eS+F
         5uQOo4KDHe9IHjjvwvxZz5L4wYEWIA26VOBE+bGykQJVToNwDPT0Dkxl7UHzw+KmBQmy
         dUXA==
X-Gm-Message-State: AOJu0YxmQkUnFQYmzjBGEPG5tblKfPA20t6jwrfvaYzS8KFDIaSbaBJg
	kzRJzgqMvLytnA89runYJ4pp85drzPY9MW4YbQMzKnVHPZa6Or18Ma1e
X-Gm-Gg: ASbGncsHu7GcDR1CRXFNc/z112XwLxGGmXF09vgjfe0cB23GJ1X7A2WQOg6oYuo2lyA
	WVtNYvz6bPLeNUcGJHaYvN6iQGougiAcTOmojHznnzo/gUk2hZ4JsmXxTl5FuGN49fzJPJ+W3A1
	ke2DKPk7ElEpIkdKE2m560+aGucwlCDYSStIlepRzSUxPoPqqwZhw97xnGGSTg4Rp9H9bgVWnrT
	FK0GwHzkeGSRFKKrTggix/+gSUhrqZlLkG/NXt4t2O9qMPouSbSDYLBr0Xf4tVO7Hgy8LXCTomZ
	IklazNQp91jJTUeAqY7a3yzIeHkWpVkAJTvl4qkUxvdCmgrxsd4gidny3gOS5pnlc+PYG6BtgwE
	tbCq0uFPuWlHQo9LhJRDkevM99QqWBihVdgS6QZs/6o73PlmqI8bGjzxjB+L4chq0Ok5w
X-Google-Smtp-Source: AGHT+IFpD7h4yeGYFQdvY8L3UGQbTlKp+sVFZ20A6Aar5ttJVnbOK2TmMqZz1pmfm6ELsG3LanbSSw==
X-Received: by 2002:a05:6871:290e:20b0:36d:31f3:9f1c with SMTP id 586e51a60fabf-36d31f3f7e2mr3053253fac.14.1758988319808;
        Sat, 27 Sep 2025 08:51:59 -0700 (PDT)
Received: from localhost (syn-070-116-215-226.biz.spectrum.com. [70.116.215.226])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-363a3f3610bsm2239608fac.14.2025.09.27.08.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 08:51:59 -0700 (PDT)
Date: Sat, 27 Sep 2025 10:51:57 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com, 
	sunshine@sunshineco.com
Subject: Re: [PATCH v4 3/7] clang-format: exclude control macros from
 SpaceBeforeParens
Message-ID: <5g4ysjfqrjltnqr35xh4efhzmqmzpmut44pherfsjzqinfbpmo@6ax5lzob7sox>
References: <20250925232928.3846-1-jltobler@gmail.com>
 <20250927145049.723341-1-jltobler@gmail.com>
 <20250927145049.723341-4-jltobler@gmail.com>
 <xmqqv7l39a5c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7l39a5c.fsf@gitster.g>

On 25/09/27 08:40AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > The formatter currently suggests adding a space between a control macro
> > and parentheses. In the Git project, this is not typically expected. Set
> > `SpaceBeforeParens` to `ControlStatementsExceptControlMacros`
> > accordingly.
> >
> > Helped-by: Karthik Nayak <karthik.188@gmail.com>
> > Signed-off-by: Justin Tobler <jltobler@gmail.com>
> > ---
> >  .clang-format | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> While this may be a welcome addition, I somehow do not think it
> belongs as [3/7] to this series, whose theme is about "git repo
> stats".

That's completely fair. I noticed the formatter flagged this issue while
working on this series, but I was also on the fence as to whether it
should be submitted separately.

> Perhaps make it a separate topic and have it graduate sooner?

I'll send this patch as a separate topic and can send another version of
this series without this patch.

Thanks,
-Justin
