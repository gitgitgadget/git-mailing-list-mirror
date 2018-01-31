Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E804B1F404
	for <e@80x24.org>; Wed, 31 Jan 2018 16:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932262AbeAaQMj (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 11:12:39 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:44527 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752120AbeAaQMi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 11:12:38 -0500
Received: by mail-qk0-f177.google.com with SMTP id n188so4021876qkn.11
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 08:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L1UEYqH3z51iio55hCh1gjbTgckbMvKer4cJXEyQ6Ms=;
        b=EaC79J74CtwgQpOYTG0ijDqBRHeiyvb82RRfzHAjHZM8E4oDsx8Olp5ZACfRGMU8ZN
         qBTiWKn9vqgD5srj1VLgnHlg2z/ODtUBVmp5mEd16FOv2sVjwo8EXIFPi2YXm3cs2Bzj
         kKpkohd/8i1edeX5sEM4qr320Vjtl5AFPy8f9ORwnrRhkUS3MTindwPo8b+1R7V6AQGx
         3xMDnuURDK3M1xSaNhv+9kw2X4hQGyT4SVmqdOb8nSNb1WzXxPXPM/gROABSdF7z3BhW
         LNEkF2xKicmNHntpoLmi1K9ZN/ds9+41e9aH58MT14ZmeoTRhzJG9fHui+ByfBqGvGES
         UJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L1UEYqH3z51iio55hCh1gjbTgckbMvKer4cJXEyQ6Ms=;
        b=K/AwlgIHNm+R07/O58RFcKFoaGbfnMyxHrWIPpC+Ut0WKDdmrORvKIlTEECeu8DrAa
         q3eEDtqlpxeD5KHUqIG+YFBTztBqRGZEEOQzm7ZDr5VOhKsk2HUPbOP23Lf2eXtMrAP+
         lN8aonzAh/brp2yqv5ivDtO+CjyIRRYw5YzIgGcIGdutB2mCsYeWVxccRVo9ZZX3tXtO
         l60rReB3787JzVugfWmnBjIBfm7AmpMMy3gKIE2bfLg/SByTatNclFuYv4Z5/psSqbj3
         hfyionkTb4Q0Hd9mE8gHoDuFDynCfxMTCGtKq0xr14B48TkBtqLMVDu1BJugNX+YOA6I
         CO4w==
X-Gm-Message-State: AKwxytd36LPOwDNv95hRAO7PD/cLNEmxSGY6CItzUQ6lygyxwPPC0Ywx
        HwTgEwPF8YUkEB+D1JeSm1I=
X-Google-Smtp-Source: AH8x224CUqfr3MT0qEZl+61oF0GOnJVYaqtDCU4wO945cjynI5OzU8P3Xs0tb/6ghVJJMkTZmaPPHA==
X-Received: by 10.55.106.193 with SMTP id f184mr35718419qkc.211.1517415157980;
        Wed, 31 Jan 2018 08:12:37 -0800 (PST)
Received: from [192.168.1.105] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id k2sm8880158qkc.88.2018.01.31.08.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 08:12:36 -0800 (PST)
Subject: Re: Some rough edges of core.fsmonitor
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Christian Couder <christian.couder@gmail.com>,
        David Turner <dturner@twopensource.com>, pclouds@gmail.com
References: <87efmcw3fa.fsf@evledraar.gmail.com>
 <26b9d795-b2b3-905d-c67a-83bc4e976894@gmail.com>
 <87vafjlyyp.fsf@evledraar.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <ee8f571e-a4cc-e8d4-b490-072e1579ee65@gmail.com>
Date:   Wed, 31 Jan 2018 11:12:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87vafjlyyp.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/30/2018 6:16 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Jan 30 2018, Ben Peart jotted:
> 
>> While some of these issues have been discussed in other threads, I
>> thought I'd summarize my thoughts here.
> 
> Thanks for this & your other reply. I'm going to get to testing some of
> Duy's patches soon, and if you have some other relevant WIP I'd be happy
> to try them, but meanwhile replying to a few of these:
> 
>> On 1/26/2018 7:28 PM, Ævar Arnfjörð Bjarmason wrote:
>>> I just got around to testing this since it landed, for context some
>>> previous poking of mine in [1].
>>>
>>> Issues / stuff I've noticed:
>>>
>>> 1) We end up invalidating the untracked cache because stuff in .git/
>>> changed. For example:
>>>
>>>       01:09:24.975524 fsmonitor.c:173         fsmonitor process '.git/hooks/fsmonitor-watchman' returned success
>>>       01:09:24.975548 fsmonitor.c:138         fsmonitor_refresh_callback '.git'
>>>       01:09:24.975556 fsmonitor.c:138         fsmonitor_refresh_callback '.git/config'
>>>       01:09:24.975568 fsmonitor.c:138         fsmonitor_refresh_callback '.git/index'
>>>       01:09:25.122726 fsmonitor.c:91          write fsmonitor extension successful
>>>
>>> Am I missing something or should we do something like:
>>>
>>>       diff --git a/fsmonitor.c b/fsmonitor.c
>>>       index 0af7c4edba..5067b89bda 100644
>>>       --- a/fsmonitor.c
>>>       +++ b/fsmonitor.c
>>>       @@ -118,7 +118,12 @@ static int query_fsmonitor(int version, uint64_t last_update, struct strbuf *que
>>>
>>>        static void fsmonitor_refresh_callback(struct index_state *istate, const char *name)
>>>        {
>>>       -       int pos = index_name_pos(istate, name, strlen(name));
>>>       +       int pos;
>>>       +
>>>       +       if (!strcmp(name, ".git") || starts_with(name, ".git/"))
>>>       +               return;
>>>       +
>>>       +       pos = index_name_pos(istate, name, strlen(name));
>>>
>>>               if (pos >= 0) {
>>>                       struct cache_entry *ce = istate->cache[pos];
>>>
>>> With that patch applied status on a large repo[2] goes from a consistent
>>> ~180-200ms to ~140-150ms, since we're not invalidating some of the UC
>>> structure
>>>
>>
>> I favor making this optimization by updating
>> untracked_cache_invalidate_path() so that it ignores paths under
>> get_git_dir() and doesn't invalidate the untracked cache or flag the
>> index as dirty.
> 
> *nod*
> 
>>> 2) We re-write out the index even though we know nothing changed
>>>
>>> When you first run with core.fsmonitor it needs to
>>> mark_fsmonitor_clean() for every path, but is there a reason for why we
>>> wouldn't supply the equivalent of GIT_OPTIONAL_LOCKS=0 if all paths are
>>> marked and we know from the hook that nothing changed? Why write out the
>>> index again?
>>>
>>
>> Writing out the index when core.fsmonitor is first turned on is
>> necessary to get the index extension added with the current state of
>> the dirty flags.  Given it is a one time cost, I don't think we have
>> anything worth trying to optimize here.
> 
> Indeed, that makes sense. What I was showing here is even after the
> initial setup we continue to write it out when we know nothing changed.
> 
> We do that anyway without fsmonitor, but this seemed like a worthwhile
> thing to optimize.
> 

There is already logic to avoid writing out the index unless there is 
something that requires it.  In my testing, it was often the untracked 
cache marking the index as dirty that was causing the unexpected writes.

The patch to make the untracked cache only flag the index as dirty when 
the feature is being turned on or off is pretty simple (see below).  The 
challenge was that many of the untracked cache tests assume all changes 
are saved to disk after every command so they fail after making this 
change.  The patch below does a simple hack of checking for a test 
environment variable and only forcing the index writes if it is set.

Internally, we simply turned off the untracked cache as it's usefulness 
in combination with GVFS is limited and without the patch, it actually 
slowed down common operations more than it sped them up.

Typically, changes to the untracked cache don't accumulate long before 
the user does some operation that requires the index to be written out 
at which point the untracked cache is updated as well.


diff --git a/dir.c b/dir.c
index 5e93a1350b..af1d33aae1 100644
--- a/dir.c
+++ b/dir.c
@@ -2256,7 +2256,8 @@ int read_directory(struct dir_struct *dir, struct 
index_state *istate,
                                  dir->untracked->gitignore_invalidated,
                                  dir->untracked->dir_invalidated,
                                  dir->untracked->dir_opened);
-               if (dir->untracked == istate->untracked &&
+               if (getenv("GIT_TEST_UNTRACKED_CACHE") &&
+                       dir->untracked == istate->untracked &&
                     (dir->untracked->dir_opened ||
                      dir->untracked->gitignore_invalidated ||
                      dir->untracked->dir_invalidated))
diff --git a/t/t7063-status-untracked-cache.sh 
b/t/t7063-status-untracked-cache.sh
index ea9383e8cb..e5811b6ef2 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -14,6 +14,8 @@ test_description='test untracked cache'
  # See <20160803174522.5571-1-pclouds@gmail.com> if you want to know
  # more.

+export GIT_TEST_UNTRACKED_CACHE=true
+
  sync_mtime () {
         if test_have_prereq BUSYBOX
         then


