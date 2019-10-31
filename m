Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86E451F454
	for <e@80x24.org>; Thu, 31 Oct 2019 23:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfJaXBK (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 19:01:10 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:36520 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfJaXBK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 19:01:10 -0400
Received: by mail-pf1-f173.google.com with SMTP id v19so5560730pfm.3
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 16:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5DenoWT+2YGIKeJ1LKAWwz3UEK7hzLJm2mlG4xbGWkE=;
        b=N0Ek90Vz8Eo9EkSt3FLmAaGLU9Ne5V39ePbyKiuAEG03nWRHqBL6Ae99Cf34CtS0zp
         QtqPd428jwHAMWlF3Mw2Ytz+cKtksMCUISws6bJgiLu+6s0oq4LX+AYSrNOBePzt+i4b
         /Db33jWABrl6JqxjabiMVxZzq/MpRa2oJcP4LBBCHSjZ4+ciTVLTwpj0Pi2bSWEq1Iqi
         9KftBbpoxkJxrlNEoSZq6tGsnZ1Yt2LVv18DmQFUSVrfCbBoJXZKgIZ0NHd3uOt2TjQk
         Bn5avSh9GG6fye8rGxPKFfeSUXycTiJFrQToAYxl+CnTM/YbzgTU+V9tXPJ1SMnVr8wj
         u0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5DenoWT+2YGIKeJ1LKAWwz3UEK7hzLJm2mlG4xbGWkE=;
        b=XehUC2+kUAB13bv9Vz/gOFGm1qOO1VBSGhIx8uJe7/aCi8Stj1mUMX8/gklYwd70jc
         kf9gyCO8vaA5BY2cTGiH0Vkt0qxJz8m+pBu2Xs9FVsfLjZC41ubzTERKx7i6yH+Uzukb
         fWUR7qCTME9kTDiKbe2EI5YpQET5vjEpXMZQ7S5vslXjXH8W4bCFOdE7yH7kq0YqrI92
         j81Y86QtmS/Qu+t3dU9mt3arFq25a1G1OrsbSJ6w4VonoFiTI5sTjAwU4a5EdqbiDc7a
         oNwpirXJ+ACAi+Cwc68jnkSPIS9GiJjWgbMI+EMdNcSufDrcCVUFPdpGP919CCYPz++e
         Pthw==
X-Gm-Message-State: APjAAAX3hx/7Bb4XzaEYi3/3HtptZo9+gG7yOs00x/BZuYpC5Q1kODnp
        Yb0gWMkJ3MmQ0BGMD4ojMsaAKC1h
X-Google-Smtp-Source: APXvYqxtjMgKsclhQQTtBKcpVDG4ZsDgX/zpV0gj/5wnvbMsbIu9phzD1vaZP8QRsPkkQLDYQlIWjQ==
X-Received: by 2002:a17:90a:2ec5:: with SMTP id h5mr10958335pjs.87.1572562869310;
        Thu, 31 Oct 2019 16:01:09 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id i71sm4999611pfe.103.2019.10.31.16.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 16:01:08 -0700 (PDT)
Date:   Thu, 31 Oct 2019 16:01:06 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Arkadij Chistyj <arkdchst@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Question - .git subdirectories
Message-ID: <20191031230106.GB211076@google.com>
References: <CABf25VhaqrbtRTpL5ZNRy59o4JSsiKpF3pk3+54sDCkvzdgAmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABf25VhaqrbtRTpL5ZNRy59o4JSsiKpF3pk3+54sDCkvzdgAmw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Arkadij,

Arkadij Chistyj wrote:
>                                               I just want that git
> treats my .git/ subdirs as plain dirs with any other names.
[...]
> It's very simple functionality but I can't find any simple and right solution.
> I just want to know is this possible or not? If not possible, then why?

To add to what brian wrote:

This is one of many things that Git doesn't track:

- empty directories
- full permissions for files it's tracking
- owner, group, other attributes
- resource fork on filesystems that support multiple forks

Git was initially designed to handle source code.  Later, people have
started to use it for tracking other kinds of documents, which has been
nice.  In general, when push comes to shove, the project has prioritized
making it work well for tracking source code and other documents.

Sometimes people find other uses for Git (deployment tool! home
directory tracker! configuration management system!).  It can be
fun[1]. :)  Ultimately, though, it's useful to keep the main goals of
Git in mind.

Sometimes people want to track a Git repository in another repository
as a source of test data for tests they include with their code.  For
this use, using a "git fast-export" stream or other method for
generating a repository at test time can work better, or, if one
really must use a repo-in-repo, using a bare repository.  Brian did a
good job of describing why.

Thanks and hope that helps,
Jonathan

[1] https://public-inbox.org/git/?q=ugfwiini
