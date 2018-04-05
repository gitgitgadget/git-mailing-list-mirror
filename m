Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 120721F404
	for <e@80x24.org>; Thu,  5 Apr 2018 22:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751538AbeDEWsk (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 18:48:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:50421 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeDEWsj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 18:48:39 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYLKn-1f094a2MXh-00VCxF; Fri, 06
 Apr 2018 00:48:33 +0200
Date:   Fri, 6 Apr 2018 00:48:33 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] Colorize push errors
In-Reply-To: <cover.1518783709.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1522968472.git.johannes.schindelin@gmx.de>
References: <cover.1518783709.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UKsWR9Lbazs96PAqrGucVhh/au1JgM7qi49MYFO7JrJDpAqfXr0
 JGUDOjzktZOIsE6oj7+Rb0feUS+OvWs29Qqb+/9cJDqWzu7lo2/nAVbKsQhyVhKgLvXzxDH
 3ZPXfyj5s+d4W0p1RqCKE6SCinOE2dHk2Ry4V9tVx8Vu2MmdozBkMQVPYMh5qttQpQ2vV7H
 dQ6DrCzZP3m0XPkTxyU2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S8EiBCMpnQ8=:zIySG6p2ylabazYvxfRvRO
 Izm5g0ejL2Jqw31IeIL9/VOyWcDtd74FjNg/YocSNwA07uyrYt4gANlOIAWWC15T8CFreSf6a
 yqH88ytxq1ipjDT9p6CwcUFuOnXYnFQlwCqBwUYJzjh/A49iY80Y0db52h1bCbHuXmXWSvCj3
 B3tnxjhRotJZ7Bxgy+rhLpSpcGsFv/cMZro6vTEIFshDDCoTdonLJYHA3db440kTj6lFJzAZF
 nvBYQ1iIDSW2J9sw018aMRV9DVFCGs/R/+wKehI4/s06gQ4qNT/dHNElsot+XeKsBnjWBhXmU
 EZKShIxzuysRBnra7Ektp2AdSC7aL+wJdOTLixTIeo3qCWFA2now0dPvKwVnYHVGh2zUXC59b
 U5jiMSoPgLQAd4CBrbIyICE3gZes/t77lIm/pc39dSVcGx5s5yV2kuVTdghqvVrO0LG8ljlGo
 J50URQysnb7DDrM9BDIXrgt6FLaOuIbuVKh8ri+/CPV2XwFff0v1VtsE+aEbhF+mycKKeJMAG
 LWjZpMb+mAN64v1EaMceeL8ml1PeKoSDECBChGYcpFY5TTorItFueVEw3jkeAHtxVljJXjhyJ
 K4l0m/cldckXNe8DvuhBEdnCex8XME2yzgvwQmLuJSX7FTp0Bj0K+5SGOkou/j62vKEUoa+ka
 C3SFwTGseB28TH4leuNPuHGjZ+sce1y9xD7bnxfoeP+ywKTjTItcOnuPUsejXbLiKJ4OJvcqj
 7rLlaBjBikN7KJ1UeWq2BhZ5QbpAu3olxz99wXCEI5fKjG3Sfn/UJ07/RA94SSeYPBmKRLh88
 /iNr+IHpdcbtYU36UqkyzZYicAqP5Aegz3V1RZyZStJ+hggszrPonoCgDmaXXEkQdGr337v
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To help users discern large chunks of white text (when the push
succeeds) from large chunks of white text (when the push fails), let's
add some color to the latter.

The original contribution came in via Pull Request from the Git for
Windows project:

	https://github.com/git-for-windows/git/pull/1429

Changes since v1:

- implemented want_color_fd() as suggested by Junio

- added color.{advice,push,transport} to be able to force this thing on

- added a test

- added documentation to `git config`'s man page

- fixed a bug where the push config looked at color.advice.<slot>

- fixed a bug where `color.advise.<slot>` was not parsed because
  git_default_config() would fail to hand `color.advise.*` settings to
  git_default_advice_config()

- wrapped a couple of too-long lines

- changed the strstr() hack to detect push failures to use push_had_errors()
  instead

- renamed the transport.color.* settings to color.transport.* (to make them
  consistent with all the other color.<category>.<slot> settings)


Johannes Schindelin (3):
  color: introduce support for colorizing stderr
  Add a test to verify that push errors are colorful
  Document the new color.* settings to colorize push errors/hints

Ryan Dammrose (1):
  push: colorize errors

 Documentation/config.txt   | 28 ++++++++++++++++
 advice.c                   | 49 ++++++++++++++++++++++++++--
 builtin/push.c             | 44 ++++++++++++++++++++++++-
 color.c                    | 20 +++++++-----
 color.h                    |  4 ++-
 config.c                   |  2 +-
 t/t5541-http-push-smart.sh | 18 ++++++++++
 transport.c                | 67 +++++++++++++++++++++++++++++++++++++-
 8 files changed, 217 insertions(+), 15 deletions(-)


base-commit: 468165c1d8a442994a825f3684528361727cd8c0
Published-As: https://github.com/dscho/git/releases/tag/colorize-push-errors-v2
Fetch-It-Via: git fetch https://github.com/dscho/git colorize-push-errors-v2

Interdiff vs v1:
 diff --git a/Documentation/config.txt b/Documentation/config.txt
 index 4e0cff87f62..40e3828b85f 100644
 --- a/Documentation/config.txt
 +++ b/Documentation/config.txt
 @@ -1088,6 +1088,16 @@ clean.requireForce::
  	A boolean to make git-clean do nothing unless given -f,
  	-i or -n.   Defaults to true.
  
 +color.advice::
 +	A boolean to enable/disable color in hints (e.g. when a push
 +	failed, see `advice.*` for a list).  May be set to `always`,
 +	`false` (or `never`) or `auto` (or `true`), in which case colors
 +	are used only when the error output goes to a terminal. If
 +	unset, then the value of `color.ui` is used (`auto` by default).
 +
 +color.advice.advice::
 +	Use customized color for hints.
 +
  color.branch::
  	A boolean to enable/disable color in the output of
  	linkgit:git-branch[1]. May be set to `always`,
 @@ -1190,6 +1200,15 @@ color.pager::
  	A boolean to enable/disable colored output when the pager is in
  	use (default is true).
  
 +color.push::
 +	A boolean to enable/disable color in push errors. May be set to
 +	`always`, `false` (or `never`) or `auto` (or `true`), in which
 +	case colors are used only when the error output goes to a terminal.
 +	If unset, then the value of `color.ui` is used (`auto` by default).
 +
 +color.push.error::
 +	Use customized color for push errors.
 +
  color.showBranch::
  	A boolean to enable/disable color in the output of
  	linkgit:git-show-branch[1]. May be set to `always`,
 @@ -1218,6 +1237,15 @@ color.status.<slot>::
  	status short-format), or
  	`unmerged` (files which have unmerged changes).
  
 +color.transport::
 +	A boolean to enable/disable color when pushes are rejected. May be
 +	set to `always`, `false` (or `never`) or `auto` (or `true`), in which
 +	case colors are used only when the error output goes to a terminal.
 +	If unset, then the value of `color.ui` is used (`auto` by default).
 +
 +color.transport.rejected::
 +	Use customized color when a push was rejected.
 +
  color.ui::
  	This variable determines the default value for variables such
  	as `color.diff` and `color.grep` that control the use of color
 diff --git a/advice.c b/advice.c
 index 42460877ef6..2121c1811fd 100644
 --- a/advice.c
 +++ b/advice.c
 @@ -43,7 +43,7 @@ static int parse_advise_color_slot(const char *slot)
  
  static const char *advise_get_color(enum color_advice ix)
  {
 -	if (want_color(advice_use_color))
 +	if (want_color_stderr(advice_use_color))
  		return advice_colors[ix];
  	return "";
  }
 @@ -87,8 +87,10 @@ void advise(const char *advice, ...)
  
  	for (cp = buf.buf; *cp; cp = np) {
  		np = strchrnul(cp, '\n');
 -		fprintf(stderr,	_("%shint: %.*s%s\n"), advise_get_color(ADVICE_COLOR_HINT),
 -			(int)(np - cp), cp, advise_get_color(ADVICE_COLOR_RESET));
 +		fprintf(stderr,	_("%shint: %.*s%s\n"),
 +			advise_get_color(ADVICE_COLOR_HINT),
 +			(int)(np - cp), cp,
 +			advise_get_color(ADVICE_COLOR_RESET));
  		if (*np)
  			np++;
  	}
 @@ -100,6 +102,11 @@ int git_default_advice_config(const char *var, const char *value)
  	const char *k, *slot_name;
  	int i;
  
 +	if (!strcmp(var, "color.advice")) {
 +		advice_use_color = git_config_colorbool(var, value);
 +		return 0;
 +	}
 +
  	if (skip_prefix(var, "color.advice.", &slot_name)) {
  		int slot = parse_advise_color_slot(slot_name);
  		if (slot < 0)
 diff --git a/builtin/push.c b/builtin/push.c
 index e443dd40de9..ac3705370e1 100644
 --- a/builtin/push.c
 +++ b/builtin/push.c
 @@ -41,7 +41,7 @@ static int parse_push_color_slot(const char *slot)
  
  static const char *push_get_color(enum color_push ix)
  {
 -	if (want_color(push_use_color))
 +	if (want_color_stderr(push_use_color))
  		return push_colors[ix];
  	return "";
  }
 @@ -365,10 +365,11 @@ static int push_with_options(struct transport *transport, int flags)
  		fprintf(stderr, _("Pushing to %s\n"), transport->url);
  	err = transport_push(transport, refspec_nr, refspec, flags,
  			     &reject_reasons);
 -	if (err != 0)
 +	if (err != 0) {
  		fprintf(stderr, "%s", push_get_color(PUSH_COLOR_ERROR));
  		error(_("failed to push some refs to '%s'"), transport->url);
  		fprintf(stderr, "%s", push_get_color(PUSH_COLOR_RESET));
 +	}
  
  	err |= transport_disconnect(transport);
  	if (!err)
 @@ -545,7 +546,10 @@ static int git_push_config(const char *k, const char *v, void *cb)
  			else
  				string_list_append(&push_options_config, v);
  		return 0;
 -	} else if (skip_prefix(k, "color.advice.", &slot_name)) {
 +	} else if (!strcmp(k, "color.push")) {
 +		push_use_color = git_config_colorbool(k, v);
 +		return 0;
 +	} else if (skip_prefix(k, "color.push.", &slot_name)) {
  		int slot = parse_push_color_slot(slot_name);
  		if (slot < 0)
  			return 0;
 diff --git a/color.c b/color.c
 index f277e72e4ce..c6c6c4f580f 100644
 --- a/color.c
 +++ b/color.c
 @@ -319,18 +319,20 @@ int git_config_colorbool(const char *var, const char *value)
  	return GIT_COLOR_AUTO;
  }
  
 -static int check_auto_color(void)
 +static int check_auto_color(int fd)
  {
 -	if (color_stdout_is_tty < 0)
 -		color_stdout_is_tty = isatty(1);
 -	if (color_stdout_is_tty || (pager_in_use() && pager_use_color)) {
 +	static int color_stderr_is_tty = -1;
 +	int *is_tty_p = fd == 1 ? &color_stdout_is_tty : &color_stderr_is_tty;
 +	if (*is_tty_p < 0)
 +		*is_tty_p = isatty(fd);
 +	if (*is_tty_p || (fd == 1 && pager_in_use() && pager_use_color)) {
  		if (!is_terminal_dumb())
  			return 1;
  	}
  	return 0;
  }
  
 -int want_color(int var)
 +int want_color_fd(int fd, int var)
  {
  	/*
  	 * NEEDSWORK: This function is sometimes used from multiple threads, and
 @@ -339,15 +341,15 @@ int want_color(int var)
  	 * is listed in .tsan-suppressions for the time being.
  	 */
  
 -	static int want_auto = -1;
 +	static int want_auto[3] = { -1, -1, -1 };
  
  	if (var < 0)
  		var = git_use_color_default;
  
  	if (var == GIT_COLOR_AUTO) {
 -		if (want_auto < 0)
 -			want_auto = check_auto_color();
 -		return want_auto;
 +		if (want_auto[fd] < 0)
 +			want_auto[fd] = check_auto_color(fd);
 +		return want_auto[fd];
  	}
  	return var;
  }
 diff --git a/color.h b/color.h
 index cd0bcedd084..5b744e1bc68 100644
 --- a/color.h
 +++ b/color.h
 @@ -88,7 +88,9 @@ int git_config_colorbool(const char *var, const char *value);
   * Return a boolean whether to use color, where the argument 'var' is
   * one of GIT_COLOR_UNKNOWN, GIT_COLOR_NEVER, GIT_COLOR_ALWAYS, GIT_COLOR_AUTO.
   */
 -int want_color(int var);
 +int want_color_fd(int fd, int var);
 +#define want_color(colorbool) want_color_fd(1, (colorbool))
 +#define want_color_stderr(colorbool) want_color_fd(2, (colorbool))
  
  /*
   * Translate a Git color from 'value' into a string that the terminal can
 diff --git a/config.c b/config.c
 index b0c20e6cb8a..3bdbe36a638 100644
 --- a/config.c
 +++ b/config.c
 @@ -1365,7 +1365,7 @@ int git_default_config(const char *var, const char *value, void *dummy)
  	if (starts_with(var, "mailmap."))
  		return git_default_mailmap_config(var, value);
  
 -	if (starts_with(var, "advice."))
 +	if (starts_with(var, "advice.") || starts_with(var, "color.advice"))
  		return git_default_advice_config(var, value);
  
  	if (!strcmp(var, "pager.color") || !strcmp(var, "color.pager")) {
 diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
 index 21340e89c96..1c2be98dc2b 100755
 --- a/t/t5541-http-push-smart.sh
 +++ b/t/t5541-http-push-smart.sh
 @@ -377,5 +377,23 @@ test_expect_success 'push status output scrubs password' '
  	grep "^To $HTTPD_URL/smart/test_repo.git" status
  '
  
 +test_expect_success 'colorize errors/hints' '
 +	cd "$ROOT_PATH"/test_repo_clone &&
 +	cat >exp <<-EOF &&
 +	To http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git
 +	 <RED>! [rejected]       <RESET> origin/master^ -> master (non-fast-forward)
 +	error: failed to push some refs to '\''http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git'\''
 +	EOF
 +
 +	test_must_fail git -c color.transport=always -c color.advice=always \
 +		-c color.push=always \
 +		push origin origin/master^:master 2>act &&
 +	test_decode_color <act >decoded &&
 +	test_i18ngrep "<RED>.*rejected.*<RESET>" decoded &&
 +	test_i18ngrep "<RED>error: failed to push some refs" decoded &&
 +	test_i18ngrep "<YELLOW>hint: " decoded &&
 +	test_i18ngrep ! "^hint: " decoded
 +'
 +
  stop_httpd
  test_done
 diff --git a/transport.c b/transport.c
 index dd98dd84b05..4702b9fbc8f 100644
 --- a/transport.c
 +++ b/transport.c
 @@ -34,9 +34,9 @@ enum color_transport {
  static int transport_color_config(void)
  {
  	const char *keys[] = {
 -		"transport.color.reset",
 -		"transport.color.rejected"
 -	};
 +		"color.transport.reset",
 +		"color.transport.rejected"
 +	}, *key = "color.transport";
  	char *value;
  	int i;
  	static int initialized;
 @@ -45,6 +45,12 @@ static int transport_color_config(void)
  		return 0;
  	initialized = 1;
  
 +	if (!git_config_get_string(key, &value))
 +		transport_use_color = git_config_colorbool(key, value);
 +
 +	if (!want_color_stderr(transport_use_color))
 +		return 0;
 +
  	for (i = 0; i < ARRAY_SIZE(keys); i++)
  		if (!git_config_get_string(keys[i], &value)) {
  			if (!value)
 @@ -58,7 +64,7 @@ static int transport_color_config(void)
  
  static const char *transport_get_color(enum color_transport ix)
  {
 -	if (want_color(transport_use_color))
 +	if (want_color_stderr(transport_use_color))
  		return transport_colors[ix];
  	return "";
  }
 @@ -382,11 +388,13 @@ static void print_ref_status(char flag, const char *summary,
  		else
  			fprintf(stdout, "%s\n", summary);
  	} else {
 -		if (strstr(summary, "rejected") != NULL || strstr(summary, "failure") != NULL)
 -			fprintf(stderr, " %s%c %-*s%s ", transport_get_color(TRANSPORT_COLOR_REJECTED),
 -				flag, summary_width, summary, transport_get_color(TRANSPORT_COLOR_RESET));
 -		else
 -			fprintf(stderr, " %c %-*s ", flag, summary_width, summary);
 +		const char *red = "", *reset = "";
 +		if (push_had_errors(to)) {
 +			red = transport_get_color(TRANSPORT_COLOR_REJECTED);
 +			reset = transport_get_color(TRANSPORT_COLOR_RESET);
 +		}
 +		fprintf(stderr, " %s%c %-*s%s ", red, flag, summary_width,
 +			summary, reset);
  		if (from)
  			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
  		else
-- 
2.17.0.windows.1.4.g7e4058d72e3

