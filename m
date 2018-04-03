Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAA7F1FAE2
	for <e@80x24.org>; Tue,  3 Apr 2018 20:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753093AbeDCUiS (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 16:38:18 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:45530 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbeDCUiR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 16:38:17 -0400
Received: by mail-pl0-f52.google.com with SMTP id v18-v6so8606081ply.12
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 13:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uLDxAoAYDohyG6qyrMAtKxQbQZcsTUwFGazotHIPFtQ=;
        b=UrTGquJkqcbXBclnvCWIMx2fVTaQl/BgB4wac0ps/xG8aFJz8JdgqnaI4Ec7GwpDE1
         qph2HmHFtr/Sq7AtsgmeeIAp1EOApOOQMrYpMGhhPl2XVCU7dyQUI8ivFWDrPQEpZEk9
         zhWr3Wj6ku3hn45Y5uGTkArFm827/0vfaIKsmZAirztuD/UQtABHYrMJti09hFglhOLJ
         eAAkkUC9QFsZ86GpS9uucs+Jqbfy0GjbHct4BUfuE3JOECo5rAy1wHN3weT06W78+WiH
         XIm2ZMaN8C35haVwoVzU2/70t5nzkh+bsP7N28gMUe2tjAh7xEVVDcf+CYaIfD0GDy14
         vwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uLDxAoAYDohyG6qyrMAtKxQbQZcsTUwFGazotHIPFtQ=;
        b=DN3VA5Xh61WTmjJ2QuwucpATexo/P74axzLO1soGDIswikML+HaFNiB5p2Yf8SzFWw
         JyzQAjdO5BMUFuyP2Bc0TQe6/R2lAxwIuCUj9QTsHiuL5Db9nbH/mbIFTglmWgHcs0rR
         AuqO1JI+R6iELb/GRAiY5FoFLffJVwQsxRthQaFFzSL5XCar7IyED0ZAcIadk3ShlBpf
         4gQ4HiS/j5anDdDL089+/u33liI14v0eCNQs0w2zawGQNVr3Qu4pF0PWmuTZScaaDhHh
         ZfSBpoL/wTqbvI4wXj7nM+5wTtgb8dgWIEX12PoQ4CIBNg2duXEl7WijV3KV4bPSOCHg
         Lwxw==
X-Gm-Message-State: AElRT7F1p7Lle7Gg9CM+6JI4ooZGUbHymlifY1mpY+s0U/JtX4QcTQQy
        nVTxLL69XEsWr6/g2E6Y1ru00Q==
X-Google-Smtp-Source: AIpwx48rPSkJJ6KAQCo4dSK+HgatRPXMbqb+7UtpDtlCDSbsbcimbybKoJe5in9lTeV3pqQU6Uf7rQ==
X-Received: by 10.98.192.66 with SMTP id x63mr11666543pff.135.1522787896570;
        Tue, 03 Apr 2018 13:38:16 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id a81sm6772586pfc.168.2018.04.03.13.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Apr 2018 13:38:15 -0700 (PDT)
Date:   Tue, 3 Apr 2018 13:38:14 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Simon Ruderich <simon@ruderich.org>, git <git@vger.kernel.org>
Subject: Re: [PATCH 7/7] diff.c: add --color-moved-ignore-space-delta option
Message-Id: <20180403133814.4845c4cc8cc2c9c749e2ada5@google.com>
In-Reply-To: <CAGZ79kYPx=OB92yWFw8W=zJDoJT5BjBd3Q+gt_WS_KuUw299vQ@mail.gmail.com>
References: <20180402224854.86922-1-sbeller@google.com>
        <20180402224854.86922-8-sbeller@google.com>
        <20180402174118.d204ec0d4b9d2fa7ebd77739@google.com>
        <CAGZ79kYPx=OB92yWFw8W=zJDoJT5BjBd3Q+gt_WS_KuUw299vQ@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 3 Apr 2018 12:22:32 -0700
Stefan Beller <sbeller@google.com> wrote:

> On Mon, Apr 2, 2018 at 5:41 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> > On Mon,  2 Apr 2018 15:48:54 -0700
> > Stefan Beller <sbeller@google.com> wrote:
> >
> >> +struct ws_delta {
> >> +     int deltachars;
> >> +     char firstchar;
> >> +};
> >
> > I'll just make some overall design comments.
> >
> > Shouldn't this be a string of characters (or a char* and len) and
> > whether it was added or removed? If you're only checking the first
> > character, this would not work if the other characters were different.
> 
> I considered diving into this, but it seemed to be too complicated for
> >95 % of the use cases, which can be approximated in change of the
> first character.

It's true that most use cases can be approximated this way, but I don't
think that it's worth the approximation.

> Because if we take a string of characters, we'd also need to take care of
> tricky conversions (e.g. Are 8 white spaces equal to a tab, and if so do
> we break blocks if one line converts 8 ws to a tab?)

No conversions - spaces are spaces and tabs are tabs.

> So I would definitely pursue the string instead of change of first
> character, but what are all the heuristics to put in?

No heuristics - a few lines make a block if the same prefix (which
consists of all whitespace) was added or removed.

> Just to be clear: The string would contain only the change in
> white space up front, or would we also somehow store white space
> in other parts?

Only change in white space at the start of the line - this option only
handles space at the start of the line, right?

> - # This is a sample comment
> - # across multiple lines
> - # maybe even a license header
> + #     This is a sample comment
> + #     across multiple lines
> + #     maybe even a license header
> 
> How about this?

My understanding is that this patch does not handle this case.

> >> @@ -717,10 +752,20 @@ static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
> >>       const struct diff_options *diffopt = hashmap_cmp_fn_data;
> >>       const struct moved_entry *a = entry;
> >>       const struct moved_entry *b = entry_or_key;
> >> +     unsigned flags = diffopt->color_moved & XDF_WHITESPACE_FLAGS;
> >> +
> >> +     if (diffopt->color_moved & COLOR_MOVED_DELTA_WHITESPACES)
> >> +             /*
> >> +              * As there is not specific white space config given,
> >> +              * we'd need to check for a new block, so ignore all
> >> +              * white space. The setup of the white space
> >> +              * configuration for the next block is done else where
> >> +              */
> >> +             flags |= XDF_IGNORE_WHITESPACE;
> >>
> >>       return !xdiff_compare_lines(a->es->line, a->es->len,
> >>                                   b->es->line, b->es->len,
> >> -                                 diffopt->color_moved & XDF_WHITESPACE_FLAGS);
> >> +                                 flags);
> >>  }
> >
> > I think we should just prohibit combining this with any of the
> > whitespace ignoring flags except for the space-at-eol one. They seem to
> > contradict anyway.
> 
> ok, we can narrow this one down to ignore all white space.

What do you mean? The rationale for my comment is that I saw that you
need to specify a special flag to xdiff_compare_lines if
COLOR_MOVED_DELTA_WHITESPACES is set, which could conflict with other
flags that the user has explicitly set. So avoiding that case entirely
seems like a good idea, especially since it is logical to do so.

> >> +test_expect_success 'compare whitespace delta across moved blocks' '
> >> +
> >> +     git reset --hard &&
> >> +     q_to_tab <<-\EOF >text.txt &&
> >> +     QIndented
> >> +     QText
> >> +     Qacross
> >> +     Qfive
> >> +     Qlines
> >> +     QBut!
> >> +     Qthis
> >> +     QQone
> >> +     Qline
> >> +     QQdid
> >> +     Qnot
> >> +     QQadjust
> >> +     EOF
> >
> > Do we need 5 lines? I thought 2 would suffice. (It's the ALNUM_COUNT
> > that matters, as far as I know.) This makes it hard to see that the
> > "But!" line is the one that counts.
> 
> I did not want to go with the bare minimum as then adjusting the minimum
> would be a pain as these unrelated (to the minimum) test cases would
> break.

That is true, but it makes the test case harder to read now. If you're
worried about bumping into the minimum if we do adjust the minimum,
making the lines longer should be sufficient.

> >> +test_expect_success 'compare whitespace delta across moved blocks with multiple indentation levels' '
> 
> >> +     EOF
> >
> > If the objective it just to show that the functions f and g are treated
> > as one unit despite their lines being of multiple indentation levels,
> > the test file could be much shorter.
> 
> yeah, I noticed that we already test that in the test above where we
> have that test after the "But!", where lines ziggy-zag. Will drop this test.

OK, sounds good.
