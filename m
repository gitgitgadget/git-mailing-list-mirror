Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B5AC43219
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 15:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiKBPvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 11:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKBPvV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 11:51:21 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186932AE35
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 08:51:20 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id p141so15354702iod.6
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 08:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nrZvOHVCipZCTcHel84tE7cdq+wAY6HrIK381XFeqi8=;
        b=1vdqsqjk41jcbO8g53mnVgwwQOWITJsfG8QSXLjvxlz5mCg/UA2NxLbQw/8z8OOQHQ
         VrayT/gUZYhlr5CFgd6Lg2bwMW4y4WISN8h5kMjGCmEwBLu2aWF/V64wqBANY6SS8iGR
         t5R/s80UgmesHBoBjRUCHxiJhO3L48ikIVb0uiLk3uAVHAXUTeIxCPHnbcpEgTspjP7L
         YO8FACMQMTN3uQej53QSz3hzmUzzbLHX+xwZrY5YzTP2W/nRwjkUevNWEcDvS/C0n4M2
         XBFadVdt2gg8dL+2GJefXcYR30JBawpmHwo18eSMGmd4atlG+x3/fu0XGZYZ5C7MgkXd
         H0kA==
X-Gm-Message-State: ACrzQf0D5EM1b2uiQmw+kxyVjhr5M8sSXclgilsfYIWorUKgunQwKHu/
        RSq0GPmbZcbIqcXVLClW0Yp50+hd1QWW0eLFW/wyipJhpsE=
X-Google-Smtp-Source: AMsMyM50ym4WRhJVt2AnB+h20DovaQl/NeaiIFctdoFdFja8MUoPwELysC3flhLmbkvBLvhUErw0mmvLF5iLqSKQ5Dg=
X-Received: by 2002:a05:6638:134f:b0:372:8558:1e34 with SMTP id
 u15-20020a056638134f00b0037285581e34mr15277425jad.285.1667404279249; Wed, 02
 Nov 2022 08:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1396.git.1666845947898.gitgitgadget@gmail.com>
 <pull.1396.v2.git.1667385022103.gitgitgadget@gmail.com> <CAPig+cQ2Tqt8rzvXsRjCsPFTkbq7B06gq2pourKXi5dKNx8oAA@mail.gmail.com>
 <CAPc5daXmnkGpScihLpTPDXEFOAQF0vm-aWOpeym90X=tktLC2w@mail.gmail.com>
In-Reply-To: <CAPc5daXmnkGpScihLpTPDXEFOAQF0vm-aWOpeym90X=tktLC2w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 2 Nov 2022 11:51:08 -0400
Message-ID: <CAPig+cRy66HNfTnNQC4PcAaMR-m-DwUbdETsy0zBX4saG7F4Ng@mail.gmail.com>
Subject: Re: [PATCH v2] Mention that password could be a personal access token.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 2, 2022 at 11:45 AM Junio C Hamano <gitster@pobox.com> wrote:
> On Wed, Nov 2, 2022 at 3:55 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > How about a different approach, calling it a "secret" first, and then
> > defining "secret" as different names for "password".
>
> Or more directly, say "password" and parenthetically add that some hosting
> sites may call it with different names like "personal tokens"?

I tried the parenthetical approach first but the sentence structure
became too complex and more difficult to understand. Having a separate
sentence helped simplify. That said, perhap something like this?

    Git will sometimes need credentials from the user in order to
    perform operations; for example, it may need to ask for a username
    and password in order to access a remote repository over HTTP.  In
    place of a password, some sites may instead provide a passcode,
    personal access token, OAuth access token, etc.  This manual...
