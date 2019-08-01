Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A03741F731
	for <e@80x24.org>; Thu,  1 Aug 2019 22:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388192AbfHAW5t (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 18:57:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33480 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732085AbfHAW5s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 18:57:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so34909641pfq.0
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 15:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jTb6se97cWxtOFYxdEUL4iquB3wNdOwkVDsaVjNnWdo=;
        b=jBE+0B2oJgNQLuBZN1V3oH122IcOz3Iz8ICw2N0F9VGuSyRWdG9YONKAC0QX5vsaQS
         aDEfdvmtZ86Pf7m5RmhFZZlt1pN4KLhtW1eLe+aoij5TcAi1FxUBwyeuA+35/Bhh9GPq
         kPt6B1NbPn3YeGp4FfR6yr+yvIWDqq8BLsOHabzR21QFGvudCiUTh+mPe6BGBGb70SsA
         S9p4b3w+3NyqQT/3qb6HvAPACL2QuSdHtdx8NOFb2dx0JE7M/pg9ViJkL4CmmEWG+hfe
         v3YpTOeUlRtX4UIUGwMIVsmJKvYJsaX7OkFX0m8kncLWvl/j+uRL1fFUuMk6B17M8oqK
         Mpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=jTb6se97cWxtOFYxdEUL4iquB3wNdOwkVDsaVjNnWdo=;
        b=TxOBg3WbmWwYZWSjkcNJoIt0elzVCSO+PoezahBA+ebPWSfLPmfYzsWX+spwPwzech
         3y9dNlMGXRQ7pOTq7MiQvmoLsfaCAtdNZoIeg4KwJHl95DgZpnWxZfCogoyfRvUqgIkb
         +Zd3GSLeyvaKmKO1UxbZD6Yex6wQK3bUFGcNe7G6rqeI6bl1YFfMz7RRMtqz06IWCJpK
         l6xvQsYl1zvbDkgXsJ0uFwl2uy5/88/QR3TY3ujoGpCZBc42AbVJOJTL+qi4OuC7xc4A
         pTuDUp1PrOAyORH4OnFbbxickLSANoXJmlOFNVjcpVqzkz2EfUHO/FvvAP9UefZ4ijWB
         aFQw==
X-Gm-Message-State: APjAAAUa26MekTd1lO3ehGCpwMEYNXOAPbuteGwaZfIRCQMeMuiPuMK0
        2et/9t6o4gskuJ/E+eDcsazKzA==
X-Google-Smtp-Source: APXvYqyrwcmGJ/sD9jM75GlfzTfKjT3ZT+/Apf+0v/L42nTDJlCHY5kPPuuVjvZlIVTy5OJNKmqROg==
X-Received: by 2002:a17:90a:6546:: with SMTP id f6mr1147103pjs.11.1564700267536;
        Thu, 01 Aug 2019 15:57:47 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id o95sm5536788pjb.4.2019.08.01.15.57.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 15:57:46 -0700 (PDT)
Date:   Thu, 1 Aug 2019 15:57:41 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] trace2: clean up formatting in perf target format
Message-ID: <20190801225741.GQ43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.298.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.298.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.07.31 13:04, Jeff Hostetler via GitGitGadget wrote:
> This patch series contains a few column alignment and whitespace fixes for
> perf target format. This should make it a little easier to read.
> 
> Jeff Hostetler (3):
>   trace2: cleanup column alignment in perf target format
>   trace2: trim whitespace in start message in perf target format
>   trace2: trim whitespace in region messages in perf target format
> 
>  trace2/tr2_tgt_perf.c | 42 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 10 deletions(-)
> 
> 
> base-commit: 026dd738a6e5f1e42ef0f390feacb5ed6acc4ee8
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-298%2Fjeffhostetler%2Fupstream-2230-cleanup-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-298/jeffhostetler/upstream-2230-cleanup-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/298
> -- 
> gitgitgadget

The series looks good to me.
