Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 040681F453
	for <e@80x24.org>; Wed,  6 Feb 2019 21:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfBFVwT (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 16:52:19 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37225 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfBFVwS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 16:52:18 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so7283557edb.4
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 13:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=BWxHpSopynBd4cKvdRmaQ1p1FA7Xkml+hko0yvJSU9A=;
        b=H4VteTuxLyiLv8zmo+qBeW8pszmaViNAhFVGTCRHSX6OXJPoLLbZ/fElfW7IiPb/PD
         Gw0c6s4cUe8YTemhj4Xraq6SU2ROFxH2Gxzsb3CMqdxtdPCpZ3n5rbaYue8xp8FOiIck
         AC5KB29UdluaU+/xAEjfL+k//+nCWLzNX4F0mdpZf6AsdWktszVwKQyKzpuFxRLVwAzo
         nxVgvWsr4AUxKICXFAN6oO8A8VtrkTYXvIDE9R/wzuJvXamwhNCChslQ9L+baMtnceDF
         4YJ7+ou2NTY0pYj2KTRqqL11kTkiyzpGaPXniDtmm4O5pkzPJp6HEyhp7nPRjpM8I7Nq
         ExIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=BWxHpSopynBd4cKvdRmaQ1p1FA7Xkml+hko0yvJSU9A=;
        b=Y4eM0jW8H9BS4mohRrvRp7I6fHyjFWYRxM4W2LIajHy6YtkfNnD0+5bci3zFOsH6ry
         6MP4k6APbmFJQ+SCQSIHb5/YKKUosq5LCsatRBb7qjgdqOyLvgP8eyvBkVmWiDYXTGuB
         Ndio6e9AtSJymcsnvO6Vzt+ZtIBQrHewcBYXdyvabXyXlUPOJuEy6arIVQ1UxT128zKc
         QVhExfPPta924NR8FF9FNPVf7/FyvaQCW8HSSC39ofbTvXOO+S/4GnZBCkWn4TFkXR2q
         CQBSL5Vgs/kAabzsrRDvPkPlgJZ/G/0Zqz0vbjLbKN/eQLqXsxfsM0QS8yKr1N3gl8gp
         gl+w==
X-Gm-Message-State: AHQUAuZ2YjIkX4V5mEUEocO2bnX/MTPXj57DwtX7E+106mdlRYMTQ8F4
        KP7/YzOBzn1iRYzs8QEhQEI=
X-Google-Smtp-Source: AHgI3IYDc9adjBSHYtdPrZa1R0Nxct+9U4zdXsbuc19Rhzx2j1fw9m6BuS2h7uJsTk/OMcsRHB9Mmg==
X-Received: by 2002:a17:906:45c1:: with SMTP id z1mr9084374ejq.79.1549489936984;
        Wed, 06 Feb 2019 13:52:16 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id gf12sm3755895ejb.26.2019.02.06.13.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 13:52:16 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        steadmon@google.com
Subject: Re: [PATCH 0/8] Resend of GIT_TEST_PROTOCOL_VERSION patches
References: <cover.1549411880.git.jonathantanmy@google.com> <20190206213458.GC12737@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190206213458.GC12737@sigill.intra.peff.net>
Date:   Wed, 06 Feb 2019 22:52:15 +0100
Message-ID: <87ef8klh4g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 06 2019, Jeff King wrote:

> On Tue, Feb 05, 2019 at 04:21:14PM -0800, Jonathan Tan wrote:
>
>> This is on the latest master (8feddda32c ("Fifth batch for 2.21",
>> 2019-02-05)) + js/protocol-advertise-multi.
>>
>> This is a resend of [1], which was built on the result of merging many
>> branches. Now that most of the branches have been merged to master, I
>> have rebased it on master. The only branch that I needed to merge was
>> js/protocol-advertise-multi.
>
> Thanks for working on this. With the exception of the final patch, this
> all seems pretty sane to me from a quick look.
>
> There is one thing that your test patches made me wonder. When we have
> to make an exception to a test (i.e., that doesn't work under v2), you
> do it by unsetting GIT_TEST_PROTOCOL_VERSION in the environment. That
> means we'll actually run the test, but not with the version that the
> caller specified.
>
> I wonder if it would be more obvious what's going on if we instead had a
> prereq like:
>
>   test_expect_success !PROTO_V2 'ls-remote --symref' '
>      ...
>   '
>
> and just skipped those tests entirely (and in a way that appears in the
> TAP output).
>
> I think it would also future-proof us a bit for v2 becoming the default
> (i.e., when GIT_TEST_PROTOCOL_VERSION being blank does mean "use v2").
>
> I dunno. It probably doesn't matter all that much, so it may not be
> worth going back and changing at this point. Just a thought.

So far we've had the convention that these GIT_TEST_* variables,
e.g. the one for the commit graph, work the same way. Thus we guarantee
that we get (in theory) 100% coverage even when running the tests in
this special mode. I think it's better to keep it as-is.
