Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DBC31F597
	for <e@80x24.org>; Thu,  2 Aug 2018 18:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbeHBUOn (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 16:14:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41489 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeHBUOn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 16:14:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id j5-v6so3044625wrr.8
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 11:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rZwiE0JLpXkbt+5bBrUGeO7upKfvLvzPZZmbtl1cC6o=;
        b=j+/Podxyyqn5NDPzia+S6ka9PWbIO34KzXAP5QTuDAfYYmIj4GjONBFzykS7Yzjm5j
         bkMySj4+zfNb299+COL0eY7ed56mp7EPU11GzMEDNqXyspYYlSxvSAf4eKg5xBxiQHFC
         38T76YJroxd5QKh7cJ1sgPiv27dNX3URAmje1wF9Am2++fs13VSxx7lDRHJ7n/Qyijo1
         y2FIUaFIz+oANhnlubSumDhqlFm9XBbRiNKeYOBqaMojDIw54sPpm2Q0BxMH3DVUKBDb
         zl4VKwriO+qEB9Xt6VHR2Lxrih5IMw6SNsaVVqsZnApFyaMGgD91n+Gen9+UWaZ6T7w1
         mXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rZwiE0JLpXkbt+5bBrUGeO7upKfvLvzPZZmbtl1cC6o=;
        b=BA2ba2ZcTibMLeqs3t6idzN1LIZYp/zHftfFE+qRyWoW+ljaYQq/KYcHHHapP5PlNw
         2w91LnM8qNgGRflPL55XFzRpgiv2C7bkrt3Qtg9wqlcx8Tj3tyA6rlXmW1PWm7FL4HKp
         RCkI7fe4yQHgLqGEaWtpepBnjFnCD2yRwYvTKfyKR0Kvy2ys8ifQ/dRcAKa7iQ8Z7TGD
         HQxC1gbL4EeLyQnVCyz9FjvIUX6aeTGbgcRJCy+dKoiNATwW+NDtRqT8J2ncldIXuhKz
         S89FN7bPZR64XVwgVVrLllocHPR6FPFKjVYZesgCrnX/Ip7NzPz2cwofPitlP4UOjRXC
         flGg==
X-Gm-Message-State: AOUpUlGhA2lI36wPOPqZxgvxBdvsQUwfQ33erS3kLpxG01EZDRAkEzt6
        xI7HRfmCfNZGDnX8spTWk4tI3MDr
X-Google-Smtp-Source: AAOMgpdrycONAJgYxGVvzTEXUvzmwHUTJ9OnNhzMmcLfBjz1Ehld8nQnCFf7xbLJTYuWjULZq6X8/w==
X-Received: by 2002:adf:cd0e:: with SMTP id w14-v6mr370163wrm.226.1533234145622;
        Thu, 02 Aug 2018 11:22:25 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q8-v6sm3596526wrj.97.2018.08.02.11.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 11:22:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] sideband: highlight keywords in remote sideband output
References: <20180802114753.9715-1-hanwen@google.com>
        <20180802114753.9715-3-hanwen@google.com>
Date:   Thu, 02 Aug 2018 11:22:24 -0700
In-Reply-To: <20180802114753.9715-3-hanwen@google.com> (Han-Wen Nienhuys's
        message of "Thu, 2 Aug 2018 13:47:53 +0200")
Message-ID: <xmqqpnz01vdr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> The colorization is controlled with the config setting "color.remote".
> ...
> Finally, this solution is backwards compatible: many servers already
> prefix their messages with "error", and they will benefit from this
> change without requiring a server update. By contrast, a server-side
> solution would likely require plumbing the TERM variable through the
> git protocol, so it would require changes to both server and client.

Thanks; quite readable.

>
> Helped-by: Duy Nguyen <pclouds@gmail.com>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  Documentation/config.txt            |   9 +++
>  help.c                              |   1 +
>  help.h                              |   1 +
>  sideband.c                          | 119 +++++++++++++++++++++++++---
>  t/t5409-colorize-remote-messages.sh |  47 +++++++++++
>  5 files changed, 168 insertions(+), 9 deletions(-)
>  create mode 100644 t/t5409-colorize-remote-messages.sh

I'll "chmod +x" while queuing.

	Side note: When all problems pointed out are "I'll fix it
	this way while queuing"-kind, and if you agree to the way I
	plan to fix them up, then just saying so is sufficient and
	you do not have to send a new version of the patch(es).

If your "make test" did not catch this as an error, then we may need
to fix t/Makefile, as it is supposed to run test-lint.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 43b2de7b5..0783323be 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1229,6 +1229,15 @@ color.push::
>  color.push.error::
>  	Use customized color for push errors.
>  
> +color.remote::
> +	A boolean to enable/disable colored remote output. If unset,
> +	then the value of `color.ui` is used (`auto` by default).

Nobody tells the end-users what "colored remote output" does;
arguably they can find it out themselves by enabling the feature and
observing remote messages, but that is not user friendly.

	When running commands like `git fetch` and `git push` that
	interact with a remote repository, certain keywords (see
	`color.remote.<slot>`) that appear at the beginning of a
	line of message from the remote end can be painted in color.

	This configuration variable is a boolean to enable/disable
	the feature.  If unset...
	
or something like that, perhaps?

You use `always` in your tests to a good effect, but what the value
means is not described here.

> +color.remote.<slot>::
> +	Use customized color for each remote keywords. `<slot>` may be

Isn't 'each' a singular, i.e. "for each remote keyword"?  If so I do
not mind dropping 's' myself while queuing.

> +	`hint`, `warning`, `success` or `error` which match the
> +	corresponding keyword.

We need to say that keywords are painted case insensitively
somewhere in the doc.  Either do that here, or in the updated
description of `color.remote`---I am not sure which one results in
more readable text offhand.

> diff --git a/sideband.c b/sideband.c
> index 325bf0e97..5c72db83c 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -1,6 +1,103 @@
>  #include "cache.h"
> +#include "color.h"
> +#include "config.h"
>  #include "pkt-line.h"
>  #include "sideband.h"
> +#include "help.h"
> +
> +struct kwtable {
> +	/*
> +	 * We use keyword as config key so it can't contain funny chars like
> +	 * spaces. When we do that, we need a separate field for slot name in
> +	 * load_sideband_colors().
> +	 */
> +	const char *keyword;
> +	char color[COLOR_MAXLEN];
> +};
> +
> +static struct kwtable keywords[] = {
> +	{ "hint",	GIT_COLOR_YELLOW },
> +	{ "warning",	GIT_COLOR_BOLD_YELLOW },
> +	{ "success",	GIT_COLOR_BOLD_GREEN },
> +	{ "error",	GIT_COLOR_BOLD_RED },
> +};
> +
> +// Returns a color setting (GIT_COLOR_NEVER, etc).
> +static int use_sideband_colors(void)
> +{
> +	static int use_sideband_colors_cached = -1;
> +
> +	const char *key = "color.remote";
> +	struct strbuf sb = STRBUF_INIT;
> +	char *value;
> +	int i;
> +
> +	if (use_sideband_colors_cached >= 0)
> +		return use_sideband_colors_cached;
> +
> +	if (!git_config_get_string(key, &value))
> +		use_sideband_colors_cached = git_config_colorbool(key, value);
> +
> +	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
> +		strbuf_reset(&sb);
> +		strbuf_addf(&sb, "%s.%s", key, keywords[i].keyword);
> +		if (git_config_get_string(sb.buf, &value))
> +			continue;
> +		if (color_parse(value, keywords[i].color))
> +			die(_("expecting a color: %s"), value);
> +	}
> +	strbuf_release(&sb);
> +	return use_sideband_colors_cached;
> +}
> +
> +void list_config_color_sideband_slots(struct string_list *list, const char *prefix)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(keywords); i++)
> +		list_config_item(list, prefix, keywords[i].keyword);
> +}
> +
> +/*
> + * Optionally highlight some keywords in remote output if they appear at the
> + * start of the line. This should be called for a single line only.
> + */
> +void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
> +{
> +	int i;

In a block with a dozen more more lines, it is easier to have a
blank line between decls and the first statement, i.e. here.

> + 	if (!want_color_stderr(use_sideband_colors())) {

The above line is indented with SP followed by HT; don't.

> +		strbuf_add(dest, src, n);
> +		return;
> +	}
> +
> +	while (isspace(*src)) {
> +		strbuf_addch(dest, *src);
> +		src++;
> +		n--;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
> +		struct kwtable* p = keywords + i;

	struct kwtable *p = keywords + i;

> +		int len = strlen(p->keyword);
> +                /*
> +                 * Match case insensitively, so we colorize output from existing
> +                 * servers regardless of the case that they use for their
> +                 * messages. We only highlight the word precisely, so
> +                 * "successful" stays uncolored.
> +                 */

Indent with tabs, not a run of spaces, i.e. 

		int len = strlen(p->keyword);
		/*
		 * Match case insensitively, so we colorize output from existing
		 * servers regardless of the case that they use for their
		 * messages. We only highlight the word precisely, so
		 * "successful" stays uncolored.
		 */
		if (!strncasecmp(p->keyword, src, len) && !isalnum(src[len])) {

The code in this function looked OK otherwise.

> diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
> new file mode 100644
> index 000000000..4e1bd421f
> --- /dev/null
> +++ b/t/t5409-colorize-remote-messages.sh
> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +
> +test_description='remote messages are colorized on the client'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	mkdir .git/hooks &&

> +	cat << EOF > .git/hooks/update &&
> +#!/bin/sh
> +echo error: error
> +echo hint: hint
> +echo success: success
> +echo warning: warning
> +echo prefixerror: error
> +exit 0
> +EOF
> +	chmod +x .git/hooks/update &&

Use write_script, i.e. instead of all the above, say

	write_script .git/hooks/update <<-\EOF &&
	echo error: error
	echo hint: hint
	...
	exit 0
	EOF

so that you do not have to know or care the case where /bin/sh is
not the builder's preferred shell, etc.

Our tests are not written to demonstrate that our code works as
written.  It is to protect our code from getting broken by others
who may not share vision of the original author.  Make sure that you
cast what you care about in stone, e.g. include "echo ERROR: bad" or
something in the above to ensure that future updates to the code
will not turn the match into a case sensitive one without breaking
the test suite.

> +	echo 1 >file &&
> +	git add file &&
> +	git commit -m 1 &&
> +	git clone . child &&
> +	cd child &&
> +	echo 2 > file &&
> +	git commit -a -m 2

Don't chdir the whole testing environment like this.  Depending on
the success and failure in the middle of the above &&-chain, the
next test will start at an unexpected place, which is bad.

Instead, do something like

	git clone . child &&
	echo 2 >child/file &&
	git -C child commit -a -m 2

or

	git clone . child &&
	(
		cd child &&
		echo 2 >file &&
		git commit -a -m 2
	)

> +'
> +
> +test_expect_success 'push' '
> +	git -c color.remote=always push -f origin HEAD:refs/heads/newbranch 2>output &&
> +	test_decode_color <output >decoded &&
> +	grep "<BOLD;RED>error<RESET>:" decoded &&
> +	grep "<YELLOW>hint<RESET>:" decoded &&
> +	grep "<BOLD;GREEN>success<RESET>:" decoded &&
> +	grep "<BOLD;YELLOW>warning<RESET>:" decoded &&
> +	grep "prefixerror: error" decoded

A comment before this test (which covers both of these two) that
explains why many "grep" invocations are necessary, instead of a
comparison with a single multi-line expected result file.  I am
guessing that it is *not* because you cannot rely on the order of
these lines coming out from the update hook, but because the remote
output have lines other than what is given by the update hook and
we cannot afford to write them in the expected result file.

A more readable alternative might be to prepare the message that
come from the other side more parseable, e.g.

	write_script .git/hooks/update <<-\EOF &&
	echo 'BEGIN HOOK OUTPUT
	error: error
	Error: another error
	...
	END HOOK OUTPUT'
	EOF

and then

	sed -ne "/BEGIN HOOK OUTPUT/,/END HOOK OUTPUT/p" output |
	test_decode_color >decoded &&
	cat >expect <<-\EOF &&
	BEGIN HOOK OUTPUT
	<BOLD;RED>error<RESET>: error
	<BOLD;RED>Error<RESET>: another error
	...
	END HOOK OUTPUT
	EOF
	test_cmp expect decoded

Then we do not have to make readers puzzled why we are using bunch
of "grep" and do not explain with an extra comment.

Thanks.
