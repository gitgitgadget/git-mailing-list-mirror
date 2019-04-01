Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E47220248
	for <e@80x24.org>; Mon,  1 Apr 2019 10:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDAKpA (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 06:45:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38537 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfDAKo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 06:44:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so10785504wmc.3
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 03:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=jaRnJVyZVR7eJ2a0kuVm06s2m7Rf14Ci577TJlk1spQ=;
        b=aruWliXdvWusOw1OussDKIdOnKAQB/iHlN4zEVYqBDOAH+Pd5f0eOk1qd8fjuQMjy3
         0K5MrnZ1flto1pwQHJYlPpn8/a5elsayWlzFXStp9u/MmYs19BDWZBcWvxYv0d39ng/E
         9JxPceshpQm3nPv05JFAcvbGYeDaGr3YmPSfcfQAHL0pM7uiy7JkkiwaghXKJTGf+OCL
         ciDEW0IRmM88m4ImNPQWH0hWYUaX/Sf+/1rEzpvwK/056FsKHbIpTmI5L3gb8AagULaw
         enIQaBQJI6NfmLYgMEDvh3IYVLGVZfFK46H9d/ChpKt9pyEuTPOvQijRfadxS2LSOY9j
         q/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=jaRnJVyZVR7eJ2a0kuVm06s2m7Rf14Ci577TJlk1spQ=;
        b=ZDYFcrtBO/6d6QvzUPpQ3kEIf9CCRzktAbUnvvnELx0NQSAWQr9JzA0swoD0VoiGp0
         YqyvIohMwX5+KNGoMzAWiX9prcDMFxZWHoz0tCBpjLq4v8eKrzcZzkE033zg4poveBzN
         QsRgr4uCiicy95MG2rXE9sRS4hBy2O7JkaBWEROxe20NQ7kuLzoALl3UMUclnnBpPODc
         CRlZsk0jmSVbVoQB5g0fwm+mBn3I9B+glro9EUQuIJPYsfJp0QLLr8JrCxDXqFTfjG4R
         ALU+r8rLeJw2PBsif/qOph1/TZCUHJEs4D+Ocx6F1r5mpUiu/K/WVP0JQ6xoNOyQ2PSX
         6vwQ==
X-Gm-Message-State: APjAAAUhrQYE2fnKUzU5AUw/3OecPwqlL2fnDrVZXUxs2yP8JCSjM8i6
        aXSoPtguxc5yfPHQfNSUfZc=
X-Google-Smtp-Source: APXvYqwYr/tT87XAf5qh/Es7LmGoUEkn3mmZei5o+zwsv6IFLhtMvSGYlF3BfpxBSF4PDYHGp0kVKA==
X-Received: by 2002:a1c:14:: with SMTP id 20mr11389749wma.66.1554115497740;
        Mon, 01 Apr 2019 03:44:57 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w11sm31340822wre.15.2019.04.01.03.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:44:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>, David Barr <david.barr@cordelta.com>
Subject: Re: [RFC PATCH 0/5] Fix some fast-import parsing issues
References: <20190220225846.10658-1-newren@gmail.com>
        <CABPp-BHp83H1qhrd-j1yvdWz56AwDJogFjf_3iaEDVjFvGansg@mail.gmail.com>
Date:   Mon, 01 Apr 2019 19:44:56 +0900
Message-ID: <xmqqwokevwbb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Feb 20, 2019 at 2:58 PM Elijah Newren <newren@gmail.com> wrote:
>>
>> I found a few issues with parsing in fast-import (dating back to
> ....
>> I've cc'ed the relevant folks, and have a few patches that fix the
>> issue and I think make the parser more robust against future issues in
>> a way that I think is safe enough for backward compatibility, but
>> "backward compatible enough" might concern some folks; if so, please
>> take a look at patches 4 and 5.
>
> Just thought I'd ping to see if folks have any concerns with this
> slight tweak to backward compatibility; if not, I'll just repost the
> patches removing the RFC label.

It's been more than a month and we haven't hard from anybody,
perhaps?
