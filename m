Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2671C433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 16:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344600AbiDZRAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 13:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbiDZRAo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 13:00:44 -0400
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBEF6D38E
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 09:57:36 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Knp310b8qz5tlB;
        Tue, 26 Apr 2022 18:57:32 +0200 (CEST)
Message-ID: <c0c038bf-e7c4-e534-656e-0842e95a9ae6@kdbg.org>
Date:   Tue, 26 Apr 2022 18:57:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: configure doesn't test all
Content-Language: en-US
To:     Guy Maurel <guy.j@maurel.de>
References: <c14e6883-57f1-ab66-7453-830dad9f6eb7@maurel.de>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
In-Reply-To: <c14e6883-57f1-ab66-7453-830dad9f6eb7@maurel.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.04.22 um 17:21 schrieb Guy Maurel:
> ./configure
> make
> GIT_VERSION = 2.36.0
>     * new build flags
>     CC fuzz-commit-graph.o
> In file included from commit-graph.h:4,
>                  from fuzz-commit-graph.c:1:
> git-compat-util.h:1427:10: fatal error: zlib.h
> 
> Is missing on my Mint-system, BUT configure doesn't complain about this.

Unless you have a special configuration needs, your best bet to compile
on Linux is to just run

   make

Precede this with

   rm -f config.mak.autogen

if you have already run ./configure.

That doesn't liberate you from installing missing development packages,
though, and you'll see the same error as above, also with no advance
warning.

-- Hannes
