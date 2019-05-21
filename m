Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F2651F462
	for <e@80x24.org>; Tue, 21 May 2019 11:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfEULtb (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 07:49:31 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34707 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfEULtb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 07:49:31 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so29007034eda.1
        for <git@vger.kernel.org>; Tue, 21 May 2019 04:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=x1gCu+bHjAFwchU3MGr20td9SKbCYAUR79AUWZ662Nk=;
        b=Iu+hdyIXmFlCMkHiqx7wyFAtB/8oKw0jwNnr9mqvFwt7lPrQydNR52GTCJqqBEhErH
         Da+cp8w66NSgtPWNsV24NDpF2e5ev7+5dOxJ7/2eDofrryY1hzyT3x72hog29O3fBaLm
         aeKMawu/5KgHWXmj3/QI2XNstVdVMhzBUtFagN30DVbnLiB9vVBZWCbpn0Nq0nkpuWzc
         aVUOhT0zKUrQ9dJ9/rMRQEfWK4gU6DARNIDJ8CcJ+RrsTmrXyuSqyaRj3RyHwpfap/1p
         CVS/ZQAIJBtdg34MQr0uQCBFURhY6o9yVMqXrvrNcOWvMlP9rK2F4OsXr5Lwm2AuydwS
         EfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=x1gCu+bHjAFwchU3MGr20td9SKbCYAUR79AUWZ662Nk=;
        b=sWaWFiCJsYLAIvdvTW6mtyBFTtR95jIiBVcplRd6brSpYnQvLmX4R3ss1uWTiEc/C0
         u/fNp/AiHE0G9qoR8MzDYbnyUYRxW2iVhoq3UJSA+ncuvZJZXeedp67vFOZNazOUe1qS
         URMhqRX3BIdVStZqLyASsI9jB2FuwYGWhcAePcyESiHVITSUm4U+Z32tzB4fiCCnT6o3
         12GH3IKKrQqmnJfjtUHBHXpM1kJGA3MdvB/k+o0k4ZeeSyvHux16VPG//fpTo/mXRR1T
         OOadK58cAxtoyBLDt1jH+ylAUWr3jKvhZQPoCKKf6D35qteWiez8OY8A3DaYX/MWO/tw
         XTbQ==
X-Gm-Message-State: APjAAAUZ4wJY2IL2vUlAtOurX27qbt5VW3RakTgGGrNhKHF40pHPscKD
        H6CY50W5tjHcU/M+q7xMFYTlUHRioSU=
X-Google-Smtp-Source: APXvYqyJfwsYsgdgjvQSh3LPM42GGATLIiHTAbA0mhpQyOpDRBAxInvvfZiSQTVVqzWUuGROeSXf5A==
X-Received: by 2002:a50:f706:: with SMTP id g6mr32089898edn.187.1558439370022;
        Tue, 21 May 2019 04:49:30 -0700 (PDT)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id n55sm6132622edd.93.2019.05.21.04.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 04:49:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [Breakage] 2.22.0-rc1 - t0211-trace2-perf.sh
References: <019e01d50fc2$324bd400$96e37c00$@nexbridge.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <019e01d50fc2$324bd400$96e37c00$@nexbridge.com>
Date:   Tue, 21 May 2019 13:49:28 +0200
Message-ID: <87a7fguiwn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 21 2019, Randall S. Becker wrote:

> Hi All,
>
> On the NonStop platform, the entire test for t0211-trace2-perf.sh does not
> work. The first case, in verbose, reports:
>
> We get errors when the script is run:
>
> Use of uninitialized value within @tokens in pattern match (m//) at
> t0211/scrub_perf.perl line 29, <> line 1.

Could you intrument that test top "cat" the raw trace.perf you get?

That's some bug in the perl side of the parsing.

But the real bug looks like the trace2 code unconditionally depending on
pthreads, even though NonStop has 'NO_PTHREADS = UnfortunatelyYes'
defined.

That's why we get this th%d:unknown stuff, the trace2/tr2_tls.c code
using pthreads is failing with whatever pthread-bizarro NonStop has.

That seems easy enough to "fix", just always fake up "main" if we don't
have pthreads, but perhaps Jeff H. has another opinion on it...

> Initialized empty Git repository in /home/git/git/t/trash
> directory.t0211-trace2-perf/.git/
> expecting success:
>         test_when_finished "rm trace.perf actual expect" &&
>         GIT_TR2_PERF="$(pwd)/trace.perf" test-tool trace2 001return 0 &&
>         perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
>         cat >expect <<-EOF &&
>                 d0|main|version|||||$V
>                 d0|main|start||_T_ABS_|||_EXE_ trace2 001return 0
>                 d0|main|cmd_name|||||trace2 (trace2)
>                 d0|main|exit||_T_ABS_|||code:0
>                 d0|main|atexit||_T_ABS_|||code:0
>         EOF
>         test_cmp expect actual
>
> --- expect      2019-05-21 10:38:47 +0000
> +++ actual      2019-05-21 10:38:47 +0000
> @@ -1,5 +1,5 @@
> -d0|main|version|||||2.22.0.rc1
> -d0|main|start||_T_ABS_|||_EXE_ trace2 001return 0
> -d0|main|cmd_name|||||trace2 (trace2)
> -d0|main|exit||_T_ABS_|||code:0
> -d0|main|atexit||_T_ABS_|||code:0
> +d0|th01:unknown|version|||||2.22.0.rc1
> +d0|th02:unknown|start||_T_ABS_|||_EXE_ trace2 001return 0
> +d0|th03:unknown|cmd_name|||||trace2 (trace2)
> +d0|th04:unknown|exit||_T_ABS_|||code:0
> +d0|th06:unknown|atexit||_T_ABS_|||code:0
>
> Our perl is v5.24.0 and this cannot be upgraded.
>
> Thoughts?
>
> Randall
>
> -- Brief whoami:
>  NonStop developer since approximately 211288444200000000
>  UNIX developer since approximately 421664400
> -- In my real life, I talk too much.
