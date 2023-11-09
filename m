Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C64199AF
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jOLji6r3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wixc9MOk"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782C92590
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 02:53:49 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id E33775C02EA;
	Thu,  9 Nov 2023 05:53:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 09 Nov 2023 05:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699527228; x=1699613628; bh=jz
	AcxQy2WYq+p5Je+BJ7NS7xX7ylyMJIJvRiIR7HjCw=; b=jOLji6r3MO9RMe9eaA
	g7NqsJZwvbfOaGJi7rhL1U0AwhMhaVXIsXo7FowHeOzni4ZZGEXBp3cyDTdq0oMD
	XM+VtnV4naBl/l7o92wgkPJBbFflZp9GDPi7LMxoG6w99lhGswipJr2i29jxxBup
	oHOT9nnhkYY8SRmkSFwselw9tdvtFyKk4LwOsE0Als9r3a9xEeUKzcwmqFk/Kswj
	Y+go/Rwdk5n7wJLG+GQwsopeDm0t4vWvfWzZ7bRDONwSujqG7fhb6FaOnJfCcU45
	fnzXAgZMkeTzosVp4fzZGXzBbXXdNXHm69m5VlpSuR+3KWavhZlw9eorddXllY0q
	jaew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699527228; x=1699613628; bh=jzAcxQy2WYq+p
	5Je+BJ7NS7xX7ylyMJIJvRiIR7HjCw=; b=Wixc9MOky9NEkXFINXwId2jbWO3fU
	kd5aPyl5bMORZvYP5KkX23zAGuhnDRuIPu+6RRcnWc91v8TDgVCerJ23ckykDJkr
	DifajUrsheLhElsA8OVtc0iWaPiOhDWbbewXf7zusK+bDUUp7KBb2AJ1fIjHs3Bq
	SyMyYZ+iRncbzm9LsCtpCrcKJg45U0OMMwrdSx+O6FlNhgXd6CZYARQlJVRdmZMq
	oM/5Okz2BQwMjqQdtXk9I+7n0QUTbNLLrnlt0yh4yRmqRlo5lM2SfeH9S6sIe12o
	uuFAYh/EQCI+1d7Heaj6Ck0H+PfItmcsGA9DK+TdqDlG3V1T6xDQBmgfg==
X-ME-Sender: <xms:PLpMZfJcrZu5B0kqfmdImpfJ64hOPdfWc29gOAUE00E7fQbmJIzJ9g>
    <xme:PLpMZTIbYN2g_d4-GIVkcRBtFrL8ufJJaTE4LMYtWZ8T3Knc_tln---NYyayP1Uts
    qP5MKkHD1NrKHRkAg>
X-ME-Received: <xmr:PLpMZXvY0v-PnfY6DQkmA1sN2Rlu_kSVonUk78tFQS37Awt9QpgprKCZz1o-MqgPTvTWCL33o3wZXueBaaEIQ1Ksaef329d4-6s10pObgMbMB5m2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvuddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:PLpMZYYajNtZ9cUfHhkkCZsUMyW3R1lS71LmcjfTowvqoO3tOns09A>
    <xmx:PLpMZWZzRz4my9CqpME7M1d55dzgSM5WDdvZyltC6p5Pu4ynEdpuPA>
    <xmx:PLpMZcBiCA1sp0lZL2gJ1GU-hHuSKHQhUUQNB6u1dVY33a8ANwMMhw>
    <xmx:PLpMZZywPXxTgbU463mMjPFIajl956JgMY7b__7IhIiPfV8d0x_lMQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 05:53:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 738dddd7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 10:53:20 +0000 (UTC)
Date: Thu, 9 Nov 2023 11:53:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] Makefile: stop using `test -o` when unlinking duplicate
 executables
Message-ID: <bc9489ca5b815b1a83e24771f1d7449b865a7e02.1699526999.git.ps@pks.im>
References: <cover.1699526999.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R8xWEazQuOTQ9vF/"
Content-Disposition: inline
In-Reply-To: <cover.1699526999.git.ps@pks.im>


--R8xWEazQuOTQ9vF/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When building executables we may end up with both `foo` and `foo.exe` in
the project's root directory. This can cause issues on Cygwin, which is
why we unlink the `foo` binary (see 6fc301bbf68 (Makefile: remove $foo
when $foo.exe is built/installed., 2007-01-10)). This step is skipped if
either:

    - `foo` is a directory, which can happen when building Git on
      Windows via MSVC (see ade2ca0ca9f (Do not try to remove
      directories when removing old links, 2009-10-27)).

    - `foo` is a hardlink to `foo.exe`, which can happen on Cygwin (see
      0d768f7c8f1 (Makefile: building git in cygwin 1.7.0, 2008-08-15)).

These two conditions are currently chained together via `test -o`, which
is discouraged by our code style guide. Convert the recipe to instead
use an `if` statement with `&&`'d conditions, which both matches our
style guide and is easier to ready.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 03adcb5a480..1094a557711 100644
--- a/Makefile
+++ b/Makefile
@@ -2342,7 +2342,7 @@ profile-fast: profile-clean
=20
 all:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) GIT-BUILD=
-OPTIONS
 ifneq (,$X)
-	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS=
_TO_INSTALL) $(OTHER_PROGRAMS))), test -d '$p' -o '$p' -ef '$p$X' || $(RM) =
'$p';)
+	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS=
_TO_INSTALL) $(OTHER_PROGRAMS))), if test ! -d '$p' && test ! '$p' -ef '$p$=
X'; then $(RM) '$p'; fi;)
 endif
=20
 all::
--=20
2.42.0


--R8xWEazQuOTQ9vF/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMujgACgkQVbJhu7ck
PpSK+g/9GS3ZLKN5iZSRnOHu9KbP3gMMS8qHnEpErqqLVjV5yww2chJa0DnrvO+d
rk8L6+zfD/Rm7MFngOMxjhD37Ji5NcCqomOvKnjLS15HpetRisqYlNLeuOt38BsN
78xiLsQEdVJGOz2GJ+9nZY1MiKxqcG3/pku1sWgd81v6F+PMkPe2+RybIQp0rOkL
jCpbYCTMuXxCZKrYX0p2gAwJGSkjKGxfJHxvNuN2F3GavLahjhPgGO6kIPyoilY7
oWikpnngWihrJWga5t8IjCJgvzMKwRmOC08WnbpFmM48A4zDw63/Rq8ssw4JGptC
KezFJ1nc0ngfY3wuFPnMbtu/4NmsB6xSNFO6fcmik76Mns3bfBqQquIZZc07MlvT
nFvym0J5QE4QMyzBbW4PhhJnhph9piZNJVzXQvhaaRzdu0vuL/jFgZVt/LORQzmi
44FsHpsh7UKGsb7xA/NC4kZc5dyzX9yMuH6XRZa9mOewWth355mI+QPz0emP1Thf
G++WOcQBw95gVYr8zcnkZQvBIZNh8+ln0UsSZbr0o9C7KuBCyaH64zDzXE/F3flr
fWqoRNKL+g6dIS/YJAtqzTh3hwleP1gpR2XptEOQBckP0iKSTvVXU22DUFz2ImRl
FlLPyvPSx0zzZLtglcrC/VYv3FUCZBs1I91DDjMQw+VnwBKCNcw=
=gRhb
-----END PGP SIGNATURE-----

--R8xWEazQuOTQ9vF/--
