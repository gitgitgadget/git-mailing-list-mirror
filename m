Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3E11F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 19:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbeGKTSN (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 15:18:13 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:42219 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGKTSN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 15:18:13 -0400
Received: by mail-vk0-f67.google.com with SMTP id t4-v6so14925763vke.9
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 12:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g3EGbElSjmUlvO+GeqJU6WD+ONbl9L/e+5ezs/GLEUg=;
        b=hxCLZ6WzJgRlzKMw3eaUyAKKHq4BPbN/EzNsOlpUGCAzRiTHqY/PWXrfsEXqPHAIB0
         ggjLj1YuG0R4RuMnIXg5szerPdFoF8UMMIOJMbl0XOcpATZm5yMWxf7zFl+nsoaiO+/q
         y5jv5CEg1OPsVpbcEM7zzoqHpCpLoXJtFAUHe/8y31o/mrhcYNUwZotZcjy69+VCaqYv
         Y79kR5gsGGtWhiPxK4y7UUU5xrVVhtn5dJdpDbcbDAgOcWp/ztC6sztrga0zVQ+IGwCh
         gZMX4UQVQwCk9m0j6lCSu/6ppejk1KwWtpALUyifEdpqr0xfFHzrBfwipGxsqUU4GxPe
         jJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g3EGbElSjmUlvO+GeqJU6WD+ONbl9L/e+5ezs/GLEUg=;
        b=jegTYYvSRn0HVUkQveRSlD7XqbFa31Inl6EPhebAzSsusS+bYeydCVlFwGmDmtmqcP
         KPDy1O+nXrpeeEIg9wYZar1KevNgv8lgcDyhuMEAtd1tD7jz5707cTAowoGkHiotWSyN
         LPk6/PRuWAnfU0ctvbituo82jnY9UCFWQxKs7pWzUAdkPcOXaJhTacR2yWC6IKrIRsHI
         prupFatQvmZ2c/NvnS55748jrW7hX9WbV69HiXVhZyJTAMJW0TEaMBSTMDWxT7bVm37j
         ElXJ55brPASohUM9K9Nu8kMBiK6gVcG3wwkpVj4r64swdbm4WpCw6VPDVck1ea5KzBWc
         UiKg==
X-Gm-Message-State: APt69E1tGtD7eEwsLAjU1u3/gyCQqtcxb7czEE/z08jkYk8xcjzAEhHz
        k63LrnZDIWxxDcVUPx3h3UEEL0ACFDE4HRNWlpg=
X-Google-Smtp-Source: AAOMgpdKF+cFbP1nxT8vBfcY/Nxf0IyIw/bLPqW6xnh4a9zZCG0G9IOU3OR6oX7L7ydo35/QT/CovejuRTY70gtodgg=
X-Received: by 2002:a1f:41d4:: with SMTP id o203-v6mr17423396vka.149.1531336350571;
 Wed, 11 Jul 2018 12:12:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 12:12:30
 -0700 (PDT)
In-Reply-To: <CAM0VKj=rGHm3V_z4S6NNP2-fjyfrgrLz-bWrZ8t0gcVD-gTq_w@mail.gmail.com>
References: <20180627073623.31725-1-newren@gmail.com> <20180627154804.3743-1-newren@gmail.com>
 <20180627154804.3743-2-newren@gmail.com> <20180627182805.28375-1-szeder.dev@gmail.com>
 <CAM0VKj=rGHm3V_z4S6NNP2-fjyfrgrLz-bWrZ8t0gcVD-gTq_w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Jul 2018 12:12:30 -0700
Message-ID: <CABPp-BF_HDW-ie1ZaTrnniWuE7FxThiukk0xJ7P5rfUiwXBGug@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] t3418: add testcase showing problems with rebase
 -i and strategy options
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

HI SZEDER,

On Wed, Jul 11, 2018 at 3:56 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> On Wed, Jun 27, 2018 at 8:28 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>>
>> > diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
>> > index 03bf1b8a3b..11546d6e14 100755
>> > --- a/t/t3418-rebase-continue.sh
>> > +++ b/t/t3418-rebase-continue.sh
>> > @@ -74,6 +74,38 @@ test_expect_success 'rebase --continue remembers me=
rge strategy and options' '
>> >       test -f funny.was.run
>> >  '
>> >
>> > +test_expect_failure 'rebase -i --continue handles merge strategy and =
options' '
>> > +     rm -fr .git/rebase-* &&
>> > +     git reset --hard commit-new-file-F2-on-topic-branch &&
>> > +     test_commit "commit-new-file-F3-on-topic-branch-for-dash-i" F3 3=
2 &&
>> > +     test_when_finished "rm -fr test-bin funny.was.run funny.args" &&
>> > +     mkdir test-bin &&
>> > +     cat >test-bin/git-merge-funny <<-EOF &&
>> > +     #!$SHELL_PATH
>> > +     echo "\$@" >>funny.args
>> > +     case "\$1" in --opt) ;; *) exit 2 ;; esac
>> > +     case "\$2" in --foo) ;; *) exit 2 ;; esac
>> > +     case "\$4" in --) ;; *) exit 2 ;; esac
>> > +     shift 2 &&
>> > +     >funny.was.run &&
>> > +     exec git merge-recursive "\$@"
>> > +     EOF
>> > +     chmod +x test-bin/git-merge-funny &&
>>
>> You could use the 'write_script' helper function here.
>>
>> > +     (
>> > +             PATH=3D./test-bin:$PATH &&
>> > +             test_must_fail git rebase -i -s funny -Xopt -Xfoo master=
 topic
>> > +     ) &&
>> > +     test -f funny.was.run &&
>
> And please use 'test_path_is_file' here ...
>
>> > +     rm funny.was.run &&
>> > +     echo "Resolved" >F2 &&
>> > +     git add F2 &&
>> > +     (
>> > +             PATH=3D./test-bin:$PATH &&
>> > +             git rebase --continue
>> > +     ) &&
>> > +     test -f funny.was.run
>
> ... and here.
>

Thanks for looking over things.  This particular test was a copy of
another from the same file, just for rebase -i instead of rebase -m.
I think it'd be nice to keep the two tests looking similar and either
fix up the rebase -m case with a preparatory patch added to this
series, or wait for this series to merge and let a future series clean
up both testcases.  For other suggested fixups to the same test, Junio
suggested just taking the latter approach[1], so I'm assuming that's
how I should handle these as well.

[1] https://public-inbox.org/git/xmqqmuvgdods.fsf@gitster-ct.c.googlers.com=
/
