Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8921D2FC896
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871925; cv=none; b=TDBV/DiijQKhZ63uNTObxuCMJ087j7wKOlLZq6orDvU9CcJY4f9BS9xD2rNZEA7un7r0IJO9GbeNZQ1p3nMHQ5ZJmEMu799YW7HEgRkz3ZpUwL6QpRb0uwghH1jBNoNr0xwagts2YLutN7e3Rho9yeWW01jX52a94a6eLjm4FoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871925; c=relaxed/simple;
	bh=LOSUX01RZUfXP3aM1YzybxLKZGSs8oacaFDg3tncl0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sv8UkFOqI0xLg1P8Udcn3uKvBsZNJPbJTFVdt8Fv78RT4CW5do+F5n+/18/Igwly8arJdAXM/uxfuFIT+2hPy4zlUcLs3Xhl3YEyeH8ISR54V2v2WqbgAn5pIWXgG5huQLrYeF+8lFdQuX0BTE+DFI64XVp2avCcxREaX1XDTxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOZtCjri; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOZtCjri"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47778b23f64so16233315e9.0
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 06:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762871922; x=1763476722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=swBtsJw0m0cor0YaaqJZoH39e2sf6UJ+FfOMY27ERWQ=;
        b=jOZtCjri7EnQarvNzpJ41DC2opl+/zgQi73vcHhDkdBF0Nw8WYtOFQY+UfBJZcOico
         gXloOp3gXiq18MBR2ftBh5k/uXnCXYVAj9nNad8J4zboqYd7Ir260al4UAcUZnwneH2e
         YOhvIGnh4lIUxichsmHa9+VYBRJePEo/McE8QtZ2utB2T1dNDWGQ1E4sZ8aGn8SRBvYl
         8XE08N2W5sPxEoHv/gKukEtyIcEPR1ymjj2FuAr5+Us2lubCx+zmrix3cz9YOpNlu2TY
         sl/Hm2bgyqboHkZhYg4mx3AmY5INHU/alTtZxfJeGP/gCAUx3kKt46+Oxqkh4/RiCmix
         1I6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762871922; x=1763476722;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swBtsJw0m0cor0YaaqJZoH39e2sf6UJ+FfOMY27ERWQ=;
        b=IXH+FZZineaA+xFJ55y5Vzx9J4YOLCYWWoq8KW1hlS/2B21coBXJSWziDJUPHwFMD3
         niJ+L+JxDm4rJOL+6z84zwCjgOieyYKS7i5b43ffYeZKF7cmnCMLDGUW5ILXJ7wZflo9
         RJ8vxLNsBCQXWNi0yzc1XCgYCLveQ1lnRrGB4JRyxczkQhHXyL4aQS7svtKT+v/fg3ZQ
         /9smKuL8cMXrPRVuNRWTZtwu6df7sfBuoBLa4B1b/wFkIkz1Ixonp6cl9CSj5H65tNQW
         8xEe1/98oWeWPNrstqSJPTtZkBIukjkJ0+Zf3A8snKQy0cT9W+uD8eTND9LXTcoY8HEs
         RXtA==
X-Forwarded-Encrypted: i=1; AJvYcCVXhjKO5iA3kYEqJ1graEzREZhZ1tyEu1HM36IJ9b8w27/b8tnUj8wTBvXo6ztn/NG0UAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzuThNyUC1YVW73jp6hNNsg6hszSyeVJpOmQ6w6T32Pduw59vg
	D1V9AkyIpU8S6cJzKOZeqqS9Bfi/8VW2wYb2a3B1dfGIhV+uEFou/aws
X-Gm-Gg: ASbGncuLp6hReOmSKV3LF0lFW4DkUZDQzkVcw7jZXqlWALL/q5gPfxp3NBxmZI7+dT+
	XuZ/QON3jV80arQJR5KA+jLAn9aDGDxGHYUkF8fjy9Ek0EKMuONsjuCvENWDGM0S+lZSJ5MD3CY
	0lM+k7EVRck0HkMyBaGaGj3KezRX++YseDJBneoMMAktRzfiB1L5nVSz9WJMxyyBghbCO9jeBwF
	IxTYDqbgF0rfRrk5BCZZYGPuvu95CNlQwiNGllm3wq4wRrReBs2mDxV0d3839TqMDI4DV8L6du0
	a5g7p8rKqZ8spN2guM4n06REkM+KkXm8VqEkp3/n45IOgEvoN2FUX2H8I7E67by7Q7r9YZD+bW2
	hGg699qKAIezFy0fuDgSta1jndwer/NnyKjtt0XphOa0pcWGaRQTUCvcUGiXUXZdNpFHDmd9qa1
	zY54Do8209h3e0hn6GFbQFNQeErMaCoT1DJal2BAaGamO9yWbFYFEDw57VSjygYl8=
X-Google-Smtp-Source: AGHT+IEBfl7M8AWmDkyjZO+WCot0FhIBe6tA1i4KxISvGMkbo9L6no8mEVFT4N/O1XLYhNVk58xfbg==
X-Received: by 2002:a05:600c:8b5b:b0:46f:b42e:e392 with SMTP id 5b1f17b1804b1-477732a22dcmr88726935e9.39.1762871921459;
        Tue, 11 Nov 2025 06:38:41 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc528sm386768545e9.7.2025.11.11.06.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 06:38:40 -0800 (PST)
Message-ID: <7d99f00c-3602-4b28-8efd-4780cad41ca8@gmail.com>
Date: Tue, 11 Nov 2025 14:38:40 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] commit: add --committer option
To: ZheNing Hu <adlternative@gmail.com>, phillip.wood@dunelm.org.uk
Cc: ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com>
 <CAOLTT8TPrNTCjHwJfdeei+t8+7AxGC-dvbq-4oHJ=qNn_c+-jQ@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAOLTT8TPrNTCjHwJfdeei+t8+7AxGC-dvbq-4oHJ=qNn_c+-jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/2025 13:01, ZheNing Hu wrote:
> Phillip Wood <phillip.wood123@gmail.com> 于2025年11月11日周二 00:50写道：
>> On 09/11/2025 10:22, ZheNing Hu via GitGitGadget wrote:
>>> From: ZheNing Hu <adlternative@gmail.com>
>>>
>>>
>>>       This patch introduces the --committer option to git-commit, providing:
>>>
>>>        1. Consistency with the existing --author option
>>>        2. A more convenient alternative to environment variables
>>>        3. Better support for automated workflows and scripts
>>>        4. Improved user experience when managing multiple identities
>>
>> What's the use case for the same person committing under different
>> identities? We already have a config mechanism to set different
>> identities for different repositories but I'm struggling to see why
>> someone would want to create commits under multiple identities in a
>> single repository. For scripts it easy enough to set the relevant
>> environment variables if a tool wants to create commits under its own
>> identity.
>>
> 
> I frequently need to distinguish between different user.name and user.email
> configurations on our company's internal GitHub.
> 
> The current problems are:
> 
> When I misconfigure (which happens occasionally), git commit --author only fixes
> the author part, I still need to additionally set GIT_COMMITTER_NAME and
> GIT_COMMITTER_EMAIL environment variables to fix the committer information
> These environment variables are painful to use, requiring manual setup
> every time

I'm afraid I don't quite follow. If you are amending existing commits to 
fix them up after you have corrected your configuration then they will 
have the correct committer automatically when you run "git commit 
--amend --author=..." to correct the author. If you are committing 
before you have realized that user.{name,email} are misconfigured then I 
don't see how "--committer" helps because you have not yet realized 
anything is wrong.

Thanks

Phillip

> If a --committer option could be provided to align with --author, users wouldn't
> need to remember and use these additional environment variables.
> This would greatly simplify the workflow and reduce cognitive overhead.
> 
> 
>> Thanks
>>
>> Phillip
>>
>>>       The implementation follows the same pattern as the --author option,
>>>       accepting the format "Name " and properly validating the input.
>>>
>>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1997%2Fadlternative%2Fzh%2Fimplement-committer-option-v1
>>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1997/adlternative/zh/implement-committer-option-v1
>>> Pull-Request: https://github.com/gitgitgadget/git/pull/1997
>>>
>>>    Documentation/git-commit.adoc |  9 +++-
>>>    builtin/commit.c              | 58 ++++++++++++++++++++++++-
>>>    t/t7509-commit-authorship.sh  | 80 +++++++++++++++++++++++++++++++++++
>>>    3 files changed, 144 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
>>> index 54c207ad45..a015c8328e 100644
>>> --- a/Documentation/git-commit.adoc
>>> +++ b/Documentation/git-commit.adoc
>>> @@ -12,7 +12,7 @@ git commit [-a | --interactive | --patch] [-s] [-v] [-u[<mode>]] [--amend]
>>>           [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]
>>>           [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
>>>           [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
>>> -        [--date=<date>] [--cleanup=<mode>] [--[no-]status]
>>> +        [--date=<date>] [--committer=<committer>] [--cleanup=<mode>] [--[no-]status]
>>>           [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
>>>           [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]
>>>           [--] [<pathspec>...]
>>> @@ -181,6 +181,13 @@ See linkgit:git-rebase[1] for details.
>>>    `--date=<date>`::
>>>        Override the author date used in the commit.
>>>
>>> +`--committer=<committer>`::
>>> +     Override the committer for the commit. Specify an explicit committer using the
>>> +     standard `A U Thor <committer@example.com>` format. Otherwise _<committer>_
>>> +     is assumed to be a pattern and is used to search for an existing
>>> +     commit by that author (i.e. `git rev-list --all -i --author=<committer>`);
>>> +     the commit author is then copied from the first such commit found.
>>> +
>>>    `-m <msg>`::
>>>    `--message=<msg>`::
>>>        Use _<msg>_ as the commit message.
>>> diff --git a/builtin/commit.c b/builtin/commit.c
>>> index 0243f17d53..88e77cbaab 100644
>>> --- a/builtin/commit.c
>>> +++ b/builtin/commit.c
>>> @@ -49,7 +49,7 @@ static const char * const builtin_commit_usage[] = {
>>>           "           [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]\n"
>>>           "           [-F <file> | -m <msg>] [--reset-author] [--allow-empty]\n"
>>>           "           [--allow-empty-message] [--no-verify] [-e] [--author=<author>]\n"
>>> -        "           [--date=<date>] [--cleanup=<mode>] [--[no-]status]\n"
>>> +        "           [--date=<date>] [--committer=<committer>] [--cleanup=<mode>] [--[no-]status]\n"
>>>           "           [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
>>>           "           [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]\n"
>>>           "           [--] [<pathspec>...]"),
>>> @@ -112,6 +112,7 @@ static enum {
>>>    } commit_style;
>>>
>>>    static const char *force_author;
>>> +static const char *force_committer;
>>>    static char *logfile;
>>>    static char *template_file;
>>>    /*
>>> @@ -690,6 +691,48 @@ static void determine_author_info(struct strbuf *author_ident)
>>>        free(date);
>>>    }
>>>
>>> +static void determine_committer_info(struct strbuf *committer_ident)
>>> +{
>>> +     char *name, *email, *date;
>>> +     struct ident_split committer;
>>> +
>>> +     name = xstrdup_or_null(getenv("GIT_COMMITTER_NAME"));
>>> +     email = xstrdup_or_null(getenv("GIT_COMMITTER_EMAIL"));
>>> +     date = xstrdup_or_null(getenv("GIT_COMMITTER_DATE"));
>>> +
>>> +     if (force_committer) {
>>> +             struct ident_split ident;
>>> +
>>> +             if (split_ident_line(&ident, force_committer, strlen(force_committer)) < 0)
>>> +                     die(_("malformed --committer parameter"));
>>> +             set_ident_var(&name, xmemdupz(ident.name_begin, ident.name_end - ident.name_begin));
>>> +             set_ident_var(&email, xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin));
>>> +
>>> +             if (ident.date_begin) {
>>> +                     struct strbuf date_buf = STRBUF_INIT;
>>> +                     strbuf_addch(&date_buf, '@');
>>> +                     strbuf_add(&date_buf, ident.date_begin, ident.date_end - ident.date_begin);
>>> +                     strbuf_addch(&date_buf, ' ');
>>> +                     strbuf_add(&date_buf, ident.tz_begin, ident.tz_end - ident.tz_begin);
>>> +                     set_ident_var(&date, strbuf_detach(&date_buf, NULL));
>>> +             }
>>> +     }
>>> +
>>> +     if (force_date) {
>>> +             struct strbuf date_buf = STRBUF_INIT;
>>> +             if (parse_force_date(force_date, &date_buf))
>>> +                     die(_("invalid date format: %s"), force_date);
>>> +             set_ident_var(&date, strbuf_detach(&date_buf, NULL));
>>> +     }
>>> +
>>> +     strbuf_addstr(committer_ident, fmt_ident(name, email, WANT_COMMITTER_IDENT, date,
>>> +                             IDENT_STRICT));
>>> +     assert_split_ident(&committer, committer_ident);
>>> +     free(name);
>>> +     free(email);
>>> +     free(date);
>>> +}
>>> +
>>>    static int author_date_is_interesting(void)
>>>    {
>>>        return author_message || force_date;
>>> @@ -1321,6 +1364,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
>>>        if (force_author && renew_authorship)
>>>                die(_("options '%s' and '%s' cannot be used together"), "--reset-author", "--author");
>>>
>>> +     if (force_committer && !strchr(force_committer, '>'))
>>> +             force_committer = find_author_by_nickname(force_committer);
>>> +
>>>        if (logfile || have_option_m || use_message)
>>>                use_editor = 0;
>>>
>>> @@ -1709,6 +1755,7 @@ int cmd_commit(int argc,
>>>                OPT_FILENAME('F', "file", &logfile, N_("read message from file")),
>>>                OPT_STRING(0, "author", &force_author, N_("author"), N_("override author for commit")),
>>>                OPT_STRING(0, "date", &force_date, N_("date"), N_("override date for commit")),
>>> +             OPT_STRING(0, "committer", &force_committer, N_("committer"), N_("override committer for commit")),
>>>                OPT_CALLBACK('m', "message", &message, N_("message"), N_("commit message"), opt_parse_m),
>>>                OPT_STRING('c', "reedit-message", &edit_message, N_("commit"), N_("reuse and edit message from specified commit")),
>>>                OPT_STRING('C', "reuse-message", &use_message, N_("commit"), N_("reuse message from specified commit")),
>>> @@ -1785,6 +1832,7 @@ int cmd_commit(int argc,
>>>
>>>        struct strbuf sb = STRBUF_INIT;
>>>        struct strbuf author_ident = STRBUF_INIT;
>>> +     struct strbuf committer_ident = STRBUF_INIT;
>>>        const char *index_file, *reflog_msg;
>>>        struct object_id oid;
>>>        struct commit_list *parents = NULL;
>>> @@ -1930,8 +1978,13 @@ int cmd_commit(int argc,
>>>                append_merge_tag_headers(parents, &tail);
>>>        }
>>>
>>> +     if (force_committer) {
>>> +             determine_committer_info(&committer_ident);
>>> +     }
>>> +
>>>        if (commit_tree_extended(sb.buf, sb.len, &the_repository->index->cache_tree->oid,
>>> -                              parents, &oid, author_ident.buf, NULL,
>>> +                              parents, &oid, author_ident.buf,
>>> +                              force_committer ? committer_ident.buf : NULL,
>>>                                 sign_commit, extra)) {
>>>                rollback_index_files();
>>>                die(_("failed to write commit object"));
>>> @@ -1980,6 +2033,7 @@ cleanup:
>>>        free_commit_extra_headers(extra);
>>>        free_commit_list(parents);
>>>        strbuf_release(&author_ident);
>>> +     strbuf_release(&committer_ident);
>>>        strbuf_release(&err);
>>>        strbuf_release(&sb);
>>>        free(logfile);
>>> diff --git a/t/t7509-commit-authorship.sh b/t/t7509-commit-authorship.sh
>>> index 8e373b566b..45527f6a70 100755
>>> --- a/t/t7509-commit-authorship.sh
>>> +++ b/t/t7509-commit-authorship.sh
>>> @@ -12,6 +12,11 @@ author_header () {
>>>        sed -n -e '/^$/q' -e '/^author /p'
>>>    }
>>>
>>> +committer_header () {
>>> +     git cat-file commit "$1" |
>>> +     sed -n -e '/^$/q' -e '/^committer /p'
>>> +}
>>> +
>>>    message_body () {
>>>        git cat-file commit "$1" |
>>>        sed -e '1,/^$/d'
>>> @@ -171,4 +176,79 @@ test_expect_success '--reset-author with CHERRY_PICK_HEAD' '
>>>        test_cmp expect actual
>>>    '
>>>
>>> +test_expect_success '--committer option overrides committer' '
>>> +     git checkout Initial &&
>>> +     echo "Test --committer" >>foo &&
>>> +     test_tick &&
>>> +     git commit -a -m "test committer" --committer="Custom Committer <custom@committer.example>" &&
>>> +     committer_header HEAD >actual &&
>>> +     grep "Custom Committer <custom@committer.example>" actual
>>> +'
>>> +
>>> +test_expect_success '--committer with pattern search' '
>>> +     echo "Test committer pattern" >>foo &&
>>> +     test_tick &&
>>> +     git commit -a -m "test committer pattern" --committer="Frigate" &&
>>> +     committer_header HEAD >actual &&
>>> +     grep "Frigate <flying@over.world>" actual
>>> +'
>>> +
>>> +test_expect_success '--committer malformed parameter' '
>>> +     echo "Test malformed" >>foo &&
>>> +     test_tick &&
>>> +     test_must_fail git commit -a -m "test malformed" --committer="malformed committer"
>>> +'
>>> +
>>> +test_expect_success '--committer with --amend option' '
>>> +     git checkout -f Initial &&
>>> +     echo "Test committer with amend" >>foo &&
>>> +     test_tick &&
>>> +     git commit -a -m "initial commit for amend test" &&
>>> +     echo "Modified for amend" >>foo &&
>>> +     test_tick &&
>>> +     git commit -a --amend --no-edit \
>>> +             --author="Test Author <test@author.example>" \
>>> +             --committer="Test Committer <test@committer.example>" &&
>>> +     author_header HEAD >actual_author &&
>>> +     grep "Test Author <test@author.example>" actual_author &&
>>> +     committer_header HEAD >actual_committer &&
>>> +     grep "Test Committer <test@committer.example>" actual_committer
>>> +'
>>> +
>>> +test_expect_success 'GIT_COMMITTER_* environment variables' '
>>> +     git checkout -f Initial &&
>>> +     echo "Test env vars" >>foo &&
>>> +     test_tick &&
>>> +     GIT_COMMITTER_NAME="Env Committer" \
>>> +     GIT_COMMITTER_EMAIL="env@test.example" \
>>> +     git commit -a -m "test committer env vars" &&
>>> +     committer_header HEAD >actual &&
>>> +     grep "Env Committer <env@test.example>" actual
>>> +'
>>> +
>>> +test_expect_success '--committer overrides GIT_COMMITTER_* environment variables' '
>>> +     echo "Test override" >>foo &&
>>> +     test_tick &&
>>> +     GIT_COMMITTER_NAME="Env Committer" \
>>> +     GIT_COMMITTER_EMAIL="env@test.example" \
>>> +     git commit -a -m "test override" \
>>> +             --committer="Override Committer <override@test.example>" &&
>>> +     committer_header HEAD >actual &&
>>> +     grep "Override Committer <override@test.example>" actual
>>> +'
>>> +
>>> +test_expect_success '--date with --committer changes both author and committer dates' '
>>> +     git checkout -f Initial &&
>>> +     echo "Test date override" >>foo &&
>>> +     test_tick &&
>>> +     git commit -a -m "test date" \
>>> +             --author="Date Author <date@author.example>" \
>>> +             --committer="Date Committer <date@committer.example>" \
>>> +             --date="2024-06-15 10:30:00 +0800" &&
>>> +     git log -1 --format="%ai" >author_date &&
>>> +     git log -1 --format="%ci" >committer_date &&
>>> +     grep "2024-06-15 10:30:00 +0800" author_date &&
>>> +     grep "2024-06-15 10:30:00 +0800" committer_date
>>> +'
>>> +
>>>    test_done
>>>
>>> base-commit: 4badef0c3503dc29059d678abba7fac0f042bc84
>>
> 

