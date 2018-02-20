Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00F791F404
	for <e@80x24.org>; Tue, 20 Feb 2018 13:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbeBTNVH (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 08:21:07 -0500
Received: from m131-177.yeah.net ([123.58.177.131]:40530 "EHLO
        m131-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeBTNVG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 08:21:06 -0500
X-Greylist: delayed 1877 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Feb 2018 08:21:05 EST
Received: from [192.168.1.101] (unknown [120.239.72.141])
        by smtp1 (Coremail) with SMTP id ClUQrACHgPRmGYxai8YtFw--.16427S3;
        Tue, 20 Feb 2018 20:49:43 +0800 (CST)
From:   chenzero <chenzero@netease.com>
Subject: About connection resuming
To:     git@vger.kernel.org
Message-ID: <b85f9654-3552-30c0-79bb-84fe10309d8b@netease.com>
Date:   Tue, 20 Feb 2018 20:49:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: ClUQrACHgPRmGYxai8YtFw--.16427S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr4kCF4DGFyrWr18XrW5ZFb_yoWDZFX_uF
        yft34qv3y0yFZ7Gay7Krs5Zr9xW39rXFWFkF98WrsIgry5Zan3W3yvk3s0vr4rJayvgr13
        WFnxu3ZrCr1I9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0khLUUUUUU==
X-Originating-IP: [120.239.72.141]
X-CM-SenderInfo: hfkh06hhurq05hwht23hof0z/1tbiDQfywlH7jFhcpQAAs9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
First, I am a user of git for about 2 years, I really appreciated you 
all to create this great useful software!
My encountered problem is:
sometimes, the repo is big and because my networking is not stable(or my 
network proxy has
some limitations), so, the clone will always fail.
I tried following ways to solve this, however, not much success.
1. clone depth 1
git clone --depth=1 https://..../repo.git
however, some repo even depth=1 might fail.(It seemed that my network 
proxy limit tcp connection.
if transfer over 50M, it will break)
2. download bundle file.
but no all git repo provide bundle files to download.

After some investment on the code, I think, perhaps,
if enhance the git-http-backend to support http header: Range, or 
Content-Range,
maybe it will enable connection resuming.
the problem of this way is: it needs to upgrade the current deployed 
"git-http-backend",
and maybe much code need to change including git-remote-http etc.

This is the very basic thought, and whether I should try other way ?
Thanks a lot!

