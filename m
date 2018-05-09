Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D99311F424
	for <e@80x24.org>; Wed,  9 May 2018 17:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935304AbeEIRmw (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 13:42:52 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:46753 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933555AbeEIRmu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 13:42:50 -0400
Received: by mail-yw0-f179.google.com with SMTP id i17-v6so10941474ywg.13
        for <git@vger.kernel.org>; Wed, 09 May 2018 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BlTTFJGVuhsyxHRqE8CerRB2QXXeABjyi0zBNR2+rWg=;
        b=QpW6B+35l2q49QMi1R9Egi51Yck2hQhHMoAsQcoFix6wUUFp/+65uye8pDEZ2Xii5c
         W+6/e5zRAVeqP4cLC6Lm2tRKmysMG04cmx0uUrX6zg2zd49s71w6vicFgpt3kq4IsdhD
         MQMbjkpRsJiyHkxZAqr/gzTADtm5kTKp+YTHjFY23sucLEjPaxfsp+6W7Vcp/P658qhp
         7fJm615Hdw3hS2esnoQ/6LT/l9PrHVrJiPFeXJdgBdavlDmED5V+I3CS9IClG0sAUQZQ
         55NC7LBNRZy18iW1qar4xyXah+RtARixI3bT5M1CMENqxfvq8s0Xq2GVoQIDJ3NkWuEG
         ZBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BlTTFJGVuhsyxHRqE8CerRB2QXXeABjyi0zBNR2+rWg=;
        b=GQ7bFPUWrg/Ro1SAUOtkit2t1KQnCUcAxb2eVNtVY74lIHffgpvn9z+vP5xCz9PV+9
         Y7rMrJY19oEr2vclAwgcRx2eG62bcU8So6y7Z3jau6f4hTv28vp0i/RU/QlEtWcEkyo2
         8YZNJ8/QQZvIys9yvuPxRbcbZ+HTyuwN/QkK/J2Wm5bQXiXsenTZkyt4ONns36X85bV3
         MD5y+eMevC297BXCUfj6QwY8SumlJbN7OuC5OjqIaEOIpN5pEpMNjNfoF3FPL/qdP2iH
         ViMWDidWHHxwrKcNbHI7cfv6mqaUEddVyZjeg18SPUmf+mV5D5rHXoMANk6Ogj/0GiF3
         AChA==
X-Gm-Message-State: ALQs6tA/RAYElPaksSywuzC7AUYa6knbYBaMzUx5/ZaKKnpvyWpcbdGA
        GYAfMhEnj+IzfDL8KoLUvaw2qyyu7kivFpr6TSaUcg==
X-Google-Smtp-Source: AB8JxZpvUXJhsKfNRZlGOi/f6l51ufzHlxmG6zqXPMFbtGRr2boa3Huy9idbQeTcIenxZ5bneymQHZVWnuCVSFQiHK0=
X-Received: by 2002:a81:8801:: with SMTP id y1-v6mr24674610ywf.238.1525887769701;
 Wed, 09 May 2018 10:42:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Wed, 9 May 2018 10:42:49 -0700 (PDT)
In-Reply-To: <CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com>
References: <CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 May 2018 10:42:49 -0700
Message-ID: <CAGZ79kZx=wHKc=2WLz-8pQWv1VhRq+pKVV9=Shq3gEMdkX-Q=A@mail.gmail.com>
Subject: Re: Implementing reftable in Git
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Wed, May 9, 2018 at 7:33 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Hi,
>
> I might start working on implementing reftable in Git soon.

Cool! Everyone is waiting for it as they dream about the
performance and correctness benefits this brings.

Benefits that I know of:
* performance in repos with many refs
* no capitalization issues on case insensitive FS
* replay-ability of the last fetch ("show the last reflog
  of any ref under refs/remote/origin") is easier to do
  in a correct way. (This is one of my motivations to desire reftables)
* We *might* be able to use reftables in negotiation later
  ("client: Last I fetched, you said your latest transaction
  number was '5' with the hash over all refs to be <sha1>;
  server: ok, here are the refs and the pack, you're welcome").

Why are you (or rather booking.com) interested in this?

> During the last Git Merge conference last March Stefan talked about
> reftable. In Alex Vandiver's notes [1] it is asked that people
> announce it on the list when they start working on it,

Mostly because many parties want to see it implemnented
and were not sure when they could start implementing it.

> and it appears
> that there is a reference implementation in JGit.

The reference implementation can be used in tests
to see if we can interact with them, using the JGIT pre-requisite.

> Looking it up, there is indeed some documentation [2], code [3], tests
> [4] and other related stuff [5] in the JGit repo. It looks like the
> JGit repo and the reftable code there are licensed under the Eclipse
> Distribution License - v 1.0 [7] which is very similar to the 3-Clause
> BSD License also called Modified BSD License which is GPL compatible
> according to gnu.org [9]. So from a quick look it appears that I
> should be able to port the JGit to Git if I just keep the copyright
> and license header comments in all the related files.
>
> So I think the most straightforward and compatible way to do it would
> be to port the JGit implementation.

I would think you can go by the spec and then test if it is compatible with
JGit; that way the spec will be ironed out in corner cases.

> Thanks in advance for any suggestion or comment about this.

I volunteer for reviewing.

(Advanced:) The spec allows for some tune-able parameters and JGits use
is heavily optimized for the server side. I think git-core may need to have
slightly different tweaks in different situations, e.g. block sizes and how
many restarts are put into the block.
On the FS we may want to have faster access at the cost of more disk space,
whereas in the future when using reftables on the wire as well for ref
advertisement we may want to opt for smallest tables. (largest blocks,
no restarts)

With that said, please implement it in a way that it can not just be used as
a refs backend, but can easily be re-used to write ref advertisements
onto the wire?

Thanks,
Stefan
