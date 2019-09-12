Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 327C61F463
	for <e@80x24.org>; Thu, 12 Sep 2019 07:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbfILHSj (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 03:18:39 -0400
Received: from forward101o.mail.yandex.net ([37.140.190.181]:39423 "EHLO
        forward101o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbfILHSj (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Sep 2019 03:18:39 -0400
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Sep 2019 03:18:37 EDT
Received: from mxback7o.mail.yandex.net (mxback7o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::21])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id 848AF3C0372B
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 10:12:47 +0300 (MSK)
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [2a02:6b8:0:1a2d::25])
        by mxback7o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id SBD8hHifoA-ClfSRfm2;
        Thu, 12 Sep 2019 10:12:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1568272367;
        bh=2ndFDjwVwluZkeZejLNfmCyg+1sw49cieEjxnBBbCRw=;
        h=Subject:To:From:Date:Message-ID;
        b=aq5ihCCu8o4yZKXxFjlVIkBW+B9qp7OYx7hwe3buw7GEvv+bEn61cuT12v0gw+Dwx
         ii4Q3EQ14bTtMB2Fl+qzLUG1XQKNr/eG0C3cz3anJ1csUFDOyvAdq2V7IneJh3Giz7
         8NoERYsSfglpBmqw5Hx5i9uPTVMVPBk+jyo/X4P4=
Authentication-Results: mxback7o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 3WF64yOqPk-Ck0u8Ztm;
        Thu, 12 Sep 2019 10:12:46 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Thu, 12 Sep 2019 10:12:45 +0300
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <386490889.20190912101245@yandex.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: error: could not read '.git/rebase-apply/head-name': No such file or directory
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git,

Next commands cause the error:

$ git pull
fatal: It seems that there is already a rebase-apply directory, and
I wonder if you are in the middle of another rebase.  If that is the
case, please try
        git rebase (--continue | --abort | --skip)
If that is not the case, please
        rm -fr ".git/rebase-apply"
and run me again.  I am stopping in case you still have something
valuable there.

$ git rebase --abort 
error: could not read '.git/rebase-apply/head-name': No such file or directory

$ git --version
git version 2.20.1

$ rm -fr ".git/rebase-apply"

$ git rebase --abort 
error: could not read '.git/rebase-apply/head-name': No such file or directory

$ git pull
fatal: It seems that there is already a rebase-apply directory, and
I wonder if you are in the middle of another rebase.  If that is the
case, please try
        git rebase (--continue | --abort | --skip)
If that is not the case, please
        rm -fr ".git/rebase-apply"
and run me again.  I am stopping in case you still have something
valuable there.


I resolved this issue by
git checkout -f some_br

But this issues should not occur


-- 
Best regards,
Eugen Konkov

