Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 941611F461
	for <e@80x24.org>; Mon, 24 Jun 2019 15:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbfFXPl1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 11:41:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39098 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFXPl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 11:41:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so14418626wrt.6
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 08:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=viQIS5x2rKWgDvlbNFKXRLH6HL0tijqS8OaY9tU+ZRE=;
        b=j+p2bdzWwnkgCLWL38mmKsNjAK1DfvN863hoFmoSzPTC7bIAYZKL+tOkc7VRRXn9pk
         zj3XF5LLEF5KeK3b7/3w51JS6lKc04qmUBvE0jPQPECDyj41laHx5wWqHvnSk7JGyBkd
         wVz6fQAD+nzJTXykbXGymFCfC8r6Emx0zywTVN7h+cSm2aepeM0UTQ2X18BBKtDu6jJ7
         X0w866ehvoJcJPP/l6/1PgpQ0ZQuY9nWjrh++Zcwcapu6KTErESN65zAn+0SWifXzzAK
         K2jaU/+MOEE4m1Pidql68yCIk2BqoE/pXJeR2+ddYbkogO5GuekDr6zpjWh1/Tnd68v2
         k6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=viQIS5x2rKWgDvlbNFKXRLH6HL0tijqS8OaY9tU+ZRE=;
        b=L7ZESZ4b5QV+c6hRQuipoHtRhj8M0Y/MureqbaII7NZwSoMdzzAOPm3fKSHiGNlxFL
         +73AnP0fMeTfL1iawb2U87+99dr+vPkBMJErpqGB10ZGUfQhv+dZuwR/gHhpZ+TwnM8U
         utmvLUHgRD2Qtvy897CAEos6pKhVkvE5yC6KjCtAyKoGA+q1ZybNvZNNOvBpNP4T0Wm6
         av4vQ9aqVcGCxmxfljsYovIb9t8K6w2HswrVROj61QH59fkuKgFEHP94NdMwffY/hzRs
         BWktOT6aJR7RR7xR4gUx57rzAX0l1ewF5Ru5dGKCe+74VwaCP+qqV/dFK2sG68xuQGVv
         n3eQ==
X-Gm-Message-State: APjAAAU6wIDzN78vlf6DQA95fH9eQT+BrVH/lwalZaJWZRH90O2Vd6yc
        2v7RzgWJmPTMCqBp+VGPunk=
X-Google-Smtp-Source: APXvYqwdrszc+1ytKpX8tF8ueihxA2LDJoD6D4bIYOUxVc7W4mb1G2ZRQf3TPXnH4wxHhza/waAVSw==
X-Received: by 2002:adf:efc8:: with SMTP id i8mr1548402wrp.220.1561390884311;
        Mon, 24 Jun 2019 08:41:24 -0700 (PDT)
Received: from linux-16.fritz.box (2a0a-a542-2a07-0-a793-8424-e1d1-435c.ipv6dyn.netcologne.de. [2a0a:a542:2a07:0:a793:8424:e1d1:435c])
        by smtp.gmail.com with ESMTPSA id i25sm14848676wrc.91.2019.06.24.08.41.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 08:41:23 -0700 (PDT)
From:   Morian Sonnet <moriansonnet@gmail.com>
X-Google-Original-From: Morian Sonnet <MorianSonnet@googlemail.com>
Received: from linux-16.fritz.box (localhost [127.0.0.1])
        by linux-16.fritz.box (8.15.2/8.15.2) with ESMTPS id x5OFfMFU010223
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 17:41:22 +0200
Received: (from momo@localhost)
        by linux-16.fritz.box (8.15.2/8.15.2/Submit) id x5OFfLgk010222;
        Mon, 24 Jun 2019 17:41:21 +0200
To:     johannes.schindelin@gmx.de
Cc:     MorianSonnet@googlemail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, gitster@pobox.com, moriansonnet@gmail.com,
        sunshine@sunshineco.us
Subject: submodule foreach: fix recursion of options
Date:   Mon, 24 Jun 2019 17:40:50 +0200
Message-Id: <20190624154050.9943-1-MorianSonnet@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <nycvar.QRO.7.76.6.1906241241080.44@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1906241241080.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

here comes the next version.

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> Hi Morian,
> 
> On Sat, 22 Jun 2019, Morian Sonnet wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > > On Tue, 18 Jun 2019, Morian Sonnet wrote:
> > >
> > > > "Morian Sonnet via GitGitGadget" <gitgitgadget@gmail.com> wrote:
> > > >
> > > > > Calling
> > > > >
> > > > >     git submodule foreach --recursive git reset --hard
> > > > >
> > > > > leads to an error stating that the option --hard is unknown to
> > > > > submodule--helper.
> > > > >
> > > > > Reasons:
> > > > >
> > > > > . Above call is internally translated into
> > > > >
> > > > >     git submodule--helper foreach --recursive -- git reset --hard
> > > > >
> > > > > . After calling
> > > > >
> > > > >     git reset --hard
> > > > >
> > > > >   inside the first first level submodule,
> > > > >
> > > > >     git --super-prefix <submodulepath> submodule--helper \
> > > > >       foreach --recursive git reset --hard
> > > > >
> > > > >   is called. Note the missing --.
> > > > >
> > > > > . Due to the removal of PARSE_OPT_KEEP_UNKNOWN in commit a282f5a906 the
> > > > >   option --hard is not passed to
> > > > >
> > > > >     git reset
> > > > >
> > > > >   anymore, but leads to git submodule--helper complaining about an
> > > > >   unknown option.
> > > > >
> > > > > Fix:
> > > > >
> > > > > . Add -- before the command to execute, such that now correctly
> > > > >
> > > > >     git --super-prefix <submodulepath> submodule--helper \
> > > > >       foreach --recursive -- git reset --hard
> > > > >
> > > > >   is called.
> > >
> > > This is a good explanation, even if the format is not exactly close to the
> > > existing commit messages ;-) If you look e.g. at
> > > https://github.com/git/git/commit/e5a329a279c7, you will see what I mean:
> > > there is much more "prose" (and less bullet points) going on.
> >
> > Ok, I see the differences. Shall I adapt the commit description?
> 
> Well, I would if I were you ;-)

Ok, done.

> 
> > My test so far was designed to not actually check whether git reset
> > --hard has shown any effect.
> 
> Right, but the test case's title suggested that...

The commit message is very specific regarding git reset --hard, right.
Changed that.

> 
> > Taking the test "test "foreach --quiet --recursive"" and the test
> > "option-like arguments passed to foreach commands are not lost" for
> > example, I suggest the following:
> >
> >   git -C clone2 submodule foreach --recursive "echo be --hard" > expected &&
> >   git -C clone2 submodule foreach --recursive echo be --hard > actual &&
> >   grep -sq -e "--hard" expected &&
> 
> Please without the `-sq`.

Oh, ok, i took it from another test in that suite.

> 
> >   test_cmp expected actual
> 
> Sounds good to me, especially with this suggestion:
> 
> > As final comment: One could change the flag --hard to something which
> > will definetely never be an option flag for both, echo and git submodule
> > foreach, e.g.  --this-will-never-be-an-option.
> 
> Personally, I'd go for `echo --an-option`, and yes, you are absolutely
> right, the intention of your bug fix is not so much to fix the recursive
> `git reset --hard` as it is to fix _any_ recursive command with
> command-line options.
> 
> To be honest, I had missed that `git submodule foreach --recursive`
> executes commands even in uninitialized submodules... I could even see how
> some users might consider that behavior a bug... are you sure this is the
> case? Is this `echo` really executed even in `nested2`?

I think this is a misunderstanding. I did not mean that the subcommand
is executed in `nested2` (which it actually is not) but rather that
`git submodule--helper foreach ...`
is again executed in `nested1` and this even if `nested1` does not
include any submodules.

Best regards,
  Morian


