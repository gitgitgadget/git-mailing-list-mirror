Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72DAC1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 16:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404123AbfHHQxP (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 12:53:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40009 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403910AbfHHQxP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 12:53:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so95571519wrl.7
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fvgqlt5njOD0RfTd+OCAy3/xju+JmtWNfwW5ATo5GBw=;
        b=Th7b2SYZ14CVKnp9V5t1EzFXjCJdWgha7y+YEXcFQiY2PTfpXK0Gf3rm1tIQx7ZZgS
         QNsRKPvFNlMnCNqBP9MHP516IRk7Y5Jqc8FqLSe+2t/h/gzdURCWNBTlHOt58fXMquOM
         I755EIbB8RwZ0/5LxwCMpNgiDZY2BkY88NjNjw9fCZ7ipm/0MwuFbhiDCrdxMPqwEhQ9
         FgY7iQxtNG7D0oYbXyPpW/uYRuI3jHEN44Ikn9ES6BuUy+UJJmlRMmUYlV23uhjAyiHZ
         bsUfSN7154nO+l2a+OejUjXncDaQR2OiYZTv5W8GOhI3PpCrbKoMWNpSIHPwqZil/GAo
         WnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fvgqlt5njOD0RfTd+OCAy3/xju+JmtWNfwW5ATo5GBw=;
        b=eqEtBTBkOQz8CPBxnEdRdEn5/McMR83sb3QB/5MY3hb5tao091OqrL2UfFqM4cLJON
         v4hAHF9sPoyszhJ9W4TFizqxeDnMGBF+7T4K91lvU2LVYf00oUbmZ/TjlZqFu76Y9isW
         EKPclF/ENIB2UbACwt+HTzJ648he7rYJS1n4HqPUt+pdGSpybFh2dPcv/i646JkeO995
         b3OD9WJV8ech8L99coZxaBujKtWEMDLOmxZ3Fubz2zbdXfQsdTxCECl3qUG3BNH4SbH/
         OQ/KLfbNTqBrp0ziMXdfqa/EUoHTK/UnCFnaUzwGq4vnkJVnAOLgcPbU62pEM2jkMGXF
         RUfw==
X-Gm-Message-State: APjAAAURDB9GVsaNhe27vOd16dfg08Nz/uOQz5aztVV1RrtzJEYud6pj
        uOdxeqXoiDuMgyxlxKSR7PlD06uY
X-Google-Smtp-Source: APXvYqzVd9rWSTqd4aXDW0i1vc1RXWC2Di8mjBDMcPCxDP6KeKntgljbfK9fNiMlpBg0FoWsGcWnuA==
X-Received: by 2002:adf:c70e:: with SMTP id k14mr18911467wrg.201.1565283191638;
        Thu, 08 Aug 2019 09:53:11 -0700 (PDT)
Received: from [192.168.1.18] (host-78-148-43-8.as13285.net. [78.148.43.8])
        by smtp.gmail.com with ESMTPSA id w7sm2745824wrr.71.2019.08.08.09.53.10
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 09:53:11 -0700 (PDT)
Subject: Re: [GSoC][PATCHl 5/6] rebase -i: support --ignore-date
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Junio <gitster@pobox.com>, GIT Mailing List <git@vger.kernel.org>
Cc:     Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>,
        Dscho <Johannes.Schindelin@gmx.de>,
        Martin <martin.agren@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190806173638.17510-6-rohit.ashiwal265@gmail.com>
 <0619f7b7-a7e5-54a2-3d28-ac359139bde7@gmail.com>
Message-ID: <24577efb-a959-04b1-c202-284571c5505e@gmail.com>
Date:   Thu, 8 Aug 2019 17:53:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0619f7b7-a7e5-54a2-3d28-ac359139bde7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-HK
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08/2019 12:42, Phillip Wood wrote:
> On 06/08/2019 18:36, Rohit Ashiwal wrote:
>> rebase am already has this flag to "lie" about the author date
>> by changing it to the committer (current) date. Let's add the same
>> for interactive machinery.
>>
>> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
>> ---
 >> [...[
>>   static const char staged_changes_advice[] =
>>   N_("you have staged changes in your working tree\n"
>>   "If these changes are meant to be squashed into the previous commit, 
>> run:\n"
>> @@ -985,7 +997,7 @@ static int run_git_commit(struct repository *r,
>>   {
>>       struct child_process cmd = CHILD_PROCESS_INIT;
>> -    if (opts->committer_date_is_author_date &&
>> +    if (opts->committer_date_is_author_date && !opts->ignore_date &&
>>           setenv_committer_date_to_author_date())
>>           return 1;
> 
> We read the author script again just below, can set the committer date 
> there by parsing the author string, that would mean you could use the 
> same function that works on an author string in try_to_commit() (this 
> comment should be on patch 3 I think)

It's a bit more complicated as you've done this to avoid the duplication 
in the previous version. I think it should be possible to do it by 
reading the author identity upfront (protected by 'if 
is_rebase_i(opts)') and processing it appropriately in the two code 
paths. (You might need to refactor some of the functions like 
read_env_script() to do this.) An alternative would be to refactor 
try_to_commit() so that it can create the root commit and delete the 
code here that does that.

Best Wishes

Phillip

> 
>>       if ((flags & CREATE_ROOT_COMMIT) && !(flags & AMEND_MSG)) {
>> @@ -1013,10 +1025,18 @@ static int run_git_commit(struct repository *r,
>>           if (res <= 0)
>>               res = error_errno(_("could not read '%s'"), defmsg);
>> -        else
>> +        else {
>> +            if (opts->ignore_date) {
>> +                if (!author)
>> +                    BUG("ignore-date can only be used with "
>> +                        "rebase -i, which must set the "
> 
> I know it's only a bug message but it's not just 'rebase -i' but 'rebase 
> -k', 'rebase -m' ... that use this code path, it would be better just to 
> say 'rebase'
> 
>> +                        "author before committing the tree");
>> +                ignore_author_date(&author);
>> +            }
>>               res = commit_tree(msg.buf, msg.len, cache_tree_oid,
>>                         NULL, &root_commit, author,
>>                         opts->gpg_sign);
>> +        }
>>           strbuf_release(&msg);
>>           strbuf_release(&script);
>> @@ -1046,6 +1066,8 @@ static int run_git_commit(struct repository *r,
>>           argv_array_push(&cmd.args, "--amend");
>>       if (opts->gpg_sign)
>>           argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
>> +    if (opts->ignore_date)
>> +        argv_array_pushf(&cmd.args, "--date=%ld", time(NULL));
> 
> I think this is racy as it only sets the author date, the committer date 
> may end up being different.
> 
>>       if (defmsg)
>>           argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
>>       else if (!(flags & EDIT_MSG))
>> @@ -1425,7 +1447,7 @@ static int try_to_commit(struct repository *r,
>>       if (parse_head(r, &current_head))
>>           return -1;
>>       if (!(flags & AMEND_MSG) && opts->committer_date_is_author_date &&
>> -        setenv_committer_date_to_author_date())
>> +        !opts->ignore_date && setenv_committer_date_to_author_date())
>>           return -1;
>>       if (flags & AMEND_MSG) {
>>           const char *exclude_gpgsig[] = { "gpgsig", NULL };
>> @@ -1447,7 +1469,7 @@ static int try_to_commit(struct repository *r,
>>               res = error(_("unable to parse commit author"));
>>               goto out;
>>           }
>> -        if (opts->committer_date_is_author_date) {
>> +        if (opts->committer_date_is_author_date && !opts->ignore_date) {
> 
> If we only handled committer_date_is_author_date in a single place it 
> wouldn't need to be changed twice in this patch
> 
>>               char *date;
>>               int len = strlen(author);
>>               char *idx = memchr(author, '>', len);
>> @@ -1507,6 +1529,11 @@ static int try_to_commit(struct repository *r,
>>       reset_ident_date();
>> +    if (opts->ignore_date) {
>> +        ignore_author_date(&author);
>> +        free(author_to_free);
>> +        author_to_free = (char *)author;
>> +    }
>>       if (commit_tree_extended(msg->buf, msg->len, &tree, parents,
>>                    oid, author, opts->gpg_sign, extra)) {
>>           res = error(_("failed to write commit object"));
>> @@ -2583,6 +2610,11 @@ static int read_populate_opts(struct 
>> replay_opts *opts)
>>               opts->committer_date_is_author_date = 1;
>>           }
>> +        if (file_exists(rebase_path_ignore_date())) {
>> +            opts->allow_ff = 0;
>> +            opts->ignore_date = 1;
>> +        }
>> +
>>           if (file_exists(rebase_path_reschedule_failed_exec()))
>>               opts->reschedule_failed_exec = 1;
>> @@ -2667,6 +2699,8 @@ int write_basic_state(struct replay_opts *opts, 
>> const char *head_name,
>>           write_file(rebase_path_signoff(), "--signoff\n");
>>       if (opts->committer_date_is_author_date)
>>           write_file(rebase_path_cdate_is_adate(), "%s", "");
>> +    if (opts->ignore_date)
>> +        write_file(rebase_path_ignore_date(), "%s", "");
>>       if (opts->reschedule_failed_exec)
>>           write_file(rebase_path_reschedule_failed_exec(), "%s", "");
>> @@ -3484,6 +3518,9 @@ static int do_merge(struct repository *r,
>>           argv_array_push(&cmd.args, git_path_merge_msg(r));
>>           if (opts->gpg_sign)
>>               argv_array_push(&cmd.args, opts->gpg_sign);
>> +        if (opts->ignore_date)
>> +            argv_array_pushf(&cmd.args,
>> +                     "GIT_AUTHOR_DATE=%ld", time(NULL));
>>           /* Add the tips to be merged */
>>           for (j = to_merge; j; j = j->next)
>> @@ -3756,7 +3793,8 @@ static int pick_commits(struct repository *r,
>>       if (opts->allow_ff)
>>           assert(!(opts->signoff || opts->no_commit ||
>>                   opts->record_origin || opts->edit ||
>> -                opts->committer_date_is_author_date));
>> +                opts->committer_date_is_author_date ||
>> +                opts->ignore_date));
>>       if (read_and_refresh_cache(r, opts))
>>           return -1;
>> diff --git a/sequencer.h b/sequencer.h
>> index e6cba468db..73d0515a3e 100644
>> --- a/sequencer.h
>> +++ b/sequencer.h
>> @@ -44,6 +44,7 @@ struct replay_opts {
>>       int quiet;
>>       int reschedule_failed_exec;
>>       int committer_date_is_author_date;
>> +    int ignore_date;
>>       int mainline;
>> diff --git a/t/t3433-rebase-options-compatibility.sh 
>> b/t/t3433-rebase-options-compatibility.sh
>> index ceab48a831..95d99c4b7b 100755
>> --- a/t/t3433-rebase-options-compatibility.sh
>> +++ b/t/t3433-rebase-options-compatibility.sh
>> @@ -81,4 +81,20 @@ test_expect_success 
>> '--committer-date-is-author-date works with interactive back
>>       test_cmp authortime committertime
>>   '
>> +# Checking for +0000 in author time is enough since default
>> +# timezone is UTC, but the timezone used while committing
>> +# sets to +0530.
> 
> That sounds potentially fragile but I guess the timezone is unlikely to 
> change in the future
> 
> Best Wishes
> 
> Phillip
> 
>> +test_expect_success '--ignore-date works with am backend' '
>> +    git commit --amend --date="$GIT_AUTHOR_DATE" &&
>> +    git rebase --ignore-date HEAD^ &&
>> +    git show HEAD --pretty="format:%ai" >authortime &&
>> +    grep "+0000" authortime
>> +'
>> +
>> +test_expect_success '--ignore-date works with interactive backend' '
>> +    git commit --amend --date="$GIT_AUTHOR_DATE" &&
>> +    git rebase --ignore-date -i HEAD^ &&
>> +    git show HEAD --pretty="format:%ai" >authortime &&
>> +    grep "+0000" authortime
>> +'
>>   test_done
>>
