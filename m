Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC97B364A4
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705859820; cv=none; b=cNHPEd3d+ZwipxJpUoGuyIPSo9jcnyjQHWtW8QeVYlxRXzTcwWd/IGTNQ12QZyicydHKn3xlelTy0o8hI20hVdyiS7VfTdMzH1MpxbEBrStzlDzeXNzD9YqUTKA+EttvZZk+FdRK4gie1suCRf3U8b4mvAGQxJuEzBH1qxphGF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705859820; c=relaxed/simple;
	bh=MFzYtf9NG9tF5IPQOaRppSZFlZWgus8QLHT1Hc1phpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQsySrYsBKVYXjuneN0CSpHs2gUPEWL4M491M7xWYoOxI63+bKw1cUsvoA0RI9uen9MdjoJjsemDlDJMhUpV6Yrmz9JNUGHT/WyGznucBIwydbtY0Taqf9OrCcFY+DMZIc9CSc3GxdLO2EqWcwFJAX8AhIrAspvOjQVk++keEr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=nyUlonly; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="nyUlonly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705859800; x=1706464600; i=l.s.r@web.de;
	bh=MFzYtf9NG9tF5IPQOaRppSZFlZWgus8QLHT1Hc1phpE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=nyUlonlyvgxLdwcTO6yCfRjIbQe7ASXZDqzA8qptJ3ol+Itmb966BWWRE1HaQINr
	 8ga2ZfalAoacUmQWuEEqevwhJdZ87Dhz+Vreez+XS3zb0dyGmVJdv2lXnYEfPL+3B
	 bZkpkvrPQGEma1jk6i+x0hUQIT1MAHl3NGDSUtQroAcPycFKbtCc+aggZtTg0FA2y
	 uQeGccIqA787tnGawnQQu5sNe3Rk31LqIQVxR59pCKNH326FsA7g9p78cxcYT87zw
	 Gb5UWMYd6h6lTSacbdJVgdNWzKMAogN6tX3zYWuBwhd/BlJfLgsIT24tUhnhao+VA
	 ZmBPBudaD/vXgdxrDg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.25]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7ux4-1rWXjm07zm-00517S; Sun, 21
 Jan 2024 18:56:40 +0100
Message-ID: <fb3c679a-5f00-4934-b028-6b2d081cd5b2@web.de>
Date: Sun, 21 Jan 2024 18:56:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug?] "git diff --no-rename A B"
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
References: <xmqq34uvtpob.fsf@gitster.g>
 <20240120011800.GF117170@coredump.intra.peff.net>
 <579fd5bc-3bfd-427f-b22d-dab5e7e56eb2@web.de> <xmqqmsszga9m.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqmsszga9m.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:au2OJ9ZfO/u9CEBMoaQHM5UXTJXydvZSs79n94hjruJpTMkoRJ1
 aVX5XAanY8mazAPwyltsqd8hQHIOa8iaYPX8QOH+rlv00b6LjwurKc08FrdiWRpaphtv48S
 BnIUQbsNq15lJ8rKwO3nOqr8eKj+RGlZIaxal3R1laWmnG7MTIxZIPVOrds6hDChk3t9yt1
 /z/eVQr9NpwmWhg80t4TA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iCz9RO8gkc8=;WZHD2z2uXP3k0/eoMmOSxFwu0S2
 9rq60dPCPS1MTyjcrGGoAoxOQNGG+TdCug/yk1XdYP3VEokHyF21jbK6Om6qvs5tFdpmTRhIx
 xh+QwjC2ChfHcUL8pFrehp8NU2slRtDSzu2fKT/Y3jzmk542P5psUJJ7lsiq/Atw8eHFLmOrU
 rXJ5x3+nZQ8ZmIRuZ0hB1ijdYyyrtPJugBwWk249M9JAGOOQSBFP4j+orGD23I9NHVMbAxLt/
 k5QSHZihadQhCZl5KLEV9miXt3FmEpnux/V26n/e15tMWeMxASzYZ6qu+V54IlwmleqVJvHBr
 xsTKwrwmoYBLIZHMdgU0ezH1a7vlwvaB8UfBG6yw90ojZoBn+axS7TgHWv5OBWbWH1CmJn7WJ
 KrxixPHqzwbtisstIGoM0BUAnUNJIwbKWW5ug2MQljWUx6TEoCF3HqdM6xEgc5NJof2yzWDL0
 Wew2fpk0Afom5RW+GU7++MQGOz5WDrvDJZKnyrTc24Zb6Yoril3rhRdcoZduNcTaWOHudX0Gh
 n0/hSNmbRW4o2Q773jWCKNVm6HmlLnwy0lF6WkkQAIntkYW3jjnyZBo07vpZNqJ7Om3ymMOys
 VC8bbMwTXUAFaArqhBzDSQyEyRUE5PidFurzpG2+pWqrEpcG3aVQXd+WU+nU4q7VwYICHMAt2
 WZxF4072fSkkpMnHj8j0R3eSgAi/3/CTeq9XC1yROiSCec8da1ZbPxFQwOrcZxlsw6xjpSYrI
 S1HVkMFDvd9aY5L4zFsR2dHl8SiaALZUfAmRV2jZvIN7Ucj5lbzeJ59v4TIg7jY9102kMi+Lo
 FMkxF5yqL/b8aq2Jw456cRZqt97/j/udw7Y5LWokGXH8U6hxc8xUPpY/V92lTiwzHbaIj//kK
 4k9tNi40Z4a1VbkR0+X7dKbTzTnMBt2rIISDP132UikREhRpQFSflMcBeX7SCUVKDvjR7PfbB
 c4wzlA==

Am 20.01.24 um 18:55 schrieb Junio C Hamano:
>
> I agree with you that the structure of that loop and the processing
> in it does look confusing.

Here's a small simplification.

=2D-- >8 ---
Subject: [PATCH 2/1] parse-options: simplify positivation handling

We accept the positive version of options whose long name starts with
"no-" and are defined without the flag PARSE_OPT_NONEG.  E.g. git clone
has an explicitly defined --no-checkout option and also implicitly
accepts --checkout to override it.

parse_long_opt() handles that by restarting the option matching with the
positive version when it finds that only the current option definition
starts with "no-", but not the user-supplied argument.  This code is
located almost at the end of the matching logic.

Avoid the need for a restart by moving the code up.  We don't have to
check the positive arg against the negative long_name at all -- the
"no-" prefix of the latter makes a match impossible.  Skip it and toggle
OPT_UNSET right away to simplify the control flow.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Patch formatted with --function-context for easier review.

 parse-options.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 92e96ca6cd..63a99dea6e 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -353,95 +353,94 @@ static int is_alias(struct parse_opt_ctx_t *ctx,
 static enum parse_opt_result parse_long_opt(
 	struct parse_opt_ctx_t *p, const char *arg,
 	const struct option *options)
 {
 	const char *arg_end =3D strchrnul(arg, '=3D');
 	const struct option *abbrev_option =3D NULL, *ambiguous_option =3D NULL;
 	enum opt_parsed abbrev_flags =3D OPT_LONG, ambiguous_flags =3D OPT_LONG;
 	int allow_abbrev =3D !(p->flags & PARSE_OPT_KEEP_UNKNOWN_OPT);

 	for (; options->type !=3D OPTION_END; options++) {
 		const char *rest, *long_name =3D options->long_name;
 		enum opt_parsed flags =3D OPT_LONG, opt_flags =3D OPT_LONG;

 		if (options->type =3D=3D OPTION_SUBCOMMAND)
 			continue;
 		if (!long_name)
 			continue;

-again:
+		if (!starts_with(arg, "no-") &&
+		    !(options->flags & PARSE_OPT_NONEG) &&
+		    skip_prefix(long_name, "no-", &long_name))
+			opt_flags |=3D OPT_UNSET;
+
 		if (!skip_prefix(arg, long_name, &rest))
 			rest =3D NULL;
 		if (!rest) {
 			/* abbreviated? */
 			if (allow_abbrev &&
 			    !strncmp(long_name, arg, arg_end - arg)) {
 is_abbreviated:
 				if (abbrev_option &&
 				    !is_alias(p, abbrev_option, options)) {
 					/*
 					 * If this is abbreviated, it is
 					 * ambiguous. So when there is no
 					 * exact match later, we need to
 					 * error out.
 					 */
 					ambiguous_option =3D abbrev_option;
 					ambiguous_flags =3D abbrev_flags;
 				}
 				if (!(flags & OPT_UNSET) && *arg_end)
 					p->opt =3D arg_end + 1;
 				abbrev_option =3D options;
 				abbrev_flags =3D flags ^ opt_flags;
 				continue;
 			}
 			/* negation allowed? */
 			if (options->flags & PARSE_OPT_NONEG)
 				continue;
 			/* negated and abbreviated very much? */
 			if (allow_abbrev && starts_with("no-", arg)) {
 				flags |=3D OPT_UNSET;
 				goto is_abbreviated;
 			}
 			/* negated? */
-			if (!starts_with(arg, "no-")) {
-				if (skip_prefix(long_name, "no-", &long_name)) {
-					opt_flags |=3D OPT_UNSET;
-					goto again;
-				}
+			if (!starts_with(arg, "no-"))
 				continue;
-			}
 			flags |=3D OPT_UNSET;
 			if (!skip_prefix(arg + 3, long_name, &rest)) {
 				/* abbreviated and negated? */
 				if (allow_abbrev &&
 				    starts_with(long_name, arg + 3))
 					goto is_abbreviated;
 				else
 					continue;
 			}
 		}
 		if (*rest) {
 			if (*rest !=3D '=3D')
 				continue;
 			p->opt =3D rest + 1;
 		}
 		return get_value(p, options, flags ^ opt_flags);
 	}

 	if (disallow_abbreviated_options && (ambiguous_option || abbrev_option))
 		die("disallowed abbreviated or ambiguous option '%.*s'",
 		    (int)(arg_end - arg), arg);

 	if (ambiguous_option) {
 		error(_("ambiguous option: %s "
 			"(could be --%s%s or --%s%s)"),
 			arg,
 			(ambiguous_flags & OPT_UNSET) ?  "no-" : "",
 			ambiguous_option->long_name,
 			(abbrev_flags & OPT_UNSET) ?  "no-" : "",
 			abbrev_option->long_name);
 		return PARSE_OPT_HELP;
 	}
 	if (abbrev_option)
 		return get_value(p, abbrev_option, abbrev_flags);
 	return PARSE_OPT_UNKNOWN;
 }
=2D-
2.43.0
