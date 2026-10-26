Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015624;
	b=Z/X/hCG7ac8wBuPcH4zianWfg5zYUoWtJ4tNIHp2Idjtah7B07cJce7IvrOz9W3hPHPd
	 wss02qfIhdJyU7ksG+nXXwOTsQCWoi9i/o6o+CH/CIu0CsBoPuxvL+hHvppPBwvdEk85s
	 uqtQe+VaOeuTECNHtrEAN+p1Nc+1WaCJkTsY+xoJavtEyII/RsJSwH9PS5SNwmLJAiWVQ
	 h8TPsx7YGzjQ2S2VFCh2+IQIJoBE1OVqBvz8CMgJsNjyTO8MHWAYdcJcCszqSuxfSYK9P
	 3hRTtD4LO7kdUO3RPQVkIHOWffY6WeWxVPQkPuWCi88631J8abUXtN4zfapXPPQXf1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015624;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NfPajAkBK4TzMloSGlSvNd39gnh/Ollo0PHydhi5T44=;
	b=Z9jlm4Abu2DlwSAcim3Nj6rFD0n9BxpZXIQug8AySu5gyahRki+hcXNZZwxTyIwT09oQ
	 lDp3p31XL1ZnsZN+bArS8zEdrZHAf2fj/wBpl0NwqGuISKt7doddf+B9WSy4IO4kEHP38
	 MKlFQHdM3XtiZZnUqshJlt7gCAzrGPoVuZoWS85+6EtT5hoWDQIV1sSfDBpXoY9kR/crm
	 gXJP5Z1Et/8aa83kueOeNbxzhkO0FJIwQIZcpFodOtNjV35LwojGVipLOvOnIxPmnnLrP
	 Jm0YJ8zSjYAxzawUHhDcNL56aLn5ksokbFaXctWt7gmMZjQNUEk1fi30rtjVw5o45Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=IbrqVmH4;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qWi71Q48;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B798606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B798606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=IbrqVmH4;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qWi71Q48
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EDD817A01C8
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:53:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 26 Oct 2026 07:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793015622; x=1793102022; bh=NfPajAkBK4
	TzMloSGlSvNd39gnh/Ollo0PHydhi5T44=; b=IbrqVmH4Xcndq7Rdmgqj/c8tDF
	XPbf5tPx8xcqTftiHu9iylhTELgjV5njRcAiCf/pjYzclryZ9oMOUU6UPNyM3yPS
	QDPdH7TYxPQ4AObwvwiqal5i0HkPHjbiJySXhydfTg/RiJmWcvLyxleWHlVBK5Ln
	Ma1QIF/2ArtDDKUUpKuaujVI4buenL/VGku5aFaAIPjub/Vt8fKts8JA/L0vQs2C
	MK59+5wRlPx1dmtWAJF0QywTUrsWIqTwnjGm6bSr/URQ2DmFhAOBwUNIMBi1mk77
	V3tw3bAlyLN6RaohgwdwDEbyislzcAAzL3A9HnaeosoOyJ1RdRKvkY0kaHRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793015622; x=1793102022; bh=NfPajAkBK4TzMloSGlSvNd39gnh/Ollo0PH
	ydhi5T44=; b=qWi71Q482ATGXDyqM3uVtWJiLqVYGri978rEW8tRcyOsN+gqht3
	hvrHx7ozXorfLEFtKEJI5uaErrxmqIE2q/gqdMpqqzLtfFLvxdWRMCVHLFPB5vwI
	LO4fk5LT+zPulYohhHGaQ50U/1TzUgDzBImsG1sKnQEOYH98QNqY5YP1Y5iVSlpg
	ePtv+dVpQnDF7lyvuCAdacClPYZs+W9jNTVR+KMTSv79l00M9SyC7HTzhD2YAe4z
	ghasVn2unTC6A//xozdfphhxO4pCobfvqz4+1CifXIa8kLDzTdlnVGsazDa3Rut4
	FOpvwezSSOZBAEc0oK3ekb5BlHxd41Yd6nA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793015622; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:qmg9Qz1upI+/8llzmsVt0ItcGTGflqAP4H4M5jMbL6lMp9l
	FfWaVqgxEyRDEvo/SPTV/QgTf8YTxd8HFExrSB3uG4Zv53fQc2uMurP7UW+thebi
	DPW0qgkPLKhfl5PQoXWBcYqRAWI824PZG+nw3UcV4dFL3Ph4EdY5bDtKFYjOGXe3
	7bNtNibJsCR7keI3lpcrOI3qv87X3AdEb1S0L5F3RLSxk1QKpeKRK2JRZjUBpsWi
	vnP0TaxtJIPDqIJl2rMDeSlgCZYHhIhai6KwyS/VGpIzTPp+NEeIgTHYsbeajzej
	n2HVKpW0Q+NxBR49VW5VzdPGs3OAsrutjKTN/Aw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:aVGyQaghXOqw5qzDmO6RG3IuCtfkZCQPxkNd7ZND7Lw=:QmVyeB99S6Lo3t8lzN7O9hBqd2LggspFuVNreKrYTmw=;
X-ME-Sender: <xms:Rj_fas8wcs8QgXf1vEi_vfuiiEXh_gTLFWtkPuqxtMBSypGDSwrjrA>
    <xme:Rj_faqth4ES2BicIq5j07TGYFg8yqJohjrNklwdz7zxKgNeRK1zxZILXR7UuY2_ID
    9ah-9ZLQqE5ULYhbVl6ssivZmS5CDUMJUJbcNm3VYyy-LhledAmrh0h>
X-ME-Received: <xmr:Rj_favotNnMu3cEi0LXrFOIwzyNrT1JofM0dKJu23QMxcKCph6hs0Q>
X-ME-Proxy-Cause: dmFkZTEFqmrT2PnKGtODHcIuztx+kwMOT0fpJNzi45z112pOGCALzxtbFEumPYTVLyEYXF
    l1Qwjxx9gVZCqCux1VKAvzJgNgpeOjpHC1JX53/D7LjZ2fl1fCUC5cxpbVI6OA8BX9cfZB
    lZbQGioMBpiM87MXLfOWruYGuAiJ0BxH0ZHaqMLANCcuoBtc9qbZfPG8sAGOCsRohZbEGe
    H5btN8GdgLQ9O6COkCYSlJ9VW9RZRDzpU/oxilgwIRHbsy5ITyYqc+0/ic3sN0TQ+oqD7k
    I8664crYkC6UJR2U/AtmEm8rmRocOIfTzERqXagY0a6cy2Vl8Oj3CxH35lWQ2khH8uFcE+
    dr4NWd+ERwsfcSFqRH+9MsXHdxqym81eXbebB8vIwTZ+dTPFSoTerxzIkjqKkLHc+EVJKY
    EYNAfN75zQ/MSPeZErsGBOho/Syuu4gLl16CyeN4RJzhEr1aktyySt/Lvj2uUVOHce+twz
    0gxrilqOFUrdkr41PsvCbz2jYh4uh+zo0ZcScPMxuPAMra1Gr6lvojOdHs0avWA8yZm1Xo
    0DteyOFD45hrIzz8IPoy+3ohJTqDdwsScuZie2UEIuinimTzno+NicbofRA/OKhNvZBPyo
    hX4nYINrMdGtd4LH75AmK5r2+njekM960tCfMcKEbtDrjfw8UG8CjQ6Ng9iA
X-ME-Proxy: <xmx:Rj_fanl4shHkCvRJUbdDRGPt26-U_zr6WJ5JBsrrXrg2EaMh9dGEFQ>
    <xmx:Rj_fajx_jMjNJJUwXgi1pmpB7Kba8xvuDa8kG0-VInnKjbKKwsDgOg>
    <xmx:Rj_favn_CY-LaKJ8cyRWiU-sILZrCX1w08rXV1p1wCjVTXioa_OACQ>
    <xmx:Rj_fasdlXKYZoYV8OS5LWC1kCBexcOHMs1QUaM0csfSjmszwOoWTHw>
    <xmx:Rj_fartga0Ar2DQOw_E61uz34c8Cprz-bEaV4vnpanq9phUJOJ66RzKk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 07:53:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4d6b5833 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 11:53:39 +0000 (UTC)
Date: Mon, 26 Oct 2026 12:53:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/7] odb: introduce object storage extension
Message-ID: <at8_QLCDRoH0DX4K@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
 <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im>
 <CAOLa=ZQ+25HBP5NAOQ+6TKBtNH2gSk-sH8d6DPDmxgGShowvAw@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ+25HBP5NAOQ+6TKBtNH2gSk-sH8d6DPDmxgGShowvAw@mail.gmail.com>

On Mon, Oct 26, 2026 at 04:35:27AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > this patch series introduces the object storage extension. The extension
> > is of course similar in spirit and design to the ref storage extension:
> > it can be configured via "extensions.objectStorage", has the same syntax
> > with "<schema>[://<payload>]", and we have the same mechanisms to
> > configure it ("--object-storage-format=", GIT_OBJECT_STORAGE_FORMAT,
> > GIT_DEFAULT_OBJECT_STORAGE_FORMAT, "init.defaultObjetcStorageFormat").
> >
> > For now, we only support the "files" object storage format, so not a lot
> > of stuff really changes. That being said, its optional payload allows
> > you to configure a different location for the ".git/objects" directory.
> > So if you specify "extensions.objectStorage=files://objs", objects would
> > be stored in ".git/objs" instead.
> >
> > The series is built on top of c51408889c (The 6th batch, 2026-10-16)
> > with the following dependencies merged into it:
> >
> >   - ps/odb-files-alternates at 0ba59c8453 (odb/source: drop
> >     `read_alternates` callback, 2026-10-08) merged into it.
> >
> >   - ps/setup-enforce-repo-passed-to-create-repository-has-no-state
> >     (phew, what a mouthful) at 0ba59c8453 (odb/source: drop
> >     `read_alternates` callback, 2026-10-08).
> >
> > Note that these two series conflict with one another. The conflict can
> > easily be resolved by just deleting the whole conflicting sections.
> >
> 
> I went through the patches since the range-diff was on the larger side.
> Apart from some nits, the series looks good. I think we can ignore my
> nits too :)

Thanks! I'll wait a bit and send out a new version tomorrow morning.

Patrick
