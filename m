Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B2978283
	for <git@vger.kernel.org>; Mon, 13 May 2024 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629632; cv=none; b=KU5+EEEZoUooLI2bXIJhR1mHvrb36wVnFMKosq/soVZB/sOsI2/AmW3EERsF5tUm4FTWHg0KypzSnznUZlisuytfUxM1PAqmNoueGF5W4RHJfuUuknSTkHg4r+p6yoZdmlc/NOkUUTVJXv18Pe4AfNvdNaoXiTWUbKrkIpiCAjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629632; c=relaxed/simple;
	bh=IfJmXldN4kzvHKKOIU0rgUElt9/0IEBEWiVZ1oCu9YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbaM/U7nuaanv1qMMTxf+3wN9t98oByKljuXDslqLo2MUjqtejDxE6WRNrfiaNDSGD4UBE8Ds9qVUp0qaV9fNQqaeZ+FXhV+iujtzETPoHtsU+1Mx9bkmKEY56dj42NG5nT9db1ZOfYi6l80K0tRcdceUKF8FO7a/AyR4shg2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=iFcZekx7; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="iFcZekx7"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61bee45d035so49357717b3.1
        for <git@vger.kernel.org>; Mon, 13 May 2024 12:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715629630; x=1716234430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T99MBf0nl63CklueBJ6l+rwD6AWoXckiL5U/kn0dPCw=;
        b=iFcZekx7KgIShZipR9NXwTDP0cFnLoy+NjnE2QnS9DQVsdYskA7yC1UyQ0FBPUNBsX
         8L8o2D9G0Y8fMk3fY8YPI8fTcqdGMi/6fmPa0kDdQ82D1FgC7SZQPMZv5IALFwm/dchR
         kniudPCukHfYqSLGjQmblmXJG5cvdapFFQTFLTd1P07OH1pxfLeB+mloLaTMNuSFce+d
         eJm3w+qm167Ff+DJyGAKJA3Hff0C2Cmt5wcVoumpLWva1BnwkOWdT7hq61+NRXdEf9zl
         LbVzBDrBQxuoAl0fi5rx5gbg0+3bx83+qj4OHNkJ+JzT4iu4POuN+a95s/QbWxTQf5yQ
         rFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629630; x=1716234430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T99MBf0nl63CklueBJ6l+rwD6AWoXckiL5U/kn0dPCw=;
        b=hcW2P9nc+qpFD8/CBHeidUtSv2NHjUj9vfphW9LTt9eo2IJNin8K3M6V0UdJtOOg5C
         9GoY381A2cb+KUApDhs7wK3/Xcczn2Ho2azXPSPqrlx3J1OabL4OlfRWMuze6HxsbMol
         zfPyBemoOz3dulUetHgG1ZAz6L96cDAQGCacYSRQKWmivH3OzKa315RuhqE62QKrOAit
         /L/iAKignkwR5qaq7Qg1Smhx0zFd5wQejo3slko3+LdKbu2gvPZuGIDiuA6P4+Ey/8rY
         bMh01nZ2BMFgPJtnHcpiohrT/4jgxpOiDeTpeutBXQFJ5T4MuM8NW3auTq9iXzbo7ZXx
         wk3g==
X-Gm-Message-State: AOJu0YxHExfBOfSQm94u4PZolHMi22YURYopRoojxZWYsxtb9BsXhI9m
	neehDycVtqZmKJmg4HejD73GbKLt2VjdCKblzFdYLrFUEPq9GR5FXA5cbKsfkb0=
X-Google-Smtp-Source: AGHT+IGKyK+V+1qFO0T4yEi60l7fLUT4zXe0BXgVOkxdLZrY/pEwvPOf0a74+YD2f8neIWRtFBX1Mw==
X-Received: by 2002:a81:9149:0:b0:61b:418:139 with SMTP id 00721157ae682-622afff635bmr95154677b3.27.1715629629890;
        Mon, 13 May 2024 12:47:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e12b42801sm23250861cf.55.2024.05.13.12.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:47:09 -0700 (PDT)
Date: Mon, 13 May 2024 15:47:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/23] Documentation/technical: describe pseudo-merge
 bitmaps format
Message-ID: <ZkJuNSWLRcPjPT6S@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <43fd5e3597151a86254e18e08ffd8cadbcb6e4f0.1714422410.git.me@ttaylorr.com>
 <ZjjEjNRp2BAMWJ47@tanuki>
 <ZjkHT9XVl7ua8E14@nand.local>
 <Zj4JM3ATSMice5do@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zj4JM3ATSMice5do@tanuki>

On Fri, May 10, 2024 at 01:46:59PM +0200, Patrick Steinhardt wrote:
> > > > +* An (optional) extended lookup table (written if and only if there is
> > > > +  at least one commit which appears in more than one pseudo-merge).
> > > > +  There are as many entries as commits which appear in multiple
> > > > +  pseudo-merges. Each entry contains the following:
> > > > +
> > > > +  ** `N`, a 4-byte unsigned value equal to the number of pseudo-merges
> > > > +     which contain a given commit.
> > >
> > > How exactly is the given commit identified? Or in other words, given an
> > > entry in the lookup table here, how do I figure out what commit it
> > > belongs to?
> >
> > They aren't identified within this section. The extended lookup table is
> > indexed into via the lookup table with an offset that is stored in the
> > `offset` field when the MSB is set.
>
> Okay. Would this explanation be a good addition to the document?

I think we already have this written down in the section above. See in
the previous bullet point the section reading "containing either one of
two possible offsets, deepening on whether or not the most-significant
bit is set: [...]"

Does that work?

Thanks,
Taylor
