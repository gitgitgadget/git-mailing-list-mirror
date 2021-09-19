Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3E7C433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 18:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F6F161242
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 18:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhISSrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 14:47:45 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:55107 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhISSro (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 14:47:44 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4HCGqW3wN3z5tlB;
        Sun, 19 Sep 2021 20:46:15 +0200 (CEST)
Subject: Re: [PATCH 3/4] difftool: use a strbuf to create the tmpdir path
To:     David Aguilar <davvid@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20210919015729.98323-1-davvid@gmail.com>
 <20210919015729.98323-3-davvid@gmail.com>
 <8dfd0683-e019-a45c-30a4-d49ea627e36d@kdbg.org>
 <CAJDDKr6AM0YZ-5GmXHz=2VbRKOusjQ-OAP2ng8GpBDb0x1pPRg@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d882e3a7-d459-5063-eca7-e77e1addfed5@kdbg.org>
Date:   Sun, 19 Sep 2021 20:46:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAJDDKr6AM0YZ-5GmXHz=2VbRKOusjQ-OAP2ng8GpBDb0x1pPRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.09.21 um 20:13 schrieb David Aguilar:
> A better title might be:
> 
>     difftool: use a strbuf to generate a tmpdir path without double-slashes
> 
> The double-slashes are the point. This patch is a minor cleanup that I
> found on the path towards fixing the data loss bug in patch 4.
> 
> Thanks for the heads-up about the confusion ~ I'll reword in the next
> submission to make this point clearer.

Thanks. My primary concern with the patch was actually that it looks
like mere code churn that introduces an error by not using is_dir_sep().
This is now settled.

But still, without a justification why the slashes should be cleaned up,
the patch looks like code churn. You can ignore me if it is obvious for
others why we need the patch.

-- Hannes
