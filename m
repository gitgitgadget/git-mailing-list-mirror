Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7021C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 21:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350419AbiCHVVB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 16:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350412AbiCHVU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 16:20:58 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4204C791
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 13:20:01 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B9ABA3F4135;
        Tue,  8 Mar 2022 16:20:00 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5E4BD3F4131;
        Tue,  8 Mar 2022 16:20:00 -0500 (EST)
Subject: Re: [PATCH v6 19/30] help: include fsmonitor--daemon feature flag in
 version info
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <bc240a9e665841a622c96b8a245ce033684394f6.1646160212.git.gitgitgadget@gmail.com>
 <220307.86cziy2fvv.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1442043e-d8d4-715a-7534-32f76536eb41@jeffhostetler.com>
Date:   Tue, 8 Mar 2022 16:19:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <220307.86cziy2fvv.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/7/22 5:51 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
[...]
>> +# Does this platform support `git fsmonitor--daemon`
>> +#
>> +test_lazy_prereq FSMONITOR_DAEMON '
>> +	git version --build-options | grep "feature:" | grep "fsmonitor--daemon"
>> +'
> 
> As I found recently (referenced in another series) the test_lazy_prereq
> doesn't currently catch segfaults etc. in git even if test_must_fail and
> friends are used.
> 
> But it's still better to future-proof things and not add more cases of
> git on the LHS of a pipe. So instead:
> 
>      git version .. >out &&
>      grep ...
> 
> The prereqs are run in their own temporary directory, so creating those
> files is OK.

Yes, I think I saw a series on this topic in my inbox recently.

This command is very safe, so I'd rather not reroll just for this.


> 
> Also: You run "grep" here twice, but as the code context shown we could
> just run it once.
> 

True, but I think this can wait too.

Thanks,
Jeff
