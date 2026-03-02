Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D62836DA11
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454915; cv=none; b=b8sd1CgsEiQf556I8enLLoZx0sTdOiAqsOYkPvQ4DluOlGvoi+jMEN3pSpvrxTAupA8tpr3YiQCz0/sboxU2YPjBiIMWBygFkXvBM05Fzk6X9c/+DOYxbTaDW8WpbHWsZGyH3yv/akaUdeMiD52b7HbdgaqcEG6yGvyG6HE7LyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454915; c=relaxed/simple;
	bh=ABp7F6wW/pMFp0FjxNo3m5jc3oLwpSh4tao+YQRcOng=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AReoBOnPantAraUJVBMoQvXjN4NjSj5wTWH6EUhVIfFhh5DPqwWdgUtIzeSyFdY18R5iYB4BdARAksxlJww1bXUTb48uqENYS48PJOcIy/7agU8I1zWH1vmJazyCLzrfjxZXInitquB1q/KtPICP6HhJ/91/YULTROmFNSWwie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=AudUF5xA; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="AudUF5xA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772454905; x=1773059705;
	i=johannes.schindelin@gmx.de;
	bh=exr6fCmhjZR6x++UdrcCGcF1ZZ6fM5UPoEIlu8nUF/8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AudUF5xAXX9N8ZTCZEZGl5I1DmzirVOxiqURYqbBPJm8N1DveJsJJsr9NK1QPgIe
	 IfMRMQpfo0byXf1frt8V8fmBQ1WafJVdFMQGr2lXnnsPLU8UtYEon6OxipWeH+/65
	 0QLEItnOxUFsYesvt1wblpWI1X0b5v1sCTeXL/iBpJVRpoCU52BWCwtZV5stBLWOh
	 a1E3SwjXUH//52wBvk0yCXZABXEDUW3ltTONu4Sw0b3llfJwxu8CsO3KubvUAK3GB
	 i57t7wP6itxCwgrfzC1Tf4Rt/HsF61CEg/1FrATW0vvC6XwFkbK5uoCqp8t7x0hqc
	 BCeSCCMzb5MO03zatw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYc0-1vGbBf0EpS-00ZKpA; Mon, 02
 Mar 2026 13:35:05 +0100
Date: Mon, 2 Mar 2026 13:35:03 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Junio C Hamano <gitster@pobox.com>, 
    "Daniel D. Beck via GitGitGadget" <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, 
    "Daniel D. Beck" <daniel@ddbeck.com>
Subject: Re: [PATCH] doc: fetch: document `--jobs=0` behavior
In-Reply-To: <aZggm7R-4VohiCYm@pks.im>
Message-ID: <25715312-b6a0-0cdd-d62c-3a4a840b0244@gmx.de>
References: <pull.2047.git.1771443159369.gitgitgadget@gmail.com> <aZb2acEvAtNmt-4j@pks.im> <xmqq4inc5zlt.fsf@gitster.g> <aZggm7R-4VohiCYm@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ec55EBfugiqO+u0xmfrY0asciiGwM4F0TAogo91azKZeMYX/3Ag
 4vJpyqJMzpOaVgjH9NubKyzKucxz/wYn8JDIN7mePl9+B2ocNdhbsRqbCvovjZSTZ1De3HH
 eFD/3Nk0cXNoEnWcMmaqZjEwLgnqzPGoiNO/bHnxqDdFSzCCakJp8MVEAaeY/rQpIYokQGL
 TQip3wwPau65CSZF6tKxQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Cm5UK0hmL+c=;Zlio7d1839PrdWsC3F+4lisw4H7
 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
 yXi8MnqrGtLx5BvzDOQLWYANDBSQl
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Fri, 20 Feb 2026, Patrick Steinhardt wrote:

> On Thu, Feb 19, 2026 at 10:59:10AM -0800, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >=20
> > > On Wed, Feb 18, 2026 at 07:32:39PM +0000, Daniel D. Beck via GitGitG=
adget wrote:
> > >> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch=
-options.adoc
> > >> index fcba46ee9e..e15cbc51f2 100644
> > >> --- a/Documentation/fetch-options.adoc
> > >> +++ b/Documentation/fetch-options.adoc
> > >> @@ -234,6 +234,8 @@ endif::git-pull[]
> > >>  `--jobs=3D<n>`::
> > >>  	Parallelize all forms of fetching up to _<n>_ jobs at a time.
> > >>  +
> > >> +A value of 0 will use some reasonable default.
> > >
> > > Can't we do better though than saying "some reasonable default"? As =
a
> > > user I would wonder what this is even supposed to mean. True, we don=
't
> > > do so either in the documentation of "fetch.parallel". But arguably,=
 we
> > > should update both sites to reflect the status quo.
> > >
> > > Going into the code we seem to fall back to `online_cpus()`. So shou=
ld
> > > we document this accordingly?
> >=20
> > I do not have time to dig this out myself from ancient discussion
> > threads, but we probably had the same discussion when "git config
> > --help" described the fetch.parallel with exactly the same phrasing
> > and decided to leave the exact implementation detail out of the
> > end-user facing documentation.
>=20
> Doesn't look like it. The thread in question is [1], and neither the
> commit message nor the discussion around the patch mentioned why we
> don't document what the reasonable default is.

Thank you for digging deeper. There was indeed no discussion about this in
https://lore.kernel.org/git/pull.369.git.gitgitgadget@gmail.com/t/#u.

There was no discussion about that, either, in response to the What's
Cooking email talking about the preceding pd/fetch-jobs branch:
https://lore.kernel.org/git/mhng-2c9b8fd0-22e7-4679-9d9b-f8128881fada@palm=
er-si-x1e/t/#mb58c71041bd41456ba0135437952ae15760e6724

Nor was there any discussion about the "reasonable default" in thr
original `pd/fetch-jobs` contribution:
https://lore.kernel.org/git/mhng-0d288d1c-02fc-4280-bd8f-b7f611af3e8a@palm=
er-si-x1c4/t/#u

> Dscho, do you remember by chance why you decided to not be more specific
> here?

Unfortunately not.

So I went on reconstructing the lay of the land back when d54dea77dba
(fetch: let --jobs=3D<n> parallelize --multiple, too, 2019-10-05) landed.
With that commit, the `max_children` variable (which `--jobs=3D0` would se=
t
to 0) would be passed via `fetch_multiple()` [*1*] or
`fetch_populated_submodules()` [*2*] to `run_processes_parallel_tr2()`,
which would pass it through to `run_processes_parallel()` as the first
parameter (called `n`) [*3*]. That function would pass that variable to
`pp_init()` first thing [*4*], which would fall back to `online_cpus()` if
it saw a value smaller than 1 [*5*].

So: The "reasonable default" is the number of CPUs, or more correctly, of
CPU cores. It does seem, though, that that was considered common knowledge
at the time, given e.g. v2.40.0's release notes saying [*6*]:

  "git fetch --jobs=3D0" used to hit a BUG(), which has been corrected
  to use the available CPUs.

Ciao,
Johannes

>=20
> Thanks!
>=20
> Patrick
>=20
> [1]: <pull.369.git.gitgitgadget@gmail.com>
>=20

Footnote *1*:
https://gitlab.com/git-scm/git/-/blob/d54dea77dba081770fec7707110d8480ccaf=
9439/builtin/fetch.c#L1783

Footnote *2*:
https://gitlab.com/git-scm/git/-/blob/d54dea77dba081770fec7707110d8480ccaf=
9439/builtin/fetch.c#L1796

Footnote *3*:
https://gitlab.com/git-scm/git/-/blob/d54dea77dba081770fec7707110d8480ccaf=
9439/run-command.c#L1860

Footnote *4*:
https://gitlab.com/git-scm/git/-/blob/d54dea77dba081770fec7707110d8480ccaf=
9439/run-command.c#L1819

Footnote *5*:
https://gitlab.com/git-scm/git/-/blob/d54dea77dba081770fec7707110d8480ccaf=
9439/run-command.c#L1611-1612

Footnote *6*:
https://gitlab.com/git-scm/git/-/blob/v2.40.0/Documentation/RelNotes/2.40.=
0.txt#L57-58
