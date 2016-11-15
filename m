Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1FE72021E
	for <e@80x24.org>; Tue, 15 Nov 2016 21:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752497AbcKOVJR (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 16:09:17 -0500
Received: from mout.gmx.net ([212.227.15.18]:56791 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbcKOVJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 16:09:16 -0500
Received: from [192.168.178.43] ([88.70.147.72]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MRoyH-1cCy5A0IH3-00T00Z; Tue, 15
 Nov 2016 22:09:13 +0100
Subject: Re: [PATCH v15 04/27] bisect--helper: `bisect_clean_state` shell
 function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1a82-dc1c5b57-3e93-4996-87e7-4a1d83cb5817-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <13aa642a-2272-c5b8-4a30-382ab5e73b98@gmx.net>
Date:   Tue, 15 Nov 2016 22:09:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <01020157c38b1a82-dc1c5b57-3e93-4996-87e7-4a1d83cb5817-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:vPpKlgPP0NJojVesxEdJ70MOCiJ675VGb/0RQfvVfR5x6HrqzpW
 tym6Up560v3VrQzB0Oqs8fuaGBE95tEy98Aa2e+gZKTdbpBjpxWoQZYkHejGjMID6b9EGwO
 FOxBQ6YV6ASBlox8hoMF4Ugy3Xr/c0/DWLuWFkEtMefKLxo7N9Zcq2/vFQEfEuYKNeZLebT
 NGWsVfMK/82gBr8vEXxpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GU+Phrvz5Yg=:xP8wU/xRooMnT/TletOYwN
 Yxp7sXYsq9kz67yDBVZLY++w3JZsnB89DZDPeF95t8IuFiHLYOejoozzLYwcXqSPyz15c6L3o
 UDJOu9CHHR22Txlhi3T3m99blnWSUN6BKKoN70kDiSrfrV6XfdDB8h3bGNuW8Q8akQFo+sbLs
 dx4tF12wORRthjve7nR0OQAp6cZjK36XO44MFSvKaCbxON9a4jrHuiyNRjGT4+4u+qOYNCbhj
 414IiR9i2UX0cmG+LSqS7BFkNoLGXGcRzOQYiqE+8R+ty2P42oFNBF7TUgtLag5l14ZBkRqAw
 qIZNGivWahPQtdM0zgmSb785Sn1rttc5rMll4H/OJ2SVJ9b6HSqHcn3QlQICmrQU40HocoCv9
 Z9wy6SoMe0tUWZP/Nma2Y0r52tYgkVIr+tAVxL+fbRo8q1QunvrNoAtmit1FfQWLF8aYgNMOw
 4quUXNGyce0UeH5x55xwAP3IycSGar+UkM3uSlWKtTrWq9O6MR4UD3L4rUqAXPZQNAPSmAjmY
 EGGL5uKY6b+1JM1yeCtc3KZhrTLi8ncRViMT0dvPh4xUrxYteWv4mnvXF4xoxfQO8yDAM70Ju
 F6WU3Mvr6Tx+DUeZQ18oJ2Qo1KE4BuwbNWRuF71evCdXyjxBk8lox4sRYcxvj6soaugLNNtVE
 7dxZJHMel+boP2oYMMTzSmLMYmFeKBvCInkPgkwb1y2rSpTZe0U0OSANEahyVWjLT6L5hSpBs
 5eXQJDIN7CFwHknQAERU3zGcWZI1mmIbjAArIrsoaY+zwSSMyIxvB3ZREj5JO94od72O8PE/v
 1OcSAys
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 10/14/2016 04:14 PM, Pranit Bauva wrote:
> diff --git a/bisect.c b/bisect.c
> index 6f512c2..45d598d 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -1040,3 +1046,40 @@ int estimate_bisect_steps(int all)
>  
>  	return (e < 3 * x) ? n : n - 1;
>  }
> +
> +static int mark_for_removal(const char *refname, const struct object_id *oid,
> +			    int flag, void *cb_data)
> +{
> +	struct string_list *refs = cb_data;
> +	char *ref = xstrfmt("refs/bisect%s", refname);
> +	string_list_append(refs, ref);
> +	return 0;
> +}
> +
> +int bisect_clean_state(void)
> +{
> +	int result = 0;
> +
> +	/* There may be some refs packed during bisection */
> +	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
> +	for_each_ref_in("refs/bisect", mark_for_removal, (void *) &refs_for_removal);
> +	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
> +	result = delete_refs(&refs_for_removal, REF_NODEREF);
> +	refs_for_removal.strdup_strings = 1;
> +	string_list_clear(&refs_for_removal, 0);

Does it have advantages to populate a list (with duplicated strings),
hand it to delete_refs(), and clear the list (and strings), instead of
just doing a single delete_ref() (or whatever name the singular function
has) in the callback?
I am only seeing the disadvantage: a list with duped strings.

> +	unlink_or_warn(git_path_bisect_expected_rev());
[...]
> +	unlink_or_warn(git_path_bisect_start());

Comparing it with the original shell code (which uses "rm -f"), I was
wondering a little after reading the function name unlink_or_warn()
here... Looking it up helped: despite its name, unlink_or_warn() is
really the function you have to use here ;D

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 65cf519..4254d61 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -5,10 +5,15 @@
>  #include "refs.h"
>  
>  static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
> +static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
> +static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
> +static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
> +static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")

This is perhaps a non-issue, but you do not need any of these new path
functions in *this* patch. I think nobody really cares, though, because
you will need them later.

Cheers
Stephan
