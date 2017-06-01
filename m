Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37BA2027C
	for <e@80x24.org>; Thu,  1 Jun 2017 07:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbdFAHvH (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 03:51:07 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35903 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbdFAHvG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 03:51:06 -0400
Received: by mail-it0-f66.google.com with SMTP id i206so4358449ita.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 00:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gOgdp0YAbAXHKfjAzcNhgzS1baKEWUfLWvG7cHF5lQU=;
        b=SMpx4QtL579564jC/E9D9aoxv2F5cgVrcRYEQdpzA4EhxMeySn4ETUKhobiztv/9TC
         2u3ADorp/31jkcxBh2qJ58rRPqgB8o10pjMfEfwxp4pvBmuyph43w+IDs76XNMkO9pAI
         bkljUswh3PszBiWnuOVsEpPmICMzf1qhB5MT+NZv0Jupg5LTQTvhjRl6q3MQE+fBBg/j
         vsOzVjPxp/4nHknL415NKVE1d9PKLKgfP3R+9++P/hyUZd0GJFyPMqs3huS2/2TXH+E0
         o5uMkeXch8Tfe1DyjPstsPNkukz8R55SZSfHc3PqwAUXZZKl/TKlM65ZvncXuT4mgRAP
         xIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gOgdp0YAbAXHKfjAzcNhgzS1baKEWUfLWvG7cHF5lQU=;
        b=iJiFlyfQ4/fTooPKI4xEXcW6LROKM+RZDfNl2cKQhP4b/45Joyrgp5EMjbeTHnFD10
         guPT20wzKY8NnSxs3RYlbpUFDVQBZJiuqY8gZUzxqlPWhFgZJYqCjyb0tMlcVO5tZWPQ
         ynKp1KZeho0tez1yQGMWfBsSVfHWkV2Bp7Tw9rPpfVgNoGCpvGdmH1jnW8EdhFSIyMiT
         7zpoVbdoFA7yidS+CjmSo8GLjjt/zQYgv7z5H/e7ug0Py1g7boGfYFx9pfMjxobD4354
         HYdivJoWJTkuviV7Pk2VMzphzYV8MUsZjoGHrXLlwTNuexnY78NOF9i8t2Hb0qJFOMRz
         ovTg==
X-Gm-Message-State: AODbwcDH1sKk6+4mEr90qIVmOUkCHj+19FopHwVhO0Uqc4fgA21SIhW2
        xegxkLBTMnMBNQ==
X-Received: by 10.36.46.200 with SMTP id i191mr11384289ita.83.1496303465665;
        Thu, 01 Jun 2017 00:51:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id m15sm11998009iti.19.2017.06.01.00.51.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 00:51:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 8/8] t0012: test "-h" with builtins
References: <20170530051930.pqywvihwl5klg7hz@sigill.intra.peff.net>
        <xmqqwp8yc255.fsf@gitster.mtv.corp.google.com>
        <20170530060555.ponbsyp4agdo4yau@sigill.intra.peff.net>
        <xmqqshjmc1wm.fsf@gitster.mtv.corp.google.com>
        <20170530061546.tdpuhvq7yk34rvlj@sigill.intra.peff.net>
        <xmqqo9uabhqt.fsf@gitster.mtv.corp.google.com>
        <20170530152756.vs777v6unaxg6otb@sigill.intra.peff.net>
        <xmqqinkg734c.fsf@gitster.mtv.corp.google.com>
        <xmqq7f0w6z7u.fsf@gitster.mtv.corp.google.com>
        <xmqq37bk6ynz.fsf@gitster.mtv.corp.google.com>
        <20170601062511.e53kpcmqukaxb5fy@sigill.intra.peff.net>
Date:   Thu, 01 Jun 2017 16:51:04 +0900
In-Reply-To: <20170601062511.e53kpcmqukaxb5fy@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 1 Jun 2017 02:25:12 -0400")
Message-ID: <xmqqo9u85eon.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If we don't mind a one-time pain, I think we can just convert the
> existing usage() to something more like usage_with_options(). The patch
> below does that (and teaches the latter to handle a NULL options field).
>
> The diff is ugly, and the conversion is mostly mechanical. But I think
> some sites can be improved. For example, look at the change in bundle.c,
> which now hands a set of strings rather than formatting the whole "or:"
> chain manually.
> ...
> With bonus points for actually describing each option (though at that
> point it may be as much work to just convert the thing to parse-options,
> which would also be fine with me).
>
> That's tedious work which would need attention paid to each individual
> command. So I'd probably do a single mechanical patch like this one
> (that keeps the output identical), and then let people fix each one up
> on top.

Yup.  Unlike my other hack, this does look more useful to me.  It
was kind of surprising that the change to parse-options is just a
single liner, but it's just "no input resulting in no output" ;-)

> diff --git a/git.c b/git.c
> index 1b8b7f51a..3496f8a23 100644
> --- a/git.c
> +++ b/git.c
> @@ -3,12 +3,14 @@
>  #include "help.h"
>  #include "run-command.h"
>  
> -const char git_usage_string[] =
> +const char *git_usage_string[] = {
>  	"git [--version] [--help] [-C <path>] [-c name=value]\n"
>  	"           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
>  	"           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]\n"
>  	"           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
> -	"           <command> [<args>]";
> +	"           <command> [<args>]",
> +	NULL
> +};
>  
>  const char git_more_info_string[] =
>  	N_("'git help -a' and 'git help -g' list available subcommands and some\n"
> @@ -694,7 +696,7 @@ int cmd_main(int argc, const char **argv)
>  	} else {
>  		/* The user didn't specify a command; give them help */
>  		commit_pager_choice();
> -		printf("usage: %s\n\n", git_usage_string);
> +		printf("usage: %s\n\n", git_usage_string[0]);
>  		list_common_cmds_help();
>  		printf("\n%s\n", _(git_more_info_string));
>  		exit(1);


> diff --git a/parse-options.c b/parse-options.c
> index a23a1e67f..b0cc2a410 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -600,6 +600,9 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
>  		usagestr++;
>  	}
>  
> +	if (!opts)
> +		return PARSE_OPT_HELP;
> +
>  	if (opts->type != OPTION_GROUP)
>  		fputc('\n', outfile);

