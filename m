Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72390200B9
	for <e@80x24.org>; Thu,  3 May 2018 21:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeECVTn (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 17:19:43 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:40764 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbeECVTm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 17:19:42 -0400
Received: by mail-yw0-f172.google.com with SMTP id p144-v6so6104356ywg.7
        for <git@vger.kernel.org>; Thu, 03 May 2018 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e3qRYoCYEsECwVeNHhvMzrQ0J/rlXPoimFFs2wgNlB4=;
        b=R6kBUIh99FpcXrgUql7hq2RAIMw8HuoPyaN+31CyH3j6uzik4PZZv9k9TAzCy+7vTM
         JKySp3Iz6QXGk4b66VWeRJSum99VmivpZ1NwtCz3qtWvVDX9g1AVAY1yjuPcaFC6bB7q
         xjUg8zSxdvqeCbUFCjw9VVTlpHhPqMD749pU44McJnhOPlFBfMKvTeT/OEbd35ozHuRB
         EMRcRlxGkX/SE8HO8K0L+4djQYBDbiAWXPpr7bZnXhPEzmFA1dN5liiGh//dCdYhhZSw
         fKQJwjBJk4nrira3y6nqVke3DKsefCOBD4KAP+E5l07Gy3yenI5nllAk7srPV7GWXMfy
         es/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e3qRYoCYEsECwVeNHhvMzrQ0J/rlXPoimFFs2wgNlB4=;
        b=Y6JBu+flRXb6snxlDQrFhPeHGxjfek56q5xiEBtrJP8vWIVaponaVgNE2mbhi4rO3d
         rcNpJIZr+HNZZQ3CTDWmIcGavo1kC27UktHo32crAmJs7+NTIL9ILbcRQD4TAWAFbu5C
         5vmkkmnjQkR9vwnQZ3MavkWy3xJ2iwNLKUR8C73KF0GbCoNVAiEqBt3fHbQW1df+W9fa
         oGG9nFIikTYvBJj7QNicdZFahVySdo9zG87xzkuNRA7TxaBQp4+EqW47vsTsohVNN3eg
         uWoR11IWSnYPmiiHNaicnyZJCVn8dqwaBCLiGfnC9aA7vlWySOxcG/jUTDqd/Ss80Awa
         JnbQ==
X-Gm-Message-State: ALQs6tCC5oxXlG+7ddFdaKM7w5ort7d7nCFbY1tSBOIGX/SuDwDeZc1Y
        iR+sj/nM6+RzqSB4CDBSqYuxg3UFvJhRDphmTic7Tw==
X-Google-Smtp-Source: AB8JxZpvx41XVwFV5mPU3++hA8k2/rTfbNEyYL/pyZVXZgGvW1SD43pZVF/Gn4g6OOeZznDs+jvaKyNqqiUbNYtz6JA=
X-Received: by 2002:a0d:e28e:: with SMTP id l136-v6mr14164489ywe.500.1525382381314;
 Thu, 03 May 2018 14:19:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Thu, 3 May 2018 14:19:40 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1805032246040.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <ec51c71779a325263c1b705a6b1bfb003fcd528a.1525361419.git.johannes.schindelin@gmx.de>
 <CAGZ79kYzZkdZKdR4hMK0V6D6=cm4damct01MGidGA0g-dtW+gQ@mail.gmail.com> <nycvar.QRO.7.76.6.1805032246040.77@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 May 2018 14:19:40 -0700
Message-ID: <CAGZ79kZQ+mq1O_sL11jC4_Lt18nO6b_6pSPBahOqyZ+izrRm7w@mail.gmail.com>
Subject: Re: [PATCH 03/18] branch-diff: first rudimentary implementation
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> To be honest, the main reason I spawn here is that I did not want to be
> bothered with resetting the commit flags after traversing the first commit
> range. But I guess I was just too cheap and should really do it?

Oh right, you'd have to do multiple revision walks.

> OTOH spawning here is a lot easier than not spawning, so maybe it would be
> premature optimization?

Most likely.

>
>> In addition to that patch, we'd have to buffer commit messages
>> and buffer multiple commits, as that only buffers a diff of a single
>> commit.
>
> ... and make sure that the moved-code logic (which is currently the only
> user of emitted_symbols, correct?) would never be called at the same time
> as we generate the diff.

The moved detection is all part of the flags of an emitted symbol.

By design the emitted symbol has easy access to the raw line of the output,
which made it easy for the move detection to work on the lines. AFAICT this
is also desired here as lines are put into a hashmap for comparisons.
(and having it colored differently would make finding the same line
complex using hashmaps)

I just entertain the thought of having move detection active in a
branch-diff. That would be really cool actually.

>
>> The benefit would be no invocation of new processes, letting us
>> do more in core. This would allow for tweaking revision walking
>> internally, e.g. passing of options to this command such as rename
>> detection factors, can be passed through easily without the need
>> of translating it back to the command line.
>
> On the other hand, we can simply copy those options to the command-line
> for `log`. Which might even be better, as e.g. `--format` changes global
> state :-(

ok.

Thanks for your patience,
Stefan
