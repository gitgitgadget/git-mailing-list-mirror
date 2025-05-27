Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24A5218AC1
	for <git@vger.kernel.org>; Tue, 27 May 2025 22:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748384479; cv=fail; b=LFtpctgq+P7ireHI9pTdj8mNp8eoVOFR1+9APhEGkGYunDW0gGcdJwxYERKnROlxtw/T/QCeSZuWFsp/1R8TO68gtT0pKYqOYV8K5bfupeZdWt/nW70+141HLgQ4Dui+hV80ySvJRQBbP46HSLbOFM5mCIavw7QNSbXaNWaBb9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748384479; c=relaxed/simple;
	bh=JGbvJeBEXPdBr1QBjVYk88Rtx6GznlJ6Rt/YCw1E8G4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PXTBbtxZgSanYeLBGr7X7f/pOKvbZFmtriAn5BLwXa5ECA+nmI3I3Z7hTPa1usOoghJlK4kXyYIZQarzB9fNWEsYIRuPPBpTouqsApxwBzVhtlN8E25PSzESZz10n4HbnLYUsRH/ZpWTEhA76Qa+bzQHbxvLCIAY7AO9UCAR6XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=commvault.com; spf=pass smtp.mailfrom=commvault.com; dkim=pass (2048-bit key) header.d=commvault.com header.i=@commvault.com header.b=FhxxAdps; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=commvault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=commvault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=commvault.com header.i=@commvault.com header.b="FhxxAdps"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGMT9vKo4SR33fic51xoqHgYSFFFVma+FWh6H4o3EcLXctd+sdlu2NNlojvcTCIV1VVhm5tPyeKmFGhPtzRDuHvh/s2rHKCQCpQlX+UdNm6JeyqUMbuNiqynhDfg82rPVRy6JA+eM0RHFLecz/VyYS5+wcNOvdOHR539iaBQfTu2MDpAEgYly12QXArK4A1C6ajTTVnVBj77PzraaqKhDC5XFs58Y6E3qPFQSA4OCpjBdunHBL6c1Dq6zInMEx6ih0YrDCll4grriDgsb6t05FUesNrvov9flxdxbtO2ijTCFlyNwEPV35chkbXtLQe2DNFs25EUfJcyaSfRMB6DWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGbvJeBEXPdBr1QBjVYk88Rtx6GznlJ6Rt/YCw1E8G4=;
 b=makZbTGMdK+rIUrdhhiePzMa0qJZ48SRxEaKE3JPDPkrtQMcVSv7z+eugRXB12eHMKL609sHuK/rKVqZnBjIcjK5af/8OPu5lojVbFp5WxLJrhmFf4neoYJ825TZ/OG/Gx+JUvky+vJ9YtE+btj/X3V4NgrLC+0je21CgPBREnQMiw582Nd5aYyOT2slSqQZ0DMvcQLDE8uIrij2Uor/lB6DjngIASr9Av7q/RqMCTdTabn8h71JDgHoa/C0abGC6RB2X5zMjxcvLYtmxQDrx7TmA6p7iykwKBCZYHz46+2RyXhGtugau1G7LinJVFncYz6wHQ72aUcvf2MfQIdzUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=commvault.com; dmarc=pass action=none
 header.from=commvault.com; dkim=pass header.d=commvault.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=commvault.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGbvJeBEXPdBr1QBjVYk88Rtx6GznlJ6Rt/YCw1E8G4=;
 b=FhxxAdpsz4UpX2LH6v/RfHFLlNuW6rWUfJI5v4c8MEuYu+McQVQWsKn1PUlWYS7YwtjRstaqM7cdm0yulBB94+1hL+9dJZW8QOctztE1exREKJ+/H0U21hm9WDwLgHwzDcHNFc+b6t2Jytv4jWIzNxcL5mtGTwXDiQDIhtcoTIseiXbdugW9pJhWxeu0ixO04L6HuDFSwWVMBrJ0SJu+vX1th4oxcpQ4CbevC4mnXOQONANRi+Rgp5nDaQHE2ubWsHej4KraZcxKKj9Yoed+sTktKGKzV8yM+us7KvuSvqKAjlLCr0H9UtE2V6zsNyuoZFsTP02oV+rY/IbzZtqauQ==
Received: from SJ1PR19MB6401.namprd19.prod.outlook.com (2603:10b6:a03:458::14)
 by BY5PR19MB3747.namprd19.prod.outlook.com (2603:10b6:a03:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Tue, 27 May
 2025 22:21:11 +0000
Received: from SJ1PR19MB6401.namprd19.prod.outlook.com
 ([fe80::dfce:4bc1:f841:c291]) by SJ1PR19MB6401.namprd19.prod.outlook.com
 ([fe80::dfce:4bc1:f841:c291%6]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 22:21:11 +0000
From: Abhishek Dalmia <adalmia@commvault.com>
To: Jeff King <peff@peff.net>
CC: Justin Tobler <jltobler@gmail.com>, Akash S <akashs@commvault.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>, Adithya Urugudige
	<aurugudige@commvault.com>, Abhishek Dalmia <adalmia@commvault.com>
Subject: RE: Incremental Backup of repositories using Git
Thread-Topic: Incremental Backup of repositories using Git
Thread-Index:
 Adu9yuZ7Kg9IZ5BOSWCrIQPM1Q8FHgADnPsAACq806AAEOrIAABOC8/wABIVKQADwzJLwA==
Date: Tue, 27 May 2025 22:21:11 +0000
Message-ID:
 <SJ1PR19MB6401A2664CD337F9DF482317AE64A@SJ1PR19MB6401.namprd19.prod.outlook.com>
References:
 <PH7PR19MB70252D42F5D04FFC0331AB63C08E2@PH7PR19MB7025.namprd19.prod.outlook.com>
 <2dz3cema2mr5mrlvuroemnyeqyrglxfmusfdz2kaghv6rvj3ro@ti2dhu45fdmr>
 <SJ1PR19MB6401D7734B73C453E491D54DAE89A@SJ1PR19MB6401.namprd19.prod.outlook.com>
 <hanlqq5mma3dvbfq4j4u2zgz5mjegejjg3gjrhyggg2e6ozd5t@354nrc4nq6gn>
 <SJ1PR19MB64010CDB3F21FE91C97E566BAE8BA@SJ1PR19MB6401.namprd19.prod.outlook.com>
 <20250508183910.GB10864@coredump.intra.peff.net>
In-Reply-To: <20250508183910.GB10864@coredump.intra.peff.net>
Accept-Language: en-GB, en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=commvault.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR19MB6401:EE_|BY5PR19MB3747:EE_
x-ms-office365-filtering-correlation-id: e840385c-ec17-47a0-513f-08dd9d6cc910
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MlhnUjVQYlZBVUdQaytvbitGVWtZSjdRZ2RiT1pJQjhjNExlM1pPRWhHQW02?=
 =?utf-8?B?NUZmZmJFR05nZ2dSb0pzOW5TdWpyR0Q2WVRteXJkQ3BWNzBsb1NNR2xEazZD?=
 =?utf-8?B?OWtSRnVPOXlsaEhObDA5U1RzeEJpbDFla3hseFJubVVQNkJsa0g0VHJkTzlS?=
 =?utf-8?B?aStGWlRDbStqZnkrS3AvYnFwUmhNYmllcEVkN1lKY1J6MERVblFuT2hoU0ky?=
 =?utf-8?B?TnY2ZXdOMXAzOXFSR0Vtd2t3a1dQR0dvRnBxN3gyTE1DYXZRMCtpeklCcHZY?=
 =?utf-8?B?dmJZN0xmWm54WnRHNmJYYTdNVjBEZjdUNmpZL29pbCtpamxLalFXTWRXRDJB?=
 =?utf-8?B?cHBrMWhZTjdTSnNkRHQ4TS9STTUxYnhtdVZMblJjbjhNWUlBOVovcXdLeDU0?=
 =?utf-8?B?Y0pCNlNQME1ldTE5eXV5ZjlGUWVLMXMwUmZmdFRiYjVhTndaMTFuQndCOUtr?=
 =?utf-8?B?cXVuc1QvMGZZY3I0c0VsZHZnRkh5Z0ZDMHFBSkF5R1hUaWFsUkNLK3JtbmNm?=
 =?utf-8?B?VDFaYmxTQTQwUzFFY3pGY3lEdEMraEM2Z25xMzVuQXl1cTArbWZYTDRBaUhO?=
 =?utf-8?B?clU3S2lVL2pVZUFITjlWcTI0ZUUzN1BhKy9NazJQTjM2NjJqR0RZd05kNkNn?=
 =?utf-8?B?UmpkNWdjSDJWTUkxaS9rQndVOFhiRUZBREhQdHNsaWQwUWFkblpPVUxidlpi?=
 =?utf-8?B?eFpIT2c3YVl2QUN1dVV1YzFRVldwVkhybzRMU3ZzU2xqVFJDRS9XR2p2ai85?=
 =?utf-8?B?SEFXaEhIZDBLa3dWUzFDNXRoY1QyYmJrMFJ4bUgvbmE1dU0waVZrRzk5V1Vv?=
 =?utf-8?B?bDM3dlhhS29WR2J0VDRYV2tMamJQWEUvMUx1YW1QcnNuVzZlM3kzRDR1ZFB3?=
 =?utf-8?B?Q0IyUFF2QlltT2RCbFgzM1hDSFJsbWhiVThpamgzd3JVTDFPdTRSSU5wNmJU?=
 =?utf-8?B?SEdXUnFFRll1ZWU1dGZmRzVZTFpweHRXVGJ2dGtDRzd4eGJkT3ZWV1djS2Rk?=
 =?utf-8?B?ME5YN2kxYUFPdm42L21LMVB0SE42QWxuTXNLaFlNZEYzeDVuMStNdm1NS2Yx?=
 =?utf-8?B?bW82K3JrM29ZVlpGU0RzWjFYRkFKUjMyNzJMRGJkVjZGZnp4WitqcENpVUFx?=
 =?utf-8?B?ZHJveTZHVkJRS2lvYm0wZzdnZlFmTE9NQTJSNEowaUhhZzBBaFR4ZmE4b2xt?=
 =?utf-8?B?SU1vY1VzR0tFSVRldTBlOVZ4Zm1hamZMUUhCNUFOc3h4Q0o5TXhYRFUrcDR2?=
 =?utf-8?B?N0psWEE0KzFrd1VjVmxtWUtJUzR6ZWRiSzkrUjJCMDZQdWNLcHQ2QkQ5RWJl?=
 =?utf-8?B?cUswWHE1NGhxT2djV3lLOXZNQUtnZm1jTWdWTnI4YmpYa0NFN0JiNWZKU3V6?=
 =?utf-8?B?YlJXcmFFMXRGK2tDMC8zeE5NeCsyOTNHUDBVWjFLcHFaQWx0V2xZS3lkSy9W?=
 =?utf-8?B?MFZNbnplMzRseHBYeW1JZ1E5QkxtNHd3aXc3V2w3dWNzV1d5VC9yNzdYdVYv?=
 =?utf-8?B?UVMrVVM2T0JIQUs1V3lYajNVbGJZU1A1WEUwYkFSMUNIZ3ZpOEYwUjdhd1A0?=
 =?utf-8?B?Nkt0eDVMOWdCMU81TldaM05IK0U5UEpyK1BlOHdaUHo1SGVEeTJHOE1od1d2?=
 =?utf-8?B?TWZWSzdoT1I3ZmU4UktSSGZqcFU5dUsrVW5EamNXOFZWejN0UmFKY0hHT1Mx?=
 =?utf-8?B?cEVWRGk4Nm96OTBJbkE0U2dxUFJ4M3BpcDYwdE1wTGVaa1llVlFwc2ZXQWpp?=
 =?utf-8?B?WjVyTjMyTXZXWU1DQTlNdEVjUjY0MmQveHZlNUwvNzZwRnJYVUZSZnV0WkpE?=
 =?utf-8?B?Mkc4cXFUKy9WTTFPUlNyMWMrdWIrdUVrVW42RWJ0OHFhM0swM1dpSUxOK2dC?=
 =?utf-8?B?eVhIR2NNK242NjM1WlA2bTRtS1lSTkRYcHVGQXZydEsyOG9PVnoxMVJTMGYr?=
 =?utf-8?B?YyttaDVoTS92QkwzWlNFM3hzc0Rla0loYWdRdzArVnloWWNFVG1GcVZ6QTZU?=
 =?utf-8?Q?0Fe5He4hKrUQBI5YkEEnQvMI/RA8EA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR19MB6401.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M29OQk81TmVITW1XcVJuWFk1blhYcTZmK0pvVTg0KzVmb0ZrcURldXZEV0hl?=
 =?utf-8?B?YW9uN0FWYy9BWmZrd1Bncy9lZnptN3FMRlQwK2VxVVBWRHpaSXphMXZvS05m?=
 =?utf-8?B?d0hodDY1TnRydGd2emtwU2VQVXFjZ1lTVGE0WTdVNWVNb0FpRkxKdHBkUEZL?=
 =?utf-8?B?cVBqVTZXalN4cWhLaVRQcHJOckNYb3lJT3VHa3ZRRTZ0YTN1Yzg5dGpDV05q?=
 =?utf-8?B?TFpqNEt6ckVKRjF3bDJHMFNlWlB1MzI4WEFWdkRkVm8vMjVXUndDT0NpL213?=
 =?utf-8?B?NUFvak1PRW92QVRwN2YwVmR6Tnhaem9tMm1RYzNxS1Y4Yi9WcFNpK0g1SWRv?=
 =?utf-8?B?UnRtdVowdmR3M3U5UFRFZ2tPUEpGd25reThiM3g3OHdZSUtmTExtQWpMc0M5?=
 =?utf-8?B?eWU1Sks5QWtiNk0wVjhsL3A4OThMc3hqM1IvNmFTWVNVM25lQVlQcVBEeE1w?=
 =?utf-8?B?YUpZOWF3dXE1bEpteGMwMmhjd2ptMko4TXM0dmw4SWw4V1orRk5Ta2QrUWhL?=
 =?utf-8?B?aHE5U3h2amR5OEhUdUNQM2I3dEhVRVhuakNPKzYvbFI1VGR4aEwvWkFNakpr?=
 =?utf-8?B?RklOTjNORFVBUWlZR2JCY0FnOXRRZ1N0RHpWTlhDMDB1djA5NjRneUZOUnIy?=
 =?utf-8?B?a0pubjR3cmg0ZFMxOXVoMk9JVUUyOU8vb2gzU01zWkJXaTl2QmozVG83MmlS?=
 =?utf-8?B?WlQwekV5U2lhRHZZSWZidWtiNnl5K0kraGhKUWN1RWJiWEtJRGMzcytvNFg5?=
 =?utf-8?B?R2hRNk05ZzlSbWtpM3lXMnJrNFZoMHplWENZQk5nYlhOWHRSTFludnJtbTc0?=
 =?utf-8?B?aTAwZlVGdDRiRzdtSFdPR3VKT1N1TnZIQkhwS0laSVdwR3VHYkczek0xQWEr?=
 =?utf-8?B?RndiOFRTWE5RbFplbUJnL21rb29EVXE0NWZOUkIySlpJaUlTRXpmeFZUOUk0?=
 =?utf-8?B?UlhpTzBTbmNUWVVMaFNYLytmc0tuTkoyb0prNEJZVU1EZmNRU2lEeDYvRlhF?=
 =?utf-8?B?dENlVWw4N21vNkVMTWcvaDljZFY0MVlYWFlLOTIyVlM5UnRselM3VXd1WGgv?=
 =?utf-8?B?TTA5VHJ6dTRIOGYwSGVlT3pKQllJV3Z5SVRqUFMybWk1ZWVkNkFna3ZpRHdP?=
 =?utf-8?B?V3Z2SStXY0tKRGdnTTQyTWpLaTRlRmtRQW1tVTJWdEpYTHVDYnJ4cTkzVnN1?=
 =?utf-8?B?MVNqWFBzYWk0cklWZkIwcit4UHlLYzRlSHJIS1cvYXA0dEZVN2REUnJERHM4?=
 =?utf-8?B?YmJKWmgzc3FHY2psdG1NUlVHTHhiN3E5b2U1OVQ4d2VVOVFOMkF3TjIrR3oy?=
 =?utf-8?B?ZjRmaWhvVWQ0aEMrQ252YlhlRFpVSU9DNlZRQ214N3lDNVFXSzIwQVNSNitB?=
 =?utf-8?B?UWhyQUMzWGUxZE4vczVxSGYxQ0V0MjJ6S3IwcWUyRnpFQlduWTE0RndzR0ha?=
 =?utf-8?B?cjVOK29HQW9Yc2RuQnBLWWl2NCtyTkZRSUpWeUhla3h3a1Vub3p3UGphWk1y?=
 =?utf-8?B?SWNxbDZ5R1hmek0yblZFZVFjZ29vSi9tQXVpUThPMmpJdkMzdHl1aTRjb1ky?=
 =?utf-8?B?bURWM3dvZVN4QS9oenUvbFZQWDdjNTlsMUJEQXcyM01MdUFjNkdkWEV1MFl0?=
 =?utf-8?B?M2ZzRVFsd2d2c0RIdkVwNzh4SVB0RzhRMjZiZ0VoWnJ4eUZVRTBGTk9ncS9Q?=
 =?utf-8?B?a2MzaE9OSDV4bFUwVmFoU09jL04rcUxWcWVOaGlkNUpMNW5nOGp6RFJyUHhG?=
 =?utf-8?B?ZVZQb3JCYkZPcFJuckt4M095U01PbEg5NnRwYkdqeWlDNUtqZXRtMWhUSVZt?=
 =?utf-8?B?NjJpUk41VDFPdHp1R3JpZG5MTDdhZjFSbXVjSFVDa29ubVEzOVlJWG11QjVi?=
 =?utf-8?B?azJES3FoTFpyZEx3alcvZFJ6elFjcDNIZ1NMc0FEVVliNUpneU5EOFJLUlRo?=
 =?utf-8?B?MWVVNGxzNC8wbllEdmR0LzdxOUVZRHpNYmJjK0NTc3A2RGFBT2F0dUt0dmZM?=
 =?utf-8?B?UzYzU3d0RVJyblJObEhVOUlManFHUlZoamhOZGQvVXNYTEc2SjNZT1IrUWIr?=
 =?utf-8?B?Q2NOaGlidzI3TklFZzFZcHJNdHBkUFpnYU5JTHRxVW1kWmRrS3NxZWlWbnFR?=
 =?utf-8?Q?mZsYvY+u0kWqsclJhwXie9Pmz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: commvault.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR19MB6401.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e840385c-ec17-47a0-513f-08dd9d6cc910
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 22:21:11.1692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 40ed1e38-a16e-4622-9d7c-45161b6969d5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /dI7qghuw0W3dy3lgUaNC1dSMegE1lRtdxO5+NjzUsNAiOgWN853W0EkAO0XCRxuWVlQasMugkfjyGG20TTaHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3747

SGkgSnVzdGluL0plZmYNCihwcmV2LiBlbWFpbCBnb3QgcmVqZWN0ZWQgZHVlIHRvIEhUTUwgY29u
dGVudCkNCkkgdHJpZWQgcmVzZWFyY2hpbmcgbW9yZSwgaWYgd2UgaGF2ZSB0aGUgcHJldmlvdXMg
c3RhdGUgb2YgcmVwbyB0aGVuIHdlIGNhbiB1c2UgZ2l0IGZldGNoIC0tYWxsIGFuZCBoYXZlIHN0
b3JhZ2UgbGV2ZWwgaW5jcmVtZW50YWwgYmFja3VwcywgYnkgdXNpbmcgdGhlIGNoYW5nZWQgb2Jq
ZWN0cyB1bmRlciAuZ2l0L29iamVjdHMgKC5wYWNrIGJ5IHByZXZlbnRpbmcgYXV0byBnYykuIEJ1
dCBpdCB3aWxsIG5vdCBiZSBmZWFzaWJsZSwgdG8ga2VlcCBhcm91bmQgdGhlIHJlcG8gY2xvbmUg
Zm9yIHRoZSBpbmNyZW1lbnRhbCBiYWNrdXBzLg0KDQpJIHJlc2VhcmNoZWQgYWJvdXQgZ2l0IGZl
dGNoLXBhY2sgaW4gYSBnaXQgaW5pdCAtLWJhcmUgcmVwbywgd2hpY2ggbWlnaHQgaGF2ZSBoZWxw
ZWQgaGVyZSwgYnV0IGl0IGlzIG5vdCB3b3JraW5nIGFzIGV4cGVjdGVkOg0KMS4gSXQgZG9lc24n
dCB3b3JrIHdpdGggaHR0cHMgLT4NCiQgZ2l0IGZldGNoLXBhY2sgLS10aGluIC0tc2hhbGxvdy1l
eGNsdWRlPTI4MzA3Njg4ZjczNDQwMThjYWQ0NmMzMTA4MjZhODIwNDFiMzliOGQgaHR0cHM6Ly9n
aXRodWIuY29tL2VsYXN0aWMvZWxhc3RpY3NlYXJjaCByZWZzL2hlYWRzL21haW4NCmZhdGFsOiBw
cm90b2NvbCAnaHR0cHMnIGlzIG5vdCBzdXBwb3J0ZWQNCjIuIFdpdGggc3NoIGl0IHNheXMgZmF0
YWw6IHRoZSByZW1vdGUgZW5kIGh1bmcgdXAgdW5leHBlY3RlZGx5IC0+DQokIGdpdCBmZXRjaC1w
YWNrIC0tdGhpbiAtLXNoYWxsb3ctZXhjbHVkZT0yODMwNzY4OGY3MzQ0MDE4Y2FkNDZjMzEwODI2
YTgyMDQxYjM5YjhkIG1haWx0bzpnaXRAZ2l0aHViLmNvbTplbGFzdGljL2VsYXN0aWNzZWFyY2gu
Z2l0IHJlZnMvaGVhZHMvbWFpbg0KZmF0YWw6IHRoZSByZW1vdGUgZW5kIGh1bmcgdXAgdW5leHBl
Y3RlZGx5DQpJcyB3aGF0IEkgcmVxdWlyZSBoZXJlIChmZXRjaCBuZXcgb2JqZWN0cywgd2l0aG91
dCByZXF1aXJpbmcgcHJldmlvdXMgb2JqZWN0cyBwcmVzZW50KSB0ZWNobmljYWxseSBwb3NzaWJs
ZSB3aXRoIGdpdC1jbGkvIGxpYmdpdDIgbGlicmFyeT8NCldlIGNhbiBoYXZlIHNvbWUgbWV0YWRh
dGEgdG8gdGVsbCB1cyB3aGF0IGNvbW1pdHMgd2VyZSBiYWNrZWQgdXAgZm9yIGVhY2ggcmVmIGlu
IHRoZSBwcmV2aW91cyBiYWNrdXAgaWYgdGhhdCBjYW4gaGVscCB1cy4NCg0KQXMgYW4gYWx0ZXJu
YXRpdmUgSSB0cmllZCBvdXQgd2l0aCBBUEkgcmVxdWVzdHMgdG8gZG93bmxvYWQgY29tbWl0IGJs
b2JzLCBidXQgdGhhdCBqdXN0IGhpdHMgcmF0ZSBsaW1pdHMgdG9vIG9mdGVuIGFuZCBpcyBmYXIg
c2xvd2VyIHRoYW4gZ2l0IHByb3RvY29sLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogSmVmZiBLaW5nIDxwZWZmQHBlZmYubmV0PiANClNlbnQ6IDA5IE1heSAyMDI1IDAwOjA5
DQpUbzogQWJoaXNoZWsgRGFsbWlhIDxhZGFsbWlhQGNvbW12YXVsdC5jb20+DQpDYzogSnVzdGlu
IFRvYmxlciA8amx0b2JsZXJAZ21haWwuY29tPjsgQWthc2ggUyA8YWthc2hzQGNvbW12YXVsdC5j
b20+OyBnaXRAdmdlci5rZXJuZWwub3JnOyBBZGl0aHlhIFVydWd1ZGlnZSA8YXVydWd1ZGlnZUBj
b21tdmF1bHQuY29tPg0KU3ViamVjdDogUmU6IEluY3JlbWVudGFsIEJhY2t1cCBvZiByZXBvc2l0
b3JpZXMgdXNpbmcgR2l0DQoNCltZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gbWFpbHRv
OnBlZmZAcGVmZi5uZXQuIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2Fr
YS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KDQpFeHRlcm5hbCBlbWFpbC4g
SW5zcGVjdCBiZWZvcmUgb3BlbmluZy4NCg0KDQoNCk9uIFRodSwgTWF5IDA4LCAyMDI1IGF0IDEw
OjI0OjU1QU0gKzAwMDAsIEFiaGlzaGVrIERhbG1pYSB3cm90ZToNCg0KPiBJIHJhbiBpbnRvIGFu
IGVkZ2UgY2FzZSB3aGlsZSB0ZXN0aW5nIGluY3JlbWVudGFsIGJhY2t1cHMgd2l0aCBnaXQgDQo+
IGJ1bmRsZS4gSWYgYSBjb21taXQgaXMgY3JlYXRlZCB3aXRoIGEgdGltZXN0YW1wIGVhcmxpZXIg
dGhhbiB0aGUgDQo+IGxhdGVzdCBmdWxsIG9yIGluY3JlbWVudGFsIGJhY2t1cCwgaXQgY2FuIGJl
IGV4Y2x1ZGVkIGZyb20gdGhlIG5leHQgDQo+IGJ1bmRsZSBkdWUgdG8gdGhlIC0tc2luY2UgcGFy
YW1ldGVyIGV2ZW4gaWYgdGhlcmUgaXMgYSBidWZmZXIuDQoNClllYWgsIEkgZG9uJ3QgdGhpbmsg
eW91IHdhbnQgdG8gdXNlICItLXNpbmNlIiBoZXJlLCBzaW5jZSBpdCBpcyBhYm91dCBjb21taXQg
dGltZXN0YW1wcy4gWW91IGNhcmUgYWJvdXQgdGhlIHN0YXRlIG9mIHRoZSByZWZzIGF0IGEgcGFy
dGljdWxhciB0aW1lLiBPciBtb3JlIGFjY3VyYXRlbHksIHlvdSBjYXJlIHRoYXQgeW91IGhhdmUg
Y2FwdHVyZWQgYSBwYXJ0aWN1bGFyIHJlZiBzdGF0ZSBwcmV2aW91c2x5Lg0KDQpTbyBpZGVhbGx5
IHlvdSdkIHNuYXBzaG90IHRoYXQgc3RhdGUgaW4gYW4gYXRvbWljIHdheSwgZmVlZCBpdCBhcyB0
aGUgImN1cnJlbnQiIHN0YXRlIHdoZW4gZG9pbmcgYSBidW5kbGUsIGFuZCB0aGVuIHNhdmUgaXQg
Zm9yIGxhdGVyLiBZb3UgY2FuIGVhc2lseSBjcmVhdGUgc3VjaCBhIHNuYXBzaG90IHdpdGggZm9y
LWVhY2gtcmVmLCBidXQgSSBkb24ndCB0aGluayBnaXQtYnVuZGxlIGhhcyBhIHdheSB0byBwcm92
aWRlIHRoZSBleGFjdCBzZXQgb2YgcmVmIHRpcHMgYW5kIHRoZWlyIHZhbHVlcyAoaXQganVzdCB0
YWtlcyByZXYtbGlzdCBhcmd1bWVudHMsIGFuZCB3YW50cyB0byByZXNvbHZlIHRoZSByZWZzIHRo
ZW1zZWx2ZXMpLg0KDQpZb3UgY291bGQgcHJvYmFibHkgZ2V0IGF3YXkgd2l0aCBqdXN0IGNyZWF0
aW5nIGEgYnVuZGxlIHdpdGggdGhlIGN1cnJlbnQgc3RhdGUsIGFuZCB0aGVuIHB1bGxpbmcgdGhl
IHNuYXBzaG90IHZhbHVlcyBmcm9tIHRoZSBjcmVhdGVkIGJ1bmRsZS4NClNvbWV0aGluZyBsaWtl
IHRoaXM6DQoNCiAgIyBmb3IgaW5pdGlhbCBiYWNrdXANCiAgaWYgISB0ZXN0IC1lIGxhc3QtYnVu
ZGxlLXNuYXBzaG90OyB0aGVuDQogICAgPmxhc3QtYnVuZGxlLXNuYXBzaG90DQogIGZpDQoNCiAg
IyBtYXJrIGV2ZXJ5dGhpbmcgZnJvbSBsYXN0IGFzIHNlZW4sIHNvIHdlIGRvIG5vdCBpbmNsdWRl
IGl0LA0KICAjIGFsb25nIHdpdGggLS1hbGwgKG9yIHlvdXIgY2hvaWNlIG9mIHJlZnMpIHRvIHBp
Y2sgdXAgZXZlcnl0aGluZw0KICAjIHdlIGhhdmUgY3VycmVudGx5DQogIHNlZCAtZSAncy9eL14v
JyA8bGFzdC1idW5kbGUtc25hcHNob3QgfA0KICBnaXQgYnVuZGxlIGNyZWF0ZSBvdXQuYnVuZGxl
IC0tYWxsIC0tc3RkaW4NCg0KICAjIGFuZCBub3cgc2F2ZSB0aGF0IHJlZiBzdGF0ZSBmb3IgbmV4
dCB0aW1lOyB0aGlzIGlzIGluaGVyZW50bHkNCiAgIyBwZWVraW5nIGF0IHRoZSBidW5kbGUgZm9y
bWF0Lg0KICBzZWQgLW5lICcNCiAgICAgICAgIyBxdWl0IHdoZW4gd2Ugc2VlIGVuZCBvZiBoZWFk
ZXINCiAgICAgICAgL14kL3E7DQogICAgICAgICMgZHJvcCBjb21tZW50cyBhbmQgb2xkIG5lZ2F0
aXZlczsgY29weSBvbmx5IGZpcnN0IHdvcmQgKHRoZSBvaWQpDQogICAgICAgIHMvXlwoW14tI11b
XiBdKlwpLiovXDEvcDsNCiAgJyA8b3V0LmJ1bmRsZSA+bGFzdC1idW5kbGUtc25hcHNob3QNCg0K
T3IgYWx0ZXJuYXRpdmVseSwgaW5zdGVhZCBvZiB1c2luZyBnaXQtYnVuZGxlIGF0IGFsbCwgeW91
IGNvdWxkIGp1c3Qgc3RvcmUgYSBjb2xsZWN0aW9uIG9mIHJlZiBzbmFwc2hvdHMgKGZyb20gImZv
ci1lYWNoLXJlZiIpIGFuZCB0aGluIHBhY2tzIChmcm9tICJwYWNrLW9iamVjdHMgLS10aGluIC0t
c3Rkb3V0IiwgZmVkIGZyb20gdGhlIG9sZCBzbmFwc2hvdCBhbmQgdGhlIG5ldykuIFdoaWNoIGlz
IHJlYWxseSBhbGwgdGhhdCBidW5kbGVzIGFyZSBhbnl3YXkuDQoNCi1QZWZmDQo=
