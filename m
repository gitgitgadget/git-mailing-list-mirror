Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 636C41F576
	for <e@80x24.org>; Tue,  6 Mar 2018 10:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbeCFKWY (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 05:22:24 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:11787 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752908AbeCFKWX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 05:22:23 -0500
Received: from [192.168.2.201] ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id t9jhelxQtlYtpt9jhexF0T; Tue, 06 Mar 2018 10:22:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520331742;
        bh=t+445vQlajbqoTa8IPu+apqEmEY3g0YARncC9Hvh83Y=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=i5GF42h0f6dIhFELMit3+ZfxDnw1xHPTozbrSihvoaBOiLG45vBZBrF/B1H52hiZk
         dUrFSFhdTd/b7IsRrSWZxyeoyKFwI3VSK2w4EWPvjJaDota03xVS2kZqO1B/vMLWKz
         ZksUnlP2eQw2ZgZQwec9g6xLJZtpK9QjT20WJGp0=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=JZeSU3CV c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=q3880xPEMou4M2AT50MA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] completion: don't set PARSE_OPT_NOCOMPLETE on
 --rerere-autoupdate
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
References: <20180303092307.3796-1-pclouds@gmail.com>
 <20180303092307.3796-2-pclouds@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <623faa67-7072-3d72-e784-5380e204f570@talktalk.net>
Date:   Tue, 6 Mar 2018 10:22:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180303092307.3796-2-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIhqVX/6MI0KDBuO8exQCRqJCuBVMw8WLJekKRyIi9e5HL7zEX4lgahPFkq7gp80jIRYa/b6bByDe7P7WExM3GmR26CP6SRfpRFB3YD/d02AIs6u53yZ
 nUXDHpf581zm9ZiygUu+EZnU0N4yNXO7rpsA4sDwshyt1x+L0s5ibYDLweRqSusd0/96NcdNCfn3X44QujtgVdodHQ7pGE8OgiBv+Ffxqp6T1BcA3sLa8+eR
 /2EAieGkXN+rj7fInRrvfnKaBuTnsoTzNUHwqkEosj3EZoflT9XiEhiKRNiu3Z34UZdn9VYgU7YRn978dvyTDvQfn4gC1e7gHwmyURRuYeA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03/18 09:23, Nguyễn Thái Ngọc Duy wrote:
> 
> There is not a strong reason to hide this option, and git-merge already
> completes this one. Let's allow to complete this for all commands (and
> let git-completion.bash do the suppressing if neede).
> 
> This makes --rerere-autoupdate completable for am, cherry-pick and
> revert.
> 

This is slightly off topic as it doesn't use OPT_RERERE_AUTOUPDATE but
it looks[1] as if rebase is missing completion for --rerere-autoupdate
(and --signoff which is definitely off topic)

Best Wishes

Phillip

[1]
https://git.kernel.org/pub/scm/git/git.git/tree/contrib/completion/git-completion.bash#n2010


> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 3 +--
>  parse-options.h                        | 4 ++--
>  rerere.h                               | 3 +--
>  3 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 0ddf40063b..c310b241d3 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1754,8 +1754,7 @@ _git_merge ()
>  
>  	case "$cur" in
>  	--*)
> -		__gitcomp_builtin merge "--rerere-autoupdate
> -				--no-rerere-autoupdate
> +		__gitcomp_builtin merge "--no-rerere-autoupdate
>  				--no-commit --no-edit --no-ff
>  				--no-log --no-progress
>  				--no-squash --no-stat
> diff --git a/parse-options.h b/parse-options.h
> index 0ba08691e6..ab1cc362bf 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -148,8 +148,8 @@ struct option {
>  #define OPT_STRING_LIST(s, l, v, a, h) \
>  				    { OPTION_CALLBACK, (s), (l), (v), (a), \
>  				      (h), 0, &parse_opt_string_list }
> -#define OPT_UYN(s, l, v, h, f)      { OPTION_CALLBACK, (s), (l), (v), NULL, \
> -				      (h), PARSE_OPT_NOARG|(f), &parse_opt_tertiary }
> +#define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), NULL, \
> +				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
>  #define OPT_DATE(s, l, v, h) \
>  	{ OPTION_CALLBACK, (s), (l), (v), N_("time"),(h), 0,	\
>  	  parse_opt_approxidate_cb }
> diff --git a/rerere.h b/rerere.h
> index 5e5a312e4c..c2961feaaa 100644
> --- a/rerere.h
> +++ b/rerere.h
> @@ -37,7 +37,6 @@ extern void rerere_clear(struct string_list *);
>  extern void rerere_gc(struct string_list *);
>  
>  #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
> -	N_("update the index with reused conflict resolution if possible"), \
> -	PARSE_OPT_NOCOMPLETE)
> +	N_("update the index with reused conflict resolution if possible"))
>  
>  #endif
> 

