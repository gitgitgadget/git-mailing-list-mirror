Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13C76208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 19:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389445AbeHGV2r (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 17:28:47 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37875 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388948AbeHGV2q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 17:28:46 -0400
Received: by mail-yw1-f67.google.com with SMTP id w76-v6so5350890ywg.4
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 12:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d5feJEfiYM7YuIholhsNWpLqyKjT4/w6RMfHGKXOoJU=;
        b=pKWJn1puFv2rq6bBg46KDiJSDdLw4dgH7qGqe4G3A0iWB9MYA/EVXNo5rw+ROQSJ9z
         Dsm4Vc4NHC8zkzx7+uwjnk1qn7+oVL9PgrltWu/9V/fV2d3+RHq8j/YBMXM0+XNeI0cK
         +cgK0RAbnJiQVfsqOcw6o4II0ISBovyY0JyTrh+q/263S8k76KD6pdB51w3eUdZSF18f
         Gs8bvLdXzLh9Vq97vkeT/PNj5DjnWoNUUm205RM2tMoeIdpnFWYDSiiTdYgMGJBGl6zY
         2Ni1lNfRL9tRT7rxqx6W4YEmyJxUrLSCkDx0V6iJ1mJ/5O6b36pr7wCIWzn3xM/fAVKl
         O6Gw==
X-Gm-Message-State: AOUpUlEtFsGFMTa/IcEWfkrJJJ2Loi45BMY6CQ0uXwPZ3nkmz/qSMsud
        cUPai50ZI0FHk8epvtvgdsDUCpvTvcH88ng699BUt603
X-Google-Smtp-Source: AAOMgpcARBzPIe2ueD2zzQy8vBwuBRLVCKVdwmW+ArjMuZSIUZcawl46TILFi/pNfG3+oKyIHJN0dxjIFWpc3NTIdHw=
X-Received: by 2002:a81:4153:: with SMTP id f19-v6mr11117962ywk.418.1533669177635;
 Tue, 07 Aug 2018 12:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180807132113.118297-1-gitter.spiros@gmail.com>
In-Reply-To: <20180807132113.118297-1-gitter.spiros@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 7 Aug 2018 15:12:46 -0400
Message-ID: <CAPig+cS-b2yL2FeLRzS+jW-O5fRd1g8Kqak7j1QX5PRP0ojQEQ@mail.gmail.com>
Subject: Re: [PATCH] worktree: add --quiet option
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Karen Arutyunov <karen@codesynthesis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(cc:+Karen Arutyunov[1]; perhaps also do so when you re-roll)

In addition to the good review comments by Martin and Duy...

On Tue, Aug 7, 2018 at 9:21 AM Elia Pinto <gitter.spiros@gmail.com> wrote:
> Add the '--quiet' option to git worktree add,
> as for the other git commands.

It might make sense to say instead that this is adding a --quiet
option _in general_, rather than doing so specifically for 'add'.
Then, go on to say that, at present, 'add' is the only command
affected by it since all other commands are currently silent by
default (except, of course, 'list').

Whether you like that idea or not, as Martin suggested, please do say
something in the commit message about why the other commands don't
need it.

> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -115,7 +115,9 @@ Unlock a working tree, allowing it to be pruned, moved or deleted.
>  OPTIONS
>  -------
> -
> +-q::
> +--quiet::
> +       With 'add', suppress feedback messages.
>  -f::
>  --force::

In addition to the blank-line issues Martin raised, please move this
hunk downward to be a neighbor of the --verbose option.

REFERENCES
[1]: https://public-inbox.org/git/02659385-334f-2b77-c9a8-ffea8e461b0b@codesynthesis.com/
