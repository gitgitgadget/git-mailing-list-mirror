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
	by dcvr.yhbt.net (Postfix) with ESMTP id 22B561F454
	for <e@80x24.org>; Sun,  3 Nov 2019 19:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfKCT7a (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 14:59:30 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38052 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfKCT73 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 14:59:29 -0500
Received: by mail-lf1-f67.google.com with SMTP id q28so10680468lfa.5
        for <git@vger.kernel.org>; Sun, 03 Nov 2019 11:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xE68Bf0/4SHc3uPwfvnWmJImikI6lzxGzutnaCUm7EQ=;
        b=Tkdryba8FLei+p0QWqIDvQs3xex+Lmgpq2s2XFqJ7Swkaqw/rJTD+v94ax0MJI2sOj
         9Ac5euWgKYUTFHLcmDyw5shyYjivXNivaQTMSS3HG780EMgCbeyXfwQV74nY9M0vCgDV
         O9MyyKMUOXFaGSXe+KaWd1Y2Hi4MFWFX7h/SVpCA7aOv/1oEUM+SnRbYbI1NKE4wXVfZ
         gbvE4YtVKpNl7GjgC0HCSJVGXL5SqPp+KgxnFZ3sS363cS/1WHB97Ewfug1LC89I08g4
         NSL8JYcF3QgU6lhCcHTDuDpfqHIXkVOUoGdGMqutETtX0v7RAccpDmeGYsDxbKrvLuaB
         lVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=xE68Bf0/4SHc3uPwfvnWmJImikI6lzxGzutnaCUm7EQ=;
        b=HqtsfQZmXcMWWwPPEalxxwf3ULN1mDA1voRGJjWZezzLT311Apu8brlKg9jT7jruNu
         EWQST913K2CuazOPnsoYXL7BipfBpMtXlFLv+Zu439FrMQD/31/sA2lhpqw7BPqN+z6k
         2xGUKgVUhxT/h5OJXolqI5oVqO2qcGddZgKfyHbzJEAnvUpinCOKOubaXUYyz26DXJnq
         pPO5pmkaMbLtkmQahhWSbgLodVPA5ShUi3VnQK8fUWULiQ1Mt4jOJD/L1+EH7reln6sd
         1Df2dALC0y1LXDaBlZlBEzPrPm/p4driFUTqsZ1WgRUtM7bQKlOkHsG1VM3SxxqVYzNj
         CohQ==
X-Gm-Message-State: APjAAAXPni52kuYC7ZWjxffr+/x/wujBBLPfdw++twULAeSPY+CmHK9H
        VS74tLwqVzS4fpnKqMCEDMA=
X-Google-Smtp-Source: APXvYqw1fsnEXJ8bGKgjrRxEhRn+1QzsvRRt1xTjapy2dV7OPfb3atGl8FUSuQREmbXTJAnl9lan8w==
X-Received: by 2002:a05:6512:146:: with SMTP id m6mr13729211lfo.98.1572811166663;
        Sun, 03 Nov 2019 11:59:26 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id b23sm5929801lfj.49.2019.11.03.11.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Nov 2019 11:59:26 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Abimbola via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Abimbola Olaitan <craftwordltd@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] remove-annotate: change cmd_annotate to cmd_blame
References: <pull.442.git.1572753114.gitgitgadget@gmail.com>
        <6e164528059529fe07a53f0cfceb22a388a6758b.1572753114.git.gitgitgadget@gmail.com>
Date:   Sun, 03 Nov 2019 20:59:24 +0100
In-Reply-To: <6e164528059529fe07a53f0cfceb22a388a6758b.1572753114.git.gitgitgadget@gmail.com>
        (Abimbola via GitGitGadget's message of "Sun, 03 Nov 2019 03:51:50
        +0000")
Message-ID: <86tv7khgtf.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abimbola via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH 1/5] remove-annotate: change cmd_annotate to cmd_blame
> From: Abimbola <craftwordltd@gmail.com>
>
> Changing this command is to remove the annotate.c file which does almost
> the same thing as blame.c. git annotate will invoke blame directly

Both the summary and the detailed description of the changes is not
entirely clean.  What is this 'remove-annotate' subsystem?  Why we would
want to change cmd_annotate to cmd_blame -- and wouldn't we loose
difference (in defaults, and thus in output format) between git-blame
and git-annotate?

>
> Signed-off-by: Abimbola <craftwordltd@gmail.com>

Why not

  Signed-off-by: Abimbola Olaitan <craftwordltd@gmail.com>

> ---
>  git.c | 143 +++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 82 insertions(+), 61 deletions(-)

Looks like a big change, strangely.  And annotate.c is not actually
deleted...

>
> diff --git a/git.c b/git.c
> index ce6ab0ece2..84042846b5 100644
> --- a/git.c
> +++ b/git.c
> @@ -5,17 +5,17 @@
>  #include "run-command.h"
>  #include "alias.h"
>=20=20
> -#define RUN_SETUP		(1<<0)
> -#define RUN_SETUP_GENTLY	(1<<1)
> -#define USE_PAGER		(1<<2)
> +#define RUN_SETUP (1 << 0)
> +#define RUN_SETUP_GENTLY (1 << 1)
> +#define USE_PAGER (1 << 2)

Please, please do not include such unnecessary (and possibly accidental)
changes.

It makes review harded (where are the actual changes), and it makes
merging it harder (as it can much more easily conflict with other
changes in flight).

Also, those changes that remove aligning of values make code less
readable, and would probably be rejected.

[skip whitespace-only changes (I hope)]

> -static void list_builtins(struct string_list *list, unsigned int exclude=
_option);
> +static void list_builtins(struct string_list *list,
> +			  unsigned int exclude_option);

This may be a good cleanup, but is unrelated to the change in question.
Better leave it to a separate patch.

[skip horizontal and vertical whitespace changes (I hope)]

> @@ -93,8 +94,7 @@ static int list_cmds(const char *spec)
>  			strbuf_add(&sb, spec + 5, len - 5);
>  			list_cmds_by_category(&list, sb.buf);
>  			strbuf_release(&sb);
> -		}
> -		else
> +		} else
>  			die(_("unsupported command listing type '%s'"), spec);
>  		spec +=3D len;
>  		if (*spec =3D=3D ',')

This may be a good cleanup, but is unrelated to the change in question,
Better leave it to another separate patch.

> @@ -467,7 +476,7 @@ static int run_builtin(struct cmd_struct *p, int argc=
, const char **argv)
>  static struct cmd_struct commands[] =3D {
>  	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
>  	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
> -	{ "annotate", cmd_annotate, RUN_SETUP | NO_PARSEOPT },
> +	{ "annotate", cmd_blame, RUN_SETUP },
>  	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
>  	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
>  	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },

That looks like the major portion of the change.  How the look and feel
of git-annotate command is preserved, though?

> @@ -478,10 +487,9 @@ static struct cmd_struct commands[] =3D {
>  	{ "check-attr", cmd_check_attr, RUN_SETUP },
>  	{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
>  	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
> -	{ "check-ref-format", cmd_check_ref_format, NO_PARSEOPT  },
> +	{ "check-ref-format", cmd_check_ref_format, NO_PARSEOPT },

This may be a good cleanup, but is unrelated to the change in question.
Better leave it to a patch.

Regards,
--=20
Jakub Nar=C4=99bski
