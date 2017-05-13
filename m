Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F323520188
	for <e@80x24.org>; Sat, 13 May 2017 19:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756016AbdEMTbe (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 15:31:34 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:33259 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755847AbdEMTbe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 15:31:34 -0400
Received: by mail-io0-f170.google.com with SMTP id p24so55863860ioi.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 12:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jf419kDr7nWjEdmuXwwmMy198DuGYfeOJdunqeR1U2c=;
        b=qAMe8RI92Asg2xFiNb/FtK9nJorNvfj5SmvEnO2LsKUcAG1t4SE8oD625kXxAdH4cJ
         LgSe45vnZV3yXVva5U+m3XN1EHrn6BPBiOqzUKn+81l9XYU3wh3LkYD31ZeBaLcMJvv/
         6HP3JrBUShPac7TNFrvWxiZMq6rrs2Vzrdzg/FUlmgS+R2ObILgdmQUI8IHL1Nxr549L
         nqNNrhpekZN+EWcIb/B4RCQIiQ8MvxbdhxKpzw0WFzwXmGLAzxzGo1rUW1I/nqIpHRpD
         hUjZD+GGr0o8lPsRhuiLIqVvIG9OXrC6LhKxUTpCMmEAxqXunJbK45GJYVpzcTG5XlsH
         MOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jf419kDr7nWjEdmuXwwmMy198DuGYfeOJdunqeR1U2c=;
        b=pta/IOfQgf28dqSv+i3mHp1x8A3Z7J2FjvTy/tRk6FzD+S6oSzTzN8BejCdG4xWh6R
         LrYJesnHMdFUuvrNvWx95AV3oHB4Mx2a505pSlen9pOYy3ijbSwLkfANp7XwOzbP3twP
         LW3PKbuluqAfgeUoMLoMsbWGX0xVjKK4IEi7ARnbuGiPuQCmqcC7jXew7BNyhF4HUxbu
         oj/qquD6BFiaw0ykJwSnCvvvKBZ9Unw1XiemMs8BfviYBjSdQZvsyaCy+0GPPX57QYum
         SKjAdgI9nNgbXP/Xt5zesaTMRKs7pQHG0GiEAqMfPDBk28W1UKZFMDInxqRR4s5pM4nz
         pRaw==
X-Gm-Message-State: AODbwcBhey1WVKXzeicIyebWpmV+dtVfEe5Q9THH9g9ltZDgwxCJna8K
        FLy6ANUu/kVo/cYqFlnCGmNl9/TXxw==
X-Received: by 10.107.138.21 with SMTP id m21mr9919133iod.80.1494703893164;
 Sat, 13 May 2017 12:31:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sat, 13 May 2017 12:31:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1705131251260.146734@virtualbox>
References: <6a6782863a74432094a1d7fba7f2477991ef2d16.1494510612.git.johannes.schindelin@gmx.de>
 <CACBZZX4UUwzRQmyH8joYaqHnuVTjVtGBHp+iZKcnAnwoM_ZJhg@mail.gmail.com> <alpine.DEB.2.21.1.1705131251260.146734@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 13 May 2017 21:31:12 +0200
Message-ID: <CACBZZX6Qx+oy83GjTOahUyHM4=gESzX+QNMLrY2DHgdYMo3cNw@mail.gmail.com>
Subject: Re: [PATCH] compat/regex: fix compilation on Windows
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 13, 2017 at 8:30 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi =C3=86var,
>
> I originally replied in a very verbose manner, going step by step through
> the "one-liner", but decided to rephrase everything.
>
> So here goes.
>
> On Sat, 13 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Let's drop this current gawk import series.
>
> Well, the reason why you imported the current gawk regex is that we (you?=
)
> decided originally that it'd be easier to go with that one rather than
> with the gnulib one (which they friendly-forked). If you switch to gnulib=
,
> I would like to see (in the commit message) the original reason we picked
> gawk (which forked gnulib's regex code, after all), and why that reason n=
o
> longer applies.

It was just easier to extract the code from gawk than gnulib at the
time. The thread starting at <20100715220059.GA3312@burratino> has
some details.

> I also would strongly prefer a *non* one-liner, in a commit message that
> adds the relevant source code from gawk or gnulib *verbatim*, followed by
> patches that adjust the code to Git's needs. That way, a future update ca=
n
> repeat the commands outlined in the first commit message and then
> cherry-pick the subsequent patches.
>
> And remember that you do not need to clone the entire repository. You can
> 1) fetch into the current one, and 2) use a shallow fetch. Example:
>
>         git fetch --depth 1 http://git.savannah.gnu.org/r/gawk.git \
>                 gawk-4.1.4
>
> The next commands could be something like
>
>         git read-tree --prefix=3Dcompat/regex/ FETCH_HEAD:
>         git clean -dfx -- compat/regex/

Sure, if I submit this again I'll update whatever one liner is in
there to import it via git.

> Oh, and please do not use `master`. If Git is any indication, a tagged
> release will most often be a bit more robust than any in-between commit.

The reason to use the master branch of gawk is that since the last
release only one trivial change has been made to it, but the files
were all renamed as well, so it was easier for that one-liner in the
README to use master than the latest release.

If we move to gnulib we'll also use the master branch, because that's
what you're supposed to do according to their docs, they don't make
releases.
