Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F5263A1
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="TM7l5Slw"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED03E1
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 04:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1698494288; x=1699099088; i=l.s.r@web.de;
	bh=7OQutgrrQEuS/zHVhdKsoLtMMtoVfBNOj27Rwi7kxBQ=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=TM7l5SlwEPWYLBpRS8Ho8gwTNwbKV9TwGotioAk44jYgKJC8nkxQZcei66PneFtQ
	 xcMaPyXtEoZzcE7irKlVkTyBYU0VFAvUSotrPDXTjhCk2/C0D8B/83MuhuccyaBrO
	 Gw4fckVQvc9eYVNUaPzOjXNSsxxZ6JRijo3lNguJ4dqmekXmBOCDNfiIZ82asfYBl
	 Eo0FUJ4gZ+uihH5FVf19cqbM3ph8TZ1LNggwRGNLXNuhF9dINRHxjUOHdolpfAqOY
	 Dc9c6s1aLIJqhLsSRE8whlramBa5zruK4IIKofDRbjgF/HX/xP12sudRXAg8TRqtY
	 AyQnjXhulBTWWNJnWA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.209]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9IOj-1qs0aV0ONb-006WGP; Sat, 28
 Oct 2023 13:58:08 +0200
Message-ID: <10e09b2d-15d7-4af1-b24c-217f9e2f457a@web.de>
Date: Sat, 28 Oct 2023 13:58:07 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] am, rebase: fix arghelp syntax of --empty
Cc: Elijah Newren <newren@gmail.com>, =?UTF-8?B?5b6Q5rKb5paHIChBbGVlbik=?=
 <aleen42@vip.qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lbfbJoxJBcAUZfLlf40Qv1mGS0zHtYA4EQTYEAbFAE/7Fdrqe7C
 Yycvzt7GJd7CKWFL361JtJB0kp7MNrRmRuCxY46uGGUnaSCmmtY1sxr61pUDqD2GhoafLah
 nIJJLPrnuv1WQyuRli9PLYfsuPTNbiavP/mKMn7nWyZyOHasO3MktdMtx7c5Q7IV6J2nBQL
 4q0UfoiKlT7Uk2hNhdcQQ==
UI-OutboundReport: notjunk:1;M01:P0:vhVHkPOxl9U=;0YrU2yeooQH/WpOxZVlWVguTSHs
 NtcpqrVp7WqooESn0ptr72OzoWeKFbfyGiuDexT3oa4VSm+Y+UygqrRppaQx6XG7qJOiaovUi
 5UeQapo0ajWPMTMTIAAYNwSJoRuIdJH/3OFtAr1PqbH+y1BTgCzBHMZgv3ZD/rTMqU5pXaE4x
 ArdYCkY8OSK9L9WO1cSE6rk0CBqXvAiKUhSNRO5i7DAiZiJd3E/GiTF5GdmpON0ZP4nTsXx2I
 5pISXfijL7wLAma6FB5Fors2iP8hBsVJZb1VhjfWVmAT3/AITwEPkSo9EU+/t9x+ZUZ1iD+TH
 zTOwW6XFHu/5mULek6SgypQDo+Lv0AQTnodutJsqAvTG79PXehBY+3esIAuj8zQumXTXSRiy6
 8VQe9NnfqDaZ2865q5vwya8jkDLtAZlObInaeB6M5yTOB2CaENV+QEyI8Dzc6a+w/yIUoA9ot
 1RVAYm2JlWNu6cA1JGqSdceFRbVgf/JU2tavicqlhjjTLmdqgtDyOcwjl0OXvjziut6W/C1EZ
 NXHHfbJGM3mNsTV/RWUZbsmGZX/b258ExKhoEDkNTQpfvMoFCpFtw4cjvtfMhxglnem4I8Yuu
 YGSUqAuMSJvusP29xwk3z7hsJTN/9iyHozUiUsDrfeiQwNTsJ0sFChVGAGq82gaqBtOSne7EZ
 RrLrhi4nIsLhZp3V1zQfk0cLZHJ+sYH4QZZNxADbXHrVVPEmpOLG8V7IHX4ac15EHbpT5u8Mj
 N8lHxAgluHcll7nGz69g9u7ch6rJlieJ1sHf4qNuN6JE0jktI64Dqrux8IMydnvRtE7cfR+rL
 eWV/kilLn3hjalxXr2OSAuxmIpaTC+EfWFT6NrspiISCJ/o8CxgdyRkOBkwOMZiEhwLhZyHY1
 uEwX11tKn1R8HZgF1Sq80VSIyseXuzs4gXo0mKdjlNIVLaAtUezNXJML8hUVhrJSj4EzMDEbp
 2+5gXQ==

Use parentheses and pipes to present alternatives in the argument help
for the --empty options of git am and git rebase, like in the rest of
the documentation.

While at it remove a stray use of the enum empty_action value
STOP_ON_EMPTY_COMMIT to indicate that no short option is present.
While it has a value of 0 and thus there is no user-visible change,
that enum is not meant to hold short option characters.  Hard-code 0,
like we do for other options without a short option.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-rebase.txt | 4 ++--
 builtin/am.c                 | 2 +-
 builtin/rebase.c             | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index e7b39ad244..b4526ca246 100644
=2D-- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -289,7 +289,7 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.

=2D--empty=3D{drop,keep,ask}::
+--empty=3D(drop|keep|ask)::
 	How to handle commits that are not empty to start and are not
 	clean cherry-picks of any upstream commit, but which become
 	empty after rebasing (because they contain a subset of already
@@ -695,7 +695,7 @@ be dropped automatically with `--no-keep-empty`).
 Similar to the apply backend, by default the merge backend drops
 commits that become empty unless `-i`/`--interactive` is specified (in
 which case it stops and asks the user what to do).  The merge backend
-also has an `--empty=3D{drop,keep,ask}` option for changing the behavior
+also has an `--empty=3D(drop|keep|ask)` option for changing the behavior
 of handling commits that become empty.

 Directory rename detection
diff --git a/builtin/am.c b/builtin/am.c
index 6655059a57..9bb73d1671 100644
=2D-- a/builtin/am.c
+++ b/builtin/am.c
@@ -2420,7 +2420,7 @@ int cmd_am(int argc, const char **argv, const char *=
prefix)
 		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
 		  N_("GPG-sign commits"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
-		OPT_CALLBACK_F(STOP_ON_EMPTY_COMMIT, "empty", &state.empty_type, "{stop=
,drop,keep}",
+		OPT_CALLBACK_F(0, "empty", &state.empty_type, "(stop|drop|keep)",
 		  N_("how to handle empty patches"),
 		  PARSE_OPT_NONEG, am_option_parse_empty),
 		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
diff --git a/builtin/rebase.c b/builtin/rebase.c
index f990811614..ad7baedd4a 100644
=2D-- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1147,7 +1147,7 @@ int cmd_rebase(int argc, const char **argv, const ch=
ar *prefix)
 				 "instead of ignoring them"),
 			      1, PARSE_OPT_HIDDEN),
 		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
-		OPT_CALLBACK_F(0, "empty", &options, "{drop,keep,ask}",
+		OPT_CALLBACK_F(0, "empty", &options, "(drop|keep|ask)",
 			       N_("how to handle commits that become empty"),
 			       PARSE_OPT_NONEG, parse_opt_empty),
 		OPT_CALLBACK_F('k', "keep-empty", &options, NULL,
=2D-
2.42.0
