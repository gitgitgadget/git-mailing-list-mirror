Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615512;
	b=izfyGlC6GpPFvVUZ+pHQIAjX+FL0qaHxKuOsPNP1DieDPw3scSK88Kc7LUlEPTZxE3kx
	 QOOnKI/CfFZH/kgiKImYIp4+rkvazFZInpYk/IU8LhkcxWrcw1UZap+8tolUNsCSJJw6F
	 +NfnZ4JqVvODS3x3GnTdPWw410mPIbVMC4x8nKhDyYjxSjlKbFZJuSWMSaHeIfFE+Evpa
	 gmcYkO4EEIYdZivJ2q2AYdsHnnvPFxdQlQZ3xr2zCvRFN8pMw5a+sAIHV0qKlm938kq6a
	 CzQVvT9/JdUYu5q4SBPieF4iRokfFHAFgdGHiWVzr28t6N/6Gg8tfBBwS0VGWM9YuBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615512;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport:Content-Transfer-Encoding;
	bh=L9M9Q6qSOFUMvBoBPb7HTVO3J2vsaHOOJlIecjN4Cic=;
	b=MJvWPzXeK2Y5PARi07cxolts3j3W29vYySSgl0sMTpE5IBQi5h9b/3hprlik+gUnjl1Y
	 CYbpaI05/1RRyueoeDRNajfTEuqiIK95Itr+HOFxQdgrnfNT8ovDqkm0qoAyqc42didJe
	 12e+n9Pgo5vGasUlX4/wvHUUy8xZEys/0AudvO/nu7CmlgJLsCFl+WRpnvS2Ann7v3+jb
	 g6JasR59lHYMxxdOYYoBev8AOskUTJme6dkV5oWMM/2qHg5biCUYUcdRLQ3qiJwd/7Ihl
	 P5hPTl7HZ09pKw1Z5J2/kI46V7FvaEA22XH77ULqO5K2C8DWgfoyE+QOdqQ8NuPOKig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=f8rgDcCb;
	arc=none smtp.remote-ip=212.227.15.19
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18189606A327
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 14:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18189606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=f8rgDcCb
DKIM2-Signature:  i=1; m=1; t=1795615509;
 mf=PEpvaGFubmVzLlNjaGluZGVsaW5AZ214LmRlPg==;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:Ajs/J1PiIKCsPHFNRxWv7ePFaieP
   3b6GimCzxC3O8holreHZiKXMQgHeY32A7QSAacfeXQjVk9lv1Qy+LkXuNJ/WUn6TuHfRo0Hc03i
   x41pwbBxp/FYXvOne3996vB1lrJbQAFd7xrp35hrTvUx4DNk3qxRB7wRz5QPfGeRCOc2vWaTDe0
   I6KnBIgb9xaOBDw6A7QrOkmbW2QkjmGHqFbdDoYf9GbXphg+ZD0H3guKgD+emMz44CQiXxDzneY
   nBb4G7oX0dLPwokc3q2VMOMbw/xZ24g+IoCWKTxO/S7CVCfHa/esenKf5sTFhm+CG5f4TvvK0Oz
   LjSG9HfhITow5w==;
Message-Instance:  m=1;
 h=sha256:
   5RwdlXkFIBX10jpkPmYuXDiYIK5+FDyHpeOGFx4afW0=:
   Cog4RLBrd33Lu/UOmRVlHPWMSgr1q3F8TFxeNKNUg6M=,
  sha512:
   KOtNdhGxZoLJVnslLOjrzShD6NM/I58APOn8UHmbmVOiO2pPDvjWYyYC7mw/QRcBwU+OBHoqgqV8xqZJOxcoYg==:
   +ZUYpHNY8YYJ33uAV9ch9ztn2OQfdmhOHnx0CoNyAOuLJKdoHd2g4ZrqNG7QR6bi92WCBrBIsqkISaf9EwFuuw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795615504; x=1796220304;
	i=johannes.schindelin@gmx.de;
	bh=L9M9Q6qSOFUMvBoBPb7HTVO3J2vsaHOOJlIecjN4Cic=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=f8rgDcCbzSER7UCWCHz2dSgtJxRxi2/XPtZZZ5zZNbE0Kw9I/fFf3SOK8zuJCFBy
	 5WYhepzWHTPCdES3MWpJzGhTm51JDPIDwbU666INut02wJMxHshQeAyYIss98N/UT
	 umVywhiOfiipX1dIXS53RFtoVsZS8/AB3ef0An6XN7HGHSl4CxRTQ882+a5GC0K3t
	 BjfGVdMscp087wyo5k7/fi08uzwSY/LtuqWCJ265qFbbItgar7z41Bbsh4qmf1E89
	 I1IUtd/PQ2OJfP5Gr8rdAFEnR1GCiz1SdnzYPzQqia2IJD8+d5JV9I0E6ZVTLXaVV
	 H5hR9KcrsZZ+WeYCYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHXFr-1xjftW3amP-001p8k; Wed, 25
 Nov 2026 15:05:03 +0100
Date: Wed, 25 Nov 2026 15:04:57 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
    Patrick Steinhardt <ps@pks.im>, Harald Nordgren <haraldnordgren@gmail.com>, 
    Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: [PATCH v2 2/5] http: use `size_t` for byte position in
 fwrite_sha1_file
In-Reply-To: <xmqqfqwqt8sl.fsf@gitster.g>
Message-ID: <7e0e2cfd-e189-cb75-6252-3fed5ccb093e@gmx.de>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com> <pull.2253.v2.git.1795472027.gitgitgadget@gmail.com> <38cc1dec532ff56a2d3de5ea85f80077823bbb19.1795472027.git.gitgitgadget@gmail.com> <xmqqfqwqt8sl.fsf@gitster.g>
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
X-Provags-ID: V03:K1:NEm0w6HA9yqtRmCNmKKzX4xwhIqu4BgE83l2BB2qvfLIijLuK/U
 eHL8zsraXKE7lp2pL2jcPLBcWD5hxrn3g/T6/21qYsBoX1RYHMbRvfh2LBJVEqBHZLgm77w
 SVTiNffsnBkUP31EoGsp7hq4EiN/yQsAcCSH6DB3Xn516h2fa5xjV/jnOVozH4r/UM5qY0y
 sxUfWKYE1p3672yzp+z4Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5OVmCb0yOdo=;l0esKR/UYdruYX+w+Noq65SGt3r
 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
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 24 Nov 2026, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The `fwrite_sha1_file()` function tracks the number of bytes written v=
ia
> > an `int` variable, but the total size to write is of type `size_t`. Wh=
en
> > the HTTP response body exceeds INT_MAX (~2GB), this causes an overflow
> > and a heap under-read, then writes that data to the local object file.
> >
> > The hash check afterward would reject the corrupt object (so no bad da=
ta
> > enters the object store), but the under-read itself could leak adjacen=
t
> > heap contents to the temporary file. In practice this is unlikely
> > because curl delivers data in small chunks (typically 16KB per callbac=
k
> > invocation), so in practice, the total size is far below INT_MAX in a
> > single call. However, the function interface accepts arbitrary sizes,
> > and the accumulation across the loop means that the `int` variable gro=
ws
> > across calls within a single invocation, not across callbacks.
>=20
> The second paragraph also repeats "In practice ... so in practice".
>=20
> I had to read the two paragraphs a few times to convince myself that
> they are not delivering contradictory messages.  In fwrite_sha1_file(),
> 'posn' is a local variable reset to 0 on every invocation, so a
> multi-gigabyte HTTP response body delivered in normal chunks will never
> overflow 'posn'.  Only a single invocation whose eltsize * nmemb is
> larger than INT_MAX would overflow it, as the second paragraph notes.
>=20
> Perhaps shorten the thing (while removing the repetition) along the
> lines of something like...
>=20
>     The fwrite_sha1_file() function tracks the number of bytes written
>     during a single invocation in an int variable ('posn'), even though
>     the buffer length size =3D eltsize * nmemb has type size_t.  If a
>     caller or callback ever passed more than INT_MAX bytes in a single
>     call, 'posn' could overflow and wrap negative, causing (char *)ptr +
>     posn to under-read the buffer.  While curl delivers data in small
>     chunks in practice, matching the variable type to 'size' avoids the
>     defect.
>=20
> perhaps?

I'll use that.

Thanks!
Johannes

>=20
> > diff --git a/http.c b/http.c
> > index d79678d01f..2879eb3874 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -2848,7 +2848,7 @@ static size_t fwrite_sha1_file(char *ptr, size_t=
 eltsize, size_t nmemb,
> >  {
> >  	unsigned char expn[4096];
> >  	size_t size =3D eltsize * nmemb;
> > -	int posn =3D 0;
> > +	size_t posn =3D 0;
> >  	struct http_object_request *freq =3D data;
> >  	struct active_request_slot *slot =3D freq->slot;
>=20
> And of course, this single line change itself is good.
>=20
> xwrite() clamps per-call I/O to MAX_IO_SIZE, and posn/eltsize division
> avoids signed-to-unsigned promotion on the value this function returns.
>=20
> Looking good.
>=20
>=20
