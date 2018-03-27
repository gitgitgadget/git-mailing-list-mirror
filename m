Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC271F404
	for <e@80x24.org>; Tue, 27 Mar 2018 16:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeC0QCf (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 12:02:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:55633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752292AbeC0QCe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 12:02:34 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVN0w-1f3Vpx2mWE-00YiXd; Tue, 27
 Mar 2018 18:02:31 +0200
Date:   Tue, 27 Mar 2018 18:02:30 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Joel Teichroeb <joel@teichroeb.net>
cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/5] stash: convert apply to builtin
In-Reply-To: <20180327054432.26419-3-joel@teichroeb.net>
Message-ID: <nycvar.QRO.7.76.6.1803271744370.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180327054432.26419-1-joel@teichroeb.net> <20180327054432.26419-3-joel@teichroeb.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7R5KYvf+S33eFK98UUH5GjjzjqOxt8FLjG+v3DKNdjvixGYGJPD
 Sjyr2CLxfI6mV7lGW9R9/xOvPGU6u8Fzc5o8NkAnFjz9FbLhEiKcm3pSe1v3OeZ3isybTPv
 JRj/xI4gv0rOMuXqnDoAKXP8g0GSytsXB0n7CjjNxxKYd09PBWgnyss7gKN7ZIVjIeojYQG
 +jlNIAWsg8e34djSwMP0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LEYyCr37ays=:05JopwC4/DLfneOT816DTr
 gbgd71XWZ/UwAgmfLYQH/Y130ri+oj9gBLqDI3tS5DFHoV/3csMjqbMvZjhWKAucepkRBc2Ad
 IsJhz8pQAoEt86cYpo/3iyrmRphZ/vwPdJ1PWHSkwUsfNeMb2bi28Xs5CBavLyRaEuX6HAU3g
 fNJwsUz29Rr3t82tmCHslmay/0MiJA9nqoilPXNhjw4H5T2/eq/4ObJI1SbNdbxlbZhS5WHwf
 rlF7raVCjSptXI3oZJp39WbEoHwRKwl0AJdTWpXiahln5M0Yfa4YG72Vd7KyUvVCwo67MLKff
 5lTk25ljhHuMoTHlLJaawrQZMZMOIkPlfVoLh9NNrIQlDmCUVO7zzPqYboTGdUv5XnEgQHKpR
 y5oOXodsvKgNoG/D3KqFhx0ZMdr+9mHbMdE6++NBFCuXH+dDX8ictBe/4IHqsFMC9Lsj0fbBU
 Ly3XnKovtJlRTi6+/uFLzxPw7WfMePmWwUOCpzXvcMQf49+au4sBZoosMo8Z5WmcMz3HyKQbL
 Jl+k1Qvwe55XCJq2OTuRq0Lv5N9GLMQ1eHB4Dw00WztFE2QRCM8VuFIW+qzNFEJiZSEfyjjTf
 h40ydC28qpFz2E9LfW8Nl2XM+fWa+26+jeu/WyK8keAfIUgGTtC2/3KK0mN4KwmJRco7+dR47
 zEtzqvqml/mFQgZgFG5bBKQgzxkSuhRnHrQojRnQTegmzX24zueIoJYgO/RNjHPutb0wAFrlh
 Oj59jaRVXSp8ic+eGzisYpmkWdbSZVWw+fp+CTv4nqtvco4s+M/NcoIWn2X5O9nC9sfN1fmKy
 u/S2on6bNFGiZxX4p8kjvIs6DVP80OU+xz+mmEYf+Wi1iChWx2lQ+6obUMdUobr+CVgH/Zl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel,

On Mon, 26 Mar 2018, Joel Teichroeb wrote:

> Add a bulitin helper for performing stash commands. Converting
> all at once proved hard to review, so starting with just apply
> let conversion get started without the other command being
> finished.
> 
> The helper is being implemented as a drop in replacement for
> stash so that when it is complete it can simply be renamed and
> the shell script deleted.
> 
> Delete the contents of the apply_stash shell function and replace
> it with a call to stash--helper apply until pop is also
> converted.
> 
> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>

Makes sense.

I need a couple of adjustments before it compiles on Windows:

> [...]
> +
> +static int do_apply_stash(const char *prefix, struct stash_info *info, int index)
> +{
> +	struct merge_options o;
> +	struct object_id c_tree;
> +	struct object_id index_tree;
> +	const struct object_id *bases[1];
> +	int bases_count = 1;
> +	struct commit *result;
> +	int ret;
> +	int has_index = index;
> +
> +	read_cache_preload(NULL);
> +	if (refresh_cache(REFRESH_QUIET))
> +		return -1;
> +
> +	if (write_cache_as_tree(&c_tree, 0, NULL) || reset_tree(&c_tree, 0, 0))

When applied on top of current `master`, I need to replace the &c_tree by
c_tree.hash.

Likewise...

> +		return error(_("Cannot apply a stash in the middle of a merge"));
> +
> +	if (index) {
> +		if (!oidcmp(&info->b_tree, &info->i_tree) || !oidcmp(&c_tree, &info->i_tree)) {
> +			has_index = 0;
> +		} else {
> +			struct strbuf out = STRBUF_INIT;
> +
> +			if (diff_tree_binary(&out, &info->w_commit)) {
> +				strbuf_release(&out);
> +				return -1;
> +			}
> +
> +			ret = apply_cached(&out);
> +			strbuf_release(&out);
> +			if (ret)
> +				return -1;
> +
> +			discard_cache();
> +			read_cache();
> +			if (write_cache_as_tree(&index_tree, 0, NULL))

... &index_tree -> index_tree.hash.

These are probably changed to use object_id's already in `pu`, I guess.

I also need this change:

> [...]
> +
> +	index_file = get_index_file();
> +	xsnprintf(stash_index_path, PATH_MAX, "%s.stash.%d", index_file, pid);

Since `pid_t` is `unsigned long long` on Windows, I changed the %d" to
%"PRIuMAX and cast `pid` to `(uintmax_t)`.

With those changes, the entire patch series compiles here.

BTW t3903 runs in 13m30s here with this patch series, 14m30s otherwise.
That might not seem like much, until you realize that t3903 *still*
performs a metric ton of Unix shell scripting outside of `git stash` (and
that is the reason for the slowness).

Ciao,
Dscho
