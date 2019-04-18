Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97CDC20248
	for <e@80x24.org>; Thu, 18 Apr 2019 17:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388387AbfDRRce (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 13:32:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42656 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbfDRRce (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 13:32:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so3914054wrx.9
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 10:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=cglEzcMx/WUo3lXOaHosfVRluf1tlDVA0Vl5cWZtlAc=;
        b=N5HjPS7PZCdv698xRFUKA2FaeMcM6pLXz5oGOhAEqDQb2Fg2BFrQsP0RcTc/P6BPBD
         +IGOr7lvJvBfzvKIr7uSTtS7pJGe5qnq7Xj1q9ieYe8fs+yVbOI4dIesSzeuDNy9zE+B
         d7FzChKT86f1NTiTvUMMPrBzPZA46o8cI4MIgj7zVYXfUFONG6iKFL/SssAuYKd1q3IY
         ItfPoPq3+bDRUgjqq6hZYNf103Ktx+n2ygq5tG7Os71/L81DOGMrowaCKTvt5eGJj0/7
         lvT9BjF14N9K3+QpARyuytgbsxN94RsTVwEbWOsafV7YsK62MsAxOYOtz0m9gJt1x5Gz
         GF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=cglEzcMx/WUo3lXOaHosfVRluf1tlDVA0Vl5cWZtlAc=;
        b=R+2Y6mZHz++5CDNXdpyUQdGW6YuBMWIEIUwUB4E57TyD6d5zmrQPCJurPaSnuSWEt0
         8FJKdW+cRWDmW/9f4yDppl5kLpQCDrkNuR1y24QMzXl2kRjeNCRBm36jK5tl7tZLbm1d
         SKCM4FdULrROtr5ld0H5sI1OglWX7CqJQbHoQ57x7eiZH9Ba/oP28Lt5mKTvV+0a2253
         ldLUPu5WOFgobet42ggaLkMewl26CbJnugWgarWNfTJgddwH1HJd0x1wNNhbXjPpJ4Aw
         WZ2VDHwhvZ7GAvYeQ5BUtcqLDwozRu7IRwmWgmOBSBh+sorE6COj1uIwGWcU3wbgEU3n
         3ozw==
X-Gm-Message-State: APjAAAU8pevnMKF8LQDHBqYxKsEkPvdeOXw3apVPN1wOPAImpyq4Vmee
        7eG7nHKD3XK1fohefhnuTJ1kQJPOuEU=
X-Google-Smtp-Source: APXvYqx+fZqZrCLgdq4ikzmK9sZRpWhbxPRCD32aXkGxHgauOolBrSWXOSGPD4VTejmrfao7Ey2lww==
X-Received: by 2002:adf:ef0c:: with SMTP id e12mr61013963wro.170.1555608752180;
        Thu, 18 Apr 2019 10:32:32 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ejz242.neoplus.adsl.tpnet.pl. [83.21.167.242])
        by smtp.gmail.com with ESMTPSA id h9sm1825828wmb.5.2019.04.18.10.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 10:32:30 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Giuseppe =?utf-8?Q?Crin=C3=B2?= <giuscri@gmail.com>,
        git@vger.kernel.org
Subject: Re: Feature request: Allow to update commit ID in messages when rebasing
References: <CAGV3M54XhRMDXdhbfTon5nRV59VOjw8W4YrNP63TqPYm8pxd8Q@mail.gmail.com>
        <878sw8bbby.fsf@evledraar.gmail.com>
        <xmqqtvewgj4c.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 18 Apr 2019 19:32:26 +0200
In-Reply-To: <xmqqtvewgj4c.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 18 Apr 2019 11:08:51 +0900")
Message-ID: <86o953z0b9.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> On Wed, Apr 17 2019, Giuseppe Crin=C3=B2 wrote:
>>
>>> The feature I'm asking is to add an extra-step during rebasing,
>>> checking whether there's a reference to a commit that's not going to
>>> be included in history and asks the user whether the heuristics is
>>> correct and if she wants to update those references.
>>>
>>> Scenario: it can happen for a commit message to contain the ID of an
>>> ancestor commit. A typical example is a commit with the message
>>> "revert 01a9fe8". If 01a9fe8 and the commit that reverts it are
>>> involved in a rebase the message "revert 01a9fe8" is no longer valid
>>> -- the old 01a9fe8 has now a different hash. This will most likely be
>>> ignored by the person who's rebasing but will let the other people
>>> reading history confused.
>>
>> This would be useful. Done properly we'd need some machinery/command to
>> extract the commit id parts from the free-text of the commit
>> message. That would be useful for other parts of git, e.g. as discussed
>> here:
>> https://public-inbox.org/git/xmqqvaxp9oyp.fsf@gitster.mtv.corp.google.co=
m/
>
> That's a helpful input.
>
> But in general we do not have an infrastructure to systematically
> keep track of "this commit was rewritten to produce that other
> commit", so even if a mention of an old/superseded commit can be
> identified reliably, there is no reliable source to rewrite it to
> the name of the corresponding commit in the new world.
>
> For that mapping, we'd need something like the "git change/evolve"
> Stefan Xenos was working on, which hasn't materialized.

Well, what about limiting changes and rewriting only to the commits
being rewritten by [interactive] rebase?  I mean that we would rewrite
"revert 01a9fe8" only if:

a.) the commit with this message is undergoing rewrite
b.) the commit 01a9fe8 is undergoing rewrite in the same command

We could use the infrastructure from git-filter-branch for this.

It is serious limitation, but that might be good enough for Giuseppe
Crin=C3=B2 use case.  Though for example there is a question what to do if
referred-to commit (01a9fe8 in the example) is simply dropped, or is
gets split in two?  Ask user?


Another possibility would be to provide a command line option to rebase
which would automatically generate replacements (in git-replace meaning)
from old pre-rebase name to new post-rebase name (assuming no splitting,
no dropping commits).  This would make references just work... well, as
long as refs/replace/* are in place (they are not copied by default).

On the other hand some of our performance-improving features, like the
commit-graph, do not work if there are replacements.


Best,
--
Jakub Nar=C4=99bski
