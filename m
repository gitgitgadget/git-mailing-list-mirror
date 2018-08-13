Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 342331F428
	for <e@80x24.org>; Mon, 13 Aug 2018 20:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbeHMXNq (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 19:13:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34848 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeHMXNq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 19:13:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so10130892wmc.0
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 13:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3955G4XrSIP71MWDlnuIx+uSZrKYiDKDN1d9BDnx8hE=;
        b=cuo9yGaays0gmUY9Ru7op7Pd1m/pMarmZafChxxwjWSr3fepz3R+t1SzenQG5YZ69B
         9KyccO5E23eOmLE1wDuiBC2AHDtANEmATscbtfFlSqhT1Gb5i7Oys5sSOI2QFl9CBo8O
         eKJc/MJpPQdx2gtyiZWNE9LjfVdKFV4gLNusjpTdgFK8DlC0nSiLlFaPPengMujdJ7ee
         DYtylQlAVDtFdlQges3fw7SLnDwNC/GG7KxBm4pgxDHcXRGKHeWor3lFyg6OMiABKR/V
         kXVJnypbfnZYaQ+J08you/KsHXD8Ay1X2hcyvXEn6yMQ9Znfrlz0n35b8u5eDIFaWxVB
         0kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=3955G4XrSIP71MWDlnuIx+uSZrKYiDKDN1d9BDnx8hE=;
        b=ktGd8tBRAmZFJwrvrKvHtoQW2OJDIkX4oVUz8Yk3A1vuNB58UAfcaXNxkvVnJbEvAZ
         o3HVLRpxgdiPUD9KoLZ1VR07MR7oh71vnmzbRu09Ek9Ihp085Tzw54kg/2xFlSS7JiJZ
         TS2hiak1iekKhvZrLp3Cx02PlQ47daPBZGQt/a+FXWBla2Iv9h7/Ad3uZNPVhAFAJJNV
         92Sy+JFC+i4hnpE6gvqz1+an53dZEQii2yoFu57l+z23bzDhwSlSxGX8zjNhGpuJFEcg
         8nvyiWgt2aPIlaez5iPVWYAO+xTHNIXw3y6xLcP9UC+/iGQf52GHbe8/s4o9/dCbDtk2
         lNBQ==
X-Gm-Message-State: AOUpUlEGmPNkRw2JdqHV3bU83t6R2q0Fz1smxJv3Y3hDt5ah2GGir/G+
        za5SQI4Z9fUh9bW5AhGzS+Q=
X-Google-Smtp-Source: AA+uWPyteaJY9z3EiyIDTHmnnJkcAZYwNCoP7Z9RTpS7MBhEJq2cW3osv9L+j8yc8RwuMpDDiNAgGw==
X-Received: by 2002:a1c:dac6:: with SMTP id r189-v6mr9021277wmg.150.1534192197542;
        Mon, 13 Aug 2018 13:29:57 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h184-v6sm4485805wmf.28.2018.08.13.13.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 13:29:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v3 0/7] Prep for "git fetch" should not clobber existing tags without --force
References: <20180731130718.25222-1-avarab@gmail.com>
        <20180813192249.27585-1-avarab@gmail.com>
Date:   Mon, 13 Aug 2018 13:29:56 -0700
In-Reply-To: <20180813192249.27585-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 13 Aug 2018 19:22:42 +0000")
Message-ID: <xmqqlg9a3t8b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> This is unchanged from what's been cooking in pu for months now, so
> hopefully it can be merged down faster than most, and then I can later
> submit the actual meat of this series once I fix the (mostly doc)
> issues with it.

They have been held in 'pu' only because you said they were not
ready, I think ;-)

I can confirm that the first 5 do look the same, and you dropped the
old 6, 8 and 10.  The remainder look the same.

I quickly re-scanned them and all of them looked obviously good.
Will discard the remainder and requeue.


>
> Ævar Arnfjörð Bjarmason (7):
>   fetch tests: change "Tag" test tag to "testTag"
>   push tests: remove redundant 'git push' invocation
>   push tests: fix logic error in "push" test assertion
>   push tests: add more testing for forced tag pushing
>   push tests: assert re-pushing annotated tags
>   fetch tests: correct a comment "remove it" -> "remove them"
>   pull doc: fix a long-standing grammar error
>
>  Documentation/pull-fetch-param.txt |  2 +-
>  t/t5510-fetch.sh                   |  2 +-
>  t/t5516-fetch-push.sh              | 65 +++++++++++++++++++++---------
>  3 files changed, 47 insertions(+), 22 deletions(-)
