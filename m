Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77AEF20248
	for <e@80x24.org>; Thu, 14 Mar 2019 13:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfCNNTs (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 09:19:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39261 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfCNNTr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 09:19:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id p27so4589179edc.6
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=cuNA+q4aeZgKMj0Gd84+QfYwlpjDX//eTUNfNUE9DIg=;
        b=rbBEGEdC2Eqqy1qSsi1JdD8Y+ZUX7N5wXy3hC0iuexvGJHZ0Ge4ht+eXHovV4O1aIk
         ILwW3sKjpFPpe2CLcYJY4SqV1ZLLKt/bm9rCM5+5+/mOL138QndwRZv7s/qQhNZEB3H0
         4QATcWOyi+VfFE2lLVSNmiVQPq8mK9pK4o0SlRPzkdkuPR5wqrlkmht2nhKX7l+O/jbB
         BNk4Rjo5Gbu4K1XixlG8e0zGqfVGBEpHjhf8MByNgpvRvObTSZEv/VlxYubyGtVrWxCp
         O5KPWleRlzz8EqrZJPSQgzcLOJsrBs8RNf+CnZ69G/hjJC/3acevH55nvA35eC7xicHH
         Cgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=cuNA+q4aeZgKMj0Gd84+QfYwlpjDX//eTUNfNUE9DIg=;
        b=kHDZaIHEa8t9e1wZGlHx7PelyhRpF+DqnWRzfwmeb8SCKV0wlfkFl72OL06AOvWDlM
         l/8eFQ4DzUNTC0MU/e/4xO92m4lEWNVE5vgeFbav3KyLidgD8Pl2wedXPYsgfGolgZyj
         kFANbnY+frzOLbVd9t5e7aEcYd934CzCerA2y2msc0CkLMnhwDHt0QxHu6fasmOpEc4x
         JOSbVXJ2sgN1hj/mo1Ua+qRlkVseOAaXtrkGRaIDk6kJUXv1p2HI0/S7u3hcekbaZ/yl
         7KPlJA83s658I6L3O3HtfILwyJHCc75/aqJph2rW/ciPCluucj912Jrbz/6jedm6+3nn
         eMKw==
X-Gm-Message-State: APjAAAXiS+R/upLAEiEsFPFFzmUvln+O1q+6lhRhM6eRxcb8cr6QAz2u
        jonv7YiYc5ZAYqY2xkDSGpBfMAalzok=
X-Google-Smtp-Source: APXvYqy3BONDzG3lgdhKBqhytfsDBaLQ9ujPAuuFf8RwRBM4irFi7xwM8gQLRIQKN2ls2wREgYZDmA==
X-Received: by 2002:a17:906:194e:: with SMTP id b14mr1404226eje.6.1552569585665;
        Thu, 14 Mar 2019 06:19:45 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id d11sm1089988eja.23.2019.03.14.06.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 06:19:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>
Subject: regression in new built-in stash + fsmonitor (was Re: [PATCH v13 11/27] stash: convert apply to builtin)
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet> <20190225231631.30507-1-t.gummerer@gmail.com> <20190225231631.30507-12-t.gummerer@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190225231631.30507-12-t.gummerer@gmail.com>
Date:   Thu, 14 Mar 2019 14:19:43 +0100
Message-ID: <87ftrpbnkg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 26 2019, Thomas Gummerer wrote:

> From: Joel Teichroeb <joel@teichroeb.net>
>
> Add a builtin helper for performing stash commands. Converting
> all at once proved hard to review, so starting with just apply
> lets conversion get started without the other commands being
> finished.
>
> The helper is being implemented as a drop in replacement for
> stash so that when it is complete it can simply be renamed and
> the shell script deleted.
>
> Delete the contents of the apply_stash shell function and replace
> it with a call to stash--helper apply until pop is also
> converted.

This

    GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all ./t3420-rebase-autostash.sh

Now fails, which bisects to 8a0fc8d19d ("stash: convert apply to
builtin", 2019-02-25).

Tested on both a CentOS 6 & modern Debian testing machine:

    + git rebase -i --autostash HEAD^
    Created autostash: 5cd734b
    HEAD is now at 0c4d2f1 third commit
    hint: Waiting for your editor to close the file...
    error: There was a problem with the editor '"$FAKE_EDITOR"'.
    Applied autostash.
    + exit_code=1
    + test 1 -eq 0
    + test_match_signal 13 1
    + test 1 = 141
    + test 1 = 269
    + return 1
    + test 1 -gt 129
    + test 1 -eq 127
    + test 1 -eq 126
    + return 0
    + rm -f abort-editor.sh
    + echo conflicting-content
    + test_cmp expected file0
    + diff -u expected file0
    --- expected    2019-03-14 13:19:08.212215263 +0000
    +++ file0       2019-03-14 13:19:08.196215250 +0000
    @@ -1 +1 @@
    -conflicting-content
    +uncommitted-content
    error: last command exited with $?=1
    not ok 36 - autostash is saved on editor failure with conflict

Are you able to reproduce this? And if so I suggest running the test
suite with some of the other GIT_TEST_* modes documented in
t/README. Maybe it'll turn up something else...
