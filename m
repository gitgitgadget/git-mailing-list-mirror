Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9850C20288
	for <e@80x24.org>; Fri, 21 Jul 2017 16:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752817AbdGUQ1H (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 12:27:07 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35213 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751996AbdGUQ1G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 12:27:06 -0400
Received: by mail-qk0-f194.google.com with SMTP id f67so657268qkc.2
        for <git@vger.kernel.org>; Fri, 21 Jul 2017 09:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y5nTYwof6gFD8DxpFT2+HpISeUT23EY0qbq4tXW3xJM=;
        b=aJy01yPqjayf4viq5cvfgkx+X1QRtFia/QgSAIKBpgI36S13Df78fy6fFBNp6GJWVw
         IFOIb4TOiksvb8IDUhMGpoW74q+9Mx8/wclyNaGXE5AxTk+ExM6Tm1UI6K56aU43SjaN
         S/W57XJM9tJv/aT5a0EGSFzvLEg/ACQMy8m+z8u/a+38N56CtCEmDzw+8hnbN7s+wkdh
         0XM3kBhISEoh9y5LmsTbVIffUmrmox+YOsx4anxoOon+kUdZQ6dlqG8KXUoy36GWzQ3s
         ea95YBGZ0vWkDBJa8QSKN0dOjt5e9wu9lRokqQIRqbEBUbOwhGb0KW5qp6GTcnk8ufmr
         UjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y5nTYwof6gFD8DxpFT2+HpISeUT23EY0qbq4tXW3xJM=;
        b=f6qSEmDl4jzNNVXWDo2x7MhdjjrAS/C6RZLaeZziGa1Il0eMHu+dIUQT+MWFJu8d6f
         dOZWj9f43HkQox7tvBJVAHvGMuqezijX1EFqBfdukn1pztlLdyGxLUFbcMHNtP0LxMtf
         YIxWFrEy1TQYW/bHTOaJsCNbe1qNg1+R8SIqNBhGpzTah1f7i88+jbGSqk6BWeGTq3XX
         JK3uLXsNFtCVs14xXH5K3gNg+0x2LR2H/xtdb5kYg08rK3IyLCHKvrzYjAVWdKfOxvaZ
         GRSteLL/3zVzAsx0lHwCJh5zeQXHl/SXvTzzuVb0+ncTVjqQbTN/FufPIM65ATHPZ2Nd
         Qqng==
X-Gm-Message-State: AIVw1111KFrCJ3VKWOEbYUKqLEpgc0hJznjOfcjJsvkV+pjJ2Ue1T+JT
        TdWDMBWBLTLxrQ==
X-Received: by 10.55.79.151 with SMTP id d145mr9495020qkb.37.1500654425952;
        Fri, 21 Jul 2017 09:27:05 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id w24sm3805104qtc.49.2017.07.21.09.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jul 2017 09:27:04 -0700 (PDT)
Subject: Re: [RFC PATCH v2 4/4] sha1_file: support promised object hook
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Philip Oakley <philipoakley@iee.org>
References: <cover.1499800530.git.jonathantanmy@google.com>
 <cover.1500508695.git.jonathantanmy@google.com>
 <a7fa848672281e29bff01f8caf2abe9f6ce5f4ba.1500508695.git.jonathantanmy@google.com>
 <CAGZ79ka6vcF4Douc7EizwL_+_xaorro=gVw=1hfJv56kvN+7oQ@mail.gmail.com>
 <75d5c3cd-c1d7-f06a-fc7e-894cde95afa7@gmail.com>
 <20170720141804.22cdd2bf@twelve2.svl.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <a3d1d0b9-5d28-e643-4964-6d087b7b0ec2@gmail.com>
Date:   Fri, 21 Jul 2017 12:27:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170720141804.22cdd2bf@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/20/2017 5:18 PM, Jonathan Tan wrote:
> On Thu, 20 Jul 2017 16:58:16 -0400
> Ben Peart <peartben@gmail.com> wrote:
> 
>>>> This is meant as a temporary measure to ensure that all Git commands
>>>> work in such a situation. Future patches will update some commands to
>>>> either tolerate promised objects (without invoking the hook) or be more
>>>> efficient in invoking the promised objects hook.
>>
>> I agree that making git more tolerant of promised objects if possible
>> and precomputing a list of promised objects required to complete a
>> particular command and downloading them with a single request are good
>> optimizations to add over time.
> 
> That's good to know!
> 
>> has_sha1_file also takes a hash "whether local or in an alternate object
>> database, and whether packed or loose" but never calls
>> sha1_object_info_extended.  As a result, we had to add support in
>> check_and_freshen to download missing objects to get proper behavior in
>> all cases.  I don't think this will work correctly without it.
> 
> Thanks for the attention to detail. Is this before or after commit
> e83e71c ("sha1_file: refactor has_sha1_file_with_flags", 2017-06-26)?
> 

Sorry, my bad.  I missed the comment in the cover letter that said this 
needed to be applied on top of your other patch series.
