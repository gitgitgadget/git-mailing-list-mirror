Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51308C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 09:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbiA0JoW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 04:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbiA0JoV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 04:44:21 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F6EC061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 01:44:21 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id c10so6932764ybb.2
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 01:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o13a+UHF8dQqefW2Vwua3VDqMkAlx+MasKiWfBc1Ivc=;
        b=My51HMFo93+m/61qRex1mJeNOFoPowNoxjfgDhgTlzehJsgU89jtXigU4Xa1VKLtJS
         mn27+TtifhUvPFTvicgJ97bQ8DOqC6NlzEyAOkPzIhPQw9no8SxjHVYLOL1pW7GfX2I8
         UZilG/ZJ1cpg8Fzf/4bJS7VmwKaLSmozEY7SQ7I422eZNLQPM8FF0AmdLv9o6rv0I8gX
         TP6gOd0zo//FncTz/G+KhV6cYLsaGyWI8b1N8QArjX2y80L3h9UOV4GQQje/xzLI9ZN8
         ouVHI4yhrEEyJ1Ww7fHVAdG6HQHY+2Ujwi0DedqR1G4Yk8isHZXAx0swirgJiRQRj/mj
         36SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o13a+UHF8dQqefW2Vwua3VDqMkAlx+MasKiWfBc1Ivc=;
        b=q+95toOIwMPPOTVryo2h5RHUULSNCERjMROBf0/mUcshfGjk6sPydCBh42IypG+Sao
         gRZVX1nLq4M8sKSMvD9Y6ca/myLxfHnaBDWpmNtW1qeDsqfERH9qG+fv2uuCW3Xwa0DX
         7cjW8gT62jIdpk3Azb8M5vjB1fs7kbv0RHPunOmSEjV/3jrx0nWOrzxqEwCxTTDeK3de
         XLht5ZErYvvI7pGVvL7+LljkfdsbY0wRIQ09ydxb8j+1h139w3p9V6khDa7nks2w+oKp
         vWexufN9HH4W7VrwMYIvikNH62zI86pwYkUaiv2tUCu3GoT+4WpPiKuVc1nNth182YDN
         WJ0Q==
X-Gm-Message-State: AOAM531aymT1S8cuob3RfpoS5sEYcB2CcoMwAQU7cT5Tiy/zE3xhek06
        D9NkprQ57km5yrIorXrVuZ09tjyOWOLihD/lAyjEhio9Iz0=
X-Google-Smtp-Source: ABdhPJyVnGUuvEk3zePBEBOcxA2WPRkGBr/Cyxkqm2HGaBfRI4p9JDwlFd2B11ljzC9ZyBgV6+wLKA0ybbteVvXvA4Y=
X-Received: by 2002:a25:b296:: with SMTP id k22mr4633702ybj.50.1643276660722;
 Thu, 27 Jan 2022 01:44:20 -0800 (PST)
MIME-Version: 1.0
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com> <9d2e58ab-2d8f-0797-84ed-0c1e8941edaa@gmail.com>
In-Reply-To: <9d2e58ab-2d8f-0797-84ed-0c1e8941edaa@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 27 Jan 2022 10:44:09 +0100
Message-ID: <CAP8UFD38WDwMKf3tMKGt6hMxmsuZk2JkDRJaOZsXFqHvbVLRLQ@mail.gmail.com>
Subject: Re: Git in GSoC 2022?
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git Community <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 27, 2022 at 4:55 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 27/01/22 01.29, Kaartic Sivaraam wrote:
> >    - Project ideas: There are two mentioned in SoC-2021-Ideas[3]
> >      but both were picked by GSoC students the previous year. So,
> >      we would need new ones this year.
>
> I have several project ideas:
>
>    - Document the "binary diff" format. Right now we have documentation
>      for all diff formats used in Git, except for binary diff. Hint:
>      read `diff.c`

It seems a bit small as a project idea. Also we usually propose code
related projects. It might be a good one for Google Season of Docs
though:

https://developers.google.com/season-of-docs/

But I don't think we have ever participated in it.

>    - Rewrite `git-request-pull.sh` in C. Currently the shell script
>      implementation hard-codes message template and only outputs to
>      stdout (though can be redirected to a file using shell means).
>      In the C version, message template can be configured (with the
>      default is same as current version) and introduces new
>      `-o/--output` option to specify output file.

In https://lore.kernel.org/git/nycvar.QRO.7.76.6.2001301154170.46@tvgsbejvaqbjf.bet/
Dscho put this script in the "Probably better to leave them as shell
scripts" category, so you might want to explain a bit more what would
be the benefits of converting it. Also would you be interested in
mentoring or co-mentoring a GSoC student working on this?

Thanks!
