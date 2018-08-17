Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63AB11F954
	for <e@80x24.org>; Fri, 17 Aug 2018 16:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeHQTdD (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 15:33:03 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:33378 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbeHQTdD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 15:33:03 -0400
Received: by mail-wr1-f43.google.com with SMTP id v90-v6so4412556wrc.0
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=37hmJlnnRSK7BJ0xg/baKEX3KtWGCC0UoRnUXN33IwQ=;
        b=kBYXAq6icpcj2E50yRnat4HnUrEILKipvBudXpBdqfKo8q7OX2LyH/yZXJE7cw28BZ
         GbsknusxHU4nbJqAb1lfQeMHORTUK/9MpQXiimmPfFlZjQ8hZCpuaFCnvg27gLxBo8hP
         9AWY3Cz3AGx69FGAhfW2VWrC2ToZ6XskBAHtDKnIMZGeCMQU85qMqlrEbHIn2LaHEPwI
         irBz/Yayo3bYPAKYEpC46BYgpze5sKJ1OIdaLvzIkmdSoS7pAk7z0lyOAR9MXBPdPc4b
         Ph50+07VM4yMO5i3jpAcDFy6x2rV2Jv/dXwBs1vL3Sry+7jCehVBptSAVSDCgipGt3Y0
         FG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=37hmJlnnRSK7BJ0xg/baKEX3KtWGCC0UoRnUXN33IwQ=;
        b=Q9ynuc+h5RzBAiEcl9f8+xquBHa3ZXnMNoa+/PNFdEFWiE2qJ5C3Ez4SbDH8jxKF+y
         IYh4Ge1Od2Yk4/aoij5gxMvkDFf04scItwN86gC1iLE4OYNrK6Oa32TenP2BUaEN+EIW
         NOR2eurpDAME5A6ICTzldf2IAo7XrNYOQiWrpTqqfmMI3TgNAsGWYSs7IssVUKAdukqx
         xwfpzAoBf8TtsN+FBHLc8FrRmCvdgkCGDLpiu1erMNoadyErB/h9Q7I8Sv1YweuWTdZs
         IZuTCJ9o2zkspQhL+Z4OH2OSmJcVNeF7761PcE4/go7kIvFPILJ329/l6Ud/8fSo5fUe
         ldSg==
X-Gm-Message-State: AOUpUlH+qfS2ROidd+pGMoCjGbUSuQr4xPvI3qdKWHn3lrhWk9+wt1cm
        uIQoYJKo9LCKTF8lGch3o54=
X-Google-Smtp-Source: AA+uWPzwGeVfb0TBPIxOjwJ6dA4R4AdaFnuAgZjZSTJPXMLEUgUmdP0fP4hG7B/uEVWyEwwuLT9EWw==
X-Received: by 2002:adf:e50f:: with SMTP id j15-v6mr21914689wrm.111.1534523340838;
        Fri, 17 Aug 2018 09:29:00 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y11-v6sm3429626wrt.4.2018.08.17.09.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 09:29:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Syncing HEAD
References: <CAP8UFD0_jpKdcDvNx5CYnmyDMagE_O-E7cef5VthaT_w-=4xsA@mail.gmail.com>
        <20180814210616.GA32367@sigill.intra.peff.net>
        <20180814214723.GA667@sigill.intra.peff.net>
Date:   Fri, 17 Aug 2018 09:28:59 -0700
In-Reply-To: <20180814214723.GA667@sigill.intra.peff.net> (Jeff King's message
        of "Tue, 14 Aug 2018 17:47:24 -0400")
Message-ID: <xmqq6009c5ys.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So all of this really implies to me that you want to be able to say
> "take this symref on the other side and update this one on the local
> side". I.e., some way to tell a refspec "don't update the value, update
> the symref destination". ...
> ...
>   git fetch origin ~HEAD:refs/remotes/origin/HEAD

We need to be a bit careful here.

You can define the meaning of the above sanely if you know that
refmap refs/heads/*:refs/remotes/origin/* is in effect for the
remote to read "My HEAD points at refs/heads/frotz" and interpret it
as "In order to match, I need to make my refs/remotes/origin/HEAD to
point at refs/remotes/origin/frotz".

Also, what should the above form of "git fetch" write in FETCH_HEAD?
Should "git pull origin ~HEAD:refs/remotes/origin/HEAD" run the fetch
and then merge it (which may have value of refs/remotes/origin/frotz)
to the current branch?  Should the underlying fetch be also fetching
the frotz branch from them at the same time, or do we attempt to merge
a possibly stale 'frotz' (which might not even have been there, the
last time we fetched from them)?

