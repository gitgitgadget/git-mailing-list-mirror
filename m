Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10C5420288
	for <e@80x24.org>; Fri, 21 Jul 2017 16:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbdGUQY6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 12:24:58 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33639 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752811AbdGUQY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 12:24:57 -0400
Received: by mail-qk0-f195.google.com with SMTP id d145so2007978qkc.0
        for <git@vger.kernel.org>; Fri, 21 Jul 2017 09:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8FYn7s2Z0BacXZJrji/6BOjsYQ/LMGvMKpKJ4XqGqhk=;
        b=No3vi3NHwRQpjQMUz7Ua62Mb6wTMVdztdDi5ILNdx77P1oAB/d+uNzFV6+FecIMH5E
         kqLo6bF5dmxOpdB7XNEg5EFCikirecfKl0ccBFoceBcsTz/JxqidEW0nHPVVisBju3IB
         D0yvVdyBaLXBPSVnVXLNLFK5gD4ng5QkZ5rMIPT62XnrvOxFyrRZe4XeX8CnQ18/9Vrs
         gQjgsIaY3Xp054bijZtvXAt+gDWWfZkUC5xfnxdvuTnSmCnQdofzaQLbVOySP4f9CJVi
         tjhZlkW829EFqB8iETU9CdmDLZ6awdG678haSfLUxQOgP23KVNuVo9ZmyhopOthf7blo
         eKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8FYn7s2Z0BacXZJrji/6BOjsYQ/LMGvMKpKJ4XqGqhk=;
        b=PB9ifJ2EjhtZcVtMd9Ty5f1yKhTduTYrdREiYNF9mvSIhAbge7uTA7OC2YKwFDSiFa
         H7g20fkhVhLS/Efp+KyZhTWkjeHTEAzgVszMA/ctrLmCtyRJYZUTo7W0Xj/OcaJ335L4
         kHUXMVy97UHpLG3UP9QpzwIWaheXISRgIPa8j/5GZIonV27aiUavsOy8zYgp4Diz6F0W
         oIta00y7sww4DrWvS0Ixc+NdBv0cbGPV5v2PEYW7O1fOUWl4/uqY2FvVa/N7MIzDhGvD
         VIPCIjLLfbOaFRktDPgPd6B+LvBCbu51puISvg8DAKuKviJflKuMJ4ybFho0+R4jRKC/
         bV+A==
X-Gm-Message-State: AIVw112yRUH+wjgkoyYc0LpfTk3wsAVmppwC8nZvgg/OQx6ynZuH6RCj
        FFcW9KLpZ2kUe6Rd6UM=
X-Received: by 10.55.27.97 with SMTP id b94mr10716688qkb.309.1500654296649;
        Fri, 21 Jul 2017 09:24:56 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id 43sm3721863qtn.91.2017.07.21.09.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jul 2017 09:24:55 -0700 (PDT)
Subject: Re: [RFC PATCH v2 2/4] promised-object, fsck: introduce promised
 objects
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com,
        git@jeffhostetler.com, philipoakley@iee.org
References: <cover.1500508695.git.jonathantanmy@google.com>
 <3420d9ae9ef86b78af1abe721891233e3f5865a2.1500508695.git.jonathantanmy@google.com>
 <d8beb406-6d03-d893-4f37-83a7bdd6b9ac@gmail.com>
 <20170720141342.6a89aace@twelve2.svl.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <d014682f-66a5-c3c1-cf66-ef4bb28de076@gmail.com>
Date:   Fri, 21 Jul 2017 12:24:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170720141342.6a89aace@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/20/2017 5:13 PM, Jonathan Tan wrote:
> On Thu, 20 Jul 2017 15:58:51 -0400
> Ben Peart <peartben@gmail.com> wrote:
> 
>> On 7/19/2017 8:21 PM, Jonathan Tan wrote:
>>> Currently, Git does not support repos with very large numbers of objects
>>> or repos that wish to minimize manipulation of certain blobs (for
>>> example, because they are very large) very well, even if the user
>>> operates mostly on part of the repo, because Git is designed on the
>>> assumption that every referenced object is available somewhere in the
>>> repo storage.
>>>
>>
>> Great to see this idea making progress. Making git able to gracefully
>> handle partial clones (beyond the existing shallow clone support) is a
>> key piece of dealing with very large objects and repos.
> 
> Thanks.
> 
>>> As a first step to reducing this problem, introduce the concept of
>>> promised objects. Each Git repo can contain a list of promised objects
>>> and their sizes (if blobs) at $GIT_DIR/objects/promised. This patch
>>> contains functions to query them; functions for creating and modifying
>>> that file will be introduced in later patches.
>>
>> If I'm reading this patch correctly, for a repo to successfully pass
>> "git fsck" either the object or a promise must exist for everything fsck
>> checks.  From the documentation for fsck it says "git fsck defaults to
>> using the index file, all SHA-1 references in refs namespace, and all
>> reflogs (unless --no-reflogs is given) as heads." Doesn't this then
>> imply objects or promises must exist for all objects referenced by any
>> of these locations?
>>
>> We're currently in the hundreds of millions of objects on some of our
>> repos so even downloading the promises for all the objects in the index
>> is unreasonable as it is gigabytes of data and growing.
> 
> For the index to contain all the files, the repo must already have
> downloaded all the trees for HEAD (at least). The trees collectively
> contain entries for all the relevant blobs. We need one promise for each
> blob, and the size of a promise is comparable to the size of a tree
> entry, so the size (of download and storage) needed would be just double
> of what we would need if we didn't need promises. This is still only
> linear growth, unless you have found that the absolute numbers are too
> large?
> 

Today we have 3.5 million objects * 30 bytes per entry = 105 MB of 
promises. Given the average developer only hydrates 56K files (2 MB 
promises) that is 103 MB to download that no one will ever need. We 
would like to avoid that if possible as this would be a significant 
regression in clone times from where we are today.

I'm also concerned about the performance of merging in promises given we 
have 100M objects today and growing so the number of promises over time 
could get pretty large.

> Also, if the index is ever changed to not have one entry for every file,
> we also wouldn't need one promise for every file.
> 
>> I think we should have a flag (off by default) that enables someone to
>> say that promised objects are optional. If the flag is set,
>> "is_promised_object" will return success and pass the OBJ_ANY type and a
>> size of -1.
>>
>> Nothing today is using the size and in the two places where the object
>> type is being checked for consistency (fsck_cache_tree and
>> fsck_handle_ref) the test can add a test for OBJ_ANY as well.
>>
>> This will enable very large numbers of objects to be omitted from the
>> clone without triggering a download of the corresponding number of
>> promised objects.
> 
> Eventually I plan to use the size when implementing parameters for
> history-searching commands (e.g. "git log -S"), but it's true that
> that's in the future.
> 
> Allowing promised objects to be optional would indeed solve the issue of
> downloading too many promises. It would make the code more complicated,
> but I'm not sure by how much.
> 
> For example, in this fsck patch, the easiest way I could think of to
> have promised objects was to introduce a 3rd state, called "promised",
> of "struct object" - one in which the type is known, but we don't have
> access to the full "struct commit" or equivalent. And thus fsck could
> assume that if the "struct object" is "parsed" or "promised", the type
> is known. Having optional promised objects would require that we let
> this "promised" state have a type of OBJ_UNKNOWN (or something like
> that) - maybe that would be fine, but I haven't looked into this in
> detail.
> 

Caveats apply as I only did a quick look but I only found the two 
locations that were checking the object type for consistency.

>>> A repository that is missing an object but has that object promised is not
>>> considered to be in error, so also teach fsck this. As part of doing
>>> this, object.{h,c} has been modified to generate "struct object" based
>>> on only the information available to promised objects, without requiring
>>> the object itself.
>>
>> In your work on this, did you investigate if there are other commands
>> (ie repack/gc) that will need to learn about promised objects? Have you
>> had a chance (or have plans) to hack up the test suite so that it runs
>> all tests with promised objects and see what (if anything) breaks?
> 
> In one of the subsequent patches, I tried to ensure that all
> object-reading functions in sha1_file.c somewhat works (albeit slowly)
> in the presence of promised objects - that would cover the functionality
> of the other commands. As for hacking up the test suite to run with
> promised objects, that would be ideal, but I haven't figured out how to
> do that yet.
> 
