Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64E091F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 14:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeJHVb1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 17:31:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34388 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeJHVb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 17:31:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id z25-v6so8869207wmf.1
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 07:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Mu3SSZJRzuzDju673/xFPB9I2Kxq1n5J6AzDi4VhXhU=;
        b=ZyA1D9p6zkBiHZDVGdk4YkcnB2F8gNgvoeEVDh/J/9cqdTgoH+dLD6i4Xou+WHcVM5
         +m1khJa4Q7rS8yKaotqa/ClnYIKj7goMa9r5RD4bQtI4lRYadx089BYfy7KxkAWa0DCt
         PDMdWwGhq8x1MldNgINR88+9VV4PQx0vqE3DIP0zZcvmSPRj0X3MuaDP3xUJBkuLPC5/
         689tz5ANcPgPmOuePQLeQVldNBZQxT9LIm4mN+VDglvzHh6sjEg9or+mF5x0K8YsKz0v
         IWBnsyamuLrzocyA2oErbIJY4seRX4VAto+KrjkKBhVzQoq8FKJdPMZ7f05JD6Prk6JG
         HgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Mu3SSZJRzuzDju673/xFPB9I2Kxq1n5J6AzDi4VhXhU=;
        b=rqu1ecbuz8pVe8dXm1DLQvWL6jtGiYnl1Ho/9dgkfRIVHNmWO6rzKoJPp/Moc29OKL
         1MQ2KK2M1+IrZWXwLQVpsZGSJd+r0Y2g34lOyo84uZvJf0DSUKdsF8VFKARBIUYTv0bX
         8MfsmFvXlb/Ax5t1rCGYTkGvDQJoG2YrFZzcy0M/tXir6HDYfZhjxdqhtIR4mH2F+NKr
         YiAYZ+yMkfwNTMBVeSy3Hsl5Vm+qOvBS8eqrciPzV5wk1iND841vXON7E8J1OpgFY5jp
         2Xq2vOMQXCkH3YLwH7AHWkq1jJ6jou7+SMvWHyro6+NuySgtH5FvIxMzPPlLv8xRQans
         kzlA==
X-Gm-Message-State: ABuFfohQDwD1UyiB8akFmwb+HoHtGUUE5eRKCAbjz6slokyBHAt6czR1
        biZ3eXvswiD/3gZ/dz/kao5S8VFq
X-Google-Smtp-Source: ACcGV62vk3vXqglvsuj8hdlm/NACM0ciRrpTaJt7tiLzCcH39RogGJwXWUwiyXFSr3fVONeow1FY9A==
X-Received: by 2002:a1c:981:: with SMTP id 123-v6mr15138207wmj.130.1539008368558;
        Mon, 08 Oct 2018 07:19:28 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id e14-v6sm14483396wrs.69.2018.10.08.07.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 07:19:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: t3404.6 breaks on master under GIT_FSMONITOR_TEST
References: <87k1vwn9qe.fsf@evledraar.gmail.com> <87sh2mrefa.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <87sh2mrefa.fsf@evledraar.gmail.com>
Date:   Mon, 08 Oct 2018 16:19:26 +0200
Message-ID: <87a7noa5ch.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 06 2018, Ævar Arnfjörð Bjarmason wrote:

> On Thu, Feb 01 2018, Ævar Arnfjörð Bjarmason wrote:
>
>> The GIT_FSMONITOR_TEST variable allows you to roundtrip the fsmonitor
>> codpath in the whole test suite. On both Debian & CentOS this breaks for
>> me:
>>
>>     (cd t && GIT_FSMONITOR_TEST=$PWD/t7519/fsmonitor-all ./t3404-rebase-interactive.sh -i)
>>
>> Whereas this works:
>>
>>     (cd t && GIT_FSMONITOR_TEST=$PWD/t7519/fsmonitor-all GIT_SKIP_TESTS=t3404.6 ./t3404-rebase-interactive.sh -i)
>>
>> The entirety of the rest of the test suite still passes with
>> GIT_FSMONITOR_TEST.
>>
>> This has been failing ever since GIT_FSMONITOR_TEST was introduced in
>> 883e248b8a ("fsmonitor: teach git to optionally utilize a file system
>> monitor to speed up detecting new or changed files.", 2017-09-22). Under
>> -v -x -i:
>>
>>     + echo test_must_fail: command succeeded: env FAKE_LINES=exec_echo_foo_>file1 1 git rebase -i HEAD^
>>     test_must_fail: command succeeded: env FAKE_LINES=exec_echo_foo_>file1 1 git rebase -i HEAD^
>>     + return 1
>>     error: last command exited with $?=1
>>     not ok 6 - rebase -i with the exec command checks tree cleanness
>>     #
>>     #               git checkout master &&
>>     #               set_fake_editor &&
>>     #               test_must_fail env FAKE_LINES="exec_echo_foo_>file1 1" git rebase -i HEAD^ &&
>>
>> Maybe once this is fixed running the test suite under GIT_FSMONITOR_TEST
>> would be a useful Travis target, but I don't know the current status of
>> adding new options to Travis.
>
> *Poke* at this again. Ben, or anyone else with knowledge of fsmonitor:
> Can you reproduce this?
>
> This failure along with the one I noted in
> https://public-inbox.org/git/87tvn2remn.fsf@evledraar.gmail.com/ is
> failing the tests on Linux when run with GIT_FSMONITOR_TEST.
>
> I'm looking at this again because SZEDER's patches to the split index
> reminded me again that we have these long-standing failures in rare test
> modes (see
> https://public-inbox.org/git/87va7ireuu.fsf@evledraar.gmail.com/ for the
> split index discussion).

For what it's worth this is still broken, but more importantly (I'm not
just keeping bumping the same thing) the only thing that's now broken
under fsmonitor. I.e. my skip config is now GIT_SKIP_TESTS="t3404.7"
whereas before 43f1180814 ("git-mv: allow submodules and fsmonitor to
work together", 2018-09-10) I needed to add "t7411.3 t7411.4" to that.
