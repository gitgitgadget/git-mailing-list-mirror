Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010010.outbound.protection.outlook.com [52.103.68.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813452288C0
	for <git@vger.kernel.org>; Fri, 30 May 2025 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748605037; cv=fail; b=LEALWD3Bx3Z0dN6u5xg4H/RWA3Escj44x+g0OZrP+VK24TtL7BWFxJv+u1Qip0G6sXrcEi5fpBmH2lGPsz2Kx8ae5vxnr6g7FRNKw+XUT8H/JBzueH1d6vtDhX8OyUlEyu6SErRpbpje68tt1RWePzgS5WGeT0eEslk67P954w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748605037; c=relaxed/simple;
	bh=Iqlwo6LNlCKjh/D/XdqKGd8U+VlONb2CiaAjwS0ik5c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jxHwNqarHtCMiMP4UbkV8VQ8+G+iX3dX0gMFqthnw7b5RcY50SGvR2UnBewCVzWlEhPprxlzTibOBXFflvNheI03ejVc0XzNoO0eg9imP4Gb+2/4hPSoPmy9DYPa3O6Nh2uHNVl/IzZIpYqHmJJR1eHp7NqY3hOsfoACWhCSXxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=aRfURbp9; arc=fail smtp.client-ip=52.103.68.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="aRfURbp9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/zIegeVtd/veZgI6vh7Nu9kDicZk2RYlFcj1Z+nUG0al8Uv4VpCz8WqfJAxC1B6hkMJNM6gGPyhzG41jPucgpRmmMNpyaDD2Ymb1MvgwosgRHEWXOOqjdq3eOdXzJnUX0ANeQqNQYefqlYQ2dET/7v7qWwgRJ0FA87V28kqLvO/K6HjyOl3tzJxh9PBN738RuQdnNynLMq980DQQBZOGlLgRJ7/1xTF9zLZ2ynd1CWM3ZUCvK5rMYuiDcy+k6CY4Mja3TuOvY3Oev1HKA38IDn1ls2A5hgPf6lkkdO3XFpbrHHL/hT2l5QvqOrC8dcw+C+Ft7nNuD4QGKwAKdw6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tw9jlKVa8PgZsq6omaLyP1gAz190aAw2zzdjbDBArQw=;
 b=x/r8nzq5djhUTufzmuC5PpMzL0zS/DrpEL/JjKt1T8apw0RWTw1x/Y3w5RzTAOUn/UJA85NSMVCjf/W4SqVZNrATTEHTQhdFvEbaIesiy+nGEa+tPgu2jOMklq1D1yj1/YqkQdN3ABwjYTWG7bwxaGIMhhkNWUQp5Oav4wIhaERBqnSo6jlvqGS6IaoIBGITBMPwebqQZq/gkRhGKDFCpIDnm5/6FoBVd62QsZ0Io9/MJNc1xR73V4QjDbvsKYmLab2hnxwSeXMBZcn+lL8FJrdjJPSEeS1sM5Vvt/p2+h2RP9TzKozXNE0snaAbIh1Ep+jEgLO7B8YDe1ILMXSMwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tw9jlKVa8PgZsq6omaLyP1gAz190aAw2zzdjbDBArQw=;
 b=aRfURbp9b2mMl9IRyzw9T2DuNG/96ScU4dp5eq1hs04QXCT7cLzEs3IdmRdjq9RKqdHW02Zzh0hthd3b5aw2z04lbkM2jV8QUNXnzCjh4cZmDmMn3FRQIdER3pRMajmnRvvGhMIo/UZz6Qo0voyxb6sXiL3sGCWsP9ZP+Uwy96+DB2fsli0rAbxrQIozUMQ6UBfjlRCzSGDweOuXCbp7RI9W+bC5l4YnN1yhxUlky8ISJ4t7lKChlkXxAalccDwfveHk0ucpVZsM+n/AL8arxFd6QHM4uQ1hhsvJNm++9izVlBiLWyg8ZX0SsR1tKalaYVwmzzHNetlbBCZozHBZyg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 11:37:09 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 11:37:09 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Julian Swagemakers <julian@swagemakers.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Johannes Schindelin
	<johannes.schindelin@gmx.de>
Subject: [PATCH v6 1/4] docs: add credential helper for yahoo and link
 Google's sendgmail tool
Thread-Topic: [PATCH v6 1/4] docs: add credential helper for yahoo and link
 Google's sendgmail tool
Thread-Index: AQHb0VctnpOLH7L4UUyo8Yi1sNNwuQ==
Date: Fri, 30 May 2025 11:37:09 +0000
Message-ID: <20250530113627.8639-2-gargaditya08@live.com>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250530113627.8639-1-gargaditya08@live.com>
In-Reply-To: <20250530113627.8639-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PNZPR01MB4415:EE_
x-ms-office365-filtering-correlation-id: 21aaf999-3d4b-4a63-8dc5-08dd9f6e4ff4
x-ms-exchange-slblob-mailprops:
 02NmSoc12DcHu/Dr1OK6cqcYKvfIm6M5ssuS2g8SdpNkKEbHuCmT74OafjWk9vs8zxLTL2R+Mi8qBD06rOIkwDqQa0wdS/quEEz4qKNrjEXU3CD0zRJWDxLa/ztJipkkrwTPSa8dBfX3i+87kEQKshaMzmZeI8+LMN1FhuWz6f6sF2dvVqPLqtVggxDJl1H9NQNBTWssN4I7oreEWn6gTrWbVyH3YKQpBO7pNjEw2CoLYYuHCxOcXN72XM9MYDAxJ9qVTrU8/9OI7QfAuXe23T+iUsf2E/AIq+Ki12aU2Pr1K9mwKw8eawO/EX95bwrYvqEwK6Yi/YfveVYg0RiPdfuUAGRmKYs3J6eKCfZasrvMKv8v4ZrT2TQ3eG2j5cXNh/LItPS3TD536DcOVC6toL9NhIxEPp8tpraOhBfJC8neJDlYIujLasZid6rZX2A27NK0ukZpzaU9bnbN0PUbRadCUTQZZJZILGBu06UJQQLREnSbjAXZEXRaM2stOAmUqr4z3sI6vLvdlKMEDWzNU09wR02RIehwF3tubVyllFhDrDk1RnZiYI+92W1xW4qgdHVl7/vxeaxLXGwhjVGcoC1oJQZuzi049CUA8+p8gjLYbF3G3FXsiUSTI0bHPXf7OpzIllJlTzujF4RhL5sg2XezXYVlvIQdGi8mTaftceH8FtEAcpF8nG+W7NzzPCPnfDV+3hqwkGbzdBSKankDJU/qI8Jda9G4NPr9sWSkcJ8wR3iN0xbHtslxTL1/r+ki
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599006|8060799009|461199028|38102599003|19110799006|8062599006|15080799009|3412199025|440099028|102099032|19111999003|10035399007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Uyi/qz05edqVkStZNfzqmPS4gNclByuahPX6Q+c0D1MXwzgQpdP4+17bXy?=
 =?iso-8859-1?Q?X0U6NxyyfEvDd61vM9TpJZMeV4cYXHRtfw0+69pUy9SYkDEaD42E3+5i8G?=
 =?iso-8859-1?Q?y5+6k0/TyA/VHrwv2tFB4K1wiodzP4hkc5fBnZRW/TOYwK1ZLrHYRKRDxn?=
 =?iso-8859-1?Q?3ViUr0bF86NSJx7k8aROUic5bTR9dLzdjb74EnRFaCPbu7awzXLBkBgZTM?=
 =?iso-8859-1?Q?U0dO8ykGG027RAjhf+TYtjtO6j9xVtYy8sQbG+EcL9/A/WoZbopV3q+A4X?=
 =?iso-8859-1?Q?ke3zDW5hwRayif9fK5OE67GLelSkjuukuOYGfwG6TPLrJRvh5Je37vJrpR?=
 =?iso-8859-1?Q?4XCY/EIi9tUJ3hpbYNJ9dN4fznIUfzQ05LGObopUwFVx8sBajRP4wfTBSU?=
 =?iso-8859-1?Q?IAQCieYIQ6Fk3t1VVTmXAyPqyqr27rogo2OfFe9hMAuy4MY4HKZZDKdLaZ?=
 =?iso-8859-1?Q?q3h2pcZk+s2bkmh3leuBNB91PqKW8rSpad1eOboHHkf2+gd51SgQESxIm0?=
 =?iso-8859-1?Q?krfapo7cHXgpJtQFICrq+rJoD2xetj0XXkWkxqGqUYoUxp4dUp7hRLOvIW?=
 =?iso-8859-1?Q?i7rZe3We4JzvvzmM3yxPAmsImfKhz5GtjCbn+nBOdP+8GenIrEFqjjaSnw?=
 =?iso-8859-1?Q?7x2z7e6SgPe7vu0LezR65kMppBbkpkpFT//HxLPkdlgcf+OOPYFu9j60nv?=
 =?iso-8859-1?Q?GS4icNVZt9hayP1jjzWQ59HFhkgwHRKtjx6CSihh9ghP1U5bE8leba7jWO?=
 =?iso-8859-1?Q?VJSfa+lGXRKxsRbpAP4hDLJMCXYw6PBTLK+spR4y26x9R9MF9ryIMGC36u?=
 =?iso-8859-1?Q?xrG/EvlsKwKrHKqhpaIeHRIL1eLDjey/8KlBd1nneLV5Ry3ISAB1TPxhvK?=
 =?iso-8859-1?Q?uZlSfX5ZDXTNfSUPZkyRBKSlb3jr2XMn71zAfFMjFSoqte+nyqDjUTPUqx?=
 =?iso-8859-1?Q?23G5lLw9arrvN/A1v/2o12nFuX1gsJer8P9BiBUPG0NIXlAuVg5kHXT9cS?=
 =?iso-8859-1?Q?GB++K2Rc0RQKSPPOfksAaisif2Vzbp76lL6iBYMG+YbMoVboWbDe6PHLtx?=
 =?iso-8859-1?Q?t6EZARfCkCP6FWX8SJuisTWdpalgE3zDmazCquPWN4nZO8myo7BKwcQ6v2?=
 =?iso-8859-1?Q?HQM9s0S9q6foCA/7y7StrYfqYDWbeNvRUzVIplHvuOdcBIvyiKEnUoMKIR?=
 =?iso-8859-1?Q?dazwn9+ok7HR91/mG0J7mAhtsrtmQVqqwfi4+QJxARAoslnBj5OE1kK0gu?=
 =?iso-8859-1?Q?EIDi6ZW4J7Dm/uGz+6xUBHwFdaInScf3uyiVn6DDE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3uDn94zFzyMtZ3nuDRzbJCjdW87Uc4tTaZxxwejVhzC1SgzOPub5chM9+E?=
 =?iso-8859-1?Q?v90JCxz500DH+CwceOQvtnop+6AvFSXpcsx402NjtMaDQffqUnfsboEWFZ?=
 =?iso-8859-1?Q?twTRfRaFWxIcFMO0/pEoa3fiIsq+nleYnZ52TO41h+P3HT3KjqxX1pYXzr?=
 =?iso-8859-1?Q?5YfKaxvxdxsdqu4jnyqmxPcMYChxuyUtKZStAYqMJvAq8FKEi6gLBTNGK5?=
 =?iso-8859-1?Q?X+bZoI0ltJVN1up5+25epJWIvTvSBtkPdRfWPEKjciZk6nsXi5Ys36aCTe?=
 =?iso-8859-1?Q?8PRygp2o+xetZ4lvBADacH06SqUcF6fUIoVOukUC4rUNee7o2tRRfFYA0n?=
 =?iso-8859-1?Q?5nzsHbFSyfuzfaKzoLvwQkTE/rlNw4zRrJXKO2MYE8aO8mYdv4MCxwFdcM?=
 =?iso-8859-1?Q?q+1ZlfzuqguVfsEsFLxqrbUOgsHdiUf3huPDT677yeM2MFuKaP2eOj8XrV?=
 =?iso-8859-1?Q?IKorfHU+BTNkEwm6cGjd7+AYcdfx8L69SjAVw/cagUHXTSpQdF35lZQdIY?=
 =?iso-8859-1?Q?8UGv0gKnWlYKUzVxNXIJQy5a+i396CtYht0MGISJkf2hIy56S09obpx+5e?=
 =?iso-8859-1?Q?sYFoR+97rsnzLXCYbYTXnQt3xP6+XtqyRQwih9LhhEX6uKnKNHR1T2Od08?=
 =?iso-8859-1?Q?VA/bWnrnPoio7B/5PEtuVhm8ZynNwhxUflMx/beoyPD4AoAmE8ONgJdsv1?=
 =?iso-8859-1?Q?dMaBNbHqjUt214rhJAamKRfRhlxqfM3zh8PluMZqdz7LXG51OjhyaclKfK?=
 =?iso-8859-1?Q?qG9b4dTAlEgQ31JlD1Tsek+3hBvDL+zcpRDUDwyv0BR/T7BlhimdMYMvVg?=
 =?iso-8859-1?Q?kY1Fi4jcYEJwzctlQwgk0+P3m93e+5z7Cw8EIAPtTD7XnxfaG627NIhBP8?=
 =?iso-8859-1?Q?JD1F/MWgKRLIPyBsXL1XWSclcrX/WLitvBsFCbKNHDuPEK4+lkUYmt7AdB?=
 =?iso-8859-1?Q?CSW9YYY6urJziIc+Soy616RziV94bZeoRqTBILyplgzyLVK04rJdkNKXJU?=
 =?iso-8859-1?Q?BFkWBlZC9Pgt9MEUeY7hILirBhxQSbnJC+pKBvMQE0Cn/ykZU7K+CDE6u3?=
 =?iso-8859-1?Q?wMXzcLs/LQqxpfce9dsBhhKVFHY9xBwlSdXLR68S9HeWZ0skAxhq+MOcBq?=
 =?iso-8859-1?Q?OasZ3OG1IgiMCofAEOEMv9xueBIDOA3ifP7N3HO3AXwycWHmCbvDrO2Yyx?=
 =?iso-8859-1?Q?uoaJ9GEwerdeJLwvknP8HdjhtbjNEbx39Ke0Pgc/9qBpL5osi5qE3A7VCX?=
 =?iso-8859-1?Q?kISyAoMvLjYGHNs4GBbSZyBJPGk/dSIWr76hQA8ik=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 21aaf999-3d4b-4a63-8dc5-08dd9f6e4ff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 11:37:09.2758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB4415

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
2.49.0.638.g03d7d6a772

