Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9DD20954
	for <e@80x24.org>; Wed, 22 Nov 2017 19:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbdKVTsK (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 14:48:10 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38214 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdKVTsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 14:48:09 -0500
Received: by mail-wm0-f44.google.com with SMTP id 128so12444359wmo.3
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 11:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VWaNh4yb/rqhRL8HhZdhp7EThMX6LKssKKuomBe6bck=;
        b=KCP8hQqUNTzaEQdIp0hhlsNyV8psBuZvbucwX2onPpPOrdSIM6ZS656gjF0l8+r9mB
         cehNN0d/LpCrhtkWTc2x3z4Lg3D5b5oN17VcAr1PY5qTLJTYt3WuqJ/Bi8yVUw+N2azy
         6nxFHV0MewTlHZrzxlwARPRlDZ1sqphnFV6Mc8b9Biv3YBGcDGghTImA191Ue6YK/wGj
         Huvho7QlndON3t/5SPccHqH8/xifUQwGgpTgPQ+gVACKIBda08ilq1XtNBH3HSp+zu4O
         /9lVZLX/OasgZnCdg+EUborF8BR4YaYYvwO0XOeQcEzDcUrecsjWxYIrtgRBcee9uNG/
         I/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VWaNh4yb/rqhRL8HhZdhp7EThMX6LKssKKuomBe6bck=;
        b=YYWuHMyGbY04Rh/2eFyyn87lOKK9uV6D5W8KwsCwM39SDp9mSwdB2RXbMYDbhp8BZV
         odF/t2a9zFR5SuVO343/GWFQfZLqOEWLzpDWgB0OedvbsVO0El2G+CvPYzDeCRAvywLx
         bXJYUESuI3UukNWKb6RA7DErniEuuAPE/K79ZYyv5jVccs7GLzdUAplo+QDAGSkrp6JJ
         kBnZ/ewusGt5WBmxZ8FXKVJg53az6ZP3uxhdJslNqw/2u2pmOBS8j1XUl5zFZTQOslbk
         q39XaWOYmVvL8kDu0gF4DGmQN9e0M95rGAli7VtkHjxZ6P2YDM4F5E6BjgG4UBOCAPFL
         4oew==
X-Gm-Message-State: AJaThX5xSC0m1OwdqnzmtdfzMkfoaaOCHYDN6Ggxr+L4tMtxku5nmTfK
        fdp+ntTjPzSio2yypuYz8UE=
X-Google-Smtp-Source: AGs4zMaU0KaI6lDorKGzUBnIiwmwAXLfCux1N+JgWENupGcyZ2r72xAIFrnh3zdmW1Ay6DlaDykwiw==
X-Received: by 10.28.158.206 with SMTP id h197mr4835274wme.23.1511380088604;
        Wed, 22 Nov 2017 11:48:08 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id d9sm11511544wrf.45.2017.11.22.11.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 11:48:06 -0800 (PST)
Date:   Wed, 22 Nov 2017 19:49:37 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 3/3] worktree: make add <path> dwim
Message-ID: <20171122194937.GA11773@hank>
References: <20171118181103.28354-1-t.gummerer@gmail.com>
 <20171118224706.13810-1-t.gummerer@gmail.com>
 <20171118224706.13810-4-t.gummerer@gmail.com>
 <CAPig+cQqbvuZg0Y8ZMObZc7mYXzohooVBFj0-o+CGGXrgGLp5w@mail.gmail.com>
 <CAPig+cTmqHt5s+C1vTFA7S4ZBwjqnzkn-2wA6i3jVeLw7i1_Lg@mail.gmail.com>
 <20171121221339.GA4047@hank>
 <xmqqh8tnyuq3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh8tnyuq3.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/22, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > I didn't consider that, I think you are right, and the flag should
> > apply in that case as well.  I think at that point we may as well pass
> > this flag through to the 'git branch' call, and let users set up
> > tracking if they want to, the same way it works in 'git branch'.
> 
> OK, so tracking is set up by default in the current implementation
> of "git worktree" (even without your proposed update), but we will
> stop doing so, and instead take an explicit "--track" option (or
> "--no-track" to countermand an earlier "--track" on the command line
> and/or a default configured with branch.autosetupmerge) just like
> "git branch" does?

I was a bit brief in the above.  The full story is that tracking is
set up by default if the '<branch>' given is a remote tracking branch,
and isn't set up otherwise, the same way as 'git branch' behaves.

What I'm planning to do is introduce a --[no-]track flag to override
this behaviour.  As 'git worktree' really just calls 'git branch'
internally, the branch.autoSetupMerge configuration is also
respected.

> I think that it is very sensible thing to make sure that "branch",
> "checkout -b" and "worktree", i.e. the three ways to create a branch
> to work on (the latter two being short-hands), behave consistently.

So in summary "branch" and "worktree" already behave consistently, the
plan is just to introduce the same "--[no-]track" flag as branch to
allow users to override the behaviour the same way as they are allowed
in "branch".

> Thanks.
