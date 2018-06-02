Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D42051F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 18:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbeFBSDY (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 14:03:24 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37138 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbeFBSDX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 14:03:23 -0400
Received: by mail-wr0-f196.google.com with SMTP id d8-v6so7958456wro.4
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Pwyav4AkQIpGWiuLxXKFoAMTO6HGz3IjmfJLqo7UrbE=;
        b=n/U0MsQQOANDdht9DeRycXwVutQeB2a3h/NrpH/MLqAgJQ5nom0epHjl9yAULg0ZrM
         Nwh8riCbyVaxsYgtnzRJv1PPF2wnLNi2vdWLeG8DerP6pMVva0XfO4+HjQfWk+DcukeV
         EOzbIjEOO6Rszxc+82JEWyjrWhRLz3Tf8RRPNhn+Jt+DWMV6a/RYtrgxj5G6Tp4phEzE
         K01yYO3NrZb6sIi0pJ0I0S0jwngYLZxtX4F1ciGqDsXHbVUrdWBHPZCj3vz+LSmI5DfM
         OxpRBkpUw2uTHkQo/pNtOyFHkoJ2U7kHCKAqPZ67fpNIW/FJJZKycWJK33OBfWLbdoki
         0e7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Pwyav4AkQIpGWiuLxXKFoAMTO6HGz3IjmfJLqo7UrbE=;
        b=MAPocZb0UyZMkw3jTHhHtpNP4RTZ/12RSZt9XAyR0m+6TszlYd0iXMd8bJBnknI2J2
         KhnzD9C7SD0+Tg/cEaslasN4Ow2xz9YSXdkQMX4KexybD3OYOT44ji1yoiXR5aTxBOrU
         BTfNWO3HVvaIbnp61RUU5y/0InK0n+q5C/eayt4O4wwi4bQa5CbSsF8igRlvOKw7uimo
         CIgzXBO7bd7OXw+3MYDl065oWIvzMdu8WyKYfqaFmCmhQzzaA8JrelxlirevILooU925
         hgLxhvVXiOZwuUdk0tUN7lF+h0NUGQO17csb42JKF0KtHexkzMJEK9/xVBug9PWGw8fk
         UQhA==
X-Gm-Message-State: ALKqPwdv/cWrxyil2ym8Cu+Codst2YYli4qNusuxJw91+udleU/x21L8
        lHOx3RuWsxJLnn+5XA6UbFU=
X-Google-Smtp-Source: ADUXVKLSNfVvvCot5V1nKTmi5s3mM6Kq1P/hrigjgGCmEauc6rzT2bgdb4eb3dRu5bWsNN5CpfOYhA==
X-Received: by 2002:adf:adcb:: with SMTP id w69-v6mr12692773wrc.101.1527962602389;
        Sat, 02 Jun 2018 11:03:22 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abri204.neoplus.adsl.tpnet.pl. [83.8.102.204])
        by smtp.gmail.com with ESMTPSA id v14-v6sm14488379wro.33.2018.06.02.11.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Jun 2018 11:03:21 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 19/20] gc: automatically write commit-graph files
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-20-dstolee@microsoft.com>
Date:   Sat, 02 Jun 2018 20:03:18 +0200
In-Reply-To: <20180524162504.158394-20-dstolee@microsoft.com> (Derrick
        Stolee's message of "Thu, 24 May 2018 16:26:09 +0000")
Message-ID: <866031rrq1.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> The commit-graph file is a very helpful feature for speeding up git
> operations. In order to make it more useful, write the commit-graph file
> by default during standard garbage collection operations.

I think you meant here "make it possible to write the commit-graph file
during standard garbage collection operations." (i.e. add "make it
possible" because it hides behind new config option, and remove "by
default" because currently it is not turned on by default).

>
> Add a 'gc.commitGraph' config setting that triggers writing a
> commit-graph file after any non-trivial 'git gc' command. Defaults to
> false while the commit-graph feature matures. We specifically do not
> want to turn this on by default until the commit-graph feature is fully

s/turn this on/have this on/  I think.

> integrated with history-modifying features like shallow clones.

Two things.

First, shallow clones, replacement mechanims (git-replace) and grafts
are not "history-modifying" features; this name is in my opinion
reserved for history-rewriting features such as interactive rebase, the
`git filter-branch` feature or out-of-tree BFG Repo Cleaner or
reposurgeon tools.  They alter the _view_ of history; they should be
IMVHO named "history-view-altering" features -- though I agree this is
mouthful.

Second, shouldn't we, as Martin =C3=85gren said, warn about the issue in the
manpage for git-commit-graph?

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/config.txt |  6 ++++++
>  Documentation/git-gc.txt |  4 ++++
>  builtin/gc.c             |  6 ++++++
>  t/t5318-commit-graph.sh  | 14 ++++++++++++++
>  4 files changed, 30 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 11f027194e..9a3abd87e7 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1553,6 +1553,12 @@ gc.autoDetach::
>  	Make `git gc --auto` return immediately and run in background
>  	if the system supports it. Default is true.
>=20=20
> +gc.commitGraph::
> +	If true, then gc will rewrite the commit-graph file after any
> +	change to the object database. If '--auto' is used, then the
> +	commit-graph will not be updated unless the threshold is met.

What threshold?  Ah, thresholds defined for `git gc --auto` (gc.auto,
gc.autoPackLimit, gc.logExpiry,...).

> +	See linkgit:git-commit-graph[1] for details.

You missed declaring the default value for this config option.

> +
>  gc.logExpiry::
>  	If the file gc.log exists, then `git gc --auto` won't run
>  	unless that file is more than 'gc.logExpiry' old.  Default is
> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index 571b5a7e3c..17dd654a59 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -119,6 +119,10 @@ The optional configuration variable `gc.packRefs` de=
termines if
>  it within all non-bare repos or it can be set to a boolean value.
>  This defaults to true.
>=20=20
> +The optional configuration variable 'gc.commitGraph' determines if
> +'git gc' runs 'git commit-graph write'. This can be set to a boolean

Should it be "runs" or "should run"?

> +value. This defaults to false.

Should it be '...' or `...`?  Below we have `gc.aggresiveWindow`, above
we have 'gc.commitGraph', for example.

> +
>  The optional configuration variable `gc.aggressiveWindow` controls how
>  much time is spent optimizing the delta compression of the objects in
>  the repository when the --aggressive option is specified.  The larger
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 77fa720bd0..efd214a59f 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -20,6 +20,7 @@
>  #include "argv-array.h"
>  #include "commit.h"
>  #include "packfile.h"
> +#include "commit-graph.h"
>=20=20
>  #define FAILED_RUN "failed to run %s"
>=20=20
> @@ -34,6 +35,7 @@ static int aggressive_depth =3D 50;
>  static int aggressive_window =3D 250;
>  static int gc_auto_threshold =3D 6700;
>  static int gc_auto_pack_limit =3D 50;
> +static int gc_commit_graph =3D 0;
>  static int detach_auto =3D 1;
>  static timestamp_t gc_log_expire_time;
>  static const char *gc_log_expire =3D "1.day.ago";
> @@ -121,6 +123,7 @@ static void gc_config(void)
>  	git_config_get_int("gc.aggressivedepth", &aggressive_depth);
>  	git_config_get_int("gc.auto", &gc_auto_threshold);
>  	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
> +	git_config_get_bool("gc.commitgraph", &gc_commit_graph);
>  	git_config_get_bool("gc.autodetach", &detach_auto);
>  	git_config_get_expiry("gc.pruneexpire", &prune_expire);
>  	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire=
);
> @@ -480,6 +483,9 @@ int cmd_gc(int argc, const char **argv, const char *p=
refix)
>  	if (pack_garbage.nr > 0)
>  		clean_pack_garbage();
>=20=20
> +	if (gc_commit_graph)
> +		write_commit_graph_reachable(get_object_directory(), 0);
> +

Nice.

Though now I wonder when appending should be used...

>  	if (auto_gc && too_many_loose_objects())
>  		warning(_("There are too many unreachable loose objects; "
>  			"run 'git prune' to remove them."));
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index a659620332..d20b17586f 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -245,6 +245,20 @@ test_expect_success 'perform fast-forward merge in f=
ull repo' '
>  	test_cmp expect output
>  '
>=20=20
> +test_expect_success 'check that gc clears commit-graph' '

I wouldn't use the word "clears" here...

> +	cd "$TRASH_DIRECTORY/full" &&
> +	git commit --allow-empty -m "blank" &&
> +	git commit-graph write --reachable &&
> +	cp $objdir/info/commit-graph commit-graph-before-gc &&
> +	git reset --hard HEAD~1 &&
> +	git config gc.commitGraph true &&
> +	git gc &&
> +	cp $objdir/info/commit-graph commit-graph-after-gc &&
> +	! test_cmp commit-graph-before-gc commit-graph-after-gc &&
> +	git commit-graph write --reachable &&
> +	test_cmp commit-graph-after-gc $objdir/info/commit-graph
> +'

...but otherwise, nice test: it checks that git-gc after rewriting
history changes commit-graph file, and that the changed file is what we
expect it to be (note: here we compare commit-graph files directly, and
not just check the features via 'git commit-graph read').

> +
>  # the verify tests below expect the commit-graph to contain
>  # exactly the commits reachable from the commits/8 branch.
>  # If the file changes the set of commits in the list, then the
