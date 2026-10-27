Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106900;
	b=gV3xdL3hSWCelPpEE2+f17WZhbTzPTlAqSrBH6bm0OrvfCSTvIcyGbf2iTOo9F3+3YxI
	 n/mbqKHTtl1Hrg+2JUJzcqMwVtC/8Cud6vG5vFErH3b85YWZtCfhOeWUr0LhXjEtLbYGi
	 5ONx5F9DAUvCsSexBFhYgy1e/CkAJce4+iZJLLCdI5DvLM/lh8c46klkH2BEuyJ7xrbTN
	 ENx8Ri7yrgV5MyChmP9bvDV119sHgO5BBVsZHOf/X8ryo113vmIo1OlbQu51wB1S/1VAq
	 mnoZJyd8rae4kXinz8l3RH0u83FYQVq8024aEDn39xvhYQt1ciKxrZwyMCBaAKpwwAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106900;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=XuTPU5kN7I5gXc76SSGceDsh2o1DcNOuPQJxtp08K74=;
	b=TZuau6bAtAOL9xlQ+VZUJTzaGS+kozOCvREmMtha2rdGERGgtfgZBLAg1Qlnnkc2lnkM
	 pprwmeHTJoi1QGypA6D+xjr22TDDoAUcMydJIwgcA4tx0aye0sQld09RUf/jpw9fGsaa7
	 xeeXwxKmaLndOnZfmZewg8lg2XbcR6PYtF5o9AMXMR+JrWt+3BHELA4OTmsAc05wFcg24
	 KM0HEspE+K1IC3D6fOJFR4scSsA9HvSGZQj3sKGQS/k+wDU5wXPRLSrrSgSjesW8UJNZ+
	 7o08GnMIOChK1ZBgjnibKGXy8dXOUO3WOIJx9iBjdIB7KjoqDY2EgWPwHVuHqX+313Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ovy5PAvY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=nYxj3Y5x;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5C1606A327
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 13:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E5C1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ovy5PAvY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=nYxj3Y5x
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 802A6EC00AE
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 09:14:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 27 Oct 2026 09:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793106899;
	 x=1793193299; bh=XuTPU5kN7I5gXc76SSGceDsh2o1DcNOuPQJxtp08K74=; b=
	ovy5PAvYQzmHaC+X3WK+enLVU1YN7OWVac1AxtH/HvhIsW5wmm6GATCn6JKMAFt/
	/cH4Wy7aeq+tGbqBzD/IYBkDHzbhIthVTQX6rFqsfe8cUJVvYU2BWxfdsMu1AnCA
	+5MsOHfpj0VAp8yBlrFMnD2uXs3QoUQavmJGbYPhi/BeZwuyfMoVOiG2lgXgzaNS
	txlY1zP4BaDlcYirp4uxVvEjBkhzFmalPbWZ7dDZ2S8843GJGcFCExKfSH/mGLA0
	fNSd2ez6BH84tw6/PvY0D3zkw319IhlhY4MGCDO1+DrhQNHzF+qC5yZnoRC6aQde
	y+KvljoTZ6y0zBv/VWpbGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793106899; x=
	1793193299; bh=XuTPU5kN7I5gXc76SSGceDsh2o1DcNOuPQJxtp08K74=; b=n
	Yxj3Y5xvPULhQwZOJNPa/tW1BLM+oHzWY5bO4u7RFPR+TILJNDuMH/dPDC7IfDsv
	R1Iw78ksd+hn35zZDZ98iYFkyj0DtFVcmQUUsxsCozAzNb80OLT4HytxO0yTi6F4
	FkHGdJjTMRImc8n2oghuPvhou5rFmkYOhE5Ra7inrocsUU12yU10oCmhxVbBMoYo
	Eh+/0lObeKUH+WRWEqmjn4l0KNNBtUEaP5v37L9rc8kg4ejFUFPEZtH2yJWC+K6U
	BHoVuP0FnytVVM5VEGv1dVAFQDHJHjon6QegsFgSH/W1RECown5etG+IYbnVctBU
	YuNTK/zV9XmK5xpSvMhTQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793106899; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:OOy193jb+gHLeXksJCcsKY2WoBXks7Lmubo3+V2OBVB7CGE
	14mYROGRuKOFLv+ISZfrqIA0IkZgHbBaJTfwKEExhXS2eSdf2R8G4Q8NAuT3vKkx
	IPaVPFvRRqLjqnIjDA/tFhbcnqXkZTKZuu5BLly/7vY7OWfFAEQUqOLiwQ4M0e4t
	ZhTXYp+eMRLMZqZrKpc/7qQtMuykBCtqQQfunYSVqkQqReoKE52DLvTknSwUDC0F
	FR3l5Hpgge76wWe6GNG/trQljebSpyulxlvXLVE9Joa1Eg8r9LEuY4cO2lEzs8TF
	VI1+d0mWXOoWCK0eb5KFPBxjGrHEnea2ybzE9JQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2cHh+dES1YMKhT6k1JNpgQ455jCINaA3Xc5gbXSmLBY=:9u2WPm8MzdcNIHBBOyuoPsowmrO92UfvywtVksgsOck=;
X-ME-Sender: <xms:06PgamQUTKUiTTFhYNY5GgJpIEWlycGqan5GDZUHyr5vnGzU5MByEQ>
    <xme:06PgahwmehgP-v-r8B12y7BbWCI9HAzIbxeWVCCiWCstspyL9W-HicbnNJff0cqPG
    BGGY8Mi8a-lGAGRs7cqIaK6XAQKkwYTtjI6udCUlCg43HHv0MMZ0Ns>
X-ME-Received: <xmr:06PgahdYWMgOjgr03MdiKF0XFJue_zCCTv4Yn4gd5zQQqTx87Lilaw>
X-ME-Proxy-Cause: dmFkZTFVDB7a424z9+9c5Q+0xM/4zsAPdvGqj3tPcsZZvMMFjLW4E2EZaQWUlXmb74d7us
    Q9LeblDe5EAm/+K10U9QybjnDhGb+7fr5imsIaZCaZD8l6gXTEM8fxMYV0k5tEjyfxJwU+
    1RrGzGbNHHyDZ17RjlQfRcoZsIhZDBIgysHYRWzbAKBDUr2HjkSLUJ2Zk+xFg4K09m1hLg
    qXIihG9T4EhRHTuAM+dg2dchGiCAFRwi1dRsEDupG2ZzPT3YL2tTgOXL0YSeqBIoCIMCFJ
    6so376PkuImwScgzpG5GCMt76SdwS4Tg2RdJ6spgTu/Ra9wi1Et+1b3a7tGjDeRyQJFxhE
    lrmSBhVWwpjl1KupfcnI1+tB7cdrQlW3qX++ZoaPQDJ/UIylD23MrkBqJ3i3CHf51sLD2c
    UV+cYu5pBkbvs7F+/6PGJR8Z/ONU8QhAI9u3OoqXZMZMU9wH4XwQCnVhrTV+7le8vDSxcF
    UILq+w01gIwI0KjaOrckerio432FNJImnsATU4sRAuuQONYCdPXDWCl33+ubr/w1PWgrar
    5T94jGNJ5LgxKi+peBXGVY2GNIVhU20ZtuDnOV5l5acK5WHPS8DKJayFgAQxfEFQ6YRCem
    MKdFYOg48BTLfnGsNcxwTFlZzOUz2I3lc7tVUYC60tlVdFbuXlIB6nU9orFg
X-ME-Proxy: <xmx:06PgatJ00PvqiXWORjXubiUXZuxebfnSaTgd-KafDZXBqQ1Cr1u_mQ>
    <xmx:06PgaiHnFDhtoqoKf_wsaKzGGJn1vqABbDFjn5inqaXlodCETnoJIQ>
    <xmx:06Pganr6kfYLvznZ7vu87XU1Cwm79hdNeXHPFQ2hJN1bYcFQivIZpg>
    <xmx:06PgarT0PbM49leHsAyJggQukjH_jtb1y6ejGfW_O-N0Um14cg71rA>
    <xmx:06PgaqC1RgGJV9iFLw4O3SbBrxUMzkTjawWUbqWlL7rb-aEm6L91ejAC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 09:14:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4590e859 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 13:14:58 +0000 (UTC)
Date: Tue, 27 Oct 2026 14:14:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 5/6] odb/source-files: avoid stat'ing already-known
 alternates
Message-ID: <auCjz2OeO3GiRnDk@pks.im>
References: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
 <20261023-pks-odb-files-reload-alternates-v2-5-30559d7ff43b@pks.im>
 <CAP8UFD1-Fh-fiGpFiVtBk09JygbD0P5fOYHgXjvk1X+YUCVyPQ@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1-Fh-fiGpFiVtBk09JygbD0P5fOYHgXjvk1X+YUCVyPQ@mail.gmail.com>

On Tue, Oct 27, 2026 at 01:36:35PM +0100, Christian Couder wrote:
> On Fri, Oct 23, 2026 at 2:48 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > When adding alternates we first check whether the alternate exists
> > before checking whether we already know about it. This results in a
> > useless stat(3p) syscall in the case where we already track the
> > alternate.
> >
> > Reorder the logic so that we first check whether we know the alternate
> > already before checking whether its directory exists to avoid the
> > syscall.
> 
> Does avoiding the syscall means not printing the "object directory %s
> does not exist" error then, when we know the alternates but its
> directory was removed?

It depends. When trying to add an alternate that doesn't exist we'll
continue to print this error. But when such an alternate disappears
after we have already added it to the object database then we indeed
won't print this error anymore.

I don't think this really is a huge issue by itself, as it feels
sufficiently niche to not really matter, and the end result itself
wouldn't change. But let me know in case you disagree.

Patrick
