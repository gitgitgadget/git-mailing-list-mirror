Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DEBC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 22:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9437960F4C
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 22:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhHBWJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 18:09:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:41477 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231987AbhHBWJn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 18:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627942167;
        bh=t5DwV8oyC0izEitCKfMvtWRCAe9K28poXDEYOLE9cuo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Q295QlbZVio4SrIgiTqhKUB/ZgmAJgW9TUee7hj3tYdUPxdSsCTP86su/s7PbabxS
         B3rV2iJKs1gZ2IEo5h59dbvUIPHvXltfZFw+6UDzjp+azWFUT5hZ6PSpZZpX59KfMV
         exwvznx6ivqDGQ1e+jxK1KjUxa+UUhVjJMFreYZo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.101.220] ([89.1.212.168]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKHm-1n4qfz2NMy-00ylad; Tue, 03
 Aug 2021 00:09:27 +0200
Date:   Tue, 3 Aug 2021 00:09:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ben Boeckel <mathstuf@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 4/4] advice: remove static global variables for advice
 tracking
In-Reply-To: <20210731022504.1912702-5-mathstuf@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108030007060.55@tvgsbejvaqbjf.bet>
References: <20210731022504.1912702-1-mathstuf@gmail.com> <20210731022504.1912702-5-mathstuf@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HBppFi1Fo+DwBtqocIzuTXR9eglyZcetBHJsK+yZBIE1pCXhyUX
 k6dEc8K6UTLiL+vHjySqBlyDYdQakyBcwVMbJyQF5HJZj2rwxj3nfSC0zwdjDH4LIAyI66P
 llb0ZpcF+cdGfou3/5jFO83ep64hHvRxgJNfhmYrryOUJBzsvzMkzrcux0bMOfYf0Cvz1qP
 AzP8ohrNeFVmWL+GTLACA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AuNUL4kF5G4=:AryDHyJHsBznRBoG17oD8a
 m7ctAprKwgtyZBcj6Zbvp1jHwDBIcxsItMlF1OXOxQEH6vPOsdwJh5sRdkbN0F+5jeIkUKure
 QXKAd0gn7LVo/RBGDX0poyVKBKMjYn/T+yEDuvL8nvt8kwmbwBmy/0mTQNKdfxVgxVAAGflpE
 OcD96ZXhDHFQ/BxSRNIwf8rrdJn8zQz50whJm9q3elgG7S8N1pUdx4TeT6ONZWb16we24cpXu
 rxoAJyXVfAujD97oGxeFFjrJsOwk5RAR8C68gibCgPGG3GWjx3tSQ5iVSr6o3JqGDx7/SsZTD
 rf7I3PrurDeoSuxqM7TgggINCjp6A4DDqeVcOOG/eNozxg2oPFNW0uOPyRzJYKlAxUhP3TWGg
 MW+OT+8BZyIp3T25PD9JP5ZNLojqW21cMW0LeQyPQaDkrMEbDeRoMQGk45LMBFVl71R9UyOAw
 UaPwXjyBlWuhwQyDDU5sZgUpRr5IPuGNBTqyl51Aa2gCKiLvzb+H7NCoxpjivT8FdF7N8VRwR
 sgQZc/fkmmGRui0h3hzpx4hWVPITmD3/h9x0/JAkLORvR8+dk4Z3WxZRs7gLCK/5N8eniC1b9
 s9iKiTyE53UQspCrG3v4OuV+0kulNiK4hmTOQQvwUffLnAdIKoZrOUnGWqeLEhnHAxd3vjWZN
 3prErrcAy6pBUKbSf7iqAvffNi1hXlUEr/Qa/Rll9f+7hNV6EwvQq50dhYuaKS/MoF0mTbc6s
 PlCUcmzjXEJmh4Z/7sMT2RBgW2hrSG5AEXSPbymnIa6hGaX05nIGqqPw85idpJwg8asV/nmyd
 E2Z980uZCVxHYoaqvwLJEDkhzFUacZw+ic0qs5YnpFEQQoaPqmc3Yk4Im5TLL1ZMAPVL/Evzf
 uW+cK9lAqbDu12gsc2jlQfJOViS2LFGNCozUNJRGuv2sAeh6op89UUOt4zJnDRzSzxotMomON
 DeEU3R0r+vs4QSDH3UU9asjWWhYeF5vt+MnCUHC6jCzjT5UixVFj9WuJ7ik8QpTPugSYsjH/t
 hrn7qhkifDSdp0qCE/8uW1g43LfBsNl/p2etLJsRJ1uyPT0RhlpXLJVDVAsBdmS3v8nGQYqEy
 O28Bv9Xd69NJU4yHhokEm8N96biYzxtEWmFtZ3vSFE/R95Q9+S7Ss4X9A==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Fri, 30 Jul 2021, Ben Boeckel wrote:

> All of the preferences are now tracked as part of the `advice_setting`
> array and all consumers of the global variables have been removed, so
> the parallel tracking through `advice_config` is no longer necessary.

Maybe add "This concludes the move from the old advice API to the new one
introduced via c4a09cc9ccb (Merge branch 'hw/advise-ng', 2020-03-25)"?

At least this reader would have found that helpful.

And as I mentioned in the review of patch 3/4, the removal of the
explicit assignment to the `advice_*` global variables should be moved
here.

Ciao,
Dscho

>
> Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
> ---
>  advice.c | 77 --------------------------------------------------------
>  advice.h | 31 -----------------------
>  2 files changed, 108 deletions(-)
>
> diff --git a/advice.c b/advice.c
> index ee4edc5e28..6ba47f3f5e 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -4,37 +4,6 @@
>  #include "help.h"
>  #include "string-list.h"
>
> -int advice_fetch_show_forced_updates =3D 1;
> -int advice_push_update_rejected =3D 1;
> -int advice_push_non_ff_current =3D 1;
> -int advice_push_non_ff_matching =3D 1;
> -int advice_push_already_exists =3D 1;
> -int advice_push_fetch_first =3D 1;
> -int advice_push_needs_force =3D 1;
> -int advice_push_unqualified_ref_name =3D 1;
> -int advice_push_ref_needs_update =3D 1;
> -int advice_status_hints =3D 1;
> -int advice_status_u_option =3D 1;
> -int advice_status_ahead_behind_warning =3D 1;
> -int advice_commit_before_merge =3D 1;
> -int advice_reset_quiet_warning =3D 1;
> -int advice_resolve_conflict =3D 1;
> -int advice_sequencer_in_use =3D 1;
> -int advice_implicit_identity =3D 1;
> -int advice_detached_head =3D 1;
> -int advice_set_upstream_failure =3D 1;
> -int advice_object_name_warning =3D 1;
> -int advice_amworkdir =3D 1;
> -int advice_rm_hints =3D 1;
> -int advice_add_embedded_repo =3D 1;
> -int advice_ignored_hook =3D 1;
> -int advice_waiting_for_editor =3D 1;
> -int advice_graft_file_deprecated =3D 1;
> -int advice_checkout_ambiguous_remote_branch_name =3D 1;
> -int advice_submodule_alternate_error_strategy_die =3D 1;
> -int advice_add_ignored_file =3D 1;
> -int advice_add_empty_pathspec =3D 1;
> -
>  static int advice_use_color =3D -1;
>  static char advice_colors[][COLOR_MAXLEN] =3D {
>  	GIT_COLOR_RESET,
> @@ -62,45 +31,6 @@ static const char *advise_get_color(enum color_advice=
 ix)
>  	return "";
>  }
>
> -static struct {
> -	const char *name;
> -	int *preference;
> -} advice_config[] =3D {
> -	{ "fetchShowForcedUpdates", &advice_fetch_show_forced_updates },
> -	{ "pushUpdateRejected", &advice_push_update_rejected },
> -	{ "pushNonFFCurrent", &advice_push_non_ff_current },
> -	{ "pushNonFFMatching", &advice_push_non_ff_matching },
> -	{ "pushAlreadyExists", &advice_push_already_exists },
> -	{ "pushFetchFirst", &advice_push_fetch_first },
> -	{ "pushNeedsForce", &advice_push_needs_force },
> -	{ "pushUnqualifiedRefName", &advice_push_unqualified_ref_name },
> -	{ "pushRefNeedsUpdate", &advice_push_ref_needs_update },
> -	{ "statusHints", &advice_status_hints },
> -	{ "statusUoption", &advice_status_u_option },
> -	{ "statusAheadBehindWarning", &advice_status_ahead_behind_warning },
> -	{ "commitBeforeMerge", &advice_commit_before_merge },
> -	{ "resetQuiet", &advice_reset_quiet_warning },
> -	{ "resolveConflict", &advice_resolve_conflict },
> -	{ "sequencerInUse", &advice_sequencer_in_use },
> -	{ "implicitIdentity", &advice_implicit_identity },
> -	{ "detachedHead", &advice_detached_head },
> -	{ "setUpstreamFailure", &advice_set_upstream_failure },
> -	{ "objectNameWarning", &advice_object_name_warning },
> -	{ "amWorkDir", &advice_amworkdir },
> -	{ "rmHints", &advice_rm_hints },
> -	{ "addEmbeddedRepo", &advice_add_embedded_repo },
> -	{ "ignoredHook", &advice_ignored_hook },
> -	{ "waitingForEditor", &advice_waiting_for_editor },
> -	{ "graftFileDeprecated", &advice_graft_file_deprecated },
> -	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remo=
te_branch_name },
> -	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_er=
ror_strategy_die },
> -	{ "addIgnoredFile", &advice_add_ignored_file },
> -	{ "addEmptyPathspec", &advice_add_empty_pathspec },
> -
> -	/* make this an alias for backward compatibility */
> -	{ "pushNonFastForward", &advice_push_update_rejected }
> -};
> -
>  static struct {
>  	const char *key;
>  	int enabled;
> @@ -228,13 +158,6 @@ int git_default_advice_config(const char *var, cons=
t char *value)
>  	if (!skip_prefix(var, "advice.", &k))
>  		return 0;
>
> -	for (i =3D 0; i < ARRAY_SIZE(advice_config); i++) {
> -		if (strcasecmp(k, advice_config[i].name))
> -			continue;
> -		*advice_config[i].preference =3D git_config_bool(var, value);
> -		break;
> -	}
> -
>  	for (i =3D 0; i < ARRAY_SIZE(advice_setting); i++) {
>  		if (strcasecmp(k, advice_setting[i].key))
>  			continue;
> diff --git a/advice.h b/advice.h
> index 101c4054b7..17ee5d3633 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -5,37 +5,6 @@
>
>  struct string_list;
>
> -extern int advice_fetch_show_forced_updates;
> -extern int advice_push_update_rejected;
> -extern int advice_push_non_ff_current;
> -extern int advice_push_non_ff_matching;
> -extern int advice_push_already_exists;
> -extern int advice_push_fetch_first;
> -extern int advice_push_needs_force;
> -extern int advice_push_unqualified_ref_name;
> -extern int advice_push_ref_needs_update;
> -extern int advice_status_hints;
> -extern int advice_status_u_option;
> -extern int advice_status_ahead_behind_warning;
> -extern int advice_commit_before_merge;
> -extern int advice_reset_quiet_warning;
> -extern int advice_resolve_conflict;
> -extern int advice_sequencer_in_use;
> -extern int advice_implicit_identity;
> -extern int advice_detached_head;
> -extern int advice_set_upstream_failure;
> -extern int advice_object_name_warning;
> -extern int advice_amworkdir;
> -extern int advice_rm_hints;
> -extern int advice_add_embedded_repo;
> -extern int advice_ignored_hook;
> -extern int advice_waiting_for_editor;
> -extern int advice_graft_file_deprecated;
> -extern int advice_checkout_ambiguous_remote_branch_name;
> -extern int advice_submodule_alternate_error_strategy_die;
> -extern int advice_add_ignored_file;
> -extern int advice_add_empty_pathspec;
> -
>  /*
>   * To add a new advice, you need to:
>   * Define a new advice_type.
> --
> 2.31.1
>
>
