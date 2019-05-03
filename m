Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA3831F453
	for <e@80x24.org>; Fri,  3 May 2019 07:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfECHfS (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 03:35:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39782 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfECHfS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 03:35:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so5447114wmk.4
        for <git@vger.kernel.org>; Fri, 03 May 2019 00:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WZBysgEJfWZNkC+35DAYleN91pjrOB7xJAHEdbUCGs0=;
        b=AeGWi0G5DdUdRoh5reoWkqepYnaMgHygYyVDkDyWTxvUdihclaNqDlt1KcI7AK1Zao
         cCbcDM4kqpiYzGgg3HYWt9PYlE0cM7NiGs9TSwve+5Bhb1GCN/Y/6h/F3DWCfkgD9UJ3
         jjGoW+ke8IHBEa3IGm7GW08RHOKZwXt83/bu3na2tQnkrCDAlBfHuygxTiNaCV/hoONR
         pj/h89Ysin9FcHH/WApqPmDmAzLWmn3+7HJsirQshrYd6aQaMh6DzuBXXRRFbdOdNo1s
         aMSXMxAB8Ih6zmOjKJziqMcgeFKJ/cgWFlCq8RH8l63qWbRfQu5hXFJ/vBiEmAu5Zixy
         sgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WZBysgEJfWZNkC+35DAYleN91pjrOB7xJAHEdbUCGs0=;
        b=gNO6zVa3K9q3r0a5g/Uv0nW28oQAmQaH5j7nmNobdFSaxjWymhC2/VWfffWet8Nhu5
         8XKkKmNfBU1Hv17JD+5OwJfUFDqruIZKhx0KFEp8qbwv3pFg7VBxL5rhUBQNsn4HcoP7
         iDVz1hpu3h20sAhX3LuLwAaW0PdtQ5cUO21GUcCVRxheL3rzFTdKgki6HFBxczgKuGMG
         6JsooOu2A36stYmQOatwnXI1ffbRCu6QjAwzwQqmQK9/UXHbK94/dPvOx2Le6Q4u39JW
         uKtYVrPhG8KOzZA+2+lMm67HZjkQZBxruDf21MtXm3iEagqqgYUfNNlimzrtquUKuW1j
         dwVg==
X-Gm-Message-State: APjAAAVcZVqWdQivqH3oXzc5x7kp9xwEQhgiCfLc33xr+YnxlwmBPe2n
        GKp0HbZJbPZw3TUxd/NPuio=
X-Google-Smtp-Source: APXvYqwOS5mhJe4fhEVMtb2tBX2xoAke+LmmYxf6qJeunAGJtfd4hqPy0DYpvJG7kaF3lS2lzkfclw==
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr4980197wmb.77.1556868916344;
        Fri, 03 May 2019 00:35:16 -0700 (PDT)
Received: from ?IPv6:2001:a62:437:4001:fd44:6515:8790:2e05? ([2001:a62:437:4001:fd44:6515:8790:2e05])
        by smtp.googlemail.com with ESMTPSA id y70sm2405388wmc.8.2019.05.03.00.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 00:35:15 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] revisions.txt: mark optional rev arguments with []
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <18c8ed70602271a28c93df922eb3da8fb7563e2e.1555913472.git.liu.denton@gmail.com>
 <cover.1556367012.git.liu.denton@gmail.com>
 <90c787c219d25f38c1d53ae837160994a7bc6355.1556367012.git.liu.denton@gmail.com>
 <1684a040-ebc0-2567-225e-d26aa13951a2@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <91924cb1-f1c5-eeb5-21d8-dc6123a223b1@gmail.com>
Date:   Fri, 3 May 2019 09:35:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1684a040-ebc0-2567-225e-d26aa13951a2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.05.19 um 09:17 schrieb Andreas Heiduk:
> Am 27.04.19 um 14:16 schrieb Denton Liu:
>> In revisions.txt, an optional rev argument was not distinguised.
>> Instead, a user had to continue and read the description in order to
>> learn that the argument was optional.
>>
>> Since the [] notation for an optional argument is common-knowledge in
>> the Git documentation, mark optional arguments with [] so that it's more
>> obvious for the reader.
>>
>> Signed-off-by: Denton Liu <liu.denton@gmail.com>
>> ---
>>  Documentation/revisions.txt | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
>> index e5f11691b1..68cce2ca06 100644
>> --- a/Documentation/revisions.txt
>> +++ b/Documentation/revisions.txt
> 
> I think I found another one here:
> 
> @@ -65,7 +65,7 @@ some output processing may assume ref names in UTF-8.
>  '@'::
>    '@' alone is a shortcut for `HEAD`.
>  
> -'<refname>@{<date>}', e.g. 'master@\{yesterday\}', 'HEAD@{5 minutes ago}'::
> +'[<refname>]@{<date>}', e.g. 'master@\{yesterday\}', 'HEAD@{5 minutes ago}'::
>    A ref followed by the suffix '@' with a date specification
>    enclosed in a brace
>    pair (e.g. '\{yesterday\}', '{1 month 2 weeks 3 days 1 hour 1
> 
> The doesn't give a hint that <refname> is optional but actually it is.
> 
>> @@ -95,7 +95,7 @@ some output processing may assume ref names in UTF-8.
>>    The construct '@{-<n>}' means the <n>th branch/commit checked out
>>    before the current one.
>>  
>> -'<branchname>@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
>> +'[<branchname>]@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
>>    The suffix '@\{upstream\}' to a branchname (short form '<branchname>@\{u\}')
>>    refers to the branch that the branch specified by branchname is set to build on
>>    top of (configured with `branch.<name>.remote` and
>> @@ -103,7 +103,7 @@ some output processing may assume ref names in UTF-8.
>>    current one. These suffixes are also accepted when spelled in uppercase, and
>>    they mean the same thing no matter the case.
>>  
>> -'<branchname>@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
>> +'[<branchname>]@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
>>    The suffix '@\{push}' reports the branch "where we would push to" if
>>    `git push` were run while `branchname` was checked out (or the current
>>    `HEAD` if no branchname is specified). Since our push destination is
>> @@ -131,7 +131,7 @@ from one location and push to another. In a non-triangular workflow,
>>  This suffix is also accepted when spelled in uppercase, and means the same
>>  thing no matter the case.
>>  
>> -'<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
>> +'<rev>{caret}[<n>]', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
>>    A suffix '{caret}' to a revision parameter means the first parent of
>>    that commit object.  '{caret}<n>' means the <n>th parent (i.e.
>>    '<rev>{caret}'
> 

And another one I've found after hitting "Send" :-(

@@ -346,7 +346,7 @@ Revision Range Summary
   as giving commit '<rev>' and then all its parents prefixed with
   '{caret}' to exclude them (and their ancestors).
 
-'<rev>{caret}-<n>', e.g. 'HEAD{caret}-, HEAD{caret}-2'::
+'<rev>{caret}-[<n>]', e.g. 'HEAD{caret}-, HEAD{caret}-2'::
 	Equivalent to '<rev>{caret}<n>..<rev>', with '<n>' = 1 if not
 	given.
