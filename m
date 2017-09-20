Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EB5F20A2A
	for <e@80x24.org>; Wed, 20 Sep 2017 16:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751622AbdITQTe (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 12:19:34 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:56685 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbdITQTc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 12:19:32 -0400
Received: by mail-qk0-f182.google.com with SMTP id u7so3183997qku.13
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 09:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I5VOH9p69ZPrub4w6WgkPL03WJZsQo/hgHUllSgnPcA=;
        b=W8YUdL/a51knMEcSebnOAW8cWxWp1iKjJmuP+T9fCJPOr0JT2UlWWXe4MzUspi/9+l
         VBOu0LU1HtHYsGweX3R+6qO0Sf1cNR4rxJNEjUZqctweNupS1L/Yyweq3P2uHzTKXUTC
         Q8qckRpgHP4c8EzLSfPJQ5Kw3/5Xj5Qe7oz7N6GdpV4dWQIn/wes81vyyKGiJ1Hg6F8R
         7c0C9r8WtjmSRkUz/aZ7jfQMyB8s0UieK4sHbX8/j6oGbrwO/pl9xysjLR7fqouHJblb
         b2WULUAVnwSL7FuX4IuOtc2Fz0jsYVIm2EZvmBUYt4wP0Re1WWPrYI51WZWQnqXNe9uL
         lZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I5VOH9p69ZPrub4w6WgkPL03WJZsQo/hgHUllSgnPcA=;
        b=ZHR7BXkwUJnQ/Pz/Os0dVCo7/lnD0vNPJicWDpeNKrN4hUcsfQDlKuHJb2NKlhGvsG
         dMxbpOrHR+AZXO2PU7LT9wiqxtSqo4VdMA09Q24WKlmYG74qqj4rexWyvbXQd2UjWGuA
         eSmD8c7uqmrLHO7B73YL7p1cy3xRkqH/mzVN4tJkq+Gpi4WmduE7UCgCpkgmj8WBhKap
         nNlUCGGVQlD2Qjw2jIzydAK8niJvbHseiL2ZUrjM9Rl9GcforbyEpTGS/nK2xYKB+B7l
         UnX6bB5KUm7YJXptpQaGdEiAS68eQNeqoAMuHBZdTE7/ZxX9E1Z/rL87D0i8S3KteOlO
         BWVg==
X-Gm-Message-State: AHPjjUhuloTp+ItN9C0+wsNG0406Wz6zmh87lFW5gwm6zcppk7FYkyOJ
        UVRr0KTTTg/p2A74rFblMQE=
X-Google-Smtp-Source: AOwi7QCcWV601ISQ4DY9QoK5Gy45aJdx/18tlkpwWRItmob9rBIcsMP/X8rkxQnr0bGv9ZUZJSAXAw==
X-Received: by 10.55.4.141 with SMTP id 135mr3059790qke.86.1505924371728;
        Wed, 20 Sep 2017 09:19:31 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id j40sm1581291qtj.38.2017.09.20.09.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 09:19:30 -0700 (PDT)
Subject: Re: [PATCH v7 04/12] fsmonitor: teach git to optionally utilize a
 file system monitor to speed up detecting new or changed files.
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
 <20170919192744.19224-5-benpeart@microsoft.com>
 <xmqqr2v2p0gn.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <3311de8b-f9df-07e0-6c5d-7f491e9bcaa8@gmail.com>
Date:   Wed, 20 Sep 2017 12:19:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqr2v2p0gn.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/19/2017 10:28 PM, Junio C Hamano wrote:
> Ben Peart <benpeart@microsoft.com> writes:
> 
>> +/* do stat comparison even if CE_FSMONITOR_VALID is true */
>> +#define CE_MATCH_IGNORE_FSMONITOR 0X20
> 
> Hmm, when should a programmer use this flag?
> 

Pretty much the same places you would also use CE_MATCH_IGNORE_VALID and 
CE_MATCH_IGNORE_SKIP_WORKTREE which serve the same role for those 
features.  That is generally when you are about to overwrite data so 
want to be *really* sure you have what you think you have.

The other place I used it was in preload_index(). In that case, I didn't 
want to trigger the call to refresh_fsmonitor() as preload_index() is 
about trying to do a fast precompute of state for the bulk of the index 
entries but is not required for correctness as refresh_cache_ent() will 
ensure any "missed" by preload_index() are up-to-date if/when that is 
needed.

>> +int git_config_get_fsmonitor(void)
>> +{
>> +	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
>> +		core_fsmonitor = getenv("GIT_FSMONITOR_TEST");
> 
> Will the environment be part of the published API, or is it a
> remnant of a useful tool for debugging while developing the feature?
> 
> If it is the former (and I'd say why not, even though "git -c
> core.fsmontor=..." may be easy enough), we might want to rename it
> to replace _TEST with _PROGRAM or something and document it.
> 

This was added this to facilitate testing.  That is why it has the magic 
naming of "GIT_***_TEST" which is the only way I found to ensure that 
env variable gets passed to tests.  Its use is discussed in patch 10 
which contains the tests.

>> diff --git a/diff-lib.c b/diff-lib.c
>> index 2a52b07954..23c6d03ca9 100644
>> --- a/diff-lib.c
>> +++ b/diff-lib.c
>> @@ -12,6 +12,7 @@
>>   #include "refs.h"
>>   #include "submodule.h"
>>   #include "dir.h"
>> +#include "fsmonitor.h"
>>   
>>   /*
>>    * diff-files
>> @@ -228,6 +229,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>>   
>>   		if (!changed && !dirty_submodule) {
>>   			ce_mark_uptodate(ce);
>> +			mark_fsmonitor_valid(ce);
> 
> I notice all calls to mark_fsmonitor_valid(ce) always follow a call
> to ce_mark_uptodate(ce).  Should the call to the former be made as
> part of the latter instead?  Are there cases where we want to call
> ce_mark_uptodate(ce) to mark the ce up-to-date, yet we do not want
> to call mark_fsmonitor_valid(ce)?  How does a programmer tell when
> s/he wants to call ce_mark_uptodate(ce) if s/he also should call
> mark_fsmonitor_valid(ce)?

mark_fsmonitor_valid(ce) is the way to indicate that cache entries that 
were once fsmonitor dirty are now properly reflected in the index so can 
come off the "dirty" list.  It can't really be combined with 
ce_mark_uptodate(ce) as that would prevent the CE_MATCH_IGNORE_FSMONITOR 
logic:

	if (!ignore_skip_worktree && ce_skip_worktree(ce)) {
		ce_mark_uptodate(ce);
		return ce;
	}
	if (!ignore_valid && (ce->ce_flags & CE_VALID)) {
		ce_mark_uptodate(ce);
		return ce;
	}
	if (!ignore_fsmonitor && (ce->ce_flags & CE_FSMONITOR_VALID)) {
		ce_mark_uptodate(ce);
		return ce;
	}

In addition, fsmonitor is an optional feature and so the 
mark_fsmonitor_valid(ce) call should only happen when the feature is 
turned on. I tried to keep it as simple as possible by making that test 
and set logic part of the function but still be performant by making the 
function inline.

> 
> Together with "when to pass IGNORE_FSMONITOR" question, is there a
> summary that guides new programmers to answer these questions in the
> new documentation?
> 

Only the discussion in this mail thread.  I could add something to the 
function header in fsmonitor.h if that would help.  How about something 
like:

diff --git a/fsmonitor.h b/fsmonitor.h
index c2240b811a..03bf3efe61 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -34,9 +34,11 @@ extern void tweak_fsmonitor(struct index_state *istate);
   */
  extern void refresh_fsmonitor(struct index_state *istate);

-/*
- * Set the given cache entries CE_FSMONITOR_VALID bit.
- */
+/*
+ * Set the given cache entries CE_FSMONITOR_VALID bit. This should be
+ * called any time the cache entry has been updated to reflect the
+ * current state of the file on disk.
+ */
  static inline void mark_fsmonitor_valid(struct cache_entry *ce)
  {
         if (core_fsmonitor) {
@@ -46,8 +48,11 @@ static inline void mark_fsmonitor_valid(struct 
cache_entry *ce)
  }

  /*
- * Clear the given cache entry's CE_FSMONITOR_VALID bit and invalidate any
- * corresponding untracked cache directory structures.
+ * Clear the given cache entry's CE_FSMONITOR_VALID bit and invalidate
+ * any corresponding untracked cache directory structures. This should
+ * be called any time git creates or modifies a file that should
+ * trigger an lstat() or invalidate the untracked cache for the
+ * corresponding directory
   */
  static inline void mark_fsmonitor_invalid(struct index_state *istate, 
struct cache_entry *ce)
  {


>> diff --git a/dir.h b/dir.h
>> index e3717055d1..fab8fc1561 100644
>> --- a/dir.h
>> +++ b/dir.h
>> @@ -139,6 +139,8 @@ struct untracked_cache {
>>   	int gitignore_invalidated;
>>   	int dir_invalidated;
>>   	int dir_opened;
>> +	/* fsmonitor invalidation data */
>> +	unsigned int use_fsmonitor : 1;
> 
> This makes it look like we will add a bit more fields in later
> patches that are about "invalidation" around fsmonitor, but it
> appears that such an addition never happens til the end of the
> series.  And use_fsmonitor boolean does not seem to be what the
> comment says---it just tells us if fsmonitor is in use in the
> operation of the untracked cache, no?

I don't have any more planned bit fields.  I only needed a single bit so 
used a bit field just in case someone else comes by later and needs 
another bit.  If you aren't worried about that, we can just make this an 
int.

Correct.  The bit just indicates whether fsmonitor has been used to 
ensure the cache is current or if it needs to be checked.  I have 
comments to this effect where the flag is used in the code but could 
move/duplicate them into the header if wished. For example:

/* With fsmonitor, we can trust the untracked cache's valid field. */

and

/* Now mark the untracked cache for fsmonitor usage */

> 
>> diff --git a/entry.c b/entry.c
>> index cb291aa88b..5e6794f9fc 100644
>> --- a/entry.c
>> +++ b/entry.c
>> @@ -4,6 +4,7 @@
>>   #include "streaming.h"
>>   #include "submodule.h"
>>   #include "progress.h"
>> +#include "fsmonitor.h"
>>   
>>   static void create_directories(const char *path, int path_len,
>>   			       const struct checkout *state)
>> @@ -357,6 +358,7 @@ static int write_entry(struct cache_entry *ce,
>>   			lstat(ce->name, &st);
>>   		fill_stat_cache_info(ce, &st);
>>   		ce->ce_flags |= CE_UPDATE_IN_BASE;
>> +		mark_fsmonitor_invalid(state->istate, ce);
>>   		state->istate->cache_changed |= CE_ENTRY_CHANGED;
> 
> Similar to "how does mark_fsmonitor_valid() relate to
> ce_mark_uptodate()?" question earlier, mark_fsmonitor_invalid()
> seems to often appear in pairs with the update to cache_changed.
> Are there cases where we need CE_ENTRY_CHANGED bit added to the
> index state yet we do not want to call mark_fsmonitor_invalid()?  I
> am wondering if there should be a single helper function that lets
> callers say "I changed this ce in this istate this way.  Please
> update CE_VALID, CE_UPDATE_IN_BASE and CE_FSMONITOR_VALID
> accordingly".
> 
> That "changed _this way_" is deliberately vague in my question
> above, because it is not yet clear to me when mark-valid and
> mark-invalid should and should not be called from the series.
> 

Please let me know if my comment/patch above does not address this 
concern sufficiently.

>> +	/* a fsmonitor process can return '*' to indicate all entries are invalid */
>> +	if (query_success && query_result.buf[0] != '/') {
>> +		/* Mark all entries returned by the monitor as dirty */
> 
> The comment talks about '*' and code checks if it is not '/'?  The
> else clause of this if/else handles the "invalidate all" case, so
> shouldn't we be comparing with '*' instead here?
> 
> Ah, fsmonitor-watchman section of the doc tells us to write the hook
> in a way to return slash, so the comment above the code is stale and
> the comparison with '/' is what we want, I guess.
> 

Correct.  Sorry about missing that.  Here is a patch that can be 
squashed in.

diff --git a/fsmonitor.c b/fsmonitor.c
index b8b2d88fe1..7c1540c054 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -176,7 +176,7 @@ void refresh_fsmonitor(struct index_state *istate)
                         core_fsmonitor, query_success ? "success" : 
"failure");
         }

-       /* a fsmonitor process can return '*' to indicate all entries 
are invalid */
+       /* a fsmonitor process can return '/' to indicate all entries 
are invalid */
         if (query_success && query_result.buf[0] != '/') {
                 /* Mark all entries returned by the monitor as dirty */
                 buf = query_result.buf;

