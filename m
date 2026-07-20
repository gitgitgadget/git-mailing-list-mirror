Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CD23CAA3F
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579978; cv=none; b=W/9HgrSCYAqHiSndqy1OojDoARxodDxQRlgf222MODoRjCaPg0yePAs9lmgQEUN6BNz403Lrlv/Kq1ur3oez8vrRirJNuUAJ7vMzjqf3sqcOYRZSCaDcB8LgjEk+wfOIxfEyi58LZrwWcb8Gg6Dj+Ri4Ou6G3OIdGB4mG+lLQWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579978; c=relaxed/simple;
	bh=Y14k3+sZP+Fi1w7XAm3NgJU/5aXUCIo0lUToZ3tXJQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m4Ly45+dS4tRiXkAtR7Z0Btq6JJU0MiIswcsKW1vZUJIbSK1bpQU0UWJQGCIjSRfxINxi2dsDtNtnBFBoWf3uGnHI2v+ZtIV0wxloALABfxPSy4Iyx9/ZDK6w3kBK/of1gR7ymmDP2a/BG6LzAkusYrB/Wh3rHUj+KMod3mnRRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=IWvHchKP; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="IWvHchKP"
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:ca50:7747:ead3:b011])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id CCFDE13F880;
	Mon, 20 Jul 2026 22:39:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1784579972;
	bh=Y14k3+sZP+Fi1w7XAm3NgJU/5aXUCIo0lUToZ3tXJQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IWvHchKPyD0vgWEAvO9g9+KWzTyAQyFO/LsuZyz72MalRa+gdbzpijPHpKjk2fz3y
	 6LbI3QU9MClzrC1B9iwonhznZBewmJoM7r27Asr90ixItQqGgvZxgzoZTsD5MMpkjR
	 fMHi5SKEtWz9bpJCfvkUHQoge19JXTVo7waW2Sc0SV6vYfWERULUxi6t5Vee4C8d3Z
	 tqhVWEJQ/F139O0dJKQA5qAAEUHYsLZLIwET2fgDnAAWXHF3D3ml16tp9Hum3ADSea
	 Fel7FluswjUQvrvQSRdkC7e1oaRhudV11SO/PJgczPYvNLZzxjoPjwNRbqUV60XyWo
	 7JQrcD2QzsOfA==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To:
 =?UTF-8?B?SmVhbi1Ob8OrbA==?= Avila via GitGitGadget <gitgitgadget@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject:
 Re: [PATCH 4/4] doc: convert git-request-pull synopsis and options to new
 style
Date: Mon, 20 Jul 2026 22:39:29 +0200
Message-ID: <23179740.EfDdHjke4D@piment-oiseau>
In-Reply-To: <xmqqfr1eleyx.fsf@gitster.g>
References:
 <pull.2185.git.1784490878.gitgitgadget@gmail.com>
 <5b6e9bd3f3569cf9977d1cfd120a92756ec86b29.1784490878.git.gitgitgadget@gmail.com>
 <xmqqfr1eleyx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, 20 July 2026 01:47:02 CEST Junio C Hamano wrote:
> "Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > @@ -54,11 +54,15 @@ the `v1.0` release, and want it to be integrated in=
to=20
the
> > project.>=20
> >  First you push that change to your public repository for others to
> >=20
> >  see:
> > -	git push https://git.ko.xz/project master
> > +-----
> > +git push https://git.ko.xz/project master
> > +-----
> >=20
> >  Then, you run this command:
> > -	git request-pull v1.0 https://git.ko.xz/project master
> > +------
> > +git request-pull v1.0 https://git.ko.xz/project master
> > +------
> >=20
> >  which will produce a request to the upstream, summarizing the
> >  changes between the `v1.0` release and your `master`, to pull it
> >=20
> > @@ -67,11 +71,15 @@ from your public repository.
> >=20
> >  If you pushed your change to a branch whose name is different from
> >  the one you have locally, e.g.
> >=20
> > -	git push https://git.ko.xz/project master:for-linus
> > +-----
> > +git push https://git.ko.xz/project master:for-linus
> > +-----
> >=20
> >  then you can ask that to be pulled with
> >=20
> > -	git request-pull v1.0 https://git.ko.xz/project master:for-linus
> > +-----
> > +git request-pull v1.0 https://git.ko.xz/project master:for-linus
> > +-----
>=20
> Is there a widely accepted guideline among AsciiDoc users governing
> how many dashes should delimit these blocks, other than "at least
> four, with the opening and closing counts matching"?  If so, what is
> it?  We see five, six, five, and five dashes in the proposed changes
> above, and in '[PATCH 1/4]' we saw nine.  Even if varying counts are
> functionally equivalent, the inconsistency is a bit distracting.
>=20
> Thanks.
>=20
> [Footnote]
>=20
>  * an excerpt from [PATCH 1/4]
>=20
> diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-
send.adoc
> index 538b91afc0..dd1e0a3718 100644
> --- a/Documentation/git-imap-send.adoc
> +++ b/Documentation/git-imap-send.adoc
> @@ -192,7 +192,10 @@ supports only `XOAUTH2` as the mechanism.
>=20
>  Once the commits are ready to be sent, run the following command:
>=20
> -  $ git format-patch --cover-letter -M --stdout origin/master | git imap-
send
> +
> +---------
> +$ git format-patch --cover-letter -M --stdout origin/master | git imap-s=
end
> +---------


"Widely accepted", I do not know. I would better frame it as "because at le=
ast=20
four is needed and I'm lazy, then it's four". I'm not expert enough the=20
asciidoc specification to have a definitive answer of mine, but the=20
asciidoctor specification says exactly four [1]

We could indeed apply the rule of 4 dashes by default.

Note that this only applies because it is a listing block which does not=20
accept nesting.

I will reroll.

[1]: https://docs.asciidoctor.org/asciidoc/latest/verbatim/listing-blocks/
#delimited-listing-block


