Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=193.56.114.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794908519;
	b=5S9AnJ3MkbKbYafy1NIebGGkrdbfJ6wiH24vth6sBYINpCDwmUAEbKsYReiGy0akZUW5
	 vG07/+XM9+Fe9C8mCcjiYPhwbvm60Ip3Di7pMuwQWX1rJSnFwribp9TbvpJFQ06/mw3o2
	 oLfYPnps9obHvGFI4w4WycxMOSa04g+AdY894x+WNxmLmdW1thbODytizhJgZXrzJeH9u
	 94AlZg2jQOQ6bzRbJB3dVsifcUycOcEKdCIUChE8Mw/JOmNaUwTqG7ot/vNQjifCkWnZ1
	 O8CzY5Ut+juqn0BOri/ixpgUijhuNy8PsP1BicustpjqEYLGWUpBLPgg8bHOWjkpb7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908519;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-MGA-submission:Received:DKIM-Signature:Received:
	 Received:From:To:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=d2m4knx8mHjXrU7P19oYDuYnEAv6j1plKeXztQvHW1o=;
	b=2LefkLrub534ZR934kKlcKCGxf+MHZiojeK6mgQpbQTX9byFf1mU/6XpRHpTUUeU99QS
	 OR/u752Yx9oep3vZb1SZGx5MB3wOUREyUCdfWt5bLySAEj4CpKgefDQ5P1dhNLjcODAM5
	 0J/prHG/Am/qpI3/QFKWCM8cMRaleSjx08JDq5IL9EUl+IfudCuKByg7tZlR0WpO2NQnJ
	 5YBlv0CY2n+xn+G9MyL16nxICfk/zB/4URlvWWu1aIqZyX5t7uIMPGewQhSpnB7whm/2r
	 yl58TWmXEp2gukCqOtOX/pdDyk1a1LuCW7KOJ9MiUaFLp/VIbdghf7AiiI2zUcuG5Cw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=atos.ai;
	spf=pass smtp.mailfrom=atos.ai;
	dkim=pass header.d=atos.ai header.i=@atos.ai header.a=rsa-sha256 header.s=mail header.b="hebhtcN/";
	dkim=pass header.d=Atos.ai header.i=@Atos.ai header.a=rsa-sha256 header.s=selector1 header.b=NxXTC1OQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=193.56.114.176
Received: from smarthost3.atos.net (smtppost.atos.net [193.56.114.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284BB606A323
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 09:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 284BB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=atos.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atos.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=atos.ai header.i=@atos.ai header.a=rsa-sha256 header.s=mail header.b=hebhtcN/;
	dkim=pass (2048-bit key, unprotected) header.d=Atos.ai header.i=@Atos.ai header.a=rsa-sha256 header.s=selector1 header.b=NxXTC1OQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.ai; i=@atos.ai; q=dns/txt; s=mail;
  t=1794908517; x=1826444517;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=d2m4knx8mHjXrU7P19oYDuYnEAv6j1plKeXztQvHW1o=;
  b=hebhtcN/glGcGtNLACUdojT8jbYkeYhbE07udDzmOHEaeIIyZDNSBoTi
   pCCQ/WvUHWAobU7AXZoE67dOWUfKluVNzK/ftzXhGQzulwVbtXeNJUF9A
   m8i2dEQtSgfdQnQHtyshcjurzoD/FqnLnUYo/XXyPLjHNyet3QYhHOdyU
   pL1ljnPcvQ/Sw18P9So+6qpMdpd91VgvBCKMrWTfoise48NyMbFO7DJ2i
   Q/xInwWOQ3+mV8TBQaAmyU8jM52MApBROn2++WJkYkpwW1KCE/HZ9gBAy
   K3M9J0GqvlHaXvA24WGQVQs5U11LWJpFV2IaFE5lbZzAcv0S39PjbfIo9
   w==;
X-CSE-ConnectionGUID: KCJNbWNnR06OYPCNevsEvA==
X-CSE-MsgGUID: vGHOFgMdRqeECti9AYW8kg==
X-IronPort-AV: E=Sophos;i="6.27,218,1787004000"; 
   d="scan'208";a="881759433"
X-MGA-submission: =?us-ascii?q?MDEqieP3gLoZ1KFj+AYDNZGzsiGd4HhwSEjKFx?=
 =?us-ascii?q?06Lqwtc+KZQhonealPJZNdc/yMnX9i0xQ7frhKjyNj4OveDUYrM/Vn92?=
 =?us-ascii?q?SO7zQ0Eh2seMt1yHvdGv29j26RhpyrZxL2C8eRkHhQmcBw5PyZxNnmum?=
 =?us-ascii?q?5I?=
Received: from mail-duzpr08cu00107.outbound.protection.outlook.com (HELO DUZPR08CU001.outbound.protection.outlook.com) ([40.93.64.71])
  by smarthost3.atos.net with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 17 Nov 2026 10:41:48 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8f8qLoZay1hSaKlQ3z8jF7hzeLNaTzETdimosLn8C0RKP+5v5fzSuJS3qI+SQ3VWKg5bTEeYKT0QN238SPEWkG2JJL/fcMwFjAI4xF/P4LAfz06/fquQlq/L4Xrfv5o7nGSnct86rC+PDkse5k25cInCJZPedG2YAE0jty95IIYkghP1RXvRC472NjjGViGLZ71i2GkhGttd1pV0H3KmstOn8yqxrbShdjZ62cs33kxKzJkGhBwlJzBIV8til6wKw/NTNhOsrwi+O1DdUTMjquGjA/ijbYpg+EVZCBZctK2yrv7/mO59bSAlZl6rlZJWXBhOV6H9RpSiWVOHaoe6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2m4knx8mHjXrU7P19oYDuYnEAv6j1plKeXztQvHW1o=;
 b=tPO3cgYTcAcE8DjXWM2mZFCGsBskFB23qcv4tgEe02PL8LcK22Y7E4yhoPraYLZbjR39WYe0KTa1T+kTMKbA3n0D7pKd9gH9yPzNEbT8xzYUlatj/0MBaHNgqoUL3Sw5hkKNpYmjNLs1MJEZDTiEA6xvjr02WD7kp5G34G8bnQCB/TJa3+JF8u8WbqNYsIDII+Spyc6VzA2uXT7l1idzw6DKZLP7/YkEx6YJWbP2EfNnvKADOfF1xqy7sQJkx0tZIRDPePxptYNBnvA7fZmWb6Wxam0SphCmycr3siNpZ9LgTGFYZvF8Lpo609xSxKN3ZC+XkhTXoMTqWTzkn68E5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.ai; dmarc=pass action=none header.from=atos.ai; dkim=pass
 header.d=atos.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Atos.ai; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2m4knx8mHjXrU7P19oYDuYnEAv6j1plKeXztQvHW1o=;
 b=NxXTC1OQPweGAUBlHHofwF9nSErJox7aUTM3JRi6HBkEvdkZY+4HxwSJUerENia7jQRUA5/TR1JORb7h0shauuU1J1iFaC0nkU4AFAKBht5YtXTAtH5d+uYA7BmD2duSpTMCdv+RZskAsSXcRusxI18xGhOojhbM6EDRmWS24bBsUbpWIdfbj39e/m37/YKZIbxEVqMBuUX+HWNvFUbzhhDFOQBDTbdByxUC+eyleJpguArD4N1ENvB6wS8iIagF+A2GPWFbxwODsDiY0cNIsV+OAKKNvp6iOAj3dp1JOdIqx/hP2XsCItHCSkVEX6EtHV0FlG22DKvfk/edRG+9DA==
Received: from AS4PR02MB8336.eurprd02.prod.outlook.com (2603:10a6:20b:517::6)
 by BR0PR02MB958055.eurprd02.prod.outlook.com (2603:10a6:2c8:5d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 09:41:46 +0000
Received: from AS4PR02MB8336.eurprd02.prod.outlook.com
 ([fe80::b6b2:4b44:41b3:f6ef]) by AS4PR02MB8336.eurprd02.prod.outlook.com
 ([fe80::b6b2:4b44:41b3:f6ef%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 09:41:46 +0000
From: Richard Kerry <richard.kerry@atos.ai>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Email formatting (was RE: [Outreachy] Draft internship proposal:
 Improve how command arguments and options are scanned and parsed)
Thread-Topic: Email formatting (was RE: [Outreachy] Draft internship proposal:
 Improve how command arguments and options are scanned and parsed)
Thread-Index: AQHddnfcjU6SX07T20OsqlzXeQJ5bg==
Date: Tue, 17 Nov 2026 09:41:46 +0000
Message-ID:
 <AS4PR02MB83363999DA64DD82F6E25FB0EB7B2@AS4PR02MB8336.eurprd02.prod.outlook.com>
References:
 <CACWAS-UqbkgfzsJ2283=OgoUHRs-FeRNYc0zkBR2y0XD4jTWsw@mail.gmail.com>
In-Reply-To:
 <CACWAS-UqbkgfzsJ2283=OgoUHRs-FeRNYc0zkBR2y0XD4jTWsw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=e5097b32-8d91-4f1f-929b-669147322779;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All
 Employees_2;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2026-11-10T16:25:14Z;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atos.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR02MB8336:EE_|BR0PR02MB958055:EE_
x-ms-office365-filtering-correlation-id: a41304c2-5c44-42a6-e416-08df448eff37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|23010399003|3613699012|38070700021|10067099003|11063799006|5023799004|56012099006|261021121427099003|261022115727099003|261021135927099003|261022113327099003|261022105027099003|261021123027099003|261022075727099003|261028144727099003|261026140227099003|261026121527099003|261102123227099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 aexiZA/Z15GZdKZxqgxmnXS3p2UqFAUscmG2xBKDNoX5NBLkauVoO1iRZ0O35+JatWhWxsw1GwgcQRp9rV3qzlQxxckslFsMR7sKcnwlFLg3her/1Cp46ANppv6TGJoD5AxwypP1sR73l5wjYta/1PnqoccY3ci64oHl/6AVWOWkeolEAvb/wrEOvqtWx9qvbLJDZ8gfZM/tAU9QhKCeBDZuis/9wWaswLHQ+bMHzcgvIwgIX/u01MMCdVclecNX+D+DwZYQFJ5MjMeOqxBwxMxBqvArAx7vDodrs2dRSGPw+8ui1aiSyP/iH+t1anKsK+NvhwTzJjhNIGufbn+Nm0T5w1oY7fKQX0vktKcAgwehIiOEAiPzsv0kZTm76A+MAPp32bo8on0Q6yRSvh6ubhWFve3IHGR1srpPnr9TE4fIXefsbtB+RabR0eSGuGKKvI6o/aiusc3/9dxuewltyLtJ9DQLoGFO/mWHyMy5qLQQS/Aeg/Q83klyvR+koMLpt3nhvNuAOm2ttQISFQ85HpltQDK3HxugRhw/XwSmpvA5dwplRnXrZYrD98EBHgfWkmjfSaWrhP/qBW1TavBWwGFZVZb1MZSUwxnRwy4Ed7LGYeBpE+Hu8VqPEEXNcaXmAllhdncyexQtSOFqQasTpijrKkulVTzgaGgCBCQDIs62bmwAajpbPV2nbadkCqjV5uTTuwBusOAvfd4fACZXGEX1MVlHnWU7tGJTesTfmfnbh1Ee45fKTUppmYmJ53R7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR02MB8336.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(23010399003)(3613699012)(38070700021)(10067099003)(11063799006)(5023799004)(56012099006)(261021121427099003)(261022115727099003)(261021135927099003)(261022113327099003)(261022105027099003)(261021123027099003)(261022075727099003)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zYBEhauaND20Ukg6n5Q2lZZl+9wFkXv7GvHY5wYaVg6/xR5k7AF+u0mCNd?=
 =?iso-8859-1?Q?Z4FpHExnTRZJc6Gu3pwkBXoTTu6jUJuJecUgDb3bKl7er/hIWuMw0WJln0?=
 =?iso-8859-1?Q?shPo6ZCXSZArXo5NDfWKF/LlN270+ftUAq/L01CHaVT+LpMqsyIuCL6+Za?=
 =?iso-8859-1?Q?yEFL6F0zntYdJFSjyx1aoTm2Nl7hVwfhH7k7Q5cMTFxP0ebzMXMq0jVgaw?=
 =?iso-8859-1?Q?kLiKfXUgg2M2uaEyNvLgBuda3UmlJuxmODGMe3jJJByxKMQlMvjyeWsMLK?=
 =?iso-8859-1?Q?7+crZYzCBxhg9JT/CvZ38GereRSor5xQzFpCbp3rJ2rwTo7DjUzp4xUFbY?=
 =?iso-8859-1?Q?dcq3RCEuuaR73I0bdnAA806K8RL5U3x/zehckfhq9qfMzmXbKh1w9NBibi?=
 =?iso-8859-1?Q?H06X7Q6bUYdqhinER+yANRT2fjmUGCKDAuUjfw/METeOIMsKDmKmpaEaHt?=
 =?iso-8859-1?Q?vE8B4Ll8spMpygKD6GUbzhF+WrtAeHJsDTT6fcW3B0idR7qXetJGkTs9lw?=
 =?iso-8859-1?Q?tqab66tJ49AukwfW0nxzaj/fzfCzwWOg7DQZ37tDvNDiSgzyBONz9N9Z0s?=
 =?iso-8859-1?Q?IAYTS1DYUgM6hvUkArt45i3p0NgqcB5TJ+T1jP82/rm9h9huAwkBdRjCe6?=
 =?iso-8859-1?Q?4X9t75CMsjvC5xEHYt/R4OIZ5/RaATW1KlIcYlNM3kRU++WPL9XiXpOkS2?=
 =?iso-8859-1?Q?klEATSwICyt1ZUigfRlRIF3M3DPryNfn6vSI85IxBdWXk1awvW8KpmhpvS?=
 =?iso-8859-1?Q?ZYzOKhDKYWT0wU5Osugk0IXVvBV4i3MDkBYB82CJ8i8Hbj/zRSE3pMjpIl?=
 =?iso-8859-1?Q?sRiA00JqsnH+HDpGq/YTq0ak90BKIBYu1b9FmrZ3oBza7j/Sg02a/YqB87?=
 =?iso-8859-1?Q?tELlswQ7KmmyR/JBabo2PqZmKJ2jIJvrYZmG/pt0XmqRcRpftVgKUR/+kA?=
 =?iso-8859-1?Q?DbZ9fYd9PKWK7OKx89VUxYjOpd/XuP+2RAtvKsH2BoBOu6NEkB2y9ias54?=
 =?iso-8859-1?Q?h0BitmvXBjvCmYBGEGxB5Vsh/aV9B8g3dfO1C6Cnkwmv5pg3Wpnle3lh5J?=
 =?iso-8859-1?Q?1j01zavyOCMFhGPqJfqshWr3TuUSGgoC6ZegaQbEhG9jc291uErCAM9LXC?=
 =?iso-8859-1?Q?dbPm8+yThTexDoOiysLXQdf6vN+nHESKeV3dKYcxC/tpoxg8+LpgutEa3e?=
 =?iso-8859-1?Q?bj3rRjAMVVkpKkR1BOyPU3RtCAqAwULWuLdIsPZCQiW73Uut21ItdYtZg/?=
 =?iso-8859-1?Q?E5Af+Ju5JRpLYaUJnul6JFyjvBV/12n7aq7Vy/6ifUU9i4b0XUc+43nvPx?=
 =?iso-8859-1?Q?sefu8+Sl1AUaULZ2s6iZyGzadV90yQ4XesUleYqi1n8sMlCVWxjiA/g19G?=
 =?iso-8859-1?Q?BcbBoQrIJ174PbcDbEA+siRRuGUI2bj6oOzA39AzIMTUNcTfN+iIBlmGWX?=
 =?iso-8859-1?Q?0b4Fwmdy7L5pGHn4resIDAfV2j+zhsN7X15r1gCmWRmnl4mlFn7XSUqm2M?=
 =?iso-8859-1?Q?lS841wg8r/dXT1yhw8grHg1/nau6uYPaV6x+JRVjx3wU811enRMK2I0iHq?=
 =?iso-8859-1?Q?F5Vvjl6Bnz73+AnrmR07vF/aXAQYT4Qx8WNhoGsOMEO2ByXPSPzOQaZ5Gt?=
 =?iso-8859-1?Q?1aeGBY0dh6gWr0qeewjRMzwnTZyxRC31k2W3w97ZCmWN3CCRpfe5Wz0KQU?=
 =?iso-8859-1?Q?FlYC6PJ1NLbNkfcD3TvBrudjWtlH4GGXMx2RVMo/KwOjF5X1X4SV7LZwoR?=
 =?iso-8859-1?Q?58vERSwFkYSyG6VxEES2e6DSK+qvYMbO3zeSridcbMY7ObPj1pP6dTwTrl?=
 =?iso-8859-1?Q?sqZzvfz4bQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	xQ6+IRyDXKwukU7ndTXOErD84ZbTQF5FZVnDms92KFgi3x10Fh0qWX+wwDzegzakUE6okpzUjfAG0oiUj3iwH4n9XT9n4qNWGgXu0Mxe1Q+gucD4rnQ0m1zkOL8eHy799K/ZAbCwuiN5OVq9aq039p+UnIPmsze/wcO0m1MEV4+xAPmDgeh8Q8t4JMBIxMQ2F0rdCZUh2clXETc99ApCkLTLC9wWUY54CxkDGmsDftP+sAuSz7MeEhNAqgIk5F1l+DR23uZpG7vhdUPP03YorDCgcP+j1YnltwzhrzZ8l2QZGze1xsjhUmPpdhZL/hPy+xTkGVoBtjWEo/MWU4MchA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3u5e3w0tsVwD3dr0KFUE7bk4lprzrmvyaD6oF9m2UwPGeSPNP3aXGXKwqgK4gtTkg1M7fl+QlU+rA1QfHkTIjt6rNRGaq1q5wqQUqbD7tlcFZ/xVJkzHTyw/zycSDqQuP6XyX72WsV8hgzVev71YQmk7CpOfwq3hVqlvwYacVUJhaNlZfH14ZLcUq225YZBvn6nhbRcjQHn9lrKolN292Nn9Ij2On3QdImqMUedOI33nmtT0Uwd3qnmST5ur4GqVESoTy1xLC8do6NxkOwuaeFR+3IhMtcV2fux7JHXqj2+2OSonQ7XHx609hXKV+2asKQ2s4Ll9haEgwIqS46LXvJVd9pqpt045AIbGmCczsY83DSH2r+GWB0+NK6OXZdOFaBrztW6fiFtHPv4S80Ej9WO/+ewsulb3yKM97qbi+Wh92Te8Ag3uvlrSvCeW0jZdtbU/55DpG1qOPJXpcMNdTad20WmS5WJa0T4EKLILclmxzwYQzylXsxoSYMjFzn+s2I5IAFohNWrkjN4i9IMmG5mc4b1Hw+HXxD4fko6Mz5fJ659bIukXIFxng9M325UiKDmWfWRUoahODrHZeGvrsXeeAup2aX4jEqvxluQ54Ir6Hvc8oXwas14FwNtPr84WSQBGJayFnSOcXTis0c8UKlg7hiQbDrIBWz6RefIUOCtzJguqhBXjdrUBh6+ALqt6
X-OriginatorOrg: Atos.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR02MB8336.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41304c2-5c44-42a6-e416-08df448eff37
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 09:41:46.7409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3TdP0wuflwaVsnUzVDqE3PPoHfTp2B5c8e9urzr65YLRVPJsypphgArgoMqOxSI2qw9D2faM2QGiehM558gzCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR02MB958055


I don't know whether it's because of my mail reader, which is Outlook (I kn=
ow it isn't a favourite in these parts but this is a corporate machine), bu=
t this email has come through to me with no indentation and no blank lines =
between any lines.

I don't know whether the guidelines explicitly mention this but for myself =
I find both these properties make it difficult to read.

There are a small number of fairly frequent contributors to the list who ar=
e also in the habit of not putting blank lines around additions (or even pu=
tting just one after the addition) within long blocks of text with reply ma=
rks (ie '>' characters).  That also doesn't help me be able to easily read =
contributions.  If there is a mass of text with all but a handful of lines =
starting with '>' they are very difficult to spot.

Would it be reasonable for me to ask that the guidelines should request at =
least a little bit of breaking of large slabs of text, whether plain text, =
as here, or long replies, as elsewhere?

Regards,
Richard.


Kind regards,

Richard Kerry
BNCS Engineer - Media Competency Centre
MidCity Place, 71 High Holborn - London WC1V 6EA - UK
atos.ai


> -----Original Message-----
> Sent: 09 November 2026 05:22
> Subject: [Outreachy] Draft internship proposal: Improve how command
> arguments and options are scanned and parsed
>
>
> Community: Git
> Project: Improve how command arguments and options are scanned and parsed
> Mentors: Christian Couder and Siddharth Asthana Internship period: Decemb=
er 7,
> 2026 - March 8, 2027 1. About Me Hello everyone, I'm Fien Dora, a Compute=
r
> Engineer with an interest in C programming, systems programming, and
> understanding how things work in the background.
> I've always enjoyed mathematics and solving problems. I've always been cu=
rious
> about compilers, and what happens when a command is sent. That curiosity
> pushed me to start learning programming. In 2023, I joined the ALX learni=
ng
> program, where I was introduced to C, shell scripting, and systems progra=
mming.
> Of everything I was learning, C caught my attention the most.
> I liked that C helped me understand what was happening closer to the comp=
uter
> itself like compilers, interpreters, memory, and how software communicate=
s with
> hardware.
> I am still growing as a C programmer, especially when it comes to underst=
anding
> large codebases, but I enjoy taking time to understand a problem and work=
ing
> through it until things become clearer.
> That is one of the reasons I was drawn to Git's Outreachy project.
> Availability: 30 hours per week from 7 December 2026 to 8 March 2027.
> 2. Why Git and Outreachy?
> To me, Git is the reason behind successful software development. I usuall=
y use Git
> mainly as a tool for tracking changes or versions, working with branches,=
 and
> collaborating with other developers.


Atos is a trading name used by the Atos group. The trading entity is regist=
ered in England and Wales: Atos IT Services UK Limited (registered number 0=
1245534). The registered office is located at: Second Floor, MidCity Place,=
 71 High Holborn, London, WC1V 6EA. The VAT No. is: GB232327983. This e-mai=
l and the documents attached are confidential and intended solely for the a=
ddressee and may contain confidential or privileged information. If you rec=
eive this e-mail in error, you are not authorised to copy, disclose, use, o=
r retain it. Please notify the sender immediately and delete this email fro=
m your systems. As emails may be intercepted, amended, or lost, they are no=
t secure. Atos therefore can accept no liability for any errors or their co=
ntent. Although Atos endeavours to maintain a virus-free network, we do not=
 warrant that this transmission is virus-free and can accept no liability f=
or any damages resulting from any virus transmitted. The risks are deemed t=
o be accepted by everyone who communicates with Atos by email.
