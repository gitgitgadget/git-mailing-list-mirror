Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D04471F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 19:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436685AbfJPTJA (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 15:09:00 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:48155 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731321AbfJPTI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 15:08:59 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iKofI-0005Jl-Ca; Wed, 16 Oct 2019 20:08:57 +0100
Subject: Re: [RFC PATCH v1] t/README: the test repo does not have global or
 system configs
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     GitList <git@vger.kernel.org>
References: <20191016124515.1807-1-philipoakley@iee.email>
 <20191016164707.GW29845@szeder.dev>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <dc8afd1b-2e69-e54d-aee9-e5d6c4b729f5@iee.email>
Date:   Wed, 16 Oct 2019 20:08:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016164707.GW29845@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/10/2019 17:47, SZEDER Gábor wrote:
> On Wed, Oct 16, 2019 at 01:45:15PM +0100, Philip Oakley wrote:
>> Signed-off-by: Philip Oakley <philipoakley@iee.email>
>> ---
>>
>> While tring to get to grips with some Git-for-Windows config settings
>> for testing >4GiB files, I couldn't find any note in the readme about
>> the test system config file sources.
> The path of the system config file is determined at compile time, with
> no way to override it at runtime.  Since we don't want external config
> files influencing our tests, the only choice we have is to ignore the
> system config file; that's why our test framework sets
> GIT_CONFIG_NOSYSTEM=1.
Thanks.
>> Is this the right place for the information, is it complete enough,
>> and is the default config template special?
>>
>>   t/README | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/t/README b/t/README
>> index 60d5b77bcc..3daa1fa182 100644
>> --- a/t/README
>> +++ b/t/README
>> @@ -485,6 +485,9 @@ This test harness library does the following things:
>>      the --root option documented above, and a '.stress-<N>' suffix
>>      appended by the --stress option.
>>   
>> + - The --global and --system config files are ignored, and
>> +   a basic --local config is created in the tst repository.
> s/tst/test/
>
> However, note that the global config file isn't really ignored, but
> different.  The path of the global config file depends on the values
> of the env variables $XDG_CONFIG_HOME and $HOME, and, again, to avoid
> external influences, our test framework unsets the former, and
> overrides the latter with HOME="$TRASH_DIRECTORY".  IOW the global
> config file in our tests is '.../t/trash directory.t1234-foo/.gitconfig'.
Thanks
>> +
>>    - Defines standard test helper functions for your scripts to
>>      use.  These functions are designed to make all scripts behave
>>      consistently when command line arguments --verbose (or -v),
>> -- 
>> 2.23.0.windows.1.21.g947f504ebe8.dirty
>>
I'll revise the text with this clarifying information (rephrased to man 
page style)

Philip
