Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0CE61F461
	for <e@80x24.org>; Tue, 23 Jul 2019 13:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbfGWNNa (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 09:13:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:35243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbfGWNNa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 09:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563887597;
        bh=WSuyd8z6RSB+qI+ZbOZVSj+i+HSjuwcNJl3hCdd2Nu4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bhbgAXFuogMoG6ZwfTbtG29cGBOAWv474KEIXatGEmFYOiF+nOJcS/1KhyfmVhmkO
         V/7fOJwTw6G8d4/QmhZC1L4HMHeCB5ebGbtktaoFXj+sswntYbMzQUiC92pG6SXayz
         6HdocQawibcvyQV0R/N+KVoS7RHFu5+W4c5CZuAA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.21.16.31] ([194.69.102.31]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJFBe-1hrZIO1Gqw-002oS0; Tue, 23
 Jul 2019 15:13:17 +0200
Date:   Tue, 23 Jul 2019 15:12:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, peff@peff.net, jnareb@gmail.com,
        pclouds@gmail.com, carenas@gmail.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/5] repo-settings: consolidate some config settings
In-Reply-To: <72f652b89c71526cc423e7812de66f41a079f181.1563818059.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907231512130.21907@tvgsbejvaqbjf.bet>
References: <pull.292.git.gitgitgadget@gmail.com> <72f652b89c71526cc423e7812de66f41a079f181.1563818059.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ddIC1B8Tl1QZsTn7b9vFDHJ5M2yqGVinmPLos4B65MpYF0t4n6b
 UugGzUXTbnVMoCwrccISDXJNNpAVQNfydkL/HCZ1L4rRkeyAlKMyx4etY9KV5DkRpmwbFBq
 BEKqd7PkjEY3Zm78fHRXKzuCjsC5ziMWZfhsFMyHNN0bXAGY+pvS5o/3zqWDZ4laYrNeJWo
 Tt8NFzbS1J/rUT3YnnHlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I3vez+1fRRg=:mHyLSWMlr2oDkqtUW+fWUe
 IQV7hEWb5+120CV5h9K5Empr4A+Pth3pLqmAYzLpsDT7aVgJuIfZpOqgDWhE0kIHMsvV8K+59
 jrpLvVrScX+lk33D+xgDvHmzlCUxDiv/p7fvsoiJin8sORFFSRDH8DEaP4iyQg5gjDBxCNno3
 fLcduU6SUHQ1JDBM9WQy8ErON01WG13L7Cci3XZ27Om/7vkZ68hseI0iWvhF1MEo1glETzawI
 wYlOC1v3r6Bp2HneLpGUXMl8aLyC8SgxVeCPXOR0n70VjF82xwlAmBtjBn71idULXKTXQOkoL
 mIENSdY0ajfmHDj8TWJXmxmiNco+dkts0bhrRX6ShsKCxWR3mi0o3LcjVDwdZ5KIwt1I1EkBl
 95hFhQvgDH080fvmKq3tWLf2DqFuw+iGwJe5P4musUD4g0BhVJUg37apSXCcKbC7ntF/42Agk
 V1Y+hj8RkvlmVPyI/qzZgBHexd/DMCamc2d7OT78EGCWWR+Pcws0TcdSxDZBUc6ChfjJ4j91k
 8BkBklCFEyQ5sXPxbaZwB2/vj/q3Uo4s+OVQXNEm9t8DN7lE01ZXaxwuMbLCcfrGYTfz/B/7V
 OrF6lm56nMI7w9HUSq27FSUo5iZMdt/7PywfOh8D3yj8fcjveuKR/mYCd/DWd4TGYIQ5BU3Zp
 XP2f80BxGy3YtwNDzR+5EXj5xSYcbJ0HAexYR0nR37zQ10jTsDCQ7hFXjKaWJx7gGFuq0p9TB
 rcgqbJ52eGfm8A2fZTgB5NganeKYM3kzjFnA39pNW3nLyjVWPaI5TlprzGPG/fjVsUhDiOqvZ
 xC0z6uxITxspk6byd3v04hf3TeEL3JRYGe28WFvK8d5INHNh5p+ynbUg1OGKYzZzJtFSg2qSY
 ZLgjzqwvXDVkCNIMvffcDkBP8sAGb2hl4XBN+JGxf+keNWYCkhbyhJLgjUsIyqSa61r1IJ+RN
 kbL1/zwIU/3RvGyBL41jiblOmBtZnzHljp9ulf3TJDS77ZYamAz516IHKG9i5EFZySkozGt0b
 xiM1ovimBp3Hoe1n0KY7zzW+KRPUPV119mpv88aRvbj/D0tvm/PwuoanB8LC+7ODS2+zohRB5
 uqyLOjc9GFYE80VeZs/3b/pdJDsN38k20ip
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Mon, 22 Jul 2019, Derrick Stolee via GitGitGadget wrote:

> diff --git a/builtin/gc.c b/builtin/gc.c
> index c18efadda5..243be2907b 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -27,6 +27,7 @@
>  #include "pack-objects.h"
>  #include "blob.h"
>  #include "tree.h"
> +#include "repo-settings.h"
>
>  #define FAILED_RUN "failed to run %s"
>
> @@ -41,7 +42,6 @@ static int aggressive_depth =3D 50;
>  static int aggressive_window =3D 250;
>  static int gc_auto_threshold =3D 6700;
>  static int gc_auto_pack_limit =3D 50;
> -static int gc_write_commit_graph;

I _really_ like that direction. Anything that removes global state will
improve Git's source code.

> [...]
> diff --git a/read-cache.c b/read-cache.c
> index c701f7f8b8..ee1aaa8917 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> [...]
> @@ -2765,7 +2767,7 @@ static int do_write_index(struct index_state *ista=
te, struct tempfile *tempfile,
>  	}
>
>  	if (!istate->version) {
> -		istate->version =3D get_index_format_default();
> +		istate->version =3D get_index_format_default(the_repository);

It is too bad that `read-cache.h` is not `the_repository`-free at the
moment...

>  		if (git_env_bool("GIT_TEST_SPLIT_INDEX", 0))
>  			init_split_index(istate);
>  	}
> diff --git a/repo-settings.c b/repo-settings.c
> new file mode 100644
> index 0000000000..13a9128f62
> --- /dev/null
> +++ b/repo-settings.c
> @@ -0,0 +1,44 @@
> +#include "cache.h"
> +#include "repository.h"
> +#include "config.h"
> +#include "repo-settings.h"
> +
> +static int git_repo_config(const char *key, const char *value, void *cb=
)
> +{
> +	struct repo_settings *rs =3D (struct repo_settings *)cb;
> +
> +	if (!strcmp(key, "core.commitgraph")) {
> +		rs->core_commit_graph =3D git_config_bool(key, value);
> +		return 0;
> +	}
> +	if (!strcmp(key, "gc.writecommitgraph")) {
> +		rs->gc_write_commit_graph =3D git_config_bool(key, value);
> +		return 0;
> +	}
> +	if (!strcmp(key, "pack.usesparse")) {
> +		rs->pack_use_sparse =3D git_config_bool(key, value);
> +		return 0;
> +	}
> +	if (!strcmp(key, "index.version")) {
> +		rs->index_version =3D git_config_int(key, value);
> +		return 0;
> +	}

I would actually prefer to use the `repo_config_get_*()` family here.
That way, we really avoid re-parsing the config.

> +
> +	return 1;
> +}
> +
> +void prepare_repo_settings(struct repository *r)
> +{
> +	if (r->settings)
> +		return;
> +
> +	r->settings =3D xmalloc(sizeof(*r->settings));
> +
> +	/* Defaults */
> +	r->settings->core_commit_graph =3D -1;
> +	r->settings->gc_write_commit_graph =3D -1;
> +	r->settings->pack_use_sparse =3D -1;
> +	r->settings->index_version =3D -1;
> +
> +	repo_config(r, git_repo_config, r->settings);
> +}
> diff --git a/repo-settings.h b/repo-settings.h
> new file mode 100644
> index 0000000000..1151c2193a
> --- /dev/null
> +++ b/repo-settings.h
> @@ -0,0 +1,15 @@
> +#ifndef REPO_SETTINGS_H
> +#define REPO_SETTINGS_H
> +
> +struct repo_settings {
> +	int core_commit_graph;
> +	int gc_write_commit_graph;
> +	int pack_use_sparse;
> +	int index_version;
> +};
> +
> +struct repository;
> +
> +void prepare_repo_settings(struct repository *r);

Hmm. I can see that you wanted to encapsulate this, but I do not really
agree that this needs to be encapsulated away from `repository.h`. I'd
rather declare `struct repo_settings` in `repository.h` and then make
the `settings` a field of that type (as opposed to a pointer to that
type). In general, I like to avoid unnecessary `malloc()`s, and this
here instance is one of them.

Thanks,
Dscho

> +
> +#endif /* REPO_SETTINGS_H */
> diff --git a/repository.h b/repository.h
> index 4fb6a5885f..352afc9cd8 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -4,6 +4,7 @@
>  #include "path.h"
>
>  struct config_set;
> +struct repo_settings;
>  struct git_hash_algo;
>  struct index_state;
>  struct lock_file;
> @@ -72,6 +73,8 @@ struct repository {
>  	 */
>  	char *submodule_prefix;
>
> +	struct repo_settings *settings;
> +
>  	/* Subsystems */
>  	/*
>  	 * Repository's config which contains key-value pairs from the usual
> --
> gitgitgadget
>
>
