Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011025.outbound.protection.outlook.com [52.103.67.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BAA244665
	for <git@vger.kernel.org>; Wed, 28 May 2025 07:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748415937; cv=fail; b=dZiOKyiYw2f3dGgwJ1bUm02gUJTw1MJXE73HGeoaOI+tACw1BjqpBap7Z4KDJch1jpBNbyevUgioTCvBdYbY+bvfurtJ42689p+T99//SDSmGNhtXDMbWMXnwzx5Nu3pmptcUCXCsC43aGfhP0EzbP4vrDrvpD4JMslzF+SBXAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748415937; c=relaxed/simple;
	bh=aCy6p58+2mcudF6DixcVq/u0OzWwYymgW6lCDtLF4Xc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K63Vuaj0hFGiLddhwUBixbdNxTM62ukyd9dRckIUTMHWheQeTBeReTX+xKDJQW5YdlhCjljhyiwOy4JHS7uEJemxJFdbBDIrNnfisq563wwiv/NOOpM77yXzaiC5Wm+akxXVFHMSY3+Pv+scR/EVu/RP1xT7fhTXO1oA9NBiUKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=MKEzhh86; arc=fail smtp.client-ip=52.103.67.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="MKEzhh86"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gu7jAx3v8o7oAy8Efz+woToa+92or6/G71iVdRqwTwzA5H3cmjh9FVhiHbuEY5CiJVMW93QKDrh4b0CE9TGnNedNvyK2XiXRBUmmENn+yMNhvVZok1wyA+Nt2Ffb1ZAkzLs82K53RrlGI7HtbCNCzjT8AwlFOLLZcdbY+0E5S0CT0rVRm6Pz936lKJEj1uleOmbWPmarTyE/QXYb88ND3DkDWtqNfrbwCruur6jwvUZgvl4+jHHb5Tk2QI07dkX83/VPuUa4acq77YdQl2e2AKgy6oGue4rrv/3S+Wd9g6xzbvxT0oBQ3XcMlRq2gI9Lef6k/PdBzOqhhcUQ9TQ7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7RU5HJKukJ4Xuve1o90mf6jipEt+Tt+lI3hTZDbl8U=;
 b=kx/tnPalyTj0wyZvfpdbYTEBIGxm40kqCckrx4ayz6SPQ7KGg/OMC9uMNHXe3U8u36WdBLDYf50HZnpsN2+UhKHAHb4FWGpmMdoQVm9/p/L7KSnSNDF7pWYThTHktHXm6KRWcepekbrWtxgdzbTzYYbRffYumxrFJdiP11KomYyBgbo6HQG+QL9JLj26FCX9NSo01Dcojgx7gB+1hRonT4vQCNixCFPAVNAG6ym0nXLYxRAHauC4exUIvZ1+pXk5nTcgwHzOd2MsGOYFgBwlz0vftYJLlI1JuUEZ4+tlHwZuwYZQ/JFxse+qPneDZcbuJ4CSr2w88s/5HQJfgRkpzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7RU5HJKukJ4Xuve1o90mf6jipEt+Tt+lI3hTZDbl8U=;
 b=MKEzhh86Hbo85oGBHHEnawKt4DwhNa4HSxNzb8MXSPkKXw8KAvlVjgearf9E13CEGaXL9oEP8dusst2uwIjf2kCah8bYMUiIfXvlTFwA60mJNA02ggKs1YO0Ez+i3HqKQcljrD3WDEcv8KfoP5HasrPKzU6zCgJprHi21FtKnSVHgDk5XjHDZFSCjFO+3Tzj956/feNnbvPBfAg0gupdhzw+65i3YmlQ0RN/N4nxtGgsJr8mne9Z3I6UdvkedWKqsxdaYjBS7jEd+PjDkPZbcy+HEBSilSgwzRpnf95J9mMR7zZVamwxfnvpbOpqMm/lMmbTaqHpJA1YtRbetk2eBA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNXPR01MB7259.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 07:05:32 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 07:05:32 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Julian Swagemakers <julian@swagemakers.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Johannes Schindelin
	<johannes.schindelin@gmx.de>
Subject: [PATCH v5 1/4] docs: add credential helper for yahoo and link
 Google's sendgmail tool
Thread-Topic: [PATCH v5 1/4] docs: add credential helper for yahoo and link
 Google's sendgmail tool
Thread-Index: AQHbz57my2ofXF4jPEOmGoxbZtADRw==
Date: Wed, 28 May 2025 07:05:32 +0000
Message-ID: <20250528070521.17379-2-gargaditya08@live.com>
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
x-ms-office365-filtering-correlation-id: 90df22c5-dbbe-468f-c83f-08dd9db60948
x-ms-exchange-slblob-mailprops:
 02NmSoc12DcHu/Dr1OK6cqcYKvfIm6M5ssuS2g8SdpO1C9Qqpx45trlIuyf9MVpTDFwsKywogkWWQyEcNiIipDtmNgO8t3ST9B6rOIP40hlvnJXPv50JGM2xazQkSY2VZb/nWSOV1lXTUtpJkO/LH8qQOZaKZWQG8CVHZFSFmWj09BysuNwYpHdrEBaVuEgLxSKMKrUgyjaLURztfVYQffPopb6eGsrDx1CU6eUCW1BWhZteAGzGZjUlFQPHVbltCsvx643PvRH7ATTHjVdGbIUVt60A4jpwUyiaLDrc/p2Y6UQBhqmIjkfFCTXfwd6k9Xq1Vm0Eg+EuLk33BtD0/xl3aZTCU5dEgGcRWG2+oZosT86A1CBS67pFslxk5G1dX1CVIEmpfOIwjJ0b2aemJ8X0Y6idxpDcnGEKcyBWwfGlUHzMS2Z4V+DYKvaBVldrgReCMD2nsr8X3VFxVHOHW/NAxntt5jVneY0z2OGbTRd3CBfKF320tGx0y45/PJGtsoH7whPTzAHNmVW+pD/NR1hO0YivHi7EZBBRitI+CV3zkxf4qUeTWRgbcYM1g9tCnvSvbIr73K+e40szEzSfS6RMTo3G6ZRqdy+IAreRpyc8m1q6lfEDQm0R9vMeXiTGZUXlTFtKCTIAiYmsyQy+oyidm63MeBZMwGZWE7pGqNvesGgc61PhR/KzXbSgI8ZOj1loFOCYNP/By0RlNXOGchHhqyYsxj8C6LxIqowuPgUQ1xmf/sqOHcxzjJiVQSmF
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599006|19110799006|15080799009|38102599003|8062599006|461199028|8060799009|3412199025|440099028|19111999003|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?UWFJmbgeVpIbpo7snFfb2TUDpbvM23vq9HJ87yQwijGiLWqpe65KQXgrh/?=
 =?iso-8859-1?Q?YTCWZZvCjze8qxx9z2lsXYPk//zqLD6Eoh2HmvKgH8g3zR/Q2xyRNRi9dh?=
 =?iso-8859-1?Q?eGu0YmkgXE87eZX/3/mflUGYPUAb2gsLRYcdkjZMThn7kSUvpoP9sY+/VW?=
 =?iso-8859-1?Q?GoNeboY6FY+w4JdMpiCr/ZkPULdk9BoMq4pdjhkGejQKnJVynRi7DYfNTp?=
 =?iso-8859-1?Q?Er4iu0xuPXdxIQjDwts41PB7vhOyzeiVbOTMvd9mIWcyd6N6gOVfYaUfC3?=
 =?iso-8859-1?Q?Ca0i0L4Q9rx4gGsDCV5yzzuYr7POaxSqy1JcMlg7nl8E2nDJmEwO0SW65O?=
 =?iso-8859-1?Q?uouBkWicsAQN6iDZ2l6Ms3QVsc9dICHs/iYa4DO6Gas4CBcd70rBReY7NT?=
 =?iso-8859-1?Q?j2O36WuRCLlo9VdT21ar+rraAYkLdQVlGKl6xgh17IlPb0ieEVwiT5eXuu?=
 =?iso-8859-1?Q?kzXkolURle111Q24s9Cipk7H+qrnJuz1Hidax2JIu359bIc1yvA7qVKUKA?=
 =?iso-8859-1?Q?Mke7KxpQiqmTXS13PWfD2gduuf7Po8vqjIPncv5KjsSVuQAlI28xkJIfSP?=
 =?iso-8859-1?Q?Kx2D44BM2J1iF5o4Q0R+q9aDxpX9Pgw/NFFa81sWUmL3dJDRVlQOJtK7Pf?=
 =?iso-8859-1?Q?c6IFZ9FmnDovGnCSaUeAOmK70mq2Vs4zQFxTLAHMFmi5z5EfdQ0S3UJRL4?=
 =?iso-8859-1?Q?odzg+2cvfLWA6e6e5YgHBpLK5iuZOXBgPJLFti5AdZdhEtL8WFon1STp1G?=
 =?iso-8859-1?Q?ThNvpEucre7iL7bVvmEek3ukabq7K4+1QuwYIbj6cn4wO/qBT5afyTLRlR?=
 =?iso-8859-1?Q?3c2CUaM65TXKt9Q8Rf43qQoXOxMWpICxcyQbGvxqgdTEAW6ubaWbyLHP40?=
 =?iso-8859-1?Q?3NH5G9QVnzJmXQXoFBKf9SPVgMk8IhI8zovMKWGIwFFfKRAxS58ctCMrLz?=
 =?iso-8859-1?Q?EjYeScM45hR2QPy3Xb7n5w4fPo6y0q1d50gmirWwgXGwvBb/IHapemX0vG?=
 =?iso-8859-1?Q?sDhEutiadj9714FHY3N7cQOBs69r05Fz7aDpW2vs+xT91BR74u7AsgIqtw?=
 =?iso-8859-1?Q?cwvTU4lJYz0HJrEBcU6auLjHAhN7NR82uR1tBO2aKmFEhXTeGSMSCx3yJo?=
 =?iso-8859-1?Q?+pcJ45cAyHb5ziJGz/8rVySII7WMrsQfXrypDdlIkqqSp92DjpqS7JKO3/?=
 =?iso-8859-1?Q?dIe4ZNzYxL0+lzi9ZS+wGUn2VbMAnWQpK1deBHdSao9YPjCOltihS3kAZp?=
 =?iso-8859-1?Q?jLyIVyxV9EF4YUJIVlm87O5gSLXrSmH/g/I5mmHbk=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+e3R0SvbzHCgaASX8PrCJTDZ4z5g/4xUG9LpKMjE/kBVpldw5bZLabJrsK?=
 =?iso-8859-1?Q?mc7CTDQQ7hbFeNEJEHbaK2BRFaMl2DhxQnsNwzMVoB+2vsesdd2ztTItVR?=
 =?iso-8859-1?Q?iZq5ZsU6Nawd1LiDHhe+H/kIVKg8dzBaSKfcxOYnr+EsY+RGhBuo6TSUIQ?=
 =?iso-8859-1?Q?+qeaB+lIwRgAYNBWttEBjZSsVSh3DEcoZq115tUrVkJaW4BV0rtGOkFR7r?=
 =?iso-8859-1?Q?ZTDvWGQuN8XUsjFpFr+wTh5mRT3vFGCpGfbjichsPgHzPHUMsJe1DUnJoi?=
 =?iso-8859-1?Q?Z50OEq2GqipQELmZbpvmtqek6faT/pF7H+DO4uBKmstfW49r01UH6+dF51?=
 =?iso-8859-1?Q?RwmWLgtzBpQyOH+xYjRieazbgedDIJbzk5wSIn2PsnFI77J6OXqF/YeBbK?=
 =?iso-8859-1?Q?7tt2oXiBw/rOeLF+nvkgpsFVdjexPifOg70d/jF4EdWiLmenPGSFhR2lSB?=
 =?iso-8859-1?Q?9op1UgQhyZC5bnk+VrOekhnKuHmrTfxDX8KMOcmW4fevjEkdDTazR2V/Q4?=
 =?iso-8859-1?Q?VFM5X4kxmdM+dv517sFYcmKH7xN0KN94i9Ue+3h06uKReosAiWrFHAdnVF?=
 =?iso-8859-1?Q?PuDxzYL42GgSfffEkGEdnVwSbUo4kOH++IwE2tVVUnGGo73vsaA4oAkrCY?=
 =?iso-8859-1?Q?VjCERo0yBfV712DrWHILUBpzfr2hLBO/wBdgT+udR5zkH8eEug0vx2HdQh?=
 =?iso-8859-1?Q?IIsjK4BBw595c1/FOiSczPJS97sfR2Wq56D45nJaXcPSGmflAzimaMMBRd?=
 =?iso-8859-1?Q?XOJQXdhYYfDqXnm88iHQnPqNUY75Q8WRZ4+S2LyxbCb2hG4M5mxk+UFHEb?=
 =?iso-8859-1?Q?KGF8xbAeX1E2n8DhDj6CeT9M3aCyvs5BXAmdUgHOfl3KPZ81RquAb4+gub?=
 =?iso-8859-1?Q?8dKlT/1Vxc1hUvQPxCzFHlrbl/SAaF3j/pSnSaUfz/cvYExxaKLpakdrXl?=
 =?iso-8859-1?Q?eNSjqLEpcTiHxgIYpegHG3HezBxSK13NaXaA72ZLF4l4bSEyhL65knkt6q?=
 =?iso-8859-1?Q?+H5n0KBoTJoLsP0GM0SrME/XmeREKjOsxzkE4KADrVUF5sESC4Mvn6lQmJ?=
 =?iso-8859-1?Q?RQ8nhZb/X2EDHuLHmcTsZF9dtOHgGi3+Xh+qLS9+gmcmB3ruNdQMDPJrP+?=
 =?iso-8859-1?Q?9rtKtQEvgUPbkd9ElQqpVbPv3BblB8NDhbIks27bCdxMVqx2xCAuGTG8Pv?=
 =?iso-8859-1?Q?s7JLsp80oJNy+gxkoJcg+FeHQ8mj+fKABgr00XDQEW7KPyvXRrJND2hJI/?=
 =?iso-8859-1?Q?IMJVfvZBGMyXVu3MgR9LH31vzymzPDQpnK0tFPnqQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 90df22c5-dbbe-468f-c83f-08dd9db60948
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 07:05:32.1313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7259

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
2.43.0

