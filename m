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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5828820248
	for <e@80x24.org>; Thu, 14 Mar 2019 15:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfCNPkb (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 11:40:31 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39537 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfCNPkb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 11:40:31 -0400
Received: by mail-ed1-f65.google.com with SMTP id p27so5021234edc.6
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 08:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=PUWvqBroaXBiE0z5Q7bTVlkwyAk5k7j5tIxnUF2uFX8=;
        b=aAYJkYPdZDrux5KrCejv7pT0m3UkMjNoYup4uDtWQ8SB1+vrcMIejHdNSRIt9fxyPn
         NRMNoCf++Q+ketH6jdr5uqE/x3CogT1uqrNiF72HgIMbjXIxkTF4OvzMWSmdw9G+yA5Y
         hPwrz2K+cu1PQmzm6CbK111HkvPmU69GkROpWce3Ckwdeow1Qa41LauzedCG6LgFe6El
         E0Tyb5VYpzW2lRrpeW/A38g8oQG5zKyStMLD758xF1mnBYbX3sHNjWXxhmO6t0uAstLB
         OaRp4/NikeJN6thxJ5MidR8uFifok/oD8gxQeLfy00XK5WFRJWPZYauh7TNu75uqcrj3
         FK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=PUWvqBroaXBiE0z5Q7bTVlkwyAk5k7j5tIxnUF2uFX8=;
        b=q9diHlVk0/+NEo1dsNF8qSWglYbL0IPU05gjw613pTB4QZYXYq1XGfA3C2hgkI9mUq
         SiIGEWHNR7bztIvQR7fqbaTwdbLsx2oJT6A7mi4K1h2PQB9cij2lo8g8N9a0dyU0EVro
         Jxl+ys1PNAteWHUwVtNbPpZPT009xhhHqh/3+RdrL1DBKfa94h70yMZQLrBgbj/qJQm2
         TiMK5KllHVv3UA8Q1zCzYIFfp6oIfIM/YblvUMPF7Myeo2taEG8J9aHZvTsmzfuDQaro
         DwjJPvOZyk/Eavxay2Lfh638TDyI3BIQ1OjWBr6aiiLrkLgtNTYfR2CGZWfSB3jut4VF
         p/aQ==
X-Gm-Message-State: APjAAAXrliPWELZYbG/PVZRWGxuNhvwWCSHa6uIecZhr/zRnIpiPjU0p
        Wc6PcWJivjTENmyK8SWFl5g=
X-Google-Smtp-Source: APXvYqwg9SFiRXe3lsZbUJuZU+1xJ2j6cDn8duJa8tUYVVxsL+CjDt9weM9w4ByzIN6fJQuqRUD/bQ==
X-Received: by 2002:a17:906:485:: with SMTP id f5mr33531961eja.85.1552578028958;
        Thu, 14 Mar 2019 08:40:28 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id x3sm1559501ede.25.2019.03.14.08.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 08:40:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>
Subject: Re: regression in new built-in stash + fsmonitor (was Re: [PATCH v13 11/27] stash: convert apply to builtin)
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet> <20190225231631.30507-1-t.gummerer@gmail.com> <20190225231631.30507-12-t.gummerer@gmail.com> <87ftrpbnkg.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1903141600020.41@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1903141600020.41@tvgsbejvaqbjf.bet>
Date:   Thu, 14 Mar 2019 16:40:27 +0100
Message-ID: <87d0mtbh1w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 14 2019, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Thu, 14 Mar 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Tue, Feb 26 2019, Thomas Gummerer wrote:
>>
>> > From: Joel Teichroeb <joel@teichroeb.net>
>> >
>> > Add a builtin helper for performing stash commands. Converting
>> > all at once proved hard to review, so starting with just apply
>> > lets conversion get started without the other commands being
>> > finished.
>> >
>> > The helper is being implemented as a drop in replacement for
>> > stash so that when it is complete it can simply be renamed and
>> > the shell script deleted.
>> >
>> > Delete the contents of the apply_stash shell function and replace
>> > it with a call to stash--helper apply until pop is also
>> > converted.
>>
>> This
>>
>>     GIT_TEST_FSMONITOR=3D$PWD/t7519/fsmonitor-all ./t3420-rebase-autosta=
sh.sh
>>
>> Now fails, which bisects to 8a0fc8d19d ("stash: convert apply to
>> builtin", 2019-02-25).
>>
>> Tested on both a CentOS 6 & modern Debian testing machine:
>>
>>     + git rebase -i --autostash HEAD^
>>     Created autostash: 5cd734b
>>     HEAD is now at 0c4d2f1 third commit
>>     hint: Waiting for your editor to close the file...
>>     error: There was a problem with the editor '"$FAKE_EDITOR"'.
>>     Applied autostash.
>>     + exit_code=3D1
>>     + test 1 -eq 0
>>     + test_match_signal 13 1
>>     + test 1 =3D 141
>>     + test 1 =3D 269
>>     + return 1
>>     + test 1 -gt 129
>>     + test 1 -eq 127
>>     + test 1 -eq 126
>>     + return 0
>>     + rm -f abort-editor.sh
>>     + echo conflicting-content
>>     + test_cmp expected file0
>>     + diff -u expected file0
>>     --- expected    2019-03-14 13:19:08.212215263 +0000
>>     +++ file0       2019-03-14 13:19:08.196215250 +0000
>>     @@ -1 +1 @@
>>     -conflicting-content
>>     +uncommitted-content
>>     error: last command exited with $?=3D1
>>     not ok 36 - autostash is saved on editor failure with conflict
>>
>> Are you able to reproduce this? And if so I suggest running the test
>> suite with some of the other GIT_TEST_* modes documented in
>> t/README. Maybe it'll turn up something else...
>
> Yep, totally can reproduce it :-(

In the meantime I did a build with "next" (so stash-in-C) using the
standard test mode and these:

    (cd t && GIT_TEST_GETTEXT_POISON=3Dtrue /usr/bin/prove $BKNG_GIT_HARNES=
S_OPTIONS t[0-9]*.sh)
    (cd t && GIT_TEST_FSMONITOR=3D$PWD/t7519/fsmonitor-all GIT_SKIP_TESTS=
=3D"t3404.8 t3420.36" /usr/bin/prove $BKNG_GIT_HARNESS_OPTIONS t[0-9]*.sh)
    (cd t && GIT_TEST_SPLIT_INDEX=3Dtrue /usr/bin/prove $BKNG_GIT_HARNESS_O=
PTIONS t[0-9]*.sh)
    (cd t && GIT_TEST_FULL_IN_PACK_ARRAY=3Dtrue GIT_TEST_OE_SIZE=3D10 /usr/=
bin/prove $BKNG_GIT_HARNESS_OPTIONS t[0-9]*.sh)
    (cd t && GIT_TEST_COMMIT_GRAPH=3Dtrue /usr/bin/prove $BKNG_GIT_HARNESS_=
OPTIONS t[0-9]*.sh)
    (cd t && GIT_TEST_MULTI_PACK_INDEX=3Dtrue /usr/bin/prove $BKNG_GIT_HARN=
ESS_OPTIONS t[0-9]*.sh)
    (cd t && GIT_TEST_STASH_USE_BUILTIN=3Dfalse /usr/bin/prove $BKNG_GIT_HA=
RNESS_OPTIONS t[0-9]*.sh)
    (cd t && GIT_TEST_CHECK_COLLISIONS=3Dfalse /usr/bin/prove $BKNG_GIT_HAR=
NESS_OPTIONS t[0-9]*.sh)

Only this specific test failed.
