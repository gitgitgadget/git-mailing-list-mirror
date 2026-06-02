Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD23E6DF4
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413888; cv=none; b=g7n3HtSRA/J9pll98GRmmZ8VW7ILbiMkl35fPMM7Za3g8J41m0SQfOhvdwfEFnqeByAmYElGB1TZEpOWRnDuIB9bC8HLVrBxMWeQ5xOFZjmNVHCTq4LjWYofGsrabw4Sz6cUltKiEl+2bmtbmkpdPcO6Gw0hipyYEUkKOLWzbj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413888; c=relaxed/simple;
	bh=Mf405nyeS2frNgLbVuBr7m3BM9YfNhKVx/IrofrDn60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIKZaN/j3E7Pd2WZz52DdzzyQ4RZui/qllJb1O6m+M+8Z8kNrCOZ7rYSDE+QyfCU6NU2fz0GEwzs3l2181Dl0xW4J+5UPQeizogFuc6DkNl+8O34hbEFM5qt40ULawrX9VCQCEun6c1esLJsIfgo1PrSoTB92UCJxqKI2wC+RyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkmyCHQh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkmyCHQh"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45eee266c6cso4062774f8f.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780413885; x=1781018685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TQOBdPvxn2LTwo3CeCYha6DJCRjAoCSLp4wrgAlUYkY=;
        b=mkmyCHQhVO9tfzA7h5bEu1/WfmjDvTX17mQHuR+aoptRrpkn4Gj7aMkZCfFxMLDPbm
         9Wy75D3LER4YjDNxDxpu1zXwWgHgAJ1/e0PRM35QinbGEQXij8kxSwqSm9qqO0N/9vW6
         UyQd+rimFHydAm/4XQD8N9aFLxA3I3SKKbtWFL24xhhPDc25DrqSJQd6IyxD/OkmgI9a
         ojbOFGmO2mwebr1PiouDlFwOI05L2CzVHGYAEzJZbG4QU4rVfEk3vOzKNBqra0KjPn7f
         Wt84pasYt31h3SWq/RYl4euc5zec81yJ346+J03eS1ULRegsm/TDtaZNisu0c/bQ01th
         O6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413885; x=1781018685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQOBdPvxn2LTwo3CeCYha6DJCRjAoCSLp4wrgAlUYkY=;
        b=ikl526Ie/PCwA9ii1TO9eUVkWFIrsz/mqc0Y7z2vIcALgqCBLThLl/PSFZnw5ypxr4
         acv6drFwbm/Ut0dMAftj3l+aX3Nlxew3z7xvl764cTuy69ccmdO7lzc2en0Rv9eYjgCe
         bVb1B3Er/NRNUMb0RqUquzwLRLwtpB8xKevBzopvaP5uePD/9EGzdpVWoVQ9MC6lPGm2
         8ExjtiaL8msOXQJZeXG1YKrDK7RlAK2LqBBktiaJJ1FRLhiRWBAI5z43AC1O1FAAOXhK
         1A1EOSufpUtzvoI7Ye4ZE7Opj6i2D9VAOgfO+qGrN9Bb1U0dZDE0jyK8rFhzZ+VxTG6s
         O3NA==
X-Forwarded-Encrypted: i=1; AFNElJ94abJ9ApoE1XgDYTpJn3USY6+lDK0d5lRrYaKW/dKBMab1WVOjG+8fkTHynYg+y8GQmY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuksQ0N4D+8k3AzZwf3h9MOv0JcQuVHGINgWVy9j0wOS8KNLV7
	UBJS3LngmF/QmUAg0HqGg0p9CdxwIr/xbF95JGuPQxRSciA2Hq30+CXu
X-Gm-Gg: Acq92OGGJKf9gDQP8LlfGDnPs4g1TKbsgI2XT7MH3+NHvUhHs3CYRzjVYIxNqHrUAWD
	3+T7cHo3eC9slmQ10GgTI84GUEJiDjQq7/iC8wDyiLSgsbhzS5nNtENPjRXOIQJn9YzmDbQAu5j
	TY8yiu7qr4MAJsrP3JqXTaMXMeW2chXPxk3ZMbrkdnfGLE05SUbmGHmG28ww5tOyaHEZgT8iU+v
	oWzdjV3YHLzY9SgmcYONYmRorcxFaTSxz3uNDNey5fHTBBJ5NN85lEOqV4pi2mrUthY0QdfnTiw
	nIe/ezX5jRZTh/w9Rn2FkY1ztNWd6Uo9pR/iShj5Vax+bh0uJXcQDl3qXnAd9xRkQCBF5/fFnYp
	MqRDHI6jsvHuUvMA7Vq5xMLj11kTeHVkqsmbkS2vbP8V1D9QC4GBXRqGhx4SbCnLKKS53iylso/
	SSl4hegFjsXmCM3LG1W44fz2b3S+aCbKL2AY+/4fvK/h0r5EwBKzLN/yeni+ro
X-Received: by 2002:a05:6000:18ab:b0:460:c9f:8747 with SMTP id ffacd0b85a97d-4600c9f897fmr21729490f8f.33.1780413885144;
        Tue, 02 Jun 2026 08:24:45 -0700 (PDT)
Received: from localhost (62-165-238-1.pool.digikabel.hu. [62.165.238.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc412sm39098f8f.4.2026.06.02.08.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 08:24:44 -0700 (PDT)
Date: Tue, 2 Jun 2026 17:24:43 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/init-db: deprecate alias for git-init(1)
Message-ID: <ah71u8f8L/uN7O1Q@szeder.dev>
References: <20260601-pks-deprecate-git-init-db-v1-2-ea3e6eebe674@pks.im>
 <276a92ac-b2cb-4a89-96d0-9071ab6200be@app.fastmail.com>
 <ah12uk7IFxS92OR1@pks.im>
 <042e66b5-122b-4c86-a9a9-f75f763666a7@gmail.com>
 <ah2VL-ftCQelNoOc@pks.im>
 <2e266786-4ccd-4300-9b53-6f13fbaa2933@app.fastmail.com>
 <xmqqcxy93nph.fsf@gitster.g>
 <ah58IJ8DgSZYRjMM@pks.im>
 <xmqqv7c1xs76.fsf@gitster.g>
 <ah7N5bKAiAORtNkp@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ah7N5bKAiAORtNkp@pks.im>

On Tue, Jun 02, 2026 at 02:34:45PM +0200, Patrick Steinhardt wrote:
> On Tue, Jun 02, 2026 at 05:27:41PM +0900, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > > I wouldn't mind that outcome much, either. What triggered this series is
> > > that I'm always annoyed that it's "builtin/init-db.c" instead of
> > > "builtin/init.c", and the same for `cmd_init_db()`. But I intentionally
> > > constructed the series in a way that the first commit can be picked
> > > as-is, so that we can adjust our code to the modern world while not
> > > doing the deprecation dance.
> > >
> > > So I'd be equally happy if we just drop the second commit in this
> > > series.
> > 
> > I'd actually find myself annoyed by such a rename when looking for
> > builtin/init-db.c only to find it gone---much like how a previous
> > rename made ll-merge difficult to locate.
> > 
> > My point is that while static names may annoy some, renaming them
> > does not resolve the annoyance; it merely shifts it to someone else.
> > 
> > So, if the primary motivation is just the first patch, I would be
> > less inclined to support this series.
> 
> That's entirely fair. My take on this is a bit different, as I think
> it's beneficial to accept a short-term adjustment for core contributors
> in favor of making stuff easier to discover/maintain going forward.

That's not a short-term adjustment, but it will be an ongoing
annoyance, because 'git log builtin/init.c' will cut off at the rename
barrier.

