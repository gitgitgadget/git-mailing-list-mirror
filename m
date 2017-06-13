Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 036441FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753092AbdFMRo7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:44:59 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:32828 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbdFMRo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:44:57 -0400
Received: by mail-pg0-f52.google.com with SMTP id f185so63824880pgc.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qtUQptaFUvC8bt17qYr/hBiXe6tz7dCDzveo9bWwcZY=;
        b=M2LXx9Q53bJDlR+6GFv644Wk8xjjsuSuEhTYRlW24BgyqmFS+vsVA27vjzCZHm7qt4
         QoxGeusHzp6SoXxWdOg5q0N2iXWl7ByCsxmcw+xMJc40zU6dQgbMt139+J+OtT1z1oR8
         wOFz/+u7tDlHeZmgTWJA6rjukmByvMhg7KlQ2Z+4KU9Qc90WY97wua3UkWz+dpUTnAmQ
         0OnWw7n9gAPBJSn5kvubaTunQERtKv5b6rrIqBqw64KiMW6qJdJX08Xc8JLs+c9JMI0h
         Zqyah+V7+ANrf+V2qzkmq4iLlhf4XNTNawPNorO299giU8GyGDqtW+aMcvmBCvupj7jT
         7Hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qtUQptaFUvC8bt17qYr/hBiXe6tz7dCDzveo9bWwcZY=;
        b=pqhcMxLnDXoy500qrirWglaSMSldVic9nByoRqYZiDwK2SBDZgz0632t2HnSXqeVqa
         0D0tHEK7/ud75GygnM9CWO5wIL979SYNTOd7hzRBs0WZsZ2HJwErv69p2Cl7sakK8Q77
         0NY9I/aRqDi91lj5cCB7Y/S9kgHknNdt1tb7BD1uJpTXCsNA2/u8IMRXDPMgZjhq3uuJ
         4flCtdQfLCtA2yXBLD9aHbN0tNXusOGzRMvsbv9IW48WTtA0MX6RxCMHbYJx180HG5I8
         qMMxQ2znEs0hGDNhejD24Ke/Ba0SI0I9zTj9juozrRRfa05lHYYWoe4NXXLtTYJPRA1p
         f8jQ==
X-Gm-Message-State: AKS2vOxnsQ/HQ2n/oiAEe6ErV8Z3FMkv7jQlwVZnHXcsp5Zrwq9mZEjZ
        JJRDY6g9HMBCAnAFevnR7gb5ehRsj7nZ
X-Received: by 10.98.205.194 with SMTP id o185mr682503pfg.105.1497375891686;
 Tue, 13 Jun 2017 10:44:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 13 Jun 2017 10:44:51 -0700 (PDT)
In-Reply-To: <xmqqbmpr7pyj.fsf@gitster.mtv.corp.google.com>
References: <20170613023151.9688-1-sbeller@google.com> <xmqqvanz9afq.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYR+qh1X-dQixdpDbcr5z-DJ2mkdncaVn_8y90kNco9tw@mail.gmail.com>
 <xmqqa85b9626.fsf@gitster.mtv.corp.google.com> <CAGZ79kYV8Ngis=ux50Zs1r5XOBUJ=hw2=8BEkNqk7PiGamX0AA@mail.gmail.com>
 <xmqqo9tr7qkk.fsf@gitster.mtv.corp.google.com> <CAGZ79kafV5aXd9SAOHHGOgsAdpuY=YV6yWoWSsuG9rncLYhphA@mail.gmail.com>
 <xmqqbmpr7pyj.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Jun 2017 10:44:51 -0700
Message-ID: <CAGZ79kZNXCjBBnzPZLJqPY9S_ovPAegNT0pdCKAMWJH5AQoCCw@mail.gmail.com>
Subject: Re: [RFC/PATCH] builtin/blame: darken redundant line information
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 10:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> But you do not want to (yet)? The goal is not to tell you where the bounds
>> are, but the goal is to point out that extra care is required for review of
>> these particular 3 lines.
>
> And when you _can_ help users in that "extra care" by pointing out
> where the boundary is, what is the justification for hiding that
> information?

It is very complicated and confusing. Consider this:

>          context
>         -C
>          context
>         -B
>         -B
>         -B
>         -A
>         -A
>         -A
>          context
>         +A
>         +A
>         +A
>         +C
>         +B
>         +B
>         +B
>          context

So from your emails I understood you want to markup
block starts and ends, but in this case C is *both* start
and end of a block, and has also different blocks around.

So ideally we could tell the user this

>          context
>         _context C goes to after +A
>         -C
>         _context C goes to before +B
>          context
>         _context -B goes to after +C
>         -B
>         -B
>         -B
>         _context -B goes to before contextB
>         _context -A goes to after contextA
>         -A
>         -A
>         -A
>         _context -A goes to after contextA
>          context
>         _context +A comes from after -B
>         +A
>         +A
>         +A
>         _context +A comes from before contextA
>         _context +C comes from after contextC
>         +C
>         _context +C comes from before contextC
>         _context +B comes from after contextB
>         +B
>         +B
>         +B
>         _context +B comes from after -A
>          context

(show the context of where the move is coming from/going to,
maybe just one or two lines)

And how many colors would be confusing for the user?

I would think we want to start with a simple model and if a
niche is not good (read: people think it can be improved easily
compared to the usefulness they get out of it) enough we fix
it up later.

I thought that adding 4 new colors is already maybe too much,
as Git users were happy with a handful for 10 years, so I am very
opposed to add more than 4 colors unless there is a very good
reason. And I'd think that this is not adding a lot of useful information
for a reviewer?

Thanks,
Stefan
