Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9ED25785D
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765547298; cv=none; b=IM/bV4xNQq0PF+q6zljhQxcrUmX5o5c8KsGirFstBoHTgBALuF1RUZUgOyEbO+gIBSWVV4ZAZFkYYMngkWLpIPbb3RLqTaGIxhnnaSqdC8h6Mcoo0yJWX4nX+lFobWSTGPPtbWEi3LW/wQjbQIPv3s0PCXpifJZmICRCI4vPJIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765547298; c=relaxed/simple;
	bh=5Bj7nhPwPso2lFnHJzh5YJ4hZd9gxNwP4KG3kQSHqjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMsdDMGGp1C0CgwIinILxBoqc2ytixubblZU9Zj3g2K7tk0Vh9YS9mOMS320Obqea3zLsiDS/KkpeHvRf35UBy02dRYJgnPej/BIMtMz+dvZv0vZuldcOcs74eYc41MiawJVP5Q/4vgEUTIl6Nk18kMhBdzQbszSt98VnETOXZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ccheuVZt; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ccheuVZt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765547285; x=1766152085; i=l.s.r@web.de;
	bh=GIPAx68CVld+WX/M4Mol71dhC1m6reXqf6JnVngTMl0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ccheuVZt2Ukwry2EVzLFRjH9cW9iyRDP1bAzoylrBh0oSgMecW1NTVH3VklJnTFY
	 3fi3NAsrxXZ3Eds2ptk5AThspIQmd5q22dmddz+StVP7Z2RW/Tvu7OCi3Tv6k8aeb
	 AUmBxpUUlS/GhNJTfgWKOD16aEbX5YtZC/xAiK0SOESpXzCoWekBJpP1ImGqfloUl
	 iDFrscQqr/52B7gBzapVaw8kF6G/vuN3/qO/YV/w88mN/Jcwnwr9tG/L2ixt+PNY5
	 UHZ2AqxoZgApTYWYvD53hO+eqTTIKqAoB3hUUq6UkKtV80LVFdjmjJ2gGZFdVawWZ
	 h3tXMoLYNeEijOdMmA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2PdU-1vRILa3Kv8-006x9w; Fri, 12
 Dec 2025 14:48:04 +0100
Message-ID: <4b752020-036e-4f1b-9963-a54f361ef0fd@web.de>
Date: Fri, 12 Dec 2025 14:48:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] config.mak.uname: use iconv from Homebrew on macOS
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 Git List <git@vger.kernel.org>, Koji Nakamaru <koji.nakamaru@gree.net>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
 <qnb77j3b5m6rfbzr3qhmwalo5lha4gqslvzqsfuq6zur74ze7j@wqriu4w7wbzw>
 <1b3509d7-e421-4136-a62c-de86213d65b2@web.de> <xmqq7buthgq4.fsf@gitster.g>
 <vxi7g67b322sre7ylkcfwujf3n34j3f5vtpl62zhrj4ds6f675@hyyh2rxhaib6>
 <xmqq7buse906.fsf@gitster.g> <3ac57efd-a0c6-49da-b63d-825d97b3821c@web.de>
 <xmqqms3nc0mj.fsf_-_@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqms3nc0mj.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l1L+S4xBTCy2tTS6cSqbbD9hmqQPlXH6PQeO+mG98b1Ffd0tvQS
 g8G2Ch5QLV1kkwacAEH6O2yXquYSNI6dshJlwC+ng3h/6YhGXGbx4VHwICjhXhos29h4LL/
 lLZMh2RNOope2LPLw3BwA2pdxGGafw6SJSBFi8O0ozrAl+AflmLdtD3YRdUrKXS6JG5Y9MI
 xzbEUPuzkJxT9uKdYaQ2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v9JUjXc5bN8=;9x+T+jab2+DGmqJH7znK41pEi/f
 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
 An2D5hSMZVvY9VgCatUAzngS85+68

On 12/12/25 2:04 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> Fink uses /opt/sw
>> (https://www.finkproject.org/faq/general.php?phpLang=3Den#why-sw).
>=20
> Perhaps they have a symlink or something from /sw to /opt/sw, then,
> as our Makefile only talks about /sw and /opt/sw
Hmm, they changed that in https://github.com/fink/fink/commit/db958e12bf
six years ago.  Apparently we didn't get the memo.

Ren=C3=A9

