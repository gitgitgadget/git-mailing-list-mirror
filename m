Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448B82F2A
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732141446; cv=none; b=uTedOqoBGKwmORhs5J+G79Zpj8p8hs4175nUSEaH/C9ms03IAUNlDEmwCxes+6T+mRbZZCuOsGlYds2V44u6qMEbIWds1Nrfx1oY2bMubu91beI1uPJvjABlH6cdgrJPSy3rOvXLWUehf1/Uj/Dd2UdsOGEcg7swU4IaUphfccU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732141446; c=relaxed/simple;
	bh=RIq0f0YSwfQKBkG8wni057tYwlLMkwJIiFmfAa82WE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaOq5N9CewxoDePHCwuU9MZdzLeD1KwYVzlhYIH0xChlLOTMf6/fIIWxgDKKfoLe0Y31yo5S8yy59xunSqKrWHDUs2XhwuyJNCVz5iFZd4NcPXNiIiFoYIV4zmG145g2o2DOIddpUYot/pw4ecciwIcr6pmli449t+4RNCB/d7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=w99SDmga; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="w99SDmga"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6eeb2680092so2029117b3.1
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 14:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732141443; x=1732746243; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gD0wE1F3lEjJh+XIif2CypVST5odt2vOp42/GHr3QAA=;
        b=w99SDmga5pcUkVu2y4m2F7zGJvCBgtVYJYTsENKYea+FnFbqq2iGO4PuLd/Bu6MLgD
         Z6gQkCdpzDQttfDS18hEZUkg1a5Q7dsN3urRc1qhqyyOxoaFF46EWrQ2MfWqwKd1Cy4k
         Cn7f0HNAqKdGlTiYL3fpNXvpMYX3hTroRbDuJB5sq3VB8jYpOmlrKiYzraJnx1Qvr2SQ
         wmhkd2zszH6GzVABg594lAM8o4JcLc/cGt8qq25fNsO0Ve03Min4SXqPy1F9FxQohN01
         D/NHzr0sJFhIYWHwYj0SWOcWarkut240RD3iFlm8xZsopCFXmDobH7GpLt8v+oPsU2JB
         f6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732141443; x=1732746243;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gD0wE1F3lEjJh+XIif2CypVST5odt2vOp42/GHr3QAA=;
        b=j736dPkV1zzdR+xAt+Qa8ZBCb5o2wG/t9e7OJKtlDA8f6Tb3URA0Lv8QgN68apQiib
         QBGj4DCvwWWXweUkDkS2kK+mYitG709mnAU4ZmUupMDs3W7olYE1Tu5oZpGKmMTMr1Dd
         /JUYy1NwfaSPrA0vPkz8MIu/rS2VNTu1p30BOTXtQ/XxFf17kVC3nPxmqZEaHh+INO1v
         rIGRfJhKJDXGaU4iA4vNWPrQy0OMQ7wckaKxHaBz1Xjgj72+YfePbJZHSlTIjAIJP4xL
         6ky16QEqll7HgWupH302C5UPLpDKh/K2lJtLKKVsryVcV4fvC+tnafX3XuWqqW48kTGD
         j+FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBB6yALkqqjX5KeINkWq/LAKHL07l9jaesxN7sPD+trgVuXfcRC7ldbx0lXuDZ0JxtsVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3KLysOucrPYepwIn3HXMFR1Y8oAtt8ngj4m1PX5qiWG8jgWS2
	QqTTiHNT7sKDxn5fdnH2Azzv0cLXNAomxWXeDmtpv89Gt3TKZlC/Sq+PsBDQ6cg=
X-Gm-Gg: ASbGncsP/hAz0J7tRbV9+c3KkU3b/OttK9pxabPl/mL50QH8GF+7png5/2ORvf5KwD/
	Xpbp6rrrFQIlKAFfgDi4yHZahYu73GTwUC628exSRtF4RUGajzJu3vmxyp+SKErPTHNGWBZSkaW
	Fhcl26Ut+5TTB7cEo4KsSA7JaaiCLoBhf3Z0tkiNtbbW2g9KkQRbDxhH9j2ujkVA9PX48bocDLH
	zq7hvWBztTujFqwzrwDy/U8o5dtaYVAugH5okwDPPJecX8hdXr/H5z6+JXqfO1MP3UWLoW80Ap0
	YIxGyXneEgBWVCdoHWn/hg==
X-Google-Smtp-Source: AGHT+IGf01wNgyM4QQmmh2Io9ew3ZVrNfKpm7kLxKzAqpbDnUVo/i1oW2YjKv1t9wl3Em356YxfV5A==
X-Received: by 2002:a05:690c:4d43:b0:6d4:4a0c:fcf0 with SMTP id 00721157ae682-6eebd14af0amr46639517b3.20.1732141443286;
        Wed, 20 Nov 2024 14:24:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee71342667sm24391177b3.75.2024.11.20.14.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 14:24:02 -0800 (PST)
Date: Wed, 20 Nov 2024 17:24:01 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, ps@pks.im,
	shejialuo@gmail.com
Subject: Re: [PATCH v2 00/10] Change midx.c and midx-write.c to not use
 global variables
Message-ID: <Zz5hgZ1DM9XRdXqj@nand.local>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <CAP8UFD08qQ2hm98dKfMNEABs19Bbs_O6T6EMLpHOofQ9=A_WpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD08qQ2hm98dKfMNEABs19Bbs_O6T6EMLpHOofQ9=A_WpQ@mail.gmail.com>

On Wed, Nov 20, 2024 at 07:20:33PM +0100, Christian Couder wrote:
> On Tue, Nov 19, 2024 at 4:38 PM Karthik Nayak <karthik.188@gmail.com> wrote:
> >
> > Similar to the earlier patch series on cleaning up packfile.c and
> > removing usage of global variables [1], we change the midx.c and
> > midx-write.c files to no longer use global variables.
> >
> > This is done by the following:
> >   - Usage of repository variable already available in existing structs.
> >   - Passing down repository variable from other subsystems.
> >   - Modifying all subcommands to obtain repository variable from the
> >   command in `builtins/` and passing down the variable from there.
> >
> > The biggest change is in the first commit, wherein we modify all
> > subcommands to add the repository variable. Since the subcommand
> > definition are not often changed, it shouldn't cause too many conflicts
> > with in flight topics.
>
> Overall I like the way it's done. I found a few improvements that
> could be made to some commit messages though.

Same here!

Thanks,
Taylor
