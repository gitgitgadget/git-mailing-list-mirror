Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011030.outbound.protection.outlook.com [52.103.67.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C511FF7B3
	for <git@vger.kernel.org>; Sun, 18 May 2025 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747553734; cv=fail; b=UUkbCQcOXpcw/4a564gYGd/OqbC/QLidRoQil8yLzEUuRFWK70C+pRKDrDRhyS29ou6qhWpjHrxwGCs2wGIjuX0wBKwMhXE9Fku554yqVGJa0qnPOt9FMNyHPJ9U/iYHqEgE42VIO8aoqfiFl/yvgXNBxuGLqfjIQbn0VNv9KIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747553734; c=relaxed/simple;
	bh=ZkoLRO8jJptvMbLEFRQYcttaQPmuSrbsOOK+K4+Mvsw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m4q4EeGFZX72RUR30Da/ZcAL7C3XNKLYT4NT+87B3LJXj1OXxH1aGSsnH3ASwb2VwUomBBnQXmyzcLqbMnt8zr0GGy4rZ1jnT+DgWGnO5Zvz6B1No8RYm42eVGUFRwoTGHfBbOT0y7LT2fpjZUR2aAv2fXZJugf+vxBSahzgyAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=FpniM9b6; arc=fail smtp.client-ip=52.103.67.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="FpniM9b6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDm8B6qin09RRVKw3jW1W5Uh7XQ8pZCm7AepJ71mDAhbH0nHFVJhg8hW4WYhgJD5jP61yOu5bAZ/a/Xm51CNzS8P1iqNXFoYiOJ5RoVckIs2ctqgdCIY7KHkYm8cIffxSmR371AD245SiepUfy5IhZycw1LSAy1RZtPXOiVGc+Nz8lH9u67o5wG81hivkY39F5fUZQy/F/6VixmoE/smwveHTgQlebca6YPggHIQrRnGtrnhKAE3VkcYuNdTXr+mv4rMf7wxMOw7lTeQh7eYJ3HFUVPJ/SLIWI6MmrAjXjLEtCjsoQuwaVl+agoJ/RNtXN9tqFH5zzoObtcIPiUWlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7xiDru5EEi8sSe1+Ym0yK6qoMsiL3KCFGtDWOKMSTM=;
 b=L2S/E6pQ364UY6iaKEfAK7tmInfd84STu8gy8ENEBfWAJOo3oSQly9gZM116Rp4M0h09Lt+hfsP1/oG5aLsJCJ47vSf2qxM+ne+zvhG3S2qEyUwTiKGbI1Dsil7T/hYHxamoUywOtBO4djJyQ0CZsOAP2vmnWjHm6oExjsBQqTpZWpT3gsioB2MGKxcOV8lYtQogAou66EsV8TUJXbDO3XLLGsmT45VcewvAKkHS5oV/RKrZuzDXsIYjMsc2w56hV+8jiiEEpJLaZz70X/yz9Pqslnd+lxJ3TjrqBw5f6KTKnyk+6sDX6iZ6didTi3eOIVduERJpuzJe1tCBIYJ6Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7xiDru5EEi8sSe1+Ym0yK6qoMsiL3KCFGtDWOKMSTM=;
 b=FpniM9b6UE1FETj1XFwYW5BpgASpRDQFMQg0E9PnIvfygvlpH35a61/se+LCKmhtx/Xzy4Zug1I5/m+tYBgko9Opg1e3Qk50gbl0u22vHsLDOMIdu10n2JmpmKU57u1A6QJwtinnzkcgL4b8GtO4K3iliLT5R/HdU5gm9KB486ZBLm51pOpFswNZHJdti/+WC/13WDeivIUK/5rbVd0MsBh3EmPWz1ej8l1st+zAks9IJSBdlz8rkk6+XTYW/csSSG5ZebOcbOohORYp0XsRnIIufc6kIj6r4SpeAy2a00aSI3Tp11CM236HQJBiteLq4EjmwV/+qUVrckBWTsS9tQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA1PR01MB4418.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 07:35:28 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8746.030; Sun, 18 May 2025
 07:35:28 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 1/3] docs: add credential helper for yahoo and link
 Google's sendgmail tool
Thread-Topic: [PATCH v3 1/3] docs: add credential helper for yahoo and link
 Google's sendgmail tool
Thread-Index: AQHbx8dtN4muH3/IFUaIaeXznkFuag==
Date: Sun, 18 May 2025 07:35:27 +0000
Message-ID: <94643E90-49A6-4615-A82B-110A7D5297B1@live.com>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597D6BAA98013269897A963B890A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <6D57A8EA-FDE8-42C9-9541-7B97C2DDBCA1@live.com>
In-Reply-To: <6D57A8EA-FDE8-42C9-9541-7B97C2DDBCA1@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA1PR01MB4418:EE_
x-ms-office365-filtering-correlation-id: 3cca8645-030a-44e6-0e79-08dd95de8f8c
x-ms-exchange-slblob-mailprops:
 30ekHghIwFpWJZJ/S7H67WW7FVejyf+CS7VPE5yrpzVevCpFbxguxJMRpxq5yEdU4lxcb5kHYflQUQT6ftUSXR+ZzKpRn1kNeyXWw6Pj+dUfgcmYKLDvPe129ypVbf2XT5DDhKGl5q8NXIhx579SOVNUwMqIdJojWDuZ9QI0HsbFcQLiFv3gE0Mt7hMFUhcaT7UtM7DFsJFeRH150DXBy3Ht9x1H3Axb4D0dcjGrQSmTAAc088gABgFPksrBza5qWbKuN6zKF1tMHbAtf3PxgkQKS101lfldeYsjCxfQeguKJTTmbvedA7bfP8UqMiDPuIIXhJGxmHjqsAQVsKXp7IWEknHPMFZAp7WBn+5UTeQV242UscdTk1pPjXHMisJ5DnddhoERI2gqb8HfgAf4tVoSvakAQKy78VpNNxrXkkjZdg+dsdcjRcMhRZ+h6I6pyVu5TkmNx6pRd3e5miKlOkiK1/M1efyvXzkrUEHNs+6LZiar3S7id4DHzUnIHhHGD4YicaiiQdIDVVaWUAvEle1jImBiYDXOd6enpYfC5B4afhNNXntFqrpIuUDwb2aNNHKQwnaMhGUkb3rJz/Y6Bt0euoZ9EnhxxZswgXmjaMmdMISDP9+xXtaamZf0MA/exXgZA89WY1/6K9VNphGiRcTW3dHfdKvpTsv7+AJvOLx8ZBzq/WRzW+3LHRrTVKXJmqzwB+zrpJM6z0NmFD2IZlFkIgXAeah1BYpeJWYn5Q6E1E3itqc07XaKvxOK8bBJ
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799006|8062599006|15080799009|7092599006|8060799009|461199028|102099032|3412199025|440099028|10035399007|34005399003|19111999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hRXC5T0wIdUYbIlfXZXWahmZAZjiST1y5ysFbxprmSEmvMtbKCjcQ7bEg+d9?=
 =?us-ascii?Q?h3Hkubw5Z3O7J/TegRoWXDhKxJomCQSC5WlnJ10QCpkkw5OCKG51DrICbYCn?=
 =?us-ascii?Q?UzKuFHLZY9SgEW6z1FdMsagdFX15uGGfWu/HydX+uK+wNkpehlzDZ8UmIgxb?=
 =?us-ascii?Q?h3iGeOFGJzfTLCKP1YJ9lLCTsTYZDkJtt7kNSz4kihQ3bXFua+BulqieRP++?=
 =?us-ascii?Q?aRGq0OPjfWfQTW+0ZziTQQdFuZ3rs52kAPqWWIDvbzdbPkRTcAdLFw8qEiuF?=
 =?us-ascii?Q?ZHk9GZIBTPWOKBgIjNtQIB55aVxG9evC7mm//UUiXH8OoeruigRY+ejax9Wd?=
 =?us-ascii?Q?gD/12eBGpSEb9JEWxrdXpIFZGurBL3XJ/mnDyCWBZDW8E0i8ws5qEVy5nV4i?=
 =?us-ascii?Q?kvXbiDlzPOe+wPXzpMV96hqA7urjmlDv1BDT4VWJnG/dMNxTls7Jv7gQtPMf?=
 =?us-ascii?Q?BC+Gyn8Pt5Ne/NIkmnfykgDl2tsmcxxkujjk6hwYHdBwhl2cTsoQL247nI9K?=
 =?us-ascii?Q?WYh7ccyUcePKNfjnbhpKESxvNYIIoMxch6V7IONpxZhVvpDHkEkZlyLBJipR?=
 =?us-ascii?Q?QL7xtmT05OwlaJv7SXQiw5llnrBkxwRIWB1GVYnfq1SwzqMud/RsEF8WBspa?=
 =?us-ascii?Q?4HjDsTzo0YnDK+FXN5cFgMxR1WCLCDYmKgdOC9c+pQP6IMD4qTFGKHnLphzs?=
 =?us-ascii?Q?E2mBuFm8ASHj1RrIyaaa+9yt0M5dy5DFy6708VWM+okEul3//LrKDWElolxo?=
 =?us-ascii?Q?mIF/mwnA607jp1ykyTkD8TntfZiPMr9mJBLJtlJi2sOigAdJNoMGkJzcnaRR?=
 =?us-ascii?Q?iMjIArPqQU6/ucyh7+0eJguIghDzOc4hfPA+MjFHz+cNgooJZouLD9W706u6?=
 =?us-ascii?Q?/UOLURcBkH5uxY07Yn/szBE1XWo+2Tdcg6TF8TFJdcACOVETDeacEBEZLYWK?=
 =?us-ascii?Q?2Op1psqOsWNIGjEZj5lv2PSSpO16lxSpYw7L1RYzkRj4frJRxC4MzaoiIVCU?=
 =?us-ascii?Q?+/3NqaqtWSdyp1tU6XCzVgE+h9Fi4/fcMCSc3Vvhh4bEVonmcsFZRl3Vh0bk?=
 =?us-ascii?Q?IQmHdZYu+7gFqVBF4ZL9iqf4WQxSovSK1EivG2TXR3FFFiCaTlj3PdkvSoTm?=
 =?us-ascii?Q?QVpJhtUjai+e+udSIZv/Ttkd7K4VzUK9/U/7ZnGbGwbWeQntXqEEBQ24ned5?=
 =?us-ascii?Q?wr0TuN0gNISXkzGx7IX12LsrhImNVhF1+yXn1qkryujmzsyo5p0y2UhDhtU?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?P1M9UDLo5Mnf9D1cddevOp4yigMxJh+ARBDGN5uRw+QA34nGKOd/5QUsAfjU?=
 =?us-ascii?Q?C5jcUX3NWPeb0RexgfyzM7sngY+v9qpGM8HT6c+RDjy/h2qmPRhijEkJVc24?=
 =?us-ascii?Q?UqL7rzagrw8KIoIdmQqW/rkR0358updnXhBIBSLsSyJYQ0bg14bX/wt+hby4?=
 =?us-ascii?Q?fivIYLHlXB+cKmU+C9FqDBccf5cWqg9DcRxAFmvcEOExctNFhX4he4VXLhAL?=
 =?us-ascii?Q?T0YYJwYPBrlre+dONfc4IhJMnjX1t0a5Z1VMR+DutEhAgH/z38KskYGlYRrR?=
 =?us-ascii?Q?cjfGeW6UKAzxV3Ym8eMhPAdgQ+AnJYg0afAbXkAg9vSpVxxF79uI2SXElvCl?=
 =?us-ascii?Q?ksuCInOeovqQbCZtgpD6XmVw/OCA508JNj5vbDarivDI5kSreGNrVn3vvp9Q?=
 =?us-ascii?Q?ra56WS9vBrmv/0mxGEqrzoWethWfSmOAiZ+q5lARIc5EgK6jaRcbDAwwbfhu?=
 =?us-ascii?Q?HiWHc+9vbC2XJBaDUkNkrPSbqZxF789xACcGF5zlFCyvuIHtY6gLvtXSYw5h?=
 =?us-ascii?Q?Au1OKaHiNHEmRZqOuyNIxh8DRZCqm/aFOEiSaGsuLpw/Aqne5KtC1WCMoNt9?=
 =?us-ascii?Q?3jGndoODKOIAw5EokcaHj+g4PP6pjUhb8KG55GlrZf43Li31ab9CWW/CcKVm?=
 =?us-ascii?Q?T0JFlYpTU8nFRs8Shu+eP7a+HUP6xZAuabmwP9DiLwbkjcYPPzMvRBa+jPuX?=
 =?us-ascii?Q?X2PnmBBA7FbES7QfpOHnWxaCb8pMawPczZbQ1AIDWioHzNycrMr6oQosOhMk?=
 =?us-ascii?Q?t+eETO3JZAbjKQfYY2F9KNOb4M0VbjKYBVdzDcNO5mYGhhoKzCKfn0PGVFSS?=
 =?us-ascii?Q?layAvR1+svDKnWRG7QQxFlVtiHlFr6WA4BPCkw8naR2jZd1gk3i149AMpVa7?=
 =?us-ascii?Q?lQKkyOUDcALH5OUDrNtuOm721pOUHOQRsDe5YvbA622DWELXQZZW/DIFF8wA?=
 =?us-ascii?Q?C4XhQbV0HCV5npWNZKjBW/98jP9FeblNx9Caqsjt4nUlMTx6MjvtFPG8cRIv?=
 =?us-ascii?Q?M+9dhLXNwxxoSxWLy6N3lcO6CxXmPkggoF/bU8YsZGc+cfY7X4vuQHnf/Xuj?=
 =?us-ascii?Q?EF16zhSM6KZ1txMNtf0/A51iz53B6JyarStpznCjKdt8NPnrTQNNgLV1NZay?=
 =?us-ascii?Q?f7Qz4dUXwAZkyQi/jmWz6w3QVsqQCpk2sWnEzj/hsOIWViTcMoWq87P64Sbq?=
 =?us-ascii?Q?iEFhleCHXrvj4IcGOzz5Mo0wc2QJwGDuo3kFU2kanDzFYTNS0L0V0nUQ41Xe?=
 =?us-ascii?Q?Wytxe58bqMRlcB6UBfSCDnlSbOq5pxslJkviV3x9+ZD2GUaPCWb4IyWxKYja?=
 =?us-ascii?Q?Br4I5lXDYJ8l44vDiwZDhusi?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CEBAA283E7F9E74BAC8C5045105A9DFD@INDPRD01.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cca8645-030a-44e6-0e79-08dd95de8f8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2025 07:35:27.9858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR01MB4418

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

