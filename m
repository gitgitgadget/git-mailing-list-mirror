Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 262531F731
	for <e@80x24.org>; Wed, 31 Jul 2019 10:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfGaKMS (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 06:12:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45229 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfGaKMS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 06:12:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id x19so59252490eda.12
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 03:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xRNA9jpd/UF1B2FclXh18bounahKHDR0z1iIxgP0WWU=;
        b=hOZKMUJgRJnbztiwplHSxyCpRvrl4cEDHNPPcCLziUn0aVMV2o5RGiNTlVbLgV09yE
         x1CWXUzldxCFYtyhp+YxQgEACi0QDiKtaAKviX98+8dD2LfA39v7pXMUn9U32B9GRDS0
         SYt3smRaALq0HLFdwjNDDOy+R6fYxh8RP5OQKqdfQ1GMkKHiXVu2Aflh3IAFZGJrFAao
         H1+77I4ee0/9TbWzAUnFFDA8NNBAV0AUHpCktRKeCAeH+SYsdu3VuhfmckTNaIqW+py0
         quMyH+PR7HVubdRLKLSeUMI1PSI6Cy8iFr8CC0Rpf6/NLLE7xiEpuyOPaB2DFZ5WcZOP
         26Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=xRNA9jpd/UF1B2FclXh18bounahKHDR0z1iIxgP0WWU=;
        b=K4mGNjViBisHcMtm8vBIl+3GZRQFHuOlfJro7t4nB8ocV4bCe2doQcalAjXgDY6jIu
         42fLx6GTN/XL9ahi12rfwJosuukuKShhc/HX6g1X0BxUtsLHh851Rsy7+gfNrlhx9d1i
         QCEH66s0xprAzxGkl2GXfMErYzuAYWEjYW/IYdG+mr12qVk/tD9ztStcrPE7qeiyg5tW
         vSxngtrFtnLkEXQ73c0sOb4/lZ1Tf1ZSPdZPke/FMHon7JLBiOlffOyQH6J+uHPii9YW
         RA5J1cTvc+jxBCMn0pZUqaPsPxSDGA+zH6J/StTalZGdn01bByeiEFNnFhO2bVq66ifb
         xhCQ==
X-Gm-Message-State: APjAAAVPvFg4Znm20Cn6ERU6uzAPVqDBdXS/waoVkODKkf5pWESEodo/
        30PhlGLF66V/1WkKMLmkhGI=
X-Google-Smtp-Source: APXvYqyvIEWv9e7W/DVgWYsH6Cc+gkB1vn6azkigTLXgS2Iq1285uxlIKJ7two9pIX3sX9Lzld3t/g==
X-Received: by 2002:a17:906:b283:: with SMTP id q3mr38886506ejz.153.1564567936085;
        Wed, 31 Jul 2019 03:12:16 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id x11sm17279985eda.80.2019.07.31.03.12.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 03:12:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 0/4] gc docs: modernize and fix the documentation
References: <20190318161502.7979-1-avarab@gmail.com> <20190318215107.GH29661@sigill.intra.peff.net> <87ftrjer8s.fsf@evledraar.gmail.com> <20190319001829.GL29661@sigill.intra.peff.net> <878svjj4t5.fsf@evledraar.gmail.com> <20190507075158.GG28060@sigill.intra.peff.net> <8736lnxlig.fsf@evledraar.gmail.com> <20190731042601.GA26559@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190731042601.GA26559@sigill.intra.peff.net>
Date:   Wed, 31 Jul 2019 12:12:14 +0200
Message-ID: <87pnlq5x8h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 31 2019, Jeff King wrote:

> On Fri, May 10, 2019 at 01:20:55AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > Michael Haggerty and I have (off-list) discussed variations on that, b=
ut
>> > it opens up a lot of new issues.  Moving something into quarantine isn=
't
>> > atomic. So you've still corrupted the repo, but now it's recoverable by
>> > reaching into the quarantine. Who notices that the repo is corrupt, and
>> > how? When do we expire objects from quarantine?
>> >
>> > I think the heart of the issue is really the lack of atomicity in the
>> > operations. You need some way to mark "I am using this now" in a way
>> > that cannot race with "looks like nobody is using this, so I'll delete
>> > it".
>> >
>> > And ideally without traversing large bits of the graph on the writing
>> > side, and without requiring any stop-the-world locks during pruning.
>>
>> I was thinking (but realize now that I didn't articulate) that the "gc
>> quarantine" would be another "alternate" implementing a copy-on-write
>> "lockless delete-but-be-able-to-rollback scheme" as you put it.
>>
>> So "gc" would decide (racily) what's unreachable, but instead of
>> unlink()-ing it would "mv" the loose object/pack into the
>> "unreferenced-objects" quarantine.
>>
>> Then in your example #1 "wants to reference ABCD. It sees that we have
>> it." would race on the "other side". I.e. maybe ABCD was *just* moved to
>> the quarantine. But in that case we'd move it back, which would bump the
>> mtime and thus make it ineligible for expiry.
>
> I think this is basically the same as the current freshening scheme,
> though. In general, you can replace "move it back" with "update its
> mtime". Neither is atomic with respect to other operations.
>
> It does seem like the twist is that "gc" is supposed to do the "move it
> back" step (and it's also the thing expiring, if we assume that there's
> only one gc running at a time). But again, how do we know somebody isn't
> referencing it _right now_ while we're deciding whether to move it back?

The twist is to create a "quarantine" area of the ref store you can't
read any objects from without copying them to the "main" area (git-gc
itself would be an exception).

Hence step #2 and #6, respectively, in your examples in
https://public-inbox.org/git/20190319001829.GL29661@sigill.intra.peff.net/
would have update-ref/receive-pack fail to find "ABCD" in the "main"
store due to the exact same race we have now with mtimes & gc, then fall
back to the "quarantine" and (this is the important part) immediately
copy it back to the "main" store.

IOW yes, you'd have the exact same race you have now with the initial
move to the quarantine. You'd have ref updates & gc racing and
"unreachable" things would be moved to the quarantine, but really the
just became reachable again.

The difference is that instead of unlinking that unreachable object we
move it to the quarantine, so the next "gc" (which is what would delete
it) would notice it's reachable and move it to the "main" area before
proceeding, *and* anything that "faults" back to reading the
"quarantine" would do the same.

> I think there are lots of solutions you can come up with if you have
> atomicity. But fundamentally it isn't there in the way we handle updates
> now. You could imagine something like a shared/unique lock where anybody
> updating a ref takes the "shared" side, and multiple entities can hold
> it at once. But somebody pruning takes the "unique" side and excludes
> everybody else, stopping ref updates during the prune (which you'd
> obviously want to do in a way that you hold the lock for as short as
> possible; say, optimistically check reachability without the lock, then
> take the lock and check to see if anything has changed).
>
> (By shared/unique I basically mean a reader/writer lock, but I didn't
> want to use those terms in the paragraph since both holders are
> writing).
>
> It is tricky to find out when to hold the shared lock, though. It's
> _not_ just a ref write, for example. When you accept a push, you'd want
> to hold the lock while you are checking that you have all of the
> necessary objects to write the ref. For something like "git commit" it's
> even harder, because we implicitly rely on state created by commands run
> over the course of hours or days (e.g., "git add" to put a blob in the
> index and maybe create the tree via cache-tree, then a commit to
> reference it, and finally the ref write; each step adds state which the
> next step relies on).

I don't think this sort of approach would require any global locks, but
it would be vulnerable to operations that take longer than the
"main->quarantine->unlink()" cycle takes. E.g. a "hash-object" that
takes a month before the subsequent "write-tree" etc.

All of the above written with the previously stated "I may be missing
something" caveat etc. :)
