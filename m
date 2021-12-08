Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE5BC433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 19:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhLHUBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 15:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhLHUBe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 15:01:34 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E09CC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 11:58:02 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso3890226otr.2
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 11:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:cc:in-reply-to:content-transfer-encoding;
        bh=zAsngNLnx/ElS5HSXa6S592PmFEJ54cd5Imejn8ZOrU=;
        b=Jnx937htkxPJwwFD2Fz4ByE8NXBHx0yj4hifOIUwIVzysrnjkGphbdNkNinPE5McFB
         g6cuROalWV8j4fvsT9bzNtYFSrtPHMHv00c+DDWcqK3lDxxc7q11InPElDXcvPfq4sAs
         DmX36xme+mMbgADFVM8jPNVkX6lsJysFzb8iWNvPOGbPRfZs1wIcu/esiHeZ5NzJ7Hzo
         G78j7aERo8tbPBnF8mWZg1+RrnhMcDhxn53xOjWjRxDfgVd3n5/KqxAURyZy6wjb2g0D
         +8ZaV7IoiABz+gqNNOzXRq/dxQFTQH+eLoH7lzbCfIG70TB7FdEaViimvKNp+b3+eb1G
         bYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=zAsngNLnx/ElS5HSXa6S592PmFEJ54cd5Imejn8ZOrU=;
        b=eyCX1fnOF0rr2gWSjhp+/Cg6b2WDsFZgz5XD8VNpiFTSXMMuHU8zzEUeZDikw4Lb1f
         Z26IkBpd9mER9E0M4sCm4MxuIobNNIpY4ozc5l6jwMLJxzkFs8vHuEaYBZwrUanZ1yhf
         ZpTU+kOZkwzcIqi7LGlzMfEJhGSFaI6ZPEyNlQvfqG2VHaaVYtBjMiCPjhGCKw6I8QiS
         vkQ0TEB8hnbY9eEyExtmgn8QUpHGMzhw/T1pdLWmOa7b11vHKa5b7UBqckH0QVJ4Euga
         pyKFglUHvUc1frAQOe/WCArQ6oT+EOlND0Gg1bZ6PGVtEj5vCsCmYkDkl17OjMuKZGZs
         dPdA==
X-Gm-Message-State: AOAM532GczdEV5s1bMU8JUg0jaeB4ei/MX9k7rKGKl5qOxJI/Yl3d/vP
        GoTlqvXlFUd/K2AgnB8Z7ig=
X-Google-Smtp-Source: ABdhPJzcZtzm5zOr5y+I84+GSvEGVn0XKmIWoG0w1LS1wHtxswfwnIH3HMJL0kNUmrow4QHVHKJ9yg==
X-Received: by 2002:a05:6830:104f:: with SMTP id b15mr1395282otp.215.1638993481658;
        Wed, 08 Dec 2021 11:58:01 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id t13sm814810oiw.30.2021.12.08.11.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 11:58:01 -0800 (PST)
Message-ID: <a4968ff2-17c6-faa8-e9be-0c1880e870dd@gmail.com>
Date:   Wed, 8 Dec 2021 13:57:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: ld/sparse-diff-blame, was What's cooking in git.git (Dec 2021, #02;
 Tue, 7)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8rwv6e0a.fsf@gitster.g>
From:   Lessley Dennington <lessleydennington@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
In-Reply-To: <xmqq8rwv6e0a.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> * ld/sparse-diff-blame (2021-12-06) 8 commits
>   - blame: enable and test the sparse index
>   - diff: enable and test the sparse index
>   - diff: replace --staged with --cached in t1092 tests
>   - repo-settings: prepare_repo_settings only in git repos
>   - test-read-cache: set up repo after git directory
>   - commit-graph: return if there is no git directory
>   - git: ensure correct git directory setup with -h
>   - Merge branch 'vd/sparse-reset' into ld/sparse-diff-blame
>   (this branch is used by ds/fetch-pull-with-sparse-index; uses vd/sparse-reset.)
> 
>   Teach diff and blame to work well with sparse index.
> 
>   Will merge to 'next'?
>   source: <pull.1050.v6.git.1638806161.gitgitgadget@gmail.com>
> 

This series has been reviewed at different stages by:

Junio C Hamano <gitster@pobox.com>
	- Suggested addition of BUG in prepare_repo_settings.
	- Suggested --help fix for certain builtins when run outside repos
	  or with special config settings.
	- Suggested using --cached instead of --staged in diff tests.
Elijah Newren <newren@gmail.com>
	- Suggested diff commit message cleanup.
	- Corrected git commit message typo.
	- Corrected comment on blame sparse index tests specifying why
	  this builtin does not work on files outside the working
	  directory.
Ævar Arnfjörð Bjarmason <avarab@gmail.com>
	- Suggested lower case first letter in prepare_repo_settings BUG
	  message.
Taylor Blau <me@ttaylor.com>
	- Suggested diff/blame commit description cleanups
	- Suggested addition of more diff sparse index test cases
	- Suggested cleanup of blame sparse index test cases
	

I believe all comments have been addressed (either in the form of a
re-roll or a patch or explanation in my reply) and that this branch is
ready to merge to 'next'. I have cc'd all reviewers, though, in case there
was something I missed.

Lessley
