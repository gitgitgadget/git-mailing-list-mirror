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
	by dcvr.yhbt.net (Postfix) with ESMTP id 254291F453
	for <e@80x24.org>; Wed, 13 Feb 2019 13:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfBMNbf (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 08:31:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43244 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfBMNbf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 08:31:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id r2so2472484wrv.10
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 05:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=+kF1c3jK6+nsBL0z267c1Afqeb+Dyd5BkibCMSMNnbQ=;
        b=DoxmOSPn8X+nwT/DjWJ+S+3hI8ZgWgx8PKSp0EnNqiXA6qsy6bNxRubY56kuibdMuX
         biHYTIp329QZ6jrjEaVQ1cgG99wixc6xMgi3+lcUCxYuGxgEwFioPpR+2K3JPf6p8utj
         BcIKonFWXNVGTM4WUMXcblUzhZS+QE+ukdB6VN+XnLPtxsV2cXLonKOeHiJ3R2XtLgpe
         g1Y7xU4C2wngLvjDtaHNvF5OM7flFECuGGAR3jJx4JqLqG7NxndPOqhvrLSh027EB8Nd
         gUuj40Hb0+CAxDwGReBMZup43d/wL1cikUrM3vUYLRoL+1krJxm/Bl1Ke+PAe5YEflLp
         pNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=+kF1c3jK6+nsBL0z267c1Afqeb+Dyd5BkibCMSMNnbQ=;
        b=eeipAbHz7YYcMBCSGd0HpIrFnxdgWBvbWQv7tLSxD4CfjFrR5qo9RTl4kD244BHdGp
         RsQaLDAABtYuz6yq/sOQLf2CFC65V4OkRVWjkjCaoZ9yYMsFYFwI9VBcBUeVRkNmBqx+
         2MaWs2UfnxmSBVzKIX1NuKjoPyHZq52lTyJm8ylPXar9+Cn6OSte/n+7y8PYn+sKz+eX
         xT4YpTckfXpWVJ/dpJfOTAP2Wh7PxM1VMSl56HSslvJ418q49pAVk2FbnmoLYY7rA5dn
         72ovcPeGAbtSsOE1g1dV+cUYjca5Oaqcfwvb9HKWFyrunyeYu9oexQtYLTDLClOO5Esw
         WU5g==
X-Gm-Message-State: AHQUAubfnykH5tKczdDO93V6CDo8O5Hqfvi1lQj4AtS3+sFCBtHEqdzI
        CdlawzzV4Vl2PaAw7t0gxohwzYT8c54=
X-Google-Smtp-Source: AHgI3IbHZOmDJq5myAr2vYAnnqK2c0WF0YTGeyhue71qIpsT6fQN2SnfMuJU0cPx7TEQXvjEEgVQoA==
X-Received: by 2002:adf:dfca:: with SMTP id q10mr435887wrn.45.1550064692835;
        Wed, 13 Feb 2019 05:31:32 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id b3sm8451890wme.27.2019.02.13.05.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 05:31:31 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rebase -x: sanity check command
References: <nycvar.QRO.7.76.6.1901291632070.41@tvgsbejvaqbjf.bet> <20190129184327.30391-1-phillip.wood@talktalk.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190129184327.30391-1-phillip.wood@talktalk.net>
Date:   Wed, 13 Feb 2019 14:31:24 +0100
Message-ID: <87ftsrke6r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 29 2019, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If the user gives an empty argument to --exec then git creates a todo
> list that it cannot parse. The rebase starts to run before erroring out
> with
>
>   error: missing arguments for exec
>   error: invalid line 2: exec
>   You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
>   Or you can abort the rebase with 'git rebase --abort'.
>
> Instead check for empty commands before starting the rebase.
>
> Also check that the command does not contain any newlines as the
> todo-list format is unable to cope with multiline commands. Note that
> this changes the behavior, before this change one could do
>
> git rebase --exec='echo one
> exec echo two'
>
> and it would insert two exec lines in the todo list, now it will error
> out.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>
> Apologies for the resend but I messed up the from address on the
> previous send and I don't think it made it to the mailing list.
>
> Thanks for the comments. I've updated the code as suggested by Dscho
> and tried to make it clearer in the commit message that this is fixing
> git creating a todo-list that it cannot parse.
>
> Range-diff against v1:
> 1:  9626549aec ! 1:  726b84c300 rebase -x: sanity check command
>     @@ -2,8 +2,9 @@
>
>          rebase -x: sanity check command
>
>     -    If the user gives an empty argument to --exec then the rebase starts to
>     -    run before erroring out with
>     +    If the user gives an empty argument to --exec then git creates a todo
>     +    list that it cannot parse. The rebase starts to run before erroring out
>     +    with
>
>            error: missing arguments for exec
>            error: invalid line 2: exec
>     @@ -33,21 +34,16 @@
>
>      +static int check_exec_cmd(const char *cmd)
>      +{
>     -+	int non_blank = 0;
>     ++	if (strchr(cmd, '\n'))
>     ++		return error(_("exec commands cannot contain newlines"));
>      +
>     -+	while (*cmd) {
>     -+		if (*cmd == '\n')
>     -+			return error(_("exec commands cannot contain newlines"));
>     -+		if (!isspace(*cmd))
>     -+			non_blank = 1;
>     -+		cmd++;
>     -+	}
>     ++	/* Does the command consist purely of whitespace? */
>     ++	if (!cmd[strspn(cmd, " \t\r\f\v")])
>     ++		return error(_("empty exec command"));
>      +
>     -+	if (non_blank)
>     -+		return 0;
>     -+
>     -+	return error(_("empty exec command"));
>     ++	return 0;
>      +}
>     ++
>      +
>       int cmd_rebase(int argc, const char **argv, const char *prefix)
>       {
>
>  builtin/rebase.c              | 17 +++++++++++++++++
>  t/t3404-rebase-interactive.sh | 19 +++++++++++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 00de70365e..f75bd79b45 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -793,6 +793,19 @@ static void set_reflog_action(struct rebase_options *options)
>  	strbuf_release(&buf);
>  }
>
> +static int check_exec_cmd(const char *cmd)
> +{
> +	if (strchr(cmd, '\n'))
> +		return error(_("exec commands cannot contain newlines"));
> +
> +	/* Does the command consist purely of whitespace? */
> +	if (!cmd[strspn(cmd, " \t\r\f\v")])
> +		return error(_("empty exec command"));
> +
> +	return 0;
> +}
> +
> +
>  int cmd_rebase(int argc, const char **argv, const char *prefix)
>  {
>  	struct rebase_options options = {
> @@ -1130,6 +1143,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>
> +	for (i = 0; i < exec.nr; i++)
> +		if (check_exec_cmd(exec.items[i].string))
> +			exit(1);
> +
>  	if (!(options.flags & REBASE_NO_QUIET))
>  		argv_array_push(&options.git_am_opts, "-q");
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 7a440e08d8..c98f64eb2d 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -147,6 +147,25 @@ test_expect_success 'rebase -i with the exec command checks tree cleanness' '
>  	git rebase --continue
>  '
>
> +test_expect_success 'rebase -x with empty command fails' '
> +	test_when_finished "git rebase --abort ||:" &&
> +	test_must_fail git rebase -x "" @ 2>actual &&
> +	test_write_lines "error: empty exec command" >expected &&
> +	test_i18ncmp expected actual &&
> +	test_must_fail git rebase -x " " @ 2>actual &&
> +	test_i18ncmp expected actual
> +'
> +
> +LF='
> +'
> +test_expect_success 'rebase -x with newline in command fails' '
> +	test_when_finished "git rebase --abort ||:" &&
> +	test_must_fail git rebase -x "a${LF}b" @ 2>actual &&
> +	test_write_lines "error: exec commands cannot contain newlines" \
> +			 >expected &&
> +	test_i18ncmp expected actual
> +'
> +
>  test_expect_success 'rebase -i with exec of inexistent command' '
>  	git checkout master &&
>  	test_when_finished "git rebase --abort" &&

This patch breaks the test suite (with these two new tests) under
GIT_TEST_REBASE_USE_BUILTIN=false. So a 2.21.0-rc0 regression.

It would have been better to raise this before the rc period, but I just
noticed this now, but we can now:

 1. Skip the test under that mode
 2. Fix the shell code to do the same thing
 3. Just remove the shell code & GIT_TEST_REBASE_USE_BUILTIN=false mode

Maybe we should just do #3. The reason for the escape hatch was in case
we had bugs, and now we've had a full release cycle, but maybe that's
too early...
