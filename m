Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12853C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 19:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbiCAT75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 14:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiCAT74 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 14:59:56 -0500
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73D535866
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 11:59:14 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4K7SkR0gY7z5tlB;
        Tue,  1 Mar 2022 20:59:11 +0100 (CET)
Message-ID: <1480c08e-940b-cc7e-9e92-5fe3b951d34a@kdbg.org>
Date:   Tue, 1 Mar 2022 20:59:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] userdiff: add builtin diff driver for Kotlin language.
Content-Language: en-US
To:     jaydeepjd.8914@gmail.com
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220301155431.2534136-1-jaydeepjd.8914@gmail.com>
 <xmqq8rttsic1.fsf@gitster.g> <c59383e0-d549-d198-f358-18153f18d24b@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <c59383e0-d549-d198-f358-18153f18d24b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.03.22 um 19:09 schrieb jaydeepjd.8914@gmail.com:
> When any test fails, its verbose output is not "verbose" enough.
> For example, If due to wrong xfuncname regex or wrong test, all of the
> following hunk headers
> 
> @@...@@
> @@...@@fun right(){
> @@...@@fun
> 
> produce the same verbose output:
> 
> `not ok:....hunk header:[testfilename]`

You run

  ./t4018-diff-funcname.sh -v -i

which stops at the first failing test case. You get

expecting success of 4018.160 'hunk header: kotlin-interface':
                git diff -U1 kotlin-interface >actual &&
                grep '@@ .* @@.*RIGHT' actual

not ok 160 - hunk header: kotlin-interface
#
#                       git diff -U1 kotlin-interface >actual &&
#                       grep '@@ .* @@.*RIGHT' actual
#

from which you see that you have to inspect the file actual:

  less trash\ directory.t4018-diff-funcname/actual

-- Hannes
