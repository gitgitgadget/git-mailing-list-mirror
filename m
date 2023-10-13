Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58E763A9
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 05:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I5Fhv4Dk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jjC3YvPk"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D03DBC
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 22:53:46 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id AADD73200A68;
	Fri, 13 Oct 2023 01:53:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 13 Oct 2023 01:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1697176421; x=1697262821; bh=MN
	rUoQnWhVqoSzdi7WwAXLvcc/XvxCNQ/30F52KhvFs=; b=I5Fhv4DksYmkYus1sJ
	Uwcdg1YUC0+Ei+XDg0O3tRsdIZnp4N8+vrEokl8vp/mz9umNuteA4ysZNGyHpNDa
	sLUrdkvRtQ4lFGF3tmchPDUvvJ6yYrzv8Nw8EaPsJMaJXFSxR/nWNcUY+G5QATOs
	l9vDXbN3Tm7jomug0ClwKKNKO05EYNQWGJdjWDNZ8kO2A1P0GyT9uBNGpVyKOG82
	OYmtOFn4BrvK5/NH23X6loGS5GubPUYjYVsY9uNc+ZZ0X0b5ZycK/fv0BGF3YvZh
	wOfS/GslHZoV84dXu0SUZ0tOeeZM5EvSjQiURRvsbvo9jTLzJn1G44P6Rep9u/69
	6ZcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1697176421; x=1697262821; bh=MNrUoQnWhVqoS
	zdi7WwAXLvcc/XvxCNQ/30F52KhvFs=; b=jjC3YvPkrx1Xdz2VnISLPu8WbkPwv
	98hzzUReD5+wAO6GNT/C2r7AT/ie0dVI2C0mVC/cewDBkvuIX/pbWd862TTGzPfv
	9ogjbmjCO+8ZO7QVxzmypnk50814E6KlZWXP/JMXz82AxZz3BD1LYKqjLO/u8Vv/
	kcaXhHTl8XEbgLyF7yn/7KUzhIE6RJQeAL2u0WQaQi0v1AYxBEtf9sp/VAKxKsvI
	Z/UQLm1WPUp9rlDKNCox4SzgQWFQYyfHjntZJKuPi6ffUC6P9CAGyLZMB97a/LqB
	UQRmSchN1f6tOPZyGxFv5y2UEhdPrkra0tI9Jnt6mj4nCc2Yw6665bWAw==
X-ME-Sender: <xms:ZdsoZTZkhr5D_TXWI72l3a353JXHn4_YNTZu1igcLKLpp8ChrgewTw>
    <xme:ZdsoZSZL_1osmQc6WbA2Cenp0tXuXpDrrH3f6UOzGOUtRfjfEoXtlsSeN0CJjZEVx
    IIYp6bHc14UkdKG4g>
X-ME-Received: <xmr:ZdsoZV97n042vjeY8JI4DSTEQIxQolcuwjc-xOEZ0-jOeY1UvX27OgLi48vbwHmjxgSZP2HhGSpqL63rwC6Oyq2vIKSQlucNb3VOr0RrOZBniKM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedriedugdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehfefhuedtvedtfeeiteeugefgfeelgeelveehffeukeelfefhieekteevudfhffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:ZdsoZZpNNiXVLjrPyKAmvf80M2glCIXUv2Ujxyvned3xuHJniYHJWw>
    <xmx:ZdsoZeoqE_TPai__REjTvqjnJUiNisCsWbiHRUBg1dtAOT2fPOXKLw>
    <xmx:ZdsoZfQdViGsG2e5FTJCs-Z8cbmT4STZS4c4Hnq1JfVyORa1W9OIpw>
    <xmx:ZdsoZTCyy35nWdFLHtNU0j95qmR0fWVmf1gdtxfnr-gtTHUCxacgAA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Oct 2023 01:53:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8bda5514 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Oct 2023 05:53:37 +0000 (UTC)
Date: Fri, 13 Oct 2023 07:53:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] rev-list: add support for commits in `--missing`
Message-ID: <ZSjbYCXfSUtEIkAt@tanuki>
References: <20231009105528.17777-1-karthik.188@gmail.com>
 <ZSTs3BUVtaI9QIoA@tanuki>
 <xmqqil7etndo.fsf@gitster.g>
 <CAOLa=ZSbd_E+DAkhuGrUpfHkxaje3jrH9-fEDyctAPFExKnj9A@mail.gmail.com>
 <xmqqbkd5nlq0.fsf@gitster.g>
 <CAOLa=ZQxNX4oGtqrgLyKenC_D8M=9q0sFJVmo4fyjSPtgw315Q@mail.gmail.com>
 <ZSfSt4tXx8sE68Bn@tanuki>
 <xmqqy1g7hl2y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N9UaJD6LlrJBeFdK"
Content-Disposition: inline
In-Reply-To: <xmqqy1g7hl2y.fsf@gitster.g>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--N9UaJD6LlrJBeFdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 09:17:09AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Wouldn't this have the potential to significantly regress performance
> > for all those preexisting users of the `--missing` option? The commit
> > graph is quite an important optimization nowadays, and especially in
> > commands where we potentially walk a lot of commits (like we may do
> > here) it can result in queries that are orders of magnitudes faster.
>=20
> The test fails only when GIT_TEST_COMMIT_GRAPH is on, which updates
> the commit-graph every time a commit is made via "git commit" or
> "git merge".
>=20
> I'd suggest stepping back and think a bit.
>=20
> My assumption has been that the failing test emulates this scenario
> that can happen in real life:
>=20
>  * The user creates a new commit.
>=20
>  * A commit graph is written (not as part of GIT_TEST_COMMIT_GRAPH
>    that is not realistic, but as part of "maintenance").
>=20
>  * The repository loses some objects due to corruption.
>=20
>  * Now, "--missing=3Dprint" is invoked so that the user can view what
>    are missing.  Or "--missing=3Dallow-primisor" to ensure that the
>    repository does not have missing objects other than the ones that
>    the promisor will give us if we asked again.
>=20
>  * But because the connectivity of these objects appear in the
>    commit graph file, we fail to notice that these objects are
>    missing, producing wrong results.  If we disabled commit-graph
>    while traversal (an earlier writing of it was perfectly OK), then
>    "rev-list --missing" would have noticed and reported what the
>    user wanted to know.
>=20
> In other words, the "optimization" you value is working to quickly
> produce a wrong result.  Is it "significantly regress"ing if we
> disabled it to obtain the correct result?

It depends, in my opinion. If:

    - Wrong results caused by the commit graph are only introduced with
      this patch series due to the changed behaviour of `--missing`.

    - We disable commit graphs proactively only because of the changed
      behaviour of `--missing`.

Then yes, it does feel wrong to me to disable commit graphs and regress
performance for usecases that perviously worked both correct and fast.

> My assumption also has been that there is no point in running
> "rev-list --missing" if we know there is no repository corruption,
> and those who run "rev-list --missing" wants to know if the objects
> are really available, i.e. even if commit-graph that is out of sync
> with reality says it exists, if it is not in the object store, they
> would want to know that.
>=20
> If you can show me that it is not the case, then I may be pursuaded
> why producing a result that is out of sync with reality _quickly_,
> instead of taking time to produce a result that matches reality, is
> a worthy "optimization" to keep.

Note that I'm not saying that it's fine to return wrong results -- this
is of course a bug that needs to be addressed somehow. After all, things
working correctly should always trump things working fast. But until now
it felt more like we were going into the direction of disabling commit
graphs without checking whether there is an alternative solution that
allows us to get the best of both worlds, correctness and performance.

So what I'm looking for in this thread is a reason why we _can't_ have
that, or at least can't have it without unreasonable amounts of work. We
have helpers like `lookup_commit_in_graph()` that are designed to detect
stale commit graphs by double-checking whether a commit that has been
looked up via the commit graph actually exists in the repository. So I'm
wondering whether this could help us address the issue.

If there is a good reason why all of that is not possible then I'm happy
to carve in.

Patrick

--N9UaJD6LlrJBeFdK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUo21sACgkQVbJhu7ck
PpQ5tRAAhqtJcCev/pIWZtgon/1ulkpVMg09qUJqArQJN9j6R+AM9NJ4MXJWeWsT
sK3TqL7zxr47Q0TKpuL4HcXac+WIvuiwDLl5AvsK1wF2Ma6GU1MzTkAUPmzfLNMg
Wzj6XL9ZnJUSucKY19CTSnr+b+GYajAicoC48V0OWewFd1NKoCsIIl/5SXc94zT+
QfzKq9/MiTCVmJSwtr+fx6Eo0W8G/Unz7Oml+1zN+TMuxTU9YxOiNJpwLazHUzvZ
OCf7lB4aiyDDiANSkF70Lmhyfqjhwsr0HhtFxMME38IXAtTEqjl0HizjnWS1Rv6L
nEYzMsO8RhhUw8qMRnhf+Joxd2oeyLsMLoA2Menh+azgcuTZ448rKohwdv3xow6k
CcYJAGe/zUK9wJWfeTXNBDv9/VxyHRLKyJZTNyRNNs8VQ+l5v7ESS8fUQgR6Qm39
bf1G7cBlPM6UcVATP8LOpu2g1K+MtGMPpOYql/g5rNgBDd9Iz+rGnuUilTxOwzrN
sKo1UozXCgNGBBNbMiuzU31D6QtZvtGy/kjFJ+a+Wv5LOCPDyWuq22ThhF90UPCi
bB5SgGFMllKZB799/RXc+lVQyg8cn/xUavfyJ0dF0NjyxF97limQMerHqu18opXI
FUam7YzVw6X2ZQbuZvw0WkzGiDbLLvj2Ve29cm20gJN4bI2egqY=
=2+z4
-----END PGP SIGNATURE-----

--N9UaJD6LlrJBeFdK--
