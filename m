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
	by dcvr.yhbt.net (Postfix) with ESMTP id A28DB20248
	for <e@80x24.org>; Thu, 14 Mar 2019 23:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfCNXjg (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 19:39:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39991 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfCNXjg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 19:39:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id r23so6109344edm.7
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 16:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5s/IKQ04gJc7hHQdZOSEhWJ8fH1a9TNvr3ex0FPtTXk=;
        b=NKKhsulyL9s8gt3/mGssCdD1J9ecAJjcqAuwnnDDlJ1RZjdNz8nwM1lV5jOpUo5tWF
         yQOr1nQn4+Vws0+SZOLfIFItiTThkoQH+uQXTXenSDJV3rdO1L2f1U/f8YHM66973dnY
         SwlIlTX/CxMwSs47obfnZeBzAEfTL9Eo/4OvHZm6uADy993og93g3AlsUINm5hHKFsPq
         quscibDkPghRRI2Iutd/d++kPJ7vYl0jh8EL9v80aAC28seEnD7xCER6WAgyW4ZYHyzo
         3bkzXas3l7J2526vPyXMptdNa7LnxbIRv3Hn0DGWh4QL5hdQQ2BZWfHHIw5XQp8QO+qM
         rOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=5s/IKQ04gJc7hHQdZOSEhWJ8fH1a9TNvr3ex0FPtTXk=;
        b=iyaAl+PnZqLsCakf9jWsxdL2Yyw6qVzJFFymwvYnzjTXSJQMkQ45YCTYYzDmHONCuZ
         j0lPU9I34YnS7wYFmY4H7LiOC+3dDp0pChBAMeoqJQJRiy02tSNNctz1o+R3Q/+hrq0f
         AMQqS+e9KDx5Ie9kfWUK8pqR/f78SOXB7VG6OcaY1fRDKqXrw64yAApbphB1PsKn+ZCs
         54/aMg1cuJpMKEScACxMxK+VYBiDHFT05h5dfQvN79+GdxPefNQ6lj0Z8J8ZAOaqEzru
         o6OpCMHY3P1dZIKYshP2M3C012gR3b5YlE8xw5Dx69SEKRqclCgEYMaWtH/14/Hmvjq7
         jqpQ==
X-Gm-Message-State: APjAAAWaW9D3OcsBFK1WYMlegazEzN4vuxKqLtuvqHxh9lFupP2BuBsJ
        1VtxmtUpWWZu0Z98JuBxiEM=
X-Google-Smtp-Source: APXvYqz/LNREZqIuGp/xl80G56AjmkOYkATri/I2138+mU9V+5aqKWd7iXSKQxOM0Pq/DHWMp5K6Sg==
X-Received: by 2002:a05:6402:1596:: with SMTP id c22mr648225edv.122.1552606773906;
        Thu, 14 Mar 2019 16:39:33 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id z42sm151990edd.29.2019.03.14.16.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 16:39:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: regression in new built-in stash + fsmonitor (was Re: [PATCH v13 11/27] stash: convert apply to builtin)
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
        <20190225231631.30507-1-t.gummerer@gmail.com>
        <20190225231631.30507-12-t.gummerer@gmail.com>
        <87ftrpbnkg.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.1903141600020.41@tvgsbejvaqbjf.bet>
        <87d0mtbh1w.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.1903142058130.41@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1903142058130.41@tvgsbejvaqbjf.bet>
Date:   Fri, 15 Mar 2019 00:39:30 +0100
Message-ID: <878sxhauvh.fsf@evledraar.gmail.com>
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
>> On Thu, Mar 14 2019, Johannes Schindelin wrote:
>>
>> > On Thu, 14 Mar 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >
>> >> On Tue, Feb 26 2019, Thomas Gummerer wrote:
>> >>
>> >> > From: Joel Teichroeb <joel@teichroeb.net>
>> >> >
>> >> > Add a builtin helper for performing stash commands. Converting
>> >> > all at once proved hard to review, so starting with just apply
>> >> > lets conversion get started without the other commands being
>> >> > finished.
>> >> >
>> >> > The helper is being implemented as a drop in replacement for
>> >> > stash so that when it is complete it can simply be renamed and
>> >> > the shell script deleted.
>> >> >
>> >> > Delete the contents of the apply_stash shell function and replace
>> >> > it with a call to stash--helper apply until pop is also
>> >> > converted.
>> >>
>> >> This
>> >>
>> >>     GIT_TEST_FSMONITOR=3D$PWD/t7519/fsmonitor-all ./t3420-rebase-auto=
stash.sh
>> >>
>> >> Now fails, which bisects to 8a0fc8d19d ("stash: convert apply to
>> >> builtin", 2019-02-25).
>> >>
>> >> Tested on both a CentOS 6 & modern Debian testing machine:
>> >>
>> >>     + git rebase -i --autostash HEAD^
>> >>     Created autostash: 5cd734b
>> >>     HEAD is now at 0c4d2f1 third commit
>> >>     hint: Waiting for your editor to close the file...
>> >>     error: There was a problem with the editor '"$FAKE_EDITOR"'.
>> >>     Applied autostash.
>> >>     + exit_code=3D1
>> >>     + test 1 -eq 0
>> >>     + test_match_signal 13 1
>> >>     + test 1 =3D 141
>> >>     + test 1 =3D 269
>> >>     + return 1
>> >>     + test 1 -gt 129
>> >>     + test 1 -eq 127
>> >>     + test 1 -eq 126
>> >>     + return 0
>> >>     + rm -f abort-editor.sh
>> >>     + echo conflicting-content
>> >>     + test_cmp expected file0
>> >>     + diff -u expected file0
>> >>     --- expected    2019-03-14 13:19:08.212215263 +0000
>> >>     +++ file0       2019-03-14 13:19:08.196215250 +0000
>> >>     @@ -1 +1 @@
>> >>     -conflicting-content
>> >>     +uncommitted-content
>> >>     error: last command exited with $?=3D1
>> >>     not ok 36 - autostash is saved on editor failure with conflict
>> >>
>> >> Are you able to reproduce this? And if so I suggest running the test
>> >> suite with some of the other GIT_TEST_* modes documented in
>> >> t/README. Maybe it'll turn up something else...
>> >
>> > Yep, totally can reproduce it :-(
>
> Well, isn't this exciting: we found not a bug in the built-in stash (even
> if Junio probably expected yet another one), but an fsmonitor one! Even
> better, I think this might be the bug that Alex Vandiver was chasing and
> that he talked about at the Contributors' Summit last year in Barcelona.
>
> The symptom is that cache entries are sometimes considered up to date,
> when they really are not.
>
> And the reason is that the fsmonitor has this honking global flag
> `has_run_once` (it is not really global, it is `static` to
> `refresh_fsmonitor()`, but that's the same for all practical purposes, as
> it is *not* specific to one `struct index_state`), which was kind of okay
> as long as `the_index` was used implicitly by everything.
>
> Except it was not okay when `discard_index()` (or `discard_cache()`) was
> called: in that case, the flag was not re-set. And re-set it needs to be,
> in that case, otherwise the fsmonitor is not asked which entries need to
> be updated.
>
> I saw this pretty early on in my investigation and marked it up for a
> follow-up task, wasting hours of investigation by not believing that this
> could be the culprit of the bug you described. I did not believe it
> because `git stash apply` is *spawned*, so there is not even an index that
> needs to be discarded (I thought; more on that one later).
>
> It is quite curious that this is the only occasion that our test suite
> covers that particular part of the fsmonitor...
>
> I do not really want to rely on implementation details of the rebase to v=
erify
> that the fsmonitor is queried again (and, crucially, resets the
> FSMONITOR_VALID flag of the file(s) indicated as out of date) after the i=
ndex
> is discarded and re-read.
>
> I guess the best bet is to extend `t/helper/test-read-cache.c` to optiona=
lly
> output information about a specific cache entry, then refresh it, and the=
n run
> that test helper with fsmonitor-all (which should mark anything as modifi=
ed,
> all the time). That should verify that the fix works.
>
> I did exactly that, and pushed the result to https://github.com/dscho/git
> as `fix-fsmonitor` branch.
>
> Could I ask you to test that one (it is based off of Git for Windows'
> `master`, but that should compile cleanly for you)?
>
> For now, I am a bit spent, so I'll leave the rest for tomorrow.

It fixes not just this issue, but now the whole test suite passes with
GIT_TEST_FSMONITOR, i.e. this test that's been failing for ~2 years also
works now:
https://public-inbox.org/git/87k1vwn9qe.fsf@evledraar.gmail.com/

>> In the meantime I did a build with "next" (so stash-in-C) using the
>> standard test mode and these:
>>
>>     (cd t && GIT_TEST_GETTEXT_POISON=3Dtrue /usr/bin/prove $BKNG_GIT_HAR=
NESS_OPTIONS t[0-9]*.sh)
>>     (cd t && GIT_TEST_FSMONITOR=3D$PWD/t7519/fsmonitor-all GIT_SKIP_TEST=
S=3D"t3404.8 t3420.36" /usr/bin/prove $BKNG_GIT_HARNESS_OPTIONS t[0-9]*.sh)
>>     (cd t && GIT_TEST_SPLIT_INDEX=3Dtrue /usr/bin/prove $BKNG_GIT_HARNES=
S_OPTIONS t[0-9]*.sh)
>>     (cd t && GIT_TEST_FULL_IN_PACK_ARRAY=3Dtrue GIT_TEST_OE_SIZE=3D10 /u=
sr/bin/prove $BKNG_GIT_HARNESS_OPTIONS t[0-9]*.sh)
>>     (cd t && GIT_TEST_COMMIT_GRAPH=3Dtrue /usr/bin/prove $BKNG_GIT_HARNE=
SS_OPTIONS t[0-9]*.sh)
>>     (cd t && GIT_TEST_MULTI_PACK_INDEX=3Dtrue /usr/bin/prove $BKNG_GIT_H=
ARNESS_OPTIONS t[0-9]*.sh)
>>     (cd t && GIT_TEST_STASH_USE_BUILTIN=3Dfalse /usr/bin/prove $BKNG_GIT=
_HARNESS_OPTIONS t[0-9]*.sh)
>>     (cd t && GIT_TEST_CHECK_COLLISIONS=3Dfalse /usr/bin/prove $BKNG_GIT_=
HARNESS_OPTIONS t[0-9]*.sh)
>>
>> Only this specific test failed.
>
> Well, good!
>
> Thank you for getting the ball rolling!
> Dscho
