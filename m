Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A210D182A1
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ppqlb9qS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uEnGE89q"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83019B8
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 01:00:07 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 704403200A0E
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 04:00:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 26 Oct 2023 04:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm3; t=1698307204; x=1698393604; bh=UgMobPGetxHYozLHtlJ3PO3gy
	vAtCPuKgCyooGoljdk=; b=Ppqlb9qSe9amWGAdGJAPPbbHpOQAHd4ruJDyccyYO
	SjiDd3w8MX5cxsrj15nPCYLC3kRkF6fsiPXO4xNPWaxJR75m+dvqgpi9jNvCPswU
	s2rvdFuDYlhoo4faB3HRVEbeGg7SLQyDGJpQluCJYDYIrrk2knWo/JVWOrZ8njt4
	SCuDbx65xEaSk0/7pcaA186+K92fTT5kw+VlaIgOOmYX0tu7cCYj+ID4+W4VZ03v
	IArD2A16yJeXpDAScEec3ifVW4sPmqfqhVA/3H1jSSF39lG6227PtRfufeuMjW1G
	P9mdZSZuPYT2XtCO/AdqXSUwp8ktZwjYSfS4iP20Pe6Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698307204; x=1698393604; bh=UgMobPGetxHYozLHtlJ3PO3gyvAtCPuKgCy
	ooGoljdk=; b=uEnGE89qo05mkpqngfmWiPPKKkSG2HE+zR0sh7oN27eRU9SyJ6g
	P1W6aYVH4kGwLKmyxDh1XKBMriaT3/l/0Holn36irHvzRsGP6uuAnDxgif/4ljsE
	wHCog8Qz//T5oNO7HTdy75LMBRGvguaudGsveLnNljJx/nnxMU5BXQoh7ux2YZAD
	lFQZ0CxTsPbr2CrpUKquF0+4J8hjXb6pWiu8OLBqj85El6WBfere+134ZxjUwe4X
	IxB6gvu1/XAgxcVwsQHeeOJFbg/TlTVzEbMOFGjQcWTtAFYtPtxKXWFujW7CZNS5
	WYsU+9KNbe+FCdu6DYA4qVKMU8tO/jBvMRg==
X-ME-Sender: <xms:gxw6ZT-WYyLiAh5a99vqQjB_NZ0jPh3pTYmSTp-NCt34YDuqibDYNA>
    <xme:gxw6ZfuubYmPfv2o-INAuu0CiHpUmH1IDAvT6NwVwQops8fHU3bfKnNRK_fPC-DQU
    8Wl-myhqVSPPsSMUw>
X-ME-Received: <xmr:gxw6ZRBbrf-2JNR3zOCqADcqFOqCNOJEwRWfBRaEv35g7oOoh9mTFoQv_hYPHpQaMXJv68xkYjH9phk0l5AE_CsHKFZSOe3uehW5-1aq5aHqteY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledugdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjefgfeevleefjeettddvjeeugfdtieejvdekge
    fhkeeuleetgfekheeugfeugeefnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:gxw6ZfeRQ7RQ4EdMb30qyIT5oYf-I-LNDq91CgN227BZ_myiJPxZHg>
    <xmx:gxw6ZYPU4HOEPdqTL5K8aTICUxRDaer8LpX14cWRkIAU56hD8LfAMw>
    <xmx:gxw6ZRnKUllhUMyQwcVKNdNObD6k9vEhR_OzYn7wgccnZ-RN2wDV2w>
    <xmx:hBw6ZTam3HUqrYac5LeOJw9wxkbeXhGnHcK5DgEIPP9FTrfU8ZletQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 26 Oct 2023 04:00:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 289cf836 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 26 Oct 2023 07:59:52 +0000 (UTC)
Date: Thu, 26 Oct 2023 09:59:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/5] ci: add GitLab CI definition
Message-ID: <cover.1698305961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bohyH0O2yGVh4X2+"
Content-Disposition: inline


--bohyH0O2yGVh4X2+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series adds GitLab CI definitions to the Git project.

At GitLab, we're have already and will continue to ramp up our
involvement with the Git project. I myself will be working almost
exclusively on Git in the context of the reftable reference backend.
This has surfaced some issues in our own workflow, and the current CI
integration is one of the biggest pain points I personally feel right
now.

It's happened multiple times already that we sent patch series upstream
that passed on our own self-made pipeline at GitLab, but that didn't
pass the GitHub Actions pipeline. This is because the latter is a lot
more involved than what we have. There are pipelines for:

    - Various sanitizers in the form of the linux-leaks and
      linux-asan-ubsan jobs.

    - SHA256 in the form of the linux-sha256 job.

    - The linux-TEST-vars job, which sets several environment variables
      to non-default values.

    - The linux-musl job that tests on Alpine Linux.

We have none of that. And while we could of course iterate on our own
pipeline definition, the current setup results in quite a convoluted
workflow on our side. While I realize that this is not the problem of
the Git project, I really hope that we can integrate GitLab CI into the
Git project.

And this is exactly what this patch series does: it adds GitLab-specific
knowledge to our CI scripts and adds a CI definition that builds on top
of those scripts. This is rather straight forward, as the scripts
already know to discern Azure Pipelines and GitHub Actions, and adding
a third item to this list feels quite natural. And by building on top of
the preexisting infra, the actual ".gitlab-ci.yml" is really quite
small.

I acknowledge that the Git project may not be willing to fully support
GitLab CI, and that's fine with me. If we want to further stress that
point then I'd also be perfectly happy to move the definitions into the
"contrib/" directory -- it would still be a huge win for our workflow.
In any case, I'm happy to keep on maintaining the intgeration with
GitLab CI, and if things break I'll do my best to fix them fast.

I hope that this sheds some light on my motivations here. I do not wish
to replace GitHub Actions and would be okay if this was only a
semi-supported thing. But it would help us at GitLab and by extension
also the Git project because we will hopefully send higher-quality patch
series to the mailing list. And maybe this is even useful to somebody
outside of GitLab.

If this is accepted I'll likely eventually iterate to also support macOS
and/or Windows. A full pipeline run of this can be found at [1].

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/pipelines/1045746751

Patrick Steinhardt (5):
  ci: reorder definitions for grouping functions
  ci: make grouping setup more generic
  ci: group installation of Docker dependencies
  ci: split out logic to set up failed test artifacts
  ci: add support for GitLab CI

 .gitlab-ci.yml                    |  51 +++++++++++
 ci/install-docker-dependencies.sh |  15 +++-
 ci/lib.sh                         | 139 +++++++++++++++++++++++-------
 ci/print-test-failures.sh         |   6 ++
 4 files changed, 179 insertions(+), 32 deletions(-)
 create mode 100644 .gitlab-ci.yml

--=20
2.42.0


--bohyH0O2yGVh4X2+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6HHoACgkQVbJhu7ck
PpS3vg//QJXjiNjpdfCcM7rEkAs4J+xL3ry79f8dL8PfMTQ26XrTQO00Aynhpn6Z
BugEcZrZUaqUuUemt10pRgX+MnKBwqD8vhQbR1R4KuCCwntUqDk1v18QJ7+670vl
5guREDtbhP8iqB/9QsBjFcygZWwvLeb/nK8Mq8m6YU4OrMiA23ib25yfKJeKXQ+V
UIqgs6CoK52nycI/T4SiOWcvM6UvQ8vqRbJb/QEMQ+lVQDX0LrzECsdFPWWkcpU8
6LzniEfQK2HRW8xSBOZNS4FE3hEpQUP28aN3sRQCOEYO2puJSECogZMt7HvY/tSR
MkTLop647teOaouC7V4UbXV7hC4lRptRk3iqvYYvAcVL8GoO89mUqCFCDNWR6YfL
dsGrxu4cjCzDYkZV/qmnd5LeHZcDmuXHsHvwU03zwl7UYMkgZ6xIX8AjAK08r+aD
Skx5t/efod2uHid9/rNulvX1Ms7AEhViD4g7Db33boMhKPKnjerg/EfU8zD6sdGC
DecJlCST+h5OiYcNxQbNKvW7cQfXobBU5k/DqBRJIZA5ubOyafO+AYubnk1qfzPs
1DudQhPn1UysOIOuE486NIpfyKJmQyVATQM5FjnrNbLzB2x6WeGBAR0yhAmKqOEE
hZ8P3H/Adaf5+53vR7oRlpbPpQdm+OOucIr710W4EFj9SmUUO9g=
=qw81
-----END PGP SIGNATURE-----

--bohyH0O2yGVh4X2+--
