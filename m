Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA32C1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 06:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeKHPsS (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 10:48:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33918 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeKHPsS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 10:48:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so19895681wre.1
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 22:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tyPZ8NizQRr77+dmSQ+eyHbbQ5WLcXKVb+jRaq31NT4=;
        b=HQmHPjrc52bfC4JbtWRdRV7Cjzw3ET7oL9WUT7BXLKbzA8IKBErIG6y0MdywFvtGyi
         n+81RdWgf3s1xFNHo0GKswfZt74XM05xpw5Pw2+98svlMn/4wLkO9ZbAxO6GqXMG4c27
         AFe07IKknKk0ec1M3cQDtjqWTG92/VEDxPK/WhTAlRtu9BcfRtiRjZLLvPAxEPhJzC8e
         yvqgUquRDVuUN3AJgOafeZ6iqxr4LrhXFLSVfA/R3Gi/pkl0upvRXELXS6ll/4BDCJ8F
         kfe5HeTsKN+Q024Y+TwKgCzB92rHxJElEK9y6MBKKB3tqI/Ew3KFbhx9stdg3m/xvsT4
         EFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tyPZ8NizQRr77+dmSQ+eyHbbQ5WLcXKVb+jRaq31NT4=;
        b=hZ2uhN0V5YuyF2mduubDmFy6QRXZxBdxzmQJW07nG5c4/EZ/QDcLAawvhKXlUkF3jf
         2MFIAurXOolJ0f8v7ith2bCR70OcRkept1hoSOxY5UsNCnNvmq9qYmkkX4o2kXurXGR3
         L1kQAqUn9FLhtp11Z7nrMdNIvHpl40eELbyPz7REbXAeBFRAmfKOCG8wD7/WoOQmIr3l
         +Q1i3+I7kIugxMGWuT09LsPaXZRAi6SyJ7RfWvGjxB+xONslTicIzKWgxhYAZQl4y9ZN
         C7RtDyFZVKrRuQ6e3lIBuS/DSMw9ihamjjNbi+5Kl0FXM8RDeeFH+bWRsk/4bspzC22r
         J7Jw==
X-Gm-Message-State: AGRZ1gIT94xA3WgQQmfVXvmQDad1sT80ng6sb6xnOUXGU4gHFbZOEc5c
        3gQTvY0NysnpMmSO++d6OCk=
X-Google-Smtp-Source: AJdET5eDx6SPf93m2nbP6FPEh7kGLdNsWo60HL+ATo1LyxeMh1ZZXGkWwyhfJHWu6CCRf/ZEcmdnSA==
X-Received: by 2002:adf:b34e:: with SMTP id k14-v6mr2845282wrd.207.1541657664252;
        Wed, 07 Nov 2018 22:14:24 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h18-v6sm2314917wro.0.2018.11.07.22.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 22:14:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Force.Charlie-I via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] http: add support selecting http version
References: <pull.69.v2.git.gitgitgadget@gmail.com>
        <pull.69.v3.git.gitgitgadget@gmail.com>
Date:   Thu, 08 Nov 2018 15:14:22 +0900
In-Reply-To: <pull.69.v3.git.gitgitgadget@gmail.com> (Force Charlie-I via
        GitGitGadget's message of "Wed, 07 Nov 2018 20:54:57 -0800 (PST)")
Message-ID: <xmqqy3a46qpt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Force.Charlie-I via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Normally, git doesn't need to set curl to select the HTTP version, it works
> fine without HTTP/2. Adding HTTP/2 support is a icing on the cake.
>
> This patch support force enable HTTP/2 or HTTP/1.1. 
>
> example: 
>
> GIT_CURL_VERBOSE=1 git2 -c http.version=HTTP/2 ls-remote https://bitbucket.org/aquariusjay/deeplab-public-ver2.git
>
> Force Charlie (4):
>   http: add support selecting http version
>   support force use http 1.1
>   fix curl version to support CURL_HTTP_VERSION_2TLS
>   http: change http.version value type

When somebody reads over these four patches as a first-time reader,
I think s/he notices a couple of things:

 - In the proposed log messages, there is no explanation on the
   reason why we are doing these changes.

 - Each of the steps n/4 (n > 1) looks more like "oops, it was a
   mistake that we did not do this in earlier patch, and here is to
   correct that".

 - There is no test or documentation.

I suspect that a single patch that updates http.c, Documentation/
and t/ at the same time should be sufficient for a change of this
size.

Thanks.


>  http.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
>
> base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
> Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-69%2Ffcharlie%2Fmaster-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-69/fcharlie/master-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/69
>
> Range-diff vs v2:
>
>  1:  4f5a935c43 = 1:  4f5a935c43 http: add support selecting http version
>  2:  06e9685d2b = 2:  06e9685d2b support force use http 1.1
>  3:  eee67d8356 = 3:  eee67d8356 fix curl version to support CURL_HTTP_VERSION_2TLS
>  -:  ---------- > 4:  ef975b6093 http: change http.version value type
