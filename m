Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0469F1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 21:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeDRVEd (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 17:04:33 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:36322 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752334AbeDRVEb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 17:04:31 -0400
Received: by mail-wr0-f171.google.com with SMTP id q13-v6so8415185wre.3
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 14:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5X19+tbkDhVjvrKd4xc01Kkv2XTZL64Si0C6zej2p3M=;
        b=G16r+IaNXeCrw638xsKBAe/LT6A2ST8YaZjvDjWUq8+7g8+O/0VGyBKlQRbGx0urSm
         wCCgAnQy7we4d3t3lTQSTCyjxXL8QLLC078HVR72P/2CZVMq1pHKKlcqZh4IQH++SDiI
         /nJow6zJYwx6PPHvXuT6Zm15uha87CzVKzSaZSPkh5tnsVBmVH8qDWzK8kqwpk8QDmeK
         xeL8Qjvkw2S9gwyI2nKWXvJDO4QVq6A9+04aEDLlIKgIwCrzX6sZSZPhdSUYJMkx+bn0
         2uealOf+mkKM7rVYe1sAEp/eIx38BcxiKyjUuoSR86UTQfQUONrBmkEYkssE8h2nR/pF
         XnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5X19+tbkDhVjvrKd4xc01Kkv2XTZL64Si0C6zej2p3M=;
        b=nlY47hNI5gXmsy+AUsCcehB1d6SxywSo34zaQW+HT7tiDD/uZZqVGFJOh77DaqtrFc
         BKyMaRvr7v2d8KwrfUP1yk3tsDwUBia9GKYG1xwk2vFNzpQrrP7j5O4Z+pijt4A9r16u
         xX2sBNZJWQ8B3pdRfX7OJw9+m4svM6F+IpASZTfsW0BjaySoIq+PjLY1XFoafCM75061
         g4p17u88YMBHB5k51bmgXJkNPoNH3L6MlA0BMLeHoFS6IZUOfNa1YXuGuBu0AGwegwXs
         Pqtgh+OO3nAkaXgkRKk0fqgL4UmF+9EzykBygzRaP+0AnKqsLd/z43HOtZ/KbTi6Kj4k
         aCcQ==
X-Gm-Message-State: ALQs6tBXoHbZj1axGsQ+8p8VuSdf0JM4jdU17Xj3k00MfrfJ3RhA+sAR
        0ZRdR98VlZm/QZlEZVwYIFc=
X-Google-Smtp-Source: AIpwx4+0V15xCAU9kUYOpM1lFilvxWkSiEqMX/SdJioYkX2lk5Lvung8ew7LLSQwsEJs3Tf8u9l1Tg==
X-Received: by 10.28.7.141 with SMTP id 135mr2852014wmh.157.1524085469503;
        Wed, 18 Apr 2018 14:04:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g105-v6sm3311722wrd.45.2018.04.18.14.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 14:04:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Apr 2018, #02; Tue, 17)
References: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com>
        <CABPp-BEKe1u_e=5V471PzoJjdvuYZ2n8H=h7mVa8fOR7XsoytA@mail.gmail.com>
Date:   Thu, 19 Apr 2018 06:04:28 +0900
In-Reply-To: <CABPp-BEKe1u_e=5V471PzoJjdvuYZ2n8H=h7mVa8fOR7XsoytA@mail.gmail.com>
        (Elijah Newren's message of "Wed, 18 Apr 2018 12:39:17 -0700")
Message-ID: <xmqqzi20grab.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Mon, Apr 16, 2018 at 11:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> * en/rename-directory-detection-reboot (2018-04-16) 32 commits
>>  ...
>>  - directory rename detection: testcases to avoid taking detection too far
>>  - directory rename detection: directory splitting testcases
>>  - directory rename detection: basic testcases
>>
>>  Reboot of an attempt to detect wholesale directory renames and use
>>  it while merging.
>
>
> Thanks for rebasing/cherry-picking the series and applying my newest
> changes.  It looks like a couple of your squashed fixes in the rebase
> of the old commits ...

Thanks for rebooting the effort.  The above wasn't a serious attempt
to re-queue the series to be polished for 'next'---to me, this
branch was primarily to keep track of your interim 29+fractional
patches until "the real thing", possibly rebased to newer codebase,
gets submitted.

> Also, the newest patches can still be fooled by a specially crafted
> rename/add conflict, but I believe with a small restructure I can both
> simplify the code and cover all the cases.

That's nice.  Very much looking forward to the updates.

Thanks.
