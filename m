Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCD718622
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711295269; cv=none; b=aHUnEWTOhGANorEvAqmynjbsIPTToXEInA8VtR6kWTCRNo+cYdvOsNL51IA6BfL01y7R7cYoxHLxDiOGDZ3cbV1zs/AyacLeG4o6k6Ejl/OzFOLagb7TkTerLzro2etjDwh/NnyUFvIdvkqHEy0EoQWkZWGocE71CZwRF/FwjGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711295269; c=relaxed/simple;
	bh=VRgTxKOpc/pK/4pzrUyUXtPiM9qfnDlxiADQhh1ruZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5j85u2pzxshlyjUtpdhrefwLgxAYh7AsHQN+9TQ5o2tk/z9gEpclcDTJgAp63KAISRQJlyqC9RJh4pnK8dx6H6akvE/pv9gWaUKkwal2EBxIqGuhriqdnPL7HAZ7iU5e675pfVuAfLV6p05cmYyzyzaNIgxVg3ZEfDxPRdl0to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 13643DF9A1F
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 16:41:11 +0100 (CET)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:c155:9cef:5d9c:8b9d])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id EC9CEB0055A;
	Sun, 24 Mar 2024 16:41:00 +0100 (CET)
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <avila.jn@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] doc/gitremote-helpers: fix more missing single-quotes
Date: Sun, 24 Mar 2024 16:41:00 +0100
Message-ID: <1812061.VLH7GnMWUR@cayenne>
In-Reply-To: <xmqqmsqov0at.fsf@gitster.g>
References:
 <20240320091748.GA2444639@coredump.intra.peff.net>
 <22254967.EfDdHjke4D@cayenne> <xmqqmsqov0at.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Le dimanche 24 mars 2024, 03:19:38 CET Junio C Hamano a =E9crit :
> Jean-No=EBl AVILA <avila.jn@gmail.com> writes:
>=20
> >> Hmmmm, here, true and false are to be given verbatim.
> >
> > In such case, it's (`true`|`false`) . As well as the command before.
>=20
> Yes, they should be given like so, I think.
>=20
> >> I know we added the _<placeholder>_ thing, but have we added these
> >> to Documentation/CodingGuidelines yet?
> >>=20
> >> Thanks.
> >
> > No, we haven't.=20
> >
> > I skimmed over different documentation projects and there's no real=20
consensus=20
> > on what the formatting should be in detail, except for some common rule=
s.
> > man-pages(7) gives some good hints that we should adhere to, which are=
=20
echoed=20
> > in the guide of asciidoc: https://docs.asciidoctor.org/asciidoctor/late=
st/
> > manpage-backend/ . Basically, verbatim are in bold, and variables are i=
n=20
> > italic.
> >
> > In our man pages, the asciidoc verbatim are rendered as bold and asciid=
oc=20
> > emphasis are rendered as underlined, just like italics,  which adheres =
to=20
the=20
> > principles,
>=20
> What I meant by "verbatim" was "what the user would give Git
> verbatim", which are marked up as `true` (or `false`), and typically
> typeset in monospace in HTML.  I just checked the prerendered man
> pages, and indeed \fB...\fR surrounds verbatim phrases, which was a
> bit surprising to me.
>=20

In asciidoc legacy mode, the "verbatim" is two-sided : tell asciidoc to not=
=20
interpret the content (in modern mode, this is no longer true) but also for=
mat=20
the snippet in a way to indicate to the reader that this is a constant part=
 of=20
the syntax.

On this formatting surprise, the current behavior, verbatim as bold, is=20
inherited from xmlto's special option manpage-bolt-literal.xsl of processin=
g=20
docbook and differs from asciidoctor's direct conversion which formats the=
=20
verbatim as monospace in the roff output.
When converting the roff file to ps or pdf, the format difference stands ou=
t and=20
some form of markup is preserved, but in the console, monospace is lost.=20

So, with our current setup, if we shift to pure asciidoctor for compiling t=
he=20
docs, without further postprocessing, we may end up loosing in part this=20
useful formatting for console manpages, something I had overlooked. If we k=
eep=20
using the docbook format as a pivot format, then we're safe.

Side Note : for man pages that are translated, pure asciidoctor is currentl=
y=20
used and this special conversion is not applied.

> > Note that bold/verbatim are usually also used in terms of description=20
lists.
> >
> > I'm totally ok to change the CodingGuidelines and reroll git-clone and=
=20
git-
> > init with these new rules.
>=20
> So to go back to the original example, what do we want to do instead
> of ...
>=20
>     'option deepen-relative' {'true'|'false'}::
>=20
> ... this?  Like this ...
>=20
>     `option deepen-relative` (`true`|`false`)::
>=20
> ... or something else?

With our currrent guidelines, this latest markup is the right one.

I will change the CodingGuidelines in another patch series to add more=20
litteral formats in the synopsis and in the terms of description lists, so =
as=20
to converge toward the generally accepted format of manpages.





