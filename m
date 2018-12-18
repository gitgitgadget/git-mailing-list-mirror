Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEC261F405
	for <e@80x24.org>; Tue, 18 Dec 2018 19:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeLRTHa (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 14:07:30 -0500
Received: from mail-yb1-f170.google.com ([209.85.219.170]:45477 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbeLRTHa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 14:07:30 -0500
Received: by mail-yb1-f170.google.com with SMTP id r11so6897017ybp.12
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 11:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TaSge7oNQj71NmXL2VrZZaa8PjBzL4clsJtOza/7BiI=;
        b=gXcjedQPAvQLvGUBFJ6PjhhcCSWc72aJoO4ujRGeRNXPQz2WzxlOGRMeMwPkxZROqN
         QosKJJdIklW7SzzEXQZrsHGJ5Ut+VCA5pWMA35Q32RKgdNmcP6DXQXxg69eYGMIsUE/x
         gvEKS5YyTVi4qN35YUK6vWPiqWIFc7M3Zb2Vej119nPi5lhYSjSuX+9P35jJgDXFOtIq
         JWAdMdcfGyJJ9vMeIgPAHhZQkp0ZdO9NufMfZ1rttIk/8tcI7PX9ODeOWP72oaJVZ09I
         w48w9RxU6HMHvq+/UHDGue9ymm2HmAAP90w/yT/rwB8DbA0vcyCZFGCcIcR8d2R4U/yV
         ObuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TaSge7oNQj71NmXL2VrZZaa8PjBzL4clsJtOza/7BiI=;
        b=jTqEPI472Off57awE8QB+CrMcKwsRwvNc1ELzrfbET4kkfnVc6Ij9Lx3xQSNWcIfIJ
         gCuBWv4lIL/W/ZAjt+quxI6bnq+oneXspyA7SKLZHKPKeHU5jLCyzQxkKtfZIIyDP2aW
         Acaev92gdRWUI0BEIwwcksoY7BK80HaWb3Tx9FEWyXJ8kc1tpK3QbM5Zm8NDqUmQwLKn
         d1EBbdsEP1uBlYNmDOHz7fAthiqZdYsKKKk1l4JzK89pWgkVGX2i1xOtI8xM2MUFGEes
         gOjKUDC71agibGNvsk/8SgDmzPxwwCEQne2mWazufpPL8wr3oMnbM7omI4xwam/9+XuX
         rXew==
X-Gm-Message-State: AA+aEWb3RahmtPkiR1O2SkOt/4ERWIys77Au2HtpxnhsG9y+8zU5Jai6
        389ievbnIQgZ8K33o3bDiqQ5RKLW
X-Google-Smtp-Source: AFSGD/VHLX2rEtXK6hGc5X68yqc7h3fL3XkmKwsPtszYC2DNW8TZAqtSsGUCDiVkQTuOkg2kHfb91Q==
X-Received: by 2002:a25:bd81:: with SMTP id f1mr17872511ybh.98.1545160049247;
        Tue, 18 Dec 2018 11:07:29 -0800 (PST)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id j6sm5453817ywi.110.2018.12.18.11.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 11:07:28 -0800 (PST)
Subject: Re: commit-graph idea: warn when disabled for incompatible
 repositories
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CAEcj5uXJC3Za0YCyazJi82JdF-tLCDs5OrzCwyD8Y155GnJa6Q@mail.gmail.com>
 <b74bab07-dd77-5195-aaee-a324e9a6b824@gmail.com>
 <87bm5ig0h3.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <98e86f95-78d7-a64b-86d9-c33cecfcb28c@gmail.com>
Date:   Tue, 18 Dec 2018 14:07:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <87bm5ig0h3.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/18/2018 1:21 PM, Ævar Arnfjörð Bjarmason wrote:
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 871a56f1c5..702568b70d 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -662,9 +662,14 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>   	if (pack_garbage.nr > 0)
>   		clean_pack_garbage();
>
> -	if (gc_write_commit_graph)
> +	if (gc_write_commit_graph) {
> +		int verbose = !quiet && !daemonized;
> +		if (verbose && !commit_graph_compatible(the_repository))
> +			warning(_("The `gc.writeCommitGraph' setting is on, "
> +				  "but commit_graph_compatible() = false"));
>   		write_commit_graph_reachable(get_object_directory(), 0,
> -					     !quiet && !daemonized);
> +					     verbose);
> +	}

I actually think this is the wrong place to put it. This will cause a 
warning for someone with 'gc.writeCommitGraph' enabled and running GC on 
a shallow clone.

I think the issue was someone running 'git commit-graph write' inside a 
shallow clone that succeeds without doing anything.

Also, I bet you would hit this block if you run the test suite with 
GIT_TEST_COMMIT_GRAPH=1.

Thanks,

-Stolee


>   	if (auto_gc && too_many_loose_objects())
>   		warning(_("There are too many unreachable loose objects; "
> diff --git a/commit-graph.c b/commit-graph.c
> index 40c855f185..60915bf9aa 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -61,7 +61,7 @@ static struct commit_graph *alloc_commit_graph(void)
>
>   extern int read_replace_refs;
>
> -static int commit_graph_compatible(struct repository *r)
> +int commit_graph_compatible(struct repository *r)
>   {
>   	if (!r->gitdir)
>   		return 0;
> diff --git a/commit-graph.h b/commit-graph.h
> index 9db40b4d3a..7c92d41a28 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -12,6 +12,8 @@ struct commit;
>
>   char *get_commit_graph_filename(const char *obj_dir);
>
> +int commit_graph_compatible(struct repository *r);
> +
>   /*
>    * Given a commit struct, try to fill the commit struct info, including:
>    *  1. tree object

This part looks correct, and necessary for the warning in 
builtin/commit-graph.c

Thanks,

-Stolee

