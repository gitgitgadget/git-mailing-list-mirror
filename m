Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66D6C0015E
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 17:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjGZRgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 13:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjGZRgi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 13:36:38 -0400
Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9ACE42696
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 10:36:37 -0700 (PDT)
Received: from [192.168.5.3] (c-73-202-23-161.hsd1.ca.comcast.net [73.202.23.161])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 36QHaH8a034763
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 26 Jul 2023 10:36:36 -0700 (PDT)
        (envelope-from yuri@tsoft.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-202-23-161.hsd1.ca.comcast.net [73.202.23.161] claimed to be [192.168.5.3]
Message-ID: <792f71bb-2b9a-2e2b-80ea-9e3afd9fbfb4@tsoft.com>
Date:   Wed, 26 Jul 2023 10:36:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: 'git stash push -- {dir}' puts files in stash that are outside of
 {dir}
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <5fce9c4f-0ea7-9393-4a30-ddd66946661d@tsoft.com>
 <xmqqsf9ad1ju.fsf@gitster.g>
From:   Yuri <yuri@tsoft.com>
In-Reply-To: <xmqqsf9ad1ju.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/26/23 10:29, Junio C Hamano wrote:
> Are there configuration variables set to affect the behaviour of the
> "git stash" command in your environment that I do not have (I have
> nothing in "git config -l | grep stash" output), which may be
> affecting why it does not reproduce for me?


"git config -l | grep stash" doesn't print anything.

Interestingly, the command 'git stash push -- Mk' puts intended and unintended files in stash, but the changes in unintended files (ones not under Mk) stay, while changes in the intended files are gone, as expected.

Clearing all changes and doing 'git stash pop && git stash push -- Mk' reproduces the problem.


Yuri

