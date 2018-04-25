Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C80BE1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 00:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750882AbeDYAL1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 20:11:27 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:46730 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbeDYAL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 20:11:26 -0400
Received: by mail-pf0-f179.google.com with SMTP id h69so13609653pfe.13
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 17:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SsPpmXE4F7u2/Hsbi5917q7ey5z5zJjO1v5fywdmc6E=;
        b=smq/uqxtNdUMLIQ+cfQOw04g2jbHbGgDubBxwMGi3f9FG/sMnZjOs3jXly0AWsTp7Z
         UMpRIwX/a1TSagKZX5mPUQM7aLMYJOFn0/oMn0xeHoLXoGOJw3A0TG+Ilp+7ata6PloO
         X8NGDmrP7LKboNcvGpqGMskZFQvuV4H2XQOf6lvmLtSpPoBUiWKDg5oXsFD9Vc2ZTzWh
         U27UOFr9FRwgG9XCC+p5y4X5xNzGxketX0U5iwhtEK8CcgIzrlRv7YWTXz+WLIn8WmPj
         VuYNPERcajpZG9I7Z1GLftk9qK8whEiOOdYVi+IM7QTaMmCJY5S0eyoT3EdTj6I2p6UL
         /kcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SsPpmXE4F7u2/Hsbi5917q7ey5z5zJjO1v5fywdmc6E=;
        b=RMRcgIYK4lSMcSKARIX0rH3+Vh95rQwFHvK22ZYb3oh5Pd2ujtWdo1BcwqarORMb9L
         vEM8+QRD0pswDYrJKrrKHvEY28jDGJom5OcNVUjVOczdB8+JznyC7Tq4AtFLgAffp0U8
         f8NluzGRDXndLsruy+ydAQsW0jI6ayu73uYKy0jOc7gSd1l6Gtv+bedRCUHwHsjg77Ti
         mXUaRM7DxOuxSygD0J8uniNw8guHvXGPWqBvYwYKPvu2QD1ax3xJQJphwqpU0Ti3222s
         lHui+jxLZofTqB/lMjTZwh0qKEUoTbNLzsxOrEcRTHE2Rh03Hei23xtNwM/GmIMAYX6w
         RSpw==
X-Gm-Message-State: ALQs6tAr21GMYwEtUdsloXIVI5sYv3OIFf2UcQZ2k3DBvx2q89+S5702
        bBSSdV76OoMIl8JJkgiQobhzz4Cxs94=
X-Google-Smtp-Source: AB8JxZoOCPRbZD3KzvWhVHVVg0X5NWnOvhiMOHKf5ber50fqHyU2ZsOkR2Dc80RXBxsKvfOXIktxjQ==
X-Received: by 2002:a17:902:5681:: with SMTP id j1-v6mr1388606pli.383.1524615086045;
        Tue, 24 Apr 2018 17:11:26 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id r80sm25346897pfe.44.2018.04.24.17.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 17:11:24 -0700 (PDT)
Date:   Tue, 24 Apr 2018 17:11:23 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Simon Ruderich <simon@ruderich.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 7/7] diff.c: add --color-moved-ignore-space-delta option
Message-Id: <20180424171123.7092788b94498908c25eccf0@google.com>
In-Reply-To: <CAGZ79kbQUWq_pfvwLWotqCxc1-Y=ctJ4SqgqR+EvJ5wkJkp5kQ@mail.gmail.com>
References: <20180424210330.87861-1-sbeller@google.com>
        <20180424210330.87861-8-sbeller@google.com>
        <20180424153513.dc2404cd111c44ac78bd8ed8@google.com>
        <CAGZ79kbGkHFSS9K8KKTwNikx3Tw+m+RMLY3RAf8SW_iK9a2OJQ@mail.gmail.com>
        <CAGZ79kbQUWq_pfvwLWotqCxc1-Y=ctJ4SqgqR+EvJ5wkJkp5kQ@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 24 Apr 2018 16:23:28 -0700
Stefan Beller <sbeller@google.com> wrote:

> >> s/missmatch/mismatch/
> >> Also, what is this used for?
> >
> > The mismatch should be used for (thanks for catching!)
> > checking if the remainder of a line is the same, although a boolean
> > may be not the correct choice. We know that the two strings
> > passed into compute_ws_delta come from a complete white space
> > agnostic comparison, so consider:
> >
> > + SP SP more TAB more
> > + SP SP text TAB text
> >
> > - SP more TAB more
> > - SP text TAB text
> >
> > which would mark this as a moved block. This is the feature
> > working as intended, but what about
> >
> > + SP SP more TAB more
> > + SP SP text TAB text
> >
> > - SP more SP more
> > - SP text TAB text
> >
> > Note how the length of the strings is the same, hence the current
> > code of
> >
> >     compute_ws_delta(...) {
> >         int d = longer->len - shorter->len;
> >         out->string = xmemdupz(longer->line, d);
> >     }
> >
> > would work fine and not notice the "change in the remainder".
> > That ought to be caught by the mismatch variable, that
> > is assigned, but not used.
> >
> > The compare_ws_delta(a, b) needs to be extended to
> >
> >   !a->mismatch && !b->mismatch && existing_condition
> >
> > Ideally the example from above would be different depending
> > on whether the other white space flags are given or not.

Thanks - this gives me food for thought.

I'm starting to think that it is impossible to avoid creating our own
string comparison function that:
 - seeks to the first non-whitespace character in both strings
 - checks that both strings, from that first non-whitespace characters,
   are equal for some definition of equal (whether through strcmp or
   xdiff_compare_lines)
 - walks backwards from that first non-whitespace characters to look for
   the first non-matching whitespace character between the 2 strings

The existing diff whitespace modes (to be passed to xdiff_compare_lines)
do not give the exact result we want. For example, if
XDF_IGNORE_WHITESPACE is used (as is in this patch), lines like "a b"
and "ab " would match even though they shouldn't.

This comparison function can be used both in moved_entry_cmp() and when
constructing the ws_delta (in which case it should be made to output
whatever information is needed as out parameters or similar).

> >>> +     if (diffopt->color_moved_ws_handling & COLOR_MOVED_DELTA_WHITESPACES)
> >>> +             /*
> >>> +              * As there is not specific white space config given,
> >>> +              * we'd need to check for a new block, so ignore all
> >>> +              * white space. The setup of the white space
> >>> +              * configuration for the next block is done else where
> >>> +              */
> >>> +             flags |= XDF_IGNORE_WHITESPACE;
> >>> +
> >>>       return !xdiff_compare_lines(a->es->line, a->es->len,
> >>>                                   b->es->line, b->es->len,
> >>>                                   flags);

We can't add XDF_IGNORE_WHITESPACE here - as far as I can tell, this
means that more lines will be treated as moved than the user wants (if
the user did not set --color-moved-ignore-all-space).

> >> It seems like pmb and wsd are parallel arrays - could each wsd be
> >> embedded into the corresponding entry of pmb instead?
> >
> > I'll explore that. It sounds like a good idea for code hygiene.
> > Although if you do not intend to use this feature, then keeping it separate
> > would allow for a smaller footprint in memory.

If you're worried about memory, wsd can be embedded as a pointer.

> > The command is missing a --color-moved, as the --color-moved-whitespace-settings
> > do not imply --color-moved, yet(?)

Maybe one should imply the other (or at least a warning).
