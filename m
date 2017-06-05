Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54A041F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 14:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbdFEO1P (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 10:27:15 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35142 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbdFEO1O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 10:27:14 -0400
Received: by mail-qt0-f195.google.com with SMTP id x58so8760837qtc.2
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MYnLPlK7jAJhJCIYYYILglg+PorYCcNHFM/NjOKRZlk=;
        b=j7xWXS3o/uI25jngvGhD4N14kM9uPtk1y9PqiQTbcNVLe10Bj09o+BBf7hJHBNHEhP
         rfzWsscZBJomDUq9aHxLqYIXJ5SE2kgjfNKmZnsBxtQhT+5s6dVcioGRueOmw27uNbsk
         mSAwG3r2G14D7SlvDkReJ4xoEMNLQ30BiBknWOXp9ITW8TBm26fCWDg8Czt8lE/Sai1K
         C5v4cUMKlFZDmCXyS0R2iKzMpDkT7Ne8qcpUkCyHdKf9wehzn2+TGELDWQ8GMv0tP79L
         6K/+kv7tiuE2Dr7amkLVLzbNLZxNus//6U9sacacpImG7BJnomNBB2cUNibbnlmoqXAZ
         /JiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MYnLPlK7jAJhJCIYYYILglg+PorYCcNHFM/NjOKRZlk=;
        b=KrD/CuusqT6nL+lAFHdYNyIqLXy/VU16SDfEKdfB8oswSNOAZDRF6uYShVW+A2W9IA
         22ZWwBW34fF8Q+cRDWz1Ftv2vPL9NhMMbEAEf78kwKL9q4TG/b/QAAQJtYwEB2+eVcAE
         kYATYr9YdjQ5pGNf+FQyssWPIrvsFxBpV/puayeJ6v7mBtiuVGkb67XAz74DVZG0s3+R
         bo/z2mNrQkOwx9Ceflw6faFClaxGjt0AVm0mgjNyn9YwJ5dGaE/r0M7NKPLVQciQGtwO
         wBw+I49xYN5bu+R3h3cNfrIFzfxJUDo8jl69RB6K8WhyXTkhWoOBugZRSu3qq+rHiHKW
         YuoQ==
X-Gm-Message-State: AODbwcCsXltN/tFkQ6MwDUUBwEFHBHegKogS21DBJcSaJGYQVnBbbH+p
        Q8gD6v2rnKG7kg==
X-Received: by 10.237.45.103 with SMTP id h94mr24882683qtd.204.1496672832976;
        Mon, 05 Jun 2017 07:27:12 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id x80sm15770338qkb.63.2017.06.05.07.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jun 2017 07:27:12 -0700 (PDT)
Subject: Re: [WIP/PATCH 7/6] perf: add a performance test for core.fsmonitor
To:     David Turner <David.Turner@twosigma.com>,
        =?UTF-8?Q?'=c3=86var_Arnfj=c3=b6r=c3=b0_Bjarmason'?= 
        <avarab@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
References: <4c3fed40-774b-8ae6-fa1b-50efe6ef552f@gmail.com>
 <20170602102853.23073-1-avarab@gmail.com>
 <75ecd288047648178ed93105ee1f7a9e@exmbdft7.ad.twosigma.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <65158deb-981f-47f2-4ded-e5f691e2264f@gmail.com>
Date:   Mon, 5 Jun 2017 10:27:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <75ecd288047648178ed93105ee1f7a9e@exmbdft7.ad.twosigma.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/2/2017 5:44 PM, David Turner wrote:
> BTW, a medium-sized (~250k files across 40k dirs) synthetic repo is available over bittorrent at:
> http://bitmover.com/2015-04-03-1M-git-bare.tar.bz2.torrent
> 
> I tried Ævar's perf test with that (on a beefy laptop with SSD), and got significantly slower results with bp/fsmonitor:
> Test                          origin/master     bp/fsmonitor
> -----------------------------------------------------------------------
> 7519.2: status (first)        0.32(0.23+0.39)   0.32(0.26+0.36) +0.0%
> 7519.3: status (subsequent)   0.18(0.14+0.34)   0.32(0.24+0.37) +77.8%
> 7519.4: status -uno           0.11(0.08+0.32)   0.24(0.18+0.34) +118.2%
> 7519.5: status -uall          0.49(0.22+0.56)   0.62(0.36+0.55) +26.5%
> 7519.2: status (first)        0.32(0.23+0.39)   0.32(0.26+0.36) +0.0%
> 7519.3: status (subsequent)   0.18(0.14+0.34)   0.32(0.24+0.37) +77.8%
> 7519.4: status -uno           0.11(0.08+0.32)   0.24(0.18+0.34) +118.2%
> 7519.5: status -uall          0.49(0.22+0.56)   0.62(0.36+0.55) +26.5%
> 
> I have not yet looked into why this is.
> 

I was very focused on getting minute long status calls down to seconds 
and multiple seconds down to sub-second.  The greatest benefits are when 
the file system cache doesn't already have all the file information 
cached and the current perf test doesn't test that case - just the warm 
cache test which has the least benefit.

That said, status times shouldn't be getting worse and this has 
highlighted that they are.  I've found one reason (the current patch 
series always flags the index as dirty so it gets written out every 
time). I've got a fix that only flags it dirty when the extension is 
turned on or off or when it actually finds an entry that has become 
dirty.  This helps but there is more going on than that.

I'm looking into why the minimum status time with fsmonitor turned on 
and a warm cache seems to be ~30ms.  More to come...

>> -----Original Message-----
>> From: Ævar Arnfjörð Bjarmason [mailto:avarab@gmail.com]
>> Sent: Friday, June 2, 2017 6:29 AM
>> To: git@vger.kernel.org
>> Cc: Junio C Hamano <gitster@pobox.com>; Ben Peart
>> <peartben@gmail.com>; Nguyễn Thái Ngọc Duy <pclouds@gmail.com>;
>> Johannes Schindelin <johannes.schindelin@gmx.de>; David Turner
>> <David.Turner@twosigma.com>; Jeff King <peff@peff.net>; Christian
>> Couder <christian.couder@gmail.com>; Ævar Arnfjörð Bjarmason
>> <avarab@gmail.com>
>> Subject: [WIP/PATCH 7/6] perf: add a performance test for core.fsmonitor
>>
>> Add a performance test for the new core.fsmonitor facility using the sample
>> query-fsmonitor hook.
>>
>> This is WIP code for the reasons explained in the setup comments,
>> unfortunately the perf code doesn't easily allow you to run different setup
>> code for different versions you're testing. This test will stop working if the
>> fsmonitor is merged into the master branch.
>>
>> Output against linxu.git:
>>
>>      $ GIT_PERF_REPEAT_COUNT=10 GIT_PERF_LARGE_REPO=~/g/linux
>> GIT_PERF_MAKE_OPTS='-j8' ./run origin/master avar/fsmonitor ./p7519-
>> fsmonitor.sh
>>      [...]
>>      Test                          origin/master     avar/fsmonitor
>>      -----------------------------------------------------------------------
>>      7519.2: status (first)        0.08(0.04+0.09)   0.12(0.07+0.10) +50.0%
>>      7519.3: status (subsequent)   0.08(0.04+0.09)   0.12(0.06+0.11) +50.0%
>>      7519.4: status -uno           0.02(0.02+0.05)   0.06(0.05+0.06) +200.0%
>>      7519.5: status -uall          0.08(0.06+0.07)   0.12(0.07+0.10) +50.0%
>>
>> And against a larger in-house monorepo I have here, with the same options
>> (except the repo path):
>>
>>      Test                          origin/master     avar/fsmonitor
>>      -----------------------------------------------------------------------
>>      7519.2: status (first)        0.20(0.11+0.18)   0.27(0.15+0.21) +35.0%
>>      7519.3: status (subsequent)   0.20(0.11+0.18)   0.27(0.15+0.21) +35.0%
>>      7519.4: status -uno           0.04(0.03+0.10)   0.22(0.08+0.12) +450.0%
>>      7519.5: status -uall          0.20(0.13+0.16)   0.27(0.18+0.19) +35.0%
>>
>> Against linux.git with a hack to flush the FS cache (on Linux) before running
>> the first 'git status', only running one test so the result isn't discarded as the
>> slowest of N:
>>
>>      $ GIT_PERF_REPEAT_COUNT=1 GIT_PERF_LARGE_REPO=~/g/linux
>> GIT_PERF_MAKE_COMMAND='sudo sync && echo 3 | sudo tee
>> /proc/sys/vm/drop_caches >/dev/null && make -j8' ./run origin/master
>> avar/fsmonitor ./p7519-fsmonitor.sh
>>      [...]
>>      Test                          origin/master     avar/fsmonitor
>>      ------------------------------------------------------------------------
>>      7519.2: status (first)        0.30(0.18+0.10)   8.26(0.22+0.10) +2653.3%
>>      7519.3: status (subsequent)   0.08(0.04+0.08)   0.81(0.09+0.07) +912.5%
>>      7519.4: status -uno           0.02(0.01+0.06)   0.08(0.04+0.07) +300.0%
>>      7519.5: status -uall          0.08(0.06+0.07)   0.15(0.08+0.09) +87.5%
>>
>> Now obviously due to 1 run that has a lot of noise, but I would expect that
>> first invocation to be blindingly fast since watchman has info on what files
>> were modified since the cache was flushed.
>>
>> The same on the large monorepo noted above:
>>
>>      Test                          origin/master     avar/fsmonitor
>>      -----------------------------------------------------------------------
>>      7519.2: status (first)        0.59(0.28+0.24)   0.93(0.35+0.19) +57.6%
>>      7519.3: status (subsequent)   0.20(0.10+0.19)   0.28(0.16+0.20) +40.0%
>>      7519.4: status -uno           0.04(0.04+0.09)   0.11(0.08+0.12) +175.0%
>>      7519.5: status -uall          0.29(0.11+0.18)   0.40(0.16+0.19) +37.9%
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>
>>
>> On Fri, Jun 2, 2017 at 2:40 AM, Ben Peart <peartben@gmail.com> wrote:
>>> Any chance you can provide me with a bash script that contains the
>>> exact sequence of commands you are running to get this result?  I've
>>> been trying to replicate it using your notes but have not been able
>>> to.  I'd like to see if it is a repo difference, a platform
>>> difference, a command sequence difference (or something else entirely
>> :)).
>>
>> I can do better than that, here's a new perf test on top of this series which
>> demonstates the issue. I've only tested this on Linux
>> 4.9.0 with watchman 4.9.0 compiled from git (yes, they're coincidentally the
>> same version).
>>
>> A good addition to this would be `printf <fmt for date N sec in the
>> past> | watchman -j` as noted in my earlier mail, but I ran out of
>> time.
>>
>> You can also set any combination of GIT_PERF_7519_UNTRACKED_CACHE &
>> GIT_PERF_7519_SPLIT_INDEX to play with turning that on. I haven't tested all
>> combinations of that, but e.g. testing with untrackedCache didn't give results
>> that looked different from the performance regressions noted above.
>>
>> Aside from performance, I think a very good addition to stress-test this series
>> would be a patch to t/test-lib*sh guarded by some env flag to do a similar
>> watchman watch-del/watch/watch-list dance as the one I'm doing here in
>> the setup, and setting up the hook / config.
>>
>> That would allow testing the entire git test suite with this feature, to find any
>> subtle bugs this might have introduced in git-status.
>>
>>   t/perf/p7519-fsmonitor.sh | 58
>> +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>   create mode 100755 t/perf/p7519-fsmonitor.sh
>>
>> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh new file
>> mode 100755 index 0000000000..b838a0ff14
>> --- /dev/null
>> +++ b/t/perf/p7519-fsmonitor.sh
>> @@ -0,0 +1,58 @@
>> +#!/bin/sh
>> +
>> +test_description="Test core.fsmonitor"
>> +
>> +. ./perf-lib.sh
>> +
>> +test_perf_large_repo
>> +test_checkout_worktree
>> +
>> +test_expect_success 'setup' '
>> +	# Maybe set untrackedCache & splitIndex depending on the
>> +	# environment, defaulting to false.
>> +	if test -n "$GIT_PERF_7519_UNTRACKED_CACHE"
>> +	then
>> +		git config core.untrackedCache true
>> +	else
>> +		git config core.untrackedCache false
>> +	fi &&
>> +	if test -n "$GIT_PERF_7519_SPLIT_INDEX"
>> +	then
>> +		git config core.splitIndex true
>> +	else
>> +		git config core.splitIndex false
>> +	fi &&
>> +
>> +	# Relies on core.fsmonitor not being merged into master. Needs
>> +	# better per-test ways to disable it if it gets merged.
>> +	git config core.fsmonitor true &&
>> +
>> +	# Hook scaffolding
>> +	mkdir .git/hooks &&
>> +	cp ../../../templates/hooks--query-fsmonitor.sample
>> +.git/hooks/query-fsmonitor &&
>> +
>> +	# Setup watchman & ensure it is actually watching
>> +	watchman watch-del "$PWD" >/dev/null 2>&1 &&
>> +	watchman watch "$PWD" >/dev/null 2>&1 &&
>> +	watchman watch-list | grep -q -F "$PWD"
>> +'
>> +
>> +# Setting:
>> +#
>> +#    GIT_PERF_REPEAT_COUNT=1 GIT_PERF_MAKE_COMMAND='sudo sync
>> && echo 3 | sudo tee /proc/sys/vm/drop_caches && make -j8'
>> +#
>> +# Can be used as a hack to performance test 'git status' on a cold fs #
>> +cache with an existing watchman watching the directory, which should #
>> +be blindingly fast, compared to amazingly slow without watchman.
>> +test_perf 'status (first)'       'git status'
>> +
>> +
>> +# The same git-status once the fs cache has been warmed, if using the #
>> +GIT_PERF_MAKE_COMMAND above. Otherwise the same as above.
>> +test_perf 'status (subsequent)'  'git status'
>> +
>> +# Let's see if -uno & -uall make any difference
>> +test_perf 'status -uno'          'git status -uno'
>> +test_perf 'status -uall'         'git status -uall'
>> +
>> +test_done
>> --
>> 2.13.0.506.g27d5fe0cd
> 
