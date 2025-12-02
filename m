Received: from mx-relay40-hz1-if1.hornetsecurity.com (mx-relay40-hz1-if1.hornetsecurity.com [94.100.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B5B1F936
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.128.50
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764680945; cv=fail; b=hkKrx8K5S7RUz6oE4pBcnQxPK4F1swX9EVByxUXozV2mLxAVru3k3wFlIkKitFbF4Ivwvxvu9Is5gZvj6SZfhtatYNwCaeCv3/qDd8s+7e9Rnqx6bUZ90WCEmL3OCvXYamBud30unmWq7DY0LggdQ5HwadunIGKy4DvqGghPdFw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764680945; c=relaxed/simple;
	bh=wTEv/08F6XB3kMs/JWfgbKfg+2dMrfww10aEaU+89Ow=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Yivf3NtMMp6ELSFUxs4eDX2rpdoIswv1UQRONdGzHEOeF5qNTDfXW0byix6K46Dd/GO1tfJTgEsVEEH12LRU2zuIyrfQqiZsfqXRbeuyITCmqeY7A3StZyLQ0LXNxLqIRTW4jxsMWHXVkBi7isI/dVkoHnD/qIu5r8MzvW4TexI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=miele.com; spf=pass smtp.mailfrom=miele.com; dkim=pass (1024-bit key) header.d=miele365.onmicrosoft.com header.i=@miele365.onmicrosoft.com header.b=qvi7VcZa; dkim=pass (2048-bit key) header.d=miele.com header.i=@miele.com header.b=JqtmSkEQ; arc=fail smtp.client-ip=94.100.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=miele.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miele.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=miele365.onmicrosoft.com header.i=@miele365.onmicrosoft.com header.b="qvi7VcZa";
	dkim=pass (2048-bit key) header.d=miele.com header.i=@miele.com header.b="JqtmSkEQ"
ARC-Authentication-Results: i=2; mx-gate40-hz1.hornetsecurity.com 1; spf=fail
 reason=mailfrom (ip=52.101.65.50, headerfrom=miele.com)
 smtp.mailfrom=miele.com
 smtp.helo=du2pr03cu002.outbound.protection.outlook.com; dkim=pass
 header.d=miele365.onmicrosoft.com header.s=selector2-miele365-onmicrosoft-com
 header.a=rsa-sha256; dmarc=fail header.from=miele.com orig.disposition=reject
ARC-Message-Signature: a=rsa-sha256;
 bh=wTEv/08F6XB3kMs/JWfgbKfg+2dMrfww10aEaU+89Ow=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1764680909;
 b=Rwt+peow8Vb36CcAsyxlNX7w/lZ5LPM8GkEMmB3lE99fMKHEME5LS64FLYoBngvX2QMrDvWG
 ZLMhPjL871tCc+DN7JP6lrHgdHgtqe0UE4dkPO6Cf9nvy2nJfFEVsonFeJW/pgFk85DHJjFbiHV
 DsGS/aHVyKPT2pTU9QlqxGSQwvfCX/gHBslMQjtZ88pujDIz1qv6YEUMXPj/YURsbXR9ZUieX8w
 xQFiak2sMgPBdCWNIyCi1++DV7XVD9en3QSxlAmR7/zDJEp78tx3FUP//FSzZgObBNtuStnIjAc
 Whfx8aTOM4Sf+9bp2T7N3vA6K4z0nzZbOd4/kvtCKM2dQ==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1764680909;
 b=Tr1NK6Sz4Qh0qD9pTeXpaKL2pKcOzPfQM793ZGGY9YalglyZRbF5QqStxITzoTUxhloA3SdY
 AMnVPyizB80H/duLNKxThc18nzlPb+ggS4EGamlJtyDVdDMOBqQpQhtv7PSTHE1Bm8LxyjOEsSR
 cVXGqZ8fyYyGqHt3BCpEnToacE6FIE7F6KRur0aA5f3iLvzfVdW6P4/eUgcJwx3SHYveCFqUUoO
 RAHVTSdyU61s7lkuOZH4yLwQu2J16srxFMIRiLBmSQwZ9eZa0ARQCs1YC1FL89xafgSbiqh5w+n
 dc0WRIZM09lN6fskChp7qv2t0BD5A2Wrc4viHy/xD8jrA==
Received: from mail-northeuropeazon11011050.outbound.protection.outlook.com ([52.101.65.50]) by mx-relay40-hz1.antispameurope.com;
 Tue, 02 Dec 2025 14:08:29 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6aZGqZ2ajMT35tRe+BUjX0NyehjdssXk8fRys4wWoE/p9/Lpi59ZcOpPHbNU0IW7OtorJcTWQmzh+vprSudvbSEviJCQTF+0RXTHpuk4zPcxAqZSAN0/siEOZ22f/zugJcbixuFvdfkLP/HRqvCFDN8hu7WFdiT03643EAFd2ZSFWdA0WarGznuyrPZ5GW/LGNNmSIrmSD4+UPJZYxWzjdIZtJX8Wo3m3kyOkkTyZ+GeicvuAWvnl6sN6JiPxIkTNl1QryhLgDys4bJWWgNh7dLoP/j/ozq07Thi64+L9fEHTuYbdKHJBp/CeJyuFMc0BIZlZ9Gc7GuzlUsNq/xfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTEv/08F6XB3kMs/JWfgbKfg+2dMrfww10aEaU+89Ow=;
 b=mTXPvccgQxmS2fb3KHSwN6bTDTCNNx4GCaSYjo96dGib4MuL8w7SivlI6U5pP4ilig8Ii1bOn84uUC4pvASUfTdXEQb3S7RmhEbEn2d2lajaKjeQHDm8X8ggZ/jGebGp+iEEMOwx/8kQ8QzXpEzAySDmEKvBgrrsh++PiwUSQhslT6IwZ1OEvowFLL0ewGazoxB5bWG5AMPhDYd2mtVdQBc6yhW/VhRSuFSD0+G6WsUEOeWFJgfKlqPzTvyBxn4gCuLSoJM61oqIF4t8222BqsxabaD3JDi8z0TXRd1Uf5+urcWzL6C31NW/3fFFiuDi+lKmbQyRsYFyQqpFbQZwQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=miele.com; dmarc=pass action=none header.from=miele.com;
 dkim=pass header.d=miele.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=miele365.onmicrosoft.com; s=selector2-miele365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTEv/08F6XB3kMs/JWfgbKfg+2dMrfww10aEaU+89Ow=;
 b=qvi7VcZahDBQTZ0dx5EuH3DKbDDcK7SfwGpNFxpomPBUZT+KPA5NvOjQBbhkKahO2luLQ+zeYTvvc0mAJ3f8aXaNrpr/lzrv0L34qn6fbrdH7PADlU3RhkN7nryjJH9GsfdgwaBbeaadA2nCCKWUPb70t4gCmU+KAnVTVXQ+mcI=
Received: from AM0PR08MB5426.eurprd08.prod.outlook.com (2603:10a6:208:184::18)
 by AS2PR08MB10205.eurprd08.prod.outlook.com (2603:10a6:20b:64e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 13:08:22 +0000
Received: from AM0PR08MB5426.eurprd08.prod.outlook.com
 ([fe80::d351:b1bb:ce65:883a]) by AM0PR08MB5426.eurprd08.prod.outlook.com
 ([fe80::d351:b1bb:ce65:883a%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 13:08:21 +0000
From: "tobias.boesch@miele.com" <tobias.boesch@miele.com>
To: Git Mailing List <git@vger.kernel.org>
CC: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] gitk: fix history window panes position
Thread-Topic: [PATCH] gitk: fix history window panes position
Thread-Index: AdxjfVz5xV1bhNtlQMuC0kJ0bml6MQ==
Date: Tue, 2 Dec 2025 13:08:21 +0000
Message-ID:
 <AM0PR08MB5426BC141388A69BB5087732E1D8A@AM0PR08MB5426.eurprd08.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_ActionId=97cc5c71-2d10-402a-a5b0-4e5b8bcdbf23;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_ContentBits=0;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Enabled=true;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Method=Privileged;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Name=General;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_SetDate=2025-12-02T13:05:06Z;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_SiteId=22991c1b-aa70-4d9c-85be-637908be565f;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=miele.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR08MB5426:EE_|AS2PR08MB10205:EE_
x-ms-office365-filtering-correlation-id: 7e9e44b8-e94a-4eb4-125f-08de31a3de70
x-miele-exorule: Spamfilter umgehen
x-miele-exorule-disclaimer-company-imperial: 1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHlmSkNiTGIvVTlRS1g0Sm02Q2FJK0JiVStqZU4vek5qK05WbGZDaFVqZmNh?=
 =?utf-8?B?TWNjOGNZUzZtT2g0OFU1bE83eGljbWNjbVh0OEJySnplWlFWV2YyLzVlWDRm?=
 =?utf-8?B?cTVHYXhXek4yRDFTREJOT3BYbXRqT2J2TE1XTUUvQzB4ejNUdHFtSFhRL3hV?=
 =?utf-8?B?RW01d1F0Rk03Y010amlQQ3FYS29mVmRIM29wcHZjemF3S0taSGRUU2NBajk1?=
 =?utf-8?B?RnhvZG5sWDhMT1dXVUNSYytjekhHRHRoMnloR2I4cHNXdGRacExkRXgzWk5Y?=
 =?utf-8?B?Y1BlTzRIZCtXWGZSallURkh6SGV5T0k3dWZlTEJscG1STGdaSmQzVG5OdHhE?=
 =?utf-8?B?R0ZEKzBDbFQ5TlpETzF5dkxIdDQyQUdvT0U1aXp6WWFVcmFaL2l0bm1xcnBT?=
 =?utf-8?B?RTFmSWpPNW83cVlPTGtHR1NJVTJmNGRCbmhZUi9xeTU5ZnJKRDN2TnhJK015?=
 =?utf-8?B?K1ErUHNiN3BlQnhEaU9KNlNGQ25paEZ5Znc5OThVenRBTktROFNRTDhVNERK?=
 =?utf-8?B?a0piVGF0QjNGcGZnVmFqeFkzeEpTN05XcGJBWkErWjVTdG1OTkJjRHFDdUdI?=
 =?utf-8?B?S2QvclNqKzJZY3pNeDUzVFFlSzUzV0NNamNkcFNjRVpxQ0RXdEJMblhaNzFV?=
 =?utf-8?B?VU8rUXVSSzh5TldJNFhRbVNTRkRXWEhmMWE3UHkwUzRHVDhUL0JQeVV5NHVn?=
 =?utf-8?B?c3NvSWlmQURnRURaYkFBeDR2MjFVMWlLNnNzSG1IeWZicEhQaWY4NldlcGpq?=
 =?utf-8?B?ZGFPa2pld24yRGhBSTNPZFlVQ2xIRm1ydXJlYWlDbzl6enlpbmxJdnBESTRm?=
 =?utf-8?B?RUVHTUNDNmUybm1SQ1prMndkbEtVdVkvVzZDSWxKKzZMQzFkeW4yQzlyRlk5?=
 =?utf-8?B?V3ltb25WWXJWOHNMb2hTVFJnakdHaWFvcitkVVdtU05sSjJielF2cXFkT09K?=
 =?utf-8?B?TUN3TWdBVGpRQWgzMy8rK3RNb3lCaURscWt0OUwydHZCV0V1VkxPSExURUlU?=
 =?utf-8?B?clZTcFJINldLbTdSaGpMVTRFdmRnRlNZd2ViNC9VQ1diNVZhK2lzQmo1ZFN3?=
 =?utf-8?B?VHpsSCtSRE1kM1M3QmxzOXZBb1RWaHhraWFIT2FnWE95SkFVMEtvVEwyR1Ft?=
 =?utf-8?B?SGxCYmVUdWRTZGxQRU9xSVJGdFNxNDRVOXVJcG41YmRoU3ZPQm43ZFp2NHo3?=
 =?utf-8?B?a1RqcGVHSXhSTUZNcHlsakp2Q2pFMDJGdythdHhUVTFoaHV3ckgyRVQwdVVo?=
 =?utf-8?B?MUVCMnpvZnpYOEtiWkR3Y2pQc242djI1ODJ5MGlORHNGYWoxekJUR2Y4NGR5?=
 =?utf-8?B?V2hlc1pobFRUdHQ4aXo2QU9hSGRKRHRWQk44RC8xWFpxeUJCUGlSNVd3eFda?=
 =?utf-8?B?MkpHTmh0ZG1lbk03UmdDRkhzSW9qUWw4S0pPU0g5Ty9RZjVJbGdPaXdRYko3?=
 =?utf-8?B?c29RVkJZN3BBYzNyMXVuZzdzRkdnY3A2RkxsUmU4UW9tS0Y1SEwxQmdzN1Ey?=
 =?utf-8?B?MGtDSENVMVBQV015S3BQVmkwb2g5dkMvMUlFVlhvK0tnS1hUWEZpMEhKemlu?=
 =?utf-8?B?R0NIMXpUK2J0Yno2MjhKYVpGMlFkS1hmRUNhQ3VPbitPdkI4TjZTNnc1WGdr?=
 =?utf-8?B?eXU1VitOc3BlZU5zOEZLbkg2bGFNbGkzV201U05ESUo1LzVTWjduV1duRm5O?=
 =?utf-8?B?b3Y0aUl3QlVVK0JvMzg5N2Z5M1VBRlYyRWFRc09KczNUT1ltNzVTVm1aYjZU?=
 =?utf-8?B?Vmk1S2gzQkNtYTR2KzhEdlJqTGdnRGhSZ0xTOW01VW5NYVFOWjdNdmJoeVpj?=
 =?utf-8?B?aHFJUmp6NGhncENTR1A4V2VFNk43QVlhbG0yL0tHTWNkTjlkOFAycDl3eGRX?=
 =?utf-8?B?MWhCQjVXV3YwU3NQckVVU0RQeHBucjB2djd4YkpRQnI5aHZTMnQ3bm5WWENx?=
 =?utf-8?B?dkc3aG02RnZoSUJrM1oreDlRU1VuMkgxU2c5Z1MyQlpoazRGM241KzVGU05l?=
 =?utf-8?B?U2xFV2E1UVZKZXhYTnlkcEhBOHdHZGlaUWtvdU5JcWh2SldjVjBKVGlQc1VC?=
 =?utf-8?Q?/WV1W0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bk81dEJiYlpuV3k1akR4WGxDQVA0b3hNb3R5Z0lMUlQvS0dtdjUvWWFiRlNC?=
 =?utf-8?B?dEcyMy85VHhPVndMR29PeC9NY1YwMUVxWGVhTEl4TlZhNUtGdWt1SHI5QjlC?=
 =?utf-8?B?K3pVb0t0VGlFdE9rU1M4cVRkdlg3RGlTSXNzUU9rQ3dNK3JsQ1d0ZXJrMFBW?=
 =?utf-8?B?UFU3dUtycU10WW5NcHRHNlQ0K2V3TUhvY2tFRG8vQmxRQ2lOQ0VnNUlQS3NV?=
 =?utf-8?B?NGpwamc5TEZyZGM3UGVPRnRnYnFFZnQ2cHdBME0vMVdmL0c4Z2lFeVdyNHJk?=
 =?utf-8?B?WUE3UUpoaGRWSXV0NU9BVEMwa3BNOS84V3B5RDNDcjUyYjBSNHNpK1hQbENT?=
 =?utf-8?B?THo2cUYzMmpJbEVqTTM4WGg4YzJmMWVZcW8yUW1ZOUxWYzlxeTdqREtZODR2?=
 =?utf-8?B?enNoNG1pMXBmN2FtY0NOMDB1UXA4aWZPS2d3MVVqTWNkNnM3aGVJY2JmZitN?=
 =?utf-8?B?U3pTV1Vmd0RPTWRXRm9hK0c0R1NhVjRmcERRekRtMnQ1aTNKM3Mwd0lUSFg3?=
 =?utf-8?B?WE9MRWdBKzEvd0t0RjlFZ2NyMi9oN2hGemJmd2ZoMEdsbkQ4YkhiTDBMTEw4?=
 =?utf-8?B?enl1cExQWTQ4YktncHdZWEszQk5ManRpQ0phcE9MNTY5dDFrbW0xTSt5WmhE?=
 =?utf-8?B?STh5c3BQMzZKOUMxdlNIUkpVeXduRWZ1SUdYZHA5YytGUDB6Nm9WMlV1T1FC?=
 =?utf-8?B?c1Vsb2ozZWx5TW8wY1prVXJ0TjNmM3NjODlFWUtvV0FUa0IxTXRld2hoTFM5?=
 =?utf-8?B?UWkvZU15NGl2WWp1WG9VckhoeW9ZS0RWNnZhcDA2ZGtKY2VsZk5zU0dlV0R4?=
 =?utf-8?B?MUs0VTNzOXR4RkJhbC92ZGNYcXVxVTRqK1ZJcVU3TFJTV2hQMm1xNkc5OWw3?=
 =?utf-8?B?N0JLL2hpWThKOGhTeUtTaGFzS2NCM3VuMVdNUi9JRUdUUC94cGdyRHZ6RExr?=
 =?utf-8?B?MkRrSmpZVXU1RG9hSkh5LzdVejgvNzNOZGhxNzQ4TFdHYW1TYjdoZzBKTWdD?=
 =?utf-8?B?TjVXcENIWXQyd2hYaWM0M1lOSHk1QnZObkNTdTBlSUtwNHJRejNheDBzekZ0?=
 =?utf-8?B?dmRkYVRmeWRDdjUyU3dLVlNtaDBGc05UbFVlVUZuWEo5M21MeHdVNkVTUjV1?=
 =?utf-8?B?Z1NDZFIvb3o1ZTluOFJkT21wTFJ5Rll6WWQyZnJpRW5yU2o2K3lrWG9SM3d2?=
 =?utf-8?B?RVRwbkxEREdCOWkzMWRFTkhiaW5NQndJZ0VVSUduL3dUWmkyWmRGUXZzNThD?=
 =?utf-8?B?RUN4V0dGK1E2ZU4vZTIvanQvYmZHL1pyajlZVDBIZlVmSjFZY2d3YS8xZVEz?=
 =?utf-8?B?eGM4VmRjUFRnN0VvNFhySjdPQnlHcTF1MWhYRC8xNHdxb1FvOG9DRDdCb1R4?=
 =?utf-8?B?ckJEYU9nY0wzMHRMcC9JK1AzYXg1V0hNUUZ2aFhGYisyZnIzZGsyVjlJQ3NW?=
 =?utf-8?B?V3BxcWg2Z2V5bjBWbnlnb1MwT0hxQTRYOXJmMUE2ajkvbmgvcVpmYzh3Vklw?=
 =?utf-8?B?VFFwaXpMYXlneDJCYmMremZPNzZPOGtYT3A2b3RuUzRwNFhLN2xSQkphQmxy?=
 =?utf-8?B?Y1dZV210WHYyTzVIdWFnam00Um1uangxTUJ6VE5Bd1ZsNnVrTGpxb29qWVhW?=
 =?utf-8?B?NEo5Y3ZxcE1SVGNrT1BSeDBIWk83L1EwWVFkajIwOTNzTi9pVmtWejZLbEFX?=
 =?utf-8?B?dDJUOS9ncTlIdlM4YnBNZjVOcTFqYUR5RVFYVTg2UkUxeFFNaUJFYWh2Q2ZH?=
 =?utf-8?B?WGVGRk11cHpDUXVESjRvYy81SlJRMElWU3VsMlMzbENibFp2M0FyalZub3J5?=
 =?utf-8?B?QTBzaFhtU21kelltTTFreE1PdCt2aEVjR29kWDh5cXVLWXFmZzFId0Vpa0E2?=
 =?utf-8?B?VnJzcS90b3U5YzVmMWtTLzlmOGZ3OWlJbU5WZWsxQUQxeit0aTg3Vm9LeldF?=
 =?utf-8?B?MTRBdHRtYmpibTUwL0dZM2I3em1Uc2JoeDZoMTM1eURoYUFaYThTd0pZZ1ZU?=
 =?utf-8?B?dk5PSEcwYXgwdytKQ3BnNitDQmljLzl4MXd2NmJPM3Z1aVA2cFFUcS9GZFdD?=
 =?utf-8?B?L0tjS0M5Y1NzYXBHSXM1MG12TEVGQlh2eFkycWwyVzh4bXZjaG1ud3lJYUFr?=
 =?utf-8?Q?OO4WREo8PhpwxMAnso7PpiZgT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: miele.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB5426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9e44b8-e94a-4eb4-125f-08de31a3de70
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 13:08:21.4122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22991c1b-aa70-4d9c-85be-637908be565f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2ZMAA5xs1DFOJR+7PZqV6QbQia6gXqmooaKngg+mqB1Exu95RiuGUPDA7u23sti+iWt6/Ttyi8sKv7zxS+12w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10205
X-cloud-security-sender:tobias.boesch@miele.com
X-cloud-security-recipient:git@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay40-hz1.antispameurope.com with 4dLLgF38rfzfq9Y
X-cloud-security-connect: mail-northeuropeazon11011050.outbound.protection.outlook.com[52.101.65.50], TLS=1, IP=52.101.65.50
X-cloud-security-Digest:3c980e92629dd116e884ff73df74f234
X-cloud-security:scantime:1.705
DKIM-Signature: a=rsa-sha256;
 bh=wTEv/08F6XB3kMs/JWfgbKfg+2dMrfww10aEaU+89Ow=; c=relaxed/relaxed;
 d=miele.com; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1764680909; v=1;
 b=JqtmSkEQoQImlCC13jb1A8VMbe04xs45nqNN5W2rJ8+tZdrWdLeq1Iu0dftNV9Xi6Sds7jYe
 AHlhpHsPQAYk5Oly9nI9mvoHWHqBA6H7r2qwBv2o8+IzNMF9VDa/ItibMHjI0ZyM4HwfGIidVlq
 XyBOUbkhIuNwZVw3CBCXA0vJSYxSDfqo7Rouy35RBOT76JlUjSeMzCHXO+amgUWJdGgbIEnf3Uz
 AApHXzMNspOVAtDDYzcgi/zm8HeGHQqRTxLFi56V/JixDp96qdU5QHGpZqOiHU+RdzOg2oPagVw
 LMAB8wSvBCChe74qo3Yzhht13ISTjf0BGdjNPtjT2h0eA==

RnJvbSBiMmNhN2FiYzdkN2VmZmZjNzMxMjg1OWI3MDA3ODBhYmI5MjdlMGIzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogVG9iaWFzIEJvZXNjaCA8dG9iaWFzLmJvZXNjaEBtaWVsZS5j
b20+DQpEYXRlOiBUaHUsIDI3IE5vdiAyMDI1IDExOjI3OjE2ICswMTAwDQpTdWJqZWN0OiBbUEFU
Q0hdIGdpdGs6IGZpeCBoaXN0b3J5IHdpbmRvdyBwYW5lcyBwb3NpdGlvbg0KDQpXaGVuIHRoZSBo
aXN0b3J5IHdpbmRvdyBwYW5lcyBpbiBhcmUgcmVzaXplZA0KYnkgbW92aW5nIGVpdGhlciBvZiB0
aGUgdHdvIHNhc2hlcyBhbmQgdGhlbg0KdGhlIGdpdGsgd2luZG93IGlzIHZlcnRpY2FsbHkgcmVz
aXplZCwNCnRoZSBzYXNoZXMgZmFsbCBiYWNrIGludG8gdGhlaXIgcHJldmlvdXMNCnBvc2l0aW9u
IHdpdGhvdXQgcmVzcGVjdGluZyB0aGUgdXNlcnMgd2lzaA0KZm9yIHJlc2l6aW5nLg0KU2F2ZSB0
aGUgc2FzaCBwb3NpdGlvbiB3aGVuIHRoZSBzYXNoZXMgYXJlDQptb3ZlZCB0byBtYWtlIHRoZW0g
a2VlcCB0aGVpciBwb3NpdGlvbiB3aGVuDQp0aGUgd2luZG93IGlzIHJlc2l6ZWQgYWZ0ZXJ3YXJk
cy4NCg0KV2hlbiB0aGUgZ2l0ayB3aW5kb3cgaXMgb3BlbmVkIGFuZCBtYXhpbWl6ZWQNCm9uIGEg
c2NyZWVuLCB0aGVuIGNsb3NlZCBhbmQgb3BlbmVkIG9uIGENCnNjcmVlbiBzbWFsbGVyIHRoYW4g
dGhlIHByZXZpb3VzbHkgdXNlZCBvbmUsDQp0aGUgYXV0aG9yIHBhbmUgYW5kIHRpbWUgcGFuZSBv
ZiB0aGUgaGlzdG9yeQ0Kd2luZG93IG9ubHkgYXJlIGEgZmV3IHBpeGVscyB3aWRlIGFuZCB0aGVp
cg0KY29udGVudHMgYXJlIGJhcmVseSB2aXNpYmxlLg0KV2lkZW4gdGhlIHR3byBwYW5lcyBvbiBz
dGFydCBvZiBnaXRrIHRvIGENCnJlYXNvbmFibGUgZml4ZWQgc2l6ZSB0aGF0IHNob3dzIGEgZ29v
ZCBhbW91bnQNCm9mIHRleHQgb2YgYXV0aG9ycyBhbmQgdGltZS4NCg0KU2lnbmVkLW9mZi1ieTog
VG9iaWFzIEJvZXNjaCA8dG9iaWFzLmJvZXNjaEBtaWVsZS5jb20+DQotLS0NCg0KTm90ZXM6DQog
ICAgRGVidWcgcHJpbnQgc3RhdGVtZW50cyBhcmUgbGVmdCBpbiB0aGUgY29kZSBmb3IgZWFzaWVy
DQogICAgdGVzdGluZyBieSBtYWludGFpbmVycy4NCiAgICBUaGV5IHdpbGwgYmUgcmVtb3ZlZCB3
aGVuIHRoZSByZXZpZXcgaXMgZmluaXNoZWQuDQoNCiBnaXRrLWdpdC9naXRrIHwgNDEgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNDEg
aW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZ2l0ay1naXQvZ2l0ayBiL2dpdGstZ2l0L2dp
dGsNCmluZGV4IDdmNjJjODA0MWQuLjZmYmMyNTg4ZmIgMTAwNzU1DQotLS0gYS9naXRrLWdpdC9n
aXRrDQorKysgYi9naXRrLWdpdC9naXRrDQpAQCAtMjQ3MSw2ICsyNDcxLDIzIEBAIHByb2MgbWFr
ZXdpbmRvdyB7fSB7DQogICAgICAgICAteHNjcm9sbGluY3IgJGxpbmVzcGMgXA0KICAgICAgICAg
LXlzY3JvbGxpbmNyICRsaW5lc3BjIC15c2Nyb2xsY29tbWFuZCAic2Nyb2xsY2FudiAkY3Njcm9s
bCINCiAgICAgLnRmLmhpc3RmcmFtZS5wd2NsaXN0IGFkZCAkY2Fudg0KKyAgICBiaW5kIC50Zi5o
aXN0ZnJhbWUucHdjbGlzdC5jYW52IDxDb25maWd1cmU+IHsNCisgICAgICAgIGdsb2JhbCBvbGRz
YXNoDQorICAgICAgICBzZXQgcGFyZW50IFtyZWdzdWIge1wuW0EtWmEtel0rJH0gJVcgIiJdDQor
ICAgICAgICBwdXRzICJDYW52YXMgKHB3Y2xpc3QpIGNvbmZpZ3VyYXRpb24gY2hhbmdlZCBzYXZp
bmcgc2FzaCBcDQorICAgICAgICAgICAgICAgIHBvc2l0aW9uIGlmIHBhcmVudCBwYW5lZHdpbmRv
dyAkcGFyZW50IGlzIGluaXRpYWxpc2VkIFwNCisgICAgICAgICAgICAgICAgKG9sZHNhc2ggZXhp
c3QpIg0KKyAgICAgICAgaWYge1tpbmZvIGV4aXN0cyBvbGRzYXNoKCRwYXJlbnQpXX0gew0KKyAg
ICAgICAgICAgIHNldCBzMCBbJHBhcmVudCBzYXNocG9zIDBdDQorICAgICAgICAgICAgc2V0IHMx
IFskcGFyZW50IHNhc2hwb3MgMV0NCisgICAgICAgICAgICBwdXRzICIgICBTYXNoMCBpcyAkczAi
DQorICAgICAgICAgICAgcHV0cyAiICAgU2FzaDEgaXMgJHMxIg0KKyAgICAgICAgICAgIHNldCBv
bGRzYXNoKCRwYXJlbnQpIFtsaXN0ICRzMCAkczFdDQorICAgICAgICAgICAgcHV0cyAiICAgb2xk
c2FzaCBzYXZlZCBmb3IgJHBhcmVudCINCisgICAgICAgIH0gZWxzZSB7DQorICAgICAgICAgICAg
cHV0cyAiICAgb2xkc2FzaCBub3QgeWV0IGV4aXN0aW5nIHNvIG9sZHNhc2ggaXMgbm90IHNhdmVk
IGZvciAkcGFyZW50Ig0KKyAgICAgICAgfQ0KKyAgICB9DQogICAgIHNldCBjYW52MiAudGYuaGlz
dGZyYW1lLnB3Y2xpc3QuY2FudjINCiAgICAgY2FudmFzICRjYW52MiBcDQogICAgICAgICAtc2Vs
ZWN0YmFja2dyb3VuZCAkc2VsZWN0Ymdjb2xvciBcDQpAQCAtMzExNiwzMCArMzEzMyw1MyBAQCBw
cm9jIHNhdmVzdHVmZiB7d30gew0KDQogcHJvYyByZXNpemVjbGlzdHBhbmVzIHt3aW4gd30gew0K
ICAgICBnbG9iYWwgb2xkd2lkdGggb2xkc2FzaA0KKyAgICBwdXRzICJTdGFydGluZyByZXNpemVj
bGlzdHBhbmVzLi4uIg0KICAgICBpZiB7W2luZm8gZXhpc3RzIG9sZHdpZHRoKCR3aW4pXX0gew0K
ICAgICAgICAgaWYge1tpbmZvIGV4aXN0cyBvbGRzYXNoKCR3aW4pXX0gew0KKyAgICAgICAgICAg
IHB1dHMgIiAgIFVzaW5nIG9sZHNhc2ggZnJvbSB3aW5kb3ciDQogICAgICAgICAgICAgc2V0IHMw
IFtsaW5kZXggJG9sZHNhc2goJHdpbikgMF0NCiAgICAgICAgICAgICBzZXQgczEgW2xpbmRleCAk
b2xkc2FzaCgkd2luKSAxXQ0KKyAgICAgICAgICAgIHB1dHMgIiAgIFNhc2gwIGlzICRzMCINCisg
ICAgICAgICAgICBwdXRzICIgICBTYXNoMSBpcyAkczEiDQogICAgICAgICB9IGVsc2Ugew0KKyAg
ICAgICAgICAgIHB1dHMgIiAgIE5ldyB3aW5kb3cgY3JlYXRpb24gZGV0ZWN0ZWQiDQorICAgICAg
ICAgICAgcHV0cyAiICAgV2lkdGggaXMgJHciDQorICAgICAgICAgICAgcHV0cyAiICAgVXNpbmcg
c2FzaCBmcm9tIHdpbmRvdyBzYXNocG9zIGRpcmVjdGx5Ig0KICAgICAgICAgICAgIHNldCBzMCBb
JHdpbiBzYXNocG9zIDBdDQogICAgICAgICAgICAgc2V0IHMxIFskd2luIHNhc2hwb3MgMV0NCisg
ICAgICAgICAgICBwdXRzICIgICBTYXNoMCBpcyAkczAiDQorICAgICAgICAgICAgcHV0cyAiICAg
U2FzaDEgaXMgJHMxIg0KKyAgICAgICAgICAgIGlmIHskczEgPiAkdyAtIDE0MH0gew0KKyAgICAg
ICAgICAgICAgICBwdXRzICIgICAgICBTYXNoMSBncmVhdGVyIHRoYW4gd2lkdGggLSAxNDAsIHNl
dHRpbmcgbWF4IHNpemUiDQorICAgICAgICAgICAgICAgIHNldCBzMSBbZXhwciB7JHcgLSAxNDB9
XQ0KKyAgICAgICAgICAgICAgICBpZiB7JHMwID4gJHMxIC0gMzAwfSB7DQorICAgICAgICAgICAg
ICAgICAgICBwdXRzICIgICAgICAgICBTYXNoMCBncmVhdGVyIHRoYW4gc2FzaDEgLSAzMDAsIHNl
dHRpbmcgbWF4IHNpemUiDQorICAgICAgICAgICAgICAgICAgICBzZXQgczAgW2V4cHIgeyRzMSAt
IDMwMH1dDQorICAgICAgICAgICAgICAgIH0NCisgICAgICAgICAgICB9DQogICAgICAgICB9DQog
ICAgICAgICBpZiB7JHcgPCA2MH0gew0KKyAgICAgICAgICAgIHB1dHMgIiAgIE5hcnJvdyB3aW5k
b3cgKCR3KSwgc2NhbGluZyBzYXNoIGluIGRlcGVuZGVuY3kgdG8gd2luZG93IHdpZHRoIg0KICAg
ICAgICAgICAgIHNldCBzYXNoMCBbZXhwciB7aW50KCR3LzIgLSAyKX1dDQogICAgICAgICAgICAg
c2V0IHNhc2gxIFtleHByIHtpbnQoJHcqNS82IC0gMil9XQ0KICAgICAgICAgfSBlbHNlIHsNCisg
ICAgICAgICAgICBwdXRzICIgICBXaWRlIHdpbmRvdyAoJHcpLCBzY2FsaW5nIHNhc2ggaW4gZGVw
ZW5kZW5jeSB0byBvbGQgd2lkdGgsIG9sZHNhc2ggYW5kIHdpbmRvdyB3aWR0aCINCiAgICAgICAg
ICAgICBzZXQgZmFjdG9yIFtleHByIHsxLjAgKiAkdyAvICRvbGR3aWR0aCgkd2luKX1dDQogICAg
ICAgICAgICAgc2V0IHNhc2gwIFtleHByIHtpbnQoJGZhY3RvciAqIFtsaW5kZXggJHMwIDBdKX1d
DQogICAgICAgICAgICAgc2V0IHNhc2gxIFtleHByIHtpbnQoJGZhY3RvciAqIFtsaW5kZXggJHMx
IDBdKX1dDQogICAgICAgICAgICAgaWYgeyRzYXNoMCA8IDMwfSB7DQorICAgICAgICAgICAgICAg
IHB1dHMgIiAgICAgIFNhc2gwIHRvbyBzbWFsbCwgc2V0dGluZyBtaW4gc2l6ZSINCiAgICAgICAg
ICAgICAgICAgc2V0IHNhc2gwIDMwDQogICAgICAgICAgICAgfQ0KICAgICAgICAgICAgIGlmIHsk
c2FzaDEgPCAkc2FzaDAgKyAyMH0gew0KKyAgICAgICAgICAgICAgICBwdXRzICIgICAgICBTYXNo
MSBzbWFsbGVyIHRoYW4gc2FzaDAgKyAyMCwgc2V0dGluZyBtaW4gc2l6ZSINCiAgICAgICAgICAg
ICAgICAgc2V0IHNhc2gxIFtleHByIHskc2FzaDAgKyAyMH1dDQogICAgICAgICAgICAgfQ0KICAg
ICAgICAgICAgIGlmIHskc2FzaDEgPiAkdyAtIDEwfSB7DQorICAgICAgICAgICAgICAgIHB1dHMg
IiAgICAgIFNhc2gxIGdyZWF0ZXIgdGhhbiB3aWR0aCAtIDE0MCwgc2V0dGluZyBtYXggc2l6ZSIN
CiAgICAgICAgICAgICAgICAgc2V0IHNhc2gxIFtleHByIHskdyAtIDEwfV0NCiAgICAgICAgICAg
ICAgICAgaWYgeyRzYXNoMCA+ICRzYXNoMSAtIDIwfSB7DQorICAgICAgICAgICAgICAgICAgICBw
dXRzICIgICAgICAgICBTYXNoMCBncmVhdGVyIHRoYW4gc2FzaDEgLSAzMDAsIHNldHRpbmcgbWF4
IHNpemUiDQogICAgICAgICAgICAgICAgICAgICBzZXQgc2FzaDAgW2V4cHIgeyRzYXNoMSAtIDIw
fV0NCiAgICAgICAgICAgICAgICAgfQ0KICAgICAgICAgICAgIH0NCkBAIC0zMTQ5LDYgKzMxODks
NyBAQCBwcm9jIHJlc2l6ZWNsaXN0cGFuZXMge3dpbiB3fSB7DQogICAgICAgICBzZXQgb2xkc2Fz
aCgkd2luKSBbbGlzdCAkc2FzaDAgJHNhc2gxXQ0KICAgICB9DQogICAgIHNldCBvbGR3aWR0aCgk
d2luKSAkdw0KKyAgICBwdXRzICJGaW5pc2hlZCByZXNpemVjbGlzdHBhbmVzLi4uIg0KIH0NCg0K
IHByb2MgcmVzaXplY2RldHBhbmVzIHt3aW4gd30gew0KLS0NCjIuNDcuMS53aW5kb3dzLjINCg0K
DQoNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KaW1wZXJpYWwt
V2Vya2Ugb0hHLCBTaXR6IELDvG5kZSwgUmVnaXN0ZXJnZXJpY2h0IEJhZCBPZXluaGF1c2VuIC0g
SFJBIDQ4MjUNCg==
