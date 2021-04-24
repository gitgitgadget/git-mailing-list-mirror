Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFCBC433ED
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 19:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5563A613D5
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 19:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbhDXTp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Apr 2021 15:45:29 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:59195 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233563AbhDXTp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Apr 2021 15:45:29 -0400
Received: from host-92-1-139-132.as13285.net ([92.1.139.132] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1laOCt-0001fx-BT; Sat, 24 Apr 2021 20:44:49 +0100
Subject: Re: [PATCH v2] [GSOC] pretty: provide human date format
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Taylor Blau <me@ttaylorr.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.939.git.1619195245606.gitgitgadget@gmail.com>
 <pull.939.v2.git.1619275340051.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <c0780b56-8852-d055-97ec-45ff93aa41de@iee.email>
Date:   Sat, 24 Apr 2021 20:44:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <pull.939.v2.git.1619275340051.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

quoting nit..
On 24/04/2021 15:42, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
>
> Add the placeholders %ah and %ch to format author date and committer
> date, like --date=human does, which provides more humanity date output.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     [GSOC] pretty: provide human date format
>     
>     Reasons for making this patch: --date=human has no corresponding
>     --pretty option.
>     
>     Although --date=human with --pretty="%(a|c)d" can achieve the same
>     effect with --pretty="%(a|c)h", but it can be noticed that most time
>     formats implement the corresponding option of --pretty, such as
>     --date=iso8601 can be replaced by --pretty=%(a|c)i, so add
>     "--pretty=%(a|c)h" seems to be a very reasonable thing.
>     
>     Change from v1: add %(a|c)h link to rev-list-options.txt.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-939%2Fadlternative%2Fpretty_human-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-939/adlternative/pretty_human-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/939
>
> Range-diff vs v1:
>
>  1:  ed8abd6179d1 ! 1:  1517708876b5 [GSOC] pretty: provide human date format
>      @@ Documentation/pretty-formats.txt: The placeholders are:
>        '%ai':: author date, ISO 8601-like format
>        '%aI':: author date, strict ISO 8601 format
>        '%as':: author date, short format (`YYYY-MM-DD`)
>      -+'%ah':: author date, human style
>      ++'%ah':: author date, human style (like the --date=human option of
>      ++	linkgit:rev-list-options.txt[1])
>        '%cn':: committer name
>        '%cN':: committer name (respecting .mailmap, see
>        	linkgit:git-shortlog[1] or linkgit:git-blame[1])
>      @@ Documentation/pretty-formats.txt: The placeholders are:
>        '%ci':: committer date, ISO 8601-like format
>        '%cI':: committer date, strict ISO 8601 format
>        '%cs':: committer date, short format (`YYYY-MM-DD`)
>      -+'%ch':: committer date, human style
>      ++'%ch':: committer date, human style(like the --date=human option of
>      ++	linkgit:rev-list-options.txt[1])
>        '%d':: ref names, like the --decorate option of linkgit:git-log[1]
>        '%D':: ref names without the " (", ")" wrapping.
>        '%(describe[:options])':: human-readable name, like
>
>
>  Documentation/pretty-formats.txt | 4 ++++
>  pretty.c                         | 3 +++
>  t/t4205-log-pretty-formats.sh    | 6 ++++++
>  3 files changed, 13 insertions(+)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 45133066e412..e37d5cbb6b16 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -190,6 +190,8 @@ The placeholders are:
>  '%ai':: author date, ISO 8601-like format
>  '%aI':: author date, strict ISO 8601 format
>  '%as':: author date, short format (`YYYY-MM-DD`)
> +'%ah':: author date, human style (like the --date=human option of
shouldn't that option be quoted " `--date=human` " so as to match the
format in rev-list?
> +	linkgit:rev-list-options.txt[1])
Also. Is this right? Shouldn't it just link to the dashed git- command's
man page, rather than the file, i.e.
 linkgit:git-rev-list[1])
>  '%cn':: committer name
>  '%cN':: committer name (respecting .mailmap, see
>  	linkgit:git-shortlog[1] or linkgit:git-blame[1])
> @@ -206,6 +208,8 @@ The placeholders are:
>  '%ci':: committer date, ISO 8601-like format
>  '%cI':: committer date, strict ISO 8601 format
>  '%cs':: committer date, short format (`YYYY-MM-DD`)
> +'%ch':: committer date, human style(like the --date=human option of
likewise, quote the option ? and resolve the linkgit: to the man page
> +	linkgit:rev-list-options.txt[1])
>  '%d':: ref names, like the --decorate option of linkgit:git-log[1]
>  '%D':: ref names without the " (", ")" wrapping.
>  '%(describe[:options])':: human-readable name, like
> diff --git a/pretty.c b/pretty.c
> index e5b33ba034bd..b1ecd039cef2 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -745,6 +745,9 @@ static size_t format_person_part(struct strbuf *sb, char part,
>  	case 'I':	/* date, ISO 8601 strict */
>  		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(ISO8601_STRICT)));
>  		return placeholder_len;
> +	case 'h':	/* date, human */
> +		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(HUMAN)));
> +		return placeholder_len;
>  	case 's':
>  		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(SHORT)));
>  		return placeholder_len;
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index cabdf7d57a00..d4d75b0b350e 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -539,6 +539,12 @@ test_expect_success 'short date' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'human date' '
> +	git log --format=%ad%n%cd --date=human >expected &&
> +	git log --format=%ah%n%ch >actual &&
> +	test_cmp expected actual
> +'
> +
>  # get new digests (with no abbreviations)
>  test_expect_success 'set up log decoration tests' '
>  	head1=$(git rev-parse --verify HEAD~0) &&
>
> base-commit: b0c09ab8796fb736efa432b8e817334f3e5ee75a
Looks good otherwise.
Philip
