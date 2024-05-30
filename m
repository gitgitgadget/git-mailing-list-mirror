Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97A3176185
	for <git@vger.kernel.org>; Thu, 30 May 2024 08:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058354; cv=none; b=NaOhHoLDWR6+19GO7kLxOOAIJfJ0sMI6EEFUI/idlRATBIxeVXytEqAYj1t7mO0AAPKcTXyep2k+rzne9ajyA+BBHEUcrwCTlKwgK8ItglLQNgFJJpazEnqmRob/cHSIRDTeY+i+F+JWde4T4SUgeSOZVOKW7s1J/2GZ/F8c4jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058354; c=relaxed/simple;
	bh=lcVT1Y8nyELF3//e38QY0N2fkP+N6eAUkC5OJUtfTzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiBGhDrzxb1wBX/pio9pmIl+CX/CRwwNQB1rU06CwLnQYIQV406GGEuuVNcuAR45fWyjnPsgYXkXFNNPn7+UqtKa34CUCPX9p3u+m5uqyV741ALwjax1nMeSVq15fWRH6JWWfEwAibxpnXdFB/UMxHegn3W1BWG+k6UaKB9wqpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4Hh2HR9; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4Hh2HR9"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70224f928edso639054b3a.0
        for <git@vger.kernel.org>; Thu, 30 May 2024 01:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717058352; x=1717663152; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w3KxxTzNrd/W92YibB6YYyJySfow1XRQPo2u2hF59JI=;
        b=E4Hh2HR9bz6Xt0BHIUlbtAA1LIOg9tg0DYVk8qMzcAlf4XAsxjb9CyMBTQRM3HCJQl
         LRB28jgI+M5n7Vp3xDkSefrofWnsrIDGtyfqbJ+YGDiDCbIr6grPsUrfefH4CQ0ifhMN
         Ig9/3xY4lBOaV5vTs10E6Yd0DRr2SPmXMAM0n74QZZJ87vbrv05pUWWDwcC+/7hhpEN6
         hGaZbOt6CCqX/+ZvVVKnuBhHb/7cQ9eQHJ62s01F2gGCyjJUJK91N+wbTkUe8lzihy3i
         ajIMXVcJ948/PrvcHNMItK8qYM/mUyWNsX3jYTFaFJCgxOgpczRVIetUEVk/jd48UmcZ
         KztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717058352; x=1717663152;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3KxxTzNrd/W92YibB6YYyJySfow1XRQPo2u2hF59JI=;
        b=OHxcJYkgTQw8gpqHdsZzoCw6LH81DWxLB8qr7rjs5oMm/Rzgr0CNp/OO6RPTYFOV2L
         YyrmHkLkt0R8iKdprM004mWgf7CD42Ml+cGGv0ctOsHKGssZMn4elB48hzPOMpblgpzY
         wHIqKRnBpAPjN1NZtnOKiXiLCSrRN7DVG3JkPmmpHlC0JgYBQTnO8P1Sp/wPKK31+maF
         I3KOSobEdOjNueaIeTxXSKeyoCJ3lyYPgmlDzNONI1LgbU308yWLCDctW6nk3mwgqhw9
         1lP7BgxtSOOdNyVJxyBbgy0gpQmPxG5q7nsJf0exveJrb8DltkjTmb3MoO3A1NQ/DuvH
         0SSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPB+hA7Y+K5Yx79inyzH7XsUCHzZIYoJFLO60mMjK5XtzJhKUHkw0CUH6xT4x6aYmtwiWX+DS7/Adbq3FRd4QexoNN
X-Gm-Message-State: AOJu0YyQfcCdi8cVifhZXXVLHjxyxopRRkJGPikcfGhx6yEPVF49NLa6
	Kq6lYHuTaqZUnGJTrAeaeTl7JiKlKWHpDdlKgIBl40lw0K6vxXv5I9L820ozzJ8yMA==
X-Google-Smtp-Source: AGHT+IF37WQKc6JRQFPBoS055n4MpkM2sSERThri98AQcMLQAnCB3rf8SMfoCayZAkDg2hIxqnFgag==
X-Received: by 2002:a05:6a20:3d8d:b0:1af:e649:6f4 with SMTP id adf61e73a8af0-1b264633301mr1487329637.57.1717058351799;
        Thu, 30 May 2024 01:39:11 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f476f665b0sm88339345ad.250.2024.05.30.01.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:39:11 -0700 (PDT)
Date: Thu, 30 May 2024 14:09:09 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH] t/: migrate helper/test-example-decorate to the
 unit testing framework
Message-ID: <tubjmjeczh6iigem32ulffvt2ucpygbm4frsr3jsps5tv2i7v5@ly3wge23zn6f>
References: <20240528125837.31090-1-shyamthakkar001@gmail.com>
 <xmqq8qzsuwh1.fsf@gitster.g>
 <CAP8UFD1YVyZj-uGfGXp6UxMfj3kZC5XXNed-5s-jj=ROx4URnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1YVyZj-uGfGXp6UxMfj3kZC5XXNed-5s-jj=ROx4URnA@mail.gmail.com>

On Thu, 30 May 2024, Christian Couder <christian.couder@gmail.com> wrote:
> On Wed, May 29, 2024 at 11:41 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
> 
> > > +     TEST(t_add(&vars),
> > > +          "Add 2 objects, one with a non-NULL decoration and one with a NULL decoration.");
> > > +     TEST(t_readd(&vars),
> > > +          "When re-adding an already existing object, the old decoration is returned.");
> > > +     TEST(t_lookup(&vars),
> > > +          "Lookup returns the added declarations, or NULL if the object was never added.");
> > > +     TEST(t_loop(&vars), "The user can also loop through all entries.");
> >
> > These tests as a whole look like a faithful copy of the original
> > done by cmd__example_decorate().
> >
> > I do not understand the criteria used to split them into the four
> > separate helper functions.  It is not like they can be reused or
> > reordered---for example, t_readd() must be done after t_add() has
> > been done.
> >
> > What benefit are you trying to get out of these split?  IOW, what
> > are we gaining by having four separate helper functions, instead of
> > testing all of these same things in a single helper function t_all
> > with something like
> >
> >         TEST(t_all(&vars), "Do all decorate tests.");
> >

In addition to what Christian said, doing it all in one function would
provide no context as is. i.e. when we do it in a single function,

*** unit-tests/bin/t-example-decorate ***
# check "objects_noticed == 1" failed at t/unit-tests/t-example-decorate.c:46
#    left: 2
#   right: 1
# should have 2 objects
not ok 1 - All decorate tests
1..1
make[1]: *** [Makefile:78: unit-tests/bin/t-example-decorate] Error 1

vs separated

*** unit-tests/bin/t-example-decorate ***
ok 1 - Add 2 objects, one with a non-NULL decoration and one with a NULL decoration.
ok 2 - When re-adding an already existing object, the old decoration is returned.
ok 3 - Lookup returns the added declarations, or NULL if the object was never added.
# check "objects_noticed == 1" failed at t/unit-tests/t-example-decorate.c:56
#    left: 2
#   right: 1
# should have 2 objects
not ok 4 - The user can also loop through all entries.
1..4
make[1]: *** [Makefile:78: unit-tests/bin/t-example-decorate] Error 1

The latter provides much more context (we almost don't have to open
t-example-decorate.c file itself in some cases to know what failed)
than the former. Now, of course we can add more test_msg()s to the
former to improve, but I feel that this approach of splitting them
provides and improves the information provided on stdout _without_
adding any of my own test_msg()s. And I think that this is a good
middleground between cluttering the stdout vs providing very little
context while also remaining a faithful copy of the original.

> > in cmd_main()?  If there is a concrete benefit of having larger
> > number of smaller tests, would it make the result even better if we
> > split t_add() further into t_add_one() that adds one with deco_a and
> > t_add_two() that adds two with NULL?  The other helpers can of
> > course be further split into individual pieces the same way.  What
> > ere the criteria used to decide where to stop and use these four?
> 
> The original code has some kind of "sections" (or paragraphs)
> separated using comments like:
> 
>       /*
>        * Add 2 objects, one with a non-NULL decoration and one with a NULL
>        * decoration.
>        */
> 
> or:
> 
>       /*
>        * When re-adding an already existing object, the old decoration is
>        * returned.
>        */
> 
> I think it makes sense to separate the code using functions matching
> these "sections" and to reuse each comment in the TEST() macro that
> calls the corresponding function. If this patch is rerolled for some
> reason, I think it would be a good idea to mention this in the commit
> message though.

I agree about the commit message.

Thanks.
