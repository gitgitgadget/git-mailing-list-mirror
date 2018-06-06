Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40A0C1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 12:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752341AbeFFMpE (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 08:45:04 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35369 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752210AbeFFMpD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 08:45:03 -0400
Received: by mail-qt0-f194.google.com with SMTP id s9-v6so6139960qtg.2
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UccDGYna3vwDH57hAsZGgjU+65R1hBSTQu3mopU0Khs=;
        b=fM6B+W8Sy7e66dTAqaD0A7axojk8wBNpfqzhJIF+v2SbifmhqSL80+Mq2R9zo5WErg
         2nOraKDDJZvKn04+3ybvKkVxrZHjAT6+9h2zbB+XcVATtsT1kV9AH3UlzLEMsdkRkAny
         WuJ4N0nSeR2Q23WH76ZKm6YzTnEQp55U8ZG3IqePH2dqtsgvIadQ2vJo+JL2+2+TI3aS
         lTnU/khWfPw8u7hjEvib9N5k6Bmu/wYd2o7ewKYLT7vPPrFnbGclacBEPE5wCKwo/GY3
         SXl9ByHTduuTJ3PmyNY9uFiX6zpJ176XR6L6YA6l4bBGAvTVcaDE4otZMAGxlcCUERS1
         2L+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UccDGYna3vwDH57hAsZGgjU+65R1hBSTQu3mopU0Khs=;
        b=lkiAxkLkyrIV1ubkx+Sk3eeYS/4pNqAVquPFWtZtIFuK/QJH8VTEFzs8AmR7hZSu8W
         5PXuo+0gBxB0zYPvSQHpOXivwu9bUjjGkPYBlNCIWoRN0yGTNEZ47VNZvezoVq/HGGrg
         WRhzTUlGgqxsvlowdhwkeBV4FYpYDy/DT5zz+OepIWfuvpuCnwwYeocdtmRK3tobKyJ1
         8hnLYcORdPtoEZrC9viooxbG2oPB+xwqu+knFcht0V0Ks4Hchw91dKpxmD1X3jvhFKsv
         D0qky78a6iClhpItzJzsoBTM38/xj1QTnETwaEMywYNOrB1rBEnKxZEZuCehydV4yhl9
         L8/A==
X-Gm-Message-State: APt69E0TMIyUThNcWDcnQppYHFINl6LxEc+zEyhgLjS9xpXYXmUAKflQ
        JQLusiU1cGPW6Im344g/wKA=
X-Google-Smtp-Source: ADUXVKJvS9etsjbioPGUe1cFS092fjVeCbKzK8CnW9UL2NK+XZeM/QjmPYb2Wr/lJ83FxAwDzWQceg==
X-Received: by 2002:aed:3c27:: with SMTP id t36-v6mr2479117qte.398.1528289102579;
        Wed, 06 Jun 2018 05:45:02 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:519d:bedf:507e:40cb? ([2001:4898:8010:0:3ad3:bedf:507e:40cb])
        by smtp.gmail.com with ESMTPSA id t15-v6sm18540968qtc.66.2018.06.06.05.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 05:45:01 -0700 (PDT)
Subject: Re: [PATCH v5 18/21] commit-graph: use string-list API for input
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
 <20180606113611.87822-1-dstolee@microsoft.com>
 <20180606113611.87822-19-dstolee@microsoft.com>
 <87h8mgyv0f.fsf@evledraar.gmail.com>
 <aa4c3a93-0c63-f424-db0b-0e451bbaa91e@gmail.com>
 <87efhkyubq.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <548f9285-da68-478c-1423-a9b9b5021d97@gmail.com>
Date:   Wed, 6 Jun 2018 08:45:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87efhkyubq.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/6/2018 8:26 AM, Ævar Arnfjörð Bjarmason wrote:
> On Wed, Jun 06 2018, Derrick Stolee wrote:
>
>> On 6/6/2018 8:11 AM, Ævar Arnfjörð Bjarmason wrote:
>>> On Wed, Jun 06 2018, Derrick Stolee wrote:
>>>
>>>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>>>> ---
>>>>    builtin/commit-graph.c | 39 +++++++++++++--------------------------
>>>>    commit-graph.c         | 15 +++++++--------
>>>>    commit-graph.h         |  7 +++----
>>>>    3 files changed, 23 insertions(+), 38 deletions(-)
>>>> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>>>> index 3079cde6f9..d8eb8278b3 100644
>>>> --- a/builtin/commit-graph.c
>>>> +++ b/builtin/commit-graph.c
>>>> @@ -118,13 +118,9 @@ static int graph_read(int argc, const char **argv)
>>>>
>>>>    static int graph_write(int argc, const char **argv)
>>>>    {
>>>> -	const char **pack_indexes = NULL;
>>>> -	int packs_nr = 0;
>>>> -	const char **commit_hex = NULL;
>>>> -	int commits_nr = 0;
>>>> -	const char **lines = NULL;
>>>> -	int lines_nr = 0;
>>>> -	int lines_alloc = 0;
>>>> +	struct string_list *pack_indexes = NULL;
>>>> +	struct string_list *commit_hex = NULL;
>>>> +	struct string_list lines;
>>>>
>>>>    	static struct option builtin_commit_graph_write_options[] = {
>>>>    		OPT_STRING(0, "object-dir", &opts.obj_dir,
>>>> @@ -150,32 +146,23 @@ static int graph_write(int argc, const char **argv)
>>>>
>>>>    	if (opts.stdin_packs || opts.stdin_commits) {
>>>>    		struct strbuf buf = STRBUF_INIT;
>>>> -		lines_nr = 0;
>>>> -		lines_alloc = 128;
>>>> -		ALLOC_ARRAY(lines, lines_alloc);
>>>> -
>>>> -		while (strbuf_getline(&buf, stdin) != EOF) {
>>>> -			ALLOC_GROW(lines, lines_nr + 1, lines_alloc);
>>>> -			lines[lines_nr++] = strbuf_detach(&buf, NULL);
>>>> -		}
>>>> -
>>>> -		if (opts.stdin_packs) {
>>>> -			pack_indexes = lines;
>>>> -			packs_nr = lines_nr;
>>>> -		}
>>>> -		if (opts.stdin_commits) {
>>>> -			commit_hex = lines;
>>>> -			commits_nr = lines_nr;
>>>> -		}
>>>> +		string_list_init(&lines, 0);
>>>> +
>>>> +		while (strbuf_getline(&buf, stdin) != EOF)
>>>> +			string_list_append(&lines, strbuf_detach(&buf, NULL));
>>>> +
>>>> +		if (opts.stdin_packs)
>>>> +			pack_indexes = &lines;
>>>> +		if (opts.stdin_commits)
>>>> +			commit_hex = &lines;
>>>>    	}
>>>>
>>>>    	write_commit_graph(opts.obj_dir,
>>>>    			   pack_indexes,
>>>> -			   packs_nr,
>>>>    			   commit_hex,
>>>> -			   commits_nr,
>>>>    			   opts.append);
>>>>
>>>> +	string_list_clear(&lines, 0);
>>>>    	return 0;
>>>>    }
>>> This results in an invalid free() & segfault because you're freeing
>>> &lines which may not have been allocated by string_list_init().
>> Good point. Did my tests not catch this? (seems it requires calling
>> `git commit-graph write` with no `--stdin-packs` or
>> `--stdin-commits`).
> Most of your tests (t5318-commit-graph.sh) segfaulted, but presumably
> you're on a more forgiving compiler/platform/options. I compiled with
> -O0 -g on clang 4.0.1-8 + Debian testing.

I appreciate the extra platform testing. I'm using GCC on Ubuntu (gcc 
(Ubuntu 7.3.0-16ubuntu3) 7.3.0).

>
>>> Monkeypatch on top which I used to fix it:
>>>
>>>       diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>>>       index 76423b3fa5..c7eb68aa3a 100644
>>>       --- a/builtin/commit-graph.c
>>>       +++ b/builtin/commit-graph.c
>>>       @@ -122,6 +122,7 @@ static int graph_write(int argc, const char **argv)
>>>               struct string_list *pack_indexes = NULL;
>>>               struct string_list *commit_hex = NULL;
>>>               struct string_list lines;
>>>       +       int free_lines = 0;
>>>
>>>               static struct option builtin_commit_graph_write_options[] = {
>>>                       OPT_STRING(0, "object-dir", &opts.obj_dir,
>>>       @@ -155,6 +156,7 @@ static int graph_write(int argc, const char **argv)
>>>               if (opts.stdin_packs || opts.stdin_commits) {
>>>                       struct strbuf buf = STRBUF_INIT;
>>>                       string_list_init(&lines, 0);
>>>       +               free_lines = 1;
>>>
>>>                       while (strbuf_getline(&buf, stdin) != EOF)
>>>                               string_list_append(&lines, strbuf_detach(&buf, NULL));
>>>       @@ -170,7 +172,8 @@ static int graph_write(int argc, const char **argv)
>>>                                  commit_hex,
>>>                                  opts.append);
>>>
>>>       -       string_list_clear(&lines, 0);
>>>       +       if (free_lines)
>>>       +               string_list_clear(&lines, 0);
>>>               return 0;
>>>        }
>>>
>>> But probably having a pointer to the struct which is NULL etc. is
>>> better.
>> Wouldn't the easiest fix be to call `string_list_init(&lines, 0)`
>> outside of any conditional?
> Sure that works too. We'd be doing the init when we don't need it, but
> it's not like this part is performance critical or anything...

