Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD61C433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 07:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhLNHii (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 02:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhLNHii (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 02:38:38 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399CEC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 23:38:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso15409694pjb.2
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 23:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=z0MtoN35chdW+ly5XcjmuJ1TO0VG9Z4an28plCtxSn8=;
        b=oScI8MXmWES5GWlwppqw+saFcu/azaY3Y18LxFotaR2o8l83JyMtB3CX/FkzNOwTg2
         OyEluCiQT4RsQJ+xc0r+vscPluJRRksq/7XpOkzvmNaTcFj7D0YEdLrLQsXQFjiNEYAx
         0mhu+fSrqV19bc33/36JkoRIP6YEcPzOCeQ8RVyHam0I+dTrWWZ6bc7shvkZgrw+LBYr
         sadNEAbQLgWN+wCzSfRvM10OIeF13UFw12JVYxJal0luW+mu1wFG+77l7U+lQ5D9D4i2
         zdKI2214AT/zdSDkJn2nLoOetsqw6SoyRrKNR3Mesan6HhfeLZuNCZ+doQ+FDY4adA5B
         Y7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z0MtoN35chdW+ly5XcjmuJ1TO0VG9Z4an28plCtxSn8=;
        b=guHLkywt4ozsb7mot0qIezYvghzm+x6VeQV3OS2vAvSJGhxdaflzoDRUthnwonVvaF
         pyIUO83rDMsXC0fod+oXVxxn14Od22+q5LZ+8tcaZnfmD58yfr9HZdQ08g64RvXwuntj
         3l7XyBYbujjak6+rJy6NbWSNv1CaQTGVlPlNtLlY4Mq8ZHuO2sx+uyU2027PkJBw3Mk1
         CPIojrmZObOdiGnvG/k17WY0lvH2d0KJZ+PY+dwUJStX/dmmBXddcxKoZwL/51f8CeTh
         0gDjwtWX94fPZ6qhlSJQBfvFG4qRt41JPwhz0pKeejuYtgnBKP3/er3ZKqDa6G6yPea0
         +a5Q==
X-Gm-Message-State: AOAM531CLkrIsiDahP4orbxu73wG6zWz+lSB4KM8OhkqujNNrtSQx+Ak
        dkoz7dDU/97mbkI6PKP001o=
X-Google-Smtp-Source: ABdhPJz0j5Cd2erRz0LCxHz7Kqxh5uyttg26JU2r8dlsMgxQnbwWAO62uhAhASNoVQQewDIxjtnhmw==
X-Received: by 2002:a17:90a:a786:: with SMTP id f6mr3855866pjq.158.1639467517745;
        Mon, 13 Dec 2021 23:38:37 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-85.three.co.id. [180.214.233.85])
        by smtp.gmail.com with ESMTPSA id b19sm14982017pfv.63.2021.12.13.23.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 23:38:37 -0800 (PST)
Message-ID: <84ffc06d-09a7-0180-5460-6e1460b8aaac@gmail.com>
Date:   Tue, 14 Dec 2021 14:38:33 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 09/10] Documentation: clarify/correct a few sparsity
 related statements
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
 <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
 <f669829a98b590d8a53be75b88d97b1d004eb855.1639454952.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <f669829a98b590d8a53be75b88d97b1d004eb855.1639454952.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/12/21 11.09, Elijah Newren via GitGitGadget wrote:
>   --sparse::
> -	Initialize the sparse-checkout file so the working
> -	directory starts with only the files in the root
> -	of the repository. The sparse-checkout file can be
> -	modified to grow the working directory as needed.
> +	Employ a sparse-checkout, with only files in the toplevel
> +	directory initially being present.  The
> +	linkgit:git-sparse-checkout[1] command can be used to grow the
> +	working directory as needed.
>   

s/toplevel/top-level/

>   It uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell
>   Git whether a file in the working directory is worth looking at. If
>   the skip-worktree bit is set, then the file is ignored in the working
> -directory. Git will not populate the contents of those files, which
> +directory. Git will avoid populating the contents of those files, which
>   makes a sparse checkout helpful when working in a repository with many
>   files, but only a few are important to the current user.
>   

Looks OK.

-- 
An old man doll... just what I always wanted! - Clara
