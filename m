Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CD431F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 06:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfKNGys (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 01:54:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34118 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfKNGyr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 01:54:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id z188so3114401pgb.1
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 22:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t8RZyDdJ8tc2kH0OO9pS0zQ89U7zeSh6ceSzRbl23ko=;
        b=us8yKcAg87WsSFLyyQvMHTwFey5EAfIes2Cxjo61apPAU06G0H2mSRBjZO+gwCZD8E
         2P4+OfbESNO/qJKXUNBCFTx7d20lPEH2/A8ZAtgI8ZTnncIJ0oqZJRa/6bOJZVjhBGKl
         JtmMW/qgH4vYxTWsDUlYBKYOVo2fbLax6DUoGSfdLbiIJDELVNhwulJrqNaulLqMRXNc
         H++O9YgdZHZ7KHy2ISdj4L5+lOOSW3RRmoq+ytFB47tQNl+QhlOsCFUhcKkhzhKaf7Br
         onYTZ/SChaMm/vM6YkUgjsaRY00ZBAmWOA+yHwSF+BT5KvMiquUgmvRAoooZjEL4vkl0
         jm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t8RZyDdJ8tc2kH0OO9pS0zQ89U7zeSh6ceSzRbl23ko=;
        b=VbLbd+akAzV2SfHXFCOuS22sXiio1WGFegpxEbkqiXkhtzSKqBJ179BIBjdiPo9Jd9
         DkDoN+3j0WBLrJNNa4rvjtmgQxr/eX90cn3U4tZGameApMsKbn5n2+qiUTlh3xO4wuxu
         DhV/w5XOSmUfqDrqRFtB8vTklwxsvQfdX63/W6oGIWwg0QUIOFqvGQrD8a/J25bpRJEb
         SlQHVvAJqc0ZKBB6iprhDgKBWds+4W8/O4399UtNR4CxKyWqnRftdVv67jhxnvOgzTi6
         nHXTm+ALpye/SHSsswQ9Aywhgv8158PNczc69wFhekmtaen9bt5b6Z9ECWzf6/vJYg8p
         Y4MA==
X-Gm-Message-State: APjAAAVlKEhOAId57KQPzQD57JaxD/mnYuJ/vhly0kM8doetBh9es/L9
        dCui6HuXIslUHDjd353zvhpC/vF+gL1sNAOCyxsnRPUR
X-Google-Smtp-Source: APXvYqxDBV5yN1wEl5PudTWhjOyV/h1YAD90jKxBfHYYMt9o+hHfB8ZKQ6gLZtcNPCOZ2lPV+MadsHkDJ8yuFt3PJdI=
X-Received: by 2002:aa7:918e:: with SMTP id x14mr8817678pfa.12.1573714487208;
 Wed, 13 Nov 2019 22:54:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573670565.git.martin.agren@gmail.com> <20191114062900.GD10643@sigill.intra.peff.net>
In-Reply-To: <20191114062900.GD10643@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 14 Nov 2019 07:54:35 +0100
Message-ID: <CAN0heSrtwi9V607vBX9PMSfNLQ8iGcno6_iGuR4Fs8ndGxqh8A@mail.gmail.com>
Subject: Re: [PATCH 0/8] builtin/config: canonicalize "value_regex" with `--type=bool[-or-int]`
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 14 Nov 2019 at 07:29, Jeff King <peff@peff.net> wrote:
> This seems like a good idea, but I wonder why we'd limit it to bools?

Basically because that's what the existing left-over-bits mentioned and
it felt like a good place to start. But you're right in asking about the
bigger picture up front.

> It seems like any type would probably be better off matching a
> normalized version.
>
> We already have two functions in builtin/config.c which handle types:
>
>   - format_config() is for actually interpreting an existing value and
>     writing it to stdout
>
>   - normalize_value() is used when writing a new value into a config
>     file, and normalizing what the user provided on the command-line
>
> I don't think you'd want to use format_config() here.

I just speculated a little around format_config() in a reply to Junio.
Already with my patch series and with type=bool-or-int, there's a
visible funny-funky corner case where one hand doesn't know what the
other is doing.

> For example, if I
> say:
>
>   git config --type=color --get-regexp ^foo red
>
> I want to match the original "red" color, but _output_ the ANSI code.
> But normalize_value(), by contrast, leaves colors intact. So maybe it's
> a good match?
>
> OTOH, I'd probably expect to match expanded pathnames or expiration
> dates there, too, and it doesn't expand those. Those ones are less clear
> to me. The whole premise of this series is making an assumption that
> "--type" is about how you want to match,

Right.

> and not just about what you
> want to output. In your example above it's clear that you don't care
> about the output type (because you're using --name-only), but for:
>
>   git config --type=path --get-regexp ^foo /home/peff
>
> it's unclear if you want to match a value of "~peff/foo", or if you
> simply want to output the expansion.

Hmm, I feel like we're opening a can of worms here.

> I wonder if we'd want to allow specifying the output type and the
> matching type separately? Maybe that just makes it more awkward to use
> for little benefit (I admit that it's hard to imagine somebody wanting
> to normalize bools on output but _not_ for matching).
>
> Anyway. It would be nice if we could build on the existing logic in some
> way, rather than making a third place that has to handle every type we
> know about.

Understood. Thanks a lot for sharing your thoughts.

> > The last patch is not meant for immediate inclusion, but I post it
> > anyway. I can re-submit it at an appropriate time, or maybe it could
> > slumber on pu until the time is ripe for completing the switch.
>
> I think bailing on values that can't be converted is normal for other
> code paths. E.g., just trying to print:
>
>   $ git -c foo.bar=abc config --type=bool foo.abr
>   fatal: bad numeric config value 'abc' for 'foo.bar': invalid unit

I'm not sure if you mean "... so we could be a lot more aggressive
here"?

I'm running now and I feel like I'll need to read your mail again
tonight and get back to you in more detail.

Thanks
Martin
