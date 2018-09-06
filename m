Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DB7F1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 12:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbeIFRL3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 13:11:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35094 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeIFRL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 13:11:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so11120287wmc.0
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 05:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=j3L25C0V10SmBAJp/JJLW2hdNFq8c3HQU6eMZxUZVfk=;
        b=HhJabNPk/y3ivcjksXTFbaDzroIgFRF/UlZXI2OIFae0xRnu0YoRWSE02ITBdxmae6
         uE/DynbmF23f5B7yE9qgHxTZdf9KyE/Tf1utKUM1sQdpEqMozFOpYC/orxC3jqKLxiQx
         JhGQU0tRQ8R/cB6WG4YiOxQXviCe02N2KsKraqYYhYF9xSHk0nW4ZuK3p04xAg/fwHzv
         HOuyGziYO4ijFWr72/ueufLSC4QzG8mHBZP6W7K3Bd7YjBraWxe76QN7SseyyckX+n2v
         gZo6u8+99kX593qFqIy0e5YSUG/JVdjC8B21ZTgnuJzDQeDFxpak0k1F+MHDsynmzYqy
         vZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=j3L25C0V10SmBAJp/JJLW2hdNFq8c3HQU6eMZxUZVfk=;
        b=FQy80eY3tu7OOTdxV5gooLKUyhLTgmhiBq9xFjBDUYdMt2l0GfgARWPTmf+18Oinhh
         x8hUQN3hHqyZ2UR7ILqQ5rMnLZnUaR/xEdNT1QP1p7Xg0rCFo1iLOXmTtUCpboWwlQo+
         ukA0rvccYyhHsQeJtzozov6aZWX4wKtmBgl1lCVmQEQbh7bgUQlSyw1qfsRuqkhJVjSW
         kX6yFPaRrKpcoeUeqLUYzQiWgJMGFUwmf07C/I/Q4RSnALzrdKb37XlgivnreuadtNZz
         Cr8yopzp90uRBJCoPPZbRIM2ilawMHEnqEABuYvN8Htn1X1wwonl9M9/OjqFXiIIl+kM
         I6HA==
X-Gm-Message-State: APzg51AuhjehKUzL3DGikSh7B6iM+bx8GBtmd1dHGWi9K/4cRmUi3YiN
        S7sOfst6/FgcNWZHqDAnXOqmJ3yo
X-Google-Smtp-Source: ANB0VdYlLT4dJkS0+9LazTuSmW3FsUztRfTZ0X0Hv78ljerF//31EsO3FzT8cQegJNPq9pXWTX+MkQ==
X-Received: by 2002:a1c:48d:: with SMTP id 135-v6mr2162149wme.128.1536237370786;
        Thu, 06 Sep 2018 05:36:10 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id a6-v6sm5078137wmf.22.2018.09.06.05.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 05:36:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: t3404.6 breaks on master under GIT_FSMONITOR_TEST
References: <87k1vwn9qe.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <87k1vwn9qe.fsf@evledraar.gmail.com>
Date:   Thu, 06 Sep 2018 14:36:09 +0200
Message-ID: <87sh2mrefa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 01 2018, Ævar Arnfjörð Bjarmason wrote:

> The GIT_FSMONITOR_TEST variable allows you to roundtrip the fsmonitor
> codpath in the whole test suite. On both Debian & CentOS this breaks for
> me:
>
>     (cd t && GIT_FSMONITOR_TEST=$PWD/t7519/fsmonitor-all ./t3404-rebase-interactive.sh -i)
>
> Whereas this works:
>
>     (cd t && GIT_FSMONITOR_TEST=$PWD/t7519/fsmonitor-all GIT_SKIP_TESTS=t3404.6 ./t3404-rebase-interactive.sh -i)
>
> The entirety of the rest of the test suite still passes with
> GIT_FSMONITOR_TEST.
>
> This has been failing ever since GIT_FSMONITOR_TEST was introduced in
> 883e248b8a ("fsmonitor: teach git to optionally utilize a file system
> monitor to speed up detecting new or changed files.", 2017-09-22). Under
> -v -x -i:
>
>     + echo test_must_fail: command succeeded: env FAKE_LINES=exec_echo_foo_>file1 1 git rebase -i HEAD^
>     test_must_fail: command succeeded: env FAKE_LINES=exec_echo_foo_>file1 1 git rebase -i HEAD^
>     + return 1
>     error: last command exited with $?=1
>     not ok 6 - rebase -i with the exec command checks tree cleanness
>     #
>     #               git checkout master &&
>     #               set_fake_editor &&
>     #               test_must_fail env FAKE_LINES="exec_echo_foo_>file1 1" git rebase -i HEAD^ &&
>
> Maybe once this is fixed running the test suite under GIT_FSMONITOR_TEST
> would be a useful Travis target, but I don't know the current status of
> adding new options to Travis.

*Poke* at this again. Ben, or anyone else with knowledge of fsmonitor:
Can you reproduce this?

This failure along with the one I noted in
https://public-inbox.org/git/87tvn2remn.fsf@evledraar.gmail.com/ is
failing the tests on Linux when run with GIT_FSMONITOR_TEST.

I'm looking at this again because SZEDER's patches to the split index
reminded me again that we have these long-standing failures in rare test
modes (see
https://public-inbox.org/git/87va7ireuu.fsf@evledraar.gmail.com/ for the
split index discussion).
