Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8C2C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 15:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355151AbiASPay (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 10:30:54 -0500
Received: from mout.web.de ([212.227.15.4]:37731 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355659AbiASPal (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 10:30:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642606231;
        bh=h2MxrzkR3bwq0GFqyWSV4YX6FijdbgD0TkTxLkf0KM0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RnHVorwdM2dZ/BuPIgYEY97Sf7TP7Ui11YkF3aIu1m1Pt3bvFhcHp8hvjQRpbybt4
         l203/n5FmJReGtBkG1yXM4orD/Ww/zu6kCkYrbPBndvI7OAFjrAJw6kdu2ZtagEIxB
         sfuyCMd8RmPyMhwX8RcfQRLeItISbhzg4NEwLwfU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MK52w-1ms72H1ZFe-00Lizm; Wed, 19
 Jan 2022 16:30:31 +0100
Message-ID: <d41c3a86-dfc9-b867-0094-632d5f3e07cf@web.de>
Date:   Wed, 19 Jan 2022 16:30:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] parse-options: document automatic
 PARSE_OPT_LITERAL_ARGHELP
Content-Language: en-US
To:     Bryce Ekrem <bekrem@g.clemson.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        avarab@gmail.com
References: <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
 <3de40324bea6a1dd9bca2654721471e3809e87d8.1642538935.git.steadmon@google.com>
 <xmqqh7a0r87q.fsf@gitster.g> <ba624c59-5330-360e-dc4a-432752d22fc1@web.de>
 <CA++g3E-azP3wFTtNkbFdmT7VW3hvULL0WkkAdwfrMb6HDtcXdg@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CA++g3E-azP3wFTtNkbFdmT7VW3hvULL0WkkAdwfrMb6HDtcXdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n/wXCuHWLfJeMTPQeP7b3rw1wLqwiGANQYmTnwr+2obuAQ3vAuS
 cp+6QOJakOqoUPdokerdzP4EEzHxffOCMn1dVpSniHpYs/yolpGxzyoJeLjGtiqZMj9isO/
 PyDU82dQBuwd7adxggBN+1QSdNIbxQwHpLRm5ZOSkjfQuby6mfiJC24zqnRYIEJP1uDaxR6
 GawWgfmcUyAMX5UCAhdXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zc41U3OsLBo=:6lbQTKqiJZJnfcsXjh9B6Z
 Ye3ZmecDf+5DpoArar8RwEJ0a/vbEGU3fiy1vPLMOA0vL1rpqsyRcCraiiMOZxXyEHhQhEwB4
 WRqnUHSxQd8cF2xHdqrodhcfFRJYQQQFlfR5zGXzEuiQqk4z71qDOuWZ539XZ3Obh9BpjaZ0c
 /Fqo2frHYCdMpADDqWh240r4LWBSSjd2Mi7CTZ9o62sQQTHwhIZPSzTYSHNwybMKhk5zOY2iM
 njbiqJruD+9ybFO30GQoetFAn3puxu8F+p8RipqqwGZwoGGDD6tu2Ae3r3rMeM9mHdx9V6Sny
 WGwAOcrMlRjvfGfzyP9gA1CTCuGMhV83KSD5k6Najr23q6YssuSgeHBMvFgvxeKFlnA1EVtCA
 5L5m7rpcS49kefUaxO7ukZIQ2Y+syodQVf15sAIrPSAZPSzfLmt9junMqcI/hRf89CpM3TXmS
 IANF7DmlcO5tX8J40LW6Dq7eeO8OZIISajRpECfQ1mBISvzbDDJ81tsi+FWUsbob0KVwVzeox
 HStnzXz0MJV0g5AtszMehR51KgRyubNjIFyqH0APET5cXzmDbBojqQlcovrIEcmGmNH9V1kqd
 s+CuMv+POBhd5r5QxL/e81VmJLrE+XryozfZ3Od0yLNY4QUai3Y5ieYricWnEnwEPlBtFuStz
 nAC6zQRLBZfzb4QZ4WPF8sGYYKRj4a4DU1WBxEpHMzmwG0Nax6cedZhQ0XF5LKbPvuxgXBRuc
 bkTb1UDhcJPoQ1gr2OIqhs9n1sH6m5cwDh/JwL0tvv19hKC5ZWMS7LNMZMVIvCeqfMTafYfOS
 yM5xAwF9vLrVFXgJue44NX+IeS+jTB8xp2Jw8EOwhzfUKCLqwVzRm7i9t8nKH8VfpPLdpcb6k
 1PJhZi7bVPPA7DWoB04DrDZpHLscsStmk3LyjS/TfamGE/rdOVL7FhoUZ7rZf3BzlIuX7dLh4
 6d0JWoascssaMpTGg89Xue6dkBdqmtkZh7HaOZegTZff/4Qd2wjX5OyRHp/tzPlzTVSYBYsNw
 /HK1vUSJsry7MG5BSP/LQdqDnyYbWI8bN2YRZXuZY6wS7PXevNPD0DWu8Xv+VkCUZphWDFDZj
 Rz7xLcyHokjoAE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.01.22 um 16:15 schrieb Bryce Ekrem:
> Can you clarify what argh is instead of argc and argv
> sounds like you said arghelp

argh is a member of struct option, defined in parse-options.h.  It is a
string that describes the argument of an option, i.e. it's a short
"argument help" or "argument hint".

> On Wed, Jan 19, 2022 at 2:57 AM Ren=C3=A9 Scharfe <l.s.r@web.de <mailto:=
l.s.r@web.de>> wrote:
>
>     The help strings for arguments are enclosed in angle brackets
>     automatically.=C2=A0 E.g. if argh is specified as "name", "--option =
<name>"
>     is printed, to indicate that users need to supply an actual name.=C2=
=A0 The
>     flag PARSE_OPT_LITERAL_ARGHELP turns this off, so that "--option nam=
e"
>     is printed instead, to indicate that the literal string needs to be
>     supplied -- a rare case.
>
>     This flag is enabled automatically if argh contains special characte=
rs
>     like brackets.=C2=A0 The developer is supposed to provide any requir=
ed angle
>     brackets for more complicated cases.=C2=A0 E.g. if argh is "<start>,=
<end>"
>     then "--option <start>,<end>" is printed.
>
>     Add a comment to mention this PARSE_OPT_LITERAL_ARGHELP behavior.
>
>     Also remove the flag from option definitions for which it's inferred
>     automatically.
>
>     Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de <mailto:l.s.r@web.de>=
>
>     ---
>     Somehow I feel this is not enough, but I can't pin down what's
>     missing.
>
>     =C2=A0builtin/am.c=C2=A0 =C2=A0 | 2 +-
>     =C2=A0builtin/push.c=C2=A0 | 2 +-
>     =C2=A0parse-options.h | 2 ++
>     =C2=A03 files changed, 4 insertions(+), 2 deletions(-)
>
>     diff --git a/builtin/am.c b/builtin/am.c
>     index b6be1f1cb1..fa8d28794a 100644
>     --- a/builtin/am.c
>     +++ b/builtin/am.c
>     @@ -2402,7 +2402,7 @@ int cmd_am(int argc, const char **argv, const =
char *prefix)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { OPTION_CAL=
LBACK, 0, "show-current-patch", &resume.mode,
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "(dif=
f|raw)",
                        ^^^^^^^^^^^^
This is the argh for that particular option (--show-current-patch).

>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 N_("s=
how the patch being applied"),
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PARSE=
_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGH=
ELP,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PARSE=
_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parse=
_opt_show_current_patch, RESUME_SHOW_PATCH },
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_CMDMODE(=
0, "allow-empty", &resume.mode,
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 N_("record the empty patch as an empty commit"),
>     diff --git a/builtin/push.c b/builtin/push.c
>     index 359db90321..4fa6dfbd09 100644
>     --- a/builtin/push.c
>     +++ b/builtin/push.c
>     @@ -552,7 +552,7 @@ int cmd_push(int argc, const char **argv, const =
char *prefix)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_BIT('f',=
 "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE),
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_CALLBACK=
_F(0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
                                                            ^^^^^^^^^^^^^^=
^^^^^^^^^^
And here's the one for CAS_OPT_NAME, defined elsewhere, (resolves
to --force-with-lease).

>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0N_("require old value of ref =
to be at this value"),
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PARSE_OPT_OPTARG | PARSE_OPT_LITERA=
L_ARGHELP, parseopt_push_cas_option),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PARSE_OPT_OPTARG, parseopt_push_cas=
_option),
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_BIT(0, T=
RANS_OPT_FORCE_IF_INCLUDES, &flags,
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 N_("require remote updates to be integrated locally"),
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 TRANSPORT_PUSH_FORCE_IF_INCLUDES),
>     diff --git a/parse-options.h b/parse-options.h
>     index e22846d3b7..8d089fb3ae 100644
>     --- a/parse-options.h
>     +++ b/parse-options.h

Here's the comment about argh from parse-options.h:

 * `argh`::
 *   token to explain the kind of argument this option wants. Does not
 *   begin in capital letter, and does not end with a full stop.
 *   Should be wrapped by N_() for translation.


>     @@ -108,6 +108,8 @@ typedef enum parse_opt_result parse_opt_ll_cb(st=
ruct parse_opt_ctx_t *ctx,
>     =C2=A0 *=C2=A0 =C2=A0PARSE_OPT_LITERAL_ARGHELP: says that argh shoul=
dn't be enclosed in brackets
>     =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(i.e. '<argh>') in the help m=
essage.
>     =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Useful for options with multi=
ple parameters.
>     + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Automatically enabled if argh con=
tains any
>     + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0of the following characters: ()<>=
[]|
>     =C2=A0 *=C2=A0 =C2=A0PARSE_OPT_NOCOMPLETE: by default all visible op=
tions are completable
>     =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 by git-completion.bash. This option suppresses th=
at.
>     =C2=A0 *=C2=A0 =C2=A0PARSE_OPT_COMP_ARG: this option forces to git-c=
ompletion.bash to
>     --
>     2.34.1
>
