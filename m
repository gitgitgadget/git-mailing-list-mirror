Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010013.outbound.protection.outlook.com [52.103.68.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE5AD2FB
	for <git@vger.kernel.org>; Sun, 18 May 2025 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747553660; cv=fail; b=qu5hc75mrQ1Us35aL9Tn5aZ8WEJhCkFF6OQv/PeV3fTFuehsrbq7t6x1OOs9yLA7c2zof6SnxQSEMW9kb/3XM7onLVMSfI+akek0rJjyd50z2qfBoKqFyeWsoEpMmTfLb5LZ1lQmM/n0A8uzsKE2DgxaNaVNNq5i4oHSOgZ3rXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747553660; c=relaxed/simple;
	bh=rikAWKZCOJTfrUH3mZ4IU/oG0o5PY3SLXV09UQQA9q8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J/V3e1n63hB51SiuvUUlfnxVKYqvtf3daJsHzOwsxbT8kPK5kaYmEb8A+IZyOJZZ+6AweuEMIvuiJkL/ec8LcuRUzLXIEUTnBoV6N9KCuwF9j0E9bwXZix3yTyk8NVha36bojg7oNleSGHwgV4biHFCEdJNETR+n3EcrEtinJRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=As1vGD9V; arc=fail smtp.client-ip=52.103.68.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="As1vGD9V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JT3bLt4zn4nPrV+H4jBsAXco6nfBJtr92n+KJP9DwXe9pLTJ9V4AcIJkFsSgeUi6Q+RYDkpyGIp97vukBjrI0KTmA2cHEndm1IScKlSr64Iw/zx/pjKC0SS6BOg4F/wsmSXxnMzf3I66KJxDd6szTkESY/iEl92NJ2oyxVKm+6KSDE90JKrNZn7QXwi7zeWvVer3z1jr9hLkEOWASnUODSruGBtkiXGZL77J0hGRpe97mrJtzcljgQw4MzFR9rBQn5rLzSY1FHhy7W/9UdVjam4eBuoamcU4mRW49DuaqBq61KyQ8LBmVfafsNfQC1XIk3fOHXN9E9FAs4sLLjK1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AIJ+GgTxEN1SpH+YzVAfl1wQle9uToxlrXeM/OW87U=;
 b=Wqdu3NrQVo8x1h4zyZAXuqWt5esoKoDrOAE8DSLZQXYZf8ZFkxkwtnRwpBLnMjV36a+TcNKC/N+uKp6winRPDkzblYc7qyJ2YLEu2j6jfv8R1aP5vaPO9alRB73zp8s4HLGYi6LUDM4IqQmcCyLJSDez1LArbmDvNJYKU1hz5Jw2/DaYYHZ/VOwcaemScaWl/oGepmoSkeqabbxCuXRaRLYiJ/EGxRgucn4PvVt6ZEW0NAChslLcj1fp/BtNIO72xNvI4V61pANpCD/5TL+sR6e1ANN4JrnvM8SeaPrD1KhjW09cgEQbnV7NaU1iAarTAulXGvzZ7dkEfsx7uGwuQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AIJ+GgTxEN1SpH+YzVAfl1wQle9uToxlrXeM/OW87U=;
 b=As1vGD9V/SFB64ybPUoyfe0coxssGl2GMAgOQAgl8Zf7KfQgGH5O+cdlh9n14LNgGhYnBGyyGKGCn8CcEuBXNSWDD4ewiyx1YR9WA37EvQfEeG24R+t12pgDxJwAq/TVewMxOynI7Y0qtTM0sBosMiZ9Q4IEh4obABC4DaOOtaVjsdYnqU99DZG8T+OClQcms7/A9lP1SkAPWGESXWNyv9DrCkK6vveUQOZbnmOKnRU/2J9NU1NTpdqxyaTFf+H5IELEsWvBp5Cik9lHDDwlGBONFnbjsG6ekVBN2wxjIuwTY+nHcxpsBnV5dhDUey2b/yakZE1NH5G8B8xMfI53IA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA1PR01MB4418.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 07:34:13 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8746.030; Sun, 18 May 2025
 07:34:13 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 0/3] docs: update email credential helpers and improve
 formatting
Thread-Topic: [PATCH v3 0/3] docs: update email credential helpers and improve
 formatting
Thread-Index: AQHbx8dA8MMRE3x7i0aA4L4Dn6nlcw==
Date: Sun, 18 May 2025 07:34:13 +0000
Message-ID: <6D57A8EA-FDE8-42C9-9541-7B97C2DDBCA1@live.com>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597D6BAA98013269897A963B890A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3PR01MB9597D6BAA98013269897A963B890A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA1PR01MB4418:EE_
x-ms-office365-filtering-correlation-id: c916496d-31c4-4f8e-523f-08dd95de62f6
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|19110799006|8022599003|8062599006|15080799009|7092599006|8060799009|21061999006|461199028|102099032|3412199025|440099028|10035399007|34005399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vcF8RYTEz7qwh9PRDR5VmBB/xvsdPOhbjP6jUO3z/IOb5TOhEcLZrnX1u9ro?=
 =?us-ascii?Q?vcWsNXbFpS1qILzoqPj2PuAfd1jmAbt0R4w13EariqESBJWSVsOoXFOBYyPW?=
 =?us-ascii?Q?cYMZQfQ/ewv4sScY7SKfe22uW756l3/GYrCQFDggqxFec/mgK6id+9SalbET?=
 =?us-ascii?Q?kkqB70qSf2MIHv3SCFOEfdEahEF3JwtC+rkIlj1ErCnltpZi3aDHBZMOW4MU?=
 =?us-ascii?Q?TOaqS6M1Nzp7JBSpqzz+8sZpNAsmFWCw/weXeQTvPNgPyJc+lL7J/IzkMr+0?=
 =?us-ascii?Q?wFOtY3+4m9W/B54hXAaIXflhKXXhtcW5ssbmG0KuiWN9125Uy+uPoRXfw+NT?=
 =?us-ascii?Q?0iXmuNlEYufm+jJuBK/JfItMFObEMCHFiZE4tDNgCRth60WMojy5ZJlJSkeU?=
 =?us-ascii?Q?mJ6vRMz1AE4FKFJ1z0WOZFyjx/W4ChVmjwKotxgQYCgBgvYVWGmiIAkGABRr?=
 =?us-ascii?Q?AG2eueB1vV7eb5tLwlqeaVAAvEILiNTFsJKcT8BwUIPutDGHbw0iJpAJuWjm?=
 =?us-ascii?Q?C4I4aqPxRRURt4VB9QlP+UeLYd0/8VW11RyzZ0fCIwurC05RaNJUuV2SUzzl?=
 =?us-ascii?Q?+HzHPDqRkPjRhCdEzaLaZ9ItFH67/vk3A7rhV3Psx4Xtgd+zTIfG+56Pb8Qj?=
 =?us-ascii?Q?L+4U+LqQiGBcqyz5MhFkLjdJwMU2uOFvYjGTWlmNdmkSImVX3HJvSfiw09rQ?=
 =?us-ascii?Q?rBLP/wq5sasVmUH9A72sMVwTtC4cH789RalL6ON6yJsFzmk/C86xXLObM3Xx?=
 =?us-ascii?Q?SQC7d7VuoPlcf6gGXANZTWXdM3CeS29OzeItAw/vjTbDp+qhujxW8X5EgM2Y?=
 =?us-ascii?Q?dJaS5Qj6gdD/BUcY3OIidLs6UuaKCa3dWoFRN2aZdV0aG1zv3qcSjfu5U8Yk?=
 =?us-ascii?Q?TruEI69Efthe4ZgIN2bqcpE5flxcUlSQXo4TfWzog+VK3Tr5tX6aJRYSI6C9?=
 =?us-ascii?Q?gz85NHYDuMb0MrucBIICQ/WbIAIMWIUWbVBOMDY1fdP+r+66axWvcs7dP84i?=
 =?us-ascii?Q?7lT9QknaqWRfG7enVLld0sErboNKquciY459jkD8YcNmlrKmVpmjEKLsRg4/?=
 =?us-ascii?Q?AChD9kMBIYeV6kAOrn5r6J1zA+0zJ9bkA9uOr8nPUJdNCjNwE2Rw1VOXngqj?=
 =?us-ascii?Q?wtGjtQPilMj8hTpvLTcneYZ0BnL1yqQFqdtOnLEzJQjhGdrKNN9Cx1rCbXiJ?=
 =?us-ascii?Q?8RSHN4sm6ZPg0ZyNZUXXS4g+IhIY4PvE9K7fBli8nidXGcutgQFAAbm+X5pr?=
 =?us-ascii?Q?unHaLh5topJsJhqsjR9G0cIaLrVsuQzH8l36ns8yPDD3vhXLo1DRusGIk1qU?=
 =?us-ascii?Q?GjE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?raFyimxhHc5fIt6jWmJUuDruHCLCfLf/scSKVh+kupv+MPJSb6LT26wUcjBV?=
 =?us-ascii?Q?f/AUQrVFP+rBZUfP8jP9FaI8cQqwm2jD4IH3bPrKTLcXibh1QbzRealT22Nb?=
 =?us-ascii?Q?RphOfiRipdLWY0xrlkgKhyEKoCCw/EvdRdDNsgsp/C3MCOn5V67x8hpI/P4L?=
 =?us-ascii?Q?GeMkjVpooc96I+qwquzywIVcms5YN38ItoMa/sHR91S5v3t4VOqJg5DdXjf2?=
 =?us-ascii?Q?u474D1pClkEhXhUVyNy+WRbr1rUtrQu1ddgl7XthQ+bUpJtco2lkJRdKU6eW?=
 =?us-ascii?Q?bh7e38tcT+WnsNPw37wKXyjX5g+antUnNTXXNJvOAmYGeTpJik2TPw+b6NfW?=
 =?us-ascii?Q?2eY+d1xIdRjOR7n7dyG2ed4IM38BWuK/xm6BXlGPj8x1yahNUNjs7pQj0EHp?=
 =?us-ascii?Q?htS/cpzqEhGpFcf+jh5I0GFm2kSlXFQz2tL4olRmQhxVyK7TKElT9tdbFI34?=
 =?us-ascii?Q?w9pKHDS4BI9X9qYNrtpZXojLVxga1gVPCDX57t47oCJRaHE+f3Q8/KkaH9h8?=
 =?us-ascii?Q?I7Ub/zokiCu8AfyH32qPlqyq2NK5k3o+zPwiNFYR/GEunIRs6Gbh1shM+9Xk?=
 =?us-ascii?Q?OcBkEgm5IqVRK2r73N+VXf8zxNB2yhgtdNc3FrIDAYmePZoYEu6+wLdSLJRf?=
 =?us-ascii?Q?wEGf9pavlxcEyl0+gw+in7rphA3HZDyQoq9FS9X0Ur+2ZJpC6SHXEwPsMmU6?=
 =?us-ascii?Q?XVwOSEH+xztas0R17wcLZgF3e3QRK2CnHwjvdN+o47kQNoSfR1DdFP2h3zrD?=
 =?us-ascii?Q?dIGr5MvpPIrfRkgP/Tk4Bzt4P8jC//eEpsKc4k2QqxFV8sHLPcApr4IVWRao?=
 =?us-ascii?Q?ZhGv7t22SXpehjGl/ocnHLwSiJ1xor2ItVsb4j2o4v094l+tg1qUuztvW29E?=
 =?us-ascii?Q?ISkT2DCAqKzRKPmm9HopjKFkJr+65TaA7W84MDyLmb+bn+EOUm47F0WADE66?=
 =?us-ascii?Q?rAkX2gPVkGWCK7vY7yej1+2VBQkVDlrafcAhnfTMWVjGkTo3/hIrscD9RrX6?=
 =?us-ascii?Q?2T32rrBmEXCP7Urxl1th2W0BqTjeTx4EOqntXg3s88CUkQSLrHibLSyT5P8u?=
 =?us-ascii?Q?jqUPG4TNsUtz/b+TIN0vIgYB2IMEuNEQwlVzP0ujc2FFuikQen6v7mfemWen?=
 =?us-ascii?Q?++7wRoRZxClcwy8OpwgJ//bRJT7YveX2Ct8I+8+qc4DQgxEoGUsB5eTJZsFz?=
 =?us-ascii?Q?Jr0s9lPHfH7i9fVKThB26m6NHlz0q3BYKtJPzm4GG6Z4cOVypKIalYzBzvq3?=
 =?us-ascii?Q?4lVox2UIsbZ2E7QB2Du76SJA5FFm6as38QuNyIrzqYede2/1fIVuVjQoS0DA?=
 =?us-ascii?Q?SvA43dGwOMMq2FS1B5CwdHUd?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7C345A72EB3BD9449672516E275673E9@INDPRD01.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c916496d-31c4-4f8e-523f-08dd95de62f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2025 07:34:13.1937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR01MB4418

Hi all,

This patch series included three patches:

1. The first patch adds a link to the `git-credential-yahoo` helper for
   Yahoo accounts and links Google's `sendgmail` tool as an alternative
   method for sending emails through Gmail.

2. The second patch improves the formatting of the `git-send-email`
   documentation, making it more readable and consistent.

3. The third patch removed the email credential helper links from the
   `gitcredentials` page. The links are still available in the
   `git-send-email` documentation, which is the right place for them.

Detailed explanation of the changes has been done in individual patch.

v2: Removed instructions for Yahoo SMTP server since I've realised that
    Yahoo *was* a popular email service. Also, the instructions were
    just making the docs more crowded. I've also added a link to
    Google's `sendgmail` tool in the first patch. The second patch has been
    added to address the issues that came up here:
    https://github.com/git/git-scm.com/pull/2005

v3: Added a patch to improve the formatting of the `git-send-email`
    documentation.

Aditya Garg (3):
  docs: add credential helper for yahoo and link Google's sendgmail tool
  docs: improve formatting in git-send-email documentation
  docs: remove credential helper links for emails from gitcredentials

 Documentation/config/sendemail.adoc |   8 +-
 Documentation/git-send-email.adoc   | 187 +++++++++++++++-------------
 Documentation/gitcredentials.adoc   |   4 -
 3 files changed, 102 insertions(+), 97 deletions(-)

--=20
2.49.0

