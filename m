Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D86CA1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 12:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeFFM0h (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 08:26:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36173 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeFFM0g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 08:26:36 -0400
Received: by mail-wm0-f67.google.com with SMTP id v131-v6so11625681wma.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 05:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JUDbkoval7jEWNCEDaUN/mAvPnbWAi+wSkRr9DgJKKw=;
        b=GrTV+lWzE7cJWOmnAsetOkotQQxnYheMNthRHCmZFQC/YXfum87XgeQPuks00g+8V8
         b2Dzt3TnrfaXx9yQ/WO7qKbWmFuR0ZAOoWBb0tvr343thUCJnNGALlJCd60qcu06YN20
         zsA9CS1hO6e5of/KCqhtCrFnLm3fbGR5gSDuuW4Y+lgnffnOJ6Ph0HFAzjZvXP4I+jDa
         4g49DHuf9pnq99TV9/Egb92lm1seWOpc2ZzDuztR4tFg+NsbG5OfeimSRIQAkG/DG/9W
         owrD1LI9yKuDUq7brvcOBv6fE2j2ji5TQTHKFRQ0i9mJ2sNkW8BHCGQAwiIel2DNUkba
         Vhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=JUDbkoval7jEWNCEDaUN/mAvPnbWAi+wSkRr9DgJKKw=;
        b=r6Yz/jt61e9H39Ihs9dobY2HYDclm0iwZr/v4WSqx3o4AYTrMNh6qMteXOaYJuRCUd
         rBgCQpyBFPxn8JxjhweyhELH4q6zTpDjxf729ZZ165JnycLSejXDbYBWBVIqt7g5msbH
         2aCnMALEIo348Xza9F7edJ9p3xKTTKCdTw/MhLQYGWMhzVZj9BxRv8LDzFeXisffQMUt
         oCiMRvR6SWDehMZakCcMHnDwDIqqXE4l/BRbT2ZwrAGqeYXCLr/dsWy/BFAkW2LA8PhX
         WdBZdKWGwZ9LyOpSmSJhtQ70A1jRBmCYkzZfNCGa/i2YRvefIXVwZ35FWjDcbXftwRgy
         3OiQ==
X-Gm-Message-State: APt69E1WqJdeSgHQ0FCP6P4Am8ORukpr71apMkwseLhJysdNd8zMbUgq
        RS24YhpiYkvL38VMs3szfvo=
X-Google-Smtp-Source: ADUXVKLnYPLImBdBcURmEl9KBcUbfkbHjRtsNm8Kt71k+9HQ/ysF0DkSpyH/hM4eMGpoGN8RB16nRQ==
X-Received: by 2002:a50:c29a:: with SMTP id o26-v6mr3548946edf.156.1528287994858;
        Wed, 06 Jun 2018 05:26:34 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id c13-v6sm6765811edr.78.2018.06.06.05.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 05:26:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb\@gmail.com" <jnareb@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "gitster\@pobox.com" <gitster@pobox.com>
Subject: Re: [PATCH v5 18/21] commit-graph: use string-list API for input
References: <20180604165200.29261-1-dstolee@microsoft.com>
        <20180606113611.87822-1-dstolee@microsoft.com>
        <20180606113611.87822-19-dstolee@microsoft.com>
        <87h8mgyv0f.fsf@evledraar.gmail.com>
        <aa4c3a93-0c63-f424-db0b-0e451bbaa91e@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <aa4c3a93-0c63-f424-db0b-0e451bbaa91e@gmail.com>
Date:   Wed, 06 Jun 2018 14:26:33 +0200
Message-ID: <87efhkyubq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 06 2018, Derrick Stolee wrote:

> On 6/6/2018 8:11 AM, Ævar Arnfjörð Bjarmason wrote:
>> On Wed, Jun 06 2018, Derrick Stolee wrote:
>>
>>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>>> ---
>>>   builtin/commit-graph.c | 39 +++++++++++++--------------------------
>>>   commit-graph.c         | 15 +++++++--------
>>>   commit-graph.h         |  7 +++----
>>>   3 files changed, 23 insertions(+), 38 deletions(-)
>>> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>>> index 3079cde6f9..d8eb8278b3 100644
>>> --- a/builtin/commit-graph.c
>>> +++ b/builtin/commit-graph.c
>>> @@ -118,13 +118,9 @@ static int graph_read(int argc, const char **argv)
>>>
>>>   static int graph_write(int argc, const char **argv)
>>>   {
>>> -	const char **pack_indexes = NULL;
>>> -	int packs_nr = 0;
>>> -	const char **commit_hex = NULL;
>>> -	int commits_nr = 0;
>>> -	const char **lines = NULL;
>>> -	int lines_nr = 0;
>>> -	int lines_alloc = 0;
>>> +	struct string_list *pack_indexes = NULL;
>>> +	struct string_list *commit_hex = NULL;
>>> +	struct string_list lines;
>>>
>>>   	static struct option builtin_commit_graph_write_options[] = {
>>>   		OPT_STRING(0, "object-dir", &opts.obj_dir,
>>> @@ -150,32 +146,23 @@ static int graph_write(int argc, const char **argv)
>>>
>>>   	if (opts.stdin_packs || opts.stdin_commits) {
>>>   		struct strbuf buf = STRBUF_INIT;
>>> -		lines_nr = 0;
>>> -		lines_alloc = 128;
>>> -		ALLOC_ARRAY(lines, lines_alloc);
>>> -
>>> -		while (strbuf_getline(&buf, stdin) != EOF) {
>>> -			ALLOC_GROW(lines, lines_nr + 1, lines_alloc);
>>> -			lines[lines_nr++] = strbuf_detach(&buf, NULL);
>>> -		}
>>> -
>>> -		if (opts.stdin_packs) {
>>> -			pack_indexes = lines;
>>> -			packs_nr = lines_nr;
>>> -		}
>>> -		if (opts.stdin_commits) {
>>> -			commit_hex = lines;
>>> -			commits_nr = lines_nr;
>>> -		}
>>> +		string_list_init(&lines, 0);
>>> +
>>> +		while (strbuf_getline(&buf, stdin) != EOF)
>>> +			string_list_append(&lines, strbuf_detach(&buf, NULL));
>>> +
>>> +		if (opts.stdin_packs)
>>> +			pack_indexes = &lines;
>>> +		if (opts.stdin_commits)
>>> +			commit_hex = &lines;
>>>   	}
>>>
>>>   	write_commit_graph(opts.obj_dir,
>>>   			   pack_indexes,
>>> -			   packs_nr,
>>>   			   commit_hex,
>>> -			   commits_nr,
>>>   			   opts.append);
>>>
>>> +	string_list_clear(&lines, 0);
>>>   	return 0;
>>>   }
>> This results in an invalid free() & segfault because you're freeing
>> &lines which may not have been allocated by string_list_init().
>
> Good point. Did my tests not catch this? (seems it requires calling
> `git commit-graph write` with no `--stdin-packs` or
> `--stdin-commits`).

Most of your tests (t5318-commit-graph.sh) segfaulted, but presumably
you're on a more forgiving compiler/platform/options. I compiled with
-O0 -g on clang 4.0.1-8 + Debian testing.

>>
>> Monkeypatch on top which I used to fix it:
>>
>>      diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>>      index 76423b3fa5..c7eb68aa3a 100644
>>      --- a/builtin/commit-graph.c
>>      +++ b/builtin/commit-graph.c
>>      @@ -122,6 +122,7 @@ static int graph_write(int argc, const char **argv)
>>              struct string_list *pack_indexes = NULL;
>>              struct string_list *commit_hex = NULL;
>>              struct string_list lines;
>>      +       int free_lines = 0;
>>
>>              static struct option builtin_commit_graph_write_options[] = {
>>                      OPT_STRING(0, "object-dir", &opts.obj_dir,
>>      @@ -155,6 +156,7 @@ static int graph_write(int argc, const char **argv)
>>              if (opts.stdin_packs || opts.stdin_commits) {
>>                      struct strbuf buf = STRBUF_INIT;
>>                      string_list_init(&lines, 0);
>>      +               free_lines = 1;
>>
>>                      while (strbuf_getline(&buf, stdin) != EOF)
>>                              string_list_append(&lines, strbuf_detach(&buf, NULL));
>>      @@ -170,7 +172,8 @@ static int graph_write(int argc, const char **argv)
>>                                 commit_hex,
>>                                 opts.append);
>>
>>      -       string_list_clear(&lines, 0);
>>      +       if (free_lines)
>>      +               string_list_clear(&lines, 0);
>>              return 0;
>>       }
>>
>> But probably having a pointer to the struct which is NULL etc. is
>> better.
>
> Wouldn't the easiest fix be to call `string_list_init(&lines, 0)`
> outside of any conditional?

Sure that works too. We'd be doing the init when we don't need it, but
it's not like this part is performance critical or anything...
