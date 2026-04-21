Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB13DDDD0
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803592; cv=none; b=GN3UAAg4qUA0D0jq2HTpm5uox509FXkOJMfqdIHeMXK5HUx2l3cdnqLWzTVcB6qDdswpOMFz8OgJ/Bs1nUly7wZB0YwAxuiXY1TkaRF1EqztZ3FtLGC/4tNnRm2XCvaD/4P5DsrZdifWiGrjwU6+mW0Uyy9xDytvNm7DimnYAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803592; c=relaxed/simple;
	bh=ulPAXUnvjited290GeDvWeOHoOibXkzVR65cnVl4xWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=NblBMp7D4fFyuaMTya7bNo2nuv3ezNJx2CfgZZL+PHYX4NLgZ7yM5nxTs5bYayhjEy3OTEtBdg9tw1R5YK1v3wDqd6rfv30IHACXNeNNYkTw2RtEivMwWXUYg06Rad1FsYSUEIFvrBsRSxhcRRYKiQeQgvklU9ZrfRfTwkymNAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=VtSYEN3c; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="VtSYEN3c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1776803585; x=1777408385; i=l.s.r@web.de;
	bh=gHO5/bBscGGSM92Ulh1WDPQkqB5JKzexRHb4yc+gwOM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VtSYEN3ci7D0KN1fQRz7vc30mCYOgLUyuQuNkCxXwW9VYTF6h+cTIu1g9hDDt+bG
	 b6OS3VWFxvWKmHy5h+JJsXmOopbK0YPeatRZGupooqRzo+y4P312+o79XGSls3oN3
	 lYt+vHIwp2YAdWAnBMMt0IqwINGmfivjeqIQPr4tYE/Jss5teQivrQBD9G2AVpef6
	 9YIQZOres984LukWiH92UDU4OB2m5uTL8avHt2oc65qsQ61Zh0z9Fr5pKQwXYTQx3
	 Yh/fqrB2ITLcczdyulvG8atyte6xwGQh/PTKZeKJxNhKfRYVzqHUE1Lr80ehVE+47
	 d+nOn+jLGDPoqCbD1Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIL4Y-1w9nc50NBk-002ZtZ; Tue, 21
 Apr 2026 22:33:05 +0200
Message-ID: <3ce1906a-85e3-4fb1-9ebc-a5639f3194c9@web.de>
Date: Tue, 21 Apr 2026 22:33:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git grep bug with --column and --only-matching
To: Brandon Chinn <brandonchinn178@gmail.com>
References: <CAGANf=dkRgFp+bEkB5f8QBeiR3m+3WE8sKqT9vKstkGHqbxA3A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <CAGANf=dkRgFp+bEkB5f8QBeiR3m+3WE8sKqT9vKstkGHqbxA3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xcFkfp6JdjScffeTDWhJBvfBl65nkq62jUpWjbmTv6zGz3Om1u4
 VDxHKT+taS4UzI/WfqHjNfg/TTdAf7OHodA4G88a8gTVVqAoRRnIHFUr9BtmiLlQS/WY55t
 b1r2WGn4yJhQJGlKfzeo576DhNqmMf75Ocyh6SHHPpk7fnGbXkWkmptfifWWsgXPOXTUqxa
 BxlcvyX/Mq/oRuH0zoDLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2BPvIJTQKCs=;gefpc7igHRt3AZquSBk8SjZDUSi
 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

On 4/21/26 7:03 AM, Brandon Chinn wrote:
> I'm encountering a bug when using `git grep` with both `--column` and
> `--only-matching`, is this a known limitation?
>=20
> Repro:
>=20
> ```
> $ echo 'x   x   x' > repro.txt
>=20
> $ grep -bo x repro.txt
> 0:x
> 4:x
> 8:x
>=20
> $ git grep --no-index -o -n --column x repro.txt
> repro.txt:1:  1:x
> repro.txt:1:  2:x
> repro.txt:1:  6:x

The first column value matches (1-based for git grep, 0-based for
grep(1)), the remaining ones are different.  grep(1) shows the offset
like for the first match, but git grep adds the relative position of the
end of the previous match.

I don't know how to use the resulting numbers and I agree that it seems
like a bug -- showing the column of each match within its line makes
more sense for an option named --column.

However, the original submission of this feature in
https://lore.kernel.org/git/cover.1529961706.git.me@ttaylorr.com/
gave similar examples in its commit message and its tests, called
them "as one would expect" and was not challenged on that, so I may be
missing something.

Here's its first example with underlined matches, a ruler and the
intended output (without unnecessary headers):

  (`man gitcvs-migration` or `git help cvs-migration` if git is
        ^^^                   ^^^                        ^^^
           1111111111222222222233333333334444444444555555555566 =20
  123456789 123456789 123456789 123456789 123456789 123456789 1
          =20
  7:git
  16:git
  38:git

And here's the last line of the test file from t7810 with underlined
matches (the other four lines are very similar), a ruler and the
expected output (unncessary headers removed):

  foo_mmap bar mmap baz
      ^^^^     ^^^^
           111111111122
  123456789 123456789 1

  5:mmap
  13:mmap

If we wanted to show the column of matches 2 and beyond then we could do
something like this:


diff --git a/grep.c b/grep.c
index c7e1dc1e0e..a54e5d86a9 100644
=2D-- a/grep.c
+++ b/grep.c
@@ -1267,6 +1267,7 @@ static void show_line(struct grep_opt *opt,
 		regmatch_t match;
 		enum grep_context ctx =3D GREP_CONTEXT_BODY;
 		int eflags =3D 0;
+		const char *start =3D bol;
=20
 		if (want_color(opt->color)) {
 			if (sign =3D=3D ':')
@@ -1285,6 +1286,7 @@ static void show_line(struct grep_opt *opt,
 			if (match.rm_so =3D=3D match.rm_eo)
 				break;
=20
+			cno =3D bol - start + match.rm_so + 1;
 			if (opt->only_matching)
 				show_line_header(opt, name, lno, cno, sign);
 			else
@@ -1294,7 +1296,6 @@ static void show_line(struct grep_opt *opt,
 			if (opt->only_matching)
 				opt->output(opt, "\n", 1);
 			bol +=3D match.rm_eo;
-			cno +=3D match.rm_eo;
 			rest -=3D match.rm_eo;
 			eflags =3D REG_NOTBOL;
 		}
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 64ac4f04ee..bd439563d6 100755
=2D-- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -322,11 +322,11 @@ do
 		${HC}file:1:5:mmap
 		${HC}file:2:5:mmap
 		${HC}file:3:5:mmap
-		${HC}file:3:13:mmap
+		${HC}file:3:14:mmap
 		${HC}file:4:5:mmap
-		${HC}file:4:13:mmap
+		${HC}file:4:14:mmap
 		${HC}file:5:5:mmap
-		${HC}file:5:13:mmap
+		${HC}file:5:14:mmap
 		EOF
 		git grep --column -n -o -e mmap $H >actual &&
 		test_cmp expected actual

