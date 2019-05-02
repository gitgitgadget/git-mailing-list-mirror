Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C70AB1F453
	for <e@80x24.org>; Thu,  2 May 2019 20:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfEBUU6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 16:20:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46198 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBUU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 16:20:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id f37so3298343edb.13
        for <git@vger.kernel.org>; Thu, 02 May 2019 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XzTGLwzHvW2Pjm2r7hDzJ8lg+iEgNjMb7IsVCq9vn48=;
        b=mscobI0RNBDdiKs4rzO0Tl7Qzetjc98EzvLnxYNQuiGb2ih3cU49tmmF5f4FQMAh/H
         LybCIj5cvUbpGXGNOnXE+Kg8GI7FmObn5RcBoUU394OJ+GBiEzq2lO1o3a62/FuVM9l3
         RypoqFlInHJWgEdf9EaG2GWBeKR8/s+bvrWZJ8wyimPLkqXGKHd7udzCe/PT004YUuQP
         hPUaQ831UvtJAzU3Y9UtOuwGiyZC2mCRqZFxJsPjghl9hOFkegxPgwysv9Z2haOsdJWL
         aqdTV5CGRay5k4yWDD7qU9Gjeo9+uFcWPa03KlC8uNKXn9tuWsV29rDEhBvEQ6QCbC2+
         hWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=XzTGLwzHvW2Pjm2r7hDzJ8lg+iEgNjMb7IsVCq9vn48=;
        b=ikoHOU0F7/qdFOESQbr3MRSgg6v0h/Rff31NccIiXpQbNrN5wCYCRN6bx3xd1NRbwB
         9kV+wfPtk5WXH1fd6WCFHSG6hEhHw2E1CopOJd8EK2a2fzPXIjOzMK6ZfpqdPePuKYx4
         CnB4jzfgscjJA6pUFZc1JwHcf8mSQxsHhKqKD70QxB+9Mc1/p4Dn7d8d+26lrOJNqPFW
         HjyAhNZ/V9EbVkU+KXn0AHCkOzLGIUS1aMxU3i8/byPHVU3S9NGFywPDDCz39O9kQFTM
         Mxe1eYvhBl0iVJBS/9oFl/gSQ35eHGJqQSTnrjZyZzWuxK9hAV+zHM7LVZpmoyuecRuO
         2R8Q==
X-Gm-Message-State: APjAAAVDtXKRqfI52K02g3W31LWoF1nt6LdRo3gd7owIedI2PxkeMAP2
        8WdtGdivywA288TnzWKb104=
X-Google-Smtp-Source: APXvYqwrQ+XOGVSYx+fpC+6gVJhQCbTg86Md51DGdm4fYZB9NLEyjClBl6gms+It6/M/7a+eHL5Cqg==
X-Received: by 2002:a50:aeaf:: with SMTP id e44mr3944026edd.239.1556828455404;
        Thu, 02 May 2019 13:20:55 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id f1sm17729edm.59.2019.05.02.13.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 13:20:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 2/2] archive: avoid spawning `gzip`
References: <pull.145.git.gitgitgadget@gmail.com>
        <44d5371ae6808ec40e8f52c3dc258a85c878b27e.1555110278.git.gitgitgadget@gmail.com>
        <20190413015102.GC2040@sigill.intra.peff.net>
        <20190413221646.GL12419@genre.crustytoothpaste.net>
        <nycvar.QRO.7.76.6.1904261051310.45@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1904261051310.45@tvgsbejvaqbjf.bet>
Date:   Thu, 02 May 2019 22:20:53 +0200
Message-ID: <87ftpwip5m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 26 2019, Johannes Schindelin wrote:

> Hi brian,
>
> On Sat, 13 Apr 2019, brian m. carlson wrote:
>
>> On Fri, Apr 12, 2019 at 09:51:02PM -0400, Jeff King wrote:
>> > I wondered how you were going to kick this in, since users can define
>> > arbitrary filters. I think it's kind of neat to automagically convert
>> > "gzip -cn" (which also happens to be the default). But I think we shou=
ld
>> > mention that in the Documentation, in case somebody tries to use a
>> > custom version of gzip and wonders why it isn't kicking in.
>> >
>> > Likewise, it might make sense in the tests to put a poison gzip in the
>> > $PATH so that we can be sure we're using our internal code, and not ju=
st
>> > calling out to gzip (on platforms that have it, of course).
>> >
>> > The alternative is that we could use a special token like ":zlib" or
>> > something to indicate that the internal implementation should be used
>> > (and then tweak the baked-in default, too). That might be less
>> > surprising for users, but most people would still get the benefit since
>> > they'd be using the default config.
>>
>> I agree that a special value (or NULL, if that's possible) would be
>> nicer here. That way, if someone does specify a custom gzip, we honor
>> it, and it serves to document the code better. For example, if someone
>> symlinked pigz to gzip and used "gzip -cn", then they might not get the
>> parallelization benefits they expected.
>
> I went with `:zlib`. The `NULL` value would not really work, as there is
> no way to specify that via `archive.tgz.command`.
>
> About the symlinked thing: I do not really want to care to support such
> hacks.

It's the standard way by which a lot of systems do this, e.g. on my
Debian box:

    $ find /{,s}bin /usr/{,s}bin -type l -exec file {} \;|grep /etc/alterna=
tives|wc -l
    108

To write this E-Mail I'm invoking one such symlink :)

> If you want a different compressor than the default (which can
> change), you should specify it specifically.

You might want to do so system-wide, or for each program at a time.

I don't care about this for gzip myself, just pointing out it *is* a
thing people use.

>> I'm fine overall with the idea of bringing the compression into the
>> binary using zlib, provided that we preserve the "-n" behavior
>> (producing reproducible archives).
>
> Thanks for voicing this concern. I had a look at zlib's source code, and
> it looks like it requires an extra function call (that we don't call) to
> make the resulting file non-reproducible. In other words, it has the
> opposite default behavior from `gzip`.

Just commenting on the overall thread: I like Ren=C3=A9's "new built-in"
patch best.

You mentioned "new command that we have to support for eternity". I
think calling it "git gzip" is a bad idea. We'd make it "git
archive--gzip" or "git archive--helper", and we could hide building it
behind some compat flag.

Then we'd carry no if/else internal/external code, and the portability
issue that started this would be addressed, no?

As a bonus we could also drop the "GZIP" prereq from the test suite
entirely and just put that "gzip" in $PATH for the purposes of the
tests.

I spied on your yet-to-be-submitted patches and you could drop GZIP from
the "git archive" tests, but we'd still need it in
t/t5562-http-backend-content-length.sh, but not if we had a "gzip"
compat helper.

There's also a long-standing bug/misfeature in git-archive that I wonder
about: When you combine --format with --remote you can only generate
e.g. tar.gz if the remote is OK with it, if it says no you can't even if
it supports "tar" and you could do the "gz" part locally. Would such a
patch be harder with :zlib than if we always just spewed out to external
"gzip" after satisfying some criteria?
