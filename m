Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7851F80D1
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019996; cv=none; b=GX+ywe8ZsbfUFEUx4JaKpHyJQ/K8uHkziahP85Hs2EhXavWhdNZ036a3NiUzd+NxiPRor6ujUKShM8I3D0DPh7DKG71csyaEIuomwkqf4WC4IILUOEolTImLkFBTqRUxNnqCR/QLDjPLv1gf8kK/5dLFFiz05Y+dAwYfTsuCv1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019996; c=relaxed/simple;
	bh=4mVfY5v2LkVMIFbLS24snMdNlun3eV8YoyQlyBYtDv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASq7v5kC94dqdIm6EmIlOew6UsDvRrv/wzUA2ujHcNImBBdDHYllC4sPV2HgzEzrP9ZtlvnO6w2Q9zAmmYzYpawxg9Upr+rVdAnE4StQD036IbXtprXjkTkPk23YNjG9zFyB8sQTwtrEv5/aCMCoBY3lU0I1PQEdUJwWnKcfO6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=uq4icJgo; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="uq4icJgo"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cbe3e99680so28468506d6.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729019993; x=1729624793; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GgVIEFRk4mc3QVlIsAr/WWBPS/7HP8h0umZ/kvjSSj0=;
        b=uq4icJgokPyhCQJXsVG6Ixo/u+YJASWJ9+SPbsPBDO12iJ0Xe2XXIamtTMEKxdYOlw
         X+/tTyKhkcHcw+AOokwUzkmlzdFZ+2yf/vHHJj4XjsazgCVXueDzxU68+ZAP1IYxDQNM
         /bv3IRmUIk3iLxhcMVmnWaokqwPuCY35EF3cjpUYotO7FTSOQPR+vlLNmwsO85uBcB9O
         /Z4DstpZXFKWhjv0/SPr1wvYlvytk0KnYAwX+K/P+Y6H56JvytMigTNDubu6mxOZtOVw
         0OUUeOKmCFol+ovPivhEfmAWlke3klOTDYXwptRPKw1lGkods29HiBZlFIpZtco/M9jN
         sqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729019993; x=1729624793;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GgVIEFRk4mc3QVlIsAr/WWBPS/7HP8h0umZ/kvjSSj0=;
        b=BAY70KGmRmTAxlA49KjxIuC0JbYnmmPWV+N9QRMl+sLaFzOyQjxm1zLTOS/hSRBBYD
         7orU8nabs3xq7Wp8WwDrwB0Rq4/srbriA+OYD/bo0Sn0jmRo5RokrjWhNU3iIrAxQQHg
         YqFbUF5CBLqTRhSySKUSsZXqICOSBAR3Olql2tcQfXitiN4HERTJWJG9mR5odURd0YwP
         5W7yxBi3ivDZFw38kPHDZycNgiwDPF9sD8rvejQ2PgLCS76ok3L/fkPPYh3qj3oN5KoD
         fRIrktLf3972ctpd7jlZIOcu5ki4Lma3yAVNzQmEebtxmyGy2IScu1+1V8lISDMf7AYr
         sR/A==
X-Forwarded-Encrypted: i=1; AJvYcCUGB6MAGkul/ut/KEyw/6voga5NPpbgTReDhxmtsliTCODswKyXpWrOCjw6ncyAOrPiLm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAastd9wD5QEbIaFx2eRIPnxxlrdBWOvlvjxaLnXhvWXuX/1cp
	zIcoZH7sAFEkB7ZRcy2rp4yERfYMc7sBXHbYJbzkkd7oAou5bQPesHbQGx86IIbIlNkXDX3kWrz
	J
X-Google-Smtp-Source: AGHT+IGk7zF/8XL26DZLIoDHFFlV9KT7YludgqBmUkb5B7nvCEiBcQNdaFJ6l/SBjb+uxzfOe2oiPQ==
X-Received: by 2002:a05:6214:568e:b0:6cb:e4d3:91c5 with SMTP id 6a1803df08f44-6cc2b910281mr20689256d6.36.1729019993013;
        Tue, 15 Oct 2024 12:19:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0a68b4sm9856441cf.3.2024.10.15.12.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:19:52 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:19:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Subject: Re: [PATCH 00/13] Update versions of libcurl and Perl
Message-ID: <Zw7AVzBORjvxrvKh@nand.local>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241011074022.GC18010@coredump.intra.peff.net>
 <CAPig+cRmyZhq1qtomTFP7p7XMqrCP8-u7ah8D2+yUtrL880y7g@mail.gmail.com>
 <ZwmEDt7ftJabvMUH@tapette.crustytoothpaste.net>
 <CAPig+cS0vkTXeZX7qt6oOq3QpkWovfJnXuH7c3JtyAKOfnq1Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cS0vkTXeZX7qt6oOq3QpkWovfJnXuH7c3JtyAKOfnq1Ww@mail.gmail.com>

On Tue, Oct 15, 2024 at 02:13:45AM -0400, Eric Sunshine wrote:
> On Fri, Oct 11, 2024 at 4:01 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > On 2024-10-11 at 18:09:14, Eric Sunshine wrote:
> > > I may be in the minority here, but I'm fairly negative on this entire
> > > patch series. As you say, supporting these old versions is effectively
> > > zero-cost, so how does this project benefit from these changes which
> > > potentially "break" Git for users on older platforms? I see no upside
> > > here. The cover letter provides no strong justification for
> > > (potentially) inconveniencing people; the argument about being able to
> > > utilize more modern Perl features is weak[1] at best and is not
> > > convincing.
> >
> > It is not effectively zero cost.  When I want to write a patch, I must
> > make sure that it works on all the platforms we support, or my patch
> > will get reverted or not picked up.  That means I have to expend
> > additional effort when adding features to look through the supported
> > versions of our dependencies and either conditionally check them or skip
> > the feature.  Sometimes I have to rewrite that feature in a different
> > way, or ship a compatibility stub for a system that doesn't support it.
> >
> > I have actually spent a decent amount of work getting things to work
> > across older versions of software, both in Git and elsewhere.  The more
> > we honour the policy we have already made and agreed upon, the less work
> > Git developers have to do to support adding and maintaining these
> > features.
>
> This attitude feels backward to me. It says that simplifying life for
> Git developers ("the few") is of paramount importance and that Git
> developers shouldn't care about inflicting pain/difficulty upon Git
> users ("the many"). This is especially disturbing considering the size
> of the Git user base.
>
> Instead, for every proposed change to Git, we should be asking
> ourselves what possible positive and negative impacts the change will
> have on *users*, and if the negatives outweigh the positives, then the
> change should be considered with a very wary eye indeed.

I agree with Eric that we should first and foremost consider the
user-impact of any changes we make to Git.

I think in reality there must be a balance between the two. We should
make reasonable decisions when presented a trade-off between supporting
users and making the lives of Git developers easier. For instance, if
there is some change we could make which would involve a manageable
amount of additional effort, but would somehow benefit the lives of many
users (e.g., supporting more versions of a dependency, improving
performance, fixing a widespread bug, etc.), then we should do that
thing.

On the other hand, if we are bending over backwards as developers to
support a small portion of the user-base (e.g., by maintaining some
ancient version of a dependency that is no longer reasonable because we
can assume that 99.99% of users have a newer version), then we should
consider our options and investigate. What are the ongoing costs to
maintain that minimum version? What features are we missing? How many
users would be affected by dropping support for that version, etc.?

I am not entirely sure whether the jump that brian is proposing is
reasonable or not. The current minimum version of Perl, for example, is
from 2003, but the proposed new minimum is from 2017. While the new
version is certainly not new, I am not sure how many users would be
affected by dragging the minimum version forward by some 14 years.

> > Certainly we cannot force people to upgrade, but we also don't have to
> > support those people.  Git is an open-source project, and people are
> > welcome to make changes that they want to it without our approval, as
> > long as they comply with the license.
>
> Ditto what I said above about this attitude feeling backward.
>
> Moreover, as mentioned previously, it is not *this* project's
> responsibility to be forcing people to upgrade their insecure systems.

I do not think it is our responsibility to force people to upgrade their
systems. But OTOH we should not bend over backwards here either to
support ancient versions of dependencies when there are compelling
reasons *not* to use those versions.

I agree with your earlier comment that there is a balance between
thinking about this abstractly and applying it to the real world. But at
some point we have to throw our hands up and stop spending effort
supporting ancient/insecure versions of dependencies.

> > There's also discussion about adding Rust to Git.  Assuming we do that,
> > we're going to have to work with Rust's requirements for OSes, which
> > usually follow major supported distros (for Linux) or upstream's policy
> > (for the BSDs).  So we're going to have the same problem in that people
> > are actually going to have to upgrade to a supported OS, except it's
> > really not going to be optional because the code simply won't compile.
> > We might as well get used to doing that now.
>
> "Assuming we do that" is the key phrase.

Indeed. Let's not worry about it for now.

Thanks,
Taylor
