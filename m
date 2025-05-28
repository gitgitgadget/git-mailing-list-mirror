Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010008.outbound.protection.outlook.com [52.103.68.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6726F4A04
	for <git@vger.kernel.org>; Wed, 28 May 2025 06:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748414380; cv=fail; b=dvJM6FAWrqJX+cyzZYr8Wz2H+huzRg0JSjDlJiC4Ht/RWIKL1yC81JP4xs38T4poCudnJbTd1M5NBkC/Etpw3Qamj/KWof22g0Dl5qxwlhHxaCA+NeT1zlbsGumCmotGTbJPnAnUYSJKQFfLiuzprTwjFwgdVEN4IK1P1zOIaNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748414380; c=relaxed/simple;
	bh=CzFljyFDhV5LEx4JOM1+1evG7tqc2l6Gu/7ef9B+KY0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DwvzaJjY+lk0JLXDAmDRPeyMGKlUE+kPAn4jLoOk3T32djDhQZjgDEsNwy+ILzVZYh/1y0lueOqRWoYJVSgeH/BHGGWrFRyc0sP50QS/NPhqzDBh23e5BTXWlOvpcP9s2Boax8eu6HYDZjqLER4LSpLghurs6TBtVVHxypqE200=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=tXdLC/Ny; arc=fail smtp.client-ip=52.103.68.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="tXdLC/Ny"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xX5QPYrc1mdNARNChbM8Bjukscwp+6eT4Ke/VvuFNRifu6k47vpc6N+crotz46CMHL2mh20gsMIkUNfj3OzsHvFA2doqVWlnREkWQ7z1dPdI8iRNsT9zTMk91pxSWB+468BxA7HbQkjMxPCQFRSm27xdhC5m62/3SWwLTCa+pWYFZqh4t7D9lr8Si+H9yJIDT1fvAFXsT6c2GURxG9deCLKqx1W3FWXJRnW7imnuU3JIMeVzeP/MIWhqbPVU8HDEgSETGWXtq4N+660qy6y4mRQasUkmU8nbFlTDxkcL5edp73kU3Jn4CYpuo9df4iTWGdAwO68FkdJOv57QVcg0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMc7jWi65qMNVrqRWmGgP17l9Ed4w6vHfcOenpf9uQk=;
 b=ISw+Zb7m0F4FynFO3km+YTF+Gq1NMFK0oGDkyo800CsTGbWxDltVdgm2hY3fEVVs3SWPH22oRyEbp0NBlVffDvB9tk0tFHrODABXwhr2s1vubca8oSg0EdZwM4fBBS7Ogmpak65o84pbKq0qmxX8TqB6GyJrqmrqeL+ERLaSxtgSprgRgTmZCAZ3f4m4/ueTjBERUccbiWXD5HX81jTMhQKpg1pUKoPObt+7f5cZv6F5yrIb4um1/JeDSu0ZBaaZ37DYgnIzqX0K6zTg8J13e/5ZIwYx61uKKB8Qd7OAkRURC2ZCN6PVowPuj7wsf4IOyx8N96y5VoYsZ8r2+SYeQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMc7jWi65qMNVrqRWmGgP17l9Ed4w6vHfcOenpf9uQk=;
 b=tXdLC/Ny1bEO47uEvIeKF5blQKKv94hcqK078K9daqxCWi/BFI48CKvCbwASRhuVF91qR2/x7r6bYAmJSNeRWTPAmkt9TLaIJbsMEcWmAtymN5JluU1W3NvQCXMBCJChIPkyvnxKfIFAbqy87McTS/hgotWysdLRrYd0tRlniiiJWNn9YkLsK1VLuUNdDEwENVsobQjSw6ESvc6BMY8r4gKdHicEPPNCPk6zX/0Ka4g3K2W8/SqAugrSvZmYqmh4Q+yd+o9fSh/Lv8eAk5WKOGhUIFjWJ01Ca/1I8i6G/lJ9iXfmhS6J/24CfMk8r362fcqt+PdHT2fJ4SJMV4Usbg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PPFD2CE7FA6D.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::54) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 06:39:33 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 06:39:32 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>, Jacob Keller
	<jacob.e.keller@intel.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 1/2] send-email: fix bug resulting in increased message
 number if a message is edited
Thread-Topic: [PATCH v5 1/2] send-email: fix bug resulting in increased
 message number if a message is edited
Thread-Index: AQHbz5tFlm2GWun7JE6Mjo1GHoff5w==
Date: Wed, 28 May 2025 06:39:32 +0000
Message-ID:
 <5103ea4034cd4a8438865a2d3da19a92dda54013.1748414082.git.gargaditya08@live.com>
References: <cover.1748414082.git.gargaditya08@live.com>
In-Reply-To: <cover.1748414082.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PPFD2CE7FA6D:EE_
x-ms-office365-filtering-correlation-id: 945d99d8-0a01-4def-cb3c-08dd9db267e3
x-ms-exchange-slblob-mailprops:
 02NmSoc12DcHu/Dr1OK6cqcYKvfIm6M5GEVG6AoN3A1z0KV+1Ls+mI7ZsEiDvjijdx+LNO55s9qtc7JsFC4kyhn+fM04CEh2n2T2utBWfaD4mqBbvcXa4tBJ3MdFiMD6bpVYjECMddQW6CtDyiblJpabSpPmcOL4nu8MvpLYAR/2+FZ9q9yA+fLu5ZC3jNzhFfgxoyZ201x+tw3kt3I1gcnStbvIXkO9EAbqnnC4s6RBdlR+nYSMnc4odgcEIjYdcgFr4XI63+PdmgkNuceqyE1HVtPATN2LgAqaSwL/vUPx+NaIzlJPYd8LR9+MwqSlnmOcHHdAhsPeEeEDbFT9OE51i5CNCiQEdpwlNaXqbiEmtrsSoBdsq+H09cL2QAw+F6Y4OwKlONgV2Go2lBLw3YkZhLd1gMlOSTH2oOOCLyglof/ZdAYfDfeC9RZ+Fm+yWtnfxgQWXODNiUIMPHMonclRsyJz2xWM3MVfgAIunE7lhfy8g3BuV/zGjeEklojqoz1KQINbvx9x17Uz8t2rZryhE4HDG3HTomN2IsnnMq3LKdz0Fsb40GQELOimzG1YU02Y3gvvAVvH5SgO0SWH2Tbam905+i5V9v3anUtBLaCIptFBYvWnMVqkZl+egTZi6MvX+3++VD2b1DSjWeP96vju2OtTumyEPauE7sDEgkFMExOWvlWm7FdIt8caie8G2/57rrDkzkWpjXSfy+JrmzRgFmxpmvwqellDqJJfNw0jssDFZkMTEfcAvs/c5ib8
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|461199028|8062599006|15080799009|19110799006|7092599006|8060799009|41001999006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?tBnoImlmyXtCDYPjUITcXuR0QRIrFKOk7nTagEGatAuBJTVvnfW6kItAmV?=
 =?iso-8859-1?Q?piM1wtVdqV9Tq18onZ+bpd8HvQCgnKLt6t4CeQCCA0WVz16SjuMNgTqIKA?=
 =?iso-8859-1?Q?Ji/swNVWtmCJ7DRK8XVfrj1O9M0CXGYcJ5qMzoT1b9m0jfQMT0XuB+M4Pa?=
 =?iso-8859-1?Q?jhErY6MheHcINyHYpFt/KNSEgqGc3KFz6qIEI5nr9zKP5TP31dizhrEYgp?=
 =?iso-8859-1?Q?mEhh8prlVMF3imQMQubeJesqUstk8zaY4ZqrQY8pNQb1853Eh5hvE7Ww17?=
 =?iso-8859-1?Q?CJ15gFoigLOOMK1M/NM+l4jiNibSQeA7E/EiusEYw4Z9YidUqIsre6J/QC?=
 =?iso-8859-1?Q?QulFftJ5oSRb2GxZiHt3FMjDlCv07mBMHzzrx2xUmDW9dHXdXVp5NDhzaR?=
 =?iso-8859-1?Q?pEFZXVBUvG46pFzxx32Mbe60hNGh5tpWSdlklM+yD9t1gBY4HGoP51xUND?=
 =?iso-8859-1?Q?mk4nBdUNBBmqSTEMlwHMXPyRaRlM8GRkfZo9JzNIcopMPDuoE9dO9uAP05?=
 =?iso-8859-1?Q?1nITAczO5QqAgKb2vDjbApM96zTGtXnsd/ZgLsUBg4EcLrYqRwCFI6jb1k?=
 =?iso-8859-1?Q?I27BeRyPUl2ArNLJuNiT0V3D0yI3v1r2cjr0cCrBhWD+2Z5MesTpq7gVKa?=
 =?iso-8859-1?Q?0R/JYSisMTvAduh+HijHKcHAykHWjSeT0+gHBzlo6KbBNGnYct70jnrGRX?=
 =?iso-8859-1?Q?tUe7jNCCdI791H9DiGs6hj7uTWaqpyiEWZjaQLA00KaLfbH9okfmzM7aAy?=
 =?iso-8859-1?Q?6CXiRAA10QDZbDvMuZwc0ZOrF4AnSsx9Zf9yq05K8GmKQ/s6g03vDc90gI?=
 =?iso-8859-1?Q?tDiVvSg15uA3eNNcwm3nmWIj3IUXymtXQ8ec+Fh4WeK9BP2MHhOlSu9FbF?=
 =?iso-8859-1?Q?ThBTUCupDfuZ2pPRiHcPuey2IW9nXgFkGbX8GPjt3FEgf5L4StjYemkWRW?=
 =?iso-8859-1?Q?+6yPKmflJDWarVsn3mjmUEFeKBF1foCCHdurUg0YUcFO1dgvqWgIVSCNDN?=
 =?iso-8859-1?Q?68XHepwvJmwWoi1VcNWKOXwRogKs1a9/w4B5CRljow8tkahrbv/d4s0cuA?=
 =?iso-8859-1?Q?2Bajr8PiFSygcWeYt6hlFHwcEWTzJDaRmoXxLzpkkZS+YZs4CTcyxafyr4?=
 =?iso-8859-1?Q?rN164dOmY4/sS7jDoiaZhosDXPqQEWCWJN9odwGVRMzBo+1ogmtLwadJhW?=
 =?iso-8859-1?Q?TzitiWxzyKP/7Sitl3Gd3/XLs4UfunH+CGM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/OSDDfM6zXbumTDKRbFlkMdYFakSd3apA8EwvbcYTYVgKmiwiVTiJX8uPh?=
 =?iso-8859-1?Q?OFqIcEwc9njjpMS+rtsTGSGJtytgAWBpOZMRB4UrqTmek/g9XdH13GUsJq?=
 =?iso-8859-1?Q?HO9d8flZTKax9LbGg7C51jF1aHANLG+lQ+G2pJOgASE2xRe4gqHTg86zjl?=
 =?iso-8859-1?Q?1czrSrWe4rBbeJIo3OEc2vU7JQroWxWyDHi3oIWUwD3EsxbOdzgV/KZ442?=
 =?iso-8859-1?Q?5bvy/soQzBN3TesDxpw++kON88WTLMKdLucGqandGQPrIB8StwUAszU5NE?=
 =?iso-8859-1?Q?rFb7Nlrg5AbSPPVXyhTV7yLv4Nvz6gfKFTGCMr13EXOiR4peRWl97ZAFQ5?=
 =?iso-8859-1?Q?V7BkBONM4mUtbCBLm9XNu25NDOhb6Sb7ciUbHAt+MwbBiB02V8iMCfIP6L?=
 =?iso-8859-1?Q?wO9yBqYZAwfFF6TtnaoomsCodsCHJmo+SikkZf0SMmJkigKSU+sUJ+cuUE?=
 =?iso-8859-1?Q?NCBcES1Pza/otPzJT8vFZxzeEkoJJX88dFNieZcyePfJ2Wc4vNC7GoQMou?=
 =?iso-8859-1?Q?TOAiMGLVaw+DP3kjufijCtOeVDYrz3sL07i8bIQ8dtcO50MKlPv1XI/w+8?=
 =?iso-8859-1?Q?VWqlLgp2GT6iJJ/KEZk0WIO5+NeBkHf8cUkHjhOZtdmlisvrxz1y+v2ayl?=
 =?iso-8859-1?Q?81Vi8DO7mlqELj8aO61d72dTajJeHJ+OI8C+IXscWTyzVhsCgCyRESLZwc?=
 =?iso-8859-1?Q?QBND04xMgekm+CxNSzrDMPqeNGqjkKIgdxpt2TDlDcOpm2gxZuGwNjHjVr?=
 =?iso-8859-1?Q?jSg1A0Bp0rd/lZw+ZXxFx5/gCG9DcLSapkVUHq+RfoBbBztKjg36RzEizq?=
 =?iso-8859-1?Q?BCcjQn+0XJbBKMYFx4b/AF2RM5ft9ZKz2pdlMYHb0nEFgiDL8rHxb1sv38?=
 =?iso-8859-1?Q?qxdGqWw4exrkkF6z9xfT2gNmov9yXX3N5VhcVdU/1xAB+nlc3FnvjaCOZN?=
 =?iso-8859-1?Q?SQbIWEABZ7jqezegG5TQSxpeo1qyFCBUioTL18WJHMwdxrEKYBi8T1flrs?=
 =?iso-8859-1?Q?qH8GyuWRKAWX6SQ5V8d1SPCTawqMNhc/Zam0HFdCr7/BTJByJVaASfR5gL?=
 =?iso-8859-1?Q?KWmysAtGORG9XDQJTmrt6K7D8ufY/lrXS57JcwlbMcdJ22p+zGg4Xz9uy3?=
 =?iso-8859-1?Q?NvFrhwICRVEXeJnuQDJL52PuubpbOni1S93dhjYd1miVh3FALxwM33nKgp?=
 =?iso-8859-1?Q?Z1bSYxlVSqjob2rg24q/0EQtJFFRQA/BeAd0/8FNIx+K/JHKPfzfgaC8P8?=
 =?iso-8859-1?Q?3P6mgQqxfV7rs1uYQMJU4F8jieKdsvjt/p5HMtvJc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 945d99d8-0a01-4def-cb3c-08dd9db267e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 06:39:32.8878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPFD2CE7FA6D

Whenever we send a thread of emails using send-email, a message number
is internally assigned to each email. This number is used to track the
order of the emails in the thread. Whenever a new message is processed
in a thread, the current script logic increases the message number by
one, which is intended.

But, if a message is edited and then resent, its message number again
gets increased. This is because the script uses the same logic to
process the edited message, which it uses to send the next message.

This minor bug is usually harmless, unless some special situations arise.
One such situation is when the first message in a thread is edited
and resent, and an `--in-reply-to` argument is also passed to send-email.
In this case, if the user has chosen shallow threading, the threading
does not work as expected, and all messages become replies to the
Message-ID specified in the `--in-reply-to` argument.

The reason for this bug is hidden in the code for threading itself.

if ($thread) {
	if ($message_was_sent &&
	  ($chain_reply_to || !defined $in_reply_to || length($in_reply_to) =3D=3D=
 0 ||
	  $message_num =3D=3D 1)) {
		$in_reply_to =3D $message_id;
		if (length $references > 0) {
			$references .=3D "\n $message_id";
		} else {
			$references =3D "$message_id";
		}
	}
}

Here `$message_num` is the current message number, and `$in_reply_to` is
the Message-ID of the message to which the current message is a reply.
In case `--in-reply-to` is specified, the `$in_reply_to` variable
is set to the value of the `--in-reply-to` argument.

Whenever this whole set of conditions is true, the script sets the
`$in_reply_to` variable to the current message's ID. This is done to
ensure that the next message in the thread is a reply to this message.

In case we specify an `--in-reply-to` argument, and have shallow
threading, the only condition that can make this true is
`$message_num =3D=3D 1`, which is true for the first message in a thread.
Thus, the `$in_reply_to` variable gets set to the first message's ID.
For subsequent messages, the `$message_num` variable is always
greater than 1, and the whole set of conditions is false. Therefore, the
`$in_reply_to` variable remains as the first message's ID. This is what
we expect in shallow threading. But if the user edits the first message
and resends it, the `$message_num` variable gets increased by 1, and
thus the condition `$message_num =3D=3D 1` becomes false. This means that
the `$in_reply_to` variable is not set to the first message's ID. As a
result the next message in the thread is not a reply to the first
message, but to the `--in-reply-to` argument, effectively breaking the
threading.

In case the user does not specify an `--in-reply-to` argument, the
`!defined $in_reply_to` condition is true, and thus the `$in_reply_to`
variable is set to the first message's ID, and the threading works
as expected, regardless of the message number.

Just like the `$message_num` variable, the `$message_id_serial` variable
also increases by 1 whenever a new message is sent. This variable
displays the message number in the Message-ID of the email.

To fix this bug, we need to ensure that the `$message_num` variable is
not increased by 1 when a message is edited and resent. We do this by
decreasing both the `$message_num` and `$message_id_serial` variables
by 1 whenever the request to edit a message is received. This way, the
next message in the thread will have the same message number as the
edited message. Therefore the threading will work as expected.

The same logic has also been applied in case the user drops a single
message from the thread by choosing the "[n]o" option during
confirmation. By doing this, the next message in the thread is assigned
the message number of the dropped message, and thus the threading
works as expected.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 55b7e00d29..b09251c4fc 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1639,8 +1639,20 @@ sub send_message {
 		         default =3D> $ask_default);
 		die __("Send this email reply required") unless defined $_;
 		if (/^n/i) {
+			# If we are skipping a message, we should make sure that
+			# the next message is treated as the successor to the
+			# previously sent message, and not the skipped message.
+			$message_num--;
+			$message_id_serial--;
 			return 0;
 		} elsif (/^e/i) {
+			# Since the same message will be sent again, we need to
+			# decrement the message number to the previous message.
+			# Otherwise, the edited message will be treated as a
+			# different message sent after the original non-edited
+			# message.
+			$message_num--;
+			$message_id_serial--;
 			return -1;
 		} elsif (/^q/i) {
 			cleanup_compose_files();
--=20
2.43.0

