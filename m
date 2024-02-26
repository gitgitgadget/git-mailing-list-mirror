Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9812B166
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968414; cv=none; b=poJKkwA79C1WQXYrWuUi9hJMEa0soGZzT+Rz6si94SBWmmvbpYBsBZ8Z5w9NvvaWc5NfsZKTTxLcng7KgeuruEpbO3AfPhzPWZGtQTi+ZkRIqum+BTa2C1DF9LH4hUZ14SJxInDoTKtXQhVIiTUQcL/+WsmyWaesRomd5+s20sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968414; c=relaxed/simple;
	bh=6lFtKxOF/Zkv5k40Rx2hUtuH8Anm9mf0O/zV/II9S+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFVT4liFDf5DDDaZg+AFB9OyMRG87ejLtUPZUs4zWVvWstWpw+bSxaON3Lkm1wyf9fNFmMz7yHCaWsk/q8r97KEpmW3gtaXJ4LYzNaePpT2upsPO+XSERjgcGILE/utEF/QrIpqv1be+ntZMvBVylM44HzHpcrSImKZANxsTKUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=FVRvoTsj; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="FVRvoTsj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708968408; x=1709573208; i=l.s.r@web.de;
	bh=6lFtKxOF/Zkv5k40Rx2hUtuH8Anm9mf0O/zV/II9S+w=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=FVRvoTsj2Id9ydHwLXKEhJsHrRuEFHPdYR8hMJco7+d6o/tgnWQ2xdvzNN+00CwY
	 PQJzUhImn+ehpsBbrM7VOvYADow55IT56M9bmNLyoDbTaVibdbS/pTOUsP2w2RKw+
	 1LELZdIUm7KCptxa2XUCrjfOd0PqsMCuTbSrTnpX7yxUx4c7qI7cAgEEL7gdjk3sO
	 N5TloBoFHa9/L5Ir3o/2AzIufDVcP3awjT2xNI5ItZW2SfhBfJqfrwJlvyfT4JVjf
	 fpvo8lIcwFEM4QKV1Keinals05Df7gTFH2FvpQHKaXYJSKMbsafX/cXYvi9ufAhy4
	 eB+q31wHKrmIkENJXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8mzy-1qrYoI1o50-015fNZ; Mon, 26
 Feb 2024 18:26:48 +0100
Message-ID: <d96aaf45-f073-42d0-b69c-703393634848@web.de>
Date: Mon, 26 Feb 2024 18:26:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] t-ctype: do one test per class and char
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
 Josh Steadmon <steadmon@google.com>, Achu Luma <ach.lumap@gmail.com>
References: <20240225112722.89221-1-l.s.r@web.de>
 <20240225112722.89221-4-l.s.r@web.de>
 <CAP8UFD0Wi3ot-t0Q7ruMauwj4zkMfd89Xr9SmxYa4eQ3=2VKOw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAP8UFD0Wi3ot-t0Q7ruMauwj4zkMfd89Xr9SmxYa4eQ3=2VKOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0KILY2buIcVlSb6ATafbNapXZ4aBjgHkuEJU3h3nhWBtmTaGODc
 3abAZ9xTARsgU64zNS6wL7sFuUzgJz47sb/QHmc9Jln0N0Ww2bOyal4v/fR90WRlfM/HBxB
 e/MWkKz5FTUzjdfLfLTSFt3OOK3nJ7lp9Re40blD7hh2Zispl05/n9rkJKDxKNGU3j7opmx
 Um5ifEO9MKppevnq8KIQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wCtVYmR6eZM=;zsRVIKWr2tEImWs9pUtB03PRSDn
 0K0/fAdJwIZwXcPRSaciVohGxN0+vIjYCMOXhs/C3RM9iiMm0KSu9e4sJo2SALDfsoGUmxuNZ
 e4kcn1qQ3MGpk8WzDRucBciFrPeIvMbC52pDXN4mz4MnICeK4ggM1QdQlcSTOZIsyyk46mfMC
 4ktnyrrvIZoo9cXdRRPXnc4S/YuZyOtdY0Qr1FNHKx+aqrnleriTXoebmc/UW6i/qhv3/gcAR
 Y8Msf48S9G1K9pWR7ZemPY2Uw+y5FLxyRtiQtWnsZWlFPKA9WfdsXi4axGyr+I4muQD3IlPfR
 bxq2WWXGZcQRripP1m+pSwPBzMCC4nq4e6E+kDS+8DdZr+j69zwLjbgO8Quoyo18CT06N90wM
 AjCUvGpFWWu3RgkU8kOPctM3NrzzLW2Jkxwd6NguAlaFKS3b3F3Z1tP4o6Ny/JyLZ9LoY9Zn2
 BWv0DHypnO964kBzxlxr0JgOLVxnPXTC4++NLjeTyXBSVKshwKK9Ene7JjrHVC7aqEiarNkq8
 5yCPdCvRc57ypRCanIC71kVLuSuyJpw9ka+b3ITrpfc3syglJa1GIfc7F/som6CDwpBkIUia+
 WCJ4aqhBogbyEG+g5PF2GMnKtl9zfqMnMMJoBPbGHUhGaA0jXx2vg19QtRN0Ft7dftBlP1rgr
 ZN2ytTW40a8HGpvndhFOfzmMlMWo8hGr06Pwigkoz2PBSmWRssAts6gVQ9xNCh8/3m8aP5RcC
 QOCwf+I3Fyflmy+d0jLVyPtNIeK8q7qzr/Kj6DGQv3n9R/zUwtCQORW1IW6oQeXvXjlwoT/W7
 Cn6Yyo1a1HT1Mee2PUSRd/h6QTFE3F5I1DaKul7i4nfwI=

Am 26.02.24 um 10:28 schrieb Christian Couder:
> On Sun, Feb 25, 2024 at 12:27=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de=
> wrote:
>>
>> Simplify TEST_CHAR_CLASS by using TEST for each character separately.
>> This increases the number of tests to 3598,
>
> Does this mean that when all the tests pass there will be 3598 lines
> of output on the terminal instead of 14 before this patch?

Yes.

> If that's the case, I don't like this.
>
>> but avoids the need for
>> using internal functions and test_msg() for custom messages.  The
>> resulting macro has minimal test setup overhead.
>
> Yeah, the code looks definitely cleaner, but a clean output is important=
 too.

The output is clean as well, but there's a lot of it.  Perhaps too much.
The success messages are boring, though, and if all checks pass then the
only useful information is the status code.  A TAP harness like prove
summarizes that nicely:

   $ prove t/unit-tests/bin/t-ctype
   t/unit-tests/bin/t-ctype .. ok
   All tests successful.
   Files=3D1, Tests=3D3598,  0 wallclock secs ( 0.08 usr +  0.00 sys =3D  =
0.08 CPU)
   Result: PASS

Filtering out passing checks e.g. with "| grep -v ^ok" would help when
debugging a test failure. I vaguely miss the --immediate switch from the
regular test library, however.

Ren=C3=A9
