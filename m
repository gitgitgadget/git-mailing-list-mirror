Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.0 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8A2E211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 17:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbeL0RAa (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 12:00:30 -0500
Received: from mail.bjtu.edu.cn ([218.249.29.198]:56544 "EHLO bjtu.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729264AbeL0RAa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 12:00:30 -0500
Received: by ajax-webmail-Jdweb4 (Coremail) ; Fri, 28 Dec 2018 01:02:34
 +0800 (GMT+08:00)
Date:   Fri, 28 Dec 2018 01:02:34 +0800 (GMT+08:00)
From:   =?GBK?B?0KS9qL6n?= <06271023@bjtu.edu.cn>
To:     git@vger.kernel.org
Message-ID: <650358a3.8395.167f09e21b6.Coremail.06271023@bjtu.edu.cn>
Subject: a git svn bug
MIME-Version: 1.0
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit
X-Originating-IP: [114.249.197.27]
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 4.0.8 dev build
 20150608(70565.7215.7117) Copyright (c) 2002-2018 www.mailtech.cn bjtu
X-SendMailWithSms: false
X-CM-TRANSID: eJ5wygBnjoyqBSVcU7JiAA--.10369W
X-CM-SenderInfo: yqwsliaqstquxmwxhvlgxou0/1tbiAwITAFOeS0RU+AAFs5
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi,
   git developers. I found a bug when i want to convert webkit to git
   there are some branch named safari... in webkit svn repo.
   when i want to convert them to branch in git. a problem happen.

   if you want to reproduce the problem, just follow the guide below.
   1. git svn clone -s https://svn.webkit.org/......

   2. when it runs to about r13800, stop it and rerun the above command

   3. the git client will check the refs it already found, and if it met a ~ in the branch name. it will failed to proceed. error is git thinks it an invalid ref name

   i digged into it, and found a solution in git/perl/git/svn.pm. I mod this file and bypass the problem.

   plean be kind to fix the problem and remind me the fix commit, and i will update to a new version.

