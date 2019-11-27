Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD1CC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7122073F
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfK0QnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:43:02 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:3193 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0QnC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 11:43:02 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1ia0P4-0005Ya-Pp; Wed, 27 Nov 2019 17:42:58 +0100
Subject: Re: [PATCH 2/2] checkout: die() on ambiguous tracking branches
To:     Derrick Stolee <stolee@gmail.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.477.git.1574848137.gitgitgadget@gmail.com>
 <7dde1a3b4e4e76cd1a820b5277f694fdfad3a922.1574848137.git.gitgitgadget@gmail.com>
 <b6963515-1f28-74ab-42bc-a14a07856118@gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <94480425-1827-48d6-b7d7-966acc536c6c@syntevo.com>
Date:   Wed, 27 Nov 2019 17:42:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b6963515-1f28-74ab-42bc-a14a07856118@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27.11.2019 15:46, Derrick Stolee wrote:
>> +	if (!remote && (num_matches > 1)) {
> 
> I believe the parentheses around "num_matched > 1" are not needed here.

Fixed in v2.

> I like that you added a test for this non-obvious situation. One thing that
> would help ensure that your test is checking the right thing is to redirect
> stderr to a file and grep for the die() message you included. Something like:
> 
> 	test_must_fail git checkout ambiguous_branch_and_file 2>err &&
> 	test_i18ngrep "matched multiple (2) remote tracking branches" err &&

This is a good idea, thanks! Added in v2.
