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
	by dcvr.yhbt.net (Postfix) with ESMTP id 772061F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 15:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfJKPjR (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 11:39:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43632 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfJKPjR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 11:39:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id j18so12428019wrq.10
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dWyuvPdneDXp4ILxZfGfZk7JmKWe27GUiGxo8CdNnCQ=;
        b=Vo+DgAg9klLYgSiY6auqwVmD7GdMvgBbxwUs1F1GGjWCdP6Pl+jp+RmrMa8yboMq2+
         FYjnEW9LwCUXUBXjlr354wtrb/guAvAQCmYVKzQe7ilMd4YyBdFYjejYIIDBzGDYGkI6
         HlAmYvokQIvBhpZogndWcD595n+cOGMkOeJ9wWv+IJDB2l7I/ZP0k/3afoGb9X/jol0G
         X6I9bLBs5r1/ETpZQMsDE9mlflIdLrD2d8pCf51PSeyxNzxo5nbKtPr/UKu0JfOYJ8IT
         74ZH29ZHdbw6We+iE7v8KLjWko7lh4PVFKlxX4h2kcN4TsfVSiJuGKndf/PybB8KOU6m
         c8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dWyuvPdneDXp4ILxZfGfZk7JmKWe27GUiGxo8CdNnCQ=;
        b=NY/GuUeO1OclEiOWlfDvmYvXBKsOeYVzZNi54CxUfe7pWpAdQUReo6Q7Lqm7srCZML
         JyMHZ/M5Gvv39GzHxPbcXxXGyaJqZu7udFMvT2YTKouHjBpvIFgbDfo7N2C37j8fX1lN
         QymbVFfGe4qcbw7vY3YMCZ2MK1razStuCDAEJfWnjWhwqUltuop3w+HP6jrbUp2Lc0Iu
         Wf2iHZKdMrB2kPh2qTsDdrWoykkrLTNnLtPbaVmCRDWT0MwDTb806/J6/8AO66zRg2BN
         VDeztketlr6P4tVoZ53qcenXLC62pCmE3hWnG5ik9XcNQ1sBxu6lRDoyMIglsLFN2nqE
         54ZA==
X-Gm-Message-State: APjAAAXysCewjaHAWe9yC+YaXOw2rCj5O26KQZY343NYwcr4ikrJNkjz
        PZ1POA/zKeYy64TudxwJayA=
X-Google-Smtp-Source: APXvYqyUm5+hyLebUZ4C2OoQ61NPFX9sQDpbHPS5oasyekErolfmRX8Q1NELyL8bsea3+H8rB6Rtpw==
X-Received: by 2002:adf:ecce:: with SMTP id s14mr13210389wro.47.1570808352924;
        Fri, 11 Oct 2019 08:39:12 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-28-119.as13285.net. [92.22.28.119])
        by smtp.gmail.com with ESMTPSA id u6sm12332711wrt.92.2019.10.11.08.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 08:39:12 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] sequencer: run post-commit hook
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.388.git.gitgitgadget@gmail.com>
 <acaa086a4860b6853bc0f35dae7fcf07d3aa59e7.1570732608.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1910102324140.46@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0692ed53-6ea4-18d4-ce60-7fbd82d2685c@gmail.com>
Date:   Fri, 11 Oct 2019 16:39:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910102324140.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 10/10/2019 22:31, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Thu, 10 Oct 2019, Phillip Wood via GitGitGadget wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Prior to commit 356ee4659b ("sequencer: try to commit without forking
>> 'git commit'", 2017-11-24) the sequencer would always run the
>> post-commit hook after each pick or revert as it forked `git commit` to
>> create the commit. The conversion to committing without forking `git
>> commit` omitted to call the post-commit hook after creating the commit.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Makes sense.
> 
>> ---
>>   builtin/commit.c              |  2 +-
>>   sequencer.c                   |  5 +++++
>>   sequencer.h                   |  1 +
>>   t/t3404-rebase-interactive.sh | 17 +++++++++++++++++
>>   4 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index d898a57f5d..adb8c89c60 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1653,7 +1653,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>
>>   	repo_rerere(the_repository, 0);
>>   	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
>> -	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
>> +	run_post_commit_hook(use_editor, get_index_file());
> 
> Does it really make sense to abstract the hook name away? It adds a lot
> of churn for just two callers...

I'll drop the new function in the reroll

>>   	if (amend && !no_post_rewrite) {
>>   		commit_post_rewrite(the_repository, current_head, &oid);
>>   	}
>> diff --git a/sequencer.c b/sequencer.c
>> index 3ce578c40b..b4947f6969 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -1173,6 +1173,10 @@ static int run_prepare_commit_msg_hook(struct repository *r,
>>   	return ret;
>>   }
>>
>> +void run_post_commit_hook(int editor_is_used, const char *index_file) {
>> +	run_commit_hook(editor_is_used, index_file, "post-commit", NULL);
>> +}
>> +
> 
> If we must have a separate `run_post_commit_hook()`, then it should be
> an `inline` function, defined in the header. Or even a macro to begin
> with.
> 
>>   static const char implicit_ident_advice_noconfig[] =
>>   N_("Your name and email address were configured automatically based\n"
>>   "on your username and hostname. Please check that they are accurate.\n"
>> @@ -1427,6 +1431,7 @@ static int try_to_commit(struct repository *r,
>>   		goto out;
>>   	}
>>
>> +	run_post_commit_hook(0, r->index_file);
> 
> So this is the _actual_ change of this patch.
> 
>>   	if (flags & AMEND_MSG)
>>   		commit_post_rewrite(r, current_head, oid);
>>
>> diff --git a/sequencer.h b/sequencer.h
>> index b0419d6ddb..e3e73c5635 100644
>> --- a/sequencer.h
>> +++ b/sequencer.h
>> @@ -203,4 +203,5 @@ int sequencer_get_last_command(struct repository* r,
>>   			       enum replay_action *action);
>>   LAST_ARG_MUST_BE_NULL
>>   int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
>> +void run_post_commit_hook(int editor_is_used, const char *index_file);
>>   #endif /* SEQUENCER_H */
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index d2f1d5bd23..d9217235b6 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -1467,4 +1467,21 @@ test_expect_success 'valid author header when author contains single quote' '
>>   	test_cmp expected actual
>>   '
>>
>> +test_expect_success 'post-commit hook is called' '
>> +	test_when_finished "rm -f .git/hooks/post-commit commits" &&
>> +	mkdir -p .git/hooks &&
>> +	write_script .git/hooks/post-commit <<-\EOS &&
>> +	git rev-parse HEAD >>commits
> 
> Should `commits` be initialized before this script is written, e.g.
> using
> 
> 	>commits &&

Good point, especially if it is renamed to actual as Junio suggests

>> +	EOS
>> +	set_fake_editor &&
> 
> The `set_fake_editor` function sets a global environment variable, and
> therefore needs to be run in a subshell. Therefore, this line (as well
> as the next one) need to be enclosed in `( ... )`.

There are ~80 instances of 
set_fake_editor/test_set_editor/set_cat_todo_editor in that file that 
are not in subshells. I've converted them in a preparatory patch (that 
was fun), removing about 20 that can now safely rely on EDITOR=: 
(hopefully that will ameliorate the performance hit of ~60 extra 
subshells a little)

>> +	FAKE_LINES="edit 4 1 reword 2 fixup 3" git rebase -i A E &&
>> +	echo x>file3 &&
> 
> We usually leave no space after the `>`, but we _do_ leave a space
> _before_ the `>`.
> 
>> +	git add file3 &&
>> +	FAKE_COMMIT_MESSAGE=edited git rebase --continue &&
>> +	# rev-list does not support -g --reverse
>> +	git rev-list --no-walk=unsorted HEAD@{5} HEAD@{4} HEAD@{3} HEAD@{2} \
>> +		HEAD@{1} HEAD >expected &&
> 
> Wouldn't this be better as:
> 
> 	git rev-parse HEAD@{5} HEAD@{4} HEAD@{3} HEAD@{2} HEAD@{1} HEAD \
> 		>expect &&

Good point

>> +	test_cmp expected commits
> 
> We usually use the name `expect` instead of `expected` in the test
> suite.

OK

Thanks for looking at this series

Phillip

> Thanks,
> Dscho
> 
>> +'
>> +
>>   test_done
>> --
>> gitgitgadget
>>
