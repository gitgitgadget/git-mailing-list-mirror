Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 559B71F424
	for <e@80x24.org>; Wed,  9 May 2018 13:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934912AbeEINe7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 09:34:59 -0400
Received: from forward4j.cmail.yandex.net ([5.255.227.22]:39915 "EHLO
        forward4j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934724AbeEINe6 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 May 2018 09:34:58 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 May 2018 09:34:58 EDT
Received: from mxback12j.mail.yandex.net (mxback12j.mail.yandex.net [IPv6:2a02:6b8:0:1619::87])
        by forward4j.cmail.yandex.net (Yandex) with ESMTP id 941EE20F10
        for <git@vger.kernel.org>; Wed,  9 May 2018 16:27:17 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback12j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id WS2RrGaoGM-RGl8TJRI;
        Wed, 09 May 2018 16:27:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1525872436;
        bh=tvIOnBSC8jXgGgQqkTuQKRqmo9JaGo9s1xoVSYzkakc=;
        h=From:To:In-Reply-To:References:Subject:Message-Id:Date;
        b=o4/JRC5OojeAqddbFZJSy2m9+qoyLuyIHZ3uKFyRzf9o6dZ/x7GrgX/B+7n30KI8+
         KGoOXg2uKINcxtLVolvCXp99KPOZDFFf5xvvMdsWw7RRJntXLLykYQXPSjqEF15Ec9
         kU4Y0IPNMNekcdj/eem5JSaVrO1DTu0j5sfqHAKQ=
Authentication-Results: mxback12j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web47o.yandex.ru with HTTP;
        Wed, 09 May 2018 16:27:16 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.com
To:     git <git@vger.kernel.org>
In-Reply-To: <6015131525872315@web37g.yandex.ru>
References: <6015131525872315@web37g.yandex.ru>
Subject: Re: Can not save changes into stash
MIME-Version: 1.0
Message-Id: <5718771525872436@web47o.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 09 May 2018 16:27:16 +0300
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I even can not drop local changes:

$ git checkout local.conf 
error: pathspec 'local.conf' did not match any file(s) known to git.

$ git log local.conf
commit 6df8bab88fd703c6859954adc51b2abaad8f59ec
Author: Eugen Konkov <kes-kes@yandex.ru>
Date:   Wed May 9 15:31:02 2018 +0300

    Implement module which allow override target option
    
    Most usefull to configure application on developer host



09.05.2018, 16:25, "KES" <kes-kes@yandex.ru>:
> How to reproduce:
>
> $ git update-index --skip-worktree conf/local.conf
> $ git pull
> Updating 0cd50c7..bde58f8
> error: Your local changes to the following files would be overwritten by merge:
>         conf/local.conf
> Please commit your changes or stash them before you merge.
> Aborting
> $ git stash save
> No local changes to save
