Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2D0520899
	for <e@80x24.org>; Tue,  8 Aug 2017 20:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbdHHUg1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 16:36:27 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:38525 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbdHHUg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 16:36:26 -0400
Received: by mail-lf0-f46.google.com with SMTP id y15so19732389lfd.5
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 13:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=05YJMc3eWzWRYfO8hS/U3ocMpmvEzqLCNrch4CWRP88=;
        b=VHgIHhEdwsWRd7ZZpCZjcP/O4+tGk7xw0DR10cxSSSuFAMgBmhyZR2zEc2v290kbpl
         bnZJcHNpYhu9ZW6dUyTJKkdmbBiOegmsIkt0TGmDtpY5ahiQ+qD53sQuJQD9MnXQ/+R5
         jIg4xmBScRERrNNSffs2lnxQyXLEfg+xwAOtTxu+RptGsZvT1Q9aXVJ0N4QsM7Jz/y+Y
         WB9w0nAvNy/TzOPtOQZS/yHkGzGGkYVtZzrGNjc/uukM59sMipkIi79QjgvcfPA++5sd
         w7YTOz50AwIen7HDRgTTjflLLUWdj/rT6j+8Ls0e2mdcnOXTgOyIkalLaI7Vqx/4Z9Vj
         EeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=05YJMc3eWzWRYfO8hS/U3ocMpmvEzqLCNrch4CWRP88=;
        b=oqz47XB56ep5M9Se7iZQoSbMFVBmayABMV1pZxR1+8ekMTitAfwofxzybloEPtnqQ9
         mOegzG+JxNnM+Tm1cQ0nQ2i52WRZOep8/68ih0HcDVHNC6ILNT82sniRt6VxKcXWQdiJ
         LfpIHh+eLJxN5xkO6QJCGtZxSl7k+NnekF8EAiTZiu0PnIhNgzdpsJR9mRCXikqSVRsF
         GuvxcZiA1Z5/BCZHzrcaoskHhTIWtIi8gI6A1lcZHtCgFaoi5pGu4M/fgnXT7VGVIn6I
         ++8GPO9vCUNC+9ckvgPYtTZT3g7HYdVZ9qtCayEQlpHVd6tB5HAGPb2KJFHZTQaPX2cz
         dWiA==
X-Gm-Message-State: AHYfb5hN2sVA9JBO9fv8SRn6wlWWFojc0lopYmZWuYlMGUcWXjhYLagV
        OjEzVoGF2RzU8H4Qs2O2IEiUavp0DygFLpI=
X-Received: by 10.25.232.41 with SMTP id f41mr2178390lfh.90.1502224584738;
 Tue, 08 Aug 2017 13:36:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Tue, 8 Aug 2017 13:36:24 -0700 (PDT)
In-Reply-To: <368a1095557aa5f68cebd4d4e08628351c03b843.1502220307.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <368a1095557aa5f68cebd4d4e08628351c03b843.1502220307.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 8 Aug 2017 13:36:24 -0700
Message-ID: <CAGZ79kYQP74fTu1hFDLyKhS-2NTbUhtirWTxRMNavgO09SenYg@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] pack: move pack name-related functions
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 8, 2017 at 12:32 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Currently, sha1_file.c and cache.h contain many functions, both related
> to and unrelated to packfiles. This makes both files very large and
> causes an unclear separation of concerns.
>
> Create a new file, pack.c, to hold all packfile-related functions
> currently in sha1_file.c, and designate pack.h to hold these
> packfile-related functions.

There are also packed refs, so one could (like I did) think that
pack.c is for generic packing of things, maybe packfile.c
would be more clear?
