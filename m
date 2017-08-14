Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA91120899
	for <e@80x24.org>; Mon, 14 Aug 2017 17:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbdHNR3J (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 13:29:09 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:33634 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbdHNR3I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 13:29:08 -0400
Received: by mail-yw0-f182.google.com with SMTP id p68so59014174ywg.0
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 10:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mu4q6d0cmOK+1zy5LbKHFSrMEMCxiYQ0qGOeoeFxpXA=;
        b=UYZspBmBtJDO8ss1RLPPv5BY1WH6VDiuf1zneakEa/m9aDtivBfoLmqUt7+VTyCPBo
         3UWsXPMOGAhlKQIPBUfr7dLE8FxQWPHuYQKFK3mM9jb/LDGoTf0MBf+lBi5A0CyqWKLf
         S7qZC2Pt4nfWn5ZV327Vi0EgYAqbqA4J+Aimz0n5HqbsN+iDLwETD1+MJ8YSDB6LNk2t
         ISpbiJmQdZYrkA9t2Cgm+zLwImyAD2eNcyTSyivaYBTFlPAN7ZRmhVTeP2DJjRNSjQbL
         XwH1pYJZpeDaEse4oQ8K1mqL0fJg3IoSXoub20cqhykL0BQsC1oifINR9fj4PcKNRuCa
         43SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mu4q6d0cmOK+1zy5LbKHFSrMEMCxiYQ0qGOeoeFxpXA=;
        b=WNTFWNemE28+Od29yEfGrsgSIgUT1ehm6DLY3glUt0oQIRj6SvZgLa9al/mjrF6MU+
         Z0D7mcmhz9cf+j8cPBXf3dgNNu0kchwBOiJ24J+Uf8BuysFBUY0v9pnT5BuSUKsvkQLJ
         Vax+sSiZ5OoBQtuoUtbLT4Bc8yKAtjzamkQLVcbUJX3ehOePZMZq//dKKdUP3JPzppSE
         gwrIW5I4mgH2UWOCBOUnJxLw9C1kGnCz30YsO+eGJMRvlqMr2+n2maUw79d2cqV9Pf3+
         EyWyvRTr9DtTYoicN6X/q97MsqYPZBepsl+51NSVObwM3PYInU2knmlnh482oh2gjoWJ
         zC4g==
X-Gm-Message-State: AHYfb5iOgWj4jgT/lFT/hUP2RM+MKe+XLCc7aQYzrnoVPYxlBn2HbAsb
        iB124Sg6rQ5vqbyH6RpuObn2V0py1gaS8m0SBg==
X-Received: by 10.129.31.215 with SMTP id f206mr20452842ywf.29.1502731748077;
 Mon, 14 Aug 2017 10:29:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.75.3 with HTTP; Mon, 14 Aug 2017 10:29:07 -0700 (PDT)
In-Reply-To: <xmqqk229y5zd.fsf@gitster.mtv.corp.google.com>
References: <cover.1502491372.git.jonathantanmy@google.com> <xmqqk229y5zd.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 Aug 2017 10:29:07 -0700
Message-ID: <CAGZ79kadqx3PcchM6h_U5U6nsMVf3wHSUHt1XpD_XWxYdoYudg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Fixes to "diff --color-moved" MIN_BLOCK_LENGTH handling
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2017 at 5:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> Note that these patches are for "next", depending on the "--color-moved"
>> patches.
>
> As we have finished Git 2.14 cycle, in preparation for the next one,
> the 'next' branch will be rewound and rebuilt early next week.  I do
> not mind tentatively ejecting some topics that needs fix-ups out of
> 'next' to give them a clean restart.

These would cleanly apply on sb/diff-color-move.

>
> My preference however is to keep sb/diff-color-move topic as-is
> without replacing and fixing it with incremental updates like these
> patches.

I would have hoped to not need to reroll that topic.
Though I do find patches 1&2 valuable either on top or squashed
into "[PATCH] diff.c: color moved lines differently" and
"[PATCH] diff.c: color moved lines differently, plain mode"
respectively.

So I'd ask to pick at least patches 1&2 on top of that series, please?
(I am missing the context for *why* you preference is to not do
exactly this).

Thanks.
