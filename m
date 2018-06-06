Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CCA41F403
	for <e@80x24.org>; Wed,  6 Jun 2018 12:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeFFMPI (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 08:15:08 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:40623 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeFFMPH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 08:15:07 -0400
Received: by mail-qt0-f194.google.com with SMTP id q6-v6so6033832qtn.7
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 05:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fa1u0S6n2ayXPP8Hacjrzdz93F8hRbhnsXtQGyDU/gI=;
        b=Fj/lIsuW26nqo3UnTEABbjGQGbxF2i0/6SUCFTyE2YyggAMBDK0ZEV2Hrv1Wr0D44i
         I8BtKKcC941Pysf5+PIMRkcwZmrqyutpAQrmvsY6dDF0u+1XQu7vde7Vv65TlHF3M65S
         sZQvpaP319FgJqnYQsa2miwK9s5s7tk4H08Slmzp3kyK9gUt+YZ1OIP20NokpsKjeMr6
         U8sdmojZIMiA/ZmDtSPvgL8o10q8p+WFuAaSWI2EavQE2QDhK/PrFVcoQx3Sa90yA19h
         0QKe8pQACMmWNESEDoKlE05lXajvpFj1TRvXrZz96ib5T8QhSdCJg9a1bxKNGjVYtqJz
         JvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fa1u0S6n2ayXPP8Hacjrzdz93F8hRbhnsXtQGyDU/gI=;
        b=MOCxsH+RImG/5iu56kV0C4mJXiUvnRdoclwCJBRht/lz258JPuiNHDa6YLItXOSfI/
         ZvABSSitoy7NQsHbVEzkjbs6wFFfordgUlRVXtevRE2ST7C8iJK6GmI3W5tUwCyqAFJ7
         kmCmHU1vWowQBY4DJY1a39x/RvHDjA5wgtkkAx7rYLYGjsJ3078b87pKmSM/XiMP4fPy
         6dbXxCuitRO/dVTxFYDasKGb8BMfTiMsszRVFKQn3K3JLXskTAZU7ySADeY79hcO5gMb
         b2dH4p3gKGyGTapRknUtZmLfXKb4lBKWbzMIKcvqoLH/HN0NrMB9HWEILgjsbwUMkM30
         hHcQ==
X-Gm-Message-State: APt69E2jrem2/RBheO4S0lvJAt5yjF2rxGZ2V1NyNjXYk6xENt9dfW4x
        P2QYdMCgktZFhc0CQVO5IZU=
X-Google-Smtp-Source: ADUXVKK59aMXKlFr/okD5uSSPObD2QXv4+kqJR2DSYd1iTrJ04x9v8SxmqxElBjHJyf7UXJaZM2LIA==
X-Received: by 2002:ac8:686:: with SMTP id f6-v6mr2505450qth.348.1528287306609;
        Wed, 06 Jun 2018 05:15:06 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:3049:497a:f2dd:f3b2? ([2001:4898:8010:0:197f:497a:f2dd:f3b2])
        by smtp.gmail.com with ESMTPSA id n21-v6sm12462440qtc.38.2018.06.06.05.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 05:15:05 -0700 (PDT)
Subject: Re: [PATCH v5 18/21] commit-graph: use string-list API for input
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
 <20180606113611.87822-1-dstolee@microsoft.com>
 <20180606113611.87822-19-dstolee@microsoft.com>
 <87h8mgyv0f.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <aa4c3a93-0c63-f424-db0b-0e451bbaa91e@gmail.com>
Date:   Wed, 6 Jun 2018 08:15:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87h8mgyv0f.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/6/2018 8:11 AM, Ævar Arnfjörð Bjarmason wrote:
> On Wed, Jun 06 2018, Derrick Stolee wrote:
>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   builtin/commit-graph.c | 39 +++++++++++++--------------------------
>>   commit-graph.c         | 15 +++++++--------
>>   commit-graph.h         |  7 +++----
>>   3 files changed, 23 insertions(+), 38 deletions(-)
>> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>> index 3079cde6f9..d8eb8278b3 100644
>> --- a/builtin/commit-graph.c
>> +++ b/builtin/commit-graph.c
>> @@ -118,13 +118,9 @@ static int graph_read(int argc, const char **argv)
>>
>>   static int graph_write(int argc, const char **argv)
>>   {
>> -	const char **pack_indexes = NULL;
>> -	int packs_nr = 0;
>> -	const char **commit_hex = NULL;
>> -	int commits_nr = 0;
>> -	const char **lines = NULL;
>> -	int lines_nr = 0;
>> -	int lines_alloc = 0;
>> +	struct string_list *pack_indexes = NULL;
>> +	struct string_list *commit_hex = NULL;
>> +	struct string_list lines;
>>
>>   	static struct option builtin_commit_graph_write_options[] = {
>>   		OPT_STRING(0, "object-dir", &opts.obj_dir,
>> @@ -150,32 +146,23 @@ static int graph_write(int argc, const char **argv)
>>
>>   	if (opts.stdin_packs || opts.stdin_commits) {
>>   		struct strbuf buf = STRBUF_INIT;
>> -		lines_nr = 0;
>> -		lines_alloc = 128;
>> -		ALLOC_ARRAY(lines, lines_alloc);
>> -
>> -		while (strbuf_getline(&buf, stdin) != EOF) {
>> -			ALLOC_GROW(lines, lines_nr + 1, lines_alloc);
>> -			lines[lines_nr++] = strbuf_detach(&buf, NULL);
>> -		}
>> -
>> -		if (opts.stdin_packs) {
>> -			pack_indexes = lines;
>> -			packs_nr = lines_nr;
>> -		}
>> -		if (opts.stdin_commits) {
>> -			commit_hex = lines;
>> -			commits_nr = lines_nr;
>> -		}
>> +		string_list_init(&lines, 0);
>> +
>> +		while (strbuf_getline(&buf, stdin) != EOF)
>> +			string_list_append(&lines, strbuf_detach(&buf, NULL));
>> +
>> +		if (opts.stdin_packs)
>> +			pack_indexes = &lines;
>> +		if (opts.stdin_commits)
>> +			commit_hex = &lines;
>>   	}
>>
>>   	write_commit_graph(opts.obj_dir,
>>   			   pack_indexes,
>> -			   packs_nr,
>>   			   commit_hex,
>> -			   commits_nr,
>>   			   opts.append);
>>
>> +	string_list_clear(&lines, 0);
>>   	return 0;
>>   }
> This results in an invalid free() & segfault because you're freeing
> &lines which may not have been allocated by string_list_init().

Good point. Did my tests not catch this? (seems it requires calling `git 
commit-graph write` with no `--stdin-packs` or `--stdin-commits`).

>
> Monkeypatch on top which I used to fix it:
>
>      diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>      index 76423b3fa5..c7eb68aa3a 100644
>      --- a/builtin/commit-graph.c
>      +++ b/builtin/commit-graph.c
>      @@ -122,6 +122,7 @@ static int graph_write(int argc, const char **argv)
>              struct string_list *pack_indexes = NULL;
>              struct string_list *commit_hex = NULL;
>              struct string_list lines;
>      +       int free_lines = 0;
>
>              static struct option builtin_commit_graph_write_options[] = {
>                      OPT_STRING(0, "object-dir", &opts.obj_dir,
>      @@ -155,6 +156,7 @@ static int graph_write(int argc, const char **argv)
>              if (opts.stdin_packs || opts.stdin_commits) {
>                      struct strbuf buf = STRBUF_INIT;
>                      string_list_init(&lines, 0);
>      +               free_lines = 1;
>
>                      while (strbuf_getline(&buf, stdin) != EOF)
>                              string_list_append(&lines, strbuf_detach(&buf, NULL));
>      @@ -170,7 +172,8 @@ static int graph_write(int argc, const char **argv)
>                                 commit_hex,
>                                 opts.append);
>
>      -       string_list_clear(&lines, 0);
>      +       if (free_lines)
>      +               string_list_clear(&lines, 0);
>              return 0;
>       }
>
> But probably having a pointer to the struct which is NULL etc. is
> better.

Wouldn't the easiest fix be to call `string_list_init(&lines, 0)` 
outside of any conditional?

Thanks,
-Stolee
