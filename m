Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZsklsjrX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o8N/OO8y"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AE185
	for <git@vger.kernel.org>; Thu, 16 Nov 2023 03:19:23 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 3A53F32009B8;
	Thu, 16 Nov 2023 06:19:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 16 Nov 2023 06:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1700133559; x=1700219959; bh=cn
	TSvrn4Rqozbzo/vgFNrDoNyoMW+KRp3KTJj2HY9Q4=; b=ZsklsjrX9Js9oHNUB1
	93u4uBGgmVnpEBbKiYbV1c7xqN5ThOEsKc3u6G9YJCgo0JX6Wn1Ca6fcaHWYnuz8
	06gw0x7cup2uu6bfwodHW9z23M8hSFvqDiEdD1aDpf+VVIiOmkDaJpvwMzK6wOtr
	xPMn6T9kyu4Ps5GgjVlTClMIgdu4TgcXnWY6kQ+9zS4OX6ScvxnTQI/0i17dBvQo
	MRCX8j79A0r92MWUpOnmyRFYYstntNN5X5jkjP5gtd1blzAr3xsiaUrLM62s6Dnm
	CnkVnLbaBVjAHjxixqowznM2LLTgYssMUykBvzCORTv1kXI+zZSOs37LrKxBtiBQ
	EiFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700133559; x=1700219959; bh=cnTSvrn4Rqozb
	zo/vgFNrDoNyoMW+KRp3KTJj2HY9Q4=; b=o8N/OO8yA1vSpAP4Tv46BD4/vUaNW
	1zRmb8vf3gj7GcDk38dpAnkP64GMvUXHK8mDz0XiLKb0lEpKM1OHisPPLfpDaFMd
	msquCcJqTfQmFmecpO2JIQ3MI9NFoW5zaUs0guQvVRmzLn8fMGWdTxz6P2MVwZyq
	ZRzH+eZnUgno0g5cjtkLpkrwA+3cM7BAt58oAkhyzgdrcYI/2tzGUXbxgvDgr6oA
	uQ9YYVDdd2jrguWxGBdtoOmlkJuF5to0gEYCaY3tCbC6GpHBZKKF3NycheNVB9Do
	ZJLqZlCU1hinjbGh8+hIA9stJTyqQ04aD5CtO1Jge6JInq+zuNUEY0Gag==
X-ME-Sender: <xms:t_pVZeunLSDublvj35fHWrfDbW4iejTGXBAssGQ8oPLAE7jmC8rERw>
    <xme:t_pVZTe955aXN0wGFW-pySidzJNo5wtpPFtbscFBN3DLaV338J9jvR7TYS0cYTCoN
    um3ZiZFG4lr_kLrbw>
X-ME-Received: <xmr:t_pVZZxSv4x7I8cp_0d7S2s8jvYW0dTL7PsF4Pa3jy7itCEzsUgD7X2s8pf-7WJmmjU5mqH4jwxRzkf0arYEzFcDhlQjJ80QhB87UqtNIFs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefkedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:t_pVZZPAYYZXOnkcjSvwlIm-m_TQ2GMUnq96PAWUCdjap96O3UT1Xg>
    <xmx:t_pVZe_UakjPFCiR1rpL5sMrpF_2L1g6BVAvhoiW4Xs708Wbx6S1ig>
    <xmx:t_pVZRUABuDZKu913SrOxGTx-h_0mc-oxDJ_Lz-3AuXUFWtA1-ozVw>
    <xmx:t_pVZQLxW6S7YFMLoorDMn9-V0diLEEjgsGVwtIdfJzk2m96DYkdGA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Nov 2023 06:19:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 911b30b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Nov 2023 11:18:34 +0000 (UTC)
Date: Thu, 16 Nov 2023 12:19:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] commit-graph: disable GIT_COMMIT_GRAPH_PARANOIA by
 default
Message-ID: <ZVX6so-Gj_ES_FR8@tanuki>
References: <7e2d300c4af9a7853201121d66f982afa421bbba.1699957350.git.ps@pks.im>
 <ZVNNXNRfrwc_0Sj3@tanuki>
 <xmqq7cmkz3fi.fsf@gitster.g>
 <xmqqzfzgxops.fsf@gitster.g>
 <20231114194310.GC2092538@coredump.intra.peff.net>
 <ZVTJFOSnVonoPgZk@tanuki>
 <xmqqh6lmwogq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5UiJEhJlzCifxFY1"
Content-Disposition: inline
In-Reply-To: <xmqqh6lmwogq.fsf@gitster.g>


--5UiJEhJlzCifxFY1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 09:07:01AM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> Yeah. Just like we auto-enabled GIT_REF_PARANOIA for git-gc, etc, I
> >> think we should do the same here.
> >
> > I'm honestly still torn on this one. There are two cases that I can
> > think of where missing objects would be benign and where one wants to
> > use `git rev-list --missing`:
> >
> >     - Repositories with promisor remotes, to find the boundary of where
> >       we need to fetch new objects.
> >
> >     - Quarantine directories where you only intend to list new objects
> >       or find the boundary.
> >
> > And in neither of those cases I can see a path for how the commit-graph
> > would contain such missing commits when using regular tooling to perform
> > repository maintenance.
>=20
> I can buy the promisor remotes use case---we may expect boundary
> objects missing without any repository corruption.  I do not know
> about the other one---where does our "rev-list --missing" start
> traversing in a quarantine directory is unclear. Objects that are
> still in quarantine are not (yet) made reachable from any refs, so
> even "rev-list --missing --all" would not make a useful traversal,
> no?

You typically know about the new tips when having a quarantine
directory. So you can discover the boundary between objects in your
quarantine directory and your main object database by executing `git
rev-list $NEWREVS --missing=3Dprint` and execute that command with
`GIT_OBJECT_DIRECTORY=3D$quarantine`. The benefit is that this scales with
the number of objects in the quarantine, and not with the size of the
overall repository.

As mention, this is really niche, but we do plan to use this in Gitaly
eventually.

> In any case, it sounds like you are not torn but are convinced that
> we should leave this loose by default ;-) and after thinking it over
> again, I tend to agree that it would be a better choice, as long as
> the feature "rev-list --missing" has any good use case other than
> corruption in repository.
>=20
> So,... thanks for pushing back.

Okay, glad to hear that I'm not totally bonkers then. I'm going to wait
another few days for additional feedback before sending a v2. But if
what I'm saying also makes sense to others then v2 would only squash in
the diff I sent to run the subset of tests that is now failing  with
`GIT_COMMIT_GRAPH_PARANOIA=3Dtrue`.

Patrick

--5UiJEhJlzCifxFY1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVV+q0ACgkQVbJhu7ck
PpQUZQ/+M29NAfgDMGiVT6fRLOVDciW6R9+h04dTbxO839EufyUzOc6MtoAT0B8w
43Hp5lJnm/nD9WOhzQkVuv42j7L5L+fs8OkZRwyl6VUiwHgOSDympr6+QA5SJD1V
sfNzHkv6ok0ZLPvMzpaOWuHAEBxY2RiFWkw5bHfQ1/dulXWqbTaLqK7wN2y1z2f9
e47SLzmp6PcUQu5EChcgde0D3qC7HWFj0Soz6NsUSHd/hJX1RFIFUxdW6HXEtL6S
j8dR1Yzsj8wJMGz+avYTzUGiopDpdyUPyNF/hAW9LhLBaR6CfU81CzKzdLnEPNiK
Poh5nr6Gfb1NI9ZZMskafITJrudmZF1IPi3FhFl7BCAL/cm7s8Y0CU1pbgGnEPkt
dNTiCNWL04y7GyH5nymDYUcCruMoR/N09/UGbK+zdaGno4wt5xKmeh1rdGp3qNOs
k+w82d2h49UJJ4pGefm4FFNcMHkGhCkCG76LbAW35jtJz1apWmHe9PuY50ZZ/yTd
lISZ5Nn6sCDe0fCzNvAw/iR1aX/k1cvFQDCpktByQl9s8lGcDYVCt4MAMQMTurbE
hb1Qm8/aDpIUOLKYscqKK+lFvAbAUh1MnUl6kmDXeeaFMDo3f/tDSlT2LybSpiam
VYBtL2Ga7524fENBIWFDXq/78zbheT53ZiDwDKp0S0d3D6CT9H4=
=FjnW
-----END PGP SIGNATURE-----

--5UiJEhJlzCifxFY1--
