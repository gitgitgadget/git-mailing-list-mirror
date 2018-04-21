Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBE6C1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 08:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeDUIjU (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 04:39:20 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:39174 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbeDUIjS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 04:39:18 -0400
Received: by mail-pf0-f175.google.com with SMTP id z9so5332728pfe.6
        for <git@vger.kernel.org>; Sat, 21 Apr 2018 01:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i6T7Vc26v23fRLha4sXqJwo3XUOkC2/RwswDtvD8IsQ=;
        b=XGugSel8m+Gw02KaAt/tgz8Vhf+hjJIJMBpv3H8tXx+AbJFvIp3bDb86U3IBW53yTT
         Tc8OpvHz3MDHx+ZgYRaH5YDVr3qmUlZGsp6F3N/V+nILC/lf9KG6IF4b20SvgL5IanUb
         nKBhenkzBUO2kBnaBq74VYZcMXtICr8lU1rfRhKqGtXJXxTEmSQ7l3x2x8WH7xQz2Ipv
         EGoKuUtqPDNQn0WS1m9BKsTh9tdaq6OafNElWhiBq/sHFEhLL8qc0qVNo2MuQtKiwfEd
         tQKFVQS/NNQjnWTcaaGXRNx1ONlr4R99peRZFvTIEBOKGMDNm/BKy+EP1TMDbbFLwQeV
         m+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i6T7Vc26v23fRLha4sXqJwo3XUOkC2/RwswDtvD8IsQ=;
        b=tegmVz8KMFMvldS8JHnDhX3QvLR+Dyoc98cisOiE9wAd2J3nx/TEH0crMrFgjoInyj
         DD9tGyt7sMyKkf/UlVR7j7f07SZVnywK/NOnyeqzb+3+bAUGSOswF7+3t5lNewJA80xA
         HVKpAjxing9UMWovO0W5jCLvnuXIlVYjz8zSm0UdFIC1BDRqWOoVczzM2fMhVaayNQJs
         5aaQkluuSo+Sss45uNqTXlGuX0Ma/2jGY/qaK2SkvuF6qDbJ6wxZ5iIkt2fyKBUr9A+E
         gHezzRNsEXtVhmgjKcL+Adg+YX3pbty5hGP0fC4KLn8lv8OWw+PHOzm53klHMtzTpp5t
         kMFQ==
X-Gm-Message-State: ALQs6tDX+DwEjA3HclKFUq7PdE+sI3JahHcXz1Co5cxt8l/L6OgSU4iz
        P4JCHSmcxvSIKOnVNeYZ5V8FcFlHpcwVT8xPzak=
X-Google-Smtp-Source: AIpwx4+c696RsfdHl5dDu9NQIfLnidmospw2JNU1EF137MgYr/sh8bR4xkY16n6XrKtDIYIG86OTNe3gXPiTDh/h0hQ=
X-Received: by 2002:a17:902:1c7:: with SMTP id b65-v6mr10846272plb.298.1524299958216;
 Sat, 21 Apr 2018 01:39:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Sat, 21 Apr 2018 01:39:17 -0700 (PDT)
In-Reply-To: <20180421034540.GF24606@syl.local>
References: <cover.1524281843.git.me@ttaylorr.com> <20180421034540.GF24606@syl.local>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 21 Apr 2018 10:39:17 +0200
Message-ID: <CAN0heSp_bGqKF26g4TDOw6WpsvR2cEW6EqF3aJtKCv5POU_HmQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] builtin/grep.c: show column numbers via --column-number
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21 April 2018 at 05:45, Taylor Blau <me@ttaylorr.com> wrote:
> This commit teaches 'git-grep(1)' a new option, '--column-number'. This
> option builds upon previous commits to show the column number of the
> first match on a non-context line.
>
> For example:
>
>   $ git grep -mn example | head -n3
>   .clang-format:51:14:# myFunction(foo, bar, baz);
>   .clang-format:64:7:# int foo();
>   .clang-format:75:8:# void foo()

"example" vs "foo" :-)

> Now that configuration variables such as grep.columnNumber and
> color.grep.columnNumber have a visible effect, we document them in this
> patch as well.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---

One thing I've noted is that your messages are light on the imperative
"do this", preferring "this commit does" or "we do". That said, I found
myself following along quite well in what they're saying.

> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1159,6 +1159,8 @@ color.grep.<slot>::
>         function name lines (when using `-p`)
>  `linenumber`;;
>         line number prefix (when using `-n`)
> +`columnnumber`;;
> +       column number prefix (when using `-m`)
>  `match`;;
>         matching text (same as setting `matchContext` and `matchSelected`)
>  `matchContext`;;
> @@ -1708,6 +1710,9 @@ gitweb.snapshot::
>  grep.lineNumber::
>         If set to true, enable `-n` option by default.
>
> +grep.columnNumber::
> +       If set to true, enable `-m` option by default.
> +
>  grep.patternType::
>         Set the default matching behavior. Using a value of 'basic', 'extended',
>         'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,

You're doing what the immediate neighbours are doing, but the end result
is a bit inconsistent: columnnumber vs columnNumber. I think the ideal
end-game is columnNumber, lineNumber, and so on.

Maybe use "columnNumber" consistently since you're introducing it and
want it to be perfect from the start ;-) and if that leaves "linenumber"
looking too inconsistent, then change it while at it? (I'm not suggesting
changing all foobar to fooBar while at it...)

Martin
