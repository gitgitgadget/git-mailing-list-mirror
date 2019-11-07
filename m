Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A021A1F4C0
	for <e@80x24.org>; Thu,  7 Nov 2019 01:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfKGB0l (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 20:26:41 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35122 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfKGB0k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 20:26:40 -0500
Received: by mail-pg1-f195.google.com with SMTP id q22so637256pgk.2
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 17:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6V96EQTf34S7wY7GVn2R+GSNJowMNlelbDycpnWrXiY=;
        b=KsJLPTl8y6hGHxxsJDvNoe+xnoncGUek0wJCdrIC2xeZprBOh5wJ5Z0sRHNHCDNgGt
         jaXUr0HkhjoaqEY3pOyXarYU08cS1qqdhCwpHwSMVsItSi8dfGAcQM75N+z54Wv1SP6y
         rl/2WksutWrdscpvZGvXlJWNzCiwKKMGA9OYABOxgywVcKSyeN4Ml4jz8ouxwOxkf9fu
         SDhFyujTohB5bgdFJSuEHzqKsijQJT5hLGvNorVIv4Q4raQxYuqUuBfWZwSZ0RkxWM88
         Jfbs1I/kNiXDtT4Vx7s+2eEg+AMQOnDFnSdrVSl/29gG/L1w71M8XcUlMSyiG69NqhXL
         yjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6V96EQTf34S7wY7GVn2R+GSNJowMNlelbDycpnWrXiY=;
        b=Fwu/d4GdCMQ69dlDXQVDZ3Vky2D71ZtG++QttkdNqnyZXKVuNnpB33FNBpbS0vuNIM
         jESNFXYixW4tPqtpPa7s0GdT7p79LDhfTn1JlmI3Dpug7lfTDFZjfn6pqYtZ9HD1KkOX
         rPDfHBG2QvqCmAJXwBy1P3wU4MLdRvwqrX008Nhymo7vgSGu3CrWaoAciAvDctjNmiQI
         Y+tOE6nPwF6b5BLZpLVSCDeCK1AKTIeVy3FIvX6rkRl+gPu2ASSOiLgRLzTlgAApuHhO
         +5rh5j0FjHqsIXH7Xryd+As5MFHfqlF8UZHzesDwq1lrFW42PsUaLpDalrsCvCw1qYlS
         I74Q==
X-Gm-Message-State: APjAAAVT4fvIsnhCV5FrH7n78WZLQkr828KluTDup6yj3yYujrRXCUaA
        BIFNG1AbK1xx0iApywthZRZi7A==
X-Google-Smtp-Source: APXvYqynRUvLC9VB+7A2uBIu50z1Zss+5797zDEd3Hr0DME00Dv4c8rb0RPoOexKKCJxC9CoBsV86A==
X-Received: by 2002:aa7:9f0e:: with SMTP id g14mr505385pfr.202.1573089998198;
        Wed, 06 Nov 2019 17:26:38 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id m15sm328703pgv.58.2019.11.06.17.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 17:26:37 -0800 (PST)
Date:   Wed, 6 Nov 2019 17:26:33 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/20] pathspec: move doc to pathspec.h
Message-ID: <20191107012633.GG229589@google.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
 <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
 <dcb78b6708937c3c6af5a86c276918c19e46acd4.1573034387.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcb78b6708937c3c6af5a86c276918c19e46acd4.1573034387.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 06, 2019 at 09:59:37AM +0000, Heba Waly via GitGitGadget wrote:
> From: Heba Waly <heba.waly@gmail.com>
> 
> Move the documentation from Documentation/technical/api-setup.txt
> to pathspec.h as it's easier for the developers to find the usage
> information beside the code instead of looking for it in another doc file.
> 
> Also documentation/technical/api-setup.txt is removed because the
> information it has is now redundant and it'll be hard to keep it up to
> date and synchronized with the documentation in the header file.
> 
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
>  Documentation/technical/api-setup.txt | 47 ---------------------------
>  pathspec.h                            | 34 ++++++++++++++++++-
>  2 files changed, 33 insertions(+), 48 deletions(-)
>  delete mode 100644 Documentation/technical/api-setup.txt
> 
> diff --git a/Documentation/technical/api-setup.txt b/Documentation/technical/api-setup.txt
> deleted file mode 100644
> index eb1fa9853e..0000000000
> --- a/Documentation/technical/api-setup.txt
> +++ /dev/null
> @@ -1,47 +0,0 @@
> -setup API
> -=========
> -
> -Talk about
> -
> -* setup_git_directory()
> -* setup_git_directory_gently()
> -* is_inside_git_dir()
> -* is_inside_work_tree()
> -* setup_work_tree()
> -
> -(Dscho)
> -
> -Pathspec
> ---------
> -
> -See glossary-context.txt for the syntax of pathspec. In memory, a
I kind of miss this pointer after the change. But, maybe other folks in
the project prefer to let someone grep for this themselves.


Otherwise it looks fine to me. Thanks.

 - Emily
