Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D377EC43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 05:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiFHFRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 01:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbiFHFNd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 01:13:33 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2390A9CF14
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 19:14:19 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id s23so17462806iog.13
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 19:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WZhTQMuEaWa1s/PfGxN4+8gjahB8Pl9Zp4bGD6poaGY=;
        b=TbV8enlGJZBKr4jxxBBtcxp3CtLhi3WIv6h+EFSjtYUdA/PwHF60B2rTWnlwqx/Qd1
         v3zylAIoT+n/fcnHS8IojFbvYgMfDY4GhsIA/AqV5Ehg7qUCtMrv46Yf2aG6ZRxdmWOa
         2Izj5Kt2keXVjLSQ0CY68ClDySA/9BDWbtrbxw/arfmCMHdX9d0lw3igB/4F7uxbSCS0
         S3OQSP64Sh9AUIhigpr88yFvnUd9P6TuTJRz3D7XKkJ7k3UIHQcMM1ZzoKB/3cdLAnC5
         Ye+vrFvP79tJt/LqqfndAx8+/e5xvWSv7gW62o6YezMrl2PlXt8t/uv/VxBH2m9HqAdU
         f/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WZhTQMuEaWa1s/PfGxN4+8gjahB8Pl9Zp4bGD6poaGY=;
        b=id6I5JbrK0CldwiycjoMBH5oXHkrkyeX05RESol4DSuKPwWFeyJD03Unl6ckCTeXdW
         wGQEgSw54M0MHJOiN7HVj3Bu4webcUPAjosQB4WaMT9cc9ioEfYupV80/lKIdrO32wsM
         3hrws/KuSbXBf86pt8ViDkhM/RspjFy+t7svHI0sqVC7hrtT6VOexanphvz46yXdKNxJ
         WQk+NPEKSeb8rH+jBiW6lFi6qKZTz27ohZMz/GC5LWwdJyLJ/xzg3lBCOwe49expsh9e
         Yu1pAOamvIanA8lRAKriwZdpkQBJ0C+M2gDWRxfHIN4ZxcPw4Au6yIwKo22YLcp9SHGv
         OPZA==
X-Gm-Message-State: AOAM533kKyeVdAQZSIrraR/+LEdATKRbV7DMHUZp5sR3eB3akx8/dMy5
        iN2OJSQwRG+VsvYW4VFBUamF
X-Google-Smtp-Source: ABdhPJyUgVbiY3fZtY/HIW5hCDP6tCy9okxiY6vNcXzXEha8zrBpjMrPlSE99ZkhKGBLzzvrvnNbQw==
X-Received: by 2002:a05:6602:150f:b0:669:3a9e:e1f3 with SMTP id g15-20020a056602150f00b006693a9ee1f3mr9647655iow.35.1654654458502;
        Tue, 07 Jun 2022 19:14:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3125:e4aa:20a:c5bc? ([2600:1700:e72:80a0:3125:e4aa:20a:c5bc])
        by smtp.gmail.com with ESMTPSA id b28-20020a056638389c00b00331ab545889sm2935830jav.45.2022.06.07.19.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 19:14:18 -0700 (PDT)
Message-ID: <e84b8f19-4fb4-77cd-7e56-087e84e59817@github.com>
Date:   Tue, 7 Jun 2022 22:14:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/7] branch: add branch_checked_out() helper
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
 <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <5f54766e1032ebf3a331516a6dd696b997bdfdd8.1654634569.git.gitgitgadget@gmail.com>
 <xmqqr140t9am.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqr140t9am.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2022 6:09 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +int branch_checked_out(const char *refname, char **path)
>> +{
>> +	struct worktree **worktrees = get_worktrees();
>> +	const struct worktree *wt = find_shared_symref(worktrees, "HEAD", refname);
>> +	int result = wt && !wt->is_bare;
>> +
>> +	if (result && path)
>> +		*path = xstrdup(wt->path);
>> +
>> +	free_worktrees(worktrees);
>> +	return result;
>> +}
> 
> Don't you plan to call this repeatedly from the for_each_deco
> iteration?  I am wondering if it should take the result of
> get_worktrees() and reuse the result of get_worktrees(), instead of
> enumerating the list of worktrees and freeing for each of the
> branches you need to inspect.

Sorry, you had mentioned this in v1 and I just forgot to fix this.

> There also was another topic
> 
> https://lore.kernel.org/git/pull.1266.v2.git.git.1652690501963.gitgitgadget@gmail.com/
> 
> that was triggered by find_shared_symref() being relatively
> heavy-weight, which suggests a more involved refactoring.
> 
> I wonder if we rather want to rewrite find_shared_symref() *not* to
> take the target parameter at all, and instead introduce a new
> function that takes a worktree, and report the branch that is
> checked out (or being operated on via rebase or bisect).  Then we
> can
> 
>  - create a strset out of its result, i.e. set of branches that
>    should not be touched;
> 
>  - iterate over refs that point into the history being rebased
>    (using for_each_decoration()), and consult that strset to see if
>    any of them is being rewritten.
> 
> With the API of find_shared_symref(), we'd need to iterate over all
> worktrees for each decoration.  With such a restructuring, we can
> iterate over all worktrees just once, and match the result with
> decoration, so the problem becomes O(N)+O(M) and not O(N*M) for
> number of worktrees N and number of decorations M.

Yes, that's a good plan. I'll take a look.

Thanks,
-Stolee
