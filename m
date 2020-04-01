Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5480DC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 08:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F3220772
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 08:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="rebO0Bz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbgDAIDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:03:51 -0400
Received: from forward400o.mail.yandex.net ([37.140.190.176]:49404 "EHLO
        forward400o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731850AbgDAIDv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Apr 2020 04:03:51 -0400
Received: from mxback9o.mail.yandex.net (mxback9o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::23])
        by forward400o.mail.yandex.net (Yandex) with ESMTP id 0B25C14C0F04;
        Wed,  1 Apr 2020 11:03:49 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback9o.mail.yandex.net (mxback/Yandex) with ESMTP id 9JLeWMgynY-3maqeEJZ;
        Wed, 01 Apr 2020 11:03:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1585728228;
        bh=cH/chKarbE1K9uHoybFVeZY0v3xm3+XKSH/1Vp9IkPw=;
        h=Date:Message-Id:Cc:Subject:To:From;
        b=rebO0Bz7wRqPL5/HhBqVN2VkP95yr9xIgvsLUl5osJPCNJRHwJL91WA644vXs5Znd
         8/T3aipocCxzK+EFDuIPJw2szofYgFJxB4UDtEJTylm9dkOs/syJmqSUpdYZXIMSVA
         /7/TVSu/CF2IJ2G+vVMnc2e95Nk5jEK0mrAEG1zQ=
Authentication-Results: mxback9o.mail.yandex.net; dkim=pass header.i=@ya.ru
Received: by iva8-03ad76494624.qloud-c.yandex.net with HTTP;
        Wed, 01 Apr 2020 11:03:48 +0300
From:   =?utf-8?B?X1J1Um9fICjQkNC90LTRgNC10Lkg0KHRgtC+0YbQutC40Lkp?= 
        <ruro.ruro@ya.ru>
Envelope-From: ruro-ruro@yandex.ru
To:     "liu.denton@gmail.com" <liu.denton@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "ruro.ruro@ya.ru" <ruro.ruro@ya.ru>
Subject: Re: [BUG] git pull -- error: nothing to do
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 01 Apr 2020 11:03:48 +0300
Message-Id: <8683891585726409@myt6-674c1815a2f0.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

> I believe that this bug has been reported already.

My bad, I only searched for `git pull` and `error: nothing to do` related issues.
Didn't think to also check `rebase.abbreviateCommands`.

> Can you see if these patches fix your problem:
> https://lore.kernel.org/git/20200330124236.6716-1-alban.gruin@gmail.com/

Yes, I've just built git from the source of current `master` branch with this patch applied:
https://github.com/git/git/commit/a85ddbbb106edaaaeca34295a86aebd422479ed2.patch
And the issue seems to be fixed.

Many thanks.

-- 
Andrey Stotskiy,
ruro.ruro@ya.ru

