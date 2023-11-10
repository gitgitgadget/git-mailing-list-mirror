Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A2413ADD
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s7kXXsa5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ioIGOATl"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180CE28110
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 02:18:39 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 5CBFB32009C0;
	Fri, 10 Nov 2023 05:18:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 10 Nov 2023 05:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699611517; x=1699697917; bh=2E
	BTFqHS1m6/SS6HEMCfwcv9oN12XnAFAXvz47wv0lQ=; b=s7kXXsa5o0oC6IJdll
	1ME/sgFz1pmVAUORmtHjNTYeWIevpm057FMflMKYU7A+hNfaXwm83G6R5vWbE4oO
	qXfeitNgtpoSK3AJfcR0bbA5cE8ihaYBM/L2gDg5QAu9mtazwrKRtYAvEUeNbYqk
	Z3K1B90d4vBnhWeUr6S8DVlAaTN317UT3O68A1rAStf4qMcH/QeuVjECqHMfWZBO
	qAHC4tLumbeaHuK0QNhHQW9/6xpRPbE1WpiF8iGm5YPdpmeYEjA92247hkF/EV88
	5f+VcdwGTh3FwYJUx1vZNyIOffb1FzQZRu/QJKk/o/5/lNpnun5NFG36VEA0BAL9
	ipGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699611517; x=1699697917; bh=2EBTFqHS1m6/S
	S6HEMCfwcv9oN12XnAFAXvz47wv0lQ=; b=ioIGOATlr/sEyRJhjQOBWG3H9gOkk
	X5zIbsMX8BYtCqcdvxESL9mkqhN/sAlrgQtN8KlPNVQOzbpuzkQ+0LyT4WOUKMPK
	k2HAOZ0O0wVszcTCfI7zYYR4qRhde7fy34MsPu7V7ypfU/pujij4Q/Vt7MraI9ku
	A9mgDA7s11Ivtb0VDkx8lZDTr0uRKSvUkYuGNRaI1i58YmBVgvi9qPQ6AUKvqu9y
	k6gnc9t8+FnkMTAd9YDHaj8FSY1lOmC3IM+FOoJgEuTM6Z9s1ySHX+e/eBx/pxiM
	ADaI5yztCUTDiJA7UT3O7thfuNbu9yDxePlfI4c9Vz2HX+bjvRgeyLfBQ==
X-ME-Sender: <xms:fQNOZe7nS5YQq306zEAZ7wON9MDXk8pAQiedGQaXppn45kKcTGjSqg>
    <xme:fQNOZX6wD6yaJPkPQKfWyiwsaxBmuD94-8787DFbtQ18eQ7z15NU-eBuo3oliPb_J
    zdst3AGkno21SKRNQ>
X-ME-Received: <xmr:fQNOZdexx0rddt9t0AqLomxk0BPYbLVvBGHTa5sZZORWDbjrZJEr8gthAwQ25Z-V3QOBb5ZD_L8aCGI1AiJVKmwAsrnIf2P9WgekdLPzei6w-BBs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvfedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:fQNOZbJO5em8m2XeslcnvRh9a-eAYtpmO9rJ5hydXtvVqNvaGLDYOA>
    <xmx:fQNOZSIysr-1D2hGWa-u_EImMSfMhQ8yaniCJ83RcgymbKoDnIGSZg>
    <xmx:fQNOZcyAKOwns94KVT5N1vGVw0OupXwClQ_wTl2FzdiVTitMCxvBdg>
    <xmx:fQNOZUi-gJuwzA3GsxAk9mebn1pBNf0hJyD__cp3tFym6Q1158SQDw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Nov 2023 05:18:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 90b824fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Nov 2023 10:18:06 +0000 (UTC)
Date: Fri, 10 Nov 2023 11:18:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] global: convert trivial usages of `test <expr> -a/-o
 <expr>`
Message-ID: <ZU4DeaoGMLGJXF0o@tanuki>
References: <cover.1699526999.git.ps@pks.im>
 <c5e627eb3fef0df162da56723093a03bfd2321fb.1699526999.git.ps@pks.im>
 <xmqqpm0jyx02.fsf@gitster.g>
 <20231109184843.GC2711684@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ybxx4t+0yuI3bxNs"
Content-Disposition: inline
In-Reply-To: <20231109184843.GC2711684@coredump.intra.peff.net>


--Ybxx4t+0yuI3bxNs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 01:48:43PM -0500, Jeff King wrote:
> On Thu, Nov 09, 2023 at 08:41:33PM +0900, Junio C Hamano wrote:
>=20
> > > -elif test -d ${GIT_DIR:-.git} -o -f .git &&
> > > +elif ( test -d ${GIT_DIR:-.git} || test -f .git ) &&
> >=20
> > I do not think this is strictly necessary.
> >=20
> > Because the command line parser of "test" comes from left, notices
> > "-d" and takes the next one to check if it is a directory.  There is
> > no value in ${GIT_DIR} can make "test -d ${GIT_DIR} -o ..." fail the
> > same way as the problem Peff pointed out during the discussion.
>=20
> I think this is one of the ambiguous cases. If $GIT_DIR is "=3D", then
> "test" cannot tell if you meant:
>=20
>   var1=3D-d
>   var2=3D-o
>   test "$var1" =3D "$var2" ...
>=20
> or:
>=20
>   var1=3D"=3D"
>   test -d "$var1" -o ...
>=20
> With bash, for example:
>=20
>   $ test -d /tmp -o -f .git; echo $?
>   0
>   $ test -d =3D -o -f .git; echo $?
>   bash: test: syntax error: `-f' unexpected
>   2
>=20
> Without "-o", it uses the number of arguments to disambiguate (though of
> course the lack of quotes around $GIT_DIR is another potential problem
> here).

Right, let me fix the missing quoting while at it.

> And I think the same is true of the other cases below using "-z", "-n",
> and so on.
>=20
> But IMHO it is worth getting rid of all -o/-a regardless. Even
> non-ambiguous cases make reasoning about the code harder, and we don't
> want to encourage people to think they're OK to use.

Agreed. I'll amend the commit message to say so.

> > I do not need a subshell for grouping, either.  Plain {} should do
> > (but you may need a LF or semicolon after the statement)..
>=20
> This I definitely agree with. :)

Will fix.

Patrick

--Ybxx4t+0yuI3bxNs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVOA3gACgkQVbJhu7ck
PpSRTg/+PR7pIC4YoiVg+rRDn/fQNhJABUTZzrbntTdux5bSx+yQS/vWQTBX0Ppi
YkbzpFO5d6/5Aymvpr0jS1iHs6QikTimge55Z/EAIJal7wo9O/v5MwaUFJWTGZot
Ui+mvXsM7VcjlFKKFmHSZ1Va2pfhN18ZQMYLuAOyAM/+0DCiWK/uYhq/RJpAXt2a
69+h4UGgTH8e51/ZDLPztAlTzFvRPjvR4Sz6lU8CacYmtIZ9QRQ4C0fsWPZ8T23A
tKx5MAM4ALVyYpszJQVKauhGKQYbGGUDtrfcHBiZ/miQwtu2F1+IbPBGjpY5vINw
5zwIZ+N332wq3HvzkKXmnIb5s/92yBFha+uzkGOS/p4IHIo2OcdWfaaIU67kYmsL
lkMUBkEWn9zu9hrzip2QWXZ5/YY+TUnZxbLRyVA4CTfyRuyzQxylgNW37/SXPpKP
BUauROx/HpRoIZfw55YwvJdLnO8V7nrlVl7R0caz4A8r1UaKjTsnHE8KlanUA6XS
Earzyx3yn3vF/Cg4+hS9rven5WSP4goU7cTL5Ntt9Pfdgn8xnsF3yDhTKPMhYclO
/yw957QQILBjfaihkoLagKTru6ubVt35DsDnc2reEVK754gusl0fG1LKVHa2s49x
Nr6Vc/0R1QKQayZBT1OZNTx1REGg6mCi5QGtpbpoXROjWccPoVQ=
=iPuD
-----END PGP SIGNATURE-----

--Ybxx4t+0yuI3bxNs--
