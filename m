Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F6F91F597
	for <e@80x24.org>; Wed, 25 Jul 2018 19:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbeGYUoB (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 16:44:01 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:40486 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729821AbeGYUoA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 16:44:00 -0400
Received: by mail-yb0-f193.google.com with SMTP id y11-v6so3436791ybm.7
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 12:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2h6q9qgtV4/8piGPHxkbTce2Syte2EFLJOf7JG7LInA=;
        b=emnrDsts4ukM7lhbAh/uwmULa4R/dOFxPDygRzprzMFsemP680IrTwHIPe6Zrx0+7E
         5GY7+Nz30Bbm7cWqDa5JTx7FuI4z87x1J87iz90EtEf4iUa1rEXttF8DxqAYGfe9rNex
         nUfnktuWxpeHGjkEx5XYs+ANr1g1iVEVJBgwff3KSqv82Dal5wDRkcbHpH7AmNSj5u70
         146ethf610Yy69uh9TDoVkWABT3aA+BiO7TK6dhwookCsYe/4xYIKX48qGIoOj+2YcUg
         qW2HveVOT0V1a3z2ULSHZetYvhtx2YpxyQFHFnIjH6oebuz31EwJ/U90frJjhLC2PmEU
         vykQ==
X-Gm-Message-State: AOUpUlFGHaAsKdNm1Y+iTPoXnvLtXFGZvkpk6o/zeFjkGZ0C5kD2Y635
        1Df2op+R7S/F3YUH026OnbQL5E3ioFQhN2tu1WA=
X-Google-Smtp-Source: AAOMgpczri0AuqAS2kpzF9Tsbby5ICo8CZEdgyEDXhodzVmO2omBWAC/3kHJSLTfdt1Yzp4byABQkzAdxA7gbTkIe6c=
X-Received: by 2002:a25:9b03:: with SMTP id y3-v6mr12213735ybn.194.1532547055192;
 Wed, 25 Jul 2018 12:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180722095717.17912-1-sunshine@sunshineco.com>
 <20180722095717.17912-11-sunshine@sunshineco.com> <CACsJy8AOeiKp2JnG0h9mw40TdsNft80vUu573ORtqKMor7B+vw@mail.gmail.com>
 <CAPig+cT_7eDyY6xGev4=dwpJnKufpMevO-+hGnXVt4ec0xhEiA@mail.gmail.com> <xmqqva93usud.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqva93usud.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Jul 2018 15:30:44 -0400
Message-ID: <CAPig+cS-haNwJha44gncB9PrXRPcEPuqDVGLgKii29h=abq6sA@mail.gmail.com>
Subject: Re: [PATCH 10/14] format-patch: add --range-diff option to embed diff
 in cover letter
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 25, 2018 at 1:29 PM Junio C Hamano <gitster@pobox.com> wrote:
> A few random thoughts.
>
>  * I find it somewhat disturbing that use of dash is inconsistent
>    between "--interdiff=<arg>" and "--range-diff=<arg>".

I went with the common spellings we've seen on the mailing lists.
"Interdiff", in particular, seems well established. "Range-diff" is
new, so we don't have much data other than what we saw during the
discussion when renaming git-branch-diff, and, of course,
git-branch-diff itself is hyphenated. Another consideration: "inter"
is a prefix, whereas "range" stands on its own.

I don't have a super strong opinion, as I'm used to both the
hyphenated name (from discussion and the command name itself), and the
unhyphenated name ("rangediff" was my local branch name). I'm open to
opinions.

We probably wouldn't want to do so, but another possibility is to
recognize both --range-diff and --rangediff.

>  * Perhaps "--interdiff=<previous> --range-diff" may be a possible
>    way to say "use the same <previous> and show both"?  Do we want
>    "--range-diff=<previous> --interdiff" to mean the same two
>    meta-diff but shown in different order?

That's not at all a bad shorthand. I like it better than the
"--all-kinds-of-diff=<rev>" mentioned earlier. We don't need to make a
decision for this series since such functionality can be added later.

The order of specification of the two options affecting the order of
output is also an interesting idea. We may want to decide that before
graduating this topic.

>  * Do we expect that we may find a third-kind of "meta-diff" that
>    sits next to interdiff and range-diff in the future?  I *think*
>    two separate options "--interdiff=..." and "--range-diff=..." is
>    still a good way forward, and we'd add "--frotzdiff=..." when
>    such a third-kind of "meta-diff" turns out to be useful, without
>    fearing proliferation of options, and that would be OK, but I am
>    just thinking aloud to see if other people have better ideas.

I did consider other approaches, such as a more generic option. For
example, --embed=range-diff:<prev>. I also considered supporting more
complex use-cases. For instance, git-range-diff itself accepts the two
ranges in several formats ("a..b c..d" or "x...z" or "i j k"), plus
the creation-factor can be tweaked, so I weighed ways of incorporating
all that detail into the single argument to --range-diff.

However, those are all difficult to use (onerous to type and remember)
and difficult to document. Thus, I opted for simplicity of individual,
straight-forward options (--interdiff, --range-diff,
--creation-factor), which are easy to type, remember, and document.

We may want to revisit this later if git-format-patch grows additional
similar options.
