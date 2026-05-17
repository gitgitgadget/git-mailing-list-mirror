Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9008732C94A
	for <git@vger.kernel.org>; Sun, 17 May 2026 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779017691; cv=none; b=s+MxQq3jrISRTh/yD57m/bl43Li2GGoMn007f52BXbqJyr+Xer2VzySgZ593R1ZmL22DX9+xio9EuaEBXAiHdpZCyATHxodlUmx//WnZBtI62KHjupGHi0cHWO1zpLheXKS1aOQIwkfjgUsb6qYlyQr2+JskIbJ++ugioV3z4dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779017691; c=relaxed/simple;
	bh=g0/bQZipSK0egsP8ARCGxcVFc29LlRHOcoRMN2avvYc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J6y9IvI0vX4UzqV1RK0kc5ANfeQ/z3+EOvYLhCQs1YtrDvNBNe1+LNFFCIABOb9oFS6IDrUgMQx+fW7n7dw6QS+qNi1l8ImILiEKSHrKpIUtkQOl/2fFUA9bnsQa8oV8uzEQDOA0VrrSL6p/GCC68bDC6b+IkDuaTpJ2lID3mR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=nWnfHU/g; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="nWnfHU/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779017604; x=1779622404;
	i=johannes.schindelin@gmx.de;
	bh=CICo8VSmLl7uJ9WKQA+6ZjxQ6Tkle7BGzKb5XVgyc9Y=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nWnfHU/getpL+EcNEnwkNUTAjt12+iij3maJTS6erM+sWvoAqkS89T8p0Uebyg3J
	 L/xLLE7Dj6tXw9O9WYYZuDc5dVzRoa2hzTyArQeP+PYpGV0/gcb57GbiLxB0vpemt
	 6StGQOe3qSDH2LtznG7m7lAGbV3ZCxX3hHgUI29agr9GC2v4hEgMkTBNcrGmET/tE
	 3skqpaWZVoL7fVWZLiZrTldRwggY3v8PGc68vaBPHz8i0Fh5dA6tW3XpHkZArwhGo
	 tNoNE0+03ONgCtY+CImaUKih1X17Oejjssk7I6OehURLp8/QWx9QiYOeUOqDC6SmU
	 +d5ebmrLfSc2bBSXBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmULr-1x67m92MUL-00nva9; Sun, 17
 May 2026 13:33:24 +0200
Date: Sun, 17 May 2026 13:33:22 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ben Knoble <ben.knoble@gmail.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
    Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH/RFC 0/5] replay: support replaying 2-parent merges
In-Reply-To: <21A507D3-1B0D-4404-8AF5-9485B01E63A6@gmail.com>
Message-ID: <c594ed5c-5c81-c6b7-c660-11b2ce1bb3b5@gmx.de>
References: <4a94c675-661c-1f2a-27d0-3f10f761cf6a@gmx.de> <21A507D3-1B0D-4404-8AF5-9485B01E63A6@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1248973449-1779017604=:100"
X-Provags-ID: V03:K1:yIeU6begY0vC6orbgJjgvvuVs7dx6v/3yHsutmqJWyxIXM+wenW
 GEK4U2CusFRPxKRan14DD4CVWweleKiFhaQ6ATIvzsHD1ToSA8QaL09+GmKjcexp2S+IY5U
 a3aRpbGBedOQy/pLm+eGHUPkbXCUBn40RBSpqnCLBYuZmK6/FFygDbxXQjc/ZRE4OJSU2cK
 ukIwy9nL8rkoECOV3Slxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PNfUAdDCe5w=;JPSyW43E0EpGg/PrfTnMzmInFOc
 +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
 NYclL/GQYG2Q1zVpCAebRy/6jmw=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1248973449-1779017604=:100
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Thu, 7 May 2026, Ben Knoble wrote:

> > Le 7 mai 2026 =C3=A0 11:06, Johannes Schindelin <johannes.schindelin@g=
mx.de> a =C3=A9crit :
> >=20
> >> On Thu, 7 May 2026, D. Ben Knoble wrote:
> >>=20
> >>> On Wed, May 6, 2026 at 6:44=E2=80=AFPM Johannes Schindelin via GitGi=
tGadget
> >>> <gitgitgadget@gmail.com> wrote:
> >>>=20
> >>> [...]
> >>>=20
> >>> While I was at it, git history reword had a pre-existing
> >>> silent-success bug: a positive return from replay_revisions() (which
> >>> means "conflict, no updates queued") was treated as success. Obvious=
ly
> >>> this should never occur, as a reword simply does not change any of t=
he
> >>> file contents, but bugs do happen. The merge-replay work is complex
> >>> enough to make that class of bugs more likely, therefore I introduce
> >>> error messages for those instances.
> >>=20
> >> Fixing this bug sounded interesting; I had a hard time spotting it
> >> while skimming the first 2 patches.
> >=20
> > It's this part:
> >=20
> > @@ -482,6 +482,9 @@ static int cmd_history_reword(int argc,
> >    if (ret < 0) {
> >        ret =3D error(_("failed replaying descendants"));
> >        goto out;
> > +    } else if (ret) {
> > +        ret =3D error(_("conflict during replay; some descendants wer=
e not rewritten"));
> > +        goto out;
> >    }
> >=20
> >    ret =3D 0;
> > @@ -721,6 +724,9 @@ static int cmd_history_split(int argc,
> >    if (ret < 0) {
> >        ret =3D error(_("failed replaying descendants"));
> >        goto out;
> > +    } else if (ret) {
> > +        ret =3D error(_("conflict during replay; some descendants wer=
e not rewritten"));
> > +        goto out;
> >    }
> >=20
> >    ret =3D 0;
>=20
> Thanks, super helpful.
>=20
> (Perhaps later) if we can say _which_ descendants weren=E2=80=99t rewrit=
ten, that might be good.

I am afraid that that particular information is lost at this point, all we
have to work with is an `int ret`.

Ciao,
Johannes

> >> Did I just miss it? Is it worth splitting that fix out to a separate =
patch?
> >=20
> > Well, you _could_ argue that they were not bugs at all: a `git history
> > reword` isn't supposed to be able to result in merge conflicts, nor is
> > `git history split` because they leave the respective commits tree-sam=
e
> > (in the `split` case, the second commit).
>=20
> I seem to recall Patrick making a similar argument, but don=E2=80=99t le=
t me put
> words in anyone=E2=80=99s mouth.=20
>=20
> > I could see the point were anybody to suggest using `BUG()` instead of
> > `error()` here, but erred on the "nicer to the user" side.
> >=20
> > The only way this _might_ be triggered before this patch series is mos=
t
> > likely by playing games with replace objects. Or maybe you cannot trig=
ger
> > it at all.
> >=20
> > With the changes in this here patch series, I wasn't so certain that I=
 had
> > covered all the edge cases (an early iteration of the quick short-cut =
in
> > patch 2/5 keyed only on the parent commits' trees, and forgot to verif=
y
> > the merge _bases_' trees, for example). That's why I think it matters =
more
> > now than it did before.
> >=20
> > Ciao,
> > Johannes
>=20
> Makes sense, thanks.

--8323328-1248973449-1779017604=:100--
