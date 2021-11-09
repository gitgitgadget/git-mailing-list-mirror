Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B544C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A03610CF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbhKIXGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:06:48 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52045 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230221AbhKIXGs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 18:06:48 -0500
Received: from [192.168.9.206] (198-27-191-186.fiber.dynamic.sonic.net [198.27.191.186])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A9N3oGu012984
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 9 Nov 2021 18:03:51 -0500
Message-ID: <2f983e36-532f-ac87-9ade-fba4c6b9d276@mit.edu>
Date:   Tue, 9 Nov 2021 15:03:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v4 3/4] receive-pack: Protect current branch for bare
 repository worktree
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Andreas Heiduk <andreas.heiduk@mathema.de>
References: <a25d105a-875b-fa6a-771a-37936779f067@mit.edu>
 <20211109030028.2196416-1-andersk@mit.edu>
 <20211109030028.2196416-3-andersk@mit.edu>
 <nycvar.QRO.7.76.6.2111091717230.54@tvgsbejvaqbjf.bet>
From:   Anders Kaseorg <andersk@mit.edu>
In-Reply-To: <nycvar.QRO.7.76.6.2111091717230.54@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/9/21 08:22, Johannes Schindelin wrote:
> While `find_shared_symref()` currently won't return a `worktree` with a
> non-zero `is_bare`, to future-proof the code we might want to turn the
> `if (worktree)` below (8 lines outside the current diff context) into `if
> (worktree && !worktree->is_bare)`.

Will do.

>> +test_expect_success 'denyCurrentBranch and bare repository worktrees' '
>> +	test_when_finished "rm -fr bare.git" &&
> 
> While `wt/` will be created inside `bare.git` and therefore be removed,
> the branch `wt` won't. Maybe add `&& git branch -D wt`?

The branch ‘wt’ is inside bare.git.

> I like fruit, too! Apple, banana, grape, yummy. I wonder what's next :-)

Yay!

> Maybe make sure that `bare.git/wt/grape.t` exists? We do want the worktree
> to be updated, after all...

Right, I’d forgotten this one.  Will do.

Thanks all for the helpful reviews!

Anders
