Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="abUXJViH"
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F9010C2
	for <git@vger.kernel.org>; Fri,  1 Dec 2023 12:02:24 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-77dd0756060so126637685a.1
        for <git@vger.kernel.org>; Fri, 01 Dec 2023 12:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701460943; x=1702065743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O4wSSbPkY4nkbAKwpzurqEESoQC7BsfaqCurIlMjSLc=;
        b=abUXJViH+dSO8DVDimuMfXND1jpe/KltgGMa8C8piJRexkruRvq+rHItdQx5/lnBjK
         rbX9rS8y6JqaX1aL++hVWEffmUsO2ZWwRSSddapDw45IcsuIDkOSNi6kGFNnhH0DMzO/
         48jU6E1hlJIG4e5tXoOhutT8TeZFetLGwkAa5sdZ0IEoS1IItRSuLWTlK0DJIsU5FlsJ
         1OgcgSj2uU+yWmYYJI1FiaDVQ4+2KBnqFwCHN6LPl4ZY2z4VANCR4eJtZ874O16whn8n
         5Vi9blCVp1vUedZRRSskcuuY49fmPY9yLEaRoUaCKFoIjgrb34+s6GiV3Rz5t+QcwOUQ
         oOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701460943; x=1702065743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4wSSbPkY4nkbAKwpzurqEESoQC7BsfaqCurIlMjSLc=;
        b=M3ZWTV867jemLigD23tp7ki4DCIvV3VwQa7mZJfhpSNN9pOB6nVLF444rAv1QmpIAp
         dBRGS6z5OP1+72B6O72ZVHwpT819i4jbwr5HtpTJG4JHp+vEHpEPfkBuwcclnDXzqw/M
         FjfF/F/6RaMQumpatdeCcKT+rCVvVA5WLp2CIUiFV2D/4/kJ5sAjg7vJ9E6jOi/IRuHD
         js7FUEIUXGou6b0wUSwHA6P49uZFdQKkd/OnSM0mbDF6wUMwOjlDj8OVuLeGkWcjOEom
         bXoFjEEl4q4DB+DbjgO0nb/xjh2df7DoI/r14d1syEkoWbp69jzYTznhxOUpeQYXwZAx
         No1g==
X-Gm-Message-State: AOJu0Yy5sitRAIAd5qkme9CrnZAFLruru2LtYASq75tAI0UcNJ/9Eq/Y
	qt6OksSEAWpJMOcsBO8D3DGWHQ==
X-Google-Smtp-Source: AGHT+IHT3cfYAaX6b+QBgB2OWCSlg5UCKRPdlW7fVg8+HGqvSazibAVbyGV2EefOsD5vYLxPnYCvpw==
X-Received: by 2002:a05:620a:10a7:b0:778:991f:2f78 with SMTP id h7-20020a05620a10a700b00778991f2f78mr65860qkk.38.1701460943418;
        Fri, 01 Dec 2023 12:02:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bk21-20020a05620a1a1500b00773fe8971bbsm1779819qkb.90.2023.12.01.12.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 12:02:23 -0800 (PST)
Date: Fri, 1 Dec 2023 15:02:22 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/24] pack-objects: multi-pack verbatim reuse
Message-ID: <ZWo7zjs+q8SZ5o1o@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <ZWhha2h2zzZWCXrw@tanuki>
 <ZWjk/TYzsrdHefgy@nand.local>
 <ZWmZ0pk6fr-8dmF1@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWmZ0pk6fr-8dmF1@tanuki>

On Fri, Dec 01, 2023 at 09:31:14AM +0100, Patrick Steinhardt wrote:
> > But
> > I still find it relatively unsatisfying for a couple of reasons:
> >
> >   - With the exception of the last group of patches, none of the earlier
> >     series enable any new, useful behavior on their own. IOW, if we just
> >     merged the first three series and then forgot about this topic, we
> >     wouldn't have done anything useful ;-).
>
> Well, sometimes I wish we'd buy more into the iterative style of working
> in the Git project, where it's fine to land patch series that only work
> into the direction of a specific topic but don't yet do anything
> interesting by themselves. The benefits would be both that individual
> pieces land faster while also ensuring that the review load is kept at
> bay.
>
> But there's of course also downsides to this, especially in an open
> source project like Git:

I tend to agree with the downsides you list. My biggest concern with
this series in particular is that we're trying to break down an
all-or-nothing change into smaller components. So if we landed four out
of the five of those series, it would be better to have landed none of
them, since the first four aren't really all that useful on their own.

I suppose if we're relatively confident that the last series will be
merged eventually, then that seems like less of a concern. But I'm not
sure that we're at that point yet.

> I wonder whether a compromise would be to continue sending complete
> patch series, but explicitly point out "break points" in your patch
> series. These break points could be an indicator to the maintainer that
> it's fine to merge everything up to it while still keeping out the
> remainder of the patch series.

I think that's a reasonable alternative. It does create a minor headache
for the maintainer[^1], though, so I'd like to avoid it if possible.

> >   - The fourth series (which actually implements multi-pack reuse) still
> >     remains the most complicated, and would likely be the most difficult
> >     to review. So I think you'd still have one difficult series to
> >     review, plus four other series which are slightly less difficult to
> >     review ;-).
>
> That's fine in my opinion, there's no surprise here that a complicated
> topic is demanding for both the author and the reviewer.

My preference is to avoid splitting the series if we can help it. But if
you feel strongly, or others feel similarly, I'm happy to take another
crack at breaking it up. Thanks for all of your review so far!

Thanks,
Taylor
