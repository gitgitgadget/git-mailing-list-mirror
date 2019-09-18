Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF35F1F463
	for <e@80x24.org>; Wed, 18 Sep 2019 21:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388092AbfIRVon (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 17:44:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33389 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388087AbfIRVon (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 17:44:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id c4so1344289edl.0
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 14:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=domanski-co.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cMs/l0tslbDO5L12EnYYzCOJ6YC0WMKpaq92ZcOgIuc=;
        b=VBV1ovEnFv48kFlOfksUhtKXuLQOqUT2a1GH/X8N1L+ILfVLmTb81WzvGdnVH87K/B
         jMtGj8I2hAYCNoy0fvQN+4j54c/c5Ptg4fK3teW5ofgm8SdkQUHRhrVCypnq6TePKUZu
         TqJCz5rdI2r9h11jCjk04WoRnJB4MHNw4WOSMoy+FUe7nDDEk94B5rTGXWOtA8a9JQ2d
         gPsKysAl/el1krP2tG74cBl7J7F1wq3nxdwMQ47i1zHAXnbF6G/vnHKfTzFzvh5f2+6J
         iYJ/d1APvvRIGYXHjOaoSWbCf4LnkznzCmxDWvXTbB/K6Yyv9xbHNh8+t0AadcKLoDtb
         KalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cMs/l0tslbDO5L12EnYYzCOJ6YC0WMKpaq92ZcOgIuc=;
        b=TYFznxcAigIdf8X8GTxX22HCKT48tlZ9iLw0YTJDXQBR7q3QKAOqdCLehX4coSXDT6
         R4r9QEiWIWtus2PcZHCENn13n13W1ckT5P0zJvJ1fN79bVyV4FmudTwmeEadm0cHtmr9
         raT6JDfUVLkhIRQjZOn9lne1w2Wok6Tz8AsFW81ZgZ8bQgKliORRDew/vBckroSQ/uVT
         Vhj+MTdJpsysGwCQkk5U7IVDsnjEsptuYx8OeSGXyE7e2aWMXkxVWLVZeaEJKkN1o98s
         uZnPpV805WnKjdZOCZtJupii5JH5DPWS4Mu+MlrpxVj1KJr8NcYiiqILsV+siPDX9I4g
         AcLg==
X-Gm-Message-State: APjAAAX3D+1j9l8t7jhTrdHLMTcbAZ+rh6XQvp0QC9eDwRl7t2eK6vox
        9/KBFYKgu2ESQhEcw0JKHmliuLZP/t8=
X-Google-Smtp-Source: APXvYqxXid9t1MygGSV+Z5K+xwN6UmwFpcGyvXpimFZajmJMkLOGJunG6IJEBNV0A/UO9N/oEtB+OQ==
X-Received: by 2002:a50:b885:: with SMTP id l5mr12372603ede.190.1568843081160;
        Wed, 18 Sep 2019 14:44:41 -0700 (PDT)
Received: from ?IPv6:2a04:4540:6b28:1c00:90e0:2ff6:43c:3b2b? ([2a04:4540:6b28:1c00:90e0:2ff6:43c:3b2b])
        by smtp.googlemail.com with ESMTPSA id p4sm1254924edc.38.2019.09.18.14.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 14:44:40 -0700 (PDT)
Subject: Re: [PATCH] ls-remote: create '--count' option
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
References: <20190918001134.20776-1-kamil@domanski.co>
 <f643547f-54e0-fe4f-d8e5-95445431faf3@kdbg.org>
From:   =?UTF-8?Q?Kamil_Doma=c5=84ski?= <kamil@domanski.co>
Message-ID: <21455bdb-431e-2842-0618-2f36a18bb60e@domanski.co>
Date:   Wed, 18 Sep 2019 23:44:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f643547f-54e0-fe4f-d8e5-95445431faf3@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/18/19 8:28 AM, Johannes Sixt wrote:
> Am 18.09.19 um 02:11 schrieb Kamil Domański:
>> Create a '--count' option for ls-remote, based on the one from
>> for-each-ref. This allows e.g. to return only the first result
>> from a sorted list of refs.
>>
>> Signed-off-by: Kamil Domański <kamil@domanski.co>
>> ---
>>   Documentation/git-ls-remote.txt | 11 ++++++++---
>>   builtin/ls-remote.c             | 16 ++++++++++++----
>>   t/t5512-ls-remote.sh            |  9 +++++++++
>>   3 files changed, 29 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
>> index 0b057cbb10..5adc1d676e 100644
>> --- a/Documentation/git-ls-remote.txt
>> +++ b/Documentation/git-ls-remote.txt
>> @@ -9,9 +9,9 @@ git-ls-remote - List references in a remote repository
>>   SYNOPSIS
>>   --------
>>   [verse]
>> -'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=<exec>]
>> -	      [-q | --quiet] [--exit-code] [--get-url] [--sort=<key>]
>> -	      [--symref] [<repository> [<refs>...]]
>> +'git ls-remote' [--count=<count>] [--heads] [--tags] [--refs]
>> +	      [--upload-pack=<exec>] [-q | --quiet] [--exit-code] [--get-url]
>> +	      [--sort=<key>] [--symref] [<repository> [<refs>...]]
> It is understandable that the new option is important to _you_, but it
> does not seem important enough that it must be the first in the list.
> Please add it between --symref and <repository>
The assumption is quite unnecessary. I merely tried to reflect the 
position of this parameter in the 'for-each-ref' command, on which I 
based the patch.
>>   
>>   DESCRIPTION
>>   -----------
>> @@ -21,6 +21,11 @@ commit IDs.
>>   
>>   OPTIONS
>>   -------
>> +--count=<count>::
>> +	By default the command shows all refs that match
>> +	`<pattern>`.  This option makes it stop after showing
>> +	that many refs.
> Is the meaning of this option perhaps:
>
>      Stops after the specified count of refs have been listed.
>      If `--sort=<key>` is specified as well, refs are counted
>      after sorting; otherwise, it is unspecified which subset
>      of is listed.

Similarly, I merely copied the description used by 'for-each-ref'. I 
like your version as well, since it clarifies the relation to sorting. 
Should the description for 'for-each-ref' be changed as well then?

> I do not know whether the "otherwise" part would be true (check it!),
> but I am pretty certain that the "If" part must be true, otherwise the
> option would be pointless.

Yes, both in 'for-each-ref' as well as this patch, cutting off the 
results takes place after the whole set has been already sorted. As for 
the "otherwise" part, it appears that 'for-each-ref' defaults to sorting 
by 'refname' (through ref_default_sorting() ) if no alternative sorting 
is provided, while 'ls-remote' does no such defaulting. Do you figure it 
would be a good idea to add another patch which would introduce a 
similar default in 'ls-remote'?


Regards,

Kamil



