Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14C341F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 19:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeKUGEy (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 01:04:54 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33695 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeKUGEx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 01:04:53 -0500
Received: by mail-ed1-f65.google.com with SMTP id r27so2969121eda.0
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 11:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=r2V/bpMk9CLlJr/ziHvYECgRow/e0qCAGpGt6klVKh4=;
        b=N/TdrE1Fhkp3AQO5tcZkQ3dzDfzCkZO58L8rfc8JnZsxx1P1ooUnmIM6TM260mcC/9
         Ep3gwO0m0tOEiW2HHfHHWvy4bInit/yDhcktK+zD4/DeG7hgCZwb2/FqHyssLIOS/slV
         pyMfJrHAbsWpNgtkEFeRX84pFnt12pM2OZiTw4orRYJKc3MULq5yZZkmyorrq+jv/F/g
         7mfszmvAIPyILzkKZRioZAkgxl5RqHoStscH/SwIA7Ds1b5iUGx4rmKPNCTTgvRaG2pc
         I5qwArAA07wSfaq4ITRY9WzOD77FwHk5b5QUFwDbraunzBCg8hJnADIWFuIMvzFaFvFh
         xd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=r2V/bpMk9CLlJr/ziHvYECgRow/e0qCAGpGt6klVKh4=;
        b=bf7jTB+kDzDSMT8Ulb0KtXOWGQAyjQEw88wlZW2/f+mZY/XlYC/aQQjmfI22N7nRt6
         qNB4SvYKEd61jzzNM0aXdb59y4BIlZh+qh6kzHDPVlphqKYsnjbAB8p/1QKQ1syYGzml
         qoMoJcMwBE8Z7+MYhwL1U8hoQewIXxi52PsjOUdXzhBADLs5MQCxjCTG8N77Rt2fQ9V0
         FBYyt9lJJ8DzWAKqUz5T3svdhEy6SbICUh4tBh0IvbGPPXnBudBKoNesGpz6Q/0BAG85
         eZ2f58oiRzAb9w11Vc/N8U/tMl7+KgR+bdA/5tM8KJjsqmBDp/Nz4wDgg0qnNoa9f2Rq
         jEeQ==
X-Gm-Message-State: AA+aEWbo4y2LauE2cN+krMaungGx74DXZ0n74LnfbNcapi6olbdk3CIs
        oUH3zZvi7sEYYIAgkUIRMBv+KnmrxCY=
X-Google-Smtp-Source: AFSGD/XhIIYFUbN9NPfvAWbfj7+yQnQ/pgS9uk3wveidzsf/XYlSLOPTtW2oF5YCVCzsT6cdFaF2mQ==
X-Received: by 2002:a50:8907:: with SMTP id e7mr3295149ede.252.1542742445302;
        Tue, 20 Nov 2018 11:34:05 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id d56sm11773213ede.76.2018.11.20.11.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 11:34:04 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 10/17] help: use command-list.txt for the source of guides
References: <20180519042752.8666-1-pclouds@gmail.com> <20180520184009.976-1-pclouds@gmail.com> <20180520184009.976-11-pclouds@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180520184009.976-11-pclouds@gmail.com>
Date:   Tue, 20 Nov 2018 20:34:01 +0100
Message-ID: <87pnuzzgpi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, May 20 2018, Nguyễn Thái Ngọc Duy wrote:

> The help command currently hard codes the list of guides and their
> summary in C. Let's move this list to command-list.txt. This lets us
> extract summary lines from Documentation/git*.txt. This also
> potentially lets us list guides in git.txt, but I'll leave that for
> now.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Documentation/gitattributes.txt        |  2 +-
>  Documentation/gitmodules.txt           |  2 +-
>  Documentation/gitrevisions.txt         |  2 +-
>  Makefile                               |  2 +-
>  builtin/help.c                         | 32 --------------------------
>  command-list.txt                       | 16 +++++++++++++
>  contrib/completion/git-completion.bash | 15 ++++++++----
>  help.c                                 | 21 +++++++++++++----
>  help.h                                 |  1 +
>  t/t0012-help.sh                        |  6 +++++
>  10 files changed, 54 insertions(+), 45 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 1094fe2b5b..083c2f380d 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -3,7 +3,7 @@ gitattributes(5)
>
>  NAME
>  ----
> -gitattributes - defining attributes per path
> +gitattributes - Defining attributes per path
>
>  SYNOPSIS
>  --------
> diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
> index db5d47eb19..4d63def206 100644
> --- a/Documentation/gitmodules.txt
> +++ b/Documentation/gitmodules.txt
> @@ -3,7 +3,7 @@ gitmodules(5)
>
>  NAME
>  ----
> -gitmodules - defining submodule properties
> +gitmodules - Defining submodule properties
>
>  SYNOPSIS
>  --------
> diff --git a/Documentation/gitrevisions.txt b/Documentation/gitrevisions.txt
> index 27dec5b91d..1f6cceaefb 100644
> --- a/Documentation/gitrevisions.txt
> +++ b/Documentation/gitrevisions.txt
> @@ -3,7 +3,7 @@ gitrevisions(7)
>
>  NAME
>  ----
> -gitrevisions - specifying revisions and ranges for Git
> +gitrevisions - Specifying revisions and ranges for Git
>
>  SYNOPSIS
>  --------
> diff --git a/Makefile b/Makefile
> index a60a78ee67..1efb751e46 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1937,7 +1937,7 @@ $(BUILT_INS): git$X
>
>  command-list.h: generate-cmdlist.sh command-list.txt
>
> -command-list.h: $(wildcard Documentation/git-*.txt)
> +command-list.h: $(wildcard Documentation/git*.txt)
>  	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt >$@+ && mv $@+ $@
>
>  SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
> diff --git a/builtin/help.c b/builtin/help.c
> index 0e0af8426a..5727fb5e51 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -402,38 +402,6 @@ static void show_html_page(const char *git_cmd)
>  	open_html(page_path.buf);
>  }
>
> -static struct {
> -	const char *name;
> -	const char *help;
> -} common_guides[] = {
> -	{ "attributes", N_("Defining attributes per path") },
> -	{ "everyday", N_("Everyday Git With 20 Commands Or So") },
> -	{ "glossary", N_("A Git glossary") },
> -	{ "ignore", N_("Specifies intentionally untracked files to ignore") },
> -	{ "modules", N_("Defining submodule properties") },
> -	{ "revisions", N_("Specifying revisions and ranges for Git") },
> -	{ "tutorial", N_("A tutorial introduction to Git (for version 1.5.1 or newer)") },
> -	{ "workflows", N_("An overview of recommended workflows with Git") },
> -};
> -
> -static void list_common_guides_help(void)
> -{
> -	int i, longest = 0;
> -
> -	for (i = 0; i < ARRAY_SIZE(common_guides); i++) {
> -		if (longest < strlen(common_guides[i].name))
> -			longest = strlen(common_guides[i].name);
> -	}
> -
> -	puts(_("The common Git guides are:\n"));
> -	for (i = 0; i < ARRAY_SIZE(common_guides); i++) {
> -		printf("   %s   ", common_guides[i].name);
> -		mput_char(' ', longest - strlen(common_guides[i].name));
> -		puts(_(common_guides[i].help));
> -	}
> -	putchar('\n');
> -}
> -
>  static const char *check_git_cmd(const char* cmd)
>  {
>  	char *alias;
> diff --git a/command-list.txt b/command-list.txt
> index 3bd23201a6..99ddc231c1 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -139,3 +139,19 @@ gitweb                                  ancillaryinterrogators
>  git-whatchanged                         ancillaryinterrogators
>  git-worktree                            mainporcelain
>  git-write-tree                          plumbingmanipulators
> +gitattributes                           guide
> +gitcli                                  guide
> +gitcore-tutorial                        guide
> +gitcvs-migration                        guide
> +gitdiffcore                             guide
> +giteveryday                             guide
> +gitglossary                             guide
> +githooks                                guide
> +gitignore                               guide
> +gitmodules                              guide
> +gitnamespaces                           guide
> +gitrepository-layout                    guide
> +gitrevisions                            guide
> +gittutorial-2                           guide
> +gittutorial                             guide
> +gitworkflows                            guide
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 62ca8641f4..4e724a5b76 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1575,6 +1575,13 @@ _git_grep ()
>  	__git_complete_refs
>  }
>
> +__git_all_guides=
> +__git_compute_all_guides ()
> +{
> +	test -n "$__git_all_guides" ||
> +	__git_all_guides=$(git --list-cmds=list-guide)
> +}
> +
>  _git_help ()
>  {
>  	case "$cur" in
> @@ -1584,11 +1591,9 @@ _git_help ()
>  		;;
>  	esac
>  	__git_compute_all_commands
> -	__gitcomp "$__git_all_commands $(__git_aliases)
> -		attributes cli core-tutorial cvs-migration
> -		diffcore everyday gitk glossary hooks ignore modules
> -		namespaces repository-layout revisions tutorial tutorial-2
> -		workflows
> +	__git_compute_all_guides
> +	__gitcomp "$__git_all_commands $(__git_aliases) $__git_all_guides
> +		gitk
>  		"
>  }
>
> diff --git a/help.c b/help.c
> index c7df1d2338..23924dd300 100644
> --- a/help.c
> +++ b/help.c
> @@ -39,12 +39,14 @@ static struct category_description main_categories[] = {
>  	{ 0, NULL }
>  };
>
> -static const char *drop_prefix(const char *name)
> +static const char *drop_prefix(const char *name, uint32_t category)
>  {
>  	const char *new_name;
>
>  	if (skip_prefix(name, "git-", &new_name))
>  		return new_name;
> +	if (category == CAT_guide && skip_prefix(name, "git", &new_name))
> +		return new_name;
>  	return name;
>
>  }
> @@ -66,7 +68,7 @@ static void extract_cmds(struct cmdname_help **p_cmds, uint32_t mask)
>  			continue;
>
>  		cmds[nr] = *cmd;
> -		cmds[nr].name = drop_prefix(cmd->name);
> +		cmds[nr].name = drop_prefix(cmd->name, cmd->category);
>
>  		nr++;
>  	}
> @@ -358,11 +360,22 @@ void list_cmds_by_category(struct string_list *list,
>  	for (i = 0; i < n; i++) {
>  		struct cmdname_help *cmd = command_list + i;
>
> -		if (cmd->category & cat_id)
> -			string_list_append(list, drop_prefix(cmd->name));
> +		if (!(cmd->category & cat_id))
> +			continue;
> +		string_list_append(list, drop_prefix(cmd->name, cmd->category));
>  	}
>  }
>
> +void list_common_guides_help(void)
> +{
> +	struct category_description catdesc[] = {
> +		{ CAT_guide, N_("The common Git guides are:") },
> +		{ 0, NULL }
> +	};
> +	print_cmd_by_category(catdesc);
> +	putchar('\n');
> +}
> +
>  void list_all_cmds_help(void)
>  {
>  	print_cmd_by_category(main_categories);
> diff --git a/help.h b/help.h
> index 40917fc38c..b2293e99be 100644
> --- a/help.h
> +++ b/help.h
> @@ -20,6 +20,7 @@ static inline void mput_char(char c, unsigned int num)
>
>  extern void list_common_cmds_help(void);
>  extern void list_all_cmds_help(void);
> +extern void list_common_guides_help(void);
>
>  extern void list_all_main_cmds(struct string_list *list);
>  extern void list_all_other_cmds(struct string_list *list);
> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> index 060df24c2d..bc27df7f38 100755
> --- a/t/t0012-help.sh
> +++ b/t/t0012-help.sh
> @@ -66,6 +66,12 @@ test_expect_success 'git help' '
>  	test_i18ngrep "^   commit " help.output &&
>  	test_i18ngrep "^   fetch  " help.output
>  '
> +test_expect_success 'git help -g' '
> +	git help -g >help.output &&
> +	test_i18ngrep "^   attributes " help.output &&
> +	test_i18ngrep "^   everyday   " help.output &&
> +	test_i18ngrep "^   tutorial   " help.output
> +'
>
>  test_expect_success 'generate builtin list' '
>  	git --list-cmds=builtins >builtins

On a branch I branched off current master (bb75be6cb9) I was
consistently getting failures on this test:

    expecting success:
            git help -g >help.output &&
            test_i18ngrep "^   attributes " help.output &&
            test_i18ngrep "^   everyday   " help.output &&
            test_i18ngrep "^   tutorial   " help.output

       attributes      Defining attributes per path
       everyday        A useful minimum set of commands for Everyday Git
    error: 'grep ^   tutorial    help.output' didn't find a match in:

    The common Git guides are:
       attributes      Defining attributes per path
       cli             Git command-line interface and conventions
       core-tutorial   A Git core tutorial for developers
       cvs-migration   Git for CVS users
       diffcore        Tweaking diff output
       everyday        A useful minimum set of commands for Everyday Git
       glossary        A Git Glossary
       hooks           Hooks used by Git
       ignore          Specifies intentionally untracked files to ignore
       modules         Defining submodule properties

    'git help -a' and 'git help -g' list available subcommands and some
    concept guides. See 'git help <command>' or 'git help <concept>'
    to read about a specific subcommand or concept.
    not ok 7 - git help -g
    #
    #               git help -g >help.output &&
    #               test_i18ngrep "^   attributes " help.output &&
    #               test_i18ngrep "^   everyday   " help.output &&
    #               test_i18ngrep "^   tutorial   " help.output
    #

This was after running "make all doc". The issue went away when I ran
'git clean -dxf' and I haven't been able to reproduce it again. Just
wanted to leave a note in case anyone else runs into this heisenbug,
perhaps there's some missing dependency in the command-list.h generation
logic.
