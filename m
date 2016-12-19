Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA2921FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 23:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933234AbcLSXdF (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 18:33:05 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:36188 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932155AbcLSXdE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 18:33:04 -0500
Received: by mail-io0-f180.google.com with SMTP id 136so166334417iou.3
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 15:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l8w+JqqkIiuJR6FU2VyD6TrcQTqUXM/y2jUKlJLr4lM=;
        b=WLTdQUTq1CkM3voLeJK8vZvN9m1qg7dQpTDXuBWIULPio204Cbe8u2J/zdNhS5CSUy
         35/F7M56fYbu5d5OMhl59PP8EWeeKUYugN0IiGmruJSQAALYL1GNjWC6CtsbgVzwhfdK
         OGiQya0vvKLR38yPb93x9bGqzklGPubgLsR4m2ZXk/s8y5YVn3ggp71fEESCGbVFQKlp
         dyJoVIX1hBCYWxfiyJvqlPKowdg8o5pzYt0nXqpxQTfQx+ouYQm5fjvSvJ5uy6xUTc3N
         O563iXRsngB1f6Xp/hnoTpwP0Y/0GSwLlthzcTdesSq+cKK3rFS9Wz7ZDA8mGOSH1MtO
         qyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l8w+JqqkIiuJR6FU2VyD6TrcQTqUXM/y2jUKlJLr4lM=;
        b=Y0lUne2mC0hGj1GS9d7zmBuwyd0fGB5rP7Kn7vt+jeDN0iU+Kuo35zhD5FdIwBmWRb
         G7A3czduB4aew+t/DDFbJkGISea40hMqXaRUFFm9xw2Js+h4HSUZo9fRG3X5wMSZt/MW
         mPyjMs3XsGS4UVaeYTe/0QHROSd1WDw2wD2Xmp8P2HZVA5hqLCI71zHSHNGs5k8cjl1J
         BQn+SwE24gy0/sf11kk/11gbYpyYNVkyfpf68veFhGUwM9RSK6qcnTOULbMoUsxGEKpV
         a84ltTYtMiUzB0/zJIr1vhg2VMVir+ykt5oto54UV4lmVBAjDlZC6yL5aFF+D2T20ArD
         X7sA==
X-Gm-Message-State: AIkVDXLeMNfFEzgFSSXbhXcfT//siYI4gz8gz7PTWsPF/p4DCYcBq271SVuKKLBrz5327X1Y
X-Received: by 10.107.55.136 with SMTP id e130mr17237941ioa.76.1482190378626;
        Mon, 19 Dec 2016 15:32:58 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:8043:3f72:e099:d313])
        by smtp.gmail.com with ESMTPSA id w188sm7899865itc.9.2016.12.19.15.32.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Dec 2016 15:32:57 -0800 (PST)
Date:   Mon, 19 Dec 2016 15:32:56 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org,
        sandals@crustytoothpaste.net, David.Turner@twosigma.com
Subject: Re: [PATCHv4 3/5] run-command: add {run,start,finish}_command_or_die
Message-ID: <20161219233256.GB41080@google.com>
References: <20161219232828.5075-1-sbeller@google.com>
 <20161219232828.5075-4-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161219232828.5075-4-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/19, Stefan Beller wrote:
> In a later patch we want to report the exact command that we run in the
> error message. Add a convenient way to the run command API that runs the
> given command or reports the exact command as failure.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  run-command.c | 28 ++++++++++++++++++++++++++++
>  run-command.h |  4 ++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/run-command.c b/run-command.c
> index ca905a9e80..a0587db334 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -279,6 +279,17 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
>  	return code;
>  }
>  
> +static void report_and_die(struct child_process *cmd, const char *action)
> +{
> +	int i;
> +	struct strbuf err = STRBUF_INIT;
> +	if (cmd->git_cmd)
> +		strbuf_addstr(&err, "git ");
> +	for (i = 0; cmd->argv[i]; )

Missing the increment of i here.

> +		strbuf_addf(&err, "'%s'", cmd->argv[i]);
> +	die(_("could not %s %s"), action, err.buf);
> +}
> +
>  int start_command(struct child_process *cmd)
>  {
>  	int need_in, need_out, need_err;
> @@ -546,6 +557,12 @@ int start_command(struct child_process *cmd)
>  	return 0;
>  }
>  
> +void start_command_or_die(struct child_process *cmd)
> +{
> +	if (start_command(cmd))
> +		report_and_die(cmd, "start");
> +}
> +
>  int finish_command(struct child_process *cmd)
>  {
>  	int ret = wait_or_whine(cmd->pid, cmd->argv[0], 0);
> @@ -558,6 +575,11 @@ int finish_command_in_signal(struct child_process *cmd)
>  	return wait_or_whine(cmd->pid, cmd->argv[0], 1);
>  }
>  
> +void finish_command_or_die(struct child_process *cmd)
> +{
> +	if (finish_command(cmd))
> +		report_and_die(cmd, "finish");
> +}
>  
>  int run_command(struct child_process *cmd)
>  {
> @@ -592,6 +614,12 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
>  	return run_command(&cmd);
>  }
>  
> +void run_command_or_die(struct child_process *cmd)
> +{
> +	if (finish_command(cmd))
> +		report_and_die(cmd, "run");
> +}
> +
>  #ifndef NO_PTHREADS
>  static pthread_t main_thread;
>  static int main_thread_set;
> diff --git a/run-command.h b/run-command.h
> index dd1c78c28d..e4585885c5 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -56,6 +56,10 @@ int finish_command(struct child_process *);
>  int finish_command_in_signal(struct child_process *);
>  int run_command(struct child_process *);
>  
> +void start_command_or_die(struct child_process *);
> +void finish_command_or_die(struct child_process *);
> +void run_command_or_die(struct child_process *);
> +
>  /*
>   * Returns the path to the hook file, or NULL if the hook is missing
>   * or disabled. Note that this points to static storage that will be
> -- 
> 2.11.0.rc2.53.gb7b3fba.dirty
> 

-- 
Brandon Williams
