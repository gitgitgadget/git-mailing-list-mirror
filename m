Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C9BD1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 12:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbeCUMqO (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 08:46:14 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:39080 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbeCUMqN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 08:46:13 -0400
Received: by mail-ot0-f176.google.com with SMTP id h8-v6so5415915oti.6
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 05:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dakotahawkins.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FCmQZLMsRrWAUmli4QlfsjodRzOYtWeIylfgUZeryxY=;
        b=I22qQ4itZK9s86X5oAVRzkvDGfAN0Ja79k4f8AqL6Z7bogtn7xQRCFXGTiPDU9nm9r
         4nvdZu/M96gavCRqdrhclOA9uO3IKZm4VIx5e1ZPBw85BiCMQWOkT8ZalS+YJuFJ/puJ
         zbawTfttFYRp3gc5ZrFG9Q+gGqHDVDGNg9oTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FCmQZLMsRrWAUmli4QlfsjodRzOYtWeIylfgUZeryxY=;
        b=PU3IE0Tyyjks+0/reaONd12K/T3syedrZO5cgI/0QKV7KvNexFRvyf5dCKkJK8APpn
         W2VoVeBwhTrBUOGqGsIJDoOb+hT2zmbSND8V5OjnhONlx/FgXq9CPNvROvxzGCBAU0Vt
         b99vB97wRQS/BkzHWzOlwWRfx4yKQxutR6qhAwtaS4L2N33z7/1fyt8P15DwwHTUtDDw
         wr2qOBDT7b6JbGpS4+gVSUkQWLEIOAHuPiFTgP5qNLj+sj0q5yl9hKeL15MbQRTOE7Bc
         jbGVkQqyYrEHjalhnjh1tvyPePQd7Ge/rx/17si6eK6wVMe+a51oXb9oFtjuGZffzado
         b1sQ==
X-Gm-Message-State: AElRT7G+q1MQkhr+3pSfz1ZSl1oSPdFZxv82AG4Wa3N2fAmfNC0Q9/zc
        KawtPQ8LeFaj+lgFviwYhOPUXbWsJ1wSk2joSz7rlg==
X-Google-Smtp-Source: AIpwx49P4sHg1c5Gt7xJQ0ZTv2vWfnzW0EoJjBNwZM8mVbdedOg0vEEnerzoke5+ehn6tDotpd5QBZqQ5DBF6nXv26U=
X-Received: by 2002:a9d:4792:: with SMTP id b18-v6mr4053894otf.118.1521636373273;
 Wed, 21 Mar 2018 05:46:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4a69:0:0:0:0:0 with HTTP; Wed, 21 Mar 2018 05:46:12
 -0700 (PDT)
In-Reply-To: <87woy5y5y8.fsf@evledraar.gmail.com>
References: <CAHnyXxSqtB=bSbA83V6HC6-aPCxw60h1iKQaa6ChwsmcUUCd0w@mail.gmail.com>
 <87muz1brgt.fsf@evledraar.gmail.com> <CAHnyXxQRfzAT75P7dxvdEEN_FRYCc7j97VEfL8tTUgVdeK-O+g@mail.gmail.com>
 <87woy5y5y8.fsf@evledraar.gmail.com>
From:   Dakota Hawkins <dakota@dakotahawkins.com>
Date:   Wed, 21 Mar 2018 08:46:12 -0400
Message-ID: <CAHnyXxRYjCey8N82TfbMbv1+tXNDN4df_UWZ7znaYUj4wcS5HA@mail.gmail.com>
Subject: Re: [PATCH] doc: clarify non-recursion for ignore paths like `foo/`
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think it makes more sense to document it where it's documented now,
> i.e. under how "!" works in general, since this is an edge case with
> negative matching.

My reasoning is/was that while yes, that's true, I think it's likely
that the positive matches would be added before (in terms of git
history) the exclusions. In other words it may not occur to the user
writing an early version of `.gitignore` to think about exclusions if
they don't need to exclude anything yet -- the eventual symptoms of
this problem may be "far away" from the cause, making it harder to
diagnose (I'm living proof of that!)

> I think it can certainly be made clearer, but maybe with a practical
> example (per above) where we also show the dir structure that
> would/wouldn't be matched.
>
> I just chimed in on this one because your patch says the docs are
> "unclear" then "Explain this behavior (and its implications) more
> explicitly" without a reference to the existing adjacent docs. I think
> whatever we do we should be unifying these docs if they're amended, not
> stating this twice.

I think my inability to see it despite knowing exactly what I was
looking for (this time) makes it "unclear", at least to dummies me, so
I feel like that statement is at least somewhat defensible :)

If the explanation were unified, would the idiomatic way to do that be
to add some section way down the document with a couple of `(see SOME
DETAILS ABOUT THIS below)` and some examples in the examples section?
