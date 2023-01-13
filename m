Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE58C6379F
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 22:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjAMWJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 17:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjAMWJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 17:09:29 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CB811826
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 14:09:28 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id l22so25748300eja.12
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 14:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljFLQIPH4xiehdj4cE19faYpM37e9a/G9+I1eFFgDTA=;
        b=WRUiYcg5yi1RKrYO0+jYOKE7iKUHkitU4YVELv5Zy8FF3I9YHKXT0cJ9LHdnYqItYw
         WzkKcYO1dMMl/Etz18X2eUQHzL0YofzjjfKTprqe4jDxOWxDrGwyGbt1AxNs75S3v2dZ
         J8e4GDtlGZiojiHR91nw7UiNtB7S53yJ5mb075fB53HlxREcW9d5eLAaVUe1OaEwVQ2q
         CvZwZaknzazR49JOinix1gWPSgQ42atvUteBRd7CMl77jkiGODTL0T1JAJE/n1UGovWu
         UWkMXs+LjF0Z+SNNh6RQMwKFHu5eaBXn5+uj1uUGSgme1IVrL1eOzCUolB0mQ/aZtj5l
         32Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljFLQIPH4xiehdj4cE19faYpM37e9a/G9+I1eFFgDTA=;
        b=yz37BSZJ/v7O//RN3fIaKhFw1ADiCVwLM/I3Y6VFdiGito3JEFo6SDlPigCJGdjGnb
         bpmFzcdr5Qz+zcAwYkoB4tu1lBCQa75KeOYvZ5KXy9qkUevxLnVNMbBdO0mQiKGF62z+
         yxLJMgo66eWugZoJKcqVBMtYAOUWQ4YD1MghtYDmR+rMoCAA9h5rVMiDewN85xtWlgY7
         fIMuuQfMQQ00HkD4CI8xotn5X2Oi8jWuPHPeXIdH0KoB9MwobJv3hVHJDIW1Iefl/74v
         3gYA74aLSq36sxWguufzWyrTS6pV4/wDJZbiaUEdZn4UWskQhVsAaXIEtBigQl9ooE3b
         Lrew==
X-Gm-Message-State: AFqh2kp2OVLMvRPlo0aqC1pAlYuEbulzr2t03nUXRGWndbaczJODCAgh
        tzmdulm1Uj82VBjlUS16+2b4ESaVHMaMjdKkNic=
X-Google-Smtp-Source: AMrXdXusjR+sOJ5d5+ZK9WK722xNqTPC8VOAmrmmKngtorZIM3GSJ/XEpg0mtUtyCDguHRXxv9wYOw==
X-Received: by 2002:a17:906:a853:b0:84d:4325:7f7a with SMTP id dx19-20020a170906a85300b0084d43257f7amr4387593ejb.65.1673647766565;
        Fri, 13 Jan 2023 14:09:26 -0800 (PST)
Received: from [10.12.18.155] ([45.88.97.218])
        by smtp.gmail.com with ESMTPSA id lb19-20020a170907785300b0084d1efe9af6sm8943300ejc.58.2023.01.13.14.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 14:09:26 -0800 (PST)
Message-ID: <f03094ce-e9e5-9530-7ed7-893a3f291ab0@gmail.com>
Date:   Fri, 13 Jan 2023 23:09:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] t6426: fix TODO about making test more comprehensive
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1462.git.1673584084761.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <pull.1462.git.1673584084761.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/01/2023 05:28, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> t6426.7 (a rename/add testcase) long had a TODO/FIXME comment about
> how the test could be improved (with some commented out sample code
> that had a few small errors), but those improvements were blocked on
> other changes still in progress.  The necessary changes were put in
> place years ago but the comment was forgotten.  Remove and fix the
> commented out code section and finally remove the big TODO/FIXME
> comment.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

Thank you for taking care of this FIXME.

>      t6426: fix TODO about making test more comprehensive
>      
>      See
>      https://lore.kernel.org/git/CABPp-BFxK7SGs3wsOfozSw_Uvr-ynr+x8ciPV2Rmfx6Nr4si6g@mail.gmail.com/
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1462%2Fnewren%2Ft6426-fix-todo-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1462/newren/t6426-fix-todo-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1462
> 
>   t/t6426-merge-skip-unneeded-updates.sh | 56 ++++++++++----------------
>   1 file changed, 22 insertions(+), 34 deletions(-)
> 
> diff --git a/t/t6426-merge-skip-unneeded-updates.sh b/t/t6426-merge-skip-unneeded-updates.sh
> index 2bb8e7f09bb..1fcf5d034ed 100755
> --- a/t/t6426-merge-skip-unneeded-updates.sh
> +++ b/t/t6426-merge-skip-unneeded-updates.sh
> @@ -380,40 +380,28 @@ test_expect_success '2c: Modify b & add c VS rename b->c' '
>   
>   		# Make sure c WAS updated
>   		test-tool chmtime --get c >new-mtime &&
> -		test $(cat old-mtime) -lt $(cat new-mtime)
> -
> -		# FIXME: rename/add conflicts are horribly broken right now;
> -		# when I get back to my patch series fixing it and
> -		# rename/rename(2to1) conflicts to bring them in line with
> -		# how add/add conflicts behave, then checks like the below
> -		# could be added.  But that patch series is waiting until
> -		# the rename-directory-detection series lands, which this
> -		# is part of.  And in the mean time, I do not want to further
> -		# enforce broken behavior.  So for now, the main test is the
> -		# one above that err is an empty file.
> -
> -		#git ls-files -s >index_files &&
> -		#test_line_count = 2 index_files &&
> -
> -		#git rev-parse >actual :2:c :3:c &&
> -		#git rev-parse >expect A:b  A:c  &&
> -		#test_cmp expect actual &&
> -
> -		#git cat-file -p A:b >>merged &&
> -		#git cat-file -p A:c >>merge-me &&
> -		#>empty &&
> -		#test_must_fail git merge-file \
> -		#	-L "Temporary merge branch 1" \
> -		#	-L "" \
> -		#	-L "Temporary merge branch 2" \
> -		#	merged empty merge-me &&
> -		#sed -e "s/^\([<=>]\)/\1\1\1/" merged >merged-internal &&
> -
> -		#git hash-object c               >actual &&
> -		#git hash-object merged-internal >expect &&
> -		#test_cmp expect actual &&
> -
> -		#test_path_is_missing b
> +		test $(cat old-mtime) -lt $(cat new-mtime) &&
> +
> +		git ls-files -s >index_files &&
> +		test_line_count = 2 index_files &&
> +
> +		git rev-parse >actual :2:c :3:c &&
> +		git rev-parse >expect A:c  A:b  &&
> +		test_cmp expect actual &&
> +
> +		git cat-file -p A:b >>merge-me &&
> +		git cat-file -p A:c >>merged &&
> +		>empty &&
> +		test_must_fail git merge-file \
> +			-L "HEAD" \
> +			-L "" \
> +			-L "B^0" \
> +			merged empty merge-me &&
> +		sed -e "s/^\([<=>]\)/\1\1\1/" merged >merged-internal &&

It seems that this line can be dropped, because merged-internal is not
inspected afterwards. None of the other tests in the file do similar
calls to `sed`.  Such substitutions with sed are present in
t6422-merge-rename-corner-cases.sh and t6406-merge-attr.sh though.

> +
> +		test_cmp merged c &&
> +
> +		test_path_is_missing b

Function test_setup_2c() creates commits in order: commit O (create b),
commit A (modify b, create c), and then commit B (rename b->c).
I would have preferred if "test_path_is_missing b" check was done
several lines higher, just before "test_line_count = 2 index_files".
It feels more natural with this order of commits in setup to check what
happened to file "b" first.  It would also mean that all checking of
directory contents is done in one place, before merge conflict in file
"c" is inspected.

I see, however, that all tests in this file follow the pattern of
checking missing files at the very end, and consistency might be
preferable here.

>   	)
>   '
>   
> 
> base-commit: 2b4f5a4e4bb102ac8d967cea653ed753b608193c

Aside from unnecessary call to sed and nitpicking about order of
assertions, the patch looks good to me.
