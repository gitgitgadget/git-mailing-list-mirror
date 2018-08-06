Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 009A5208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 17:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbeHFTbg (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 15:31:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40255 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeHFTbg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 15:31:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15-v6so13099306wrs.7
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2uGJRCzwTQGa8LK7EFjAA4HlRUIIH6z6qEHh62VEPPM=;
        b=hWK8P9jG87f4F9pOu+uNxOAxXg1C2mWrtDUxkK/jaUZHu/UMrsLJ2p1ovgtBNzG/Y/
         3BL1FBUqU8JVt08TE3bWoC05Z9Hs8VkkktcNT033m94qwTJ8/in1FtDYLuek9Vo8pCO4
         oXIlUcWfps8vnbLP6Kb+Tqhpx6+EHSycbllsQK//RDva6FNJDGYeZUYICN1QTO8y5Zt9
         VlAv3rXunFAcqlpYEUNCDfl2kTXba3fkKluzcN3rYzoRMDDKZX3+cutmXSBNDIr4WLxO
         Lph59Bv+tNq2vn/XswjMka92estey/BB5/8XmCJ8OGyMuz+Ispf9dYCvO2kmMFF0YDxk
         lSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2uGJRCzwTQGa8LK7EFjAA4HlRUIIH6z6qEHh62VEPPM=;
        b=WyV3BUUvwdJSQiTqdX2r0MGA/DvtL9CmZtyrV8hDD8rj72pv31tmEiXN4uwIjyHluy
         gGUaXLMLj71F410KX4ZsahMxLrbgz3OJYFEYYIv4Thn7mQtx3lDNf4Mu3YH+BzEv23GT
         Z5ll2dq7jlDQStYlraCS3r2GxbyeYGa2mwWI8NmV8WwD8q9UtDGUSiItpw4iutoVDZ8I
         oZreQdc/Co63wSWsVm33Uo7oesldKYZbqpqv+mfcf77bedi17pNuk/STpG1Fgbd/y8Mk
         QSj+GokuEJDvPuqJgTBCc0NXfmm6V2FIsA5VAcLlbNVCY5GI17qg9/ijgFweyMR87q/f
         NR1w==
X-Gm-Message-State: AOUpUlFUJuhVhMUpKqDAI5ciRAjqBhdQIr0Kw56jG0FIY+PMRfZLLe48
        ZsaqhQrl9YCY2aGJNW188dc=
X-Google-Smtp-Source: AAOMgpeZeJaBjsyRQYtU0nXTYn5OV4RMDbQLCOdJzjvm2bD4+Bo1xPPt0LCwIbDWqbUbeNuXa1tdVA==
X-Received: by 2002:adf:dfcd:: with SMTP id q13-v6mr10081547wrn.113.1533576089314;
        Mon, 06 Aug 2018 10:21:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s7-v6sm14073817wru.96.2018.08.06.10.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 10:21:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     sunshine@sunshineco.com, jrn@google.com, git@vger.kernel.org
Subject: Re: [PATCH v5 2/2] sideband: highlight keywords in remote sideband output
References: <20180806143313.104495-1-hanwen@google.com>
        <20180806143313.104495-3-hanwen@google.com>
Date:   Mon, 06 Aug 2018 10:21:27 -0700
In-Reply-To: <20180806143313.104495-3-hanwen@google.com> (Han-Wen Nienhuys's
        message of "Mon, 6 Aug 2018 16:33:13 +0200")
Message-ID: <xmqqbmafpg14.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> The Git push process itself prints lots of non-actionable messages
> (eg. bandwidth statistics, object counters for different phases of the
> process), which obscures actionable error messages that servers may

s/which obscures/which obscure/, as I think that "which" refers to
"messages" above.

> The highlighting is done on the client rather than server side, so
> servers don't have to grow capabilities to understand terminal escape
> codes and terminal state. It also consistent with the current state
> where Git is control of the local display (eg. prefixing messages with
> "remote: ").

Yup.

When we introduce "the receiving end asks messages to be sent with
such and such decoration" protocol support, we would want a lot more
than just painting messages in color, e.g. i18n, verbosity, and even
"Hey, I am a script, send them in json".

Until that happens, let's keep things simpler.  No i18n messages and
no colored output over the wire.

> +color.remote::
> +	If set, keywords at the start of the line are highlighted. The
> +	keywords are "error", "warning", "hint" and "success", and are
> +	matched case-insensitively. Maybe set to `always`, `false` (or
> +	`never`) or `auto` (or `true`). If unset, then the value of
> +	`color.ui` is used (`auto` by default).

Reads much better.

I am still trying to find a concise way to help readers who saw a
line that begins with "Warnings: foo bar bla" and accept that it is
OK the early 7 chars are not painted.  "... case-insensitively and
honoring word boundary" is the best I came up so far, but  I am
afraid that is adding more words without hinting what I want to convey
strongly enough, so I am not going to suggest that (at least not yet).

> diff --git a/help.h b/help.h
> index f8b15323a6..9eab6a3f89 100644
> --- a/help.h
> +++ b/help.h
> @@ -83,6 +83,7 @@ void list_config_color_diff_slots(struct string_list *list, const char *prefix);
>  void list_config_color_grep_slots(struct string_list *list, const char *prefix);
>  void list_config_color_interactive_slots(struct string_list *list, const char *prefix);
>  void list_config_color_status_slots(struct string_list *list, const char *prefix);
> +void list_config_color_sideband_slots(struct string_list *list, const char *prefix);
>  void list_config_fsck_msg_ids(struct string_list *list, const char *prefix);
>  
>  #endif /* HELP_H */
> diff --git a/sideband.c b/sideband.c
> index 325bf0e974..239be2ec85 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -1,6 +1,108 @@
>  #include "cache.h"
> +#include "color.h"
> +#include "config.h"
>  #include "pkt-line.h"
>  #include "sideband.h"
> +#include "help.h"
> +
> +struct keyword_entry {
> +	/*
> +	 * We use keyword as config key so it should be a single alphanumeric word.
> +	 */
> +	const char *keyword;
> +	char color[COLOR_MAXLEN];
> +};
> +
> +static struct keyword_entry keywords[] = {
> +	{ "hint",	GIT_COLOR_YELLOW },
> +	{ "warning",	GIT_COLOR_BOLD_YELLOW },
> +	{ "success",	GIT_COLOR_BOLD_GREEN },
> +	{ "error",	GIT_COLOR_BOLD_RED },
> +};
> +/* Returns a color setting (GIT_COLOR_NEVER, etc). */
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
> +	if (!git_config_get_string(key, &value)) {
> +		use_sideband_colors_cached = git_config_colorbool(key, value);
> +	} else if (!git_config_get_string("color.ui", &value)) {
> +		use_sideband_colors_cached = git_config_colorbool("color.ui", value);
> +	} else {
> +		use_sideband_colors_cached = GIT_COLOR_AUTO;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
> +		strbuf_reset(&sb);
> +		strbuf_addf(&sb, "%s.%s", key, keywords[i].keyword);

This design means future enhancement to allow more keywords will
have to be done in the form of adding more "color.remote.<key>",
which means a few restrictions on them are cast in stone at the
end-user facing design level, which we need to be careful about.

	Side note. I do not worry about the implementation level
	limitation at all.  For example, the current code will not
	allow end-users and projects to add new keywords to be
	painted, as it relies on the keywords[] static array we can
	see above.  But that implementation detail does not prevent
	us from improving it later to support more code in this
	codepath that notices "color.remote.failure" in config file
	and paint a line that begins with "failure:".

Because the third-level "variable" name is case insensive, matching
of any future keyword MUST be also done case insensitively.

Also, as you mentioned elsewhere in this patch, the string that can
be in the keyword MUST begin with an alphabetic and consists only of
alphanumeric or dash.

I do not think these limitations imposed by the design decision this
patch is making are particularly bad ones---we just need to be aware
of and firm about them.  When somebody else comes in the future and
wants to recognize "F A I L" as a custom keyword case sensitively,
we must be able to comfortably say "no" to it.

	Side note. We _could_ instead use "remotemsg.<key>.color"
	namespace, as the subsection names at the second level is a
	lot looser, but I do not think it is a good idea to use in
	this application, as they are case sensitive.

The above discussion may deserve to be in the log message as a
record to tell future ourselves why we decided to use
color.remote.<key>.

> +		if (git_config_get_string(sb.buf, &value))
> +			continue;
> +		if (color_parse(value, keywords[i].color))
> +			die(_("config value %s is not a color: %s"), sb.buf, value);

That's a bit inconsistent, isn't it?  If the configuration is not
even a string, we ignore it and continue, but if it is a string, we
insist that it names a color and otherwise die?

> +	}
> +	strbuf_release(&sb);
> +	return use_sideband_colors_cached;
> +}

> +/*
> + * Optionally highlight one keyword in remote output if it appears at the start
> + * of the line. This should be called for a single line only, which must be
> + * passed as the first N characters of the SRC array.
> + */

Saying "MUST be" is cheap, but do we have anybody who polices that
requirement?

I think the code is OK without any assert() or BUG(), and that is
because the design is "we just paint the keyword at the beginning of
what the other side of the sideband wants us to show as a single
unit".  If the other side sends a payload with an embedded LF in a
single packet, that's their choice and we are free not to paint the
beginning of the second line after that LF.  So from that point of
view, perhaps we shouldn't even talk about "a single line only".

> +static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
> +{
> +	int i;
> +
> +	if (!want_color_stderr(use_sideband_colors())) {
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
> +		struct keyword_entry *p = keywords + i;
> +		int len = strlen(p->keyword);
> +		/*
> +		 * Match case insensitively, so we colorize output from existing
> +		 * servers regardless of the case that they use for their
> +		 * messages. We only highlight the word precisely, so
> +		 * "successful" stays uncolored.
> +		 */
> +		if (!strncasecmp(p->keyword, src, len) && !isalnum(src[len])) {
> +			strbuf_addstr(dest, p->color);
> +			strbuf_add(dest, src, len);
> +			strbuf_addstr(dest, GIT_COLOR_RESET);
> +			n -= len;
> +			src += len;
> +			break;
> +		}
> +	}
> +
> +	strbuf_add(dest, src, n);
> +}
> +
>  
>  /*
>   * Receive multiplexed output stream over git native protocol.
> @@ -16,7 +118,7 @@
>  #define DISPLAY_PREFIX "remote: "
>  
>  #define ANSI_SUFFIX "\033[K"
> -#define DUMB_SUFFIX "        "
> +#define DUMB_SUFFIX "	     "
>  

Was this change intended and if so for what purpose?  I can drop
this hunk if this is a mere finger-slip without proofreading, but I
do not want to do so without making sure I am not missing anything
and not discarding a meaningful change.

>  int recv_sideband(const char *me, int in_stream, int out)
>  {


> diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
> new file mode 100755
> index 0000000000..a9afb55ef1
> --- /dev/null
> +++ b/t/t5409-colorize-remote-messages.sh
> @@ -0,0 +1,80 @@
> +#!/bin/sh
> +
> +test_description='remote messages are colorized on the client'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	mkdir .git/hooks &&
> +	write_script .git/hooks/update <<-\EOF &&
> +echo error: error
> +echo ERROR: also highlighted
> +echo hint: hint
> +echo hinting: not highlighted
> +echo success: success
> +echo warning: warning
> +echo prefixerror: error
> +echo "  error: leading space"
> +exit 0
> +EOF

Noticing the dash in "<<-", I would have expected all of the above
lines to be indented with a tab to align with 'w' in 'write_script'.

> +	chmod +x .git/hooks/update &&

No need for this "chmod +x"; that's one of the points in using
write_script.

Thanks.
