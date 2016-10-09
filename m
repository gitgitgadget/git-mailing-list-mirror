Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	URIBL_RED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96993207EC
	for <e@80x24.org>; Sun,  9 Oct 2016 13:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbcJINm6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 09:42:58 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36838 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbcJINm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 09:42:57 -0400
Received: by mail-qk0-f173.google.com with SMTP id o68so79139288qkf.3
        for <git@vger.kernel.org>; Sun, 09 Oct 2016 06:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gforgegroup-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g1QJZqQMrS66FcYYz1YH4/+Ht+Wzg4Ygm2l9CHDxyio=;
        b=WztQ+gz7125DZZUp5xu2qPvbyX3EPSP3HMSkRVe86DfO4NtImSP0Aacd7xrQA775zd
         caKJAxqQRQ5+TItye/y/7aiapjS0KVFnM+/8tnYMxNVO4kDxyATQ70gb95QFQf7RuI1X
         kkMPgkoEH9yCc8np7AIm4yOWjgTvKOs01D8qIe9ClBSSXfzHa+Vtn6MMnmd1fzNoeTOn
         j9s1B/9P/0EpjYvOgzWwlbbtBeuMFgCTYxIyS0DUdgQmbJPNMPN45oi09qdI6bNiiSIy
         m0zDMjTsPKxmx1a83zoekanEF8IKWSMSN/EHdQO7/0rVqGXAG89j0+Xf2v/fsAPxHWKE
         Wl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g1QJZqQMrS66FcYYz1YH4/+Ht+Wzg4Ygm2l9CHDxyio=;
        b=ay+s+Qv9f7Y6uOJKDqcMANrGHf9OB/DBzGI8jEgfv5qV6v4kQza4ieSSIl8M/86UNo
         zuDzpa9IWBVWbpnRX7TfZWuJpR+89Z3h6e5xJklCuZKC+T/sjirciV15qBsUi0InTFMr
         rDuwJ6ndJsXjBXhdRV6ILYNa7ITnoNyYkABH2K3XTauZfnxnFB/Ajn7we+VCpASKozPU
         BBpXP2ncRXGtc373//inziezu/c1de/7Qu17ipzWkio/O35m1dA6nAgVQGQqIAZ9sJRC
         IgOYAFwamdE79YG6KQjXmq8iYUSzH/NMbcc1arDPXGOHHoA29Q8C+DtLF609Z9AMrUCb
         J1dg==
X-Gm-Message-State: AA6/9Rk2mb8uXfrvjOG40/dSXgJ691EtEOHJ/zMwlylcXXNmr6jn+0wCkhQDfcwS1uK5/0DRVODKjZIvChGMghPz
X-Received: by 10.55.221.146 with SMTP id u18mr25744218qku.42.1476020576492;
 Sun, 09 Oct 2016 06:42:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.164.69 with HTTP; Sun, 9 Oct 2016 06:42:55 -0700 (PDT)
In-Reply-To: <CACsJy8CmgmGLEi0xQUY9Eo-4FkA4eDNk9WJ2LtEDVFQBjbFdCA@mail.gmail.com>
References: <CAOi_75+2SG2WYHBMQhfGj96eKsZ66niJzOevVGM5eJv-qqrVNg@mail.gmail.com>
 <1475999513.7410.8.camel@kaarsemaker.net> <CACsJy8CmgmGLEi0xQUY9Eo-4FkA4eDNk9WJ2LtEDVFQBjbFdCA@mail.gmail.com>
From:   Michael Tutty <mtutty@gforgegroup.com>
Date:   Sun, 9 Oct 2016 08:42:55 -0500
Message-ID: <CAOi_75+Zoeeq5FD1HKgG4MjeL9LkBshsSfdrMOTi8m-Mt-OQNQ@mail.gmail.com>
Subject: Re: Bug? git worktree fails with master on bare repo
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Git Mailing List <git@vger.kernel.org>,
        Michael Rappazzo <rappazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis,
Thanks for the great response, and for spending time on my issue.
I'll try that first patch and see what happens.

In the meantime, it got weirder...

I created a brand-new (bare) repo and was able to git add worktree
/path master.  I was able to do this repeatedly, even using the
worktree to merge other branches to master.  I didn't find any
condition or step that caused some kind of orphan master work tree,
which was what I thought the underlying problem might be.

So, on the one hand, you found code validating my initial experience.
But on the other hand, I found a test case that didn't appear to have
that problem.

WAT.
      M.

On Sun, Oct 9, 2016 at 5:52 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Oct 9, 2016 at 2:51 PM, Dennis Kaarsemaker
> <dennis@kaarsemaker.net> wrote:
>> On Sat, 2016-10-08 at 19:30 -0500, Michael Tutty wrote:
>>> Hey all,
>>> I'm working on some server-side software to do a merge. By using git
>>> worktree it's possible to check out a given branch for a bare repo and
>>> merge another branch into it. It's very fast, even with large
>>> repositories.
>>>
>>> The only exception seems to be merging to master. When I do git
>>> worktree add /tmp/path/to/worktree master I get an error:
>>>
>>> [fatal: 'master' is already checked out at '/path/to/bare/repo']
>>>
>>> But this is clearly not true, git worktree list gives:
>>>
>>> [/path/to/bare/repo (bare)]
>>>
>>> ...and of course, there is no work tree at that path, just the bare
>>> repo files you'd expect.
>>
>> The worktree code treats the base repo as a worktree, even if it's
>> bare. For the purpose of being able to do a checkout of the main branch
>> of a bare repo, this patch should do:
>>
>> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
>> index 4bcc335..b618d6b 100755
>> --- a/t/t2025-worktree-add.sh
>> +++ b/t/t2025-worktree-add.sh
>> @@ -138,6 +138,14 @@ test_expect_success 'checkout from a bare repo without "add"' '
>>         )
>>  '
>>
>> +test_expect_success '"add" default branch of a bare repo' '
>> +       (
>> +               git clone --bare . bare2 &&
>> +               cd bare2 &&
>> +               git worktree add ../there3 master
>> +       )
>> +'
>> +
>>  test_expect_success 'checkout with grafts' '
>>         test_when_finished rm .git/info/grafts &&
>>         test_commit abc &&
>> diff --git a/worktree.c b/worktree.c
>> index 5acfe4c..35e95b7 100644
>> --- a/worktree.c
>> +++ b/worktree.c
>> @@ -345,6 +345,8 @@ const struct worktree *find_shared_symref(const char *symref,
>>
>>         for (i = 0; worktrees[i]; i++) {
>>                 struct worktree *wt = worktrees[i];
>> +               if(wt->is_bare)
>> +                       continue;
>>
>>                 if (wt->is_detached && !strcmp(symref, "HEAD")) {
>>                         if (is_worktree_being_rebased(wt, target)) {
>>
>>
>
> You're fast :) I'm still studying  8d9fdd7 (worktree.c: check whether
> branch is rebased in another worktree - 2016-04-22). But yeah that
> should fix it.
>
>> But I'm wondering why the worktree code does this. A bare repo isn't a
>> worktree and I think it shouldn't treat it as one. A patch that rips
>> out this feature and updates the tests to match would look like this:
>>
>>
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> index 5c4854d..3600530 100644
>> --- a/builtin/worktree.c
>> +++ b/builtin/worktree.c
>> @@ -382,15 +382,11 @@ static int add(int ac, const char **av, const char *prefix)
>>  static void show_worktree_porcelain(struct worktree *wt)
>>  {
>>         printf("worktree %s\n", wt->path);
>> -       if (wt->is_bare)
>> -               printf("bare\n");
>> -       else {
>> -               printf("HEAD %s\n", sha1_to_hex(wt->head_sha1));
>> -               if (wt->is_detached)
>> -                       printf("detached\n");
>> -               else
>> -                       printf("branch %s\n", wt->head_ref);
>> -       }
>> +       printf("HEAD %s\n", sha1_to_hex(wt->head_sha1));
>> +       if (wt->is_detached)
>> +               printf("detached\n");
>> +       else
>> +               printf("branch %s\n", wt->head_ref);
>>         printf("\n");
>>  }
>
> This goes back to the first very first commit of "git worktree list":
> bb9c03b (worktree: add 'list' command - 2015-10-08) and was sort of
> pointed out during review [1] but nobody answered it.
>
> A bare repo does not have an associated worktree. However only main
> worktree can be bare. If we take this out, "git worktree list"'s first
> line will no longer be about the main worktree (because it does not
> exist). That may cause trouble since we promised in "git-worktree.txt"
> that the main worktree is listed first. I don't think we have any way
> else to determine if the main worktree exists. Showing "bare" may be
> the way to see if we have a main worktree or not. So we probably want
> to keep this function unchanged.
>
> [1] https://public-inbox.org/git/%3CCANoM8SWeqxD2vWLQmEfxxxn8Dz4yPfjGOoOH=Azn1A3So+wz2Q@mail.gmail.com%3E/
> --
> Duy



-- 
Michael Tutty, CTO

e: mtutty@gforgegroup.com
t: @mtutty, @gforgegroup
v: 515-789-0772
w: http://gforgegroup.com, http://gforge.com
