Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79EAD1F991
	for <e@80x24.org>; Sun,  6 Aug 2017 16:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbdHFQ4W (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Aug 2017 12:56:22 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36338 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdHFQ4V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Aug 2017 12:56:21 -0400
Received: by mail-wm0-f49.google.com with SMTP id t201so52414282wmt.1
        for <git@vger.kernel.org>; Sun, 06 Aug 2017 09:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=xW5OsNIp7tITB0OllXRootUzeEQvCIU3GEvZ5zOz/fc=;
        b=oYt3q06e3CRKAdA/IgooRVl/ALzFqI7wDeOnBJHW1cjD8quWP07trGOqxLLErZYlaX
         CmzMrxrVS0GDgGMc5gBC4Wt5wtLqyHz0b+zdTRWiFHQTGfQIceN8Q6KKztpJWRlJYwqd
         0zVjMxXYl/cPx7n/ZuQjBB31LM+gBCqamBWhIcWEDpTGCRF71m/J7Dq7bhl2zODExjL/
         0DElcGX36Np2il4aMJrqT+5v8jMTArIQEc1d3o0RsIUpZACZeWLQFfsz2vfGT/UHfiaJ
         iot4Avlog0/q9KPNQofuZcadnxIp9onEV6iVKKWfEBkq3JFuoxp/JA/0t+RcRT8nfRU4
         192Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=xW5OsNIp7tITB0OllXRootUzeEQvCIU3GEvZ5zOz/fc=;
        b=SsHHcGOKIC+mzo48E+pvk8R3m3hKtfzNVoS0xX86nc5xGJbJcnZSMnFo7k1ypoBumA
         CvpIwurqvQoR2VDbpWPTHdQtsQwM0kdy+vydK7kUAPsChegY7rqmbJIs90sP0l6+4kyf
         goRvycNYKD2QFUXztlJQhr7N6z//P1tOo6jdXG/a50rZBWrpGQFoxWhi0lQAn92z1gV7
         lyDTOMJls/x8TfwvDhRlLQKx5WO56oqDu8WJWoKGU4za7WaGlr5uXo4kdDfY5T/bObvI
         sb/H83NB3VlNSYsKhyvH6SKdRwiVpUt6wgsdFRCa/LRKqVCElbclIvgYtS9YQyWVNnzJ
         UHXQ==
X-Gm-Message-State: AIVw111degIyoFPV5LhRc/rp9d0GM3an7Q328/SVSFAdAV40HAg4SLDD
        9vy9Da6S/4tP+A==
X-Received: by 10.80.241.8 with SMTP id w8mr8791381edl.245.1502038579847;
        Sun, 06 Aug 2017 09:56:19 -0700 (PDT)
Received: from snth (157-157-140-194.dsl.dynamic.simnet.is. [157.157.140.194])
        by smtp.gmail.com with ESMTPSA id y94sm3730538ede.18.2017.08.06.09.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Aug 2017 09:56:18 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1deOqe-0003Y5-1M; Sun, 06 Aug 2017 18:56:16 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <David.Turner@twosigma.com>,
        Ben Alex <ben.alex@acegi.com.au>,
        Kristoffer Sjogren <stoffe@gmail.com>
Subject: Re: reftable [v5]: new ref storage format
References: <CAJo=hJsOHF0KVmXvbSBiBgxq4zRdt7v7sj_GuKvcpbu8tkujFA@mail.gmail.com>
User-agent: Debian GNU/Linux 8.9 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CAJo=hJsOHF0KVmXvbSBiBgxq4zRdt7v7sj_GuKvcpbu8tkujFA@mail.gmail.com>
Date:   Sun, 06 Aug 2017 18:56:16 +0200
Message-ID: <874ltkzlcf.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Aug 06 2017, Shawn Pearce jotted:

> 5th iteration of the reftable storage format.

I haven't kept up with all of the discussion, sorry if these comments
repeat something that's already mentioned.

> ### Version 1
>
> A repository must set its `$GIT_DIR/config` to configure reftable:
>
>     [core]
>         repositoryformatversion = 1
>     [extensions]
>         reftable = true

David Turner's LMDB proposal specified a extensions.refStorage config
variable instead. I think this is a much better idea, cf. the mistake we
already made with grep.extendedRegexp & grep.patternType. I.e. to have
'extensions.refStorage = reftable' instead of 'extensions.reftable =
true'.

If we grow another storage backend this'll become messy, and it won't be
obvious to the user that the configuration is mutually exclusive (which
it surely will be), so we'll end up having to special case it similar to
the grep.[extendedRegexp,patternType] (i.e. either make one override the
other, or make specifying >1 an error, a hassle with the config API).

> Performance testing indicates reftable is faster for lookups (51%
> faster, 11.2 usec vs.  5.4 usec), although reftable produces a
> slightly larger file (+ ~3.2%, 28.3M vs 29.2M):
>
> format    |  size  | seek cold | seek hot  |
> ---------:|-------:|----------:|----------:|
> mh-alt    | 28.3 M | 23.4 usec | 11.2 usec |
> reftable  | 29.2 M | 19.9 usec |  5.4 usec |
>
> [mh-alt]: https://public-inbox.org/git/CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com/

Might be worth noting "based on WIP Java implementation". I started
searching for patches for this new format & found via
<CAJo=hJtrdCOF-RxzXfyLx7R-1f2-7pZVO_UOg28J=wUDNdf3yw@mail.gmail.com>
that it's JGit only.

Also if one wanted to run these tests via JGit using your WIP code where
does that code live / how to test it?

> ### LMDB
>
> David Turner proposed [using LMDB][dt-lmdb], as LMDB is lightweight
> (64k of runtime code) and GPL-compatible license.
>
> A downside of LMDB is its reliance on a single C implementation.  This
> makes embedding inside JGit (a popular reimplemenation of Git)
> difficult, and hoisting onto virtual storage (for JGit DFS) virtually
> impossible.

This rationale as stated reads a bit too much like https://xkcd.com/927/

I.e. surely the actual problem isn't that there's a single C
implementation of LMDB, since that's one more than the C implementation
that exists of this new format already.

Also isn't this info out of date now that this exists:
https://github.com/lmdbjava/lmdbjava ? That project has been implemented
after David's initial LMDB patches on-list, but I don't know if it
implements the subset of the LMDB format needed for his proposed ref
storage.

But rather something like:

    A downside of LMDB is that it would be too complex to implement the
    subset of its database format needed for this reference storage in
    Java in the nascent lmdbjava project and to keep the two compatible
    going forward while juggling support for two upstream projects whose
    aims may conflict with ours.

Or:

    A downside of LMDB is <above rationale> + even if we did that
    benchmarks <do we have those?> show that it wouldn't be worth it to
    use the LMDB format since it's slower/bigger/whatever.

> A common format that can be supported by all major Git implementations
> (git-core, JGit, libgit2) is strongly preferred.
>
> [dt-lmdb]: https://public-inbox.org/git/1455772670-21142-26-git-send-email-dturner@twopensource.com/
>
> ## Future
>
> ### Longer hashes
>
> Version will bump (e.g.  2) to indicate `value` uses a different
> object id length other than 20.  The length could be stored in an
> expanded file header, or hardcoded as part of the version.
