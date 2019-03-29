Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8290020248
	for <e@80x24.org>; Fri, 29 Mar 2019 11:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfC2L1c (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 07:27:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41134 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbfC2L1c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 07:27:32 -0400
Received: by mail-io1-f68.google.com with SMTP id v10so1412919iom.8
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XB4TY7PWo2tdfsAWoECgg6cYtRVMKAV+My9+I/jui+U=;
        b=hyR1MPFR4oP5lFh6c5AjfzhTeIxoA7hw3/8dvHd7//cGbOHiNkPMVagS5Qh9h+TAcZ
         FiU+UmOi3ScBN9GoYHsbb8styNXL1kc1e4ydjZixqhiMp5ihxYW4r1qG89sgXbLk5AI3
         l0GMcWxYp/quRBpXxbNr9wNqrkPNVY9AGXXqW4A0xa+qjk5SvaI3eFyHyVTqW7yw7zlm
         ZZQovKCErUkhMaFm5WVo7hszRndEnBTXkeY+q+/ktcHZArjcJ9uOy/HKv7RE9tIfXIF1
         oW6OnQCeGI3WvVamj4RkUt3fVjYoWOpGWKKlKw6x0QIuiRj3aB5aXFku8tGPCGqdQPRT
         oYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XB4TY7PWo2tdfsAWoECgg6cYtRVMKAV+My9+I/jui+U=;
        b=Y5AHK6kAllZtTExjaRjdfMDN1ycMtdi7dCfFe0EaxqdDmHn7w+VeTK9IefYRpiMflm
         9h6ZSg5FxTEDKRnBVvCAk46/zeLRzAj4N0tl1rhogQ6ColSIElimQj6FLDIx+oQWgkCh
         HfHNnk6506lLlCU1b8ftLM7oANYnkumIcB8xrIkLqiT+B74oKIx8GNor8uZYNJDakPyE
         ZlxX4QXAYW0fXNNtXCaj0qjeczThSK63NL9onZlHkk8bUt2zhi1z90XBVyUA45kBf5Xn
         RIP1KDVWA5eHVA94Xn676UJ6zoK0fOv2mA6RfyBMEoAPQUOqFGtLEhZVkuz9h4JKJg3A
         X7sA==
X-Gm-Message-State: APjAAAWsew9QuS/KEQg7Wn0vfFlqb8hjQaX9hO4rdLNmMeU0X2+Eaudb
        giyJ8SZpITTAeBR7htCF+i3uNqA5O5XCmwQ4IXip3w==
X-Google-Smtp-Source: APXvYqyWztc+eMYIDRlH9V1laF5ifprvIXizfDEgH9nWyVNh4mw0eIRQQqKKmcQvJoyGSMI8xpqv+GZN9TrCHBXF8ww=
X-Received: by 2002:a6b:3709:: with SMTP id e9mr8579122ioa.282.1553858851321;
 Fri, 29 Mar 2019 04:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=YtUvQkWriAk5w@mail.gmail.com>
 <CABPp-BEksf4SuD57YsUO3YKhU12CAwFTy6pA1tETFrHB1DAz9w@mail.gmail.com>
 <CACsJy8DPDEvNDeE5MpqcGZk9jRmT9g=ix+MOhkv+50J3Egef7A@mail.gmail.com>
 <CABPp-BFTyALWmnJ=dT1xNivjcQhtKak15ydfkYjEsEC-j4BD9w@mail.gmail.com>
 <0dc8820c-c6b0-c4ca-2107-84061fdc5333@gmail.com> <CACsJy8AmgDh1Z4CKTzSAVrywo0q-CFKbpuyqdtRm9m7pkUweSw@mail.gmail.com>
 <a68ce0b4-81c5-e889-fc90-ed8b17a10d4a@gmail.com> <CABPp-BHsD=o=3jPKH6gH+XbEdNVqzhr18BSfupbaSNpxAgaqdw@mail.gmail.com>
 <42ba7f39-4a8e-9866-eebd-2a4dd5ff8414@gmail.com>
In-Reply-To: <42ba7f39-4a8e-9866-eebd-2a4dd5ff8414@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 29 Mar 2019 18:27:04 +0700
Message-ID: <CACsJy8AVGoNvU9yC=y5BvNWQaMachD-nU-OVXuFVAw62_+mxKg@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 29, 2019 at 6:04 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > I am especially concerned with the idea of
> > having something like "git switch --ignore-in-progress
> > --discard-changes" being used to quit merges or cherry-picks or
> > reverts or even rebases. In my opinion, doing so is creating flags to > combine uncommon pairs of git commands (git <operation> --quit + git
> > switch) in a way that is far less clear.  I think that's a bad route
> > to go down, and we should keep the commands orthogonal
>
> keeping commands orthogonal is certainly clearer, if less convenient -
> lets do it (assuming Duy agrees).

I sent out v6 a bit too early I guess. But removing
--ignore-in-progress also makes it orthogonal. You could cancel the
in-progress operation and resume switching, or find another way and
forget about switching.
-- 
Duy
