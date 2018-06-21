Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4752A1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 09:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932739AbeFUJha (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 05:37:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:49969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932677AbeFUJh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 05:37:28 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lh7PL-1g16Bg2qvf-00oaEC; Thu, 21
 Jun 2018 11:37:23 +0200
Date:   Thu, 21 Jun 2018 11:37:33 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][PATCH v2 1/3] sequencer: add a new function to silence
 a command, except if it fails.
In-Reply-To: <20180619154421.14999-2-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806211040430.11870@tvgsbejvaqbjf.bet>
References: <20180618131844.13408-1-alban.gruin@gmail.com> <20180619154421.14999-1-alban.gruin@gmail.com> <20180619154421.14999-2-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1/q/9I3Zy45g+BuDmyMqsmmz0m+ZtQ5JEJQdgN0hjbOU45fy9Xv
 /J9V6drr7S84rG6btZRrSr7eCOuNE1MU88B8BVDEDmXCd+QQt+BkjZ1ipSwC6Aoot/zoJK0
 TtGffcmtTMSOGNge6T7b2ElpsRH1Y549R9+YTgw8gKeWRtc5B9sTq8DdOe+jIHktyt8aPqD
 NpFday88sblxlUzQKw/Wg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kSuugwiHth4=:aRWQnrHMk2X5J4YMhx00jQ
 xbOLFrNoudnP3s0ZvzaoYOtVfZnnyCgyiAPL/UJVAy+/mAqnrTuUYf5sx2QvV6Hdiu9+U1+0T
 5kZQHDAdoN0SodtMpInVEC+7nDN61U7ZUqQ9ekmdKsholeVhw7AXAE41dyCctFDF9ZqVLLZEW
 v9OLj8pDbX+iqbVJKZCnjfTbeanHZQ1yfs7eYoqFwFJF5V9Nx9Q2ppTQVCLxk+UvyrdKlDocy
 eQRoH8+/DJMWHiOe0vdNucxKhYkHhFoO6FGhhyBm8fRroJDNBpF6CYu/s5EhyMX8Nd/wQcNm3
 TfA8XpK2Mp3O83VYO4ycmTRbpI5Zj/bfIL3pK1s6heHnt/wUK14apdRu/pwcy8KjkhjTHVhqS
 pJgT+MT3qfSl0IoC1W9EB9wGIJE0PjX3PB++WvmIqdjdPSMNn/CUCxZhQDaKCwgJ8MGhp+9kf
 veBnS5unGowaRUsIwNftXWGQT/gCa9fVuVXhgisHzR5nFQBhhmUH9AiNAbEeEB57pLWpUgWgI
 cqRYE100EJBi8+n3+bv2ZOGUoMvu04I3Na2MMLeyReqMIJEgMfi10xTOftg+mVhWeXs7svHkn
 25493JfH9+C40GWeLkgdCF5wgecjoIDLxqlHHA41lV+zbXEBqT2XmV69WcEZxcjrM3aGhnQoV
 MllUuwcmRg9KPF38WRZvOsF1n901pEtNDjzp8dhXrmzMkvdnb1tBn9RiXXboBJskslPBNjrUN
 h3B56nXQ2g4bLcYUZcKhtteaeDRFn9P9xImYT7ppWfKK5eijbPmQUgweekd9McxzHPtY0qlOX
 V/0apTq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Tue, 19 Jun 2018, Alban Gruin wrote:

> diff --git a/sequencer.c b/sequencer.c
> index 7cc76332e..9aa7ddb33 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -766,6 +766,29 @@ N_("you have staged changes in your working tree\n"
>  #define VERIFY_MSG  (1<<4)
>  #define CREATE_ROOT_COMMIT (1<<5)
>  
> +static int run_command_silent_on_success(struct child_process *cmd,
> +					 unsigned verbose)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	int rc;
> +
> +	if (verbose)
> +		return run_command(cmd);
> +
> +	/* hide stderr on success */
> +	cmd->stdout_to_stderr = 1;

This comment is a bit misleading: that line does not hide stderr on
success, it redirects stdout to stderr instead.

> +	rc = pipe_command(cmd,
> +			  NULL, 0,
> +			  /* stdout is already redirected */
> +			  NULL, 0,
> +			  &buf, 0);
> +
> +	if (rc)
> +		fputs(buf.buf, stderr);
> +	strbuf_release(&buf);
> +	return rc;
> +}
> +
>  /*
>   * If we are cherry-pick, and if the merge did not result in
>   * hand-editing, we will hit this commit and inherit the original
> @@ -820,18 +843,11 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>  
>  	cmd.git_cmd = 1;
>  
> -	if (is_rebase_i(opts)) {
> -		if (!(flags & EDIT_MSG)) {
> -			cmd.stdout_to_stderr = 1;
> -			cmd.err = -1;
> -		}

This code made sure that we *only* do this redirection, and stderr
buffering, if `git commit` is called non-interactively. When it is called
interactively, redirecting stdout and stderr is absolutely not what we
want.

> +	if (is_rebase_i(opts) && read_env_script(&cmd.env_array)) {
> +		const char *gpg_opt = gpg_sign_opt_quoted(opts);
>  
> -		if (read_env_script(&cmd.env_array)) {
> -			const char *gpg_opt = gpg_sign_opt_quoted(opts);
> -
> -			return error(_(staged_changes_advice),
> -				     gpg_opt, gpg_opt);
> -		}
> +		return error(_(staged_changes_advice),
> +			     gpg_opt, gpg_opt);
>  	}
>  
>  	argv_array_push(&cmd.args, "commit");
> @@ -861,21 +877,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>  	if (opts->allow_empty_message)
>  		argv_array_push(&cmd.args, "--allow-empty-message");
>  
> -	if (cmd.err == -1) {
> -		/* hide stderr on success */
> -		struct strbuf buf = STRBUF_INIT;
> -		int rc = pipe_command(&cmd,
> -				      NULL, 0,
> -				      /* stdout is already redirected */
> -				      NULL, 0,
> -				      &buf, 0);
> -		if (rc)
> -			fputs(buf.buf, stderr);
> -		strbuf_release(&buf);
> -		return rc;
> -	}
> -
> -	return run_command(&cmd);
> +	return run_command_silent_on_success(&cmd,
> +					     !(is_rebase_i(opts) && !(flags & EDIT_MSG)));

It would probably make more sense to change the signature of
`run_command_silent_on_success()` to not even take the `int verbose`
parameter: why call it "silent on success" when we can ask it *not* to be
silent on success?

And then you can avoid this overly-long line (as well as the quite
convoluted Boolean logic that took me a couple of seconds to verify) very
elegantly by this code:

	if (is_rebase_i(opts) && !(flags & EDIT_MSG))
		return run_command_silent_on_success(&cmd);
	return run_command(&cmd);

I vaguely recall that I wanted to make this an option in the `struct
child_process` when I originally introduced this code, but I think it was
Peff who suggested that doing it "by hand" was the more appropriate way
here because I use it only once.

My recollection might fail me, but if it is correct, maybe that would be a
good way forward, to make this an `int silent_on_success:1;` field?

Ciao,
Dscho
