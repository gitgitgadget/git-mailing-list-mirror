Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D439BC4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 23:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A2B221FE
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 23:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507011AbgJUXFE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 19:05:04 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:43443 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507008AbgJUXFE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 19:05:04 -0400
Received: by mail-ej1-f67.google.com with SMTP id md26so5562435ejb.10
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 16:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=prqCvu0J16uW4IJ3L9tlWruYwu3CWonVdepMoNLtQCY=;
        b=okhv+LSg4bv520HoiDDs6XYzes3R1MbW+xmCbyOIvB4Ft+EM4i99Ac7OfDi646/s+8
         T6TWTlE9x94vWmFOSWc/bgJ+fhHW/MRH2OqllN5V7oZkrcm/jh3Lj/Y7WWIvh0bZLa1v
         a6xpQIJEsM0/HLXuRfqVbAMC5R4i+muwdmtJ5iVkXg3MulRzWAH/9TImwjNYXqBHY5z0
         5bSYMOMpGNUtPLHRMfiO9FEuPquyzFXZaZzQg7iIK2JO1v0YZX5nn0uU06kOjCLTyQvj
         W/acgjrgJXt6PEkAtf61tqij868QYj6mmWVbzjqmv+683Wx3pYOaZg1i/4c6Bhosk+s3
         vOpg==
X-Gm-Message-State: AOAM53157XkZC71aMjrH3ivSbyvq4+OV1myD86q1fia/akrGw40NN+Pj
        OZPoRToa3fXxaAqne1gMl/XywuOrLQ3dBIp1pY4=
X-Google-Smtp-Source: ABdhPJwQX4YIxT0vHzGWmdk9XgQCkJLJ9azWn/mbLoGDdg8w8gBNAkJ5n9/ERg6pTiTO5/FvwgnsIgp0Iss1tzsCavU=
X-Received: by 2002:a17:906:5f96:: with SMTP id a22mr5654187eju.168.1603321501943;
 Wed, 21 Oct 2020 16:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
 <20201021131012.20703-1-sangunb09@gmail.com> <CAPig+cSi1SSZTS86-6_0gDCeDqPCEvT+Lh3gLXe--Y1PDJSDfw@mail.gmail.com>
 <CAHjREB6Agm9Nia2+e4=1zAJ6Y3NXgPQLmN_he1353ScaznK5hQ@mail.gmail.com>
In-Reply-To: <CAHjREB6Agm9Nia2+e4=1zAJ6Y3NXgPQLmN_he1353ScaznK5hQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 21 Oct 2020 19:04:51 -0400
Message-ID: <CAPig+cRLGsSzHZ-280WJD1vMLvK-kL2EEg3mc8gFiEEa8Tj6Aw@mail.gmail.com>
Subject: Re: [Outreachy] [PATCH v2] diff: do not show submodule with untracked
 files as "-dirty"
To:     Sangeeta NB <sangunb09@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 21, 2020 at 3:40 PM Sangeeta NB <sangunb09@gmail.com> wrote:
> > Another option is to have a preparatory patch which first modernizes
> > the script, and then your new tests would follow modern style. But,
> > that may be outside of scope of your submission.
> >
> > To summarize: The only really actionable review comments are the minor
> > style nits in the C code. The nits about style issues in the tests are
> > judgement calls, and could be handled (by someone) at a later date.
>
> For the style issues in the tests maybe what I can do is I can submit
> another patch with this patch to modernize the test scripts of these
> files? I am expecting some feedback from the community on how to
> handle this.

If this is a microproject, then it probably makes sense just to fix
the remaining style nits in the C code, and leave it at that.

Even if this is not a microproject, the answer really depends upon how
much time and effort you want to devote to this. As a reviewer, I
don't demand or expect you to fix all the problems in the old test
scripts just to get the change accepted which prompted your submission
in the first place. It's important to focus on that first rather than
getting sidetracked working on stuff which may not be important to
your primary goal. Also, keep in mind that fixing all the style issues
in those old test scripts may require multiple preparatory patches,
rather than just one, and multiple re-rolls, which could end up eating
up a lot of extra time to get it all polished properly.

For these reasons, I'm inclined to suggest polishing the current
submission to get it accepted. Then decide afterward if you want to
devote time to working on these ancillary tasks.
