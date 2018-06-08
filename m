Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 434D41F403
	for <e@80x24.org>; Fri,  8 Jun 2018 09:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbeFHJlF (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 05:41:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51984 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752674AbeFHJlA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 05:41:00 -0400
Received: by mail-wm0-f66.google.com with SMTP id r15-v6so2211440wmc.1
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 02:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=OvYQ9YnLffu/f8nENSdiiwjKXX7GAReyPI8SqX3Y4Bg=;
        b=itoIf0mLAdezmzoF0gX88G/gIqVl2N0uGf2JOVx0aaOiTaiD0wY9PqTPGVqLniUv6e
         kwZulczUYWcdWR3yCSD+CgIX0GauLnI6d+RgrqKcS8T9poZyTFuE5PhhBbY+cT1f0YJI
         1lrj0gMYjxYtCE9REGsiWbcM+++kgOeDz+1j4E/PDOeDTK5Ic8Lg0+cqTXhQZ1RwkJCY
         M5ufeLsLYRuaLvVLSWVOzIVTmX5+H6gLAq+cwJi+8kyq0OO7/OjHWRfL2KINxXdrDXpe
         Ob4SrwMtL9jHWWf+GJX3SKe3K9DEN9DlUX4e7FQ8t9ZbS3P1sC2DEfOM+Vag6/vL0RPT
         JBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=OvYQ9YnLffu/f8nENSdiiwjKXX7GAReyPI8SqX3Y4Bg=;
        b=cGj2+jxJgJpN2P0NJcqetdS8UOfmwlhKoNiZDUrRTgl0nJ+TSoodY+3F/UbkijO0Hm
         pFm/4JQpd+pluUhPwWrKQ/b8Byzj0nFM0r13gq9Ci98mCZ4JjMTQ6z2dWCO7jxRJ4FTK
         4B6Yrz+9DHomPW5vzTEg+oKg2gavJRTXPHHxYjyqxfHY9EYYgTCw39D2yZSpzHdR5Q5k
         NPmFNUAYBv5U7wYwAakfa9PSAHhh3qaUJsKPvOxR6wtQxp4gy5UuGlCQEhGSCWXamEO2
         NbMKaFumMtjKY8YxhlpT0EcbDGK3/6tk7hxc29vjnUZMcjbwsCpBQu7WqonoJwYBSuql
         zJUw==
X-Gm-Message-State: APt69E16ErTN5DQ3zB/r1gSHZ/MrPISppFO24MkiH0kIQHuAk5yI63OA
        307jIm+QJDtalKL8GQ+r/1WF6COb
X-Google-Smtp-Source: ADUXVKI6RQCnCQb9FUrl6T5xEpujJkMiNAUklW5YHioHQrfTblaiAbKKxo/YY8qOSUIQ7F3eNreKHA==
X-Received: by 2002:a50:a307:: with SMTP id 7-v6mr6305179edn.292.1528450859304;
        Fri, 08 Jun 2018 02:40:59 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id b32-v6sm607706edd.85.2018.06.08.02.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 02:40:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
References: <20180607145313.25015-1-git@jeffhostetler.com> <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
Date:   Fri, 08 Jun 2018 11:40:57 +0200
Message-ID: <871sdhzkd2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 07 2018, Johannes Sixt wrote:

> Am 07.06.2018 um 16:53 schrieb git@jeffhostetler.com:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> I've been working to add code to Git to optionally collect telemetry data.
>> The goal is to be able to collect performance data from Git commands and
>> allow it to be aggregated over a user community to find "slow commands".
>
> Seriously? "add code to collect telemetry data" said by somebody whose
> email address ends with @microsoft.com is very irritating. I really
> don't want to have yet another switch that I must check after every
> update that it is still off.

To elaborate a bit on Jeff's reply (since this was discussed in more
detail at Git Merge this year), the point of this feature is not to ship
git.git with some default telemetry, but so that in-house users of git
like Microsoft, Dropbox, Booking.com etc. can build & configure their
internal versions of git to turn on telemetry for their own users.

There's numerous in-house monkeypatches to git on various sites (at
least Microsoft & Dropbox reported having internal patches already).
Something like this facility would allow us to agree on some
implementation that could be shipped by default (but would be off by
default), those of us who'd make use of this feature already have "root"
on those user's machines, and control what git binary they use etc,
their /etc/gitconfig and so on.
