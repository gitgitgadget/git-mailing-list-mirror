Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC43E1F576
	for <e@80x24.org>; Wed, 14 Feb 2018 09:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934884AbeBNJHp (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 04:07:45 -0500
Received: from mail-ot0-f177.google.com ([74.125.82.177]:36446 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934695AbeBNJHo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 04:07:44 -0500
Received: by mail-ot0-f177.google.com with SMTP id m20so19786228otf.3
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 01:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8z481QuFCEAN/lTQKj423mXe4St796R8CvQtb43S+/c=;
        b=eBlye/czxWAPY1cpq1RuvJtfSnYicp1eZCV5CKQwPlwSVC83QlSw/J/19Tr8DG6bvq
         VoPnR3UaN2zGgMhS3HWVBN040KqYfdnNf+2LEEQDJbGJ3OlnITGFg5tQ4Q+y6s0lc4RJ
         NVExoQMlwJDD7dRXBp2merKBghgj8Lx3gMWsoeKiz0bOEWzyyib+dAyImSjo/0bfLArc
         IvwxN+dM+9O7Mw++o6OcASdPEMSPKMx/HAuPIApAStRcXDU5nK68I9I1VEge0zzrPGjr
         qr6riBLyP9DbNNfQjlLb1LABn8GQ63wxQxI6HviGHhKD6MTwwkzzNPkMVeJywaU5V4Rl
         THIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8z481QuFCEAN/lTQKj423mXe4St796R8CvQtb43S+/c=;
        b=rutLVPtQrPr1O2WBxiMNloFKmv3Q9aZzIYgfglWO4gYTKK+B51LtduTiQ9+mn4T99n
         xZewuN6lTFYIgHe4RXlNRxIyaf8EHm7rVk51QRDMnajG/9LlP3OPqnIPEPJyTYC90A/Y
         w+7iWmMkEuM80gdN9qzOlQrFF/T7bIoa1uUm/C3Y6RZnDFqo1vvo5/kC71friYW57w+8
         ccGEl84fIUXpwDDzolwa83eYYiz1Ri6g32W2dn3yVIjDVJmGWZtwbgFO+JEy0Rrxc1L4
         6RVB7Zj2aCCSBq78jbVw6MMcf9I84Fpvggx8LAgGdm6locrMqDWKLYAmBVsLqr+YpJdQ
         ygqA==
X-Gm-Message-State: APf1xPCO40YEuN0tu8esNxivBwRRw2T0ljShoNXG+6m7IdtwsBhxFu0u
        e+Zc9s6FKVcvxkD5arwUscDRADFS2KhAK1WfbyI=
X-Google-Smtp-Source: AH8x2257pg4/B2R6SYTT51PxYJt5pjlE45VW78HZFWgKCY1m1CN8JMx0CISuQhzF7XrZqvCg5TxW0fG1mqVzAkPkJyc=
X-Received: by 10.157.2.8 with SMTP id 8mr3148056otb.106.1518599263404; Wed,
 14 Feb 2018 01:07:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Wed, 14 Feb 2018 01:07:12 -0800 (PST)
In-Reply-To: <20180214031614.GC25188@sigill.intra.peff.net>
References: <20180124095357.19645-1-pclouds@gmail.com> <20180124095357.19645-4-pclouds@gmail.com>
 <CAPig+cQeQRppb2y4YyQnqWWnCO0TXE-PjfTAhxakCJNk45ec1w@mail.gmail.com>
 <CAPig+cRYL6-jEgsQoiQokNSd0zq5zoFkMHBA0Vp9kqa0LvMnsA@mail.gmail.com>
 <CACsJy8A+zMTC2N8Y0Ua-KyLF6Wp2oHL=8mbsSXck6mKZGG=37g@mail.gmail.com>
 <20180206021313.GA26323@sigill.intra.peff.net> <CAN0heSofAfuXEUKcfF00ni_a7nAKJYySF_UEnNTL8+nHiBzw-A@mail.gmail.com>
 <CACsJy8BjFex==2UQV6-k4_rTnBijJOzBAOmtNmZopc87U19Jmg@mail.gmail.com>
 <CAN0heSpxcm1a9KN3etWAD5Vc_gkabQmEppa_1P4soZSZOnP8pg@mail.gmail.com>
 <20180213002758.GA9274@duynguyen.dek-tpc.internal> <20180214031614.GC25188@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 14 Feb 2018 16:07:12 +0700
Message-ID: <CACsJy8B9dRshT2RUhnNLbnwTY0VdVdKP9A_YGxwiqqAyMN_OAg@mail.gmail.com>
Subject: Re: [PATCH 3/7] worktree move: new command
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 10:16 AM, Jeff King <peff@peff.net> wrote:
> Hmm. That is not too bad, but somehow it feels funny to me to be
> polluting each test script with these annotations. And to be driving it
> from inside the test scripts.
>
> It seems like:
>
>   make SANITIZE=leak test GIT_SKIP_TESTS="$(cat known-leaky)"
>
> would be sufficient.

And all new test files are considered leak-free by default? I like that!

> And updating the list would just be:
>
>   # assume we're using prove, which will keep running after failure,
>   # and will record the results for us to parse (using "--state=").
>   # Otherwise use "make -k" and grep in t/test-results.
>   make SANITIZE=leak test
>   (cd t && prove --dry --state=failed) |
>   perl -lne '/^(t[0-9]{4})-.*.sh$/ and print $1' |
>   sort >known-leaky
>
> That would update both now-passing and now-failing tests. Presumably
> we'd keep it checked in, so "git diff" would show you the changes.
>
> -Peff



-- 
Duy
