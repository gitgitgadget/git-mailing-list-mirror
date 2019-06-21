Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4F001F461
	for <e@80x24.org>; Fri, 21 Jun 2019 18:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfFUS0n (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 14:26:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34366 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfFUS0n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 14:26:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so11397051edb.1
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RHnj3DqGmkqq5glzAVV7PH6jTo9s0CPVji0Zcj1U4NE=;
        b=t9TxYJQYi0jpe0O6WodieVMviXz2s/aPpdTJGLme/Ncn+mEzABVDPkFDt1Dbf5LThP
         5XPpoSCQyxb7zcGetif0sEDDBEW9N0AHiSHpx0DnNm3rUqLn+R+tWLvNnjko3uNPVoA2
         ajZlvOaK/ouSyPgu6YEisYssQ/jJ65FLmCgFsRg5GC/D6yLu0bw5p9RUX8kFZWddIeC0
         8UT0E6tnb4lYM6mjp48sU/465sr0nNEUgO1ThqgyuX0hc2bWi6LIK5icEyJiaIc2KORx
         QkJYlhNYyahPRVs2FR9WZw7QVO/dNqHGlEuwp+y9T/QcZTU7F+LfgfpVVNj43CMU4F1Q
         Lz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=RHnj3DqGmkqq5glzAVV7PH6jTo9s0CPVji0Zcj1U4NE=;
        b=YejUJ9fbbYcrhHLaKq8BESMGS4k7ekmzNhjj41aQ7cF60rp6r/mHw3znR4DWvex1Eh
         JC1rYnuz1pFNPxpS1P0J8C5+XSTfMaaVQpVVNKyqBh6+vBfsz0UBeA5T3YygppP0p+0W
         tT+aqqT8h0akSXeGdj681MRkb0ITyYdgoKjkxQbYvnVQ+zoamY/wToEWeayvI1fX1Xfp
         vhNYAHs4kbSD/ay24XHflL8ZhjumEUPHb63C5O88wYTMOkaiwAEQ1IXGBbTDxPi1lClN
         SHoqrMvg67CiPRtOnwA7AjyauXtTGG67Jt5TMy2ahIPUG72sIXVjcTWpoy7w4UkomuAf
         rN8g==
X-Gm-Message-State: APjAAAXqlD937KKJvCPwgOvkyl5/xK3GhMAlmVxsBGXGae/mMXvZI/Id
        R9UyC51EfCwWl0TbQBT+HZU=
X-Google-Smtp-Source: APXvYqywerj+tEv6BIQ9BrZQpjCoWgo+sGYK7mXzSjvVnYSTcQj5zFuWVVRMuiSsGcQIlLu6v5HCCg==
X-Received: by 2002:a50:972a:: with SMTP id c39mr113247760edb.46.1561141601588;
        Fri, 21 Jun 2019 11:26:41 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id m6sm1042018ede.2.2019.06.21.11.26.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 11:26:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] tests: mark two failing tests under FAIL_PREREQS
References: <20190513183242.10600-1-avarab@gmail.com> <20190620204227.8947-1-avarab@gmail.com> <nycvar.QRO.7.76.6.1906212000580.44@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1906212000580.44@tvgsbejvaqbjf.bet>
Date:   Fri, 21 Jun 2019 20:26:38 +0200
Message-ID: <87a7ea94m9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 21 2019, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Thu, 20 Jun 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Fix a couple of tests that would potentially fail under
>> GIT_TEST_FAIL_PREREQS=3Dtrue.
>>
>> I missed these when annotating other tests in dfe1a17df9 ("tests: add
>> a special setup where prerequisites fail", 2019-05-13) because on my
>> system I can only reproduce this failure when I run the tests as
>> "root", since the tests happen to depend on whether we can fall back
>> on GECOS info or not. I.e. they'd usually fail to look up the ident
>> info anyway, but not always.
>
> I had to read the commit message (in particular the oneline) a couple of
> times, and I have to admit that I wish it was a bit clearer...
>
> From the explanation, I would have assumed that those two test cases fail
> often, anyway, so they shouldn't care whether `FAIL_PREREQS` is in effect.
>
> The only reason why they should be exempt from the `FAIL_PREREQS` mode
> that I can think of is that later test cases would depend on them, but how
> can they? Those test cases would also have to have the `AUTOIDENT` prereq,
> and they would be skipped under `FAIL_PREREQS`, too, no?

The test doesn't depend on "AUTOIDENT", but "!AUTOIDENT", i.e. the
negated version. The effect of the FAIL_PREREQS mode is to set all
prereqs to false, and therefore "test_have_prereq AUTOIDENT" is false,
but "test_have_prereq !AUTOIDENT" is true.

So this test that would otherwise get skipped gets run.

I honestly didn't think much about these cases when I wrote dfe1a17df9
("tests: add a special setup where prerequisites fail", 2019-05-13), and
now I'm not quite sure whether it should be considered a bug or a
feature, but in the meantime this un-breaks the test suite under this
mode.

> In other words, I struggle to understand why this patch is necessary.
>
> Could you help me understand?
>
> Ciao,
> Dscho
>
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  t/t0007-git-var.sh          | 2 +-
>>  t/t7502-commit-porcelain.sh | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
>> index 5868a87352..1f600e2cae 100755
>> --- a/t/t0007-git-var.sh
>> +++ b/t/t0007-git-var.sh
>> @@ -17,7 +17,7 @@ test_expect_success 'get GIT_COMMITTER_IDENT' '
>>  	test_cmp expect actual
>>  '
>>
>> -test_expect_success !AUTOIDENT 'requested identites are strict' '
>> +test_expect_success !FAIL_PREREQS,!AUTOIDENT 'requested identites are s=
trict' '
>>  	(
>>  		sane_unset GIT_COMMITTER_NAME &&
>>  		sane_unset GIT_COMMITTER_EMAIL &&
>> diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
>> index 5733d9cd34..14c92e4c25 100755
>> --- a/t/t7502-commit-porcelain.sh
>> +++ b/t/t7502-commit-porcelain.sh
>> @@ -402,7 +402,7 @@ echo editor started >"$(pwd)/.git/result"
>>  exit 0
>>  EOF
>>
>> -test_expect_success !AUTOIDENT 'do not fire editor when committer is bo=
gus' '
>> +test_expect_success !FAIL_PREREQS,!AUTOIDENT 'do not fire editor when c=
ommitter is bogus' '
>>  	>.git/result &&
>>
>>  	echo >>negative &&
>> --
>> 2.22.0.455.g172b71a6c5
>>
>>
