Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3520C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0F320708
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i89UDht/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgA3Woc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:44:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35458 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgA3Wob (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 17:44:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so1914510plt.2
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 14:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tacexjkai8/aWJPKMpFyz6ruq42LzDZh8MUZ/AdJwAg=;
        b=i89UDht/yJG7l/Xf5I9zNaYoTGoTF6rKipYSz579MQsTDxZyfIen+pXb4KR8qeioE7
         /WuR35ewDHthw+tFux+8XVpZ50mAuwz36F53bJ+xqzKU780ykqWbKBmbHNOgRLVKqZ5j
         F0rxuRMlXVSwsfjxMW0IiS42991BkRtCs5z6LPpFKoX8qSxRWKTFmMfm3OB6kLaRJ18N
         l/p2Iu5tyAQkq7J5/j5cKz9H4GO7PUf+UGuwGghhxvFKcRKVlx2gQ9mu2Vo+5+fNAvxp
         WpZPiiiYYKCWijd8hyK7CjTYlRIqrSYlJsjAfutVDFLYLoQ5ETmFg135xmb6QO4GyQV8
         IjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tacexjkai8/aWJPKMpFyz6ruq42LzDZh8MUZ/AdJwAg=;
        b=UD/urAeXnmdKdKHXDjt9f4Adq4jK4rm8F1nYPMuxVwoJFns7MGJgwwnTvmTOZjnIz+
         lU8w438lFDolVAARAEBZv2ePId9I7n6zaaszbD0ZtlX1o2ncu309toAKhwz1EbXeIMmL
         YSmDny/nY3Y+UpuLN3lTstkQW1+0Qq/mjUqHpGIixranpVAfBZhHlWfSii3OUs4LqsQa
         fXDWKXajJYHBUx9V6B1V4H8jFsG9aqa6WNIfLIQZJn3y9N9dObqV1uPbeoFrCxqt1ivB
         MB5x2hsy6xBlX/+cNDD2z/pghsz2p1+JlQcpWzv/79Yuxc3guRd2Pm5usXBYI11VSWrC
         pceQ==
X-Gm-Message-State: APjAAAVxfVi45ayK5tloUrBEzIweyfqGmtWhM9zjoHk3JYiZUHdZrCB3
        VfP7CWRw9juZIw+tBbJbKgqV1XCMvJANJ4HwmZ8qKN9C
X-Google-Smtp-Source: APXvYqz93VbcGny9JcGOL20rTbVwlIqF/E7Eq3RQPVcCEre8/HDoXcRwNMbVM5ps4rH7r7eiK5QB+nrqLpdAa/sDzT8=
X-Received: by 2002:a17:902:8341:: with SMTP id z1mr6762929pln.178.1580424271085;
 Thu, 30 Jan 2020 14:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20200130223011.tx6gzmaql24zemht@LykOS.localdomain>
In-Reply-To: <20200130223011.tx6gzmaql24zemht@LykOS.localdomain>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 30 Jan 2020 23:44:19 +0100
Message-ID: <CAN0heSpqQHAVYennbtDYsymzp1P5e1kjMHypygz7no_9pm9QPQ@mail.gmail.com>
Subject: Re: change of mail archive?
To:     Santiago Torres Arias <santiago@nyu.edu>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Santiago,

On Thu, 30 Jan 2020 at 23:30, Santiago Torres Arias <santiago@nyu.edu> wrote:
> I just noticed that the archive[1] I was using is missing almost a whole
> month of emails. Is there a new "blessed" archive? Sorry if I missed a
> memo...

There's https://lore.kernel.org/git/ -- I think you'll like it.

You might see https://public-inbox.org/git/ mentioned a lot
historically, but see [2].

Happy reading-up!
Martin

[2] https://lore.kernel.org/git/20191120154347.x6w4v7cdzy4yrx6q@chatter.i7.local/
