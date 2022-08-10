Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB6BC19F2D
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 01:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiHJBGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 21:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHJBG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 21:06:29 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F248552E45
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 18:06:26 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso9645795otv.3
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 18:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=D4FlIkkXrCdtcdNqEwFDRzGtpFjLD3HtkJQ+kMg2fjA=;
        b=VyHExGimGTv4YFxzNjHUPBzJMBsoCxwFtnEC/0XnvjRJYq/UZZLMuBQSPXT9ISvzYT
         KHFiGnmes68JK7OuG3Wo/nsKSvAwJhVBapmtTVhuGhZF+qyDfO/WDPs8CZ3a/S8AdkIv
         GtCVbPWjyu9i38kD9WQ5u+Xx2VXNNP/x+MSzVt+7Bq8acjaxyU5+/moraOJjNixFUw9+
         xJjTvjAhyB37cmBQuepI+y83wV0JFIrXd4lsGKPGgfAQn8B+ctn1tNpUp+pQ6eu+XQRt
         D2SaLFL0Al+BqJK3pxCNos9bfZa+ZANTiG6vy7Lb95XGRcPvOFegVEzhBuSV5Ib4Tr+A
         9C4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=D4FlIkkXrCdtcdNqEwFDRzGtpFjLD3HtkJQ+kMg2fjA=;
        b=uUzMx3YMhLR+FjLGmTkuoheRuskzrD4Y381vllRMyyni7aKJ7i9GvjskpDIKQRsyn1
         IrRQ81cU642hKB+tIpWWtlfI2O6/8wE6Znfig/pmkQeyqX47y930ZMM5SpQej1hc8rbQ
         WqMVt8ybr+SojFj+nTKRdisRCWQrDtlnCo47Gw7mGAChuFCxC1oDnCylL95eGKJyQFEq
         hnfPj5V/Rx2TxJVDDLJY8RPlHV4CEMaxzMhplokYMFsI6Dc/eZ8YTOkTOzmQz6Kqsoti
         ItwnRpqAhxSv4LKKqVfrIW+M5WOBK2CUfAidDRUsK/9YntlDqkuLC0W+xhemWc5b3Gna
         BkYQ==
X-Gm-Message-State: ACgBeo3gj4TVbv0o0W9Gb4+URawBHMBJ1G/fG5sgTgv5jrVn7h1pEggs
        2K5+UOcm9z0u56qCrLPvhOelm2wJ3CNWGzKnE8s=
X-Google-Smtp-Source: AA6agR7MVauPSibh8hms09y+KDBFgBCgb2caoZD5uUM1yr83FbqiOVOSP5viC83Kb0Fv7g1l5kjZpBa3IpnTptm0ls0=
X-Received: by 2002:a05:6830:2b1e:b0:61c:b444:f1a8 with SMTP id
 l30-20020a0568302b1e00b0061cb444f1a8mr9505175otv.31.1660093586326; Tue, 09
 Aug 2022 18:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1301.git.git.1659543457.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.git.git.1659543457.gitgitgadget@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 10 Aug 2022 09:06:14 +0800
Message-ID: <CANYiYbFc6xywoCPgge+RMb6Scr8JwS2f=n65XG2jupHS-w2jLw@mail.gmail.com>
Subject: Re: [PATCH 0/3] refs-advertise: add hook to filter advertised refs
To:     Sun Chao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Sun Chao <16657101987@163.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 4, 2022 at 12:31 AM Sun Chao via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Gerrit is implemented by JGit and is known as a centralized workflow system
> which supports reference-level access control for repository. If we choose
> to work in centralized workflow like what Gerrit provided, reference-level
> access control is needed and is possible if we add a reference advertise
> filter hook just like what Gerrit did.
>
> This hook would be invoked by 'git-receive-pack' and 'git-upload-pack'
> during the reference discovery phase and the commit fetching phase, each
> reference and will be filtered by this hook. Git server can put
> reference-level control process to this hook and the git client does not
> need to change or known about that.

From the document you provided in patch 3/3, the hook returns not only
names of the references, but also OIDs. Since the oid of reference
should be provided as-is during the advertising phase, it is
sufficient for the hook to just return the visible reference names.

How about:
1. Implement a batch version of "ref_is_hidden()", such as
    "refs_batch_hidden()", to turn on or turn off the hidden bit
    for all references.

2. If there is an external hook, such as "hide-refs", call it instead
    of the config variables such as "transfer.hideRefs" to filter refs
    based on ACL and operations (read and write).

--
Jiang Xin
