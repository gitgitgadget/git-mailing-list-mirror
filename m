Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44C44203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 20:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758203AbcGZUTL (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 16:19:11 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:36261 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbcGZUS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 16:18:56 -0400
Received: by mail-io0-f180.google.com with SMTP id b62so40596458iod.3
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 13:18:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3i0TVsQmqIeSbBY/9AN8qWMimossKX56I9AH7buF22A=;
        b=THBr7QH5fd9CFSx3PFWuHA8SS4PNQQZ4P87zpuH3FRar2ObdsHhC4yB1CxVrygiaxz
         RqaTE+1eGEv6ksnifSsXau3/M1Cksg5v491R4xd5WxZ8sy4oGXb30fRIJrDzkQpjF+uT
         qSQcFwTlBqvtMSU1cMd/+E88YVA9TDwGQOGV+fsoZdDsGEcYlD2vnvXBfbMMuZ3tfbSY
         qU3eQji/1eU0VL71aKdGzV8ncTjaL8/b/faYXlgDhEVWvSPr8lqHXsRX+VsGYR2R0VtI
         LvSkSwGYtIqIAEF2aRqDu0MzZwmiGxg9rsW/Lce0NXXHWczTavMKKTSxiLVdS5WjGWyr
         ft2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3i0TVsQmqIeSbBY/9AN8qWMimossKX56I9AH7buF22A=;
        b=RQaLqBTvLucHWKfliKBoGha6Lq117BD1yhoLQsEbHxFKeXu6AaC27LgnAG8tgEeXzP
         UFQm14EAvPcL7cjnlrQOcdq+AE/ncEX8F/mbVZFbTtonho00MDvWKIYqi/s+y9xS+UKx
         wHIpkiXaKUP38FhIWtFFlmxAWX6X+/lyH2ANYr2/5+lZ9mpk25dhCOpoalGu5K1zjWx0
         lKBjGZHKhynRSFAO93rwf+9qOaRb68NNdna2nb8PHw2kisOKLMFTC9Wb7+ukyoA9Mn7+
         uH77R2bz3dAjeVIW1ww+E+Ap1ZZh6DLzXpuIpp6kBDhEXwUORMpNZBqAoSOjD/hDzHvu
         KWvA==
X-Gm-Message-State: AEkoouvogPTM0lUzhAnsl6sT9lcqMcx4S0PkRQAtdQqgszOxx1T8i306q1XCVZrYhgaMv06RPDyUrBrlIV7wE5ii
X-Received: by 10.107.144.10 with SMTP id s10mr27121973iod.165.1469564335833;
 Tue, 26 Jul 2016 13:18:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 26 Jul 2016 13:18:55 -0700 (PDT)
In-Reply-To: <CAH8BJxGZW8eNQogksZ416sVaBkpQ78uYkV7FtN6wxGafzNwjAg@mail.gmail.com>
References: <CAH8BJxGZW8eNQogksZ416sVaBkpQ78uYkV7FtN6wxGafzNwjAg@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 26 Jul 2016 13:18:55 -0700
Message-ID: <CAGZ79kaop1HB4tQAKxOcq8ZNEc+6VMPB1suwA9jra2BoXc27cw@mail.gmail.com>
Subject: Re: git cherry-pick conflict error message is deceptive when
 cherry-picking multiple commits
To:	Stephen Morton <stephen.c.morton@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

> Would it be possible to expand the hint message to tell users to run
> 'git cherry-pick --continue'

Instead of expanding I'd go for replacing?

I'd say the user is tempted for 2 choices,
a) aborting (for various reasons)
b) fix and continue.

So we'd want to point out the way for those two ways and not
give an additional arbitrary way that is not quite (b) but goes that
direction?

I realize this is what the patch does, but I wanted to point out the difference
on expanding vs replacing. I think a 4 line hint is "enough", so I'd object
adding more lines, but changing existing lines is great!
