Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F8431F453
	for <e@80x24.org>; Tue, 12 Feb 2019 11:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfBLLie (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 06:38:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39442 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfBLLie (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 06:38:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id f16so2645832wmh.4
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 03:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=filenko-ms.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version;
        bh=vYmGyHOGA+10plB0Mfjoy7yxgIrh4JhcMJ2AXB8ybsY=;
        b=UpEMRNeCGE8xs+gO+HnwVG4jFXk3RY+mswVu4E4GVIpHQ4DdBKGFjZ0Me9VXheVtgd
         Z/qpnf2TXUcp317j5/j2rYej4jHUzEYOeZ3hrD2AezSJG1pSkrWrS/pcod6mEMB0/W8c
         o4hD005AfRINDkTQPQ7tfS7YLKqchguQUBJ87ECJpjThZJ2OAB1WflrDFYiR2DBwT0hf
         T2Jz+afRu35zXOTU5myrcsohBxu2l5ATrFZfgNVd9ri1o2cJs5v3xqow8SFqdJ2m+nvm
         Sj9484LmzJwMUW2q4YCBR9CfTUCr6W2+9GwJgTvT5sYjy7cauMR3E8lZYKu0I5GqvbYs
         Rpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version;
        bh=vYmGyHOGA+10plB0Mfjoy7yxgIrh4JhcMJ2AXB8ybsY=;
        b=dSwUc36JLO7ESwvDvq2u/zyKye+OJoaFZ1ZFcdFdcclLciPySxQvw3t2lEEJxmdWlb
         +5kWnIFpdA3YnoyHmz9+/yDhhxLtbInA3vEbG0RFw2+EsD8Hb9HAbhAgndM0WNGf0kcR
         BoxhNZH3Sqq/4iQi1wVzeEtJ1AB47V2FvJFEr+RTQZXboa6WD+UzbGo1+XNeOcdJx1p2
         nCAK6DFiexzJ9tIgjCNO9uUUqafVVha3it8Nq/h1YdCcAoBHETOZheHMcm9+K0Iovr3M
         40fRRVojV5EqnWqmVfDKyDN4U6e5T8rig5zWY1C+99H/ZvBMbeg+NzJzCy6hYbBTwEbI
         yP8Q==
X-Gm-Message-State: AHQUAubo2sYt8CLQgXb46zTy4mCombneQFPdgbXwouo6kx0hKsAUrod5
        aBvKEzhI1AvFXqORGxPcQSnej8W4JD/Iaw==
X-Google-Smtp-Source: AHgI3IbMbh6yVs+8pKPlJNVilCe7bhdZaVcnoni9EwTscFY6QelcdElJmSAWeeFFM276Rq87bXl6+w==
X-Received: by 2002:a7b:c08a:: with SMTP id r10mr2483578wmh.112.1549971511761;
        Tue, 12 Feb 2019 03:38:31 -0800 (PST)
Received: from bouncer ([213.61.81.99])
        by smtp.gmail.com with ESMTPSA id r12sm15265872wrt.76.2019.02.12.03.38.30
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 03:38:31 -0800 (PST)
From:   Max Filenko <contact@filenko.ms>
To:     git@vger.kernel.org
Subject: git-am drops colons in the beginning of a subject line
Date:   Tue, 12 Feb 2019 12:38:25 +0100
Message-ID: <m2lg2lxmmm.fsf@bouncer.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey there,

git-am seems to omit colons in the beginning of a subject line.

I have the following simple patch (just an example):

    $ cat 0001-four-colons-prepended.patch
    From e8213a2d10a61c9dc75521d88d656b8d5330e6bb Mon Sep 17 00:00:00 2001
    From: Max Filenko <contact@filenko.ms>
    Date: Tue, 12 Feb 2019 12:21:21 +0100
    Subject: [PATCH] :::: four colons prepended
    
    ---
     file.txt | 2 +-
     1 file changed, 1 insertion(+), 1 deletion(-)
    
    diff --git a/file.txt b/file.txt
    index 4dd1ef7..b5da95d 100644
    --- a/file.txt
    +++ b/file.txt
    @@ -1 +1 @@
    -This is a file.
    +This is a plain text file.
    -- 
    2.17.2 (Apple Git-113)

I apply this patch:

    $ git am 0001-four-colons-prepended.patch
    Applying: four colons prepended

As you might have already noticed git message above doesn't have colons.

Let's double check this:

    $ git show
    commit 6341a6a2872f850ecb376c268b1b3bae54a6a74f (HEAD -> master)
    Author: Max Filenko <contact@filenko.ms>
    Date:   Tue Feb 12 12:21:21 2019 +0100
    
        four colons prepended
    
    diff --git a/file.txt b/file.txt
    index 4dd1ef7..b5da95d 100644
    --- a/file.txt
    +++ b/file.txt
    @@ -1 +1 @@
    -This is a file.
    +This is a plain text file.

The commit message reads 'four colons prepended' while it should read
':::: four colons prepended'.

Colons are missing in the commit message after apllying this patch.

I don't think that's an expected behaviour, isn't it?

--
Cheers,
Max
