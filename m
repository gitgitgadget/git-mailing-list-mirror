Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D68D22F19
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722497566; cv=none; b=DryXvTLeciRfr22vhv5IdwtIDo6w+IMAtuN045ibn6CKc7MzeH5StgHDsrHaCTu/3AIWKTPcABGKiSV8RWAnRrHq6K/L9aVXcscMJPmE7R5Gg0GvcprhvLk7YLu2vhl69OvQ+f1lMIk15uMUFvXZuvoXe41GcuJmhfidzqYEr0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722497566; c=relaxed/simple;
	bh=DdI3lUUMDFDkbLVXpl7lhSD+CXXRY7KiAAjz++/NHO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aoIWE10tnpB/BAnMwE5mV9xkzzs/cgw9HwDsql8A8rHrXiT7QcUwfhWINB5YnJc+zQfONAF+4BIK7vfpgcm1e06ndrBH0nYJKsVj9htV5ursf2a7MnB3LsuS8UWm2SBCIZUDSQe8N5rIPUfLNsvG09NMPqupxuE7NTFN3bdAK7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=rCPoaaiz; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="rCPoaaiz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722497553; x=1723102353; i=l.s.r@web.de;
	bh=DdI3lUUMDFDkbLVXpl7lhSD+CXXRY7KiAAjz++/NHO0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rCPoaaizKNbpZmTVc7mIWCn7/Fa71XRL/R3KrjPznPyK17tVbbiTeDqNGTNTHkOc
	 S3JW5acOkknbhSB9a3SaVx8OCnIuB0TwAwutysxKgqDqfSyop0O6aPDSxSrBscTtv
	 yoWtT9NVSzTY+3t3vThhAsS0/thYCUuykMhDp3PBHy8TWOHjDURrJJmXDUfztB5xs
	 rdPlETcZKqayAI5GKMaXuxa5ySJvDN9n6RX+Zwx5tWjEnXbfTpXcME8u+5YPZ+JCV
	 KKzdbngtAHTvQ0JYLQZrZnjYrFLQdz/Rumfqv4H1C462B5m15IN1ukCf0/k4vLodY
	 pKo5mGN5hg37Btlqaw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.126]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxYbD-1sJvoW2iPh-018Ndn; Thu, 01
 Aug 2024 09:32:33 +0200
Message-ID: <51ec32ed-f2f1-4993-92e5-1acfcdbb7c79@web.de>
Date: Thu, 1 Aug 2024 09:32:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] unit-tests: add if_test
To: Kyle Lippincott <spectral@google.com>
Cc: Git List <git@vger.kernel.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <077a178e-eb30-45ff-b653-a514bfd33077@web.de>
 <da902de9-288e-4783-8b4b-a2a968d1e1f8@web.de>
 <CAO_smVh_2FEbTAqJDMZAKMsfTKrB=NH36G6jNmMTaEOtRaP2Pg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAO_smVh_2FEbTAqJDMZAKMsfTKrB=NH36G6jNmMTaEOtRaP2Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XwsGsRGw7hptaE4albXzfYvBdXQtNjXFM1labHBQKH5aVPlUEWr
 IwF65/PLP44xpp7G6XUO24/ixdlPtVqxcp2U5AaTPn5cPk+TeFGFwwOIwz7YtXOU7aARxq8
 HoksIjrmJKlNyhKa+9cIJvPXqt5jzDnwdwY9YLfpmP/BvewOo9l6y9YDTfW80s3VFlup79o
 iYkbbw0DgF41R2mT3dZyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bEYNfOQDx00=;PlQ4FbBCThpZb06RLhKSJ4xSj9R
 rZxyEXZEI0DQ7sBFOu3yvHomOE0siNNtU4e0N0BePEUiIvY7bQExSmDtnC1x5MO0wJjVI7US9
 35BiwRQAS7qQSq5dYeEAVilYQuQiQ2aydkU7pjgvd3aJmOnZT8taLvgLwqrw9+n5KhTGTC2G5
 Z7m/oSSpqlz13yBB4miWYO/3PpIpmVs2cbuR6XFKXIx27zCbM9EiRIxPqPqpSSnZAEPphlYeg
 bdvBZ2ELdcAPr/os31VjUOTCM0o0nhkol66JkgKB3TNV5wQ7naJbldot3z2TA+cZwlZniXT6U
 AkgckAkeIhSKXOD2st8yTsg/CMe/D/miwAPGFp4SqQ0+HrfQW6wj7HRryQLCpRxBgiZ85q3hh
 AOH0iUVv2fdbtdCJWsEKeAeT8rYLF7bsBeL6IpUgtGMhbPFl46yY2+hbTPMx/m+Pf1ffPs8VB
 XsWYwUZ2wy+CHwCtxyBsAOF2h4c092WiMSZCO8Q2ogtavyMDgmXWNNbc4I9vgapLyDaEyxGnh
 l961H2OFo5qtHAetZnSTlI/tuhIS7BPZHl3syOjuRYhZExZhN0A7xsc6xqFg8SrdTnJoedjZf
 ft1iLWzKTFgnwqFGbprW9sZKtrK4vXCk36WKLFEqlR6PQgYkiR70avYsvsXCFUPbXZuarif/z
 7bUxll1T7/Vh7fMfQHX85juehw7quCQIKQAMOBtHRWRTjewrFoEqZMCLvJ0zAMRhcl22bAm8e
 +etb1O4HgVGz+MLBEBZaaVd3JgM7iZCVMsiQuKKQCBk1zt+jifo2pxDE6FalbHaLdLFWxDTfu
 menZGu5zWtwpeMgz9R5MSI7w==

Am 01.08.24 um 00:04 schrieb Kyle Lippincott:
>
> I'm still not wild about the name, and I'm still not convinced of the
> readability improvements. I still want to read `if_test(...)` as
> having a condition in the parenthesis. Tests "skipping everything"
> seems like an internal implementation detail that there's disagreement
> on whether to expose to the test author/reader or not; maybe we should
> redesign if we don't migrate to clar or some other test framework. Do
> we get significant benefits from a test function continuing to execute
> after the "skip everything" flag has been set?

The idea is that the unit test framework may allow to skip individual
tests in the future; see
https://lore.kernel.org/git/c2de7f4e-e5dc-4324-8238-1d06795a2107@gmail.com=
/

Ren=C3=A9
