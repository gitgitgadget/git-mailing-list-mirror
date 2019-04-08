Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7BDD20248
	for <e@80x24.org>; Mon,  8 Apr 2019 14:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfDHOP1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 10:15:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52539 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHOP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 10:15:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id a184so14545182wma.2
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 07:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=skDrAGjKZbR+r4eXRu2dQSJcKpdhMrTi/BYVRXM+bD8=;
        b=RcGQJQY2gcFTKoFgf7Q5QhIwi+alq92a400QVudNDAfGk0zyp632BBEoHxoTrPV+7a
         l5vMYSlKaDy/d66rwHCzUvdlbw27AKnATjya7JbTQsQ1+/y9mLwfIwuxHB3emaKkwY0T
         rMJbwMxSwwVFu2vZ4oqKeXXDm7UmX2ISkkZrYlJzkPEqjSkCS7A+kp4PLPpy2OGEN5n/
         3zxgH7qNWckfWxUlOvRDux+smN/kKQVWGBDCp9xxYwGpwj3wVUAmqG41iirhos10PLP5
         7UpkYPqDogzsV09fQV+erYh3jy7yLvxiHboEY+kArnRKL6U8rADOYjWOzt5D8MSW0U0l
         q/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=skDrAGjKZbR+r4eXRu2dQSJcKpdhMrTi/BYVRXM+bD8=;
        b=X/4TvzzPCOeO4wx9SDya1YJTb4g/HrzYgSOptzHg7lqXdSHj4vBB6Mdi994IE3MB8b
         sKib2jnh+NzS8q1ojHIjE1snnQ5MUtamsnmm5Y+VQtwHCDi729+3OdqSmqcYXTO6tNu3
         qx20TYhgHjGO2CwXD9qSnrIRGTRMhgSarUGs6SwvcSg/iPg9h468Kw2EGuxCuAn0uhSb
         yTpSlGDsdvPkgTTyuYukE9XmCN4jnHmtBOOF89wooC19TlT46lX3yJ4QK5n5dwCGUy4X
         DLUmiZKlGQRG9v3uWReGQmKt2hglyGX4tM1S7Dwzz0BBYX247SU+NM9tHNcaY0zRG77Y
         DeWA==
X-Gm-Message-State: APjAAAVCwHBpoU3Xnl/6kE2RkzKXwOKzst+i8z9adbxHKu9PoW5B8ytz
        4dgUl/7RcO4bTcCKsTT5fys=
X-Google-Smtp-Source: APXvYqxhuEBampZH58CclwuTP9N5tFu9bvB28ZpeGtTT7BqBw2H4zmskwdtb77ZUDDA8XlW0VJQ+Hg==
X-Received: by 2002:a1c:7611:: with SMTP id r17mr17515679wmc.98.1554732925674;
        Mon, 08 Apr 2019 07:15:25 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-29-11.as13285.net. [92.22.29.11])
        by smtp.gmail.com with ESMTPSA id b204sm19184506wmh.29.2019.04.08.07.15.24
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 07:15:25 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] commit/reset: try to clean up sequencer state
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20190329163009.493-1-phillip.wood123@gmail.com>
 <20190329163009.493-2-phillip.wood123@gmail.com>
 <xmqq36n2yvr8.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <1a3cf9ed-69ff-d961-e62b-a38b45913411@gmail.com>
Date:   Mon, 8 Apr 2019 15:15:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqq36n2yvr8.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 01/04/2019 09:28, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When cherry-picking or reverting a sequence of commits and if the final
>> pick/revert has conflicts and the user uses `git commit` to commit the
>> conflict resolution and does not run `git cherry-pick --continue` then
>> the sequencer state is left behind. This can cause problems later. In my
>> case I cherry-picked a sequence of commits the last one of which I
>> committed with `git commit` after resolving some conflicts, then a while
>> later, on a different branch I aborted a revert which rewound my HEAD to
>> the end of the cherry-pick sequence on the previous branch.
> 
> I've certainly seen this myself.  Do you use command line prompt
> support to remind you of the operation in progress?  I do, and I
> have a suspicion that it did not help me in this situation by
> ceasing to tell me that I have leftover state files after a manual
> commit of the final step that conflicted and gave control back to
> me.

Same here, the prompt I use just checks for the presence of 
CHERRY_PICK_HEAD which disappears after committing.

> And detecting that we are finishing the last step and making sure
> that the state files are removed does sound like the right approach
> to fix it.
> 
>> diff --git a/branch.c b/branch.c
>> index 28b81a7e02..9ed60081c1 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -5,6 +5,7 @@
>>   #include "refs.h"
>>   #include "refspec.h"
>>   #include "remote.h"
>> +#include "sequencer.h"
>>   #include "commit.h"
>>   #include "worktree.h"
>>   
>> @@ -339,8 +340,10 @@ void create_branch(struct repository *r,
>>   
>>   void remove_branch_state(struct repository *r)
>>   {
>> -	unlink(git_path_cherry_pick_head(r));
>> -	unlink(git_path_revert_head(r));
>> +	if (!unlink(git_path_cherry_pick_head(r)))
>> +		sequencer_post_commit_cleanup();
>> +	if (!unlink(git_path_revert_head(r)))
>> +		sequencer_post_commit_cleanup();
> 
> This and the same one in builtin/commit.c feels a bit iffy.  If we
> had CHERRY_PICK_HEAD or REVERT_HEAD and attempted to remove one or
> the other, whether the removal succeeds or fails (perhaps a virus
> scanner on Windows had the file open while we tried to unlink it,
> causing the unlink() to fail), don't we want the clean-up to happen?

Good point, I could add '|| errno == ENOENT' to the if or just use 
file_exists() as you suggest below

>> @@ -1678,6 +1680,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>   	if (amend && !no_post_rewrite) {
>>   		commit_post_rewrite(the_repository, current_head, &oid);
>>   	}
>> +
> 
> This is an unrelated change.

Oops I'm not sure where that came from

>>   	if (!quiet) {
>>   		unsigned int flags = 0;
>>   
>> diff --git a/sequencer.c b/sequencer.c
>> index 0db410d590..028699209f 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -2220,6 +2220,29 @@ static ssize_t strbuf_read_file_or_whine(struct strbuf *sb, const char *path)
>>   	return len;
>>   }
>>   
>> +void sequencer_post_commit_cleanup(void)
>> +{
>> +	struct replay_opts opts = REPLAY_OPTS_INIT;
>> +	struct strbuf buf = STRBUF_INIT;
>> +	const char *eol;
>> +	const char *todo_path = git_path_todo_file();
>> +
>> +	if (strbuf_read_file(&buf, todo_path, 0) < 0) {
>> +		if (errno == ENOENT) {
>> +			return;
>> +		} else {
>> +			error_errno("unable to open '%s'", todo_path);
>> +			return;
>> +		}
>> +	}
>> +	/* If there is only one line then we are done */
>> +	eol = strchr(buf.buf, '\n');
>> +	if (!eol || !eol[1])
>> +		sequencer_remove_state(&opts);
>> +
>> +	strbuf_release(&buf);
>> +}
> 
> I find this helper doing a bit too much and a bit too little at the
> same time.  To reduce the iffiness I mentioned earlier, the callers
> would behefit to have a helper that
> 
>   - notices the need to remove CHERRY_PICK_HEAD or REVERT_HEAD, and
>     returns without doing anything if there is no need;
> 
>   - remove the *_HEAD file.
> 
>   - detect if we have dealt with the last step, and returns without
>     doing any more thing if there are more to do;
> 
>   - remove the state files.
> 
> IOW, replace the existing series of two unlink() calls with a single
> call to the helper.
> 
> On the other hand, the bulk of hand-rolled logic to determine if we
> have processed the last step is better done in another helper
> function that helps this helper, i.e.
> 
> 	void sequencer_post_commit_cleanup(struct repo *r)
> 	{
> 		int need_cleanup = 0;
> 
> 		if (file_exists(git_path_cherry_pick_head(r)) {
> 			unlink(git_path_cherry_pick_head(r));
> 			need_cleanup = 1;
> 		}
> 		if (file_exists(git_path_revert_head(r)) {
> 			unlink(git_path_revert_head(r));
> 			need_cleanup = 1;
> 		}
> 		if (!need_cleanup)
> 			return;
> 		if (!have_finished_the_last_pick())
> 			return;
> 		sequencer_remove_state(&opts);
> 	}
> 
> as that makes it easier to follow the logic of what is going on at
> this level, while at the same time making the logic in the
> have_finished_the_last_pick() helper easier to read by giving it a
> meaningful name.

Thanks that definitely improves things, I'll send a re-roll

Best Wishes

Phillip
