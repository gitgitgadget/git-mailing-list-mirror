Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22EEA20248
	for <e@80x24.org>; Mon, 18 Mar 2019 22:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfCRWQJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 18:16:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36103 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfCRWQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 18:16:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id e4so14926177edi.3
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 15:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ckeYryjI/RobawqB1vaoTGQgT9WwHEW+YuZ4FlXnIn8=;
        b=edqnPPXgfpsoZZDjfCxaJ+C+MRKV4otY6Hr6j2SFecUgGCqbOFsC6YzfAs+Sc8nYRd
         fX3KcG6CgDZtpcnXJjWkbfaeN0txzHn77SVnDAfBvenXmgu9l5sOp7xglcFER8CO6TIx
         QrBnKWc//0VxqXs2e+ZrdGUIO3ed1FxErTbljbskmZca0Xdw8qBNXR6QdUYwrpDzowMF
         KeT9eB8myIJTscjNLpuvFvw6h59LQNd6bp1bB8b5BKclRsQFXkecF2xBkDNGkzThtJI6
         ilFy0v9JT1RHy1wyETSF9WgQ+ATfETbeau7m2oNaYDHfMHuu/wWU1FL2i6BmsNx5cYhj
         zyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ckeYryjI/RobawqB1vaoTGQgT9WwHEW+YuZ4FlXnIn8=;
        b=bOw506501UincBwmlXn0GTQ3k2rgZbgCWyXzscOTpCJIiEzM4O1mBw6Yt3xq/dqFV7
         ltcNzM2HqijvkFxl3BGceR3/M/2iPgKkPUmtbAwfvm4UOwGirJdM7cRogebzjtSNA84J
         L+uAD+D+tPEn7xPHukXsebZn0sjRsjh4rD2QP7rkCZeD6127KkV24v/lC3cNVbFfbofQ
         sS3SNohmjsfpN43QHF4WFvevhVgLiBl4/l701zm+LLbM0NKW/rdIlaBsjLYSm4fbfEMj
         6Fg4Ovw+6bHIIflXLZrKj8DamITewq5/s75oykG6EVZ5XUqLCqdPrw99nfjow0pbA8FK
         Ux9g==
X-Gm-Message-State: APjAAAW83tbRhLmYCcyuOADL3Bj+hnfrh44odBL0mxsUkqGeR//Fxujb
        M21X7mPbmvCBFn5TP18xWsSugeIlRR0=
X-Google-Smtp-Source: APXvYqzIJdRjZuN5jMu9OX7vS5TXNaczR/lfqRJ+09Thm4+01cwJMEgFMKIaNkXNSK/RTn3HEzhQOg==
X-Received: by 2002:aa7:c50a:: with SMTP id o10mr14250152edq.57.1552947367682;
        Mon, 18 Mar 2019 15:16:07 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id z7sm3895291edl.59.2019.03.18.15.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 15:16:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 4/4] gc docs: downplay the usefulness of --aggressive
References: <20190318161502.7979-1-avarab@gmail.com> <20190318161502.7979-5-avarab@gmail.com> <20190318202824.GA24222@gmail.com> <20190318212227.GD29661@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190318212227.GD29661@sigill.intra.peff.net>
Date:   Mon, 18 Mar 2019 23:13:57 +0100
Message-ID: <87k1gvespm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 18 2019, Jeff King wrote:

> On Mon, Mar 18, 2019 at 01:28:24PM -0700, Jonathan Nieder wrote:
>
>> > +Using this option may optimize for disk space at the expense of
>> > +runtime performance. See the `--depth` and `--window` documentation in
>> > +linkgit:git-repack[1]. It is not recommended that this option be used
>> > +to improve performance for a given repository without running tailored
>> > +performance benchmarks on it. It may make things better, or worse. Not
>> > +using this at all is the right trade-off for most users and their
>> > +repositories.
>>
>> This part kind of feels like giving up.  Can we make --aggressive have
>> good runtime read performance so we don't have to hedge this way?
>> E.g. is this patch papering over a poor choice of --depth setting in
>> --aggressive?
>
> I thought we already did that, in 07e7dbf0db (gc: default aggressive
> depth to 50, 2016-08-11). As far as I know, "--aggressive" produces
> packs with similar runtime performance.


What happened here is that I'd entirely forgotten about your 07e7dbf0db
and in skimming while writing this throught we were still picking larger
depth values, which we aren't.

I'll fix that, and see that gc.aggressiveDepth also needs to be changed
to note that the depth it's now using as "aggressive" is just the
default of 50 you'd get without --aggressive.

> It is possible, if it finds more deltas due to the larger window, that
> we'd spend more time accessing those deltas. But if the chains aren't
> long, the base cache tends to perform well, and delta reconstruction is
> about the same cost as zlib inflating. And we have a smaller disk cache
> footprint.

I haven't tested that but suspect it won't matter. We do spend a *lot*
more time though, so that still needs to be noted...

On the topic of other things I may have screwed up, is this:

    +The effects of this option are persistent to the extent that
    +`gc.autoPackLimit` and friends don't cause a consolidation of existing
    +pack(s) generated with this option.

Actually wrong since we don't pass -f usually, and thus a one-off
--aggressive would live forever for the objects involved in that run no
matter if we later consolidate?

From the docs it seems so, but I'd like to confirm...
