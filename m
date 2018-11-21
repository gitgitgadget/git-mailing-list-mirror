Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 214351F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 11:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbeKUW3Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 17:29:25 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37786 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbeKUW3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 17:29:25 -0500
Received: by mail-yw1-f67.google.com with SMTP id h193so884187ywc.4
        for <git@vger.kernel.org>; Wed, 21 Nov 2018 03:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=q4jv1M3TMtzT7kFpUxlkZfFRPhPfiUEG70TQYF06NOE=;
        b=DdQ48tTsq3ZtYttln7V8ZI8HNsxwbnMJ2gz5nA7hDdBJpLYpWw7OXGWmHXugXnM8yW
         UuIKZNLxNklyvznIWJLpXBpWIHp8k1rjC/d7HMoj5q76ZMnHjdUG3Mxx17/9lOoruWPy
         NA8vHzYq7+hG6UrVrEwhwfZiImr1hxgdMIr8RExHulQTHKQLTP+vxGQrCzcPB2vTIhgr
         CD6CFSAzY8Fm+2obyrbL3kniVeyE44T9TkZc0ufCxanPyHfDOcUW7VO36vm8zjRDOcfT
         8KfSWWM+CDfTOX6R7sTIieWBvhHeuSBICUDHssFpeD05+gPu5otGVXIjhiM2AAiOXmFw
         WDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=q4jv1M3TMtzT7kFpUxlkZfFRPhPfiUEG70TQYF06NOE=;
        b=uSFtOhDAbjpOKsknF8OIWW96hjq+ZQnGDw3oMggCY/ht11bbf6OfKGBbX07peE347K
         Va4eg49I3at+LwGKyOUawHHKC5LJUOInLYG8iRdDexFbdNVFz5pFID9gHltW9bEtoXTj
         TiiXJNQadWwr1D3VSPuPnBkOFBolrpmmROXcGt9JIgXDHLz0B2X9i/bawJfFUu7eno4U
         z1h/wu2aSNCw8h6jeUo99gL/Yt9v4simoyPb+kXOeABsW7yvgp5IQ+XeZzdOrznqNImX
         Q9AnfzbomQdIq80GILDTLUSwrUuGPY9KvQPCtC1zdgxFx3jhnlVonzyGi6hszCBYvNqu
         0wnw==
X-Gm-Message-State: AGRZ1gK9ZrOMRYtJHA3EQq5GUO57dojuS94mMO0kUP8C7R8skAZNPERu
        wcsha1B6Nbv8S4AHMbguZRyAxoKS
X-Google-Smtp-Source: AJdET5ccYm3Bz3Lu+gpvBfJwTWCPMNDms8qJWcRPyVnHCd66usOxUGc6H3a7/zPKNVnx3H/BqLMs+Q==
X-Received: by 2002:a81:33d7:: with SMTP id z206mr5999009ywz.410.1542801318314;
        Wed, 21 Nov 2018 03:55:18 -0800 (PST)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id u4sm26171275ywu.92.2018.11.21.03.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 03:55:17 -0800 (PST)
Subject: Re: [PATCH v2 1/1] Use size_t instead of 'unsigned long' for data in
 memory
To:     tboegi@web.de, git@vger.kernel.org
References: <20181117151139.22994-1-tboegi@web.de>
 <20181120050456.16715-1-tboegi@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <17c472c4-34be-390d-947f-ff998398295c@gmail.com>
Date:   Wed, 21 Nov 2018 06:55:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181120050456.16715-1-tboegi@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20/2018 12:04 AM, tboegi@web.de wrote:
> From: Torsten Bögershausen <tboegi@web.de>
>
> Currently the length of data which is stored in memory is stored
> in "unsigned long" at many places in the code base.
> This is OK when both "unsigned long" and size_t are 32 bits,
> (and is OK when both are 64 bits).
> On a 64 bit Windows system am "unsigned long" is 32 bit, and
> that may be too short to measure the size of objects in memory,
> a size_t is the natural choice.

Is this change enough to store 4GB files on Windows? Or is there more to 
do?

> Thanks for all the comments on V1.
> Changes since V1:
> - Make the motivation somewhat clearer in the commit message
> - Rebase to the November 19 pu
>
> What we really need for this patch to fly are this branches:
> mk/use-size-t-in-zlib
> tb/print-size-t-with-uintmax-format

I believe communicating these direct dependencies is the correct way to 
go, and the rebase you mentioned is unnecessary (instead, test with a 
merge).

Hopefully the patch applies on top of a merge of those branches.

> @@ -529,7 +530,7 @@ static void *unpack_raw_entry(struct object_entry *obj,
>   }
>   
>   static void *unpack_data(struct object_entry *obj,
> -			 int (*consume)(const unsigned char *, unsigned long, void *),
> +			 int (*consume)(const unsigned char *, size_t, void *),
>   			 void *cb_data)

This is the only instance that is not paired directly with a variable 
name like "size", "sz", or "len". However, it appears to be correct from 
context.

Thanks for this!

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

