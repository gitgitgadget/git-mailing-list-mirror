Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EBF520A26
	for <e@80x24.org>; Wed, 27 Sep 2017 20:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbdI0Ukd (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 16:40:33 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:56506 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbdI0Ukc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 16:40:32 -0400
Received: by mail-qk0-f180.google.com with SMTP id g128so14584018qke.13
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 13:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0n18kKdc98A+leRFFQwkWIn0CSXJkjBrEdZLpE5XoLM=;
        b=Pp4iyQtPpWBgsOaFXL9yP62+nCS1FJJqLEJrp88Ts4l8q5/vJOo1FxGzM+ybVcHITM
         71VM7W9oHwrP6W8hLGkVJEFFtHSBjfWU51sX3MkhWuuJl83pZcZNnsAD51FtfMMwScVT
         aEAz4Zn/ecTUEXuawv5MgXx/Y1am9lnC4oXKiX0/LBaiBhXGA6HIuTZ+XDvpcE1c0hYk
         /5GzA/iIMa+ThZuIOUydyTY92V9AQZW345juGnf4pOIY6sQAMttQMs9chaa8o5AwedhU
         QtoUz2OEcT5p3C8qyBUpDTC5f1tgq/62fOmAA4dzRE2bFDLdmYY46b564AxrtPWsDl2V
         wq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0n18kKdc98A+leRFFQwkWIn0CSXJkjBrEdZLpE5XoLM=;
        b=IZwlZR5j4T9lEP7jODGXAGoUMtsDEO8D9COEN2yY0CRZoM2PJp1pArCq0CNjc72/rq
         o0j4dwf0KPSBp2IibWF6QRZn1i/tYuR7XkBuL2s0n21Z5XwXgpSufTss8CE2J6Tv2LkR
         PsXhkaHutdupBI3rHEiYMGBCNFewbefo5j59lWb95DagGg1kmQL2uH6Yc1ufDX6Na2mQ
         Fl0oEPeJyu+i6M2GT36G69GFW6PeEnXDcZ3smo93C4/etgkta+CbVFnJw+CzqPo6xmJj
         pzungbxhRHi3+wMTBCIhjwknFv85LgMfQgAvzUsPuEdNqh5STeorZQy4+bPFLeC73E6h
         K//g==
X-Gm-Message-State: AHPjjUjoyLbJpjcHTlMmPHHKdarJ0V98R/kjIOfkH2T0DqxXQ04sDaY9
        UVXliRtLt4yGCGxzPHf0FWh7IKrPehlTvYMtRkSZgQ==
X-Google-Smtp-Source: AOwi7QCdY3LgbqzlwrtOk+buk41Ew0S8NSvKCgyTDqr05ASv4fzuNFzAevwEryf41FO3ZJb2uNPGYdNVTNLOWXjH+44=
X-Received: by 10.55.90.199 with SMTP id o190mr4357366qkb.180.1506544831235;
 Wed, 27 Sep 2017 13:40:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Wed, 27 Sep 2017 13:40:30 -0700 (PDT)
In-Reply-To: <CA+55aFzThd6cayUVuv39k=sb8KCphLkWGCV4n2HUjfn7Pxkd3g@mail.gmail.com>
References: <CA+55aFzThd6cayUVuv39k=sb8KCphLkWGCV4n2HUjfn7Pxkd3g@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 27 Sep 2017 13:40:30 -0700
Message-ID: <CAGZ79kZF5w7ucbUCKJAuAbz2KBoMJjWneAxFcjOPeted8SBNmg@mail.gmail.com>
Subject: Re: diffstat summary mode change bug
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 11:15 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> (ok, linewrapping in this email may make that look wrong - but the
> "mode change" land the "create mode" are both on the same line.

Thanks for the bug report.

> and the reason seems to be that the '\n' at the end got dropped as the
> old code was very confusing (the old code had two different '\n' cases
> for the "show filename or not").

I disagree with this analysis, as the fix you propose adds the
new line unconditionally, i.e. this code path would be broken
regardless of "show filename or not".

Both search for "create mode" and "mode change" results in
hits in the test suite, so we should have caught this.
I wonder why our tests failed to tell us about this.

Specifically we have t4100/t-apply-4.expect
  mode change 100644 => 100755 t/t0000-basic.sh
  mode change 100644 => 100755 t/test-lib.sh
which would seem to exercise this code path.

The code *looks* correct, but I am full of doubts now.

Stefan

> I think the right fix is this whitespace-damaged trivial one-liner:
>
>   diff --git a/diff.c b/diff.c
>   index 3c6a3e0fa..653bb2e72 100644
>   --- a/diff.c
>   +++ b/diff.c
>   @@ -5272,6 +5272,7 @@ static void show_mode_change(struct
> diff_options *opt, struct diff_filepair *p,
>                           strbuf_addch(&sb, ' ');
>                           quote_c_style(p->two->path, &sb, NULL, 0);
>                   }
>   +               strbuf_addch(&sb, '\n');
>                   emit_diff_symbol(opt, DIFF_SYMBOL_SUMMARY,
>                                    sb.buf, sb.len, 0);
>                   strbuf_release(&sb);
>
> but somebody should double-check that.
>
>                         Linus
