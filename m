Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEA4C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 20:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349484AbiCHU1P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 15:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242196AbiCHU1N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 15:27:13 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526A951302
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 12:26:16 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3709F3F4131;
        Tue,  8 Mar 2022 15:26:15 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B7F3A3F4090;
        Tue,  8 Mar 2022 15:26:14 -0500 (EST)
Subject: Re: [PATCH v6 16/30] compat/fsmonitor/fsm-listen-darwin: add MacOS
 header files for FSEvent
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <cdef9730b3f93a6f0f98d68ffb81bcb89d6e698e.1646160212.git.gitgitgadget@gmail.com>
 <220307.86h78a2gcn.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9bc32c17-7249-303f-e579-8992c5bc8497@jeffhostetler.com>
Date:   Tue, 8 Mar 2022 15:26:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <220307.86h78a2gcn.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/7/22 5:37 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>> [...]
>> +#define kFSEventStreamEventFlagNone               0x00000000
[...]
>> +#define kFSEventStreamEventFlagItemCloned         0x00400000
> 
> Can we define these as 1<<0, 1<<1, 1<<2 etc.? We do that in most other
> places, and it helps to quickly eyeball these and see that they don't
> have gaps.

All of these constants are defined by Apple in their header
files and system documentation.  For example, see:
https://developer.apple.com/documentation/coreservices/1455361-fseventstreameventflags/kfseventstreameventflagitemcloned

The set is relatively fixed by Apple and we won't be adding any
(since they define the bits in a FS event from the kernel).

Changing them to shifts would be wrong.


thanks
Jeff
