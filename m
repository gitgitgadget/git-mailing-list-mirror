Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC6410940
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705761917; cv=none; b=rLdtaa6Z3k/+kkO6kzXN1rT3l6VRnA5zZ+N7IHH4SmwRT/lG4XGqB5bGvUqbsXSCwRxGManhzSFPMAMcKZ9NX1Q+7uNWma335clLQAIObuppmlSD478s1+Z2BLhYWxAm76tAQ+aZ2x5EUz8Xkhm74crmp69J4UvEaKY/ImJcFT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705761917; c=relaxed/simple;
	bh=IkbbsE7huM5BCwQMz/E2CWq80fjhLbQi2ALY1I0Fg9g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=g1ZOB8mwBR27hPNGZ1rja1Twob0+CZ55khcREUDIFFfPxzM9yF4MX1xGgC31vLnHKgWncXMUXLuT8cr1a8wDnjNQlGZjpsFq7mfkl8s9rIr7RGAPmjTPMFQVm/ZaoqlrGaW9pVn058E0uwH9gZs1OSTFn0tT0HUWUc1YEigU3/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Osa1sKBh; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Osa1sKBh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705761905; x=1706366705; i=l.s.r@web.de;
	bh=IkbbsE7huM5BCwQMz/E2CWq80fjhLbQi2ALY1I0Fg9g=;
	h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:
	 In-Reply-To;
	b=Osa1sKBh0KqIw8C6zqq6OlksIRpCkWYr3f58FBVqnXobKOJlv1nnVDmJnYMooC2e
	 P8GcCVW81ArlPsLFdVemy1zgzvfqTmIoIq8V8vMnSsQi7e/+gks/30DaHwfFhJ2MZ
	 Hj0G7S7Mj119pjBQX9YfQ45Sp72MhVtNIxoHqocvhpuhy2A0W9SPxTGVGOLKvg62c
	 HoZHmiLmmgLPhxVieqRNS5UOtIBKaf0zYDIdxdxSHesjLHLXZFF46GHp+u6kiiQWW
	 LWEvRnxapTtgzshDaucqnXmVdcvMrLHNP5TPWcz7JgXYg5r8SZIZCKBY5lO6sC8u9
	 57FIH8UtIAOmpBveWQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.214]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9ISh-1rVrLQ01P5-0064KF; Sat, 20
 Jan 2024 15:39:39 +0100
Message-ID: <579fd5bc-3bfd-427f-b22d-dab5e7e56eb2@web.de>
Date: Sat, 20 Jan 2024 15:39:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [Bug?] "git diff --no-rename A B"
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqq34uvtpob.fsf@gitster.g>
 <20240120011800.GF117170@coredump.intra.peff.net>
X-Mozilla-News-Host: news://lore.kernel.org
Content-Language: en-US
In-Reply-To: <20240120011800.GF117170@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c+gPGjcS95DklglUv5gH4K5itkrTNsv+zpxAQXIglBJgrRq+4dM
 FV9IPcC0UWMdv46ZXEISmS56sUtUdrK8DA7VEpJEa86cqltn6sGLl5567Yz7yzPu5t6rPo0
 Y7inoVUz+dTRt7+QkLqP8/Enn6cQYxRewNdX7jKn5/xlSOMGEHcAWMC8GvbjsvwyBKZRxlP
 4bCY7Qbg15aVOi+vA9q1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OXdKpjPAjp8=;VdsYlzF2WdPP4jJKl1i7OLY47KL
 lDB+vJmHpohBOEGMVq7ITSbM3tuvwZq6Qcm61CPTTdeMEOuonLGoMrJprnQ6F2YuHwNGOmewx
 U7OATJlzpGZ+p+X5j2Erk63U6aN5WBb1FW+6ipeUeXo3SLUvNVss+o253/JxUEhZprGZSiIS1
 jbKHSPo+fdNCfwud8wbjATeptKzDYfEPrMDP40QNKDFONeu6hVuLWKmAbY6fg7BxMNXBfKN+s
 WzT2MD4Pa5wX3v6ADuvGtJPzwUEqgZ8DDeEjv+WJK7mcJHb1ZN5Rf1xbzSYoME+zfMWFz9/Va
 kCu5f1WlKTAPsRNkA26Bdf+VtrO23QknuCt9FPScP1YHNHvT3Ycl6RCfi5l/WQF2dzNh0vy6M
 dEugPm/bEhG4Se8qfa5T1G6Ftkq5U92dwFKFXgeV5KpkAwM3dxReHTTIkc0zVtoxUGJhWAWxc
 N2PmyyPiiUAm+sv+7LRnQjOOVZRJJ1e6/W53IkGK3hJ+uCDtiMcCqGcRYbcggCwpxOKXgMO0t
 uWwxaa6BUJaaDlgqT7vF7Oqk7j2X7koeOkl8Qr59Q/vDzKBZVWqn8BTH1mSjorlZezmpN70O1
 ykfhyMvUpefW4S5lWWfYZJYOr+89jgVqgo1wWnsbiJGyMDUPqqDsWxmf5km5hE9qmZe5yyF1C
 Q6kJQrvjzeB0s1B6GukAD2wIqnnaSIeW3TSbx0gg0Dshb7LDhqhayN6EBo1+ixQ5Jg8KGOuyc
 C5hm+8eROKrW6nuCHnJUSNHGg7XGFeiqf6h2VHOlV6xeBXoKiJWp9nZty0E2CXiTQu4XsS9cI
 yYGHPSYeCchHwEV2gjExmJnj7OZW6+t33pweXV7XOlIvY+jtG0KMg8s3/yr4JamEZginHQ2Wq
 ymJu4uQz1YbkLj6DRsGRj45afZY1D0FVHleobJ/zk+2NwP/AXSYxtmVxHu/Hsj/ymWZ4OjCyD
 pcccMg==

Am 20.01.24 um 02:18 schrieb Jeff King:
> On Wed, Jan 17, 2024 at 05:07:16PM -0800, Junio C Hamano wrote:
>
>> When the user misspells "--no-renames" as "--no-rename", it seems
>> that the rename detection (which is ont by default these days) still
>> kicks in, which means the misspelt option is silently ignored.
>> Should we show an error message instead?
>
> I wondered if "--no-foo" complained, and it does. I think this is a
> subtle corner case in parse-options.
>
> The issue is that we have "--rename-empty", which of course also
> provides "--no-rename-empty". And parse-options is happy to let you
> abbreviate names as long as they are unambiguous. But "--no-rename" _is_
> ambiguous with "--no-renames". Why don't we catch it?

Because diff_opt_parse() passes PARSE_OPT_KEEP_UNKNOWN_OPT, which makes
parse_long_opt() skip abbreviation detection.  Which it does since
baa4adc66a (parse-options: disable option abbreviation with
PARSE_OPT_KEEP_UNKNOWN, 2019-01-27).

It added a condition only to the if.  Its body can be reached via goto
from two other places, though.  So abbreviated options are effectively
allowed through the back door.

=2D-- >8 ---
Subject: [PATCH] parse-options: fully disable option abbreviation with PAR=
SE_OPT_KEEP_UNKNOWN

baa4adc66a (parse-options: disable option abbreviation with
PARSE_OPT_KEEP_UNKNOWN, 2019-01-27) turned off support for abbreviated
options when the flag PARSE_OPT_KEEP_UNKNOWN is given, as any shortened
option could also be an abbreviation for one of the unknown options.

The code for handling abbreviated options is guarded by an if, but it
can also be reached via goto.  baa4adc66a only blocked the first way.
Add the condition to the other ones as well.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Formatted with --function-context for easier review.
The code is a quite tangled, any ideas how to structure it better?

 parse-options.c         | 8 +++++---
 t/t4013-diff-various.sh | 6 ++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 4ce2b7ca16..92e96ca6cd 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -353,93 +353,95 @@ static int is_alias(struct parse_opt_ctx_t *ctx,
 static enum parse_opt_result parse_long_opt(
 	struct parse_opt_ctx_t *p, const char *arg,
 	const struct option *options)
 {
 	const char *arg_end =3D strchrnul(arg, '=3D');
 	const struct option *abbrev_option =3D NULL, *ambiguous_option =3D NULL;
 	enum opt_parsed abbrev_flags =3D OPT_LONG, ambiguous_flags =3D OPT_LONG;
+	int allow_abbrev =3D !(p->flags & PARSE_OPT_KEEP_UNKNOWN_OPT);

 	for (; options->type !=3D OPTION_END; options++) {
 		const char *rest, *long_name =3D options->long_name;
 		enum opt_parsed flags =3D OPT_LONG, opt_flags =3D OPT_LONG;

 		if (options->type =3D=3D OPTION_SUBCOMMAND)
 			continue;
 		if (!long_name)
 			continue;

 again:
 		if (!skip_prefix(arg, long_name, &rest))
 			rest =3D NULL;
 		if (!rest) {
 			/* abbreviated? */
-			if (!(p->flags & PARSE_OPT_KEEP_UNKNOWN_OPT) &&
+			if (allow_abbrev &&
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
-			if (starts_with("no-", arg)) {
+			if (allow_abbrev && starts_with("no-", arg)) {
 				flags |=3D OPT_UNSET;
 				goto is_abbreviated;
 			}
 			/* negated? */
 			if (!starts_with(arg, "no-")) {
 				if (skip_prefix(long_name, "no-", &long_name)) {
 					opt_flags |=3D OPT_UNSET;
 					goto again;
 				}
 				continue;
 			}
 			flags |=3D OPT_UNSET;
 			if (!skip_prefix(arg + 3, long_name, &rest)) {
 				/* abbreviated and negated? */
-				if (starts_with(long_name, arg + 3))
+				if (allow_abbrev &&
+				    starts_with(long_name, arg + 3))
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
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index cb094241ec..1e3b2dbea4 100755
=2D-- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -663,4 +663,10 @@ test_expect_success 'diff --default-prefix overrides =
diff.mnemonicprefix' '
 	check_prefix actual a/file0 b/file0
 '

+test_expect_success 'diff --no-renames cannot be abbreviated' '
+	test_expect_code 129 git diff --no-rename >actual 2>error &&
+	test_must_be_empty actual &&
+	grep "invalid option: --no-rename" error
+'
+
 test_done
=2D-
2.43.0
