Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2382C71153
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 11:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352046AbjIBLhZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 07:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjIBLhY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 07:37:24 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB61DD
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 04:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1693654629; x=1694259429; i=l.s.r@web.de;
 bh=IJM7MqpZiOEYRweyL2GwtZOliQq3ceq2U07lSEJTHGM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=iVvw+4n9j6RaV/kQaC2WcAxWcXtsp8HMMnW8CRIdau0U+gLR9qwVMAmXj+j/oTkJDNNhHuR
 FhFGP4GbOEOuugVAowXQ5cJkYahzi6VzNkAyogN+MLQMnBe/fy8PAAGYLC9Qj3cC7P/dk/r7k
 NnqzgUeFRP3iUgVO0yfsILOuc5Jn5gsX5pt7rt8L9FAzUU6D/G00N5upncQzwlJPc3A7rDdzz
 KnAB6hGOIfeZrFllYMmTRCWt6Grm/zx5Y7J6rMtNWh/90V16d7ldtjsV1i87FlCS7lxnVWoUQ
 yuK30X8wyIgGm6UaBhMWmfhLcVOXfHapwvydmzObiR4e4Js1XV2g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.152.246]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MumNN-1pkz8Y31mt-00rOSL; Sat, 02
 Sep 2023 13:37:09 +0200
Message-ID: <3bf1bd4a-9d28-32c1-7838-09acd2c85d03@web.de>
Date:   Sat, 2 Sep 2023 13:37:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 10/10] parse-options: mark unused parameters in noop
 callback
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20230831211637.GA949188@coredump.intra.peff.net>
 <20230831212220.GJ949469@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230831212220.GJ949469@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:reQQw2ITdotd8EfojUVg+APf5QWEnst7h6U9qW71l/ElKzir1HY
 NhnUnyI1kryfelFlTS3CxBWoD057smrgr+KP431+wpBXlpdOv63Pxi67ZpqgydLGIra40Vm
 vMiZ60HbbRPVppEyqlsjUrL0SKcWorvExNp9VpZV4WBTWrHfkyLm1cmhqi2eBv8FgV2cEu+
 llfugiE90XRvojfeV5d8Q==
UI-OutboundReport: notjunk:1;M01:P0:Zw6skHX2E7U=;dOjUyXqJWtTPf1r6yDOOFTFMYnf
 I2KFXn1A4tUtQr72v7yHKw+IqCSUORrXcJU28ozmUm4UZVZXmU7XcwFZuHl45BdJd/V23JkVE
 qlsfUv4w/Uy47PsAJIY44s2KWfQuQ4lsZKoHn1Ez/il8lhgl/c+0dHu/vIss8280HwUjF3tJ1
 Bg8hBNN10/vnZcUvx12I4tdO/4BN6YqBrQykppRIGe6dHlXkwQttdTu6m9eE93NnkxUGAJWTD
 Ff7x0NyUrmE60RRe0/IYhV58SRAURs+ISnWPPBk7fmXP+YzWcqVsRB7yTQxGXa9hxrjylTLti
 SmH7iFsUzTkEVZLKPdrI521pmkEIfJYqS3KAjQLC3vjFUIDRHs8VfGNYzAmF/c1lHgR3S9RIX
 +cJxkKKYuTbkiu8Qy1VBTeKlVlGQ85Eud7UbfCbL1PShFk1P8ssFOpkK3NlXrbak6qQIqqWpL
 Zm8IHhJUfzmUfdjJYtQ4541FcOnvLJKzyFvTvARuTC5Bf3w6pbzekwxJ9WA614jFk2sxMUg1u
 kUdv2z8QkbLaB3j4cPzNRA1KPLf6UhvHuiwjxf07mC4mC3Dgs7JyQ4885ZCQSwfZP3reGcF9v
 9s73czgpo62V/vPCTgv9wZCFGL82Bfvhfl0+t5zWRU815sNMTfouA8CAr5TwqDDGgDshwB8eH
 uHFjua5aBK00lmArHgtMQn7jq8wCJX7PxY3YbAECvpd763YRv2YazgBPuYWBesov4k4kPdih+
 Ref71YuviNmd7PXSOGUxEexyQt6tTMpHTn2f5emjqOuKFjq2wX4vJrXSC1S12DyDdcPktIknH
 sJx7fwdaGTD0iize+65eT0J9P21DwlA4NYqc7lk01kMGycSV9X+r3ur9NPso3WRAUcXfyS8ML
 2dFJIQTT6zNcBe3iimXzumnt6GtE+gPaRDaecl6RPv+kmyW1o1UhTPIeO0mzStLmy2JplR0Gl
 jsvvnNkm174V92azU7hFpV/f7Ws=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.08.23 um 23:22 schrieb Jeff King:
> Unsurprisingly, the noop options callback doesn't bother to look at any
> of its parameters. Let's mark them so that -Wunused-parameter does not
> complain.
>
> Another option would be to drop the callback and have parse-options
> itself recognize OPT_NOOP_NOARG. But that seems like extra work for no
> real benefit.

I'm not sure about that -- we don't need to add special flags or option
types to drop parse_opt_noop_cb().

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  parse-options-cb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/parse-options-cb.c b/parse-options-cb.c
> index a24521dee0..bdc7fae497 100644
> --- a/parse-options-cb.c
> +++ b/parse-options-cb.c
> @@ -227,7 +227,9 @@ int parse_opt_strvec(const struct option *opt, const=
 char *arg, int unset)
>  	return 0;
>  }
>
> -int parse_opt_noop_cb(const struct option *opt, const char *arg, int un=
set)
> +int parse_opt_noop_cb(const struct option *opt UNUSED,
> +		      const char *arg UNUSED,
> +		      int unset UNUSED)
>  {
>  	return 0;
>  }

Your patch is simple and makes sense.  The one below is more
complicated, but leaves the code in a slightly better state.  I'd go
with that variant if I'd had to add OPT_NOOP_NOARG today, and I
slightly prefer it, but similar to you think that the benefit is low
(though non-zero).  So I'm unsure if that's enough to be worth it or
just bikeshedding with some hindsight..

Ren=C3=A9



=2D-- >8 ---
Subject: [PATCH] parse-options: let NULL callback be a noop

Allow OPTION_CALLBACK options to have a NULL callback function pointer
and do nothing in that case, yet still handle arguments as usual.  Use
this to replace parse_opt_noop_cb().

We lose the ability to distinguish between a forgotten function pointer
and intentional noop, but that will be caught by a compiler warning
about an unused function in many cases and having an option do nothing
is a benign failure mode.

We also lose the ability to add a warning to the callback, but we
haven't done that since it was added by 6acec0380b (parseopt: add
OPT_NOOP_NOARG, 2011-09-28), so we probably won't do it soon.  We can
add a callback back when we want to show a warning.

By letting go of features we don't need this patch simplifies the
parse-options API and gets rid of an exported empty function.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options-cb.c | 5 -----
 parse-options.c    | 7 +++----
 parse-options.h    | 2 --
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index a24521dee0..e79cd54ec2 100644
=2D-- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -227,11 +227,6 @@ int parse_opt_strvec(const struct option *opt, const =
char *arg, int unset)
 	return 0;
 }

-int parse_opt_noop_cb(const struct option *opt, const char *arg, int unse=
t)
-{
-	return 0;
-}
-
 /**
  * Recreates the command-line option in the strbuf.
  */
diff --git a/parse-options.c b/parse-options.c
index 76d2e76b49..5be8de93f5 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -201,8 +201,9 @@ static enum parse_opt_result get_value(struct parse_op=
t_ctx_t *p,
 		}
 		if (opt->callback)
 			return (*opt->callback)(opt, p_arg, p_unset) ? (-1) : 0;
-		else
+		if (opt->ll_callback)
 			return (*opt->ll_callback)(p, opt, p_arg, p_unset);
+		return 0;
 	}
 	case OPTION_INTEGER:
 		if (unset) {
@@ -494,9 +495,7 @@ static void parse_options_check(const struct option *o=
pts)
 				optbug(opts, "should not accept an argument");
 			break;
 		case OPTION_CALLBACK:
-			if (!opts->callback && !opts->ll_callback)
-				optbug(opts, "OPTION_CALLBACK needs one callback");
-			else if (opts->callback && opts->ll_callback)
+			if (opts->callback && opts->ll_callback)
 				optbug(opts, "OPTION_CALLBACK can't have two callbacks");
 			break;
 		case OPTION_LOWLEVEL_CALLBACK:
diff --git a/parse-options.h b/parse-options.h
index 57a7fe9d91..41bb47120d 100644
=2D-- a/parse-options.h
+++ b/parse-options.h
@@ -348,7 +348,6 @@ struct option {
 	.long_name =3D (l), \
 	.help =3D N_("no-op (backward compatibility)"), \
 	.flags =3D PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, \
-	.callback =3D parse_opt_noop_cb, \
 }

 #define OPT_ALIAS(s, l, source_long_name) { \
@@ -490,7 +489,6 @@ int parse_opt_commit(const struct option *, const char=
 *, int);
 int parse_opt_tertiary(const struct option *, const char *, int);
 int parse_opt_string_list(const struct option *, const char *, int);
 int parse_opt_strvec(const struct option *, const char *, int);
-int parse_opt_noop_cb(const struct option *, const char *, int);
 int parse_opt_passthru(const struct option *, const char *, int);
 int parse_opt_passthru_argv(const struct option *, const char *, int);
 /* value is enum branch_track* */
=2D-
2.42.0
