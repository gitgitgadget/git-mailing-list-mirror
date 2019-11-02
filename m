Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2209B1F454
	for <e@80x24.org>; Sat,  2 Nov 2019 03:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfKBDck (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 23:32:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41619 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfKBDcj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 23:32:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id p26so8281100pfq.8
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 20:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yiDixyJoxhFGjGpvUhkO8rDh+3v8+Y9PfvFRpxQEUug=;
        b=GUJ8wwkttC6Zo6m3aqcyHOABaySweR98DhczEfSuAwfAB8UCX+IK2hozJmo8X9wWk8
         LtSUlWIUhCicJaI/7ZMGQSuGdg/jR2PxrPnho58KbxnmSIaIuDCywUeqQTOJB+9lLRoZ
         1TDjDVsfYJGd7+qB9QEIaJeJeBMHH0EhDwbgCG5dnV6cFCkTdqQ57Z6DKZkkfmTSl0du
         ZSphxf4YlvC8ITOQhGPVvcjZaNcWAISg605V6UJ8kmN5ukBPk22B53CwIrUCaAXniVI4
         1nz6dLqumj2EX0Xq8VN3EIL0l961TLpmh+WyEH7dPJKqp3TTTx+Pgo217Xk7QOxC11nI
         M+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yiDixyJoxhFGjGpvUhkO8rDh+3v8+Y9PfvFRpxQEUug=;
        b=riqlkWKC0UubdV+SaLhYKkbIO/HD4vbnOCikvFIc2Gxqcfz7WSSi90FYT8S4ReeCKR
         RTiVC2tfQC2e0y2aJCNJwbsshenJC9Xsrc7wpkZ0I+SX37zEEbnTsP2SQfHWrNuvij0U
         P7Zi4giwD9gUcDRyRoAn38V0RUQ3+VTZRMmdiTsxCVmCDA4BYIi5UuiS/r4n16jL7y5n
         iV1IlJNkTT+mbcVNo2E+ClMd4FD/tCQzH4yuiBKHpzydIPdBQb5n/Ll3wNkgYPZ0gLFM
         3ZYbbgBlVXO0o5SXpxE+jcEGnlc9iOby6MaPuOS+OVPoZdk7eSPmVkkfiRMCZEF3XTRG
         g6ow==
X-Gm-Message-State: APjAAAXpPSvePdccbxr2EGdwQuFbJFgvvMOW50K3uhlBYJFAo3ZhNGpG
        EtP47dJwSPdwBQHiM+ZJ491D2BuL38FuWA==
X-Google-Smtp-Source: APXvYqw86FAxC81ygG3TwzdqyswePfTXeAoK2UZzsOty5v/qXAivkeHPsOf4bYsQz/EUEKwgRyskaA==
X-Received: by 2002:aa7:9787:: with SMTP id o7mr16753871pfp.120.1572665557518;
        Fri, 01 Nov 2019 20:32:37 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:8cf7:b958:9b37:1730])
        by smtp.gmail.com with ESMTPSA id t4sm9148815pjo.26.2019.11.01.20.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 20:32:36 -0700 (PDT)
Date:   Fri, 1 Nov 2019 20:32:36 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] RelNotes/2.24.0: fix self-contradictory note
Message-ID: <20191102033236.GB93209@syl.local>
References: <pull.440.git.1572466878.gitgitgadget@gmail.com>
 <0f3aa67e4aafbb7befd37d83a8c0d53a0a186259.1572466878.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f3aa67e4aafbb7befd37d83a8c0d53a0a186259.1572466878.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 30, 2019 at 08:21:18PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> As per Wikipedia, "In current technical usage, for one to state that a
> feature is deprecated is merely a recommendation against using it."  It
> is thus contradictory to claim that something is not "officially
> deprecated" and then to immediately state that we are both discouraging
> its use and pointing people elsewhere.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/RelNotes/2.24.0.txt | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/RelNotes/2.24.0.txt b/Documentation/RelNotes/2.24.0.txt
> index 26e018078d..bde154124c 100644
> --- a/Documentation/RelNotes/2.24.0.txt
> +++ b/Documentation/RelNotes/2.24.0.txt
> @@ -6,10 +6,9 @@ Updates since v2.23
>
>  Backward compatibility note
>
> - * Although it is not officially deprecated, "filter-branch" is
> -   showing its age and alternatives are available.  From this release,
> -   we started to discourage its uses and hint people about
> -   filter-repo.
> + * "filter-branch" is showing its age and alternatives are available.
> +   From this release, we started to discourage its use and hint
> +   people about filter-repo.

I suspect that this change was motivated by our off-list correspondence,
where I struggled to phrase a section about this in GitHub's release
highlights.

I think that I'm mostly reflecting what Elijah has already said himself
in another thread, but this change makes sense to me. I think that we
have effectively deprecated 'git-filter-branch'. If we're printing
warnings when it is called, and recommended that users refer to
'git-filter-repo' instead, I think that we might as well call it
deprecated.

But, if that phrase is too heavy-handed for 2.24, I think that this
patch makes a lot of sense. It's--as Elijah notes--confusing to say that
we recommend against using a tool but haven't 'officially' deprecated
it. This works nicely around that issue by not using the phrase
'deprecated' at all, and instead being clear about what the state of
'git filter-branch' is.

>  UI, Workflows & Features
>
> --
> gitgitgadget

Looks good to me.

Thanks,
Taylor
