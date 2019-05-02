Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 928731F453
	for <e@80x24.org>; Thu,  2 May 2019 12:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfEBMvW (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 08:51:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54799 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEBMvW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 08:51:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id b10so2658119wmj.4
        for <git@vger.kernel.org>; Thu, 02 May 2019 05:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ub5g8wVyUSb0cOX3T8/85PwIxr7+JVFIeZprsjy1Iw8=;
        b=cExplnt6AMkBx2Gh76nz9MbjGoTs9kQ9iJSUwPN0Gcyv8gBm2d5dTw7OnTxgjqrTAk
         poRvNhHpJSCVIlOlYkIq+4VmHn/h5fIUVl5GWRsUYdVs0S6LXn242XmV05PRdjtuHZ+4
         uLiTt+aSVgMIXQJRljD7xkOZvyVqCG1A3f1FzWRco9+1blMFP12kV2S0uSlA7rhAfLKF
         RWVbu+ZnMOKfQ2ge2eMmH5idQRE6e1AMO0tzq0QwdNdVLaykmpOR+h8wttDaP1ZsfFwm
         TdL+r3rvr5KBM+tIVo57H0+Ccx1hXJZthZPNQhsYChcoVHZLNtYrfErKUBgvaS1jamSR
         F+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ub5g8wVyUSb0cOX3T8/85PwIxr7+JVFIeZprsjy1Iw8=;
        b=D6o7kcBTOya2LQ/Fhj4TVAvL/9qSYm2jX5/yp2aB/9NHyLORCgbqOCG7XXoHDWQGMv
         ivnpToum3CNTnT2kubggZo1Qhruq1TuVT/HXqiEZW8ObcQVHR7fbszHnR+Zf5HK13K1Z
         3hxhnXKgexZ2KLCeofinUupHdtTb1ybyxTtk2PDpb2xC6A6WhPqEQfnCHuM4+Wash4wd
         hQOtclswJbLD/dfrgAzvuBk2oBFLFHAFAJmnrJ7fJT2A+S1Z4FDwMYrxvKsihnSe1ENA
         VjMIbW30KPGOKqZ2OI8vQCLp8nhn+5PzlfQ9wNGsQIbCjvhHW/upChQqtTQvdc8v8BQk
         lv0Q==
X-Gm-Message-State: APjAAAUy4go4olt9vzF4HTdVLPXDB8rPOR+MRJtOTY9W8kfS01k85opa
        S/HREejVxtd8FbiTcOoEHeQ=
X-Google-Smtp-Source: APXvYqzqC1LB2Rx65zgCIf6RNijj6yWcOhAVyC0jfXXW61td0rUeXL6MVDAvI3rCaOndxpJaRy/CCA==
X-Received: by 2002:a7b:c844:: with SMTP id c4mr2226686wml.108.1556801479732;
        Thu, 02 May 2019 05:51:19 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id 17sm309138wmu.16.2019.05.02.05.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 05:51:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     frank kulow <kulow.f@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: "git branch -f" corrupt other worktree
References: <CAA2qrhBmbSe5R0xQPBZiRcz0MGG=JcF4BjxHqmyeTFNR19FKbg@mail.gmail.com> <CACsJy8CJ_PB+QKp-T-yTHNPYgjEEVN39QbnAu4kKzGGcEQ0ezA@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8CJ_PB+QKp-T-yTHNPYgjEEVN39QbnAu4kKzGGcEQ0ezA@mail.gmail.com>
Date:   Thu, 02 May 2019 14:51:18 +0200
Message-ID: <87d0l1qat5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 02 2019, Duy Nguyen wrote:

> On Thu, May 2, 2019 at 6:59 PM frank kulow <kulow.f@googlemail.com> wrote:
>>
>> git version 2.21.0.windows.1
>>
>> > /c/tmp/gt (Branch_702091a0)
>> $ git worktree add ../wt master
>> Preparing worktree (checking out 'master')
>> HEAD is now at f534c32 4
>>
>> > /c/tmp/gt (Branch_702091a0)
>> $ git branch -D master
>> error: Cannot delete branch 'master' checked out at 'C:/tmp/wt'
>>
>> #but this is possible:
>>
>> > /c/tmp/gt (Branch_702091a0)
>> $ git branch -f master HEAD
>
> I admit I didn't see this. But I don't know how far we would go
> protecting other worktrees. You give --force and that usually means
> "Yes I know what I'm doing, don't stop me". If --force rejects in this
> case, what would be the real force, --force --force maybe, or fall
> back to "git update-ref"?
>
>>
>> #and the other worktree is now corrupted:
>>
>> > /c/tmp/wt (master)
>> $ git status
>> On branch master
>> Changes to be committed:
>>   (use "git reset HEAD <file>..." to unstage)
>>
>>         modified:   txt.txt
>>         deleted:    txtb.txt
>>
>>
>>
>> greetings f.kulow

Part of this is "doctor, it hurts when I stab my eye" :) but I wonder in
general whether users are more likely to expect different worktrees to
have different views of the refstore, since they way they're created is
"I want just this branch over there".

I.e. whether they want something closer to another directory with
"alternates" pointing to the "main" repo, and whether that should be
promoted to UI that's easier to set up than it is now.

Or maybe something in-between, where they'd expect remote tracking refs
to update for everything, but a worktree's "master" branch not to be
touchable by a worktree on "topic".

