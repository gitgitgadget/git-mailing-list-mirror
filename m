Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 747031F463
	for <e@80x24.org>; Fri, 13 Sep 2019 18:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389368AbfIMSpd (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 14:45:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44581 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388709AbfIMSpd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 14:45:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so15664088pgl.11
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 11:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OBqyxtu8b4/GLR3vPjv3vdu97TmceaxE7WAVWz2wu/g=;
        b=XxXqKyt7F3YtBMRxstA92lO642Y4tAWNf4KaWv9GFWpabSlbOoxELHdkfp5C4sbt27
         08SF2mtyUPPSxXynfk9RrRSkywq9AzIcdpx/69qPzs7Ljm5PRvTnc1Uwo5OxUFXJdCxS
         V1Z1j5ecX0fRSRXALse66rUAVWGC1U+TIQBz91TnHwF7JAgHJH6BNLbVrb91qKjegBXO
         aMUCCRVOSM5cd6HEnrz1lBGjiLIXAkkzfNiahQOSh9eBevVj0arY3Sz+MSK8B9hzV84N
         9feGk/uIqcdbaxfVgXTupCZRkf5PiZQxBgehyWBs7KbXF9hjkV1+iTcOEuefEf+mtkKw
         HEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OBqyxtu8b4/GLR3vPjv3vdu97TmceaxE7WAVWz2wu/g=;
        b=ivtxTGUjCTDpM8jlLeup+iE0ww7KlllRHM4Y/94mkOeeF3mLuwiA8wUEc+SoWy1x/J
         zxPgnhbjw7n6EW2eC13Tv7fl/OwKmTJpU05KtM1BF4YcusxWX/FLE0nXOktol0kRUnBh
         tI/ZXQPKOuwR7sGlHVcHg8a/Cpk6YFExlHDqs1OT8IYC8U00pqWcPIILDzEEEw1vwSwj
         GVdC1yPM6Lf+yRfZQGiNjn9EmWpUIApYLNrTKlVdlEkE/Vcvxjcjg74ihvFiKMQY8TX2
         X5NkaKzTDKtOt3DqVs9UroQ43MSTCjBvYRKPRGa9GpJKAoCfp+KSjLdFXWuFA5U+1w3k
         B/rQ==
X-Gm-Message-State: APjAAAX/IKiHI2yd1LvWHW+mxeDqXUt0A2TWRmZt5HkSxFCWVwQRvTIT
        xDpm6Tsq/ifKJOsUFxGVFd4=
X-Google-Smtp-Source: APXvYqzz96qan17dCTId7x+PUaFgWJLAFn9wc7s5edhPcj9NcocCrIiWbecRFR/S5gy1ZkrWkaBYZw==
X-Received: by 2002:a17:90a:24a1:: with SMTP id i30mr7225340pje.128.1568400330731;
        Fri, 13 Sep 2019 11:45:30 -0700 (PDT)
Received: from GVFSs-MBP.guest.corp.microsoft.com ([2001:4898:80e8:2:8e2:7a1d:3741:e8a7])
        by smtp.gmail.com with ESMTPSA id n66sm47883661pfn.90.2019.09.13.11.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2019 11:45:29 -0700 (PDT)
Subject: Re: [PATCH 1/1] multi-pack-index: add --no-progress Add --no-progress
 option to git multi-pack-index. The progress feature was added in 144d703
 ("multi-pack-index: report progress during 'verify'", 2018-09-13) but the
 ability to opt-out was overlooked.
To:     Junio C Hamano <gitster@pobox.com>,
        William Baker via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
References: <pull.337.git.gitgitgadget@gmail.com>
 <0821a8073a48067ecd9ce08226656fa04d803f6b.1568216234.git.gitgitgadget@gmail.com>
 <xmqqlfutfewv.fsf@gitster-ct.c.googlers.com>
From:   William Baker <williamtbakeremail@gmail.com>
Message-ID: <24c1a9aa-c83b-a984-8821-ecc51a4bc0e2@gmail.com>
Date:   Fri, 13 Sep 2019 11:45:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <xmqqlfutfewv.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Thanks for the review!

On 9/12/19 1:17 PM, Junio C Hamano wrote:

>> +'git multi-pack-index' [--object-dir=<dir>] <subcommand> [--[no-]progress]
> 
> I am wondering what the reasoning behind having this new one *after*
> the subcommand while the existing one *before* is.  Isn't the
> --[no-]progress option supported by all subcommands of the
> multi-pack-index command, just like the --object-dir=<dir> option
> is?
> 
> always show "global --options, subcommand, and then subcommand --options" order).

Thanks for calling this out.  I didn't have a specific reason for making this
option appear after the subcommand.  I tried looking at other commands as
examples and I missed that there's a specific ordering based on the type
of the option.  I will clean this up in the next patch. 

> I also see in the code that
> handles opts.batch_size that there is a workaround for this inverted
> code structure to make sure subcommands other than repack does not
> allow --batch-size option specified.

> we probably would want to correct the use
> of parse_options() API in the implementation of this command before
> adding any new option or subcommand.

To confirm I understand, is the recommendation that
cmd_multi_pack_index be updated to only parse "batch-size" for the repack
subcommand (i.e. use PARSE_OPT_STOP_AT_NON_OPTION to parse all of the common
options, and then only parse "batch-size" when the repack subcommand is running)?


>> @@ -47,14 +54,15 @@ int cmd_multi_pack_index(int argc, const char **argv,
>>  	trace2_cmd_mode(argv[0]);
>>  
>>  	if (!strcmp(argv[0], "repack"))
>> -		return midx_repack(the_repository, opts.object_dir, (size_t)opts.batch_size);
>> +		return midx_repack(the_repository, opts.object_dir, 
>> +			(size_t)opts.batch_size, flags);
>>  	if (opts.batch_size)
>>  		die(_("--batch-size option is only for 'repack' subcommand"));
>>  
>>  	if (!strcmp(argv[0], "write"))
>>  		return write_midx_file(opts.object_dir);
>>  	if (!strcmp(argv[0], "verify"))
>> -		return verify_midx_file(the_repository, opts.object_dir);
>> +		return verify_midx_file(the_repository, opts.object_dir, flags);
>>  	if (!strcmp(argv[0], "expire"))
>>  		return expire_midx_packs(the_repository, opts.object_dir);
> 

> We can see that the new option only affects "verify", even though
> the SYNOPSIS and usage text pretends that everybody understands and
> reacts to it.  Shouldn't it be documented just like how --batch-size
> is documented that it is understood only by "repack"?
> 
> If the mid-term aspiration of this patch is to later enhance other
> subcommands to also understand the progress output or verbosity
> option (and if the excuse given as a response to the above analysis
> is "this is just a first step, more will come later")

Yep this was my thinking.  Today "repack" and "verify" are the only subcommands
that have any progress output but as the other subcommands learn how to provide
progress the [--[no-]progress] option can be used to control it. 

> instead of adding a "unsigned flag" local variable to the function, it would
> probably make much more sense to
> 
>  (1) make struct opts_multi_pack_index as a part of the public API
>      between cmd_multi_pack_index() and midx.c and document it in
>      midx.h;
> 
>  (2) instead of passing opts.object_dir to existing command
>      implementations, pass &opts, the pointer to the whole
>      structure;
> 
>  (3) add a new field "unsigned progress" to the structure, and teach
>      the command line parser to flip it upon seeing "--[no-]progress".
> 

Thanks for this suggestion I'll use this approach in the next patch.

One small point to clarify, in the current struct I'm using an int for 
"progress" because OPT_BOOL expects an int*.  Do you have any concerns with
keeping "progress" as an int in the public struct, or would you rather 
cmd_multi_pack_index parse an int internally and use it to populate the
public struct?

Thanks!
William
