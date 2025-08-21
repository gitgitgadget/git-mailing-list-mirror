Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331B33218B6
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781719; cv=pass; b=jwSJ/gbyvkNQ9IM+Gm4ws07dniPHJJXN7R2GZQilC9rN5vMoV4e4vvWXAtWcRoAQumY9uAq/gh+X+BglJOjPHlHTKCsqsTshj5qelzCuNAPDuAlaSnH+1+Z1J44312ZmXNvDn6Y7H9XHtctyWecM3TF/vqciJZcQr0WxJeJVNUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781719; c=relaxed/simple;
	bh=QaEYedjBtpyMRAAKb8g1HeINZYDp+olszHfr1CH1jZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gURPFKCuYxgodf07rbUxwDXmIAbrVkWm7izGrlyv+1x3OOs5hVk/OQtnTs4m9m6hwo/9USBp5ytbzzpTf2ycLWrntbu9EAQKt7I628+kO7wwA92hKYlhr6hGPWjuNrOzQKyW+Ljz15M3Zx3keizxfjqkvH6PCWYUte/zA59+F5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=gouceu9c; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="gouceu9c"
ARC-Seal: i=1; a=rsa-sha256; t=1755781702; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FQp+jZarmbXRKCW0ejTNhjKue4oxwbt+Ba8//OEiqzZteiUo1et6SHTO8lw0cn5yxadfW6CtoIDC0gRusvM2MpUAF07TeLXXo5Sjjt3CGGu5oEsiIYpbXxHprM2AoYYdEBa/6moH3Ooj4w2x1pOe80+BAydv1QdEcJ6LkW5TuL8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755781702; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+NgwC8lFSgM50sDqQ4Zn/rVzhGwP2V3+5SoQphk3BJw=; 
	b=mlzyhhlucd9GU3eB5RoWG5EKwk8I9le3Scre0VsPXdnZAb1g7vhJ62+WLHHKQbr5HnZL5NuXYDgtO3MSVI878MC6km9lZCk4p0B/Nrh8JHubjozu35OIw61WCH/UECWtpn23VilHswXRAaTEELUh9SG9iQx5nS043sN94SpAOOs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755781702;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+NgwC8lFSgM50sDqQ4Zn/rVzhGwP2V3+5SoQphk3BJw=;
	b=gouceu9cXQkzIG9Kwixht5r8e6tFQ5i7GL5+pKO+YAn1Kc85dEbCzb8hTlY4oOzC
	JgFzK7gdJ72eVEczzClZhffpKpGmZYL2k6xvSIKcaS8eo454mnsWk03EbOv03yDj6Va
	bExMXUmOq88hWdGK8fXhmDoSde8JzW6sgRJpOPH4=
Received: by mx.zohomail.com with SMTPS id 1755781699363396.40272035989904;
	Thu, 21 Aug 2025 06:08:19 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 5/9] strbuf: bring back is_rfc3986_unreserved
In-Reply-To: <AF619536-A31E-4D5C-A553-4CDF8D05FCB0@gmail.com>
References: <20250816213642.3517822-6-adrian.ratiu@collabora.com>
 <AF619536-A31E-4D5C-A553-4CDF8D05FCB0@gmail.com>
Date: Thu, 21 Aug 2025 16:08:15 +0300
Message-ID: <87v7mg7rgg.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Sat, 16 Aug 2025, Ben Knoble <ben.knoble@gmail.com> wrote:
>> Le 16 ao=C3=BBt 2025 =C3=A0 17:39, Adrian Ratiu=20
>> <adrian.ratiu@collabora.com> a =C3=A9crit :  =EF=BB=BFCommit f89854362c=
=20
>> ("credential-store: move related functions to...")=20
>=20
> Here and elsewhere, we refer to commits by the output of =E2=80=9Cgit=20
> show -s --format=3Dreference <object>=E2=80=9D=20
>=20
> Best, Ben=20

Ack, will fix in v2.
