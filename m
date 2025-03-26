Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C404042069
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742973638; cv=none; b=KYcrIAN3euRmAdALP8+XHQ0wJWDyBz5MeQv8XLR1gk1HaEMxwlh78+gD1VSAFF/q3k6KA49gAbsDRCrhpvDj/qvXKKlHuhy9VcA7QMB95D7RfWlrUx5qka3nNSLLopUsEeqLQfxcYMCvGpIsqN0tiDm0flmdbA7VhKL3dCGmJOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742973638; c=relaxed/simple;
	bh=ndnYkaAdHBPWKPFucoPr985JcCd9C3L8sQ/14FtfEIQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W8AwNmsAMjCc0yWIwTdWShqYuKy8N9ncztnW3Zcmq1y6zM/1WOYUIX7YwB8j752afQiEpdkAV1XTXZVmMIt6Zzftui1h0g9Lgnqlqs6M+rty7DjVUVDIIVKEGFa9PXPm2CMERsaYjaa1lwMHmEfh17QHIpIh99RK0IGYvmOS3/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=lRtMb8td; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="lRtMb8td"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742973633; x=1743578433;
	i=johannes.schindelin@gmx.de;
	bh=NMvMmhqX6M1WOJTUi+mx9nR/vM+7fxHDF01GN4oqbA0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lRtMb8td0em5lmU7iNYxtyPUVzn8/s9COADmaPlkz9mywoSRuJr0b66aaR9i1Upu
	 AUi8N56/CqpkMcYpuD5dkLtTjHLCfyiw/YIJ+sq13BRBk1Dw4YM1LV4MctNTSd6lp
	 e/AVSTz0U8sLWOy17Owz4U4OBfAssmnMbX3eG38CWm0Jw2PK5RqYTREq8+AKVphVG
	 WbHBfSVUQK+hDR0ZoAUJamrJdWbY6Q2+cjsYOZXSfFlFM7EAVxlLvSWSiO5Ahd6+j
	 mdVK4dpqvXfgA5d5gsNTqEtBREvLuXlgTzQm9Wcr8I+DSao7oevBFCnxvnbvRvfsC
	 Ne9OcpXbbp0wuOxGDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8XPn-1t1mXg0eYL-0138WB; Wed, 26
 Mar 2025 08:20:33 +0100
Date: Wed, 26 Mar 2025 08:20:32 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 06/10] diff-delta: explicitly mark intentional use of
 the comma operator
In-Reply-To: <Z-OWoK-DlvnxXPkO@pks.im>
Message-ID: <050f5d65-32eb-fd26-1461-579b06018dc6@gmx.de>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com> <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com> <5e0e8325620395196608a0851f1f6fc9408f6090.1742945534.git.gitgitgadget@gmail.com> <Z-OWoK-DlvnxXPkO@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FyP/Y4TmyRw7L4Cq+LMOXFasoO4qaC0DGvyaaDFJX/WHdx3fUL3
 exHtxitif7r3reGio3mBtiOqXVDsZ2dB54/Ff/e7J/HW300y9iX6+pjD5fUZCLnmYc7PPFF
 /ovQNjiy4xmjWVhXU/Fait51Olo+R74wWViCqhNzQ+fsTsPlbAQwA/RZBc3dhaLEhjcNtcj
 B1ajNeuZXx+3smd39Fahw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yxRl25Nsr40=;u4KyZyI7gZHSpg6ZlVO7dUSVgXt
 B/Tp6IeiUFUh5UN+Hg1vHPeHRFyQ0BlYT7c8Xdvd0MDXDyHH6dfqMfF4pbc7xYkNi6f/oKBU9
 bDLvPEmpaBoxL5nx1SiyzbS8zpG2i5fRyfbqz4tX1l+TEalQk6XWuKDU4zhCoMPUmmL/9QtsT
 IRKjyvE8znyR5h9JvXp5HklLUMhDmNhsrevflkz8rn8cnD5fpBdXjAV6nY7HsrnYDLHmGUXfg
 hfKu+zoqUnKveUueWhBRBSSBu5tcwa503z0kQ3uJXsyyr2npBbHZZMtjihngE6A4mjl3FuTuv
 vj6LrmwP+JqVCBnUQPqtQzDD9pTjzKQbsT44Rb+rIl97wruXBuUS3UFOQlNl6nxVYTyxGVw9m
 exKZAQ4lMzrfLGcmNuxD/ydsa1/sHQ0waJ2V7H5aP5+uCOlT7GGKOR6C36UtkWqwi1tzAQu9y
 UQEwj71fe2wwR8KVS+jDfdinV9OF3ZZ0uxCqmCTDYrHP8F7/NRG9QWSpHowziTXiNi52emmMk
 NpPwSdgN8fT00QW3Z8gyUEM7w7O1VugeS3slS5m9dn/YWRBfRFmj4yJIfAT3+BQEIL1wsPPU2
 4sazcdoWK0/xOt+0hW354BXG9I/EiaIdtpmpp19arxi3M/EgECSlxRZ5MXFSe4ySDfN+eRb/P
 I4EGJm1WUF1fgCRhxcVCCPAmCMoGxF4MA/O134wzoyc9hdDrJegmPmda0G6ZeulIVgN9Qb0Ga
 /WozIQ/zNY7lHf61gWMluixLs1NZIBtVN/JmLLFZOY8n5wIpSL0RPtRFr2VyqYhMn4VTkyVTs
 kuvS+SB7GXr32Vl7cW1CZrG1HLLdySu6AHHRxv9uIWWvTWUzozg3NYQknsjdTjLt0CjKEamyu
 eV+xGmdV7RwXUwM1Uj3ojDypAtveT8hZknfnZOSbxjdNHEjAqSx4SwO6TgX5v4ljzA4p+sPvb
 tsHBLu5uEWNR19MngmkuGiCTgBd0NxB5u20gWyDxbRp3dUYZnEq4bBHBoWfPTIqOVvhSfXphq
 PCx2pd0H1zaIPfVmwSAMqfuBE2On1fUKZXn/UMwX38RWGD+fBsM6FKcslfSUjfis9c4r8C0wi
 XG2+bK75blj17qAmSXv1LZlvGHphqmnKGon2yDUjaFwg4dt0C39EOgwzdRUDaxhQE2Iioqz/x
 bBo5DfDHr3Z6j9TqWDXxIn8D+D+ZKhlHs6lBdYKjjy90eeti3RIxNYQa3k9bLsXfD7dnz8u4K
 +ZEVMI9l4yStHEGSKvOcOjIRVOj/vCdIVX2p/I65zZUq1W6g7jsKy+kjEOOcKEV46JDPOMUyS
 ImOYOlxlQrorUC8zBC25oqP9Ev6uFWOze4cNCRRlCtmv8ihby0kHFonNQTLn/vyPMUV4gjgGK
 +T9suCcZ6T1Iwl6N/zfjOE1xg9cUQUtxYxMi81cwBVpPuCPYoE6xhM+u4hXRXBZA9ROzCoGjM
 eKXlPGKzLzQZVjhnL0DepNnwr/vH6vy7R0x+oadHD45rfAo8q
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 26 Mar 2025, Patrick Steinhardt wrote:

> On Tue, Mar 25, 2025 at 11:32:10PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The comma operator is a somewhat obscure C feature that is often used =
by
> > mistake and can even cause unintentional code flow. That is why the
> > `-Wcomma` option of clang was introduced: To identify unintentional us=
es
> > of the comma operator.
> >
> > Intentional uses include situations where one wants to avoid curly
> > brackets around multiple statements that need to be guarded by a
> > condition. This is the case here, as the repetitive nature of the
> > statements is easier to see for a human reader this way.
> >
> > To mark this usage as intentional, the return value of the statement
> > before the comma needs to be cast to `void`, which we do here.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  diff-delta.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/diff-delta.c b/diff-delta.c
> > index a4faf73829b..a03ba10b2be 100644
> > --- a/diff-delta.c
> > +++ b/diff-delta.c
> > @@ -439,18 +439,18 @@ create_delta(const struct delta_index *index,
> >  			i =3D 0x80;
> >
> >  			if (moff & 0x000000ff)
> > -				out[outpos++] =3D moff >> 0,  i |=3D 0x01;
> > +				(void)(out[outpos++] =3D moff >> 0),  i |=3D 0x01;
> >  			if (moff & 0x0000ff00)
> > -				out[outpos++] =3D moff >> 8,  i |=3D 0x02;
> > +				(void)(out[outpos++] =3D moff >> 8),  i |=3D 0x02;
> >  			if (moff & 0x00ff0000)
> > -				out[outpos++] =3D moff >> 16, i |=3D 0x04;
> > +				(void)(out[outpos++] =3D moff >> 16), i |=3D 0x04;
> >  			if (moff & 0xff000000)
> > -				out[outpos++] =3D moff >> 24, i |=3D 0x08;
> > +				(void)(out[outpos++] =3D moff >> 24), i |=3D 0x08;
> >
> >  			if (msize & 0x00ff)
> > -				out[outpos++] =3D msize >> 0, i |=3D 0x10;
> > +				(void)(out[outpos++] =3D msize >> 0), i |=3D 0x10;
> >  			if (msize & 0xff00)
> > -				out[outpos++] =3D msize >> 8, i |=3D 0x20;
> > +				(void)(out[outpos++] =3D msize >> 8), i |=3D 0x20;
>
> Hm. I think the end result is even more confusing than before. Why don't
> we introduce curly braces here, same as in preceding commits?

The interleaved -/+ lines make it admittedly hard to see what I meant.
I'll unwind it a bit (presenting only the `moff` part, the same
consideration applies to `msize`):

		if (moff & 0x000000ff)
			(void)(out[outpos++] =3D moff >> 0),  i |=3D 0x01;
		if (moff & 0x0000ff00)
			(void)(out[outpos++] =3D moff >> 8),  i |=3D 0x02;
		if (moff & 0x00ff0000)
			(void)(out[outpos++] =3D moff >> 16), i |=3D 0x04;
		if (moff & 0xff000000)
			(void)(out[outpos++] =3D moff >> 24), i |=3D 0x08;

In this form, it is very obvious (from comparing the right-side half of
the lines) that a shifted version of `moff` is appended to `out` and `i`
gets a bit set, and the correlation between shift width and the set bit
is relatively easy to see and validate (at least my brain has an easy time
here, thanks to the alignment and thanks to visual similarity between the
non-blank parts).

It is admittedly quite a bit harder not to be distracted by the repetitive
`(void)(out[...` parts to understand and validate the `if` conditions on
the left-hand side, but thanks to those repetitive parts being identical,
and being only one line between those `if` lines, I can bring my brain to
focus only on the differences of the bitmask and understand and verify
them with relatively little effort.

When I compared this form to the following, the cognitive load to wrap my
head around the code is quite a bit higher there:

		if (moff & 0x000000ff) {
			out[outpos++] =3D moff >> 0;
			i |=3D 0x01;
		}
		if (moff & 0x0000ff00) {
			out[outpos++] =3D moff >> 8;
			i |=3D 0x02;
		}
		if (moff & 0x00ff0000) {
			out[outpos++] =3D moff >> 16;
			i |=3D 0x04;
		}
		if (moff & 0xff000000) {
			out[outpos++] =3D moff >> 24;
			i |=3D 0x08;
		}

The reason is the visual distance between the near-identical code.

Having said that, I do realize that my brain quite possibly works in
special ways here and that the general preference is to go with the latter
form.

Do you have a strong opinion which form to use?

Ciao,
Johannes
