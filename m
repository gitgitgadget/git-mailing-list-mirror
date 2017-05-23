Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 049AC20281
	for <e@80x24.org>; Tue, 23 May 2017 19:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933426AbdEWTI5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:08:57 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33369 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757621AbdEWTI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:08:56 -0400
Received: by mail-pf0-f171.google.com with SMTP id e193so123418416pfh.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 12:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f4hhn3C6xUBlD1fRxusGmIdyLyjasRID9++fV9GgAVE=;
        b=FTfvLA2C/OMAZ+r1AeIGp8UJIFPvMSdwTuB00JaZNsLdBzb1FWZviGewhryqlATb7B
         JXBdY07iWzDh+Z1U9QMnH/wUtw+BUaryGIAMn6NLkmYaAdrMt7TSjIlsoyF7LCt8+UN5
         /6+rj+eWN2SvqtJHvWUA026+ERbvKct2t1JmQodQ23MKaW7iY8mIlNYBNjX3EjKQTCwK
         2SZp4tRXx3NrQ0SI3sp7QPc3ynhFZKS5HpjOaPessGVbgsO3XSwQtPpITw4goC6I3iez
         PN2HNT7y6OThOfia4pJpPGiEuSXAMjKtR2vh0BFPJ8Z/7dSiZS4sngFgW4PIdS0k+rq8
         twLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f4hhn3C6xUBlD1fRxusGmIdyLyjasRID9++fV9GgAVE=;
        b=uK+5ac9y7ZS6Q1tdMzzb2hms/7wRHnCXhqFnhpW/lDgw0h8Xik7p/Y/2TRjuBG0ZEu
         tCqGnXjQdZh6CuhCMTft+1YWEJWuqahST7N7Ov4SJcI/M3nWZradMTXqdcsCfqxfyuHT
         zsgJLH2dJ6l4fWHs1aMy0IQTAmSK0GuLz5yIu/ZevjT0AR3dIHl8RdiUgMSemjhk89hu
         RZ9rg2u44n0h0M/rVh0RP535c7TlcW6VzqFM+cRj548Kz8yt1Dg9ZHeLjzhxxRqDq+QR
         pML2kIRddTk3Qq5ec4ufemj7Nq4iD+zsou2L68BOatToBrdbH0aAY/bb+eQ1ak+CZW4O
         WThw==
X-Gm-Message-State: AODbwcBAVlG5MydqIVLvVW4GFjFR6AzxQg7dPaj7vyyVHKyth78I/2rn
        dQnPLS0MZ4QKLcVqG2V6RMJoZrKb6ZEX
X-Received: by 10.99.60.81 with SMTP id i17mr33986691pgn.183.1495566535723;
 Tue, 23 May 2017 12:08:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 23 May 2017 12:08:55 -0700 (PDT)
In-Reply-To: <xmqqwp98j8q2.fsf@gitster.mtv.corp.google.com>
References: <xmqqwp98j8q2.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 23 May 2017 12:08:55 -0700
Message-ID: <CAGZ79kZMJP7K5MU0UujuEatZ2MOrSnFpfD707aSGa64mKyCZbw@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2017, #07; Tue, 23)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2017 at 1:08 AM, Junio C Hamano <gitster@pobox.com> wrote:

> * sb/submodule-blanket-recursive (2017-05-23) 6 commits
>  . builtin/push.c: respect 'submodule.recurse' option
>  . builtin/grep.c: respect 'submodule.recurse' option
>  . builtin/fetch.c: respect 'submodule.recurse' option
>  . Introduce submodule.recurse option for worktree manipulators
>  . submodule test invocation: only pass additional arguments
>  . submodule.c: add has_submodules to check if we have any submodules
>  (this branch uses sb/reset-recurse-submodules.)
>
>  A new configuration variable "submodule.recurse" can be set to true
>  to force various commands run at the top-level superproject to
>  behave as if they were invoked with the "--recurse-submodules"
>  option.
>
>  Seems to break t7814 when merged to 'pu'.

I will investigate! (It passes on its own, so I guess it is some
interference with a recent grep series)


> * sb/diff-color-move (2017-05-23) 17 commits
>  . diff.c: color moved lines differently
>  . diff: buffer all output if asked to
>  . diff.c: emit_line includes whitespace highlighting
>  . diff.c: convert diff_summary to use emit_line_*
>  . diff.c: convert diff_flush to use emit_line_*
>  . diff.c: convert word diffing to use emit_line_*
>  . diff.c: convert show_stats to use emit_line_*
>  . diff.c: convert emit_binary_diff_body to use emit_line_*
>  . submodule.c: convert show_submodule_summary to use emit_line_fmt
>  . diff.c: convert emit_rewrite_lines to use emit_line_*
>  . diff.c: convert emit_rewrite_diff to use emit_line_*
>  . diff.c: convert builtin_diff to use emit_line_*
>  . diff.c: convert fn_out_consume to use emit_line
>  . diff: introduce more flexible emit function
>  . diff.c: factor out diff_flush_patch_all_file_pairs
>  . diff: move line ending check into emit_hunk_header
>  . diff: readability fix
>
>  "git diff" has been taught to optionally paint new lines that are
>  the same as deleted lines elsewhere differently from genuinely new
>  lines.
>
>  Seems to break t4060 when merged to 'next'.

It breaks own its own, but when merged to next it breaks, too. :(

The reason for this is the submodule color thing that I added
last minute as manual inspection of submodule diffs seemed
odd to me.

It turns out submodule diffs were never colored appropriately,
so I'll resend with this interdiff (that let's test pass again),
once the discussion settles:

diff --git a/submodule.c b/submodule.c
index 428c996c97..19c63197fb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -550,8 +550,6 @@ void show_submodule_inline_diff(struct
diff_options *o, const char *path,

        /* TODO: other options may need to be passed here. */
        argv_array_push(&cp.args, "diff");
-       if (o->use_color)
-               argv_array_push(&cp.args, "--color=always");
        argv_array_pushf(&cp.args, "--line-prefix=%s", diff_line_prefix(o));
        if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
                argv_array_pushf(&cp.args, "--src-prefix=%s%s/",
