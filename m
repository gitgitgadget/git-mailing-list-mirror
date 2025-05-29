Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011031.outbound.protection.outlook.com [52.103.68.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D973B21423C
	for <git@vger.kernel.org>; Thu, 29 May 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748530631; cv=fail; b=tXUMFeI9OEj/giit9Z93YvRhweTF/cSj6l8BBPGsD5cfjTciFC7+FMvEJMjkxzE7AwWr4rbQUTAPLH3yPn9KMqz73jTjBMczWAxaATRatxS4ww8/4kvfXoXcoBmulC3SCQR020cg/NVSzPVAN3TIKbFPbCRhaWPU2RJAoVEeFq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748530631; c=relaxed/simple;
	bh=zbc37Tyx+iFMj2zvKxv6VvWM6BfVDVeMI8bs4/OYgk0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bsgjb90osbOw/zxcX3vqL0pfXIEWRm6AO7EG1cJJA3VoPOx3xrsiN7+vHkend07Bbk5JY1fBLio84T8MHzVIXmbcTzdnAqmFdFxFWMqb+0wvh0wq9yDLFXGV6GqPquV7nSU2EVwbG6dKkZA+Wo2hw9Y5zmL37Lu55Ht85RN7HIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=D0HpN0e5; arc=fail smtp.client-ip=52.103.68.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="D0HpN0e5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQYiu+PG0Bq6eeSpUwd3xmjrNp/vj6Nfia+v1Icr97mVoSt7SgNfa7HM9qiyX/FNFwM9ATcU5fTbMgF3Qr/AB7UcENWZSieGAuHTXi5+VSqIHkwJHeX/m+BD4eFK/Xl9qKokIOs9vdyQV+YCRz4rMHowyW4QzBjHFx+9N2J8FU0u5gxOqKuravmOcCVzwYd1qSWdnC/VYKc9AsNt07jj4FDmO25LirQXbU4pWc9JZRc+uO7G/QYlJbvqrEluyzWnvGcgI2F1csypQ2B9d1LAKCFpm/B4EPNmv4hpCihMoo/P/L9jlPw/WXFZEIJzgNJKa8gGi3qRO0ylKlVctVhhiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+btWgjn5vvOkluP0tB8SySiHOQn6/k9FXLBQQPGgNlk=;
 b=UAoJve5WPShcYdlaTMKZ1qeXyXYvW9XGXQZjqxMfUkDb6g9RFUpOq9WkLTJDbVrmLsQMvuz2kDOFzBfiEgSAuLo+V9aoFeSxcc2Q9w0GdeNzh1x9+BrmZ56KJj4o0ndY6um39u+PAXfOlkqZbvOa0rZ4VFXHg3Oh2j9qALoZ/DPaOE22qPHpXg7dbdv4m7rRXw75TawG+r0heVVkyYbtnwzdKCMhKsV0XAw1v5xhm7RwDTiqXBsNk8iXR9jXDWV9U2TON/PhUaj0kW2Pmj6VipvMjTz3hrYPgbgkDD7jQ0ZPFfBuPtID51X6KnlWahPj/AfAQ0I0DujXZA3PuzifSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+btWgjn5vvOkluP0tB8SySiHOQn6/k9FXLBQQPGgNlk=;
 b=D0HpN0e5uxM792ZHW1rrBoB6I378bqef2Er2YfW59HYoLhVbiofKJrAgtMgnZbDA8A8cKUwcjj+LpAwJdJTayotqICbNPW6ljsgMZmtupCiwE24Wm2FUTAbgNwjf/AaDMK3Ra+x1fq8YXoLUJG7xVG+geR5W2zo1jqvPP99tTB9f1QpUKRE790/LcX4NbvGnPqyELn5xn1XUutWRkPXC3tfhs1xuqBok+O887fStC6mcsL2Flxu/3ZJ35jGX9+aOBzQQB5EZNTESPAZO4T6v4QGJ3ynImnQnGrKZdiFcJkaadQ2s2CIkRRQlkhTP8ttvpRt346rcw+ottNXT+bMkOw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PPFD2CE7FA6D.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::54) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 14:57:02 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 14:57:02 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>, Zi Yao
	<ziyao@disroot.org>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v6 1/2] send-email: fix bug resulting in broken threads if a
 message is edited
Thread-Topic: [PATCH v6 1/2] send-email: fix bug resulting in broken threads
 if a message is edited
Thread-Index: AQHb0KnvOr0VWsapUU+8dV8cOOThfQ==
Date: Thu, 29 May 2025 14:57:02 +0000
Message-ID:
 <d965439f76e341b97c8356e6d3c021532d4bcbeb.1748529954.git.gargaditya08@live.com>
References: <cover.1748529954.git.gargaditya08@live.com>
In-Reply-To: <cover.1748529954.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PPFD2CE7FA6D:EE_
x-ms-office365-filtering-correlation-id: 66b6b975-c03a-45eb-9fbf-08dd9ec111ed
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgniszrdJyq0g6QdsHI5YtmH56UiN2UppJvuO9Px/aQ+UzXDDJ6HyN2gvWBcsXu11OiRfY1G5boeIvk1YkqyUzy0L5mHrrizCucLeCcxFE8NVOegaEnSgvTidajwChzwfVZ7t7YEDwR5MofKnvLSOUIq4zoG+W+E8D41cx6VRK24Wf0UwMMkah/eCvJfXgDKcjoWZ0UpHJ2/KMkpWvFT543g//9zVi1Im4oEd9FgAFv64eq5c/bH2E3yvE/UYH3GFPo6RuPqwSxnVZZTYriiIKthSmyNhFcC5t4qUBzmzcvAOBlZnf7zS29DFCak6xh8ElGWC5E/NDqYSToMjetJ4pP+nKpscpD/+ssIDxJXkx/E1uSfzoKxVNtdFhstphFKJ99U9ZEqt4/BN9u3ZRuO04vfULws5OpFABo+ylHt+zUTs40wKqYh5kUPbgxQ8e4SCdtZ0YySzfeSK7DxdvB3GmvCPPy3t36EW6ZmPzRdukNQz/9Ouanw6EhO2L8auTF/DPAVyiwFpzyFD6IGlutZEO5hBIwvEyGSqkwpvse+unAfE8DCeC3s8RTKleGh7xcw+NUxQiomL4775yh1nWZGZIfjIt4au4UQYNwJKYZfnqzAOdjPfc3koltJXjoItYAw8S3ASUV9S+SxRLek0m9+LJFUhnz0E0T3RuNgUQ//9leL65uw+B+365TjN/MzV6HI83W3HU4CzsvonpWZ3j3MOYHmYUZFSLizsYF3A8SmFlLzwY=
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|461199028|15080799009|19110799006|7092599006|8060799009|8062599006|41001999006|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?EADsLUT+kJxvOWoE6cEXT7E4Ej5r3YcbGuiMRIxwY355VN5Swf4YnPzQNQ?=
 =?iso-8859-1?Q?ymQ8GkkO1WTpaBGOG6cY+bovbDdLWKfuT2n2nlyq6Ft+O1ChzvlnjLE7ZS?=
 =?iso-8859-1?Q?nc26X17FSoU+gTWxmSi6tsnU9noCoAb966zhNegkEnKFwCHW7rDAzpMpbF?=
 =?iso-8859-1?Q?zLhra0lpyFkxlaqShvhXKBV6KunAS+vRQY/Nicl76bWq4pOBNzo5CDYnNB?=
 =?iso-8859-1?Q?wRUYPGwZRXzU94Vc+BsSkqWR/UTGOkU8n+lXpPqvpXuWb61IfNiw4CMjKr?=
 =?iso-8859-1?Q?DxO1qF0B9k0OrLW8em6ZC5YFcJfvD6rH2sFp1Mz1m3Xek2lkfFb32/l3h3?=
 =?iso-8859-1?Q?wOsyfWiJkSppGmmjkXZWqZoBO13DKqvFr4Fggv8qpBZbhRW9OV3byaneR5?=
 =?iso-8859-1?Q?/vbhpLBLIXifaQxMjVemgsDSZjscGgSU7FFn15zarU4ifApJu1pLntrptQ?=
 =?iso-8859-1?Q?VJdcLpWnz1PzdMZEF5cXdJCbKZExlS+blS4CwUHSxSeuJnAb3SrBlcpmSn?=
 =?iso-8859-1?Q?dfZNIzn9w5FwP9w5kvbZbMzcUYhC4/hPmGD1wQ0DFbD63/RJJMePrHTcHR?=
 =?iso-8859-1?Q?HepChQNpJss42UAhov57hCpsAey/So7rRX07eLwVkej2pxKKZivZn60Jyi?=
 =?iso-8859-1?Q?odLbujQRXcf4bGBYGsdMpc8XQSr4n794CqZZivwua8SJj1jy7NvPy1p95r?=
 =?iso-8859-1?Q?LRkhFS8wjs7xRmCSBsjByiqIKRDXbDiUgkqIMQovWHf/B+GxkxdTSn+ZqD?=
 =?iso-8859-1?Q?TseSg08PtWA3yKQoopk+yge2apnWiCplcnQNWcUQdxRQche1zz2iEqSeV2?=
 =?iso-8859-1?Q?u9fvI5SYdM9Yc3B0VuKVVpiuHXpxgdGKV0n5xPEzNyL2zeYKTM8A86k2+X?=
 =?iso-8859-1?Q?nEW3AI1V4wIf8hboKw0s14aOq6jXfK3HlHYGgMKGO0ip44MrHdJqfIGnSw?=
 =?iso-8859-1?Q?NB6ZYrcb6qYIBrjqWNiKRhKwlOVPhrOAhXuAlxOhKnoJv5JK0oxP9l3kFE?=
 =?iso-8859-1?Q?4Paeuo4AfFoWh1CUb0V3LFyZ8AGZ7s7sYCJPq32+lO4lA4NXAvGFreQUV+?=
 =?iso-8859-1?Q?g4QwvAAVKA4lX7GNYKMuPH9At5rOdRmcVriEDAE6dwFwgPcf6tn7CT6SxZ?=
 =?iso-8859-1?Q?tveew5XmtbU98EDKQWtuKiFVEpKHd9dQM6wyXAr+CY78K/BmsrvG/vuHQq?=
 =?iso-8859-1?Q?tTOMteFSLenN+7A3nTKHHl/jyOLVJIGRgwY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Uo7ArbeAFJj0nwCsuXd8TiB2aUjWN728iSmkOvBFZ4v83LxFoIb1h1sPR2?=
 =?iso-8859-1?Q?Zl02UTqhdzxO8dBibxo/NronGV0HNwc3WQhLSoecC+RxqcHnFVW2mXAm8X?=
 =?iso-8859-1?Q?MD8AyQ7ZK8fltTvLcNWn4x5LAT9ZRcRHI0kIqh9H9WNOEWUn5LuX2PhDI0?=
 =?iso-8859-1?Q?e4NIBmj5CsKZcDb7DXQyILhn1WUkFSjT+js74VsOLx4v9616H4RvAbdpyU?=
 =?iso-8859-1?Q?CFuZTKAvxmFEvhbFBK9TjI2jK9n86FDoTb0fkYTqknRZVbEizivE0MTRKJ?=
 =?iso-8859-1?Q?qajWmIDnRE73XCMD74W36aSVwufzIbMIze5rW9zifoP2/D5VjWjSysoUaX?=
 =?iso-8859-1?Q?F26ziaTjOB/2mABhHJq9pSlxh1aDD+081o4YXsflrRxcRM1e373qlbaNPV?=
 =?iso-8859-1?Q?plGgOJ4pbCvTvXmTLBoH5e5DXY5Sl7iwtB0XjCDFGivZamrUya6HZWYGFD?=
 =?iso-8859-1?Q?GmS5tjSSD+h6dV0yd/V0T1dHd2qkYq2ARp6M5HafaguoM8vgqxtFSwToHs?=
 =?iso-8859-1?Q?t6l1di2Ju9IeLz/10PsLIXm6qa+xnBpsh5uiah8s8aVEabxmgfXww/xOCS?=
 =?iso-8859-1?Q?De0espW6kkSdvUWIJT6L7nExnLgJzi7epd9Nc5GMyBcy6d3LhwhyxYp/eR?=
 =?iso-8859-1?Q?n6E4x35nO6+85vC5q0+YblHpmtLlnfpr3/b2JwwbZA3gQLwpJnnrkeWu99?=
 =?iso-8859-1?Q?hhweA8++w5sDGdpOLymT6EFBt9GHGTGz3FyyaG+/nqLgx6HkHUqM861ShM?=
 =?iso-8859-1?Q?3qbgYm2NFHfM/2wbjSx8BQiS4r0S5J3qOsB2ZikrOkplJple8hrRYlOPst?=
 =?iso-8859-1?Q?ccyUC3B6SNyvw+PzVVDJAct67dL32GwpqCC0WBookiu+GIJ4u566kp06k8?=
 =?iso-8859-1?Q?2BYh0CnW8lAWZRoSOqljCpl+1VcasV5ECAuFb8iqTaG75RK5jIDt95vPnl?=
 =?iso-8859-1?Q?7KN6Q4M1LJ70Yhg0iUavlugrhCTVQsva+fvVCzVmL6GPazesUcguY+2vHx?=
 =?iso-8859-1?Q?xq1d31cdto3TIbnn+IGQ+dWcTAf8JM1BLyHoyCAdS2Jmx2AjWq312LZf04?=
 =?iso-8859-1?Q?QfMIm2KrFjyQK03NFu75z1qC0dcco723zr4EuCS5aGhdWpFrVucLI8uAUY?=
 =?iso-8859-1?Q?QNpUa2R+7KhtoaLf7FbAVP2reU7sSz6bZ97fCfTmbR7MSRGsGOwbm2Amwi?=
 =?iso-8859-1?Q?MVQZUpGI4JIGZX0xO2EtGC17poGhE1NCAscKCqqiS1e3F3zUMATD/T0iT3?=
 =?iso-8859-1?Q?Kd3AcBkAW2qSWPuJuP+rZS1ynMglk6ZGQObXWft28=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b6b975-c03a-45eb-9fbf-08dd9ec111ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 14:57:02.2510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPFD2CE7FA6D

Whenever we send a thread of emails using send-email, a message number
is internally assigned to each email. This number is used to track the
order of the emails in the thread. Whenever a new message is processed
in a thread, the current script logic increments the message number by
one, which is intended.

But, if a message is edited and then resent, its message number again
gets incrmented. This is because the script uses the same logic to
process the edited message, which it uses to send the next message.

This minor bug is usually harmless, unless a special situations arises.
That situation is when the first message in a thread is edited and
resent, and an `--in-reply-to` argument is also passed to send-email.
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
and resends it, the `$message_num` variable gets incremented by 1, and
thus the condition `$message_num =3D=3D 1` becomes false. This means that
the `$in_reply_to` variable is not set to the first message's ID. As a
result the next message in the thread is not a reply to the first
message, but to the `--in-reply-to` argument, effectively breaking the
threading.

In case the user does not specify an `--in-reply-to` argument, the
`!defined $in_reply_to` condition is true, and thus the `$in_reply_to`
variable is set to the first message's ID, and the threading works
as expected, regardless of the message number.

To fix this bug, we need to ensure that the `$message_num` variable is
not incremented by 1 when a message is edited and resent. We do this by
decreasing the `$message_num` variable by 1 whenever the request to edit
a message is received. This way, the next message in the thread will
have the same message number as the edited message. Therefore the
threading will work as expected.

The same logic has also been applied in case the user drops a single
message from the thread by choosing the "[n]o" option during
confirmation. By doing this, the next message in the thread is assigned
the message number of the dropped message, and thus the threading
works as expected.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 55b7e00d29..ac1d5b7070 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1639,8 +1639,18 @@ sub send_message {
 		         default =3D> $ask_default);
 		die __("Send this email reply required") unless defined $_;
 		if (/^n/i) {
+			# If we are skipping a message, we should make sure that
+			# the next message is treated as the successor to the
+			# previously sent message, and not the skipped message.
+			$message_num--;
 			return 0;
 		} elsif (/^e/i) {
+			# Since the same message will be sent again, we need to
+			# decrement the message number to the previous message.
+			# Otherwise, the edited message will be treated as a
+			# different message sent after the original non-edited
+			# message.
+			$message_num--;
 			return -1;
 		} elsif (/^q/i) {
 			cleanup_compose_files();
--=20
2.49.0.635.g48fa2f4343

