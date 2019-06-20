Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB4101F461
	for <e@80x24.org>; Thu, 20 Jun 2019 21:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfFTVAx (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 17:00:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42643 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFTVAw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 17:00:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id x17so4390906wrl.9
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 14:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Ovv+6XAbw93upaikJMusR+HnCVImzEmfcHobjVrbhGo=;
        b=r/jAc1ju+YAfKak9/QKhQboJ3bpX+sOIO/orgctMUzb31/Ogxtk3K+iR8PaEmOS17k
         CylC/STzmI/M9CtGji4G6c1E6kUqPk6aMB10/KtBUGW4QN5nSvDiV5jkmRB8m/PszF9j
         Q3Gi8aLfQnfBF3Lfhg5derVOZhLlTliby8YUNpncf3X0uI8OyGY26eVQji9NgaqjUIeo
         30rKIMAk0w2TKJq0Zrk5Q235vb3FIE+o+JHTKdlOsnhPFuC/Cw5/HdqPZrq/6cJgMTGy
         iKgD7AEUhjuMqvaQzKZYcUGJmNPAW0MqXq9rQZ4FfSgBOAuXZo578HWos/9DhBQBCeqF
         tRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Ovv+6XAbw93upaikJMusR+HnCVImzEmfcHobjVrbhGo=;
        b=oUdkR478ROdw/WW8qch2qWS2S1MUmZehQBmltkpWZ+4KxRLmP/DCWW6W7BYAgD7kwx
         Z3CueJn2O/X4Lm7vj0Mu+4XVawVINGspl5GVUR+4j/thZDUuMe6bCLSH8rqBj0Jds1u8
         QyQIG1z30eF2ON+Z/SHpxLLcvHIN9za1DMssnfB5Xbrp9e9ge60RFoV+IvedbVUwx3fF
         ZQJSGJdYXLnfE8A0Ss6Bsa5YDXQ+OWexgX+JbvNXS8crf1DdZ0rkjYvhBuO/fpQEvmrA
         JwIdgSvGKyU+0p4/akb5NPi4nmt9Lws4wk9OD1suksivTy+2yPw8x8FfzuDRspTk8Fvi
         szCA==
X-Gm-Message-State: APjAAAWvL9LcxtQZNMy8qzhzd9etAoacupmrDdbAVGG3yNss1JWFCo5w
        +lCp6/kHvDtGBU6x9jsXva/9lotxfLk=
X-Google-Smtp-Source: APXvYqzMTVYJTCb/H+02zNT+cGC4HuDBn8+E/wUACahCszvuTCSepd7SIgFyH2+vmMCa0/VO7knPTw==
X-Received: by 2002:adf:a443:: with SMTP id e3mr39797329wra.221.1561064450184;
        Thu, 20 Jun 2019 14:00:50 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id w23sm453682wmc.38.2019.06.20.14.00.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 14:00:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] Change <non-empty?> GIT_TEST_* variables to <boolean>
References: <87imt18a2r.fsf@evledraar.gmail.com> <20190619233046.27503-1-avarab@gmail.com> <xmqqo92snn0o.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqo92snn0o.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 20 Jun 2019 23:00:48 +0200
Message-ID: <87fto47z0f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 20 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This changes the remaining <non-empty?> special snowflake test modes
>> to <boolean> and gets rid of test_tristate() in favor of the now
>> standard "boolea" test.
>>
>> I'm replying to my "gc: run more pre-detach operations under lock"
>> thread because one of the things my WIP patches to make gc locking
>> less sucky depends on is new GIT_TEST_GC_* test modes to test its
>> racyness, which in turn depends on these cleanups.
>
> That sounds like the "gc: run more ..." depends on these (iow, that
> should be the reply to these, not the other way around)?

Yeah the tests in that otherwise unrelated series loosely depends on
this, so I figured I'd try to get this in first.

> I am asking because I see obvious value in these "uniformly require
> <boolean>" consistency change (which could be backward incompatible,
> but as long as these are GIT_TEST_*, we do not mind too much forcing
> developers to adjust), but not yet in the "gc: run more ..." one,
> and do not want these to be taken hostage.

Yeah these should be viewed independently. Perhaps I shouldn't have
filled that In-Reply-To...

>>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (6):
>>   env--helper: new undocumented builtin wrapping git_env_*()
>>   t6040 test: stop using global "script" variable
>>   tests: make GIT_TEST_GETTEXT_POISON a boolean
>>   tests README: re-flow a previously changed paragraph
>>   tests: replace test_tristate with "git env--helper"
>>   tests: make GIT_TEST_FAIL_PREREQS a boolean
>>
>>  .gitignore                |  1 +
>>  Makefile                  |  1 +
>>  builtin.h                 |  1 +
>>  builtin/env--helper.c     | 74 +++++++++++++++++++++++++++++++++++++++
>>  ci/lib.sh                 |  2 +-
>>  gettext.c                 |  6 ++--
>>  git-sh-i18n.sh            |  4 ++-
>>  git.c                     |  1 +
>>  po/README                 |  2 +-
>>  t/README                  | 12 +++----
>>  t/lib-git-daemon.sh       |  7 ++--
>>  t/lib-git-svn.sh          | 11 +++---
>>  t/lib-httpd.sh            | 15 ++++----
>>  t/t0000-basic.sh          | 10 +++---
>>  t/t0016-env-helper.sh     | 70 ++++++++++++++++++++++++++++++++++++
>>  t/t0205-gettext-poison.sh |  2 +-
>>  t/t5512-ls-remote.sh      |  3 +-
>>  t/t6040-tracking-info.sh  |  6 ++--
>>  t/t7201-co.sh             |  2 +-
>>  t/t9902-completion.sh     |  2 +-
>>  t/test-lib-functions.sh   | 58 +++++-------------------------
>>  t/test-lib.sh             | 29 ++++++++++++---
>>  22 files changed, 220 insertions(+), 99 deletions(-)
>>  create mode 100644 builtin/env--helper.c
>>  create mode 100755 t/t0016-env-helper.sh
