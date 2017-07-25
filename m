Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 479D01F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 15:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752252AbdGYPKh (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 11:10:37 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36194 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbdGYPKg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 11:10:36 -0400
Received: by mail-qk0-f195.google.com with SMTP id d136so12902962qkg.3
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xKSEaQnNYJ/VBkFvzbMTQzVrIYFnKvFdA2NmTz92bvY=;
        b=LFCmCSiS33R7JZgT9/IK4WccBvCE8bJFIXMgGuHPFPe5ub4GMVq9rX0YJyL7IKokue
         qlrpmLaFejMQAPGCcS8Syx1XLbcvcWWF7b91L2iBwQu/pA9EiWGXgomx230554D5a2E5
         uYUcyO5RgOE6MStRK11grvXKPk1zox6vZzZ7KY6L7fyLuXqiL53f6AebdMV+CeU6FqKo
         HfmVRJIWbRWXdTbWjQHRZPaM2/vHe8qChCDq2L+HIVNbADswSVXPK/jSRfxoO6nejdTN
         DPgu8MKoiAoU7CAm2whUfEBpk+AwvQJtord1ngEY5U7zAGe+wKqOjvTzejX03ZuQr4RK
         afog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xKSEaQnNYJ/VBkFvzbMTQzVrIYFnKvFdA2NmTz92bvY=;
        b=LuMlNv/12PQCpKPoI7GV6zQMmUBuncKSEjVXgNMzx+k7zl9YaIVsAVaKqYfSiOeW04
         5nAQoSqV9r0doXbHiFF/J7urjOljqCr2JzvcAfg7ebsJdicVC2fti/9rOccPmbLU/8sw
         Cs8MhFM+RpKGfehF4kfdBhz0j7gNAK53kgWDN6b1D9JLE9WVXRUuJfDL5W507+/9UgQP
         8bNm7O/wmugSPmt1awFAwVV7hBOglbyGUcg3z+YS0IItC14/8tPuLf1ZFoC3EXIU1+95
         oWuE2Igk8LMJgyLdhSyCVtcaACGaBO2tyDn/u8ArdXb5OgbQse+W0GS9C6a55aQHmZ5U
         yuiA==
X-Gm-Message-State: AIVw110ivXAduB45/cD0A1JvF2LhLJKRxaDfK/j/D1ayqmOMTDDYwG+x
        es33RdMhdse98TpD5LM=
X-Received: by 10.55.99.14 with SMTP id x14mr25531469qkb.331.1500995435836;
        Tue, 25 Jul 2017 08:10:35 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id s2sm4667216qkl.84.2017.07.25.08.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jul 2017 08:10:34 -0700 (PDT)
Subject: Re: [RFC PATCH v2 2/4] promised-object, fsck: introduce promised
 objects
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com,
        git@jeffhostetler.com, philipoakley@iee.org
References: <cover.1500508695.git.jonathantanmy@google.com>
 <3420d9ae9ef86b78af1abe721891233e3f5865a2.1500508695.git.jonathantanmy@google.com>
 <d8beb406-6d03-d893-4f37-83a7bdd6b9ac@gmail.com>
 <20170720141342.6a89aace@twelve2.svl.corp.google.com>
 <d014682f-66a5-c3c1-cf66-ef4bb28de076@gmail.com>
 <20170721133308.422e736d@twelve2.svl.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <96e8a347-d6b5-e21e-4129-2957fc26db19@gmail.com>
Date:   Tue, 25 Jul 2017 11:10:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170721133308.422e736d@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/21/2017 4:33 PM, Jonathan Tan wrote:
> On Fri, 21 Jul 2017 12:24:52 -0400
> Ben Peart <peartben@gmail.com> wrote:
> 
>> Today we have 3.5 million objects * 30 bytes per entry = 105 MB of
>> promises. Given the average developer only hydrates 56K files (2 MB
>> promises) that is 103 MB to download that no one will ever need. We
>> would like to avoid that if possible as this would be a significant
>> regression in clone times from where we are today.
>>
>> I'm also concerned about the performance of merging in promises given we
>> have 100M objects today and growing so the number of promises over time
>> could get pretty large.
> 
> After some thought, maybe a hybrid solution is best, in which it is
> permissible but optional for some missing objects to have promises. In
> that case, it is more of a "size cache" (which stores the type as well)
> rather than a true promise. When fetching, the client can optionally
> request for the sizes and types of missing objects.
> 

In our GVFS solution today we do not download any size or object type 
information at clone as the number of objects and the resulting file 
would be too large.  Instead, we have a new sizes endpoint 
(https://github.com/Microsoft/GVFS/blob/master/Protocol.md) that enables 
us to retrieve object sizes "on demand" much like we are enabling for 
the actual object content.

This protocol could easily be extended to return both size and type so 
that it could be used to retrieve "promise" data for objects as they are 
needed. Having a way to "cache" that data locally so that both git and 
other code could share it would be great.

At a minimum, we should ensure the data stream passed back is the same 
whether at clone time or when hitting a "promises" end point. I think it 
would also be helpful to enable promises to be downloaded on demand much 
like we are doing for the object data itself.

> This is good for the large-blob case, in which we can always have size
> information of missing blobs, and we can subsequently add blob-size
> filtering (as a parameter) to "git log -S" and friends to avoid needing
> to resolve a missing object. And this is, as far as I can tell, also
> good for the many-blob case - just have an empty size cache all the
> time. (And in the future, use cases could come up that desire non-empty
> but non-comprehensive caches - for example, a directory lister working
> on a partial clone that only needs to cache the sizes of frequently
> accessed directories.)
> 
> Another option is to have a repo-wide option that toggles between
> mandatory entries in the "size cache" and prohibited entries. Switching
> to mandatory provides stricter fsck and negative lookups, but I think
> it's not worth it for both the developers and users of Git to have to
> know about these two modes.
> 
>>>> I think we should have a flag (off by default) that enables someone to
>>>> say that promised objects are optional. If the flag is set,
>>>> "is_promised_object" will return success and pass the OBJ_ANY type and a
>>>> size of -1.
>>>>
>>>> Nothing today is using the size and in the two places where the object
>>>> type is being checked for consistency (fsck_cache_tree and
>>>> fsck_handle_ref) the test can add a test for OBJ_ANY as well.
>>>>
>>>> This will enable very large numbers of objects to be omitted from the
>>>> clone without triggering a download of the corresponding number of
>>>> promised objects.
>>>
>>> Eventually I plan to use the size when implementing parameters for
>>> history-searching commands (e.g. "git log -S"), but it's true that
>>> that's in the future.
>>>
>>> Allowing promised objects to be optional would indeed solve the issue of
>>> downloading too many promises. It would make the code more complicated,
>>> but I'm not sure by how much.
>>>
>>> For example, in this fsck patch, the easiest way I could think of to
>>> have promised objects was to introduce a 3rd state, called "promised",
>>> of "struct object" - one in which the type is known, but we don't have
>>> access to the full "struct commit" or equivalent. And thus fsck could
>>> assume that if the "struct object" is "parsed" or "promised", the type
>>> is known. Having optional promised objects would require that we let
>>> this "promised" state have a type of OBJ_UNKNOWN (or something like
>>> that) - maybe that would be fine, but I haven't looked into this in
>>> detail.
>>>
>>
>> Caveats apply as I only did a quick look but I only found the two
>> locations that were checking the object type for consistency.
> 
> I haven't looked into detail, but you are probably right.
> 
