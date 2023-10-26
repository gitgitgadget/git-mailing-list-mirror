Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B92727728
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sxgg2E8a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GhNf94/F"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDB6193
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 02:44:42 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 91E7B32009DE;
	Thu, 26 Oct 2023 05:44:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 26 Oct 2023 05:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698313478; x=1698399878; bh=U8
	UYxRaAm2caDZQBVXA/pQ8ksFnOLVronZqBVVlzprA=; b=Sxgg2E8abV80p3WpcJ
	CbBdEGMOtPPwtkslw5gWaTDRaL70WAhyUyohP8453TCpDg0/lDA1Y5OQrql3/pEB
	kpd8gTBvLCPncyX+7wuO479JXx5wzV5+Yw0Vk+jiaPuJ6h6BLCNaFFTivmfeL3Fl
	T2mAe7NAEcaLs+OtCneV1bpPML52l0W85iM0m9KaFjamseLDV3xBsg5t3rDE1LCM
	qo1tZ+ORcDAvGZolEA+icI9PYCvbNPvlkP5xoxuYFQsRFKl+YZfsLgMTBgwgqLwP
	ROBad0M30lB1HuTc33ZCRV0wU2zRFgo6mQxIVVnRGnxS3+uSP9pCMyWviIwNeBXe
	AxEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698313478; x=1698399878; bh=U8UYxRaAm2caD
	ZQBVXA/pQ8ksFnOLVronZqBVVlzprA=; b=GhNf94/F5BHFRvX+Kxs0FYkHXyKEz
	X16fWqTZJZQEUA4VJSGbSsfhlg2vRGxkQoSvrF4Rh6GJprCWvfzP4/16Httyzkh2
	0WcpllxJTAs7MKE3KsCxfykn68Ou68M69D/Gx7TLoSo4a0R+B8atRHKjVek3B7/5
	strw5BU6uPCJqCwXhMWlUg1Z07/AVHP3ZeV0j10uvj3ecMDD4BXOwwewhvPTDvIS
	BnkkMfyctijcZeFDovG3TIeDaaXE87GgxLbpSzdUgHH0rYEqqCeFchPklUu3QcZ3
	eIi5//NHs/Oool6uchGE9OOJ8ZCGaKwQuWbB3JmRQrqHMnReWN+DHXOtA==
X-ME-Sender: <xms:BTU6Za-fY0OWivJV6Y7O38KM7u0hNZmUy7p89f5sHk4btyeH227WSQ>
    <xme:BTU6ZatTLHL1q_vGb6vJavnnLpVJjulElogs3s9erCCQaq9vwmZzAsWWJvUIgVCMn
    yHRoxKrVj8XIHy7QA>
X-ME-Received: <xmr:BTU6ZQCaD9OtpgNXNgcemhy9FDrKo5q7zEmVBlaA61545tF09t9hoyMjELiU07WPRmvkCcFOXRTUYfL2l3iZpBMhw3h2oLMOw2HHae8FuRdwZQk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvgeduveejffevfefgjeefvddtffekkeetudevkeejveehjefgjeejhfegueevvden
    ucffohhmrghinhepphhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:BTU6ZSf-4x4JCxCrVoG7zAQNbZIGHn0NWAWqxx8dsuIUMX_eTAuyHA>
    <xmx:BTU6ZfMEold_-GMIzvqo787c_YnAdUV4lxWQwejmlzy8PXrPWStjWQ>
    <xmx:BTU6ZckJWat69JprKXHNOFSVXCssDqwTMYmH8TAwJ2rO22xKzSkr5w>
    <xmx:BjU6ZYad302u3rYmCMCcA0pBQIWdNij8EzJvuCdUZFM9ejFBcyeMDg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 05:44:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 62d36cf4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Oct 2023 09:44:26 +0000 (UTC)
Date: Thu, 26 Oct 2023 11:44:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwen@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 00/12] show-ref: introduce mode to check for ref existence
Message-ID: <ZTo1Af8JKaovhJtk@tanuki>
References: <cover.1698152926.git.ps@pks.im>
 <xmqqttqf3k5a.fsf@gitster.g>
 <CAFQ2z_PqNsz+zycSxz=q2cUVOpJS-AEjwHxEM-fiafxd3dxc9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RhOr5qftGEwiUNtX"
Content-Disposition: inline
In-Reply-To: <CAFQ2z_PqNsz+zycSxz=q2cUVOpJS-AEjwHxEM-fiafxd3dxc9g@mail.gmail.com>


--RhOr5qftGEwiUNtX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 04:26:35PM +0200, Han-Wen Nienhuys wrote:
> On Tue, Oct 24, 2023 at 9:17=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> >
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > this patch series introduces a new `--exists` mode to git-show-ref(1)=
 to
> > > explicitly check for the existence of a reference, only.
> >
> > I agree that show-ref would be the best place for this feature (not
> > rev-parse, which is already a kitchen sink).  After all, the command
> > was designed for validating refs in 358ddb62 (Add "git show-ref"
> > builtin command, 2006-09-15).
> >
> > Thanks.  Hopefully I can take a look before I go offline.
>=20
> The series description doesn't say why users would care about this.
>=20
> If this is just to ease testing, I suggest adding functionality to a
> suitable test helper. Anything you add to git-show-ref is a publicly
> visible API that needs documentation and comes with a stability
> guarantee that is more expensive to maintain than test helper
> functionality.

The first patch of the original patch series where I split this out from
did exactly that, see [1]. Junio questioned though whether this should
be part of production code instead of being a test helper.

And I tend to agree with him, or otherwise I wouldn't have written this
series. It's actually a bit surprising that we do not have any way to
test for reference existence in any of our helpers in a generic way. All
current tooling that I'm aware of is lacking in some ways:

    - git-rev-parse(1) will fail to parse symbolic refs whose target
      does not exist.

    - git-symbolic-ref(1) can look up such unborn branches, but the
      caller needs to be aware that=20

    - git-show-ref(1) tries to resolve symbolic references.

    - git-for-each-ref(1) is simply not an obvious way to check for ref
      existence.

    - All of these will fail to parse references with malformed names.

So the new `git show-ref --exists` mode is a trivial-to-use and generic
way to simply ask "Do you know this reference?". The lack of this option
likely shows that you can most often get away without such a tool, but I
still find it funny that there is no obvious way to perform this query
right now.

At the Contributor's Summit, we've also discussed the issue that our
plumbing layer has become less useful over the years. It is often
missing functionality that exists in user-facing commands. It also has
inherited many of the restrictions of our porcelain tools, like not
being able to look up references with bad names. So this series is a
small step into the direction of making our plumbing more useful again.

I also assume that it's only going to become more important to address
these limitations in our plumbing layer once we have something like the
reftable backend. A user or admin would have been able to fix issues
with misformatted referencen names rather easily in the reffiles backend
even without support in our plumbing layer, as it mostly was a single
"rm .git/refs/$broken_ref" away. But that's not going to be an easy
solution anymore with reftable due to the complexity of its format. So I
also see it as part of the upcoming preparatory work to make sure that
they have all the necessary tools to address such situations, at least
up to a reasonable point.

Patrick

[1]: <e947feb1c77f7e9f3c7f983bbe47137fbce42367.1697607222.git.ps@pks.im>

--RhOr5qftGEwiUNtX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6NQAACgkQVbJhu7ck
PpTygw//cYA60niacOk4d1R/xulp7xu9cP/TpwYW2mFDYxk4/zUFh3XLhsS+qMO6
KRrfABwH7HI5V+J6iiztH8iN9wMkHu0ZPsCH4Dw1kOFNhlAk4URCSjkKEQ8Wt4E+
ruVPUgHIMD19cA9mW5UBZqZt0GPQWqlwQ98LJDrXNtzDRFPYTDJRxh1xi58iggMy
+Cn/QIAnHB3FJPczW2hbjrp0bNWgAnx9vhsWSywaWOtY3dXekpDZMEo6DrPyicsS
dddF7CJo7J+tVUfv2s7jCE06yErLnm49VisF0zFecuHSRjddkSvgpuq+hkX/QOtw
IVgjJeZYDpSRevhhkQ55vJh2ugBD7VxsaaBsyVVtG/wkVrAI1tI97wPJ8pcdGINl
/E9QPNXLL9Rqw1m+bjP5+pRrfPjmEju4efXuuxCzA0PdEMHT3nb3b8znoeReKqZx
XiSTV5iB2mEQgtuaZ17WU5G6pKsiZwqp/H5dxa96dW//RczIGsao0VGwvRgov7Qf
mE1oLzswBMTGEEjOj1rWBsp+H0niwGOgNCEUkZzK1AUECGeUPZuwhCiAqY5fo3pY
WjU9Xda4I8wCcpf2g6rsNrQmBl/Wgpph96F0dOjpgVAc2tarYGrJZr+sTBDmk5EI
23slaU9o3y9VXlaCMRBs62Hw4RcY8MWWC7D9APsDulWjJ51hPaA=
=MN7P
-----END PGP SIGNATURE-----

--RhOr5qftGEwiUNtX--
