Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4976F1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 23:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754454AbdLNXeo (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 18:34:44 -0500
Received: from mout.gmx.net ([212.227.15.18]:63571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754438AbdLNXem (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 18:34:42 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNq8p-1eMbx629CV-007SL9; Fri, 15
 Dec 2017 00:34:39 +0100
Date:   Fri, 15 Dec 2017 00:34:38 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 2/2] version --build-options: report commit, too, if
 possible
In-Reply-To: <cover.1513294410.git.johannes.schindelin@gmx.de>
Message-ID: <9b379e2060ca06e9cac44cdc69df327022be9c80.1513294410.git.johannes.schindelin@gmx.de>
References: <cover.1512752468.git.johannes.schindelin@gmx.de> <cover.1513294410.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZGDa05pX63a8znXA2TOmsaEzCuLe1WREIA4T0PVVba22xg9lzFu
 RyI++XOHlHG0/KxP6lryOyPUXfgK2nJmGr4DTozpgyDVN7L5APUjxY6intaQag3KdDPryiq
 sutu1UiT729tNYV0v9nlT6MTRU/KfOWSUYvGeroen+SMhER1PnjvlagbM4OPg5VHq2nZ55Z
 1FqVaea++OvWgTZ3uarLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t4F+6klsSyE=:JSwu0lQLuTPt6C1B430raG
 UZyRuI48uk+S2gBBgIqcKNIhViG/L/gvOPufW+k1DHNTdPS32f7eJxn59d760EblGHInO20Un
 em7IyaWy24KWeNCfWaZlrOvlnBlMUJyNb+tDM0iR+m5yv8eASvvBmFNOJvk3TShZgBswdP5Pk
 pdtzF5KhtwSjSU1pnXs8nV9WbQHYNTdNk/w8v4RbdiT55BMl2z8wmyIt4TzPPtVZQuUZVmPaG
 GbRGG3pZwF49k4rza9l0SvovTjit3w3tw2RN2FoBJ4tdU2NXtR1PKkMo93QaB2gT2gBw3W63w
 nzrCi4FHnxeflhrUu1G9s6fnbLwvU4ce1m/ZoSDZh+xP1+aZk2vcAf4q5CAA/eRsVZPQsXks8
 RSXBkGNTiDIn2f7zMJbPb3m6eQTMv1VQqNUzDhckJF9OqAM1utJAjpvLhAxPUQ/mNHkv15wp6
 71/LqnCQ2j2VIwJSOaPAxRaeXHNzQN/zONTkYLDQeUhrqW3HPPnG3EGnRKFdm1KoagwEGtsKu
 QFWPCgaKm32I+3Ie0hq/Bs+SlzbgCd/uQdp39IRk/408StQ3zocdbjuMeXysV4O08Z6/rW92Z
 pgquy2Cm976RTo0NE7Y4qPMYkXeZP+3IKjnpPgbziZrVsBaTD+XPtu4ki0wTrfnTuAncBWFgd
 eg+5ZC8wlTcQlD4KBSylVu8Bh/S+D/eVQl3nCjtGvI8B3p7qsIT6qRp+wMe/45k5J2WSB2eaZ
 D4sUwE86ciqueWK7sfzphRgJZQAFluVRYT1AhLAYjDYSPhPyTLUFWbKCRWYjN9ZuBs1j/Igrb
 2kIJLRN2+6Er7xH1aOTVsmDAb8QpAWxS3xOwo+hTvCk5Ut6U4Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In particular when local tags are used (or tags that are pushed to some
fork) to build Git, it is very hard to figure out from which particular
revision a particular Git executable was built. It gets worse when those
tags are deleted, or even updated.

Let's just report an exact, unabbreviated commit name in our build
options.

We need to be careful, though, to report when the current commit cannot
be determined, e.g. when building from a tarball without any associated
Git repository. This could be the case also when extracting Git's source
code into an unrelated Git worktree.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile  | 4 +++-
 help.c    | 5 +++++
 version.c | 1 +
 version.h | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 5587bccc932..2ce70d205d9 100644
--- a/Makefile
+++ b/Makefile
@@ -1902,7 +1902,9 @@ builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 version.sp version.s version.o: GIT-VERSION-FILE GIT-USER-AGENT
 version.sp version.s version.o: EXTRA_CPPFLAGS = \
 	'-DGIT_VERSION="$(GIT_VERSION)"' \
-	'-DGIT_USER_AGENT=$(GIT_USER_AGENT_CQ_SQ)'
+	'-DGIT_USER_AGENT=$(GIT_USER_AGENT_CQ_SQ)' \
+	'-DGIT_BUILT_FROM_COMMIT="$(shell GIT_CEILING_DIRECTORIES=\"$(CURDIR)/..\" \
+		git rev-parse -q --verify HEAD || :)"'
 
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
diff --git a/help.c b/help.c
index cbcb159f367..60071a9beaa 100644
--- a/help.c
+++ b/help.c
@@ -413,6 +413,11 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 
 	if (build_options) {
 		printf("cpu: %s\n", GIT_HOST_CPU);
+		if (git_built_from_commit_string[0])
+			printf("built from commit: %s\n",
+			       git_built_from_commit_string);
+		else
+			printf("no commit associated with this build\n");
 		printf("sizeof-long: %d\n", (int)sizeof(long));
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
 	}
diff --git a/version.c b/version.c
index 6106a8098c8..41b718c29e1 100644
--- a/version.c
+++ b/version.c
@@ -3,6 +3,7 @@
 #include "strbuf.h"
 
 const char git_version_string[] = GIT_VERSION;
+const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
 
 const char *git_user_agent(void)
 {
diff --git a/version.h b/version.h
index 6911a4f1558..7c62e805771 100644
--- a/version.h
+++ b/version.h
@@ -2,6 +2,7 @@
 #define VERSION_H
 
 extern const char git_version_string[];
+extern const char git_built_from_commit_string[];
 
 const char *git_user_agent(void);
 const char *git_user_agent_sanitized(void);
-- 
2.15.1.windows.2
