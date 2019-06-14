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
	by dcvr.yhbt.net (Postfix) with ESMTP id 813461F462
	for <e@80x24.org>; Fri, 14 Jun 2019 22:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfFNWzX (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 18:55:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43311 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfFNWzX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 18:55:23 -0400
Received: by mail-ed1-f67.google.com with SMTP id e3so5619863edr.10
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 15:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=BWRpdk31FbEYpNjbL9tYtMpDaYiPJQuQY2suwqB+j4c=;
        b=su45jph8A0Oc2PHPjvfSCc3xz6rcwr+aLVWAVzyn5mYLcgR+zfqv0TUXEEN14qD804
         tL1uOusgsGA/l1+ohEG5MkoYShxEVVJkrr68p6Cw/cF8rOL92smeSkXGaqcIa4U8HEyZ
         ypmVXnyyS4lCF2p56rVaNzBoaD4J2uyCPOJBYR7E9ZPbDLHOSQFltj/9NZ6kusrhf0wh
         6LueqADPO3Hu7CSR13wn6fLu1kGX5lgbsA/XyIEMPNYbEAoKyQh1nYSlCKM98Yp/SOdw
         hLuXOQ4mHPknSVh6d05eesUpacvac3yQ3D8tLoaeNZzuZ/b68IN3jSXbMiB0JkUQiCar
         w5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=BWRpdk31FbEYpNjbL9tYtMpDaYiPJQuQY2suwqB+j4c=;
        b=Z8FdYTielGPhKfu4ROiBEm5bMoK/bR+voh9QTfqepy1V+8Uq7Nm0rWQiNL/tMCnch8
         SGPXhFTmSXRAydHOyizDxV71aDGCA6etl+1WZEnsld2YdkoGVLDmqruQWYg0M7s5ZGpZ
         fqLMlgVba7IsxDngXJSkF0oglvYh4A0ozX2k8LGqRJMVcrjdiM43VwInQXSXJ8UY8ZH0
         GHXku5RE2lGDh/6HXsLIVCCEZAJPA2KbwsJlv5RbQ5m/blURRQYqR/d2fF6FF2D8AKT8
         yxBhNZtSGEpp9arRSYwfca6kl8reVNO63wMjzMbbqtBUgymXUPAx75Ccg+qfiyBLggLo
         WwCA==
X-Gm-Message-State: APjAAAVU2Gh0CxVDttdxA6UZ2VLb5sNeMlwuolPzP4ouXGVGWQFUDN8i
        eAuXVZAAyReFycBm/AbC6MlINnlG
X-Google-Smtp-Source: APXvYqw46HYIUHZZ333gEjWrJlRySmvrcQSQvWSMOiNVihoBlXpjjbjIhncPPqKXbiNJS5e29/y3RQ==
X-Received: by 2002:a50:aeee:: with SMTP id f43mr30964721edd.221.1560552920555;
        Fri, 14 Jun 2019 15:55:20 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id m4sm1258548edc.24.2019.06.14.15.55.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 15:55:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, git-packagers@googlegroups.com
Subject: Can we just get rid of kwset & obstack in favor of optimistically using PCRE v2 JIT?
References: <pull.265.git.gitgitgadget@gmail.com> <c1527a71672056859a4613f2318bcbfce31e8b50.1560426581.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <c1527a71672056859a4613f2318bcbfce31e8b50.1560426581.git.gitgitgadget@gmail.com>
Date:   Sat, 15 Jun 2019 00:55:17 +0200
Message-ID: <87v9x793qi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 13 2019, Johannes Schindelin via GitGitGadget wrote:

> The kwset functionality makes use of the obstack code, which expects to
> be handed a function that can allocate large chunks of data. It expects
> that function to accept a `size` parameter of type `long`.
>
> This upsets GCC 8 on Windows, because `long` does not have the same
> bit size as `size_t` there.
>
> Now, the proper thing to do would be to switch to `size_t`. But this
> would make us deviate from the "upstream" code even further, making it
> hard to synchronize with newer versions, and also it would be quite
> involved because that `long` type is so invasive in that code.
>
> Let's punt, and instead provide a super small wrapper around
> `xmalloc()`.

I have a WIP patches from 2017 that do $subject that I can dig up, but
thought I'd gauge interest first.

Right now the grep code & pickaxe machinery will detect fixed strings
and use kwset() as an optimization.

Back when kwset was added in 9eceddeec6 ("Use kwset in grep",
2011-08-21) this helped, but now doing this for grep with a PCRE pattern
is actually counterproductive for performance. On top of current
`master`:

    @@ -368 +368 @@ static int is_fixed(const char *s, size_t len)
    -       return 1;
    +       return 0;

And running p7821-grep-engines-fixed.sh[1] (which is in git.git, and is
as far as I got with this) we get:

    Test                             HEAD~             HEAD
    -----------------------------------------------------------------------=
--
    7821.1: fixed grep int           0.48(1.59+0.63)   0.48(1.53+0.68) +0.0%
    7821.2: basic grep int           0.55(1.64+0.51)   0.72(2.97+0.54) +30.=
9%
    7821.3: extended grep int        0.65(1.63+0.54)   0.77(2.92+0.60) +18.=
5%
    7821.4: perl grep int            1.01(1.62+0.55)   0.36(0.97+0.58) -64.=
4%
    7821.6: fixed grep uncommon      0.18(0.51+0.45)   0.18(0.51+0.46) +0.0%
    7821.7: basic grep uncommon      0.18(0.50+0.46)   0.30(1.36+0.33) +66.=
7%
    7821.8: extended grep uncommon   0.18(0.45+0.52)   0.28(1.37+0.37) +55.=
6%
    7821.9: perl grep uncommon       0.18(0.52+0.45)   0.16(0.28+0.54) -11.=
1%
    7821.11: fixed grep =C3=A6            0.31(1.28+0.39)   0.31(1.24+0.43)=
 +0.0%
    7821.12: basic grep =C3=A6            0.30(1.29+0.38)   0.22(0.85+0.36)=
 -26.7%
    7821.13: extended grep =C3=A6         0.30(1.26+0.40)   0.22(0.78+0.45)=
 -26.7%
    7821.14: perl grep =C3=A6             0.30(1.33+0.34)   0.16(0.25+0.56)=
 -46.7%

So what this means on my Debian box is that when we use PCRE with JIT
and just get out of its way and let it do its own fixed string matching
it's up to ~65% faster than the kwset() path.

The usual case of just feeding the fixed pattern to glibc's regex
function is slower, although as seen there when you grep for a
rarely-occurring non-ASCII string glibc does better now (the perils of
using ancient last-version-to-use-GPLv2 snapshots...).

So my plan for this (which I partially implemented) was to have a series
where if we have a fixed string and have PCRE v2 we'd use it instead of
kwset() for fixed strings.

It seems most packagers build with PCRE v2 now (CC:
git-packagers@). I.e. we'd keep something like compile_fixed_regexp()
(and as an aside just use PCRE's \Q...\E instead of our own escaping).

We'd have performance regression for platforms that use kwset() now but
don't build pcre2, or where pcre2 jit doesn't work. Does anyone care?

This would allow us to just "git rm" kwset.[ch] compat/obstack.[ch],
which is ~2k lines of tricky code, 1/2 of which we're currently doomed
to maintain a bitrotting version of due to license incompatibilities
with upstream[2].

As an aside there's other code in grep.c that we could similarly remove
in favor of optimistic PCRE v2 use, e.g. the -w case can be replaced by
\b<word>\b, but I found that less promising[3]. We can also get a huge
performance win for BRE and ERE patterns by using PCRE v2 with a
translation layer for those under the hood[4], but various solvable
backwards compatible headaches[5] related to that are why I got lost in
the weeds back in 2017 and didn't finish this.

But just the s/kwset/pcre2/ case is easy enough.

1. Via:

    GIT_PERF_REPEAT_COUNT=3D10 GIT_PERF_LARGE_REPO=3D~/g/linux GIT_PERF_782=
1_GREP_OPTS=3D'' GIT_PERF_MAKE_OPTS=3D'-j8 CFLAGS=3D-O3 USE_LIBPCRE2=3DYesP=
lease' ./run HEAD~ HEAD -- p7821-grep-engines-fixed.sh
2. https://public-inbox.org/git/87wohn95vb.fsf@evledraar.gmail.com/
3. https://github.com/avar/git/commit/49ca92e799
4. https://github.com/avar/git/commit/a3cc090344
5. https://github.com/avar/git/commit/7dd367eb37
