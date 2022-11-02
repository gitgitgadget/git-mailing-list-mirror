Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840F2C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 09:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiKBJba (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 05:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiKBJbP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 05:31:15 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6362910E2
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 02:31:14 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id h206so11063225iof.10
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 02:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2AaMBXX7R5Y9YOLOlOjHNRjkdy6D7oQvpJCtr1j31cs=;
        b=mDl3BOHuGTZO0T3ZOtBj/eKgMUfU2IGeG2fWeG7umqNndmhaNJ3AyyfKulquUlDolA
         3dlbOjofkvSYicaWS6hnJwReh+GKjI6PbI8aNxmuIjyCAjw//D0ZvhO5pVVKx7+E4bu9
         Sz2tQjHv96X26aQm6iZbPxI4OK+BJD0FBxkvxk9utMVaZB9zwH8vc+RoM0+W6ui81LtI
         NcqUpbUTAbWPyC+Z5C6w6q3Lk27lz5LwGPAnnO31JXoZj37izrtneNh215tL813abg5N
         zTHmpHTQIT+lHOLaxRaWN/fltluwMsdg2RAKbgXO/JOgaJlqwq40hplKeM+QBqnJpLC5
         /IHw==
X-Gm-Message-State: ACrzQf02TzJwtpNqf7W+5mwUux6AcSKTngB5QD9rZAkqIBruu/eYZMsR
        DA038myB+dSvDDrZx6kVeIqA07V2oX6S5HeARKE=
X-Google-Smtp-Source: AMsMyM4pmVGflB6zIh3aZgNkYEloe73t5RjPllSGv08XyZC1OSm5d5wHV2xP1IYKXMRNMIGUcnlWRAk3Rt3mwRhR5sg=
X-Received: by 2002:a05:6638:134f:b0:372:8558:1e34 with SMTP id
 u15-20020a056638134f00b0037285581e34mr14362723jad.285.1667381473614; Wed, 02
 Nov 2022 02:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
 <Y2CFRJLFRXvGwFBC@coredump.intra.peff.net> <221101.86a65b5q9q.gmgdl@evledraar.gmail.com>
 <Y2GHjnuyuwGpY3II@nand.local> <Y2ItZWx+kBmTreGQ@coredump.intra.peff.net>
 <CAPig+cSj78Mh8v6mN3BtyHJ+NxOvT2H_NW6SPFSAce0op2DfjA@mail.gmail.com> <Y2I1FsYyIRCCwh30@coredump.intra.peff.net>
In-Reply-To: <Y2I1FsYyIRCCwh30@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 2 Nov 2022 05:31:02 -0400
Message-ID: <CAPig+cTZfckXjX5=nD=cufhus_m9G8LgPqA2dtzKW0AT2bqLgw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] t5551: be less strict about the number of
 credential warnings
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 2, 2022 at 5:15 AM Jeff King <peff@peff.net> wrote:
> On Wed, Nov 02, 2022 at 04:49:37AM -0400, Eric Sunshine wrote:
> > > Note that the tests for the "die" mode don't need adjusted. They die
> >
> > s/adjusted/adjustment --or -- s/need/& to be/
>
> https://english.stackexchange.com/questions/5407/central-pennsylvanian-english-speakers-what-are-the-limitations-on-the-needs-w
>
> Don't stomp on my linguistic heritage. :)

Sorry. My head needs hanged in shame. I forgot that I can't grammar.
(I can't math either.)
