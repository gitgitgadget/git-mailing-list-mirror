Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122773;
	b=sbkMJNgvhcaAyBAyFT/oqbifOhbXMrYbnbuLsdHbOaX1aHQDWbcLDqQKQh4ezLaYy++8
	 FcDdt6L7lBHtmtcy4MeBZqqUf2NbW+/CRbtvs6kpV6GjZSxfCqt0sGcESV6n0yp8u9GHg
	 VL/TyZchtej3zwYTuo1p3xMgAvJmI0xUuGU3IgNTjL3DvcaRfRFIC3kN2qIoQbpb5JgCW
	 YvEa46G/WVK/PgOOtAwzcuL+6aG7EXdzK0GXCTYcPmn76G4PjhGJOaQtkZTYxx92W9QaC
	 3VoXFOEcu01NBqYhkveTSLWleRfHw9IKJbFJqFlc5mwczKS7I9CYFuqJdXWRJOgjABA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122773;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=WcR05aavkt7jzvs8lhsG+juV6Z/VVkuvgoxBGz2FvQ4=;
	b=KN84uwYDhRZMlwqLcekAKf2UfBIxmhKwHIoWRMMbMn5Aca/ZPY9yK6DB0wSfzOfi0z5l
	 VZHmmPkZ97j0JVCX2v5FbOmv9gxHDmFte24ds5csF1FdMifnw6uKJSLVY6aZ2EpozEItf
	 hexLzjfNi4PQEOszXkVHXVBWbAT6SDyYc01DYwZtLJYqtlBTMnX1I5pvX2OrDyYZJr9dK
	 Nrs3vAeBbyVN+JPAg/b2ZVLfk94rL0FYDHbYVxQef/dgjWBTKuYQ7PPuW5mJ65DJC/P2/
	 ZOE4LmBCUFDOHVDPPY9Fx4irhrrRLHd2xYJ7pbsNw2gvMNDT/+NshV7PF8JSu02Po2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=C3KKzBTs;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cHdUe6MD;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88855606A31D
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88855606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=C3KKzBTs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cHdUe6MD
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id DCB611D00123
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 13:39:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 27 Oct 2026 13:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793122771; x=1793209171; bh=WcR05aavkt
	7jzvs8lhsG+juV6Z/VVkuvgoxBGz2FvQ4=; b=C3KKzBTsothb6J1TM/NklELhZk
	d0tbUhbiR6HkxHcZvq6D7DbsV9dc3CA16Il0ctPCOUhzEIspye/Ro7sCHrhMxZfM
	6KCr+Dol9Nf/KznNtPbtoXrEfYp2GfYhvAiFQzBY0Yw6s8poC6tyBQIXzjagsbO4
	Fp7a5AQIpoyWGWYAiKrHrCa9tCZywx9+rIzN/TQu6h4QPq/3Zz+QS9/K5ApgpTbX
	35f2+CQbZNFqmAC+JDoKbNdNIl/aBtbKz8xSQUjnUXxMwM1CuAtK1a7B09QWtwha
	YjhQGHwP+B+Vdsk5P3aE4ZrbQVQYmzEH+8decm4oiSXeDcG/07vUpMVpXkcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793122771; x=1793209171; bh=WcR05aavkt7jzvs8lhsG+juV6Z/VVkuvgox
	BGz2FvQ4=; b=cHdUe6MD3QZSiSOXZIj2i6Dj4WnZPZk3sKuBrT2j9P8e5rltZZS
	mXFe2PnedVW98gYfWXNPLuaR/AztmuxeFsNqsS891SJoGHuyne0UyEVbGL4Q7ubm
	gbcnqw3idZtxI0txDH0s9ta9re+f4X3Oq+UCJcWpGxlZgf2YvhkO5uBUJPxK8fSu
	WPWf962FFhouqeZK19VQuIkeNfkfhEEybf6iGoDsc1c9JWLKvx8/2wgaCnM6Vdvu
	lHA0L2IR3KrVUEJ/wzkM2M3lnRyZH3uui+Y/l/yhWHuwOB4uDCVZ5fTZ5KmGd6Ff
	NYmShcIeNxx2bkUsy+PcqwBSLI/JmhwP0nw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793122771; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:oKFTBbhMmleGcqi2g96LlEDCH306+MwiyY2gzhSgIBgn7rr
	D8I4/nIk3qtEKvqFOBXAb3FV3fTbuOvnFsph+JGXIl9e1U1jMLu9JY4egShaFJOj
	xm76MgAJSWOK00l42WkvXeLIE6vr43SkR9xuYWJ6reWi40MRPr9qbbTGb3c3T3IH
	MFsIC69S5cEaYMu4WtYlhwFL5eMIbMMbkkcADfaQK4DTs7E1E5RJiH5tmmBla9Lu
	8KTP+9cESqJSpm9lUK9J8K+y9uSnBS1OGo4oBmPG/A7CruwxBts4OIyEnugNxOif
	3WAIXlTUky/VqQjPMDTYFen/m4WMcxfO8GWkWJA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:vQPk277iw7tYVVSvqSv9R2Km1g70SCphFs2nimBMr1c=:t447fFJtPyd9LzIYsbXT+f1X2mgb9QTjCZcIfQL4Alg=;
X-ME-Sender: <xms:0-HgarziVbISn-Lf3hO2dxtXpRJVChKANUjv-GpfGQCXw98PJ2xa8w>
    <xme:0-Hgalh2ZCSbjSCBExnb75_cq-XfvOuXxzbUJnUm_pyfHpeaaiwLaqnJVAR1fq5JM
    ujDOvp9LthWTD7FKi6PZxo1ScrbeXRMl7WMtQCp9nBWHhvrfdsmsAI>
X-ME-Received: <xmr:0-HganlPfRUS-FWus-cI8taSt0tXV6S8bZQqV9FinsiFa8OSQ0Yx7FnaOtyHSTPTfJ6J5DA9v_Kn7QiIBHhoY7GWAMFZyl238qqW>
X-ME-Proxy-Cause: dmFkZTGOVMqF8OsEllURrwAlKTayKkW9uBTHzSKKqwRn/2yWp4AcU264DKx3dwMTgvcCge
    l2xMW0K7LeU3R26+26HBw1rEkrSUC9oKrAzNeCnJicsO/u/0cCf8ZDEBhbp5KNz5p/hsF1
    3P87yOFrOEJwIq7ciQzBRfCyx1DOLS0FEVFf1ysMpWycfBYA75r8YfAhgDn3HbWah5sHVR
    zUyAwsHD/cQjxnDMkGMl/oj8UyhD2qdGo8MDiuoYTlxo12z1tq++iEJJ9C9QadUfLvPfZl
    5SopAw4Pq8s8r0iAHiF/Py+8CTUB/FLg4t5SRdtHwvxx8A39+w45XRC6eZgepf07Fu18fP
    Yx4W/iofhIuGv/sL3aLEZXsxAS1Tc6LkOxrvkXOvrGDhngao6B13CVr2xznR1vmVQ6TOf1
    Xrq/Xw0GMEGZzIAA5jiX164YG6bAN9D9hDBpgOODv6hNoBZltXHrMenGHk+QJFVMLy+nit
    /EyCvWzYt/hJRDpQbMM09YvQiMUQpsJxLcBlp2yIjupEx7wNl8pJIwHRJirM1WkL6zumcF
    qBsOzXaHJ9NdQ6PovCv3K/8OI7zrt8KlW+taWwA38J7UwZDj3ShrQKVa0lur556rp3KjXs
    gttGmY9RlCOw+XsaWSqLpIWCv6VamLI9Q6sXS0aVAH5Nvcd2He+CZONoT2qQ
X-ME-Proxy: <xmx:0-Hgarj6_HttreAFpMvyCJDwNNl8MUVJxpr4ghQ14NdW7gKTVjY4gw>
    <xmx:0-Hgar3kTA0WAoT11rpovej2ESQo-av8OEeX1hVRKh6x7siuCTPmhg>
    <xmx:0-HgakKSyNWPOXqGm6ZlO3aU6WMfNINWIySBPvyfCvBlQ2H2aYiC8Q>
    <xmx:0-Hgarztf75BhfNn62aWMzeLlw64X6DQiaHHo1LLtuQf3BOc9N9E4w>
    <xmx:0-HgakKzv12kEjNpMjfsiiHnfTdm-Rg_cMyMddUrlGKHpeF4xsuN_JOP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 13:39:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Adrian Ratiu
 <adrian.ratiu@collabora.com>,  Jacob Keller <jacob.keller@gmail.com>,
  Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] submodule: make '^/' work like '../' but with an
 absolute path
In-Reply-To: <20260929185122.3127574-1-lightofmysoul@gmail.com> (Stanislav
	Aleksandrov's message of "Tue, 29 Sep 2026 18:51:22 +0000")
References: <20260929185122.3127574-1-lightofmysoul@gmail.com>
Date: Tue, 27 Oct 2026 10:39:29 -0700
Message-ID: <xmqqmrrzkppq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Stanislav Aleksandrov <lightofmysoul@gmail.com> writes:

>  Documentation/git-submodule.adoc       |   8 +-
>  Documentation/gitmodules.adoc          |   7 +-
>  builtin/submodule--helper.c            |  39 +++--
>  remote.c                               |  61 ++++++++
>  remote.h                               |  15 ++
>  submodule-config.c                     |   8 +-
>  submodule-config.h                     |   6 +
>  t/helper/test-submodule.c              |   7 +-
>  t/meson.build                          |   1 +
>  t/t0060-path-utils.sh                  |  43 ++++++
>  t/t7427-submodule-root-relative-url.sh | 190 +++++++++++++++++++++++++
>  t/t7450-bad-git-dotfiles.sh            |   5 +
>  12 files changed, 366 insertions(+), 24 deletions(-)
>  create mode 100755 t/t7427-submodule-root-relative-url.sh

Jacob seem to have had a reasonably well informed convesation with
you on this topic, and I'd trust his judgement much better than mine
on submodules ;-), so I was looking at this patch to queue.

One bad news is that t7427 is taken by another topic in flight, and
this topic will break tests when merged to 'seen'.  I'll try moving
it to t7428 before queuing, but when a new iteration of the patch is
posted, please make sure to check (1) it applies cleanly to 'master',
(2) the result of (1) merges cleanly to 'next' and 'seen', and all
three pass all tests (not just 0060, 7428, and 7450).

Thanks.
