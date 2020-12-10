Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A05FC4167B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 23:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD75F23DB4
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 23:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgLJXGC convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 10 Dec 2020 18:06:02 -0500
Received: from mx-out2.deshaw.net ([149.77.95.28]:38080 "EHLO
        mx-out2.deshaw.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgLJWcK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 17:32:10 -0500
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Dec 2020 17:32:10 EST
Received: from mx-relay2.deshaw.net (localhost [127.0.0.1])
        by mx-out2.deshaw.net (Postfix) with ESMTPS id 3060F806EAC
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 17:15:12 -0500 (EST)
Received: from deshaw.com (mail-multi.dr.deshaw.com [10.218.243.33])
        by mx-relay2.deshaw.net (Postfix) with ESMTPS id 2E0191403D1F
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 17:15:12 -0500 (EST)
Received: from exchmbxpsc1a.deshaw.com (exchmbxpsc1a.deshaw.com [10.218.74.16])
        by mail-multi.dr.deshaw.com (Postfix) with ESMTPS id 25758600012C
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 17:15:12 -0500 (EST)
Received: from exchmbxtoa1b.deshaw.com (10.219.74.15) by
 exchmbxpsc1a.deshaw.com (10.218.74.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Thu, 10 Dec 2020 17:15:11 -0500
Received: from exchmbxtoa1b.deshaw.com ([fe80::b55e:2430:4455:ec8c]) by
 exchmbxtoa1b.deshaw.com ([fe80::b55e:2430:4455:ec8c%8]) with mapi id
 15.01.2044.006; Thu, 10 Dec 2020 17:15:11 -0500
From:   "Shupak, Vitaly" <Vitaly.Shupak@deshaw.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Why does "git pull --rebase" require a clean git directory?
Thread-Topic: Why does "git pull --rebase" require a clean git directory?
Thread-Index: AdbPP61Cqd2qDGLkQBqcxA5WNQltwg==
Date:   Thu, 10 Dec 2020 22:15:11 +0000
Message-ID: <ea1e654cec62411884e2c260524fb05a@deshaw.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.219.66.99]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

"git pull --rebase" requires having NO uncommitted changes, even if the locally modified files haven't been updated upstream, or even if there are no changes to upstream at all. I know I could use --autostash, but that's inefficient and may be undesirable if it would create a conflict.

Would it be possible to change the behavior of "git pull --rebase" so that it only fails if the locally modified files conflict with the files modified upstream (similar to the default git pull behavior without --rebase)?

Thanks,
Vitaly

