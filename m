Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A38A34677D
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768585670; cv=none; b=OFzMnd+z0UC6PvlKZqZvVNeSJCznWXH84/76pKaZg8vexkUp/k2SzcJJ95JKMcUNhSq97gG6l/S9LkdOOARWYjLs/vDsB1BMi8pZgJAXs6WrnUZdXbCcUoGVoUKotzoYM1+f2pgnReYo8kCTQzKwj3cYAL9iRwGjJB9K3oYMtOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768585670; c=relaxed/simple;
	bh=1xTFPY9IQPGPE9eyrA6sH6yYacy5Jns8Pz0eCyWoGmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KczTlCjAJ9wZqfklzvpsEeV7AvoDIDbM/TuD1qrdlpB24yOdmxcSzTTxzNdjr5dQCxpFnBsERZ+QlVAvtoFEsY6uR2EcgqfeXGRE1HdRsujMFvkfrE5TrlQ++JKhi/8a8/aRAP3RFjx9p5eKfGreZ6uO8avfW6tZ/9WBp1oQRHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMSuY1x/; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMSuY1x/"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7cfd53a8c31so1517532a34.1
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 09:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768585666; x=1769190466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n2iZl/Sjya+jVBlgdoas7dh6WkNBxcdeo1QEoQqsrnI=;
        b=DMSuY1x/tFFcsu0xfryPfawj4b+n69J/cYQ7LEEAMCQA+x4w7iJ+D0F88z5mTRX1WN
         xd4yCJbz8X4nU4NoDLk+wmyYG0eOkPrEFJUl+IZs5MprRGbCVkw4611IWCJoyYtO/AyF
         qVeFRxV5RZBNYBTCjeqhFvJ1q8P2bPF1cBHQvsm1SQ8M0HUBeVyUnOZW8Y1ps4AbM9u4
         xwePORnm6x9WTn+DISGDYkyODxNi6fuQvHbmPoI6mhH2pZMzj9jqDZwsGnzlo3GK7Ec1
         kYX66PYDFoNBWr5LfA+yNyUTeFkCh2E4hwmjfGhzJYmwvqu+Z4eIHRMI9aNi4eNI+5Yq
         w0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768585666; x=1769190466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2iZl/Sjya+jVBlgdoas7dh6WkNBxcdeo1QEoQqsrnI=;
        b=iMJTa8DZIHwk2XvyJRDdW5M9+Nd+Dd7fdJfT/j2Oy5IKttDaHvushM8G9AA9V0x0+o
         ke1pgu9CDrFYT/zrYXkCdrzOmkt0ZW1C+djy3ynbXjtb5cgtNLpY76Ve9zNxvNxeBpB5
         f56hWXFwFhX4zezZatVII0Mwfb11lIKVNFmNojH4rj/TtDLBbx8PMZtZmAc+nGhtttI+
         4flmXv+zBpM8geqGwWT6j+X58TNKUKmUf4KOt123VqqRCNQJT87MUVwDZoHnIDKDdKOr
         Hr9O1aICPOrliOCGWA1zQrSO7rKfCPo4PP6bxprEWtlxnoHI/Ji+zfE5HoFQ0BXrTYKs
         v1cw==
X-Gm-Message-State: AOJu0YzuUIPBGYvdrju91RglWfW8L4nopMYK6pdk75rZ7EgdUZR56obb
	k9Nri75Y+p4zkIEhn3DSsktmg6A7ecBfDcf5Yv4kdF6fyV5a9Z5GM9dR
X-Gm-Gg: AY/fxX7/TpkGuHSqrfYecFJbTCe85v+12zmeDSeVfBEvl7/5qn9/WZTwb3W27pXek6J
	m6Gjj2D+/v+CgaHxS9QzGuxO4+Q6kDspc+WZo77jvwgpRoRZ7vIMo9eAQrpQC6ANDT+KZmhiLRp
	GVLJ1ubrWZ1anOUCx0b78FBTAoRhzZW2rSJ3uWnodaavghWzXHxJRRqkxckyTGB6pbnv6edMWc1
	FLBHgqFMCahGwx2goUsMDghsJHN9fJvUrNA6SwF28u8UlkAQfgX+DR0PKZZR42xjbnItRzO2Od+
	UNUeB+uMJoCUciWkCrecCce46Sy+b6624gblsrimuE1iUBAHHrjzR2F5PBnFnZyzQWDYmcakttY
	M5OpcPzZS5qvw3UEP3gb6BVVR6UvY35RaZrmCrUASxdpqxhXUwTp3hlW4sOYNTgNj+Fk7B9BIuO
	6lyGsh
X-Received: by 2002:a05:6830:668b:b0:7c7:620:b1b4 with SMTP id 46e09a7af769-7cfdeb9b70dmr2066267a34.0.1768585666163;
        Fri, 16 Jan 2026 09:47:46 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf0f0137sm2034315a34.12.2026.01.16.09.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 09:47:45 -0800 (PST)
Date: Fri, 16 Jan 2026 11:47:45 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/14] treewide: drop uses of
 `for_each_{loose,packed}_object()`
Message-ID: <aWp5dToSXoqAqiT6@denethor>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
 <20260115-pks-odb-for-each-object-v1-10-5418a91d5d99@pks.im>
 <aWlemFAu9HwKgpOe@denethor>
 <aWniz5_-Q6o0tJXQ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWniz5_-Q6o0tJXQ@pks.im>

On 26/01/16 08:03AM, Patrick Steinhardt wrote:
> On Thu, Jan 15, 2026 at 03:44:50PM -0600, Justin Tobler wrote:
> > On 26/01/15 12:04PM, Patrick Steinhardt wrote:
> > > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > > index 6964a5a52c..7d16fbc1b8 100644
> > > --- a/builtin/cat-file.c
> > > +++ b/builtin/cat-file.c
> > > @@ -861,8 +871,14 @@ static void batch_each_object(struct batch_options *opt,
> > >  						&payload, flags);
> > >  		}
> > >  	} else {
> > > -		for_each_packed_object(the_repository, batch_one_object_packed,
> > > -				       &payload, flags);
> > > +		struct object_info oi = { 0 };
> > > +
> > > +		for (source = the_repository->objects->sources; source; source = source->next) {
> > > +			int ret = packfile_store_for_each_object(source->packfiles, &oi,
> > > +								 batch_one_object_oi, &payload, flags);
> > > +			if (ret)
> > > +				break;
> > > +		}
> > 
> > Huh, I was a bit surprised to see that we are still handling object
> > iteration in a backend specific banner here. I would assume ideally we
> > would want to transparently iterate across objects wherever possible. I
> > assume the reason here has something to do with how iteration is handled
> > with bitmaps?
> 
> Exactly. I was pondering a bit over whether or not I should invest a bit
> more time to also make this part here generic. But I felt like the patch
> series was already long enough, so I decided to not pursue this for now.
> 
> It's certainly something to iterate on in the future though.

Certainly not worth rerolling by itself, but it might be nice to explain
this in the commit message and/or comment. :)

-Justin
