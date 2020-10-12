Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA42C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 15:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C314420878
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 15:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="J1CV1vrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389189AbgJLPEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 11:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388518AbgJLPEX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 11:04:23 -0400
Received: from forward103j.mail.yandex.net (forward103j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB7AC0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 08:04:23 -0700 (PDT)
Received: from mxback15j.mail.yandex.net (mxback15j.mail.yandex.net [IPv6:2a02:6b8:0:1619::91])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id F00F267409B6
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 18:04:19 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback15j.mail.yandex.net (mxback/Yandex) with ESMTP id rJCjNL3nS1-4JTO8eBE;
        Mon, 12 Oct 2020 18:04:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1602515059;
        bh=Oh74068WEjyT8k8rUOS+7yfdTLFUC2Mh+QOGD2NzPQY=;
        h=References:Date:Message-Id:Subject:In-Reply-To:To:From;
        b=J1CV1vrILRbmCdpYnlSqpz4yM+upn52rqXTCeL1g7dNCV0iyNTFDARt2bHABrPmwo
         FzsAKAcQfYPgoT3g6gxWQyWAwl7vCMJC67phMvzb1N4oasHyn5FkoYPL+X0mZdTF96
         Jf8oopZtmK93gFEtQZBffVSZ+wlBbViCh8Y/OYPk=
Authentication-Results: mxback15j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva8-c4b4179e2e3a.qloud-c.yandex.net with HTTP;
        Mon, 12 Oct 2020 18:04:19 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Victor Porton <porton@narod.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <28a86c75-de4d-acbe-dab7-e5512961538c@narod.ru>
References: <28a86c75-de4d-acbe-dab7-e5512961538c@narod.ru>
Subject: Re: Feature: checkout and merge
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 12 Oct 2020 18:04:19 +0300
Message-Id: <5293161602514983@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



12.10.2020, 14:12, "Victor Porton" <porton@narod.ru>:
> It is a very often need to checkout a branch and them merge the branch
> that was before the checkout. Moreover after this is very often needed
> to push.
>
> So please add the flags to `checkout`:
>
> 1. to merge the old branch immediately after checkout
>
> 2. to push after checkout
>
> I repeatedly write:
>
> git checkout stable && git merge main && git push && git checkout main
>
> (I am not subscribed to this mailing list.)

Why not make a shell script to do this?


-- 
Regards,
Konstantin
