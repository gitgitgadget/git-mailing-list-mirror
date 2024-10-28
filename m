Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1A18E05D
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145033; cv=none; b=tvAH/1oW2K/c9CMfNOic4SrKMo/jtVUJdVIKSvAuqswx1Ne0/D2ggIDQh41ptjSBF9q1eqApN1j9bDschGfF+cKsJ7l8uydgBoSnJ6ZJmMVM39eeNW2P9dLnK3EkskBJve+zOD343LtQ5W1uQTb2wwGqYaalskwRC9OXHi3KPdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145033; c=relaxed/simple;
	bh=ThO9PbR3zluAJydLPWwU29JVMA62rL1NTo6f2n1D5uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6d6Lsk/+Ij/Zmhq8dQJIMzjlTdVvqF3LgsioOSCfUy1TVvepdi7gQziPOMDtEmLzTLH8ouV5z68srjR4+SBrEMa8Kjs1cfQzYB/Lc7VXSZyPQNGjffGZV3FIjRzgrRgyJgtdSdWmYgX1JuQtEOmoO7gn9Y6eZXSjYjP5o8RKs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ZDo88gSU; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZDo88gSU"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e29218d34f8so3568301276.1
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 12:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730145030; x=1730749830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ThO9PbR3zluAJydLPWwU29JVMA62rL1NTo6f2n1D5uA=;
        b=ZDo88gSUfNmzkPFEeJhS4LJRwR5CJi9YXnjBVlvgs0KBeetOzyM02VFPezLyEL3aUM
         z5XWxUC3wg02P1jwdCqTpeI2FJhuSStNt7ugngcLvcLvv0WsxoXPUZ5X8HD1DjwvLKPu
         kn2WwU5zF8cShcu6paeLLKva9DaetFSN22j7ayQviWPhhNzGTE61uy9A9pHWdLd6EdQ2
         6oZmbvqk7/KWebLMo7Xrd9UycaeO44Pzu+dG0xz3duAkgSZJdF4q2YJfuOMoggG1pxuL
         lun6SRtmZ/y3o/Ytfni910vTfsVd1zAh8vcLS0iefzNnhGvZGWLsIh18ITiuZIL2odm6
         fTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730145030; x=1730749830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThO9PbR3zluAJydLPWwU29JVMA62rL1NTo6f2n1D5uA=;
        b=bfxi/UpplhxOVGrY4Kywz1mMedFJJ0v56FaQbVpVuViTt+DWi0rfWSxNzpKgaylQsU
         OuwEQVD5xLTT8lSEBYq/jsFW/tPJWYWGtdxDvQegDf8rvlMjh+TIlJhDUk01ensQadr8
         c+AEWzI5sYeRVYQbybPgO/QMVcdTWBYLhaysTLSF28rCuTRLQ/aLq7AbTCVmRx5dEIeS
         eMmc/ubp0JzViYuESCRLBiouzyJWlznh1AmEc+1K04ZvIpORsl8AY33efBhWZbRqRA3x
         VRs1fAMriQCPmo0hEJIg26+tr54/kBdSk8kTHb3UkNrjxnFuF6c7NCTPAcKXhoAKWMJG
         xGOg==
X-Gm-Message-State: AOJu0YzpJm/xNk+092CeRyIiIEto7KFVE3BsPhRjhKMRL1CORJTSBrB2
	P1tQmDYbBGvghUqS2ULl38eqDo/psl7sowUKRHkql/vfYxu4Y0BzTHuCRTy+4Qk=
X-Google-Smtp-Source: AGHT+IGKVIGkfJgxwyyMKxVN3IQjwFANUeVskImcx43SYRi7BGbTkwQz9Ja/zbNHhpFl1gIV47bPYQ==
X-Received: by 2002:a05:6902:2113:b0:e2e:2cf4:3eba with SMTP id 3f1490d57ef6-e30bc6a43eemr851529276.27.1730145029918;
        Mon, 28 Oct 2024 12:50:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e307a03bf31sm1460149276.58.2024.10.28.12.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 12:50:29 -0700 (PDT)
Date: Mon, 28 Oct 2024 15:50:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org, calvinwan@google.com, hanyang.tony@bytedance.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/5] pack-objects: make variable non-static
Message-ID: <Zx/q/HztQRT4eLMQ@nand.local>
References: <Zx7bEq5DVG4CmokI@nand.local>
 <20241028193409.3648734-1-jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028193409.3648734-1-jonathantanmy@google.com>

On Mon, Oct 28, 2024 at 12:34:09PM -0700, Jonathan Tan wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > This patch appears to conflict with ds/path-walk, which wants to read
> > the exclude_promisor_objects variable from outside of cmd_pack_objects()
> > (but elsewhere within the builtin/pack-objects.c compilation unit).
> >
> > Is this refactoring a necessary step, or just cleanup? If the former, it
> > may be good for you and Stolee (CC'd) to work together to figure out how
> > to eliminate the conflict from your two series. If the latter, it may be
> > worth dropping this patch.
> >
> > Thanks,
> > Taylor
>
> It's just cleanup. I've dropped this patch in my local copy but will
> wait for reviews before sending the next one (probably not worth sending
> it now since it's a relatively trivial change).
>
> I've also looked briefly at ds/path-walk - will reply with a few
> comments on that email thread.

Great, thanks on both.

Thanks,
Taylor

P.S.: it's good to see you back on the list again :-).
