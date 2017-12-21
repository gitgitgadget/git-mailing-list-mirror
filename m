Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D37511F424
	for <e@80x24.org>; Thu, 21 Dec 2017 20:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754888AbdLUU5x (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 15:57:53 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:40314 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752950AbdLUU5w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 15:57:52 -0500
Received: by mail-io0-f193.google.com with SMTP id v186so22419098iod.7
        for <git@vger.kernel.org>; Thu, 21 Dec 2017 12:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m8PXVd92HWxxVEvfUEI7DY1NSNt1f/qJ01XVPCdIeRY=;
        b=dATxMYHn+ivE9eoaNK0ZeT+IsxEguLIvMB9kRoTAuBO9wVyJCwNwom/CkdPQ1S90NY
         2ySWQ6oFjgVdgxsbkxnEnSMjTjGT9FtZZ8TSvZD4L16BiBwayhYOw7KnPr66+LxfPnHQ
         kboOd73GMFHGsh17R2/xfkEQ1wLuKyKkCRY21iItFt6JXpcnsdkdBVDgy+3pcuolb44q
         F4y+gm8LNmXaIfCRVncc/vqlPiH3ikFUAMYKCSAHtKt5B4w6uANIVM427dcoG3R/wIzu
         A21dmdbFgj2b0V6LgNszSe/3ydU8Xj0pTDme3fpmbxXdSauHuo3K/ni4t6Ex6TejQ+XE
         YqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m8PXVd92HWxxVEvfUEI7DY1NSNt1f/qJ01XVPCdIeRY=;
        b=Xev9JNeKh3NRyLy1HmY1OW5Wuv73qvphp6I2BtGoshsxtPBelgLYquHvcysDgZKCpg
         Z+BZ2cXcELquPzOzW7LmXaxqMm6Hz8quuPsMA5g1Of1itN32KpyuvE+ajcn8yo4q7LyH
         WDxioeFv9atR0SUYu7mjceu3QpDpTbtC0qCSnbfKeGK9EBT9vrCNYiTr9ew2hLj34EzS
         DkEqkvFivvq/m2n0L8zxqfnQXMTSO8eHeQljjK0yaE1aN5vP1AC7oEbBROIX+aPNAjIA
         yG4ZslxuN6TNJeFXpdNiF5bC4oG3dBaz/dMO6ZljF0lZaAxXgCMqS1gMrxfJL/NrNcbk
         2JWA==
X-Gm-Message-State: AKGB3mKt56a7S/sA9BeJWIbZxOfF7bPlXexRAqzQA6wFZAl1qQk3p5ID
        k997xrtT5fMYFOdtajn5Tu7Snxsi
X-Google-Smtp-Source: ACJfBouygt8dXYs5BlV50EO7Sexp15qfUpJSUPgWSj9V5eXKVRhDx5cjsqmEI2cuM8klaxMXtIBCcQ==
X-Received: by 10.107.156.149 with SMTP id f143mr14228001ioe.226.1513889871983;
        Thu, 21 Dec 2017 12:57:51 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id q82sm4690830itb.7.2017.12.21.12.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Dec 2017 12:57:51 -0800 (PST)
Date:   Thu, 21 Dec 2017 12:57:49 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 3/5] status: add --[no-]ahead-behind to porcelain V2
 output
Message-ID: <20171221205749.GC58971@aiede.mtv.corp.google.com>
References: <20171221190909.62995-1-git@jeffhostetler.com>
 <20171221190909.62995-4-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171221190909.62995-4-git@jeffhostetler.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff Hostetler wrote:

> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -141,6 +141,7 @@ static int sequencer_in_use;
>  static int use_editor = 1, include_status = 1;
>  static int show_ignored_in_status, have_option_m;
>  static struct strbuf message = STRBUF_INIT;
> +static int ahead_behind_opt = -1;

nit: is there a logical place amid these constants to put the new option
instead of chronological order to make it easier to read through later?
That also has the side-benefit of making the new option less likely to
collidate with other patches that add a new option to commit.

That collection of options seems to be mostly about how the commit
message is generated.  Maybe this one could go after status_format:

	static enum wt_status_format status_format = ...;
	static int ahead_behind;

Even better if it can be made into a local in cmd_status.

[...]
> @@ -1369,6 +1370,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>  		  N_("ignore changes to submodules, optional when: all, dirty, untracked. (Default: all)"),
>  		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
>  		OPT_COLUMN(0, "column", &s.colopts, N_("list untracked files in columns")),
> +		OPT_BOOL(0, "ahead-behind", &ahead_behind_opt,
> +			 N_("compute branch ahead/behind values")),
>  		OPT_END(),

Similar question: is there a natural place in "git status -h" to show
the new option instead of chronological order?

What does the value of the ahead_behind variable represent?  -1 means
unset so that we use config?  A comment might help.

[...]
> @@ -1389,6 +1392,21 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>  		       PATHSPEC_PREFER_FULL,
>  		       prefix, argv);
>  
> +	/*
> +	 * Porcelain formats only look at the --[no-]ahead-behind command
> +	 * line argument and DO NOT look at the config setting.  Non-porcelain
> +	 * formats use both.
> +	 */

nit: No need to shout: s/DO NOT/do not/

> +	if (status_format == STATUS_FORMAT_PORCELAIN ||
> +	    status_format == STATUS_FORMAT_PORCELAIN_V2) {
> +		if (ahead_behind_opt < 0)
> +			ahead_behind_opt = ABF_FULL;
> +	} else {
> +		if (ahead_behind_opt < 0)
> +			ahead_behind_opt = core_ahead_behind;
> +	}

Can be more concise, to save the reader some time if they don't care
about the defaulting behavior:

	if (ahead_behind_opt == -1) {
		if (status_format == ...)
			ahead_behind_opt = ...;
		else
			ahead_behind_opt = ...;
		}
	}

> +	s.ab_flags = ((ahead_behind_opt) ? ABF_FULL : ABF_QUICK);

nit: both parens here are unnecessary and don't make the code clearer

[...]
> --- a/t/t7064-wtstatus-pv2.sh
> +++ b/t/t7064-wtstatus-pv2.sh
> @@ -390,6 +390,66 @@ test_expect_success 'verify upstream fields in branch header' '
>  	)
>  '
>  
> +test_expect_success 'verify --no-ahead-behind generates branch.qab' '
> +	git checkout master &&
> +	test_when_finished "rm -rf sub_repo" &&
> +	git clone . sub_repo &&
> +	(
> +		## Confirm local master tracks remote master.
> +		cd sub_repo &&
> +		HUF=$(git rev-parse HEAD) &&
> +
> +		cat >expect <<-EOF &&
[...]

This looks like a collection of multiple tests.  Is there a
straightforward way to split them into multiple independent
test_expect_successes?

That way, it's easier to tell which failed if there is a regression
later and to run only one of them (using GIT_SKIP_TESTS) when
debugging such a failure.

Thanks,
Jonathan
