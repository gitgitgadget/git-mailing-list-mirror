Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12D941F403
	for <e@80x24.org>; Mon, 18 Jun 2018 15:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754940AbeFRP0l (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 11:26:41 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:23108 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754481AbeFRP0l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 11:26:41 -0400
Received: from [192.168.2.240] ([92.22.19.223])
        by smtp.talktalk.net with SMTP
        id Uw3BfSfA7VlGZUw3BfS6kf; Mon, 18 Jun 2018 16:26:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1529335599;
        bh=JkI2D0gDPiHT0vK6hlLk3q4j3sJfllFp43/IekN70xI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=A2HnYejtSNDpmfAgVuyA3KacmwWIoG7ES9Q98IRaBhuurAN/IJuAjepjQgG8JMXhi
         Dvi/Cb4/gPrj7jEF4w3Ki3FQImUENqkiB9MthYvfJ1eEmSBbnenx4P2iB3l5z2znXy
         cY/aSdYL7O60InIPxq7my7ixHRyIjmhiOrVIEvsU=
X-Originating-IP: [92.22.19.223]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=DH/r9e32v+C519lOzZJhbw==:117
 a=DH/r9e32v+C519lOzZJhbw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=JEJBCbLQAcAHY0qy_rUA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH 1/3] sequencer: add a new function to silence a
 command, except if it fails.
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
References: <20180618131844.13408-1-alban.gruin@gmail.com>
 <20180618131844.13408-2-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <b23a9e30-58bf-afde-4d77-563e0b288e70@talktalk.net>
Date:   Mon, 18 Jun 2018 16:26:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618131844.13408-2-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfG+2Sr4QG5WvjVuOoNqy6dBy3yOhdzPHbxxrfw5uPrksk8pvhOioLPHiF5+7YJZvKeCArbkZd6b9Q4q2LtNPm0KOoPVSZEakaSQdKU2mo0kYypSEatTh
 JXHW5+dd89E1d1nMrNhqcpUDypSnPmckBi+CKlke0qpRz3JVHckZF86SQOOjecatrd8BFHpFzIh08/uVqeai5hOfxBS9bWQPMYLNmSHo9ji1FtTkhbFpYUye
 z/GLhXo0O4bNshyWyewOoSlWhBAsCRuzFw+DjdyHXhV+mUP2g6jZa9i60xUw1RecWrYJU2FUleCp7m0qfjSjWwbDbcxcrXV/AY5I/0EZe/Oyvh2Njdtvp1oa
 GIdAwro2VZsAJ1k+YgJoS9KjzOONMwDsDQ0j+/duBhqS7djRY4QpPiPLqg+vmQqr0daUBqaP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 18/06/18 14:18, Alban Gruin wrote:
> This adds a new function, run_command_silent_if_successful(), to
> redirect the stdout and stderr of a command to a strbuf, and then to run
> that command. This strbuf is printed only if the command fails. It is
> functionnaly similar to output() from git-rebase.sh.

s/functionnaly/functionally/

It's not quite the same though because the shell versions handles 
--verbose where as here the caller has to put that check in every call 
site. I wonder if it would simplify the callers if the C version did the 
--verbose handling it's self.


Best Wishes

Phillip
> run_git_commit() is then refactored to use of
> run_command_silent_if_successful().
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>   sequencer.c | 53 +++++++++++++++++++++++++++--------------------------
>   1 file changed, 27 insertions(+), 26 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 7cc76332e..3437673d2 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -766,6 +766,25 @@ N_("you have staged changes in your working tree\n"
>   #define VERIFY_MSG  (1<<4)
>   #define CREATE_ROOT_COMMIT (1<<5)
>   
> +static int run_command_silent_on_success(struct child_process *cmd)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	int rc;
> +
> +	/* hide stderr on success */
> +	cmd->stdout_to_stderr = 1;
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
>   /*
>    * If we are cherry-pick, and if the merge did not result in
>    * hand-editing, we will hit this commit and inherit the original
> @@ -820,18 +839,11 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>   
>   	cmd.git_cmd = 1;
>   
> -	if (is_rebase_i(opts)) {
> -		if (!(flags & EDIT_MSG)) {
> -			cmd.stdout_to_stderr = 1;
> -			cmd.err = -1;
> -		}
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
>   	}
>   
>   	argv_array_push(&cmd.args, "commit");
> @@ -861,21 +873,10 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>   	if (opts->allow_empty_message)
>   		argv_array_push(&cmd.args, "--allow-empty-message");
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
> +	if (is_rebase_i(opts) && !(flags & EDIT_MSG))
> +		return run_command_silent_on_success(&cmd);
> +	else
> +		return run_command(&cmd);
>   }
>   
>   static int rest_is_empty(const struct strbuf *sb, int start)
> 

