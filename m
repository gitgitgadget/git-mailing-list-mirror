Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75044C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 19:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C4E361D3B
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 19:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhF2Tsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 15:48:39 -0400
Received: from mout.web.de ([212.227.17.12]:46129 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233801AbhF2Tsi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 15:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1624995954;
        bh=XYQb/1JRvawBG1As4Ul5pc3xf90LUNqxmNeQ+nEEEvI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jOQp5oB8xM4YtK+BTfCFiB5TLmFpOt6oqnRpuU0j8rI8JwTk6nWoAxqJxBetxM1ey
         pB8ENQy0YQo+LwTNgO0DHZwtANKLBBs9t0ghoc9em9UZ3MQiQOPS/PLHZgAdDf3FBm
         w8qiIOP11jpwF7Ny0S/dewiwWxcg2km0grMT6ZPs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0M1GAG-1l5Ne61wzY-00t90v; Tue, 29 Jun 2021 21:45:54 +0200
Subject: Re: [PATCH v2 3/3] hook-list.h: add a generated list of hooks, like
 config-list.h
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com>
 <cover-0.3-0000000000-20210629T183325Z-avarab@gmail.com>
 <patch-3.3-ba7f01f4f6-20210629T183325Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <76bd9738-65e8-3696-7934-8090b5912427@web.de>
Date:   Tue, 29 Jun 2021 21:45:53 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <patch-3.3-ba7f01f4f6-20210629T183325Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V12jSq7VNG9BDvy4IscP/wgRkZxukMwq67R73nelbXCjmttPg3c
 iD1JlBdFyH2FwG7nxtBWmIOdujua521sgmwoSn1H+d+qt1mt4L8vh3mm8w8UWbNPccH5qnC
 BQnhP1DiahK5KhmNj4QAEdEZz87zR2BEHlTKbHP53B/RIAHsg9rfV6zPBfW28HJY/Zp2JTI
 L7x9g6UdrcpInlkCyYkPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:loaGs7x30Tk=:4NpHeeESZ2zOrqWhQJ6mM5
 /J8XTJlMuCevtajhLUx4wFxP7Qlf25KdLmjtNxmiDFYpBCxNaVQFfUNmRSy661iJoDgAZL5Dg
 ms0lk/IOIGyYOwriyr4o5S4PSJK76FbGAHKJlOfmNCar44GQ6HEFa348z+r1G2nccgvypA4AG
 PSOomwMD8moHoTjkECf2mMX+qBhtH+sTG0oMvxSyhJwWj26Pz+xv2eOy1htDQbzAZGdvdsd3q
 T6EcE4ATBR+xybHOD8d6J68n8Dwi8NOsmMIMxMWu0kU13YkLlqsA/ejZoDTiREnpmLCkzTdQS
 d7rRBFTd/cCSCEL/tIC0IL8IC2SgqD5jeNPF6ybCAy/2UX/QRRczNPxctv1O0eLcDpuqeg5vH
 BXrk1ygiiPR6B4H6bzxtf4UEdXCoLNgtHPJUgDTtTZCPbW7JKnBCLArwEZnlKPlgRe1PIVAM0
 0sUevsMhWsIhrTGVGaQPO3f7ZMEHQ5bgiwpdykWve7xGDRb0QT4pzFUI8c4xSd9NvFBtlcMnR
 4bDbd302eS+QVyAyXl8VcwfFNvVCFnUf7wG4ysx37NtcOiSzQWYaD10PXsYl6fsqHlcdVWh7B
 CEQn5qGEyhdcvAvQMNCt6JF+sY/OA1CJuQeqIiG0B63Mwlj+zAS7nVbj0tJooQeBnjXPPv4+B
 RNhr7KpYmbAizdboJXK7Bo/eIeRM0a+6L51TcOgFvufTEe7J6IiWdbjUeEln8b+y3Fea30lxK
 S7amE6AL/XNdQZwe4LTnkkcb1oJRX4PlCoUmVwAcOgMFZc/NjCTxiDTP2Bkh7dYErJouhArTc
 FiM9q5bvpzBcvhdvUnXOLLxHOYV5YZNoFGNdJlhG5zIgviOIMBqIl3TMfMMlGTyv+EVAClK15
 o8qUtXmt3+izZbcuR/8UbYrdMZo8vRrcHSBpyPynEbI2FOcfTUXyDPOUvKwuBHrZe1IUAKMlL
 oowxR8wIuWR2RlyB1xO+Oa+1RrJI3IOWff3JX2YrRgXzKGvhKGLwgDDa3fI0apjL7ByvSYzAH
 g1aQYERzijg/NWIg1KwmnkjxzeliAafmvP2TOqeBx1+oWjpjERNUU3CxSYU0DNOgaZnkyJjWS
 u2JZlnicQOSgKNzFt9NL6cAtWuMGr3UPHzU
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.06.21 um 20:54 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Make githooks(5) the source of truth for what hooks git supports, and
> die hooks we don't know about in find_hook(). This ensures that the
> documentation and the C code's idea about existing hooks doesn't
> diverge.
>
> We still have Perl and Python code running its own hooks, but that'll
> be addressed by Emily Shaffer's upcoming "git hook run" command.
>
> This resolves a long-standing TODO item in bugreport.c of there being
> no centralized listing of hooks, and fixes a bug with the bugreport
> listing only knowing about 1/4 of the p4 hooks. It didn't know about
> the recent "reference-transaction" hook either.
>
> I have not been able to directly test the CMake change being made
> here. Since 4c2c38e800 (ci: modification of main.yml to use cmake for
> vs-build job, 2020-06-26) some of the Windows CI has a hard dependency
> on CMake, this change works there, and is to my eyes an obviously
> correct use of a pattern established in previous CMake changes,
> namely:
>
>  - 061c2240b1 (Introduce CMake support for configuring Git,
>     2020-06-12)
>  - 709df95b78 (help: move list_config_help to builtin/help,
>     2020-04-16)
>  - 976aaedca0 (msvc: add a Makefile target to pre-generate the Visual
>    Studio solution, 2019-07-29)
>
> The LC_ALL=3DC is needed because at least in my locale the dash ("-") is
> ignored for the purposes of sorting, which results in a different
> order. I'm not aware of anything in git that has a hard dependency on
> the order, but e.g. the bugreport output would end up using whatever
> locale was in effect when git was compiled.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>

Please remove my sign-off line.  The code looks OK, but there are
basically only trivial traces of my suggestion left.  That's fine, but
it makes my sign-off unnecessary, and I cannot certify the origin of the
rest of the patch.  You could turn it into a Helped-by or
Contributions-by if you like.

> ---
>  .gitignore                          |  1 +
>  Makefile                            | 10 ++++++-
>  builtin/bugreport.c                 | 44 ++++++-----------------------
>  contrib/buildsystems/CMakeLists.txt |  7 +++++
>  generate-hooklist.sh                | 18 ++++++++++++
>  hook.c                              | 19 +++++++++++++
>  6 files changed, 62 insertions(+), 37 deletions(-)
>  create mode 100755 generate-hooklist.sh
>
> diff --git a/.gitignore b/.gitignore
> index 311841f9be..6be9de41ae 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -190,6 +190,7 @@
>  /gitweb/static/gitweb.min.*
>  /config-list.h
>  /command-list.h
> +/hook-list.h
>  *.tar.gz
>  *.dsc
>  *.deb
> diff --git a/Makefile b/Makefile
> index d155b7be21..9b811d3548 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -817,6 +817,8 @@ XDIFF_LIB =3D xdiff/lib.a
>
>  GENERATED_H +=3D command-list.h
>  GENERATED_H +=3D config-list.h
> +GENERATED_H +=3D hook-list.h
> +
>  .PHONY: generated-hdrs
>  generated-hdrs: $(GENERATED_H)
>
> @@ -2208,7 +2210,9 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS=
)
>
>  help.sp help.s help.o: command-list.h
>
> -builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
> +hook.sp hook.s hook.o: hook-list.h
> +
> +builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook-list.=
h GIT-PREFIX
>  builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS =3D \
>  	'-DGIT_HTML_PATH=3D"$(htmldir_relative_SQ)"' \
>  	'-DGIT_MAN_PATH=3D"$(mandir_relative_SQ)"' \
> @@ -2241,6 +2245,10 @@ command-list.h: $(wildcard Documentation/git*.txt=
)
>  		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
>  		command-list.txt >$@+ && mv $@+ $@
>
> +hook-list.h: generate-hooklist.sh Documentation/githooks.txt
> +	$(QUIET_GEN)$(SHELL_PATH) ./generate-hooklist.sh \
> +		>$@+ && mv $@+ $@
> +
>  SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
>  	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):=
\
>  	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index 941c8d5e27..a7a1fcb8a7 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -4,6 +4,7 @@
>  #include "help.h"
>  #include "compat/compiler.h"
>  #include "hook.h"
> +#include "hook-list.h"
>
>
>  static void get_system_info(struct strbuf *sys_info)
> @@ -41,39 +42,7 @@ static void get_system_info(struct strbuf *sys_info)
>
>  static void get_populated_hooks(struct strbuf *hook_info, int nongit)
>  {
> -	/*
> -	 * NEEDSWORK: Doesn't look like there is a list of all possible hooks;
> -	 * so below is a transcription of `git help hooks`. Later, this should
> -	 * be replaced with some programmatically generated list (generated fr=
om
> -	 * doc or else taken from some library which tells us about all the
> -	 * hooks)
> -	 */
> -	static const char *hook[] =3D {
> -		"applypatch-msg",
> -		"pre-applypatch",
> -		"post-applypatch",
> -		"pre-commit",
> -		"pre-merge-commit",
> -		"prepare-commit-msg",
> -		"commit-msg",
> -		"post-commit",
> -		"pre-rebase",
> -		"post-checkout",
> -		"post-merge",
> -		"pre-push",
> -		"pre-receive",
> -		"update",
> -		"post-receive",
> -		"post-update",
> -		"push-to-checkout",
> -		"pre-auto-gc",
> -		"post-rewrite",
> -		"sendemail-validate",
> -		"fsmonitor-watchman",
> -		"p4-pre-submit",
> -		"post-index-change",
> -	};
> -	int i;
> +	const char **p;
>
>  	if (nongit) {
>  		strbuf_addstr(hook_info,
> @@ -81,9 +50,12 @@ static void get_populated_hooks(struct strbuf *hook_i=
nfo, int nongit)
>  		return;
>  	}
>
> -	for (i =3D 0; i < ARRAY_SIZE(hook); i++)
> -		if (hook_exists(hook[i]))
> -			strbuf_addf(hook_info, "%s\n", hook[i]);
> +	for (p =3D hook_name_list; *p; p++) {
> +		const char *hook =3D *p;
> +
> +		if (hook_exists(hook))
> +			strbuf_addf(hook_info, "%s\n", hook);
> +	}
>  }
>
>  static const char * const bugreport_usage[] =3D {
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/=
CMakeLists.txt
> index a87841340e..c216940945 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -602,6 +602,13 @@ if(NOT EXISTS ${CMAKE_BINARY_DIR}/config-list.h)
>  			OUTPUT_FILE ${CMAKE_BINARY_DIR}/config-list.h)
>  endif()
>
> +if(NOT EXISTS ${CMAKE_BINARY_DIR}/hook-list.h)
> +	message("Generating hook-list.h")
> +	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-hooklis=
t.sh
> +			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
> +			OUTPUT_FILE ${CMAKE_BINARY_DIR}/hook-list.h)
> +endif()
> +
>  include_directories(${CMAKE_BINARY_DIR})
>
>  #build
> diff --git a/generate-hooklist.sh b/generate-hooklist.sh
> new file mode 100755
> index 0000000000..6d4e56d1a3
> --- /dev/null
> +++ b/generate-hooklist.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh
> +#
> +# Usage: ./generate-hooklist.sh >hook-list.h
> +
> +cat <<EOF
> +/* Automatically generated by generate-hooklist.sh */
> +
> +static const char *hook_name_list[] =3D {
> +EOF
> +
> +sed -n -e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}; x' \
> +	<Documentation/githooks.txt |
> +	LC_ALL=3DC sort
> +
> +cat <<EOF
> +	NULL,
> +};
> +EOF
> diff --git a/hook.c b/hook.c
> index 97cd799a32..1f1db1ec9b 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -1,11 +1,30 @@
>  #include "cache.h"
>  #include "hook.h"
>  #include "run-command.h"
> +#include "hook-list.h"
> +
> +static int known_hook(const char *name)
> +{
> +	const char **p;
> +	size_t len =3D strlen(name);
> +	for (p =3D hook_name_list; *p; p++) {
> +		const char *hook =3D *p;
> +
> +		if (!strncmp(name, hook, len) && hook[len] =3D=3D '\0')
> +			return 1;
> +	}
> +
> +	return 0;
> +}
>
>  const char *find_hook(const char *name)
>  {
>  	static struct strbuf path =3D STRBUF_INIT;
>
> +	if (!known_hook(name))
> +		die(_("the hook '%s' is not known to git, should be in hook-list.h vi=
a githooks(5)"),
> +		    name);
> +
>  	strbuf_reset(&path);
>  	strbuf_git_path(&path, "hooks/%s", name);
>  	if (access(path.buf, X_OK) < 0) {
>
