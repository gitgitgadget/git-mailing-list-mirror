Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F093C062A
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621297; cv=none; b=Vg3mWo7fE5SmJo8aijSW2OQaL+7f0q8Bc2sPc9fMksQPY5WzGg/JQ0RdSwmjyUri93COp4lsdBeW7buogQ7t2iSI9lhrUhVPEZGjSHTMnY1HgTXeiqblkQcKu6YKa9HcIv++LBzFEF10SckSg1RnDIuRiQ8ve4NjdjBbwbX1USw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621297; c=relaxed/simple;
	bh=mAKj3jFOgwkDvgaSp1J6P4OlMVaE3v4lhkBbDNpEPd8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sl+4C9AMdG1bmb5C38Nc00Hcj4Da59e7yqS6juk5TA3Skx5vvnCmPu6xp4oFr5cWVYzdsUkW05O1/igGsJJ+XVenQSD2RRSW088mqYve8ikjVys2cTqmcfHIC6HshVS2Px1Nq76aXwg0j3h7XXOd8ggCBEwd0b1k24Dyh6rWfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=AaYiXimO; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="AaYiXimO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781621288; x=1782226088;
	i=johannes.schindelin@gmx.de;
	bh=ceKB1Y0dSXkG7ApO5QD1Qg6LuyfGPTLzM5j8o1BrtAA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AaYiXimOjg0LAPulrWDQ+menbnfl4d8rPab7zk+kxDfu/KRUr3bTaqPxptl7xpLt
	 MPj3E6zeq15jBSQ0VDamqCci9gnvjkNOcG4QudFnJHS7N9/Ika/ik0MI8MkZuMmzK
	 /nF7wN9L9yFaFkrAkvn9sGqEJx6lRBHn0MgUAnuN1x6vg4xjhI6aiKFxNAR8p0rO2
	 gr6wC0QAmmL9WfTmkwQHfUEyXEBNgz50RYq5VcUprr/QXi2SNq8hkhSEnrN2kTeo7
	 bcWRVFFRK/DybUQ+ODugZKjiUlI0WyVRUAQLeCjiZ+jrMGsF5e632IASb7verxhi1
	 D2RyxHRSchKqXDaCOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUosT-1whvHV0r6P-00KlU3; Tue, 16
 Jun 2026 16:48:08 +0200
Date: Tue, 16 Jun 2026 16:48:06 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 3/6] hash algorithms: use size_t for section lengths
In-Reply-To: <ai-5VmawU2MRiAHQ@pks.im>
Message-ID: <8acdcffb-e49f-12fe-ffd7-19f0799c91d4@gmx.de>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com> <253d6f8004e710d05b5de1f8279d67d2220f83de.1780593313.git.gitgitgadget@gmail.com> <ai-5VmawU2MRiAHQ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:d1oXD2KOHaXreN/Yr7HrAf/JFbgCK5svflwMi7N604hbeczEJpN
 +gJ3Xmmv/jL4NtDBnKccKvSiAWe0sdcSIFSNNucVO1BDvUez130OnttsbpPidfwolCpqySB
 3u+75ctO9r+Kd7bmsOBsQUnVHpMjnAx6Wvc8a5+BNzAYUl3RBWJfxbTsZ8shJcyt33+QdcP
 HUjLsWOVMdFjTjjgJ5Svw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n+uV9INPIlw=;hJI+XpMK7rvINFQ66JcPWs914rJ
 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
 Hf14Qxj+zYy5AW3hRwsKiOxZ9AjWP6/sTq2BKMH
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Tue, 16 Jun 2026, Patrick Steinhardt wrote:

> On Thu, Jun 04, 2026 at 05:15:09PM +0000, Philip Oakley via GitGitGadget=
 wrote:
> > diff --git a/object-file.c b/object-file.c
> > index 1f5f9daf24..c648cecd80 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -581,7 +581,7 @@ static void write_object_file_prepare(const struct=
 git_hash_algo *algo,
> >  	/* Generate the header */
> >  	*hdrlen =3D format_object_header(hdr, *hdrlen, type, len);
> > =20
> > -	/* Sha1.. */
> > +	/* Hash (function pointers) computation */
> >  	hash_object_body(algo, &c, buf, len, oid, hdr, hdrlen);
> >  }
> > =20
>=20
> Thanks for updating this comment while at it :)

It wasn't my idea, it was Claude Opus'. I would have left it as-is, but
then decided that it's actually a good change and not worth splitting out
into a separate commit.

> > diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
> > index 7867fd1dbf..10382a815e 100755
> > --- a/t/t1007-hash-object.sh
> > +++ b/t/t1007-hash-object.sh
> > @@ -261,7 +261,7 @@ test_expect_success '--stdin outside of repository=
 (uses default hash)' '
> >  	test_cmp expect actual
> >  '
> > =20
> > -test_expect_failure EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
> > +test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
> >  		'files over 4GB hash literally' '
> >  	test-tool genzeros $((5*1024*1024*1024)) >big &&
> >  	test_oid large5GB >expect &&
>=20
> Previously we required `!LONG_IS_64BIT`, because the test would have
> succeeded on platforms where it is 64 bit wide. But now that this test
> works on all platforms I rather wonder whether we should completely drop
> that prerequisite here, as we expect it to pass regardless of whether or
> not long is 64 bit now.

Good point!

Thank you for the review,
Johannes
