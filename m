Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C61C20281
	for <e@80x24.org>; Mon,  2 Oct 2017 19:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbdJBTzT (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 15:55:19 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:48257 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbdJBTzS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 15:55:18 -0400
Received: by mail-qk0-f177.google.com with SMTP id d67so2969115qkg.5
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 12:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oDgl83YfeAFasHtcN+s36oLLj3jT8UYtHPOJUuMszU4=;
        b=Yjl6b9G+whScPzTlIVQa95EuZRNd5GJO5SeVh5d1ApKJDJAvFDM+AYH414s4F5jwhO
         WTrdDIOigOobaDYic6q4FA9Oj9SlO9a0BqANDZznJTOEy2XxjHHcNwIFzX113kE92utz
         VHC2+4+GKPZUxvIFn0O+v7yk4xm7RBeW00zWWJ89mxC171kNavKUafKS41K1OD3xkjnl
         cK4GzUO2FY+t6Mn8q038u/7DCHdLo9X2T/rHnfuWpsvHj8lveZp5f+NMUgklR8ihSGUu
         5MC6h/L4G/Okg6S/TnOOmJ2yByREAbPal522shdMW8HSVW0Eyiqhkq9fdEHtIiJ/bDiI
         IqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oDgl83YfeAFasHtcN+s36oLLj3jT8UYtHPOJUuMszU4=;
        b=MwngcK1/I8YMF8e/XheEusmDlYmx5Os0tOHlA5rvj0G9RZojnzxJuw2MnQLNpyMonB
         zr7NI/iZPBeV6amMPtOCFXh5eWByHDIDsrcBPeIIP7lef0eT11TP723npq5ORzbIIq3v
         iynqziQhytFOCjNBHC5VXPojselDGvE7eZKrEeoIXwO9EnaZJkVtV6q2qLVqrVes4IUm
         WL6+fc86Z0bS8Gb94FX1Iwv2unUEYD6MxbPqVjOw3ZzPio9BIHWqQTPasxNpUXuxNhCv
         TWg5qSmzSK5631w5WLY4qtP8z+dMOS/pLEGvLdYvrhIFNqExYEgSUCmmepO0AitXzPzu
         424g==
X-Gm-Message-State: AMCzsaVvaISbg6i8nL/Br0Co4qy8iYhjPwn9jblV2WPoKFPSqKgELdnm
        HD8MOVmKb24qamKL6tZlaYWRYqCUE+Uigch4DE5cLg==
X-Google-Smtp-Source: AOwi7QA5iAeqBwjbChzRwiSE9Phd9hFW6rMr53SYMPyr7MPUhYI6ALefvDLOESzIg7QOJJuTRXm/qi+b57xFRW/YQOo=
X-Received: by 10.55.45.199 with SMTP id t190mr17471755qkh.230.1506974117353;
 Mon, 02 Oct 2017 12:55:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Mon, 2 Oct 2017 12:55:16 -0700 (PDT)
In-Reply-To: <CAA4Wa2sVddG_SS70Dy_womGLKW0ipAjsxR4g+yjMKscjErRjvQ@mail.gmail.com>
References: <CAA4Wa2sVddG_SS70Dy_womGLKW0ipAjsxR4g+yjMKscjErRjvQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Oct 2017 12:55:16 -0700
Message-ID: <CAGZ79kYt1rC5D=Gk8Ei1FmwF_zqK2AQgP_TQFHsV-NGHfVgOKA@mail.gmail.com>
Subject: Re: git submodule add fails when using both --branch and --depth
To:     Thadeus Fleming <thadeus.j.fleming@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 30, 2017 at 10:20 AM, Thadeus Fleming
<thadeus.j.fleming@gmail.com> wrote:
> I'm running git 2.14.2 on Ubuntu 16.04.
>
> Compare the behavior of
>
>> git clone --branch pu --depth 1 https://github.com/git/git git-pu
>
> which clones only the latest commit of the pu branch and
>
>> mkdir tmp && cd tmp && git init
>> git submodule add --branch pu --depth 1 https://github.com/git/git \
>   git-pu
>
> which gives the error
>
> fatal: 'origin/pu' is not a commit and a branch 'pu' cannot be created
> from it
> Unable to checkout submodule 'git-pu'
>
> Investigating further, there is indeed only one commit in the local repo:
>
>> cd git-pu
>> git log --oneline | wc -l
> 1
>
> But that commit is the head of master.
>
>> git branch -a
> * master                                 remotes/origin/master
>   remotes/origin/HEAD -> origin/master
>
> This appears to be because git-submodule--helper does not accept a
> --branch option. Using the --depth N option causes it to only clone N
> commits from the default branch, which generally do not include the
> desired branch. Thus, the next step,
>
> git checkout -f -q -B "$branch" "origin/$branch"
>
> fails, and provides the rather confusing error message above.
>
> I'd suggest that git-submodule--helper learn a --branch option
> consistent with git clone, and if that is impossible, that
> git submodule add rejects the simultaneous use of both the --branch and
> --depth options.

Adding the branch field to the submodule helper is a great idea.

>
>
>
> --tjf
