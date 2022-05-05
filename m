Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E83C433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 13:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376668AbiEENSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 09:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbiEENS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 09:18:28 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2F91EC4E
        for <git@vger.kernel.org>; Thu,  5 May 2022 06:14:48 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t16so3076559qtr.9
        for <git@vger.kernel.org>; Thu, 05 May 2022 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7GjTK2gbsEBUFTV4gO/9VGx97A7LBL5WBlmkGtkD91A=;
        b=UNetUIu9UKpvC9KXqU9gYtUZ0dFJqsvp9a1OAjnH6heuO+nuShteToJ0mvS/8Wave/
         Baaz00hnV2+zlRBEum4Vp+VawgILrmplaorEnDq13tF/ZKFCjrqv60g8lf4W+W0rCfF9
         cwknXh/EqzJ8LVOAII+RM2vaoHfd5jc+PDroXMPlsaEfVhdH6+k3QodR6y5TDDLxd4RH
         /AEUyNLTNJlclPUOU6qh9K/zyAScAOU2ajnPyUx9MsDWmHuUHCFt4Cf8TtRfkcU4rgPH
         e6MSYitcHW33tXvSaELa/ITFk0qavAZ8uAmAWsDWo28LDhgRsP0y48tF2vcl4VCy0jty
         XNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7GjTK2gbsEBUFTV4gO/9VGx97A7LBL5WBlmkGtkD91A=;
        b=pXSxIR1elvjt4+88mD9Q1dvinmf4Gc9pA3mM9Oj6opjp6rrPk0mvR5fdJd6+3T0aar
         eFJ1gls1m+7usXdomYcVBM3+lt/5RKgbuzt3LPYi4MiLY1T1n9SksmAzaJNXUhkA8qdi
         GOLdAMHJ92+QyhTCeQIRlgMxgBhDAWtkFc3b8CeTBoLhqZUyAnElWdTzhzySRgffKdn7
         A/4adn3vPW+YPqIGQHXpFzg9s3YDXfNCljK5gtOLjl8pLPXCp9fk6OK6OfldqafpHTLc
         7Q71orRplG1ISm2tc1XBxms2/IUaI+FnWjy/g6XZzPh0ZEjUduQDxHXrRdpkpLKtqC2f
         7TGg==
X-Gm-Message-State: AOAM5327mAIv1cVfRjZ6z8h+mbnvdw3qkXsZSZHLudnEA2Dbe5L0RaVZ
        5JTX1rM7J/FIoP1srMyfUtHq
X-Google-Smtp-Source: ABdhPJwSb78Kx+fa6Gx/cjA/N8g6uPVbgM4Vf47cQ/NLm8CWU8OR42Jj8Wdjwrpsr1gc8c3ZKwylPg==
X-Received: by 2002:ac8:5dd0:0:b0:2f3:87d9:dede with SMTP id e16-20020ac85dd0000000b002f387d9dedemr23530090qtx.351.1651756487353;
        Thu, 05 May 2022 06:14:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a0d9:dd04:b268:f889? ([2600:1700:e72:80a0:a0d9:dd04:b268:f889])
        by smtp.gmail.com with ESMTPSA id x15-20020ac84a0f000000b002f39b99f6b2sm770871qtq.76.2022.05.05.06.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 06:14:46 -0700 (PDT)
Message-ID: <0f9aaada-8e72-38b9-e58a-9b26ed7bc780@github.com>
Date:   Thu, 5 May 2022 09:14:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] setup: tighten ownership checks post CVE-2022-24765
Content-Language: en-US
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, junio@pobox.com
References: <20220504184401.17438-1-carenas@gmail.com>
 <20220505005009.27789-1-carenas@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220505005009.27789-1-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/4/2022 8:50 PM, Carlo Marcelo Arenas Belón wrote:
> 8959555cee7 (setup_git_directory(): add an owner check for the top-level
> directory, 2022-03-02), adds a function to check for ownership of
> repositories using a directory that is representative of it (its workdir)
> and ways to add it to an exception list if needed, but that check breaks
> when the ownership of the workdir is not the same than the ownership of
> directory where the configuration and other relevant files reside.
> 
> An attacker could create a git repository in a directory that he has write
> access to but is owned by the victim, and therefore workaround the fix that
> was introduced with CVE-2022-24765 to attack them,

It's worth noting that this requires having the current user owning a
directory, but allowing other users to write into it.

> [...] like in the following
> scenario which could result in privilege escalation if root then runs a git
> command in that directory or any of its sub directories:
> 
>   $ git -C /tmp init

This /tmp example is an example of why that is actually common, and not
just a "user misconfigured their machine" issue.

> To avoid that, extend the ensure_valid_ownership function to be able to
> check for ownership of both the worktree and the gitdir, and use that for
> non bare repositories.

You mention extending the check here, but...

> -static int ensure_valid_ownership(const char *path)
> +static int ensure_valid_ownership(const char *worktree, const char *gitdir)
>  {
> -	struct safe_directory_data data = { .path = path };
> +	struct safe_directory_data data = { .path = worktree };
> +	const char *check_path;
> +
> +	if (gitdir)
> +		check_path = gitdir;
> +	else
> +		check_path = worktree;

...this makes it appear like you are choosing to check only _one_ of the
directories, not _both_, which is what I would expect for a strengthening
of our security checks.

>  	if (!git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
> -	    is_path_owned_by_current_user(path))
> +	    is_path_owned_by_current_user(check_path))
>  		return 1;

Indeed, we are checking only one of these directories for ownership.

I think you should remove check_path and instead do the following:

	if (!git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
	    is_path_owned_by_current_user(worktree) &&
	    (!gitdir || is_path_owned_by_current_user(gitdir)))
 		return 1;

Thanks,
-Stolee
