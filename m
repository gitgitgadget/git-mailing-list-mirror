Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bIagy6sH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MuqxAKAj"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18863EB
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 01:08:53 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 4BD553202824;
	Mon, 11 Dec 2023 04:08:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 11 Dec 2023 04:08:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702285731; x=1702372131; bh=K5
	V1DyEOym8PY12ge1FSKIh2QN4TDyHRO0/+4Olsw4k=; b=bIagy6sH+qsANy41kZ
	SLkNgz4DZ8SqOXk5Iia9qM0CqV6CXy3J0tu9xaQXjm+gC3qDe5lRZEDb2M5eGg6K
	8PwDKeT5EYEOwzJIPG3GgN82o6NMidijU701JDd+3XDRGb2QqZ+ccU3Zc4HLsgDJ
	ZbF4XyaVhg2skw3J2iTao7lh3EJGZEPO/4iLhIngjj5JK3eQLlBYxPE0f5vlKEF6
	bfzcKjRKM2/vW40oyxsvZ35J1mt3MtMSf4yhjJhDwiLsu2U+YxhR27kfpqjzTx2E
	2XRR3G1ZPjwp1UTGa5Y5yuWQFdeH9YtRqVwQYTQIw/kYEYu+QLr+0StuWTeI7NON
	FC6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702285731; x=1702372131; bh=K5V1DyEOym8PY
	12ge1FSKIh2QN4TDyHRO0/+4Olsw4k=; b=MuqxAKAjaSXnoz3ZM0JOH6LBiBWJQ
	TElq1SigA8ONCeI7vG+yQjEpPv7x4zHlfpwhj4cqlV09ENcs1dyn8c6wdOZetAbm
	GLjzi3iVqFa6+Kyts7LyO8glbceZDg2HGXt2jQGG6gYChofPWQEUOY7KSV/ZSf1+
	Mq/3yb6+aHMXgUrONG/S8USKXpyqBsMIO1+8T7uEFijkyPRR1WW6729YZ13/k/6j
	MZ467/FJ3JR/9tVPCwC6L1hj7/76RRcJWGfEgV/kJUPNHTX2mKbkPGE4S94xO+zz
	geyvg7WiEJwXLp3yGJ9nY3bHf0JYBXGy5yUBiZxoCeVgFLOooUAMu13og==
X-ME-Sender: <xms:o9F2ZR-0Z8cQHnJ8diCn0c_ndYtqmtKfl8eBwYQ-YR2QLWQWNz-CDg>
    <xme:o9F2ZVunhUnypky5ldcAgLkWVXSDTRW_8ZVZcjlSX_PhZNryJNQaEOxSzd6aaZtWN
    F1wqJdcnbyeCMxrxw>
X-ME-Received: <xmr:o9F2ZfBbiIumE7mhCmFgCikrHi3ApuNxPGEvkjBm59tUmadVIsP1KVXs8e0YgFXniGZG6KuZmwq34LdhueiVw1FBalDUqcjBnsCcaIgjFtAHTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:o9F2ZVcxzBEYkgnEJ9U-839m4t93EdSH9ETxzIi6O_xfsxFNblvuXQ>
    <xmx:o9F2ZWPwvDJ8fErEvSD6lkmsAaprUR9-IH3mbd4HV591OjjzfrutBQ>
    <xmx:o9F2ZXnolVDxIJemV-JZ_t97F6bxEq7LCiL5_JY7Jr3K66uHEy0EZw>
    <xmx:o9F2ZfaGwttBJFk3zzAOlUGHB3-qnpJXfGuC90b2D83sa3NBDmcnzw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 04:08:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d1b6f07f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 09:07:14 +0000 (UTC)
Date: Mon, 11 Dec 2023 10:08:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 07/11] reftable/stack: fix stale lock when dying
Message-ID: <ZXbRoDh7j18olBDx@tanuki>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
 <e82a68aecd0a1179df3a59755864c71995e979d3.1702047081.git.ps@pks.im>
 <ZXOXpQstse8CdI7J@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fSK4Vmq3caw8hXJ1"
Content-Disposition: inline
In-Reply-To: <ZXOXpQstse8CdI7J@nand.local>


--fSK4Vmq3caw8hXJ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 05:24:37PM -0500, Taylor Blau wrote:
> On Fri, Dec 08, 2023 at 03:53:23PM +0100, Patrick Steinhardt wrote:
> > When starting a transaction via `reftable_stack_init_addition()`, we
> > create a lockfile for the reftable stack itself which we'll write the
> > new list of tables to. But if we terminate abnormally e.g. via a call to
> > `die()`, then we do not remove the lockfile. Subsequent executions of
> > Git which try to modify references will thus fail with an out-of-date
> > error.
> >
> > Fix this bug by registering the lock as a `struct tempfile`, which
> > ensures automatic cleanup for us.
>=20
> Makes sense.
>=20
> > @@ -475,7 +471,7 @@ static int reftable_stack_init_addition(struct reft=
able_addition *add,
> >  		goto done;
> >  	}
> >  	if (st->config.default_permissions) {
> > -		if (chmod(add->lock_file_name.buf, st->config.default_permissions) <=
 0) {
> > +		if (chmod(lock_file_name.buf, st->config.default_permissions) < 0) {
>=20
> Hmm. Would we want to use add->lock_file->filename.buf here instead? I
> don't think that it matters (other than that the lockfile's pathname is
> absolute). But it arguably makes it clearer to readers that we're
> touching calling chmod() on the lockfile here, and hardens us against
> the contents of the temporary strbuf changing.

It doesn't make much of a difference, but I can see how this might make
things a bit clearer to the reader. Will change.

Patrick

--fSK4Vmq3caw8hXJ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV20aAACgkQVbJhu7ck
PpQ4dQ//QeNYdNRRiCOzKfMUuropcFxbYT9+m5+uUe7DSdBLavapBFyhBq4kmD5W
eFZCjvLDBiJDq9R3gKeRM3lU2tB62YrtIyqHaoNqPUlxhdsETDRgvzs/W9qyqhck
eRPkj8/uMJVgjTmms2AKa9l1q7IR2jmJoM+GRQCJMlAGeDIL04BJi0En0xJjq4NW
tdzaedWf2dgMfjr9rqsXfgR/GVME0sPTIG4ynA5ynqwqVNVSWdU7ok8N6zctaUD4
y+zHW7LE7bdn1GMCXdc9q0feiQg8pH/dFTHP6iDqRWzyM1jthMkXKEJDUwd320y9
vfIRSR6kaErrsUvsFi5njsHpO88yA4a1fmgHelO44MIgq+pk9/WZk7UbOOcsELwl
FcoHoe33dEfgkuEXEDC2yluKQVy105E8Oh715QR51r7NMAIFuQMoVO53Kme0zX2z
7MewqlEOT4BJZb6snDBzxONBxcTmvJhnneyOe1u+CSpwKazztzpRD414LHxdFmUW
Gu5p34Gry3j+BVEthofK3gHNlFrBnCdBoNx2eH0vAvpE+HMHUGE4c4QZwjSc4+wf
k7DRFRJzbJEMe2e1ljD/ADhTG0F4UVey9J0XnDo0ePSRyPhdOEknUnGq+5m0TzI4
DJ8ZtTOE9G/IfkOCHKB76Ie8sdLN+SNN10svSAIWKsMlPPqVdZY=
=fhlE
-----END PGP SIGNATURE-----

--fSK4Vmq3caw8hXJ1--
