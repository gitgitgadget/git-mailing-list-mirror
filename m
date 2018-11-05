Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B67D1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 20:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbeKFFkL (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 00:40:11 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46892 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeKFFkL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 00:40:11 -0500
Received: by mail-qt1-f196.google.com with SMTP id c16-v6so100592qtj.13
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 12:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fx4KPaAnGzWQOX2tfov+6/AhXknZC6dOSqTvKle5+VE=;
        b=VLBHdA9QyAzahkJdJ8AOsh9nOYs7fAd6P5UoyqO0c0SjT2bJnz/7YRuBGvqh1TBXrH
         c7SqornSqRtiHjQhnafyE+Jq11SMHy9sN/Jc1THxJFW/RCdMZI5ItdL1s0wkpRbEYAHE
         xUSm5unGKlbMfS+tj/Ztwu0qTUp5/1KT8HNFe/MBOd59zx2awqTK0n8G86rry8muuh/b
         zyfn1JprycHh7ThcK2C0Y5/VHgH360FEyrNGeWFvBDFunTBk8envBEnwWYfSXTOZrVMm
         19N2GB5Iq/1+wt95ttac1DiHqimXONd7lnFR5bYJfQ9rXc3Wc7HpSNe/gGimeqVk1muG
         b0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fx4KPaAnGzWQOX2tfov+6/AhXknZC6dOSqTvKle5+VE=;
        b=fC/pR2NFMdNsGk6KomWHBPkk4lCsAPEDf2fNvkLTYZKRA0nECeoW883pCkSxEewmzG
         IIODW2C+sQ3We9WkDRZSTS2uytjskVWybymIUb0+yJ37N0CvSJ2Glc1ULnE+ogHcoj3T
         yhJjPiJ7vFDVBgfW8O9MXIW4TGE0ypO64Zwbdv5VKkfYV/hZIc5aA7+DD5Ad+4umFKu9
         GG5/ki/12U7e8DlRPUPVTaxfEw3BBrcv18rlEmq81ixubuudQWjzPxpVGuaIHRZkfwuJ
         bCS978BuyRhTYxpYZKoKn43VgThroUxoERwBPKmtaW3QETnXvGe237FdjhB4Adv3iDbX
         bWxA==
X-Gm-Message-State: AGRZ1gK/Dh/1jtnW6tyrfkOofOwRmWZwBjMNvluRgq6kdXPAxKGdeihf
        eVhDtq6YsYllNyR5YEZb34M=
X-Google-Smtp-Source: AJdET5cZ+p3SgEU9uqqHnJVw3mxVii/iSXu+cZOB0JiQtrdkxJdpPx8hICbaUrkUBrM9jSCqpCAq7Q==
X-Received: by 2002:a0c:e34f:: with SMTP id a15mr22930728qvm.147.1541449127879;
        Mon, 05 Nov 2018 12:18:47 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id k38sm18192921qkh.72.2018.11.05.12.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 12:18:47 -0800 (PST)
Subject: Re: [RFC v1] Add virtual file system settings and hook proc
To:     Duy Nguyen <pclouds@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
References: <20181030191608.18716-1-peartben@gmail.com>
 <CACsJy8DbiVZYmY11Nt4c_+egSi5tz0iVq7rNv2BiVdyJ4htgvw@mail.gmail.com>
 <1f7efd07-4881-daa7-cd1d-145bbf3ffcc8@gmail.com>
 <CACsJy8BqWu0YG_Q8EFNeDgrRhYCCKBU+zPJjrhAWFU_gTDCoXg@mail.gmail.com>
 <20181104210105.GK731755@genre.crustytoothpaste.net>
 <CACsJy8BHp_m3M8FjzyXuquPq65UiXTxi2goUzP2GECYzXq7T6Q@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <79a5103e-1546-f670-13bd-7010ff8571c7@gmail.com>
Date:   Mon, 5 Nov 2018 15:18:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8BHp_m3M8FjzyXuquPq65UiXTxi2goUzP2GECYzXq7T6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/5/2018 10:22 AM, Duy Nguyen wrote:
> On Sun, Nov 4, 2018 at 10:01 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>>
>> On Sun, Nov 04, 2018 at 07:34:01AM +0100, Duy Nguyen wrote:
>>> On Wed, Oct 31, 2018 at 9:53 PM Ben Peart <peartben@gmail.com> wrote:
>>>> It's more than a dynamic sparse-checkout because the same list is also
>>>> used to exclude any file/folder not listed.  That means any file not
>>>> listed won't ever be updated by git (like in 'checkout' for example) so
>>>> 'stale' files could be left in the working directory.  It also means git
>>>> won't find new/untracked files unless they are specifically added to the
>>>> list.
>>>
>>> OK. I'm not at all interested in carrying maintenance burden for some
>>> software behind closed doors. I could see values in having a more
>>> flexible sparse checkout but this now seems like very tightly designed
>>> for GVFS. So unless there's another use case (preferably open source)
>>> for this, I don't think this should be added in git.git.
>>
>> I should point out that VFS for Git is an open-source project and will
>> likely have larger use than just at Microsoft.  There are both Windows
>> and Mac clients and there are plans for a Linux client as well.
>> Ideally, it would work with an unmodified upstream Git, which is (I
>> assume) why Ben is sending this series.
> 
> Ah I didn't know that. Thank you. I'll have to look at this GVFS some time then.
> 
> If we're going to support GVFS though, I think there should be a big
> (RFC perhaps) series that includes everything to at least give an
> overview what the end game looks like. Then it could be split up into
> smaller series.
> 

We've always had the goal of not needing a fork at all and are 
continually working to bring the list of differences to zero but in the 
mean time, you can see the entire set of changes we've made here [1].

If you look, most of them are changes we are already in process of 
submitting to git (ie midx, tracing, etc) or patches we fast tracked 
from master to our branch (your unpack_trees() optimizations for example).

Most of the others are small tweaks and features for performance or to 
smooth integration issues.  This RFC contains the core changes that were 
required to enable VFS for Git.

[1] 
https://github.com/git-for-windows/git/compare/master...Microsoft:gvfs-2.19.1
