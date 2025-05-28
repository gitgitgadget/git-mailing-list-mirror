Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011034.outbound.protection.outlook.com [52.103.68.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFEB20F087
	for <git@vger.kernel.org>; Wed, 28 May 2025 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748415950; cv=fail; b=F+eIRea7mNw/MrbCxdRiBKOHng3CEvzU0NHNerOI3UoWmdYJO4XF0CxA7PLV8gjRzSbKp45LBWHNI8FTqX2Ikc6lh2bIKDCrvDKftul9XFVUHXZNuCodGKIMsmhS9mioQEIEZuMouux1zeN1C/0g/QOWsT2JtOxMi9xcreMnrWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748415950; c=relaxed/simple;
	bh=aUVMnOAzud9LH2Q9Tk9JxjkrYN7Omn+6IGcAasFQeBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WIsmwHrMkPWZYaemHu9aMLuGRTVX6UgC7zuY2pKLXFKljkfe/BxDbNYPBQrocfG94o/I63ZH2VEEgLBCVZ2APkETPjl7Hyg2ZmnYgfFObHpG+jIN0UhmnH3VtLs/UK5rFgdchyzrnftyLIz0NUHb2XRNtarX6shY3Zng6w4sM54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=N9YeZNAX; arc=fail smtp.client-ip=52.103.68.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="N9YeZNAX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8vm3m0rmOJQ2dDP7a2zuj7PLaaHtZk3htnc8POsmvylFwcaT6HmRjpHfIdcFYl4Npcn0pDxujyDKIukPJUh6bB1WAVCGT0nJWlzeocV/yT0paKqFDCN8rOHE4niTlxWmtGEYATK0XguwChZckibPn18EViUtpkz9wO94jv9pyk2a6sN8mBuUVCn86Y8sagstf31xAh7V1Dh9zJksS/GL6XF5Z5DqW8mk7VZVp46U97vpV7Khg9Cci4vK97+lgSbLo9nyUSQhmT2uAbUi1mYuXuDnUwDcclkMPWPwNMsyzlDsAa3jJSSjmLlHdrdQO2uRDtYhJckHQxtTaCWai6L6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTIjTiipZD5wxFZJq4OkaWvF5eDRMhOrCLnvLF1o0yA=;
 b=uBd2P0Ooj68CFNkyJfS+fg6Q8UuEYDc8m4ibJITRLFnYc90ra+4I3UfHd9wRnx9k7Q9cFHPRxUtg9Jo/9lwpiJKAfCm9L8kDPCCT50jDOho5Y1bF73vXP/XzYfBYeJWPvT6LNdIM+i2sTImnKDPiCshhrxdo5rqRQGo10jrhAConKZoQ51SxlNrsBgKbInpnMLRxZAXi5EoXTImurK6z4XAJ2QK2eLG8fBuMXZhMWdfISXzB0EHJ9U3XN7d2MmhrLpqUwkzMM0fcZWtzywjt0SUpe4RbfuidCDurnJs4LIhUN86xQer0/qN+fftHk+R65Vx1/IvGgx30SYGjalVgWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTIjTiipZD5wxFZJq4OkaWvF5eDRMhOrCLnvLF1o0yA=;
 b=N9YeZNAXj3f70mksxQqaiyTF0XiTzDOApcInE4D+cSSecdvpLOO9iAkZmAfIZrYJSi0+meKRj8CixWoYiOlqRntMMtSmeoIGctRsgzY7kwlHdXumSRcgrCgDFqfl3OilxK6JUbQ+igL2xpDE1ZH3Ih+BUpyTUv0ENIBcTS4J8JUEua9QOSw2mcpkC2y0aVjgR33ujVKwhzOY8eyk1HS/X9t04/y4YDBnTfsnK7TXS+4Z3Rh9TWWJV3szerfGQmZ2pHlbdPj1r53fLLa/xAGUtqE/8Fobq0xzEjPKpmWOd2X9u0iLct+yxKtSLJ6YiwLT7FSpJeEWRouaZ8AJAouj1g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNXPR01MB7259.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 07:05:36 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 07:05:36 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Julian Swagemakers <julian@swagemakers.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Johannes Schindelin
	<johannes.schindelin@gmx.de>
Subject: [PATCH v5 3/4] docs: remove credential helper links for emails from
 gitcredentials
Thread-Topic: [PATCH v5 3/4] docs: remove credential helper links for emails
 from gitcredentials
Thread-Index: AQHbz57pEQFx2l80j0C5HHS/PLgE4g==
Date: Wed, 28 May 2025 07:05:36 +0000
Message-ID: <20250528070521.17379-4-gargaditya08@live.com>
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
x-ms-office365-filtering-correlation-id: c0c0ed4b-41e7-467c-d8b7-08dd9db60bc7
x-ms-exchange-slblob-mailprops:
 laRBL560oLR0Ybdxcp7KTbjbpYD2CblC0MDwbM6L//+1lh9tRMjZsNymaznHO+yMJFvuNIqVQBcJ5z8jDffhWnnp/4XVnZWkZTvZSCEY3BEFnqWyfvbWtNMf+ISpN3vqZMN2fM4Z2Scf5hKWPis6f4/ULbt3d9Dr6uuOjGMUIrWkuoX18ZraMYYhq4Hj9Z2+kzJM1Zp1oeHKChvwjfq26dJrUga6PS90/1dAnx+MMc3D8e0OddAqM8Qrk+tRNH7vlg1j29FYjW/0tWIG6ZPWjnX+Pv/1wtvXbTAfARlvuyEARXYlO416DgcpDDpEdgRWVXRrooxMhJBitvLUjOSdXIYzwKv+NvG6Tthvi47hyvA5rzCof/CHm2BXrZMU/olfVOulKQG63kGQrS/ljw+qVeDqSqHzeF8ivNofHBEVHGPVhNlS2q2ZDvEClWaxGNcNIojh5UwAqdMpyQQUQQx/IPHMDHeElHnc04tM0A7I9SiUpGifMcrhgtvxiVR5hx9+mKltlqJWGtZ8vEs1RSjevnRGTWawoKuKhq636YTCLXrqVB4TgnQfOD8Ba95IGevYeYGFhMXkTlYr8rPEruwytNojE+0TiI/IOZJD5aBbkwnCJjD7ozqAGaNn6qiY8Zh5fiXtiMCDBse7Cve3sRrBeXTu+3JRuVhEyM2ar5YP9fqrv/RFdRazb2pzAcxE8dE1mJ7JZvvUzJXcZlPZOvfbBarQonbPcO+m/skF7i6SXWDkxYy8X2Qt+xtuT3sG+3bAMvGFGrf83TO7MDaRWH81+s/VRY6tsIxE
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599006|19110799006|15080799009|38102599003|8062599006|461199028|8060799009|3412199025|4302099013|440099028|10035399007|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?e76ZnyGIYTpMAcZBRkLyiBMm7pXLHtY1JO/MtHi7ky5gz0bA1YJfsYSZHw?=
 =?iso-8859-1?Q?wnskUorphGrU6ZT65UCHA9tSzvrmrUzdp+cRLbVqJlc7IGV/4uDPjilgXS?=
 =?iso-8859-1?Q?zXV9LiBJD8RasP9DBtCCYGG8yI0eb+dETv1styElOIzq/uQ02e3qk7Dhgo?=
 =?iso-8859-1?Q?dVrn/xPcBVQB7RTlj80gdwUFOO5r3j+kBbOXJYGgELifXzQVDMgM4t4wr1?=
 =?iso-8859-1?Q?RHf9sTnThzaZ+3XfxxC2lwNZzaCnmwm7J2wrPpj1r8MkZUF1ToYUibTLPj?=
 =?iso-8859-1?Q?dY8qqS9eiJcnKkXLFJoVcbpqrP8G/JPQnfTSdAhfc/B4EGAMWPCErZlbtC?=
 =?iso-8859-1?Q?MS+Y5R5/9G1ZAi+ytt/Ri7dkWkrgc5pvFR3pTCJFo68GbE7GXZKIX4OokZ?=
 =?iso-8859-1?Q?h9veGrI22RwYv/2A8VlH/9mItGChfoq3wfRt1kN0gotjzUtJRSNlNbvqfG?=
 =?iso-8859-1?Q?hxMxmR8cFFOWpayebKA0RvTGVErYpvSa8NpX17mSksF5MJnarq7uNWI2X1?=
 =?iso-8859-1?Q?2Z0Q46SWGFtMgQcClVgdoH+avGBatgh/xCSFQVgJHl8KUCo4lUKb/XXHVJ?=
 =?iso-8859-1?Q?Mez18XM1z5ta3CzbB3A+416+2RvqmYOJ1iW843+bUHWI385XwO9TepI4n4?=
 =?iso-8859-1?Q?4AwIgsyd41ZTXn0SjLwvlzv59ZBzR1BJ6lM5G4zU3ar9PbrW8h8eeVKI/n?=
 =?iso-8859-1?Q?G5Jqjs+VthvoYgDoqYuuJQUSEnpYNKHNL+hmV4swzZ7F5bSAr1/wrCOYqd?=
 =?iso-8859-1?Q?hGK2F0QL0PhkzqzqXB7AOS2Z6EAJ8Ygs9/KhDJjx+8J7uKA5USqDmNec1r?=
 =?iso-8859-1?Q?01Ixsjs/mwoRhVv45cMRrfwGXPa+dlJssisfxMb+XjRh/Vo+1LgTLOeHrc?=
 =?iso-8859-1?Q?ydy9Sfc5yotPBTi9onGaeiX8FgeXFYgvK8hlmeUOOCCg9xSnsAmmknK+X3?=
 =?iso-8859-1?Q?lKUhWwcrACRQU8a3sHxHaYy9254HdThVO3SSn81Uiw/tpnzedpwVZnkWNi?=
 =?iso-8859-1?Q?rPk/mLcbJ0bJF7ONO76WTeUHYrqolgGx0SzlASIeJQ6iPVOy5LS4Fmxitt?=
 =?iso-8859-1?Q?epqM1zPllk+ZQdbjRrbgEgn7NaQRj/mD1u+z24KguYLBOZIc0CVy5Qu42r?=
 =?iso-8859-1?Q?ks97K1rvugDGWzGLbKo/qIs6dMW1rLZ770rijhkctHl/fw9A24bsgiCvUR?=
 =?iso-8859-1?Q?GRFBPVbA83Go/krNON3VXd8u/+qPCncffAaPILwq8qPH4Cpb3CCzctBmQv?=
 =?iso-8859-1?Q?fxwyMsPxkqU8Ltpd0gNbv28Tow7r+ml62b2JEsaVZEjL8Lmy2e/rhm2gAO?=
 =?iso-8859-1?Q?laFP3cbDeRH0BKDZKH4Lli1Yjw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2mUrIb4tDQr75NaZjzQXoKNrZ72c9soC2NDsGYWUj1XCCvwW+RvDCWh1Tf?=
 =?iso-8859-1?Q?0ZVA7ktOlOveVJL6sufn+9Lejo1i86SQ8H45tzbBk3UXKri57LElBxo5vj?=
 =?iso-8859-1?Q?gf9RpmvR5qBU9L5MhSW2bEEQRdCcFkNUUpkSO8EnG28pTDYh10Cm9Gol6d?=
 =?iso-8859-1?Q?XKrLJDi3GcmR+oQIWLKio+qaslLP/a3kGejln/haHUEr0ePzFshTvhx2Wm?=
 =?iso-8859-1?Q?Z9/a3wJFRR0lfgvwGv8Yfo+Hb2f+Ry5zJ404PsGCKQDzeafzQxhyRVWNuy?=
 =?iso-8859-1?Q?VlWpvhpY8gE1YHJAEUUFedN8YLjExaD8WZ5w1WncY7sD9NTyo3FTfKyltb?=
 =?iso-8859-1?Q?UVRCq4/LCA8EW5tXFhOlP/M+smIP0X6hu6fCB1Vb1X3PcmRJCmbYts1WjQ?=
 =?iso-8859-1?Q?g5C5BHyjBO1aQldfVFiEnASiBk5dEqXhGlReGtI5L8HSkrwfxp3fK9uBtt?=
 =?iso-8859-1?Q?/9NoU1ekTwgt41X3Aj3dc7dhuQyCs2+qdieLRVpzDTT+aMvAdAc/M89RFQ?=
 =?iso-8859-1?Q?+5qoJO+ei2A/49J1OnvIFK22134ab58x8QDu7oqCs3BAPTRGJA+wBCYbnL?=
 =?iso-8859-1?Q?NMtH1ek4K3Jp+gVyU/b+TdoOtyNbcwlIK1EzRNeUJAXdrDUMrz8SVaXh96?=
 =?iso-8859-1?Q?QxfHkGOwdUaSwE+BQh2hVVPC8ZZoiqUMWV+hTwhJ2SF4ZBKtkn9JDioIe7?=
 =?iso-8859-1?Q?s//gFUoT+mbtjO1pSkjs9qmOxDW2cEHfUgnSvUdP5rrs6gRwSm1XeyGsMB?=
 =?iso-8859-1?Q?UG2fU00UJSD2eEd/NlG5u7UwwYfV3YPLABL9pSeKaZSfiol8yCgxaVLHXx?=
 =?iso-8859-1?Q?Lv0r3beLbMxF6DUS57aacqCf+xnxFT5HfnqJSKiZ6tOevf7Y7Bs+Z8j6OR?=
 =?iso-8859-1?Q?rBHVcJfrhhfJMXHT7lYM1k3RnHLwPMGCQCTvHvfXns90FBA6+osTuda1Dw?=
 =?iso-8859-1?Q?SCgLMRcn+085wjaz2N0m20CA/yBBtMLjFFhAUWl1eTVsoUFin3xDdkpcMH?=
 =?iso-8859-1?Q?EvpiF5gKj5+6qSmD3896LDB5xYXpg3g+P5Xuggq5n8LCR6wxlsBoBTmBqL?=
 =?iso-8859-1?Q?KhhrlBmfzO6799Jp+vMvFw38IvSWvPfMiREJ38y7zeBAkvW5EiSVkLFJDg?=
 =?iso-8859-1?Q?O8yVRz7xfUKFnDYxYsdIvLetLD9BXxuJg1fbS2UlmRyYwzKa47BNCei4Nc?=
 =?iso-8859-1?Q?GZoPCiVWR4bZKfGftDwCTQ8ydZMrTGtOBo6ECdxLqZvZFe7+epx4mjUbu0?=
 =?iso-8859-1?Q?6YfVrUbPcC+qSLnnHEq+2VnpHIPKf94R8VyMThb1Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c0ed4b-41e7-467c-d8b7-08dd9db60bc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 07:05:36.3482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7259

In a recent attempt to add links of email helpers to git-scm.com [1], I
came to a conclusion that the links in the gitcredentials page are meant
for people needing credential helpers for cloning, fetching and pushing
repositories to remote hosts, and not sending emails. gitcredentials
docs don't even talk about send emails, thus confirming this view.

So, lets remove these links from the gitcredentials page. The links are
still available in the git-send-email documentation, which is the right
place for them.

[1]: https://github.com/git/git-scm.com/pull/2005

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/gitcredentials.adoc | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/gitcredentials.adoc b/Documentation/gitcredentia=
ls.adoc
index b49923db02..3337bb475d 100644
--- a/Documentation/gitcredentials.adoc
+++ b/Documentation/gitcredentials.adoc
@@ -133,10 +133,6 @@ Popular helpers with OAuth support include:
=20
     - https://github.com/hickford/git-credential-oauth[git-credential-oaut=
h] (cross platform, included in many Linux distributions)
=20
-    - https://github.com/AdityaGarg8/git-credential-email[git-credential-g=
mail] (cross platform, dedicated helper to authenticate Gmail accounts for =
linkgit:git-send-email[1])
-
-    - https://github.com/AdityaGarg8/git-credential-email[git-credential-o=
utlook] (cross platform, dedicated helper to authenticate Microsoft Outlook=
 accounts for linkgit:git-send-email[1])
-
 CREDENTIAL CONTEXTS
 -------------------
=20
--=20
2.43.0

