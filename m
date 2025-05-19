Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C471A274673
	for <git@vger.kernel.org>; Mon, 19 May 2025 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747659133; cv=fail; b=hwMYaYWyVB6yzcpAAtrY5HYadsTIpE23tWwIsgDn5KUYdzhRQrubr+lJI5GtLCMc8Ozg8P6/UBsf8UCtpI0EvxxRbXUYzgwI5/yPUh2+U4Do++XbQqt0C+weBR0Cdyl3rtp5ZubJCLnmC+MWsnJOIktX1trDTzNd8/xWYbgxR48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747659133; c=relaxed/simple;
	bh=ZkoLRO8jJptvMbLEFRQYcttaQPmuSrbsOOK+K4+Mvsw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XXQEeM8PNJ1NZ9ysds8gH/uOmq+Ir3/9+1aa48t6j0183T6xIlunFRCyRP5ZWCGKEdLG+Q0mS2YglNUWckI6YNGkrsTNUEaJZDdvZzs54Bw3ZKy5UYUzSWu55YI15NOks7fTNoINNQ07OmwJwNpfhWIrk07mCUbE6sD73cHzYJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ACB8P7Cz; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ACB8P7Cz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTPXiHYPb0UoPAemKOipTVAJFQG1ywMsKEycdzDpDmcTLOAyg8eVYq6p9DkcnLDu76pk553U8vZT0c9DD4drUnwQT4fpGCVIAD1OpUJTOSMAdQc5phBdFpRQOXZtnkgoOrUGeBF4o1J24JnP6jjNGl+a202dHJFZ8tKIwKTiDtt6SG9qkSnTcn3yjsL8lLht13opT9mtPBE45FJ6lQOTQh8V/sE0a7fFeNr5S7LY0fURTfbtwfDU37f66VHltuPxqr/Itli3aDtP9txySEa3S9V8MAobOm9U3dq4p+JeSXJ9Nayh4DJ2tdLjGZQh7pQkd4y0cGAdDKA/5fkrAQUSbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7xiDru5EEi8sSe1+Ym0yK6qoMsiL3KCFGtDWOKMSTM=;
 b=KduG8wzyhNAGJt1dm8U4jF3QcurBNzTDGctG3zgbTAeGvax4qnRaItPm9z5vjQfbRbp3RMY10+sUYSS604VNeMaMv3r6FO6c+AC53Syw+JsIzaTqHyUqYxdBQlFTI4gLbxsyX5Uc8ho2xD9vrsfmG0ezHjHpZo/nS4xo4K8EpD1cv3hei6oxIutLzqPlN5BotDbGp3Jvkl87lehmagbXHMa6x1O28VUOY+4KSkfwNy2VRzNbOEZCqM+cmPhmo5vWAGqw+4HZpHx3QIoFvJVv98UwVpv9Jf0aW4MO5jP30x0TduJf2LPKLUqFYhJ5J7FrBORNKxfcX6DDOVj8DntchA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7xiDru5EEi8sSe1+Ym0yK6qoMsiL3KCFGtDWOKMSTM=;
 b=ACB8P7CzVtgs273n1UlIfgNMY1V+iYjIW50E0i4Bw0xpq+PPVhcxplG3RDQu7TWHlFVCeQlCUvUWYlyiophmmBM1dMIY69Tbm3of1HCHYscIY4q02rj093FQcf1I4yybPlGAbR5CF8zcTR1n/kSeFdBc1Hl7asqHBsM+9Ctt0tq5LQGQpMSreIsO/ocPH/L4ZeVrl/22Qv6wRRU7EKN8a9RKwuBQVzMqriI8rHETbiL3j5Gqu1pO3M3o98e5xlrPiQ/Mh/D4kYLG2w1kDc7PR3N5ySwwneJT/ejeoFMmDgr69ur72rO6Z+9EzeO/A92OFfs4Z6il/YEt+LHIxH4NXQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6332.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 12:52:05 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 12:52:05 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Julian Swagemakers <julian@swagemakers.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v4 1/3] docs: add credential helper for yahoo and link
 Google's sendgmail tool
Thread-Topic: [PATCH v4 1/3] docs: add credential helper for yahoo and link
 Google's sendgmail tool
Thread-Index: AQHbyLzTWh2kcXUUrkaoNBfCLCudDA==
Date: Mon, 19 May 2025 12:52:05 +0000
Message-ID: <5DDE8CCF-790B-4E1F-A601-473436483D52@live.com>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <A84F634C-3423-48E2-B648-068A75423037@live.com>
In-Reply-To: <A84F634C-3423-48E2-B648-068A75423037@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB6332:EE_
x-ms-office365-filtering-correlation-id: 9d6b460c-b6da-47b8-7f5a-08dd96d3f58f
x-ms-exchange-slblob-mailprops:
 30ekHghIwFpWJZJ/S7H67WW7FVejyf+CS7VPE5yrpzVevCpFbxguxJMRpxq5yEdU4lxcb5kHYflQUQT6ftUSXQmue28va5qVd72vx3eKwxKIsz54MgRU9t13izt41+bPXEB1JBRKrteEemG+kwtH8Qur8W+oTQ5b42ZfgJezaTzS4CiNyLtCDZ9q3IY1mIu3ZZs/A1Q0sx47PUDgEOuhxs1fLXzPMWuGIRMKGd5F4nesnMnz1oZ3IcpOY0U7Ka+RvRiMcl87izTKn6CVOFh6IZxzXvubSh4qidUBNRlbjYoXhaEn4PIpHtrEtt6aNEAb4pE3GK8rOxMiMXu8sqTw/bkMc3reDBQ2NbF/8EaQF8Z7Aw+nBZPMwlxt1pm1IKMQmGhGmuBb/wqRUJAB/Vu16uRZelKWd5aAu+I8n9gxKyyjE32JLaij0/LvNYc15xy34PPs+UWug0lD1/IyF9x1G+CmM5+dEppK7yCLk5uFAq/dVrSDQzO4DPG2RJO/QpGTzSZdLfJkVwCzia85ffLH5h0Y9lJQnGMZbyeT8qbMDH+CgMCaqTl6LS/DXgJVAt5IMFoRDgKzR25437dyP3Sjd/vBQavBVhOPw47xcVRepkHEOVU7UIAHdXsX9EgctY6yOo6kBdn9/mYD05F+HLJHewuLWzE/LxCUbIuhQJbYEzmSZjirjyUKmRj76xf5NcgXWzczrLckOrNSGmRfBQdeoYGQ4RSIhGgbC0ayn/ybt8FOqqBGvKQR6JqBMHNOmgS0
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799009|8062599006|19110799006|15080799009|7092599006|3412199025|440099028|34005399003|10035399007|102099032|19111999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EXuQ7C2sEcvB7MzjQssZ/Xw0L59dEhzSrPTzUbLW75eXrVhonSvNrpucZ2ph?=
 =?us-ascii?Q?hU5ZJh5bC0XiGgl+Ha7H6aXfr7AahiruwcELQeEvU1AlNG/Ha9YFEZ2YcAPP?=
 =?us-ascii?Q?OtrBf8UzA29AzcYuzK4bIO7o9kDsgXvwA9NPrI5Vegv2T9fLNMffsbR+t7O8?=
 =?us-ascii?Q?WCbOYZyRVVdO5RQ4Xhs0IlJdmp9fIYLHRogOzJ9xuMpn5rKadK5G/zOMj0i7?=
 =?us-ascii?Q?LWeaAfIDNO5ABHzFjHurP0U3vnwLyVpcsD8C5OHdQakf/s123XmC2d5l1GSQ?=
 =?us-ascii?Q?GPINwBKEaDh6S6dm2674Kak1z9OCU6OE5rkRlAYnztkcdVhUkt3x/onJm5hF?=
 =?us-ascii?Q?Vr/PI2HVHfUk1t8awz6wiXFexjgGes2hDFsPGmLfI8TEoYjl9tte00lxN+PA?=
 =?us-ascii?Q?iYNjmd0yrBeiIEw+ZORBEfOudEOkGqQ4DHNnV2Mnoz2wCHuwVB54DpBqOi1X?=
 =?us-ascii?Q?kRdjy+pMVTXuEofXaKl+jQto1sY/RiRAJavPyjGMLps9vnMjuydf0Czu7kC/?=
 =?us-ascii?Q?tn15p2y6+I53KG1eWJySXgBYvdirwynJqZCNbrAs/Ymxj54Kxi3n2K1c2L3m?=
 =?us-ascii?Q?OKrN15MCo4dmbaBV6wl3jLXmjNdG351gw1Exc3gKuqFy7b6fbVglM8ZC9wtJ?=
 =?us-ascii?Q?/sfYoJSlFvp5gyQGVBiJR2OACo9fr95jKSzs+hJUKxRfwATKrNp1E37trx0H?=
 =?us-ascii?Q?U7hvnZcz8qwiSwBo3fy+IVdVEuvUNQFQcrvm8dy9sTmYI7KogeXZQOwf1aPw?=
 =?us-ascii?Q?R5ohpj2CO4BHVnRNSAjemB8pg+Bcp5U52AmKuaNKl4vNXEhnFOBKIERL8nPP?=
 =?us-ascii?Q?ACJfKvlO/p/eWmxCyHJNfFVMHgV3/qtRbqhQlE2o0HJOnOBTa9wowuWOYp/9?=
 =?us-ascii?Q?8WthnnLZL4UqyCUkNpzJIKsx8sCGfCwxq4YaNxAtc8z2x7MAx9/d6n/qBfyQ?=
 =?us-ascii?Q?AA6yXBYFnyNYDWxKB92oPwlsn0rU+aqT2KpstoElFHQvKtrUnRDhuosrPahV?=
 =?us-ascii?Q?tvJUn5MLs/N8iG+h92ZIi4ih6aPTf2pOC7QtYg1kMEtEKA2v70bdgJi4Zbsa?=
 =?us-ascii?Q?dVDHCHRCiZaCDuOmeDh1HGeS2FAyywEaBzeEO2T/vG0z05fgjf67t7NfFKf9?=
 =?us-ascii?Q?w022EDXyHDLS10H2radqW7XwtcU6fVZBiOaCHt/lLRS6OFOfWRgyGrlGiCDs?=
 =?us-ascii?Q?RZlTqALOPrcv4Cbf9hU8ASz+B1FautNZ2lF+7SeLqrrSU+0LQLz/nzV8zQI?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cTZUJT552A9tTeOcy4OyvC3vZarMcFFb9BmvcD3X4ssisiTTnN9pZJmqmZBO?=
 =?us-ascii?Q?svsKui66CkLg+z3kfhHaXVGnPRKipZXmIU0kl3Sl6vf71hL1FaYU4iazDC2R?=
 =?us-ascii?Q?woSZRl3QFrjRAsfvwvh/c89l1i9Ypd8HEpFzV2vcXyL8IBfxSsYbLKeiO23D?=
 =?us-ascii?Q?I5Jx013Rx6O8vCo/ik6vPJEmzulHlFqYC3+oGGbsFmwWZSRrbShb8pDXXb/U?=
 =?us-ascii?Q?kPchBjgMSZECu6zbV6Vm8r4BNI4nTodS+1mCwF1Pjc5UxE/qE2Pb108IeWT3?=
 =?us-ascii?Q?minv0XYq2H1mIdCvVQLN2E2yrcz8krjpKjlflhIgS/PRaUiqfDT9j/P39Wie?=
 =?us-ascii?Q?EDTqJmWB4dH88XkNFXNm5YI9osjjpM/ceB305ZtNfFD/H2WMW32qztbdjFfb?=
 =?us-ascii?Q?96Y/I98om02CPhNllL9agaF0JiknsifjPEjbnSHln14W8IgUaZ49xGTarmv5?=
 =?us-ascii?Q?+Os+RMveuKbXyIzFxqOCX0cL87BdQo7maznRzeas4ahlFUxn6xiDRDQfdEed?=
 =?us-ascii?Q?EZgjQh6VWXT2m+aFS+xDodXRBlQ9eEy9viRBcQpqGgfquOY6QNSDeE7vXcLU?=
 =?us-ascii?Q?q4bSt8Kr+uVqEon25t/5pUp5MevFReWiNfoRt8agnz8zXYow4Pi/sTf5tRw3?=
 =?us-ascii?Q?OHc3J4j6Ijlh93LK+UeSrHAzk50MQNF3PJYcD5JAn6YoM1Hiu9VhR7npkcEf?=
 =?us-ascii?Q?4OcXPMSWBTGHkR1H8p5/mv02cc3o5mF621OINweAK1R/hcUwk1+WnXkwZCXg?=
 =?us-ascii?Q?WurCy8Akp6vkB34IfCzjqZ7wba5fQhyLsH3gSyHQ8dWnzJ0oCR+ZvkSTCbge?=
 =?us-ascii?Q?r0s6d7rfhq/kx8rQcosSjC77QlI3ZBoM5qUBjbhsQesi/9qlou4EC2HMAaHA?=
 =?us-ascii?Q?/fEBPdylbMU0yoCpY5U3/jIxUgcFep7CdDjIzQ2sImU3LzvkTmv/62IAtd8O?=
 =?us-ascii?Q?WygAA07SIHQ/uJN/8Sd7RkRt/B5ah5lCPEwWOWVT4CndfvBryMZExMtPOpzs?=
 =?us-ascii?Q?Bjomxa+PanN1ig/xOlyMxuaI/iXAlqkX66PrKbBwBB6L0mVTZZpWPSZdjf4i?=
 =?us-ascii?Q?yWT+qMYkByBuldsbgZpjZHmkucWBFsoRtVpExW1RcgHXdFX3oH42LmwnJ25e?=
 =?us-ascii?Q?MA+0VoWaHI80yqAyPHbCsuz3e+BoIct4uBLFv5TlEyy8APzwX5x+jfmlLIE+?=
 =?us-ascii?Q?2RdKKkQvn80R+ydRzzZ9FSkXUrSxqrH8V5+BVLbS6OBO5tC4LzAgJNs8fH53?=
 =?us-ascii?Q?vwXjhv5KNY7jNNFhFmbiPkruFSf1x5nnbuSeeZJuhGbF+BpX1fi3r/kxbipT?=
 =?us-ascii?Q?0u0oGW8tNNa0qbXaB8B6B6Kd?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E927FDA107315408D696C1A7749F87C@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6b460c-b6da-47b8-7f5a-08dd96d3f58f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 12:52:05.8040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6332

This commit links `git-credential-yahoo` as a credential helper for
Yahoo accounts. Also, Google's `sendgmail` tool has been linked as an
alternative method for sending emails through Gmail.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-ema=
il.adoc
index 26fda63c2f..81f8cbc6f3 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -543,6 +543,10 @@ settings:
 	smtpAuth =3D OAUTHBEARER
 ----
=20
+Alternatively, you can use a tool developed by Google known as
+https://github.com/google/gmail-oauth2-tools/tree/master/go/sendgmail[send=
gmail]
+to send emails using `git send-email`.
+
 Use Microsoft Outlook as the SMTP Server
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Unlike Gmail, Microsoft Outlook no longer supports app-specific passwords.
@@ -579,8 +583,7 @@ next time.
=20
 If you are using OAuth2.0 authentication, you need to use an access token =
in
 place of a password when prompted. Various OAuth2.0 token generators are
-available online. Community maintained credential helpers for Gmail and Ou=
tlook
-are also available:
+available online. Community maintained credential helpers are also availab=
le:
=20
 	- https://github.com/AdityaGarg8/git-credential-email[git-credential-gmai=
l]
 	  (cross platform, dedicated helper for authenticating Gmail accounts)
@@ -588,6 +591,9 @@ are also available:
 	- https://github.com/AdityaGarg8/git-credential-email[git-credential-outl=
ook]
 	  (cross platform, dedicated helper for authenticating Microsoft Outlook =
accounts)
=20
+	- https://github.com/AdityaGarg8/git-credential-email[git-credential-yaho=
o]
+	  (cross platform, dedicated helper for authenticating Yahoo accounts)
+
 You can also see linkgit:gitcredentials[7] for more OAuth based authentica=
tion
 helpers.
=20
--=20
2.49.0

