Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099111A275
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336779; cv=fail; b=nMkp1nsVzi8FXEkftQh1B88aFtLUxFTlMbwY/1t7w9rg08vBmqbZyeVCRjglLiHe7DusK9yl9vvnCelYaaoGu5s6pb9PZptCFdLCExpZj26ZqZes/naVAAbbXuVVLPEes1K6KQpS74Kp3CsWb+GVshMMz5QebHAJZmzrNXmtrdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336779; c=relaxed/simple;
	bh=Ndp8EOYgFY2lYcBoNg1p0p5o/G57tKScciwTS96/yi0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QPNCpzGwXmyvHb8RQcUezIe7WjedffwpJVpsAS5iaNRuELRLV+bpGueDK7eaLcfUkRkuUln0/Gc9+TQyEVVrDCVa+4sNpgFZzptO1FY/T8BDQbwd3Q1tgIkJV7wvlFtbwZgc/wKRcOfyw4kmIksW63UYzZ3Vrj1Zir1T9p9SQS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mkYHzbUu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TmkQFFFh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mkYHzbUu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TmkQFFFh"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L1Mlus044768;
	Thu, 21 May 2026 04:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=i8E/xuK6KbdCv7Rg/K
	yxJVUFfbFKUrHLVetZoSMZZKw=; b=mkYHzbUuteAcHgx/L9uozmxuHUZOGKZJrs
	QaCHD0/QRP0kXlCdUxgP24IZiUCJIt59JOISVoLDx8SE+jElS1alRQy8ZGEY4tz3
	iB+p0c4DUwNkBGnCKGwnjxf66Qeb0WmbnO6d0kufDtVypTwOTKC0lg2bnGHnQ2m5
	x1QMuhtihF15Opgis3gIKd6pI02p2/ZoiVMKyT2ElNMVSrqPDuT0GRMOu9pxni3h
	TvlDPFwhL44c+Cq1IP+if/BefNhze6H+hHoJbhCRXb1rcRftwpmjnRjzu7BN3uFa
	NBIM3UkuGC8+wLAlf3hcbnxTy0ibF0YfrhhulIDK6nlG7mpjkdtg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6gyx8jk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 04:12:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64L49hbA034215;
	Thu, 21 May 2026 04:12:45 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011013.outbound.protection.outlook.com [52.101.57.13])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1d24mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 04:12:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/+K96aeTDK7swApeU/nkqVzX16zVcZWfA6zk6ckxdQCB7YDD+uINp6dtkFoWNRKSpQS78jNi51n7JKP0VYqzGFQlD/vWZw2IhDn4fLIGuAJokCtloYK3lgY9H89QfpExTJlfgyECHivo1h2j1Gp1Pi3vPTAAWE8EnAWtDt4Kl8oGMv7ocXs+8/s5gKRAh49Vd4phU+UlQ4szZvQzJE18RwvB8nypfRfQd23BnBntz4S5N4+3QTwvUtn8rt1Z+W6wODavw/cqszo+x2VL460HiUYQn46D5+bRYRmoWU0xPWoBlzcHcwOTW1EYfRu6oQnxi0JOJ0buEC/LSlorU43Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8E/xuK6KbdCv7Rg/KyxJVUFfbFKUrHLVetZoSMZZKw=;
 b=hPlyfQVZ7Mpig8jI3GdzGZgUuUgYrPaiFKYaKajrCx7mmrVOVGj7rM84zaJgXd435HC3HnoHiK6pzVsjqNlIRhDIRzqVaL4wyIdyGg/am+89FylaM+9RCCLzfQ4RI3cr33z1LzWc9+BNyKFJ1eo7/QkoEZag2BEJ7QpHwM9Q6Sf9Y51lpFJPkyBVDU7D+GzsJVwH3cj1PYD+y9WkZVbJcOn4Fiq+34+OgA99dIxOc3tD7rM5lIfbF3tVxPeKKZZOmJYpJS+X+YDmljWnInpRcngbaJCpVbhbNUCBtLD2aWqmpIP1N7qB1B4rn33yQ/wU9pmPnNMiO7LZ/kmyu2rS1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8E/xuK6KbdCv7Rg/KyxJVUFfbFKUrHLVetZoSMZZKw=;
 b=TmkQFFFheOGoyE8OFZNND5Ps2XEawtko19lvVcLeRCnZQ8bqIxDTHGSyqGZofiOAH+gTCwnMf8srUV+FBw/jfFgRgbxr0CUCG2YvgxKC4Tca58Wm2eEoUzVa3mKCfElngfiFezhVbTaAl3+3VcM5TvohyAVuHaNWbSaHgYA1CRQ=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS0PR10MB6032.namprd10.prod.outlook.com (2603:10b6:8:cc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 21 May 2026 04:12:41 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 04:12:41 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>,
        "calvinwan@google.com"
	<calvinwan@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "newren@gmail.com" <newren@gmail.com>,
        "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>,
        "ps@pks.im" <ps@pks.im>, "code@khaugsbakk.name" <code@khaugsbakk.name>
Subject: Re: [PATCH 7/9] notes: support an external command to display notes
Thread-Topic: [PATCH 7/9] notes: support an external command to display notes
Thread-Index: AQHc6NgRQCtQusJ99U+vwyIrjo2hcA==
Date: Thu, 21 May 2026 04:12:41 +0000
Message-ID: <4086055f59eec99f94847a1b37c684a084f08e0b.camel@oracle.com>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
		 <9619077369f1a567bd505b1de1e4f672a5cd1950.1779207350.git.siddh.raman.pant@oracle.com>
		 <ag5b4O7-k-3QBR4W@fruit.crustytoothpaste.net>
In-Reply-To: <ag5b4O7-k-3QBR4W@fruit.crustytoothpaste.net>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|DS0PR10MB6032:EE_
x-ms-office365-filtering-correlation-id: c751b088-0c5c-4247-1dcd-08deb6ef337e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|6049299003|10070799003|4053099003|56012099003|22082099003|4143699003|18002099003|5023799004|38070700021|6133799003;
x-microsoft-antispam-message-info:
 v6QLfkeCR9/3Mr9U6pxTfl+1yujpwDR6fMZoWB/a0dC54q1OSDKmRwXA7vgfln2Tr18AS5LEAc+giv61FwT6ySQwaAZbL2K4iwYF9B2tpunZLLcx1UQAO1bWbpdDadgoX2PVn8bKoc+2OaJYSapouXGVZr3J6d0aB6bveqyQJ9PpZnZ6wHhsSiWS5QaTjPonugzqU6PKRfB65nrYMbQni7T4Mmo2c/wFiHRmywk6b1+bdcPcUE06vjTc7BLic7BsHebr286W3zqhldSeEdtlq0pkhjgv0tgj8rDdlYBSyK91HtzJ5s2H05/PulB0zzSOB+nvEap32gj5NCWFxi2fzkbq/dB525vV/ggjLATlDQ+s8ut+lEfIT8/HW24JcN7XJcia9M5sp+Dufzk+ttHrSNwJwm106NKYy+Y1W2RNTxrAMeJY9jnhtAw6fU+/TGn3mj6h24MR2WQYIFU2c0FV5QeY6V4Sne9ebkV+TFAoESsMiVF+DT37yaJCV/mW9Z9v58ndNQXe0UN5hH9ImEksZoIq/I0gZOPe3vwlpDGNwo/2H8T56L2Iy6wF7OY7INiU9aLwuOTKvHMeMzH/eyj8rb9yMixxh3/sjO/OouI/7ivZ95s8lZb/We/YMnAf76VIgG8jI5y3BvB85ECy3Nx5OIL8VlVO9MwEDZZAF5Lg7jkrijwjOyagYj5pt1DYHy+lPsm7nBipM2Bl1DmaaAV+E9tE7Z/t5M3WfM0fA4PDrUY2LZrTZCSLGa6QrRMHTMpY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(6049299003)(10070799003)(4053099003)(56012099003)(22082099003)(4143699003)(18002099003)(5023799004)(38070700021)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDRyWWcxN0d4QjNuRk5zd2lYbXIzZVBGZFpQVGc4SW54VGloMkpOZGNHb2tm?=
 =?utf-8?B?UHlUc0FTVTVvTm53WUQ0Z2hjeVp6VUJMdFlUclFKTDdkeTNvN2hydEloaVlB?=
 =?utf-8?B?bVc1REpkS1dObzc5aDN6cm9ZV3h1dTEybmVwa25aL1FQcVpkbllZVDhQcXFt?=
 =?utf-8?B?QWZWRTlCc2hVUCtGd2JOZldxSmVneCtSSXVyYzBXcjJMTjhxSTN5eUF2a3Zp?=
 =?utf-8?B?blBVS2ExaWxuWjdjZFcxOFl4NkltR2VZNXVmc1FaUUV4b2lTalU1T3NsdkNF?=
 =?utf-8?B?aEJTSTZXU2c2YytJYW5hVmtTSCtzWjhDVW83YkdXSnZHbFh6ZS9ZMUtUZVdO?=
 =?utf-8?B?RXlUWk9kV2NYb3k0TUVISnNBN3duMUNOQk96SmdiY0tqMlRuZ3UvU1N1bHdp?=
 =?utf-8?B?M0gvQUcvbFBGVWJnN2hEMS8wUS9UYXRlV1lEVEpnOWVSdjFTRWVoT1VKM1Fm?=
 =?utf-8?B?US9OY2xMYkMwbnNXSTg1cVRONTZ0dVlkaVBEUGhiQWV0TVpJdFAweE9QdGNu?=
 =?utf-8?B?dkF6Sjc1Wkp0eDl4WkoyaVRtWnJ1amZnTkVqUnN3WXBmUmRaYnpydjNKalBB?=
 =?utf-8?B?S05IUHphVmdwaTJnY1N1L2VrcnFYWGF5bFV3U2NyZlU4djJTRHEveXJCRHJv?=
 =?utf-8?B?SzRoUUdOWWd4NTUvY3VPZ1VQR2l3aEtiOFJzemQreGtYd1lXYlF0RWRqYWk5?=
 =?utf-8?B?SmdzakpxU1BFM2tiQkoxbHpsTXdqSUl0YWtuZ1M0RVBOUU8zeGNURzZMQTIr?=
 =?utf-8?B?KzUvVUN3MzNodWtFc1E5M2luWUpYMExQek9zbmFpbWtTclBodWhEakwvRURi?=
 =?utf-8?B?RHk2WWEwbVAwb2h4aDZYaDNxZU5mbXU5Skc2OFllQmhSS2loMVBweGVkbFc0?=
 =?utf-8?B?aWtkTUtsNTNHSlNpU0pWWkdZWS9jWWZmdHk5d3dXdEFsYkdubDQ1RmJIN0sx?=
 =?utf-8?B?UXdvNFExUlIrTW5VN1hmUHdPSGo0VEZnM3RJNnZuOFhpRW9MUS9hOVgzaURT?=
 =?utf-8?B?L2RWTEgzUDFtQW1XZnpGZUdQemlYdmVoNlh1M1ZEbW5DRE1RUTZDZFF4eWtv?=
 =?utf-8?B?eGdWOFZ3OCsvM3FpSWdYT1kyMTFWM0p6Z1NRY1VYbjFDcGUvU0ZSbUlaajc4?=
 =?utf-8?B?MTVzSmk5emVYWW1yNVp1YnhLZnF4TFRSaFU1cU14djEzZVVidzVITjFnVlRj?=
 =?utf-8?B?NVZ6OTV2WU9mcWFXTFcvN0JkVDY2M2cwZHEvUEdMRHVZa0pza3gxVE4rQ1lU?=
 =?utf-8?B?STNGYTZhQmQ1cG9mMFRTWUt5OFFJdTFWTFdrb2xwR3VnUTdnd242VURHZGtx?=
 =?utf-8?B?bjRnWXplcm5ldWJvQlRvaU1lVWt2aWdJWDhjWmtNMExuZFgvcnB5NFJKZzNM?=
 =?utf-8?B?ZXlnVGdHUUZ4WHovL21MZHV4ZGk3Rk9vTm5QTjIyczcyZEYwbW5yck02blll?=
 =?utf-8?B?aU5KNk50M3pwbXp5QWs0Y2VYVmptQng0cjkwWUlpYURsdVZZY1IvUzNSRFRW?=
 =?utf-8?B?UGlaYkpJN0JMSnlQY3hlc084czVQR01aNGpVSEpRd3JaR1h1YnlNNEMzSkU2?=
 =?utf-8?B?QjNMNTNnRHdPc3FtRDBEaEV6YXBZdEpxVDk2czFQZlpTVzFMbUwrNGxqZFBJ?=
 =?utf-8?B?VWlrYkxEeVJ4TVdzcmtGVURlRTV4ZjErTEs0bmtNN1hqYVdKbnJrMnFhT1d0?=
 =?utf-8?B?dkROTEdCcmRwZmd1emtpTVRGZGd1UDJYbEdUSDF5M05ROWVTdEl6MGJtZG5i?=
 =?utf-8?B?RU1qWitCbkVuNnFkZ3pGYzFmMVlPa2ZIL082Vzg1Q3prVUlVSXZiY2xHOFl0?=
 =?utf-8?B?bVV0N09CWjMyclAyMTlXZUR2YUxkeTlUTGxuZzR2MXM0bGZTcU9IMmtDUlBw?=
 =?utf-8?B?SVJIbklzV2ZyODluRzRIaUhGTjJNUS8xaWV2dzRMU09hSjRtTzNrc1pZREdF?=
 =?utf-8?B?RHBkaTFqRmNqNk8wS3p5cHRUQU9WSThQVE5zWjBqUGVjU1NiN2NlRk1zRjBj?=
 =?utf-8?B?UXVOcGhjZVdkbWh1ZUVHb0JmYmdQU0pjOU9PZEFVQk4ySDloc2xESXp3NzFW?=
 =?utf-8?B?Q29Ia2ltWjF5aGhqbGliRjE3TGtnUGtRcDRiYmNWRll5cG9QaXhwbDVxMjJu?=
 =?utf-8?B?NElWb1hSNlRlNGRlMkRyL2t3YlhQRkpBbEdHSDNHSS82d01GV0lBamN3R3dU?=
 =?utf-8?B?UjB5TmsvUW5CMitLWGFQcVp1QzRxOGtNdHhETnpnM1ZGSFZJMzNSNHZpQTlY?=
 =?utf-8?B?ZjdzUnNRbkVQTWFub005U3J4U0hrRXlSZHFQNGpIc3l1QUE5NGI1WFdjeEhm?=
 =?utf-8?B?a0E2elBKWjNoUTBmbk9nT2VnZFo4bXlPc2hwbWJTdXpicnkxS1JSV1NwSUd2?=
 =?utf-8?Q?ElmXf3Iq23SWoxQZyKxqmLedm3H6yCwPKyCVN7+8YJLqp?=
x-ms-exchange-antispam-messagedata-1: P66V70x1BXAWLRohrfu7tKawyDrV2d+Mb+8=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-e/aswTEx4ljbVZpbRnX/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	U03ECpImlhQa4RzHLesHhsQMA2AYiy4dEW3dxu31/jf/V+SLkXxTr8NklWcTmY0rxqSytKkKKWCYFL15MkAXMsPVU9ygmTkRe++L5t4etax3G8aV66G/ql+LMRdzm+2UWK3CBYyYriVUjCTRAixjkSLB3rKQcFNp60Hs3Cwwo0y/8e/QM/DeIxouOcIxYEG1EYEG3NAD90gBzfIGct6A1mRvzUL5EB6sXmRaK27WYqjLDN/avHlrTTau8VPtHCKTU5+iIhiorhWpjENnWRXLnIfgy0iNLrs+1tRKU0xXWOq/a3eLJ6DkZnFU8goTgEQlFETEn1mXq+kJ9It+A4uMBg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LSn3Gv51TEbwQkpr7gSk5Q6Be8FFXaQfzMRPOW/HsRhsAAqXsKqI7zU6Ld+3L2tkZiZ3SU2emdITzGvxkc617jkc8N8d3ycLsv277XMClxDhvPh0He4Uxb9FeqpPH096jpELmVxKD6rxP3KKSUled9wVYDANytJ3tt486b4yUD8G/w3XHBQ9LZTSjT/yW4NVDCkUzTDHQf/OyoQuGN7xJSr+ApuiA4PSqs+vAGAN3cU//eNVbWvMZlxmypRHLcxP2FUYbKyi5y0b/wjQSliyuy7D2JT8pMAtVjFpN4QJKrP39yp4dHZZYLTa49lIwNZmk+xAvrDW4+rq0XreBzNWWVXdDPH98J4CXof8elgrObtzciQ2SUUHiQiG5axEDDvRQulOMtz/cDhHS241cFbXP9JEBEDxsGv8pGEKdsNRvolO6rAtN5AcbN81uh9rkIfpa491XxqtN+4DH0vm/0Z6TDa9p4Mds7ekkPMPbNwY7hDK3bB/ADV5VnfRGeU2SH8YlPZai45SypVa8yP17kzz7oLOKvGxOoijy6USjiX8X041wc8ySc3dz92/CdsRvL/hx9hCbOEdGRACL1W8gc+tmNu+e107Oe8JN1v5XWs+p4o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c751b088-0c5c-4247-1dcd-08deb6ef337e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 04:12:41.0283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ZSXByYamFlRySxjDqpVpEfHfxqlKh7xJ7ZaJq9mesG+fMzmlKQIp/o3gM2rWnV9/eoXjEG2wTLhlmDELpacnLCL2NYPNSfkWonxANKeNs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6032
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605210037
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAzNiBTYWx0ZWRfX4Jheek+5EltF
 kxv1516TvR8n+nlEDvMLSoOSXSWR3E0fEpIolkTbR53i0kh99ivBQsGZUvPeWWhbyI4MUVL3fkt
 wePezstq1h0cS2ZskooGkS82TFQi5ZI1M2tS0CZvgzhNnZJhODBC1yUh7HLkFh4EFaZwp+Kr6Pw
 pQgA58K+PC6o+DNiNHQele0Y7ZZ0v/OEa+zR+sQki+D/pOAkOQLUF+8igqfBTQ4nskOVsxTXcH7
 WghD4dprROI+PjvOosYBELZk4JW/7LIkfEcbycuSAoh95SoGKMci+VLXVmriUuC1lGLnrIYI5fz
 abacTEnfopphYtZ86ZiMsl8n17G1kcQLT9cfe6BO5QtsaDavnNxmoiy4MIxY+Tt1pgo6hBl9DBi
 UXM3srW8uVrO4tKCfLhJ0UFLXFQ/bFjGMeQWTqKNq1QlLRkmy8MkBEY4GXcQFM5QDcjrxU16F0h
 rSi2gG0ZAtkJkFYRYdg==
X-Authority-Analysis: v=2.4 cv=Ls2iDHdc c=1 sm=1 tr=0 ts=6a0e863f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22
 a=VwQbUJbxAAAA:8 a=iER9q-A39bkchfbUawkA:9 a=QEXdDO2ut3YA:10
 a=QcvAUOehpIHYeKHwSfsA:9 a=FfaGCDsud1wA:10
X-Proofpoint-ORIG-GUID: QUmTWY7v_sSKi8C2xcmRq5CN8lH8UYhs
X-Proofpoint-GUID: QUmTWY7v_sSKi8C2xcmRq5CN8lH8UYhs

--=-e/aswTEx4ljbVZpbRnX/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21 2026 at 06:42:00 +0530, brian m. carlson wrote:
> > Assisted-by: Codex:gpt-5.5-xhigh-fast
>=20
> Just a question here: was this written in whole or in part by Codex, or
> was it just used as a reference to ask questions?  I ask because the
> style of notes-external.c differs quite a bit from the style we use (for
> one, the horizontal rule comments) and we have this in

AI tools typically don't generate comments in code like in this series,
you can see by trying out for yourself. Each comment is hand-written by
me. Sorry, I'll remove those lines in v2 after this discussion.

AI was used for review, and providing the initial skeletal, which I
changed significantly.

> SubmittingPatches:
>=20
>     The Developer's Certificate of Origin requires contributors to certif=
y
>     that they know the origin of their contributions to the project and
>     that they have the right to submit it under the project's license.
>     It's not yet clear that this can be legally satisfied when submitting
>     significant amount of content that has been generated by AI tools.
>=20
>     [...]
>=20
>     To avoid these issues, we will reject anything that looks AI
>     generated, that sounds overly formal or bloated, that looks like AI
>     slop, that looks good on the surface but makes no sense, or that
>     senders don=E2=80=99t understand or cannot explain.

Please tell me why this change is a slop and doesn't make sense.

If I wanted to mislead here, I would not have used the "Assisted-by"
trailer, which is now being used in kernel land:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#usin=
g-assisted-by

There have already been commits in the git.git history having the
Assisted-by trailer.

> I'll note that it also has a lot of global variables, which are common
> in the codebase but we're trying to move away from,=C2=A0

Is there a new facility to store the config without a global variable?

If the issue is the number, I can make a housing struct if you want.

> and it's more
> verbose in commenting than we'd normally see elsewhere in the codebase.

I added comments to explain the code clearly as it's being followed,
especially since this is a new feature and I wanted the intent to be
clear.

If you could tell me which comments to remove, that would be great.

Thanks,
Siddh

--=-e/aswTEx4ljbVZpbRnX/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmoOhjQACgkQBwq/MEwk
8ioi6A//UOvAT0kmi2ls2SxTQ5RbuRUUNeAyK4UZZKmt3h+gxaPTzScoy9r+0q1q
ydgxu5LvMxsrXmdhUtMxp9o1Q1eIKsyMIrf4wTpz3sce1z5PqXRntmvfSHTX/IfU
2kHrCnWSsyzNOt0lVXoeQgitlhX7dQjJomwNzPBNpHnAPmciv9t/7U4CgLKjZozr
Zi+z2DubJHcF8ShzDzkIPSCxbLuuMHWbvcCEecEHzulENr0KTIeunJpx/pyEcQHE
iXnfdNnhP6u3T9n/UJ2ZeddRNjvrzVj8UD4VONFVxY1g4Rufwtuu7ogCi+qILB8w
aEj77hLgdHgrXJm4XOnUM5Vx2+mNrZ+9YBFTdOKQqzRwB1/5e0Dd3MJGFBLjnW65
unHX0QwLe5rhCa3JAIhpH7Q3kfz3p1DW88HKe+br5Kh1VmuvLWAICT0uibZlF5a+
ufw05v4vrlo+EqtxIuKRJqP639oaZSf6+5gk6Css+bymbZFMv/5kDHpDLlyzUVKw
r+0U8xcBlRTuAwLIayInqorBwgJZEb0b26Ql+tSm7eDWg78rDA8gKyOm4bgSJAcQ
Y3/zeETvGpKC6HfOqtuAninVG/Bfq3SlZEN5QAUlZDxORp0ptVu6Pw79adEJN781
cUHoT7bRFjTbqnbmIxLmHKA7Y8k/t+MNArFqLH6KeM4EB6Ysmr0=
=NrIO
-----END PGP SIGNATURE-----

--=-e/aswTEx4ljbVZpbRnX/--
