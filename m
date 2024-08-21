Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266EF1531F4
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244532; cv=none; b=tIdW4tonHIj2J+dv0TFQx0GOGBX81sljBTyy0Pc2oX7AFKRYBZbtlMtOALzUZuIQrJqT8ceiTQuw5JziCWS2Ca1tOp9lhouWPtYOaMi2uS7v/VBGX0F/nVryss47QwAmVgi+9FMMsLbEGCElkd/u9Dne89ynnpHvRhVngB3NzK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244532; c=relaxed/simple;
	bh=vZuO1PFK+unkBNN4KNjf1oFrcr/eeio8OEqVB+mZtfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gL36CsVJA2rj6z9CPIe6EkbH19sE9zY0ec6zCqnoJ+WD4aRvWhGqQYPcWzC1zcyoHymsxkRQQQvq0dcqaKWHxCL44SgFc20YwO7qgxTQq3pWYQmkpP2ruBZEpAY0ZgF/qnf4MzOTav450QwrTZ/H3QBhtRbTKb2RSVnaCSfTPy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3uS4LYM; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3uS4LYM"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db16b2c1d2so4593256b6e.2
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 05:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724244530; x=1724849330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GV8zJMmHU7msVTgP+UpRvFAkLbQQwR4bAaVCNlPktPU=;
        b=W3uS4LYMzRHF8jd5F9L4NAt8uqBG2Mvw55jfGfhRWy9QaAVFFBh0oWL0XK96IkYSNA
         /9JH3rjhjOlOp+s1lYqTiNCyogLMzAHV2LNUXnrK91zSuwzB3BJNFnO/xIZZz74bQP4q
         6k4yDKmJhz7alJLCZSCFXz2KgsWuagvwrAZ2BUVO6CUfsMY9kq0O2SI3B9Kei/r5lqp8
         vbK5AK+EWAL8TNHn15ZPdOibX0Xf5bQdJguDHuvXtqJ2nTL0a9OEzUjGTmwgoYia7TS1
         kN/GnjqT2XxYFH3MvTCKEYVjmVq9Y8e/710XP7Puwd0n7329odiCf4XF+3bL76upgCYR
         BtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244530; x=1724849330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GV8zJMmHU7msVTgP+UpRvFAkLbQQwR4bAaVCNlPktPU=;
        b=HenQAKbfAeFvmgtaYd6xKlXLZP4Ko0y9I4FTCHkKSQRBrI7hp7jChrynjuk7IwIiQ8
         4W+IdxnGC7IkPiq8FRZ9rSlpr7aMDG4mfAi5bqgCfDzWvVhDHO+ZmN50cFqX0MTAg0UE
         WwGicSH/pPdBXKW8MXCoPopW1s2nfwcnjIC+OugX2sYYkmx5r43VwSYPwIX22TcP6Fad
         R0pqVjvHmKrb3PRJsYTDLuAyn/3FYmvRWTWfxqMnvUNSPIA+OY/3vdcCIEnDkYEmfgIG
         upwcpWaUbL7tfkMRtIdxXTI4ShGfSkedZcjCeidIn9jFeuGtjUnEFIJxxTwqj976gRB2
         Jy/Q==
X-Gm-Message-State: AOJu0YzYoiD+ntZjTW11lKdPm240dkuukHSEf7WSZJcytL/NSZY5CnKr
	Tx568rY4rUx8pjsQzGJ3XrGmzHHgMZDx7nJYCkkbQ3oA6XRq1x4q
X-Google-Smtp-Source: AGHT+IF7ibiPHzAE6UIDyvGDreRj/pvDzFtO2eBbcLvh9pW2xZMuWo+7l1xUgMTzIXP/aJNysouruw==
X-Received: by 2002:a05:6808:1a16:b0:3da:ab89:a7d2 with SMTP id 5614622812f47-3de195141fbmr3013689b6e.21.1724244530072;
        Wed, 21 Aug 2024 05:48:50 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7142fc59823sm68457b3a.105.2024.08.21.05.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:48:49 -0700 (PDT)
Date: Wed, 21 Aug 2024 20:49:34 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v1 1/4] fsck: introduce "FSCK_REF_REPORT_DEFAULT" macro
Message-ID: <ZsXiXi4Nt1eSKLad@ArchLinux>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
 <ZsIM0L72bei9Fudt@ArchLinux>
 <xmqq4j7fb1pn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4j7fb1pn.fsf@gitster.g>

On Tue, Aug 20, 2024 at 09:25:56AM -0700, Junio C Hamano wrote:
> >  	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
> > -		struct fsck_ref_report report = { .path = NULL };
> > +		struct fsck_ref_report report = FSCK_REF_REPORT_DEFAULT;
> 
> ... the code without this patch is already doing so.
> 
> When designated initializers are used to initialize a struct, all
> members that are not initialized explicitly are implicitly
> initialized the same as for objects that have static storage
> duration (meaning: pointers are initialized to NULL, arithmetics are
> initialized to zero).
> 
> So I do not quite see why this change is needed.  By hiding the fact
> that the "report" structure is zero-initialized behind the macro, it
> makes it less obvious that we are clearing everything.
> 
> If the patch were to rewrite the above like so:
> 
> 		struct fsck_ref_report report = { 0 }
> 
> it would make it even more clear that everything is zero
> initialized, and also makes it obvious that .path member is not any
> special.
> 

Yes, I should use this way. Thanks.

> Thanks.
