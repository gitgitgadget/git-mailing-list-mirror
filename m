Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010004.outbound.protection.outlook.com [52.103.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD8918DB01
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215587; cv=fail; b=n0QphLerK8F5IMDh5DU/JcA4963k6nKdGfU+eDyw/4a0kQoLHaZGqhtQQ+YMc4yz1MlIsskDomJpkRFk0KAqnfVVK0rwUQ4QHRzFXF4h5jPr9OYEvshV0wbrP7H/yEF2wbOyawengrG0n7+ZVGWMCAK3ayyymhc66zTmbNr8NR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215587; c=relaxed/simple;
	bh=jnTIX9syvIESP0Qaj4+300FPxhw7fxIJ8mbjwSAEwtk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C7bzLUoNxfwBP38x+XuOjBZTmX4UEITnfOgDjOI+0690M0MvtZfo0d7r73FByfgstaPvmLYagqnJUoddTyGj3eJFr8q+TXweZMDwTe54KtHCDh2oNjOaTsmymg3CgMuFhxBmT4uQHMWuMpPJf7vtf89lno0ni+K8FBn2g3fA05o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=oGIQtLEj; arc=fail smtp.client-ip=52.103.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="oGIQtLEj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INre4bKSV8MYdzXF7zYOG41E52orG6+JUAFDe3Oph3+XrbdTroWAfTpEeTu++JyEIpbOzLwXS4AxTnzVKEju6lSJnko7/3NtQYSioVEFAnmcbSrb4/+xWQtn/mVfK8aTVmORmiJ/EX6YJ7dB9A9V2bz7sKGLD6qP+9zNcKoDQDHPVKj9y1u+h7OUefaqtnB30LClMo/+IVOEJklPQJhBXy1MVpD7SzPeNHDM2LduGD4zU4sPKK3PlGAPELOyKFYeZupn8Jb4O05jbmF2fs7Qqp9QHgJ3VFLx9ly1SrO7jzGIaW5UX5WwvNLhcXNV5KrS4iWs3BU5YKcBa0SsJycxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bduu+haHrC6UrxtmdHe7ZzvJX5vtSbhllhRzsWLvm2w=;
 b=AR3j9HlPUSx/Ef1mhkR77rVCpzzjVa9YOLqsm2105eU1rPCpE7kL2yrgMAPKa4UWKIBh6iYvKfGQCjZOqnkCn+4IGfGSg3oRXtylx0NuLJy5PD8P12LNbmShs4gNaQn3JeSIVY4hRkaupdUXo8jYpDgYDHN/nCW3jHGAjl+L4iwQaKD24q/H2LUgyWZBIhTsooXpLQOYcSkryaXBj1EZjjux4Ndlgj0vATRZDKuvx9HKh4xCxy7/ysSn43ZuXTR42fOAchKEKoNX8tH/8BGu80nw45adWQ5FJcVzhKEg9NWBvHOtyshtetd1cOiWMAt7fAC22Yacs1xPsqIgTILq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bduu+haHrC6UrxtmdHe7ZzvJX5vtSbhllhRzsWLvm2w=;
 b=oGIQtLEj5sAiA8SCRrXvd26fqEDDKBVtzwXxiJd3KsmItzSV1qeC6joKXw6k1UbwrDzkVYKN+KELjjokthJIWRlupz6itBBx3STrt1rvZJOgSABNkaJhDSwujJAPunG4+WlEtdSnfrjJUosOnIGhtIsg7W4uOnYNOg0ABMogAwPP2HWaV5dWR5xX/EhwOYkEx02MqzyjKxkp2YYPmks45eZIFOyXCn5METD0w8B739gP0jqYQI7O6Ruea+M5y6J9havKFWz9NKi+knbvmT61gFLnnUZBMfIBsmGsnm1MWSbUqtBMAirN1MXaZROKxX/C0Cat8QSJftv0Mx3MJjNAmw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN4PR01MB11173.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 13:39:38 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 13:39:38 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>, Junio C Hamano
	<gitster@pobox.com>
CC: Eric Sunshine <sunshine@sunshineco.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, "brian
 m . carlson" <sandals@crustytoothpaste.net>, Julian Swagemakers
	<julian@swagemakers.org>
Subject: [PATCH v4] send-email: add --get-smtp-server option to fetch SMTP
 settings
Thread-Topic: [PATCH v4] send-email: add --get-smtp-server option to fetch
 SMTP settings
Thread-Index: AQHcFo7ehK/r3v0/AEeQXLLJulGm/A==
Date: Tue, 26 Aug 2025 13:39:38 +0000
Message-ID: <20250826133936.1569-1-gargaditya08@live.com>
References: <20250822151039.36006-1-gargaditya08@live.com>
In-Reply-To: <20250822151039.36006-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN4PR01MB11173:EE_
x-ms-office365-filtering-correlation-id: 8c719562-d930-4a31-b348-08dde4a600f6
x-ms-exchange-slblob-mailprops:
 3tqGmd+bMX7r2I+CN6gWn0QfB8Gt6GD5v3bf30ewlKtKRs7eVctmLcX4RqA6w7clf+mpKpJtND81GtDnWhX0s1pSm+7B8lDeVtj0xt33OBVt6ym6iDhw5JUFUG7kLsA32lRhcxoF1v6GqFdVxd46ItRk/I8QP9b2ds8owjQtpsaOHJDIY2vu9VEIHH4g66rzg7ULXNzsvlcnlXQa/Gn/ZmsmwnQSlMhyQ5u7yZj9nZmfRFxMoHKGAZYbis5JRpu4z7jRxrcx+H4sdq+9bUvjMEJoZmMRU4PAeUgWMgW0/QSk1H/3tuB280ows8V7FwGMayx1FcizQVe2PCJwsw1n3jrXLDXVAWgyqFZ0vIl2ZMatCLy2oINMLx/SEAHtDnL7Dj4xkSH2xlLquBiToMHz8i8/euFxnA0Q2i5mFlKXuV5h7OMr82xinJ61+V5hnSM+sEuzWXmFelZ5Vroj5ifXnTdIFm0gebGM9XZGM2XxMQ+jP6YIJ34MePtRaj+TliPa2NsQr9MJv30KB+caxx1KdhGu893eU1ZMLZ367Nqoe3/uweerVZGrg5B5hk3xHnMZLXvtaDpE2twBWrJ1QC9Xnst8az0R2vXSFMDeZ+uaPvfsNI+gSDc+fnfJ1rC7QjgefwO67trbBAS1ROKqW19BFA0kdJ1dr6SgoG8HtTvLvTiMbQlR9G2R8lWjkAqmvvoSoH+zQCBFoAi3IW5Chh7kTO/xoUwJlDToWl5o+h+ZcGtJNkzFOSmYHSoOp21e4bSquUoGIPpp0InUzss3getro2hYz1KKYvsO2Z6rKH7UHzPJh8uymC/bYMZ5mN1t7/pg5TLol6IdzzJPRIwpl1yqj98XSdMgbSm3514VeOw8E5zMtF+YejmMRcv/NnJP/S9ZEgTSKRxWBwGT1c8fOE/pWs9X0GATZFCEskjJar2VQVzL1MlVLdhFPvlAAGp8GChg
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|41001999006|8062599012|8060799015|461199028|19110799012|38102599003|15080799012|4302099013|40105399003|3412199025|440099028|12091999003|19111999003|102099032|1602099012|10035399007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?r/iAt8F6YXV0sAoAlMf9KjBVz4Mqrk+JgnlI5MtRneCKwcp7yzK5i+U9pG?=
 =?iso-8859-1?Q?hoiRQV9l64JX/1EyFIp8PK2Pj28hzWniKZVfZ11JoeCUTZjUAkJp+rasZ6?=
 =?iso-8859-1?Q?l0T3CXDfZepsN0xAzU8TsmrVXnBSiAvxGlq/UHzBMsiwRhsvpq1PNBCZHM?=
 =?iso-8859-1?Q?DXEHXzOKhjf4lLFsrHj9HKGt+ux5ySklquRJiwtMnP6TJmiQ0836vvmMmH?=
 =?iso-8859-1?Q?u+pBy07P1HfY4tf/eyhsRLvViFldiRbaB44rEu8fvYH+6Zv1oH4Kg5dd2z?=
 =?iso-8859-1?Q?CSCfx0yTLo8/WMrb0I5epOTsIHte+d+X/i6/6PZOfgA90ymAeESlVxGlTF?=
 =?iso-8859-1?Q?Xov6+lrPhdQJL7OBtle+nJu4klRqNDzUuieRyi3/e0zjN03TXfiCiLZIyx?=
 =?iso-8859-1?Q?E7VeS/FhT414bQprw/ke7ceCUn6GdyYtwkanmEefg6NOHNp3ropCDsUeNs?=
 =?iso-8859-1?Q?T0jnGOxMBGjkWfKZ3kvcv6NAgvY/mY1BtvjuTz+EIXZgYbP6KeBOz31CNx?=
 =?iso-8859-1?Q?nrbEjEoN4cr2mmcYxEDnTB8yf4kvUVtLAh8/WJReh3YcTkDaxsBE7jCiSk?=
 =?iso-8859-1?Q?EO5GNLT6iiB1cE6dWI37iaFyOBNBamW9Za1j2ysDL3A3tF17LsalfHTDDI?=
 =?iso-8859-1?Q?ktyXUeQ0+BrA03ZED9m/vrr5X3zQvu7+ozD/K+Ueg62sRyh0qfniLP8OZb?=
 =?iso-8859-1?Q?qC3MHJ0bzQCX/GMTOvTNcxNVI65nP5fOvjbG2Y6FVFu84KveiOblNQb2E7?=
 =?iso-8859-1?Q?wiDhytbwRWiQwX7xCWz8GXmkP1PjBsa05XKBek5L9Z47cfYf3sVIczcsD9?=
 =?iso-8859-1?Q?Wdciy/nYD4/hWalFcYT3CB69Jz5V0BV8WCjypbHGJ8HtHmJXfaojratEzL?=
 =?iso-8859-1?Q?1sb9lT3evJIcYGS0mSiTY0yW2n2d4YwUSuJKb9Hk0NKCR4tDDsDTXn91D3?=
 =?iso-8859-1?Q?AmVv2yxnXW9V1XXhK0VrzfJqyDHh9bW/DSOtEV33qurOoNqV97d5MMWdJk?=
 =?iso-8859-1?Q?zk95W5iCnc/g4DxdEQlbtCaJQgJzbn9AH8BlfC5hcVbhxplXcrvqWZe1pN?=
 =?iso-8859-1?Q?2jKWNVV6ntTYjW2WPRyu6+HofW/GjA2ZdOyr8fqpzt3cdgIS5OIoxz+k2j?=
 =?iso-8859-1?Q?4S5UNWAXAZkO/8Ogkb8Bn+RjSr8K5pnkxP523RlOgEq73jS3CRsIHmx2Xm?=
 =?iso-8859-1?Q?U3xS8G+AW5W3bB+cxAIHQwnldLJJ3UQM24/chDApR/tw/6rcxIlwM0TR+6?=
 =?iso-8859-1?Q?Sm3uUaxebye9THOwYvhSdEW8PfIaju9ZvpCWq7e6qtkZDqeSamjY5bO9B6?=
 =?iso-8859-1?Q?aa2LIU5VPZ8U+cszrtZTWl3NKDVnf2RbUJt4WzaBQgnnV1i8BOL0qBBcDo?=
 =?iso-8859-1?Q?Fdf5k+0jrxexQun90NjiLaijn5snU2PrlccJeHHPe0jPeqvogO4KU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?h6DCpDnvBnGfVwuCxm63Tg8h83gca9j4HOL+W9eKt17Fk6zy1M1npTbmnk?=
 =?iso-8859-1?Q?o2TAzEFePLtyqpoaV6zTQq39cx4wXVn3xeD0NlM9m7snMIIQHbVrXmpGgl?=
 =?iso-8859-1?Q?xOrmmTqIAO2Is/nOAmQI8VRTXLeEuBDL3ItFGTlCoJ28MlbmTDB773YKD6?=
 =?iso-8859-1?Q?+2t9uv46vltfvoQfZ2JYhC8hMNXHM4Bc10KLUHrYppLHKKToPnugZwtpqI?=
 =?iso-8859-1?Q?vlXLW3szbG/2fK7KYPMSz5Th8PC9d6Z/wFA5i+nTva+0DeUb7160kZt1lI?=
 =?iso-8859-1?Q?lOWOpVmz2KcB8rxLhIsC6KF8NPNIpO8rcwKv4/H1R/VeqIw2/X5YU7mlhv?=
 =?iso-8859-1?Q?AK7XmqGC1oKWN0qBf3rBFo6w36B/+vN/T16F78dYzaRakrRFummSwCl8qo?=
 =?iso-8859-1?Q?kGrK+bbveVoXnDPAEyxjvC16b/6KFYXFC9IgW76fAaPcZ/ON4FfsF4ZLRT?=
 =?iso-8859-1?Q?jdnERvoT+iWYuyviKB5hsMspdGIwsz0hT+E2c6MA8PKaET507NvX1co67Y?=
 =?iso-8859-1?Q?qoSuoQR3f81OWmV3ZQKM6lWqgRGg2IaTIzikEsQ8NijR+94wnsgk4OQKWN?=
 =?iso-8859-1?Q?/NdyL02sv6DBRifcDUyj46m5oRIZENoq6mGC9YRdKBY0an7r3nvYF24xf3?=
 =?iso-8859-1?Q?mNhl6oRmMH2YBcJrm4E5UpXrZ5qikPCFBqheeO+17S3irjeHCx+r9hAqGq?=
 =?iso-8859-1?Q?Gp7BcIIYPhW41RjEa2S6EnecH2nCP25J9iaNpV4FGxNXT6ZfMOwUfjIPtD?=
 =?iso-8859-1?Q?nrlvQgn7kl0fyNXGjwzrM3172FkMZI5K700Oyf9SmDznm/WTbkpEyG2Xlp?=
 =?iso-8859-1?Q?98EQmCmJV87V0ctCtLXBUzLRt4B1oYekzolHQk3wjodcWDF8Jy9RFQqEXo?=
 =?iso-8859-1?Q?awhatWby6SnyLstwv0xmH5fDFGRQY2NuPRc0/9j6N4VGCAl2sWMNwo4pD5?=
 =?iso-8859-1?Q?NfofqbzKXjvvewxSyRZZPKWMQmnEHuWFecvBgvVdp//oPPwmjXHuehWuYY?=
 =?iso-8859-1?Q?CE+ibFHLj6b/MBo9l04AKETiMVlRo56hnfA54Vhoij3SOYLDktK773fE3e?=
 =?iso-8859-1?Q?5/JTWfhKFjE2SAqsksHaMpOekern65N0SzqZdN6LN8YxHXw8VEsv2u+ONB?=
 =?iso-8859-1?Q?pDCpU8DvaTGTTu+VwqASxk4UsNtS18ccdIpGvQY1Zwm2iPWR/IGUps5LTa?=
 =?iso-8859-1?Q?NEovxx5D916TvtfTlS9qUuh/sVpz+4qZK2NniTQ1MGVK1iGqV08PwlKeqp?=
 =?iso-8859-1?Q?xYLu+sIZf9dTqEudQ+i1p05/5yEQrqdudT3faJyls=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c719562-d930-4a31-b348-08dde4a600f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 13:39:38.8210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN4PR01MB11173

Autoconfiguring SMTP server settings is a common feature present in many=0A=
email clients. In order to get the correct SMTP server settings easily,=0A=
this commit adds a `--get-smtp-server` option to `git send-email`. This=0A=
option attempts to fetch the SMTP server settings for a given email address=
=0A=
via the following steps:=0A=
=0A=
1. It first attempts to fetch the autoconfig file from the email=0A=
   provider's autoconfig URL, which is typically in the format=0A=
   `https://autoconfig.[domain]/mail/config-v1.1.xml?emailaddress=3D[email]=
`=0A=
   or `https://[domain]/.well-known/autoconfig/mail/config-v1.1.xml`=0A=
=0A=
2. If that fails, it tries to fetch the settings from Mozilla's ISPDB at=0A=
   `https://autoconfig.thunderbird.net/v1.1/[domain]`.=0A=
=0A=
3. If that also fails, it falls back to checking the MX records of the=0A=
   domain used in the email address to find the SMTP server. It can be=0A=
   useful in case of emails with custom domains. It attempts to guess=0A=
   the correct domain for the email from the MX records, and repeats the=0A=
   first 2 steps with the guessed domain.=0A=
=0A=
This feature is heavily inspired by the autoconfig feature in Mozilla=0A=
Thunderbird. A detailed documentation about how thunderbird fetches the=0A=
autoconfig settings can be found at:=0A=
=0A=
https://www.bucksch.org/1/projects/thunderbird/autoconfiguration/=0A=
---=0A=
=0A=
v2: - Improved checks for valid email address.=0A=
=0A=
v3: - Try to get settings from email provider's autoconfig URL first,=0A=
      followed by Mozilla ISPDB, then MX records.=0A=
    - Add support for another variant of autoconfig URL:=0A=
      `https://[domain]/.well-known/autoconfig/mail/config-v1.1.xml`=0A=
    - Added support to list supported auth mechanisms.=0A=
    - Added warning if encryption is plain (unencrypted).=0A=
    - Suggest user to read the docs for OAuth2.=0A=
    - Give instructions on how to apply the settings.=0A=
=0A=
v4: - Fix typo in git config commands=0A=
=0A=
 Documentation/git-send-email.adoc |  51 ++++++-=0A=
 git-send-email.perl               | 219 +++++++++++++++++++++++++++++-=0A=
 2 files changed, 266 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-ema=
il.adoc=0A=
index 5335502d68..daddaae36d 100644=0A=
--- a/Documentation/git-send-email.adoc=0A=
+++ b/Documentation/git-send-email.adoc=0A=
@@ -13,6 +13,7 @@ SYNOPSIS=0A=
 'git send-email' [<options>] <format-patch-options>=0A=
 'git send-email' --dump-aliases=0A=
 'git send-email' --translate-aliases=0A=
+'git send-email' --get-smtp-server=0A=
 =0A=
 =0A=
 DESCRIPTION=0A=
@@ -505,6 +506,14 @@ Information=0A=
 	address to standard output, one per line. See `sendemail.aliasFile`=0A=
 	for more information about aliases.=0A=
 =0A=
+--get-smtp-server::=0A=
+	Attempt to get the correct SMTP server settings by entering an email=0A=
+	address. Once an email address is entered, it will first attempt to check=
=0A=
+	for an autoconfig file hosted by the email provider, followed=0A=
+	by attempting to get the correct settings from=0A=
+	https://autoconfig.thunderbird.net/v1.1/[Mozilla's ISPDB], finally fallin=
g=0A=
+	back to the MX records of the domain used by the email address.=0A=
+=0A=
 CONFIGURATION=0A=
 -------------=0A=
 =0A=
@@ -512,6 +521,41 @@ include::includes/cmd-config-section-all.adoc[]=0A=
 =0A=
 include::config/sendemail.adoc[]=0A=
 =0A=
+GETTING THE CORRECT SMTP SERVER SETTINGS=0A=
+----------------------------------------=0A=
+=0A=
+You can attempt to get the correct SMTP server settings by using=0A=
+the `--get-smtp-server` command line option with `git send-email`.=0A=
+It will ask you for your email address, then attempt to get the=0A=
+correct SMTP server settings for that email address. An email=0A=
+address may have more than one configuration. In that case, any of=0A=
+them can be used.=0A=
+=0A=
+For example, an output with email `someone@gmail.com` yields:=0A=
+=0A=
+----=0A=
+Configuration 1:=0A=
+  Server: smtp.gmail.com=0A=
+  Port: 465=0A=
+  Encryption: ssl=0A=
+  Username: jhk@gmail.com=0A=
+  Authentication: Normal Password=0A=
+  Authentication: OAuth2=0A=
+----=0A=
+=0A=
+Here the value of:=0A=
++=0A=
+- `Server` corresponds to `sendmail.smtpServer`.=0A=
+- `Port` corresponds to `sendmail.smtpServerPort`.=0A=
+- `Encryption` corresponds to `sendmail.smtpEncryption`.=0A=
+- `Username` corresponds to `sendmail.smtpUser`.=0A=
+- `Authentication` indicates supported authentication methods.=0A=
++=0A=
+=0A=
+This method should work well for almost all large email providers in the=
=0A=
+world. If it provides invalid settings or cannot retrieve them, contact=0A=
+your email provider.=0A=
+=0A=
 EXAMPLES OF SMTP SERVERS=0A=
 ------------------------=0A=
 Use Gmail as the SMTP Server=0A=
@@ -624,8 +668,11 @@ https://metacpan.org/pod/Net::SMTP[Net::SMTP].=0A=
 =0A=
 These additional Perl modules are also required:=0A=
 =0A=
-https://metacpan.org/pod/Authen::SASL[Authen::SASL] and=0A=
-https://metacpan.org/pod/Mail::Address[Mail::Address].=0A=
+https://metacpan.org/pod/Authen::SASL[Authen::SASL],=0A=
+https://metacpan.org/pod/Mail::Address[Mail::Address],=0A=
+https://metacpan.org/pod/Net::DNS[Net::DNS],=0A=
+https://metacpan.org/pod/URI::Escape[URI::Escape] and=0A=
+https://metacpan.org/dist/XML-LibXML[XML::LibXML].=0A=
 =0A=
 Exploiting the `sendmailCmd` option of `git send-email`=0A=
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=0A=
diff --git a/git-send-email.perl b/git-send-email.perl=0A=
index 437f8ac46a..7d7fb52d6a 100755=0A=
--- a/git-send-email.perl=0A=
+++ b/git-send-email.perl=0A=
@@ -32,6 +32,7 @@ sub usage {=0A=
 git send-email [<options>] <format-patch options>=0A=
 git send-email --dump-aliases=0A=
 git send-email --translate-aliases=0A=
+git send-email --get-smtp-server=0A=
 =0A=
   Composing:=0A=
     --from                  <str>  * Email From:=0A=
@@ -108,6 +109,7 @@ sub usage {=0A=
                                      input according to the configured ema=
il=0A=
                                      alias file(s), outputting the result =
to=0A=
                                      standard output.=0A=
+    --get-smtp-server              * Print the SMTP server settings for a =
given email.=0A=
 =0A=
 EOT=0A=
 	exit(1);=0A=
@@ -222,6 +224,7 @@ sub format_2822_time {=0A=
 my $force =3D 0;=0A=
 my $dump_aliases =3D 0;=0A=
 my $translate_aliases =3D 0;=0A=
+my $get_smtp_server =3D 0;=0A=
 =0A=
 # Variables to prevent short format-patch options from being captured=0A=
 # as abbreviated send-email options=0A=
@@ -501,6 +504,15 @@ sub config_regexp {=0A=
     if !$help and ($dump_aliases or $translate_aliases) and @ARGV;=0A=
 die __("--dump-aliases and --translate-aliases are mutually exclusive\n")=
=0A=
     if !$help and $dump_aliases and $translate_aliases;=0A=
+=0A=
+my %get_smtp_server_options =3D (=0A=
+	"get-smtp-server" =3D> \$get_smtp_server,=0A=
+);=0A=
+$rc =3D GetOptions(%get_smtp_server_options);=0A=
+usage() unless $rc;=0A=
+die __("--get-smtp-server incompatible with other options\n")=0A=
+	if !$help and $get_smtp_server and @ARGV;=0A=
+=0A=
 my %options =3D (=0A=
 		    "sender|from=3Ds" =3D> \$sender,=0A=
 		    "in-reply-to=3Ds" =3D> \$initial_in_reply_to,=0A=
@@ -565,7 +577,7 @@ sub config_regexp {=0A=
 my @initial_bcc =3D @getopt_bcc ? @getopt_bcc : ($no_bcc ? () : @config_bc=
c);=0A=
 =0A=
 usage() if $help;=0A=
-my %all_options =3D (%options, %dump_aliases_options, %identity_options);=
=0A=
+my %all_options =3D (%options, %dump_aliases_options, %identity_options, %=
get_smtp_server_options);=0A=
 completion_helper(\%all_options) if $git_completion_helper;=0A=
 unless ($rc) {=0A=
     usage();=0A=
@@ -757,6 +769,208 @@ sub parse_sendmail_aliases {=0A=
 	exit(0);=0A=
 }=0A=
 =0A=
+our $doc;=0A=
+=0A=
+sub fetch_config_domain_autoconfig {=0A=
+	require XML::LibXML;=0A=
+	my ($domain, $email_enc) =3D @_;=0A=
+	my $parser =3D XML::LibXML->new;=0A=
+	my $autoconfig_url =3D "https://autoconfig.$domain/mail/config-v1.1.xml?e=
mailaddress=3D$email_enc";=0A=
+	my $xml =3D fetch_config($autoconfig_url);=0A=
+	if ($xml) {=0A=
+		$doc =3D eval { $parser->load_xml(string =3D> $xml) };=0A=
+		return $doc if $doc;=0A=
+	}=0A=
+	if (!$xml || !$doc) {=0A=
+		$autoconfig_url =3D "http://$domain/.well-known/autoconfig/mail/config-v=
1.1.xml";=0A=
+		$xml =3D fetch_config($autoconfig_url);=0A=
+		if ($xml) {=0A=
+			$doc =3D eval { $parser->load_xml(string =3D> $xml) };=0A=
+			return $doc if $doc;=0A=
+		}=0A=
+	}=0A=
+}=0A=
+=0A=
+sub fetch_config_mozilla_ispdb {=0A=
+	require XML::LibXML;=0A=
+	my ($domain) =3D @_;=0A=
+	my $parser =3D XML::LibXML->new;=0A=
+	my $ispdb_url =3D "https://autoconfig.thunderbird.net/v1.1/$domain";=0A=
+	my $xml =3D fetch_config($ispdb_url);=0A=
+	if ($xml) {=0A=
+		$doc =3D eval { $parser->load_xml(string =3D> $xml) };=0A=
+		return $doc if $doc;=0A=
+	}=0A=
+}=0A=
+=0A=
+sub fetch_config {=0A=
+	require HTTP::Tiny;=0A=
+	my ($url) =3D @_;=0A=
+	my $http =3D HTTP::Tiny->new(timeout =3D> 10);=0A=
+	my $res =3D $http->get($url);=0A=
+=0A=
+	return unless $res->{success};=0A=
+	return $res->{content};=0A=
+}=0A=
+=0A=
+sub extract_base_domain {=0A=
+	require IO::Socket::SSL::PublicSuffix;=0A=
+	my ($host) =3D @_;=0A=
+	my $ps =3D IO::Socket::SSL::PublicSuffix->default;=0A=
+=0A=
+	my $public_suffix =3D $ps->public_suffix($host);=0A=
+	return $host unless defined $public_suffix;=0A=
+=0A=
+	my @host_parts =3D split(/\./, lc($host));=0A=
+	my @suffix_parts =3D split(/\./, $public_suffix);=0A=
+=0A=
+	# Find where the suffix starts in the host=0A=
+	for (my $i =3D 0; $i <=3D $#host_parts - $#suffix_parts; $i++) {=0A=
+		if (join('.', @host_parts[$i .. $#host_parts]) eq $public_suffix) {=0A=
+			# Precursor + suffix =3D base domain=0A=
+			return join('.', $host_parts[$i - 1], @host_parts[$i .. $#host_parts]) =
if $i > 0;=0A=
+			return $public_suffix;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return $host;=0A=
+}=0A=
+=0A=
+sub get_mx_base_domain {=0A=
+	require Net::DNS;=0A=
+	my ($domain) =3D @_;=0A=
+	my $resolver =3D Net::DNS::Resolver->new;=0A=
+	my $query =3D $resolver->query($domain, "MX");=0A=
+=0A=
+	if ($query) {=0A=
+		my @mx_hosts =3D sort { $a->preference <=3D> $b->preference } grep { $_-=
>type eq "MX" } $query->answer;=0A=
+		if (@mx_hosts) {=0A=
+			my $mx_host =3D $mx_hosts[0]->exchange;=0A=
+			$mx_host =3D~ s/\.$//;  # Remove trailing dot=0A=
+			return extract_base_domain($mx_host);=0A=
+		}=0A=
+	}=0A=
+	return;=0A=
+}=0A=
+=0A=
+sub parse_config {=0A=
+	my ($doc_parsed, $email) =3D @_;=0A=
+	my $config_num =3D 0;=0A=
+	my $smtp_encryption_config;=0A=
+	my $smtp_user_config;=0A=
+	my $supports_oauth2 =3D 0;=0A=
+=0A=
+	foreach my $outgoing ($doc_parsed->findnodes('//outgoingServer')) {=0A=
+		$config_num++;=0A=
+		if ($outgoing->findvalue('./socketType') eq 'SSL') {=0A=
+			$smtp_encryption_config =3D 'ssl';=0A=
+		} elsif ($outgoing->findvalue('./socketType') eq 'STARTTLS') {=0A=
+			$smtp_encryption_config =3D 'tls';=0A=
+		} else {=0A=
+			$smtp_encryption_config =3D 'plain';=0A=
+		}=0A=
+=0A=
+		if ($outgoing->findvalue('./username') eq '%EMAILADDRESS%') {=0A=
+			$smtp_user_config =3D $email;=0A=
+		} elsif ($outgoing->findvalue('./username') eq '%EMAILLOCALPART%') {=0A=
+			$smtp_user_config =3D (split /@/, $email)[0];=0A=
+		} elsif ($outgoing->findvalue('./username') eq '%EMAILDOMAIN%') {=0A=
+			$smtp_user_config =3D (split /@/, $email)[1];=0A=
+		} else {=0A=
+			$smtp_user_config =3D $outgoing->findvalue('./username');=0A=
+		}=0A=
+=0A=
+		my $auth_mechanisms =3D $outgoing->findvalue('./authentication');=0A=
+=0A=
+		print "\nConfiguration $config_num:\n";=0A=
+		print "  Server: ", $outgoing->findvalue('./hostname'), "\n";=0A=
+		print "  Port: ", $outgoing->findvalue('./port'), "\n";=0A=
+		print "  Encryption: ", $smtp_encryption_config, "\n";=0A=
+		print "  Username: ", $smtp_user_config, "\n";=0A=
+		if ($auth_mechanisms =3D~ /password-cleartext/i) {=0A=
+			print "  Authentication: Normal Password\n";=0A=
+		}=0A=
+		if ($auth_mechanisms =3D~ /password-encrypted/i) {=0A=
+			print "  Authentication: Encrypted Password\n";=0A=
+		}=0A=
+		if ($auth_mechanisms =3D~ /NTLM/i) {=0A=
+			print "  Authentication: NTLM\n";=0A=
+		}=0A=
+		if ($auth_mechanisms =3D~ /GSSAPI/i) {=0A=
+			print "  Authentication: Kerberos / GSSAPI\n";=0A=
+		}=0A=
+		if ($auth_mechanisms =3D~ /client-IP-address/i) {=0A=
+			print "  Authentication: Client IP Address\n";=0A=
+		}=0A=
+		if ($auth_mechanisms =3D~ /TLS-client-cert/i) {=0A=
+			print "  Authentication: TLS Certificate\n";=0A=
+		}=0A=
+		if ($auth_mechanisms =3D~ /OAuth2/i) {=0A=
+			print "  Authentication: OAuth2\n";=0A=
+			$supports_oauth2 =3D 1;=0A=
+		}=0A=
+		if ($auth_mechanisms =3D~ /none/i) {=0A=
+			print "  Authentication: No Authentication\n";=0A=
+		}=0A=
+		if ($smtp_encryption_config eq 'plain') {=0A=
+			print "\nWarning: Encryption plain is unencrypted!\n";=0A=
+		}=0A=
+	}=0A=
+	if ($supports_oauth2) {=0A=
+		print "\nThe SMTP server supports OAuth2 authentication. If you want to =
use OAuth2,\n";=0A=
+		print "please review the git-send-email man pages for more details.\n";=
=0A=
+	}=0A=
+	print "\e[33m"; # yellow=0A=
+	print "\nTo apply the settings use:\n";=0A=
+	print "  git config --global sendemail.smtpServer VALUE\n";=0A=
+	print "  git config --global sendemail.smtpServerPort VALUE\n";=0A=
+	print "  git config --global sendemail.smtpEncryption VALUE\n";=0A=
+	print "  git config --global sendemail.smtpUser VALUE\n";=0A=
+	print "\nOmit --global to set the configuration only in this repository.\=
n";=0A=
+	print "\e[0m"; # reset=0A=
+}=0A=
+=0A=
+if ($get_smtp_server) {=0A=
+	require URI::Escape;=0A=
+	print "Enter your email address: ";=0A=
+	chomp(my $email =3D <STDIN>);=0A=
+	$email =3D extract_valid_address($email);=0A=
+	if (!$email) {=0A=
+		die __("Invalid email format.\n");=0A=
+	}=0A=
+	$email =3D~ /@(.+)$/;=0A=
+	my $domain =3D $1;=0A=
+	my $email_enc =3D URI::Escape::uri_escape($email);=0A=
+=0A=
+	# 1. Try domain autoconfig if ISPDB fails=0A=
+	$doc =3D fetch_config_domain_autoconfig($domain, $email_enc);=0A=
+=0A=
+	# 2. Try Mozilla ISPDB if domain autoconfig fails=0A=
+	if (!$doc) {=0A=
+		$doc =3D fetch_config_mozilla_ispdb($domain);=0A=
+	}=0A=
+=0A=
+	# 3. Try MX record lookup=0A=
+	if (!$doc) {=0A=
+		my $base_domain =3D get_mx_base_domain($domain);=0A=
+		if ($base_domain && $base_domain ne $domain) {=0A=
+			$doc =3D fetch_config_domain_autoconfig($base_domain, $email_enc);=0A=
+=0A=
+			if (!$doc) {=0A=
+				$doc =3D fetch_config_mozilla_ispdb($base_domain);=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+=0A=
+	if ($doc) {=0A=
+		print "\nFound SMTP server settings for $email:\n";=0A=
+		parse_config($doc, $email);=0A=
+	} else {=0A=
+		print "\nUnable to find SMTP server settings for $email\n";=0A=
+	}=0A=
+	exit(0);=0A=
+}=0A=
+=0A=
 # is_format_patch_arg($f) returns 0 if $f names a patch, or 1 if=0A=
 # $f is a revision list specification to be passed to format-patch.=0A=
 sub is_format_patch_arg {=0A=
@@ -1760,7 +1974,8 @@ sub send_message {=0A=
 		}=0A=
 =0A=
 		if (!$smtp) {=0A=
-			die __("Unable to initialize SMTP properly. Check config and use --smtp=
-debug."),=0A=
+			die __("Unable to initialize SMTP properly. Check config and use --smtp=
-debug.\n"),=0A=
+			    __("Use --get-smtp-server to get correct settings for your SMTP ser=
ver if needed.\n"),=0A=
 			    " VALUES: server=3D$smtp_server ",=0A=
 			    "encryption=3D$smtp_encryption ",=0A=
 			    "hello=3D$smtp_domain",=0A=
=0A=
Range-diff against v3:=0A=
1:  63f9c628ac ! 1:  7638f71514 send-email: add --get-smtp-server option to=
 fetch SMTP settings=0A=
    @@ git-send-email.perl: sub parse_sendmail_aliases {=0A=
     +	}=0A=
     +	print "\e[33m"; # yellow=0A=
     +	print "\nTo apply the settings use:\n";=0A=
    -+	print "  git config --global sendmail.smtpServer VALUE\n";=0A=
    -+	print "  git config --global sendmail.smtpServerPort VALUE\n";=0A=
    -+	print "  git config --global sendmail.smtpEncryption VALUE\n";=0A=
    -+	print "  git config --global sendmail.smtpUser VALUE\n";=0A=
    ++	print "  git config --global sendemail.smtpServer VALUE\n";=0A=
    ++	print "  git config --global sendemail.smtpServerPort VALUE\n";=0A=
    ++	print "  git config --global sendemail.smtpEncryption VALUE\n";=0A=
    ++	print "  git config --global sendemail.smtpUser VALUE\n";=0A=
     +	print "\nOmit --global to set the configuration only in this reposit=
ory.\n";=0A=
     +	print "\e[0m"; # reset=0A=
     +}=0A=
-- =0A=
2.51.0=0A=
=0A=
