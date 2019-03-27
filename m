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
	by dcvr.yhbt.net (Postfix) with ESMTP id E89AA20248
	for <e@80x24.org>; Wed, 27 Mar 2019 10:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733128AbfC0KJW (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 06:09:22 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:45021 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfC0KJW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 06:09:22 -0400
Received: by mail-wr1-f43.google.com with SMTP id y7so13662974wrn.11
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 03:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=8GjzeUI1L6HMjREOi8hQemFUcTWbONOMj1BxNQjFgFg=;
        b=ghFA2mpNpKOSntj4MUXgw36d79cVyfOAN9UNjA1xDIEwG7tma04z9STtw9EHNHzAPP
         XUc9SC3r1PcMNCeHVDvSYzVEn5fV5BnATxxHY8y8vbet0v7piy+2c+/x/AOGyytP54lf
         7T9bcKuHnZWk+a3QFdLbrjRJ8e1JpElZWJxlbA4Nyhg94shOLOKGw7UzKWnQV7kUyrYG
         kkCMfgUHN5B96SMHHVzQxgP/SwK7gBsCy2cpRZXonT7SkILGKUpVSoSR+J5XA98fxeDB
         WukBzOZGVVAjpPo1ZS7dly8B7Psk4PeZqwfgFQY9FvNMIDIeTbx8edfhqoeFXeLWJIHq
         02NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=8GjzeUI1L6HMjREOi8hQemFUcTWbONOMj1BxNQjFgFg=;
        b=mW7rnYKPwMiVHfedOkenmgRVjV7hixa+infpuJbVzZwusH/VnguQ6h2M3Dj1hgkc0Y
         FRllGRvsOKk2EgYT0H3roJ3PNr4BqiKXZ/rxGCnG8AyhZ3nX2AVMEV13ymEpG0dQipTE
         O7hzYBzZvir0W+0HmVj5VAd2k2r40J6rFE5VG3zvZ8Iid/EB8Iycsm88YECkb011X7Xs
         eKILsH2tXJln0Hjg7iWalsfV3vet6p+1xINVZZ/LM6oHinoC3QGpTdPI2pWua2Hhbdm0
         psZwPxtJE43NPuFWYJIoyyEfYY6PPUrf8ApUhUIdVjzG8ApHBn/h/ZgsyG/21v+T0c2d
         merg==
X-Gm-Message-State: APjAAAWrgLaYx5dBck826QfPQThPxqadtAZhNw+NNLZ7WCb4PwWbuz13
        RUr186pSoMFhG/xtmCBNfmA=
X-Google-Smtp-Source: APXvYqyXKgdlwzHrdSkHiKPMNZPh4mXWhjcJGGiVc0KR21WsDSatboc+jFlkUg6x3FtrTuoVqaQuaQ==
X-Received: by 2002:adf:ee07:: with SMTP id y7mr21873961wrn.219.1553681360479;
        Wed, 27 Mar 2019 03:09:20 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id v13sm19309275wmj.43.2019.03.27.03.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 03:09:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Mooga <contact@m-mooga.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [GSoC] microporject test_path_is_*
References: <38B8E527-2338-485E-8840-29121F259687@m-mooga.com> <CABPp-BHwUoqk79Kf=ynna5x+mCJyOLz66v6pDieyEeM7YCRS+g@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CABPp-BHwUoqk79Kf=ynna5x+mCJyOLz66v6pDieyEeM7YCRS+g@mail.gmail.com>
Date:   Wed, 27 Mar 2019 11:09:18 +0100
Message-ID: <877eckbpdd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 26 2019, Elijah Newren wrote:

> Hi,
>
> On Tue, Mar 26, 2019 at 2:10 PM Mooga <contact@m-mooga.com> wrote:
>>
>> Hi,
>> I am still a bit confused about the task itself
>>
>> it=E2=80=99s just text replacing for example:
>> t1400-update-ref.sh , line 194 -> `test_path_is_missing`  has to be =E2=
=80=98test_path_is_file=E2=80=99
>>
>> Thanks
>
> There are several places in the code that use test with -e or -f or -d
> (or -h or...) in order to check for the presence of a
> file/directory/symlink/etc.  For example,
>    test -f path1/file1
> This could be made more clear and produce nicer error messages if it
> were instead
>    test_path_is_file path1/file1

See also the recent thread I started
https://public-inbox.org/git/87sgwav8cp.fsf@evledraar.gmail.com/ asking
if these wrappers were useless now. The consensus was to keep them (a
bunch of use-cases I didn't know about). Useful if you're poking at them
and wondering why we're using this / what it gives us.

> There are likewise several that use one of
>    ! test -e path/to/filename
> or
>    ! test -f path/to/filename
> or
>   test ! -f path/to/filename
> which could be replaced by
>   test_path_is_missing path/to/filename

Interesting that for some we use the 'test_is_there/test_is_not_there'
pattern and for others 'test_is_there [!]'. E.g
test_path_exist/test_path_is_missing v.s. test_i18ngrep.

> This GSoC microproject is just about picking one testfile that has
> some of these constructs, and fixing the cases found within that
> testfile.
