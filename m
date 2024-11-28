Received: from mx-relay112-hz1.antispameurope.com (mx-relay112-hz1.antispameurope.com [94.100.132.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3441482ED
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.132.104
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732782486; cv=fail; b=suyDi0bfitXjCFh8YHhflDQVcpJIdE2KOJd1qsCrDOjNh50JwdYrN6Oik8Ty3KlygTZvNb/AAMXbXmUo92rabP26vBf2K+mksLiXre4mhbvX0N4cO+Vo6oNCcUJTsCyHTnzPhZBtIlRjvy/MUatSQGSomdV5jupXZgx6XrACDdw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732782486; c=relaxed/simple;
	bh=B9+SK78fsvfZLZ3aH3Z8jKlBjX2UT948LxnTz+pp7Vw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cJnoTNzmx5HAT4KB5jI/W43CVTRwS0hxk1fr4qYilMHJEYQ2xo+eJmB6fl1Sp2ZKy+AlOh6aCijAm5q4Sk+2I+0rbPGZmfbX50L6wx4bnK9UNS2etXrpAD3Dmf24LaF+xJM/UqKH6ebInGYegSI8LarlDBRzH6IkorbNVur9yPM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=miele.com; spf=pass smtp.mailfrom=miele.com; dkim=pass (1024-bit key) header.d=miele365.onmicrosoft.com header.i=@miele365.onmicrosoft.com header.b=fbMXK/rr; dkim=pass (2048-bit key) header.d=miele.com header.i=@miele.com header.b=X9CtwEWg; arc=fail smtp.client-ip=94.100.132.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=miele.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miele.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=miele365.onmicrosoft.com header.i=@miele365.onmicrosoft.com header.b="fbMXK/rr";
	dkim=pass (2048-bit key) header.d=miele.com header.i=@miele.com header.b="X9CtwEWg"
ARC-Authentication-Results: i=2; mx-gate112-hz1.hornetsecurity.com 1;
 spf=fail reason=mailfrom (ip=104.47.11.49, headerfrom=miele.com)
 smtp.mailfrom=miele.com
 smtp.helo=eur02-vi1-obe.outbound.protection.outlook.com; dkim=pass
 header.d=miele365.onmicrosoft.com header.s=selector2-miele365-onmicrosoft-com
 header.a=rsa-sha256; dmarc=fail header.from=miele.com orig.disposition=reject
ARC-Message-Signature: a=rsa-sha256;
 bh=B9+SK78fsvfZLZ3aH3Z8jKlBjX2UT948LxnTz+pp7Vw=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1732782469;
 b=Sh05NYFcqkQ8nhQcr+XKYJ/QvdFgWXmcLaVmo9sQd95c9t2PGwHs+9+8kJg8swB9GDdFyY8M
 UDDsFI17JYfxb7ZYV8aSPt9BHwnS5S/1KctauSte8Tx4rB5XyIRYblbePMRabAqPkZLesOm0erO
 WQXL9u1DCcRE1e3BAQWf+5kLvixgJyTFFYZKJcZ8USSIQExx5x0l0aGLbMIQy6ePMWXO12DFCz7
 dwuhBu3ZWAuJky26HPyILS6+8sRgKZhmRCFrdaEvb0q04KqkmJoBSLt5pRRM7qKtrISRLaIHBSZ
 NB1wzb0PGlZQA7J2F5SI6n5vwIYEsV2bDH3qyQk7OLweA==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1732782469;
 b=Sc1ym2SMQwSxnbjDUBYW6Fqwr5pa/RFH991qSW5PhJHTx3TKr0WhJ9RZyJ0ccqmSLhth4V9w
 LO7FcqFSF3W/m1ilNBoIQwUGYmW2obCgJncR0lukUEgOH/EEjDk2iEMEa7g1A1k5obNCdS1P8H2
 WKH0eL+HetiaIh05pAYSLL5wGH+niW5a1M8rA5222NK/zXW/Jnr5SnByunZLcvB526HLJjCryHu
 K2b2JBwQf7Hgrx3e8uhkbgX7FvC9So4eKRVo8KelWU2hZnxWPc5zrNTPZAm6cEXzmTTBqAPxQbZ
 UooAgUF2ZarIg1dJXRtBWoAQtIOm/rtmEKL+dn2xmNfYQ==
Received: from mail-vi1eur02lp2049.outbound.protection.outlook.com ([104.47.11.49]) by mx-relay112-hz1.antispameurope.com;
 Thu, 28 Nov 2024 09:27:48 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYC/FudD8eCLsY1Akil3hsR8SwszjQJJ515o8V7nz1VytuuQBePMRAv2lvULhrahPCU1PU7Ofsi4tE4q+/nrhW/Za4CTMKocctZ95XY65+N0PWSbL4Qb1VRchTKFA1PEQY13PTYww10xixnAIR4VvJ7PImrySQ0nvL1/DJVC0FeIN351D+BWrFYJ6Rmg0neab14e1arX7AtMObK0FgXCbHYjN6TBTz5B8MI7hzpfO65C2+EZhydfrpqPpMDwGyJmZwlpI07tzERj/i9zuqYlXJvVoNER9VQ32IAmiEOZKH8iPG+MddmLdhIhC/oSHeGoEzf1jy/URsaLDM3UfHyp6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9+SK78fsvfZLZ3aH3Z8jKlBjX2UT948LxnTz+pp7Vw=;
 b=DrrNCnHefSdXHy/YMp1+35q5rr8oyaac3Heg98W8J4GNfzw8JGSJXT4pBCv+BAIqqwkYcmZt9BmZhKbmomZyiQJSP4vOYY6tXATMj3tgJOOf6OTPSijH05z5YkiPqWTtfJPzn+4gUpApW31T8Oy+UAnVagbAycQ0QUv34M1HHITtEQr6V7LnUd2wByiM9qU/U1Q1PHWYdRS/6q0HhXAyOX35wlj9mywt4u8xc1nxPo6iKG0xP8glfw561TGvWKEAJQcvvguWR2XURc1UqxNX4kb/tRHTFPM60W8LdI/Rd6RSi9GlRT9w5bIHRICmOjHeNM3GEocgqO1+G0W0TZ43NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=miele.com; dmarc=pass action=none header.from=miele.com;
 dkim=pass header.d=miele.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=miele365.onmicrosoft.com; s=selector2-miele365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9+SK78fsvfZLZ3aH3Z8jKlBjX2UT948LxnTz+pp7Vw=;
 b=fbMXK/rrrG2Rz8bg//Co3rLtUiAQOQ4Gm+4b90QI6nD2w6KEL+sC6z+AfZt0UFMmp2QJg5NeW0PgEtKsTosM+z4WzpDJYvoLbGj8gi9Gj3+rR+RZZF1EJBFU4kknShgYH/tTN+p+KDhg92xTbgiWOni1yIwx5sker2Rspf0HZVE=
Received: from AS2PR08MB8288.eurprd08.prod.outlook.com (2603:10a6:20b:557::8)
 by AS8PR08MB6631.eurprd08.prod.outlook.com (2603:10a6:20b:339::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 08:27:37 +0000
Received: from AS2PR08MB8288.eurprd08.prod.outlook.com
 ([fe80::85a6:7b0e:5297:24a]) by AS2PR08MB8288.eurprd08.prod.outlook.com
 ([fe80::85a6:7b0e:5297:24a%7]) with mapi id 15.20.8158.024; Thu, 28 Nov 2024
 08:27:37 +0000
From: "tobias.boesch@miele.com" <tobias.boesch@miele.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Understanding the diff output in gitk when comparing a commit with
 working tree
Thread-Topic: Understanding the diff output in gitk when comparing a commit
 with working tree
Thread-Index: AdtA4OPs1nnKTANCS4GUVi/jMt9kfAAjjn8Q
Date: Thu, 28 Nov 2024 08:27:37 +0000
Message-ID:
 <AS2PR08MB82880324292BB445428393B7E1292@AS2PR08MB8288.eurprd08.prod.outlook.com>
References:
 <AS2PR08MB82888F1C5AE63BD383E53FE6E1282@AS2PR08MB8288.eurprd08.prod.outlook.com>
In-Reply-To:
 <AS2PR08MB82888F1C5AE63BD383E53FE6E1282@AS2PR08MB8288.eurprd08.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_ActionId=52464080-0064-4d6a-aa05-e6f010cf7a09;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_ContentBits=0;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Enabled=true;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Method=Standard;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Name=General;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_SetDate=2024-11-27T14:51:22Z;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_SiteId=22991c1b-aa70-4d9c-85be-637908be565f;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=miele.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR08MB8288:EE_|AS8PR08MB6631:EE_
x-ms-office365-filtering-correlation-id: 8e1383c1-7255-4c53-2dbf-08dd0f86840f
x-miele-exorule: Spamfilter umgehen
x-miele-exorule-disclaimer-company-imperial: 1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YnhKdTVhUjZvNUM1dXpyay9qeVg2aEx3dVprK0pPVlFIN3JkeUlwTTYzU3Fy?=
 =?utf-8?B?UGdKdUd2Q0t4T2cyc3RReUM1Rzgwdk9RMmw3NnN3WGU5aG1yMDNqem5ZNGh0?=
 =?utf-8?B?K1ROWXNUcVBXR094U2JFTTlZbERmSGRPa242RlNEaW56dnFYK0NiQ2kzR0do?=
 =?utf-8?B?S2l6SXRnSVVvazVza1piZlBCaHhYcDZwWVEzamVEVDdSODZqbWhpV1oxNVIr?=
 =?utf-8?B?MnFWWGRWNGJvL1JOa1EvUWdLcmloV1pDV2k2UE5XYjVhS0VCa0JnYldxL3NI?=
 =?utf-8?B?clloUnNla1h2OGJiSEFUdUNoUjhjbUZKb0dCcm5QeHdrTnF6QTBDV3RpVldR?=
 =?utf-8?B?MWE0SXpsYXJZZW85OUR1Q3dIUFdDQm1oRlFiRG9KMDZSVWhXQzI3SG9VTnNx?=
 =?utf-8?B?bWR6ZDk1SHZyZG9IeVRodzJyT1J0K0NXbXNxYzg1V0pNM3VOdUp2SjFNbnVG?=
 =?utf-8?B?MFhZRGpoaDEwenNQbHZwQzQ2R2hSWWxWdFU1ODU2NTRHTHJMVmZJMVNlYlJO?=
 =?utf-8?B?L3dVQzVsVFZmbk9WMm5mcXpHNGFPV3BwRzFwTW5zSThtdy9lUDZKK3B6Y2Zs?=
 =?utf-8?B?NmloZVlOb3FHU1NPbmJ3UU5abjAxbkdOUDVoSVd3N296Y0ZZYS9rUW1Ya0JO?=
 =?utf-8?B?ZHlFSkM3bi85ZlhXRlcwY1dkSExocGphVHIvRlo0ZzlyYlhzQUl4c1FLNERC?=
 =?utf-8?B?SS92RGFPamxUQXZGcGQ3ZFVjZzd1eHhBamhSeFAybWdPUlplVVZFNVpNYTcw?=
 =?utf-8?B?SnF2eGdlNVRPbSs0TE54MXY1VzRXU1NRTlJUUWt0Y0srbXRsTmk5NjZ1blNh?=
 =?utf-8?B?S1dSN1VabzRESGtkNVk4TzFxOWNtcGNHMzlOTEF4Wjd3bVNWUTloZEdCWE1H?=
 =?utf-8?B?TVcydWRYU1pYNG1BSUNLaXJvaUNjU0VmeXdHUFR4cTBoNnN0SmJNSFRFcUtH?=
 =?utf-8?B?YXJhR2JGeVhPa2dGK0kyNXdta0VseE01TkNuaE1XZjYyWExzUW1YNnU3RjRu?=
 =?utf-8?B?cHB1YWRmRzFpSXZDL1g0TVcyOFM1YzAxR3Y1djRwY0JqcnM4UlFTcEd1NHNv?=
 =?utf-8?B?RG5oV01jU2s5SmNzekRxZzVtUlVkYlNmMU4wQlpqd2ZPajExelJ1clA4YkV1?=
 =?utf-8?B?WjZLNWkxaFJwTTZ5cWpaRzVvbHNicEFURFVQcW9ZS0VGTmIyaTIyWkF3Mk95?=
 =?utf-8?B?RXZyUGMvVTNzY2l2RlR4elUyVWdrZ2tmOHIxaFJVL0g1Q0MxR0RQV1k1Tzhm?=
 =?utf-8?B?R1VlQnlLTkRHNFZTcXdPUmtwUzd6eDF6RkhreTQ0S2xRYkZzRElVZktUOHNj?=
 =?utf-8?B?VDRoSFdjNlBlcnVzcmhJdUtTNkRSZkFmVko3Z3BQRDV1YzhSRi83OG1Dckkx?=
 =?utf-8?B?QTVicUIxaFdGUmhjMlhRTm5oYWhIcXJQY1Zwc0N5cG1FQzkvNTBtY2xsUWha?=
 =?utf-8?B?Q050VnVEWTNDa2ZGQU1YdGg5WlNKaU1zQ0VTbVgxWC9BSXNYWDM2OUxiY2FJ?=
 =?utf-8?B?RTVhUU56d3crb0ZqbVlScDhvbGZCQkdPRG5KeVZnNGNPYUhocXAzeE1wcUph?=
 =?utf-8?B?Y1JHNGhGSlp5TDZUcFRRVUgvYUJIN0dtdW5OdnAyL25rcVp3N2xXU01NS1dr?=
 =?utf-8?B?cEZVV1NMWmhjZ2haZnVNVHkzYW56UTNiYU9leHF4bFdxWVk0K1l6cWZGTWRZ?=
 =?utf-8?B?NmI0bFl5V2lZOWEra1hQTjg4ZVBnaVExWUtlblNRdUJCUHcvbzAxRSs5WHF6?=
 =?utf-8?B?cGQzQm5TSUx5QlRFTElhM3I2R0RIL0NBMUlIY1hBL01iaEVTalZEYWlobW5y?=
 =?utf-8?B?RDhlbUhKWlE2aXhXOGZMUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB8288.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zjd2ZHlpQy9taklRZzNsQ3ArNm9Ia1R4QlRVZFIrTnFKRzdobVBlZ3hkM2Mw?=
 =?utf-8?B?WUpNZWhwV2J6YUZUQ0FDaG5sMzV6bmRVeFE4NXRvRXZBZDlqbnl2OHdURHo3?=
 =?utf-8?B?ZUZ2VmROWHVoRmdva1NOazZ5NFk4aFNEckg2SUErcHltL0FLQ2xlR3Nsb3lU?=
 =?utf-8?B?ck1YTkcvNGd5WjkyUk9CMWR1MlUySFNIOUgwTWxtZTFQaFVkRnhJSVlwZDc0?=
 =?utf-8?B?TXlRZC85RHJ3OC90L0pSazJKUjFpWWx5bklGUDVVRE92Z2hzNGFreWxDV3Zy?=
 =?utf-8?B?SUFtd2FydzFua1pmMjVkRWlRdDE4WHJHYkdjUy9aTy9RN2tlVHo2ZlpuZ2tM?=
 =?utf-8?B?d1pmMnAzSXNKQ0Nwc2RCOUs0RTcrdEVQZUFYTVBzQ3dtQjNqdFh3ZVNwU1pV?=
 =?utf-8?B?Z2QrMEZwUmViTkZMdndXOVBkZWtRbjZ5cy9wNUk2MW5vOW1hL0ZEQXBjSFVh?=
 =?utf-8?B?WkUzbTlRZHF4cEg2NEVLRUFjdjExelZXTS9FVTVMajM0eW9YR2p4R295bERF?=
 =?utf-8?B?MUNlT2VOY3hYMUVPVnRZTW1EZ0hyMzVBNDZtdzZIMnlJRXRpU3JOd1BwVGRF?=
 =?utf-8?B?aDRpcGNNWDVkL0pEZTR6TDFIbnZweVR0NXpKcVhCMk5LL1NjVjkrdkd4Yzdo?=
 =?utf-8?B?blh0bVBaSHYxQUluQ1dYVHdQL0JFclZaNEkxb3REVHJrU2ppSE50bVd6UjRL?=
 =?utf-8?B?QnhVMXhiVktQcjV0L29oMjhQMURRSHhISGxqTkxKQTZVQnVnNWxXditRMHJh?=
 =?utf-8?B?TzN1cThIQTA4NGZIVEIrZzY1eU5LVjZETkhCMTcrMlB4U25BTEZUVjZmS2hR?=
 =?utf-8?B?UGhNZXBUbnlUUGlSY05sL002aU1EM00wV0xZYjBrVnRhZm9oa1dHc2FJdFZD?=
 =?utf-8?B?dyt1VjR4OW01aUlROUZPbXhPSmFSbExyeUIwUlF5SzhJZFVORWhZRVFVcEUy?=
 =?utf-8?B?R1lkVzIrRThCYVRaSWlKZ2RrSEFjWms0emlLUWtNVGgwQTBPZXlQNEhmZm9B?=
 =?utf-8?B?RUVZNFMxTXdEOUhvWGJibXFSOVp0VGdkN1A1ajlKM2R4aTZEY1hOMU9PQW5u?=
 =?utf-8?B?KzI5QVM4NjFyMGY0WmNOTmhKT2Z5Sm5nSzVQdkdDalZ5bjF2YW9PRm1PbitK?=
 =?utf-8?B?Z3huNDNSVnlmNXo1ZU9BYlhpK2dHb0hMa3VsMXE3ZFBjUDY5ZlJSM25CZ1VG?=
 =?utf-8?B?UWlEdGdtUWt4WVhGZW5ZcE5XWWY3NTdKQkdOQS9QWisyYXJZUUZpS3orNFhm?=
 =?utf-8?B?VFAydEtsSU54dHMya201RmVMZHJrclpyQzl5TDlrSGdsaE5EeSttejFtUm5v?=
 =?utf-8?B?VHpEczZCMnYydFZ1ZGNHTDFJZUc3WDJMTE51ZFhBbWt5M0RKRnBJSXRIWk9l?=
 =?utf-8?B?MEdBSjA4S3U1SHBtSVkvTU8zcjdoWFpsSlpPMzY4ZkZaa0tzVkVTMzh6MGI2?=
 =?utf-8?B?WlRwaDVkejU2bnRmb2xwS204U3g3TGN3UitQeG53TG9pdWpuS1BHWGxxR2Zr?=
 =?utf-8?B?SEo2aUtlMWNyOWI1ak1jaGpXZEF5N1paVDAvOUJoWWV1ZzVKZ0VsSnd5M0du?=
 =?utf-8?B?ODcwOXNjemZvMWs3cjBlOXo5cG9LNjNGRHROKzRjOWZVWWo2Zmp3SHdrS09X?=
 =?utf-8?B?V3NBUC9VMVROS1gxT3l2UnZ6Z2t2N3lCQjBjQlJmaStFcVR5SGxGOFdNWTBI?=
 =?utf-8?B?c0w4TzA2KzJiM3B6TkZIZVFIN2grKzlZSUd0Y1YrRW9UM2liNkZQRlFwalhK?=
 =?utf-8?B?azhaY2FIQ0NXUWUxQkEzQkVhR2NtVDlWS254TXRndktvcVdyMzRabktVOERG?=
 =?utf-8?B?VERHUnR0a1hQd1BmdGkvS29vTDEvUjZCL3FsRjQ5MC9mNFpSWXFLb0RVdkJQ?=
 =?utf-8?B?Y1UyS3J3WnFGWmN1NGlkS25rYWpuTy9Zb09KQVZZcGk3UGhTYnAzL0JJVkRj?=
 =?utf-8?B?SzFabGdBQS9za1lKMTBiVGRvL0JKUjlYSXN0Yy80MEs1NWxibWZFQmdoT1J1?=
 =?utf-8?B?d1RMelZxVkVxNGVGdlRTNzZEU2k3eGZ6YTlQdTdaQjhxRXZKRTAvanNSeVl3?=
 =?utf-8?B?bHpLQmZUbktyTmNVMVdGeHVpRC96QUx0d2U3bGVsV3pXMm9QeGk2MjRIblFt?=
 =?utf-8?Q?eA7RBRIWksfvV3DgZ6Kp7sVHW?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8288.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1383c1-7255-4c53-2dbf-08dd0f86840f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 08:27:37.1796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22991c1b-aa70-4d9c-85be-637908be565f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MG5essp1te+46dTy3gx65CVKnpDA4/jqfi9JHFVsSSmjZfInfhkO6dMDfAYPKA9yqd/Spf0BgwIajWBiKWPX7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6631
X-cloud-security-sender:tobias.boesch@miele.com
X-cloud-security-recipient:git@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay112-hz1.antispameurope.com with 4XzTvZ2zsKzwR0m
X-cloud-security-connect: mail-vi1eur02lp2049.outbound.protection.outlook.com[104.47.11.49], TLS=1, IP=104.47.11.49
X-cloud-security-Digest:88cee353ecd8b5060e8b10f7584de990
X-cloud-security:scantime:2.537
DKIM-Signature: a=rsa-sha256;
 bh=B9+SK78fsvfZLZ3aH3Z8jKlBjX2UT948LxnTz+pp7Vw=; c=relaxed/relaxed;
 d=miele.com; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1732782468; v=1;
 b=X9CtwEWgr5NOO4MECcOLQ4t2Hus/WpnOICIk9y1Sq2Jrqvb0tPuZqNO6jFVU0LKBgBSbK7xb
 iJUoXZf3OBGrB+cd2tV9qcT/LW8gMGw/J7n259LgzM9kdqTJycfhjSjWjzqOxT+YjMSJfFprxC7
 5H913rpdTqu2jGAZ+U6SpB+KEudXOgXdgCyNmMYjY4CaFNQ3cgO2cO/87AkxkErJ18qpKBwpw4/
 w5zsqKhrYulgwFvGnpuoPPGIG0zggP2H5Vi8AtuitoBT6jP+IYI9+Qc0awwjDYxXYyKrCBiyd0+
 iM+/59m9eer42CvtlLyb/Wq2uDySUo/NC4pmcTtV88jMA==

SGVsbG8gZXZlcnlvbmUsDQoNCmluIGdpdGsgb25lIGNhbiBjb21wYXJlIGNvbW1pdHMgYnkgc2Vs
ZWN0aW5nIG9uZSBjb21taXQsIHRoZW4gcmlnaHQgY2xpY2sgb24gYW5vdGhlciBjb21taXQgYW5k
IHVzZSB0aGUgZGlmZmVyZW50IGRpZmYgb3B0aW9ucyBpbiB0aGUgY29udGV4dCBtZW51LiBUaGF0
IHdvcmtzIGdyZWF0IQ0KSSBmb3VuZCB0aGF0IHdoZW4gY29tcGFyaW5nIGEgY29tbWl0IHdpdGgg
dGhvc2UgY2hhbmdlcyBtYWRlIGluIHRoZSB3b3JraW5nIHRyZWUsIEkgZG9u4oCZdCB1bmRlcnN0
YW5kIHRoZSBmb2xsb3dpbmcgb2JzZXJ2YXRpb25zIEkgbWFkZSBpbiB0aGUgZGlmZiBvdXRwdXQg
Zm9yIF9zb21lXyBmaWxlczoNCg0KLSB0aGUgZGlmZiBvdXRwdXQgaXMgbm90IGNvbG9yZWQgaW4g
cmVkIGFuZCBncmVlbiBmb3IgYWRkaXRpb25zIGFuZCByZW1vdmFscywgYnV0IGluIHJlZCBhbmQg
Ym9sZCBibGFjayAoc3RpbGwgcHJlY2VkZWQgd2l0aCDigJwrK+KAnSwg4oCcKy3igJwsIOKAnC0t
4oCcIGFuZCBzbyBvbikNCi0gc29tZSBmaWxlcyBzaG93IG5vIGRpZmZlcmVuY2VzLCBidXQgYW4g
ZXh0ZXJuYWwgZGlmZiBzaG93cyB0aGF0IHRob3NlIGRpZmZlcmVuY2VzIGFyZSB0aGVyZQ0KLSB0
aGUgaW5kZXggb2YgdGhlIGRpZmYgc2hvd3MgYW4gb3V0cHV0IGxpa2UgbWVudGlvbmVkIGluIHRo
ZSDigJxjb21iaW5lZCBkaWZm4oCdIGZvcm1hdCAoc2VlIGh0dHBzOi8vZ2l0LXNjbS5jb20vZG9j
cy9kaWZmLWZvcm1hdCNfY29tYmluZWRfZGlmZl9mb3JtYXQpLCBhbmQgbG9va3MgbGlrZSDigJxp
bmRleCBOVU1CRVIsTlVNQkVSLi5OVU1FUuKAnQ0KDQpPdGhlciBmaWxlcyBzaG93IHVwIGluIGEg
4oCcbm9ybWFs4oCdIHdheTsgYXMgYSBkaWZmIHdpdGggcmVkIGFuZCBncmVlbiBoaWdobGlnaHRl
ZCBsaW5lcyBmb3IgYWRkaXRpb25zIGFuZCByZW1vdmFscyBhbmQgbm8gZW1wdHkgZmlsZSBkaWZm
cy4NCg0KVG8gcmVwcm9kdWNlIHRoaXMgbWFrZSBzb21lIG1vcmUgY2hhbmdlcyBpbiB0aGUgd29y
a2luZyB0cmVlIG9mIGEgZ2l0IHJlcG8uIFRoZW4gY29tcGFyZSBhbiBvbGRlciBjb21taXQgd2l0
aCB0aGUgd29ya2luZyB0cmVlIGluIGdpdGsgYW5kIHNlYXJjaCBmb3IgbXkgb2JzZXJ2YXRpb25z
IGluIHRoZSBkaWZmIG91dHB1dC4NCg0KQ2FuIHNvbWVvbmUgcGxlYXNlIGV4cGxhaW4gbWUgd2h5
IGFsbCB0aGlzIGhhcHBlbnM/DQoNCkJlc3Qgd2lzaGVzDQpUb2JpYXMNCg0KDQoNCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCmltcGVyaWFsLVdlcmtlIG9IRywgU2l0
eiBCw7xuZGUsIFJlZ2lzdGVyZ2VyaWNodCBCYWQgT2V5bmhhdXNlbiAtIEhSQSA0ODI1DQo=
