Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BC6320954
	for <e@80x24.org>; Mon,  4 Dec 2017 19:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbdLDTpi (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 14:45:38 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:44324 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbdLDTpg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 14:45:36 -0500
Received: by mail-qt0-f171.google.com with SMTP id m59so6515636qte.11
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 11:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hunwpWx0O2/1PWmmP8vhmpZHOxdUlF399kl5C/r6u6k=;
        b=E28g2MYgOVB8ULUoFDhIemHR4J9dnhzHurPnDCDFSwPjbE50u9WjVICZX2+gJ9cm5H
         fPNVei/GsG4NZtZlilOqZTXerTbg+usJbcRA6KksrvJrM4MlQ03eznl/nUlOnAC/O2Xg
         N0PHElTN7WoHuI/KCtFi1kgpfECIThj5Nh9eB3yVuEs6Ij0fhFBu+3tv0BZS8yU6w9Z9
         FCabv9rP5BV9vDxhpR3SHScYoaAPiw5Ef6vTtA1KGNbQVVBG5BZ1scCOqQIrsMoD19Hs
         7/zVOBMOU8Kw5HbMLDjTyRribNmRpxrcvpVPTTPO5BbxuKTRzXVKxwqJbw+e2S/Q/ER+
         cQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hunwpWx0O2/1PWmmP8vhmpZHOxdUlF399kl5C/r6u6k=;
        b=cazcTsA0ZuJEFw92s9V0Dy5EvgiLKOt3xJkC5o8uk7owio2U1nOYtet9674e9GAVjK
         uJednFiltdgejl4eAXVIqYvlJDFGLT2973jXcaDoANi8DcPtPyLMz9FKK8aVqZuBr0JI
         2jn8gZ/72/R/2c0+hQW5QSULikvmRAzAjdotEEyRs7noC/iKGs43Nk6n5wWNiejlGpGr
         lvX7ClkVkS3IOAgdgzaXWBY6QkB3J8pYBJ2y7QlKzZPvKcXNcdJ4WT0bsEkDrxaoR9e9
         SQJyXOFo5jjFKbgP0H20kCMGoWbjP/1Xm8JuBraQGnR7FfFa7q3iSNwMy6agexzT6KyD
         d4fA==
X-Gm-Message-State: AKGB3mKnl9grBX6W+hWR+jO69pVdO7FP2ic7ogM+zsVNYU6qv1OrJrx7
        bbWyGIVNva+Cc/aNm2dZMpLmmowekCju5IVgZ3WAXg==
X-Google-Smtp-Source: AGs4zMY2xSm8iyV0oSsOi5zIcNq2r1hmNxUIvHK3Q9qRLyyWS6T033Q+Vr+8tbzsTAhhIOAC1m+WTIpiEXFqOpPsvKM=
X-Received: by 10.237.42.22 with SMTP id c22mr69803qtd.162.1512416735323; Mon,
 04 Dec 2017 11:45:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 4 Dec 2017 11:45:34 -0800 (PST)
In-Reply-To: <20171130152605.1b775e9cc2ddd7f917424448@google.com>
References: <xmqq1skj9o7r.fsf@gitster.mtv.corp.google.com> <20171128184703.155931-1-jonathantanmy@google.com>
 <alpine.DEB.2.21.1.1711300134560.6482@virtualbox> <20171130152605.1b775e9cc2ddd7f917424448@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 4 Dec 2017 11:45:34 -0800
Message-ID: <CAGZ79kZ7EvpOUgdkMe=+nx1qV23jvDaY4-GVzjmtN_hnJ71bag@mail.gmail.com>
Subject: Re: [PATCH v3] diff: support anchoring line(s)
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 30, 2017 at 3:26 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Thu, 30 Nov 2017 01:36:37 +0100 (CET)
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
>> Hi Jonathan,
>>
>> On Tue, 28 Nov 2017, Jonathan Tan wrote:
>>
>> > @@ -4607,7 +4627,14 @@ int diff_opt_parse(struct diff_options *options,
>> >             DIFF_XDL_CLR(options, NEED_MINIMAL);
>> >             options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
>> >             options->xdl_opts |= value;
>> > +           if (value == XDF_PATIENCE_DIFF)
>> > +                   clear_patience_anchors(options);
>> >             return argcount;
>> > +   } else if (skip_prefix(arg, "--anchored=", &arg)) {
>> > +           options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
>> > +           ALLOC_GROW(options->anchors, options->anchors_nr + 1,
>> > +                      options->anchors_alloc);
>> > +           options->anchors[options->anchors_nr++] = xstrdup(arg);
>>
>> I looked and failed to find the code that releases this array after the
>> diff is done... did I miss anything?
>
> You didn't miss anything. As far as I can tell, occurrences of struct
> diff_options live throughout the lifetime of an invocation of Git and
> are not freed. (Even if the struct itself is allocated on the stack, its
> pathspec has some elements allocated on the heap.)

I thought at least for the intra-line word diff, which allocates its own
diff options struct, we'd clear them, but looking around we seem to leak
the diff options consistently. (builtin/blame.c is nice enough to
`clear_pathspec(&diff_opts.pathspec)`, but that's about it, no other
command takes care of the cruft.

I wonder if diff_flush might be a good place to clean up the diff options
and after the flush the diff options are declared invalid?

> test_expect_success '--anchored with non-unique line has no effect'

okay, if it turns out we need this case in the future we can still come up
with ideas.

Thanks,
Stefan
