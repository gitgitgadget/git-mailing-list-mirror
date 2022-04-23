Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EACC433F5
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 23:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbiDWXuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 19:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiDWXuX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 19:50:23 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7182AE0C2
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 16:47:25 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id y74so2221931vsy.7
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 16:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hoP+8/4MHCATeBq6vqaChLIjzrrvcq5IT35Cy+g69WA=;
        b=BJryoLckTLUfJcaTAxoANyfEYacMdrjQN904UrYGl/sto8Q8JedP7Kl/epsmnnvy5o
         pj5J1we7IsU1/CiBYiCt3a8Fcw3UfsyUbV7K+qL3olaZF74Uz4c+RLM1no1IEEWy6VTD
         2Dw3h9mkroZ6P5n2TRmsrBvVhCBLJCK+oFW7SudC47s3SHE5i5nHwkGgxuBRc9XopLuY
         nWRYYgI9X7qNVA6+A4MZI39Gy0MZk2D9icfL8DGtsQsR2Kf31DM2BBVLLnNP6ThY2Rk4
         mLdRUPKSXJzG921L7WfP6EzsYPZgDy3EHkptWBkwpfvrsxGQO2HhEkI7bzHnl49To3pd
         NRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hoP+8/4MHCATeBq6vqaChLIjzrrvcq5IT35Cy+g69WA=;
        b=0XepWUzyFQ/Y7JdbM3ih8rQHL8/ZcXCRUiKfGHfptkfNlCDb9gyvvKhNxcBB9G6QYJ
         PZNRSFu9kZKHxYKo+bifnp0q4wFUXM5/C5rBAPnqeRNmUgcvJIYwAqv3hF1qn14ouq4Z
         0Qum5KyjitMsgpsFmldLS/CAbyL/ZqSXl8fJ2pdTospMTjb1OzeBthOAnXSi5AaDaiPj
         wM/M+YUgQmQKbZNjKBAvVadij8aj5y7HwcYgeojqcHfdVelvn7PO4N+PW9jltwL5euh+
         j/LUbEZc+ayeHOVMAAWndI/eSxQmfpjbWzyWE5XUkyHBSGoL9tAiVg/29vY+ydqYlR4d
         BItQ==
X-Gm-Message-State: AOAM533YSgu52jyynPxoCxjYMfWoekOvrDj10q/WtKUVmu7epZrSYLwJ
        LpE8CUlV179UwunZdQEEchx86She3UySuOnSIE+BoxoIgw4=
X-Google-Smtp-Source: ABdhPJzL+/+kCDH2l0JnWlbxwwy0CSSRR1lkQcEO0J70HvA3FzH9fIQhictNnTWJgjwHeONNr1JdFdtGm3299QoUVb0=
X-Received: by 2002:a67:fe01:0:b0:32a:122f:ff67 with SMTP id
 l1-20020a67fe01000000b0032a122fff67mr3164922vsr.52.1650757644552; Sat, 23 Apr
 2022 16:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <patch-v5-10.29-07e36035a1e-20220421T181526Z-avarab@gmail.com>
 <20220423201129.34133-1-carenas@gmail.com> <xmqqo80r1kid.fsf@gitster.g>
In-Reply-To: <xmqqo80r1kid.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 23 Apr 2022 16:47:13 -0700
Message-ID: <CAPUEspifNjJGaXZckBn16tfiR07gfEKZt2-Euz=+3Mt0rWZL_A@mail.gmail.com>
Subject: Re: [PATCH] fixup! CI: move p4 and git-lfs variables to ci/install-dependencies.sh
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 23, 2022 at 3:59 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> If p4 and p4d were the only files that we grabbed for macOS, then
> what I wanted to suggest in the previous message would have worked,

true, but it can still work by making them both use the same version
(which would be likely a CI variable) and pull the three files from
that directory (which was my end objective as shown) in :

  https://github.com/carenas/git/commit/4fd79fa1770bc9e8e57074dbac4e44de173aeb75

> By the way, I spelunked https://filehost.perforce.com/perforce/ from
> a browser to see how the files are layed out over there, not cdist2.
> I am guessing that "filehost" is the name they want end-users like us
> to use when downloading what they distribute?

I presume that was the URL they were using when this code was written,
FWIW brew uses cdist2, and that is what I get after going to their
website at the end after clicking through their download forms so I
assume it is less likely to break as well.

agree though that renaming the variable could be avoided but it looks
nicer as an intermediate state, and we might even keep it if having
two different versions is preferred :

  https://github.com/carenas/git/commit/b6699fa3f082ef6d0e8c32718ce5142612003de8

Carlo
