Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57674CA0FF8
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 10:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351961AbjIBKNP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 06:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjIBKNO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 06:13:14 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8862AE42
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 03:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1693649577; x=1694254377; i=l.s.r@web.de;
 bh=LntvOUA2x3WgZko2scEo7L2/xh2nBl84FfKOuJtFc7I=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=lYbDcTiGHzKee0kSoy7XZVQlUsbGA8jr+0JFPZyE/OJ0qHR87J+V60p8tpv0zJ3MFrRoxV0
 nNLU9Hu4p3sKUsPnAB2PTNt5Z2PSZYSMO/uHx3W2lXWNIK8GYFamYJpO6wMhB+Zqo3l44owH2
 a440I0+0vRNQHeHNp8hrDf9g2pDb9IeSnEfS42/MmsQdD0E15/kROB3pp2Fc3l2bFD3Kf+dmA
 lCTSrizLz2chAnfalsuoNBiSErqWNF/sE3TC2BzkpdiDNxgOTCSVe+/t2WdeBbSjescjhrW+C
 cC8hTtCi7K9hUcBRljfn/Xpj9KeA5SokeV5DLgid4+FkL00oZWUA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.152.246]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MV2Oi-1qCdYt27Dq-00S5lR; Sat, 02
 Sep 2023 12:12:57 +0200
Message-ID: <98d1cd21-fb2a-269a-8d0b-f3e050682739@web.de>
Date:   Sat, 2 Sep 2023 12:12:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 06/10] parse-options: mark unused "opt" parameter in
 callbacks
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20230831211637.GA949188@coredump.intra.peff.net>
 <20230831212128.GF949469@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230831212128.GF949469@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k1cwxH2Pj3DtrhVIJ/RcJzZY+u0Obgccz6VkVpL8D0768/JbVxQ
 A2awjDra8DOgEkXGqjc4Q5mkDVbyE0S4kP5s7ikIFb+iu9timoPQqCbRjmf5g95k/NyFHUC
 loP87+zxRbqoHdKOaWuI0AciBKM9jePW63pq5qwpSiqZqocpJLh+eoShtEh1R+FvKOxTWom
 vrwBu9dM9AqrtUpTIGcnw==
UI-OutboundReport: notjunk:1;M01:P0:a/b0DsiHTTU=;lF2RAg54x7kP+FNwky9pStwod0v
 blqk/E5d06lh3oFBgGAakvcZa6l8H+iaGV68gosLyRxln56TwnNFFyBwHUTnGKgp7HqegjQBw
 fvmkOTcE+b3WZNZC5K1dS6vWgxY2MF3nju6Fax8bKGUU4ErW+oG12nZiMQkGxSnyyEGjVRhAS
 G8/uegYnusfMspF5dQZ8wGSRg9OUPI9Um4OF3UoaKWf+JQWbhPLuexKUf91FmXKgUm8jgPwwx
 lfeIgk5e2Kd6JDdcN37CuTNr0ibudgr46RHzMbv8CJ5GOjN73Q3PpU6HOLKoaZ1q0bBvQTcEF
 UKmURoP9vW17F5sWaP/mHodH5FmiaxJA+X6xVXaoF1qIWOiyTA1Y5HhLzPXpfn9lKMOpVWh3x
 WSHdwl9j4YxzcMXyy2Ncj62Cq64yCrPLE+YvHnZz1+2Os2mldnxhoraXsRLsWoGPnw8piQvJT
 8M9cdgDW+lU1DJqUlmhw046mrdxI6PiLjebgc6zi4G++A9swrz8If1eVD1XY5mbahHfjIcQ++
 ZF5cUfQ3STfQlG+okZ0SuS2+Tcw20ATzvP51eIFwyiebp0BGDqSA9OLRWdznZoo0T5ksuMtXi
 GADrnlibWB14fmIx1JQ2yI0CVjpmibdRrc9EixCaKtbADYLZ9lpUW16k+J6Yq5OGIf6TlUAkN
 vdyVS1oKQ2d7wzVQ8uUor9p38Ei3U+dRDgmfxU9QpB+F12DAdaTMLxxRqjPCYFqWbzcdn2eZF
 YuQINmG2B3PU+uUiNM7nuZ8T4GjDQnPuzhaZW0er/1iSLF6c5/a0KS8ZmRcDYXIKpae6/kudb
 1TzLXJjCkhICMxi+BI7dSyeMjVs/atYjW6xCv1ryrXbUUHKzWBVKPkvkV1TDjVaM4VprNrz42
 2rZK1hCjPahfjgIOvh0KYDKiEwWa+VyGM28hxPuXJyfG9t8hqa6iNlQAsZgS42YJsyjgG/QRs
 NQ/FWJdL0iK7Fay8ggyuNcDf8us=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.08.23 um 23:21 schrieb Jeff King:
> The previous commit argued that parse-options callbacks should try to
> use opt->value rather than touching globals directly. In some cases,
> however, that's awkward to do. Some callbacks touch multiple variables,
> or may even just call into an abstracted function that does so.
>
> In some of these cases we _could_ convert them by stuffing the multiple
> variables into a single struct and passing the struct pointer through
> opt->value. But that may make other parts of the code less readable,
> as the struct relationship has to be mentioned everywhere.

Does that imply you'd be willing to use other methods?  Let's find out
below. :)

>
> Let's just accept that these cases are special and leave them as-is. But
> we do need to mark their "opt" parameters to satisfy -Wunused-parameter.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/gc.c           |  2 +-
>  builtin/log.c          | 10 ++++++----
>  builtin/merge.c        |  2 +-
>  builtin/pack-objects.c |  6 +++---
>  builtin/read-tree.c    |  2 +-
>  builtin/update-index.c |  4 ++--
>  6 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 369bd43fb2..b842349d86 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1403,7 +1403,7 @@ static void initialize_task_config(int schedule)
>  	strbuf_release(&config_name);
>  }
>
> -static int task_option_parse(const struct option *opt,
> +static int task_option_parse(const struct option *opt UNUSED,

Only the global variable "tasks" seems to be used in here if you don't
count the constant "TASK__COUNT", so you could pass it in.  This could
also be converted to OPT_STRING_LIST with parsing and duplicate checking
done later.

And I don't understand why the callback returns 1 (PARSE_OPT_NON_OPTION)
on error, but that's a different matter.

>  			     const char *arg, int unset)
>  {
>  	int i, num_selected =3D 0;
> diff --git a/builtin/log.c b/builtin/log.c
> index fb90d43717..3599063554 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -118,16 +118,17 @@ static struct string_list decorate_refs_exclude =
=3D STRING_LIST_INIT_NODUP;
>  static struct string_list decorate_refs_exclude_config =3D STRING_LIST_=
INIT_NODUP;
>  static struct string_list decorate_refs_include =3D STRING_LIST_INIT_NO=
DUP;
>
> -static int clear_decorations_callback(const struct option *opt,
> -					    const char *arg, int unset)
> +static int clear_decorations_callback(const struct option *opt UNUSED,
> +				      const char *arg, int unset)
>  {
>  	string_list_clear(&decorate_refs_include, 0);
>  	string_list_clear(&decorate_refs_exclude, 0);
>  	use_default_decoration_filter =3D 0;
>  	return 0;
>  }
>

Meta: Why do we get seven lines of context in an -U3 patch here?  Did
you use --inter-hunk-context?

This patch would be better viewed with --function-context to see that
the callbacks change multiple variables or do other funky things.  Only
doubles the line count.

> -static int decorate_callback(const struct option *opt, const char *arg,=
 int unset)
> +static int decorate_callback(const struct option *opt UNUSED, const cha=
r *arg,
> +			     int unset)
>  {
>  	if (unset)
>  		decoration_style =3D 0;

Sets decoration_style and decoration_given.  Never sets decoration_given
to a negative value.  This could be used to initialize decoration_style
to -1 and set decoration_given after parsing, then you could pass in
just decoration_style.

> @@ -1555,7 +1556,8 @@ static int inline_callback(const struct option *op=
t, const char *arg, int unset)
>  	return 0;
>  }
>
> -static int header_callback(const struct option *opt, const char *arg, i=
nt unset)
> +static int header_callback(const struct option *opt UNUSED, const char =
*arg,

Sorts strings into three string_lists based on prefix.  Could become a
vanilla OPT_STRING_LIST with parsing and sorting done later, if it
wouldn't interact with to_callback() and cc_callback().

(--function-context is not enough to see that, it requires a look at the
definition of those other functions as well.)

> +			   int unset)
>  {
>  	if (unset) {
>  		string_list_clear(&extra_hdr, 0);
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 21363b7985..0436986dab 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -231,7 +231,7 @@ static void append_strategy(struct strategy *s)
>  	use_strategies[use_strategies_nr++] =3D s;
>  }
>
> -static int option_parse_strategy(const struct option *opt,
> +static int option_parse_strategy(const struct option *opt UNUSED,

Could be an OPT_STRING_LIST and parsing done later.  Except that
=2D-no-strategy does nothing, which is weird.

>  				 const char *name, int unset)
>  {
>  	if (unset)
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 492372ee5d..91b4b7c177 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3739,7 +3739,7 @@ static void show_object__ma_allow_promisor(struct =
object *obj, const char *name,
>  	show_object(obj, name, data);
>  }
>
> -static int option_parse_missing_action(const struct option *opt,
> +static int option_parse_missing_action(const struct option *opt UNUSED,

Sets the enum arg_missing_action, fetch_if_missing and fn_show_object.
Could be changed to set only the enum and then you could pass it in.

>  				       const char *arg, int unset)
>  {
>  	assert(arg);
> @@ -4150,7 +4150,7 @@ static int option_parse_index_version(const struct=
 option *opt,
>  	return 0;
>  }
>
> -static int option_parse_unpack_unreachable(const struct option *opt,
> +static int option_parse_unpack_unreachable(const struct option *opt UNU=
SED,

Sets both unpack_unreachable and unpack_unreachable_expiration.  Perhaps
could set only unpack_unreachable_expiration and use TIME_MAX if no
argument is given, then set unpack_unreachable after parsing?  Not sure.

>  					   const char *arg, int unset)
>  {
>  	if (unset) {
> @@ -4165,7 +4165,7 @@ static int option_parse_unpack_unreachable(const s=
truct option *opt,
>  	return 0;
>  }
>
> -static int option_parse_cruft_expiration(const struct option *opt,
> +static int option_parse_cruft_expiration(const struct option *opt UNUSE=
D,

Does the same as option_parse_unpack_unreachable(), just with two
different variables.  And interacts with --cruft.

>  					 const char *arg, int unset)
>  {
>  	if (unset) {
> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> index 1fec702a04..8196ca9dd8 100644
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -49,7 +49,7 @@ static const char * const read_tree_usage[] =3D {
>  	NULL
>  };
>
> -static int index_output_cb(const struct option *opt, const char *arg,
> +static int index_output_cb(const struct option *opt UNUSED, const char =
*arg,

Calls set_alternate_index_output().  Could become an OPT_STRING_F if we
assume that the last value wins and earlier calls have no side effects.

>  				 int unset)
>  {
>  	BUG_ON_OPT_NEG(unset);
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index aee3cb8cbd..59acae3336 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -856,7 +856,7 @@ static int chmod_callback(const struct option *opt,
>  	return 0;
>  }
>
> -static int resolve_undo_clear_callback(const struct option *opt,
> +static int resolve_undo_clear_callback(const struct option *opt UNUSED,

Affects the_index.  This option (--clear-resolve-undo) is not mentioned
in Documentation/, by the way.  Not sure if it interacts with other
callbacks, like the one below.  Otherwise could be an OPT_BOOL and its
action done after parsing.  Perhaps pass in &the_index?

>  				const char *arg, int unset)
>  {
>  	BUG_ON_OPT_NEG(unset);
> @@ -890,7 +890,7 @@ static int parse_new_style_cacheinfo(const char *arg=
,
>  }
>
>  static enum parse_opt_result cacheinfo_callback(
> -	struct parse_opt_ctx_t *ctx, const struct option *opt,
> +	struct parse_opt_ctx_t *ctx, const struct option *opt UNUSED,

A low-level callback for a change.  Affects the_index.  Pass it in?
add_cacheinfo() would need to grow a parameter to receive it.  It would
document that this option directly changes the_index.

>  	const char *arg, int unset)
>  {
>  	struct object_id oid;

Phew, looks like that's stuff for a whole new series or two!

Ren=C3=A9
