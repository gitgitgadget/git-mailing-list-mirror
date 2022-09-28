Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4267DC32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 06:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiI1GNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 02:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiI1GNa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 02:13:30 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA00B1205AF
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 23:13:29 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-333a4a5d495so120505147b3.10
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 23:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=WrckdxlxqB9KMUcbwwXV+cDjyo8nXW0W8fQAJc24afA=;
        b=ChOzn8f0S8264F4hh34PE5w0XNoCDoOprmMMJ/LfDylYwqJ+QWpqx3vcm5IgGyXuOq
         GTjtVy706JIfVJ7bKZjmndZJbnxSSK2rkNaCKE4IQQ1rKvi73HtoVWVxLMYvqgSdQnrq
         pKdvUi0qX4TX0+rNBhR0seCJN3u8KG5RtjVS0nP1NbKdPBPtfR8HTkhM8cfxF4GMSOWf
         qugA5Zo5YISYbBI89hFSqCyny2ZLKZOANhIyIenKP1eaKjgRtMaGYLxzZqhK0E9rKZjh
         5ercXFElybdPSVaTgZ96BcBXlBRPBCImu8QAZjY2S3IiuP/Xh7AvSRYY3MdXrCsdKzZb
         nuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WrckdxlxqB9KMUcbwwXV+cDjyo8nXW0W8fQAJc24afA=;
        b=IgUrq3W9hRA58KhEaHoOJuNVd/JRgu43yJ51WNud6qzohZq5CcK2tazcRTE9x+16x9
         e4lUGpElqqP2LOMDftn98CQwFI7HVAC7QGDbqmaML69UKUTOOO8ZUM5/ECt3yJXxvi1k
         K37nTD5//3sDuihSA+Us1OpNqpekcgsqCyI2Q1Ia0POkRzHklbO/rs2zxljr7H08beBx
         IFmxkRdlU4Y3vvApCn+PO8GMQSD+tdHmtOgKki9nIJ5I6L/ryZcmtu6WZBrx9HDAd5n3
         eodEe5xJU/GEGQSwO/wWao4QiELgG5Xz7K7rN4tLvC0xkNtADP56UNMFs2VqJdLpFQw0
         Z/JA==
X-Gm-Message-State: ACrzQf0pboBrd85pCG6k6GuA24h4uR4OF0TZg1ti918ViQuOwCBOMXNr
        wF+uO2wnyGHdLhyXh7ERij/y63otqkQo9+KNB5M=
X-Google-Smtp-Source: AMsMyM6g8nAnX/TM49ctbgBmzV5RtvTM3jqqLJv/2+Tcqu3Z2jxI355vuSabcNs/Qod6HJuoyolTPIHo5I4l6Ry2NIE=
X-Received: by 2002:a0d:d481:0:b0:352:739d:9408 with SMTP id
 w123-20020a0dd481000000b00352739d9408mr5074038ywd.365.1664345609063; Tue, 27
 Sep 2022 23:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <Ywzv7Dl6n+LcY//n@nand.local> <CAP8UFD2gUTuae0nRp2jHHoD3yLsVSGTBzEuHkv8QLDGJVAZ-MQ@mail.gmail.com>
 <CAP8UFD0+qW9aRVbXeKkvZKKi-6rge851FdT3FxPW98_JH_KLRQ@mail.gmail.com> <YzN6btb9IzqeTEdi@nand.local>
In-Reply-To: <YzN6btb9IzqeTEdi@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 28 Sep 2022 08:13:17 +0200
Message-ID: <CAP8UFD2FsBhYEAEttmg2GQzrho3TA2UR88wV4q01FJ5y8EzndA@mail.gmail.com>
Subject: Re: Git in Outreachy? (December 2022)
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2022 at 12:34 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Mon, Sep 26, 2022 at 11:51:23AM +0200, Christian Couder wrote:
> > The deadline to submit projects is September 29, so next Thursday.
>
> FWIW, this was extended to make October 6th (at 4pm UTC) the deadline
> for submitting projects.

Yeah, they sent an email to extend it yesterday.

> > I think Taylor agreed in private discussions with submitting another
> > project related to improving our https://git-scm.com/ website (which
> > was discussed previously on the mailing list).
>
> That's not quite the case. If I recall correctly, I said that I'd be
> excited for somebody to submit that project. But I don't have the
> capacity nor the skills to mentor it this cycle. If somebody else is,
> I'd be happy to work with them to find funding for it.

Sorry for misremembering what you said.

The thread where this was publicly discussed started there:

https://lore.kernel.org/git/CAP8UFD2fN=c2JvvzH94Nu8yqt2MOOtXrn29eFxuie9aZ5YVjQw@mail.gmail.com/
