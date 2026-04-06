Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECB23559DF
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 07:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775459252; cv=none; b=s4UoY0tavZJXCpYdMZGkGGoO3IWg5hi1mbymLuut/z0pCahI0gwOciI++oKg1YSkZ260fHGx9Cv8Y+KE6tEqsjKc/LtS24nP4ZkPwE8dcFeh8e+2YoQ9xW/XzPB+8I2/uyPila+8XJw9CDOigIFQBiTf+ngZnBzbyueRa0/1hiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775459252; c=relaxed/simple;
	bh=X2mlTz4jHjOq9zya4DRVJQWsw3bDc5xIpoGqLuxeDFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=o+4YVqTchvFixQaKppD2IoZgBb1KETfKaT5S6yZJlPoe/Bo8UWtzAGoHqC0sFIhw8tEI0coFgbCVfOATmqqSHlQQwL/3Xmyr5qIeX0G6U2s9hgYQkiRUozzNkxFAQCjQPmxIOde8bTcea6zLG9BHKAEBF3zXYQ3mBa+SJKLQCg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=bKIm3ZN2; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="bKIm3ZN2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1775459243; x=1776064043; i=l.s.r@web.de;
	bh=3+Wlemk99k+If64dSgxzksWN6ivtYrqTl4DA2Txl86o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bKIm3ZN2dY/zhG/4vNaTA2JimWr+BH9/ieBKb4am/8k82Sbg7ZDIFBHfjP2NTjOV
	 3r6lwgXaXXdm3tecpZ6RVhzs/qtOw49qPXgeHaoMt9y2GCNMUvxHBwhoyuvFtMtoo
	 U/hQ+nbpRXEsUSez1jEguC3DK4lyfA1wfqf/MjTGdv0L5WDA4oPIxfMUcFyOW93wQ
	 mvO7A42PEU5cj5dBT8s8GJgXvqbWQhTeE1Po6o5zyTrDs56hZ1iPSfxFmpOB2eD+u
	 w77lGu0WojHffy2lQSKsraWHYtBin3eOmzNC3FYD2lt8fzIr6CgVlYuAE1dzeEDP5
	 vkvmvSQJAlOqvNFwZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjxeO-1vlbpT236u-00mpJg; Mon, 06
 Apr 2026 09:07:23 +0200
Message-ID: <47629c96-8764-45f1-b36d-d944d6282cb1@web.de>
Date: Mon, 6 Apr 2026 09:07:22 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git 2.54.0-rc0 Breaks on OpenSSL 3.0
To: rsbecker@nexbridge.com
References: <029f01dcc52f$2c8b8c70$85a2a550$@nexbridge.com>
Content-Language: en-US
Cc: Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <029f01dcc52f$2c8b8c70$85a2a550$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hpb9LCrroKFv5rjBt6VxHmpyB07fdx4evUc5ha4o5HptoTw0mWd
 uDV66GIcxmhlkFQwqWxgJMS4PW4IVaw8PyeXLuchpjRTN9+K5YwuD5s6g/PvysQrMYBmboI
 Un2M9FTEi9tjQ1GJIJdF0fBNDz8gZGIVJ0qpq9aXo+ytSQDdii+uLd5atvGWMHFJqZjHRvZ
 Ae4wM8wY1vSLGN0GHLF5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BCl/ynGlCmY=;sYRBEQQmxsbJSTkOKZhwLuLpG1Z
 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

On 4/5/26 9:05 PM, rsbecker@nexbridge.com wrote:
> Sadly, OpenSSL 3.0 is still out in the wild for those who have extended
> support contracts with OpenSSL.=20

https://openssl-library.org/policies/releasestrat/index.html says
"Version 3.0 will be supported until 2026-09-07 (LTS)".

> The following errors happen using OpenSSL
> 3.0 when built with c99:
>=20
> "/home/jenkinsbuild/.jenkins/workspace/Git_Pipeline/imap-send.c", line 2=
74:
> error(252):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 argument of type =
"const X509_NAME_ENTRY *" is incompatible with
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parameter of type=
 "X509_NAME_ENTRY *" (aka "struct
> X509_name_entry_st
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *")

This line contains:

	    (cname =3D X509_NAME_ENTRY_get_data(cname_entry)) =3D=3D NULL)

https://docs.openssl.org/3.0/man3/X509_NAME_ENTRY_get_object/ gives its
prototype as:

ASN1_STRING *X509_NAME_ENTRY_get_data(const X509_NAME_ENTRY *ne);

This has been matching the code since OpenSSL commit 9f5466b9b8
(Constify some X509_NAME, ASN1 printing code, 2016-07-07).  git describe
calls this commit OpenSSL_1_1_0-pre6-232-g9f5466b9b8.

> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ASN1=
_STRING_get0_data(cname),
> hostname);
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
> "/home/jenkinsbuild/.jenkins/workspace/Git_Pipeline/imap-send.c", line 2=
79:
> error(114):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 identifier "ASN1_=
STRING_get0_data" is undefined

https://docs.openssl.org/3.0/man3/ASN1_STRING_length/ gives its
prototype as:

const unsigned char *ASN1_STRING_get0_data(const ASN1_STRING *x);

It was added by OpenSSL commit 17ebf85abd (Add ASN1_STRING_get0_data(),
deprecate ASN1_STRING_data()., 2016-08-16).  git describe calls this
commit OpenSSL_1_1_0-pre6-119-g17ebf85abd.

Are you sure you use OpenSSL 3.0?  The errors suggest it's a rather
older version (before 1.1.1).

Ren=C3=A9

