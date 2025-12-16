Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E32629B8E5
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765913725; cv=none; b=Eo9SNvKrKKytgWfWSVxyHoyaJrnIE6nGZnTGLyaaNNrMp5hp6KTMKvr1MwutQI8Z0CO5ryynAXRQfDhtS/eJA8vVvXufiUlZ2U5hGK3gJXGKw14ltVqlttWNRKNuTO07mR7m9AHzA5sZweKkr/8sprbM15R3hPJLfh8Kb4mUwI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765913725; c=relaxed/simple;
	bh=HzBT+ENURFC6k7yL65AH0QUMGEcHNroiiCcKm0lKsJw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Lip3WkJJgJ5D4Mx2XDrvUNDFDZezuIK1F011BYqPXwzfWz2TbY+0wWDShvLWVMQiL49IM49RViiObtzfzukMusoscusHY1FBCogUY64etWako8RBSvgCMi+4w23ZCfxw11sDU+X90awGC0xtQakrUgqz+dp0bmMafotDIdQHXjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Wvu/1915; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Wvu/1915"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1765913707; x=1766518507;
	i=johannes.schindelin@gmx.de;
	bh=7SkdVJiEron3OI9j9LkmkRPa9GFR/f+m/GU19S6OVEg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Wvu/1915YATRM5Ggia+Qmvk0KRDo7mnEPYBpfC4ihsGTrjAGE72UP+g+nHxAdLNu
	 iiT49jSgpFe6FITieCAEm5GLl50aKTU9O3ZfQ5Pe5muZ7aH8Ro2hDV0mg/nKS2Hck
	 9Ag9CNF22cwwoeZY4sz08OKTx+5F9c4xazLZoh8+b2PpPywAHrH6qNgPY9Os6l9tp
	 1obBC7opafWN63qRp13nHIgQRMvaiZAKOTYYx+/uZgNnCCXrJnk/m8ZVZec+iaAWR
	 1aXWY7HkntNHJo3TSIeRGE0C1RAIpXRn+GtDR+csZY3GgNYrBXsUHTSy37e9XgN7F
	 V8OMoiHZSASC79wJWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.212]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQMuX-1vIAg73sy9-00WY66; Tue, 16
 Dec 2025 20:35:07 +0100
Date: Tue, 16 Dec 2025 20:35:05 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
    Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 00/10] Prepare Git's test suite for symbolic link
 support on Windows
In-Reply-To: <xmqq345a46b1.fsf@gitster.g>
Message-ID: <af386607-127c-9acd-6d08-89380c1df570@gmx.de>
References: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com> <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com> <xmqq345a46b1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Eln65n++qv7q5lzlcHDCqu1DeuaigsYXS1tpdQB2mMNwxTd0uYl
 geWx/WUzLHP0XGy7KVMQApYOP1/RPEFHqNR0vakqR9gtyzy753G3yUjrNQ1CAEga8I/4mu9
 ur2Z6HXXYKQbt/czAz99qp0Dnp6wXj7nLnv/7/H/TqtcOYSoMVvlBJiMowB9s1DUU2RjdHT
 IUeAJM3G/OuZRPaOVW1YQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1IAbQwxzn34=;Qjx2/7Se5Sn03BDLHGiaK2S+f22
 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
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 16 Dec 2025, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > It has been a minute or three since the time when Windows versions wit=
hout
> > symbolic link support were common, therefore there are plans to turn o=
n that
> > support in the MSYS2 runtime on these Windows versions by default, see
> > https://github.com/msys2/msys2-runtime/pull/114 for more details about=
 this.
> >
> > To prepare for this, I am working toward upstreaming Git for Windows' =
own
> > support for symbolic links. And to prepare for that, in turn, I am her=
eby
> > contributing preemptively the fixes required to eventually let Git's t=
est
> > suite pass when both MSYS2 runtime and Git support symbolic links.
> >
> > As a bonus, this patch series also contains fixes for the Perl tests (=
which
> > were broken for a few years, unnoticed because the CI runs need to sav=
e on
> > runtime and therefore skip the Perl tests because the consume a lot of
> > time).
>=20
> Great to hear a good news.

FWIW this was part of v1 already:
https://lore.kernel.org/git/2d329837e34a88cfe28be728fe24bb5a2c6a9752.17644=
40906.git.gitgitgadget@gmail.com/

>=20
> > Changes since v2:
> >
> >  * Polished commit messages.
> >  *=20

That was just an oversight: GitHub continues enumerations on the next
line.

> > Changes since v1:
> > ...
>=20
> Curious what the second bullet point was ;-)
>=20
> The step [6/10] somehow did not make the list.

Strange. I found a bounce, with this incredibly illuminating message:

	Message rejected. For more information, go to https://support.google.com/=
mail/answer/69585

That's it. That's the entire message. If you can make any sense of this,
I'd be quite interested to learn something new.

> I can reconstruct it

... by fetching from the tag that is mentioned in the cover letter. That's
what Git is really good at, after all, fetching code changes.

> by looking at the range-diff below (i.e., no content changes, just
> removal of bunch of lines from the proposed log message and credit
> for Patrick),

... which suggests that I simply made a rebasing mistake and accidentally
dropped the credit, and did not notice it in the range-diff because I had
been staring at the diffs for too long. That's exactly what happened,
please reuse the version from v2.

Ciao,
Johannes

> but it briefly made me wonder if steps 6-10 from posted version left
> your repository a bit prematurely and they wanted to have a bit more
> work on them, to be described on the empty bullet point (*) line above.
>=20
> In any case, thanks for updates.  I didn't see anything wrong in
> what was shown in the range diff for [01-05/10].  Will replace what
> has been queued.
>=20
> > Range-diff vs v2:
> >
> >   1:  2d329837e3 =3D  1:  2d329837e3 t9700: accommodate for Windows pa=
ths
> >   2:  b97afa9a5c =3D  2:  b97afa9a5c apply: symbolic links lack a "tru=
stable executable bit"
> >   3:  96e279f50e !  3:  f42a2f14bc mingw: special-case `open(symlink, =
O_CREAT | O_EXCL)`
> >      @@ Commit message
> >           non-existent file and create it when given above-mentioned f=
lags.
> >      =20
> >           Git expects the `open()` call to fail, though. So let's add =
yet another
> >      -    work-around to pretend that Windows behaves like Linux.
> >      +    work-around to pretend that Windows behaves according to POS=
IX, see:
> >      +    https://pubs.opengroup.org/onlinepubs/007904875/functions/op=
en.html#:~:text=3DIf%20O_CREAT%20and%20O_EXCL%20are,set%2C%20the%20result%=
20is%20undefined.
> >      =20
> >           This is required to let t4115.8(--reject removes .rej symlin=
k if it
> >           exists) pass on Windows when enabling the MSYS2 runtime's sy=
mbolic link
> >   4:  9639e04ac6 =3D  4:  70237394c6 t0001: handle `diff --no-index` g=
racefully
> >   5:  3db0599d91 !  5:  0d371ee552 t0301: another fix for Windows comp=
atibility
> >      @@ Commit message
> >      =20
> >           Just like 0fdcfa2f9f5 (t0301: fixes for windows compatibilit=
y,
> >           2021-09-14) explained, we should not call `mkdir -m<mode>` i=
n the test
> >      -    suite because that would fail on Windows (because Windows ha=
s a much
> >      -    more powerful permission system that cannot be mapped into t=
he simpler
> >      -    user/group/other read/write/execute model).
> >      +    suite because that would fail on Windows.
> >      =20
> >           There was one forgotten instance of this which was hidden by=
 a `SYMLINK`
> >           prerequisite. Currently, this prevents this test case from b=
eing
> >   6:  f2da7d4d50 !  6:  91bd72062c t0600: fix incomplete prerequisite =
for a test case
> >      @@ Commit message
> >           However, the `preferSymlinkRefs` feature is not supported on=
 Windows,
> >           therefore this test case needs the `MINGW` prerequisite, too=
.
> >      =20
> >      -    There's a couple more cases where we set this config key:
> >      -
> >      -      - In a subsequent test in t0600, but there we explicitly s=
et it to
> >      -        "false". So this would naturally be supported by Windows=
.
> >      -
> >      -      - In t7201 we set the value to `yes`, but we never verify =
that the
> >      -        written reference is a symbolic link in the first place.=
 I guess
> >      -        that we could rather remove setting the configuration va=
lue here, as
> >      -        we are about to deprecate support for symrefs via symbol=
ic links in
> >      -        the first place. But that's certainly outside of the sco=
pe of this
> >      -        patch.
> >      -
> >      -      - In t9903 we do the same, but likewise, we don't check wh=
ether the
> >      -        written file is a symbolic link.
> >      -
> >      -    Therefore this seems to be the only instance where the tests=
 actually
> >      -    need to be adapted.
> >      -
> >      -    Helped-by: Patrick Steinhardt <ps@pks.im>
> >           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.=
de>
> >      =20
> >        ## t/t0600-reffiles-backend.sh ##
> >   7:  ea74e678f9 =3D  7:  c2d3212f11 t1006: accommodate for symlink su=
pport in MSYS2
> >   8:  1619ea4a3b =3D  8:  03ff6d756d t1305: skip symlink tests that do=
 not apply to Windows
> >   9:  807bb679cd =3D  9:  4ab6aaf2cf t6423: introduce Windows-specific=
 handling for symlinking to /dev/null
> >  10:  945306b5d4 =3D 10:  5f056902df t7800: work around the MSYS path =
conversion on Windows
>=20
>=20
