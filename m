Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5361F424
	for <e@80x24.org>; Wed,  9 May 2018 16:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965082AbeEIQRw (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 12:17:52 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43011 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933573AbeEIQRv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 12:17:51 -0400
Received: by mail-ot0-f193.google.com with SMTP id y10-v6so40774192otg.10
        for <git@vger.kernel.org>; Wed, 09 May 2018 09:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7Q9O9Y0fSA5IUbEk0zy8QX+rwCdRveP5sjS5ZQBukCo=;
        b=cUw8BH8RWfAg5xKWOKGwt0103MK5gB9aj7hgGY+sSZW7a41I35FXur8N6F2m2hp9Hc
         Gd7qKoA9T0VGhu+BbOtBmwEED0Cs3iQ0rWWaxW31fCmHlku0DzAa2PuHMTvRLyvApQ6k
         ehx5MRWkklrsZ5FEqNWLCWoarftZLTDhQzjDbhTVlfRHV5EUzy/f2KkBlwr192DZEq1L
         8atoJWXTMOKO1EcEo9ZxHH+MnMRQvrnLut77P8iqyxFsUWboScW5yTzdUJ5cRXj6u1dk
         WgGGYMMPdn6b4hl5FztHdusFa8bziMDnJN3eOsD0CWqA44jOphepBat6+MiAXy9tfzC5
         fmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7Q9O9Y0fSA5IUbEk0zy8QX+rwCdRveP5sjS5ZQBukCo=;
        b=Bi2U/AztLiN9lqBdrqsnaPevtr+wlNfqjwGgCWEWbT3Os2RcmxEToIMtLEabi+fA5l
         olOoIyAvdFGDZQ3ugHq8e5Rl4b48sO+L2Gix8qLl88F8IgPygr/5VowjRLw17FL04phQ
         wcfsUfTXgXpcvWKARS4ZvHKUbwLNKQMilQ6vgqf9q9QSCDMN4b3kA7RF/4ydYXSa+FGt
         HdS8trQux7XCiZTJtoJ2Vz3OV+9u8P8cPucMPzx8hs/YB5EThB+mdQ1MMDOOx2crx5/G
         VT46yEG2Pf2F7k2fcQgNS3z5ZahT7COxuTpBR8PR2zuH/UH05TH0oFoldaliJ8qfCrqr
         SD2g==
X-Gm-Message-State: ALQs6tDAjQiEFtuLhwg+MDfdGWZN8r9xYlKKE0QWqsQ9jrB7F3DKfQJj
        JIN6SqL+ibS8z7AyS6moqGcUVxEI2BQO4KPU1og=
X-Google-Smtp-Source: AB8JxZrBV5qOU86OgwfYfQLy+pthgMzDG1kyKLIPhSxnnm6RWdnKGqHvReN/q/w1XFil37sxKFTTooL0Gc67COAoOjI=
X-Received: by 2002:a9d:e8f:: with SMTP id 15-v6mr24378429otj.14.1525882671017;
 Wed, 09 May 2018 09:17:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Wed, 9 May 2018 09:17:20 -0700 (PDT)
In-Reply-To: <9222f0ee470884a984c1174cf218dece43f77f87.1525831201.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local> <cover.1525831201.git.me@ttaylorr.com>
 <9222f0ee470884a984c1174cf218dece43f77f87.1525831201.git.me@ttaylorr.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 9 May 2018 18:17:20 +0200
Message-ID: <CACsJy8DLthWhxH6a7zwCvdirkuntanHasXZwfdADeo7iV8X79w@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] builtin/grep.c: add '--column' option to 'git-grep(1)'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>, phillip.wood@talktalk.net,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 9, 2018 at 4:13 AM, Taylor Blau <me@ttaylorr.com> wrote:
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 5f32d2ce84..f9f516dfc4 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -829,6 +829,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>                             GREP_PATTERN_TYPE_PCRE),
>                 OPT_GROUP(""),
>                 OPT_BOOL('n', "line-number", &opt.linenum, N_("show line numbers")),
> +               OPT_BOOL(0, "column", &opt.columnnum, N_("show column number of first match")),

Two things to consider:

- do we ever want columnar output in git-grep? Something like "git
grep --column -l" could make sense (if you don't have very large
worktree). --column is currently used for column output in git-branch,
git-tag and git-status, which makes me think maybe we should reserve
"--column" for that purpose and use another name here, even if we
don't ever want column output in git-grep, for consistency.

- If this is to help git-jump only and rarely manually specified on
command line, you could add the flag PARSE_OPT_NOCOMPLETE to hide it
from "git grep --<tab>" completion. You would need to use OPT_BOOL_F()
instead of OPT_BOOL() in order to add extra flags.
-- 
Duy
