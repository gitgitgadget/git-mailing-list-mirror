Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93780C48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 17:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75746613BD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 17:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhFIRqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 13:46:18 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:40532 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231219AbhFIRqR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 13:46:17 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 3E1BD4187E;
        Wed,  9 Jun 2021 19:44:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1623260660; x=1625075061; bh=s090AmIN8C6xolAFMTP
        UceAfco6h6BsetipW+8yLAkg=; b=yHFgtp2ihJSzmLe1oKNKyKKHYlmd0aj4ns2
        1NxdwGyiz8qUsP09yFa5O0ldSUOTHJaJgEeRKmJHhb1fOVgTxZ2mvkBHHdnJHS12
        +jBqlJBsBpSbFqXxL2/J0izov8q9ivwlMNTzs5h33RA64Y6P5PrF4mqb9Br2vNT4
        34veZFvBMLPX2RRHDAl2fZA9Cgsvh8jI4rMrr/0rArgfPBdUUZGT3riBpYo6jf8L
        61J7rtadLT+3udR7gWkR0xfVR+KoqSVnXbQecGEV9d08WX3t0A2dQNuito6wmpXF
        3qWNZCUnbDFjT4ecU2xbPPdp2YR2nLs/OTySNA4jw5Vt1EHQLxKuFQxrrR1Awl1b
        BkFug4jBTWcUwCwom6Yld7LQi+1nv0ZTH4i+HBUnRKAnkjAUu6O/XICWqRxBuuCs
        i1I2u0+V/v0dYZwLIvJe78I01GpGrrj+H6s1Kjbk5U93/8qticj04HlHEyJ2zRvR
        IzEqq8ZsqseFvf4MApLHY5pPZMbtBB5T/39dveTPaFfuQGA8711U4/wtVjif3ITM
        AOfUm+CqMrnnwRq0xDqA2sbQERLPGpgr2MzUYpKmDn4yUmzZlbH9NR82jGJJtCXF
        pqgkHdIrKUG/u8HIBPD5jdKZbeHjTjTCXbzBKkIKs+IeAEDlaqhTdNE56ABsrbLF
        WAkseLTY=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LvJSpQQ2N5Pq; Wed,  9 Jun 2021 19:44:20 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 1B3DB403CF;
        Wed,  9 Jun 2021 19:44:18 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 96BDA4AD1;
        Wed,  9 Jun 2021 19:44:15 +0200 (CEST)
Subject: Re: UNLEAK(), leak checking in the default tests etc.
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>
References: <87czsv2idy.fsf@evledraar.gmail.com>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <fcb0eaee-6ae1-f2cc-51d5-103eea64532a@ahunt.org>
Date:   Wed, 9 Jun 2021 19:44:12 +0200
MIME-Version: 1.0
In-Reply-To: <87czsv2idy.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 09/06/2021 16:38, Ævar Arnfjörð Bjarmason wrote:
> 
> [In-Reply-To
> <a74bbcae7363df03bf8e93167d9274d16dc807f3.1615747662.git.gitgitgadget@gmail.com>,
> but intentionally breaking threading for a new topic]
> 
> On Sun, Mar 14 2021, Andrzej Hunt via GitGitGadget wrote:
> 
>> Most of these pointers can safely be freed when cmd_clone() completes,
>> therefore we make sure to free them. The one exception is that we
>> have to UNLEAK(repo) because it can point either to argv[0], or a
>> malloc'd string returned by absolute_pathdup().
> 
> I ran into this when manually checking with valgrind and discovered that
> you need SANITIZERS for -DSUPPRESS_ANNOTATED_LEAKS to squash it.
> 
> I wonder if that shouldn't be in DEVOPTS (or even a default under
> DEVELOPER=1). I.e. you don't need any other special compile flags, just
> a compiled git that you then run under valgrind to spot this.

I'm not familiar with git's development conventions/philosophy, but my 
2c is that it's better not to enable it by default in order to minimise 
divergence from the code that users are running. OTOH it's not a major 
difference in behaviour so perhaps that's not a concern here.

More significantly: I get the impression it's easier to do leak checking 
using LSAN, which requires recompiling git anyway - at which point you 
get the flag for free - so how often will people actually perform leak 
checking with Valgrind in the first place?

> 
>>   builtin/clone.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index 51e844a2de0a..952fe3d8fc88 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -964,10 +964,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>>   {
>>   	int is_bundle = 0, is_local;
>>   	const char *repo_name, *repo, *work_tree, *git_dir;
>> -	char *path, *dir, *display_repo = NULL;
>> +	char *path = NULL, *dir, *display_repo = NULL;
>>   	int dest_exists, real_dest_exists = 0;
>>   	const struct ref *refs, *remote_head;
>> -	const struct ref *remote_head_points_at;
>> +	struct ref *remote_head_points_at = NULL;
>>   	const struct ref *our_head_points_at;
>>   	struct ref *mapped_refs;
>>   	const struct ref *ref;
>> @@ -1017,9 +1017,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>>   	repo_name = argv[0];
>>   
>>   	path = get_repo_path(repo_name, &is_bundle);
>> -	if (path)
>> +	if (path) {
>> +		FREE_AND_NULL(path);
>>   		repo = absolute_pathdup(repo_name);
>> -	else if (strchr(repo_name, ':')) {
>> +	} else if (strchr(repo_name, ':')) {
>>   		repo = repo_name;
>>   		display_repo = transport_anonymize_url(repo);
>>   	} else
> 
> In this case it seems better to just have a :
> 
>      int repo_heap = 0;
> 
>      Then set "repo_heap = 1" in that absolute_pathdup(repo_name) branch,
>      and...
> 
>> @@ -1393,6 +1394,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>>   	strbuf_release(&reflog_msg);
>>   	strbuf_release(&branch_top);
>>   	strbuf_release(&key);
>> +	free_refs(mapped_refs);
>> +	free_refs(remote_head_points_at);
>> +	free(dir);
>> +	free(path);
>> +	UNLEAK(repo);
> 
> Here do:
> 
>      if (repo_heap)
>          free(repo);
> 

Although this is possible, I don't think it's worth it: if UNLEAK 
already exists, we might as well use it here to make the code simpler. 
And UNLEAK is unlikely to go away anytime soon because... (continued below)

> But maybe there's some other out of the box way to make leak checking
> Just Work without special flags in this case. I'm just noting this one
> because it ended up being the only one that leaked unless I compiled
> with -DSUPPRESS_ANNOTATED_LEAKS. I was fixing some leaks in the bundle
> code.

There are trickier examples where a cmd_* function has a complex struct 
on the stack, and correctly clearing all allocated memory pointed to by 
its members (or in turn further children with potentially multiple 
levels of indirection) is a lot of work - and that work doesn't actually 
benefit the user in any way. In other words, we either need to be able 
to use UNLEAK to suppress certain classes of uninteresting memory leaks 
- which allows us to focus on the interesting/real leaks - or someone 
has to spend a lot of time doing cleanup by hand (and/or someone has to 
implement a bunch of new cleanup functions)).

In your example above, the UNLEAK can be avoided at the cost of one 
additional tracking variable - but in many other cases avoiding an 
UNLEAK is much more expensive. It's certainly valid to debate the merits 
of the UNLEAK here, but that won't remove the need for UNLEAK's 
existence in general.

(The most common example that I remember is where cmd_* has a rev_info, 
and AFAICT there's no one-liner to clean that up. Using UNLEAK is 
honestly the best approach there. I don't think I've actually submitted 
any patches doing this, but I have a few in my local backlog.)
> Anyway, getting to the "default tests" point. I fixed a memory leak, and
> wanted to it tested that the specific command doesn't leak in git's
> default tests.
> 
> Do we have such a thing, if not why not?
> 
> The closest I got to getting this was:
> 
>      GIT_VALGRIND_MODE=memcheck GIT_VALGRIND_OPTIONS="--leak-check=full --errors-for-leak-kinds=definite --error-exitcode=123" <SOME TEST> --valgrind

It's easy to perform leak-checking runs *if* you're OK recompiling with 
LSAN, instead of using valgrind. My usual recipe for running against a 
range of tests is something like:

   make SANITIZE=address,leak 
ASAN_OPTIONS="detect_leaks=1:abort_on_error=1" CFLAGS="-Og -g" 
T="\$(wildcard t00[0-9][0-9]-*.sh)" test

Additionally: I usually specify CC=clang, although gcc+LSAN has mostly 
been stable enough in my experience so you might be able to skip that.
(I've found ASAN+LSAN to be more stable than LSAN by itself, which is 
why I specify address+leak, but adding ASAN in turn requires overriding 
ASAN_OPTIONS to reenable leak checking.)

I don't know whether or not Valgrind is more/less effective at finding 
leaks, so being able to run the test suite under valgrind would be nice 
for comparison purposes though.

ATB,

   Andrzej
