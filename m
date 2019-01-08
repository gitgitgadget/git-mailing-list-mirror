Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 799131F803
	for <e@80x24.org>; Tue,  8 Jan 2019 14:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbfAHOoZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 09:44:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42003 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbfAHOoY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 09:44:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so4283800wrx.9
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 06:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=C4ySCtiOOfIaR6fYSFeuobkX3ZbeeRjqxWwsTgxXL7g=;
        b=oRU8bwjTNzjv1nHpGePG2Hp9Nrk3hmhFryDWPMEmHLq3NxUBcrKUuh7Bj1UAZHLAIV
         Cciq3GpKO7++dfyKavZ/QUvIJqioIWQU7j7ocg5XXzS33B6H5LRDg3tgWyJvjdDBDnxy
         DmIOMgsYLepyP9kqGspdPpUe9vsmuKLXliSxbRoh6L/3yW8meWIik3HJBa1LQBnZTw02
         GelJwpa7fcbu8wVtvSoE7jSjqNLgb7clibDu+QUjYz0ZrzjckQZHZ5tnPKYqKqo60F7q
         QvmpjZPbb6XalYFvvdLYQRcUHatnW+hFbj9nzCJyG+4BmuyxfAY5k3ZUg0i+Xmg1VcUH
         nKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=C4ySCtiOOfIaR6fYSFeuobkX3ZbeeRjqxWwsTgxXL7g=;
        b=eleNlD3Y1DhwBxrEF0VP5sPNZ9fJ0oQbemYhTO3shC8hrFUILyZS7ULp+4ZdXBGCPo
         ycK4iJ2U7HTQs5HT1aMy0xfcEKqgt22ItfR9bVs14cE68aznZSri3lca5tShSrnrEZ+b
         webFUQfG29U/Vv51IIu4p7vgr/7TWwi4rLRq5M2VSg/mvDeL+NB7M5RlVvHFbrgT6z0w
         MatuNyzZkcrqSbhy6QSAdAnJvhy0G2IqzvGxwH0nOw7IqmybeBpdf/Xj2scNBkLBATw9
         eVn5+yx471UqOFCx6F/Vl8nnFZl6Kz1CfTlUi6c4vxWB3c1tsG0YuJHqkbSHauoPK9vN
         R6Fg==
X-Gm-Message-State: AJcUuketikpI4OP297lXf9iyl97xnPrOD6Y7U19cGS50X1hV2MeeOOxJ
        8Hwlx1QuafxKCpY7F28MhSI=
X-Google-Smtp-Source: ALg8bN7zOk7hP++zsYYoAjhfIrdSrb9JOmPh8Wdc2k2+UnDElWpg2H0MdTDOitgm7xFxxhypA0QX3g==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr1616818wrt.193.1546958662453;
        Tue, 08 Jan 2019 06:44:22 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u204sm10534581wmu.30.2019.01.08.06.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 06:44:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     git@vger.kernel.org
Subject: Re: Recovering from a "detached from" HEAD
References: <20190107161748.pyhgpewymdgjmgoh@x220>
        <xmqq8szw8d8o.fsf@gitster-ct.c.googlers.com>
        <20190108141927.a4q5fqug3ymkh5v3@x220>
Date:   Tue, 08 Jan 2019 06:44:19 -0800
In-Reply-To: <20190108141927.a4q5fqug3ymkh5v3@x220> (Alyssa Ross's message of
        "Tue, 8 Jan 2019 14:19:27 +0000")
Message-ID: <xmqq36q36wfw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alyssa Ross <hi@alyssa.is> writes:

>> The commit the message shows is meant to indicate where your unnamed
>> branch diverged at named branches.  Immediately after moving to the
>> unnamed branch by detaching the HEAD, the message says "at"; the
>> HEAD is pointing directly at the tip of the then-current branch and
>> that is where the tip of the unnamed branch is.  You can tell from
>> that message that you will not lose any commit if you were to check
>> out a named branch from that state.
>>
>> After you make a commit on the unnamed branch, you have something to
>> lose if you were to check out a named branch from that state, as the
>> detached HEAD is the _only_ thing these new commits you built on top
>> of the fork point.  Upon seeing "HEAD detached from 9745ede235", you
>> could do "git log 9745ede235.." and see what you would end up losing
>> if you were to switch to another branch without saving them first to
>> a named branch.
>
> Thank you for the detailed explanation. I was for some reason under the
> impression that "git status" would show the current HEAD, rather than
> where it was detached. Why I thought that, I don't know.

I wrote not from the documentation but from what I remember about
the discussion that led to final phrasing of the message, and I
strongly suspect that your impression is the sign that our docs are
insufficient.  If you can spot where we can improve on, that would
be great.

Thanks.
