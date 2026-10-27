Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106897;
	b=DLnDrdvuAA0DxrbomChD30s+JCjpqqjfkwifhZt4N0IXRXEhtQZX8t0XNhBStz6ZlwKf
	 PaDVH4OZ2YNMubzOnGGlCgOZHxTWqaah5jHluH0bQeHVt+UYbTugGRzCN9TvcQduyKcto
	 ZGtxCk8i/pYb1maWLJeICqBSy8xmTnQljxMrobi8YWHLcN8VACS5UDmhcUec7iOU73smh
	 knrojbv26WCVbklbMwVUenXJzqpdskwFKu9AuzZhDi9AVvC4qsyWrXnKdeAOmR3cYmv5p
	 zxZLxaoZWBLKo1Rue8XfkgEmArU5qHQ1w0wHFUZ8dZRM8AkVvY7uVW5CInxdWNSrWzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106897;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=V0hvoR+vsGwHTy8DlKGPpzExa8TabpvHf5F+NlfUni0=;
	b=Vhx33dYa0cQzEZEkSI/M04cxuhRUIfjXQaQcq5Lgh9+dizSgJ2WzKlzEuX0maeNHFxTQ
	 2A6JD0N13Jk7wEuJ/toVieoK8hwAI7kodu0bJdMFakCpIFY9l0qi+lJi0PlmdxUGh+lZc
	 XVOXrKDaCk8OvLIFBU7TXPK7dymvv/MtKn8dcAZq2vQuJDA/4RmBaEnUwieLBGI68tuY1
	 Nj/SZd342cRQNzZ/wJNaPd7tTH2T43PM6Yyjn76k/x/bwV3EAPFt0yYZJGKpAgfVF6t5s
	 TIyYqXZsTlMhGe0v+BVPcyT2JarvI80+M6H4GrQjNo/A56g+4W/vGEDVPR9bIgCISPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=X7A5TYH5;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=WViakjrN;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68FA606A31D
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 13:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B68FA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=X7A5TYH5;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=WViakjrN
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D2D78EC00AE
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 09:14:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 27 Oct 2026 09:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793106895;
	 x=1793193295; bh=V0hvoR+vsGwHTy8DlKGPpzExa8TabpvHf5F+NlfUni0=; b=
	X7A5TYH5HrOO4Kj75L59KDVqobBYiotuE9M8n0ernB0CB7DGPUw2nRNFDKFDnqZ8
	903V8ae9PLcU/dt80UAmj4aChZbNlT0wgIEedFrQ2f8Vlv5sf7hjPGrWpxJgJi03
	Z8kE2bmaQcNKJCzsFoEZm6g140YRd/HIEMQ/J1cPuuLMXY5VH622RHZL/hOrve36
	1Glr/4CX8avNRySllYfLvX2HXgkyqga+2CmhqTFDkRMyx1lDxCv8uSqh2cEf5tHs
	jX5ZO+k7JNRt4vFwVFeP648Vt3aP/oLV7TsJUC2d+7NIDmVFx/S1uSAOwoe8KfMR
	Dw+ZvikjWgzpq7fg3Lgw6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793106895; x=
	1793193295; bh=V0hvoR+vsGwHTy8DlKGPpzExa8TabpvHf5F+NlfUni0=; b=W
	ViakjrNGE5lQVWv5YX99KP4GWK4lARo1/tDr0Atle6q5tmhQZMyoyhAbs/gArOGd
	j6T+5oOlohgKr5RIqOKDw+BqZy05xY2Ln88KWMoQGZdrsIiHytL+Vu3lQJCGg314
	vqrHEw0PYPRwTv/ERyEzDfy2UhL11OCJZV7pE4PNivLtElPc4PF0611HhsIuK0uF
	p1e/5HeWqmLRNYa7SLk/1YZ8eFhzRQ1zrFy4nAFRU8zFOd4HWJD3A2/8qZ/QQiTS
	O04nbFMCRaJGI3Fk30jfXl1BBROj2nEZITAprfSUnGprvhDJupHpzcETIDtWOKMl
	lLUMSMd18PSRG/qxyGUqA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793106895; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:iWUEvQxXs6ND1nQw0RXE83lImr8tMNCXK25JpPRG0dJJcVz
	XMYoaCmdC9vZPEYSfDvDB2PaK7ZeVt13pCBY2PFfa9EXkHvVlNLq8FPd/QcIDVcG
	pDsowAygy6B7rTODPGq0Uzhe03eI/TfqOFmjP/4XOBeb8k064Gn3e2DXVrVeqAgw
	RSfQIG1ku+NSKUf1eQZJTTTePZzULpFlOFqaKQrrMqpRDG2v2A/gM4fIwD7Xqrmj
	QoaPIBfQjjtoHkd2bnwpPJyavZsjqB5PtB6fBtrH+boxMQHwrYvymx2JpHwaPfpf
	l+nt9xXLFqrySx251yHRoX3cQOOXh/faOupm5rQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tgd6UbG/u+QkkFSjoQ49rvYiq+ywyoFITj7P9ihmRJA=:vVFtA3E6rBg6XmAbp6XpscjQ/82QD0Vy3eo5NRlc4hY=;
X-ME-Sender: <xms:z6Pgavw4WWb0LMP06OVNDE8VLXJO_yqkYVRu4ZIwHJEBolUijGLA8w>
    <xme:z6PgatRKE6bJ5bOfxGdAAtiOpiEXieeMdk330aFMZaPLaQPkJjSnHzz--IewOUUo1
    sNipFU2NBvd8Llzx2GQ8bcoct26ZSJMz5PTfftqqyTL1lwDCJKZz-ut>
X-ME-Received: <xmr:z6Pgam9KKhMWaSyyPB6LHAx_-WoB2CWnHQijloGuU1JYrKy44YygjA>
X-ME-Proxy-Cause: dmFkZTEOZx1kzXKS+xyWwZOXj7mkib3tWf4oTDdwYt+tyWXWA8AOYAS3G8dG7lclou0+ZI
    ohLGl8LygXpEIKCufgm830wE4+PHNWvz5pOKsuOR+MTZHVmuv6wqKnQS8eOG4K0iIb4Zo0
    uoS1zc5IkAjjSx8qt955ObDLnNrc4AeapI7xZ6mmRlqqtS07R/LOEoM19/I8eTplDUSJUD
    RdqTdFYXJ6+TZ86VjxId2CKeq/5j9TLhiDsYdtprtjIVH4XV8NczZ0vFLP7x8fN4mHJGPC
    U/pYC5dTE8kW2kLkPE7p9i4AgQi/Akkl4zopOyQ6lBcfEKqIsuCsfrhC+6+Yaxpvq9RJew
    9lDd8uQ7mnlXxKu4gZr/vM9lKwBEpzkvSY/TtAkRBEtI1eA9B4eTfblx5Ta+/J6c4LLVWO
    ajzH9J5CudBDpDsAgwvcM+u0EcDgIonVtgVQFySjmUg496ac2xiZuAWVpPJXGQcEPw0EkG
    Y1maGaf96nDGwV4z0xhshfjUUpZ1GE8e7qXe/lvcyzYIkElvaMFpcCy1KfCXH+RXD1MfBU
    T/KkBU5P9paEgnqMFpyPFCHyrYp2N19fLt2HkrW/PgqrjlmnBFXonIxTcI+Uv8v/cH6/hj
    SgQPLhlRQKJoVAvDakhcmkHZOTbnNvOGqnyISTcsfDoOmvLO6AJ+zURfuKOg
X-ME-Proxy: <xmx:z6Pgakq0DzDJryj-641RnGfDpGtsHFNf3QboiZFo7sbMCEzbDaJGpw>
    <xmx:z6Pgajm9qNx2ZFV8OOjVZHMjvotMsVtKFCgb4LEtUUn2ascM3IbJhw>
    <xmx:z6PgarKy_Qn9eedM7uuwFzWfCtueNBlTGbU7wkcft87xwSXX6n2fTw>
    <xmx:z6Pgaoy0PSMdsrauquNy0QEySnhF1KgnvneL7NGb-K21rVBxEsO8tA>
    <xmx:z6PgarhjeshrVrslST9MJ-Cnx64Dqa7hKrIJ29TENML5t1qnIQ8Cs0Rc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 09:14:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5dd12f72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 13:14:52 +0000 (UTC)
Date: Tue, 27 Oct 2026 14:14:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/6] odb/source-files: simplify directory duplication
 detection
Message-ID: <auCjyXEsa06YCp8A@pks.im>
References: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
 <20261023-pks-odb-files-reload-alternates-v2-4-30559d7ff43b@pks.im>
 <CAP8UFD12rSyCh9xhfcggvL4nh30KyWSZhGWrLVmVa051KaJdpg@mail.gmail.com>
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
In-Reply-To: <CAP8UFD12rSyCh9xhfcggvL4nh30KyWSZhGWrLVmVa051KaJdpg@mail.gmail.com>

On Tue, Oct 27, 2026 at 01:13:49PM +0100, Christian Couder wrote:
> On Fri, Oct 23, 2026 at 2:48 PM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > -/*
> > - * NEEDSWORK: we're using "core.ignoreCase" to deduplicate alternates that
> > - * _may_ be the same. This requires quite a bit of boilerplate for dubious
> > - * benefit:
> > - *
> > - *   - Duplicating alternates should really only lead to regressed performance.
> > - *
> > - *   - We don't properly resolve symlinks or mointpoints, so we may still end
> > - *     up duplicating alternates.
> > - *
> > - *   - The value may be lying, in which case we might deduplicate alternates
> > - *     that are in fact not mapping to the same directory.
> > - *
> > - * We should investigate whether we can remove this whole mechanism outright.
> > - */
> 
> Removing this NEEDSWORK isn't mentioned in the commit message. I agree
> that the boilerplate is reduced with the new implementation, but I
> think the points regarding mount points and a wrong `core.ignoreCase`
> might still be interesting.

Yeah, that's a fair point. Will add it back in.

Patrick
