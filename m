Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FDEC3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 11:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjANL00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 06:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjANL0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 06:26:24 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34654768C
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 03:26:22 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id s8so8750996qkj.6
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 03:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2tvMt6S9KS/QSezmFHphCkTTdWfnjMCnoncoeKxRvI=;
        b=KEI9jjEQFTWiekBZKesLlIDcCsw5jAyfjWCLE1Q8rSmBMo09afHdsliJ/hPY9+f/wW
         sQRgzrAcE/qkRZvyeTv3v6VoNtManfmm8g4E1FZMuQIpFYTZGx0HfFZI+UgN6np7SJG0
         A4Sy5esE/e8f8GA6nwmQO0cW3GQqYFeQQee8EHweGS3pVC2japKBc0G6FefWwjfvMq7t
         xRiMiK+0T0VnsQavImATgpfXNjMNUx3JtiUuKwStP3j/UjRxVZsJwtXhYe07oyOtP1S6
         0/jppKjLKfSfUhWew6FjWU89TtecYsEDjundPjqUj41kMxVpkd4cbfnbj+vvZcFGi0Bz
         Njcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2tvMt6S9KS/QSezmFHphCkTTdWfnjMCnoncoeKxRvI=;
        b=kyfWKR/CP5mHMl/X80gfeiQGa5goCSVNrolYNKMKflPCtJ98p5WixJIIz8AZfhRE+9
         RCuf2IE1Sh7R89Zfoo7j9lGlpSgLZaBi+vo/9HFA5uuuhE7tP7ZoYBL1JwIAJQSKA5Ll
         CrhGxgfOevH/K5Ob1x0UfgMpu30ockFyNOS6FaxDV04FmVL0WB96nJuhUsPPR9oXYptz
         4dW8+THdMq3K6Rnd2NSKnu9nAfPme0OtUTdqRj8fIB/P7ZGcZfdlF7YzthWhx1agJMJv
         TUZC8W5cUfQ6gBbmhzgyvrgh2ULwFn2joImd+ONs38YR1OFV04woljGv7yVhZgxjUFvf
         xGcg==
X-Gm-Message-State: AFqh2krFkvroPp85i9jP3tZ8u3IizlaFjVXMK+b+/BZtPqR9BeIWHfY1
        NIOnjprv3hY9T6XdpNbIX+oc4fEW/MJzoeRiLCrxMpg=
X-Google-Smtp-Source: AMrXdXuwEIonMxaerrxWApcxZk1Og2+R4HPcrw2Tr47z69Dn/4G4wpx1SEqwFG+xNIIsbXHznfEnJDanZBqHd0Be7R4=
X-Received: by 2002:ae9:f106:0:b0:705:28bf:f040 with SMTP id
 k6-20020ae9f106000000b0070528bff040mr3408517qkg.203.1673695581090; Sat, 14
 Jan 2023 03:26:21 -0800 (PST)
MIME-Version: 1.0
References: <CAJGKYO5UGmFZjZ2ucFY=1MojzVur69EjRgy=aWW7wnhZ6=DaVA@mail.gmail.com>
In-Reply-To: <CAJGKYO5UGmFZjZ2ucFY=1MojzVur69EjRgy=aWW7wnhZ6=DaVA@mail.gmail.com>
From:   "Roberto A. Foglietta" <roberto.foglietta@gmail.com>
Date:   Sat, 14 Jan 2023 12:25:45 +0100
Message-ID: <CAJGKYO5yROvp44SQxgD-nJ0D4MCF2HKETB3Bo+YhYJWPLXaTKQ@mail.gmail.com>
Subject: Re: git.functions to improve the git users experience in your bash
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 5 Jan 2023 at 18:50, Roberto A. Foglietta
<roberto.foglietta@gmail.com> wrote:
>
> Hi all,
>
>  today, I have published this project which aims to deliver some
> advanced functions for git and also a lot of smart shortcuts for the
> most frequently used git commands. I hope you will like it and
> possibly also contribute to its future development with your feedback.
> At the moment, the project is limited to support bash. However, if
> someone is interested in using it under dash, I will be happy to plan
> a porting.
>
>  https://github.com/robang74/git-functions
>

It is available on the 'main' branch the v0.4-rc1 for those who like
to try it. I suggest not installing it but just try over a spendible
repository, just in case. The README.md lists and briefly explains all
the functions that wrap git.

Best regards, R-
