Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9072E20248
	for <e@80x24.org>; Mon,  8 Apr 2019 12:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfDHMpD (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 08:45:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36964 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHMpD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 08:45:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id l20so4049931edv.4
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 05:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=O4OiVtjKH4Hl3QjjqH9+D6pxUuuP5C/uxvMMuM3sW4M=;
        b=MBHUHVPlCMrHkZGwWKFROr4zzmzgKNQ7FA8KkB/l9+C2urjaiVMjxxA+sUeqJo5/EH
         X7qOx3+pkK+qNgX+DJMBROXdDWCWNqP6vcyqO3GXLqYI9L3wujkQ0gP91W9Mqc69ao9q
         uu6OEVAHMg65xLtL7I4vGeecig7AICICoaOXM6jL361yWoof1R7vr6602Vn2LklPYRb7
         GiL/apak4CaSCPcpjVavFrZD4xvK9NcfNkCJF2P9t8RYdgKH3fH5qaJkVvh6LsjjcQKp
         WjLzohofIowuAi7+aFPbVP+qhG7H8FSVyEZ/uZOJJBNxEwJ2UPhiIUNiuq4MfULjM+wx
         sviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=O4OiVtjKH4Hl3QjjqH9+D6pxUuuP5C/uxvMMuM3sW4M=;
        b=Q4dkqoSvFW52mv9MBwSNvdztOE7+orqo4Udg0KoHGO2YMEDqDZ6cf3lhn9JBP8THpL
         SXNFUqDsk++m017gBoyG9orexqIiHqldkUdc0ljl0dZGkTWHN0vTtOLiBKFEzlx1hq2B
         cIfUt2xz84wVu3jXuVG5vMiR43bZENORWNHtlFfTII17+wzsuOOGlKDJg3CP8PaakqFx
         Lp/5i094Npuct91o6mvl98+2LdqMJNQNK2i0f3If0pO7jP3gOJsnKbcGcrosbNNY+c/2
         uu0zVrWHxvmFIcAclVfGLvOb9aXm9cL0fqROJHtylVihRdDY9qeyfnlvysFPPFXZwMJA
         zURA==
X-Gm-Message-State: APjAAAWmci6HAJc13N+XEcZd9gSUs9yYYHGwSHVlzyNiczp1uc2c38Aq
        fNlLFMnnBzbxOItxzbsYjok=
X-Google-Smtp-Source: APXvYqzjthmKuWzOuTcufKkq/JfAoBgxm+qwoeW0fewNnrcCvFDQiBPMegmY4RWfIMlJdwcxhHG6mA==
X-Received: by 2002:a50:b323:: with SMTP id q32mr19074724edd.24.1554727500826;
        Mon, 08 Apr 2019 05:45:00 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id c9sm4288732ejb.1.2019.04.08.05.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 05:44:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] blame: default to HEAD in a bare repo when no start commit is given
References: <20190407234327.25617-1-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190407234327.25617-1-szeder.dev@gmail.com>
Date:   Mon, 08 Apr 2019 14:44:59 +0200
Message-ID: <878swkacok.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 08 2019, SZEDER G=C3=A1bor wrote:

> When 'git blame' is invoked without specifying the commit to start
> blaming from, it starts from the given file's state in the work tree.
> However, when invoked in a bare repository without a start commit,
> then there is no work tree state to start from, and it dies with the
> following error message:
>
>   $ git rev-parse --is-bare-repository
>   true
>   $ git blame file.c
>   fatal: this operation must be run in a work tree
>
> This is misleading, because it implies that 'git blame' doesn't work
> in bare repositories at all, but it does, in fact, work just fine when
> it is given a commit to start from.
>
> We could improve the error message, of course, but let's just default
> to HEAD in a bare repository instead, as most likely that is what the
> user wanted anyway (if they wanted to start from an other commit, then
> they would have specified that in the first place).
>
> 'git annotate' is just a thin wrapper around 'git blame', so in the
> same situation it printed the same misleading error message, and this
> patch fixes it, too.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>

There was the explicit decision not to fall back to HEAD in 1cfe77333f
("git-blame: no rev means start from the working tree file.",
2007-01-30). This change makes sense to me, but perhaps some discussion
or reference to the previous commit is warranted?

Although from skimming the thread from back then it seems to be "not
HEAD but working tree file", not "let's not use HEAD in bare repos".

>  builtin/blame.c     | 13 +++++++++++++
>  t/annotate-tests.sh |  8 ++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 177c1022a0..21cde57e71 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -27,6 +27,7 @@
>  #include "object-store.h"
>  #include "blame.h"
>  #include "string-list.h"
> +#include "refs.h"
>
>  static char blame_usage[] =3D N_("git blame [<options>] [<rev-opts>] [<r=
ev>] [--] <file>");
>
> @@ -993,6 +994,18 @@ int cmd_blame(int argc, const char **argv, const cha=
r *prefix)
>
>  	revs.disable_stdin =3D 1;
>  	setup_revisions(argc, argv, &revs, NULL);
> +	if (!revs.pending.nr && is_bare_repository()) {
> +		struct commit *head_commit;
> +		struct object_id head_oid;
> +
> +		if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
> +					&head_oid, NULL) ||
> +		    !(head_commit =3D lookup_commit_reference_gently(revs.repo,
> +							     &head_oid, 1)))
> +			die("no such ref: HEAD");
> +
> +		add_pending_object(&revs, &head_commit->object, "HEAD");
> +	}

With this patch, if I have a bare repo without a HEAD I now get:

    fatal: no such ref: HEAD

Instead of:

    fatal: this operation must be run in a work tree

Both are bad & misleading, perhaps we can instead say something like:

    die(_("in a bare repository you must specify a ref to blame from, we tr=
ied and failed to implicitly use HEAD"));

Along with a test for what we do in bare repos without a HEAD....?

>
>  	init_scoreboard(&sb);
>  	sb.revs =3D &revs;
> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
> index 6da48a2e0a..d933af5714 100644
> --- a/t/annotate-tests.sh
> +++ b/t/annotate-tests.sh
> @@ -68,6 +68,14 @@ test_expect_success 'blame 1 author' '
>  	check_count A 2
>  '
>
> +test_expect_success 'blame in a bare repo without starting commit' '
> +	git clone --bare . bare.git &&
> +	(
> +		cd bare.git &&
> +		check_count A 2
> +	)

....just 'git update-ref -d HEAD` after this and a test for 'git blame
<file>' here would test bare without HEAD.

>  test_expect_success 'blame by tag objects' '
>  	git tag -m "test tag" testTag &&
>  	git tag -m "test tag #2" testTag2 testTag &&
