Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011027.outbound.protection.outlook.com [52.103.68.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA549460
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748767144; cv=fail; b=WgBuAI5rAY2dqNUQoh4lhFuBLxPmVcrShFegqtb2SeO+yEDJnJBxA7SvNNlUAmKH/7YEaNjFkPEYpYsbwMGitEu2rwzfP1a2Luquyp5a9JuqK0187IBxMtXvv5IVaxg9QxuemKprsy2HRDEe2BHrakkvRsaY84ECpiMlIdPgczQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748767144; c=relaxed/simple;
	bh=2rwNqO8bc5Jg7wlXEYvM4RX19GMM/LS+oRYb3L7GYgU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NruAi8L/bzY+WyRyNSZRhmQySu26rKedTWLw0By6rIjq/oHO7VpD13gF3DkvFCkfDDxeoRQOoAAE/25JdxQhgvS9lVCmtIjMkRYuKP4hCvFp/sVls89tvIADSpTr3TLXE2VoQKiNRA+mA94gUY8kvpyzc/Ijnyb9lEaz900PWDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=j2n9D8+Y; arc=fail smtp.client-ip=52.103.68.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="j2n9D8+Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtbBvj04E75WexJ1CCUVbMRu+/i+uzwUDL7zSk41Ho4DCgjZh9vOxwCpx3JjOCinqLMIC+zLDtdTL+R6e5JYe/t/45qBaxenIiYR9K0XOW9jbGTaiL38NvVIgiBC0d1DCU0MaWYdatplodJpDIxqp30e/M3Wj7bBaEmYr7xqfoROWyfA+cMPv3yckaFj8Lhx96nunqpe78T3yjTnyFPPlcThu8nY2XUqmn6+FPu/2piGpS/2BDurnxDuYbmyGiBWpGHx3IKJcmkKAHgkEvk9I2y/2u9z/uZUQOxVBril6EsGW56nceEIi2caZD8Ly0GaDKsVebH+PWBTjGeMrLYlwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swUllHxU2XeQPG5VExdn/oTg6xj7HJdbQtsStHHCCH8=;
 b=EPZSxlNxUtLD1KFw15n+ALkpD9eqtXVNdYO96iZXrfzjQvfpDfAJrEtX8W9GQIHvEEdyrle81u7MobT0/QNp3POqy0MHKu+IhNIEKSLU7lHcsum3PZabeRZ8Yyq7S5c5AGer7Rr2TNR9ED93Bm6+3OkLQM0HN8Gqt+aj/KQMCqP/AnamLtOZUyCsqxn4xNWYqZvSfF9OetE7z3N8Knm/DPGDyAsMV9athRdWRGV7UWxC4xwoEsGYWMHySOhVDGIK9LsHDCzmVafdpsINAn9Vn2o8tJcj9j60uVU/mftV/M/ltaf22OnxeTJrZtaENn//uPP0+b0HUnFE6WoISsAaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swUllHxU2XeQPG5VExdn/oTg6xj7HJdbQtsStHHCCH8=;
 b=j2n9D8+Y3keAX4VBFuhSj8087pHPaQKRX4tPnjqH+DAKAp3OFgyAZ4vGSGsNLbMkkIpKDhKWETIJhecfqY8SkvmGxm4G7IeuQfpTp11VVFnofDSrNjC0SJR8Z1o6VvMpJoMyU9YFRN/2bxtjZCuf2MWIa79tpp2Zy4TM6eqa8/buYUqa4i6l4mL0FZPoKKNByHnWgDJAqpLkfBpphnJ91ZTNUXWJUIcv3Hsh2t1LV1jYozbpkHIgj8fIa9hBBuJmvTHc00rXdyo3ag/k/ECYXQoRh5e4wK2F7kUPLvOlNGV1rkDtjje3Ws5fIS+wEPUJykcO57nMu2OBRKPpaoWGtw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6304.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Sun, 1 Jun
 2025 08:38:51 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 08:38:51 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v11 1/9] imap-send: fix bug causing cfg->folder being set to
 NULL
Thread-Topic: [PATCH v11 1/9] imap-send: fix bug causing cfg->folder being set
 to NULL
Thread-Index: AQHb0tCZ581ATCcbp0aSDJsuyV4LRQ==
Date: Sun, 1 Jun 2025 08:38:50 +0000
Message-ID: <20250601083821.2440110-2-gargaditya08@live.com>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250601083821.2440110-1-gargaditya08@live.com>
In-Reply-To: <20250601083821.2440110-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB6304:EE_
x-ms-office365-filtering-correlation-id: 131f62b4-d688-453a-b805-08dda0e7bc49
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|38102599003|41001999006|7092599006|8062599006|8060799009|15080799009|19110799006|3412199025|440099028|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Pvz8AgEltlc7QwA1KvZanHghunMjNTpN4xiQO2xaY9aGbbU60qKVpC+DUP?=
 =?iso-8859-1?Q?3OyVYKZ0eglynq3uaxdikx/xUKJc8KRUCJ/E2pj1KZPaVRrm84rxEtlVRM?=
 =?iso-8859-1?Q?mbG4/wUTt5EJRwKN6T9RICOt7nreA4FotFsgGMB2bOHsdYYBNtVtGdCouS?=
 =?iso-8859-1?Q?uJYwdfEbf7JSrQ/+8PhLd5DYnznHxWhfYa5IEx1COO1RnGmLLVXnID2SdC?=
 =?iso-8859-1?Q?Gfh/ORyvqYe1so+cKlIOXx+wXFwwDX2EcdLIBk1Fx3VhH6y3xKGT1Q0fav?=
 =?iso-8859-1?Q?f7V1WsPQsVYZhFtnJU6eCond7RWcNitmI0+92srZ3uSsylhfpF+WLl5Hge?=
 =?iso-8859-1?Q?xfds3qvpZJUjZ4KUEg1UOg1MxSDSOHfA3sq3A8FK9Gaq6Cdz50Uha84Bqm?=
 =?iso-8859-1?Q?KJnZ60q6r0mGZ1zP30/pSjSLjMYbtE0RamolkC3vuuO7DwxTG3f+L/hA2m?=
 =?iso-8859-1?Q?pwt4LQ1EoFmLT1uItW8A/kWp5qBwHwjlIOyrGm/HMgoYe/YVaBH5HCOMah?=
 =?iso-8859-1?Q?i24YbyM/foks4PlIjE4rG1VKIjhDjot/HJKmFEQoAHRng+JoJx5SaFykfG?=
 =?iso-8859-1?Q?ImRJ7q2kUuitou5KrCOs21e43BoxMcb035tbVowBtWPX9Dzf4XpmEWW469?=
 =?iso-8859-1?Q?EgOMpKNIySxvey3FvV4kX+sSUCaAD6oLUt1N9hroYRqlp73ErKt+MBbSgs?=
 =?iso-8859-1?Q?i16dbYoEyFz22xlMwwQeue2A8gMxzE0xZJGc5WNJKvgfluhLlYCjcL05fm?=
 =?iso-8859-1?Q?q7Lb+8Rl5bTTecqPwh4iZUz1eQa9aihT6Ld4aFQ3zH2IRIcVFO8hCUnsy3?=
 =?iso-8859-1?Q?X4zgsz6ITMPfpKVySatAaTpbX4ARMHL13bL2i63C/wFw/2WDMaKEctUYkp?=
 =?iso-8859-1?Q?ykIkpBaqkIxOCUq1+2nrceT0jNeZjojeEji1LKbhC+gBPWNQtnFzrtg1GK?=
 =?iso-8859-1?Q?JtRdrF0a2ClVuK7r7+Hinemg7bZbQnx3t+g5tuLTyIUxjLQ8/o5Qdl0EyW?=
 =?iso-8859-1?Q?SYvc5BIIC7OC+DT89uBSRCjLm66hSRwGiVkEms8LA/zNbxYbqllGpAiJYk?=
 =?iso-8859-1?Q?IRW623u0eyl46ZPRANr9tyh6vYu9hbQUyuyoCRC6HTXZcOe5z9V98rLBAD?=
 =?iso-8859-1?Q?bWB/3ZRg81+yqTHfLSWkPc8gkq6EB6SVB2ADJeUftdR3LR3PVkSIhsiV0B?=
 =?iso-8859-1?Q?Hnoi5oJdTjs8Uy6zQnWOXUe/fGcNEk3FQxpjiq3Ngb0Nl7DbpR6paNmbaw?=
 =?iso-8859-1?Q?/C+Uh50vLnjAnMtQLG9g=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Ku/pxjujPH2G9SOkaQswOQPFAHtAdr8tDe8iX0ZQT9/WF5oMh7Ztyi9lqc?=
 =?iso-8859-1?Q?KrrYXAkMTvf+BvuCg7eY/avk01rw17NDoOkSxkp45kUQdb1i3CE2hoi+R9?=
 =?iso-8859-1?Q?+VagU8N9HayDiAP1ftTVdChtXGFFTacuNYwo698PMm2ucem+HA47Z+TizV?=
 =?iso-8859-1?Q?M3vl3AUYTdq+IaTgcBlESBKa0k5IZ+2sna2F23ant+lM2XXvoc6g2L89jr?=
 =?iso-8859-1?Q?DID6XxY1CSNPe+TnaJGWhUEMK4URxgUQBSaYfNMwtqHxSJOJ1VqHO9VC7L?=
 =?iso-8859-1?Q?VhX34CinvpSr+kNjJaJmsncGdIOc/wpIaJIJq3fdG7lgUs5UclnhlVOg0I?=
 =?iso-8859-1?Q?4vCO6HNzl50+WzBmAYf1D6XGENYkgqXFAHlxWlyLxlW5K/bwYmClpwkwuv?=
 =?iso-8859-1?Q?kdRl88Zc63018e5U47UwFOF7zU4axIhws3XJyZMP9tEI9A3SsXyAb4B6zj?=
 =?iso-8859-1?Q?sT2/UOAAizcUm3s0xvd+E0HfylLjq2dA/FNF8EkbFqLdu37T6poiTa4lZX?=
 =?iso-8859-1?Q?AFQrC7hrWovzr7ZiHYz8Cls6B+1tu3J18+oei0pVJPp/zxIhfhmXwuNpEe?=
 =?iso-8859-1?Q?Vdra3e4R48/1N7N4F9BuQhqKrO3vnSffR8XkIIybMwMJ3odPMtAkmpjc17?=
 =?iso-8859-1?Q?TswPfvM88ouMxHTbDPP/XbNlWGbNCMpv9xRUfG0rzW8AAyEfxCdZ/jSZcj?=
 =?iso-8859-1?Q?eXtMYVufkqRHHkEQymxGFTxEB+bPPFxBH9gjW3FqJgQhILyTw3p3PtUOcm?=
 =?iso-8859-1?Q?gcm2LXg+JfDy+zV+CLF2xUxm2pKrls6b83jWw/czU5yzsHv3n5VHHtnsRx?=
 =?iso-8859-1?Q?nUua1FkHdC0+T5Cjv+W7AmI6cB5HrhKyXHSq1x1U/4GWE8WWf92T3LB2xj?=
 =?iso-8859-1?Q?vcein9W9DIgmbnzbsPF6NjJH4rJkxoGZqaR3ptNJR8MkChjdSx60+WyOsH?=
 =?iso-8859-1?Q?P0KHF5/4/7tp9juM/XW++9VB1pv+3VGlozthleB2ZZrprAuUu+L2LOADA0?=
 =?iso-8859-1?Q?0XuM+bIoF9Y/Kl27eU3QMNKeQcPAhksaGwrhoP6bns1lqNz4LHwm/ZTkTM?=
 =?iso-8859-1?Q?TahC5bNrgU/2E1xKl4JoGgMtbPRbR+V0PP3JmT1oMDcLpvgQy1TDuOlQ7g?=
 =?iso-8859-1?Q?3A2aHuoFLO1U1DH3u1tnePro2ACJZeEDuPt5KQxwCRTIC482shzcVMKHKr?=
 =?iso-8859-1?Q?JaAyM5fa5XeQFnBbejvPlKRsVqVeJHFS8nlAn6O9IgCGDilh+0OHLKAXfG?=
 =?iso-8859-1?Q?uZWxdzjgGeyg28qDshrmmMOKhdXZISDV64CJ3WmoE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 131f62b4-d688-453a-b805-08dda0e7bc49
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2025 08:38:50.6574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6304

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
2.49.0.638.g5e24c6cde8

