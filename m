Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DA8520802
	for <e@80x24.org>; Thu, 22 Jun 2017 22:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbdFVW6a (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 18:58:30 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34447 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752714AbdFVW63 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 18:58:29 -0400
Received: by mail-wr0-f174.google.com with SMTP id 77so42712345wrb.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 15:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Hi9/U4dnzY3yRFTEh4O7nnJ0Gou7CD7apieoXkIl3I8=;
        b=mFiDb71om4CaUJxnvbSmY8WGw+RTIA5rx0KWKKClO40+lj2dRGWrPnVe6kmUJ/gGv2
         D4V1F5PLp8EmVWYYfek3AiMml+5WOR5s6GXrq+m5Ax9gZCo4gNEl5jYzO7Xw1C54JwZ8
         29gT/evj9YnwYHalGu0HgxwEPnVdz0T/tZtwD/w/EqqwF45ULc5GJdVXuoo4ruTq/L0j
         zwoCbElGEranWq+PFqv0Xmcu/d/fqq8NxAB88iJHkxU8Y1+Vb+FEdxOqJtdugN4pjcYW
         hPWZQXauP1Gr4+STGFwyf9lXl35rcwYg/yL+Ggk6fLiXEfllhihcRuW8uaLUKaFgEOjE
         l1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Hi9/U4dnzY3yRFTEh4O7nnJ0Gou7CD7apieoXkIl3I8=;
        b=DiYaNDLVBq33G2/Itn5LmDqNA89z9iwVWHE8jEbZFdV6ksRwPfPJNZdUe+8Vdc0RGf
         hZvxtiPoCupNa5s/HqQPnEsn8WIEEHKi01nj33oCZBSp7sIFsMD+O545RV12O0DcSegI
         OUl6CPXCYzEmVXOrTI0gdu1WS/vlRT5jSm/SnOKJIvRf65dKSwI/lrTIG2FEtHryTi/Z
         voZwIMEQnDIiKLeHAEKzupye8VhCaeXcoWm1S2sOXsZtXx+skrGhWllBvI4NuXm1XBog
         juYFfvcEYvW6R8WIuixJDdeU+E22Lxz5QORygkq94HiAJK4EWZmF22M1wcSZMdHNdF0G
         /JfQ==
X-Gm-Message-State: AKS2vOzQGnJg6Qf/3UKVihUkcREEdOqCPb+7UJkR7ovHAdCeuT0uQxBX
        zk32r6O6CCeKyQ==
X-Received: by 10.80.204.214 with SMTP id b22mr3967395edj.16.1498172308055;
        Thu, 22 Jun 2017 15:58:28 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id r28sm1425256edd.33.2017.06.22.15.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2017 15:58:27 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dOB3S-0005xn-GQ; Fri, 23 Jun 2017 00:58:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Ben Peart <peartben@gmail.com>,
        xiaoqiang zhao <zxq_yx_007@163.com>
Subject: Re: What's cooking in git.git (Jun 2017, #06; Thu, 22)
References: <xmqqinjnhcr8.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqinjnhcr8.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 23 Jun 2017 00:58:26 +0200
Message-ID: <877f03k4tp.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 22 2017, Junio C. Hamano jotted:

> * sd/branch-copy (2017-06-18) 3 commits
>  - branch: add a --copy (-c) option to go with --move (-m)
>  - branch: add test for -m renaming multiple config sections
>  - config: create a function to format section headers
>
>  "git branch" learned "-c/-C" to create and switch to a new branch
>  by copying an existing one.
>
>  Has a bit of interaction with two other topics, so perhaps needs to
>  wait for them to stabilize a bit more.

What topics are those? Didn't see any outright conflicts, but might have
missed something. Anything Sahil & I can help with?

> * ab/sha1dc (2017-06-07) 2 commits
>  - sha1collisiondetection: automatically enable when submodule is populated
>  - sha1dc: optionally use sha1collisiondetection as a submodule
>
>  The "collission-detecting" implementation of SHA-1 hash we borrowed
>  from is replaced by directly binding the upstream project as our
>  submodule.
>
>  Will keep in 'pu'.
>  Impact to the various build and release infrastructure of using
>  submodule is not yet fully known, but this lets us dip our toes.

I'm in no rush to get this in. I just submitted it initially as a
"submodules make sense here, and in git.git, yay!"

But it's been 1 month kicking around in pu now. What are we gaining from
keeping it there even longer at this point?

> * bp/fsmonitor (2017-06-12) 6 commits
>  - fsmonitor: add a sample query-fsmonitor hook script for Watchman
>  - fsmonitor: add documentation for the fsmonitor extension.
>  - fsmonitor: add test cases for fsmonitor extension
>  - fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
>  - dir: make lookup_untracked() available outside of dir.c
>  - bswap: add 64 bit endianness helper get_be64
>
>  We learned to talk to watchman to speed up "git status".
>
>  Waiting for discussion to settle.

Been meaning to do my part to follow-up on this one, sorry about the
delay.

> * xz/send-email-batch-size (2017-05-23) 1 commit
>  - send-email: --batch-size to work around some SMTP server limit
>
>  "git send-email" learned to overcome some SMTP server limitation
>  that does not allow many pieces of e-mails to be sent over a single
>  session.
>
>  Waiting for response.
>  cf. <CACBZZX5GYV50rjg9X602JHqFPaoofH9TwDf_-r_MDu8-rmNV6Q@mail.gmail.com>

I think between <7993e188.d18d.15c3560bcaf.Coremail.zxq_yx_007@163.com>
& <20170523103050.1f7ab7e0@jvn> we have sufficient info about what bug
this solves to try an alternate approach at some other time.

I think it makes sense to merge this down.
