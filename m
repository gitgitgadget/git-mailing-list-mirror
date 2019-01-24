Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AF0E1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 20:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfAXUTV (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 15:19:21 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35804 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbfAXTVm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 14:21:42 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so5532616edx.2
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 11:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zoYVTkwosR7627Ry+1vli9TnYVmxkvPiJkN+YydzyQ8=;
        b=nYrwBDO0TahL8ZxaUWqioqAi8l91xHw4O+UKr6bnQybQbsqruVGOcnP7WPzxVZhqfc
         GQDhrex8Buf9MgWzxIzqhCAsO0S5YhphIxS+G0vMZ9hrGX8PbWDf4qYwQIJgHMQWOE7+
         FyuyRGqd+BEIGI5B8g+4Fg6IusDHxbC2xdbJCCSBSzaaJ6/DA6K3LLATLItqBVXly71V
         k3LwfkeTl71XS4auEjs1D5QcqoWDL2klcyh+YM7WdNpIWPAmAiZUn6kA+sj+HiDtljTj
         C2zRjBdYkaGFc8MQFk9BFMlrTnHwk0olFK4OY15YkVppns+YuF+XkxizTLNg2lQMkFQI
         cmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoYVTkwosR7627Ry+1vli9TnYVmxkvPiJkN+YydzyQ8=;
        b=C5znqO38KxEAXPveLikXkilGXaVDVHbwjw/hHl3Fby8uTgBcAKTfjD/d8hGFKMQsHt
         Dn1CiA+1uE770PnqVaYDEfMUsIEOPOqAhTsUg8qeOum1TZXVCKAPitFvqS1gDfDDDG8i
         OX+6AXIappx51s4Feu0T5gEMN+G1D/SEJhdYqotHlKOSma+zOMLXcZ2fSByR9f1eNW/r
         CEu5kM/7+kpGRB7WkWMa4xE/ddmTZ2GaijY8wCXA/tpEZdMdH97+aVmpYQuCbhPW+sJ2
         WERN8R8eGeeZ7t/DqFcv6RsKgNiK7M38EAu+h9EpcQBaH1D1R+5DWqFK2oeXYO8fLPN8
         S8oQ==
X-Gm-Message-State: AJcUukcIFHJVcWIsg7QkjfuFMsUQ93ATRbufKaEw/ZctcwdyIC8yww0d
        CXbU4iiSkslWjggNhwuEn7reJ//RbIeyaktcuyD/DVXsEwc=
X-Google-Smtp-Source: ALg8bN4W2ER9Ig9nxjVao7/HiCfrnOdCkHhtzaxh8J6AJa/bpTMq/pEcTni1qAfTEsJLXa5EN7AgQaxRHsqmYciJHNs=
X-Received: by 2002:a05:6402:1816:: with SMTP id g22mr8018687edy.191.1548357700695;
 Thu, 24 Jan 2019 11:21:40 -0800 (PST)
MIME-Version: 1.0
References: <20190124122603.GA10415@sigill.intra.peff.net>
In-Reply-To: <20190124122603.GA10415@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 24 Jan 2019 11:21:29 -0800
Message-ID: <CAGZ79kboXBvd5kNHmHzJCsmoE7GWmYg9v5GhE4b3kPNwVqCTVw@mail.gmail.com>
Subject: Re: [PATCH 0/6] some diff --cc --stat fixes
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, David Turner <novalis@novalis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 4:26 AM Jeff King <peff@peff.net> wrote:
>
> This started as a follow-up to my "something like this" bug-fix from
> last July:
>
>  https://public-inbox.org/git/20180710203438.GB6886@sigill.intra.peff.net/
>
> (better late than never). But in the course of that, I discovered
> another really weird and interesting bug with --color-moved. This fixes
> both, along with some related cases.

I reviewed the whole series, and I like it except for the small nit
in the test setup. Arguably we can fix the --all tests once the time
comes, so I am in favor of taking this series as-is.

Thanks,
Stefan
