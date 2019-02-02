Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F31A1F453
	for <e@80x24.org>; Sat,  2 Feb 2019 03:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfBBDJn (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 22:09:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38421 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfBBDJn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 22:09:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so7465721lja.5
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 19:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HmIhnBJ63hXZfC6zQuxm1n1NiQwtgqHyxxL0FOQp5jU=;
        b=Hgf9wvMDWn+IBTYmDTifG4SNtypRjF6DGQEvE7jcaL1za1ufjbmXi0d18Udu6HCPSk
         Y6vj/pCF9VFls3JFQ6xIMvCBOTcHATGFXdxpGkke71LMw4PBj4+xIILgO/0fgQWG6hE3
         f0z0Xq2hbgmmqZB0LURoJo5vvO1P19+kLsLyp80NIzE8VOqjx6XE1YxmhcqGik1huPBp
         8J1uctlurxRWnBOfnZY+BW7Z0MkLAEYDACTDk/RCWcj/akg1AAVZaidaRGv+OwFv+QEF
         yIsMUA8mtu2I9Y06EEzNsCp8dGARPWUiP3euESGj+zOJLogAjNUnKXzhVeLjIVrbxU2o
         cHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HmIhnBJ63hXZfC6zQuxm1n1NiQwtgqHyxxL0FOQp5jU=;
        b=JSAUuU/1EfwhO9qomdHxSjv0BDhd/9mJqvCVoNMp51vyMp/ZqIjiROcIIbg6q3svmt
         0UGlcVGLrVlfSpsjiO29QaQGkzKk1gR6tvlVTnIrdKeWRN7uwqujhjYcO4koz6aG1/o5
         CFeQ/jLz/LTAwV/tZDP+MPtWw6xpQacNRzH88iJYMpsaHL6ROajvMIFInl37Bz+l0PaE
         se5LjkKgd8yZuwrjJ+jdmh3/B+37NJ9sYcEeDzBEaij8HniDpPU/Zqq4k1DqDyhpw8tt
         9q9U77TITqAJdYg12/xVsZBQMsM6ER6mJKRZi56hGpyXuNMeVCLVq7FFSZwY6QiMUFsX
         e5kQ==
X-Gm-Message-State: AJcUukftxAnWN+DiizuZsEGPSoHM+rzmKoBMzMDPoalSDrgn0q3o7V3H
        kJPgYiWifp1Y9VPo1iQ81q8+8cOdxcwzmcTjDcM=
X-Google-Smtp-Source: ALg8bN44kuG1xUT5qtOll8SaBl62A7msQCCleqPCirultDvIKyreSx0CIb7099tLho/RoKmc3io+xzvJXDYhjG9+mE8=
X-Received: by 2002:a2e:4299:: with SMTP id h25-v6mr33740609ljf.5.1549076980811;
 Fri, 01 Feb 2019 19:09:40 -0800 (PST)
MIME-Version: 1.0
References: <01020168a8338064-b1c054c4-3e05-4825-b8dc-636d9c63dcfc-000000@eu-west-1.amazonses.com>
 <01020168ab79f642-10a06c5b-c3f7-441e-86f8-bff5e41ac834-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020168ab79f642-10a06c5b-c3f7-441e-86f8-bff5e41ac834-000000@eu-west-1.amazonses.com>
From:   Brandon Richardson <brandon1024.br@gmail.com>
Date:   Fri, 1 Feb 2019 23:09:29 -0400
Message-ID: <CAETBDP7jw_z_Nz7X-+jne7sYrJ7G92wWsB3S_ipf3XjJwxYxfw@mail.gmail.com>
Subject: Re: [PATCH v2 [rebased]] [Enhancement] Improve internals / refactoring.
To:     Shahzad Lone <shahzadlone@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shahzad,

On Fri, 1 Feb 2019 at 19:54, Shahzad Lone <shahzadlone@gmail.com> wrote:
>         git_zstream stream;
> -       unsigned char ibuf[1024 * 16];
> -       unsigned char obuf[1024 * 16];
> +       unsigned char ibuf[16384];
> +       unsigned char obuf[16384];
>         unsigned long olen = 0;

This change also brings very little value because most compilers will
evaluate constant expressions such as this at compile time. A quick
google query on "Constant Folding" will tell you all about this.

I love optimization as much as the next guy, but I also feel an argument can
be made for readability too. The former version is far easier to see that
the array will be 16KB in size, where 16384 is more difficult to visualize.
