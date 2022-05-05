Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DFAC433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 13:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380301AbiEEOCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 10:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiEEOCi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 10:02:38 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617EB2D1F0
        for <git@vger.kernel.org>; Thu,  5 May 2022 06:58:59 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id l1so635661qvh.1
        for <git@vger.kernel.org>; Thu, 05 May 2022 06:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=hsndDoMgrO6hzeevRWDvYwv+jupa2mL2Qi/QfNnCCLY=;
        b=K2pGzPQhtSycwwSDZudBHYXrFVcK7YtAqGEuIoSoUoWVKgq9uezbI4Jg3rRSqnmm4x
         WXsCJRMeGPuSBgXk/uYmbi3I2UC0mcXL5aUP5io6bqBOAgKTX0TJVdJp5OuQ4w8DROr7
         zJWJyUF0MTzxNadnYBmPfHxnDWy9LnzaijyH6vUritOMxRuBPYpalsCa3ktpmtXmZvsR
         5xSG0wWUA3OGxaLdx/CDcJNRSzh2V/7kWrSXXj6Gt+18XZXZswzdqXD9INiZ5BCg9TVX
         CzfTJ+Lw/b+1Sal0FwXPca/1e3FR7LRYnu0No5xjJLXISYbhesbMd7cUHC7yn6ie+Rbf
         Kykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=hsndDoMgrO6hzeevRWDvYwv+jupa2mL2Qi/QfNnCCLY=;
        b=VstBwPSPuiwZR85MLE4ZdootMl9ISE/YG6eZvWOrTlRBA420a/yvRgOd9SIzRjjlyn
         hcHkS3hpvhjSTtKyOwEADf2mQN9je7GEuV9K35daWE2N4zUnRsmfFgRCSQknpi+TXW4n
         QBigjup1dmu5WCvpoifX3yu//YyytL5CX2TmAOZzXeeuYV+3a53g/JqaZslkKcEtlAGx
         Q/DkAiUuEr6XDzxtfjUUlOoSWjvZ2JGXKGkdr57VRqsCHBxXeXXaNwFQTIH/sQzxN4kB
         tcADOKszvSALuo8sNL+0REKAx0Lu/EqRI2O996rmijV/Zarg+CLeePmcH2JMvWxvN57c
         2RjA==
X-Gm-Message-State: AOAM530ibRI8Mmk9ZDLug/L15RydxdulhdKd2TQq+fEWHaaavC528DJT
        zKmD0vGDJTQuQdMFfFCi2aBA
X-Google-Smtp-Source: ABdhPJxu6xxoRkbqag6vL+xcx0pTIdscr3J8K1ZDyyBTfAHvfj9RRJmpBJhaeCTUwD/B3YOZNlEpKg==
X-Received: by 2002:a05:6214:b94:b0:456:38b2:2d76 with SMTP id fe20-20020a0562140b9400b0045638b22d76mr21790219qvb.70.1651759138463;
        Thu, 05 May 2022 06:58:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a0d9:dd04:b268:f889? ([2600:1700:e72:80a0:a0d9:dd04:b268:f889])
        by smtp.gmail.com with ESMTPSA id h15-20020a05620a400f00b0069fc13ce24bsm823962qko.124.2022.05.05.06.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 06:58:58 -0700 (PDT)
Message-ID: <281017cb-0078-0635-8a3b-fed430b5439a@github.com>
Date:   Thu, 5 May 2022 09:58:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] setup: tighten ownership checks post CVE-2022-24765
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, junio@pobox.com
References: <20220504184401.17438-1-carenas@gmail.com>
 <20220505005009.27789-1-carenas@gmail.com>
 <0f9aaada-8e72-38b9-e58a-9b26ed7bc780@github.com>
In-Reply-To: <0f9aaada-8e72-38b9-e58a-9b26ed7bc780@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/5/2022 9:14 AM, Derrick Stolee wrote:
> On 5/4/2022 8:50 PM, Carlo Marcelo Arenas Belón wrote:
>> -static int ensure_valid_ownership(const char *path)
>> +static int ensure_valid_ownership(const char *worktree, const char *gitdir)
>>  {
>> -	struct safe_directory_data data = { .path = path };
>> +	struct safe_directory_data data = { .path = worktree };

This also seems a bit backwards to me. I think bare repos will have a NULL
worktree, but all repos will have a gitdir. I think what we really want
is this:

	.path = worktree ? worktree : gitdir

And that might affect the callers of this method allowing the worktree to
be NULL.

> I think you should remove check_path and instead do the following:
> 
> 	if (!git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
> 	    is_path_owned_by_current_user(worktree) &&
> 	    (!gitdir || is_path_owned_by_current_user(gitdir)))
>  		return 1;

But that changes my logic here to instead be

 	if (!git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
	    is_path_owned_by_current_user(gitdir) &&
	    (!worktree|| is_path_owned_by_current_user(worktree)))
  		return 1;

Thanks,
-Stolee
