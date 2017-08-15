Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 036FC208C4
	for <e@80x24.org>; Tue, 15 Aug 2017 17:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbdHORfD (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 13:35:03 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:35542 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753220AbdHORfC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 13:35:02 -0400
Received: by mail-yw0-f170.google.com with SMTP id l82so8746494ywc.2
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 10:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fYB2fIl2JJ1u7ArxOMITzFOsj9Sac8agHxiLCOj9OIM=;
        b=EMfLwmnQkIt0M3Q8vndw8pv0gxIAymoaAxXg8+kRjr62Ad8abwc4YFhkccRb0j8lQD
         6Pcp002ROgqxWByiWCuqhkOR/dxNy17K7jj4QVyXXjRIaHaUiQOyi/Acw/gOA8Cl27dy
         Kx7bDUJ7DQzT9nfnETyCJsNfY+uf60BoLwuX+FgvSmOaGkexN6AssGGruYBuJWsZW1XK
         SWZbIMCCjZbTKki8HjF8FOLOP+CbHnXvx2SvO2CJWXd50Ib0xLn7VzadXGsRz2NYpty8
         G6KRCpr8EKISFLHAYPX/jVLSZ932Na4XQD+hNm2u8cloEX6S60fZ+Nvu6mAMsK2jWA0o
         1Nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fYB2fIl2JJ1u7ArxOMITzFOsj9Sac8agHxiLCOj9OIM=;
        b=jqLY6+i5HTmvMT+eHxRzeG1666D/6oE00H4ibIbCU9/q8p60wf9FxbVjHGiPU/GGuW
         j4b688ig2oopCjnFn5OoIIQ1Xj8+z7ngWEXVksMos4WFncjWp06NC9wjUKADmJ7E92cK
         u2iOAva0lrK6sA1L8nMD7qSoDWPgJOEeu65SIbWJaCfbYYy8ERWHvT3KkS/yHH90881e
         Yc6/ksxZi181T/iOt4eMMAt2F+/9IBaFi0XAJem7vvYluneQGFfGEJCQ58SPRQ6CBPHc
         on1VHf+ogyeWE+UfdsbrVceA/uCY5bdRYIt9EGDHvH7Hvyadiu5ztraayiROZppIdy17
         Q8ZA==
X-Gm-Message-State: AHYfb5gW6CbOMRrFidO1XWo3p4vHoJ5/aCq+/ALXdlHg7V0wclaUET7K
        mkCrMOwgUuVoqpOPuh1JX/ReFT+47CDUK7N54Q==
X-Received: by 10.129.93.194 with SMTP id r185mr16942499ywb.33.1502818501149;
 Tue, 15 Aug 2017 10:35:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Tue, 15 Aug 2017 10:35:00 -0700 (PDT)
In-Reply-To: <939b37f809dd9e1526593c02154fae14b369c73a.1502780344.git.martin.agren@gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com> <939b37f809dd9e1526593c02154fae14b369c73a.1502780344.git.martin.agren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Aug 2017 10:35:00 -0700
Message-ID: <CAGZ79kYbPvmqV1PR_NjxLbp2vqC6=JdP+-hzdwQvUmVLZU_Wtg@mail.gmail.com>
Subject: Re: tsan: t5400: set_try_to_free_routine
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 5:53 AM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> Using SANITIZE=3Dthread made t5400-send-pack.sh hit the potential race
> below.
>
> This is set_try_to_free_routine in wrapper.c. The race relates to the
> reading of the "old" value. The caller doesn't care about the "old"
> value, so this should be harmless right now. But it seems that using
> this mechanism from multiple threads and restoring the earlier value
> will probably not work out every time. (Not necessarily because of the
> race in set_try_to_free_routine, but, e.g., because callers might not
> restore the function pointer in the reverse order of how they
> originally set it.)
>
> Properly "fixing" this for thread-safety would probably require some
> redesigning, which at the time might not be warranted. I'm just posting
> this for completeness.

Maybe related read (also error handling in threads):
https://public-inbox.org/git/20170619220036.22656-1-avarab@gmail.com/

>
> Martin
>
> WARNING: ThreadSanitizer: data race (pid=3D21382)
>   Read of size 8 at 0x000000979970 by thread T1:
>     #0 set_try_to_free_routine wrapper.c:35 (git+0x0000006cde1c)
>     #1 prepare_trace_line trace.c:105 (git+0x0000006a3bf0)
>     #2 trace_strbuf_fl trace.c:185 (git+0x0000006a3bf0)
>     #3 packet_trace pkt-line.c:80 (git+0x0000005f9f43)
>     #4 packet_read pkt-line.c:309 (git+0x0000005fbe10)
>     #5 recv_sideband sideband.c:37 (git+0x000000684c5e)
>     #6 sideband_demux send-pack.c:216 (git+0x00000065a38c)
>     #7 run_thread run-command.c:933 (git+0x000000655a93)
>     #8 <null> <null> (libtsan.so.0+0x0000000230d9)
>
>   Previous write of size 8 at 0x000000979970 by main thread:
>     #0 set_try_to_free_routine wrapper.c:38 (git+0x0000006cde39)
>     #1 prepare_trace_line trace.c:105 (git+0x0000006a3bf0)
>     #2 trace_strbuf_fl trace.c:185 (git+0x0000006a3bf0)
>     #3 packet_trace pkt-line.c:80 (git+0x0000005f9f43)
>     #4 packet_read pkt-line.c:324 (git+0x0000005fc0bb)
>     #5 packet_read_line_generic pkt-line.c:332 (git+0x0000005fc0bb)
>     #6 packet_read_line pkt-line.c:342 (git+0x0000005fc0bb)
>     #7 receive_unpack_status send-pack.c:149 (git+0x00000065c1e4)
>     #8 send_pack send-pack.c:581 (git+0x00000065c1e4)
>     #9 git_transport_push transport.c:574 (git+0x0000006ab2c1)
>     #10 transport_push transport.c:1068 (git+0x0000006ae5d5)
>     #11 push_with_options builtin/push.c:336 (git+0x00000049d580)
>     #12 do_push builtin/push.c:419 (git+0x00000049f57d)
>     #13 cmd_push builtin/push.c:591 (git+0x00000049f57d)
>     #14 run_builtin git.c:330 (git+0x00000040949e)
>     #15 handle_builtin git.c:538 (git+0x00000040949e)
>     #16 run_argv git.c:590 (git+0x000000409a0e)
>     #17 cmd_main git.c:667 (git+0x000000409a0e)
>     #18 main common-main.c:43 (git+0x0000004079d1)
>
>   Location is global 'try_to_free_routine' of size 8 at 0x000000979970 (g=
it+0x000000979970)
>
>   Thread T1 (tid=3D21405, running) created by main thread at:
>     #0 pthread_create <null> (libtsan.so.0+0x000000027577)
>     #1 start_async run-command.c:1130 (git+0x0000006582e7)
>     #2 send_pack send-pack.c:562 (git+0x00000065b7c8)
>     #3 git_transport_push transport.c:574 (git+0x0000006ab2c1)
>     #4 transport_push transport.c:1068 (git+0x0000006ae5d5)
>     #5 push_with_options builtin/push.c:336 (git+0x00000049d580)
>     #6 do_push builtin/push.c:419 (git+0x00000049f57d)
>     #7 cmd_push builtin/push.c:591 (git+0x00000049f57d)
>     #8 run_builtin git.c:330 (git+0x00000040949e)
>     #9 handle_builtin git.c:538 (git+0x00000040949e)
>     #10 run_argv git.c:590 (git+0x000000409a0e)
>     #11 cmd_main git.c:667 (git+0x000000409a0e)
>     #12 main common-main.c:43 (git+0x0000004079d1)
>
> SUMMARY: ThreadSanitizer: data race wrapper.c:35 set_try_to_free_routine
>
