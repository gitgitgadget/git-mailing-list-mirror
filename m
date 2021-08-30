Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5C1C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27CBA603E7
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbhH3U1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:27:30 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:25606 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232906AbhH3U13 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 16:27:29 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Gz20T5hSWz5tlB;
        Mon, 30 Aug 2021 22:26:32 +0200 (CEST)
Subject: Re: diff-index --cc no longer permitted, gitk is now broken
 (slightly)
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
 <875yvn9j69.fsf@osv.gnss.ru>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3ce08986-a402-0b07-de87-2d0f01aef7dc@kdbg.org>
Date:   Mon, 30 Aug 2021 22:26:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <875yvn9j69.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.08.21 um 15:05 schrieb Sergey Organov:
> As far as I can tell, --cc had no effect on diff-index, it was just
> silently consumed. If I'm right, this line in gitk never needed --cc.
> Then either gitk is to be fixed, or we can "fix" diff-index to silently
> consume --cc/-c again, for backward compatibility.

That latter would be much preferable. Gitk uses the combination -p --cc
for *all* diff commands when it requests patch output regardless of the
number of parents. It would be tedious to special-case diff-index to not
pass --cc.

-- Hannes
