Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B871FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 17:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754368AbdBIRlW (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 12:41:22 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42494 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754360AbdBIRlV (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2017 12:41:21 -0500
X-AuditID: 12074414-78bff70000004a85-ff-589ca9914163
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id F9.F2.19077.199AC985; Thu,  9 Feb 2017 12:40:35 -0500 (EST)
Received: from [192.168.69.190] (p4FEDF6A1.dip0.t-ipconnect.de [79.237.246.161])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v19HeUdv004272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 9 Feb 2017 12:40:31 -0500
Subject: Re: [PATCH 1/5] refs: store submodule ref stores in a hashmap
To:     Stefan Beller <sbeller@google.com>
References: <cover.1486629195.git.mhagger@alum.mit.edu>
 <a944446c4c374125082f5ad8b79e731704b66196.1486629195.git.mhagger@alum.mit.edu>
 <CAGZ79kau2bYs7zegEiacAdbhn1LyOfAH9__rePfbQkX2iLgmMQ@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <4a21dba7-76ef-6aec-b326-c1046f3daad2@alum.mit.edu>
Date:   Thu, 9 Feb 2017 18:40:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kau2bYs7zegEiacAdbhn1LyOfAH9__rePfbQkX2iLgmMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42IRYndR1J28ck6EwfyDwhZdV7qZLBp6rzBb
        9C/vYrNY8vA1s0X3lLeMFps3t7M4sHnsnHWX3ePDxziPBZtKPbraj7B5XLyk7PF5k1wAWxSX
        TUpqTmZZapG+XQJXxv99PSwFP7gqTs3ex97A+JGji5GTQ0LAROLmu63MXYxcHEIClxklVq05
        wwLhnGeS+P52IStIlbCAm8TNsxuYQWwRATWJmatms0EVMUocXfsRrINZYCqTxPwlM1lAqtgE
        dCUW9TQzgdi8AvYS53ffAIuzCKhILJt+iA3EFhUIkZiz8AEjRI2gxMmZT8BqOAUCJTY23gDb
        zCygLvFn3iVmCFteYvvbOcwTGPlnIWmZhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/Py
        Uot0LfRyM0v0UlNKNzFCwltkB+ORk3KHGAU4GJV4eCdUzYkQYk0sK67MPcQoycGkJMorWwAU
        4kvKT6nMSCzOiC8qzUktPsQowcGsJMJ7bzFQjjclsbIqtSgfJiXNwaIkzvttsbqfkEB6Yklq
        dmpqQWoRTFaGg0NJgtdkBVCjYFFqempFWmZOCUKaiYMTZDgP0HAnkBre4oLE3OLMdIj8KUZF
        KXHe3uVACQGQREZpHlwvLP28YhQHekWYNx2knQeYuuC6XwENZgIafP30LJDBJYkIKakGRrmn
        UQorb9/7829L8xoe+yT2iE9eHCyxSluutqVmPwqf8p+by6zQ4XKX/xxRzg9KuT38Tny6T5dW
        TJpel3BjnU9cGMezdKWjmz/1FMakHdqpb1fz6/O5RCXOfF31jer339o8tg9neHFTaaLR5e7d
        IWlrZJ59N8lgaDy6a8eN2iX/Z7dlv95rosRSnJFoqMVcVJwIADtEVQoaAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/09/2017 05:58 PM, Stefan Beller wrote:
>> @@ -1402,17 +1435,17 @@ struct ref_store *ref_store_init(const char *submodule)
>>
>>  struct ref_store *lookup_ref_store(const char *submodule)
>>  {
> 
>> +       if (!submodule_ref_stores.tablesize)
>> +               hashmap_init(&submodule_ref_stores, submodule_hash_cmp, 20);
> 
> 
> So we can lookup a submodule even before we initialized the subsystem?
> Does that actually happen? (It sounds like a bug to me.)
>
> Instead of initializing, you could return NULL directly here.

The lines you quoted are only concerned with bringing the (empty)
hashmap into existence if it hasn't been initialized already. (There's
no HASHMAP_INIT.) I don't know what you mean by "initialize the
subsystem". The only way to bring a ref_store *object* into existence is
currently to call get_ref_store(submodule), which calls
lookup_ref_store(submodule) to see if it already exists, and if not
calls ref_store_init(submodule) to instantiate it and register it in the
hashmap. There's nothing else that has to be initialize before that
(except maybe the usual startup config reading etc.)

I suppose this code path could be changed to return NULL without
initializing the hashmap, but the hashmap will be initialized a moment
later by ref_store_init(), so I don't see much difference either way.

Thanks for your review!
Michael

