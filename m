Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1B2C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 17:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiJMRzG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 13:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJMRyj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 13:54:39 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F97153806
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 10:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1665683627; bh=rqGEozIQtdIdDZLRanAZExM6aPa0jqhMUyBjNofncyw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=te1NBfxuIY4zpQPM3KG95Qbbit8cKt/BEdv1DJrmeH7OKy3JLjwTIl5yDQGfyzlv4
         minbKsZK2ly82LBc8cgeqePQLWoCL5A5A6Jo/dfBmr0/T8uB061H31v8Mjf/r2hJMp
         WMzSsF2KDs+J3SCKXBCNjoruQhqifqkju4pdlNZOIqgKE8xhK0+8kEgaGb1v9GZufg
         jVlIrPRNVo54V89nGq2fekc7CEI0c67/uvsBQSw1KT2VM5jkNtKD63mLcbWkrc2/0O
         TTiZ0DnFmuRSxk2cti6MvuDVGPwbxGJthUH+cEvItAcgjoYha+SZitDq3vTvyQWnm4
         fm0m68TB+z8fg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.161]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPaIK-1oWIyf125S-00N5YZ; Thu, 13
 Oct 2022 19:53:47 +0200
Message-ID: <ee64f463-c4f7-cd1e-50ca-7c302415cf52@web.de>
Date:   Thu, 13 Oct 2022 19:53:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH v2 1/2] archive: add --recurse-submodules to git-archive
 command
Content-Language: en-US
To:     Alphadelta14 via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Heather Lapointe <alpha@alphaservcomputing.solutions>
References: <pull.1359.git.git.1665597148042.gitgitgadget@gmail.com>
 <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
 <41664a59029e2492079bef3d3da10f44d315064b.1665660960.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <41664a59029e2492079bef3d3da10f44d315064b.1665660960.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1J+zBDJfiiuVQVG/aC8TRlA9S35jqzDzSLpd/pgSq4rmSLmKj/+
 zHwmSg4T9seMMwHXF3efksn1iU0PKmHhLd5YGHyTvwvU99tNyvoS771BJbGVVj3V6EfDPeK
 tzPFKmXPSyQJDzoo07wW8BiDK+k345dn7vHkX6wvtMohVGbBy1XRPxfmcDhgFUrilBFOGG5
 xe5rHxE2eLqpeKD0NLdVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XyPehjyELvE=:na9gr015Nq0ApFJ9jPNrRU
 XJQA3pKQ684wc1SnGdmEsMxFfGo58xZ9rG6FhdU6SJepcSrmQ/ImbbcNDjRz9McoXj4c/yQ83
 R1iuU2B6ay7KSI8GFu0IoBDhxm+dSxPf2dEBjLGQr0KFe03NN2LmWXzHLOThOxS5z23zFxee6
 EqyC1cxl6rud3Enn5Zu1AVsolOEsMZ3cQ+7PTE+8xgiy0CJTeaPh+EYAeu2En4+/BrKqOwpqK
 LXOyFHfy4T8KEtlh1zBDWyoisicMgXY9+ILyK5tPEzXUzovxwgerWU9+YVjsX46Xt+XlzMtIW
 4E+c4zOOH/PSi3nBP5+tjapFaA7U5CEbAggUNpBwWa6/tk3D6IC9J3k0mGwKawstdcOfLvzu3
 1JN4FRjsvsooCgSAUdWEhORtL4KSaSLoYbhQ31DELFJHmiU948CT8l+5s4kyHSuuvGrpqEPUY
 bZqX+UF6WTv86cfZMr1Uoq4h/M0F6Nbm80LEd3iSG/1hDDeCvBhDKT3wT+/L2A3zUnKgtJa8l
 1IGA24zVcPQuu3vNLiSqbgDmYpixDVB5pfcXiMJ+gf280CNS2YueGhbpUdDoBOW56h642aGz0
 vslSJzefbPzX1WW1QbktXES9YuC8Fx6/pI438/lMz/+k3mpuNCMpF2aN8uuLGM2mM+Uhoj6jN
 dvjy+oW/nyiiWDSRNMVKrkqyqLPe0Az9ytayLhfmU/JrvhODT+VPUn9izVbP/qHuHMNWpTcXu
 6y68+yJxwwCKj/C1FGLfru8tmqhEUudIoDjoTmtZt95o1I3fsw/7eMV/DTyV8zA6s7nELrFBo
 BJWUXoanNvLqoryot8AckoJEtT+5tzilvij0lP2uri6FqjCsN4qttwzPVM6Ujk2Lra5QhfI3d
 YHE/H0Eq95JP9cJh/+en3KMRs1H0mHfbvoE4SKi2b7upJAlk+rhwd/5h7EWsisxYBBakfIyJD
 4ruUwg14dN/u/sIDh0AR/bl0oXKygbd0tMHDbYRUoLUBatjmE0zuN3APF2N9OA8JDELBl8EsK
 QR/ttD+8Q0UjJ67nWQI70Ph/m6TtpbFz4fwpafhg+dViaH0ZFeTQ9jcXB1dgFOaAMbV6GERwq
 2M35YV82wHcirwE7nwt792VgQeFT+Oyij6k6nzEP3BKZFyq9InfkCZlh0kq2IZBHIetmuoJno
 NgSVOVrOwRp/tpDQ/EwyTruGQqUhYdAGhUOM8Z6UlKSjYCC33mH1E4wV0APC2b+BlF/4DLOG1
 dDtWt/awr4nhO23GPthtBLqmIYxsZhSOkDVzFc6GzxcI/EaPhtaPrmYsy3/yYl7ggfR6WbEhR
 uvdhhIx8uf/6kr+rBgRPooCYnQa2/2n6nVQ4wPHL5tGxvSmQW3IP3+r4NgLhx9aCwKObXYI0P
 hPU/TuGYyTDldvV+Euc0RcMQHsJjecAr5l6+BLg1hajY5hqvHoggw07d3ft1nI/0X/jJSuAO2
 FvW+N7w60avk/IENQjKJIhRu6/JNUcFTFIlan380YRge2KGF8HdFNUmKyqbq33WV/ZbAmDdQq
 BUEqX/nlpVmY1LeZHP3cZ4L87kIeQkav7s/5XrNdxwB5B
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.10.22 um 13:35 schrieb Alphadelta14 via GitGitGadget:
> From: Alphadelta14 <alpha@alphaservcomputing.solutions>
>

> diff --git a/tree.c b/tree.c
> index 410e3b477e5..c5b5a0ac08f 100644
> --- a/tree.c
> +++ b/tree.c
> @@ -8,6 +8,7 @@
>  #include "alloc.h"
>  #include "tree-walk.h"
>  #include "repository.h"
> +#include "pathspec.h"
>
>  const char *tree_type =3D "tree";
>
> @@ -22,8 +23,8 @@ int read_tree_at(struct repository *r,
>  	int len, oldlen =3D base->len;
>  	enum interesting retval =3D entry_not_interesting;
>
> -	if (parse_tree(tree))
> -		return -1;
> +	if (repo_parse_tree(r, tree))
> +		die("Failed to parse tree");
>
>  	init_tree_desc(&desc, tree->buffer, tree->size);
>
> @@ -37,7 +38,7 @@ int read_tree_at(struct repository *r,
>  				continue;
>  		}
>
> -		switch (fn(&entry.oid, base,
> +		switch (fn(r, &entry.oid, base,
>  			   entry.path, entry.mode, context)) {
>  		case 0:
>  			continue;
> @@ -47,36 +48,57 @@ int read_tree_at(struct repository *r,
>  			return -1;
>  		}
>
> -		if (S_ISDIR(entry.mode))
> +		if (S_ISDIR(entry.mode)) {
>  			oidcpy(&oid, &entry.oid);
> -		else if (S_ISGITLINK(entry.mode)) {

So you remove the non-recursive handling of submodules here...

> +			len =3D tree_entry_len(&entry);
> +			strbuf_add(base, entry.path, len);
> +			strbuf_addch(base, '/');
> +			retval =3D read_tree_at(r, lookup_tree(r, &oid),
> +						base, pathspec,
> +						fn, context);
> +			strbuf_setlen(base, oldlen);
> +			if (retval)
> +				return -1;
> +		} else if (pathspec->recurse_submodules && S_ISGITLINK(entry.mode)) {

... and add recursive handling here, and there is no further else
branch.  Why do we no longer need the non-recursive variant?

>  			struct commit *commit;
> +			struct repository subrepo;
> +			struct repository* subrepo_p =3D &subrepo;
> +			struct tree* submodule_tree;
>
> -			commit =3D lookup_commit(r, &entry.oid);
> +			if (repo_submodule_init(subrepo_p, r, entry.path, null_oid()))
> +				die("couldn't init submodule %s%s", base->buf, entry.path);
> +
> +			if (repo_read_index(subrepo_p) < 0)
> +				die("index file corrupt");
> +
> +			commit =3D lookup_commit(subrepo_p, &entry.oid);
>  			if (!commit)
>  				die("Commit %s in submodule path %s%s not found",
>  				    oid_to_hex(&entry.oid),
>  				    base->buf, entry.path);
>
> -			if (parse_commit(commit))
> +			if (repo_parse_commit(subrepo_p, commit))
>  				die("Invalid commit %s in submodule path %s%s",
>  				    oid_to_hex(&entry.oid),
>  				    base->buf, entry.path);
>
> -			oidcpy(&oid, get_commit_tree_oid(commit));
> +			submodule_tree =3D repo_get_commit_tree(subrepo_p, commit);
> +			oidcpy(&oid, submodule_tree ? &submodule_tree->object.oid : NULL);
> +
> +			len =3D tree_entry_len(&entry);
> +			strbuf_add(base, entry.path, len);
> +			strbuf_addch(base, '/');
> +			retval =3D read_tree_at(subrepo_p, lookup_tree(subrepo_p, &oid),
> +						base, pathspec,
> +						fn, context);
> +			if (retval) {
> +			    die("failed to read tree for %s%s", base->buf, entry.path);
> +			    return -1;
> +			}
> +			strbuf_setlen(base, oldlen);
> +			repo_clear(subrepo_p);
>  		}
> -		else
> -			continue;
>
> -		len =3D tree_entry_len(&entry);
> -		strbuf_add(base, entry.path, len);
> -		strbuf_addch(base, '/');
> -		retval =3D read_tree_at(r, lookup_tree(r, &oid),
> -				      base, pathspec,
> -				      fn, context);
> -		strbuf_setlen(base, oldlen);
> -		if (retval)
> -			return -1;
>  	}
>  	return 0;
>  }
> @@ -121,7 +143,7 @@ int parse_tree_buffer(struct tree *item, void *buffe=
r, unsigned long size)
>  	return 0;
>  }
>
> -int parse_tree_gently(struct tree *item, int quiet_on_missing)
> +int parse_tree_gently(struct repository *r, struct tree *item, int quie=
t_on_missing)
>  {
>  	 enum object_type type;
>  	 void *buffer;
> @@ -129,7 +151,7 @@ int parse_tree_gently(struct tree *item, int quiet_o=
n_missing)
>
>  	if (item->object.parsed)
>  		return 0;
> -	buffer =3D read_object_file(&item->object.oid, &type, &size);
> +	buffer =3D repo_read_object_file(r, &item->object.oid, &type, &size);
>  	if (!buffer)
>  		return quiet_on_missing ? -1 :
>  			error("Could not read %s",

