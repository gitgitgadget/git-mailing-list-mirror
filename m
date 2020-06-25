Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71273C433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 17:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5536B20707
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 17:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405696AbgFYRyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:54:22 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:44973 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405512AbgFYRyW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 13:54:22 -0400
X-Originating-IP: 157.36.214.255
Received: from localhost (unknown [157.36.214.255])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 603E4FF804;
        Thu, 25 Jun 2020 17:54:18 +0000 (UTC)
Date:   Thu, 25 Jun 2020 23:24:16 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Hin-Tak Leung <htl10@users.sourceforge.net>
Cc:     git@vger.kernel.org
Subject: Re: git doing large refetches
Message-ID: <20200625175416.xnrx6dpgdg4rqvx4@yadavpratyush.com>
References: <1731755010.6694064.1593107165458.ref@mail.yahoo.com>
 <1731755010.6694064.1593107165458@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1731755010.6694064.1593107165458@mail.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 25/06/20 05:46PM, Hin-Tak Leung wrote:
> Hi,
> 
> Lately I noticed that git occasionally do very large re-fetches, despite the difference between local and remote being not large. For example, here are two aborted fetches (see how small the emumerating / counting /compressing are, compared to the receiving object number):
> 
> $ git fetch torvalds
> remote: Enumerating objects: 19374, done.
> remote: Counting objects: 100% (19374/19374), done.
> remote: Compressing objects: 100% (4016/4016), done.
> ^Cceiving objects:   2% (161673/7478285), 80.54 MiB | 2.78 MiB/s
> 
> $ git fetch sound
> remote: Enumerating objects: 52009, done.
> remote: Counting objects: 100% (52009/52009), done.
> remote: Compressing objects: 100% (5480/5480), done.
> ^Cceiving objects:   1% (74819/7481898), 37.92 MiB | 1.98 MiB/s
> 
> I don't see any real pattern, as the last few times I fetch from either of those two are also quite small ( a few days ago).
> 
> $ git --version
> git version 2.26.2

See https://lore.kernel.org/git/20200422155047.GB91734@google.com/

This problem shouldn't be present in v2.27.*

-- 
Regards,
Pratyush Yadav
