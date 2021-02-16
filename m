Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_05,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF78C433E6
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC69B64E28
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhBPSi6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 13:38:58 -0500
Received: from forward101p.mail.yandex.net ([77.88.28.101]:48927 "EHLO
        forward101p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229572AbhBPSi5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 16 Feb 2021 13:38:57 -0500
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2021 13:38:56 EST
Received: from forward103q.mail.yandex.net (forward103q.mail.yandex.net [IPv6:2a02:6b8:c0e:50:0:640:b21c:d009])
        by forward101p.mail.yandex.net (Yandex) with ESMTP id 73E433282375
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 21:30:22 +0300 (MSK)
Received: from vla1-0c91d72e5963.qloud-c.yandex.net (vla1-0c91d72e5963.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3a21:0:640:c91:d72e])
        by forward103q.mail.yandex.net (Yandex) with ESMTP id 6F7E661E0002
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 21:30:22 +0300 (MSK)
Received: from vla3-23c3b031fed5.qloud-c.yandex.net (vla3-23c3b031fed5.qloud-c.yandex.net [2a02:6b8:c15:2582:0:640:23c3:b031])
        by vla1-0c91d72e5963.qloud-c.yandex.net (mxback/Yandex) with ESMTP id WXFHTETCA1-UMIGMnvr;
        Tue, 16 Feb 2021 21:30:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narod.ru; s=mail; t=1613500222;
        bh=L2eLlA+sXLST4YIePSJfvbDUt0Vwy4VztTZc0K1D1fQ=;
        h=Subject:From:To:Message-ID:Date;
        b=obc3UJ0vDIJXpYBkkR/r5oh9Mm8CHZWKoxumIy7usylPrNrvcYngcGbfEp0EKgY3a
         LzG1wN/2bOS0V1A5KqAffIFN1c9YuX5SIMaV6INZi0sIFKpsotMY20s+o2Fi6vu7PU
         dkte3X11Yd25jhivllBm2fYzX/HlpTQiH827J5YM=
Authentication-Results: vla1-0c91d72e5963.qloud-c.yandex.net; dkim=pass header.i=@narod.ru
Received: by vla3-23c3b031fed5.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id fD7owEbG0R-ULKeEgj6;
        Tue, 16 Feb 2021 21:30:22 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
To:     git@vger.kernel.org
From:   Victor Porton <porton@narod.ru>
Subject: Bug? I can't manually merge changes with difftool
Message-ID: <b46fd946-42ad-2c33-0294-415949b9085e@narod.ru>
Date:   Tue, 16 Feb 2021 20:30:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I run

git difftool main HEAD

and manually merge changes in started meld or kdiff3 and then save the
resulting file, it is saved somewhere in /tmp not in the workdir.
Workdir is not modified after I close meld or kdiff3.

I need to store changes in workdir.

Is it a bug of Git 2.27.0.

