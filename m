Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE89E1F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 18:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbfDWS32 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 14:29:28 -0400
Received: from mout.web.de ([212.227.15.4]:56269 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfDWS31 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 14:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1556044165;
        bh=z8BYBefWRWMlSn4nE3PNEExByDGClEznN33/MmUKbCM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=h5J7SqCi7YU305Pw6C8v5fjCiajjUdYj6VG75rDT+3zlv/Jt5nvM6FB9dQ3Glq9tp
         TL5irTwiVUamSP+7yLiJ9Z2UjPPhJcpfKA9VMX6EvGSZ+fkZwnY//qaPkxuZkNFeNm
         0st4TXHK/dmNzqP+cqmeg7xvlTBzkEusuiXUeJu0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LjP7H-1gfoT53WPP-00dStD; Tue, 23
 Apr 2019 20:29:24 +0200
Date:   Tue, 23 Apr 2019 20:29:24 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Honor core.precomposeUnicode in more places
Message-ID: <20190423182924.r6mkwrl2o7pcwjoa@tb-raspi4>
References: <20190423173056.28523-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190423173056.28523-1-newren@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:QX0cWMhTYMF9MEfMWMsPFST475OlGS7TT0ACXqr2Nqwk2zKjhPd
 FmWS43KUa/8lqXXIs5fg7b5RNVQCZI/ajJnoUIkbPzdN+cDOHoUb71q747HRvrds9GKF/nz
 SnhB9mTfe3N6dOMV+G9pgS5gfcCisSYh2w1ugimog9/HI1Rc1HEOjETJV+Z4WRKUM/eszae
 OExHLzylRbXgPTbPbZ4zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J8o6dPGQ3DE=:+OwBD60wiNd0RtUtWP8Z+D
 CtyaroXjmcfUQ7oYVNh335hcEsQMRJzXqkJkMk0ig8yfCJzHVKVn5c3F0QWCnyvfP1yYXcX19
 jgrlsGAB1iECFZwRMvhgXLCmLg1SVMw6NRwXiREh5+0pF6Ad2j8c2AHPuy8DnB4BLAEL1WRVm
 vSqgd+XdIlaXmsU7lfmB85PZgxS5XpNwNyeuc7TZ6MctoasKp181JtAzdLi42bVgzAe0WY1oh
 DXRul2aSpHbUxfF62T703altIyMJiDlokkXFWheDVXxFQw+eRKZUkD8qj7MtSnhvOXaK3sUFf
 cMJCqfVlgdo+OFVlIpXDYzTWGoMYSzAULLh/6VUWgNi68nkLvn8l1zlPtu/P4NygR6TBqX6jp
 +YpspxJzHSZK8v+JI1x7WJHOuB6237es5u7MAAd8WrVuZoaZyNjUoiMV3mCsCX3K2BRdV4Y2P
 Cq5xmmC+h8gZRCi5SIipil3Nf26q4rZraWFt8xwlDdauAUpbCWjwzaRzedoI8WKkRs/1pzSGm
 QsKzAYf+1GUpk6k7piJCI6C5VTEW/NocgS2h1/79y1hO2SNfBLDqnVOqG2E1afLmIcF4SFCRM
 s0UfyS7EDN4bDX7WBhsttjInuOkAS8l18RAOqpSCTjm0HjVU2mPUFB2I0R8q3fgnuBQYSbOlk
 Lr7y4xpzPxx93lEqzs726JF78npJLPaXH16o9P5j3cvreehjL1kqlOcLug7Tz47XbzdeBNo98
 HGVvgZw5LwkVk5cca1XIksd0jQw2RwKc3ona1X6ysjfITtJ+QDn9iBegKZcnJ4g/zjwxp3ybP
 isXnSPATQi2MTvSO45guVQpulX9CPHUbH32fTYn9DTk3kb7JcOIPSkHV3rlEFIeNObc7sQSgk
 MPizo0fW1fmpDDedW26qENTWOmbOWK/35x3Hlhs9z3r1LvaTEhbPAgQipJan19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 23, 2019 at 10:30:56AM -0700, Elijah Newren wrote:
> On Mac's HFS ("Hilarious FileSystem"?  "Halfwitted FileSystem"?) --

How about "Hierarchical File System" ?

> where git sets core.precomposeUnicode to true automatically by git
> init/clone -- when a user creates a simple unicode refname (in NFC
> format) such as espa=C3=B1a:
>
>   $ git branch espa=C3=B1a
>
> different commands would display the branch name differently.  For
> example, git branch, git log --decorate, and git fast-export all used
>
>   65 73 70 61 c3 b1 61  (or "espa\xc3\xb1a")
>
> (NFC form) while show-ref would use
>
>   65 73 70 61 6e cc 83 61  (or "espan\xcc\x83a")
>
> (NFD form).  A stress test for git filter-repo was tripped up by this
> inconsistency, though digging in I found that the problems could
> compound; for example, if the user ran
>
>   $ git pack-refs --all
>
> and then tried to check out the branch, they would be met with:
>
>   $ git checkout espa=C3=B1a
>   error: pathspec 'espa=C3=B1a' did not match any file(s) known to git
>
>   $ git checkout espa=C3=B1a --
>   fatal: invalid reference: espa=C3=B1a
>
>   $ git branch
>     espa=C3=B1a
>   * master
>
> Note that the user could run the `git branch` command first and copy and
> paste the `espa=C3=B1a` portion of the output and still see the same two
> errors.  Also, if the user added --no-prune to the pack-refs command,
> then they would see three branches: master, espa=C3=B1a, and espan=CC=83=
a (those
> last two are NFC vs. NFD forms, even if they render the same).
>
> Further, if the user had the `espa=C3=B1a` branch checked out before
> running `git pack-refs --all`, the user would be greeted with (note
> that I'm trimming trailing output with an ellipsis):
>
>   $ git rev-parse HEAD
>   fatal: ambiguous argument 'HEAD': unknown revision or path...
>
>   $ git status
>   On branch espa=C3=B1a
>
>   No commits yet...
>
> Or worse, if the user didn't check this stuff first, running `git
> commit` will create a new commit with all changes of all of history
> being squashed into it.
>
> In addition to pack-refs, one could also get into this state with
> upload-pack or anything that calls either pack-refs or upload-pack (e.g.
> gc or clone).
>
> Add code in a few places (pack-refs, show-ref, upload-pack) to check and
> honor the setting of core.precomposeUnicode to avoid these bugs.

That's all correct, one minor question below.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/pack-refs.c | 2 ++
>  builtin/show-ref.c  | 3 +++
>  upload-pack.c       | 2 ++
>  3 files changed, 7 insertions(+)
>
> diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
> index f3353564f9..cfbd5c36c7 100644
> --- a/builtin/pack-refs.c
> +++ b/builtin/pack-refs.c
> @@ -1,4 +1,5 @@
>  #include "builtin.h"
> +#include "config.h"
>  #include "parse-options.h"
>  #include "refs.h"
>  #include "repository.h"
> @@ -16,6 +17,7 @@ int cmd_pack_refs(int argc, const char **argv, const c=
har *prefix)
>  		OPT_BIT(0, "prune", &flags, N_("prune loose refs (default)"), PACK_RE=
FS_PRUNE),
>  		OPT_END(),
>  	};
> +	git_config(git_default_config, NULL);
>  	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
>  		usage_with_options(pack_refs_usage, opts);

I wonder if we could move the call to git_config() into parse_options(),
(or another common place) but I haven't checked the details yet.
Same below for show_ref().

And thankks for picking this up.

>  	return refs_pack_refs(get_main_ref_store(the_repository), flags);
> diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> index 6a706c02a6..6456da70cc 100644
> --- a/builtin/show-ref.c
> +++ b/builtin/show-ref.c
> @@ -1,5 +1,6 @@
>  #include "builtin.h"
>  #include "cache.h"
> +#include "config.h"
>  #include "refs.h"
>  #include "object-store.h"
>  #include "object.h"
> @@ -182,6 +183,8 @@ static const struct option show_ref_options[] =3D {
>
>  int cmd_show_ref(int argc, const char **argv, const char *prefix)
>  {
> +	git_config(git_default_config, NULL);
> +
>  	argc =3D parse_options(argc, argv, prefix, show_ref_options,
>  			     show_ref_usage, 0);
>
> diff --git a/upload-pack.c b/upload-pack.c
> index d098ef5982..159f751ea4 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1064,6 +1064,8 @@ static int upload_pack_config(const char *var, con=
st char *value, void *unused)
>  		allow_ref_in_want =3D git_config_bool(var, value);
>  	} else if (!strcmp("uploadpack.allowsidebandall", var)) {
>  		allow_sideband_all =3D git_config_bool(var, value);
> +	} else if (!strcmp("core.precomposeunicode", var)) {
> +		precomposed_unicode =3D git_config_bool(var, value);
>  	}
>
>  	if (current_config_scope() !=3D CONFIG_SCOPE_REPO) {
> --
> 2.21.0.420.g4906d192b3
>
