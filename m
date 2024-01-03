Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F65D18032
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tmojUC1s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DdrF/RHc"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 7CD575C00CF;
	Wed,  3 Jan 2024 02:33:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 03 Jan 2024 02:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704267209; x=1704353609; bh=C1WV5eGU1l
	xGxsJ7ro5UzU6nJkjlQt/qJd+aOY229WQ=; b=tmojUC1sloyKJxJdLwElrAwLue
	2fwvCxiKbFTcktvy2+kQX9lGI99CGtxXP4ukiJiu7xKFTCF0uTwC612tdCaV0dK3
	UnrY6okS6e3j4vUD0/6P+6Ms55ymqVaeSkiCOq6PMxW1wbeyHqKsLZnbzQgYJWDp
	arimHp2IpUamVdqv5pjLof/wtcf+31QmMgh3x58DhjQ+XWCSkVhcfi8zbspuAa4k
	c4eGYfjbPCMxVccEMJMZoICzGt92NZ1J4QnSsY1q+vnxAHnwByrezP2N0DDJ+1x5
	E6JIdmmVbakkziWeRSdm5gTU3OQgDprFalWUaiJifRJ2RFHgkLnTcuH3bijg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704267209; x=1704353609; bh=C1WV5eGU1lxGxsJ7ro5UzU6nJkjl
	Qt/qJd+aOY229WQ=; b=DdrF/RHcV04G4tZtcxfXdbyLUmhQnzG+TQS3+ElLVNGX
	+RtH6qb/Nk+cdpZJKyUrAAuD98ma2vkM1W4CYHw+gB+CK8xwOr2nKfq+2QYKPxGM
	kfZir46Um9IWtOdrneGW7netrPRBpgo3/seLnNxRtyKq4sAzmop4W3zpuhVKKAe3
	gKBcc91duL232PnC72mZA85yHU7seJ8D132egNUpocex5qz/xhztIneodbDoBkA9
	ktZpkrR79icLBB+2e73lIKfZeqfKBiO7wKVLiLbq4qfotPOGe2bjsc9/xy+EVE85
	GBAwwZ7FrZPr8IRa05S7Ziwab3ois+nUXQvOIYUX4Q==
X-ME-Sender: <xms:yA2VZRefOVdsJc2KzUg4GFrl-uEh8F0PgS_oatCTroNfJ7cGhFo5og>
    <xme:yA2VZfOCocsNjX65n8lKia1Jy83PikOYaBLNh6-dBJADsTeUZA0mtdU7zARB7YFpt
    aVMVAuP1CeRtcy5Jg>
X-ME-Received: <xmr:yA2VZahrzzi2KdImOC-pp1EOXHGnZRjTMixlhRuC3pN1Q1jb7SmbaddSOPh6BnijFej5ZFk03SNNdPBZKRvV3fPbDtH_10KFoOtgFon97E8ITQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeggedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:yQ2VZa8yzb5qYqsotehwtB7Pre-HjhTxEd1E3b7cLbxblmyXNnAltQ>
    <xmx:yQ2VZduSf1B6eMcIrdiRKkQLTNz3HQ3U2VleSR80ZGpxk31WHxh-RQ>
    <xmx:yQ2VZZHlDLG_pV3fYm3uIDTVj_GyByRHMGHUy1qhvJTMWOp9ApIgFw>
    <xmx:yQ2VZeVEkCossLxrBGCYHoxXo75S5PEgAam0sUq2RulRxli1m5dNuw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 02:33:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2719b46c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 07:31:00 +0000 (UTC)
Date: Wed, 3 Jan 2024 08:33:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
Subject: Re: Concurrent fetch commands
Message-ID: <ZZUNxNciNb_xZveY@tanuki>
References: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de>
 <xmqqy1daffk8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qeOvRqTVEbT/cmJo"
Content-Disposition: inline
In-Reply-To: <xmqqy1daffk8.fsf@gitster.g>


--qeOvRqTVEbT/cmJo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2023 at 09:27:19AM -0800, Junio C Hamano wrote:
> Stefan Haller <lists@haller-berlin.de> writes:
>=20
> > I can reliably reproduce this by doing
> >
> >    $ git fetch&; sleep 0.1; git pull
> >    [1] 42160
> >    [1]  + done       git fetch
> >    fatal: Cannot rebase onto multiple branches.
>=20
> I see a bug here.
>=20
> How this _ought_ to work is
>=20
>  - The first "git fetch" wants to report what it fetched by writing
>    into the $GIT_DIR/FETCH_HEAD file ("git merge FETCH_HEAD" after
>    the fetch finishes can consume its contents).
>=20
>  - The second "git pull" runs "git fetch" under the hood.  Because
>    it also wants to write to $GIT_DIR/FETCH_HEAD, and because there
>    is already somebody writing to the file, it should notice and
>    barf, saying "fatal: a 'git fetch' is already working" or
>    something.
>=20
> But because there is no "Do not overwrite FETCH_HEAD somebody else
> is using" protection, "git merge" or "git rebase" that is run as the
> second half of the "git pull" ends up working on the contents of
> FETCH_HEAD that is undefined, and GIGO result follows.
>=20
> The "bug" that the second "git fetch" does not notice an already
> running one (who is in possession of FETCH_HEAD) and refrain from
> starting is not easy to design a fix for---we cannot just abort by
> opening it with O_CREAT|O_EXCL because it is a normal thing for
> $GIT_DIR/FETCH_HEAD to exist after the "last" fetch.  We truncate
> its contents before starting to avoid getting affected by contents
> leftover by the last fetch, but when there is a "git fetch" that is
> actively running, and it finishes _after_ the second one starts and
> truncates the file, the second one will end up seeing the contents
> the first one left.  We have the "--no-write-fetch-head" option for
> users to explicitly tell which invocation of "git fetch" should not
> write FETCH_HEAD.

While I agree that it's the right thing to use "--no-write-fetch-head"
in this context, I still wonder whether we want to fix this "bug". It
would be a rather easy change on our side to start using the lockfile
API to write to FETCH_HEAD, which has a bunch of benefits:

  - We would block concurrent processes of writing to FETCH_HEAD at the
    same time (well, at least for clients aware of the new semantics).

  - Consequentially, we do not write a corrupted FETCH_HEAD anymore when
    multiple processes write to it at the same time.

  - We're also more robust against corruption in the context of hard
    crashes due to atomic rename semantics and proper flushing.

I don't really see much of a downside except for the fact that we change
how this special ref is being written to, so other implementations would
need to adapt accordingly. But even if they didn't, if clients with both
the new and old behaviour write FETCH_HEAD at the same point in time the
result would still be a consistent FETCH_HEAD if both writes finish. We
do have a race now which of both versions of FETCH_HEAD we see, but that
feels better than corrupted contents to me.

Patrick

--qeOvRqTVEbT/cmJo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWVDcMACgkQVbJhu7ck
PpQitA//Utcz4SmstkZOpgVw1Idt4EPQ89OItGg+3uXr/zKMGmCN2m9Bqn9FQJ4f
Ckv0y5lbsXQsqlLYV7Z45V2rtsQKXvIBYQLOP3NPT63y/MNXLpc138yNot7BZ6M8
4cwEFIj4CicfQQeFpMWUDZ1gunzAZ+axtXOPH0gVXGbkJP1Fy9VQaK5u0DRQppHx
QKhKiA4CRo2KozTCv505qLwPN9D3Tq9E9AmE43zat6NeHMKSOSTBz+jXSLf/ccHT
DY/H+T+1jBM6CeZuXI3iA8hGZhjqFyaGkEF2CaUSYHepgFG23hafoCGTvN4NFRPh
jM0IkMcSVRIloRjDEMDmO8BcK+PXPGzXjFt85Z+MW3vh1eoSKv/UzLk8LbYESAD/
I19HX4X92N0EtgYKqH65eB38CdmEvB37019HR+UhdnfuSuJtYoPsNwZ/4fU2i88e
3uM6SboABI4b2N1ymEYE2WmyJkzay85l4y78zSL+VAkbcfmLs0L/U176Tee3RhLE
qppWew+F5QVFavtJ5X6+wTfFJUAr1kFHUgLTN88SeMkn929eGk7Rh95PXe8O3GZ9
1tS9Gmw3wmQayEz/wA6rXMW3dJ3FwRGV77h8zgDgfZe92k7ngasQDztzlchmFoiW
aXD4dAZ7sp5VbsNccIvQVBt9fh/aohRF5iNyKeahS8fKTdBb5Sg=
=j8Z9
-----END PGP SIGNATURE-----

--qeOvRqTVEbT/cmJo--
