Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AFAC433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 10:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353668AbiASK5b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 05:57:31 -0500
Received: from mout.web.de ([212.227.15.4]:58343 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353916AbiASK5E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 05:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642589819;
        bh=cbO0AyRjd4ySRmRdvEonfhkKSfTjb72dISCDh/LdCwE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=L0peAD0xXZMSSDkG0Ur+T4PhT5zrt8/gXhuQyw47B4qNzQh3yrcoZPfbVoPEy2AIv
         /mFvIVMXGEWT/OfYA09reR5abgvzspPx3wYiFpEkLfL/U/NHUqKIeAqqz14PDUp6hg
         XqVOuvuoa0Wa6IY0A3kt5WL6fJd+BU0FOGCfQVjE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MwA1A-1mI21e44qy-00sDnS; Wed, 19
 Jan 2022 11:56:59 +0100
Message-ID: <ba624c59-5330-360e-dc4a-432752d22fc1@web.de>
Date:   Wed, 19 Jan 2022 11:56:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: [PATCH] parse-options: document automatic PARSE_OPT_LITERAL_ARGHELP
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
References: <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
 <3de40324bea6a1dd9bca2654721471e3809e87d8.1642538935.git.steadmon@google.com>
 <xmqqh7a0r87q.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqh7a0r87q.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vffN4zz+/SNWojLDmg7eS//sDybdTLAlxMl88N7fc8yPooZuPHE
 0F6Uy4JLqZndYzBk2r6EBXdFRjHv8wH4/AiRfDWj7u+2TZvwdMg+3tnvOyPpy5puSk+OP/s
 rnmid4u/eZOGgqrhpvSedNNX/kUwaD3CyAIuBP+u6KlPB9Jy/7vnAKhhK25JKmL68yNqRg8
 U34txdwzorjGlBk07mNNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DncX/Hm3p3g=:YBnrCV4geA89D9Sp5vfgXg
 W5svOFUxyKMkS9ubyHUm4c+b4QbS3vrjYv0qHTnNIhf0OjGyy5Qyn3sj+zr1Ao8S8+8LjqL/l
 7iPkG+KOmih1C8vyzzfH/9OQRBA+s8kRWQr/MpDo0tfQ7P6rzzBkT0DTQB01LlpF7mohNap8R
 foz3BveomcQxqrZC3OH12DvwLPgbfy7lB9RCnZfHLackzj++8aDn2pVH0DYa2hhpndlFbuxlJ
 Z6K3EOkGREOaCrBD5ue7RYUZM/4/X/quqVL6lQ08nae23ZsoJSw5LUQ6OIxwJDUu/Z7gapi3k
 YQvxczTtjWkXSlYXx9SSO1YYXaSPJcBz0PlAw/uGoppjlOZAcWToV3QZk5jaa2fERxe3wapbk
 +IdKX/xrHzHAf+gAsBJPjihwzzMXd6q1eAS4/gbfpzEGYUAVm+jmhLZwWDPI8/WlLtmBVX0TO
 yteyqPVMVWTio5OcNwhuZGyFdQEGdlQi0sGHRjwYcOplkkgiiCGzn1oI8HfeJm5ypwD6hLhRK
 8fM19t5ZCI8f/ydBZEHzzlMxjmN4LZQQugElbqF1fxVfLOiqE+kvgLVDf7WjBYd8Pw4toQJYx
 f3x70Y6uxKgIxECFY3WoPjwL4wpxVrW+glj5LPvtNGNiUmNFIJ8scPlF/xaMXFHYKBkisCLHH
 hwiosgS4OBpszJc+UQql3jdWq8z7j5rb+qx5t0O9tGurj5bSr888pid1Xsra9qpdh6FqlsR3K
 BCZ0K7CStY62P/+377R9Y4Z3w5NEd1G+PeS+acpM6k6aV7udYufscbCjj35xX9EAcA6gtX6OZ
 E6VJDoM8uBNXDpBQXniZMhFrDKQxm3g9nhcbfLz1MbAVcCmS1JU9wTZM6F8TT9vMWYzGY2+7L
 jiYgUMfj9dbT7ysq9Y4ckl4zlfhW4METle0d7a2ZMUy2gVQkKx830rhcVHCk5ZmhWZgKvaOKM
 z4+LC+vYW2jB/39Bf46BOxyvIVg1tvSDeGXxim+XRi/L/CQY1Z+7I3F6776Xzkw1CkOGepjRp
 nwCGcZCSD5eqOMB1XPPeXVlcU06VW2zVn/v3nK2JbRhzYeUlpHCkEFLzi0lKUXzlmOmbpqTpT
 cjBEChysetrLFY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The help strings for arguments are enclosed in angle brackets
automatically.  E.g. if argh is specified as "name", "--option <name>"
is printed, to indicate that users need to supply an actual name.  The
flag PARSE_OPT_LITERAL_ARGHELP turns this off, so that "--option name"
is printed instead, to indicate that the literal string needs to be
supplied -- a rare case.

This flag is enabled automatically if argh contains special characters
like brackets.  The developer is supposed to provide any required angle
brackets for more complicated cases.  E.g. if argh is "<start>,<end>"
then "--option <start>,<end>" is printed.

Add a comment to mention this PARSE_OPT_LITERAL_ARGHELP behavior.

Also remove the flag from option definitions for which it's inferred
automatically.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Somehow I feel this is not enough, but I can't pin down what's
missing.

 builtin/am.c    | 2 +-
 builtin/push.c  | 2 +-
 parse-options.h | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index b6be1f1cb1..fa8d28794a 100644
=2D-- a/builtin/am.c
+++ b/builtin/am.c
@@ -2402,7 +2402,7 @@ int cmd_am(int argc, const char **argv, const char *=
prefix)
 		{ OPTION_CALLBACK, 0, "show-current-patch", &resume.mode,
 		  "(diff|raw)",
 		  N_("show the patch being applied"),
-		  PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LI=
TERAL_ARGHELP,
+		  PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
 		  parse_opt_show_current_patch, RESUME_SHOW_PATCH },
 		OPT_CMDMODE(0, "allow-empty", &resume.mode,
 			N_("record the empty patch as an empty commit"),
diff --git a/builtin/push.c b/builtin/push.c
index 359db90321..4fa6dfbd09 100644
=2D-- a/builtin/push.c
+++ b/builtin/push.c
@@ -552,7 +552,7 @@ int cmd_push(int argc, const char **argv, const char *=
prefix)
 		OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE=
),
 		OPT_CALLBACK_F(0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
 			       N_("require old value of ref to be at this value"),
-			       PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP, parseopt_push_cas=
_option),
+			       PARSE_OPT_OPTARG, parseopt_push_cas_option),
 		OPT_BIT(0, TRANS_OPT_FORCE_IF_INCLUDES, &flags,
 			N_("require remote updates to be integrated locally"),
 			TRANSPORT_PUSH_FORCE_IF_INCLUDES),
diff --git a/parse-options.h b/parse-options.h
index e22846d3b7..8d089fb3ae 100644
=2D-- a/parse-options.h
+++ b/parse-options.h
@@ -108,6 +108,8 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct p=
arse_opt_ctx_t *ctx,
  *   PARSE_OPT_LITERAL_ARGHELP: says that argh shouldn't be enclosed in b=
rackets
  *				(i.e. '<argh>') in the help message.
  *				Useful for options with multiple parameters.
+ *				Automatically enabled if argh contains any
+ *				of the following characters: ()<>[]|
  *   PARSE_OPT_NOCOMPLETE: by default all visible options are completable
  *			   by git-completion.bash. This option suppresses that.
  *   PARSE_OPT_COMP_ARG: this option forces to git-completion.bash to
=2D-
2.34.1
