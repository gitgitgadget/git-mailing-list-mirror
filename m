Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 923021F461
	for <e@80x24.org>; Mon,  9 Sep 2019 15:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfIIPHo (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 11:07:44 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43880 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfIIPHo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 11:07:44 -0400
Received: by mail-io1-f68.google.com with SMTP id r8so4534958iol.10
        for <git@vger.kernel.org>; Mon, 09 Sep 2019 08:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IqUeNKV9sbTEO+qjTJkh224tX2o4v+rKJ264iq0DrMk=;
        b=raHIY1HG99hpAeQM8aOGVcb0LTPlxbwHGlrqqD2O2MrTN4EXV73VU1otifAxaO186Y
         exrYGX6nTbCLHUE/EsQK9c0+AX577D65KC70WqZ4LipbbqAb0FaFtRuA3rGEsnNLgN8N
         5t9XZNlvaQjRyiB37C+UEAXfB7IsHCJ8mOfFu3O59zztkoJy8Qjh6EKddYux3dIbV8Db
         cdrKYE05dZW6wxlREh/HNqX7XAJVxR6wDP1iw3Y9jeFaLRUI1OORuSrtX66zmXUQQkZw
         G9RMbrJUvx1w4ngPvGBEJGynEJgU5teuiAcNXTFqxegmmkzQ9EBk3e6al2rCfJEZRg3/
         AJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IqUeNKV9sbTEO+qjTJkh224tX2o4v+rKJ264iq0DrMk=;
        b=GlSb5kNRLD9XQh6FhZlk1+mzIu4HoTzdsoneVU4ial5LmbwR1B34BVvbiTLNp2T1iO
         rx15Jmb3IAXr4JyKbAALHHHEwLqRXnBrQ+wDnKBmTXBI9+mugdZ2h47Hc9igB7CMPd5N
         K1UKII+KMa8yf0kWojKX1/Wo39oMM+fjXp9PG606mhbMI3iFKdXEtdQT9FsZBwwpWeCD
         yDBp9nF1uVJb6f3KLU3+3XkPMVtRwDrUbeIN+YUPEEiAmzSN+8u6JQAeh84/AA4tvQQp
         AfQE1kHy1z2BYviP9RYObzEL56rxt0irvvItzCpnngyA6Q6BZ2uEUM+4EOhqRawkw1ov
         XvLQ==
X-Gm-Message-State: APjAAAWEeT7rjbMwQ/yLx0wwvoFcG9P7Sbn7bbSkuXNVh1+6L3KbWWrd
        Cgz3YTfmOF+HxY3CViQLsxubCPvm4Q9tIPoyRRonOA==
X-Google-Smtp-Source: APXvYqzZIhmF0cpqtqAuyEQJd4lH0/+kfzpOPxtvrOPVgvEF6/PYs0crimX/xyiFjdu7lIFWHeVT/X03bgrsvN584z0=
X-Received: by 2002:a6b:6010:: with SMTP id r16mr26242360iog.124.1568041662701;
 Mon, 09 Sep 2019 08:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq5znrs9d0.fsf@gitster-ct.c.googlers.com> <20190828145444.31588-1-carenas@gmail.com>
 <CAPUEsphatmoBg3jV9p_xLF_zYe0qn=S=5UTYBCHKjnuNZm4_VA@mail.gmail.com>
In-Reply-To: <CAPUEsphatmoBg3jV9p_xLF_zYe0qn=S=5UTYBCHKjnuNZm4_VA@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 9 Sep 2019 08:07:29 -0700
Message-ID: <CAPUEspi+OXR8pjcJgTdqCCGMxE0dv8L6y-0SaX8jzB6z9mXaRw@mail.gmail.com>
Subject: Re: [PATCH v2] grep: skip UTF8 checks explicitly
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ping

any feedback on code/approach highly appreciated

Carlo

On Wed, Aug 28, 2019 at 9:57 AM Carlo Arenas <carenas@gmail.com> wrote:
>
> FWIW, the changes in grep.h are IMHO optional and hadn't been really
> tested as I couldn't find a version of PCRE1 old enough to trigger it
> but I am hoping are simple enough to work.
>
> As in my original proposal, there is no test because this is going to
> (as documented) trigger undefined behaviour and so I don't see how we
> can reliably test that.  Goes without saying tthough, that the same is
> triggered when JIT is enabled and the JIT fast path is being used, so
> this is not a regression and will be more visible once
> ab/pcre-jit-fixes gets merged because we are moving out of the JIT
> fast path with a patch[0] in that series
>
> While =C3=86var made a point[1] that this wasn't a solution to the proble=
m,
> it was because PCRE2 could have a better one (still missing but based
> on ab/pcre-jit-fixes), and it was expected that PCRE2 will be used a
> lot more and so it wasn't a good idea for it (something that doesn't
> apply to PCRE1)
>
> the patch was based on maint (like all bugfixes) but applies cleanly
> to master and next, it will conflict with pu but for easy of merge I'd
> applied it on top of cb/pcre1-cleanup and make it available in
> GitHub[2]; that branch could be used as well as a reroll for that
> topic (if that is preferred)
>
> the error message hasn't been changed on this patch, as it might make
> sense to improve it as well for PCRE2, but at least shouldn't be
> triggered anymore (ex, from running a freshly built git without the
> patch and linked against a non JIT enabled PCRE1):
>
> $ ./git-grep -P 'Nguy=E1=BB=85n Th=C3=A1i.Ng=E1=BB=8Dc'
> .mailmap:Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> fatal: pcre_exec failed with error code -10
>
> Carlo
>
> [0] 685668faaa (grep: stop using a custom JIT stack with PCRE v1, 2019-07=
-26)
> [1] https://public-inbox.org/git/87lfwn70nb.fsf@evledraar.gmail.com/
> [2] https://github.com/carenas/git/tree/pcre1-cleanup
