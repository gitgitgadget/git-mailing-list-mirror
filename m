Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBB0E201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 15:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751397AbdBXPw7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 10:52:59 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:38687 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbdBXPwb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 10:52:31 -0500
Received: by mail-it0-f50.google.com with SMTP id y135so27936208itc.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 07:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZR8PGIRFsEv6m1ceZi/DH6x4tMcM0PMmNCf5VBqBkSQ=;
        b=mY70wup5AETptqFz9XjkAdZlNsc547ny4lLk4amu7p0byuPBj6SmXizTbawDWI5Z1a
         j+o8E/8soJYhPX1vPNQhqfk4mkKxcihD60r4mgkNUgAoIPzCyRRXhP2cs3x+IclYRi3K
         5iESIbfE+c/4t238z4iMbHWNBSZwjC636zYjpsKSJFEk2vEyCWN8GikuLkA6lQIhUUTl
         TT5FkHmAW2yJxBJVdLu6Y0VAR0RIrZlrDQdvUeZCwtKa2EVKmj3MEwFEIXW3qTZS4qTW
         WtvgiQYEgm831kiHiOobi6BUKe+fuBmq8ZaZYKrynojAsAvVnmFWZUMYzauPdCvzq7Z5
         fpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZR8PGIRFsEv6m1ceZi/DH6x4tMcM0PMmNCf5VBqBkSQ=;
        b=JlHzdOnU15dABxyZetEuBhGDG7/fU7wIwauqujjyEJROR0K4JyirvdDLTg31tjTiDK
         NQqUJ1aIq2xnfLjGH8KC3JsZlG+YWySQG7PvGgHG+aONn/fFRnG1HmkViqCV5nSV76KR
         cM4uxn0m1OGYzxWsOLbQSIAX5HBER9SZSxmyXfASYfaAuwKiatNVfKCr/6602dKrVjds
         /uQFJeJziPbXHdB+N3EH9756vnlLmNm7gqhB0FkgqVcLyYU7WGtYDFEKKTmzGY03IYlS
         2aOptdtouxjSD3NliiKQcvsEpcx2Qu9XmXQgNOZERuLE0P4cwKw+PgFMb/wNTGCKeWg+
         KVUg==
X-Gm-Message-State: AMke39ly9yMuByZxCQOyv1pa8KqPc0VOyq+n3pBhwd+mDav4sNxruizqbPwCi+r3Kzf+bM+O/k7hOO1XVCOBjQ==
X-Received: by 10.107.189.197 with SMTP id n188mr3575929iof.88.1487951546298;
 Fri, 24 Feb 2017 07:52:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.137.145 with HTTP; Fri, 24 Feb 2017 07:52:24 -0800 (PST)
In-Reply-To: <CANv4PNmSjJUhFgC7GhpuBjiSQhwfAhrP8WxiP_siP2AjjXnrnw@mail.gmail.com>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
 <20170223173547.qljypk7sdqi37oha@kitenet.net> <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net> <20170223183105.joxtpbut4wcqfbtu@kitenet.net>
 <CANv4PNmSjJUhFgC7GhpuBjiSQhwfAhrP8WxiP_siP2AjjXnrnw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 24 Feb 2017 16:52:24 +0100
X-Google-Sender-Auth: 5LGRAHLyDQX-fjDioVMLOElCMaA
Message-ID: <CAMuHMdWbMFVcp-OK6BU0ey6tHC=QVaSFJWGd_Ge2aUsrAEczxA@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Morten Welinder <mwelinder@gmail.com>
Cc:     Joey Hess <id@joeyh.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 8:13 PM, Morten Welinder <mwelinder@gmail.com> wrote:
> The attack seems to generate two 64-bytes blocks, one quarter of which
> is repeated data.  (Table-1 in the paper.)
>
> Assuming the result of that is evenly distributed and that bytes are
> independent, we can estimate the chances that the result is NUL-free
> as (255/256)^192 = 47% and the probability that the result is NUL and
> newline free as (254/256)^192 = 22%.  Clearly one should not rely of
> NULs or newlines to save the day.  On  the other hand, the chances of
> an ascii result is something like (95/256)^192 = 10^-83.

Good. So they can replace linux/Documentation/logo.gif, but not actual source
files, not even if they contain hex arrays with "device parameters" ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
