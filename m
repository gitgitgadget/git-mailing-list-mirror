Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 838FB2022A
	for <e@80x24.org>; Thu, 27 Oct 2016 05:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbcJ0Ftc (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 01:49:32 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:24538 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751266AbcJ0Ftb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 01:49:31 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t4GDS6KtMz5tlN;
        Thu, 27 Oct 2016 07:49:28 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1B8CB140;
        Thu, 27 Oct 2016 07:49:28 +0200 (CEST)
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
To:     Stefan Beller <sbeller@google.com>
References: <20161026215732.16411-1-sbeller@google.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        simon@ruderich.org, peff@peff.net
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
Date:   Thu, 27 Oct 2016 07:49:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161026215732.16411-1-sbeller@google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.10.2016 um 23:57 schrieb Stefan Beller:
> In Windows it is not possible to have a static initialized mutex as of
> now, but that seems to be painful for the upcoming refactoring of the
> attribute subsystem, as we have no good place to put the initialization
> of the attr global lock.

Please rewrite the attribute system such that it can have a dynamic 
initialization. If you find a global initialization in main() too gross 
(I would agree) then setup_git_directory() might be the right place.

-- Hannes

