Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB7D1DE4E1
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765651529; cv=none; b=FWab2xquTpM+mWcy7U0xhR6Bd2+pGN/zy+jF6eOYE1gEZnxYBMQFF9fGfouPkpFJwdYq8ouyVBh3xc5vPIwE7cs1cbQFg+Ra6pd+oT1vieSCQEs/l43RLCXosjgpPTdMnM2Cyg2OtPAwHCdQzJxBUUz/aTOGmPq7xgZKuG4O9fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765651529; c=relaxed/simple;
	bh=+xs8C0um8ytH2YpfXa2h+JqCgW+jBcEs+uX3yawqFqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tVrTdwrYhJshbB8RlAcsueGY56AZe6Ypw3q+MBI6mCSCGXFtSXI5kYvnRI0W3INmAx7Qg90RMTix2dj1avWpDqEygW6ZgHiQlRf3jNEjvIc1XAEzUl7I/5bAfDuOlVcMTd0DiFJtfcAMEQq7OfNT5JQ7HLAQGnkUIvbVeBQLnIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Xzoyktka; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Xzoyktka"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765651525; x=1766256325; i=l.s.r@web.de;
	bh=e6KLsigP9huAbDvFoq6Jl+NKqbMl+BXYmPtBlpZktDY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XzoyktkaRzgD6AkTsYuCUc7x0cD29ggvw+c/uglQPqAu50bdiQgEXZ37V6I1TktD
	 6vzoy8suxD9/+ncB6XO78mowpoVg1V5o+cH6WvtzHM8sD6vLoFXkOysWt18Ma/ag0
	 QoCvy2+D7vAZT7mY+bbVzol8AP52s9Mj4s6wLNovRBybV31xV8atizT6btJgCLg6z
	 4/am6RdneG3eODqdLXj+1AqC/8j8L0ozgN/Kc/JX8Ocl7W9gMf7BaryJXKKqkgv3/
	 I1m1mP9vRVyc10238FiU6wKWwn/5wdv5ICBSxdLuS/B58OCH2j310Ztg25PZo+1RM
	 CSf/XMTXWJtwbWEtIA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MRF3I-1vgdgf2nhs-00YtdJ; Sat, 13
 Dec 2025 19:45:25 +0100
Message-ID: <8cf62607-5fcc-4b7a-8811-9046b7c3e7d7@web.de>
Date: Sat, 13 Dec 2025 19:45:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Dec 2025, #03)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq4ipwc7y2.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq4ipwc7y2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LGSFFznCVeWhC43lbAAaV9JJO5B6cwnm/P/G4p0NnrUmq88htke
 f778z6VxE/rF718Qh8kw+PZ2MRd5g4oxoI9vSfuDblrIblD3Kz+w+lqS1a9APughYkPZwpV
 elTkhjresT1SfpKyS3ABlu249GPFWultP3s1jchlWAmhl7mRY8lU0JkfVG0pDjfth0aQ6ef
 G20VrNu10iInw9/Ao0tUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TtRjI5i+Qe4=;eBaj86UWAkOxmG7bjFZe21SiW4F
 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

On 12/12/25 11:26 AM, Junio C Hamano wrote:
> * rs/macos-iconv-workaround (2025-12-09) 1 commit
>  - config.mak.uname: use iconv from Homebrew on macOS
>=20
>  Workaround that "iconv" shipped as part of macOS, which is broken
>  handling ISO-2022 encoded strings.
>=20
>  Will merge to 'next'?
>  source: <16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
Not, yet, please.  Just sent v2 which adds NO_HOMEBREW.

Ren=C3=A9

