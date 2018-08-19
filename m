Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351351F954
	for <e@80x24.org>; Sun, 19 Aug 2018 17:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbeHSUrH (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 16:47:07 -0400
Received: from mout.web.de ([212.227.15.14]:57873 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeHSUrH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 16:47:07 -0400
Received: from [192.168.178.36] ([79.237.244.101]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MeNUV-1fUhXy3ezH-00QBFm; Sun, 19
 Aug 2018 19:34:49 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] parseopt: group literal string alternatives in argument help
Message-ID: <0635e9e0-41ac-95b5-257c-d572f5cdb2cd@web.de>
Date:   Sun, 19 Aug 2018 19:34:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:mDQ98tsX8nuLLXRyMeb0s6/jULwp0OJ84B2kNc01sRo4wHDDuV9
 W+N7L7+AGJq5tMEI36E/AJsYmrZAY9bMikRqb1+540AbZ9S30SEoTaEkV8q0b1Nc/0D3y8D
 JcuyvOxDSAwRoDXo3d7oZ7Xh4ig2jlLZtZWul4+tQs9x4Yi8GNQG46Hq6zbMQFojkG5zzOv
 HaxPSwCeaS+72c+53BF2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jJKt1Lfyk4s=:6WlDrQ4vc2yamT3gR1Vu6n
 JlYK45QoqewHqQDKy6ylE3282fRG7QkPRLXW9OJYuizM3A0zN7xwVvkW8wXi5meFoSrwrPDqn
 EJvMNY3p9vm/4aBmsDrlKly49eTEV5kXpz63cYBc+a9AGgUQzs6KVhMwN13/FFyvyU+NQk+Vs
 nYCo4z8xyOwDcxOwlDngTsbTjA185wZ+3qmLvvbraGFl+/azytdmZxWy80tOSphjfKdY2bETt
 /dZDj5f2bJMUK+Ke2iSWqRCWUTdyjzj/znWhuGYqk1TPBQPC9p/JkS3PBcBnBE1+xvxvlKxIT
 4zWXd4irGMcJYCdmew20mR4VC7m9snvUfFcf1f3LNtPGx3zC/qv66JiKhg9iyw6zO1dCsmMRP
 udjOjCznqgNPwXtsrqO+H8d15VrE4GBnZain9DDuj3PC5qvw3BV3fGq6OAuI7aXb+CPpmiJKg
 w9fMTyCjM+Ef1EmHA7ydTwkSO3++sCmyh6lJis8RmZjHvMOaONX3ZGAX5ovfZSfLtkPH3Yal/
 fjRvgOkRUoeJsRe/vdyWlIqNCK1Wn24BmYaB84lGY0AQ7eTFy4WDQpkukq/HH9bLrITebrDpl
 KySXqGRGUphqqAqYtLUOMAUbzPwY2cdWwxSPDzLPUdQEUogdI8eJATHV8paAtAe5HlOsJ0XOS
 ZXouWh4g1xx+gcq2C5mph06LsJT2aoof+TL0/ocYBxvQQfzyijmVLQ7cBseuJ5D1rh9rgNjOw
 oLaBYZBZLRvsCghZpCPcqh4NnW0A/fbsW5NhDUOhSsyOrpu30021o3j8xY9C6cCEC1w/5ixX1
 E05hLul
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This formally clarifies that the "--option=" part is the same for all
alternatives.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/pull.c      | 2 +-
 builtin/push.c      | 4 ++--
 builtin/send-pack.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 53bc5facfd..681c127a07 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -135,7 +135,7 @@ static struct option pull_options[] = {
 	/* Options passed to git-merge or git-rebase */
 	OPT_GROUP(N_("Options related to merging")),
 	{ OPTION_CALLBACK, 'r', "rebase", &opt_rebase,
-	  "false|true|merges|preserve|interactive",
+	  "(false|true|merges|preserve|interactive)",
 	  N_("incorporate changes by rebasing rather than merging"),
 	  PARSE_OPT_OPTARG, parse_opt_rebase },
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
diff --git a/builtin/push.c b/builtin/push.c
index ef4c188895..d09a42062c 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -561,7 +561,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		  0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
 		  N_("require old value of ref to be at this value"),
 		  PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP, parseopt_push_cas_option },
-		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, "check|on-demand|no",
+		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, "(check|on-demand|no)",
 			N_("control recursive pushing of submodules"),
 			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
 		OPT_BOOL_F( 0 , "thin", &thin, N_("use thin pack"), PARSE_OPT_NOCOMPLETE),
@@ -576,7 +576,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),
 			TRANSPORT_PUSH_FOLLOW_TAGS),
 		{ OPTION_CALLBACK,
-		  0, "signed", &push_cert, "yes|no|if-asked", N_("GPG sign the push"),
+		  0, "signed", &push_cert, "(yes|no|if-asked)", N_("GPG sign the push"),
 		  PARSE_OPT_OPTARG, option_parse_push_signed },
 		OPT_BIT(0, "atomic", &flags, N_("request atomic transaction on remote side"), TRANSPORT_PUSH_ATOMIC),
 		OPT_STRING_LIST('o', "push-option", &push_options_cmdline, N_("server-specific"), N_("option to transmit")),
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 724b484850..8e3c7490f7 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -166,7 +166,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "mirror", &send_mirror, N_("mirror all refs")),
 		OPT_BOOL('f', "force", &force_update, N_("force updates")),
 		{ OPTION_CALLBACK,
-		  0, "signed", &push_cert, "yes|no|if-asked", N_("GPG sign the push"),
+		  0, "signed", &push_cert, "(yes|no|if-asked)", N_("GPG sign the push"),
 		  PARSE_OPT_OPTARG, option_parse_push_signed },
 		OPT_STRING_LIST(0, "push-option", &push_options,
 				N_("server-specific"),
-- 
2.18.0
