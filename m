Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91F931F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 19:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeJICbJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 22:31:09 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:42352 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeJICbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 22:31:09 -0400
Received: by mail-ed1-f50.google.com with SMTP id b7-v6so11996355edd.9
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 12:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70EHXZXG58IfsdbppsbyjsxdHVgH8nuYed81kmUy5aI=;
        b=SlIWYUUonIAMH2r6mVsbPBWvQKxxaBjikSgy5G6pWpMGwW2cApIdwcykVRGJWk7AeU
         caY+1XUq6DFjv+1j+PXpgswyNDrpCbi6pUWCUEMdTYYarMaoTy1SyyEpMIHvKckU6LOk
         wh/WJBfso04sc983Fy7fwjgukYwwbUatylv65kYttkVmCse7/eRnNB1oyMZOwIxA1L5r
         BSH9cU0fG5LxGYes92QWgPomZTBTDq4hod2yzoB1P5QxA/ZcV1mCnU0m7c8b0raLl9h2
         8Wf48brHwBYHDOYxM4tXJsyImEAG+nq7TDQQs/lbxH8cOLy+qDcJlCcRGC2H5DzPs8et
         6xJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70EHXZXG58IfsdbppsbyjsxdHVgH8nuYed81kmUy5aI=;
        b=hRykZeU0SZ0xjjvUY0HmMTB9PbaZGy0jyQZSzh1ZW/7KQzF+m9rK8ZDHdASooq4uiY
         ZZML5c6/Ho3DvhwUd/j14z2a20T8gswzr/upMzgV+ZoFSSDa4TI4or+NVVoEuCXk+NU5
         DstNe4OeNy28duyOaawxFuCGvYr7VLo88bIRmOELs89ZTEFqpRdIR3+JJrS+C1ULXEqx
         NKlBrV3AKXe1nBO7yPym6NNa/9QfglBSCdPmeLZ/P1oQ+r6cx1ev61iyMnXYvx8oLWCy
         BStzz6zu5UK1o0xdlL71qc0CS7TMJ1UHb43QFoROa/+WnwLkwq0tGZveKMrPGiIL5snQ
         Lqyw==
X-Gm-Message-State: ABuFfogbgqjuxee7aZZP+GtypELMxY+dJeLRnul5XH4+wLesVDC3d0Oe
        btWPcFGswrFTFbznBDXIOmm6W7+gFXfKgYA7n/vMyvdui5aWWw==
X-Google-Smtp-Source: ACcGV62zJz2wj0TseWLWDJZzOfFDui3NYgfRNwgP5dWaCBwsK7FblDQxhDHWewM7a4sjol6mum4CvLb+vHeMxVJrjok=
X-Received: by 2002:a17:906:b819:: with SMTP id dv25-v6mr13744405ejb.70.1539026272079;
 Mon, 08 Oct 2018 12:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
 <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
 <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
 <alpine.LFD.0.9999.0709051438460.21186@xanadu.home> <87k1mta9x5.fsf@evledraar.gmail.com>
 <xmqqpnwltu8s.fsf@gitster-ct.c.googlers.com> <xmqqlg79tta8.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg79tta8.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Oct 2018 12:17:40 -0700
Message-ID: <CAGZ79kZq3xtsbscrRFD8CSn++yrvdM6Ux+nkQ3AamgabXtPL+w@mail.gmail.com>
Subject: Re: What's so special about objects/17/ ?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        nico@cam.org, nix@esperi.org.uk, koreth@midwinter.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 7, 2018 at 1:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:

> > ...
> > by general public and I do not have to explain the choice to the
> > general public ;-)
>
> One thing that is more important than "why not 00 but 17?" to answer
> is why a hardcoded number rather than a runtime random.  It is for
> repeatability.

Let's talk about repeatability vs statistics for a second. ;-)

If I am a user and I were really into optimizing my loose object count
for some reason, so I would want to choose a low number of
gc.auto. Let's say I go with 128.

At the low end of loose objects the approximation is yielding
some high relative errors. This is because of the granularity, i.e.
gc would implicitly estimate the loose objects to be 0 or 256 or 512, (or more)
if there is 0, 1, 2 (or more) loose objects in the objects/17.

As each object can be viewed following an unfair coin flip
(With a chance of 1/256 it is in objects/17), the distribution in
objects/17 (and hence any other objects/XX bin) follows the
Bernoulli distribution.

If I do have say about 157 loose objects (and having auto.gc
configured anywhere in 1..255), then the probability to not
gc is 54% (as that is the probability to have 0 objects in /17,
following probability mass function of the Bernoulli distribution,
(i.e. Pr(0 objects) = (157 over 0) x (1/256)^0 x (255/256)^157))

As it is repeatable (by picking the same /17 every time), I can run
"gc --auto" multiple times and still have 157 loose objects, despite
wanting to have only 128 loose objects at a 54% chance.

If we'd roll the 256 dice every time to pick a different bin,
then we might hit another bin and gc in the second or third
gc, which would be more precise on average.

By having repeatability we allow for these numbers to be far off
more often when configuring small numbers.

I think that is the right choice, as we probably do not care about the
exactness of auto-gc for small numbers, as it is a performance
thing anyway. Although documenting it properly might be a challenge.

The current wording of auto.gc seems to suggest that we are right
for the number as we compute it via the implying the expected value,
(i.e. we pick a bin and multiply the fullness of the bin by the number
of bins to estimate the whole fullness, see the mean=n p on [1])
I think a user would be far more interested in giving an upper bound,
i.e. expressing something like "I will have at most $auto.gc objects
before gc kicks in" or "The likelihood to exceed the $auto.gc number
of loose objects by $this much is less than 5%", for which the math
would be more complicated, but easier to document with the words of
statistics.

[1]  https://en.wikipedia.org/wiki/Binomial_distribution

Stefan
