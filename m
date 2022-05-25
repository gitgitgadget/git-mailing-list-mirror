Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DCDC433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 16:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245422AbiEYQtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 12:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiEYQtp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 12:49:45 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314541145C
        for <git@vger.kernel.org>; Wed, 25 May 2022 09:49:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 1so11790861ljh.8
        for <git@vger.kernel.org>; Wed, 25 May 2022 09:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=plZVkNyI9FaSOKIhqEm7Aybf+RvoYXxqP26UGQCuzzY=;
        b=kQj/8iropzvTDkq6k8snhRE2Qiq+EDTSvt4KyCW72bXxnOUSwWVkTOb2On/q4zqIDQ
         Y4f4oGvjiXNYKyIVBLNr9Zj5uc4w6VUwWS//SepwonF0sBqZ5DQw+vsoNQRJHmR7egsZ
         E++j314ZMD2MmBVmCP2k316Vdd2un/qLPHBa4YQ2LWUL5F+0JUw6aVyxNIDsGepfQ1df
         yLUPrcRYcDvnRyDgYenXyhBk5aT1qmurjl5KZhBBqnqTPaVVWHco/9hisUFmLZTBxNyo
         xrQLD09yalEwwd4jmYtn76HD19IlSLcPtdTxk8WOzGfK8BSbl11dLMDHfaHRXK4vlpyM
         zkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=plZVkNyI9FaSOKIhqEm7Aybf+RvoYXxqP26UGQCuzzY=;
        b=rB71qJLz3qWIaaqSejeo5+eqGkg+BPLojs+nWuEPM5S+2VKJUe6op4wIp0KlCx1Pb4
         Tr481/w5+iYAegK0HTzjy+1zHip4r64n7k4TbLxCM1O23LCRoDTCEMJdbUB6Sk2owgsi
         jik+tlFBmYpiVwD497+JOlI7/TtRAJhEgRu9w7wI1G/2/H7EJTPmr/92RMuT1gwMIY9r
         RFUH+dYsTBEa1fpx7DkDLRgx+m4y1vyDYusSMOskKpvVlWdEXXfCKIwxcahQpKQeSi5Z
         PPjc02iP6H5g6KgWE89Mg08+bOk3SXXVQCLnhXyeWm/9Qrp37Y9P8rnEcp6+qKG+BOlF
         wv1A==
X-Gm-Message-State: AOAM533E543onGAvYzeZZu8FHr6stHf5RkX7YUzG/sIE55YoxBn3KV1j
        5yrmHeeb6rGabDpsPJ27uRea14r8NVpk36Jk4xcp8WMiHu2/QQ==
X-Google-Smtp-Source: ABdhPJxW7nBY/tx9QVemkHT2gC9hwb1rqHIiCOHk5Or4JMHbXs1FQ+1ecaJEPVpXkUSvr6Nd9mRM6EX6kQWgn+/ece4=
X-Received: by 2002:a05:651c:506:b0:254:1a3a:803c with SMTP id
 o6-20020a05651c050600b002541a3a803cmr458832ljp.88.1653497380741; Wed, 25 May
 2022 09:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <CACMKQb0Mz4zBoSX2CdXkeF51z_mh3had7359J=LmXGzJM1WYLg@mail.gmail.com>
In-Reply-To: <CACMKQb0Mz4zBoSX2CdXkeF51z_mh3had7359J=LmXGzJM1WYLg@mail.gmail.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Wed, 25 May 2022 09:49:29 -0700
Message-ID: <CAJoAoZmtzRakZB2Pgez9YW7URXaxTF3RZ2-ZWrRHMhbj81u2yA@mail.gmail.com>
Subject: Re: About GIT Internals
To:     Aman <amanmatreja@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 25, 2022 at 9:11 AM Aman <amanmatreja@gmail.com> wrote:
>
> Hello there,
>
> I have recently been reading The Architecture for Open Source
> Applications book - and read the chapters dedicated to GIT internals.
> And if I am being completely honest, I didn't understand most of it.
>
> Could someone please assist - in sharing some resources - which I
> could go through, to better understand GIT software internals.

I am really excited you asked! This puts you firmly on the road to
being the person who can help unstick all your friends when they get
into Git messes later on. ;)

https://docs.google.com/presentation/d/1IQCRPHEIX-qKo7QFxsD3V62yhyGA9_5YsYXFOiBpgkk/edit?usp=sharing
<- This is a really great intro to the internals which I love. I
pretty much always recommend it as the place to start for someone
curious about learning how Git works.
https://www.youtube.com/watch?v=5Gq3KVvcfDk <- This covers much of the
same territory but has a nice video to go through it, in case it's
easier for you to learn that way instead of reading slides.

If you have additional questions about the technical design of Git
following one or both of those presentations above, I think you could
get far starting with Git's own design documentation:
https://github.com/git/git/tree/master/Documentation/technical

From there I think the list will be the best place for specific
followup questions you might have.

Happy learning!

 - Emily
