Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF0627700D
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764690242; cv=none; b=eMZMCo6upLzMhGS6eBzBlTvCR40+top4Cn4diZgRUXvlxN5AqlSrGyoRCqp+ebYVFGoTwWq4T2uXaEGB3uM8H0xuVodkGsw0Bo9Kw6oqZJmM7bSbeXSRJDsrM8yyBBz2tdPJMvvai//ik3osvUDYXH2qLd+vVuEVmd90/ZicHo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764690242; c=relaxed/simple;
	bh=zqEH/2GvFwIRam5lFQsnq4oUTBR1HtDJPfcxCQyMJi4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XBkQVsFpkE/EczbcKqvK4MrFa1OBx9S/RfJN4d7CE7eRU2dM1ozcQyC+chIDTGgvPS6pmNrEvkUueC9C5cyi71ppy9EKOdAZYsWAY6YAJp9kd9oelW7gWsQDh0ggNhm1Opi7BAG1C6GzfNRbrmUdzQkOTv6Co4pTu4mDEiS+TeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=WpBH/EHQ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="WpBH/EHQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764690236; x=1765295036;
	i=johannes.schindelin@gmx.de;
	bh=yegPSgC2vo9dMcaIBB1MMZmtdbmyR8nDQjx5TOOzok8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WpBH/EHQYybukDK2rQBXnsjKn8ixFAjfmW9seap3r3xgAsoreue+5d9PDCrCuFnN
	 UMinfHOqlc8lCe9Nnk2+3BYhhnVrzkX34/vdksxOVcPVIuqQDOzNb5jyfXKwTleW6
	 8Y6UCfvfPOt+csrOVXtae+prVuWEF1Rwe8yJXglg78tNOABwCeCUhR2Xn7PKYyQO8
	 kd9mSzyNy5IETVjRCthsjgRtzxWTn77fhHB9/Jg7MQNc99k+knPyIwctlvOECYW60
	 3TghIbaQqXvY4xMU70AAM7DuB4cmh4n2sN5WNKAEUwGIhwaIaVwYkwGVDc7r4igwL
	 ZL1T9C5L6G2bImrfww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.165]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYvcA-1vdmM01j3A-00PMh3; Tue, 02
 Dec 2025 16:43:56 +0100
Date: Tue, 2 Dec 2025 16:43:54 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: phillip.wood@dunelm.org.uk
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 1/3] sideband: mask control characters
In-Reply-To: <f2ce08c4-f70e-487a-8dd9-286ee5bc683d@gmail.com>
Message-ID: <7fa83a64-95f3-9ca8-537e-12a7f919d8ae@gmx.de>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com> <f7fb7a38333cf6527345e3dbefaeb2cd8ade6429.1736878772.git.gitgitgadget@gmail.com> <f2ce08c4-f70e-487a-8dd9-286ee5bc683d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ptMOx/L5yXTGi3XXW7Y+q/AbwdEj3KTa+/m7Qwdhxeq4XgAt5gp
 nAMQFdpbKpl+YrRgzYZNaDFEkYeaEQnqUuHeXsBdpYleovDOyLtKpwi03eRqCUtGcKQwYvF
 +KczHDBNs0iaMRFmeONIpfTv4HDR22KCjMfZGemUUOfjYrok0ZHU8Z2Cx5tRaNXFu92WjCv
 +EAN8gt779fis84xqp1VQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OismjRqq4TU=;ShYBcpfL4r24GzS3NpGg+vF+7o2
 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
 Vi5C80wOVNWDcUJe0psK1VkmbyqKQ
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Wed, 15 Jan 2025, Phillip Wood wrote:

> Just a couple of small comments
>=20
> On 14/01/2025 18:19, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > +static void strbuf_add_sanitized(struct strbuf *dest, const char *src=
, int
> > n)
> > +{
> > +	strbuf_grow(dest, n);
> > +	for (; n && *src; src++, n--) {
> > +		if (!iscntrl(*src) || *src =3D=3D '\t' || *src =3D=3D '\n')
>=20
> Isn't it a bug to pass '\n' to maybe_colorize_sideband() ?

While a band 2 message is indeed split by newlines and fed to this
function line by line, which is the case for a long time already: since
ed1902ef5c6 (cope with multiple line breaks within sideband progress
messages, 2007-10-16), the same is not true for band 3 messages: They pass
the entire message in one go (and for multi-line payload, only the first
line is prefixed with `remote:`, which is arguably a bug, but not one that
is within this here patch series' scope).

See
https://gitlab.com/git-scm/git/-/blob/v2.52.0/sideband.c#L191 and
https://gitlab.com/git-scm/git/-/blob/v2.52.0/sideband.c#L176,
respectively.

So no, I don't think that we can currently consider it a bug to pass `\n`
as part of the `src` parameter to `maybe_colorize_sideband()`.

> > +			strbuf_addch(dest, *src);
> > +		else {
> > +			strbuf_addch(dest, '^');
> > +			strbuf_addch(dest, 0x40 + *src);
>=20
> This will escape DEL ('\x7f') as "^\xbf" which is invalid in utf-8 local=
es.
> Perhaps we could use "^?" for that instead.

Good point! This seems to be the historical way to escape DEL, probably
because 0x3f ('?') is 0x7f + 0x40 truncated to 7 bits. I'll do this in the
next iteration:

=2D- snip --
diff --git a/sideband.c b/sideband.c
index f613d4d6cc3..684621579fd 100644
=2D-- a/sideband.c
+++ b/sideband.c
@@ -175,7 +175,7 @@ static void strbuf_add_sanitized(struct strbuf *dest, =
const char *src, int n)
 			n -=3D i;
 		} else {
 			strbuf_addch(dest, '^');
-			strbuf_addch(dest, 0x40 + *src);
+			strbuf_addch(dest, *src =3D=3D 0x7f ? '?' : 0x40 + *src);
 		}
 	}
 }
=2D- snap --

>=20
> > +test_expect_success 'disallow (color) control sequences in sideband' =
'
> > +	write_script .git/color-me-surprised <<-\EOF &&
> > +	printf "error: Have you \\033[31mread\\033[m this?\\n" >&2
> > +	exec "$@"
> > +	EOF
> > +	test_config_global uploadPack.packObjectshook ./color-me-surprised &=
&
> > +	test_commit need-at-least-one-commit &&
> > +	git clone --no-local . throw-away 2>stderr &&
> > +	test_decode_color <stderr >decoded &&
> > +	test_grep ! RED decoded
>=20
> I'd be happier if we used test_cmp() here so that we check that the sani=
tized
> version matches what we expect and the test does not pass if there a typ=
o in
> the script above stops it from writing the SGR code for red.

I often debug test failures in Git's test suite and one of the most
annoying category of test failures is when test cases expect byte-wise
exact Git output that changed for totally legitimate reasons [*1*].

Even worse: In many of those instances, the _intent_ of the check is not
even clear from that `test_cmp` and has to be reconstructed, a boring,
tedious task with little benefit to show for the effort.

I much prefer tests like this one, where a precise `test_grep` states
exactly what it expects to be present, or missing. The intent of such a
command is much clearer than that of `test_cmp expect actual`.

So, much as I appreciate your suggestion, I would prefer to keep the code
as-is.

Ciao,
Johannes

Footnote *1*: This really is not hypothetical. I had to battle quite a bit
with unstable compression sizes that are part of a `test_cmp` comparison,
https://github.com/git-for-windows/git/pull/5926#issuecomment-3486556940
shows a bit of the problems but is very shy about providing the specific
number of days I spent on addressing this issue. In hindsight, I should
have spent at most two hours on converting that from a byte-wise
comparison to a qualitative comparison.
