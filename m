Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB131E230E
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772519581; cv=none; b=t2/3103VSwIoa/ZBY4aj61hyIbfu1rkgKH9M61TkNJoCCy7lsROoYYFxlwhW9LYndPIs65dkki013Z4MR2OOQD5J9VsPqTNW7aRaLH4+SGhlJwF53O1fMT/+tfRcI1KHpBIdC2TMSBMtrjurtl81lmRP4CsRuXqPgr5DSxaZeVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772519581; c=relaxed/simple;
	bh=kYfsePhoRmZDEkQDB2LmXD/jkWr4CCtgBx3Wtus7UPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4XPgOA3cEIReWkRYJivqw27xXUii10sFXucRfmIjQS/HjnZEglsmvGZb9A/X/jfqYBeA7XmwW6QURdjkEF8RxMj7L8LDvA4Kr+lYYEiiIrEjW2PuRRcVTx8o/Vd6AT7OkIOIlMvMaW4OhkK79Fu0680AFpxO9noIXr5SxqQMTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzxK4Wrp; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzxK4Wrp"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40427db1300so392416fac.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 22:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772519579; x=1773124379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bgmJKvHwBU76Ic6gBjr+8ofemKksWFwFV2HtfAExN0A=;
        b=IzxK4WrpVWXKDAbbJ4WEzwo9p/wABJoW3X4aWlzKZ7vMtxLkOHlpJL8nmf51+/fWZK
         aoDA2XSLrSU3G9M4e6EM836SaTtyI22RsX3FdJZQEQB3W0Fddz5IqGXY7OM8wuDWFGyr
         TSIwTBTRnhS0W0UuZkQrk/TWn/Li3gA3vuZol7uaqE0mSAsK/QRpckJ6HrCIfYu9waK6
         vIiX/tx+1ebWIka6j70Ue4aLvIpvPME4CpfOH6ko+yKdyjjT8+JQD+JDP9LP7Mj5vDC0
         ob547lkhFjAWFudYc0MqJonMbJiyFIn/lUyIvlmwfNTgCbfLOh6hTPtJD5AflqZfMY7k
         NPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772519579; x=1773124379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgmJKvHwBU76Ic6gBjr+8ofemKksWFwFV2HtfAExN0A=;
        b=a37HQ+cvq635gWIebx+EF/MYa0UC/bWcOoAZ5iQae+ssOWbYXxCFF0emvPdUlV7jcS
         BJdMHV57FJ4f4j0wq1tq8kaTtqa6hkfPTVqjSmI+Nv8hW5psug2U7ksoLAd3bgVSqsDQ
         pKpMdtHwZdv4HkBNrfqeGUhX0o3kOFGT5HelDjHuuvBKMZovdgfkGxuJU8mWW1iXs367
         68ZXzYFlF5Dgr7iLaqe83VoSoE6BNGRUtqXi0KUozXA0r1+rrzVfFkJxUFgjfidpwTpZ
         qWFYlyfAOUFVNKoQ9tGHf7U77iUXMfSXessxK/u0VafJOe5RmDnB/swIgf8fGFhUp0LM
         Kklg==
X-Gm-Message-State: AOJu0Ywey/ieAZUuIa7+LHbkwJglcBs3ElA3+sgwW+KzCt86QpDoKi3G
	plUWuX+c5rJ+dza0ox+fCNZWYv6I4gp/w9Iu9d2H/ttYoyCeya1D55CndemX/Q==
X-Gm-Gg: ATEYQzxWFnSqnJJx5ZSQhYcmU9qFcLWc1cVd2h0/VhJ1KPdELVquHJS+Yk3le9qucVn
	N4MlzvWBz+EZrWiB8xB05er6+EbxwORwz1upY3Cg9CLsSjDlGQHTC3PxQ5VQkqdo7m8NW882Hig
	N5Obc3QulTr20GsUW0sxOdAp5fUY1UAv66PLVNs778gYTqMrSEavf9LUKuP5bQLq9XKoHkTFOX5
	QCK5Qrkp5CLyy3VKTllgy+0W84u5D/VF2CkKFit/RZyrRHwFk5iIkfwbV7YtidWB7m0OcDDDHNP
	ReNqPW0jW+p1+Z9b/6MUm8IoOjgmkvrq0H80MfFux2kIWc1JgdEjc7XKiVZT4Z5usHdNMmKm79a
	lc0TVIiL+p/trrO2oOsx5U+cTEyhtEs/COwOtfSqpwVxLY2SkQ0cAMDoAVD/6q4NB2CeZhhzEav
	GPmKXkfoGP4QbsbK48
X-Received: by 2002:a05:6870:164b:b0:3fa:966:a859 with SMTP id 586e51a60fabf-41627053298mr7945185fac.42.1772519578567;
        Mon, 02 Mar 2026 22:32:58 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cff1aacsm13391710fac.9.2026.03.02.22.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 22:32:57 -0800 (PST)
Date: Tue, 3 Mar 2026 00:32:56 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: unset GITLAB_FEATURES envvar to not bust xargs(1)
 limits
Message-ID: <aaZ_yngsx-CXAx0p@denethor>
References: <20260302-pks-msvc-meson-xargs-v1-1-8e42abd879ce@pks.im>
 <aaXArnhYbtX9gsUU@denethor>
 <aaZ8nyJFjFqct2Ri@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaZ8nyJFjFqct2Ri@pks.im>

On 26/03/03 07:15AM, Patrick Steinhardt wrote:
> On Mon, Mar 02, 2026 at 11:11:52AM -0600, Justin Tobler wrote:
> > On 26/03/02 12:55PM, Patrick Steinhardt wrote:
> [snip]
> > > The GITLAB_FEATURES environment variable makes up for roughly a third of
> > > the complete environment. This variable is a comma-separated list of
> > > features available for the GitLab instance, and seemingly it has been
> > > growing over time as GitLab added more and more features.
> > > 
> > > Fix the issue by unsetting the environment variable in "ci/lib.sh". This
> > > ensures that the environment variables are now smaller than the upper
> > > limit on argument length again, and that in turn fixes the assert in
> > > xargs(1).
> > 
> > So if we unset GITLAB_FEATURES, that puts us at 10987 bytes (17373 -
> > 6386) which would be under the upper limit. Unsetting this environment
> > variable seems like a reasonable means to mitigate this problem. Naive
> > question: is the upper limit something we could increase for the
> > environment?
> 
> Unfortunately not. Under normal Linux systems you'd be able to do that,
> but in MSYS2 the limits are hardcoded as far as I could see.

Ah ok, good to know. I was wondering if there would be value in trying
to increase the headroom we have in case the overall size of the
environment variables increases over time again, but it sounds like this
wouldn't be possible. Hopefully we should be good though. :)

Thanks,
-Justin
