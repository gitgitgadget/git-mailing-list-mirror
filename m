Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7254A1FD09
	for <e@80x24.org>; Sun, 28 May 2017 18:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750950AbdE1S1A (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 14:27:00 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:32816 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdE1S07 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 14:26:59 -0400
Received: by mail-io0-f174.google.com with SMTP id p24so31581799ioi.0
        for <git@vger.kernel.org>; Sun, 28 May 2017 11:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dz+sJtNYVQGhtWWxbaT5BFOy/yUgfnULhzEwJgdknY0=;
        b=e9/zjX5uSSlJySolZp11vjE/m5hZgGJQgFe5BUvk5KUN7SnCTxYLJGwRn5QGAjA+x5
         B0VHHrDIKX3rLKlkwE2klKLnjNOBkh5+vQKgpZlpy9iPQ401uwOIGfPYpd/kJsn9Wy2C
         pRYsk/ENhhpmOczmuzeCTg30SBVoKs4XeZUuQGBsHqFf//B+HKRC5x+0I7gY1Ac/8MPY
         e7r2lSnbMTfxXhhV0yvTfAqw/b0xXIcMr1yQGkUfHA+1bEyhlfVtmnLwbEuJ2geFWY2a
         hsBypFy4kox0h5NPa8KhApCANLNwmb09e/CpxBACfSjmGcJG7+1PZYjaEoF3SUdz2Juq
         hPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dz+sJtNYVQGhtWWxbaT5BFOy/yUgfnULhzEwJgdknY0=;
        b=TfLccrqWRedNPqGHaEAwnxN1XbmEKvg9lIvX00CJuxE8SrpRWHUiEDi/oauxNQqB6o
         znwBgV7o1rUaPsIkUN/2PjMyc7Nh+4xDxAqOlxd+3SzBb9/+J7l3Mlku8/EhmGLzLOzP
         pH8sTUmC3QuTkNChv8UPZyiAHXEYOdS4MQockJpfpH1fSQvO2eD0n1KU89uQs/1KxM7I
         phaa/lbV0Js+88suFjQUwygIGFz9CKNczxLYtifaW2zLSekeB5jlBNpouUOgo+xjqxqf
         JhxiKLOgF8jBR5luI/mK93HcRh1Lvw6n6r+vKQNdxD5a++XrpfwulD++7tp5EBcpU6kg
         G0Sw==
X-Gm-Message-State: AODbwcBGx8V8gh2ZsBVa2zqFPmQaCz4ohGhOiCCu7ZP0RwDSRbrxyS4C
        3bxPEf2CxOmIFDlYloWenukUOleCLQ==
X-Received: by 10.107.201.131 with SMTP id z125mr9554433iof.160.1495996008383;
 Sun, 28 May 2017 11:26:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sun, 28 May 2017 11:26:27 -0700 (PDT)
In-Reply-To: <20170528165642.14699-5-joel@teichroeb.net>
References: <20170528165642.14699-1-joel@teichroeb.net> <20170528165642.14699-5-joel@teichroeb.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 28 May 2017 20:26:27 +0200
Message-ID: <CACBZZX5cxkV4C42OwJ077b1XMHCk+uTCbdHV9Ez5EVStR4DWxg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] stash: implement builtin stash
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>, t.gummerer@gmail.com,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 28, 2017 at 6:56 PM, Joel Teichroeb <joel@teichroeb.net> wrote:
> Implement all git stash functionality as a builtin command

First thanks for working on this, it's great. Applied it locally,
passes all tests for me. A couple of comments Christian didn't cover

> +       info->has_u = get_sha1_with_context(u_commit_rev.buf, 0, info->u_commit.hash, &unused) == 0 &&
> +               get_sha1_with_context(u_tree_rev.buf, 0, info->u_tree.hash, &unused) == 0;
> +
> +
> +       /* TODO: Improve this logic */
> +       strbuf_addf(&symbolic, "%s", REV);
> +       str = strstr(symbolic.buf, "@");

Could you elaborate on how this should be improved?


> +static int patch_working_tree(struct stash_info *info, const char *prefix,
> +               const char **argv)
> +{
> +       const char *stash_index_path = ".git/foocache2";

This foocache path isn't created by the shell code, if it's a new
thing that's needed (and I haven't followed this code in detail, don'n
know what it's for) shouldn't we give it a more descriptive name so
that if git crashes it's obvious what it is?

> +       const char *message = NULL;
> +       const char *commit = NULL;
> +       struct object_id obj;
> +       struct option options[] = {
> +               OPT_STRING('m', "message", &message, N_("message"),
> +                        N_("stash commit message")),
> +               OPT__QUIET(&quiet, N_("be quiet, only report errors")),
> +               OPT_END()
> +       };
> +       argc = parse_options(argc, argv, prefix, options,
> +                                git_stash_store_usage, 0);

Nit: In general in this patch the 2nd line of parse_options doesn't
align with a tabwidth of 8. Ditto for indenting function arguments
(e.g. for untracked_files).
