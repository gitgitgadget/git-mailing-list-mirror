Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37331A08DB
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615350; cv=none; b=Y+LUVRhWZOJ3AdRbBgpMzcRTjDQTZEnwQ/j1TZ0n/Ayp6U0w7lpXj4FSRuHzEK9nwPmPiy1QBYko4+9Lt47igRgNc0wiOEMx4aOQSiBnd+UxlOe5TTwMXub5BE0y18K/QdXokA/eC+YtHdB3Te34G868rr3yPHznMTFf+fWRoVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615350; c=relaxed/simple;
	bh=Zrd6mgdGRZKIai+9xeZPczV+vW1K3BoWteW1ew/ahyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RO0gLhe7UfQ5bJ0p6y36BxT4n8IvtaeNJK+7Fj+C/Fy2xh8tLwa6Q2/YbFTg6SfXyEXVY61BeQ9zkVNKN+V3C+xy9hKi9PFnfUsm2LFdASviAODm/ZB+wwJnK+KLICr2nFaqSzxksE/teQv5ym4J2+BDYu9rhdGb1lLX7VJiPIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=owkUIb7x; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="owkUIb7x"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e2e41bd08bso67644057b3.2
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 09:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729615347; x=1730220147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fj55GVnWblkgUPbjImm5FE14zcwMowo6chLuCz17xj4=;
        b=owkUIb7xrVqsUlEsFzmyvR+ablSJfA9hXWbbyOevAwiBAfwf1XfKDGfOEB6tgjGMtR
         FA6Xn/fhMkbnbo7dBCQBbEW0vgSHdFFG3DNrBDQ8lwrgmfpexMOfSq9wfFwV92Fit6sp
         bo2sr1mi1yt/2ZukD/6H6a1h3tmjz537BY8PDNWEOZRZuUkw8RtP8CAKD1aQct7hfjo8
         y5e3yhDfauSxsS4ONcwvicDQsQWNKeVf4P0/gARa6roFhB8PFihRMA6w8GVBwSkKdVcy
         0MV+6pPEYc0RLRtyyOhwPBAQnPTNtiNMyojLTvQzoPiaIdRwuSElP9GfKEr++Iy2wlWv
         2VEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729615347; x=1730220147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj55GVnWblkgUPbjImm5FE14zcwMowo6chLuCz17xj4=;
        b=Us9sIofnQ/gc3ti1hfEMnqsKqf3t9JnQOtkk2wg+l0ndrNBMFiGqpOaTsfpeB9AK9y
         bxzj/3gPO5OTS2cMEZf9fbOn70gyHJcOL1VS20G79qGAipcUMwrFlvFqEqjK80cYmfNT
         8Huoz9pe1tsDVoIfIXgOHXqEQEboQWI+fHh6gKVrQMyv0qxxWKcUPlgRNUoAYX6txRGh
         ArMvO/EXZ+ihOxl0aMwAkg5k2pYTwC42DomfqWoqeDiFxKaxM5KPbtZtf9xLyaRzhHV7
         nHUIQW79tkbPuPJk5T3GAF9ngZV2QMUSCRszXRMcH7H373jiN+491VIjgUk6C0qq2vj8
         kdTQ==
X-Gm-Message-State: AOJu0YxEKpOCUtMYPznRFcCZ37XP7Cjx5PRbyn9nu7FwIJhlzVJ+NWZf
	BPxbjgLSeLY4ANhyP+O0zRJp15e9cJtEzlRjvTJC2KeVGG4sBEaAVu/zac41yPA=
X-Google-Smtp-Source: AGHT+IFxctJ4Tv25dTczp/YVrUN1+kmRZuVn156bainIUP23l/LNGeTHlQcjVkxQ0hMNLKzXBk7QSw==
X-Received: by 2002:a05:690c:688e:b0:6e6:1018:64c7 with SMTP id 00721157ae682-6e7ef339649mr660307b3.41.1729615346766;
        Tue, 22 Oct 2024 09:42:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a4f403sm11457377b3.41.2024.10.22.09.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:42:26 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:42:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, toon@iotcl.com,
	spectral@google.com
Subject: Re: [PATCH v4 0/2] Subject: clang-format: fix rules to make the CI
 job cleaner
Message-ID: <ZxfV8fNf5UQxo3A0@nand.local>
References: <CAOLa=ZRvFBhageS65uE5enzLBz7H_CAvvnEcPsi_QAi0exRx2w@mail.gmail.com>
 <cover.1729241030.git.karthik.188@gmail.com>
 <ZxLVLiiEEj2A5Iws@nand.local>
 <CAOLa=ZSCenJLOg1jF==_uNGJ7GZdLiNd6GB_JO4XyXMdLNT65g@mail.gmail.com>
 <ZxbMRACNtMfPiWr2@nand.local>
 <CAOLa=ZQA1MkkV5tVq74LWPsueJ8L4UBXr07CF-JXGsh6jS4zTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQA1MkkV5tVq74LWPsueJ8L4UBXr07CF-JXGsh6jS4zTg@mail.gmail.com>

On Tue, Oct 22, 2024 at 04:31:37AM -0400, karthik nayak wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Sun, Oct 20, 2024 at 06:17:58AM -0500, karthik nayak wrote:
> >> Taylor Blau <me@ttaylorr.com> writes:
> >>
> >> > On Fri, Oct 18, 2024 at 10:46:44AM +0200, Karthik Nayak wrote:
> >> >> Karthik Nayak (2):
> >> >>   clang-format: re-adjust line break penalties
> >> >>   clang-format: align consecutive macro definitions
> >> >>
> >> >>  .clang-format | 16 ++++++++++------
> >> >>  1 file changed, 10 insertions(+), 6 deletions(-)
> >> >
> >> > Thanks, will queue. Are we ready to start merging this one down?
> >>
> >> I'd wait for some reviews :)
> >
> > OK. My impression was that the dust had more or less settled from
> > earlier rounds. But let's wait.
> >
> > Thanks,
> > Taylor
>
> I'd be happy if it merged down, I'll see if someone from GitLab can help
> with a review.

Having additional reviewer eyes is much appreciated. Let's err on the
side of that rather than rushing a topic if you don't feel that there is
consensus yet.

Thanks,
Taylor
