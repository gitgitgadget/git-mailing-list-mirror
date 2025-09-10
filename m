Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962422D8796
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532681; cv=pass; b=fhrCTDVIDunJ6ihtxDTgsXHDIZWAhmhotcTaqwEN93PidUcLG1j8aN92nM0J9fXQAm+NsWB71UxSVSNRhVKPiSw1X6rmWTyS1r/OPDTQBoabuVqjnT7GoHpr7wEd4fLAXxCZq0hutb1TUvy8hAAloktF1/5B0HJBwtqfxqM0EkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532681; c=relaxed/simple;
	bh=TepjwicdtR2Onzp2KAFqnf6kN1z8LXptpbxH8c4RCTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BwEGmZvtr2NYPEHlkdxrAr72P0XG7bPXlrbisGIuoHoxxrWRifqZrS7rzHR5vPspl6aa8HEjdwbakZQkD6Qkb5Aa0lnKry3+oQqqt//xBluEt3pf6UT5TP48iRVylpm/HQ+3WE9CJUYs1QUMMF8br9f7t5ppnwiLTHj9zNfxuRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=GmJ6BDUB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="GmJ6BDUB"
ARC-Seal: i=1; a=rsa-sha256; t=1757532654; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hoUBh7qlKRYmAoMoxUxKGmYd/PTxcmw9hJctdZHEymVxz0lVG82dOkwzCVer4WQ3zla0EsGoMgMQ/E21GIzL2i6jTcetjaLC5ETPo25cim6O6lgoQcv4qocB/4MiW2j8J2PsHLcElpg/toT8Ql6HfeCtUPvu+tBOQ7Q70C8m+zs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757532654; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zCbVP7Ejq7Ugxrqaz2Lf/gGr8KhVmiEaRIp0e9An1pU=; 
	b=WgQzNitA0JGaFclucjjLpOGDnHvFn+mgDV8hs4qDuhQ/23gmzq2e5mYnOHbbQkUynpy8aPyRh3fDUFqxtDYa4UoStb4C5a6ronybDtGrV9dDG9+sBYZ6xxVoIxjKUW04Xeh2nL5W5aJAMKSNXPF3n4QL+gglAGp/xDaA2PM0Gd0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757532654;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zCbVP7Ejq7Ugxrqaz2Lf/gGr8KhVmiEaRIp0e9An1pU=;
	b=GmJ6BDUBtF2GVfkxI3Uh5WK6Z22ubPIvDxjM8ErfRNui+/HWcSEIeNIHEfP0OEFq
	UGQaK7FtYQ6uC7hQZbZkLGm+QqgGOX9qKjEQaQOUVqchJx4Ta0X1IWh9M0POjpQSL2U
	tjv2ok+Ohq7viTrCKPOAe+q99h/B9hZofyrk+7eY=
Received: by mx.zohomail.com with SMTPS id 1757532651174662.1290929415784;
	Wed, 10 Sep 2025 12:30:51 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Ben Knoble <ben.knoble@gmail.com>, Brandon Williams
 <bmwill@google.com>
Subject: Re: [PATCH v2 06/10] submodule: encode gitdir paths to avoid conflicts
In-Reply-To: <aMHATMvn4Sdcz7mJ@szeder.dev>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-7-adrian.ratiu@collabora.com>
 <aMHATMvn4Sdcz7mJ@szeder.dev>
Date: Wed, 10 Sep 2025 22:30:46 +0300
Message-ID: <878qim6r6h.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Wed, 10 Sep 2025, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote:
> On Mon, Sep 08, 2025 at 05:01:13PM +0300, Adrian Ratiu wrote:=20
>> +	struct strbuf encoded_sub_name =3D STRBUF_INIT, tmp =3D=20
>> STRBUF_INIT; +	size_t base_len, encoded_len;=20
>>  	char *gitdir_path, *key;=20
>> +	long name_max;=20
>=20
> Some of these new variables are not used or are only written:=20
=20
I moved the logic to a new commit but forgot to also move the=20
variable definitions to the new commit. :)

Will fix this in v3, alongside running more tests & diagnostics on=20
each commit to ensure they are also bisectable and so on.

Thanks for spotting this!
