Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B65D1F407
	for <e@80x24.org>; Thu, 14 Dec 2017 23:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754428AbdLNXee (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 18:34:34 -0500
Received: from mout.gmx.net ([212.227.15.18]:57910 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754420AbdLNXed (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 18:34:33 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LvE2c-1f7JWZ2MRG-010OHY; Fri, 15
 Dec 2017 00:34:29 +0100
Date:   Fri, 15 Dec 2017 00:34:28 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/2] Offer more information in `git version --build-options`'s
 output
In-Reply-To: <cover.1512752468.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1513294410.git.johannes.schindelin@gmx.de>
References: <cover.1512752468.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qnimyQBVsmnCcpeVGuCkjTJ4hr2+z7YD9gny71pYhCdsq23u+Zl
 A3YNCsbnU6Uqk28u7GyF3ylpuJop7QCMYkBWFcwkZqv716kPICGg65NOkU87WdFs5ZnIRgS
 cQDEw0k+rXIh3OMuwVAKJwf/jbiDSavpc3ZUS8/A+Tgbk3jyy1+FlXiUOsd2GiyU6V8CezD
 wXqnRBMjnKcmpFgBD34Sg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tCrm4aAeFPE=:wjKrlrudxnr2LTKCFY9kZK
 IJRV1TiHAN60shkMDB0vwjLXRYVYlknYtQJWM9DSU7Idui7EYgopRpmfoj21NHyEYQRSRlFer
 MMAycfpGBgp8cOm4EyBuyWkPFnIN+xeVH6kA80ZHSU3xfcO3uUX8ot/31RSwXooNiVu0AODFT
 nOp4fTvyRm47u9kZhvgWmA1ph+7neUXvAhQYQLGs54VtfWs+N6nuKOsiXTmsN2EPU0T3/5yld
 RFBvydNyAVBxC9o+sEI7kZbCInUrbqxUK67atKVXZvSAW/TgM/LkzTWIx9wvZVVWOiS8acXIN
 IfdbVyhUOcUOimxyrY20qS/Z9KTs/kdhFFoJziYaJh6rAJMTPbp+juNzOuLPY6uW9b/UzeZxS
 yoI0O9ru7g8b/InupOTcyahsoT/MSq1i8k/13tc7xGP2M+/AYrhPah/PjsnSvjRN6JaMtlfMa
 5KsUfO7GSvF4SJZ4c1bL8z1KoeijIQERyEZIYA2TNO17DxEapZtD+7xjORePukynAbI9VmsVk
 3zAraLbH54DHaselvPzIEpfhvVySqbgMXxJiYaMRIWQ/avM59XZvO2jKoY3VsU9q4ZoNGi3x1
 qYH38PaeyXklbR+JBrqrL5WlubdHyAcuVWP1mMB8wMgoSxp9JgkSQvWBQyQ+saGJMolfJ81L7
 3KdSYYlp3V5ru1ZwWjPBMON7/xO4aja0IpVHI/tkCrBwRD2OuzxoApUxyK0eeoc83IX1hw9F9
 aBz6ItDiiauzN3A3APSAZNzOhEgcbNvVr4uUQNOhof4CqLIhfPeqcGzeJhwJ1HXiWHufYTkFP
 AM20IXKIhkpJdpPDSA8SqCOn1qJidAzpogmcaMpTSCy2nN9+e8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Git for Windows, we ask users to paste the output of said command
into their bug reports, with the idea that this frequently helps
identify where the problems are coming from.

There are some obvious missing bits of information in said output,
though, and this patch series tries to fill the gaps at least a little.

Changes since v1:

- replaced 1/2 by Eric's proposed alternative patch

- when no commit can be determined, it now says

	no commit associated with this build
  instead of

	built from commit: (unknown)

- the code is now careful not to look further than Git's top-level
  directory for a Git repository from which to determine the current
  commit. As Junio pointed out, some developer may extract Git's source
  code from a tarball into a worktree of a completely different project.


Eric Sunshine (1):
  version --build-options: also report host CPU

Johannes Schindelin (1):
  version --build-options: report commit, too, if possible

 Makefile  | 13 ++++++++++++-
 help.c    |  6 ++++++
 version.c |  1 +
 version.h |  1 +
 4 files changed, 20 insertions(+), 1 deletion(-)


base-commit: 95ec6b1b3393eb6e26da40c565520a8db9796e9f
Published-As: https://github.com/dscho/git/releases/tag/built-from-commit-v2
Fetch-It-Via: git fetch https://github.com/dscho/git built-from-commit-v2

Interdiff vs v1:
 diff --git a/Makefile b/Makefile
 index 92a0ae3d8e3..2ce70d205d9 100644
 --- a/Makefile
 +++ b/Makefile
 @@ -425,6 +425,9 @@ all::
  #
  # to say "export LESS=FRX (and LV=-c) if the environment variable
  # LESS (and LV) is not set, respectively".
 +#
 +# When cross-compiling, define HOST_CPU as the canonical name of the CPU on
 +# which the built Git will run (for instance "x86_64").
  
  GIT-VERSION-FILE: FORCE
  	@$(SHELL_PATH) ./GIT-VERSION-GEN
 @@ -1095,6 +1098,12 @@ else
  BROKEN_PATH_FIX = '/^\# @@BROKEN_PATH_FIX@@$$/d'
  endif
  
 +ifeq (,$(HOST_CPU))
 +	BASIC_CFLAGS += -DGIT_HOST_CPU="\"$(firstword $(subst -, ,$(uname_M)))\""
 +else
 +	BASIC_CFLAGS += -DGIT_HOST_CPU="\"$(HOST_CPU)\""
 +endif
 +
  ifneq (,$(INLINE))
  	BASIC_CFLAGS += -Dinline=$(INLINE)
  endif
 @@ -1894,8 +1903,8 @@ version.sp version.s version.o: GIT-VERSION-FILE GIT-USER-AGENT
  version.sp version.s version.o: EXTRA_CPPFLAGS = \
  	'-DGIT_VERSION="$(GIT_VERSION)"' \
  	'-DGIT_USER_AGENT=$(GIT_USER_AGENT_CQ_SQ)' \
 -	'-DGIT_BUILT_FROM_COMMIT="$(shell git rev-parse -q --verify HEAD || \
 -		echo "(unknown)")"'
 +	'-DGIT_BUILT_FROM_COMMIT="$(shell GIT_CEILING_DIRECTORIES=\"$(CURDIR)/..\" \
 +		git rev-parse -q --verify HEAD || :)"'
  
  $(BUILT_INS): git$X
  	$(QUIET_BUILT_IN)$(RM) $@ && \
 diff --git a/help.c b/help.c
 index 6ebea665780..60071a9beaa 100644
 --- a/help.c
 +++ b/help.c
 @@ -390,7 +390,6 @@ const char *help_unknown_cmd(const char *cmd)
  
  int cmd_version(int argc, const char **argv, const char *prefix)
  {
 -	static char build_platform[] = GIT_BUILD_PLATFORM;
  	int build_options = 0;
  	const char * const usage[] = {
  		N_("git version [<options>]"),
 @@ -413,10 +412,13 @@ int cmd_version(int argc, const char **argv, const char *prefix)
  	printf("git version %s\n", git_version_string);
  
  	if (build_options) {
 -		printf("built from commit: %s\n",
 -		       git_built_from_commit_string);
 +		printf("cpu: %s\n", GIT_HOST_CPU);
 +		if (git_built_from_commit_string[0])
 +			printf("built from commit: %s\n",
 +			       git_built_from_commit_string);
 +		else
 +			printf("no commit associated with this build\n");
  		printf("sizeof-long: %d\n", (int)sizeof(long));
 -		printf("machine: %s\n", build_platform);
  		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
  	}
  	return 0;
 diff --git a/help.h b/help.h
 index 42dd9852194..b21d7c94e8c 100644
 --- a/help.h
 +++ b/help.h
 @@ -33,16 +33,3 @@ extern void list_commands(unsigned int colopts, struct cmdnames *main_cmds, stru
   */
  extern void help_unknown_ref(const char *ref, const char *cmd, const char *error);
  #endif /* HELP_H */
 -
 -/*
 - * identify build platform
 - */
 -#ifndef GIT_BUILD_PLATFORM
 -	#if defined __x86__ || defined __i386__ || defined __i586__ || defined __i686__
 -		#define GIT_BUILD_PLATFORM "x86"
 -	#elif defined __x86_64__
 -		#define GIT_BUILD_PLATFORM "x86_64"
 -	#else
 -		#define GIT_BUILD_PLATFORM "unknown"
 -	#endif
 -#endif
-- 
2.15.1.windows.2

