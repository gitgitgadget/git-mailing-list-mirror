Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE0D4C9D
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728195801; cv=none; b=LQuYMp607Nvfe5sPfuaZMyAyyNwxBEkFqKA9aRVQhELd+Bqh260B9oNQlvbMqUJsGTFD7YzARdUuCJBGWpjOBZH7SCH9+RiB+LX1PdxI9ByZrVcEWn5ngGqdgXGqxogxKM0wzezgj/dJHtF6my76J9MfVrNkDMjuaF9/Le44sGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728195801; c=relaxed/simple;
	bh=ixq/HEr7KYoTVjAzHl5K0Ln+jENcfCzYEKXSz4OZTn0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BAbXnNGCLO6w0Nnf9sE8sG2iTTOUHZOp/rF6vg4rwHs6/qTBCcTitUXcgm3+oaV3LZO7lL1QAeKPRdHMHRS2imamMY37DotNX5si5toIlDqOPFl4XBe7Sx5ZrKmRcm7ag97djJ8y+OJLNlZUTQXvbyk8z1mLUXdFqLjOSOCeGtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=b4HlnGFy; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="b4HlnGFy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728195795; x=1728454995;
	bh=6BWYtBMJ4+OOJOfwOjtCPCARz8i83gmgHmeLZvfOl04=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=b4HlnGFyASERnyhpbE+BH2d5rpTeIHaP4yM1E2PM4idG2/Fqu3bDowPMH3i0FBCPa
	 WEqXh/BKTG5FfGoKljdHNQ8K9xJ5HBVkRFqdyz7Z+6fsK4wcYhnIUJFqFJpHM03Dyp
	 51PducDZWipYOtG7mPRrpWx+0ursoOjGURc9IzuYQuBVoaXwmaB/luL2OrCOjx8blV
	 oQDRASNcKObA0TWM0Y8D6AE2gVz9u9EVMjl9Me7KS9sZOr1u6RhPQkAr6vhLfa4Kg4
	 ND3pUGq0X1H3SJaD4nW+r8AS8KEoJ95qFpcni8tWRLvUdJ6RXuz3rrkheYMVWWtrCL
	 oP0NM2TEh5PqQ==
Date: Sun, 06 Oct 2024 06:23:12 +0000
To: "sunshine@sunshineco.com" <sunshine@sunshineco.com>
From: Caleb White <cdwhite3@pm.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/4] Link worktrees with relative paths
Message-ID: <AtSpzKynOkmMPZ3bR4qx-eA93Xo-1miPCIQSxIKP534tD-qpDU1AI74vqB78RsukQ0XP5eKdvzHcwy_lf8lpL9wAoHoom-koo5GKcbrcuX0=@pm.me>
In-Reply-To: <CAPig+cR4FXsGDE9Uu04EjK+vOo-Pi_VwOub8+Dy3r9t7z8GdkQ@mail.gmail.com>
References: <20241006045847.159937-1-cdwhite3@pm.me> <CAPig+cT6LALKjEappB7QkB7oc88NyMcr40T_qJGL2mPA77K7XQ@mail.gmail.com> <CAPig+cT7CEnb6cQmAOMbD82wxkg=7T0MMW=QNUSPU62a0rEGLA@mail.gmail.com> <TEfKiit-RYyr0ZuiQszaKaM64iSonfaQwWRqExOgXyPR1tVWyAzR3kVKmCd3aREZwDGuS5VXcHjCvneY-gCg2OuZyv2N2EkfARlZu4AVSsU=@pm.me> <CAPig+cTE0gaD=7dwSqY4S+7AqRoU9yOrS4sdBoybj0Pfyk9vxA@mail.gmail.com> <K1lpl_AWj4xpiHLG9AloFDP7hkJ7Ysf-LA5H-OeP6suaBcES3WS6NTYZGX96oQuNQ3x36eEOxGdqlj3fG3ybrn5y3LRPfCNqC7yqTyvqVrk=@pm.me> <CAPig+cQE0RNLhktuja-BbF8WwZmKC3cox_GUC-o4w87PadDpgw@mail.gmail.com> <gX8RNUg1e1FCYFS1vP-uT4rbMpg21Ax07CZm5Ha7Dsk93EN6CTuXiLr3boTaoNEi71O1rDoUxhTs6KQt7Cvfz7B3KlbpZzis5b05KW7ARls=@pm.me> <CAPig+cR4FXsGDE9Uu04EjK+vOo-Pi_VwOub8+Dy3r9t7z8GdkQ@mail.gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 853d043557fe0251ad16cf17ac9a56dabfd08000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------6fb8b1c1b2a9bcccf8e579cfbffeadda2ee4ce9061c2859591d39d89807ceb90"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------6fb8b1c1b2a9bcccf8e579cfbffeadda2ee4ce9061c2859591d39d89807ceb90
Content-Type: multipart/mixed; boundary=-------------------c966835c7f0bcfe30c39fc37b37e1189

---------------------c966835c7f0bcfe30c39fc37b37e1189
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8

On 10/6/24 01:16, Eric Sunshine <sunshine@sunshineco.com> wrote:=0A>  Inde=
ed, I'm seeing the same line-wrapping breakage in the mailing list=0A>  ar=
chive and in my Inbox for v2.=0A>  =0A>  I presume that you've verified th=
at the raw patches are not broken=0A>  like that, and that the problem is =
happening at email time?=0A=0AYes, I've checked the patch files and they a=
re good. I'm also not seeing any breakages in my inbox which is strange.

---------------------c966835c7f0bcfe30c39fc37b37e1189--
--------6fb8b1c1b2a9bcccf8e579cfbffeadda2ee4ce9061c2859591d39d89807ceb90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBQJnAizQCRAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAACbrQf+K3VtmtbSvX9IC3sxkcCfqWnR8Xmami9XJYtfSbgcQKlMHjos
empLAjEOw8trI6748fvVZYlfzCa5CsU12Iw8K97SDAZxanrPCJKTMLlatjf2
69UpLMaHmLhDqxokgpEGPEbua2KgWX8G6f2shjs364vwR20iVZuWCHuMEpFr
tXLBZCxmEiU8oPYWnFNzYdNOAhGHzn6uPuFlzmSyreufHkWdc0gZWzO61TQA
UreZBWGrz1vr0deDKFGdD+VnWy9z5Lwu3Bh75zfyoaL1V7zEBWIeDA+35Nty
4cqCkeaPgXN8UIK9eBLljM3LyERENUj8KrOBqYzw2r8j2fn7jlSrGw==
=kdVi
-----END PGP SIGNATURE-----


--------6fb8b1c1b2a9bcccf8e579cfbffeadda2ee4ce9061c2859591d39d89807ceb90--

