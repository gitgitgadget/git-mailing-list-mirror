Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9831CEAA2
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708414; cv=none; b=KxUWmFlNRtOABBAWEKJO08bw9nwKT1nF1BjlpSNv6pIy8Hi7OITD3c/1McvNy3eyXe+KotS4VV4e4oil0PwOwaEYcvdtfwol09b+IggEp3hVOIaog2mMv3z5Fi54DGJgBGoMeAqlGM7yqzp9m7Smdz1Eni2eM68/pPoGkvcLhY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708414; c=relaxed/simple;
	bh=xMv1wjk6z/59CLWfo1IlenHehXtWSQKYP/a8QdJ/SUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9tr7Vhlsp47c0APHuQ5uSvjTjtddTeL5XMfFsTtYW7HIX/LNbNMzdwa8Pa6DIgZ714u/lGyixO4eRk49gWVgKuLTbVrA9yEPmfpWP56l0NzTcCNvojvxhFAZkD1j02tw90QVrgsK45gB2NHmByBQk8GPh7feVKSHFJ0h4XwUyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=PoM60ucJ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PoM60ucJ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e7e1232648so679767b3.0
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729708412; x=1730313212; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lGLD0OtfSYFSweiQ4L0hazEgV+XxmPygFpRaO1BB6gI=;
        b=PoM60ucJly9nD4zWRQha2nckb/6R1ILhrPjocVcLpJIOXQHygmb33vtaKMABPwWmYE
         wiD8gUoP2ankVPPnEAlsyfc128Erq8/5n+V1c9Uj4fb8TwvSGBRMgSt5kjSElU59MjfZ
         6VBkcyIktf4q0XSHPMnlfDpBwp1+kVDlsmJUZHlLodS0v4RV3tCPm1EphFJgCW4q0kDo
         BcthpVbe9t4OhEbknP+usEijFFMcwsr/0qzSWdjIl5Qv0gQREPS6iDY9SMw7JHenalIR
         GiDouFoeZnKLsQdgVM5sFnUf2TcbfoLSPxTMt+x0KqwJmJYCwXtNJrTWfM0cTbsVMl3o
         F4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729708412; x=1730313212;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGLD0OtfSYFSweiQ4L0hazEgV+XxmPygFpRaO1BB6gI=;
        b=k4jgG1wY2BJk3bYJOGnnRc4Mn6SZPtwnxbSq45u56mAOJEBfLjmXPA93eZLmlPvJHV
         9yf9feCk23d4IPJkXdxhsf5OK2uiFPm1gG9kaH1rT4r6yLavTWDIoGgObVRb6n53NRmY
         GBEPfP58gN1y9Eo/llozKxYoQUiqKf0b3q8XTqDsU8gfksi4Lf7bihd7eCJ6B3NMbJ3K
         k7tHoHmmg0svHTbY8nU5tHDfG6ymZ0UdjxC/yUtGwkiw1/XrMFHr4Su8luQ2APDWMWK5
         7gJO282Tvfgys3bTouRPq/xKBg/DQN1ZzmxUgA0VyZ+sqqvg86xSg3zmhdFxjkG8bheP
         jIaA==
X-Forwarded-Encrypted: i=1; AJvYcCXzLbABCIraIZADb48i/6JVhSArpi0DU09tER2Q9Hc9GJfzbMjjSz8dNBc8Vdw33iVRG4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7vpUZdNEcY2B69hHuT453c26jGlHl6Z5nnFxhV1JfW+cmjhuV
	qP/8bWUkp84dqqFH9GHykTCNqjm7TzaEFJSofNxo0dtdM4Lz1fZUB5atPta3iPV9NiI+SOWAk6+
	co3Y=
X-Google-Smtp-Source: AGHT+IEH+f7VhV0AvUO/CR64hH+G3p7WGsXuTWWyU2jC3hYtDVKgEtqRmrdW8eZGezzoRH1p7sZJQg==
X-Received: by 2002:a05:690c:318:b0:6e3:1003:cb0c with SMTP id 00721157ae682-6e7f0fd6fd4mr36358297b3.46.1729708410719;
        Wed, 23 Oct 2024 11:33:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e7e1563f23sm7703547b3.51.2024.10.23.11.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 11:33:30 -0700 (PDT)
Date: Wed, 23 Oct 2024 14:33:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Andrew Kreimer <algonell@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] t: fix typos
Message-ID: <ZxlBedgkkNfOJ8BX@nand.local>
References: <20241023170111.6638-1-algonell@gmail.com>
 <fa5d771b-5819-4ede-bc95-9d50c456c619@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa5d771b-5819-4ede-bc95-9d50c456c619@app.fastmail.com>

On Wed, Oct 23, 2024 at 08:00:53PM +0200, Kristoffer Haugsbakk wrote:
> All of the changes here look good.

Same, modulo the one comment below where I think the grammar is still
wrong.

Thanks, Andrew, for working on this, and to Kristoffer for reviewing.

> > […]
> > diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
> > index bc2bada34c..aecd03d69f 100755
> > --- a/t/t5528-push-default.sh
> > +++ b/t/t5528-push-default.sh
> > @@ -147,7 +147,7 @@ test_expect_success 'push from/to new branch fails
> > with upstream and simple ' '
> >  #  - the default push succeeds
> >  #
> >  # A previous test expected this to fail, but for the wrong reasons:
> > -# it expected a fail becaause the branch is new and cannot be pushed,
> > but
> > +# it expected a fail because the branch is new and cannot be pushed,
>
> Also: s/a fail/a failure/ ?
>
> Perhaps “to fail”.

Yeah, I think "to fail" is what was supposed to be written her, but "a
failure" would also be acceptable.

Thanks,
Taylor
