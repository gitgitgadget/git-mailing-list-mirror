Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E61C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 00:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 481BA60F5B
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 00:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbhHaApE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 20:45:04 -0400
Received: from avasout04.plus.net ([212.159.14.19]:42188 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhHaApE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 20:45:04 -0400
Received: from [10.0.2.15] ([195.213.6.54])
        by smtp with ESMTPA
        id Krskme0egOQhvKrsmmeTdD; Tue, 31 Aug 2021 01:44:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1630370648; bh=SWKDysZvCLrcK0BPnhkDCRLDuaCJEqQDiCHXr2q2myk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TOPe0DgViIjmHutudKZrL9VhY4b+zLvLIWgNGypaq7NifLQSyn1LoCXxQvBVvM2KB
         ttJQda/Y6tF4jlSTNEu5z4lmmAoBa5ZsREoGUrE2I+ETanYoUakV3+nfZNf+3hnlZs
         I75DMXlNM5YnX3kS0l5Z3nxyNsC7NbD4wS4eHQtGeOYZsHo+gC1LC6ez4XEZDrWEzf
         Bp0f5dygoGbRuucKUQMqyje29A4n3uqpq3/DvCshT/ZlWeqJ+9hDClgWFcEQKqld73
         qQZnPcHuHP1agsxL4df96fENT63iDen9xnjxpmluXjKQJT6U5xj5ZEszK4ZFWj+Bg3
         NLP0FSoHDxUtQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=IvmFjI3g c=1 sm=1 tr=0
 a=thHlcjYJ4SvUC+rIXd59ow==:117 a=thHlcjYJ4SvUC+rIXd59ow==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=-1JJe-mRlKB3tfsuQxEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] t7900: add '--scheduler=launchctl' parameter to fix test
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        GIT Mailing-list <git@vger.kernel.org>
References: <17313607-7ae8-c37a-7931-7712c7bfdb88@ramsayjones.plus.com>
 <xmqqtuj66hu5.fsf@gitster.g>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <863717af-8500-1779-b278-be7a785ab011@ramsayjones.plus.com>
Date:   Tue, 31 Aug 2021 01:44:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqtuj66hu5.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJUdqyqo1a44chisTn0ThlcI9cX+szxuZAXsDGy0KMmDVlkmqBqbEPWcxduHCeqFzdEKMh4tmAiUN90eeBvz+BCMJxzXFZA4ahkEKSZeBLeKF1Yp3Zbu
 LhCCvm+Nxi3epX14pxZOMZQpmwfIaR7JR1aPJD2AkdhLf3VTx2+px3RSgE0lNzFW335WOXcnhjGd3w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 30/08/2021 17:02, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
[snip]
> 
> This test comes from outside Lénaïc's series.  I guess I am seeing a
> botched semantic merge conflict resolution of mine where the two
> topics met.

Oops! :( My apologies to you both.

My build of 'seen' had two test failures (t5319.19 and this one), and
I had to be somewhere else in about 30 mins ...

I should know by now not to rush out a patch ... Sorry to have wasted
your time.

ATB,
Ramsay Jones

