Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82DA1990C8
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547337; cv=none; b=O0173NELbgENHl8CDxCVJjRKF26sceNHgVdoiVpUzyGVQ55LkjhrgB4wFejBktn9+yKu0BJfn/LjSctuy674QLFHMwfbQNDxirvMTZOIIpFQ4XeXEYfukStw95qbLT9GJUffvyov8X8y1QZ0zPZfs9ITIwu6FsyZhc9eLjvoE0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547337; c=relaxed/simple;
	bh=iKRiJaZvhkPVQSZtsY9LRc894FKv+ndp+FWwqyaQv+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLFfZIlXZBT0crACmolF3/D9Me9U2KKzYs13Gtn6zRn/1LFhYliQFcEUhpCk5GURSgLZXOKrmHEU59Putz+/WbtN5nIpDYJ1VlZJCS5Nj1pHDnXPK+pEg79wqj2yhGAx5TfLzmDd75frNbLKlCvkZiSo8I5WRyNzdDRLnCWDY8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=YpOdYkSC; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="YpOdYkSC"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso4504507276.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729547334; x=1730152134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q6Kf4RdMLH4z3zwJ3grdkVvBh/f7yehD6UVkxOFCmPw=;
        b=YpOdYkSC5uJR4BWyCXdjZSaKQC5sbIgNNf4La2RVF8oXiEew4KYsw5FVZlCa/smA6Q
         Fyxph9CBEsfV0hB0IEeCKmeYshgF5CRtDax4ukMImkLNwKjoZDuVOmAOoTWGhXaX3Y66
         a05S00ROkERwSbcMRoiPFsdx/4/OEUnIoJC5PylE/NyLqTvu13g+AotY23sAOUQO8gr3
         PndMsw656MLIYbVVBqogm7bivbKb9yRZogMbg1y97OjxXot4bVB60PzKPRUl62w+Zp5+
         LGmxxK4cSMq7bxP3H0hRCuq7kECaRUnx4LGpcWx5g5Jch+aVrWJzPIJ0kzK6psYA8xwo
         8GKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729547334; x=1730152134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6Kf4RdMLH4z3zwJ3grdkVvBh/f7yehD6UVkxOFCmPw=;
        b=M7wHjsoxYQBjKjynis6puwMyp1uBkuuCujZtEsX4yW9nJImky3sN+hkPH1gyKWLMq1
         2lk5sE6/5J7D73pcal3/43IwR1/M0TYKsJT/xQVHBt1CZT7pn3ktBvIrqdbjdEnh3QKS
         jckgJnHg+NdKI7T9znMRdlgnleD6L0ZVq8uU6zByHrBfKUJXNgblxyFCWLcMpruzmWyV
         hBpahEADVu6HZCQGehTSJYWJ7bkb2XpP80+k6ImmJrc4Mc+eWdxzAvVTEhauS4tb1BhH
         SwxW6m3Tb7gP7+sV/o5aW7xKOQ15whNvOUegwiJnFrWlQZ3fv75L8kLAiSHNCmwtoEIf
         YFZg==
X-Gm-Message-State: AOJu0Yymsle19uXcGle74UI9IiNxp40aRN66kbT4fy+N/9Oxm+DpmVd1
	cESlMSfOVBfZ7278mTZJ7cboOh9zfPSduqxskLWlPNJdKnlVfU56OXr39ImnB6k=
X-Google-Smtp-Source: AGHT+IEgwbbDO+l3Y4VPWFaIVL1YfQlIvxI69cGw8WHR5cphcBomzugBucCxrqknHtshDqcCTAwCkQ==
X-Received: by 2002:a05:6902:2602:b0:e2b:be10:edc9 with SMTP id 3f1490d57ef6-e2e2717c0a3mr415344276.22.1729547333768;
        Mon, 21 Oct 2024 14:48:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdc98f25esm816824276.15.2024.10.21.14.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:48:53 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:48:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, toon@iotcl.com,
	spectral@google.com
Subject: Re: [PATCH v4 0/2] Subject: clang-format: fix rules to make the CI
 job cleaner
Message-ID: <ZxbMRACNtMfPiWr2@nand.local>
References: <CAOLa=ZRvFBhageS65uE5enzLBz7H_CAvvnEcPsi_QAi0exRx2w@mail.gmail.com>
 <cover.1729241030.git.karthik.188@gmail.com>
 <ZxLVLiiEEj2A5Iws@nand.local>
 <CAOLa=ZSCenJLOg1jF==_uNGJ7GZdLiNd6GB_JO4XyXMdLNT65g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSCenJLOg1jF==_uNGJ7GZdLiNd6GB_JO4XyXMdLNT65g@mail.gmail.com>

On Sun, Oct 20, 2024 at 06:17:58AM -0500, karthik nayak wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Fri, Oct 18, 2024 at 10:46:44AM +0200, Karthik Nayak wrote:
> >> Karthik Nayak (2):
> >>   clang-format: re-adjust line break penalties
> >>   clang-format: align consecutive macro definitions
> >>
> >>  .clang-format | 16 ++++++++++------
> >>  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > Thanks, will queue. Are we ready to start merging this one down?
>
> I'd wait for some reviews :)

OK. My impression was that the dust had more or less settled from
earlier rounds. But let's wait.

Thanks,
Taylor
