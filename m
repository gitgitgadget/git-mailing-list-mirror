Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A3crMGXM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vt+UyHbg"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1289A1B2
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 23:34:20 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 439B03200AF7;
	Fri,  1 Dec 2023 02:34:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 01 Dec 2023 02:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701416058; x=1701502458; bh=0B
	s4wh/ouWMMq2zv3B2sNBGUzHJ6AgmYZlrjzgVklew=; b=A3crMGXMnI71AVNL61
	ptyQvDBgWdABrTAGVvit0G0vnr734jMvFMJ5gTxNBFI1KbTuD/QqURoebuYvCjQa
	10sAjwLg+f8GsSkfoVWuEgKX+fu8v7YxBnGggOZfRPIE1ZGwdpAvufhzd3h/f0S2
	eSFkLdIucMqwN0WGyF6Mo3UkhgdzmHIEfXoANN/3hUNfME9p4sUX4WeDNcgdU2Z6
	lsEYoqVMgClUJUlzO+5U1Fh09efvjM4dvk59+gD+8iTYwswqNp1dyxI4mdwvsFRg
	IngUKFE6BLzIR0XHjPRZ2MIW8zF4RzAbVPheuRF/DQw/7YWhGkwLX5B1tSGcRgQg
	VhoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701416058; x=1701502458; bh=0Bs4wh/ouWMMq
	2zv3B2sNBGUzHJ6AgmYZlrjzgVklew=; b=Vt+UyHbg/5eaFDjvqlBU54H3kEphu
	YUc4eRfZ8hZ3MsRjto9b82kCLgSa3pO8feka+sD1P51MqFF80+fU+/oEO7ZcDsuk
	vcFBoDahsdIo68IEOjC7Dm+2RdwIEg+RG6u74i4BpnPT+TZLwohx2T24QkSBg6ko
	mktg9CdpZasf8KKrY2ee70VnHVm4r1j6qldW0+Ag4THAn9m+ZHJB3vkjCBLoB0CW
	+N6+V4BYrnuR1+jAo1oh3chq5kGvp+BIPv+s1ll9b/KVd8gulpyfGyWOC6Xme9d5
	NFf99NQcih/N2dEnMAN9d9jOIuSCjUnUIi9K/9faqTNYlSDa/XLGc31LQ==
X-ME-Sender: <xms:eoxpZfgU5B-uCzlZE2A89Ab5hIAGgxAsY1lMhL_uznmnxjugWPkaFA>
    <xme:eoxpZcDZiStwgGVWwMGBH856pxRW_Bubf2-xelh9Wzs7c65CWAzNRSHTG7cicvQWB
    9fbiW4e-wcTtQgYwg>
X-ME-Received: <xmr:eoxpZfGOtJcGOMLPXnkNT6_04FE0W4tPlyOQDBGfYxxYXxpuuWNEarro3CyyZhCtbzkFOE9jf3PnyRgPCV0VXjyMKlG8pIoaBrpoJkaj9OPogyk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeikedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetgfektdehvdekjeettddtheegfeehheetgfduteehuddufeekgfdtgfegjeeg
    tdenucffohhmrghinhepphhusghlihgtqdhinhgsohigrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:eoxpZcTOXNnkx3i3tS2ngyixraVq09_02gHOfYGvGU4QuPR499n70g>
    <xmx:eoxpZczlO7-ytzTZQlNbLLubM49KbjDnNMIsF94OIYwz8G2RmskS7Q>
    <xmx:eoxpZS687H1aNrGDxNY6KFSRh62nciyVptPG5HsUB9tN-Jpfcinm_A>
    <xmx:eoxpZX9guYHWRviBlnHF25Q2af2HaXRUnFDqYANmYlqyZxYqvhzxBA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 02:34:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6b37c1fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 1 Dec 2023 07:33:01 +0000 (UTC)
Date: Fri, 1 Dec 2023 08:34:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Stan Hu <stanhu@gmail.com>
Subject: Re: [PATCH] git-prompt: stop manually parsing HEAD
Message-ID: <ZWmMdjh4_25GIzjy@tanuki>
References: <cc902954f30c2faa92d1c5a4469f0dcc23e4acfe.1700825779.git.ps@pks.im>
 <CAPig+cSa9zxEhKXtXHrVuB3Eb6=vnD1Ppnfj59rA+nPEO-9j-w@mail.gmail.com>
 <20231124182803.GA11157@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w+N721b+YbsoRXxE"
Content-Disposition: inline
In-Reply-To: <20231124182803.GA11157@szeder.dev>


--w+N721b+YbsoRXxE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 07:28:03PM +0100, SZEDER G=C3=A1bor wrote:
> On Fri, Nov 24, 2023 at 01:09:03PM -0500, Eric Sunshine wrote:
> > On Fri, Nov 24, 2023 at 6:37=E2=80=AFAM Patrick Steinhardt <ps@pks.im> =
wrote:
> > > We're manually parsing the HEAD reference in git-prompt to figure out
> > > whether it is a symbolic or direct reference. This makes it intimately
> > > tied to the on-disk format we use to store references and will stop
> > > working once we gain additional reference backends in the Git project.
> > >
> > > Refactor the code to always use git-symbolic-ref(1) to read HEAD, whi=
ch
> > > is both simpler and compatible with alternate reference backends.
> >=20
> > This may get some push-back from Windows folks due to high
> > process-creation cost on that platform. As I recall, over the years, a
> > good deal of effort has been put into reducing the number of programs
> > run each time the prompt is displayed, precisely because invoking Git
> > (or other programs) multiple times became unbearably slow. In
> > particular, optimizations efforts have focussed on computing as much
> > as possible within the shell itself rather than invoking external
> > programs for the same purpose. Thus, this seems to be taking a step
> > backwards in that regard for the common or status quo case.
> >=20
> > Would it be possible instead to, within shell, detect if the historic
> > file-based backend is being used in the current repository, thus
> > continue using the existing shell code for that case, and only employ
> > git-symbolic-ref if some other backend is in use?
>=20
> Thanks for sharing my worries :)
>=20
> I sent a patch a while ago to Han-Wen to make our Bash prompt script
> work with the reftable backend without incurring the overhead of extra
> subshells or processes when using the files based refs backend.  He
> picked it up and used to include it in rerolls of the reftable patch
> series; the last version of that patch is I believe at:
>=20
>   https://public-inbox.org/git/patch-v4-21.28-443bdebfb5d-20210823T120208=
Z-avarab@gmail.com/

Fair enough, I'm sure I can roll something similar into my patch series.
I do wonder whether it's fine to already submit those patches now where
the reftable backend doesn't exist yet. But I'd hope so, because it
would make it significantly easier for us to upstream the backend if we
can only focus on the backend itself, whereas all the other parts were
already addressed in preliminary refactorings.

One question though is what the right way to detect the reference format
would be. Reading HEAD and comparing it to "ref: refs/heads/.invalid" is
okay for now, but doesn't really feel like a good fit in the long term
as there has been discussion around dropping the requirement for HEAD to
exist altogether [1] in the future. There are some alternatives:

  - Check for the existence of `reftables/` via `test -d`. This is easy
    enough to do, but also doesn't feel all that robust.

  - Extend git-rev-parse(1) to support a new `--show-reference-format`
    option. We already have `--show-object-format`, so this would be a
    natural fit.

In the long term I'd aim for the second solution -- it's the most robust
solution and would also scale if there ever were additional backends.
Furthermore, we already execute git-rev-parse(1) unconditionally anyway.
So there wouldn't be a performance hit here.

While I plan to introduce the `extensions.refStorage` format before
upstreaming the new backend itself, I think it's still going to be some
time until I submit that patch series. Until then, I'd say we simply use
the proposed way of parsing HEAD and second-guessing that it might
indicate the reftable backend, like Stan also does at [2] for our Bash
completion code. I'll make a mental note to refactor these once we have
the extension ready.

Patrick

[1]: <ZWcOvjGPVS_CMUAk@tanuki>
[2]: <20231130202404.89791-1-stanhu@gmail.com>

--w+N721b+YbsoRXxE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVpjHUACgkQVbJhu7ck
PpSPZg//SZahSt/7ELYZzx7iPe76reVwfsatiOx2JtKGByuewPIKO214nd3EOiPY
a+tpYzau5q20qDEqYJJ5h64eQaGjVqbkL3qHiW/AdZT0tK0AX65cjR4EBGr+nfHy
jzPj4seC4rUb1Ba339GyZkMWsBw7oxeDrYYOcudS41Vq0Swo8ej5LBTN6A1jRqUj
XNw0VC4A77FxL2/2ES8rEo7KWMOtoLFNYcRm6JFKgSblrR9BWBVO818dYJwcgTig
BLZK1o+QNa2Y+p3Jw8v9Nv37bWhcWwshAU4Bs1oA6Vsxn2aYZhrXOpi6ndUPTAFo
VgG3Kx8xwc3VfV5nA2nb0q4T9Ybb+nnDhGv6/b7pMFoU2WX5rzYPPhaew0pVOapa
xTR1pn/ii6/pFa1frUxe6wIFmxLmzJ8Cnjo5Du5FzRq0ND9OVdzKx6aaDAlcd9NM
B4UwNORfm9KsXGxABCCAZdwQQ0ff+N9lbYCFK3ILwdkSHs9a2kz+5PPS9BaMKu2v
mN6hrxM0s4UgnLf1cpFtY33dpW74LxvM67wIULiVsC2cd+SBZT2WcTLQUjQgphKa
Vt1uXB8Srvso2D0uQpmQfr59podX9oBbAEHW16HJTfspvpWom2Fe6gM6PiMig/bg
PUuj1YjPEymwnIc/fxs2npSiXJ9zt9cPXoxzMRFFXnB8bx2tuP4=
=NuHZ
-----END PGP SIGNATURE-----

--w+N721b+YbsoRXxE--
