Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CC001F516
	for <e@80x24.org>; Fri, 22 Jun 2018 00:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933478AbeFVAd5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 20:33:57 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:41573 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933379AbeFVAd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 20:33:56 -0400
Received: by mail-qt0-f176.google.com with SMTP id y20-v6so4592690qto.8
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 17:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=IuaDUdERNi1Q6XDeD+xUW6iKPORIgt/pwdHoXDc6X5s=;
        b=bYWf8IVHf07krv1atYnkpKluiXhtLz0FPXdn0hUHF3K54hEi8976yftH+NnDG3ovur
         EF7O7EnOGr7SHEingi3WosjCpr5S9vhpIW/9BsG7SYcup57KsiUGnzSWJeHljbwbcbFo
         wfBXupzwe6X2gZ/I553CDP9/6ZgycEPSoDlpW3Pd1Q3EGwKKhoXO8gWN7w8N8JieQxv1
         en47Yijm4xQN68HSr7kGOWIt9x5p45BAJINHR78baptZQQHRyPwZOO5MIPKvQpXpHHDx
         CqnYjzr83dVsstS1lorfVtxTB0iUj9GcyZxOiOKHfQIrW9f5P6KOiai4JZUVYa+I9fts
         eW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IuaDUdERNi1Q6XDeD+xUW6iKPORIgt/pwdHoXDc6X5s=;
        b=MGGSIRoAZhuZj+cpfqR14dttikbr7tvwXKKelGrUx0XLGqJ8kt/QtYVVewts5YQMJQ
         m3hMb9J6U/6idYW5Q4GN5f2u14KN4w6G+vGJj1mYV6AELKqKpdykwyNqfUh34tdVq7j7
         sL5TNtuTYbRoKz6q+ri81XiqX8/65d30xYvl7JKwRWhu/V4nyuyjYlmDCV3BSWRgA5AD
         IpqykgdYHsk9tG9IOEdV+ymePWKufSQJHD10Rf6AZOEB2mkP3AdFlw6fE3g//ZBridbj
         7Ld62uN3hFDNgh7SZc0X1YdENvbHR5pVaQHnGYn27aijDPlfVMO3K6MYn2WtkDuM0x11
         Jaog==
X-Gm-Message-State: APt69E3hXwj13pWpalR67VTE0DE0v/IKKFQNSIvYIEyIHSDw4h71zzDK
        aYgdR8PvkzqZQ48yruChNozR4gwh
X-Google-Smtp-Source: ADUXVKIOuC8zZ8yH4OKx2MAwtky7nN/b0rso0XiMlphwjqzk8kcg0vM2jLiBIUE/URH+111IR9BBxw==
X-Received: by 2002:a0c:d276:: with SMTP id o51-v6mr24623496qvh.182.1529627635606;
        Thu, 21 Jun 2018 17:33:55 -0700 (PDT)
Received: from [10.0.1.20] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id m15-v6sm5141088qtm.84.2018.06.21.17.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 17:33:55 -0700 (PDT)
Subject: Re: [PATCH 5/5] commit-graph: add repo arg to graph readers
To:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Cc:     git@vger.kernel.org
References: <CAGZ79kYYD48PQiSqjqHkrqX9stKbGmEAHc1ArsuUgSHhwv5=Vw@mail.gmail.com>
 <20180621230608.86117-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d7a42ecf-7261-ec14-5736-b1f9bc70ba64@gmail.com>
Date:   Thu, 21 Jun 2018 20:33:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180621230608.86117-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/21/2018 7:06 PM, Jonathan Tan wrote:
>>> diff --git a/commit.c b/commit.c
>>> index 0030e79940..38c12b002f 100644
>>> --- a/commit.c
>>> +++ b/commit.c
>>> @@ -317,7 +317,7 @@ struct tree *get_commit_tree(const struct commit *commit)
>>>          if (commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
>>>                  BUG("commit has NULL tree, but was not loaded from commit-graph");
>>>
>>> -       return get_commit_tree_in_graph(commit);
>>> +       return get_commit_tree_in_graph(the_repository, commit);
>> Here..
>>
>>>   }
>>>
>>>   struct object_id *get_commit_tree_oid(const struct commit *commit)
>>> @@ -413,7 +413,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
>>>                  return -1;
>>>          if (item->object.parsed)
>>>                  return 0;
>>> -       if (parse_commit_in_graph(item))
>>> +       if (parse_commit_in_graph(the_repository, item))
>> and here
>>
>>> +static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
>>> +                                      const struct object_id *commit_oid)
>>> +{
>>> +       struct repository r;
>>> +       struct commit *c;
>>> +       struct commit_list *parent;
>>> +
>>> +       /*
>>> +        * Create a commit independent of any repository.
>>> +        */
>>> +       c = lookup_commit(commit_oid);
>> .. and this one are unfortunate as the rest of the object store series
>> has not progressed as far as needed.
> I think the first 2 are in reverse - get_commit_tree depends on
> get_commit_tree_in_graph and parse_commit_gently depends on
> parse_commit_in_graph, so we need the commit-graph functions to be
> changed first. But I agree about lookup_commit.
>
>> The lookup_commit series is out there already, and that will
>> teach lookup_commit a repository argument. When rerolling
>> that series I need to switch the order of repo_init and lookup_commit
>> such that we can pass the repo to the lookup.
> For future reference, Stefan is talking about this series:
> https://public-inbox.org/git/20180613230522.55335-1-sbeller@google.com/
>
> Let me know if you want to reroll yours on top of mine, or vice versa. I
> think it's clearer if mine goes in first, though, since (as you said in
> that e-mail) parse_commit depends on this change in the commit graph.

I was about to comment that I thought 'parse_commit_in_graph' should 
take a 'struct commit_graph' instead of 'struct repository', except for 
these lookup_commit() calls will need the repository parameter.

Please also keep in mind that ds/commit-graph-fsck has already updated 
this method to parse from a specific graph [1]. I'm just waiting for 
some things like ds/generation-numbers to get into 'master' and some 
more object-store patches to be final before I re-roll that series. I 
mentioned this in a message that I had sent, but apparently didn't make 
it on the list (so I re-sent it recently).

[1] 
https://public-inbox.org/git/20180608135548.216405-4-dstolee@microsoft.com/

>> This is really nice!
>>
>> Overall this series looks good to me,
>> Stefan
> Thanks - let's see what others think.
