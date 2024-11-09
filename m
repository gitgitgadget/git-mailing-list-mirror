Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D01413B586
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731152166; cv=none; b=s/4S8P2pyHGL0pP/N9Xss135MqdOcLBU0D2TBfKvP/vGGRrfHES2hdZ0q8KDk+oAbXgro8/1H9iSVg2be1fFDiyo+bxk7el4hAzzk/ylePy4OAEJPdivqmFKaDvloqa37i+l9mVSEFxTOSjYndocAJOMEi9zXVZ+mt7nQPtUeHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731152166; c=relaxed/simple;
	bh=tjYDSSDPWAeZcbrQwGBjBxcR/Kk3M14rh78TacAYEBg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=mFRXs3HaLoynRoXJ+7h1QSjxOFO1pPlois2vE0CfkgQM6MRGILkK2yyyQ8TnbPH6kd7IwanWJMB2mRqBHG61hfWAPXX2BxyyS300RyLQcpvZ+iCXRlfHKkGwpKPdQlxekVCoyfg6PvSzztK1fQsnShSB3KOMZXyG1ML64ypRwO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu; spf=pass smtp.mailfrom=delpeuch.eu; dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b=BJcnLeUc; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b="BJcnLeUc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delpeuch.eu;
	s=s1-ionos; t=1731152155; x=1731756955; i=antonin@delpeuch.eu;
	bh=tjYDSSDPWAeZcbrQwGBjBxcR/Kk3M14rh78TacAYEBg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BJcnLeUcIdsrUiFwbloWxkvWkABgmLQCdYyQvTBfs7J6U3rSza7N11Sw/hKMvm1U
	 ADUcxAHRTVeLsWCUeUG5v84QAV0ASxAIFzGoV4uVS/7va/JLCY4eQKGpELwSZAq6d
	 P8RoNwuYuR4QfzTj9OOSXOHTNPAcgGtepvsfV1uyZRO4NJN3KfpwURGZFen8+r+2K
	 NKAGHaZBR2JT8zoRdE/d0wPWWAuhU9/m3G+UX2SogjOR/sAQeTwzz9rtjwN3rdHBk
	 Mn4Fj1i7cf7focy7zyVUZY+KD9jRx/22b+xY1/wJLCD8WlqMy7Kk82u0NfEBhfd2z
	 fZt1TURaLLiPZ626tQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.178.21] ([87.167.82.116]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MC2sH-1sxOMQ07TB-0067CR for <git@vger.kernel.org>; Sat, 09 Nov 2024 12:35:55
 +0100
Message-ID: <a79eaccd-f309-4f62-a243-f8fdfd0f0e86@delpeuch.eu>
Date: Sat, 9 Nov 2024 12:35:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Antonin Delpeuch <antonin@delpeuch.eu>
Subject: Mergiraf: a generic syntax-aware merge driver
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YfULe2Om6gsKnZfykI9vX8p83fWNmftbrB+MmItYGHW0wvAoMtl
 iHtxZ11TX9erJiIpv0MTlPDfWXeGexIHxYbUtTcle+P+DE0wkDHrW3ARD8Pp8wDeDN2Yh5A
 mDnGNG3cUG5cm9QfXhlDalVCVW4VIIHvVKcaWaZ1JZNz76jqYJn3IbYtbn9K4cit4tHpCiE
 uuQjV0IjhfBQ5R72CyLAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:An4mLh1AB6s=;/jHanI15bsjJhBthv4y3B6j70mn
 PYplCrPihw30dNs1oE6Id00xulYXyjXnxYgfuLWTkYf7SfVZ9FZQEL6mSUqltM0MVEviCeAx1
 9I0mSndsHjYW+LIdlSMagj5LqH1ymelK3X74LsHXkSdA7M75beuRmukwqn5yHa6OQjuNZm52i
 N4GlXwPloSp3x2UrBcNr3HK1fdivvtIL9oVJd7g4yWWpnW5G8uTES2g/dBt5hPnpUnH4tuwL0
 thye/or+fKFCPrNoJcEhNWABrB22mfHSwKDMkyIQb/ilIik1Hlz0H9/+053M/130GHUE0tkY3
 LJJo6ukqYj3inuIQH/9145WYAKJZUiCIx/ptWepI4ms9n/1h1ld19VKl3O3FDDkx9e2CYAxyx
 sDmjN9F21gJngwQztFzj1+pk6StfVfy3hRPGTmL+xlYm3cNFqxzoOUIFcAaWvzi0JUjGZptts
 xSvPIoWwBo7DV72Im60R4WujDvwkmkxImgWdMaQwlm6xr1ZaKSLLVc1rhOPuHeiGKDtKxHFE0
 ggQ6ExJJeT0ARBuoyDWuZ+JTb4qKkEpFw+EwQ8xiUWpnbCNMyPbN7cKSrmpsUXV6uPcUsG9EI
 VUssfDtR2X6l8g5z5xtlnRYKpDKxpaTHYmzj6o9Z9e2qOHQLUBcRXmuS6t/cMNLQYjj985nKu
 s5BFrqLqmGiBZbCsoCiNp8osPRnGtUDg2s+4aeQfnf+szlBXzwip5YZfB+/IKAcWo45G1MQFV
 NIHNr2WJd89ZKHSVdwQqN6kKuHGygd2c0FeO7avzOCcE4NGsokA/VdAzLvzBlmMMoDdgr4SXi
 dS9wslXg/HvpckPK9dG+NmkN2wY+n0exmR0NBO8pKCJTA=

Hello all,

I hope it's okay to share this here: I made https://mergiraf.org, a git
merge driver which understands the syntax of the files it merges. It's a
bit like difftastic, but for merging. Language support relies on
tree-sitter parsers and some more declarative settings on top, to make
it easy to add support for more languages and formats (only a dozen so far=
).

Needless to say, it's just off the press and an early prototype, so it's
bound to behave inadequately in some cases. I have tried to make it easy
to review its work to avoid bad merges.

I'd be happy for any feedback and suggestions on it.

Cheers,

Antonin

