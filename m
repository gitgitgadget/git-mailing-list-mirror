Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 104C61F42D
	for <e@80x24.org>; Wed, 30 May 2018 21:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbeE3VOO (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 17:14:14 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34472 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753275AbeE3VON (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 17:14:13 -0400
Received: by mail-qt0-f193.google.com with SMTP id m5-v6so25225313qti.1
        for <git@vger.kernel.org>; Wed, 30 May 2018 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=W68N7P7R+VzCAPUuzOc/WQon7YS83KbwUfoQQlp8rNs=;
        b=hHYaNxYqJp6FKymJhCQ4HfMa9selUmRXhGYsCwOP0nGnBaylH1HFBVjV3BGu1HrH5z
         aIAnGyawnXBUaUlVHtPco105+A3VPFIPmxq2QOh6D4l8BUdp/hqSLTlcfkz3fpxJqd63
         AQ/HrY8PZ5lv3zL35Eug62pm3K7q8CGflZzeMTmtZW6sDjLU9lHuHGi5gkqTGFysftl1
         gZBNnEm4LNvSV98mXsQvr8/cSmztLXN6+tFM33UDgFJcbig/SjhIUBjUUhDLkZp5LiG+
         7V++rT/5VLVgXqKkY6f0WPs29eQ7c14B+FI/mAlW8EA4X9vw/ib0LXv6j/J+oIl/3+bu
         9wTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=W68N7P7R+VzCAPUuzOc/WQon7YS83KbwUfoQQlp8rNs=;
        b=pNtcZCXBLS175EVH94yFSZQVBxQ5JonXCN5Dw15U2AO8SxaMesmGzK2Sm+u9mW3CVr
         BzjeutlM44fqtZWgbVZUF42q35ZH1QXJnn1zFWRqPsklx0C66yIliyc/7pyInV5rFPpt
         J1NxomCMvgqnyARltCU/ikyLfxQ0rtoq/6f0t+pyZCG1/VT5MkWG1zwSQJbpklZ7nZz5
         pd5I4gYar0FdiOwrn3secHDzgAc3w+cqRac6gHxQtq0IgvjyRMjWhj6jgHQnJRjvHN2n
         7yhJ+VNWj/TmDF6R/sURGd5PbPVKfc8sJ3fRzxsE2AjQCz/XMv8nD/hrzbezQ0s3AfzW
         ziwA==
X-Gm-Message-State: APt69E1eSQKxAJN+2qCDhkFEayd0yRvo0HLvulVRzV7ZjTYyjnkyq2IV
        dDSYFtzQiPfZRq2oytBgl/b1f6+oSZ4Mvs76SII=
X-Google-Smtp-Source: ADUXVKI20S2hLxsTIFfLOd4gTLj0ZOok/uAu69tAz82pqJK/N3rEU3pY4KNGNiOU1DfDsV5V82Rh5kfbbq2PBL0jRQo=
X-Received: by 2002:ac8:678c:: with SMTP id b12-v6mr4128287qtp.314.1527714852370;
 Wed, 30 May 2018 14:14:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Wed, 30 May 2018 14:14:11
 -0700 (PDT)
In-Reply-To: <CAGZ79ka1-emwYsEh1EQdh=pgFUV_bi2xoDu1Ajq=Z1XkkhyuDw@mail.gmail.com>
References: <20180530080325.37520-1-sunshine@sunshineco.com>
 <20180530080325.37520-5-sunshine@sunshineco.com> <CAGZ79kZ2MKpjwwx0+ZsPZ9bFu_ersPJ=kKPYWRmWYjJ8yoVhuA@mail.gmail.com>
 <CAPig+cRh02976beGp5c5Sw5=h86VgNZgVreCHh38QKP5udJeGg@mail.gmail.com> <CAGZ79ka1-emwYsEh1EQdh=pgFUV_bi2xoDu1Ajq=Z1XkkhyuDw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 30 May 2018 17:14:11 -0400
X-Google-Sender-Auth: uiPcNX-G2Hy93icZ4WJYTE1FN9k
Message-ID: <CAPig+cS+X8une=g0sSVc4dnZCsnFYe1D=v1iO+zs1ChGuQAJYg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] format-patch: teach --range-diff to respect -v/--reroll-count
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 5:03 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, May 30, 2018 at 1:44 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> Unrelated to this patch: how does this series cope with range diffs
>>> that are not in commit-ish but patches on the file system?
>>
>> I'm not following. Can you provide a concrete example to get me up to speed?
>
> I was just wondering if things like
>
>     git format-patch --range-diff=v3-00*.patch --reroll-count=4 -3
>
> would be supported, but that doesn't seem to be the case, now that I read
> the whole series. I don't think it is crucial to support right now.

Okay, that's what I thought you meant (upon thinking harder about it
after hitting Send). git-range-diff doesn't support that mode of
operation (nor does 'tbdiff', as far as I can tell), so as a thin
wrapper around git-range-diff, "git format-patch --range-diff" doesn't
support it either.

Perhaps that sort of functionality could implement later by someone,
if desired. In the meantime, the following (manual procedure) would
approximate it:

    git checkout --detach <base>
    git am v3-00*.patch
    git format-patch --range-diff=...

> This whole series is reviewed by me and I think it is good for inclusion
> once we have a reroll of the range-diff series and aligned the command
> name to call.

Thanks.
