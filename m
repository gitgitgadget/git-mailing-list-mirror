Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B0AC433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 20:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiCVU4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 16:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbiCVU4e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 16:56:34 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F9CDB0
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 13:55:06 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a26so13847550lfg.10
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 13:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLbTZnTH+Pa5kgiAXeLEaxUT0cRlAxcR168v8yPpjjw=;
        b=Vzd8YZCdOJxSrHgqYWWdjbc5iptxjFZmHIXKTY7nwSj6J57wZHWfiTnPdgA5aqCM3d
         VMjg/netrbmk0IHvL/RQgq+oquAhnLDiMsmMbrO6QaJ2e2YLmC8Uh73+3ouLXc/txyVF
         u/T3OeUHsFF0dQfnCM0GE/qQiTnvUw0V3N4t2wk0bbzGoTnAyU9jZjgqDFmYcefWtvZ6
         ktkfsIinUo4Oj7DqpFl7j9joRW7qUr7Y8W3+y01/96K2MjUHEFf7i/hMZc3HLrXvj0pq
         lZCjvCS5vB68/FmxY07IB86fjKPzfYZafSL3Wv7GRGqE28w9NOEi6rWn90+XiMlnr6qq
         09vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLbTZnTH+Pa5kgiAXeLEaxUT0cRlAxcR168v8yPpjjw=;
        b=MtQ9DSs98urlXvTFia2E1/+/p3wflhBhE51CzZm+z/4Y1VbvYu81w8r/lEFe5uHoP/
         TGDDp+vfDeWGNRggjX8s0Kp6G96mbxSU1ar42uz9f4mXcZ3RVK5afj4KtnpwpTIr4DYD
         le47RsI7c0/P8ZGHrdCX0W051dwaZ+SjcRRqabZYhILDr/2MMfCpupN6YF4V1dzH/p6i
         pxd83Q+yB4C8wRqQWosvgRbOgoaVe2w0UweKgOthc47UhUaUHWlmwZoL/UfYnCi/qQwC
         fDXgiuCkUoFJYe2H34VlAZUs53jMGQUwOkQ2phNVmBsMDtx8LVP/W1Uu29+87JrN/ZE1
         bDAQ==
X-Gm-Message-State: AOAM532XJBGLiVbvfOns+ecb1GJXUGnOk1H88uJfGpcfDiiXfneYd/nj
        uO63Inno3v2Bu1pgqNxl8cQw2DyXRsSuU/yz9Io=
X-Google-Smtp-Source: ABdhPJyOe1e9yQvzduHrtSGKEcmJWTM/A9C2T8IXANuoyTwCn7LcKhgnMUaE/LU5xl8b9d88xUBkUZPhVM1TAts8OMU=
X-Received: by 2002:a05:6512:1684:b0:448:a0e6:9fa6 with SMTP id
 bu4-20020a056512168400b00448a0e69fa6mr19739653lfb.592.1647982504753; Tue, 22
 Mar 2022 13:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com> <6662e2dae0f5d65c158fba785d186885f9671073.1647760561.git.gitgitgadget@gmail.com>
 <xmqqv8w7yyua.fsf@gitster.g> <CANQDOdeQP7b1MefkGZKSuFb-kc9F01RPypxaowFwG-A+wyZGog@mail.gmail.com>
In-Reply-To: <CANQDOdeQP7b1MefkGZKSuFb-kc9F01RPypxaowFwG-A+wyZGog@mail.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 22 Mar 2022 13:54:54 -0700
Message-ID: <CANQDOdcpvv3p8N07q29GekaJ=hZgTjfp=w-Ky1PQCqqRmr8JyQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] unpack-objects: use the bulk-checkin infrastructure
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 21, 2022 at 4:02 PM Neeraj Singh <nksingh85@gmail.com> wrote:
>
> On Mon, Mar 21, 2022 at 10:55 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > From: Neeraj Singh <neerajsi@microsoft.com>
> > >
> > > The unpack-objects functionality is used by fetch, push, and fast-import
> > > to turn the transfered data into object database entries when there are
> > > fewer objects than the 'unpacklimit' setting.
> > >
> > > By enabling bulk-checkin when unpacking objects, we can take advantage
> > > of batched fsyncs.
> >
> > This feels confused in that we dispatch to unpack-objects (instead
> > of index-objects) only when the number of loose objects should not
> > matter from performance point of view, and bulk-checkin should shine
> > from performance point of view only when there are enough objects to
> > batch.
> >
> > Also if we ever add "too many small loose objects is wasteful, let's
> > send them into a single 'batch pack'" optimization, it would create
> > a funny situation where the caller sends the contents of a small
> > incoming packfile to unpack-objects, but the command chooses to
> > bunch them all together in a packfile anyway ;-)
> >
> > So, I dunno.
> >
>
> I'd be happy to just drop this patch.  I originally added it to answer Avarab's
> question: how does batch mode compare to packfiles? [1] [2].
>
> [1] https://lore.kernel.org/git/87mtp5cwpn.fsf@evledraar.gmail.com/
> [2] https://lore.kernel.org/git/pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com/

Well looking back again at the spreadsheet [3], at 90 objects, which
is below the
default transfer.unpackLimit, we see a 3x difference in performance
between batch
mode and the default fsync mode.  That's a different interaction class
(230 ms versus 760 ms).

I'll include a small table in the commit description with these
performance numbers to
help justify it.

[3] https://docs.google.com/spreadsheets/d/1uxMBkEXFFnQ1Y3lXKqcKpw6Mq44BzhpCAcPex14T-QQ
