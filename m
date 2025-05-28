Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011034.outbound.protection.outlook.com [52.103.68.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3E5245021
	for <git@vger.kernel.org>; Wed, 28 May 2025 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748415948; cv=fail; b=nVA+O2rBUgzK69YMtqKBAUmTH0tO9shJBgbn/jqjB9bJNkku52TJBwXK8lK2a64xtChIEjeQjmmyGfWRNx3XnDLRf/ouWWVnF1J/Zatf6B86gmvYE8tY+np+D6kEhyJaCa0xSDbdjWxbBpYa+2lj5CItdWWdJ+dx5/8JV253B3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748415948; c=relaxed/simple;
	bh=kdD2PPNhKJGJrH0Dzr5qoNuC50j60RQEXxF1m+mw26U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TSi00ZyTZUs7S6eeftM22b5hLUgRPvu/7Qs/IQS8iBLmr2MeZci0dL6SA9nTo0GZXKCNoz5mBrQuvNZXNOJB47ZHz5mKpoJXyr3wqwu2oTV/1WqoTQJFhX8+lNakpzAfkATeBCP5JykxJiUG4YfcJmoNnJWF5aDtlc637AAhgGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=WAMG3z6w; arc=fail smtp.client-ip=52.103.68.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="WAMG3z6w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffs6HYxKoieLCpwUD7uPazkg1dl0jHzmnyYxF0Nyd618JH9gfWjynPoBY+6NXcUyIMw6IPC4yTvNucb2r52zG974vVHgjRt2ENFDD9sfNqd8tIxC+jM5IoJClD7F6ZYLSGSsYFcCob8m/qy/WIXheoQsSFYzI+u3AnVkus69+Hib+LKA7z4pqFxRiZRpYwuRw3MDHv1fYkphFv6gaX9GvHQOxJrfFgzaxhkKAHR5U2MvRSVvgjAk+1zqCF3XfrbyZ1cv5t73sQBZjiIpMM31DCCmf9hvzomibFwYg8HoBTo/Ge6zecfluxBRKSTm01DNv9uOd8YNTi1YcHA3gT/vsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKTNM4khYgWvR+HFMb9lUNQ2oPKGTwPLZWraIXtdCxk=;
 b=b5SZfEnszzkMAjrKWBIXeuHuz5IQN20+r0JZeyEAQUhFjVBJ2drtKhwhRMhiqfp4Wy8NR83DC7Alvd1/iJIj3ZhEkfzfGrTxwmUOMBUOQsPS+C8GWBRVOdPh5KsFSIr8BHu96LS9iPa7lPKLn4M1ERcHTChH4Iq7cBrWoGKE7/b1bPkAAIsqu5pHLbjMRVFMWDFkLngNUfCSF5hoCTcalAOAVLwjhcOjj4pN6o8Y9qFezTJ7/3efXM8vbAiYGRIN6RmwD+JnFI+U7UtINYGklYoemQEJi+DM8EWVTeJUeVjhg6pajPr3s+H6dAgD7q1f0gmGGk3Lbexvwdevyu+Z7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKTNM4khYgWvR+HFMb9lUNQ2oPKGTwPLZWraIXtdCxk=;
 b=WAMG3z6we/02NvS1vGdCqNXzmjFbJRnq0J5VLeeItemLEayEDSupxzU4BgAhrA3MO9fcJmgSWlpx52+Yppo6q3CRXVkKfAw73zfrCDCJ3JqMEcjluLag7VGgpf/cN2lzRop3K8IeqAfuIKGub5C1owI9CcE8/34/i90uFeyA6AJqGkPBRVb1qNtZ2Vx7KvVAijxBXRRuDBzVPaCAjABZRINjKudJUerjFAcqueJHJBq5+umx6iNrPidae/PDMb+/ZSiKx9H0mEBBTWWiheDO1sb1hMHrra5mdbfizaGcmRO7YjAwKuc7TA4GrDiNZY713JwL360lUD5UONUZIson9w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNXPR01MB7259.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 07:05:38 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 07:05:38 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Julian Swagemakers <julian@swagemakers.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Johannes Schindelin
	<johannes.schindelin@gmx.de>
Subject: [PATCH v5 4/4] docs: make the purpose of using app password for Gmail
 more clear in send-email
Thread-Topic: [PATCH v5 4/4] docs: make the purpose of using app password for
 Gmail more clear in send-email
Thread-Index: AQHbz57qbnQbXLfgxEaEDq8ePWOP+w==
Date: Wed, 28 May 2025 07:05:38 +0000
Message-ID: <20250528070521.17379-5-gargaditya08@live.com>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250528070521.17379-1-gargaditya08@live.com>
In-Reply-To: <20250528070521.17379-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PNXPR01MB7259:EE_
x-ms-office365-filtering-correlation-id: 94b77cbf-619d-4187-ffe4-08dd9db60cf8
x-ms-exchange-slblob-mailprops:
 laRBL560oLR0Ybdxcp7KTbjbpYD2CblCzLMPYQtHV4A8wvJCJCddtzZoUoU8XOtQQcryEm90/LjLAcGG5liwFGZ2o/MW5G8dv0hFeJa7Wr8cbAI0KdpvwY79y+KGZH6fctlorHNaEBocBJbdEWGKjoIc1qahTbxtqHQdUt8LFJZwX7XK57oHvTgXe7zsLeuVEY7kblkLmCtjLL0XOfpnN/T7KjE80VEVJwYycbylwXc3hIsrKKRTEgjyCu7YqOQIKDwHtohDCLa8UfPdPXf8f5OEpfhxY61kPvEa+2bV7CiG0BrDnoqMLM6bOvb1TWgn0UBp0WtO1NFd26nTbEp4sS/c5CWPvMQlnfIQ7yxKnJSApShjHNGWHdQyPiMbErmjCdClKzztmQ7ENIkL1gGVBfBTWb3IdoFDFcpGCTkjQZ+TR8G/6JdwuCnnaKNGtz892awdpp/XOnu0BkvlgXcLL4QC9nwM8OrtCXIPEW6sfGFL2HUeyDelmDgEjE82PBUCpqQuojAK/cOuVrRSEhhcxi69q6boJTnc895j1VywvPKtak2JtUBh0UH8oUD36WBwxE/oMg0weqrv94umjrVaPa9vT1ioL72YzsxkiJybPghn7Aw/zPBcVNtvy2vYJmlQgPl5mdAdwhK29hrZca5dLaW4Ht6/cPgPZb1YvyUH4tIMw09WAfoS/XGYhEvF+LUFLyDigVbdgaAda8OzgMYYFIeLOxdi0eq8ibAjNfvlORg5vZRxcs7mR1NaFUpFBNt8vIxNMgxcKmxzR0kD1ycs3E1iwzVKtbj0
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599006|19110799006|21061999006|12121999007|15080799009|38102599003|8062599006|461199028|8060799009|19061999003|3412199025|440099028|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ycH38e1i0lI4bZNERmWxnsGHrLizfs4h62Jjx20fbgXq3KawhDlPg3eS84?=
 =?iso-8859-1?Q?LlECBDlmH1SstD8ZIOeidCjuY+TkbwlTBV8MGafvKo1MOcIIK/z4w3h/Ln?=
 =?iso-8859-1?Q?AG7V0uRaYBmKbFORBER8v7RN4k9fm5hgqgaB8wrnz46L0SEGJMyT76zv8H?=
 =?iso-8859-1?Q?zDcF4PsIab8GdTPiXfInH+pFdsFTOxThRzXUaxRmEa20h5/2Pje2Fbd/Kf?=
 =?iso-8859-1?Q?8MUPj+msgdQWeE6es9H8UGWk9FvciTb2Z9LmjahVRQHDg++DCPKJF4AxPR?=
 =?iso-8859-1?Q?s+VT357fBHN0+n3xstZ4dNSn4Z3GwwynT+PdMnfBU+gkUl5rTJmx9Im8FO?=
 =?iso-8859-1?Q?Djdz5hv4VDgMUd03qYRvPN6pbsLR8DCvaMipSSn43dop1wuj8tKo4zm2Sc?=
 =?iso-8859-1?Q?D67zn3bmJtTCJhFe4LCDodSiSfGPGzMKlzQV+hPNzvhVLrJfI0piVi4lut?=
 =?iso-8859-1?Q?8bhxYTkWgog89GQz7qyvEpTDEVYEVziBWVZIEDhW/H7yFxWxh8yxzEkN8m?=
 =?iso-8859-1?Q?hLhOqsg/NlGN3CEOdWSGkwklOGysoju4c2ZDCblC+/ULOAvl1Iv0FxQXIZ?=
 =?iso-8859-1?Q?QCIr4/H4to/y554AR9LJYEq0vVoDXSVitLnFbt/HzxCTMhX4fquRcREIT1?=
 =?iso-8859-1?Q?mvkS30KJysxJo7FQZNRqqkLsLR8HN2pCd0CVhtpa702gqpFmV+ul58U+ch?=
 =?iso-8859-1?Q?lGBCau5Mf4Pm0SY5aAUScuWecL3/YFZ42cdcVI806fShX/4rhkn2ct/lhv?=
 =?iso-8859-1?Q?hd6XRfV4sJVvlhtwO0QtQyB6QIUuofiJ9lTaLnTFdrdxFdMmKncMnD1AMz?=
 =?iso-8859-1?Q?1wVUrZQmzOIqVgKMdzegBYDWDZ49TrWRghAM5Qdq9rM9KY0w74Ji16LZiY?=
 =?iso-8859-1?Q?aVPy7hQaSkEH1RgIFUD5cRE836LBbN2Wotdu79qY7+eXb6Bqrt5xxZ1JET?=
 =?iso-8859-1?Q?1f6wwFenf6KEbEGpjXC7ipzlMtr1skLx4zL2A+bDOHwUK/U9Ge2nOxfuk8?=
 =?iso-8859-1?Q?lPge8oziK3LjH5fSsXow423sTVCi15HCU/9eDkzzs/JA90EczvLHsYBKR8?=
 =?iso-8859-1?Q?k0nkqhEK460xHDwYf0B3yBybzP95X5Mi/OQ3eXVvR2w4bY1NYyxVwkxHuE?=
 =?iso-8859-1?Q?Z7Ewhn8c/71NDk0J+no/juvytQP0JN69rt8LT6nf4uGTNJU2MF0Vn/+4mM?=
 =?iso-8859-1?Q?MXkEaQ5fIxPIgWhiBXODVNDw8+p6s+ZXDI5Btm+kbFKf7eEO58diGIgZ1E?=
 =?iso-8859-1?Q?/EAsmPeh89WAdiTdAvmK6lMwfNYlL6Okk0jTTdDGxgr77qjvT9Qi2DV248?=
 =?iso-8859-1?Q?Lw90k8unYGmKuNhluDT7f4Ee0jbnRUs5ILlaOy6OyDIsCaE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?kBF4ntVWNJa9Fr30gn+7IdLvOiXJlGKG1146jQv0GVISQvLLKNWHlSVnku?=
 =?iso-8859-1?Q?rN/BwgjlkZFrkc5+Y/X/EqsjXgX+y5Vt3/xWpDZxRtnhPIxq/b7ldmmqhQ?=
 =?iso-8859-1?Q?6mC0EPH44Ph8nmB1wdK4w1GobC8JtxVev2Qwp80e744SgYPtpWDzYX/uPn?=
 =?iso-8859-1?Q?LzKAaDz7XGekTOTHGnd7XZTmJk0jPbCD7mWc7sQjTRL6yWg1q2AFS2ODU1?=
 =?iso-8859-1?Q?lxDgxnEzb6e6bT1+Onr7EzE8se/Q5avzg4bav4U5lyl62MoHb97PSD/Bvc?=
 =?iso-8859-1?Q?TL07ahmbiHsc0iLxkm73sCdkrqO7EHCRt9AseZwfU5quM1XgVa/HCw+BKP?=
 =?iso-8859-1?Q?eQARPXk69nt7bljEDFxw4AJNqay00faV1tEp/1bNlDfx3Fz+MUiugMG+3R?=
 =?iso-8859-1?Q?07mAnS8zLzSlX52mwbGJdm+GRAOmq97NWjnukMorPcQv1HMYe8JpmONIIG?=
 =?iso-8859-1?Q?uH3BGEA1GIqaeT6ZLEASvSt9b8RRIFvjfhm1qn4dXM6DDhhWqZswN4z6u5?=
 =?iso-8859-1?Q?qRDjp4H5wCs3Yx8cvvK928teIuWqCYLxrM39GTe83nto6aEQZVChCq8sWW?=
 =?iso-8859-1?Q?NKaHvH4X0kIsSBy8sB/ZgSFV7zsQI1jPFHFix9/mcAKVJKQXYo9fKgppuC?=
 =?iso-8859-1?Q?+ARx20woHwgyx9bcI+xxpNhtLE0Yya8CT7Cq350yImQ6mUwtl4MTQ//npU?=
 =?iso-8859-1?Q?YMxnubsx17MuPpsmALCDe/D8e6OXIPKzk+CdXcKttzAvmbj/ZkTkLZTCnR?=
 =?iso-8859-1?Q?l0xa3j58L+nRiS7ehOcPUKzvFgHpSIgDQacWHQG+ODfVOfxz1ExgQM0IXF?=
 =?iso-8859-1?Q?qZGO/spdcaspHoBBp0JYqeRpXCbcYL+aZHMUCqKw07J9O5YMHJLUTPIWjg?=
 =?iso-8859-1?Q?T4HQiwrOu97bBbp4fZApg/MJEtdeK3F9VhQPZYWqeIpU1mGG8Mkb41MxKS?=
 =?iso-8859-1?Q?ePsnSWu2wDQU6DvAjbSRvo8YIb+dd8yZmmBm2AN7pIDoMxay2T/v0qbqMh?=
 =?iso-8859-1?Q?HrvG+7Oofap348q2FhnSx5GSatBwaT0Bysdz0s+ne/h406Q+Lgw6frctDD?=
 =?iso-8859-1?Q?SXd0UjkLwuOayeb2rMm1AcI6c456jDe7VPV2t8SEmZ0jjVaM8OASKtwv/8?=
 =?iso-8859-1?Q?x3jJK37XGm7Qfaicb0O9nxjvFbrZu3lG3Acw7r4zAXHYnPdwSzmDBxss8K?=
 =?iso-8859-1?Q?Ay59EJZCccbR01vOKjjpoxwl7RxFwhOlrugZ+BQbi+dxDSjepf/FWO1s9Z?=
 =?iso-8859-1?Q?Erckpbvz2CTKTuGLwg5cy0vHYBk5PjMd/jpcWXOlY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b77cbf-619d-4187-ffe4-08dd9db60cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 07:05:38.3189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7259

The current example for Gmail suggests using app passwords for
send-email if user has multi-factor authentication set up for their
account. However, it does not clarify that the user cannot use their
normal password in case they do not have multi-factor authentication
enabled. Most likely the example was written in the days when Google
allowed using normal passwords without multi-factor authentication.

This commit clarifies that app passwords are required and suggests using
OAuth2 if the user does not want to enable multi-factor authentication.
---
 Documentation/git-send-email.adoc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-ema=
il.adoc
index aff0861d29..99c126cd5a 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -524,9 +524,12 @@ edit `~/.gitconfig` to specify your account settings:
 	smtpServerPort =3D 587
 ----
=20
+Gmail does not allow using your account password for `git send-email`.
 If you have multi-factor authentication set up on your Gmail account, you =
can
 generate an app-specific password for use with `git send-email`. Visit
 https://security.google.com/settings/security/apppasswords to create it.
+If you do not want to enable multi-factor authentication, you can use OAut=
h2.0
+authentication as described below.
=20
 You can also use OAuth2.0 authentication with Gmail. `OAUTHBEARER` and
 `XOAUTH2` are common methods used for this type of authentication. Gmail
--=20
2.43.0

