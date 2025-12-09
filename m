Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D02765DF
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765315650; cv=none; b=So7TtvBv651XxHrnpHKAJyY4ix6BOK/iZRTiZurYC1AZM47k3PVItxPotM6dwVELm7aVfNUQPAbz/qXvSBaFl6A9npuDyDq5uKolm9xRXGuRxWvnz+wyOezNOAzKIpvELm5Irk61nFaMyBayDcgFL+ZYr89AdCckDpzRJ6kEyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765315650; c=relaxed/simple;
	bh=2PwhNVAT23FhZNDys9GYMzW/M3fdPjWKkPYmZh3sqSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMYydoxfRiV1Nco3QdWpVjN11NTNrMh/hvmH6yuDvxREF9cXcDadxRcg7mTYbQdm0UEiANfVKakhWqc94TRIw/fI1g/v4EpmQIwVwd4h/4K/KLDuJX0R3Xt+7WRUkBqf8iu6JHZyrTXhdzVwZbwT+ETUIjo3z6z0Ejdzh8xNMQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=kRi/ondR; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="kRi/ondR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765315640; x=1765920440; i=l.s.r@web.de;
	bh=ahNteoCWewM78YB5VmJq0SfusoPfzfrGLddZHGM2mjc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kRi/ondRHe1zq4AIUUAmDGfqmkiqhDiimPU2W2e1m7IHt/1sHCaLf2tJELXivVc5
	 pfzd1QSXtWN9J/8nQk8YuWKAw/Xmh94vMDTvZ9XjifjrRnIjhZcRHIeMJvmMVmxWg
	 2/c6djV8Sb2dqSnTaaMPjxVyD5DpVUnHGaw5QZzYrCZtva6AxFUjWi493SIGimmPq
	 10Wm9OUvOEQzlaYqLMvz5X4hf1BiAid8VfEQQBdnFCwnS3sxXSNgdXm3XDZaOEL4b
	 aVuY+Ef5t/NeMh/BgOhvVC9Kqyi58X7Ern9iKnTXAEwD7czzDBR3EFWQ8ysf2UaD0
	 6fWj7EEy9Gz3maHFgg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJWsc-1viYmu1MGO-00Mvyd; Tue, 09
 Dec 2025 22:27:20 +0100
Message-ID: <2e9aef63-9da0-4635-90f8-fa3e16dddde5@web.de>
Date: Tue, 9 Dec 2025 22:27:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] config.mak.uname: use iconv from Homebrew on macOS
To: Yee Cheng Chin <ychin.macvim@gmail.com>
Cc: Git List <git@vger.kernel.org>, Koji Nakamaru <koji.nakamaru@gree.net>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
 <CAHTeOx-LFJVtNXrY-RfVUcAA_SjvK2310_xQ3skUEgKKQ6w57Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAHTeOx-LFJVtNXrY-RfVUcAA_SjvK2310_xQ3skUEgKKQ6w57Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xMyImh7PFu0qL2csxo+o133vv02kTpOQW5IKaO+fFbzprj57GZS
 W3/mTu+bngvFDx27G0Htf1RUH8i6lBtbEUZX2uV7QMm7asHlOt9Ex0+YUQ0KV0sUAxHtAzK
 tq7NgWVW4lneBeLFqRLkQYmOxOzwm1UkTroNxHZ8zBK5RLcc4E+UaEI26imxmONvZ445WX4
 +czriOP86Jt10r712vl6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NqfDkZiuXRk=;7u3JyTyapM+VyuSv8fyS8DQBJ2U
 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
 AUJ77Fmx5Tevt4Qos=

On 12/9/25 9:39 PM, Yee Cheng Chin wrote:
>> +       ifeq ($(shell test -d /usr/local/opt/libiconv/ && echo y),y)
>> +               ICONVDIR ?=3D /usr/local/opt/libiconv
>> +       endif
>=20
> One thing to keep in mind is that x86-64 Homebrew (which is the one
> that uses the /usr/local/ location) can be installed via Rosetta 2 on
> Apple Silicon Macs for testing (I use it myself). In that case you
> wouldn't really want to use the /usr/local/opt/libiconv location. It
> would be a somewhat niche case (the user has to be using Apple Silicon
> Mac, and somehow has Rosetta Homebrew libiconv installed but not
> native Homebrew libiconv), but could happen.

If you have libiconv from both x86-64 and aarch64 Homebrew, the patch
will use the latter.  If you only have the one from x86-64, it will
try to use that.  For gettext we already do the same.

You can force using the slightly broken system iconv as before by
compiling by setting the make variable ICONVDIR manually, e.g. with

$ make ICONVDIR=3D/Applications/Xcode.app/Contents/Developer/Platforms/Mac=
OSX.platform/Developer/SDKs/MacOSX.sdk/usr

Ren=C3=A9

