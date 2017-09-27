Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F14892047F
	for <e@80x24.org>; Wed, 27 Sep 2017 23:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbdI0X5m (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 19:57:42 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:56120 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752402AbdI0X5l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 19:57:41 -0400
Received: by mail-qt0-f174.google.com with SMTP id x54so15405587qth.12
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 16:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mGAwAnlzJ60SaY3dRPBU59TbWode4PpTTDpHD4FH7Eg=;
        b=RbInHwqciSUbjUIjKptwmHQAGBb4RyDga7pxv4Usd7sj9jk7ea9sqz2ZYjz966FEuo
         4g8yE2HZAkHHdA6Ey8Ahs1nt/IqzUQ/WVWK3cn63JKT+EJVrK87MeSxXntCqLkO4k0gS
         4pZVEsTkqsl3dDtgn6KRCTf/GBdYsmWykVkQkgKUUhhhwM11OW49OVQaPr/3C+OfEVzu
         5JcWIjHHq4n0hzWDgYNAyipNxwLIo+dJzim6qfmA936Nuw4pK0od3gS7C7L4eZB3WWC2
         DbYCt44TLqVaX5H1JsDa6l72DNOyXBpAeqreFgYIHWW3HS5RDob/EVhREen9+cjY1tzZ
         agIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mGAwAnlzJ60SaY3dRPBU59TbWode4PpTTDpHD4FH7Eg=;
        b=YgyyK+48vLFM1CV94bVkDVt2ZfSLya9+Pdlw7bC6CYuLFonq81NPlqtL/cxRuTwUBm
         5IGwX4q/VZaPR+XFAXb0jfKnsTkkQAbTwoTvjmNFmdcwwA33G+D6Sjaa2gFLr6ffprZg
         G1Ok4wz1xIvKk7BW4sKWeeZ646NVemc0afT53mtNiGd1Us1LGUg7Z6AJNdH2gB+mTwik
         qzVKe+GwUUi1uKMfkYLNOFl4NS9CsQJlSeVfBKunEfD8VqHZ6K3yxwnETA8fArAidzQk
         uVL6hELKMVT/3OY4Me43D9ZVkFmzCAs+UJiSMwM8QZe4fBGPciwbQ4PrwI7eu0JzfDP8
         gxtA==
X-Gm-Message-State: AHPjjUivRwQoK3+Bdhk40MAopZ5rVJXiLnQ2SLEI60yEYgQT4VFsTPQX
        b9aHs8mcSuCxDVW2RSMPiiIPgr1ArXm7nJMd5OXdvQ==
X-Google-Smtp-Source: AOwi7QATMI3LOplvLcczoi0yr43G0gOmL1EoMyqS5BJWT82vPuVlMixhuk9xhj13Ex1lJjbnSOo34oLKZ5p3I+s5uQ0=
X-Received: by 10.237.53.23 with SMTP id a23mr4802462qte.125.1506556660981;
 Wed, 27 Sep 2017 16:57:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Wed, 27 Sep 2017 16:57:40 -0700 (PDT)
In-Reply-To: <094ebbd4-1bc6-8360-222f-55a4a16a6ca3@ramsayjones.plus.com>
References: <20170927224909.25dfojhx6wzaqwt7@sigill.intra.peff.net>
 <20170927225126.4836-1-sbeller@google.com> <094ebbd4-1bc6-8360-222f-55a4a16a6ca3@ramsayjones.plus.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 27 Sep 2017 16:57:40 -0700
Message-ID: <CAGZ79kYAzcjECZ0Pt3weyxE0V7J0WCM=M-MvM+HM9DgBDcJQTA@mail.gmail.com>
Subject: Re: [PATCH] diff: correct newline in summary for renamed files
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> +     GIT_AUTHOR_DATE="2006-06-26 00:06:00 +0000" &&
>> +     GIT_COMMITTER_DATE="2006-06-26 00:06:00 +0000" &&
>> +     export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
>> +     git checkout -b mode initial &&
>> +     git update-index --chmod=+x file0 &&
>
> would 'test_chmod +x file0 &&' work here?

That is what I was looking for in my previous solution,
this one doesn't care about the on-disk things at all (regarding
the mode of files).

So I would argue that test_chmod may be overkill
(well we could drop the force flag from the following
checkout... not sure if that is a good trade off)
