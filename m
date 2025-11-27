Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7575A1FE46D
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764253505; cv=pass; b=AMoK8CmtCxgOietc7z72YmIOW7DPej4hfGxCZ9+a94vscF8iCPIwX+6NGlJ9smG/wE6jrZPGCF+2UaiMzFNsOrawp8tadJ0X34lDnNdFYHLgvW0ZMd4x0IST8SdE41uh9kDWB2NwvzfBoKixZdNTS2IZ4mRCC8Ah1umH0G/UBGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764253505; c=relaxed/simple;
	bh=MbSWExMi9boscvo/HgbsKh6KKzSM3PGWtDz4bQlbP/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bjyS/uiNGUyCgMsoARb5ihdJrge2RSu98WYmoCLNK1mu11LGEL+o2WK9XbJBZ8STX3uozeF4iHDN8jdx3Cpk2i1ls5PhspfpmnziZEZ0MjkiII8yJPs4+7i3KYXwXC7Z3pfF/ticAi7M/Nf9q3bnYDqYLIJ4i3Y5TD4SWtgllt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=kOFAcNA0; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="kOFAcNA0"
ARC-Seal: i=1; a=rsa-sha256; t=1764253490; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ky7REQm8Md191K1UPXHk2/IyskmhL7InR3A484oUHp84r2447ipo2ckxQrL8cCUEUuwHM2B/ixnz/ddkWYZPUk/xt7GveD0rYw0NAm9uBDjjl5GErIUQDyNRHm6pZaadFthr/7SjT9U9sFd4uIOCDBq748IcUnxlC176TDToJp8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764253490; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5va8q43cGGvp4Yj+YUZFK+3DjWe26mHPvxxohyt73p8=; 
	b=ZT69jfkFC6mYjzWuYJt92XoTVHZ1/1n2FQ8CCdizmhElILy6rANdx6hMH7iUs09qbM++mrA8Cbm7iCI2vP5GDfFAiIG+qr5O3g+7k7LFWh93MSzRvuVcEYMxcHVFO7GM0w/pRpIT2u/yI6ap9cemEPQJCwvI87so/8LahwoXUfA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764253490;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=5va8q43cGGvp4Yj+YUZFK+3DjWe26mHPvxxohyt73p8=;
	b=kOFAcNA068zi0vuSwqz+IqivzuhdZRaYdpfiUgnFB4dCtMePTHSz0qpo0hv1rtrq
	SgSliuP/Ius3PAJ4iu2b4/EQ4RFARZanzU97N5lRwzdqLRNLhlgsapVHVpLPlj14xOW
	lk2oOIxf2F1t543JDqZfhpyqx+E+zPINu+SuvRAk=
Received: by mx.zohomail.com with SMTPS id 1764253486960573.8778487338313;
	Thu, 27 Nov 2025 06:24:46 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Patrick Steinhardt <ps@pks.im>,
 Josh Steadmon <steadmon@google.com>, Ben Knoble <ben.knoble@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 04/10] transport: convert pre-push to hook API
In-Reply-To: <xmqqy0nvujlg.fsf@gitster.g>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251124172043.1650014-1-adrian.ratiu@collabora.com>
 <20251124172043.1650014-5-adrian.ratiu@collabora.com>
 <xmqqy0nvujlg.fsf@gitster.g>
Date: Thu, 27 Nov 2025 16:24:42 +0200
Message-ID: <87qztjimdx.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Mon, 24 Nov 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:=20
>=20
>> From: Emily Shaffer <emilyshaffer@google.com>=20
>>=20
>> Move the pre-push hook from custom run-command invocations to=20
>> the new hook API which doesn't require a custom child_process=20
>> structure and signal toggling.=20
>>=20
>> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>=
=20
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com> ---=20
>>  transport.c | 95=20
>>  ++++++++++++++++++++++++++++------------------------- 1 file=20
>>  changed, 51 insertions(+), 44 deletions(-)=20
>=20
> So, this completes what 01/10 hinted at when it created a=20
> generalized interface modelled after how pre-push hook was run.=20
> We used to spawn the pre-push hook and fed its standard input by=20
> calling write_in_full().  Now that is largely encapsulated in=20
> run_hooks_opt(), but the application specific processing=20
> (namely, what we write to the pre-push hook, i.e. the list of=20
> ref update status) is given in pre_push_hook_feed_stdin()=20
> callback defined here and given to the run_hooks_opt() call.=20
>=20
> In other words, the mechanisms are very cleanly separated=20
> between generic machinery and the client specific processing.=20
> Nice.=20
>=20
> How and where does the pipe we are writing into=20
> (i.e. hook_stdin_fd) gets closed when we are done with the=20
> child?=20
=20
That happens in run-command.c:pp_buffer_stdin() which calls the=20
feed pipe callback then closes the fd when feeding is finished:

/**=20
 * Feed the pipe: *   ret < 0 means error *   ret =3D=3D 0 means there=20
 is more data to be fed *   ret > 0 means feeding finished */
ret =3D opts->feed_pipe(proc->in, opts->data, pp->children[i].data);
...
