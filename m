Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90E8B1F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 13:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbfJINVv (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 09:21:51 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33612 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731138AbfJINVv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 09:21:51 -0400
Received: by mail-qk1-f196.google.com with SMTP id x134so2201396qkb.0
        for <git@vger.kernel.org>; Wed, 09 Oct 2019 06:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=48WmsWYoV0vn33M2JKtW0/ZbKvjHHEjQ5FpkrPKUJj4=;
        b=r7JdsmwnHM6n3gshZ6n0vMZFprf8YSWNO9jZxOpKLIjws+6XO1mh1nLccXQLutqYi4
         sa/oRXuczCMWOmIKdYWPBT3HY/z23yiHsTfYBSPE1ZCCGDLHB3h7+Y+9oHipbEKSVmld
         CwX/SlJPWwA1BlryucU7XgYFvz4dAIVVIvkqzjcvUCHR+Y46obMov0IzT8+PVqbmyupq
         ozrmi5PptEQScDtcNp49TubJC4NoWBgQ2pOJk+WzXagiK8hCFs+7GIX6vLCfGEVLdq5l
         KBS85F6Hqpbqir9j4HAv2Wbq61vN+3MEDjEyxWFTodnf6u9jKid5pwf+Dg0ygLpKfvM4
         8Isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=48WmsWYoV0vn33M2JKtW0/ZbKvjHHEjQ5FpkrPKUJj4=;
        b=EHWv0+e1qy16bc7x79dd3C212Sy4yxks2ggQR21LyFsBoBzBxb2IZJwb7+1hG1JvRu
         YxNVGG4zsj9qrokALpKgoZnmV6CK7F4Q1Pic2WWQ9Fk3rI03k6zU4A727TMhHWxskS3Q
         vJLKkDQLz2MDR+Kbo9J6ptFzL1FdP/wmfStMrDPfCcSEstNG/3gsJuVJKbCYabUZdwiM
         qcqdcC6EDd6tI3VOi+4YWdRQ4+FoLu3/K7n9bXOcG0gQp272uwAl627piHpXKaNMX2hP
         6uGC1iSTi75lvacICu/bnufzN1Z+3G0JNkSRKQJ7InSQp/4EdKlyiZ0TB373Gk4zYMXq
         Egng==
X-Gm-Message-State: APjAAAXOuLvF/7PLOUqgRGgrwd9eRplaogCVaaqo/5Ju93b7SUdw57Cx
        acuIiMSKhpXCoH8cuYgGOIYgW9aNoas=
X-Google-Smtp-Source: APXvYqy96nq3q5B1APufPNqTgB1cQuaeopFm+01I38d9ZyAwwpMKRbG8mjQh76CSsyzueaxJ1YSZrA==
X-Received: by 2002:a05:620a:4f6:: with SMTP id b22mr3550149qkh.65.1570627309839;
        Wed, 09 Oct 2019 06:21:49 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4529:c1e2:44b7:b11c? ([2001:4898:a800:1012:f65c:c1e2:44b7:b11c])
        by smtp.gmail.com with ESMTPSA id v23sm1128610qto.89.2019.10.09.06.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 06:21:49 -0700 (PDT)
Subject: Re: How to find the commit that erase a change
To:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>,
        junio c hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, cuifang@sugon.com
References: <5e12e2d8.1ed16.16dae58d6ac.Coremail.wuzhouhui14@mails.ucas.ac.cn>
 <xmqqmuealiy3.fsf@gitster-ct.c.googlers.com>
 <6cfb13f7.1fa14.16daea502c2.Coremail.wuzhouhui14@mails.ucas.ac.cn>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <67016186-a9ff-be2b-883d-bc93af48aad8@gmail.com>
Date:   Wed, 9 Oct 2019 09:21:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <6cfb13f7.1fa14.16daea502c2.Coremail.wuzhouhui14@mails.ucas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/2019 11:51 PM, wuzhouhui wrote:
>> -----Original Messages-----
>> From: "Junio C Hamano" <gitster@pobox.com>
>> Sent Time: 2019-10-09 11:02:44 (Wednesday)
>> To: wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
>> Cc: git@vger.kernel.org, cuifang@sugon.com
>> Subject: Re: How to find the commit that erase a change
>>
>> wuzhouhui <wuzhouhui14@mails.ucas.ac.cn> writes:
>>
>>> I have a file which contains complicated change history. When I use
>>>     git log -p file
>>> to see all changes made in this file, I found that a change disappeared
>>> for no reason.
>>
>> "git log [-p] <pathspec>" is not about seeing *all* changes made to
>> the path(s) that match the pathspec.  Especially when your history
>> has merges, the command is to give you _one_ simplest explanation as
>> to how the contents of the path(s) came to be in the shape you see
>> in HEAD.
>>
>> So for example, if you have a history like this (time flows from
>> left to right):
>>
>>     O-----A-----B----M-----N
>>            \        /
>>             \      /
>>              X----Y
>>
>> where A or B did *not* touch "file", X added a definition of func()
>> to "file", Y reverted the change X made to "file", M made a natural
>> merge between B and Y and N did not touch "file", "git log N file"
>> would not even show the existence of commits X or Y.  In the larger
>> picture, at ancient time O, the file started without func(), and
>> none of the commits A, B, M or N felt the need to add it and as the
>> result, N does not need the unwanted func().  So "file's contents
>> are the same since O throughout the history reaching N" is given as
>> _one_ simplest explanation.
>>
>> The "--full-history" option may help, though.
> 
> "--full-history" doesn't resolve my problem, but
>     git log -p -c file
> does. I found that my change was erased in a merge commit.

In these cases of erased merge commits, I find that

	git log --simplify-merges -- file

works best for finding the merge responsible. Just the
--full-history option may include many extra merges (if you
work in a repo with many collaborators).

Thanks,
-Stolee
