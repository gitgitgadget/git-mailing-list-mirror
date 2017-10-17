Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13E331FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 15:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936505AbdJQPjV (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 11:39:21 -0400
Received: from mout.web.de ([212.227.15.14]:59345 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934122AbdJQPjT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 11:39:19 -0400
Received: from [192.168.178.36] ([91.20.51.19]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LeLWP-1dSNzI3D6j-00q9Em; Tue, 17
 Oct 2017 17:39:05 +0200
Subject: [PATCH 1/2] git: add NO_INTERNAL_HELP flag for builtins
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Thomas Rikl <trikl@online.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
 <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
 <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <76c3e710-0655-7788-f6f4-af1e59d65edd@web.de>
Date:   Tue, 17 Oct 2017 17:39:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:qnMbNu7wD0S3nNp0X7JRmHi0sAHWMw0AS0R6owYO66GkhkBd/gL
 D4WEe6Hs7GwnJJGITUg2kyfLXEd5o4BF+n85V/ugOfqnCXnevueEGZWEks+lK2t2GGWkf2q
 I9an43WqCT/AIYAmleGDwfFt4y3QqwW9N6Y+o9xkhTOXWAzGXhmPAzSEzIt8J54un5wwM+e
 LDnoQJLzK6eK9kjIBwkDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i6yOhajE56o=:YVAbE0Yk5N0z4fRzhh3M2x
 HapsQAMmyVHQXHOelI2CZZ3Gtx14auwFHJ2cmdZRff9bq+kG+tOgVOrfKoTWfRabURZyklBUS
 DdKUCXkiGMTYhBIKPH8RZlY7Qq3NQc+5UTYN2WNAYf0QbscYRhZ9E/xP3cXD/okNAbpUS49PM
 DmS519R9vaOso+4Kjlxs7FWKo8UQzDZTkAwM37N7Is0lTU00PuVCFMIXWLxn0l5cv/9zglvSR
 MLjV4Xwiu8NozekdfFh7hU8Ni4+0qNWIA58meFDeBVRY/KFnFP81/kQmCuh2C+7BUQfooNth1
 rd2+V2A+haO0CTX5TX5WsaKU8nPHT8xc2YtX0CKGwr6YuyGdwLKsfBkl0N9saBQ7120tuSHYs
 ph2CWqb66adKCu9i9ANqG4QdlX1U24lmKB/TtNTqZzF+iItQ9Xao9Cdr2cIxuPrhiBKe59eqw
 dOrcsrsu5KZbYteKe5HUZE2dKe5Xbh0FvNmlcvDYP4A4PeprfmD4Dx60huINFP/a4SSAOIvdV
 hSESBkrjCc2ywFAUzJKIuS05cRhs39I0DBfLK9N8E+MF8uKccEZMCLdWW7PHa5gDcvVRL6JtH
 OlJUlLi2pS0eQTJub4wNHdt/Vwdsye9q6qGdYeBk8Dk6WNoWcMtcnJrmchwzyld+mKEMtEIlW
 x05OldjVJJkVPKo5XXh5cjElke3WziqH/vuDA1JZetBE1ks1p17gXjX7dHOiuypgtJGLadXot
 BjqZByBvFranmB7s1DTUG8eqFNi9lUXRLFCSWwwg2ZvHmz3j7Ec5+DXGGsYRBCEKydJvarGQy
 4uyYIJ6XD8eBzgQ8Yzdh+ZypjBmvT2O5FjDDti4EdBW7ogdfwQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Builtin commands have skipped repo setup when called with just a single
option -h and thus shown their short help text even outside of
repositories since 99caeed05d3 (Let 'git <command> -h' show usage
without a git dir).

Add the flag NO_INTERNAL_HELP for builtins to opt out of this special
treatment and provide a list of commands that are exempt from the
corresponding test in t0012.  That allows builtins to handle -h
themselves.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 git.c           | 6 +++++-
 t/t0012-help.sh | 9 ++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 9e96dd4090..9d1b8c4716 100644
--- a/git.c
+++ b/git.c
@@ -298,6 +298,7 @@ static int handle_alias(int *argcp, const char ***argv)
 #define NEED_WORK_TREE		(1<<3)
 #define SUPPORT_SUPER_PREFIX	(1<<4)
 #define DELAY_PAGER_CONFIG	(1<<5)
+#define NO_INTERNAL_HELP	(1<<6)
 
 struct cmd_struct {
 	const char *cmd;
@@ -312,7 +313,10 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	const char *prefix;
 
 	prefix = NULL;
-	help = argc == 2 && !strcmp(argv[1], "-h");
+	if (p->option & NO_INTERNAL_HELP)
+		help = 0;
+	else
+		help = argc == 2 && !strcmp(argv[1], "-h");
 	if (!help) {
 		if (p->option & RUN_SETUP)
 			prefix = setup_git_directory();
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 487b92a5de..74eeead168 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -53,12 +53,19 @@ test_expect_success 'generate builtin list' '
 	git --list-builtins >builtins
 '
 
+cat >no_internal_help <<EOF
+EOF
+
+test_expect_success 'generate list of builtins with internal help' '
+	grep -w -v -f no_internal_help <builtins >builtins_internal_help
+'
+
 while read builtin
 do
 	test_expect_success "$builtin can handle -h" '
 		test_expect_code 129 git $builtin -h >output 2>&1 &&
 		test_i18ngrep usage output
 	'
-done <builtins
+done <builtins_internal_help
 
 test_done
-- 
2.14.2
