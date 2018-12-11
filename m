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
	by dcvr.yhbt.net (Postfix) with ESMTP id D65AF20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 11:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeLKLpU (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 06:45:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50784 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeLKLpU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 06:45:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so1895100wmd.0
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 03:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=NK0kIYhwnpKkBwLcIooKNJHgzMVkJNTriLaQCjaAASc=;
        b=khsMb3FNlw8CvTsru0CLbZblV5/Zj8wMvuzFvg9CYILiGC7vCidDqnlusya9j4rpcl
         uo/6azr9Ia+iAhqQRIx0rsNDb8mDEcdAQhDk4kbQw8GDdOf5Y9QKewmX5gbPLcNvLGnW
         BYyXVXr2uQDhZ37unVhGb+nUJqXKlY+ucv68v4txkPo95GryGIsjXS6Hebw9Kfl3tHwW
         WjMbPAf+x/Ng1ix6FVX2mxsirmR49xUcEpDnbQ95b5l84Cmbvle/mts8MXa44WRq7h80
         ef4esja2bonrUlKZhVMxAD1PuwzeGqMbHl0A0j+UxA/1WMTVNRU8/zZOdDA1pJd1CYb1
         Q+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=NK0kIYhwnpKkBwLcIooKNJHgzMVkJNTriLaQCjaAASc=;
        b=n2XMACyuGxCCbfk/CL7B1piR10Jv+jH1p85JLVesXxE1qEmdGMdwpIhEiH48fhgrlP
         m/zMn+1/Hb2UJ3fQdz6cFLkS4p5bkB/87S4R8L69/t1S6k9CqBQqpaKmEMYeoBdPQOG4
         djrkL9DfVQ27C3B7xADB7eZMLPDKNXfCBSt6hTGcMYnWVXGybVNohWYI1xUgx8r1jNaA
         KO15BdYKhnmqfLJZ5aUgSdh4r7HSye+ynLg5QmSvIbHrOPk0ATJzzAP3pYpdzu1f7kXJ
         eyOrwD1Kk9CGRrNH3FMx0uedWR7lBETI/05xXAe1ysKG4bOv5oJhlQzJgNYgfQQDbm48
         25ig==
X-Gm-Message-State: AA+aEWa3DJBPGjXmaGlRnj4Lmb/HyObi8g1UeImq4J3Y5Haz2Cq5/A3T
        a5THW1iCjDyWOkpsCFhmQkYMynmR
X-Google-Smtp-Source: AFSGD/X37yIEUIQ1QZKVO5gl3E7O2PwK9UL3F/LyjcKmG1DEMuA/3+gbtsRjfXbTEMkF2P/x3l2sQA==
X-Received: by 2002:a1c:ad43:: with SMTP id w64mr1927106wme.32.1544528717685;
        Tue, 11 Dec 2018 03:45:17 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id h12sm5123278wma.48.2018.12.11.03.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 03:45:17 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/3] protocol v2 and hidden refs
References: <20181211104236.GA6899@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181211104236.GA6899@sigill.intra.peff.net>
Date:   Tue, 11 Dec 2018 12:45:16 +0100
Message-ID: <875zw0nv77.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 11 2018, Jeff King wrote:

> When using the v2 protocol, hidden-ref config is not respected at all:
>
>   $ git config transfer.hiderefs refs/tags/
>   $ git -c protocol.version=0 ls-remote . | grep -c refs/tags
>   0
>   $ git -c protocol.version=2 ls-remote . | grep -c refs/tags
>   1424
>
> The fix in patch 3 is pretty straightforward, but note:
>
>   - I'm a little worried this may happen again with future features. The
>     root cause is that "ls-refs" follows a different code path than the
>     ref advertisement for "upload-pack". So if we add any new config,
>     it needs to go both places (non ref-advertisement config is OK, as
>     the v2 "fetch" command is a lot closer to a v0 upload-pack).
>
>     I think this is just an issue for any future features. I looked for
>     other existing features which might be missing in v2, but couldn't
>     find any.
>
>     I don't know if there's a good solution. I tried running the whole
>     test suite with v2 as the default. It does find this bug, but it has
>     a bunch of other problems (notably fetch-pack won't run as v2, but
>     some other tests I think also depend on v0's reachability rules,
>     which v2 is documented not to enforce).

I think a global test mode for it would be a very good idea.

>   - The "serve" command is funky, because it has no concept of whether
>     the "ls-refs" is for fetching or pushing. Is git-serve even a thing
>     that we want to support going forward?  I know part of the original
>     v2 conception was that one would be able to just connect to
>     "git-serve" and do a number of operations. But in practice the v2
>     probing requires saying "I'd like to git-upload-pack, and v2 if you
>     please". So no client ever calls git-serve.
>
>     Is this something we plan to eventually move to? Or can it be
>     considered a funny vestige of the development? In the latter case, I
>     think we should consider removing it.
>
>     I've worked around it here with patch 2, but note that "git serve"
>     would not ever respect uploadpack.hiderefs nor receive.hiderefs
>     (since it has no idea which operation it's doing).
>
> The patches are:
>
>   [1/3]: serve: pass "config context" through to individual commands
>   [2/3]: parse_hide_refs_config: handle NULL section
>   [3/3]: upload-pack: support hidden refs with protocol v2

Does this issue rise to the level of needing a security point-release
(which I'm discussing here as the details are already public). The
transfer.hideRefs docs have said:

    Even if you hide refs, a client may still be able to steal the
    target objects via the techniques described in the "SECURITY"
    section of the gitnamespaces(7) man page; it’s best to keep private
    data in a separate repository.

So we never promised to hide the objects, but definitely promised to
hide the ref names. I don't know if anyone uses this in practice for
secret ref names, but if they do they have a data leak if they enable
protocol v2.

More importantly, the docs for receive.hideRefs say. "An attempt to
update or delete a hidden ref by git push is rejected.". It seems this
bit was enforced, i.e. this passes before and after your 3/3, but I have
not dug enough to be 100% satisfied with that.

    diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
    index ca69636fd5..20059c3308 100755
    --- a/t/t5512-ls-remote.sh
    +++ b/t/t5512-ls-remote.sh
    @@ -210,6 +210,13 @@ test_expect_success 'protocol v2 supports hiderefs' '
     	! grep refs/tags actual
     '

    +test_expect_success 'protocol v2 respects hiderefs when pushing' '
    +	git init --bare server.git &&
    +	git -C server.git config transfer.hideRefs refs/tags &&
    +	test_must_fail git -c protocol.version=0 push "file://$PWD/server.git" mark &&
    +	test_must_fail git -c protocol.version=2 push "file://$PWD/server.git" mark
    +'
    +
     test_expect_success 'ls-remote --symref' '
     	git fetch origin &&
     	cat >expect <<-EOF &&

If there's some bug where you can bypass this push protection that would
be much worse. E.g. GitLab uses "keep-around" refs to track its own
internal state, and it would be bad if users could manipulate it.

>  builtin/upload-pack.c |  1 +
>  ls-refs.c             | 16 +++++++++++++++-
>  ls-refs.h             |  3 ++-
>  refs.c                |  3 ++-
>  serve.c               |  9 +++++----
>  serve.h               |  7 +++++++
>  t/t5512-ls-remote.sh  |  6 ++++++
>  upload-pack.c         |  4 ++--
>  upload-pack.h         |  4 ++--
>  9 files changed, 42 insertions(+), 11 deletions(-)
>
> -Peff
