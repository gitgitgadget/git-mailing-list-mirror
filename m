Received: from esa2.hc2065-58.eu.iphmx.com (esa2.hc2065-58.eu.iphmx.com [194.165.193.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCE31EB191
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=194.165.193.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743775999; cv=fail; b=qvqvMgvAwtLyWa85i/AXQbnFFbgSAlnTYV3BpkrQ0jBBVLYiTrjJlxf5nlzIKggXfw9dkndJCE972KuOzZzlirMR+Ntw5JwnvP8B6FVj4B+EAWV9KtWYcjKAoS0LN8xhzPQcUKe+QVpq2MxQL8gjwxe6t/CYWOaBiATAUZIKWg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743775999; c=relaxed/simple;
	bh=jgwf/VkDp6a4PkhmLMn4ky/PLIwcD0z5f2yevSADsGA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eurKpY9W6vjBV7KdCaOaNXgOVVa0KRECsMNAe/DOTBwaziv0EvN4mP6cvbWRVqovtLED3QqcemCd+q68M4iSO9Fu7ANwz214KiFXeJvzH1X6e+w4giLCf+aECa10px5eibKICgR9DxGUTgdwR2ydgf6sIN4tpg3Fp2vIWPFO3j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=capgemini.com; spf=pass smtp.mailfrom=capgemini.com; dkim=pass (2048-bit key) header.d=capgemini.com header.i=@capgemini.com header.b=ol4jsYug; arc=fail smtp.client-ip=194.165.193.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=capgemini.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=capgemini.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=capgemini.com header.i=@capgemini.com header.b="ol4jsYug"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=capgemini.com; i=@capgemini.com; q=dns/txt; s=group3;
  t=1743775991; x=1775311991;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=jgwf/VkDp6a4PkhmLMn4ky/PLIwcD0z5f2yevSADsGA=;
  b=ol4jsYug+7AFdS6Qpg7ntd8O12gZ8RoCk4flDE5vxZVHVkk+XgZ5f/fD
   Co9rczhQA3D3wSf0PjaZ4FanxP5iufDJirPeyFuuy90QEIfI6XZOLktiB
   pqgO31ofr7LHfnRI/Ju3ILexrhEJTw0s0kiiNvF+G4dky4ecjrAWbJhDY
   O6/GnnINr+xqjBecHaylTbGP5ZtiaMRByfEDyhP5qW+Fe6GI28SBiaQyX
   LO2NbxlgmH+um+ZYUy/eSHilTb+a7S9NbcY7Lqia7JrqkeKJERJNVei2X
   uzJyKcF5s84TSWpPH03iB0+V1MqVQ7ntL32yTqYN9zUxI4mZtyQlVyTpz
   w==;
X-CSE-ConnectionGUID: 4xc+Ya53TUKyAbO0zjPtSA==
X-CSE-MsgGUID: YzFKDBW2TSy8y3m0kWodyA==
X-IronPort-AV: E=Sophos;i="6.13,221,1732575600"; 
   d="scan'208";a="21103729"
Received: from spffrpar02.capgemini.com ([194.4.230.74])
  by ob1.hc2065-58.eu.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Apr 2025 16:12:02 +0200
X-CSE-ConnectionGUID: NHyHCDaDSR2+DG8bkszFAg==
X-CSE-MsgGUID: BJQQxqtTQhu4aeCMk37Bng==
X-IronPort-AV: E=Sophos;i="6.15,188,1739833200"; 
   d="scan'208";a="367355768"
Received: from intdlp.capgemini.com (HELO gddlppraplv03d.corp.capgemini.com) ([10.247.137.141])
  by IRFRPAR-C695-02-D2-incoming.capgemini.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 16:11:52 +0200
Received: from GDDLPPRAPLV03D.CORP.CAPGEMINI.COM (GDDLPPRAPLV03D.CORP.CAPGEMINI.COM [127.0.0.1])
	by GDDLPPRAPLV03D.CORP.CAPGEMINI.COM (Service) with ESMTP id CE38C6002C02;
	Fri,  4 Apr 2025 16:11:51 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (unknown [104.47.11.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by GDDLPPRAPLV03D.CORP.CAPGEMINI.COM (Service) with ESMTPS id A7AF06002C1C;
	Fri,  4 Apr 2025 16:11:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsW8kltGMb4eIdJj2BTus8urm5ow8Iyh96+t7wPwah19VtvdL4GAjGSkGKOpXSbMoVvGrftRmRDEC6MdGk0Kcu+3bpsTN0jvSCRVF52ISFr/CNkzyrVTfAsCHh/L4SGSW6A82IoaX7A2eajz2o7CEy+9NQ4V5cNvjDyPpXdfJIiQXY7v469qJi4Hx2mW5j1wktdTw6pegLEoTh6e0cn0odTc1R6k+apnyxQ0v20rw/OThREIInIdAdF4LrVXpBpTuAGdLH9oj/JZtp9y331Pu9hW0NMf6d28HKM/TxtUqydDqgGnzuEDQ6p08osERthsh58IhI7D840we0smm3sfjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xg14zK1tK5DAT8QKMczeWjLXV48+q9oZU3FztSmpoXs=;
 b=L5rLFiCAX1uKOyMLo8A69kECFJ0NIcSvnMwflovZnBAgpyW5RkFFz8pYbuOyL1seOluGYZRnfcqm0EO0rKdoefTjdp8aYPI0WPP5tkzU5hdfQAsB0sssxdzhzOl8gRVI4OF7x34dF7DdG0o+uM0ZRKm+A0VGExwUXK6tlNjH979TkiJqRVeVVUd/q0WCbrD17Bq9K9tcjq62osYqaAAM4qL6XqGrxwlIpqFijoHYci07e79toxZ/CYtxgdprf6gcypjSaQHHtSh76IgxT6vBnJNmqxa4eEylqrTony2SLtJO0AJaNevu+IJUGT+7dTalSZZa9QMxtnswE4PFXvZWMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=capgemini.com; dmarc=pass action=none
 header.from=capgemini.com; dkim=pass header.d=capgemini.com; arc=none
Received: from VI1PR02MB6495.eurprd02.prod.outlook.com (2603:10a6:800:193::8)
 by AS8PR02MB8804.eurprd02.prod.outlook.com (2603:10a6:20b:537::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 4 Apr
 2025 14:11:50 +0000
Received: from VI1PR02MB6495.eurprd02.prod.outlook.com
 ([fe80::1c49:fbf5:fc0f:25b7]) by VI1PR02MB6495.eurprd02.prod.outlook.com
 ([fe80::1c49:fbf5:fc0f:25b7%6]) with mapi id 15.20.8534.043; Fri, 4 Apr 2025
 14:11:50 +0000
From: =?utf-8?B?SG9od2lsbGVyLCBKw7ZyZw==?= <joerg.hohwiller@capgemini.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [Windows] Severe problems after upgrading to 2.48.1.windows.1
Thread-Topic: [Windows] Severe problems after upgrading to 2.48.1.windows.1
Thread-Index: AduMRF1FlKoLPIQySq6CTv27PYhTgQW2LrCAAGlPe7A=
Date: Fri, 4 Apr 2025 14:11:49 +0000
Message-ID:  <VI1PR02MB6495A9779866FD337F2F8E1CFBA92@VI1PR02MB6495.eurprd02.prod.outlook.com>
References:  <VI1PR02MB64955FD0B8A0B8C4438F605FFBC92@VI1PR02MB6495.eurprd02.prod.outlook.com>
 <d3f55106-8f87-b535-1c7c-29d382378342@gmx.de>
In-Reply-To: <d3f55106-8f87-b535-1c7c-29d382378342@gmx.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=capgemini.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB6495:EE_|AS8PR02MB8804:EE_
x-ms-office365-filtering-correlation-id: 07dcafc5-a52c-4815-2afe-08dd7382a492
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:  BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:  =?utf-8?B?ZngwVUR0VCtEUFVSSmppZ1hyVDVrWi9wRFEyWkd2OVlydTJXd2pRRmhSd0VK?=
 =?utf-8?B?b3VSQmMrdFNKNlZDakdLZEdadG9hSDBOcWYvRnpoU1d6M09GSzZvMU9qVTlT?=
 =?utf-8?B?Qzl0SEZyUFB0c0dWYWFMa2FRWWp3UkZMUmxkSktqYy9ZbHVxWU01Y0s0VVRK?=
 =?utf-8?B?Zjk0THJoV2crb1pES012cEtzelE1eURtK1FYVVhTTkIwa0ZXYlJwaUxBd2NF?=
 =?utf-8?B?Ulg5NWFJOFMvYVloR1AzVGF3WVZTczVaVm92NTlOTXZMVEl4bVlFeE1tZmJX?=
 =?utf-8?B?ZEd3UGJnUWg4Ry8rM3hPSHRnMVFxZ1hUT2QrM3JwejRSSUpERUZxbUFkTHlP?=
 =?utf-8?B?dmMxeGpRR3J1V1F3bVNycHkzVVNTeVN5cDhBWThXSVdldmVXcUNkSnJUUHFm?=
 =?utf-8?B?enU4QmN3SzBwSjZSWVRtdnk0dVNPelJyTFVLdDRkd0FQZU9qV1ZhbkZ1VUR4?=
 =?utf-8?B?MHh3RVFTZUl6ekJlZVJVZm91Z0NQNnl0OEJTQmlSVUxWRksxckIyejZweDlu?=
 =?utf-8?B?MlliTkd4Rm1tVFFSTThMRjNxdmNTSlA0Rld4WW14OElsWjIzZFo4N3hTZEtx?=
 =?utf-8?B?VDhucmtpcUhyaW9zSS91UFhmVkRrZUJCcmd1dStFTDRjczRjZWR6UERoaXNn?=
 =?utf-8?B?eFphdFdZTHl0VmdxclB2ZE5NMG5zNDR0SFUwNktySDdmSm5iMVpYU214cDNF?=
 =?utf-8?B?VXQ4ckJHdndqYlpzVm1vWXRMWmtzeU15ZmlzT1NWaU43UlQrWVNVRGh0QnZv?=
 =?utf-8?B?SnlNNjhWWWZYekxjSXFBVXc1bUNySGR1dUM3VXlBcEV5bUR3NkhwWkROM0RS?=
 =?utf-8?B?eEZyUlpwUEVTb0hGRTNkQVVhUS9aaVNhZCtzMDZ5N1NTRk51dFl1dCtyNU5s?=
 =?utf-8?B?U3VpbVFPQnJwS3ArUHZLUEpaT0ljTUZPbFpCZEw5MnZ2N2VidDVXMUJpekpy?=
 =?utf-8?B?M3dCeC9UekJFdW11czB2V2tkcDVVblA2Z1pPUHY0RnNxUGFlZHdleTU2ZjFt?=
 =?utf-8?B?K3U3ZTVzZjVrVlArL0NKaVpaNnc5cG92TXV6Ull1WGlzZDlVNHhxQisxdXRl?=
 =?utf-8?B?cEJvaCtlSlZpUlY4UVgvR1RvY2VYQ2tnVGlhNVVyb0lKOXRsbHdKMXF0ZWpx?=
 =?utf-8?B?b01DZ2h2cHRQL2lzeHZsSUxFaHdFSVRaT3V0cysvSGtGMkx0c3JKdTNranhO?=
 =?utf-8?B?aWFBSzFJNGkxV0pKbVZmN0pGRVNKK1BoTXZGSkdRZHowRVNPclpBYXRqeG5k?=
 =?utf-8?B?bFdoL0tPaTdXMSt0WUJFR0NYNjdZSys2K0o3UnE0dERXKzFkT2lldThZUlAx?=
 =?utf-8?B?Q1R2M2RBVVd0NmlpNEtuTXlJUTMwZk1ZNHJwekZoVTJrWEZ4ZEc4cUxzOUgz?=
 =?utf-8?B?VFZjcVBHYldkb1RmRFAzMEJBakFpam1Kam0rMTErc3RodWxLL2RMTng2L3JZ?=
 =?utf-8?B?Wk02cURHV1lIMDQxTWRrUEdqRDZsaHp5T2JFUllYdHdpTXNVTlJiNlQxd1NI?=
 =?utf-8?B?b2J5ZVNQVjBJTlhPZEpacnlHOElQcWxXT1B2R3JhcldGYStJUW1zdDcyMlhJ?=
 =?utf-8?B?YWlGNlMvOWdyWFFQeGRKdzZIM2NQSW1HSjlLSFc0cWh1MFlQR3dyRTRBZERn?=
 =?utf-8?B?eWNjaTljdlRGRnNXRUNSMG1pK0pGdWw1Uk5rMFZtd2ZkY1BSdjh1ZFdJUXhR?=
 =?utf-8?B?by9WYjZHbmpGTHQrR0NTVko4aGpUc3J6ZmdtT2JNZUg2eXE1bWVobzFrWUNZ?=
 =?utf-8?B?OFhBdjZVMDVoTkdOd1MrQ0Q2YU9nc1hDT0ZwV00xSHd4eEFoOVhZZnBLQnlP?=
 =?utf-8?B?bHYyN2VmRkh1UVlVaVFpS1Q4UU1Pd1BzK2dhRms1SVYwbVpScnAxeFEweFRi?=
 =?utf-8?B?bXpCNFhJNU1WVXNGblova2NlQnFRaU5EdVlxM3dObGptU05TcENMRGdtc3Bk?=
 =?utf-8?Q?0ssUrJEUL1zJcs8XMBWYtNo98fhNFPcl?=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB6495.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?bDNBb3RHQjNtMCtGOVFyOGZkakp2QUpoak1LcXRqVnQ4dUdzeWpTR3BaUXhL?=
 =?utf-8?B?WjB3SWU2Vm1zWmhlVTFyaGdyQ08vclBYNmV4cUx1bUk1QXBWd0tLb1BZeWRi?=
 =?utf-8?B?Unh4VkZCL2ZWVlRpS0xYQ0J0MjU5azRvVjlPTVhTMUR4eERFTTFDWUozQ2JX?=
 =?utf-8?B?dzN2MTd2VXh4WU1RYXRiRktUN2U5TXhRSDlJaXo1ZmFzSVJzMklkclBtekY2?=
 =?utf-8?B?OG5qbllTWVZGNXRKaDF6ait2YkdIYlpqblk2TWZXUWdzdDNhbmpYWGN3UWZ2?=
 =?utf-8?B?cTRybnFPdHJGQ256Yy9Qc2tId05FS0kwQWh0UFlTYjZweGQyNlVia012czBL?=
 =?utf-8?B?cnVSUFFrNkdEMlJyaVdkMFpLQW5PbHR5WkF5UExRQnpMWGJ1SVE5Yi9YUGc4?=
 =?utf-8?B?bU4ydFJaZEJXa3I5RHJxQkN5M0FPMVB4SFFkWWtaZ0hXMXJzemxSTjFCMm9B?=
 =?utf-8?B?WVlxcHpSUW9lNTc5UWN4bzJ0T1hDdGJ6MkgxVUxPQzBWaXZhMzdnbGtZd3pi?=
 =?utf-8?B?VnZJQlIvOVpnTDZxTEhUOWJXMml5YnVlWlZZNUZOSnM0aVVBdDB4STh4Y2dh?=
 =?utf-8?B?RGhvWVp6eDI2bjV0VEl2UkVJSHVLbDM2enhEWHZldDZRU3RIbkJRQ3M2S3dS?=
 =?utf-8?B?V1hNb3BkZ1NVOHlvM3hiN1BkTEZDdENna2hJUE5SbUg0VWZCT2FoS2hvMko3?=
 =?utf-8?B?b1U5WmMybWQ3MGVJZkpaMExqWUZGeVBkS1FVUjdKUnpNcmRhRkdWZndOMjkr?=
 =?utf-8?B?TWVYQVlqemdZTkRIVWJ2M2pZVnB5VzJJdXpjcDFlQ29vdHdGMzBCWnhNdndr?=
 =?utf-8?B?blYxQVZ5ZWNpYU11RkNubWJtR0hXcThidmZzc0dMSmZrd1hMeWZzcVhNbGdW?=
 =?utf-8?B?c0Y3MU9GcDVMSzFNa1I2WjVZMk4ybE9xRjBpS1JTdWZlRVZwU0c1R3Y3YVYz?=
 =?utf-8?B?WVZjckhFSjV6ZzlKamljMWt6RDdCYkZGRXExdktMVitQKzBoQ3BqaDB3bnpC?=
 =?utf-8?B?ZEd5QmpIdllmcXpEZ0Q4czdMcSsxUUdQYjVNbVpPL2JaY2RBcDJDSCs2ckUv?=
 =?utf-8?B?dGMxSitZUE1xcnNocmF2SEt2NXRSY0tDb2g2Y0V4UVZuSGhHWUVHNzRrempj?=
 =?utf-8?B?elI0cHIrYnRJWkxLa0lZZ20zZ0FaMmNXdkNxRW9UeTR5M0Fac1JQelZIOHRm?=
 =?utf-8?B?bjZhZnVkc2JYOThqN3BzYjFVZFpTVUQ4OGE3ZmZIQTd3c1lOcUZnN3d5UzlE?=
 =?utf-8?B?QjhmTmhtYWRxeGxETG1IcEY4VXNNNEkvK3M5YzNHZWJQNExyTDBzc0JjUDBp?=
 =?utf-8?B?cnBHZzVjL2UyUFAzNDBBQlBzNnRIb3RLS0NTVlg3K0JXWmo3NGNKM0ovanJq?=
 =?utf-8?B?U3NpMmFWa0ZUTEhicS9KUmJ1M1M1eU9PT1pmb1MzU0JPRmpwZFhNNzVvZVVF?=
 =?utf-8?B?OVNKU3pLYWhzWkw5ZDRFQ0tSNjVkdEIwUTZrd0VqNHF1WGJKZXEwYWpDWVIv?=
 =?utf-8?B?M3owVUFtaE8zQVBJUG5BbGh0R3BiZDVNWWVNWnYzVktESWVTTFZmeW1vclJm?=
 =?utf-8?B?KzNPRkVMNXZOd1ZSUVBqdE9mNUV4QU1qQXRrUnVQWTEwQlgyZGdod1l3STVl?=
 =?utf-8?B?S1RBbThlZVAwbGNZVlU5YVhJam5ycXhDQVFaNE1xb3JMUW4yVnhhckJLK2Jv?=
 =?utf-8?B?MEZQQ1JzVlBMVWZlcmxtMkNyOEZWT3FjQlA4RzBubUZ3RGl6ckRUWkZ1S2k4?=
 =?utf-8?B?TVdlaE5aTCtkQjJybG15a3k0WW5aMDJzcU5EQkR4NFh1N1FhTGxIQ2VmTWt2?=
 =?utf-8?B?SDU3MHJHTTNUTGdudXpiN2IrSjFReldhM3A3S2lFRUE5RnhpNkVFcC9uQTB1?=
 =?utf-8?B?dWhpQ01mU2F1U1Rubk5yaVY5VU5NanQxZXN2UVJoZDk1WHNmMlF4NUp5Slc0?=
 =?utf-8?B?RDZoVXo3VHB6NGUwUWJNVGdPbHprcERoajJPU25nUHJHdEFhZEd3Snp0RWl2?=
 =?utf-8?B?S2JnZU1CdlZPdzNFSFlmUVlWS1Y1bXJTSVBtRml3YWFpMHI4TEVEWXNqMDlm?=
 =?utf-8?B?WURtMzJvZmR0MUhZT01XR0JSMmpYWnFzY0UrRUUrN3IzWWsrR1dtWlpTU2pM?=
 =?utf-8?B?VlhWaUNIZ3ZIZHlTakNNTC9rV2NKQk9yVVU5Yi92UjFGSm4ybDRTNGd3TkpL?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: capgemini.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB6495.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07dcafc5-a52c-4815-2afe-08dd7382a492
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2025 14:11:49.9954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 76a2ae5a-9f00-4f6b-95ed-5d33d77c4d61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZII/h5JTt8vM+NMpSg96n0JZDpp0jkHv9BuNVrn4JZsGsYZPtkv2t1h8WOv8MIRc5PodtYeHRC6qp3P1d6hilv9y3Bud7XTd4xlBU0xnWas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8804
Content-Transfer-Encoding: base64

SGkgSm9oYW5uZXMsDQoNClRoYW5rcyBmb3IgeW91ciByZXNwb25zZSBhbmQgc3VnZ2VzdGlvbnMu
DQpJIGRvd25sb2FkZWQgYW5kIGluc3RhbGxlZCB0aGUgbGF0ZXN0IFNOQVBTSE9UOg0KDQokIGdp
dCAtdg0KZ2l0IHZlcnNpb24gMi40OS4wLndpbmRvd3MuMS43Lmc0Y2E3MWJhNTMxLjIwMjUwMzI2
MTIyMzA1DQoNCkhvd2V2ZXIsIHRoZSBlcnJvciBzdGlsbCByZW1haW5zLiBJIGNhbm5vdCBwdWxs
IG15IHJlcG8gd2l0aG91dCB0aGUgZXJyb3IgSSB3YXMgcmVmZXJyaW5nIHRvLg0KVGhpcyBibG9j
a3MgbXkgd29ya2Zsb3dzLg0KVGhlcmUgYXJlIHdvcmthcm91bmRzIGxpa2UgdXNpbmcgYGdpdCBw
dWxsIG9yaWdpbiBtYWluYCBtYW51YWxseSBpbiBnaXQtYmFzaCBidXQgaXQgaXMgcXVpdGUgaW5j
b252ZW5pZW50IG5vdCBiZWluZyBhYmxlIHRvIHVzZSBnaXQgdmlhIEludGVsbGlKIG9yIGdpdC1m
b3JrIHdpdGhvdXQgZXJyb3JzLg0KDQpLaW5kIHJlZ2FyZHMNCiAgSsO2cmcNCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEpvaGFubmVzIFNjaGluZGVsaW4gPEpvaGFubmVzLlNj
aGluZGVsaW5AZ214LmRlPiANClNlbnQ6IFR1ZXNkYXksIEFwcmlsIDEsIDIwMjUgMTc6NDUNClRv
OiBIb2h3aWxsZXIsIErDtnJnIDxqb2VyZy5ob2h3aWxsZXJAY2FwZ2VtaW5pLmNvbT4NCkNjOiBn
aXRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1dpbmRvd3NdIFNldmVyZSBwcm9ibGVt
cyBhZnRlciB1cGdyYWRpbmcgdG8gMi40OC4xLndpbmRvd3MuMQ0KDQoqKioqKipUaGlzIG1haWwg
aGFzIGJlZW4gc2VudCBmcm9tIGFuIGV4dGVybmFsIHNvdXJjZS4gRG8gbm90IHJlcGx5IHRvIGl0
LCBvciBvcGVuIGFueSBsaW5rcy9hdHRhY2htZW50cyB1bmxlc3MgeW91IGFyZSBzdXJlIG9mIHRo
ZSBzZW5kZXIncyBpZGVudGl0eS4qKioqKioNCg0KSGkgSsO2cmcsDQoNCk9uIE1vbiwgMyBNYXIg
MjAyNSwgSG9od2lsbGVyLCBKw7ZyZyB3cm90ZToNCg0KPiBJIGp1c3QgdXBncmFkZWQgdG8gMi40
OC4xLndpbmRvd3MuMSAocmVpbnN0YWxsIHZpYSBHaXQtMi40OC4xLTY0LWJpdC5leGUpLg0KPiBB
bHNvIEkga2VwdCB0aGUgY2hlY2tib3ggdG8gY2FjaGUgZmlsZXMgKG5ldyBmZWF0dXJlPykg4oCT
IG1heWJlIGEgbWlzdGFrZSwgbGV0IHNlZS4NCg0KSWYgeW91IGFyZSByZWZlcnJpbmcgdG8gRlND
YWNoZSwgbm8gdGhhdCdzIG5vdCBhIG5ldyBmZWF0dXJlLg0KDQo+IEFmdGVyIHRoZSB1cGdyYWRl
LCBJIHB1bGxlZCBzb21lIHJlcG8gd2l0aCBnaXQtZm9yayBhbmQgZ290IHRoaXMgZXJyb3I6DQo+
IGVycm9yOiBjb3VsZCBub3QgZGVsZXRlIHJlZmVyZW5jZXM6IGNhbm5vdCBsb2NrIHJlZiAncmVm
cy9yZW1vdGVzL29yaWdpbi9idWdmaXgvWFktNzQ0ODgnOiBVbmFibGUgdG8gY3JlYXRlICdEOi9w
cm9qZWN0cy9wcm9qZWN0bmFtZS93b3Jrc3BhY2VzL21haW4vcHJvamVjdG5hbWUvLmdpdC9yZWZz
L3JlbW90ZXMvb3JpZ2luL2J1Z2ZpeC9YWS03NDQ4OC5sb2NrJzogRmlsZSBleGlzdHMuDQoNCldo
aWxlIHRoaXMgbG9va3MgZGlmZmVyZW50IHRoYW4NCmh0dHBzOi8vZ2l0aHViLmNvbS9naXQtZm9y
LXdpbmRvd3MvZ2l0L3B1bGwvNTUxNSAod2hlcmUgd3JpdGluZyB0byBhIFJlRlMgZHJpdmUgb24g
V2luZG93cyAyMDIyIHdhcyBicm9rZW4gYnkgYSByZWdyZXNzaW9uKSwgdGhlIHJvb3QgY2F1c2Ug
YXMgd2VsbCBhcyBpdHMgZml4IGNvdWxkIGJlIHRoZSBzYW1lLiBDYW4geW91IHRlc3QgdGhlIGxh
dGVzdCBzbmFwc2hvdCBhdCBodHRwczovL2dpdGZvcndpbmRvd3Mub3JnL2dpdC1zbmFwc2hvdHMv
IHRvIGNvbmZpcm0gb3IgcmVmdXRlIHRoaXMgaHlwb3RoZXNpcz8NCg0KQ2lhbywNCkpvaGFubmVz
DQoNCj4NCj4gSSBsb29rZWQgbG9jYWxseSAoZXZlbiBpbiBDTUQgd2l0aCBjb3B5ICYgcGFzdGUg
b2YgdGhlIGV4YWN0IGZpbGUgcmVmZXJlbmNlKSBidXQgdGhlIGxvY2sgZmlsZSBpcyBOT1QgdGhl
cmUuDQo+IEkgcmVwZWF0IHRoZSBwdWxsIGFuZCBnZXQgdGhlIHNhbWUgZXJyb3IsIGJ1dCBubyBz
dWNoIGxvY2sgZmlsZSBleGlzdHMuDQo+DQo+IFRvIGF2b2lkIGV4dGVybmFsIHNpZGUtZWZmZWN0
cyBmcm9tIGdpdC1mb3JrLCBJIG9wZW5lZCBhIG5ldyBnaXQtYmFzaCBhbmQgY2FsbGVkIOKAnGdp
dCBwdWxs4oCdIG1hbnVhbGx5IGluIHRoZSB0ZXJtaW5hbC4NCj4gVGhpcyBkaWQgbm90IGdpdmUg
bWUgYW55IGVycm9yIGJ1dCBnYXZlIG1lIHRoaXM6DQo+ICQgZ2l0IHB1bGwNCj4gRnJvbSBzc2g6
Ly9naXQuY29tcGFueS5jb20vcmVwb3MvcHJvamVjdG5hbWUNCj4gICAgNzI0NzdkNTdmMDI2Li5k
ZTc5ZjRkYmJmNjggIOKApg0KPiAqIFtuZXcgYnJhbmNoXSDigKYNCj4gKiBbbmV3IGJyYW5jaF0g
4oCmDQo+ICogW25ldyBicmFuY2hdIOKApg0KPiAqIFtuZXcgYnJhbmNoXSDigKYNCj4gKiBbbmV3
IGJyYW5jaF0g4oCmDQo+ICogW25ldyBicmFuY2hdIOKApg0KPiAqIFtuZXcgYnJhbmNoXSDigKYN
Cj4gICAgY2UzOTc5ZDYzOWQ3Li5iODBiNzBhNTZkYTcg4oCmDQo+ICQgZWNobyAkPw0KPiAxDQo+
DQo+IFNvIHdoYXQgY291bGQgYmUgdGhlIGVycm9yIGxlYWRpbmcgdG8gZXhpdCBjb2RlIDE/DQo+
DQo+IEFsbW9zdCB0aGUgc2FtZSBoYXBwZW5zIGZvciBnaXQtZmV0Y2guDQo+DQo+IEkgZG93bmdy
YWRlZCB0byBnaXQgdmVyc2lvbiAyLjQ3LjEud2luZG93cy4yIGFuZCBhZnRlciB0aGF0IHRyaWVk
IHRoZSBzYW1lIGFnYWluLg0KPiBBIGRpZmZlcmVuY2UgaXMgdGhhdCBub3cgSSBhZGRpdGlvbmFs
bHkgSSBnZXQgbG9ncyBsaWtlIHRoaXMgYXQgdGhlIA0KPiB0b3AgJCBnaXQgcHVsbA0KPiByZW1v
dGU6IEVudW1lcmF0aW5nIG9iamVjdHM6IDI2OSwgZG9uZS4NCj4gcmVtb3RlOiBDb3VudGluZyBv
YmplY3RzOiAxMDAlICgxNDMvMTQzKSwgZG9uZS4NCj4gcmVtb3RlOiBDb21wcmVzc2luZyBvYmpl
Y3RzOiAxMDAlICg0MS80MSksIGRvbmUuDQo+IHJlbW90ZTogVG90YWwgMjY5IChkZWx0YSA4OSks
IHJldXNlZCA4NyAoZGVsdGEgODcpLCBwYWNrLXJldXNlZCAxMjYgDQo+IFJlY2VpdmluZyBvYmpl
Y3RzOiAxMDAlICgyNjkvMjY5KSwgNTkuMzcgS2lCIHwgMi41OCBNaUIvcywgZG9uZS4NCj4gUmVz
b2x2aW5nIGRlbHRhczogMTAwJSAoOTQvOTQpLCBjb21wbGV0ZWQgd2l0aCA1MSBsb2NhbCBvYmpl
Y3RzLg0KPiBGcm9tIHNzaDovL2dpdC5jb21wYW55LmNvbS9yZXBvcy9wcm9qZWN0bmFtZQ0KPiDi
gKYNCj4gJCBlY2hvICQ/DQo+IDENCj4NCj4gTG9va3MgZmFtaWxpYXIuIElzIGl0IGEgYnVnIG9y
IGEgZmVhdHVyZSB0aGF0IHRoZSBsYXRlc3QgZ2l0IHN0b3BzIGxvZ2dpbmcgdGhlc2Ugc3RhdHVz
IGluZm9ybWF0aW9uPw0KPg0KPiBJIGhhdmUgdmFyaW91cyBvdGhlciBnaXQgcmVwb3MgdGhhdCBj
b250aW51ZSB0byB3b3JrIGZpbmUgc28gSSBub3cgcmF0aGVyIHRoaW5rIHRoYXQgdGhpcyBpcyBu
b3QgYSBnZW5lcmFsIGJ1ZyBpbiBnaXQgcHVsbC9mZXRjaCBidXQgcmVsYXRlZCB0byB0aGUgc3Bl
Y2lmaWMgcmVwby4NCj4gSG93ZXZlciwgdGhhdCB1c2VkIHRvIHdvcmsgZm9yIHllYXJzIGJlZm9y
ZSBJIHVwZ3JhZGVkIHRvZGF5Lg0KPg0KPiBTdGF0dXMgb24gdGhhdCByZXBvIHNheXM6DQo+ICQg
Z2l0IHN0YXR1cw0KPiBPbiBicmFuY2ggbWFpbg0KPiBZb3VyIGJyYW5jaCBpcyBiZWhpbmQgJ29y
aWdpbi9tYWluJyBieSAzODcgY29tbWl0cywgYW5kIGNhbiBiZSBmYXN0LWZvcndhcmRlZC4NCj4g
ICAodXNlICJnaXQgcHVsbCIgdG8gdXBkYXRlIHlvdXIgbG9jYWwgYnJhbmNoKQ0KPg0KPiBVbnRy
YWNrZWQgZmlsZXM6DQo+ICAgKHVzZSAiZ2l0IGFkZCA8ZmlsZT4uLi4iIHRvIGluY2x1ZGUgaW4g
d2hhdCB3aWxsIGJlIGNvbW1pdHRlZCkNCj4gICAgICAgICBmaW5kLXRlc3RzLnNoDQo+DQo+IG5v
dGhpbmcgYWRkZWQgdG8gY29tbWl0IGJ1dCB1bnRyYWNrZWQgZmlsZXMgcHJlc2VudCAodXNlICJn
aXQgYWRkIiB0byANCj4gdHJhY2spDQo+DQo+IFNvcnJ5IHRvIGJvdGhlciBidXQgZG8geW91IGhh
dmUgYW55IGZ1cnRoZXIgaGludHMgb3IgaWRlYXMsIHdoYXQgSSBjb3VsZCB0cnkgdG8gZml4IG15
IHByb2JsZW0/DQo+DQo+IEtpbmQgcmVnYXJkcw0KPiAgIErDtnJnDQo+DQo+DQo+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQo+DQo+IEZpcm1hOiBDYXBnZW1pbmkgRGV1dHNjaGxh
bmQgR21iSA0KPiBBdWZzaWNodHNyYXRzdm9yc2l0emVuZGVyOiBEci4gVm9sa21hciBWYXJuaGFn
ZW4NCj4gR2VzY2jDpGZ0c2bDvGhyZXI6IEhlbnJpayBManVuZ3N0csO2bSAoU3ByZWNoZXIpIOKA
oiBKb3N0IEbDtnJzdGVyIOKAoiANCj4gRmVsaXppdGFzIEdyYWViZXIg4oCiIFZlcmEgU2NoaWVy
aG9sdA0KPg0KPiBTaXR6OiBCZXJsaW4sIEFtdHNnZXJpY2h0IEJlcmxpbi1DaGFybG90dGVuYnVy
ZywgSFJCIDk4ODE0IFRoaXMgDQo+IG1lc3NhZ2UgY29udGFpbnMgaW5mb3JtYXRpb24gdGhhdCBt
YXkgYmUgcHJpdmlsZWdlZCBvciBjb25maWRlbnRpYWwgYW5kIGlzIHRoZSBwcm9wZXJ0eSBvZiB0
aGUgQ2FwZ2VtaW5pIEdyb3VwLiBJdCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIHRv
IHdob20gaXQgaXMgYWRkcmVzc2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBp
ZW50LCB5b3UgYXJlIG5vdCBhdXRob3JpemVkIHRvIHJlYWQsIHByaW50LCByZXRhaW4sIGNvcHks
IGRpc3NlbWluYXRlLCBkaXN0cmlidXRlLCBvciB1c2UgdGhpcyBtZXNzYWdlIG9yIGFueSBwYXJ0
IHRoZXJlb2YuIElmIHlvdSByZWNlaXZlIHRoaXMgbWVzc2FnZSBpbiBlcnJvciwgcGxlYXNlIG5v
dGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgYWxsIGNvcGllcyBvZiB0aGlz
IG1lc3NhZ2UuDQo+DQpUaGlzIG1lc3NhZ2UgY29udGFpbnMgaW5mb3JtYXRpb24gdGhhdCBtYXkg
YmUgcHJpdmlsZWdlZCBvciBjb25maWRlbnRpYWwgYW5kIGlzIHRoZSBwcm9wZXJ0eSBvZiB0aGUg
Q2FwZ2VtaW5pIEdyb3VwLiBJdCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIHRvIHdo
b20gaXQgaXMgYWRkcmVzc2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50
LCB5b3UgYXJlIG5vdCBhdXRob3JpemVkIHRvIHJlYWQsIHByaW50LCByZXRhaW4sIGNvcHksIGRp
c3NlbWluYXRlLCBkaXN0cmlidXRlLCBvciB1c2UgdGhpcyBtZXNzYWdlIG9yIGFueSBwYXJ0IHRo
ZXJlb2YuIElmIHlvdSByZWNlaXZlIHRoaXMgbWVzc2FnZSBpbiBlcnJvciwgcGxlYXNlIG5vdGlm
eSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgYWxsIGNvcGllcyBvZiB0aGlzIG1l
c3NhZ2UuCg==

