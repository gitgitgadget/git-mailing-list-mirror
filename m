Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71659C3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 19:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197762469F
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 19:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="TOA4Hj16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgB1T2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 14:28:03 -0500
Received: from forward100j.mail.yandex.net ([5.45.198.240]:50002 "EHLO
        forward100j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbgB1T2C (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Feb 2020 14:28:02 -0500
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Feb 2020 14:28:01 EST
Received: from mxback28o.mail.yandex.net (mxback28o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::79])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id EE08B50E00ED
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 22:20:47 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback28o.mail.yandex.net (mxback/Yandex) with ESMTP id t4z77vEhOB-KlFKJSJX;
        Fri, 28 Feb 2020 22:20:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1582917647;
        bh=sSwhG8FQj7nBlMH66IPw6bbBOMFIcV5h/5L2eV030K0=;
        h=Message-Id:Date:Subject:To:From;
        b=TOA4Hj16myifiut1kYyZawE8o7E28lrVyPwviRjjSZQfy3aUKC5KK2LFo3vPDGz2S
         esXmag1Vqy8dETiR7lv4w/id/VZYL0qwMNBTZZWru3whsv4BxtqNfT3wpuwvL2G6z3
         SQOtWBlVaOxXImAkGupXr0Q2GDIPL1STcVyLRW1g=
Authentication-Results: mxback28o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva6-161d47f95e63.qloud-c.yandex.net with HTTP;
        Fri, 28 Feb 2020 22:20:47 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     git@vger.kernel.org
Subject: `git log --full-diff --follow`: conflicting command line arguments
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 28 Feb 2020 22:20:47 +0300
Message-Id: <1223101582917647@iva6-161d47f95e63.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Combination of "--full-diff" and "--follow" in git log arguments causes following error with git 2.25.1:

fatal: --follow requires exactly one pathspec

This message is certainly misleading when git log is applied to a single pathspec. Bit it would be
useful to make this combination valid and show full diffs for followed history of particular file
(when -p option is also provided).

-- 
Regards,
Konstantin

