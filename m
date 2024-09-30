Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A436F18C008
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688799; cv=none; b=PnQlKKHX55ZSbibcz1upMzoslmCHwx2MuPevhx2e5p/N0bYpgnGCY5nXTTQlH5JFhsUzrB/O0vu4jEBo1PBiygYkM1Svlp02JupEkBl/FVvMUXKpCCEbELIyk31xyntPfDtkTVj+U0QKpSdU9RmtioQ/OnieQCRDq5qXnAV9fso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688799; c=relaxed/simple;
	bh=7y8qqSOcIaAuaY0ZMEvMJgdv4oBvFEL8kYXww46d3b4=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=JzFp+x5ol5O5taLO10Ng7mGYDhs4tm66NgzKXAXuk2aRrTjhec+ITSR+W2XBNi6YnhbNIkigYwNtHdjg8Wy75xssTVEtVfDV4SiZ66U1/g64KunBGD4WDG5J/7jg6IUqX79vI6nwC0gvn+uZmh/et9gqVYjEgAkrTmE2C7lHzeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=kLLJpDcv; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="kLLJpDcv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=7y8qqSOcIaAuaY0ZMEvMJgdv4oBvFEL8kYXww46d3b4=;
 b=kLLJpDcvo0xczop+ax0NVgwLNwox/lnnxT2C4a6F7q+q5ojHT/NdPt+mHLH/TJk1rI8cHsgsdAFH
   WkdcJNOol6zzzWJkEinS4k735cy8RotWsebeC8YBT8lAiw2pX6JM7FvlrcxmU1uJZQ3jMxyDw4j7
   9EsM4fvtvUVTTU9T+K3hyXcSo7VUwNXSypBpXxin5jMYgeEdvi362bRfF2eH5wa6eWA5z8sUyW0K
   uNQa8SoAtFrdlkm0GtQf1OmjaLsBGJX7PxoySNL0JjN/OfFvx/C2UURuKc/tiHpph1iA0S6+TRrD
   JDeK6ndDfRLQOSq6eUMFWam7FOIB+lDozhMJGg==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SKM00LYZCYW0EA0@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 30 Sep 2024 09:28:08 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Mon, 30 Sep 2024 11:27:47 +0200
Message-id: <D4JIG4VS5WVN.2F0PNU5514UEL@ferdinandy.com>
Subject: Re: [PATCH v3 1/2] update_symref: add REF_CREATE_ONLY option
Cc: <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>,
 "Junio C Hamano" <gitster@pobox.com>, "Taylor Blau" <me@ttaylorr.com>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Patrick Steinhardt" <ps@pks.im>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <D43G2CGX2N7L.ZRETD4HLIH0E@ferdinandy.com>
 <20240919121335.298856-1-bence@ferdinandy.com>
 <20240919121335.298856-2-bence@ferdinandy.com>
 <7fecc442-8d5e-4542-8ce8-907c35db870d@gmail.com>
 <D4CB89OCTXWW.2A4NL7RQP4IS@ferdinandy.com>
 <D4J51ZYZXBTV.60W3NPNVL78L@ferdinandy.com> <ZvpHxsPc8IABtIDo@pks.im>
In-reply-to: <ZvpHxsPc8IABtIDo@pks.im>
Reporting-Meta:
 AAFv4p1quAQ6gFp1ZKpx6hn9r/b7Viy+hOYDMFHUszG3t1+CaJ9EZFhmHkOc3Gl0
 7RjKsV7Tn5+IsJysNsO5cLi9Rz6zXA4Gln9MWTtuBXozDc0USsteMpv0rD91YiBs
 98mOQcnGpJDbAUj/UQXY3fjz2r2vL1lB/xofLACPpMTdWQUHgdB+TfJ/W1ig+Bs+
 a8JeLYWNTlj22eypT7e9YQuwlpL6e7sECIEUWco1wCQkv/n7G/T+cR0BREwrz0rf
 g0UnGRyXXBGpQTS4K96A4mmcNSH0r24UKGkAHmmoBsbrXloyNwjXksKJaB3McDkJ
 EBDZiWuqJS5TNZH7RPIPQgjB7HC73Fk3yLWks1F6RonoJH3Lxi6Qpar9mob1aB41
 jfLshBQnPmJqEVM0AqEaMquUwtjmVRmOWvSDxXLly2pjGy/QByRQW6PhQIqwzmQB
 /pyokpgugHSGkrh7UAUfXnHOHlJBwwhOb5IdiAKnhb8I+U+aMsgD2vp6


On Mon Sep 30, 2024 at 08:40, Patrick Steinhardt <ps@pks.im> wrote:
> I don't think that is a good reason to introduce this new flag though.
> If we need to have a proper way to identify this specific failure case
> we should rather update the already-existing mechanism to give us useful
> signals, shouldn't we?
>
> The problem with this flag is that it basically duplicates functionality
> that already exists, and it needs to be wired up by every ref backend
> that we have and that we're adding in the future. Your patch for example
> only implements the functionality for the "files" backend, but it must
> also be wired up for the "reftable" backend or otherwise it would be
> broken.
>
> Another issue is that it gives you more ways to create nonsensical ref
> updates. With it you could for example create requests with a non-zero
> old object ID, and if it has `REF_CREATE_ONLY` set it would never be
> possible to fulfill the request. There's probably other cases where you
> can create nonsensical ref updates already, but we shouldn't add more
> ways of doing that.
>
> Mind you, if we go the way I propose and improve the error reporting
> we'd also have to adapt both backends to do so. But that would be
> plugging a gap for which we have no proper solution right now instead of
> circumventing the current design by duplicating the functionality that
> we already have in a way that makes us able to handle this.
>
> Patrick

You make a convincing argument :) I'll try to see if I can add another
transaction error code for when you only want to create not overwrite and t=
he
ref already exists and pass it up (for both files and reftables, you also d=
on't
mention it, but I think this would not concern packed after a quick glance =
at
the code).


Best,
Bence

--=20
bence.ferdinandy.com

