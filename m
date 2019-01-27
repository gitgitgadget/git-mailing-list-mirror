Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7129B1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 11:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbfA0Lz2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 06:55:28 -0500
Received: from forward501j.mail.yandex.net ([5.45.198.251]:39519 "EHLO
        forward501j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726443AbfA0Lz2 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Jan 2019 06:55:28 -0500
Received: from mxback14j.mail.yandex.net (mxback14j.mail.yandex.net [IPv6:2a02:6b8:0:1619::90])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id C8BF43380030
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 14:55:23 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback14j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 8yfCk1JMdp-tNgSXkgA;
        Sun, 27 Jan 2019 14:55:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1548590123;
        bh=weLBt7egjMePK2kdrejV7KjVnH/zn6hpT7g+2dDCx0I=;
        h=From:To:In-Reply-To:References:Subject:Date:Message-Id;
        b=XWm2MVA3KU7w4Jw5+mtm3SfCPG7nf0nKD0rE6MXN2buA0QL0grAIl/p3qxqaFbKFt
         PS0vT1JfskGoHxB7JJRVbrUG2eyCAl1nFqgMxaUAjvYa++Zw52374+ZM9+K+oXV6n1
         br7gQ8hnTncyh5Qir2fEnfal2TU9kkG3cS9qZCDA=
Authentication-Results: mxback14j.mail.yandex.net; dkim=pass header.i=@ya.ru
Received: by iva1-16f33c6a446b.qloud-c.yandex.net with HTTP;
        Sun, 27 Jan 2019 14:55:23 +0300
From:   Sergey Lukashev <lukashev.s@ya.ru>
Envelope-From: lukashev-s@yandex.ru
To:     "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <57362151548583138@iva8-37fc2ad204cd.qloud-c.yandex.net>
References: <57362151548583138@iva8-37fc2ad204cd.qloud-c.yandex.net>
Subject: Re: unclear docs
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sun, 27 Jan 2019 14:55:23 +0300
Message-Id: <13169311548590123@iva1-16f33c6a446b.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A follow up on my previous mail.

Well, I have two problems:
1) The endings I get with core.autocrlf=false depend on whether I have * text=auto (a file was commited with LFs). At least in git 2.20.1
2) If the quote holds true then autocrlf=false is actually "true" (for output conversion) on Windows by default because default core.eol is 'native', which is CRLF. I believe autocrlf=false is supposed to mean "no any conversion, input or output, read or write the repo as is".

27.01.2019, 13:05, "Sergey Lukashev" <lukashev.s@ya.ru>:
> Hello!
>
> Could somebody please explain what 'core.autocrlf overrides core.eol' means given that we have the following statement in core.eol docs:
> "Sets the line ending type to use in the working directory for files that have the text property set when core.autocrlf is false".
>
> I would like to know which line endings I'm supposed to get in the working tree if I have core.autocrlf=false and '* text=auto' in .gitattributes on windows. I get CRLFs which is consistent with the last quote but I don't understand what 'core.autocrlf overrides core.eol' means in this case.
>
> Links:
> https://git-scm.com/docs/git-config#git-config-coreeol
> https://git-scm.com/docs/gitattributes#_checking_out_and_checking_in
