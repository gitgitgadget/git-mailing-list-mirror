Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A91A1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 19:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeI0By2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 21:54:28 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37452 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeI0By2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 21:54:28 -0400
Received: by mail-yw1-f68.google.com with SMTP id y14-v6so76186ywa.4
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 12:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DO7py1zrk00rXZfcTv0m0H6tGUa5XoRLme08JNQuXm4=;
        b=i3K0rZ6gHESr7GXB9fHkTSwe1H7abneoIAISARhrr3MTTbxUNAiI+noGIJOLkr40VA
         GBZVTwrR3T1IDVDx+tz5svh/4FS3aEKPRYznX3qBh2d1ERMUUJFrGiUMOL7nxqyeQ2zy
         QqHJO6B0QXUdlHpKfXGGJ9tBDv7LaTYNQ9PuhJGUrKahIe2DpTQOYOWPBJd46j/WfwhF
         xnb5sk0JT1n0y5DMp5ZzbOBEjNGCgN80A3kZZf+TuzwFvGh0W8+h29v7atlod4gB5wig
         KVkZ2CJbjaX29JJFogynwcj7+GN1QaijhIq4yxJ9nQoaA20guHwREnevB/AdNRidQ9bE
         /RpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DO7py1zrk00rXZfcTv0m0H6tGUa5XoRLme08JNQuXm4=;
        b=b6Ln0r695D+IHpeHOU7uux92I8di6EM0vsc8es7gdrPM+fBzXb92mkt2XHp+sy6tWb
         pYzjmNzsHxD9JYKit+mXOS/wpVwOcTSBLPKZF1+mdqcTriT8YC5ArY1AMOFqL6ALNY+C
         eor982zIek5ZvAPldlMaKk8lIRyHPIZm/RCSogBgKcJHdtY/AzLcZAYH5JtFqR4XUATc
         qYMtsmKlK4FyDR88RL306a4LtokHJEjjjWm7+5cb7SsyXM2M6wt7cfBr14wX5Bd+Bxkm
         wbaxRCMjwbUd3F/dd9S6YKEr6ls4ccfHmskMQI9RwYspt7NrjjO9Z/kFcqHbcYLKO8KH
         0a/A==
X-Gm-Message-State: ABuFfojxmXyi8Zjza6M5aca3Z6dZBIlA864CP5OebdFUY/fbK3/sP7jx
        IXcr4RPzp3j6sg9fSxeKlR13dFsWUG2dC8KVevQNbw==
X-Google-Smtp-Source: ACcGV63+13u2LPkw5yt0+wf6i4bcUhSSh59KualzCYM3YrOmJ/M1EnxMDPD8wbtuVoLD9e7t/dzmZtSQU0Fk6ad8dQ0=
X-Received: by 2002:a81:5710:: with SMTP id l16-v6mr3933986ywb.3.1537990796286;
 Wed, 26 Sep 2018 12:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180921223558.65055-1-sbeller@google.com> <20180921223558.65055-2-sbeller@google.com>
 <87h8ihk7sl.fsf@evledraar.gmail.com> <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
 <20180926041517.GA2140@sigill.intra.peff.net> <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
 <87d0t0jghm.fsf@evledraar.gmail.com> <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
 <87a7o4je0t.fsf@evledraar.gmail.com> <20180926185812.GD30680@sigill.intra.peff.net>
In-Reply-To: <20180926185812.GD30680@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Sep 2018 12:39:45 -0700
Message-ID: <CAGZ79ka=5zs2vnFhoA7NT6PjCNHm3sRUiS98Zb+rpirE3mFKUQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] sha1-array: provide oid_array_filter
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 11:58 AM Jeff King <peff@peff.net> wrote:

> Now I'll admit it seems like make-work to me because I would not plan to
> ever look at the formatted output myself. But I guess I don't understand
> the audience for this formatted output.

I have been watching from the side lines so far, as I have a view that is v=
ery
much like Peffs, if I were to dictate my opinion onto the project, we'd:
* put all internal API docs into headerfiles.
* get rid of all Documentation/technical/ that describes things
   at a function level. So the remaining things are high level docs such
   as protocol, hash transition plan, partial clones...

But I'd want to understand why we are not doing this (obvious to me)
best thing, I have the impression other people use the docs differently.

How are these docs (for example api-oid-array or
api-revision-walking) used?

I usually tend to use git-grep a lot when looking for a function, just to
jump to the header file and read the comment there and go around the
header file looking if we have a better suited thing.
(Also I tend to like to have fewer files open, such that I prefer
a header file of reasonable size over 2 files, one docs and one header)

So when I find a function documented in Docs/technical, I would first
read there, then go to the header to see the signature and then make
use of it.

If I recall an earlier discussion on this topic, I recall Junio saying that
this *may* pollute the header files, as for example sha1-array.h
is easy to grok in its entirety, and makes it easy to see what
functions regarding oid_arrays are available. A counter example would
be hashmap.h, as that requires some scrolling and skimming.

> These are APIs internal to Git
> itself. We would not generally want to install gitapi-oid-array into
> /usr/share/man, because only people actually working on Git would be
> able to use it. So it sounds like a convenience for a handful of
> developers (who like to look at this manpage versus the source). It
> doesn't seem like the cost/benefit is there.

If this type of docs makes =C3=86var more productive, I am all for keeping =
it.

> And if we were going to generate something external, would it make more
> sense to write in a structured format like doxygen? I am not a big fan
> of it myself, but at least from there you can generate a more richly
> interconnected set of documentation.

That sounds sensible to me as the additional burden of yet-another-tool
is only imposed to the developers, but doxygen would provide
a better output in my experience.

Stefan
