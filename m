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
	by dcvr.yhbt.net (Postfix) with ESMTP id A96A31F45C
	for <e@80x24.org>; Tue, 13 Aug 2019 12:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfHMMJv (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 08:09:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43050 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfHMMJv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 08:09:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id y8so1579894wrn.10
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 05:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yHXCFoZzVKOqOxrYODSHxn8P053dU8EulT2NvlddE6M=;
        b=No2uIG40ATBGehfTfrW+h40ZIaRlX2RcGx20l+OtsRocdQNwklk8zJyDxU9b9zfEmT
         jKHFtBgKdYsB6FXddp5ShCRD8VecDXBiEL+WSxssgJHpK2zfHvKTi2R4qxR93H0MigEE
         MDXDvuFRcn4PkTdZnS/BwBgQvxUTA4kUCzjeLhnXLr0GhtHCAwEFuTkt+xW/rtZCndoT
         nCSM0pWukNwQkz3b66i+Ypz8PYMUcckR9PE0MzNaNVwgciSLoErT9yTab6/uja4uRgIX
         xIhCR/lGQ8xi7xHcfZRxZz8Hf5ddS5J4BoBmMERMHkaLknTKB4CYY20qEIeqUOgd94wD
         wXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yHXCFoZzVKOqOxrYODSHxn8P053dU8EulT2NvlddE6M=;
        b=n0CsQ9+COtzsgVVdzgAvv9lWU8En9Th8UDvFJNuqswsNR4rpfwlRGXu5O6JrIostxU
         GDF3R9kbjmvT4v2zdxFimeOFf9q3ei1s2IWxdSeGCVTxgrPfNio0KBad3C5KM37ica0B
         jzH9UfK7m42Ih9oiylJoVKhuzgs1KqAwQDweJiv8arcTVLXTJLavcuilSnGhU+qHD5Ib
         pQmUf31qWpg18qsTiPxSOBLBOiui3kG5nQvDttDLtp27bLtk8PRlpkr0wHfZdCBlfmJc
         d7j5H7bXrT31Y4EM3mzPh5QhM5soNB3U8CK7rq69VnNFpGVXfPH4jrCwEYVYXgHO9irq
         Cs2w==
X-Gm-Message-State: APjAAAVJF/hhstGLbSyFeF3moiULGto71sW9S2lC3NNYsmE5PuMC7OXJ
        ysitbbpXj68iFgqT8Vwc7eA=
X-Google-Smtp-Source: APXvYqwuxlmBeb8GmS0PgFK5I7svYNfPCZldI5lz9amqmu9r/ohSlO5rHZLAiuRck1tpZ3+dDSHM5w==
X-Received: by 2002:adf:dbcc:: with SMTP id e12mr36895186wrj.205.1565698188623;
        Tue, 13 Aug 2019 05:09:48 -0700 (PDT)
Received: from [192.168.1.18] (host-78-148-43-8.as13285.net. [78.148.43.8])
        by smtp.gmail.com with ESMTPSA id r23sm1498882wmc.38.2019.08.13.05.09.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 05:09:48 -0700 (PDT)
Subject: Re: [GSoC][PATCH v2 3/6] rebase -i: support
 --committer-date-is-author-date
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
 <20190812194301.5655-4-rohit.ashiwal265@gmail.com>
 <7274e753-f75c-ad9a-9c2c-7ba8abc32971@gmail.com>
Message-ID: <f34a6bf7-8725-774c-5fde-0349bc8565bd@gmail.com>
Date:   Tue, 13 Aug 2019 13:09:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7274e753-f75c-ad9a-9c2c-7ba8abc32971@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/08/2019 11:38, Phillip Wood wrote:
> Hi Rohit
> 
> [...]
>> @@ -964,6 +976,25 @@ static int run_git_commit(struct repository *r,
>>   {
>>       struct child_process cmd = CHILD_PROCESS_INIT;
>> +    if (opts->committer_date_is_author_date) {
>> +        size_t len;
>> +        int res = -1;
>> +        struct strbuf datebuf = STRBUF_INIT;
>> +        char *date = read_author_date_or_null();
> 
> You must always check the return value of functions that might return 
> NULL. In this case we should return an error as you do in try_to 
> _commit() later
> 
>> +
>> +        strbuf_addf(&datebuf, "@%s", date);
> 
> GNU printf() will add something like '(null)' to the buffer if you pass 
> a NULL pointer so I don't think we can be sure that this will not 
> increase the length of the buffer if date is NULL.

I should have added that passing NULL to snprintf() and friends is going 
to be undefined behavior anyway so you shouldn't do it for that reason 
alone.

Best Wishes

Phillip

  An explicit check
> above would be much clearer as well rather than checking len later. What 
> happens if you don't add the '@' at the beginning? (I'm don't know much 
> about git's date handling)
> 
>> +        free(date);
>> +
>> +        date = strbuf_detach(&datebuf, &len);
>> +
>> +        if (len > 1)
>> +            res = setenv("GIT_COMMITTER_DATE", date, 1);
>> +
>> +        free(date);
>> +
>> +        if (res)
>> +            return -1;
>> +    }
>>       if ((flags & CREATE_ROOT_COMMIT) && !(flags & AMEND_MSG)) {
>>           struct strbuf msg = STRBUF_INIT, script = STRBUF_INIT;
>>           const char *author = NULL;
>> @@ -1400,7 +1431,6 @@ static int try_to_commit(struct repository *r,
>>       if (parse_head(r, &current_head))
>>           return -1;
>> -
>>       if (flags & AMEND_MSG) {
>>           const char *exclude_gpgsig[] = { "gpgsig", NULL };
>>           const char *out_enc = get_commit_output_encoding();
>> @@ -1427,6 +1457,21 @@ static int try_to_commit(struct repository *r,
>>           commit_list_insert(current_head, &parents);
>>       }
>> +    if (opts->committer_date_is_author_date) {
>> +        int len = strlen(author);
>> +        struct ident_split ident;
>> +        struct strbuf date = STRBUF_INIT;
>> +
>> +        split_ident_line(&ident, author, len);
>> +
>> +        if (!ident.date_begin)
>> +            return error(_("corrupted author without date 
>> information"));
> 
> We return an error if we cannot get the date - this is exactly what we 
> should be doing above. It is also great to see a single version of this 
> being used whether or not we are amending.
> 
>> +
>> +        strbuf_addf(&date, "@%s",ident.date_begin);
> 
> I think we should use %s.* and ident.date_end to be sure we getting what 
> we want. Your version is OK if the author is formatted correctly but I'm 
> uneasy about relying on that when we can get the verified end from ident.
> 
> Best Wishes
> 
> Phillip
> 
>> +        setenv("GIT_COMMITTER_DATE", date.buf, 1);
>> +        strbuf_release(&date);
>> +    }
>> +
>>       if (write_index_as_tree(&tree, r->index, r->index_file, 0, NULL)) {
>>           res = error(_("git write-tree failed to write a tree"));
>>           goto out;
>> @@ -2542,6 +2587,11 @@ static int read_populate_opts(struct 
>> replay_opts *opts)
>>               opts->signoff = 1;
>>           }
>> +        if (file_exists(rebase_path_cdate_is_adate())) {
>> +            opts->allow_ff = 0;
>> +            opts->committer_date_is_author_date = 1;
>> +        }
>> +
>>           if (file_exists(rebase_path_reschedule_failed_exec()))
>>               opts->reschedule_failed_exec = 1;
>> @@ -2624,6 +2674,8 @@ int write_basic_state(struct replay_opts *opts, 
>> const char *head_name,
>>           write_file(rebase_path_gpg_sign_opt(), "-S%s\n", 
>> opts->gpg_sign);
>>       if (opts->signoff)
>>           write_file(rebase_path_signoff(), "--signoff\n");
>> +    if (opts->committer_date_is_author_date)
>> +        write_file(rebase_path_cdate_is_adate(), "%s", "");
>>       if (opts->reschedule_failed_exec)
>>           write_file(rebase_path_reschedule_failed_exec(), "%s", "");
>> @@ -3821,7 +3873,8 @@ static int pick_commits(struct repository *r,
>>       setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
>>       if (opts->allow_ff)
>>           assert(!(opts->signoff || opts->no_commit ||
>> -                opts->record_origin || opts->edit));
>> +                opts->record_origin || opts->edit ||
>> +                opts->committer_date_is_author_date));
>>       if (read_and_refresh_cache(r, opts))
>>           return -1;
>> diff --git a/sequencer.h b/sequencer.h
>> index 6704acbb9c..e3881e9275 100644
>> --- a/sequencer.h
>> +++ b/sequencer.h
>> @@ -43,6 +43,7 @@ struct replay_opts {
>>       int verbose;
>>       int quiet;
>>       int reschedule_failed_exec;
>> +    int committer_date_is_author_date;
>>       int mainline;
>> diff --git a/t/t3422-rebase-incompatible-options.sh 
>> b/t/t3422-rebase-incompatible-options.sh
>> index 4342f79eea..7402f7e3da 100755
>> --- a/t/t3422-rebase-incompatible-options.sh
>> +++ b/t/t3422-rebase-incompatible-options.sh
>> @@ -61,7 +61,6 @@ test_rebase_am_only () {
>>   }
>>   test_rebase_am_only --whitespace=fix
>> -test_rebase_am_only --committer-date-is-author-date
>>   test_rebase_am_only -C4
>>   test_expect_success REBASE_P '--preserve-merges incompatible with 
>> --signoff' '
>> diff --git a/t/t3433-rebase-options-compatibility.sh 
>> b/t/t3433-rebase-options-compatibility.sh
>> index 2e16e00a9d..b2419a2b75 100755
>> --- a/t/t3433-rebase-options-compatibility.sh
>> +++ b/t/t3433-rebase-options-compatibility.sh
>> @@ -7,6 +7,9 @@ test_description='tests to ensure compatibility 
>> between am and interactive backe
>>   . ./test-lib.sh
>> +GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
>> +export GIT_AUTHOR_DATE
>> +
>>   # This is a special case in which both am and interactive backends
>>   # provide the same output. It was done intentionally because
>>   # both the backends fall short of optimal behaviour.
>> @@ -62,4 +65,20 @@ test_expect_success '--ignore-whitespace works with 
>> interactive backend' '
>>       test_cmp expect file
>>   '
>> +test_expect_success '--committer-date-is-author-date works with am 
>> backend' '
>> +    git commit --amend &&
>> +    git rebase --committer-date-is-author-date HEAD^ &&
>> +    git show HEAD --pretty="format:%ai" >authortime &&
>> +    git show HEAD --pretty="format:%ci" >committertime &&
>> +    test_cmp authortime committertime
>> +'
>> +
>> +test_expect_success '--committer-date-is-author-date works with 
>> interactive backend' '
>> +    git commit --amend &&
>> +    git rebase -i --committer-date-is-author-date HEAD^ &&
>> +    git show HEAD --pretty="format:%ai" >authortime &&
>> +    git show HEAD --pretty="format:%ci" >committertime &&
>> +    test_cmp authortime committertime
>> +'
>> +
>>   test_done
>>
