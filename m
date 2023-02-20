Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C15CC6379F
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 09:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjBTJ7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 04:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjBTJ70 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 04:59:26 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AC11556F
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 01:59:25 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536a5be71a8so21876717b3.2
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 01:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LfMHPEY04d5M5pq+9Gj85wt89lpXl7uQO3PT9y+4l4M=;
        b=POu9vM97x2OBuI4QJHWG7kV1nlE2/5pXc/A9vo2EhsmQG3CMUSL99v/lGkvboZXgOX
         /A4I92D+d64Qa+UAHvQiKEDZX4Jt+eGsl6NpMprDtZshq/oZMEt0I+nJCqi0CuieY5oz
         UGiL0S1GzIWxldvpBo5dd7kY3lNoFIVGhoPrvQFgwROkB++aG5VE2ZT830n++uhjROyX
         LwlQCWPdRlGLAqq/i2pTmg/7zSsKXjkccCYHvyygNe7i6SwZVeq06Ag1+Z0G8/qUsGcM
         r5+8gvyWjY03YtiRrs/r1nAP7PTp8paXYig09s5or+bw4KdIIaFPd83HkrcDc/PtR2g2
         G6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfMHPEY04d5M5pq+9Gj85wt89lpXl7uQO3PT9y+4l4M=;
        b=pQ3USQ2/FbwWlc0CrMhVe0T/UOO7fzg435xcoMDpxKmj5EJ6dIpfsMJculv6v6XOfm
         C+/Wx+cshV7bg1TOxfD3P4g86qeDWfByw+p5GmHGKx4rw2BOR/oFCGY3g0VPu8Al8/gq
         qhSONnryZVsACpyGmrhkHh1fMO8tNIH3nmFBXfsxHP3rp+synxnLBt9rd9CbFy2NGykB
         h7b+LkjkzdICPgYakpHkdezQdBOqwTFEXo+CcYewrx+mMYzf4SVBwX1+SXPDY/qqmQ2E
         +GPVnJ4Fa06Cwt9GT6sXiTX9MXDd9K4umH/JclgkqU+3ErV6nKAcQkEDFI//W3zvOfQY
         Yt3A==
X-Gm-Message-State: AO0yUKVBwGCURCaj742SuQJjLFWc5b2YTZWpNqYJbbTunFVRU37xe97/
        xX1k2LkUxZl3//XmgHDXU19p2cRoO8AZUednP2E=
X-Google-Smtp-Source: AK7set/X/bxZgpvf0t1FsFa0vnn6iMwy5CeVCEBDJmJYGNGCRkQxWZkticaMPRo10ztJ/lGSpItPL1slcvQbdNE5xXM=
X-Received: by 2002:a0d:f8c2:0:b0:52e:e6ed:3097 with SMTP id
 i185-20020a0df8c2000000b0052ee6ed3097mr85860ywf.535.1676887164241; Mon, 20
 Feb 2023 01:59:24 -0800 (PST)
MIME-Version: 1.0
References: <BM1PR01MB3139C97DD4B99D3024847874FEA79@BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <BM1PR01MB3139C97DD4B99D3024847874FEA79@BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 20 Feb 2023 10:59:13 +0100
Message-ID: <CAP8UFD2gtdeaJ=9_DSC4knHiyZk2TeVEq8H_XWA4sdNVEqdhUw@mail.gmail.com>
Subject: Re: How to find places where I can contribute?
To:     Divyanshu Agrawal <agrawal-d@outlook.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Feb 19, 2023 at 3:39 PM Divyanshu Agrawal <agrawal-d@outlook.com> wrote:
>
> Hi!
> I want to contribute to the Git project. However, I'm not sure what I can
> contribute to.
>
> I'm used to the GitHub workflow, where I would look at the "Issues" section of
> a GitHub repository, and try to tackle bugs / features I think I will be able
> to work on.

Git was started before GitHub (and many such platforms) existed, and
we still use a mostly email based workflow, even if we do use GitHub
and other platforms for some things like code hosting and CI.

> 1. What is the equivalent for the Git project? How can I find issues/features
> that I can work on?
>
> 2. Is there a way I can find bugs/issues that are likely easy for a new
> contributor to pick up? Similar to a "good-first-issue" label on GitHub?

We have the following documentation:

https://git.github.io/General-Microproject-Information/

There is also the microproject idea page from last year's GSoC:

https://git.github.io/SoC-2022-Microprojects/

We haven't updated it for this year yet, so some ideas might be
outdated. It might be a good idea anyway to discuss a bit your
micro-project idea on the list when you have found one before starting
to work on it.

> Based on your responses, I can also update the documentation, so that others
> like me can get started quickly!

We do use GitHub (at https://github.com/git/git.github.io/) for our
Developer Pages (at https://git.github.io/) where we have a lot of
useful docs for developers.

We also use GitHub (at https://github.com/git/git-scm.com) for our
main web site at https://git-scm.com/.

If you want to contribute as part of the Google Summer of Code 2023,
it's best to say so and to add "[GSoC]" at the start of your email
subjects.

Thanks and welcome to the Git community,
Christian.
