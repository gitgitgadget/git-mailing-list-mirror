Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292FF81AD7
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413550; cv=none; b=YDkQhBpd54js+3eP+C2PBoj57Ibu1ZAYXBlDfnaUv/cHnjUZNksZaR6feTKzDhKrjm5mTDIZR9Yk8AYCN7pdL1OtxsH8t/KZDzLVTUszyXUcBJzdOOcBnfV1Lva/B8nXK7waJqjpbV9S9OQ4YGDKM17H89XsTXqipmdbFX2R4uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413550; c=relaxed/simple;
	bh=zUbi7PudIiGlQuw2Stbr6tyjhpLuX+WU64iCQYc2z7Q=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=fa6jwfqQOV5HTCGU2PAaRxluAOmCaMYflP9o11dhfDv7iJkjxsZWq1EO1l1l+ocF9eeQGMDbpeUEO+kaVtSX5stmPw2kcGPPLsQ4AUxr4bSjP1I00S2doqJud7KWq7eciBdOwP9CEeLhN40VTSxFGlIYAeR7w1Ow2FcUNnaWL+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b=i399uJSY; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b="i399uJSY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707413546; x=1708018346; i=toralf.foerster@gmx.de;
	bh=zUbi7PudIiGlQuw2Stbr6tyjhpLuX+WU64iCQYc2z7Q=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=i399uJSYUD89rGNUK4etgyrRvnmntSLAmvdamVqP/qR3hDSygfZZIx2Lbk4L0IBG
	 MaU/G8vXh3F9dMb47dUI9vv6w0qGYNbl8Oc9HkbdLxUIoPjkb9j/23uyOB2HwFFFR
	 5IXaJKPkrDYibZq6geR4A31VdYggvz3TTc1d27NAVwAGf4i5U9F+vh76zWQ9p8kDj
	 jP52z+tdcRdJ+1uTdveify2hRRZMt3O4qPVODObpl4sjwXIb59+/rbYvdJg9k837Y
	 VWbQZDlgNktFrNA4F3S53zLfzBv/s8Rtsj9VFTmwVv4rkOvUbzhEkqNqa8AFvUStJ
	 fws6OwClD4UkRnlDAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.33] ([77.6.180.238]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmUHj-1r7dGN0frd-00iTZ1 for
 <git@vger.kernel.org>; Thu, 08 Feb 2024 18:32:26 +0100
Message-ID: <2f773980-70ec-4ad0-a49c-3ac12c294a39@gmx.de>
Date: Thu, 8 Feb 2024 18:32:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Subject: cloning the linxu kernel repo at a VPS with small RAM
Autocrypt: addr=toralf.foerster@gmx.de; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YrCOgi9zWEU4aMw//1XQrhDg1tPgnCU4dbiPGlKI64JxcD/j32/
 PCUIJXclULg0VINPN1OvLvWxEELvthTYAiafWjgqsEN+RRVJ2mYLndQrqIrh6vp5sC9NBAs
 vIAz0GbUNStMz7SW+X6W2wD36Y2is6EmAkepq1p0sVUVJ2mb9fMavrJrA+w223Yku2M4GaK
 mX2UUSMq8EB3XgewtnZAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6wVaDX3g5MM=;eruMZo8Ae4vvFVOKvHMRo+An934
 wTJmzniI8TCYADb+4aM1/vWLUyhv18vgx6qIWlG2Px0btDF0DGZqGxaKQBhEHDKREyUQi7VUe
 vpayDbzz7lhnY+xgaBfsd/8Mo9on7f0YEAuIWsm9fozi6lX2+cJbhEpXCaezOPw6HB7zb6y3U
 rbTVdNEAHs1b8MuE7sp/p3CWOVFDbSz8XwgHjPZzaGf9D+A9BiHKP5xL74nYV7dC54e/jF2tO
 mKQT6EQecnQ380b0P1KeuQ/PZrL8LQ1R9+bQuLdUmygIr6hGvaaUlGWReprcrqxlHmybQIJmR
 q8S3SXTJt2V5tcUyqyXftYfFMwbnF3z+P0jlrsJCzdG7MHcXCu3MfXfi1i7UXOwzNwSLZFfhh
 /4zYkHW2zJyATIVCAZEu9QWTatTueznw6IMbbfGCF5XRaQi1dJeKwE1Y4Z6ZyMcNMHleh490+
 urCwhctf5ArGMndF/6Up0xxdxaqgefriEs/Z38ZMAMkJeDhDG5TMUzH/K+mfDu8K2TTfz0k8a
 xAqnTJMbQQhs2T8Ceknm9S1huRi9ffLJRB2w0tyHh3jVqRP+h7nctFDryyHD52oHr3gx79P55
 aW5yMQlmokgi1JiB98kWoi3pnRZwVDNluYgMgeuuM6pCmAyvMFl+zYxf721vM8HzDvGzyEASZ
 d4j7MPgQt/psPXij1PkQtxd4SOjAUR/Sg8VwdOoYX9x7hQ6xzuL4rz87DtjHd03quRSJJvQc1
 VwCHuJZl8ZfrBYGrGeQ9PZgclw9GXcuBq3/BpVR8vyigewRfVrO2C7hbXrZawIq8gIUL/Tb/E
 /LlvoYPdEtdP9q87yzMN9SyBzh0qMqYiw7yScmniHeJ+c=

Situation:

The command
     git clone
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
fails at a virtual server with about 2 GiB RAM under a recent Debian
bookworm with git 2.39.2. What works for me:
       git clone --depth=3D1
https://git.kernel.org/pub/scm/linux/kernel/git/stable
       cd ./linux
       git config gc.auto 0
       git config pack.threads 1
       git fetch --tags
as seen in [1].

Q:
I do wonder if Git could automatically try to deal with only 1.5 GiB
available RAM?

TIA

[1]
https://github.com/toralf/tor-relays/blob/main/playbooks/roles/setup/tasks=
/kernel-git.yaml#L22
=2D-
Toralf
