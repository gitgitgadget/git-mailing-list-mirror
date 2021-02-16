Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584B5C433E9
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3298164E64
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhBPSzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 13:55:15 -0500
Received: from siwi.pair.com ([209.68.5.199]:59162 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231191AbhBPSzM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 13:55:12 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A2B723F40F1;
        Tue, 16 Feb 2021 13:54:30 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 757933F4047;
        Tue, 16 Feb 2021 13:54:30 -0500 (EST)
Subject: Re: Bug? I can't manually merge changes with difftool
To:     Victor Porton <porton@narod.ru>, git@vger.kernel.org
References: <b46fd946-42ad-2c33-0294-415949b9085e@narod.ru>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <fd7ced2a-3b07-eb07-cb48-0a57dac9a5e0@jeffhostetler.com>
Date:   Tue, 16 Feb 2021 13:54:28 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b46fd946-42ad-2c33-0294-415949b9085e@narod.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/16/21 1:30 PM, Victor Porton wrote:
> When I run
> 
> git difftool main HEAD
> 
> and manually merge changes in started meld or kdiff3 and then save the
> resulting file, it is saved somewhere in /tmp not in the workdir.
> Workdir is not modified after I close meld or kdiff3.
> 
> I need to store changes in workdir.
> 
> Is it a bug of Git 2.27.0.
> 

When you give it two branches or refs, it does a "historical" diff
between those two versions.  If you omit "HEAD" from the command line,
it will diff your "main" branch against the live version in your
worktree.

Jeff


