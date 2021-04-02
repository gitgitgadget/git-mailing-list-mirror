Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEB2C433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 20:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B462E61158
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 20:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbhDBUtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 16:49:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62681 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhDBUtB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 16:49:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 15C2412F6B9;
        Fri,  2 Apr 2021 16:49:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oHVWEDSW98xPv5jtsILQ1XC5rfs=; b=M+O0QL
        6TJaM/3rI05EHP19qD6kxoWMis3i3oiHV9NkgH9p7GJXaHwReij8tLavXH904IpJ
        vlzAQo/Kuyuw2igYizvWjOdZ0U+aiwf0RNqAoG95FO6yxzHYcOEa8aVOdsNMCQtW
        AlLmbqtF52Z6+5hVwrtVdc9SNGsGJVXaejtr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CoZH2p0OyNxUnB0GFMs9JDHAQbLksUnn
        0R1XEgN1FXF1gqawQti+f3H9GUg+dKkXPLoRyqf4Mx+9QvGO0eaeZ6sGBdUsl9gr
        /gYp/zP5yP1WGGdlk60bzcvPcVgy1V8OJwyft+LEJXbUw6tk4InpICB5j4eP+Ck1
        fXMZ/2YfI9o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0DC8912F6B8;
        Fri,  2 Apr 2021 16:49:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4016E12F6B7;
        Fri,  2 Apr 2021 16:48:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v6] [GSOC] trailer: add new trailer.<token>.cmd config
 option
References: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
        <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com>
Date:   Fri, 02 Apr 2021 13:48:55 -0700
In-Reply-To: <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Fri, 02 Apr 2021 13:26:12 +0000")
Message-ID: <xmqqim544dl4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D828611E-93F4-11EB-8583-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> quote (imagine a name like "O'Connor", substituted into
> NAME='$ARG' to make it NAME='O'Connor), it would result in

You inherited a typo from my review comments here.  This line should
have said

    NAME='$ARG' to make it NAME='O'Connor'), it would result in

I will tweak locally while queuing (read: no need to send an update
only to fix this line---but please do not forget to change it if you
are going to send an update to fix or improve other things).


>  Documentation/git-interpret-trailers.txt | 82 +++++++++++++++++---
>  t/t7513-interpret-trailers.sh            | 95 +++++++++++++++++++++++-
>  trailer.c                                | 38 +++++++---
>  3 files changed, 193 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 96ec6499f001..67649ec6134c 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -236,21 +236,34 @@ trailer.<token>.command::
>  	be called to automatically add or modify a trailer with the
>  	specified <token>.
>  +
> -When this option is specified, the behavior is as if a special
> -'<token>=<value>' argument were added at the beginning of the command
> -line, where <value> is taken to be the standard output of the
> -specified command with any leading and trailing whitespace trimmed
> -off.
> +When this option is specified, the first occurrence of substring $ARG is
> +replaced with the value given to the `interpret-trailer` command for the
> +same token.
>  +
> -If the command contains the `$ARG` string, this string will be
> -replaced with the <value> part of an existing trailer with the same
> -<token>, if any, before the command is launched.
> +".command" has been deprecated due to the $ARG in the user's command can
> +only be replaced once and the original way of replacing $ARG was not safe.
> +Now the preferred option is using "trailer.<token>.cmd", which use position
> +argument to pass the value.
> ++
> +When both .cmd and .command are given for the same <token>,
> +.cmd is used and .command is ignored.

Warning about unsafe replacement is a good idea.  OK.

> +trailer.<token>.cmd::
> +	The command specified by this configuration variable is run
> +	with a single parameter, which is the <value> part of an
> +	existing trailer with the same <token>.  The output from the
> +	command is then used as the value for the <token> in the
> +	resulting trailer.
> ++
> +When this option is specified, If there is no trailer with same <token>,

s/If/if/ (downcase).

> +the behavior is as if a special '<token>=<value>' argument were added at
> +the beginning of the command, <value> will be passed to the user's
> +command as an empty value.

Do the two occurrences of the word "command" in the sentence refer
to different things?  I do not think this is an existing problem
inherited from the original, but as we are trying to improve the
description, I wonder if we can clarify them a bit.

	... as if a '<token>=<value>' argument were added at the
	beginning of the "git interpret-trailers" command, the
	command specified by this configuration variable will be
	called with an empty string as the argument.

is my attempt, but I am not still sure what that "as if" part is
trying to say.  Does it mean with

	[trailer "Foo"] cmd = foo-cmd

and the 'input-file' does not have "Foo: <some existing value>"
trailer in it, the command "git interpret-trailers input-file"
would behave as if this command was run

	$ Foo= git interpret-trailers input-file

(as there is no <value>, I am not sure what <value> is used when
<token>=<value> is prefixed to the command)?

Puzzled and confused utterly am I...  Help, Christian?

>  +
>  If some '<token>=<value>' arguments are also passed on the command
>  line, when a 'trailer.<token>.command' is configured, the command will
>  also be executed for each of these arguments. And the <value> part of

This talks about 'trailer.<token>.command'.  Should this be changed
to '.cmd'? 

Or does everything after "When this option is specified, if there is
no trailer with ..." apply to both the old .command and new .cmd?
If so, that was not clear at all---we'd need to clarify this part.

> -these arguments, if any, will be used to replace the `$ARG` string in
> -the command.
> +these arguments, if any, will be passed to the command as first parameter.
>  
>  EXAMPLES
>  --------
> @@ -333,6 +346,55 @@ subject
>  Fix #42
>  ------------
>  
> +* Configure a 'see' trailer with a cmd use a global script `git-one`
> +  to show the subject of a commit that is related, and show how it works:
> ++
> +------------
> +$ cat ~/bin/git-one
> +#!/bin/sh
> +git show -s --pretty=reference "$1"
> +$ git config trailer.see.key "See-also: "
> +$ git config trailer.see.ifExists "replace"
> +$ git config trailer.see.ifMissing "doNothing"
> +$ git config trailer.see.cmd "~/bin/git-one"
> +$ git interpret-trailers <<EOF
> +> subject
> +> 
> +> message
> +> 
> +> see: HEAD~2
> +> EOF
> +subject
> +
> +message
> +
> +See-also: fe3187e (subject of related commit, 2021-4-2)
> +------------
> +
> +* Configure a 'who' trailer with a cmd use a global script `git-who`
> +  to find the recent matching "author <mail>" pair in git log and
> +  show how it works:
> ++
> +------------
> +$ cat ~/bin/git-who
> + #!/bin/sh
> +    git log -1 --format="%an <%ae>" --author="$1"

Unusual indentation here.  But more importantly, I am not sure if 
having both 'see' and 'help' examples is worth it---they are similar
enough that the second one does not teach anything new to those who
studied the first one already, aren't they?

> +$ git config trailer.help.key "Helped-by: "
> +$ git config trailer.help.ifExists "replace"
> +$ git config trailer.help.cmd "~/bin/git-who"
> +$ git interpret-trailers --trailer="help:gitster@" <<EOF
> +> subject
> +> 
> +> message
> +> 
> +> EOF
> +subject
> +
> +message
> +
> +Helped-by: Junio C Hamano <gitster@pobox.com>
> +------------
> +
>  * Configure a 'see' trailer with a command to show the subject of a
>    commit that is related, and show how it works:
>  +



> diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
> index 6602790b5f4c..923923e57573 100755
> --- a/t/t7513-interpret-trailers.sh
> +++ b/t/t7513-interpret-trailers.sh
> @@ -51,6 +51,77 @@ test_expect_success 'setup' '
>  	EOF
>  '
>  
> +test_expect_success 'with cmd' '
> +	test_when_finished "git config --unset trailer.bug.key && \
> +			    git config --unset trailer.bug.ifExists && \
> +			    git config --unset trailer.bug.cmd" &&

It is unwise to use && between these three "git config" invocations,
I suspect.  "git config --unset" exits with non-zero status when you
attempt to remove with an non-existent key, but you would remove the
.ifExists and .cmd even if .key is not defined.  Perhaps

	test_when_finished "git config --unset-all trailer.bug.key
			    git config --unset-all trailer.bug.ifExists
			    git config --unset-all trailer.bug.cmd" &&

would be more sensible.  Or if we just want to remove everything
under the trailer.bug.* section, this might be even better:

	test_when_finished "git config --remove-section trailer.bug" &&

as we can add new trailer.bug.* to the system and use them in this
test, but removing the entire section would still be a good way to
clean after ourselves.

> diff --git a/trailer.c b/trailer.c
> index be4e9726421c..6aeff6a1bd33 100644
> --- a/trailer.c
> +++ b/trailer.c
> ...
> +static char *apply_command(struct conf_info *conf, const char *arg)
>  {
>  	struct strbuf cmd = STRBUF_INIT;
>  	struct strbuf buf = STRBUF_INIT;
>  	struct child_process cp = CHILD_PROCESS_INIT;
>  	char *result;
>  
> -	strbuf_addstr(&cmd, command);
> -	if (arg)
> -		strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
> -
> -	strvec_push(&cp.args, cmd.buf);
> +	if (conf->cmd) {
> +		// cp.shell_no_implicit_args = 1;

Do not add new code that is commented out.  Besides we do not use // comment.

> +		strbuf_addstr(&cmd, conf->cmd);
> +		strvec_push(&cp.args, cmd.buf);
> +		if (arg)
> +			strvec_push(&cp.args, arg);

Thanks.
