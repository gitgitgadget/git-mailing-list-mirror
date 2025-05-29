Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473D722CBD5
	for <git@vger.kernel.org>; Thu, 29 May 2025 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535670; cv=fail; b=nDaUWaOw9ec9s78aUkacSWvs5M1N85De3pUAdyVNJzKaV5RP6BkTLexa4nuSwMTKAmdSz1QCxOQdIZV6br5dvUcUTdTKya6/WOgN278UP0hkrb/fc9/Hly319KIJVrQdJ8vFTWq9n60cdbc4H+PPDWtibFjJ/Cs4s5hI3WlQt3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535670; c=relaxed/simple;
	bh=vzFR/mZzB1XEfhenrMxiAkhe7YwChsuTltrT6jU6JJU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cd5cEnINroa6dudoEEudndK7vRuOx7z3SzrWtFOWBPrDd06Yo5VmAgpcx8pc3oj/9JmHOcDU+KzVTsfCx3s4FeKWCoj49z8B61qixtzFap47Gm7kGQfWke/LkL2EyY7ltYd4HnLOQdojy97fln4t7w1wLytDYh3NqKD74p6N9qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=YNtUYjs+; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="YNtUYjs+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHoR3wxYeD8kaPmTQxixQHK3vKvGNf7eqyfrPPlINJBsOwNqb5ohRBvjh8+SLZDxCkMWhCXSDdUr2VvgayLZ6Csa5co7U94FIN53izWWzGQ2kcgVhCadnYpMkGO7PtE2GFpyieyPv5nNemUx7uxI728p/D/Wt1Uhj2JrJ8vQgwMSFFpm46xYqdtgxAJZwfGnBDr7CXNUdRq9776fYdToM15sKF6axE5QzSDdlbgGEulefISonj5HkG8+mNMAsIZO7oOVe49IizdYfcLvPWQARvWyniSmYqj0oxG29qgH7wrIYawl4gEA5w2MeucbeTZKjGC7HJbUa8Ri70cgEiaPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPRFPbIRIsyT+dtHH5IXf5lptQarVN5R+W5eHwKGQgg=;
 b=HS98ar5v8YIAxDubJELF4Ds9jscHs2XnVWqQXhTuHRMtrEYldie3zaO0Rn8Ab4KI+oQ5KdQtaSQRSKrAru1pGw2iqEKrHMdx0U42c/WFVShsXiwoK6sVX5Dbybrtzkqdwr/AdjzIZu0tzLzPG8t/TebPPoSBTrgArDBNAEVJGT3DN5ECncyZy3Mo9mnKdbexDp0C7huBrziPkYg/sXmyJVrYXyNWdhT3qSu3M70r0zkY8knjuxI+E6UKWl2Aw3D59+CGssn/0AafR4abMii4BwYpg8d8RZe23GgwZDnpvHk9HodhZ4YZL67eOZx+AbmiQwA5ZlXbW27iq6iwnKVHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPRFPbIRIsyT+dtHH5IXf5lptQarVN5R+W5eHwKGQgg=;
 b=YNtUYjs+e76RArQ35ZAcS18HJ4msOssPhHfxmi/3TLXWrmxBR8hGG6AlmpsX4YRSv2B6A04ZD2rddEc8nepNtPQp7Ggylv9PEPJkPGpeGY5bhzScmPQT2X5bwAWL5L86zBp333KWfVrs/SS1JdmEM/l5l9P4A0lg9CiG0gBpYbfNFae1G0De1Oo/Fo4rWZ8QaX1Ry9JSp2vzHhL8sT87+uxb08uBfA0TPWO6r+OkDa/Tay3KQlmEDfv5jVB/VRnCG1yAedjKWWkYQffsxQ5h8IdvbT2kTyImtjjNAQHXjnUuOPHoDfqIjiu0plcLNEDtIQpkIpWGqT11bdoLUiHDxA==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by MA0PR01MB7067.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 16:21:03 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 16:21:02 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v8 1/9] imap-send: fix bug causing cfg->folder being set to
 NULL
Thread-Topic: [PATCH v8 1/9] imap-send: fix bug causing cfg->folder being set
 to NULL
Thread-Index: AQHb0LWrm2pju4m7CEqJogEaiVuj1g==
Date: Thu, 29 May 2025 16:21:02 +0000
Message-ID: <20250529162020.45187-2-gargaditya08@live.com>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250529162020.45187-1-gargaditya08@live.com>
In-Reply-To: <20250529162020.45187-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB9588:EE_|MA0PR01MB7067:EE_
x-ms-office365-filtering-correlation-id: 14531bf5-820a-4c12-8eec-08dd9eccce35
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|38102599003|19110799006|461199028|7092599006|8060799009|8062599006|15080799009|41001999006|102099032|440099028|3412199025|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?htN6yEgyYYIwAS3Iac4A7FkYLYSGxX79BUsE1vUdrH7LdbC8wNQPYpylW/?=
 =?iso-8859-1?Q?fggGv/0hQIa+7rbyPVMv+ePLeanZUOBJhdCGHlTCUTY90Ckaj/7b6i+5Av?=
 =?iso-8859-1?Q?FTkP/MNnhEWTrm9TzzbLjhVL9yht6iVFsBTV4jLCnfHQn07ZWvmwaL2Yua?=
 =?iso-8859-1?Q?uus38mA6XhTpG//XbIDn9bUgSHniJeI/IiX4WHNc8EkP0B4WNPdPasl2bZ?=
 =?iso-8859-1?Q?1ttWfAPLUSr8eiIh3as6PpXGNOSHVT+d3BLJJh8AyyPd/BcBun0WAw3GHC?=
 =?iso-8859-1?Q?8/xiHo0fx92GMrOWqKlqs2/kG2h+f5EEcbw/wWHAWcotlFIjsCDxv/2OLh?=
 =?iso-8859-1?Q?dFH3Wr5zQaNfBU7lzQnI5p7HDjd7SM/D4pT6UaDmaxQF53ZFTnqz1mmhCo?=
 =?iso-8859-1?Q?uofN+/pC8wYYVZUPg2AupNtW4i+Eg2+sD7OGytSbpGre6P1tOVfa1nsmMh?=
 =?iso-8859-1?Q?CvFTwA5t71fEs2B5FdpfnwYbUNjCEo96yOurm4RvXcoF84/rvrx/n+/yl2?=
 =?iso-8859-1?Q?6oNWaWgK51iAGq7UHhFpZNLboUnNPd44OueZ/DELX5GJz2iUiUIhkkPy/1?=
 =?iso-8859-1?Q?BEXNmifsQvY7xaM8Blq2Wy94Mas0VjYkPKcgXpVRob7I7udz6PVKBxG1He?=
 =?iso-8859-1?Q?HIuM6+VB+hQJx0jlTRJzYYYZSOckCD1I/mEF9BHLZKLxzoXuiN9pPUnOqh?=
 =?iso-8859-1?Q?OgDn1UChfeiRMCMg/BwkSkt2GzpZ4aY1C/aH/ENDQWo3jHS+w8gDgClI2s?=
 =?iso-8859-1?Q?YIpW6cxL5sEWFWxROCI6JelcuiwYyYP2l4FTEcW7aPocO4TaUP8wdJL4gW?=
 =?iso-8859-1?Q?WY4g0/ngNap5VHvYcWhTy3Y1OY5cRLchXVMqZ2vhDO447UEGDMRBPIRpQW?=
 =?iso-8859-1?Q?/IttFWhrAengT2S2WR3aVjxoL1HKCoHI9Bf7kBs8j6HZiVogfsjQINmcqp?=
 =?iso-8859-1?Q?ZDQUJ3SUFEkGaZSPKo1g2Yh60LA/qlm6pWXb5NYB1ICLkYVsF9YUqutCaf?=
 =?iso-8859-1?Q?7Mo+GVjQxVaGZfVpDw4smCCU7oHyvpJ1oKQCqiiECfmOTrHrI9J0XbUCOs?=
 =?iso-8859-1?Q?7LNBrH2S8DhwEsvDakYP5aHtpVloi2dnbXXOhyY+sYwkIFHM6MKQ0MQwlS?=
 =?iso-8859-1?Q?A3WcUX/7LrS4X5Y7dNKb1Eu0TOe+XgICC2QGroTLAi+aud3gJrEH83lvY8?=
 =?iso-8859-1?Q?Z4jWj5ugRDZmXZaE5+SvQ8PcUfNw4rLd5GJaIGttB9qS8vk6inGM4sts92?=
 =?iso-8859-1?Q?iktsRM0NfeW3ABGJDN9MG8nBjEf76/Ui6V0DpYgfk=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Fighw3g3lvq7ibv+lrF6bQTkk6zoOsw90SHw2j5kMbF2QjdTd1z0Ry+d9c?=
 =?iso-8859-1?Q?aaQmTvCOH0nz1Viu9FlRa4KCmcA7RFyohKJ/l+6YdZd4ve+uivESdGbjBw?=
 =?iso-8859-1?Q?B8hU2ar2D8VeD9uD7+zDdM9qJM1si6M9ZbCu1vs1TN/bh3t7ItS+T59bZr?=
 =?iso-8859-1?Q?ygcI9JiuSSoTJMTHUwoTYsx0ff8osTfOvD0egWE0alYqPc/CNC8QTCyLqj?=
 =?iso-8859-1?Q?T98SA/id0sE+H+JOL6D7a/PqvTT5KV3rGNK/IXFEwG5orJHxD7wLztKRDq?=
 =?iso-8859-1?Q?/S6SiQ5OfhOY4g60ARkjF99LC+2ywoLsauerQynda6Zxppfz156jUS2Qgp?=
 =?iso-8859-1?Q?q/NEauaV9wvFPlF6YCzNv88SIuAMKY/MvWad2eqIR5gBuIH0wsDTZ9x8iY?=
 =?iso-8859-1?Q?U3MQwTnnTWAQ7HQ6h4bT6v4TOzFlYUblPtTWTcrZeAq7CZn8KTZThHjsbF?=
 =?iso-8859-1?Q?H6pbL5dD9qExEW7eZbWqnG/RcUHyILNhJt0NEJSH2k6Oe9lOG35MT622JO?=
 =?iso-8859-1?Q?Pdh2RBfd4gz2imxOGz3YNAjKzh3M6VAjYl9y04IP630apDhw++hwtDmgX/?=
 =?iso-8859-1?Q?7oTSvx/pZlQ+jzYak5m65as8iisTYyRb5FsrGxR9S7s71Mf3DIma6xcXfM?=
 =?iso-8859-1?Q?pDAcNIJMSyfePHDVCvkbJ05Mu0r1lwigy057U38zNG5AA9ujBYtOr2VNYx?=
 =?iso-8859-1?Q?abH/prSyTwOvdHOlOZrNPQiClZ1p3H8VLpZzfqpd7QqMgmMrEUP6iJ8uH3?=
 =?iso-8859-1?Q?SULpacJ57o0c73X+b64CCpISIKuU5V2GDp2HV3gMJOXaQWpcwSbizS3p8x?=
 =?iso-8859-1?Q?QQ+CJ5xCaGtkWQM+zxLV87aPxVzi0T374J/OfmhJFTOwncbH94DJpH5WXe?=
 =?iso-8859-1?Q?t19+1FPONV6CmIuTd0GssadpZQs3sSn/mRomxYGAJz0l9g/9cuhxrAAzRB?=
 =?iso-8859-1?Q?BZZcNzO2fejVqPf09d106oBPM8ATd5uvphfaoPFbhFSknQutK+owrzIKHZ?=
 =?iso-8859-1?Q?WHGMJtLUHRFiLMxfmHxRJfncqlfl89ycKS8ZUh0+m+9TmIgZ8uMdqPo3qZ?=
 =?iso-8859-1?Q?dVVnYZJijZaD/LRV/3+Xt3xt/xbg4pkqQzMc1WlHvuTaK6DrNq3Ec1x//f?=
 =?iso-8859-1?Q?IPwQpZIO7LtGjZD/aK0MoOJeYUjEVC+0/G2EUUZEUV+1YWq09Hzv7v4ACA?=
 =?iso-8859-1?Q?xV/+nJy+cW9UAJHp4BSE0qFJ776tiwJtGOw9tEWmnoWXGZxDytplffYZk8?=
 =?iso-8859-1?Q?VGql2S9jF3oejg6dmJc72ZEkYxOakIrn0m0E4v7j8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 14531bf5-820a-4c12-8eec-08dd9eccce35
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 16:21:02.6461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7067

6d1f198f34 (imap-send: fix leaking memory in `imap_server_conf`, 2024-06-07=
)
resulted a change in static int git_imap_config which resulted in cfg->fold=
er
being incorrectly set to NULL in case imap.user, imap.pass, imap.tunnel and
imap.authmethod were defined. Because of this, since Git 2.46.0,
git-imap-send is not usable at all. The bug seems to have been unnoticed fo=
r
a long time, likely due to better options like git-send-email.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 27dc033c7f..37f94a37e8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1316,16 +1316,16 @@ static int git_imap_config(const char *var, const c=
har *val,
 		FREE_AND_NULL(cfg->folder);
 		return git_config_string(&cfg->folder, var, val);
 	} else if (!strcmp("imap.user", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->user);
 		return git_config_string(&cfg->user, var, val);
 	} else if (!strcmp("imap.pass", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->pass);
 		return git_config_string(&cfg->pass, var, val);
 	} else if (!strcmp("imap.tunnel", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->tunnel);
 		return git_config_string(&cfg->tunnel, var, val);
 	} else if (!strcmp("imap.authmethod", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->auth_method);
 		return git_config_string(&cfg->auth_method, var, val);
 	} else if (!strcmp("imap.port", var)) {
 		cfg->port =3D git_config_int(var, val, ctx->kvi);
--=20
2.49.0.638.g602e07a80b.dirty

