Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957EEC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 687BC60234
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhJ1SuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 14:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhJ1SuA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 14:50:00 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4E4C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:47:33 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id i5so5087244pla.5
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i5H42xW4SmqaeHveVxbb4ZIU0VM1XOIHDW2wKIhIrcs=;
        b=drkHP3vv5K2KHKZxP/esOSslTNS4oOcPheLGJnByHBBilcwrpoRWdPTG4GdFB/ImTa
         VnoZKmFEl7PPraa17SrWjPzd+I+wqEE77bnIsgl0+0XL/UYoFTkePEGxAzHPz5lz5W3Q
         iYjxvhFPHzV7Yeg7hovf+oz1Kpq6GlcPzU62BF8SVVdcx9IPv0NPmCZTzYKcwC5JTXDA
         hq3qbKT2L4xY1jPDLt5hk/gnac6S/nOUX8Ly725/JJu2kdCSAo5zjrc8eeF8LikR0tH9
         NxNQ9WK5B+ElX3tydexcogr3RhEeulU1PUm7aYNoqec9R7/oOE0tLxfldD9o9VrPe2WX
         NHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i5H42xW4SmqaeHveVxbb4ZIU0VM1XOIHDW2wKIhIrcs=;
        b=WIYArUrqtmfVlkl0+lHffGRgN9jPBLcCadBRd34b2lxEV+TdysO/Tg2NgRjgvJiMx1
         6loLlTxqHvbIbCWe08uQBwmXEPTW4gishVCRUC4K3NQkUk6H4P3siabb/CxF6AZP5H5v
         AFo8RunVlaIervt27S2FcYMFwg9GYYNwd4abUDeHQyyP6H1NBT6N8PxfjPl2oRQBYGaU
         +/EP0X/hqFvRq29znUT6s3Ix8NrEvlzwxAFiedS5jZUvIaAdEBFVlTkKcbjtYPNZZtWP
         5rj/lG6WsuTYGhVf5GkQHct0Lp2JLHJmMNnxllA12WtzMMpPo4tReqF7MOyE+uFqqL4M
         Ehug==
X-Gm-Message-State: AOAM532dg/lSkNJADB4Y4j/uednA8ivq9FVUo8cEEJTCqyVyNjAy2Lvl
        Q4zjg0UUGe93pnEhZkNRDyTvkZGS07yiKn+E1HeimFMMaco=
X-Google-Smtp-Source: ABdhPJzqHjxRGcX+P6r0u8tPop1fjqgEoNCoVF/p/oMseFj62MC1xp7wpCzWDa4Rl7tBGtQFnIQAIj3YzXvKJ8d2nEs=
X-Received: by 2002:a17:90b:2412:: with SMTP id nr18mr4391546pjb.233.1635446853387;
 Thu, 28 Oct 2021 11:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
 <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com> <984b6d687a2e779c775de6ea80536afe6ecc0aaf.1635438124.git.gitgitgadget@gmail.com>
In-Reply-To: <984b6d687a2e779c775de6ea80536afe6ecc0aaf.1635438124.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 28 Oct 2021 20:47:21 +0200
Message-ID: <CAN0heSpHfCNLL3X=eLQMe6RV8mtNq3pYEZYohc4HqzfnP1tdsw@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] doc: use only hyphens as word separators in placeholders
To:     =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 28 Oct 2021 at 18:22, Jean-No=C3=ABl Avila via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> -       It is `<unix timestamp> <time zone offset>`, where `<unix
> +       It is `<unix-timestamp> <time-zone-offset>`, where `<unix-
>         timestamp>` is the number of seconds since the UNIX epoch.

This still effectively has a space -- it renders as "<unix- timestamp>".
You'll probably need to rewrap the lines a little to get rid of that.

> -** 'separator=3D<SEP>': specify a separator inserted between trailer
> +** 'separator=3D<sep>': specify a separator inserted between trailer
>     lines. When this option is not given each trailer line is
>     terminated with a line feed character. The string SEP may contain

s/SEP/<sep>/ ?

Thanks for taking on this large task.


Martin
