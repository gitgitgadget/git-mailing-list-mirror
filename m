Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E23DC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 17:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbiF3RcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 13:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbiF3RcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 13:32:16 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317E727FF9
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 10:32:14 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id u7so214508qvm.4
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 10:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=52V7TgX6JKbtL8X1kGx0nQfGkCHzEiTjFeGXnCbgZTk=;
        b=mBllE8ZjGay7sSwq1rwHA7duLWh6NH+Xvcc8KO9ZpVkgAj2xJ3Nk/UUJyF764JIybN
         cfiIIP5z4rqTonB5lqeD68gqog+q1/6OC3SD6+Glit+vZWc0Sv/YN5ytJosFf24WLdxV
         cnQb5e9x4h4WuKPVHX7t42hbomhS6dI5eeHjvlLIQkk3LXiGfLR6yWgu5X0FpIy1xnWo
         +I/znlZ9Cu6si8GT0SF1Qj0rSd9nx49lbIwh2XXLMSg8oGDbG0pL2aaK5sWl6Bq3rxM0
         THUE8FPTMg3GKkUYvSCt27Vvrv4ppKTLinb6xg1MJ75LusGjXS/Xd5S1+rp9xG7m27n5
         I3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=52V7TgX6JKbtL8X1kGx0nQfGkCHzEiTjFeGXnCbgZTk=;
        b=p6ajIlyIgSn+YEvhHK96gTPCWEXWmSsoB4Srtsr+ammA0M5NAo3XV6WbLx2t4ScFaV
         JBPJlEUKj1UT4+RAA/6EJNhZll6leF+WneC2FqbVlr1cuH4Yot2Pbq2+XUiquZz2ZNGh
         ez9wOvhPGyjl3AxlUdkHI3YNxLiB4P2kFnfl0lx2pSkyxyzU1b8Jd1fPwXoBFxUE/sMP
         dQxhqPj9Xk+4xcHkN2+/IB0A933cF3qhQUmFHaZ2YpbMmnJoO9TSGvBpm2nv9w2zcWkZ
         VPKGOnmS1cfKpcFFSCl3MN9kZeswW29LkSuqLmOCqgCIpfrWGZHvh7OJjq0LS/ZnHqRX
         swyA==
X-Gm-Message-State: AJIora8wGoYvBQmDSlBYVs/XQOSMK5IGf2BITX2FTP1gDO1aRjgJ1NqB
        t4x2g95jvwJ0B4lw5ardUbJWwsiCggY=
X-Google-Smtp-Source: AGRyM1vYHyPrZ2ex7iBToVotx77BF+8S9tMvOpVlw+GP1JX2eF3W1kPXOCmMBLdsx6ak6zlUYXBovA==
X-Received: by 2002:a05:622a:1b9e:b0:31d:2909:bf4d with SMTP id bp30-20020a05622a1b9e00b0031d2909bf4dmr6866142qtb.283.1656610333192;
        Thu, 30 Jun 2022 10:32:13 -0700 (PDT)
Received: from carlos-mbp-2.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id z3-20020a05622a124300b00316a384447fsm13186629qtx.16.2022.06.30.10.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 10:32:12 -0700 (PDT)
Date:   Thu, 30 Jun 2022 10:32:11 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Non-interactively rewording commit messages
Message-ID: <20220630173211.pnliwplmimcaygny@carlos-mbp-2.lan>
References: <20220630152757.yxwhijvj5xoosrws@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630152757.yxwhijvj5xoosrws@meerkat.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022 at 11:27:57AM -0400, Konstantin Ryabitsev wrote:
> just need a sane strategy for non-interactively rewriting
> entire commit messages at arbitrary points in the recent history.

assuming you are still doing it by calling (albeit programmatically):

  rebase --autosquash -i

then you could prepare the new message by also programmatically doing
a `git commit --fixup reword:<commit>` IMHO

Carlo
