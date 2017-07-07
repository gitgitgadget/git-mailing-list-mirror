Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DA1E2035B
	for <e@80x24.org>; Fri,  7 Jul 2017 18:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751032AbdGGSO0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 14:14:26 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33277 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdGGSOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 14:14:25 -0400
Received: by mail-qt0-f196.google.com with SMTP id c20so5209991qte.0
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 11:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RdK25KQZqsUXMZZpzLz8oQ7WxKVKqp8Axu+Hd4/2aGU=;
        b=hP86Ccg19SbWXT7WTCrVIZLC1m8bSN7fFaP1fNTVoMLLRGMzxrynrJW9Z0c1dCAq28
         O/XWcB1XxWmlOUGZHsgfB7UwJ+hcHjeoDbKgO1BaG+3dX5eSJUyivI8KKGPPVh+3zFPg
         AS+uXyoib3bLLtV/8ky50cJ6M4sDmHgrSI5pG5o2t4Eg6ynePuaXQjK8/5CRiUE+Akl8
         lNJtK6eJahDKo8XsEJHbh3Rb/lhLQ/IJFiqaBraYLrMsK8YDWNoslPYF1cV3GRnUsry+
         XPSDVtTfaBzFwPJ9Kwpesd9168PuMj0Sb/GZikrt5/t8iFHRD9wmXcmrzu5Ww416poYz
         cbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RdK25KQZqsUXMZZpzLz8oQ7WxKVKqp8Axu+Hd4/2aGU=;
        b=L2dR71W+xUO8DhbmXybZ6VHAJz4SuN348K3GKUMmhEsCdpUYdPObaiAbKf1F+xdRgu
         drTelRCyzz6e2aLWi31ddf77ucln9SMwrcxwwsqJB9QU11vVRPdhiqk/bzdoFnoy3Srz
         M686Ka0h2q2xReuNJMT8sNBfThlbYGRB/fDb4tPPqFlvFSBEHj+Sgw6IcOERSouzCAJW
         nvGbGWfBgDwe0DiJHkTF2PB6S2zKZRXPF7+CBD1byDrtgYZ7zbDw4TEnoXMP9cx89Hp+
         CB/p/fjz+5pc4rr4bdQubZo6tSQ0e1m7b20Hctubs5/vHMzBVJHoPVG6uTj/3r3hqtsE
         MnSA==
X-Gm-Message-State: AIVw110zw/eULpip3RGq1G5+72qwxx/C2Ujm7nVATAmsGVkU3aJ5naDI
        uNCox3yOMvEtVw==
X-Received: by 10.237.46.166 with SMTP id k35mr9467833qtd.21.1499451264273;
        Fri, 07 Jul 2017 11:14:24 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id i8sm3011029qtb.40.2017.07.07.11.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jul 2017 11:14:22 -0700 (PDT)
Subject: Re: [PATCH v5 7/7] fsmonitor: add a performance test
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170610134026.104552-8-benpeart@microsoft.com>
 <xmqqo9tsn9qg.fsf@gitster.mtv.corp.google.com>
 <9c1ed8d4-6bdb-e709-758d-4b010525e9e3@gmail.com>
 <xmqqvany2z84.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <7ec36d90-7fbc-c30f-e15e-f06d39e1f206@gmail.com>
Date:   Fri, 7 Jul 2017 14:14:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqvany2z84.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/14/2017 2:36 PM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
> 
>>> Having said all that, I think you are using this ONLY on windows;
>>> perhaps it is better to drop #ifdef GIT_WINDOWS_NATIVE from all of
>>> the above and arrange Makefile to build test-drop-cache only on that
>>> platform, or something?
>>
>> I didn't find any other examples of Windows only tools.  I'll update
>> the #ifdef to properly dump the file system cache on Linux as well and
>> only error out on other platforms.
> 
> If this will become Windows-only, then I have no problem with
> platform specfic typedef ;-) I have no problem with CamelCase,
> either, as that follows the local convention on the platform
> (similar to those in compat/* that are only for Windows).
> 
> Having said all that.
> 
> Another approach is to build this helper on all platforms, with
> sections protected by "#ifdef LINUX", "#ifdef WINDOWS", etc.  That
> way, the platform detection and switching between running this
> program and echoing something into /proc filesystem performed in
> p7519 can be removed (this test-helper program will be responsible
> to implement that logic instead).  When p7519 wants to drop the
> filesystem cache, regardless of the platform, it can call this
> test-helper without having to know how the filesystem cache is
> dropped.
> 

I'll take a cut at doing this but it is obviously very platform 
dependent and I'm unfamiliar with platforms other than Windows.

For everything other than Windows, my implementation will be calling 
"system" for external utilities based on what I can find on the web. 
Oh, and I have no way to test it other than on Windows so could use some 
review/testing from others. :)

> I do not have strong preference either way, but I have a slight
> suspicion that the "another approach" above may give us a better
> result.  For one thing, the test-helper can be reused in new perf
> scripts people will write in the future.
> 
> Thanks.
> 
