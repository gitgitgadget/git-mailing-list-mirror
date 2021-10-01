Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0821AC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 06:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE3DB61452
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 06:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352243AbhJAGdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 02:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352321AbhJAGdb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 02:33:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37992C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 23:31:46 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v10so31164105edj.10
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 23:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P1hA9K3EHb4rfLKOx3xWrpdvGhd9YO2Jgubm2INk9F8=;
        b=EBnNtJBa4pijwft0a+P+8jMmtRPWczxHyrSg9HP0aRRfTK3RJYeOzhT8yva9/39Bk3
         f58sgMB2pULn1Ie5NOVEOLLCu1475LgsUKJRUFhn8Cwfcv+Ky/Zrj8v95ez8MJRK2dI+
         ihqmKN4Sm/c0Ds6cu696ICA85i0C5f272SL3XtY0onymXf2NXqAbxk8OtmabHJi8qx6R
         llmdL+NQJzcL+LuKMORBibq9w4N4z3nee+kh9Gz/icOIKtUPuBU6iLaZXfV3pbuA7bb5
         O9S5ydOFmEKZCCRmjKuWZWGnc0T2UD58WHg+ssRJ9WTn/+bDUOtOU1vQroLlW0OXDD+J
         60vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1hA9K3EHb4rfLKOx3xWrpdvGhd9YO2Jgubm2INk9F8=;
        b=QQRjsdQpiJ6q0jEk9/YC/V8zUxnOzqbajZiQGsGcaXh04draw3QsyxD72jmlcLNjK7
         HBoj6VGDEZF9xAE99Fn3Wez5LbtqYWoCDYsG5k3N7d3OForrhAxYsqSZLig+koiRRzo/
         I2tCud4a63maRZE6bSsbzAJy0WHBDH/1Sk8Lejtgh4Gp9lZfXJ+bkMYlsZZ4NEGAcWmX
         SK8PxeOxtDKophT0XS/iSNlENav+3cnpT7wrWPs0HMEypeeyNEasT+PFKmAumqv52eN2
         /BTzUJD44jYZ/adPq6X6M1F2mWE/v2Juc+c0vLZpdTG2git41EiL4EH7XfzWS6fYbpEb
         MHow==
X-Gm-Message-State: AOAM530guLHINbKnVJV12AmOPz/RL9D8pDKjbcI143VySQa51HMisa4H
        RBILPptMghjQEIWWokwYvuzPec4RLvTr9r+lSwlxBOWfNhg=
X-Google-Smtp-Source: ABdhPJxSiEwFpp5GfIIqOcAIdPYh7gbkbmJ62mMJfHxbQ+FHHNJUTkdn4vs8VmJOicCMTff+wmegU+QClcWobKig7C8=
X-Received: by 2002:aa7:cfc4:: with SMTP id r4mr12205519edy.244.1633069904399;
 Thu, 30 Sep 2021 23:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh7e18soj.fsf@gitster.g>
In-Reply-To: <xmqqh7e18soj.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Sep 2021 23:31:32 -0700
Message-ID: <CABPp-BH2C5HFw_=NtK71oNGXkntzcJd2un0TgMb=UnJ5yJxAAA@mail.gmail.com>
Subject: en/remerge-diff [Was: Re: What's cooking in git.git (Sep 2021, #09;
 Thu, 30)]
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 6:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * en/remerge-diff (2021-08-31) 7 commits
>  - doc/diff-options: explain the new --remerge-diff option
>  - show, log: provide a --remerge-diff capability
>  - tmp-objdir: new API for creating and removing primary object dirs
>  - merge-ort: capture and print ll-merge warnings in our preferred fashion
>  - ll-merge: add API for capturing warnings in a strbuf instead of stderr
>  - merge-ort: add ability to record conflict messages in a file
>  - merge-ort: mark a few more conflict messages as omittable
>
>  A new presentation for two-parent merge "--remerge-diff" can be
>  used to show the difference between mechanical (and possibly
>  conflicted) merge results and the recorded resolution.
>
>  Will merge to 'next'?

No, please mark it as expecting an update.  Peff made multiple good
suggestions in his recent review:

  * Modify the ll-merge API to return an enum status instead of
printing warning messages about binary files, and let callers handle
it
  * Replace the new auxiliary files containing conflict messages, with
auxiliary diff headers containing conflict messages
  * Do something different with the tmp-objdir usage or use
pretend_object_file().  I'm slightly worried the latter was only
designed for a few files that all fit into memory, which may not be
valid for this usecase.

And ns/batched-fsync now semantically conflicts slightly in that we
both extended the tmp-objdir API in similar but slightly different
ways.  So that needs to be worked out...
