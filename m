Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD31320323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbdCVWHt (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:07:49 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35833 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751299AbdCVWHr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:07:47 -0400
Received: by mail-pf0-f177.google.com with SMTP id 20so49073852pfk.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 15:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XyGbLGiGfIv1RNGuA6JpuSiMcqlpf3etNAk4oSZUruM=;
        b=PTuqwv35Kot8xl87pSW3azqFQH9gI9m1cDoSfsIBOKCRESjuXsyIYdT3CoZRZ+tzeh
         30XzkHzLFbR2SR/k++SuXghXo3xb2ypAXlyyn9v+PwahzK80g3ocxrLCwZjnSJkKk106
         1BjmR7Vg5/0gym8+njTy4/dJxu38eMh7YeDqpd+EgdaT86/LFzM8UgngnQewqTz8TD1m
         F3CuQV1vtGJLQufMM1/pLNKMx+TkCg0yF6w2U+VAMHTiFQOcrp+WOlt51PMzPsRAT58r
         yGKyqfdFD0mFzz5dOKocAkDEXrw+DG5gU5fyQy6i45JQhFklGkLEIqohKrZxpFyy8t9b
         D8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XyGbLGiGfIv1RNGuA6JpuSiMcqlpf3etNAk4oSZUruM=;
        b=SAgerQ+NoBYOR1gD4XeFzMQlOWKQIsZLTapUbr9zyFir65iyZIKLYpHNxsp9exNII/
         +Xj+FckkDdppr9fq6Lnd7rw+uuakYuaptkqvMGq6uKPcHvMbm7SMTrHUdER47WKRSBjP
         jXozYnOYlYNZhcu7WkMz3J4pKB4wm2Xhlbzn2Ak1M6ycUM/GPqmgiZsbjWo/1w79/zxa
         tUXGLTIiaKZeTEKkXWi7c7f70bm882DxIbcGJY68fzWiC5nmwTBhXI/ll77IlMCHlY+N
         zXCE3F4SIOX0KitJhR85uRHq4Uy+52/F98aK8VLZasYpEkd3QQCA3MBuLS8+hLWUB/H3
         1GiQ==
X-Gm-Message-State: AFeK/H0deSSQx9q/W6tTISVxM4GnuT/L68gRMFCYVtm9Vjudwj/NAOYQkxl8CM/oqxCSTkPaWD2deTEnMzTbveZB
X-Received: by 10.99.211.21 with SMTP id b21mr8770338pgg.48.1490220465937;
 Wed, 22 Mar 2017 15:07:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Wed, 22 Mar 2017 15:07:45 -0700 (PDT)
In-Reply-To: <20170322215951.f4xbxehzvsd64c4y@sigill.intra.peff.net>
References: <20170322213953.oddbgw5nfrvmzjgm@sigill.intra.peff.net>
 <20170322214948.12015-1-sbeller@google.com> <20170322215951.f4xbxehzvsd64c4y@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Mar 2017 15:07:45 -0700
Message-ID: <CAGZ79kbFjCQB_k8E1dMVop_EGF6TpnY04U1NV60VmSs1zHOnZw@mail.gmail.com>
Subject: Re: [PATCH] t7406: correct test case for submodule-update initial population
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jan Palus <jan.palus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 2:59 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 22, 2017 at 02:49:48PM -0700, Stefan Beller wrote:
>
>> * The syntax of the here-doc was wrong, such that the entire test was
>>   sucked into the here-doc, which is why the test succeeded successfully.
>
> As opposed to succeeding unsuccessfully? :)
>
>> * The variable $submodulesha1 was not expanded as it was inside a single
>>   quoted string. Use double quote to expand the variable.
>
> Hmm. Sort of. It was inside a non-interpolating here-doc inside a
> single-quoted string which was being eval'd. The second half is fine
> (the eval adds an extra layer of evaluation).
>
> Your fix:
>
>> +     cat >expect <<-\EOF &&
>> +     Execution of '\'"false $submodulesha1"\'' failed in submodule path '\''submodule'\''
>> +     EOF
>
> _does_ work, but it does so because it's evaluating $submodulesha1 in
> the shell snippet and handing the result off to test_expect_success to
> eval. So it would have problems if:
>
>   - that variable contained "\nEOF\n" itself ;)
>
>   - the variable was modified inside the shell snippet.
>
> Neither of those is true, but I think:
>
>   cat >expect <<-EOF &&
>   Execution of '\''false $submodulesha1'\'' failed in ...
>   EOF
>
> is safer and less surprising. The single-quote handling is unfortunate and
> ugly, but necessary to get them into the shell snippet in the first
> place. I notice the others tests in this script set up the expect file
> outside of a block. You could also do something like:
>
>   sq=\'
>   test_expect_success '...' '
>         cat >expect <<-EOF
>         Execution of ${sq}false $submodulesha1${sq} ...
>   '
>
> but I'm not sure if that is any more readable.
>

If I recall correctly, I made a big fuss about single quotes used correctly when
writing that patch (which is why I may have lost track of the actual work there)
to be told the one and only blessed way to use single quotes in our test suite.

Your proposal to use ${sq} sounds good to me, though we did not
follow through with it for some other reason. I can reroll with that, though.

Thanks,
Stefan
