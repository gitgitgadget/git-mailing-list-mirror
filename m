Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2385D1F461
	for <e@80x24.org>; Thu, 16 May 2019 11:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfEPLcV (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 07:32:21 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36779 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfEPLcU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 07:32:20 -0400
Received: by mail-it1-f196.google.com with SMTP id e184so5629168ite.1
        for <git@vger.kernel.org>; Thu, 16 May 2019 04:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UABh+D5vIu3HM3tsu5lBqapNGK+b1sOiQT2P+6a7VOI=;
        b=qFKDW5L4+1acBeehLzefuKIq3XOAr5zq2Ykn+xhgBWdvAanPJriZjVeEtFzIB1fqLc
         PFuYKZm+MAdpYb+lCleXBZl/ossxhCLQqj+rEwn9BwMnxWO2WrYELZcavdNi23JDu3u+
         1fP/zeNhKd/0hxS8N5PGY3QEgG1RjnX6TVQob4PJx2/SNPgknVPDmM78lar9Fp7ySx0L
         9gxESE7LEoJZ7CvSLCrUmKCFHaFJkFLG+Jpj05NLYXpzycVZUcs7jtQ29+siCUcqj6Xt
         E1tbeOwP1tS3ZfT1Spv+QSLnNewblYIUYbDgniwAtsq9Ox9bsMUhQ0KUV48y8vxPibkd
         2igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UABh+D5vIu3HM3tsu5lBqapNGK+b1sOiQT2P+6a7VOI=;
        b=KYvPxSQbKqTjta3dsIEB/XV0vKUUsJB2zj9szM/lNal3swO+eCtDWAqLJm7NEaikM3
         TbZDt97yUj6maEfOjma1Y+Bfiv6kbOQ6FUYyjMmVeKCitGa/mUdbEjv/Fei3+5oURvFW
         B9dzpWf2HaRKxp1jHHa/hTzsPeqDfn05xVjYm1O89xlqiLxItF2Yltg44UQdMjechaXD
         rne4zgwrNAcw2YCcgIW73e9FiHbUoCshrzdMSGIHjag+pa7eoMzAGNogc6AZaiNl2YGf
         vBT8nJco2QgKOJJfE/PtAXlkRsy/GMJUA8RGXLasvvUNSHMIoA3iqHXItVNC6iBpAgb2
         L4yg==
X-Gm-Message-State: APjAAAWFAnJThColZy0CODX6yqUUx1m20iZkXjr9ZXCAKankwvKRo8qH
        8l4/Yn4ZbG5NRJc2dKFdXE7AcDFc6uCQ/yG0NQRDbw==
X-Google-Smtp-Source: APXvYqy0Gy9ocUVoGu4/Pg2Dj07YODbtz6jEj2/9leYBWL0YW8GkxavPEvQF2Bkxr3Nsq0Z8WqQYoFT0A7QbMwD+6/8=
X-Received: by 2002:a24:56c1:: with SMTP id o184mr12059233itb.123.1558006339841;
 Thu, 16 May 2019 04:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190513175903.126079-1-bavison@riscosopen.org>
In-Reply-To: <20190513175903.126079-1-bavison@riscosopen.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 16 May 2019 18:31:53 +0700
Message-ID: <CACsJy8B589nOPNt6143BNQNojRYn4pyQCMNZKLRn+EGyWD4-mw@mail.gmail.com>
Subject: Re: [PATCH] clone: add `--remote-submodules` flag
To:     Ben Avison <bavison@riscosopen.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 2:46 AM Ben Avison <bavison@riscosopen.org> wrote:
>
> When using `git clone --recurse-submodules` there was previously no way to
> pass a `--remote` switch to the implicit `git submodule update` command for
> any use case where you want the submodules to be checked out on their
> remote-tracking branch rather than with the SHA-1 recorded in the superproject.

Are there any other submodule options that could be useful passing
from git-clone as well? What I'm getting at is, if there are multiple
of them, perhaps we need a different/generic approach than introducing
a bunch of --<something>-submodules. But of course if --remote is the
only useful one left, then it's moot.
-- 
Duy
