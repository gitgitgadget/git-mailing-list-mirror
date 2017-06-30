Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0A32201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 21:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753077AbdF3VVF (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 17:21:05 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34170 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753069AbdF3VVE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 17:21:04 -0400
Received: by mail-pg0-f44.google.com with SMTP id t186so69296176pgb.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 14:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+OwcERlGZP5Rx+TOHkhpcbjqRoIPY0otb0k29v7w+qE=;
        b=LH2qNZb3ArnjiIFUNwyGv+vxZvv205LFMC/7EuQbGvx6iiFJsmtETSF4VdbypjdB09
         PJ1T+JbKJimzy2EUqHYDvzxOwzp+1Qw71M0A9+dF2b+CEq3w47VSyPM9lxwzBOu+n8DX
         n3kh1g1j9LfhaieD1fR106q154IOt9hBS1AX9Z8+j60jklPULZopk/0jWFGppOJnL21k
         5uH0DH1jClXYEhyo2QNuS4t62jXz27XnTeF95YLOg2eomIV1kc71RtFqin/ADW4/BwL5
         kr7ngtHRuGhENZoexs1tIkHxAgAX2xHD9MRxyY9ArqFjp1AqcavDSKr7QIDub9EKEfvQ
         tDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+OwcERlGZP5Rx+TOHkhpcbjqRoIPY0otb0k29v7w+qE=;
        b=LjEJJOkeOshRvhtabqO1clDqxXdsIs4SVG1inokgpH7cuHqjNK4YwvbsB1G92uqKaS
         WBMe8ZNd2sBE1QQ0Ck/VeT6+aJh22XyLhs1uJDkc+HeHraywpG57o3Fg2EZVohqEyrr2
         b4zoA89rCrvxiwKGKsTrarAJdeIf/ud6Ol0jwChPtGZXeH37rySEcKyRUqLgfi4iQjXW
         jEOPZQTWm803AFVXYxW/5TCwfpBZRpB8/bn3HtfA3JH4z7SY7BHjBY/b8/Xgld9R4Rx1
         yIGqVeykAIajDd8jr8TcPGpTgEPDx0FVXffkvbQigB6MkU191WHP9yDYmIqiIEKHDOIP
         8kCQ==
X-Gm-Message-State: AKS2vOxYiGAISu4TFiR6uH6hLxYRAiq54+q5FGlT0C1kfhBK2p2G+vos
        Gmlnt6tOHVwan+WF1HFyioNGPhcOKRVh
X-Received: by 10.98.112.137 with SMTP id l131mr7806684pfc.194.1498857663952;
 Fri, 30 Jun 2017 14:21:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Fri, 30 Jun 2017 14:21:03 -0700 (PDT)
In-Reply-To: <xmqq1sq1qiyg.fsf@gitster.mtv.corp.google.com>
References: <20170630000710.10601-1-sbeller@google.com> <20170630205310.7380-1-sbeller@google.com>
 <20170630205310.7380-23-sbeller@google.com> <xmqq1sq1qiyg.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 30 Jun 2017 14:21:03 -0700
Message-ID: <CAGZ79kbD13RgcTuiegn4J1piFZrNu6bAxCGEKDYLThnVuYQLrg@mail.gmail.com>
Subject: Re: [PATCHv2 22/25] diff.c: color moved lines differently
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 30, 2017 at 2:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> +             return (int)' ';
>
> Do we need a cast here?

No, I figured it is good to have it here explicitly, though.
We can drop that if you have strong preferences one way or another.

>
>> +static unsigned get_string_hash(struct emitted_diff_symbol *es, struct diff_options *o)
>> +{
>> +     if (o->xdl_opts & XDF_WHITESPACE_FLAGS) {
>> +             static struct strbuf sb = STRBUF_INIT;
>> +             const char *ap = es->line, *ae = es->line + es->len;
>> +             int c;
>> +
>> +             strbuf_reset(&sb);
>> +             while (ae > ap && isspace(*ae))
>> +                     ae--;
>
> Not testing for the AT_EOL option here?

No, because the other options are stronger than the AT_EOL,
such that as you note it is still correct.

If in the future, we'd have another new option e.g.
IGNORE_TAB_BLANK_CONVERSION_BUT_WARN_ON_LENGTH_DIFF
(useful for python programmers ;)
this would break.

>
> By the way, this is an unrelated tangent because I think you
> inherited this pattern by copying and pasting from elsewhere, but I
> think it would be better if we avoid casting the function pointer
> type like this:
>
>> +             if (o->color_moved) {
>> +                     struct hashmap add_lines, del_lines;
>> +
>> +                     hashmap_init(&del_lines,
>> +                                  (hashmap_cmp_fn)moved_entry_cmp, o, 0);
>> +                     hashmap_init(&add_lines,
>> +                                  (hashmap_cmp_fn)moved_entry_cmp, o, 0);
>
> When hashmap_cmp_fn's definition changes, these two calling sites
> won't be caught as passing a incorrectly typed callback function by
> the compiler.
>
> Instead, we can match the actual implementation of the callback
> function, e.g.
>
>> +static int moved_entry_cmp(const struct diff_options *diffopt,
>> +                        const struct moved_entry *a,
>> +                        const struct moved_entry *b,
>> +                        const void *keydata)
>> +{
>
> to the expected function type, i.e.
>
> static int moved_entry_cmp(const void *fndata,
>                            const void *entry, const void *entry_or_key,
>                            const void *keydata)
> {
>         const struct diff_options *diffopt = fndata;
>         const struct moved_entry *a = entry;
>         const struct moved_entry *b = entry_or_key;
>         ...
>
> by casting the parameters.

I agree.  I can make a cleanup throughout the whole code base,
but I would prefer if that is done in a separate series, as this
is already slightly lengthy.

Thanks,
Stefan
