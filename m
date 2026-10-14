Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8DB3BE162
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992334; cv=none; b=hII9sEhT5H34ASydwijhc7tSHgowwR2esh/ORW3emETVoV+YCR3U5oaZmkDCnyGy5pea7c3JsaKDWYQv0BKA4pPy7N8TnSPStTMvY0hV1jz1WG9kd9FdpbKdeF+w8EaVzh6s7ox3rZeLKqhWdLgpS9VeX30pH8R8dEIQ6waNnZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992334; c=relaxed/simple;
	bh=ptzK577H71vIeflNmi7qCLAOKp84jWQgHadT7rrxFNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+JSe9joSB//v9uFcVEchlyTrVS/bx3hv6wsBw/y6tsH8sxem53K7TdgcZywA7aXBC2oxhIpQvSCAJg58dq3iSuVAirGCwD8PCXk/crgHtcuJAH6o1yWafnKUP1akkpTlLH9NUdmoGs+OGh5ZXHnaITkQhEWe2BthHpLaSQKyUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK2Ky7sA; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK2Ky7sA"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-483a66818edso287922fac.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791992332; x=1792597132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GWQpLXOBjqAZY8n5gK7qljICNtfSg3HYbWW46d4Xiis=;
        b=kK2Ky7sAsSChW295Ved1UAy1r0ffSBtG2qnitqg0fZncNEkG8wudXAFussxuWGHh+2
         KSA+WdX5iBvs6/Hm0OFfOz7qkUx8hBn3zlAALaXfeY8Fb18TUXLVgTS8hxZACTAlb9iK
         iKtWYogpO3iQa/4cdVC1e4rV7bDg6y9LHkwWO8RCOUZX6umWe36cEpD2CnZQvQDRtIwX
         7yO4WRo9fkawHdQTxAUXhx9pEcZlw5ZRuMoHQ3mla0C9dyP37xkjYg5kTqYeez1rzYtI
         hmYMw6WrII9ZQnn4nHFDYgANvblkEvbfCueO/8PjGSOgX6AxLp8QJTKSGlVsM52xUA6b
         bnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791992332; x=1792597132;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GWQpLXOBjqAZY8n5gK7qljICNtfSg3HYbWW46d4Xiis=;
        b=DjRhv0CLZ8lD6JfadzQSWUxQkd1dfqiujytPHr+Y7IBub09XJnARZ86u3ENsjEGig8
         rdHR3tfSeax8JbIzRI35KPd7AYEIUo3hbEGD1L0e+R8pevwSeKWWCusQVtlqOYgOp8qe
         es6+xuaMKYHA98fJoYG1+hRPrzPS7EjVf0i1f4Ns9mLbTRDim6mfEzVAAK1IeXnnACex
         ZoWlqndGAbqLy6ZUGMoeHoUDkQLGrMrpFPKI9YlXs1Z8LzlXi6cr4qxHNv8Nzomr1PeU
         4ppGV5zaovxJzhWBUATI1xdeMDpj3F/Fo2J39es8UmyqkceFeivARojlvCzaQsS5ogM/
         V3ng==
X-Gm-Message-State: AFq9FYKay3P4SNz9p0y1rntGz94P4IjDrBcnCrPw+OIY7AbQY2fileOq
	bacD0JTgd55Y4hTT6Tvu6LweD/XtIEqHYmLpntP7KwORnvjB6Iacu6rc
X-Gm-Gg: AYBFou2Wu2dvMsqZYm4VwCbjDrbdMIJKwcErCqDzytHZKWQJvSL8+G4Appch3rPINzH
	CmiVaRNjdlbBJcUFBCZLIr0J2d+gvFoZwPje+m4o0/mf5dBp2+6vx6RwMqvdZsyl9mzkmMdMsNM
	X6uwyBR/BQYhKWOnJLmYKLD8tEt1rdZHPRoJNhDgnDl+Ef9Ga8H1wZ2BkuNa/S12l6QRcdwH0Le
	/P8YbZ1tjiZYKa6MgoMmPaWLZuhC7nxKgQfLIip4MeV5WyXJj4avQJnfCDEblCeoaZvzODxaChq
	C8yPzHPThaSf7nWwLpOd59u2+UseqORa9Yb7YG+AnEJL+eZUPf5zIXGSoDw0VUx1kJCMJzcgEfV
	qZBebM8hi2Uwsexcfc59BwMfFlIYFfeIb7DCZrJtgyEk1KpOZw/Syh0J+YJaEQSIxnS5tJ/fvKO
	RkkNk5iGDj0y5oy4l5L4UB+BPb/FHR01wOjmBUASK3sFa886sjrPJTecBU+zbPbA5eWr3RMEdvu
	QlKNeRpkhzc0vDWLERh6fhLsu/hPd8tMA==
X-Received: by 2002:a05:6871:28b:b0:465:2bde:8b5e with SMTP id 586e51a60fabf-4a2a86aece5mr14599118fac.1.1791992331861;
        Wed, 14 Oct 2026 08:38:51 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfc44a5csm2485318fac.12.2026.10.14.08.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:38:51 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:38:50 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Wolfgang Kritzinger <wkritzinger@atlassian.com>
Subject: Re: [PATCH 4/5] odb: remove read loop for found objects
Message-ID: <as-h25nkGNYVvea7@denethor>
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
 <20261013-pks-odb-files-alternates-cleanups-v1-4-b7030ff2b26f@pks.im>
 <as6kNufOqLFeBoNh@denethor>
 <as8niG1LrNqxfRzV@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as8niG1LrNqxfRzV@pks.im>

On 26/10/14 08:56AM, Patrick Steinhardt wrote:
> On Tue, Oct 13, 2026 at 04:48:23PM -0500, Justin Tobler wrote:
> > On 26/10/13 09:36AM, Patrick Steinhardt wrote:
> > > diff --git a/odb.c b/odb.c
> > > index 69a4c203bc..095183aec0 100644
> > > --- a/odb.c
> > > +++ b/odb.c
> > > @@ -265,7 +265,6 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
> > >  	struct strbuf corrupt_err = STRBUF_INIT;
> > >  	const struct object_id *real = oid;
> > >  	enum odb_read_status ret;
> > > -	int already_retried = 0;
> > >  	bool corrupt = false;
> > >  
> > >  	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
> > > @@ -277,38 +276,39 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
> > >  	if (!odb_source_read_object_info(odb->inmemory_objects, oid, oi, flags, NULL))
> > >  		return 0;
> > >  
> > > -	while (1) {
> > > +	ret = odb_source_read_object_info(odb->source, real, oi, flags,
> > > +					  &corrupt_err);
> > 
> > Here is try to read the object, the backend is responsible for handling
> > any retries internally that it cares about.
> > 
> > > +	if (!ret)
> > > +		goto out;
> > > +	if (ret != ODB_READ_NOT_FOUND)
> > > +		corrupt = true;
> > 
> > If the repsitory is correct, does it even make sense to continue to try
> > and fetch the missing object? I wonder if we should set `ret =
> > ODB_READ_ERROR` and `goto out`?
> 
> I think I tend to agree. I don't want to do it as part of this commit
> though, which is a plain refactoring that shouldn't change semantics.
> I'll add a commit on top though.

Ok, sounds good to me!

-Justin
