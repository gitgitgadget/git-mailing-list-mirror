Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6317C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0A420716
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfLSSDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:03:51 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.102]:9828 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSSDv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:03:51 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1ii09N-00074K-Pk; Thu, 19 Dec 2019 19:03:49 +0100
Subject: Re: [PATCH v2 02/18] t7526: add tests for error conditions
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
 <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
 <c7cd46d3a3bcbf4a5cfe2aa6aa71b3713801892b.1576511287.git.gitgitgadget@gmail.com>
 <xmqqr211cmxy.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <8b300527-0800-72dc-b901-74ecbe15622a@syntevo.com>
Date:   Thu, 19 Dec 2019 19:03:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqr211cmxy.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18.12.2019 23:02, Junio C Hamano wrote:

>> +	test_must_fail git commit --pathspec-from-file=- --interactive -m "Commit" <list 2>err &&
>> +	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-interactive/\-\-patc
> h" err &&
> 
> What's with the overly-noisy quoting of dashes here?  To match a
> string that happens to begin with a dash, either one of
> 
> 	$ grep -e "-this string begins with and has-many-dashes-in-it" file
> 	$ grep "[-]this string begins with and has-many-dashes-in-it" file
> 
> would be sufficient and more idiomatic.
> 
> Or am I missing some other reason why the test is written this way?

No, it's just my lack of experience. Thanks for your fix! I have applied 
it in V3.
