Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E4AD1F89D
	for <e@80x24.org>; Fri, 28 Jul 2017 13:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbdG1NUW (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 09:20:22 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33933 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbdG1NUV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 09:20:21 -0400
Received: by mail-qt0-f195.google.com with SMTP id i19so12590197qte.1
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 06:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=USnLVa2T8uFZRAOclR/XwP0TkvUVzviOCnafMs1/m5c=;
        b=Q2gKvhCfO8xAXdy0uq0FymD0eSFS75wrFnP/D5v0ME9P3Gs9DiQrCocfMvqB5sywRa
         N3kDf0VT/tdA4XYi9V2kxrnknDomenN+q5kBRDvRBnotiBInaq7F6jAAnpjhuaAtCYUQ
         cT+vxMKuEo4e0XgjSfho21ZvtnVOkay9NU56/sWVupVdfLagUCWr1siIZnWPqLwe5mDR
         9dfPVH9ngapxsgPdX8M4dwF+OyTMsUkfgjM1MIkfVBIMNKqZEhNpA8JChSaPiVyFaztY
         LGwrhvLmJBWbgTMa+QjpD4dJQMylbGQfLcf15Hkn9v9wg+NKpaHmDq7gqVrXhf7J75u4
         gj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=USnLVa2T8uFZRAOclR/XwP0TkvUVzviOCnafMs1/m5c=;
        b=tbSYztovzjiZ6HlxV7s0LVMoxIc32Xd2DJGbCIiMNRMEYxQdIzuuWR6GAoiAPIHha3
         TzpaqoDrroAd/6svQVk3yngsYw+IbeCUD8fBkbVUSzRogczkzsqB6dICGZb127wtHYOh
         62DqUmWy9d48XkJAIRU4Q9UvR62eibW7ZYshPN3dSTCkV70782X5ol0qH/sugAABmZe4
         3wSc+WJh5RLcjgANrG6FqCRCtyChFJbCb7gNy4bx0MhaLREEtvuE5wyLWu8dCrYZIAxP
         wOtQVRDp6dHydOnLGti2Rwt1z5UvUJJRvUCBKusAzzPguojdv0G07Rw748jolcn5uL02
         6rtA==
X-Gm-Message-State: AIVw111VYgAmVakSijdJIMfc9Tj+YkddRyk3Ggj2/uWhZ8atkWFpd6qo
        HSOI9xrDyUnsAi5OPso=
X-Received: by 10.200.3.195 with SMTP id z3mr10626215qtg.185.1501248020673;
        Fri, 28 Jul 2017 06:20:20 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id y133sm15463111qkb.71.2017.07.28.06.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jul 2017 06:20:19 -0700 (PDT)
Subject: Re: [RFC PATCH 1/4] environment, fsck: introduce lazyobject extension
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com
References: <cover.1501111615.git.jonathantanmy@google.com>
 <cover.1501111615.git.jonathantanmy@google.com>
 <75766ee26264e50b7fcb3c7a8cc5808907586799.1501111615.git.jonathantanmy@google.com>
 <xmqqzibpn1zh.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <df0402d4-860a-762a-a993-5b125369bf50@gmail.com>
Date:   Fri, 28 Jul 2017 09:20:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqzibpn1zh.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/27/2017 2:55 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
>> Currently, Git does not support repos with very large numbers of objects
>> or repos that wish to minimize manipulation of certain blobs (for
>> example, because they are very large) very well, even if the user
>> operates mostly on part of the repo, because Git is designed on the
>> assumption that every referenced object is available somewhere in the
>> repo storage.
>>

I very much like the direction this is taking.  Handling missing objects 
gracefully is an important part of the overall partial clone support.

>> Introduce a new repository extension option "extensions.lazyobject", of
>> data type string. If this is set in a repository, Git will tolerate
>> objects being missing in that repository.  When Git needs those objects,
>> it will invoke the command in that option.
> 

I'm very glad you are doing this.  Having never used precious objects I 
was unaware of the extensions concept but it looks like a great way to 
deal with this repo specific option.

> My reading hiccupped after the first sentence, as the problem
> description made it sound like this was a boolean ("are we using
> lazy object feature?"), after reading "data type string".  And then
> "the command in that option" made me hiccup one more time, as it did
> not "click" that "in that option" was trying to say that the string
> is used as the command name (or is it a whole command line?  The
> leading part of the command line to which some arguments are
> appended before it gets invoked as a command? or what?).
> 
> Logically, I think it is more like
> 
>   - extensions.lazyobject can be set to tell Git to consider missing
>     objects in certain cases are not errors;
> 
>   - the value of extensions.lazyobject variable must be a string,
>     which is used to name the command to lazily make the object
>     "appear" in the repository on demand.
> 
>> Teach fsck about the new state of affairs. In this commit, teach fsck
>> that missing objects referenced from the reflog are not an error case;
>> in future commits, fsck will be taught about other cases.
> 
> In any case, sounds like a small and good first step.
> 

I agree completely with the feedback on the description.  That is quite 
the run on sentence. :)

>> +
>> +`lazyObject`
>> +~~~~~~~~~~~~~~~~~
>> +
>> +When the config key `extensions.lazyObject` is set to a string, Git
>> +tolerates objects being missing in the repository. This string contains
>> +the command to be run whenever a missing object is needed.
> 
> This has the same issue but to a lessor degree as there is "string
> contains".  What the command will do (e.g. "makes the object
> magically appear in the object store" or "emits the contents of the
> object to its standard output, so that Git can hash it to make it
> appear in the object store"), and how it is used (e.g. "this is a
> single command name and nothing else", "this is a leading part of
> command line and arguments are appended at the end, before the whole
> thing is passed to the shell to be executed", etc.) will need to be
> clarified in the final version of the series (not necessarily at
> this step---the series can elaborate in the later patches).
> 
>> diff --git a/builtin/fsck.c b/builtin/fsck.c
>> index fb0947009..1cfb8d98c 100644
>> --- a/builtin/fsck.c
>> +++ b/builtin/fsck.c
>> @@ -402,7 +402,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
>>   					xstrfmt("%s@{%"PRItime"}", refname, timestamp));
>>   			obj->flags |= USED;
>>   			mark_object_reachable(obj);
>> -		} else {
>> +		} else if (!repository_format_lazy_object) {
>>   			error("%s: invalid reflog entry %s", refname, oid_to_hex(oid));
>>   			errors_found |= ERROR_REACHABLE;
>>   		}
>> diff --git a/cache.h b/cache.h
>> index 6c8242340..9e6bc0a21 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -853,10 +853,12 @@ extern int grafts_replace_parents;
>>   #define GIT_REPO_VERSION 0
>>   #define GIT_REPO_VERSION_READ 1
>>   extern int repository_format_precious_objects;
>> +extern char *repository_format_lazy_object;
> 
> This is not a new problem, but I think these two should be
> called repository_extension_$NAME not repository_format_$NAME.
> 
>> diff --git a/t/t0410-lazy-object.sh b/t/t0410-lazy-object.sh
>> new file mode 100755
>> index 000000000..36442531f
>> --- /dev/null
>> +++ b/t/t0410-lazy-object.sh
>> @@ -0,0 +1,32 @@
>> +#!/bin/sh
>> +
>> +test_description='lazy object'
>> +
>> +. ./test-lib.sh
>> +
>> +delete_object () {
>> +	rm $1/.git/objects/$(echo $2 | cut -c1-2)/$(echo $2 | cut -c3-40)
>> +}
>> +
>> +test_expect_success 'fsck fails on lazy object in reflog' '
>> +	test_create_repo repo &&
>> +	test_commit -C repo 1 &&
>> +
>> +	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
>> +	B=$(git -C repo commit-tree -m b HEAD^{tree}) &&
>> +
>> +	# Reference $A only from reflog, and delete it
>> +	git -C repo branch mybranch "$A" &&
>> +	git -C repo branch -f mybranch "$B" &&
>> +	delete_object repo "$A" &&
>> +
>> +	test_must_fail git -C repo fsck
>> +'
>> +test_expect_success '...but succeeds if lazyobject is set' '
>> +	git -C repo config core.repositoryformatversion 1 &&
>> +	git -C repo config extensions.lazyobject "arbitrary string" &&
>> +	git -C repo fsck
>> +'
>> +
>> +test_done
