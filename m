Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5265202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 20:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933035AbdKAU65 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 16:58:57 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:47718 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751922AbdKAU64 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 16:58:56 -0400
Received: by mail-qk0-f177.google.com with SMTP id m189so4377297qke.4
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LE29MbSXmba4b7DhI0553WywIm/1KPwOR1tVNyCjiOc=;
        b=bEDe2rTse0wuvIX65rbdHkOxerHn2CZyedaCgvpfTG135T8BT3ZuSJIIUecvJ+0o5W
         /VZb4mntMBl0a5e0WNhPAEwhaJH9dHb97dlXUq8zT5KW+HHcaPD2QlVXX1pj+7nCGkFg
         agnivknj2kICEuXgKJ+x0CtWGUapY/GPSYcjTflJeedD9FoKUwCvZsoj32yN48j3+7jL
         FdgFQeERWUmPVbOH7PZ9B2slQkUtJgyImwoDFAWbOMnTY1fm2yP8ZEggPlRouw9agMFk
         LdGZOpBWfKYa3oiHY0g1CPVg/+G5QqoGN8eFTIAlK+sQWEoB+jxBeEE6jGA8VMrKAH5S
         58eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LE29MbSXmba4b7DhI0553WywIm/1KPwOR1tVNyCjiOc=;
        b=Z1dG9upVOCPGwz4RIiVv4LERzNh0GRhEb/zPerxiP4l8FSGQ5wZJFapNBMnqKm7Gi2
         qPurKk9acJTW1WzptDAdLbJf+ofMzKwR4jAjsfymAnuyRinC1hOnzNmtPNSG7anB87Tm
         /HM0A8B3qFdHK5+PubnAl/xal4x79LUGwSJSZSxY38dxdadwLLZnavARKVuSrLVRvnYN
         t6YlHrFR2QcwkMW2j8o2xqPCZHkDc9GTE4N+JJ8a8Nc12ld/zjoRewb9wIob0wOekEPA
         6Hl8so3N8jCw7MjMu7CE7k7oxXKPnkQ0TujMEBht2HJWU5Jq43l6YZkmSuBszxt8rrc1
         NdDg==
X-Gm-Message-State: AJaThX5Z3mHcdnYUw+5fzQlBoQ725DfguzcSxCbhX5BQHnYD55JAUBRv
        AdPE0OB05bkPSpR1OjJE7R5vKPENQs5Q9H1/ATjytA==
X-Google-Smtp-Source: ABhQp+SsbS75wOq1Y+OohQTK8yv2D2NQE0xPrJx6Knh2iUiw74+y+3BxOf/onhBGWOvkCIrBJ9CEM+PP7Z5i5qAZEgg=
X-Received: by 10.233.239.140 with SMTP id d134mr1836491qkg.308.1509569935530;
 Wed, 01 Nov 2017 13:58:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 1 Nov 2017 13:58:54 -0700 (PDT)
In-Reply-To: <xmqq4lqewu2b.fsf@gitster.mtv.corp.google.com>
References: <20171028004419.10139-1-sbeller@google.com> <20171031003351.22341-1-sbeller@google.com>
 <20171031003351.22341-7-sbeller@google.com> <xmqqinevzvel.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYO=4SWzfKY6bU8Spn5Ubw39ghOH6wanFhFEsKD8q9vrA@mail.gmail.com> <xmqq4lqewu2b.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 1 Nov 2017 13:58:54 -0700
Message-ID: <CAGZ79kYC4=rDSWC7WCGVL4n4OC8BpvMJFwxx+LV9GqoGnSHFSA@mail.gmail.com>
Subject: Re: [PATCH 6/7] builtin/describe.c: describe a blob
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 8:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>>  Given the difficulty in
>>> coming up with the single-liner description of what it does we saw
>>> above, I suspect that splitting SYNOPSIS out into two very distinct
>>> operating mode might make it easier to read.
>>>
>>>     SYNOPSIS
>>>     --------
>>>     [verse]
>>>     'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] [<commit-ish>...]
>>>    +'git describe' [<options>...] <blob>...
>>>
>>> Then this additional paragraph can say "When describin a <blob>",
>>> without using a (technically nonsense) phrase "if <commit-ish>
>>> refers to a blob", which is never true.
>>
>> ok, do we know about 'blob-ish' as a term?
>
> No, and I do not think there is any need to say -ish at all for this
> use case.
>
> After all, when we accept a <commit> when a <tree-ish> is called
> for, that is only because there is only one way to use the commit in
> place of the wanted <tree>; we take the top-level tree contained in
> it.  You cannot say you take <blob-ish> and take a <tree>, as it is
> unclear which entry in the <tree> can act as the substitute for the
> wanted <blob>.

But now we have a path as well, the notation of
<commit-ish> COLON <path>
is not a unique description of the blob, because
* there can be multiple <commit-ish>s depending on the tags and walking
* in boilerplate code cases, we might even have the blob at different
  places (e.g. pristine copies of a license file in subdirectories)

When calling for a tree-ish, we also accept commits and tags
plus walking directions.

So I find it hard to think we have to take in exact blob names, but
we would also accept blob-ishs (i.e. commit+path)
