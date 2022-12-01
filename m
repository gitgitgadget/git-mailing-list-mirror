Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060B0C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 08:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLAIca (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 03:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiLAIc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 03:32:28 -0500
X-Greylist: delayed 50499 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Dec 2022 00:32:27 PST
Received: from srv1.79p.de (srv1.79p.de [213.239.234.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7796385
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 00:32:27 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPV6:2001:9e8:2bda:ce00:f124:c58c:ef9e:29c4] (unknown [IPv6:2001:9e8:2bda:ce00:f124:c58c:ef9e:29c4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: sven@cs-ware.de)
        by srv1.79p.de (Postfix) with ESMTPSA id 354B9600098;
        Thu,  1 Dec 2022 09:32:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
        s=mail2022; t=1669883542;
        bh=JBbz+VQ1U5yIWGhgy4bc0dMe2SnsfQwgq1HAQ2vFAfM=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=WQXBOBdmPwQfTkB2A7BBrCmQYJfKU0jX0umw8cgBO7Y5S5m3v8SADA/Bk93iSrFcN
         Cq/RjNJGJUFIWZnRwtDK0PvOqM+bUw6of043WuiFAqNI8k5gee6nQZEsn2fePN4wEA
         pmPo71M3KnohiFD6U889sCyzMt4mmOSq0GWEOWbB3LUMpz2MkyiXTVe85jibfLJZUH
         ecOmW1DjdlbkqDiInzAl5bOgXZTju8MVnH61O5KfdGFGcKuogFaFaRwZwShXrKvfPf
         7pBVOjgLiTwVGElK88ZfgEfDjwXS9qloeoRlChbyvLRMUUWztzPKLneV2t7XR/LRir
         ofa8P5/b3FNTQ==
Message-ID: <80d5eb7c-c668-d325-2aaa-cbee742d1f15@cs-ware.de>
Date:   Thu, 1 Dec 2022 09:32:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Sven Strickroth <email@cs-ware.de>
Subject: Re: [PATCH] Don't pass -v to submodule command
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
References: <FR3P281MB21416B718C4C052A28C319B1E90F9@FR3P281MB2141.DEUP281.PROD.OUTLOOK.COM>
 <1ff185c5-4a9e-36e3-3141-8b149c1c7bb0@cs-ware.de>
 <cad05012-7bf9-5975-3add-253b11c7bcc8@cs-ware.de>
 <221130.868rjsi6bn.gmgdl@evledraar.gmail.com>
In-Reply-To: <221130.868rjsi6bn.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.11.2022 um 20:17 schrieb Ævar Arnfjörð Bjarmason:
>> --- a/builtin/pull.c
>> +++ b/builtin/pull.c
>> @@ -256,7 +256,7 @@ static struct option pull_options[] = {
>>   /**
>>    * Pushes "-q" or "-v" switches into arr to match the opt_verbosity level.
>>    */
>> -static void argv_push_verbosity(struct strvec *arr)
>> +static void argv_push_verbosity(struct strvec *arr, int include_v)
>>   {
>>   	int verbosity;
>>
> 
> It looks like you're getting somewhere with this, but you never use this
> "include_v", so the bug is still there. We just have the scaffolding
> now.
> 
> Did you forget to add that part to this commit?

Opps, seems so.

> In any case, that serves as a comment on the other thing this patch
> really needs: tests, please add some.

I don't know how to add tests and don't have a fully fledged build 
environment for git here.

-- 
Best regards,
   Sven Strickroth
   PGP key id F5A9D4C4 @ any key-server

