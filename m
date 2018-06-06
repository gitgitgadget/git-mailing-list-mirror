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
	by dcvr.yhbt.net (Postfix) with ESMTP id 564EE1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 12:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeFFMLu (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 08:11:50 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34463 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbeFFMLr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 08:11:47 -0400
Received: by mail-wm0-f46.google.com with SMTP id q4-v6so22794755wmq.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 05:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=3mRXbga9Og5CTnncAX6Gmc77F6khVdsm10oUlQKzcJ8=;
        b=d8LR1pjeEHzfq0Y/AjqUpbX8a6ao9R29K7756VmUbTBf3rIDN0ejPTixHb8xzA+DS1
         +NlqUBSGDmtWKLUCjd/8yjCye8jjwrPJ6/hCwHjch8yQixB4jHtAji4VfZJRRnOgj1e6
         5bCziAa1YJ0vL+AxuOwQjCo7hM35DTD14CmJaoJyWFI8IL8cnh7z7xHY5YHoKYiTLjBP
         sxK6RNK/rooP2vO7fGgOTlpm6AnROrKxdWTowiHLYSC22JDLeVe3ROVChfSyLQGJvuu3
         A323b7CkAe2rpHRc/Sq6XnCJVfkc0atndclB7A6B9DlTaathQ2UHEyh0ICbIDk/jaik7
         A/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=3mRXbga9Og5CTnncAX6Gmc77F6khVdsm10oUlQKzcJ8=;
        b=dK95a/tYb8Ep8w0jA/32ZMThpXLUyKqrniXQkwHaCeq73HJ5oam8FQqD+wPibFFFCQ
         EciWoS/1CQj19MuIr2Roq+gcx9wVl970ozTClfyGQqsy6RXIHPL8erw6rX8Q8X/9zbYa
         mFpMTSPgrDG5LNcdEZYU/V9P5fy1Rej2bzPouXk/eoPOBOK6ZpDExmA9c2vGg2T9xMOg
         +0DHJi29tHVBrTUioC4bYAknunDAOvFCGrgwvXekkvBbNRQIB3V5Gjm4YBBhO7cL+hvb
         Lzvmft0XoEY/RhDjprhnoptoDNXa52fHfGhIaxdTpOoWiZadT9IxwWL3tFwpQVkEZjIP
         U1ZA==
X-Gm-Message-State: APt69E0ep9YAdha6478H7JIAqD21kUwFS/ooaISPBUXioU/I7KeC1Nkw
        qIrhgj8OsifDhOMCVpZR9zwAUTYn
X-Google-Smtp-Source: ADUXVKKLonYDvvRI1B9w7tgrFKyCS5bnowbQFWe0V0wozzKL1LL2+mhscWhWgWvVik71RN4vROt5Hg==
X-Received: by 2002:a50:9090:: with SMTP id c16-v6mr3376013eda.310.1528287105984;
        Wed, 06 Jun 2018 05:11:45 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id b9-v6sm2990151edr.29.2018.06.06.05.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 05:11:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "jnareb\@gmail.com" <jnareb@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "gitster\@pobox.com" <gitster@pobox.com>
Subject: Re: [PATCH v5 18/21] commit-graph: use string-list API for input
References: <20180604165200.29261-1-dstolee@microsoft.com> <20180606113611.87822-1-dstolee@microsoft.com> <20180606113611.87822-19-dstolee@microsoft.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180606113611.87822-19-dstolee@microsoft.com>
Date:   Wed, 06 Jun 2018 14:11:44 +0200
Message-ID: <87h8mgyv0f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 06 2018, Derrick Stolee wrote:

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/commit-graph.c | 39 +++++++++++++--------------------------
>  commit-graph.c         | 15 +++++++--------
>  commit-graph.h         |  7 +++----
>  3 files changed, 23 insertions(+), 38 deletions(-)

> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 3079cde6f9..d8eb8278b3 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -118,13 +118,9 @@ static int graph_read(int argc, const char **argv)
>
>  static int graph_write(int argc, const char **argv)
>  {
> -	const char **pack_indexes = NULL;
> -	int packs_nr = 0;
> -	const char **commit_hex = NULL;
> -	int commits_nr = 0;
> -	const char **lines = NULL;
> -	int lines_nr = 0;
> -	int lines_alloc = 0;
> +	struct string_list *pack_indexes = NULL;
> +	struct string_list *commit_hex = NULL;
> +	struct string_list lines;
>
>  	static struct option builtin_commit_graph_write_options[] = {
>  		OPT_STRING(0, "object-dir", &opts.obj_dir,
> @@ -150,32 +146,23 @@ static int graph_write(int argc, const char **argv)
>
>  	if (opts.stdin_packs || opts.stdin_commits) {
>  		struct strbuf buf = STRBUF_INIT;
> -		lines_nr = 0;
> -		lines_alloc = 128;
> -		ALLOC_ARRAY(lines, lines_alloc);
> -
> -		while (strbuf_getline(&buf, stdin) != EOF) {
> -			ALLOC_GROW(lines, lines_nr + 1, lines_alloc);
> -			lines[lines_nr++] = strbuf_detach(&buf, NULL);
> -		}
> -
> -		if (opts.stdin_packs) {
> -			pack_indexes = lines;
> -			packs_nr = lines_nr;
> -		}
> -		if (opts.stdin_commits) {
> -			commit_hex = lines;
> -			commits_nr = lines_nr;
> -		}
> +		string_list_init(&lines, 0);
> +
> +		while (strbuf_getline(&buf, stdin) != EOF)
> +			string_list_append(&lines, strbuf_detach(&buf, NULL));
> +
> +		if (opts.stdin_packs)
> +			pack_indexes = &lines;
> +		if (opts.stdin_commits)
> +			commit_hex = &lines;
>  	}
>
>  	write_commit_graph(opts.obj_dir,
>  			   pack_indexes,
> -			   packs_nr,
>  			   commit_hex,
> -			   commits_nr,
>  			   opts.append);
>
> +	string_list_clear(&lines, 0);
>  	return 0;
>  }

This results in an invalid free() & segfault because you're freeing
&lines which may not have been allocated by string_list_init().

Monkeypatch on top which I used to fix it:

    diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
    index 76423b3fa5..c7eb68aa3a 100644
    --- a/builtin/commit-graph.c
    +++ b/builtin/commit-graph.c
    @@ -122,6 +122,7 @@ static int graph_write(int argc, const char **argv)
            struct string_list *pack_indexes = NULL;
            struct string_list *commit_hex = NULL;
            struct string_list lines;
    +       int free_lines = 0;

            static struct option builtin_commit_graph_write_options[] = {
                    OPT_STRING(0, "object-dir", &opts.obj_dir,
    @@ -155,6 +156,7 @@ static int graph_write(int argc, const char **argv)
            if (opts.stdin_packs || opts.stdin_commits) {
                    struct strbuf buf = STRBUF_INIT;
                    string_list_init(&lines, 0);
    +               free_lines = 1;

                    while (strbuf_getline(&buf, stdin) != EOF)
                            string_list_append(&lines, strbuf_detach(&buf, NULL));
    @@ -170,7 +172,8 @@ static int graph_write(int argc, const char **argv)
                               commit_hex,
                               opts.append);

    -       string_list_clear(&lines, 0);
    +       if (free_lines)
    +               string_list_clear(&lines, 0);
            return 0;
     }

But probably having a pointer to the struct which is NULL etc. is
better.
