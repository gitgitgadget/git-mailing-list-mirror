Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB3581F453
	for <e@80x24.org>; Fri, 21 Sep 2018 05:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388770AbeIULFv convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 21 Sep 2018 07:05:51 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37943 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIULFv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 07:05:51 -0400
Received: by mail-qk1-f194.google.com with SMTP id s129-v6so4749941qke.5
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 22:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2CzVnpyqLqSItR4m2Fkdyz8k20kuEqucZzE2Zv1V2uY=;
        b=BxyqLuftgKC4HX5HwAXTQzg7XpcjgAqEUeM/DqWaY0CHHKucRgG6DQw1ZTXNXFoRVX
         IbS1LUs2cWg1qxywqfgkmny/8Wx+WuZc3fmK7rKRBQQ+l5oTs3jnnoujjO17WGQAY8Xq
         1ogS6wlrsl6jdnGdO0LXP6v+lyoFbszbFMJAlEUJWAaq2pHjSGEYFM3PaH3r82ljSNm8
         HK4AQnqhYV6YPa8v8Fpp3zzgupegMu9Omdo0yUdkWTFO9GezM/bTP8lRPYH39dBzHX+a
         lrhKusbLF4X6Dia21DeCiTPw11FJibCtA7OJ9GvIem/c1rQ5LKotxM7XWjCS7WCrcHqc
         KVvA==
X-Gm-Message-State: APzg51ATmHuV3kMLqx7F2rt+MSAUbNdInx1wVxvwQhCPOiQ0V2VG73tn
        zJcCgwBuOX6fy3a8l0bkF1ymETpOyb8sPxlLo3U=
X-Google-Smtp-Source: ANB0VdbDBAb6U7vgL5zAd9/vpxo9ckYGImIscrh+P37NFFq6oqIHH/hiNIl+sUgzj95FMNEH2MLudHe+z0bPFh9PAyU=
X-Received: by 2002:ae9:ef13:: with SMTP id d19-v6mr29993676qkg.152.1537507121867;
 Thu, 20 Sep 2018 22:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180919201231.609-1-frederik@ofb.net> <xmqqzhwd2jcq.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhwd2jcq.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 21 Sep 2018 01:18:30 -0400
Message-ID: <CAPig+cR04cjf-D_hUgKhOSUAhHd8py7BM4-HOyE3VttV_ufXFQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] some documentation changes from the beginning of the alphabet
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Frederick Eaton <frederik@ofb.net>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 19, 2018 at 6:49 PM Junio C Hamano <gitster@pobox.com> wrote:
> Frederick Eaton <frederik@ofb.net> writes:
> > By the way for some reason git-contacts shows more names when I run it
> > on the patch hash than when I give it the patch name:
> >
> > $ ./contrib/contacts/git-contacts 222580cb60ee64f7b81fed64ec8fbfc81952557f
> > Sébastien Guimmara <sebastien.guimmara@gmail.com>
> > Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> > Eric Sunshine <sunshine@sunshineco.com>
> > Junio C Hamano <gitster@pobox.com>
> > $ ./contrib/contacts/git-contacts ./outgoing/0002-git-column.1-clarify-initial-description-provide-exa.patch
> > Junio C Hamano <gitster@pobox.com>
>
> I've never trusted what git-contacts say, but the latter one
> certainly looks strange [...]

I don't use git-contacts, but the first invocation isn't consulting
just a single commit but rather a range of commits. From git-contacts
documentation:

    Input consists of one or more patch files or revision arguments.
    A revision argument can be a range or a single `<rev>` which is
    interpreted as `<rev>..HEAD`, thus the same revision arguments
    are accepted as for linkgit:git-format-patch[1]. Patch files and
    revision arguments can be combined in the same invocation.

So, you are actually running git-contacts on the range 222580cb..HEAD,
and 222580cb isn't even one of the patches being consulted (due to how
the range syntax does not include the argument to the left of "..").
To consult just that one commit, you'd want perhaps:

    git-contacts 222580cb^..222580cb

> [...] as,
>
>         git log --no-merges Documentation/git-column.txt
>
> makes it clear that I have nothing to do with it ;-).  Perhaps the
> tool gives too much credit for Signed-off-by: footer, or something.

Since git-contacts can be used as git-send-email's --cc-cmd, it can
potentially be invoked many times, and it's a slow command (due to all
the "blaming" via git-blame). As an optimization, git-contacts limits
the timeframe of the blame via git-blame's --since option, with a
hardcoded limit of 5 years. So, the git-blame invocation made by
git-contacts for this patch file is:

    git blame --porcelain -C -L13,+7 -L23,+7 -L43,+6 \
        --since 5-years-ago \
        4a189fff51b1^ -- Documentation/git-column.txt

Since the lines changed by the patch have not been touched within that
timeframe, git-blame assigns those lines to boundary commit 128a96c984
(Update draft release notes to 1.8.5 for the fifth batch of topics,
2013-09-20), which was authored by Junio, which is why he shows up as
the only "contact".

If we remove the --since restriction:

    git blame --porcelain -C -L13,+7 -L23,+7 -L43,+6 \
        4a189fff51b1^ -- Documentation/git-column.txt

then the lines are correctly "blamed" to Duy via commit 7e29b8254f
(Add column layout skeleton and git-column, 2012-04-21).

The "Limitations" section of the git-contacts documentation says this:

    Several conditions controlling a person's significance are
    currently hard-coded, such as minimum participation level (10%),
    blame date-limiting (5 years), and `-C` level for detecting moved
    and copied lines (a single `-C`). In the future, these conditions
    may become configurable.

So, this sort of potential issue was understood. Felipe's
git-related[1], from which git-contacts arose, eventually grew the
ability to tweak these hard-coded values via command-line options. The
same could be done for git-contacts. Patches are welcome.

[1]: https://github.com/felipec/git-related
