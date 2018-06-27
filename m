Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36BAE1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 07:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeF0HtY (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 03:49:24 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:43579 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeF0HtX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 03:49:23 -0400
Received: by mail-ua0-f195.google.com with SMTP id z16-v6so664103uaz.10
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 00:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KxHjzKmYUIoRSQSG0sXugcGyXDlvWCcE+9rBTtUdAfE=;
        b=ndW1FnwEx0UPLxNCtBDvbLp0kH70Lr87KHKY4NYKIFcQrWsk29HRrZ+1oqU+fkVPMW
         cyheifrfjzh/gWWwECksJkezz73th9/uzgbJmuBIQq3V22hPV3lJPuG3zLlujlsN100Z
         8tkKw1yVPMqmfl9ma8Rj2kggelE5JaBIPjm/x+kpCz1MkxRN66jrtz3SQMFGth6WpH06
         SAGR/oVgmppbT4V1i2GsXsaUsez64acc0I0ENvgzUtWv8NJQqsd0sc77eJAjnS9+NV3s
         +ngQ8C02sJgOk/PvKfMZ08yR0Qb8dEguFkd4HMeYv3b4Ge7t2+OhSMoRQB1vY6gM9JW6
         /MgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KxHjzKmYUIoRSQSG0sXugcGyXDlvWCcE+9rBTtUdAfE=;
        b=n4Vb4aS3rbPn/TlkaRP/THRvR9A/Gj2CoX2OH65lPPnyGpP2H2LMewUCDtc9NvySdi
         IkpLc3UnLpyrb1Zxp6/rEst6kDpylAP/6r6+3CJDWuqKCNR0x2ln3X3gQHXO+drEGq6N
         4GvZa5hAEpdYegP5puzgnjEw39/hwY2b+dBuiZiwpe+R4FavNxAvRNbdxCKstejK+e+J
         J58JeO1VFFJ9N37j/ZK21Tg9WC61CbQiU07IwxlH9SDwtwPX+5LqTtXUXWAo+ZP4UVrf
         bijsLkXC2AM5OKpndzgn1RjQnNLm9DuEReosn4EhiHd7pDiEhKmTmk6FmgFYTeDaXnOW
         t9tQ==
X-Gm-Message-State: APt69E2bOTxTi3lEK5EKzdBwXhrEJnSnBrhs5x0GO55CHtqpxpcc2X9U
        SJERVolsYlWQF69/1gqzDR50Jqxkm+HdR+3HAEE=
X-Google-Smtp-Source: AAOMgpcapsw70ynejm33j6+yiSLRm1O0yvylPk0Kbl2i2364naFqI2wO7/hUT4774v0OsqMxCDJpNDJ1p8MSMtDm8dg=
X-Received: by 2002:ab0:15ad:: with SMTP id i42-v6mr3005286uae.199.1530085762623;
 Wed, 27 Jun 2018 00:49:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2310:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 00:49:22
 -0700 (PDT)
In-Reply-To: <CAPig+cTwwuqPgF2NtGRgpcdjFqJK22+FFDV2c-20oQXFLEPaWQ@mail.gmail.com>
References: <20180607050845.19779-1-newren@gmail.com> <20180627073623.31725-1-newren@gmail.com>
 <20180627073623.31725-2-newren@gmail.com> <CAPig+cTwwuqPgF2NtGRgpcdjFqJK22+FFDV2c-20oQXFLEPaWQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 27 Jun 2018 00:49:22 -0700
Message-ID: <CABPp-BFkjF5z6axqW-v=zPq9U9sOQGpUKK+WvLknkkGzX-F4rA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t3418: add testcase showing problems with rebase
 -i and strategy options
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 27, 2018 at 12:45 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 27, 2018 at 3:36 AM Elijah Newren <newren@gmail.com> wrote:
>> We are not passing the same args to merge strategies when we are doing an
>> --interactive rebase as we do with a --merge rebase.  The merge strategy
>> should not need to be aware of which type of rebase is in effect.  Add a
>> testcase which checks for the appropriate args.
>>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
>> @@ -74,6 +74,38 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
>> +test_expect_failure 'rebase -i --continue handles merge strategy and options' '
>> +       rm -fr .git/rebase-* &&
>> +       git reset --hard commit-new-file-F2-on-topic-branch &&
>> +       test_commit "commit-new-file-F3-on-topic-branch-for-dash-i" F3 32 &&
>> +       test_when_finished "rm -fr test-bin funny.was.run funny.args" &&
>> +       mkdir test-bin &&
>> +       cat >test-bin/git-merge-funny <<-EOF &&
>> +       #!$SHELL_PATH
>> +       echo "\$@" >>funny.args
>> +       case "\$1" in --opt) ;; *) exit 2 ;; esac
>> +       case "\$2" in --foo) ;; *) exit 2 ;; esac
>> +       case "\$4" in --) ;; *) exit 2 ;; esac
>> +       shift 2 &&
>> +       >funny.was.run &&
>> +       exec git merge-recursive "\$@"
>> +       EOF
>> +       chmod +x test-bin/git-merge-funny &&
>> +       (
>> +               PATH=./test-bin:$PATH
>
> Broken &&-chain (in subshell).
>
>> +               test_must_fail git rebase -i -s funny -Xopt -Xfoo master topic
>> +       ) &&
>> +       test -f funny.was.run &&
>> +       rm funny.was.run &&
>> +       echo "Resolved" >F2 &&
>> +       git add F2 &&
>> +       (
>> +               PATH=./test-bin:$PATH
>
> Ditto.
>

I'm just trying to prove how important your other patch series is.  ;-)

Doh, sorry for the mistake.  Again.  I'll fix it up.
