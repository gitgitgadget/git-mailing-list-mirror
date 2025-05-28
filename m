Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010008.outbound.protection.outlook.com [52.103.68.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237D1F8691
	for <git@vger.kernel.org>; Wed, 28 May 2025 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748414382; cv=fail; b=ENhWZE38Bpb2lCWwZhIF6wFP/DGGErbFV6E0yCL6oaIzzFbeS2ahgeKmJoXVSy9HBUri+rBQrult9oL72HiDeN4MqSemDc3Jhssz6sBQBzJ1UC6jROKmUHeROyfnVn0miY1ZoiWKdjFJvHx9Si4mGaMU0DYSL5BubHNKbq4frYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748414382; c=relaxed/simple;
	bh=CxpNTNYAuppLTf6FZHaSQF7MjP2i/2d3ib6SeMWS8Jc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UDlFO7q08vWG8qBcW1kz7WpXAFIVFQC/n2/v5/Rye83xY7PR7g5oc0fNc3tUjpFU2IVuWr/PNk35HtnJBmx23l3Iw/5lWkyKlEo1ikzRxFKjqmelQIh4h1WYnPkx6mlyiPpoiHqrhtW5tIRVY87XUdK8WEAC1bSKcB1fGsAOhvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=MaVz9yEl; arc=fail smtp.client-ip=52.103.68.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="MaVz9yEl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1ovYkrQ/S/siSgg1OZyM93Q1959M+wYKjKnXDpBPVyAeGvvlim4jNO/VWiQWldgXekPf1UWQjtjJtkLHGY1apgJTSGbSs+AuHjGqWEreGwiGfmJPRF8YcdSPyF8zl5MZkGrW6ANEmjNZ5xVAqMxpeV/170v/P0R5TVwmY+RXhrlwCKuEs4nw5ZYAo2nUMZFTAbBB2htREilQ/Xcn9YKMZBRIebNioZdn4ySAaTbJAG1KRMFGqvjqiqzmTTE+pdiK1CHYAVar+TRhkrbfcQRDl3ife2pkOjDxQ7gkg47FSJTdDSFLxz5Gua/ELG4TEYA/FPOlksKS1DmpjynXen+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9bh+gfjeVPtsNUwj5pCPZY+DQ5Nnguif0NF3lcborE=;
 b=BN6+C3/le2RxtxXDy6dTJo5StRj78YliCt27fEjTEH4qp1/PcuAsCZvs8NdiAO76Phh69ADswU9WxIZrlfa/OOCpJS9LyvMYPgrAD3zSA0wkohX9VhgSSE+viHZ7grSAVWbi47QerjLmnFEdQsNcsFCChCqgSSM16jSlnt/I+Rsr1K2Nyfgbh5+W/XhZ359LG7dvfNwJBUhXIO9ZhLMtqddTieucg2nyKANyCciy7QLeXsZjn1Tor7uzwKdcbj4FjIXDrLA99fMdGs0QDUohLqkOAZaF1YAKdaD6Lc40I+mcAUGYL+ZHsd44+HtHnaX2Xew/bFstgXSE+w4zuzq06Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9bh+gfjeVPtsNUwj5pCPZY+DQ5Nnguif0NF3lcborE=;
 b=MaVz9yElvSh0DPbVdf9bwgxso7rZ7U1h9EayHab850O4Nm36c0PLpw2vcwaay5+69KbObceAGVofzdMeJvkq8jtRfQIduOHGz4/NuRbbRNGHofQSxAqcsa3wJwg0IHnue0E0ctq2Ax66EAVY2dby+X5s3XDWBR1BJ8bF5JKo82C5/Y9WLZZfPir/exXeZ7PEAvgywhjm04vbSjJEGlW9ZnIm649Tq4a2EMvJq7+yab02o2PUhaCwDWGqoNKelkSPnNWJXKhTs9KGJ4fR9ZbT76NTl0bmshGsBxJmmMqE2bBYk6GWEBKl3z4YDX9jgOKk/xlb3ybSuDR4BP2zQlTcqg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PPFD2CE7FA6D.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::54) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 06:39:31 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 06:39:31 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>, Jacob Keller
	<jacob.e.keller@intel.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 0/2] send-email: fix threads breaking in case user edits
 emails and improvements to outlook ID fix.
Thread-Topic: [PATCH v5 0/2] send-email: fix threads breaking in case user
 edits emails and improvements to outlook ID fix.
Thread-Index: AQHbz5tErxppfv4OF0KbzulgzjcqtQ==
Date: Wed, 28 May 2025 06:39:31 +0000
Message-ID: <cover.1748414082.git.gargaditya08@live.com>
References: <cover.1748274404.git.gargaditya08@live.com>
In-Reply-To: <cover.1748274404.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PPFD2CE7FA6D:EE_
x-ms-office365-filtering-correlation-id: 7db7cdcb-536d-4d38-a087-08dd9db266ce
x-ms-exchange-slblob-mailprops:
 5fu/r660v9PcXSQ/czQan+5fCOfJxmE94kE4fNhOiQHKOK1G/j474IcHX4xFXwj2R63MNkEpKqbOFhhwpvyiuQ9TxSnqvQ+uDHF4WMYdBmovuqktWVJlLdoNilgDkq0sfdidaNMogstcbHi0q5YiOI/ayyR8c97h2WgLcq/KRIjkoywy8OMqvV6UR3EBi0qi5H1x3GXwcigL9beShjdOvI5l0oDxcRdWcGNTWQn5YZKaHvS0qy29cgWScsyS11tMCtX1lbiTBXcooQt+xwUxW0FPxre2bzhZ5J4oAUgF1Y8kNBBYdFHfn9Yrk/koI8kPWjEQ0PKMSFnQchSpcGg3Hmxg73vnjmU1ik5G4fPm9kII6Vu2Ib7qfs2x+6cpilYSnhvzG9/Af81VHSHHRyQt/dgp4IvAthW1fiNBEmB7WxnJEpHDCrTArKSk03O0vGRyaRWZ4D0REuUDi7/JeG2Rx08Vk7okE//xBrwPj8HV+SD9MuQ+aZT2cT0gCtyWN2Fp0+59Oxz1QaSsEExY4P1i9gJ/sdLLNNgcgu5ECuN8v2Yg9IQltI0y2TwQdQmyJ/zd2Ty2jeJTlq4dkgJ8H2hNwFdwTHQkSeyVItWwq3iq58PcT94FI9cM8DY0QmZoRzKUzZ78bxSh7kQla9B9OLOStq6/kxOu0SKYbIUHB5vD6dsNZ8QVci81j3BRBx4JV6qFt5gYbjUSLBEI4XeME68Ky6e2s9iv+2TUrXIg0KnvtuA=
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|461199028|8062599006|15080799009|19110799006|7092599006|8060799009|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?EseOWnsn6fREkcwdHkVxGhtP/KOkLzPMgoNoeMqnKPx3kp6/U+B+jOTdFH?=
 =?iso-8859-1?Q?EHrv3X/EqFs6FljfqR+ZnJ5Wl3b1zR+XHc1J5zrLQvnf7uQFgMANozoxvH?=
 =?iso-8859-1?Q?VVcpsLnZT+mfmlHryGxtfx13Ri9k0CW8f7CMA+PbKKk1LORKVPFLYrkYe0?=
 =?iso-8859-1?Q?vFeFC0UgnxKWeGmRqam59CXNysZ3d2HG/J0/qX4hBOFkRdddpzjQh47KHO?=
 =?iso-8859-1?Q?Vjvm57X6poyOl39k7oLMIPX2nqT3NBIYx6KA2n6Eyv48h1A18wmiL3SACF?=
 =?iso-8859-1?Q?ZdDacOFyC+zIhEgvrmqlLZKtM1L2jfG0mFw2UdoOOGpCBEjSxMvLhk6lI3?=
 =?iso-8859-1?Q?BtLSadsFk1rbsOtpQckaimc8KPevY36X8FNK4HQakJrClIKLXit3dTzdwh?=
 =?iso-8859-1?Q?qAb3IiBZ0dOsbSMtNKBewDtBVnBKb4ZJYcgTrjS+j5AkNQyjFGabFSfm/D?=
 =?iso-8859-1?Q?Nh7g3LTSkGThXOUsBsTuSjycdlDceVu54Yy/8bcqUDpLW7lZcn/PrGPYti?=
 =?iso-8859-1?Q?dXlEdEX6wnan+QxkkMYpHfmFgy/v5wnjbyTc5uTKY9OeBqJu21cX9Y7NBv?=
 =?iso-8859-1?Q?7NvJOb9ZfMnQnufyFmDU7/TwHK8YGBcFrP/AFgWyRMy1pYnmmgklfl74gb?=
 =?iso-8859-1?Q?wUKIFVJrB8CCWeHaEwrzhSBXWO7C5j9VszNcVDW09OMEchpJO84s3lQOWm?=
 =?iso-8859-1?Q?zAfly2G6U/oqY2Mq2n4b15oZpE16H3e4SvRM+i8A077bJ2yl0cLOwTm71L?=
 =?iso-8859-1?Q?Rhvdnmvl8aRiV+Xm55Lc9vN3O+W9btf0GyaMvSi/bkctGzjI1VnFangxt8?=
 =?iso-8859-1?Q?0ZDJm9Bzl9dG0EBzxVXMT9iXeo1ggqss1U78pSHJ0+0dRStTnjUar5EI1E?=
 =?iso-8859-1?Q?YpTkbNXM1uS03kVnHiJ6c11dbJQL3zt04687+u1tp1j3BgqoiJnaaD/8MS?=
 =?iso-8859-1?Q?Sbj1lrp20uSkH7yPlDxkd3ALrMYTvgcPzFdk1Byg3RkIy0H9r/qJeK1bKS?=
 =?iso-8859-1?Q?ZdglwASdKd+nZf1Gvb2yKkMbNEFgpPokhTMxC6XfjkE6p7AQU4sK8PHU+5?=
 =?iso-8859-1?Q?ZrYj3/fVtFGqx4dJImxA5dkIv/i25xbjo8k936yjlUF9P4NeW/K79Dikpm?=
 =?iso-8859-1?Q?ZznKObrXtDps7CevffMbbTJTjyyf3YjmKUyG3Sqm8zWSmjz9ZCoQhWRED7?=
 =?iso-8859-1?Q?/DVErwGh/xhyHw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?IhBxgWpSBx3sY3nds31EyXrW9trXylPkEifu1cpsf+pu9+hDFaulVCM3UJ?=
 =?iso-8859-1?Q?ZfJBzkCo0F0/RcYa8Qsmsci9FT9rC6WizhYtUOTESPs1wjJI8UgiNwuyKJ?=
 =?iso-8859-1?Q?LZhH3MHSqP71dmC9Kb2A4pYSFCnRgTOMLmQC+RR4R5VC+PpBkCUd0u19Tr?=
 =?iso-8859-1?Q?hMUGpQG/IJpv5GA89Bz4pQzjwJ33X//62jueLlBrfP4E5piA15cCO8fkHq?=
 =?iso-8859-1?Q?alq+qMwicGiqZshFwBLf5nCV8IcE01m8dPqhOhc99TSPryXDpzr2KR/kal?=
 =?iso-8859-1?Q?e7Jiq2Obmy/IXOiULZxZGkr0zAy+aiPURV4fjZwnKw+8Ux3v5c4AfowyqW?=
 =?iso-8859-1?Q?djN0mGGnnBnU0H6XF4oY4xf2KpfAFpHEtcL/0Qse1wYxszdC2qi4Y48wn7?=
 =?iso-8859-1?Q?UXvTuihOdhHvdSsRsDSpcBPL/z78beIzOm4S9hMZsQopc89M4G3MhrOKaw?=
 =?iso-8859-1?Q?I6yt4/JW3iHm0eBnQ5e4mvKUvNQDGdBobhfFInx3vwBwVm48Ec3u2a4S/E?=
 =?iso-8859-1?Q?sslVy+xPsqxLDqOSLFUYOwj/mz7nu+Rc8FSBCI0Clja/ijF2qSSnp+ZQBp?=
 =?iso-8859-1?Q?0mzkHA9bW4t7mjsFL2yKdtfjHG7JYVumRQ3taFnnnmq2QA0mwKFk9WbGcB?=
 =?iso-8859-1?Q?fUX5lBj+ecLEm8x8lDC5CVsj1XBZ+SP3DH4zkE27J/STvqiEzs4zCyQ8ZR?=
 =?iso-8859-1?Q?dNonIPywNRsJjw3fYO3TD78XwkqcWsdfzRz/Bkl3kkf0An9OAFaQnEk6ig?=
 =?iso-8859-1?Q?ULxs3Ihakq/BoiM2HJK2rULSfEfYOOayI5W3fZW4yhPDjZKp/kOvVyOKSB?=
 =?iso-8859-1?Q?zAZkGxocLFuHnvVttBLMg+w++AAvZ3NsXcD+kAUMXXu0NianODC2gI5G5T?=
 =?iso-8859-1?Q?MGmjh4c3poIZG+FZj+K4NZY98IvcG0glNXcz4PrjWILcL9SHp8OZNhAOuP?=
 =?iso-8859-1?Q?Q3Tjlq+nBIwYrEzvmEidMywUd7WIeJ/J9dMvT3bdJQ48N1wU/5QI1rIBhP?=
 =?iso-8859-1?Q?ELKSBPkq3SC5s0B4UyWC2RQ5JlQy2yFuCdrrs+86XzhIoS2e8iadKRFB+H?=
 =?iso-8859-1?Q?f341IjdHRnpn0hsh9yEK5FN0wEDUK2E8oRw8xjErXd4CQ+MvVhY2CEGPQA?=
 =?iso-8859-1?Q?X+zxtgN5jMu2suqWcmEjwCWIFYqBAUX6+BhR8LrKN9GP6usQZJZMv6yUQs?=
 =?iso-8859-1?Q?Vq/WtopoDnBKU0W+W6SFs8vr6Cuz8GlJH3OilXAv92mWarVu/tsx4sF/nv?=
 =?iso-8859-1?Q?X2sIFCK8v4O1IUhKyzNqbRo0oNsnxH+MxrroimRpM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db7cdcb-536d-4d38-a087-08dd9db266ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 06:39:31.0896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPFD2CE7FA6D

Hi all,

This patch series fixes two minor issues with git-send-email.

The first patch fixes a bug that caused the message number to increase
when a user edits an email. As a result of this bug, threads would
break when a user edits an email.

The second patch improves the logging of the new message ID assigned by
Outlook when a user edits an email.

v2 - Change the bugfix logic used to fix the threading bug.
v3 - Add additional patch to improve the logging of the new
     message ID assigned by Outlook.
v4 - Completely rewrite the commit message of the first patch to
     explain the bug in detail and how it is fixed. Also, add
     example logs to explain the second patch.
v5 - Fix numerous spelling and grammatical errors in the commit
     message of the first patch.

Aditya Garg (2):
  send-email: fix bug resulting in increased message number if a message
    is edited
  send-email: show the new message id assigned by outlook in the logs

 git-send-email.perl | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

Range-diff:
1:  63addf9d9b ! 1:  5103ea4034 send-email: fix bug resulting in increased =
message number if a message is edited
    @@ Commit message
    =20
         But, if a message is edited and then resent, its message number ag=
ain
         gets increased. This is because the script uses the same logic to
    -    process the edited message, which is uses the send the next messag=
e.
    +    process the edited message, which it uses to send the next message=
.
    =20
    -    This minor bug is usually harmless unless some special situations =
arise.
    +    This minor bug is usually harmless, unless some special situations=
 arise.
         One such situation is when the first message in a thread is edited
         and resent, and an `--in-reply-to` argument is also passed to send=
-email.
    -    In this case if the user has chosen shallow threading, the threadi=
ng
    -    does not work as expected, and all messaged become as replies to t=
he
    +    In this case, if the user has chosen shallow threading, the thread=
ing
    +    does not work as expected, and all messages become replies to the
         Message-ID specified in the `--in-reply-to` argument.
    =20
         The reason for this bug is hidden in the code for threading itself=
.
    @@ Commit message
                 }
         }
    =20
    -    Here $message_num is the current message number, and $in_reply_to =
is
    +    Here `$message_num` is the current message number, and `$in_reply_=
to` is
         the Message-ID of the message to which the current message is a re=
ply.
         In case `--in-reply-to` is specified, the `$in_reply_to` variable
         is set to the value of the `--in-reply-to` argument.
    @@ Commit message
         In case we specify an `--in-reply-to` argument, and have shallow
         threading, the only condition that can make this true is
         `$message_num =3D=3D 1`, which is true for the first message in a =
thread.
    -    Thus the $in_reply_to variable gets set to the first message's ID.
    +    Thus, the `$in_reply_to` variable gets set to the first message's =
ID.
         For subsequent messages, the `$message_num` variable is always
    -    greater than 1, and the whole set of conditions is false, and thus=
 the
    -    $in_reply_to variable remains as the first message's ID. This is w=
hat
    -    we expect in shallow threading. But, in case the user edits the fi=
rst
    -    message and resends it, the `$message_num` variable gets increased=
 by 1,
    -    and thus the condition `$message_num =3D=3D 1` becomes false. This=
 means
    -    that the `$in_reply_to` variable is not set to the first message's=
 ID,
    -    and thus the next message in the thread is not a reply to the firs=
t
    -    message, but to the `--in-reply-to` argument, effectively breaking
    -    the threading.
    +    greater than 1, and the whole set of conditions is false. Therefor=
e, the
    +    `$in_reply_to` variable remains as the first message's ID. This is=
 what
    +    we expect in shallow threading. But if the user edits the first me=
ssage
    +    and resends it, the `$message_num` variable gets increased by 1, a=
nd
    +    thus the condition `$message_num =3D=3D 1` becomes false. This mea=
ns that
    +    the `$in_reply_to` variable is not set to the first message's ID. =
As a
    +    result the next message in the thread is not a reply to the first
    +    message, but to the `--in-reply-to` argument, effectively breaking=
 the
    +    threading.
    =20
         In case the user does not specify an `--in-reply-to` argument, the
    -    !defined $in_reply_to condition is true, and thus the `$in_reply_t=
o`
    +    `!defined $in_reply_to` condition is true, and thus the `$in_reply=
_to`
         variable is set to the first message's ID, and the threading works
    -    as expected, irrespective of what the message number is.
    +    as expected, regardless of the message number.
    =20
    -    Just like $message_num, $message_id_serial variable also increases=
 by 1
    -    whenever a new message is sent. This variable displays the message
    -    number is the Message-ID of the email.
    +    Just like the `$message_num` variable, the `$message_id_serial` va=
riable
    +    also increases by 1 whenever a new message is sent. This variable
    +    displays the message number in the Message-ID of the email.
    =20
    -    So, in order to fix this bug, we need to ensure that the $message_=
num
    -    variable is not increased by 1 when a message is edited and resent=
.
    -    We do this by decreasing the $message_num and $message_id_serial
    -    variable by 1 whenever the request to edit a message is received. =
This
    -    way, the next message in the thread will have the same message num=
ber as
    -    the edited message, and thus the threading will work as expected.
    +    To fix this bug, we need to ensure that the `$message_num` variabl=
e is
    +    not increased by 1 when a message is edited and resent. We do this=
 by
    +    decreasing both the `$message_num` and `$message_id_serial` variab=
les
    +    by 1 whenever the request to edit a message is received. This way,=
 the
    +    next message in the thread will have the same message number as th=
e
    +    edited message. Therefore the threading will work as expected.
    =20
         The same logic has also been applied in case the user drops a sing=
le
         message from the thread by choosing the "[n]o" option during
2:  72b3cd1bfb =3D 2:  6f2668de07 send-email: show the new message id assig=
ned by outlook in the logs
--=20
2.43.0

