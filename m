Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23571AD9EE
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731355628; cv=none; b=Jeier8b7gu2J/GvSnUBx6X6jH0O1teNG7RQVhPqno24YS/ymzC4ZN3cs5pfhQ5Ca8cC8aOr6r2onFS4ws5jqKxPDookIcmn0Hhh0fgA7qn9LQoKtb8oVLjrPGtf+HCQjv2QbsCdnlwyaXXEHDnsPgpTBwngpzEU5qH+yvpMvv/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731355628; c=relaxed/simple;
	bh=yLPsyvwngsuV218Xki5wu0l3OmoNRpZp87FNFDiM0oE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AqLqfAvDAzI7gQ1rzgRIM6/sCQm9RMCNuvGdvbWJGzRIqEbWR0EybtTyAEVzaaIwa8cq8oIezwV4IouddNq1IFrruCh9EPN1r7m8zYJIWANsSUBVknZq8aBwNKEzSV+pgbukT8AOFi6+QC/5vzz1obzTJz6CU7Dhko9wOP+r+ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ajbuF74i; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ajbuF74i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731355622; x=1731960422;
	i=johannes.schindelin@gmx.de;
	bh=X9qzQSLQxCG61HN5KVNxunvHqdEkNBCiZhAlv4iOU4k=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ajbuF74i3NbWQsP8X+bY889fB2Jw35MfCaFEJ0ioif1ADB8hd0ap4IaOsQVt25GO
	 fb4fWUbwKRD8HdnyLOxv+41DXDmbMJnxbSroW6AbDDJzbEIkkL0Wa8Vc+ZKdsnbxc
	 IYA+Z9bvnjl6/d30Cubs8y2IToBtBomzrHQTvYIK0d3Vz1TPV2DMC11sUEsBgMquN
	 ECgc6QMhfqmJ3dsFvdoieNDEgoUFcj1SsX3T5r+klB6DyIsaQSwj+Js9m+c9Z9HwS
	 c9Vx+EWbWhO3VxY9Kw2aIbqT5K5HsM2gEOvrIdBWlsrKJI3ZpwJlpkmHJJWezhqqc
	 n/YlYYYGy+ZsteQ+Uw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.65]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel81-1tlIsl3ZP3-00cdsm; Mon, 11
 Nov 2024 21:07:02 +0100
Date: Mon, 11 Nov 2024 21:07:02 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Philippe Blain <levraiphilippeblain@gmail.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>, 
    Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] range-diff: optionally include merge commits' diffs
 in the analysis
In-Reply-To: <444e4a94-0005-bed6-1092-20770c226109@gmail.com>
Message-ID: <eb502feb-1563-b1b5-5345-784673c89c79@gmx.de>
References: <pull.1734.git.1731000007391.gitgitgadget@gmail.com> <pull.1734.v2.git.1731073383564.gitgitgadget@gmail.com> <444e4a94-0005-bed6-1092-20770c226109@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1982269919-1731355622=:108"
X-Provags-ID: V03:K1:Cv8eDn98+Kj/rghH1jHcuEH+U1yjI859LNzelaANQ7O1BSm5HWu
 WzaLbgrfiiCT2ekRlUSX5mYo7np5Cx/lwfILvkR5REAadC/U0fWcx8sumkR49Vdv9tgpvlJ
 YKPcSzxviNDpp4UbhOka23mawtnnWArJg/0/lxK5jPLuObIpSghPAe6zE0RD8VYoOFEq5x6
 5ixYGtCKHNOKSmJDJua/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+wdNSn2m/00=;hZTJcvFQA0LMT9XvW32PBfZsHMn
 8uO5IagGjo8w+INAxUH2IKQXc+DEkQOOb0pnEr4vOj7Q0ATd5DAxxedmYXDfvD2PsHqkeNmqz
 F0y0fpwf9FzokgcwktYRSw5RCe1DOyxgAyp5huzXpZa5PCjt4OZE3S0hJrKHS2qpc2Zm7MEy9
 VaNRJ9JXy5kHSlWq0hJrE9yQAMSTJ/b/hIG5m7DMOnQ+sOsuJr1SX9JXs6+A1UqzdiCGL6Gho
 DQj4/pp6gui9jrZScGJlGp1I+tUr1V1YdaT+wpDuTk2xntcU9wox7HgfivuFhF7Ch/0t937mu
 bv1Onh7bU+aSy7cv4Jbg1f2GsNMK4sQz7E9v/3sAUBmI2MD6fOOc3ftvcgf+sbMmMSCrGsUiJ
 GOQVO7hW9+vlHvxQuKLsoP8Jy4qt2CbSIn1HEcxBZF1/mcgyJdGCty0+CGKxwY0J4W6dK9Y3i
 MvEY4SUJbeDo8MhyPhUcPyLartBASwC+yznBEdEMZmL75QkMnB9NZFQpkXdGSVLetlDe5o/UN
 +qj6v9zTwhOQfJEnndmTuNe8D6X7eqS44elXg5yYOjUl9YhaNTT9Nm1/brJaVl/8AAaLxdlgl
 Nz/AOoUdoIGw2J5lc0/ZyxWDejOdx2fTR8NjqW9a5vd2Ze6NHNvznOf8DbAfMuC+heOGSVacx
 D8PvFBb/9G8WP9zi6AkgEZVE9VhSyGmxbMSxwSnR0yZDwDtrLhbu+ZgWTNyjgJdOYiyFdu9OR
 0xuNni3w4mNjG9kuYzZEGcXIuh2oqEo5sNBohNcA9PLKWb4oUb409gy5LuxX1CEtu475cUiv2
 yIfPRMe+cDVGs6ByrgEO04grMcaMJhw7qJZ1wlffjWD6Pc9b0YlwDqGz3OcNWlleIhIuQt+EP
 bpAyf8y68YnLMUSfDnPOscVvQqGfHR6IONErl+nUrTenhFXVT6m/VaWcl

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1982269919-1731355622=:108
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Sun, 10 Nov 2024, Philippe Blain wrote:

> Le 2024-11-08 =C3=A0 08:43, Johannes Schindelin via GitGitGadget a =C3=
=A9crit=C2=A0:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The `git log` command already offers support for including diffs for
> > merges, via the `--diff-merges=3D<format>` option.
> >
> > Let's add corresponding support for `git range-diff`, too. This makes =
it
> > more convenient to spot differences between iterations of non-linear
> > contributions, where so-called "evil merges" are sometimes necessary a=
nd
> > need to be reviewed, too.
>
> Maybe "between commit ranges that include merge commits" would be more
> workflow-agnostic ?

Good idea, this is much clearer than what I wrote, too.

> > diff --git a/Documentation/git-range-diff.txt b/Documentation/git-rang=
e-diff.txt
> > index fbdbe0befeb..17a85957877 100644
> > --- a/Documentation/git-range-diff.txt
> > +++ b/Documentation/git-range-diff.txt
> > @@ -81,6 +81,15 @@ to revert to color all lines according to the outer=
 diff markers
> >  	Suppress commits that are missing from the second specified range
> >  	(or the "right range" when using the `<rev1>...<rev2>` format).
> >
> > +--diff-merges=3D<format>::
> > +	Instead of ignoring merge commits, generate diffs for them using the
> > +	corresponding `--diff-merges=3D<format>` option of linkgit:git-log[1=
],
> > +	and include them in the comparison.
> > ++
> > +Note: In the common case, the `first-parent` mode will be the most na=
tural one
> > +to use, as it is consistent with the idea that a merge is kind of a "=
meta
> > +patch", comprising all the merged commits' patches into a single one.
>
> I think I agree with Elijah that we probably should also highlight at le=
ast
> 'remerge'.
>
> Also, is it worth making this a proper Asciidoc "[NOTE]" ? (I'm not sure=
, there are
> a lot of "Notes:" in our doc that are not Asciidoc "[NOTE]"s.

Right, I did not want to deviate too much from the surrounding style.

Besides, I am not _so_ versed in AsciiDoc, I consider Markdown to be much
more common, so I am much more familiar with that. I had no idea that
there was a proper AsciiDoc [NOTE].

> > diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> > index 1b33ab66a7b..901de5d133d 100644
> > --- a/builtin/range-diff.c
> > +++ b/builtin/range-diff.c
>
> The changes look good to me. Maybe it would be nice to add a correspondi=
ng
> 'range-diff.diffMerges' config option to allow users to configure the
> behaviour more permanently ?

Seeing as there are no existing `rangeDiff.*` options, I am loathe to
introduce the first one lest I am asked why I don't balloon this patch
series into introducing config settings for the other options, too.

Ciao,
Johannes

--8323328-1982269919-1731355622=:108--
