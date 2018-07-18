Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2ACD1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 20:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbeGRVC4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 17:02:56 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37744 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbeGRVCz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 17:02:55 -0400
Received: by mail-qk0-f195.google.com with SMTP id t79-v6so3099539qke.4
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 13:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oR5Yv2O97JgcH19CMFzgbXcBnJjF+++GXPXHrAN0iEQ=;
        b=hmx/zanQSpCo+Lx0zwKO+l8fz/ol6x4XvvJzYcJz3QNgHkoeV0PQCIDeklp6euSZXK
         uQRoRXGitEbxDg+s55iLGjIf8B/X1QqRUO3znRFO7T3PnNDYli36QV1oOPCPbunhCbiQ
         bbx2hrddc8+pvN5YDq/CF6dUlmL5s/saGdpPGERhcAs0SJa3iQLBORaQG3v6JMOrxKBN
         DqN64ZyQ4zuu2sICQuvDS4jhYQNneviyrT/SXRmIkFqbbHXnLWmhbp8hlv13M+Mnrkhk
         Bth401M1uaeoUMNZOi6jFiki+MgC5WC4QLJF5WyMec3N6abdXYoKSMmqDan5e9Jzhta+
         My7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oR5Yv2O97JgcH19CMFzgbXcBnJjF+++GXPXHrAN0iEQ=;
        b=m7akwDyb8F4cynriVczJ/exs8M+UZ1TZ/2Djs06HnAa9eY6a4sQhbaKOIgAB5lgEks
         k0tkuIBndnuBuibaAh1qGlZSTWAnZ8FQ80gR9DZYADNR9iKpuxPoLuhMpIWF5Gn0OetS
         Mvoq8wz8pp6GXmEIezUvgs4OxkAsqYC1JlGHMskEWyj0KEVHmYWy/qY7I+KgurXwcped
         Pouo3Um/DTKciOzyheqZ6WbbKbrm23C8k5QYPJ6VgXs5HolXPAjkSop2KzKuHEqiF2Bz
         E2A0ebZzkDOO3NJLTrF4qv+EQT6/wRTHM+bIEmqKC+sCc6j0kg4Z1AGM/Tsy1faRW1Mz
         fZKg==
X-Gm-Message-State: AOUpUlEuHkt96qAa7dfjrBl82QAR8ueP1VsrvCOmK7u1ty8WnH2pAUz6
        IBOCF9fHNShzMcPVqsdcn8Y=
X-Google-Smtp-Source: AAOMgpeYfQ+r9ESR0h4bmT+G3iFxqGBR7zibDyQhpxXLZJbwJKolUjFR+xDUHHc8mMVRf/mXPuuLJg==
X-Received: by 2002:a37:d942:: with SMTP id u63-v6mr6892949qki.165.1531945402939;
        Wed, 18 Jul 2018 13:23:22 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:68c3:1c3b:990:6a4f? ([2001:4898:8010:0:51f9:1c3b:990:6a4f])
        by smtp.gmail.com with ESMTPSA id v71-v6sm4249781qkl.42.2018.07.18.13.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 13:23:22 -0700 (PDT)
Subject: Re: [PATCH] add core.usereplacerefs config option
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <sbeller@google.com>
References: <20180718201702.GA15306@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c36c1b42-3f37-b32d-08a8-2ced5d254149@gmail.com>
Date:   Wed, 18 Jul 2018 16:23:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180718201702.GA15306@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/18/2018 4:17 PM, Jeff King wrote:
> We can already disable replace refs using a command line
> option or environment variable, but those are awkward to
> apply universally. Let's add a config option to do the same
> thing.
>
> That raises the question of why one might want to do so
> universally. The answer is that replace refs violate the
> immutability of objects. For instance, if you wanted to
> cache the diff between commit XYZ and its parent, then in
> theory that never changes; the hash XYZ represents the total
> state. But replace refs violate that; pushing up a new ref
> may create a completely new diff.
>
> The obvious "if it hurts, don't do it" answer is not to
> create replace refs if you're doing this kind of caching.
> But for a site hosting arbitrary repositories, they may want
> to allow users to share replace refs with each other, but
> not actually respect them on the site (because the caching
> is more important than the replace feature).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> We've been using this patch for about 4 years at GitHub. I'm not sure
> why I never sent it upstream until now, since it's pretty trivial.
>
> I think this should interact OK with Stefan's recent c3c36d7de2
> (replace-object: check_replace_refs is safe in multi repo environment,
> 2018-04-11), because we still consider check_replace_refs before doing
> anything in lookup_replace_object(). So even if you accidentally
> _loaded_ the replace refs due to a timing issue (e.g., looking at them
> before reading config) we still wouldn't respect them as long as you've
> loaded config by the time you're actually looking at objects.
>
> I followed the existing style of t6050 here, but it looks like it could
> use some modernization (indent with spaces, and piping git command
> output losing the exit codes).
>
>   Documentation/config.txt | 5 +++++
>   config.c                 | 5 +++++
>   t/t6050-replace.sh       | 6 ++++++
>   3 files changed, 16 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1cc18a828c..92b277d27b 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -908,6 +908,11 @@ core.commitGraph::
>   	Enable git commit graph feature. Allows reading from the
>   	commit-graph file.
>   
> +core.useReplaceRefs::
> +	If set to `false`, behave as if the `--no-replace-objects`
> +	option was given on the command line. See linkgit:git[1] and
> +	linkgit:git-replace[1] for more information.
> +
>   core.sparseCheckout::
>   	Enable "sparse checkout" feature. See section "Sparse checkout" in
>   	linkgit:git-read-tree[1] for more information.
> diff --git a/config.c b/config.c
> index f4a208a166..ce103ebc20 100644
> --- a/config.c
> +++ b/config.c
> @@ -1346,6 +1346,11 @@ static int git_default_core_config(const char *var, const char *value)
>   					 var, value);
>   	}
>   
> +	if (!strcmp(var, "core.usereplacerefs")) {
> +		check_replace_refs = git_config_bool(var, value);
> +		return 0;
> +	}
> +
>   	/* Add other config variables here and to Documentation/config.txt. */
>   	return 0;
>   }
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> index aa3e249639..86374a9c52 100755
> --- a/t/t6050-replace.sh
> +++ b/t/t6050-replace.sh
> @@ -113,6 +113,12 @@ test_expect_success 'test GIT_NO_REPLACE_OBJECTS env variable' '
>        GIT_NO_REPLACE_OBJECTS=1 git show $HASH2 | grep "A U Thor"
>   '
>   
> +test_expect_success 'test core.usereplacerefs config option' '
> +	test_config core.usereplacerefs false &&
> +	git cat-file commit $HASH2 | grep "author A U Thor" &&
> +	git show $HASH2 | grep "A U Thor"
> +'
> +
>   cat >tag.sig <<EOF
>   object $HASH2
>   type commit

This patch looks good to me. The only thing I saw was when I ran 'git 
grep check_replace_refs' and saw the following in environment.c:

     int check_replace_refs = 1; /* NEEDSWORK: rename to 
read_replace_refs */

This does help me feel confident that the case where the config value is 
missing will default to 'yes, please check replace refs', but also the 
NEEDSWORK could be something to either (1) do, or (2) remove the 
comment. Neither needs to happen as part of this patch.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

