Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 648871F597
	for <e@80x24.org>; Wed, 18 Jul 2018 10:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbeGRLgK (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 07:36:10 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41770 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbeGRLgK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 07:36:10 -0400
Received: by mail-qt0-f193.google.com with SMTP id e19-v6so3553155qtp.8
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 03:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bgrJWnP57FVyIiG1obMew3Vkl6i7bBsYSVOSlFIddXI=;
        b=rF/dMah5GzFL4IhhYTFZ5XhlPmZ4SjgFFU5/fvyKRDIIU6vpDFikKc8lfjvAGD2Da3
         T9ngrFvyKCqIYLX4wLjiMXLrHz6CTwQm/P7gJPZjb8uIhqxNOfwHl79T7Lv5t8b5aMn6
         Qw08qcDA/LGnBKAu4PW4ZkvjO17jBcnnRNXNKKSBBEAP76UNWSPgkgpnO5MwUMphSxpb
         oF0F+nn50tqwWGDw4s+1sKfLK4DysuytnMmb1tx5iAtJlWZ7un4DYNu7N/4bO9ksjgpo
         4D5M1dMb/qjVU29g+8s4/pkvxNNPlCLQc6qn0puoAORvUURZ+6zhTOxz2UcLKiV7Sk7R
         Bnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bgrJWnP57FVyIiG1obMew3Vkl6i7bBsYSVOSlFIddXI=;
        b=I8+zvFKoHLTkqH/SocYesoXJZ+MjmcnJoeZ0NIaQoDoty319969vtiXA9sn4ztJn/j
         u0nIaKBze8fDLc7o0uH3Xpxg0wBUraWjnGPOLadOtMJ+QvgdzJeyhB4fiXAwtCz16eWE
         tpE8FrXooeCCmWwj+cUaBDnznxhhsygD3UF69fW1QjWu0Lyok05OktOjF9gJq5mRVJu8
         fyXK8rETNKe+6lIQT2RcdHdDfU6PhUabSzz9QD+Now9eqGl4aW0auOIM1qo2PnUPyFO9
         FIop4BkJR4N6JPEDnQ+bIp0Gd77jfgj9mH9e8SInp7lNAvJ4Blc/zEvOQ75FMbmP1USy
         F/Rw==
X-Gm-Message-State: AOUpUlHmTZ/6ICz5YtmvCLD0ebVSZdOonCFURua058Ai9/b1aWGDsqdd
        ee3kPJMTJOMEV6BtGn7tdYg=
X-Google-Smtp-Source: AAOMgpf/rJuadiQZmCbqZX+2S16h2e++Q07w4eqcfpdjn/f7NjVESP/uD8YGH5Yj8SNzqGbHpeIgpA==
X-Received: by 2002:ac8:51cd:: with SMTP id d13-v6mr5008866qtn.80.1531911528432;
        Wed, 18 Jul 2018 03:58:48 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id o68-v6sm1808658qkf.9.2018.07.18.03.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:58:47 -0700 (PDT)
Subject: Re: [PATCH 2/2] refs.c: upgrade for_each_replace_ref to be a
 each_repo_ref_fn callback
To:     Stefan Beller <sbeller@google.com>, dstolee@microsoft.com
Cc:     git@vger.kernel.org, mhagger@alum.mit.edu
References: <20180717224935.96397-1-sbeller@google.com>
 <20180717224935.96397-3-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6c74aee8-2e18-99de-f775-dced1310809f@gmail.com>
Date:   Wed, 18 Jul 2018 06:58:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180717224935.96397-3-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/17/2018 6:49 PM, Stefan Beller wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   builtin/replace.c | 3 ++-
>   refs.c            | 9 ++++-----
>   refs.h            | 2 +-
>   replace-object.c  | 3 ++-
>   4 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/replace.c b/builtin/replace.c
> index ef22d724bbc..5f34659071f 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -39,7 +39,8 @@ struct show_data {
>   	enum replace_format format;
>   };
>   
> -static int show_reference(const char *refname, const struct object_id *oid,
> +static int show_reference(struct repository *r, const char *refname,
> +			  const struct object_id *oid,
>   			  int flag, void *cb_data)
>   {
>   	struct show_data *data = cb_data;
> diff --git a/refs.c b/refs.c
> index 2513f77acb3..5700cd4683f 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1478,12 +1478,11 @@ int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
>   	return do_for_each_ref(refs, prefix, fn, 0, flag, cb_data);
>   }
>   
> -int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data)
> +int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
>   {
> -	return do_for_each_ref(get_main_ref_store(r),
> -			       git_replace_ref_base, fn,
> -			       strlen(git_replace_ref_base),
> -			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
> +	return do_for_each_repo_ref(r, git_replace_ref_base, fn,
> +				    strlen(git_replace_ref_base),
> +				    DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
>   }
>   
>   int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
> diff --git a/refs.h b/refs.h
> index 80eec8bbc68..a0a18223a14 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -317,7 +317,7 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
>   int for_each_tag_ref(each_ref_fn fn, void *cb_data);
>   int for_each_branch_ref(each_ref_fn fn, void *cb_data);
>   int for_each_remote_ref(each_ref_fn fn, void *cb_data);
> -int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data);
> +int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data);
>   int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
>   int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
>   			 const char *prefix, void *cb_data);
> diff --git a/replace-object.c b/replace-object.c
> index 801b5c16789..01a5a59a35a 100644
> --- a/replace-object.c
> +++ b/replace-object.c
> @@ -6,7 +6,8 @@
>   #include "repository.h"
>   #include "commit.h"
>   
> -static int register_replace_ref(const char *refname,
> +static int register_replace_ref(struct repository *r,
> +				const char *refname,
>   				const struct object_id *oid,
>   				int flag, void *cb_data)
>   {

Overall, I think this is the right approach. The only problem is that 
you're missing a few 'the_repository' to 'r' replacements in the bodies 
of show_reference and register_replace_ref.

Thanks,
-Stolee
