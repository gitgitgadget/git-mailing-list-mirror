Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6ADC38A02
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 18:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiJ2Sue (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 14:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJ2Sua (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 14:50:30 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DA6637D
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 11:50:28 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id g127so1010833ybg.8
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 11:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zk00+Jy3zPJPMvcHrkjpL6o42AukXPI29Tp/c2baC2Y=;
        b=qjJc25ZUZUM9mguCO9dQJ1qQWfoyhMvabxDVDstcGLJhVNgsspVB750Dc113U/XMoG
         CONbQRie63Sy1c0RCtovoDQ/cbJP7dcfSalhSDTWtKw2yerh5AQ5T9vDZx659G3/g2/2
         hm28DuQuOjk9Sseo4N+zbd6DllHpMWrNaBZucOrD6Y+iONW4BjDrCuuXb+vVTdz+QBIF
         5W/lLZ4MSTfX0bg3vl4OgnrRlbDFQV8ZKV2rUz+pHyx8mMp4IV81vkClrk62PC67Ev4J
         z5W70hOq4wK72g9vQp0gEnd5of65iwV0Ntn1jqM5B7VF8T4cGVgVB5NkfJ4tSZLQsCu8
         lRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zk00+Jy3zPJPMvcHrkjpL6o42AukXPI29Tp/c2baC2Y=;
        b=ZVw3yvsniUjXgTGqONgXTsuyCvsgrMmP76XarIjvpEdH94nYJ+Ftw1k8I0xBECYQf8
         nDU+mjP5vXwIF9azxC26vfTjabNYqv7NEcNJ1gsR3Gw/n+p4Ff9wke3blUKZ6XUZrfA8
         GZ4E3aeALL1JDYAv+xFluAkb9XmmGk3yAQFHOH9tqLq7twPB8DMl+lOFCCYTdJWAMX1c
         NTsmgb63fZJXuHT6eXJtfd+irqKxAc/xG5F0/LJRvH0WpoIenrsUwkwjO1xgkNy3tB1y
         TpfYEfqh4rpzG7ZWjRbNW3XIBMTHpAbVr2mvxX2QsVl18fANzWArMDSRBR2VHyqrixNL
         Gi1g==
X-Gm-Message-State: ACrzQf2bhBDXjs/9R/4Hf3RKdIzhcuHUedmJuiNlmLSakKxmTFBxomrB
        9w+TwS8yaxlOj/tccEvkhpZtv0fBnQ62ThSQeV0hSLQiYA8=
X-Google-Smtp-Source: AMsMyM7vkdocrpDcd3J0X+XR/YQQl+zj4/+ze6bWPt79nEtavekbqkQRDTKwbovbQIDEAySoCAl85MBaPdYkPAh95Dc=
X-Received: by 2002:a05:6902:110d:b0:670:b10b:d16e with SMTP id
 o13-20020a056902110d00b00670b10bd16emr5021726ybu.259.1667069427037; Sat, 29
 Oct 2022 11:50:27 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 29 Oct 2022 20:50:16 +0200
Message-ID: <CAP8UFD1wLoPJDedHryOWWbKpP=-VCUSJJcWn1942baEY8gLoJw@mail.gmail.com>
Subject: Draft of Git Rev News edition 92
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Arthur Chan <arthur.chan@adalogics.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Siddharth Asthana <siddharthasthana31@gmail.com>,
        Bruno Brito <bruno@git-tower.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-92.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/602

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Monday
October 31st.

Thanks,
Christian.
