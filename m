Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0805220248
	for <e@80x24.org>; Fri, 22 Mar 2019 03:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfCVDa1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 23:30:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35090 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfCVDa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 23:30:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so738127wmd.0
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 20:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=x9k+ELwMOkJ1kdbOL1I7mbqmTZ478qUP+OBXJOQNwcs=;
        b=AxK7w5+tQuP9QYAahPkN7JmMxn5GxYuXXjbSjhPjrz+yptbKyw45B9GaDjRZDunWx0
         Pb5oH/CcYGLXDAraYjtGURwWN/bYHkHeECHF1nhTJR6eu406u5DBWvgMfn3KpgsmNBiq
         k4F2cYFiokQovpJCloRmgsq6aPvpO0HeBlNqjcl9NnFkODav0s2DCUy9TcFTWv0ecpe9
         Q0jWyYhlpeOhEwMId7yX527DcbuvzKYkxj96coWlFHKK0pMyWgJMmOG8C8A/xb3ukAEf
         V6sA0uZqUvZuemoOpuXU6G0mWbGmSPqyy66PXNMk0rYoVJaz0NJp+BK7L4/3FVz+tdbd
         8fhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=x9k+ELwMOkJ1kdbOL1I7mbqmTZ478qUP+OBXJOQNwcs=;
        b=WYcUHpzT84ZWHXPxuAJKeMgKK5YVnrDOfNTx9n8KxfgxeLPypzXZix+y0wfZY4rOtP
         Lh5S1BkxGd4jOrhPOQw6ro59yZuQKDNKc76tf7h50+G4jTOJHO4pI4g7F28EC0T0wYDi
         zXqysVlj6ZGtrZofSKGmGUMjCwn/vuJJ+3rdFxihAnhzYaVkjmraZ3JPoavCJLcjLZBV
         4pgyL6WbcnpQqmXKxFfBCSm8p5W6ihamRKm9rWANqJ3skGr700D+WojWA4KhHtCwo7GJ
         r4xhyfadUhUz7IxDoP0HqW3VpAJdanmz3vrpkbMHM6qISn2ZF1dYVrsEJnk0z7pYnJz1
         mtfQ==
X-Gm-Message-State: APjAAAXDqJeu/BrpiMNt5iRdBv7O6LtzM07nnfaOHhjcW6g7tkhysyPN
        6upkDkF806nS+lq1kWq3i6RxjOYBtZI=
X-Google-Smtp-Source: APXvYqwrdxs7AQZ934JhRVJzdS9EiuDfvZ4Wa29qOZ0ednjbdtqYCQweHnjk2ReAcZLALDP13kxFYw==
X-Received: by 2002:a1c:cc0a:: with SMTP id h10mr1347355wmb.20.1553225424754;
        Thu, 21 Mar 2019 20:30:24 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o127sm8504382wmo.20.2019.03.21.20.30.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 20:30:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        avarab@gmail.com, peff@peff.net, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2 1/1] trace2: write to directory targets
References: <cover.1552519463.git.steadmon@google.com>
        <cover.1553126984.git.steadmon@google.com>
        <59d8c6511bc8c5fd25473c282768b38c97df9e6b.1553126984.git.steadmon@google.com>
        <xmqqmulpt22e.fsf@gitster-ct.c.googlers.com>
        <51e88650-8667-df1f-13ef-4537f2e70346@jeffhostetler.com>
Date:   Fri, 22 Mar 2019 12:30:23 +0900
In-Reply-To: <51e88650-8667-df1f-13ef-4537f2e70346@jeffhostetler.com> (Jeff
        Hostetler's message of "Thu, 21 Mar 2019 13:43:07 -0400")
Message-ID: <xmqqpnqjr3g0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

>>> +	for (attempt_count = 0; attempt_count < MAX_RANDOM_ATTEMPTS; attempt_count++) {
>>> +		strbuf_reset(&final_path);
>>> +		strbuf_addbuf(&final_path, &base_path);
>>> +		strbuf_addf(&final_path, ".%d", attempt_count);
>
> Since the last component of the SID is already very unique and
> we're unlikely to have collisions, maybe change the above line to:
>
> 		if (attempt_count > 0)
> 			strbuf_addf(&final_path, ".%d", attempt_count);
>
> and in reality expect to never have files with the suffix.

That's a nice property.

> Unless, that is, they turned on more than one of GIT_TR2,
> GIT_TR2_PERF, or GIT_TR2_EVENT and pointed them at the same
> directory, but I'm not sure if I care about that edge case
> or not.

That actually makes me wonder if the auto generated filenames want
to have a common trait (e.g. suffix) that allows the readers to tell
from which of these environment variables the names came from.  It
would not be very useful if two files with the same sid component
had .1 suffix for GIT_TR2 trace for one session, and the same .1
suffix is used for GIT_TR2_PERF trace for a pair of files from
another session.

But let's not worry about it for now.  If people do not want them
get mixed up and become hard to tell apart, they can always specify
different directories for different traces.

>
>>> +		fd = open(final_path.buf, O_WRONLY | O_CREAT | O_EXCL, 0666);
> [...]
>
> Nice.  Thanks for looking into this.
> Jeff
