Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7977FC0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 12:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200BB205ED
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 12:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="V0pNR+8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbgCPMzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:55:42 -0400
Received: from forward500p.mail.yandex.net ([77.88.28.110]:42824 "EHLO
        forward500p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731064AbgCPMzm (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Mar 2020 08:55:42 -0400
Received: from mxback16j.mail.yandex.net (mxback16j.mail.yandex.net [IPv6:2a02:6b8:0:1619::92])
        by forward500p.mail.yandex.net (Yandex) with ESMTP id 61DD2940841;
        Mon, 16 Mar 2020 15:55:40 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback16j.mail.yandex.net (mxback/Yandex) with ESMTP id rPONqyAgRA-tdgaGhbD;
        Mon, 16 Mar 2020 15:55:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1584363339;
        bh=GssqK2WGhKVQDEV/zRUEj/AKD9z01Jql806PvA1DHmU=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=V0pNR+8UE763OePBqzv8ddDJmsSi/1VxOPwS0NBw8kew/O2RuLVbx+2oRyGpkz/LB
         3w4WUcgGearckQNZH3kcxwAnwWA8fnm0IARWH7aVn2kyt1pa36KQ930FySnkKLKgNN
         y/+w4yKtmpeUdW9rnHY7Ar7Xqm3sl/Wny4K/vK7w=
Authentication-Results: mxback16j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt3-cba274279eae.qloud-c.yandex.net with HTTP;
        Mon, 16 Mar 2020 15:55:39 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Damien Robert <damien.olivier.robert@gmail.com>,
        James Ramsay <james@jramsay.com.au>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <20200315221940.bdgi5mluxuetq2lz@doriath>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
         <5B2FEA46-A12F-4DE7-A184-E8856EF66248@jramsay.com.au> <20200315221940.bdgi5mluxuetq2lz@doriath>
Subject: Re: [TOPIC 3/17] Obliterate
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 16 Mar 2020 15:55:39 +0300
Message-Id: <3839451584363302@sas2-a098efd00d24.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



16.03.2020, 02:13, "Damien Robert" <damien.olivier.robert@gmail.com>:
> From James Ramsay, Thu 12 Mar 2020 at 14:57:24 (+1100) :
>>  6. Elijah: replace refs helps, but not supported by hosts like GitHub etc
>>      a. Stolee: breaks commit graph because of generation numbers.
>>      b. Replace refs for blobs, then special packfile, there were edge cases.
>
> I am interested in more details on how to handle this using replace.
>
> My situation: coworkers push big files by mistake, I don't want to rewrite
> history because they are not too well versed with git, but I want to keep
> *my* repo clean.

Wouldn't it be better to prevent *them* from such mistakes, e.g. by using
pre-push review system like Gerrit?

-- 
Regards,
Konstantin

