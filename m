Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F93C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 07:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiKVHkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 02:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKVHkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 02:40:16 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75032167EC
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 23:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669102809; bh=MowgO6YTOvoxlkzM1QfewvaLdz1VzVl1D7WwY8cqSqI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hiynsrjrSrtdZg4CsjxbYWian48QqAIBOEEXhY/SACoBycdepbqwpO1WPJPar38d5
         2SOz3y39/p359ZAVXu9qgaoMurvQep7qVs1PqSEkny7Wi7Tm8ObR9KlBTYoYoXWTOO
         Sxru+JeFHAplrQPvoUYdcW/Fzb1+iyAdgRTlCg8DicVq0ds9oR0atf3JQ9DimDJb24
         BkbBu/Hs7PRAsUhyOVLPRcedII86mZ4eczHyViVdU46k7L+hxJWXQw/5vUHqZbNyLh
         COBVSpkt2n7PTJc6J+UtUVLbqR2UMsNCV6D85XPhMu969QjglAisOBl5xVbs1/ZgOO
         S07+0dQ+L9RIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.29.212.27] ([89.1.212.70]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wpt-1p4HjM0EqP-012I4F; Tue, 22
 Nov 2022 08:40:09 +0100
Date:   Tue, 22 Nov 2022 08:40:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2] range-diff: support reading mbox files
In-Reply-To: <8d40f170-650f-800a-02d7-d279186d5883@dunelm.org.uk>
Message-ID: <rr7sp534-43o9-7n1o-5700-369n5rprq75p@tzk.qr>
References: <pull.1420.git.1668536405563.gitgitgadget@gmail.com> <pull.1420.v2.git.1668899471058.gitgitgadget@gmail.com> <8d40f170-650f-800a-02d7-d279186d5883@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1880953189-1669102809=:189"
X-Provags-ID: V03:K1:J5NTll7T/UOi8I3srIxSu46cpBVFiytZMbu+vhxxGNUDyJJXWjg
 WGUso1C1fw6Q5o7UUGCJf5SKrM01p+WI6FNv7NoEKd/dHb/nG3nFWqRJ2xpo5K+CIXJO8pX
 Dcr7OpFEwatdU/tJ4UibO+CoxCRLrgDWF5lfK1x+4KGoL7LahL9jjDdiOVKaW23gob3l7N+
 yzenzXvixrvc4ccrpdnJA==
UI-OutboundReport: notjunk:1;M01:P0:Yg567kOpEow=;qgsW+j+djwiBs6o2+lV+fp0wC3b
 KPAcBdfFQ1Q7niCWmMfwppZxgXgR0o2Ct6GBZcblA+NhnpuXmwhRXTsq+JmjNZ2wk+HHAbs0N
 L9Ax/fkjbRKMvl/7TZyKyaCKL1ctOA6PU29d0jOgs4RnUAzrh0Epd4l9JFRqw8MaNAFaTeiI2
 VMeHCt6GY8WgtdKVHfmhTW08K5Ney0UrdDJcWmiiB2gGUDnddrQSX5C2GKrPL5NPUhGKqDYdU
 23e1EDriNfCqtwFQPGjlHY08kZAOBBdzH3xRvBrfPmFfWD6IPKnCWFFVahxSUNrUp/p78xlGZ
 mvPeyaQ861yrkaOlldFqlpIWRHyfEEaSp2hKaEm/1LXZeGUbbVRScHQ2q2BAUPMe+kp4SC3ou
 nmikDiot71hiMbdwnB19yvdoNBW7jpfiTkna7TU8rZDVZpV1XqG6KWv6InsISPDDKjYm6R0xn
 fW3k+isz6AHQ4ZdjGyu44Wh6aIakrwZZKFXaRVE10BM9HwqRDwGz1SHD+pvQthjzAElowMcsL
 vqaFe9Puwark1QAs6kjhDoMou50I0Ee9m5s3aHnkSufDpQf1hFQzU8LdWUbSSVLaOvLCiPw6f
 m3sCErb2Vje7aiztFnOAYtjhSHi0msbs41EPdRJJ1Z+TSPACekDvvoS1bYsER/4tkH3Tvu7Yr
 zQ2M5NNEzg4w35VYUHLZUhfKYkjypmE8SlTConHmhYJ+8Dv4StbSYJyKpi6a8V9KvyZVgsAu8
 uG91l/d96tNZxP0ThP7d5WrAMnQS7aDKXlAZVoZcQp6qrbMLIKcB++CzPVPj0B2Ul9E8DtfXN
 OPHV3ZoTkUb795/EVk9P2tO8jCVXGLZ3sAgcDn+f0IBv0X8pfjN7z8xlBMQle4srN6SK5ax1Y
 FN3ZmA3gwb8RxHL4XrUOeKVaUHiJsVpQuMDJeiwYqimMTbyHwG1k6tqUw5XFtuHWMBQkq4Ela
 yonea/qkGBq0+WN5XsQVIGsF/10=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1880953189-1669102809=:189
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Mon, 21 Nov 2022, Phillip Wood wrote:

> [...]
> >       @@ range-diff.c: struct patch_util {
> >        +
> >        +	line =3D contents.buf;
> >        +	size =3D contents.len;
> >       -+	for (; size > 0; size -=3D len, line +=3D len) {
> >       ++	for (; size; size -=3D len, line +=3D len) {
> >        +		const char *p;
> >        +
> >       -+		len =3D find_eol(line, size);
> >       ++		len =3D find_next_line(line, size);
> >       +
> >       -+		if (state =3D=3D MBOX_BEFORE_HEADER) {
> >       ++		if (state =3D=3D MBOX_BEFORE_HEADER ||
> >       ++		    (state =3D=3D MBOX_IN_DIFF && line[0] =3D=3D 'F')) {
>
> If we see an 'F' when parsing a diff then it is probably a From: line
> indicating that we've reached the start of a new patch. I think we need =
to add
> the diff we've just parsed to the list of commits before continuing and =
change
> state to MBOX_BEFORE_HEADER otherwise we'll hit the continue just below =
this
> comment with state unchanged.

As always, thank you *so* much for modeling how to perform productive,
actionable and *thorough* code reviews that focus on the relevant.

You spotted something important. It is a bug, as you suspected, and there
is even more: `util` leaks because it is allocated both after the patch
was parsed and when we see a diff header, without releasing the first (but
granted, this leak has been there before).

You have no idea how much I appreciate your diligence; I understand how
much of an effort it takes to study patches in depth until you understand
them enough to spot complex issues like this one. (In Parkinson's
parlance: I am grateful that you focus on the design of the nuclear power
plant, see https://en.wikipedia.org/w/index.php?title=3DAtwood%27s_duck)

Back to our regularly scheduled programming (pun intended): I indeed made
a mistake here and fixed it, by removing that 'F' check again, and instead
adding a `goto` label and jumping to that upon encountering the end of the
diff.

I also de-duplicated the `util =3D xcalloc(1, sizeof(*util))` calls so tha=
t
we do that _only_ in the `MBOX_BEFORE_HEADER` arm, and no longer at the
end of the `MBOX_IN_DIFF` arm.

Since I already looked at a leak, I looked further and saw that also
`copy` is leaked in `show_range_diff()` in case of an mbox. I've addressed
that, too.

>
> >        +			if (!skip_prefix(line, "From ", &p))
> >        +				continue;
> >        +
> >       @@ range-diff.c: struct patch_util {
> >        +			author =3D subject =3D NULL;
> >        +
> >        +			state =3D MBOX_IN_HEADER;
> >       ++			continue;
> >        +		}
> >        +
> >        +		if (starts_with(line, "diff --git ")) {
> >       @@ range-diff.c: struct patch_util {
> >        +			strbuf_addch(&buf, '\n');
> >        +			if (!util->diff_offset)
> >        +				util->diff_offset =3D buf.len;
> >       -+			line[len - 1] =3D '\n';
> >       ++
> >       +			orig_len =3D len;
> >       -+			len =3D parse_git_diff_header(&root, &linenr, 1,
> >       line,
> >       -+						    len, size,
> >       &patch);
> >       ++			/* `find_next_line()`'s replaced the LF with a
> >       NUL */
> >       ++			line[len - 1] =3D '\n';
> >       ++			len =3D len > 1 && line[len - 2] =3D=3D '\r' ?
> >       ++				error(_("cannot handle diff headers
> >       with "
> >       ++					"CR/LF line endings")) :
> >       ++				parse_git_diff_header(&root, &linenr,
> >       1, line,
> >       ++						      len, size,
> >       &patch);
> >        +			if (len < 0) {
> >        +				error(_("could not parse git header
> >        '%.*s'"),
> >        +				      orig_len, line);
> >       ++				release_patch(&patch);
>
> Thank you for using release_patch() rather than the "free random struct
> members" approach that was suggested.

Indeed, it sounded like a specific suggestion to release a specific
`struct` member, but that was of course not the end of the story, and I
completed the analysis myself that I had wished the reviewer would have
completed _before_ sending off a review.

> >       @@ t/t3206-range-diff.sh: test_expect_success 'ranges with paths=
pecs'
> >       '
> >        +test_expect_success 'compare range vs mbox' '
> >        +	git format-patch --stdout topic..mode-only-change >mbox &&
> >        +	git range-diff topic...mode-only-change >expect &&
> >       ++
> >        +	git range-diff mode-only-change..topic mbox:./mbox >actual &&
> >        +	test_cmp expect actual &&
> >       -+	git range-diff mode-only-change..topic mbox:- <mbox >actual &=
&
> >       -+	test_cmp expect actual
> >       ++
>
> I'm a bit confused by this sed command, I've annotated it with my probab=
ly
> flawed understanding.
>
> >       ++	sed -e "/^From: .*/{
> >       ++		h
>
> This stores the From: header in the hold space

=F0=9F=91=8D

> >       ++		s/.*/From: Bugs Bunny <bugs@bun.ny>/
>
> This changes the From: header in the pattern space

=F0=9F=91=8D

> >       ++		:1
> >       ++		N
> >       ++		/[ -z]$/b1
>
> We loop until we find a line that does not end with a space, letter or n=
umber
> adding the lines to the hold space

I would have _loved_ to match on an empty line, i.e. `/[^\n]$/b1`. But
that construct is not understood by the `sed` on macOS.

I even went so far as to search for the source code of a BSD `sed` (and I
found it, and modified the code so that it builds on Linux, see
https://github.com/dscho/sed-bsd) to try a couple of things, but could not
make it work with any variation of `\n`. Therefore, I settled on expecting
all the lines in the commit header to end in printable ASCII characters
between the space and the `z`.

> >       ++		G
>
> This appends the hold space to the pattern space, then the pattern space=
 is
> printed.

=F0=9F=91=8D

> Doesn't this mean we end up with two From: headers? Is the in-body From:
> line already present?

There is no in-body `From:` header because the patch author matches the
`GIT_AUTHOR_IDENT` that is in effect while running the `format-patch`
command.

Let me show you what this `sed` call deals with. In the local test run, it
modified an `mbox` starting with this:

	From 4d39cb329d3ef4c8e69b43859c2e11adb83f8613 Mon Sep 17 00:00:00 2001
	From: Thomas Rast <trast@inf.ethz.ch>
	Date: Mon, 22 Jul 2013 11:23:44 +0200
	Subject: [PATCH 1/3] s/4/A/ + add other-file

	---
	  file       | 2 +-
	  other-file | 0
	  [...]

to a modified `mbox` that starts with this:

	From 4d39cb329d3ef4c8e69b43859c2e11adb83f8613 Mon Sep 17 00:00:00 2001
	From: Bugs Bunny <bugs@bun.ny>
	Date: Mon, 22 Jul 2013 11:23:44 +0200
	Subject: [PATCH 1/3] s/4/A/ + add other-file

	From: Thomas Rast <trast@inf.ethz.ch>
	---
	  file       | 2 +-
	  other-file | 0
	  [...]

>
> >       ++	}" <mbox >mbox.from &&
> >       ++	git range-diff mode-only-change..topic mbox:./mbox.from
> >       >actual.from &&
> >       ++	test_cmp expect actual.from &&
> >       ++
> >       ++	append_cr <mbox >mbox.cr &&
> >       ++	test_must_fail git range-diff \
> >       ++		mode-only-change..topic mbox:./mbox.cr 2>err &&
> >       ++	grep CR/LF err &&
>
> Thanks for adding that

Thank you for the suggestion to add it!

And thank you again for modeling how to perform actionable, helpful and
productive code reviews,
Dscho

--8323328-1880953189-1669102809=:189--
