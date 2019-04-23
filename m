Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13E381F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 01:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfDWBVf (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 21:21:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40026 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729104AbfDWBVf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 21:21:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so16609936wmi.5
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 18:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QvcMe/NdscFk0hY7h7hB6qgyJkduBaKwZQa5tvwz52k=;
        b=aphPB2jDGK85mT+5I+lU+ilSmXcvWBwufY7iiHgHHqqmlUhR0xBtaAWeZDKVYxd4r+
         EFI1Cu4AATgtoS6cw/glOsfSisljguSp8rD3vmntfYHrjaJwBjbeqzy0Si1c/c6cWorS
         sSQPT4NA3pSnAjf4qSQMie8//irywl6i2fC3jKIkX+GczywEnyRkl7CEome63J5g89rn
         BAsnIQIX1jQ7r/V1YrZJkGugVDMin0KO+JptemWQXJurscua7fwA0wUefTGgItEhyU/k
         JgNSMpPIvP53B+80PSTijZLZbturYdXXQr9JyCe341VaF7dhNxjfxVe7WRxWRJi9vLyR
         3v+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QvcMe/NdscFk0hY7h7hB6qgyJkduBaKwZQa5tvwz52k=;
        b=Or9mFn93537cJJrglneFI4p3OCNUaOFWleDuRky/d4J2j05lXfnqCST6tTCdkik0DY
         gS1RZvEE/mSNmr3jQOopRMwuDtGnSm8FPOadlckZgQ3mxdvEwZYjWIn8MfRy5DzbYnVc
         EXYy/Z6TotgRnxfxjOxwGmqMFLqVz0YJBg/OnKE60xeDWwsDoWkJ4Uni210G9jSKKK4T
         3QwE0LhUw0jHL3nV77iraGV2z7FIDe4qID7MgVtZfHNraG7jmgr0Jw4H6xUYBRMjFbyX
         LHSZn8iV4div/ZsEnmJV7NxkzuC5CmlPDzJt15Q2/SyPvViFG32oIsJJGi1Q75Ir2rUa
         Vthg==
X-Gm-Message-State: APjAAAWvCAdkM8Cib3CC/Liod3amHztfAag+QQ5qqfxsvYoZ5Ah5l+wh
        TLOqW/8xnx12WJhA2sN6jSU=
X-Google-Smtp-Source: APXvYqy1G0xdLoG18Hz4rhdcQrF/7TAt6B0p2rUk0S1Ik1UnRkFGUoAMrNjesS/y0vRwffPAw0JQCA==
X-Received: by 2002:a05:600c:21c3:: with SMTP id x3mr193280wmj.90.1555982493567;
        Mon, 22 Apr 2019 18:21:33 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o1sm20931902wmh.47.2019.04.22.18.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 18:21:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH/RFC 0/2] rebase: add switches to control todo-list setup
References: <20190422000712.13584-1-phil.hord@gmail.com>
        <xmqqk1fm9712.fsf@gitster-ct.c.googlers.com>
        <623d6ebd-60c4-916d-6295-4c648dbf3932@gmail.com>
Date:   Tue, 23 Apr 2019 10:21:32 +0900
In-Reply-To: <623d6ebd-60c4-916d-6295-4c648dbf3932@gmail.com> (Phillip Wood's
        message of "Mon, 22 Apr 2019 15:44:00 +0100")
Message-ID: <xmqq4l6p7bz7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Doing "git rebase -i master" and then editing the todo list has the
> side effect of rebasing the branch. Often I find I want to amend or
> reword a commit without rebasing (for instance when preparing a
> re-roll).

I am not sure what you mean by "not rebasing".  Are you talking
about --keep-base that uses the same --onto as the previous?

I think that is often desired, but I do not think it has much to do
with the topic of the proposal these two patches raises.

And that (i.e. "this has nothing to do with the choice of 'onto'")
was why I used the casual "rebase -i master" in my illustrations.
