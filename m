Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010000.outbound.protection.outlook.com [52.103.67.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2228E20E70A
	for <git@vger.kernel.org>; Mon, 26 May 2025 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748274712; cv=fail; b=omYsVM6TJiAXkM91h19iPQAUbSXRlG2QoQMSg8yAXgYkwuTC1omolr/LbEhD2LpbpM1uafyn7xjNcXCgN5BHbSLFxeFq5Xd7bAB/rZHtsuvm2Wc7LRbG7S63JqCujFM+Piy26FhgujwaEQBymVNce4Bkr0ObAf4jmWGfkgT3tB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748274712; c=relaxed/simple;
	bh=L2GRMXpUohLr2G/SMJdO3KmRbYpr28ZzKPM0R8DUkIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ffUIgS9P8FUQhpmQ2RCsuRp1AsVuXv5XYtevDDFnAm7kLnSafEOI0M4cT/2W12Neqqd9QbVLBd2dNKt3k9jYqki1k0ajrJXkSOAHNet3xBSklXBehb8zf8jvpYJd888UqysXPTCuyXT+cKkFTwE52zZhFlgcufmhhuHgg48PTds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=mshRO+ko; arc=fail smtp.client-ip=52.103.67.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="mshRO+ko"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiNVWBqVPfuCQADE86tpDW8vZCwMMd15AHoiKVu11v9dPRd6gBJqn6t/Bq0RXp0gVbqzmNoCnML+68sVD9UdJxxrZ/Eysr9sUc+mRhcb7s23NPmdWyu4MWhlLddCS5KvUamIbdDnoEFbb7Vxv1/U76nT5kbazVqwj9ufiQfkGHb3YEUAEjoNpb5nMsuL9zyTsfd34SLKYtH/DZHkgHo8zj48T25BHF4ks1xvuJ89iLOQ36ZNIxRNac+JwVUIU1ntazRJQRQVYfpEuD/nAi4AbpczCj2dO8uKwIgGJCNKG7HeR9ho1rPaNgzLgAG4RkZsFSbzAHMUcIt9n6oAvWfZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cL4ISnzNJsqimHcY8xcvr47N239snTDALE9DePjytbw=;
 b=FOETGqvHQjh9KcNu17wK3M6YYl8O1gQOw3yNYaZFJuK1/IaX26X35wiqcOytj7vnmpoGqLOjdB5e7ejJ/JQkKNJ2bH1pCJWMFdXP+d2MEFuF/nupuTslFRZGOTspSzhhW5c0n6TZvp4+4IVnOU4qD2bM7Y2D3Rrzt99LjzlliItAidXUrMsbQQ3BE/G71vtBX2rNsKvEBIfNkNu2WFXqRiN0bYkISJCiPj5iweN60K5p3+O41VXhuGkOsNwbDl8phz67N4Z9ieB+CzbQ1vJMWV9yfs3mz22JZrgEuZFU3U05UWBMux3Gx/6Vf1BqL+TYGey+0OZ51a5zT/WPNDGwyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cL4ISnzNJsqimHcY8xcvr47N239snTDALE9DePjytbw=;
 b=mshRO+kolJmeTJW6XAsFVgk6NCv02qeAGjfCOQkxgthNfQ66h8nlgyjxXtHK9C5+pI/G74RiTh/eFwZtb6h80BYDJz/38mSZ49Y6E+Bjj0EblxMSwDSpCFDuy8DAB+iOVMZUycjRh91JIF3IKDTLYj9BECDj7kFOp4lfJbXSyB7XnSsmM24qzO8ZoHJbrG7XeGZXHtUOFmm/CAGfy8FNGh9MXcVxQw8N+lFk3WTtdWCpT7eJPyEmMAyyDiqTw1+JOlh++hVsTotEomi+A7bDlNIIcx9Jfzair7NFhkBgZA/QoS/1CfTWvgxiN28H3Keq05fWQPbguUPBtZb1tzOXgg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB8258.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Mon, 26 May
 2025 15:51:43 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Mon, 26 May 2025
 15:51:43 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>, Jacob Keller
	<jacob.e.keller@intel.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v4 1/2] send-email: fix bug resulting in increased message
 number if a message is edited
Thread-Topic: [PATCH v4 1/2] send-email: fix bug resulting in increased
 message number if a message is edited
Thread-Index: AQHbzlYUKCjvjYZP5UCdkawa4F+maA==
Date: Mon, 26 May 2025 15:51:43 +0000
Message-ID:
 <63addf9d9b6491cba2148ba838f99119d50c0e68.1748274404.git.gargaditya08@live.com>
References: <cover.1748274404.git.gargaditya08@live.com>
In-Reply-To: <cover.1748274404.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB8258:EE_
x-ms-office365-filtering-correlation-id: 0200bf64-af65-4f33-fefd-08dd9c6d369a
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnUfhwctTiKfFssa+HDrdOQqhPASciKbNiXZcuiLodhqn+n+JsUYa6DXj2siArPUJDqG6Er/blpGMo/793TA4IR1Lhu62G9Uln1cx9wloXqR09s6qLuVRiCxuuPZzcTCDmrNPfAi+WPgWQmlbO/ZbKS1ZvRNstETUf0B5QPUN6qPBlu8TJhffvZ8muIaQJKHWGAz/jNE6t91d7XU3XJEmhseKfUuRj2GxFz8CfIX/4K2tBbj4RPIDo/hIek1HR1QhhmR9Q97MZLSPx4k8YVnm+4eFaaOnZEZch3nX+duYMWWC8mVnDGh2JRai797pNH+S8Lta85VcsmjurogU05zd4VxV1s/JxuhYdWScoZWGW41r3CtQoxtigrzlSlY8JurrrcjMyRD1XNRrJw5Yl03CdVaoOppcW3gWkwYAl01M1dY5kUZdpHvVqVkzCXYQs2QyxYf0YNjFMgh4MH/K+Ikr21OgaCGURYFEAjZsrwgwOTqw80+wvVfvc3piho5YR6v6VHi799Ma/8FH3Wm9fxz3n12RY5E0oia4PLNDXCZE1JQ7r0zOK32k8IPLMRgEy18yJ1bsK1yZy3FHzxp/kthfUu5BDr2moOwbGEY4SP+U6I01XP+f6BB8Avus1P7T10ehosjStifEPaPwiy/dMLPz9RfIhi96KJtjWY1UzSU2D9K/DYMJFUA31kH0oC75f+neYEZOfMna9RqTgFhGiPVyWlnvbwB7/qwyye68t+C9jmYk=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799009|38102599003|19110799006|7092599006|8060799009|41001999006|8062599006|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?sAltjTgrYzRUWO/U2kzIMh8dbjQU1bFxce1AlNPgeOcCM9HXkaXc63UGrd?=
 =?iso-8859-1?Q?hgQIxHCvOaTauMGYDyOScpNoRtlm/nxt9HyIF8aMgNmkd+kpjeU+4gUS31?=
 =?iso-8859-1?Q?rHGlDEP84wpEO/XfXGKY8T513SO3BJZngmslo8MdMxs3KEx7V4cqAg78eL?=
 =?iso-8859-1?Q?myy46qkfy3ePklNue7UieYMlqfAj2Uihj/BFn4jy3yEY0yzNgIeeR5oULB?=
 =?iso-8859-1?Q?PjDr5lC5LXyjV02PRk6rDgn3294e+u5BvUYzOdCiEcVs0LLZjReOGpGkCL?=
 =?iso-8859-1?Q?qrhmnJ11l3MvnbuuhCVchXesxwQ8osKPSg5osR+JGCdGZTFZa8miseJ56/?=
 =?iso-8859-1?Q?CzdHHdTiIoIfoNwx8IXK6T6SX4aBAnEtVOCbH5dlIiDhx8es2jUNZ67+OI?=
 =?iso-8859-1?Q?g3r4WPOwqV3PXNeqeg/gqsCOCAOFRanyN/OtTmvk8IbKQ3T6+jpFYaW76D?=
 =?iso-8859-1?Q?cJo/jtgYz9QnvzM2jU9ML6mKvjgmcKzlTVe0oH5q2YAn9NkocB/n4H52kb?=
 =?iso-8859-1?Q?5IViQqm/n/3X8ZYM77BxZCYrfBuHHAVBeAK9PC7nZjljln2dzGTSEV1Qnp?=
 =?iso-8859-1?Q?DUi4tPfm2Wgo+lNUtyglNTUuBJ4iGaJkIT9wbz1dhBZcBsESQq16yiQmNp?=
 =?iso-8859-1?Q?6J0X2DUCm+xVn1M9R3wA2jw1raQOxtMuPBFPpBgA7HPZ9+Tfd8prBBE7N/?=
 =?iso-8859-1?Q?ncQBZDzKekFTtppM0+9ft6Y68OhArFHkfzY9z3bes7cdt3Ei8R87yfsX1q?=
 =?iso-8859-1?Q?ywB9grlj1fa6Vj9GRt/aTELBCMr8JQs864ce/eWPnSKiUVycHHbBeib7y7?=
 =?iso-8859-1?Q?x2e4uPCgWN4E2Ky8WIOaiZpAXokf6PELZkvPI8G73MC00AsASYTac0oVD+?=
 =?iso-8859-1?Q?2dbQzfucH/IpLouQc46b7O6VSZFM7qtGizb4AdEcsnqPDrB//RV6rNR1FA?=
 =?iso-8859-1?Q?56UzQ7pfCdw5VTG0Cmkt8TzcHtx1xSXc7IMyDHpgXq+kkAp5OxZh8DYY46?=
 =?iso-8859-1?Q?8O5ihaue+j1wU9OolOhjHIY+eMVTEZyHq9YoVlLWZdbp9vot4fckWtPcG2?=
 =?iso-8859-1?Q?nYTEfwCm1J5/6WEmodpbfTeb+kS5uF7cQlXKZq6OLXjKbnpEFbLN4cCEnW?=
 =?iso-8859-1?Q?gXM8kgXAdBEp9OLKZHDZbIoYaB0bz0ilVGjFsK4mjggCE0sE5vwKk6lYOb?=
 =?iso-8859-1?Q?kr6jOfOCWKhYDiPtxlB9yQ3lKCqa7RXcvhY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?u/2qo9AAgcEBC1N/9f8h1D/IVSVm7VQnk9jn7sKLAxewxn1Feb7MqVEh6w?=
 =?iso-8859-1?Q?0ZId7z4iwQQyjtG/iiAotRXNpnTsMN+qrX+5D7IcaQuyI0PVdpjqksgiiD?=
 =?iso-8859-1?Q?CpUTsO+z0SMShj6/GX5wO/lp6qWeTUkhy4DJ8P/2ucOKtUbdG/zBOhuZro?=
 =?iso-8859-1?Q?IJYNw9ye80j0a3+CYsucosvrxeVen9ZGPfeHP3HTSlQOaTrMNaSPaIWBuG?=
 =?iso-8859-1?Q?shkCjG2oZzhawYi9OtPtveMxj1tmsibWK9CWzGgbtixKXrs3felzNompa3?=
 =?iso-8859-1?Q?0feJJM55VMubBnDwNeynZspF53MHdA8w4I+Ms7CWuL03pQm+4WCnN6iGxK?=
 =?iso-8859-1?Q?pkTxw+PQDcimt1zh7BRJImuUd5//667/vfz1nsbW7bLINed+FIXWtg+RuE?=
 =?iso-8859-1?Q?Ee/yXp4DTjY0XCAOTcZNZpOYHbL1gVrnQquNmYaK7glABcAU9u2jVeTZSW?=
 =?iso-8859-1?Q?/72n3XUrf7+VPJeIaiVTB8zEBYVwy5mhtuqdB5QbL6L+RYAo8C3o4FP6uK?=
 =?iso-8859-1?Q?8S3I28Ot7+a5xqsYLTMjJnaMNSGQCd93XXPXyXAfMmVwqPa16rbM1HwDwt?=
 =?iso-8859-1?Q?s8lhW0flHso75by2YqXk808P4mGRYJP89FXULoMzDkBADocJRoxjiojnks?=
 =?iso-8859-1?Q?L6YPO6g5MdRTYlOVWQBXmqk67BPzQAAusLx35gtnh5Lwcut7lvZfTp9gnB?=
 =?iso-8859-1?Q?tGZniy+WBEICN2NgC3rklRC3U/IUzLf49p1n15Ldu2feRdoA9tz33FIhsS?=
 =?iso-8859-1?Q?MyGCrYV4x7qehhHC0FJK3VWDfRkShtDKeb2tREqJcPhWJp4z0LQNwYNkhH?=
 =?iso-8859-1?Q?sWfbUcSq9Vew8L5ZtJbOjrZ0lexmc6+mUeQAmCt3p1D2WGf9O+PmLhaZ1m?=
 =?iso-8859-1?Q?Ea/3igrsFDp2saf8qOnRDIagcVOEni6aJ5GvXxdI8L4tK7TTV6MUJ7boiY?=
 =?iso-8859-1?Q?1z1woV/Pv3cuqsw0Ptzl9WhGvBehek20f7bCcItjRM1VyXznpenwMHdY/z?=
 =?iso-8859-1?Q?ZhQlmvMH7xgEdwi8jT2TpyZBz+kNsiUmM0mrQV8kee06fzIAGSkYl7t3UU?=
 =?iso-8859-1?Q?oRv854+30cybFw6vU+MWHZGeErcC1gkRr6qXYRVo8aAE3K7GXq/qE/sISU?=
 =?iso-8859-1?Q?LwNWMO+ZZHg1Mt8pzo48heN5f2XjkAwEhg7orfy3CkxYhgZ4FaPGSl66A2?=
 =?iso-8859-1?Q?1jhEqqjkT42knI3fUJ8449b2Z81wVxVmm17Kk5VkGtiIaIioNKHq1+wJiI?=
 =?iso-8859-1?Q?qwdwzKQo9/Qa8oe9eJbIZ5IQXbs4CrcGHtjHZXUaU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0200bf64-af65-4f33-fefd-08dd9c6d369a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2025 15:51:43.7641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8258

Whenever we send a thread of emails using send-email, a message number=0A=
is internally assigned to each email. This number is used to track the=0A=
order of the emails in the thread. Whenever a new message is processed=0A=
in a thread, the current script logic increases the message number by=0A=
one, which is intended.=0A=
=0A=
But, if a message is edited and then resent, its message number again=0A=
gets increased. This is because the script uses the same logic to=0A=
process the edited message, which is uses the send the next message.=0A=
=0A=
This minor bug is usually harmless unless some special situations arise.=0A=
One such situation is when the first message in a thread is edited=0A=
and resent, and an `--in-reply-to` argument is also passed to send-email.=
=0A=
In this case if the user has chosen shallow threading, the threading=0A=
does not work as expected, and all messaged become as replies to the=0A=
Message-ID specified in the `--in-reply-to` argument.=0A=
=0A=
The reason for this bug is hidden in the code for threading itself.=0A=
=0A=
if ($thread) {=0A=
	if ($message_was_sent &&=0A=
	  ($chain_reply_to || !defined $in_reply_to || length($in_reply_to) =3D=3D=
 0 ||=0A=
	  $message_num =3D=3D 1)) {=0A=
		$in_reply_to =3D $message_id;=0A=
		if (length $references > 0) {=0A=
			$references .=3D "\n $message_id";=0A=
		} else {=0A=
			$references =3D "$message_id";=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
Here $message_num is the current message number, and $in_reply_to is=0A=
the Message-ID of the message to which the current message is a reply.=0A=
In case `--in-reply-to` is specified, the `$in_reply_to` variable=0A=
is set to the value of the `--in-reply-to` argument.=0A=
=0A=
Whenever this whole set of conditions is true, the script sets the=0A=
`$in_reply_to` variable to the current message's ID. This is done to=0A=
ensure that the next message in the thread is a reply to this message.=0A=
=0A=
In case we specify an `--in-reply-to` argument, and have shallow=0A=
threading, the only condition that can make this true is=0A=
`$message_num =3D=3D 1`, which is true for the first message in a thread.=
=0A=
Thus the $in_reply_to variable gets set to the first message's ID.=0A=
For subsequent messages, the `$message_num` variable is always=0A=
greater than 1, and the whole set of conditions is false, and thus the=0A=
$in_reply_to variable remains as the first message's ID. This is what=0A=
we expect in shallow threading. But, in case the user edits the first=0A=
message and resends it, the `$message_num` variable gets increased by 1,=0A=
and thus the condition `$message_num =3D=3D 1` becomes false. This means=0A=
that the `$in_reply_to` variable is not set to the first message's ID,=0A=
and thus the next message in the thread is not a reply to the first=0A=
message, but to the `--in-reply-to` argument, effectively breaking=0A=
the threading.=0A=
=0A=
In case the user does not specify an `--in-reply-to` argument, the=0A=
!defined $in_reply_to condition is true, and thus the `$in_reply_to`=0A=
variable is set to the first message's ID, and the threading works=0A=
as expected, irrespective of what the message number is.=0A=
=0A=
Just like $message_num, $message_id_serial variable also increases by 1=0A=
whenever a new message is sent. This variable displays the message=0A=
number is the Message-ID of the email.=0A=
=0A=
So, in order to fix this bug, we need to ensure that the $message_num=0A=
variable is not increased by 1 when a message is edited and resent.=0A=
We do this by decreasing the $message_num and $message_id_serial=0A=
variable by 1 whenever the request to edit a message is received. This=0A=
way, the next message in the thread will have the same message number as=0A=
the edited message, and thus the threading will work as expected.=0A=
=0A=
The same logic has also been applied in case the user drops a single=0A=
message from the thread by choosing the "[n]o" option during=0A=
confirmation. By doing this, the next message in the thread is assigned=0A=
the message number of the dropped message, and thus the threading=0A=
works as expected.=0A=
=0A=
Signed-off-by: Aditya Garg <gargaditya08@live.com>=0A=
---=0A=
 git-send-email.perl | 12 ++++++++++++=0A=
 1 file changed, 12 insertions(+)=0A=
=0A=
diff --git a/git-send-email.perl b/git-send-email.perl=0A=
index 55b7e00d29..b09251c4fc 100755=0A=
--- a/git-send-email.perl=0A=
+++ b/git-send-email.perl=0A=
@@ -1639,8 +1639,20 @@ sub send_message {=0A=
 		         default =3D> $ask_default);=0A=
 		die __("Send this email reply required") unless defined $_;=0A=
 		if (/^n/i) {=0A=
+			# If we are skipping a message, we should make sure that=0A=
+			# the next message is treated as the successor to the=0A=
+			# previously sent message, and not the skipped message.=0A=
+			$message_num--;=0A=
+			$message_id_serial--;=0A=
 			return 0;=0A=
 		} elsif (/^e/i) {=0A=
+			# Since the same message will be sent again, we need to=0A=
+			# decrement the message number to the previous message.=0A=
+			# Otherwise, the edited message will be treated as a=0A=
+			# different message sent after the original non-edited=0A=
+			# message.=0A=
+			$message_num--;=0A=
+			$message_id_serial--;=0A=
 			return -1;=0A=
 		} elsif (/^q/i) {=0A=
 			cleanup_compose_files();=0A=
-- =0A=
2.43.0=0A=
=0A=
