Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7C9F1F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 16:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeFBQRo (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 12:17:44 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40604 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeFBQRm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 12:17:42 -0400
Received: by mail-wr0-f194.google.com with SMTP id l41-v6so39054205wre.7
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=fUM1gLT5XMFEhCN2IhiOsJDLJuBvB+gE1vCFOMLVlDY=;
        b=CWPRb1zZXim3HrP/yGVh2EjL5LTnXfrwgLO3SmOditoC7WPrD9kHeoqx8L1d182R6F
         s0R5vjuAhtUzVVAnOHx67qHd5FMgwH/1qoOi5fcl4UuXnCb4y2lanvCwu4qroeDQCViZ
         WjzWkfSsFJ2C9NihfC1NRCdJQMs1lWu7gilI4ZKs/OVV7AdLIrvgEJTa8IKEdAl3b477
         5j+y61lSa2RIYLj25ajqfVPlE+AwQzaCWCIeea2Z8HbZ6XkUWh5B4pANhtIJNfFSz0JZ
         cg7TqTLzisLF//+0gEfzojP4YNLp+zZeEw1AALQHw2zzp73pdOZ3XhFdbAibbLPDN0MJ
         M6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=fUM1gLT5XMFEhCN2IhiOsJDLJuBvB+gE1vCFOMLVlDY=;
        b=NCGQ4hEf7QOtRnbeIinAVsRG5sMW3g9hIJ7tiORDeK8p+0diObduOSdRBGZqSNY8YD
         xqp/pB99pe9JT6qUZAyuTknCPQzbgnUeVuXboFmUW4LI4DZT2bKzHQJyESA+zb0T5qwl
         /1Mw+ihunBarJ7cftWmZujd24ee+zIr+tes2ZmJ1w+4WNogrkfVUuSds9sskbyG3eQzz
         9FZY8AgLL6h3iepJ3b3uQrgShzEi+Uqzx+LVpryHTE3XcibKRTXUj+0HqAqI3WffjXoB
         /kTajh+glzl/P1XdZZmP2NWy3fiJRkQ0QXs/VgTsRXnjGDBhEpWo8sL7ksFJyu5cCxEH
         JHzw==
X-Gm-Message-State: APt69E3b3fw0MraK9P/WYvN2jwVA/siEmrifi6JrppNu8iACVFHsNijQ
        TMegr/3bTgfMs6udmX4PU+AaN5Lv
X-Google-Smtp-Source: ADUXVKIFuVCrhiIqsX7FGPWkc1qp5GzCVi8Sj/8mfX5L/w/W5xrFo3MgexHdKecnHCSc/ykCZuZYTA==
X-Received: by 2002:adf:93c6:: with SMTP id 64-v6mr1967151wrp.119.1527956261609;
        Sat, 02 Jun 2018 09:17:41 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abri204.neoplus.adsl.tpnet.pl. [83.8.102.204])
        by smtp.gmail.com with ESMTPSA id z10-v6sm54613235wre.43.2018.06.02.09.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Jun 2018 09:17:40 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 17/20] fsck: verify commit-graph
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-18-dstolee@microsoft.com>
Date:   Sat, 02 Jun 2018 18:17:36 +0200
In-Reply-To: <20180524162504.158394-18-dstolee@microsoft.com> (Derrick
        Stolee's message of "Thu, 24 May 2018 16:26:03 +0000")
Message-ID: <867enhtb6n.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> If core.commitGraph is true, verify the contents of the commit-graph
> during 'git fsck' using the 'git commit-graph verify' subcommand. Run
> this check on all alternates, as well.

All right, so we have one config variable to control the use of
serialized commit-graph feaature.  Nice.

>
> We use a new process for two reasons:
>
> 1. The subcommand decouples the details of loading and verifying a
>    commit-graph file from the other fsck details.

All right, I can agree with that.

On the other hand using subcommand makes debugging harder, though not in
this case (well separated functionality that can be easily called with a
standalone command to be debugged).

>
> 2. The commit-graph verification requires the commits to be loaded
>    in a specific order to guarantee we parse from the commit-graph
>    file for some objects and from the object database for others.

I don't quite understand this.  Could you explain it in more detail?

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-fsck.txt |  3 +++
>  builtin/fsck.c             | 21 +++++++++++++++++++++
>  t/t5318-commit-graph.sh    |  8 ++++++++
>  3 files changed, 32 insertions(+)
>
> diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
> index b9f060e3b2..ab9a93fb9b 100644
> --- a/Documentation/git-fsck.txt
> +++ b/Documentation/git-fsck.txt
> @@ -110,6 +110,9 @@ Any corrupt objects you will have to find in backups =
or other archives
>  (i.e., you can just remove them and do an 'rsync' with some other site in
>  the hopes that somebody else has the object you have corrupted).
>=20=20
> +If core.commitGraph is true, the commit-graph file will also be inspected

Shouldn't we use `core.commitGraph` here?

> +using 'git commit-graph verify'. See linkgit:git-commit-graph[1].
> +
>  Extracted Diagnostics
>  ---------------------
>=20=20
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index ef78c6c00c..a6d5045b77 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -16,6 +16,7 @@
>  #include "streaming.h"
>  #include "decorate.h"
>  #include "packfile.h"
> +#include "run-command.h"
>=20=20
>  #define REACHABLE 0x0001
>  #define SEEN      0x0002
> @@ -45,6 +46,7 @@ static int name_objects;
>  #define ERROR_REACHABLE 02
>  #define ERROR_PACK 04
>  #define ERROR_REFS 010
> +#define ERROR_COMMIT_GRAPH 020

Minor nitpick and a sidenote: I wonder if it wouldn't be better to
either use hexadecimal constants, or use (1 << n) for all ERROR_*
preprocesor constants.

>=20=20
>  static const char *describe_object(struct object *obj)
>  {
> @@ -815,5 +817,24 @@ int cmd_fsck(int argc, const char **argv, const char=
 *prefix)
>  	}
>=20=20
>  	check_connectivity();
> +
> +	if (core_commit_graph) {
> +		struct child_process commit_graph_verify =3D CHILD_PROCESS_INIT;
> +		const char *verify_argv[] =3D { "commit-graph", "verify", NULL, NULL, =
NULL, NULL };

I see that NULL at index 2 and 3 (at 3rd and 4th place) are here for
"--object-dir" and <alternates-object-dir-path>, the last one is
terminator for that case, but what is next to last NULL (at 5th place)
for?

> +		commit_graph_verify.argv =3D verify_argv;
> +		commit_graph_verify.git_cmd =3D 1;
> +
> +		if (run_command(&commit_graph_verify))
> +			errors_found |=3D ERROR_COMMIT_GRAPH;
> +
> +		prepare_alt_odb();
> +		for (alt =3D alt_odb_list; alt; alt =3D alt->next) {
> +			verify_argv[2] =3D "--object-dir";
> +			verify_argv[3] =3D alt->path;
> +			if (run_command(&commit_graph_verify))
> +				errors_found |=3D ERROR_COMMIT_GRAPH;
> +		}
> +	}

For performance reasons it may be better to start those 'git
commit-graph verify' commands asynchronously earlier, so that they can
run in parallel / concurrently wth other checks, and wait for them and
get their error code at the end of git-fsck run.

But that is probably better left for a separate commit.

> +
>  	return errors_found;
>  }
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 2680a2ebff..4941937163 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -394,4 +394,12 @@ test_expect_success 'detect invalid checksum hash' '
>  		"incorrect checksum"
>  '
>=20=20
> +test_expect_success 'git fsck (checks commit-graph)' '
> +	cd "$TRASH_DIRECTORY/full" &&
> +	git fsck &&
> +	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
> +		"incorrect checksum" &&
> +	test_must_fail git fsck
> +'

All right; though the same caveats apply as with previous commit in
series.  Perhaps it would be better to truncate commit-graph file, or
corrupt it in some 'random' place.

> +
>  test_done

Best,
--=20
Jakub Nar=C4=99bski
