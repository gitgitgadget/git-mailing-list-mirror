Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D22AC20248
	for <e@80x24.org>; Mon, 25 Mar 2019 02:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbfCYCjf (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 22:39:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37333 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfCYCje (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 22:39:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so7363628wmf.2
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 19:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VhPKls+jp1kIfbXAG8rOvwybDg658CXZi76t7nfgQN0=;
        b=s/eCdUVzDLg3tms7WBRLDCsgt46bEbYOTuD3OqEsNhEIvIAq50HRrLgDy28prmLmeU
         A4YyyYtDXLZ2jnWUtw5Eyp/6JLSHEKJIiFbQsstTUMZdOIIV/trBW4UuWNTUdqNVr+jN
         oAhPx6JpdVETb8T28UkawKsKop2C4Zax5aoR6p3rIY2Pd5h2wk8Q1CpEZpcyPqGwMpVh
         gjIUNIaKoU/rYUDnDJHBf73Vm8Ksb23ndiQ14GY9WjXSwArI/ryzi5nquMem0qs+KtO3
         rnAtchjGuRd4/iHtEI2e7BiDYTFCnhwAxOJPl9e7wai0Duc8keQ3Cqy5opKTYNXLwPHZ
         ddWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VhPKls+jp1kIfbXAG8rOvwybDg658CXZi76t7nfgQN0=;
        b=o3Ws05+QEJM5vi8/qYn+kq8hcYbABf4Ay7dkZVlxzTauXYq8mj4C290jg+wPbjzSNM
         Lj+b9/31hg0YM+OlSel/tgnQLrZTunLLIeZu+/QUTe+SiX4fmFtaQKS7fVSm1INrkALk
         O4mI6ZjDlN0b15O9ZjX8K2p2f2LUiMCgWlw9DgBGacYnwaTdhC1DaL66y5qjuDTiHIw/
         xIlM7iMwl9Zm8Oqsyg5eSjKKUgeSn4Tkox2cikUmU4iBCrAzRuE2fAR3quzTARTM5dQ2
         eroyOktYLQeJ30F9/BmpvVGqprEkiNauxT1faC/wxRETHkPp7zCDXb31656j3DzoCMiZ
         wuvQ==
X-Gm-Message-State: APjAAAXwFcf8gYHie2skCKRqB6llssMIbpVgNALUmMQ7QUfCQtIa2t9a
        /gONJatZaMz1T1/RzZHWxKk=
X-Google-Smtp-Source: APXvYqyuOhH94zSFQVT0xQG8YE/rzg0UiccYfOQ9vW9ww8eBdF0hakxLR0B8XnoXB8fZ19WqsT1Lqw==
X-Received: by 2002:a1c:3543:: with SMTP id c64mr4031984wma.75.1553481573309;
        Sun, 24 Mar 2019 19:39:33 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id x5sm14782178wru.12.2019.03.24.19.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 19:39:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     michael@platin.gs
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        =?utf-8?Q?Re?= =?utf-8?Q?n=C3=A9?= Scharfe <l.s.r@web.de>,
        brho@google.com
Subject: Re: [RFC PATCH 0/1] Fuzzy blame
References: <20190324235020.49706-1-michael@platin.gs>
Date:   Mon, 25 Mar 2019 11:39:32 +0900
In-Reply-To: <20190324235020.49706-1-michael@platin.gs> (michael's message of
        "Sun, 24 Mar 2019 23:50:19 +0000")
Message-ID: <xmqq5zs7oexn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

michael@platin.gs writes:

> From: Michael Platings <michael@platin.gs>
>
> Hi Git devs,
>
> Some of you may be familiar with the git-hyper-blame tool [1]. It's "useful if
> you have a commit that makes sweeping changes that are unlikely to be what you
> are looking for in a blame, such as mass reformatting or renaming."

I recall a month or so ago brho@google (CC'ed) sent a "let's allow
blame to ignore some uninteresting commit" topic, which was
unfortunately not well reviewed (what I mean is *not* that it was
reviewed thoroughly and found to be bad---not many reviewers found
time or inclination to review it well).  The topic is queued as
br/blame-ignore and its tip is at 43a290e3 ("SQUASH???", 2019-02-13)
as of this writing.

Perhaps you two can join forces?

P.S. I expect to be offline for most of the week (packing, moving
and unpacking.  Even though the places packing and unpacking happens
are within 1 kilometer radius, that does not make it less hassle
X-<).  See you guys next month.
