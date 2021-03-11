Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26306C433E9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 16:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA77D64FF5
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 16:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhCKQmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 11:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhCKQmY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 11:42:24 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6256C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 08:42:23 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id q130so4820436oif.13
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 08:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khj2GN3AxJW3vg+A03UIOsXJlSHWuDByt7IAWsb3af0=;
        b=A4RiwltcQLrhNKi/W2oQxIuhp0KwZolRdUkt9uX7O7ojYQLBuFlx8ViUQuUdIOwSGf
         zgKEgSvXGgbJE7CVPtiSs7Icos++TPYI71S4+JJgSwO4W7ipT/QxWTjjnuELHD5J3YDI
         bHeX7hQ8MMbfq6JmvifDQxlL95oApLuTcH/Cuj22+vHTAOQI4fugOxTtJJmxvMfn8vBv
         mGacsbG0oUHde/YV+MJwEt5HT40Jm2QGjc1r07UHKmEFS4qq7a6pDNVvSMClh/yohFYh
         CMyxBDDARsxWteEZEhkZjLRCJUJZ6rrRvd+vhWP498VKuETbvXFOhS5yeZ43iPPXZo0E
         QO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khj2GN3AxJW3vg+A03UIOsXJlSHWuDByt7IAWsb3af0=;
        b=tNeU6hDKq38dvAfr7RCBsX7YRLg3yn2+mM39Oe7YkALv+Wzgg9AlvVEyxraCofqdXK
         RyFhpUnRkpj2fqA8zt0P5dK+BtVBuf5DD4TSa9zYv93oIDalz05uN2Bo7AhWJSH7+J0h
         dEZW4udSiU5R3H3JANeId53JaV4K0LGd0ekhWFgkg8UgWGYvqXShg0yNylLLQyij+ygx
         PWMXuYiT5TEtT0csR2buNJJI+qbXjlBzrufrEPoava+5zkVfUgThIRf774alkIqn7VtR
         k0quXN2QcCS1R35rpeOfPlJa0NE6yofEM5tTZ8r3xz2jQ9R0f5VrIFfr2hJh51etUCo6
         Tcbg==
X-Gm-Message-State: AOAM532GrN94lbw1mYcrtGugqt3WvFI6RkOtT7ZMRbBpxYqkrMW3E8Os
        f43W4U0AfMRYrMqwnQ9HD5ufuXqU5x+uIlOCL+c=
X-Google-Smtp-Source: ABdhPJz0Q6y3fqgqVbzS+tnqMg2XpMlXvkyL88TB6t+6VJZg18o9c4xC3up4tzXL1j6NXwkoCYe4E4v8QdWwwYKL44A=
X-Received: by 2002:a05:6808:a8a:: with SMTP id q10mr6842305oij.167.1615480943211;
 Thu, 11 Mar 2021 08:42:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
 <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com> <cbf2716a-afbf-0b36-2f45-4c13ade38768@gmail.com>
In-Reply-To: <cbf2716a-afbf-0b36-2f45-4c13ade38768@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 11 Mar 2021 08:42:12 -0800
Message-ID: <CABPp-BE1TvFJ1eOa8Ci5JTMET+dzZh3m3NxppqqWPyEp1UeAVg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Complete merge-ort implementation...almost
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 7:20 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/9/2021 1:24 AM, Elijah Newren via GitGitGadget wrote:
> > This series (nearly) completes the merge-ort implementation, cleaning up
> > testsuite failures. The exceptions are some t6423 failures being addressed
> > independently[1].
>
> I like that most of the patches here are small and straight-forward, and
> are backed up by tests.
>
> I'm concerned about the coupling of the "index with one entry" mechanism.
> I'd like to see that built differently by creating methods that can
> operate on an attributes file directly. If this method extraction is truly
> too difficult, then I'm willing to concede this point. It is worth some
> effort to try, though.

Oh, I agree, I hate the "index with one entry" mechanism to activate
the renormalization code.  It feels like a capitulation on merge-ort's
design and is such a hack.  I tried to figure out how to do it a
different way, and failed pretty hard.  I was close to the point of
throwing my hands in the air and leaving the renormalization tests
failing ("who uses that stuff anyway?"), but it was the _only_ test
that merge-recursive passed that merge-ort didn't, so I kept trying
anyway.  At some point I realized that a hack along these lines might
work.  Although, to be honest, I still don't understand this code or
why my patches work -- in particular, the get_stream_filter() call has
me flummoxed.  It returns a value, but I throw it away -- yet the code
fails unless I call it.  What is it actually doing?  Clearly it has
some kind of side-effect somewhere, but reading the code didn't seem
to help me.  I discovered the function and others via various
debugging and trial-and-error attempts, and ended up finding out that
just calling that function is enough.  I know it works, but I don't
know why.  I understand everything else in merge-ort; I hate having a
magic corner here.  I'm not happy with it.

I'm certain that with enough effort the renormalization stuff could be
fixed and made callable without an istate.  Perhaps there's even a
simple way to extract the relevant logic and I'm just being dense, but
I got very lost in that code and I'm a bit afraid of it now.
