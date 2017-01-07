Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE7F20756
	for <e@80x24.org>; Sat,  7 Jan 2017 23:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755680AbdAGX0b (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 18:26:31 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35673 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755669AbdAGX03 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 18:26:29 -0500
Received: by mail-lf0-f67.google.com with SMTP id v186so2652557lfa.2
        for <git@vger.kernel.org>; Sat, 07 Jan 2017 15:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MBq8TJLgmU+Ks9OZ0oiwhp8Yt1EfMGkDn61I4+CGZpg=;
        b=ZSyLRG/qrL+IcTkdSYmWcs9ToyzwhvJa8aRCCJvINaYnSxvV8vuGu95a/PtGPtamFy
         n2kvUu3dppcPQhLJ7/w6hLjw0DelP31teScMLe5rt/pOrm+DCjwPZmxyv1nnn2U5/jn5
         lKAQqATXWTQmKDBdgy2JFfQV52aqmkehINICq6ZhK+PmaO62ZTm3eIgraJdRbogMy+aF
         ciNy7E2JNu7X5bzXXIRfBdOSSpwIyG1sAO0aIa+l3UCAqE9nj4Z04lLO2QU1QzzBzWol
         ikDHTswK1cPgTRZV54ej6vgcm6BuIbxylB+jxUMz1TLWhhzNyv/m7zCSYkWjlVaXYDwh
         0mCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MBq8TJLgmU+Ks9OZ0oiwhp8Yt1EfMGkDn61I4+CGZpg=;
        b=sg1z2wS/S88TbY0jKC5//UE134NrFKcNaA1W4zt18RQEXJtmB8Bht2mXTFXmYNaH8B
         DlRK9q21zFM6NwEHDnbHWAYCUAY7OgXdbND/4jwXgkPtbAClonRdgEl38rN5PaNcFBZg
         +y1o8DB3uj2rpVbQCTK2FLPU6dVr0MClpyTn2nTMRqlJggQ0DztapfWbMT0fXmnl1fvJ
         rLdkvJFECJ1/p0pl2DL0l39RqclmjJLJYmOS65CgmbmVztPQL2QKoOrry5P1kNwUMCyv
         Qv/8/2kGnF2T328lqkwAsJ6L1SIqtiwU38eDzsj55jvvfLFgtCdYfGzfAutJkSYiLM9N
         7j1Q==
X-Gm-Message-State: AIkVDXKAjZ2wtWt2APFV0Pitp4QGDXzKCZ0j0Dq75hFmWul8+8Kgcf1yxxqer7gV0zEC/Mx2LK/mK1wgaSn9pg==
X-Received: by 10.46.14.9 with SMTP id 9mr28017105ljo.59.1483831587511; Sat,
 07 Jan 2017 15:26:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.79 with HTTP; Sat, 7 Jan 2017 15:26:06 -0800 (PST)
In-Reply-To: <20170107011445.3e4fv6vdtimrwhgv@sigill.intra.peff.net>
References: <20170105142529.GA15009@aaberge.net> <20170106064032.eqxxer5mx5hsh2md@sigill.intra.peff.net>
 <20170106064752.iccrk656c6k2wrfy@sigill.intra.peff.net> <20170106072602.wkbzho5z3osz5hee@sigill.intra.peff.net>
 <20170106073224.5hsrib77tx5tgx7d@sigill.intra.peff.net> <3d433abf-71a2-4702-f62b-e254520dc32c@kdbg.org>
 <20170106194115.k5u5esv7t63mryvk@sigill.intra.peff.net> <2ed6f78b-7704-c724-c99b-e310c383c4e8@kdbg.org>
 <20170106232042.ptn6grtll5wpxhc4@sigill.intra.peff.net> <20170107011445.3e4fv6vdtimrwhgv@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 7 Jan 2017 15:26:06 -0800
Message-ID: <CA+P7+xqEqKWmQGgAyrmdzOZgO0CXFOGfcp=0otJ_nQPS13wFWg@mail.gmail.com>
Subject: Re: [PATCH 0/3] fix ^C killing pager when running alias
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>, Trygve Aaberge <trygveaa@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 6, 2017 at 5:14 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 06, 2017 at 06:20:42PM -0500, Jeff King wrote:
>
>> > In general, I think it is wrong to wait for child processes when a signal
>> > was received. After all, it is the purpose of a (deadly) signal to have the
>> > process go away. There may be programs that know it better, like less, but
>> > git should not attempt to know better in general.
>> >
>> > We do apply some special behavior for certain cases like we do for the
>> > pager. And now the case with aliases is another special situation. The
>> > parent git process only delegates to the child, and as such it is reasonable
>> > that it binds its life time to the first child, which executes the expanded
>> > alias.
>>
>> Yeah, I think I agree. That binding is something you want in many cases,
>> but not necessarily all. The original purpose of clean_on_exit was to
>> create a binding like that, but of course it can be (and with the
>> smudge-filter stuff, arguably has been) used for other cases, too.
>>
>> I'll work up a patch that makes it a separate option, which should be
>> pretty easy.
>
> Yeah, this did turn out to be really easy. I spent most of the time
> trying to explain the issue in the commit message in a sane way.
> Hopefully it didn't end up _too_ long. :)
>
> The interesting bit is in the third one. The first is a necessary
> preparatory step, and the second is a cleanup I noticed in the
> neighborhood.
>
>   [1/3]: execv_dashed_external: use child_process struct
>   [2/3]: execv_dashed_external: stop exiting with negative code
>   [3/3]: execv_dashed_external: wait for child on signal death
>
>  git.c         | 36 +++++++++++++++---------------------
>  run-command.c | 19 +++++++++++++++++++
>  run-command.h |  1 +
>  3 files changed, 35 insertions(+), 21 deletions(-)
>
> -Peff

I don't see the rest of the patches on the list..?

Thanks,
Jake
