Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F958C433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 10:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A95AC2251D
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 10:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbhAYKsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 05:48:47 -0500
Received: from forward103j.mail.yandex.net ([5.45.198.246]:58708 "EHLO
        forward103j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727633AbhAYKri (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Jan 2021 05:47:38 -0500
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jan 2021 05:47:37 EST
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id E6AAE6740479
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 13:38:17 +0300 (MSK)
Received: from vla1-eeea27dff809.qloud-c.yandex.net (vla1-eeea27dff809.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:5184:0:640:eeea:27df])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id E4A02CF4000B
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 13:38:17 +0300 (MSK)
Received: from vla1-719694b86d9e.qloud-c.yandex.net (vla1-719694b86d9e.qloud-c.yandex.net [2a02:6b8:c0d:3495:0:640:7196:94b8])
        by vla1-eeea27dff809.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 6aRvEcEqRp-cHHuS51O;
        Mon, 25 Jan 2021 13:38:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1611571097;
        bh=/oYPSo29+TuRZztnX6pPdnHS/snoD9BXcSt8unKIRn0=;
        h=Subject:To:From:Date:Message-ID;
        b=sE7bmY47AkwBK5dekeK/Veqj3nztfZ2exMYfl/ljB2QEG0Nlpaisuv7Mj6AU3AvLz
         M+ctXwJx9rxg8smnf44Uv0mDR+OwuQUPY6KcugqFBYIdYQYDAZsD8t1U7LO/HJVPmY
         G/sSqOATAneYq7iHAjyAThHhtMksIb3CMEdVzbME=
Authentication-Results: vla1-eeea27dff809.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-719694b86d9e.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 9tUtnnOvPO-cHI060m0;
        Mon, 25 Jan 2021 13:38:17 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Mon, 25 Jan 2021 12:38:16 +0200
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <1327609829.20210125123816@yandex.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Can not rebase to first commit
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I can not rebase to first commit.

This is how to reproduce:

kes@work ~/work/projects/general/Auth $ git tree
* 67857d5 (HEAD -> dev) asdf
* 1e99034 (local/dev) Initial commit
kes@work ~/work/projects/general/Auth $ git rebase -i --autostash --rebase-merges 1e99034^
fatal: invalid upstream '1e99034^'


git --version
git version 2.30.0

--
Best regards,
Eugen Konkov 

