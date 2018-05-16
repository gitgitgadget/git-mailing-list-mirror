Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D90DA1F51A
	for <e@80x24.org>; Wed, 16 May 2018 09:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751728AbeEPJ3v (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 05:29:51 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34168 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeEPJ3u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 05:29:50 -0400
Received: by mail-wm0-f42.google.com with SMTP id a137-v6so135844wme.1
        for <git@vger.kernel.org>; Wed, 16 May 2018 02:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=xkjIEbXyfihovdczUPbyfJ5uvAcs42aomN4NX7+xmzw=;
        b=KYU+ItS0WjFKUV9WPJyxUfvScvz5umxH9P2HbhdjqnKjOAio8tJCiBnlGiSrpbNzmP
         /eFPDsOtPSjwHLLG9JUls2G5Sq68prTfIR4q95m59yac3EA8EY+iCgsmCwytizVL3MFM
         1680c68Ew7vNpDd6+zrUA+nUVwwHpe878ubVtpRzow/n7RqpQyvAxdOUDIar31ov2O8U
         kBV+d5MJ+rVVDnSsUIL8gYv/O3Pl4YGmCcNvX/v3wD5bsCAa0AqRKVIR+utC85MSLNF0
         xK7VE7eB9ZjOxsVGcVEHl9rqeOKuS/83YW+y/2EJF+jdlb4tcKSx+L7RNvLuwP4irDcU
         rwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=xkjIEbXyfihovdczUPbyfJ5uvAcs42aomN4NX7+xmzw=;
        b=uhyjk0gJhp56XLlIdWxDayc4yKSFCYy5YIp+6//s61JzV8fCu8kr220FMZB7QLskTL
         rLhqJEte9ipkLm1Gzx0S5hTEqBgQtjqR7zI1mc8oWg3rXxVSCumiS4jQScWUpuf1D1FP
         qtUhstMm8UrYSG2eEdcEalRwxLfeSnOZd1AqxajoRmuzEYDEHMcYpbXWzxmO2+eBugdB
         fNGTwa8x8WjMhA79MadW7D/+4vRW+czKe8j05BgjMchKSDomrrUH3BXYD8vea+qJmxNL
         s53qHPo7cnCt18l19WeXp0akLX/8lGe5DDxZf+PbdYWNTlxamUdWDC+Jk+2CglUeB+ss
         5Tbw==
X-Gm-Message-State: ALKqPweTmKwyU1l4XrR2ZpFOkfkv7OI2Tvn66HErNgBZy1iYPWxP5o7d
        akevsq1IK5P81NmJRKQcOAfuKVAA
X-Google-Smtp-Source: AB8JxZr/XWobRp0COYB56/CFh6jfYOi5uN6B8PYtoQWe3ttLUVeoV+2dPRvDhQAUXiREjerkVc9gDA==
X-Received: by 2002:aa7:c553:: with SMTP id s19-v6mr73807edr.139.1526462988979;
        Wed, 16 May 2018 02:29:48 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id x20-v6sm1094737edr.24.2018.05.16.02.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 02:29:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
Date:   Wed, 16 May 2018 11:29:47 +0200
Message-ID: <87po1waqyc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 16 2018, Lars Schneider wrote:

> I am looking into different options to cache Git repositories on build
> machines. The two most promising ways seem to be git-worktree [1] and
> git-alternates [2].
>
> I wonder if you see an advantage of one over the other?
>
> My impression is that git-worktree supersedes git-alternates. Would
> that be a fair statement? If yes, would it makes sense to deprecate
> alternates for simplification?
>
> [1] https://git-scm.com/docs/git-worktree
> [2] https://git-scm.com/docs/gitrepository-layout#gitrepository-layout-objectsinfoalternates

It's not correct that worktrees supersede alternates, or the other way
around, they're orthagonal features.

git-worktree allows you to create a new working directory connected to
the same local object store.

Alternates allow you to declare in any given local object store, that
your set of objects isn't complete, and you can find the rest at some
other location, those object stores may or may not have more than one
worktree connected to them.
