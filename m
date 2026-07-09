Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDCF40E8DC
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595463; cv=fail; b=d9FVlMFNxTtCL97ffkLuGQud+dHhH6JL0MoZAawWD7uo9TdAK2VEKF3l2wzeN3w4+XVbPSaaeoHYX1abCPKSerQnbatCH3pbO1XBH4yxTVY2THWfB3WOBcDKSkeHCnJHeSRtPgV0bWVdRiyZdxin/PqrdrjS2hPBDPLvsBVYwrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595463; c=relaxed/simple;
	bh=zFWdG3uB91JTg6vmRntddOYkuv76TZVwkADu5cBbr/M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rtkxQovbnIFg55qf7Ppl3EsVDzTxlib07x5h/S1hTqFHyClmJR4s+I/ztbWIz+3JuL+HHwNpZKF9FAPOpW7dQPxt+lNaL5Od+fPI7qCO6s+1RrFHM+kag90Hrk7zmNjVZ5iniggQdEbKXudN4/MZW4bQN7hDgoYjp3PlD6jUihA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KvqPnIXt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PHB3ON8K; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KvqPnIXt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PHB3ON8K"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6693IJOK388473;
	Thu, 9 Jul 2026 11:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zFWdG3uB91JTg6vmRn
	tddOYkuv76TZVwkADu5cBbr/M=; b=KvqPnIXtxCMpeiz6w9pAlT3D1cIKsetVE5
	9cYH0HMQ/ulYyC04VncbMXrtHGBa9eYqeYyEVdJZdPYTOVBrS2HI9VUXMvPk5hHI
	XyXdMly+plgISnZ7DYfZMwhKQKtCId7VU0xjJUypeKPhs5ctHx5svEz8jEro1oJF
	x9S+mSuYiiI/0CNyqT7MOZbCc0uBJPpQIDlgXc/wC7K8lLImRncsmGOI8KVXLOsC
	lJH7y29jsyv3r9qjGEmsp1Ym4Ut3tG/iX5MCO7/Gi3yqhiFUZd7Ix5VndbAEULmT
	yVAtOMb3Eu3oKSNghx+K4EaolktIz/vyN/4ZwtptONFUozlRP2Ug==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f6tqs96c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jul 2026 11:10:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 669B3WCW006618;
	Thu, 9 Jul 2026 11:10:41 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013050.outbound.protection.outlook.com [40.93.196.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f6rmg378v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jul 2026 11:10:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMuaVTnduX3hWBf2YWzpuNQlJlbob5ATMP5hgZCggDOYqpzctUZXgVvvj9jN9xouDoNvIu2kvw8w9/7ibvGEwn7G3WgEhpOwzQfjkKaONL229lZVrpMA8Dv+dgHQbs/QtSUWytrYxQ2uZ+zL93mfkzzR9pwnx7QKCx7j6liBuD6jDTFk6cPVE/AJv6JWuiH2/VwxZ6jMhV9ie4IBlOszO0LrD+M9jgq+5Mq1R80PGTgu5RZR+Fsjfi/bJQaxsW86umXQ8YaEK/I/IgDxFRbqdblN9WfLCZltBKcwuQyzAxWh+dBWHfivOUEyUNmAMU9yIB7HZIYGs+HEJk1rT9N8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFWdG3uB91JTg6vmRntddOYkuv76TZVwkADu5cBbr/M=;
 b=nr6k4RwflMcw/rhLdWAS92ZxLidEarfq+bq4IWn0rX0kBj+h38ODPPTfjMNWT3UAL07Qzp7Ju+/AVAslZ2NjDGIp+yNsKWKrmoZasrSV8yoDKl/4iX1R0GeiMeLrbCTjoqk6A2h8Jb0DvCqsx2nGhLGOrTPHgh3uZGa52cL80aAPYVUJGwQHz8gN8YTfEVyOagWG7HrCEf+xwsGIQ4Pel0IfUCRAICa6R7nGW9rFqgCpK/gL5WGCeABBeGd0fpU7GzT4AgouHVwM9N4QN3bUOBds4TejsgwQwO51tOSA/YVHcc9cyEYFpqjtkmwkK+43qK5TQoHHfr9/f9H3lobwvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFWdG3uB91JTg6vmRntddOYkuv76TZVwkADu5cBbr/M=;
 b=PHB3ON8KWWuFWvEZybT4gL5e/Wy5neUPnR9UOojn+C1pxgRgfJIQRAkes3TE3xyfO5MqTsfkXDwZ15X1k8BRMd4hPsA/XizuozWP8Dwzn3SrQpyMcnK/e2DNoZGRmsc8i1n+2DljxCBmhdoAUMd7Y5swRzI52VqwSOh9qKoBO5A=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH0PR10MB4661.namprd10.prod.outlook.com (2603:10b6:510:42::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.16; Thu, 9 Jul 2026 11:10:35 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 11:10:35 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "j6t@kdbg.org" <j6t@kdbg.org>
CC: "oswald.buddenhagen@gmx.de" <oswald.buddenhagen@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "code@khaugsbakk.name"
	<code@khaugsbakk.name>,
        "peff@peff.net" <peff@peff.net>, "ps@pks.im"
	<ps@pks.im>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "newren@gmail.com" <newren@gmail.com>
Subject: Re: [PATCH v3 4/4] notes: support an external command to display
 notes
Thread-Topic: [PATCH v3 4/4] notes: support an external command to display
 notes
Thread-Index: AQHdA79PzBPlUtUocUSnOOEhBtTP57ZlH5GA
Date: Thu, 9 Jul 2026 11:10:35 +0000
Message-ID: <65e2e9f6f30b74725ca4516424e8d7116383e368.camel@oracle.com>
References: <cover.1779532562.git.siddh.raman.pant@oracle.com>
				 <7284a8bccb6bfb5734adb09f05ae4b61a63da2df.1779532562.git.siddh.raman.pant@oracle.com>
				 <3a2ba6c0-4ced-4d2c-820e-401c2dff1dd1@kdbg.org>
	 <76cc093d2835a7b3ed110e20f1480dbe5fc2ecbb.camel@oracle.com>
In-Reply-To: <76cc093d2835a7b3ed110e20f1480dbe5fc2ecbb.camel@oracle.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|PH0PR10MB4661:EE_
x-ms-office365-filtering-correlation-id: 87a205f2-60d4-496d-7f40-08deddaab329
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|23010399003|1800799024|6049299003|4053099003|38070700021|18002099003|22082099003|6133799003|56012099006|5023799004|4143699003;
x-microsoft-antispam-message-info:
 TB/68JhagRFtFk2lSzVAoCHswXifQB9UTmLp4MVJJigbz8sX9sgCiYeG8owxjYF2O8oVMXKYkUmhlYQSPwRtu/SolxHvqMbu1T9y7CkMj9g8YdDi0wyjvtkLRspGjYKx3e9ZWS72/QiNHxkqDY/io2HsysS9IKl4vHb86XrDvl8MdCu92bWHtOt6rOccrsH/Vd/I7b97IovzZfasbfzjaJM+LN71ievpv+zPJnJ59To4P+NfvqHShlXw5NmxjvnFPow7zZ1Ak3iJNjHElg6w7aBclnz24+UhIaE/CXjH5KyAAlQjTymXQXl+34uawD4jbxsxG4B4ickS+QyNesef5b9k885zUjRefgvCUa5a5b1oknLcw3MNJJvQ3AwLrOanJMRSoubr6CI8nfDpFKRN165lQqj1xmE1816CEHEXOWZlMihjmJsEzdXkPYDorL3NV85mynVbCRaV/lU2dD9eOaS51R+lppp+v4m6aaTc0Z3NZGM3ky9slRMoAsTvCrG/nZjjI4JLmF64ThTXWlgSwTRwVdc2tQLZzNAkYcPrCsQ9qKCIzouYEQY0s/NsPfmyu6gILL3rz/UN4OH6AY2VhAur2vFXJQ89dUdoSk9o1EswnLumDle4o12AwFtqSLPwYQrhFmnnJ5mmInh51M7P5AtdbQ/KfWDTn5vbrTahJBvPvh6vQ2XNVNerF5Aju/FnFx+LdfuazN2rRJTsNx5CiVOYGzzNkxkMx/GmO6RUI34=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(23010399003)(1800799024)(6049299003)(4053099003)(38070700021)(18002099003)(22082099003)(6133799003)(56012099006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHFTS0N1U3VmeGk4R093ZXVRQmQvbW10RVFIalN5a1M0OXI0T0w5K0VleVI0?=
 =?utf-8?B?c0luTnBUQ1lFenJxZmdaaGErdXAwV1pPaFpVQTJVV2tGVFljbW15Y01sWHQ3?=
 =?utf-8?B?V1FVNDI3Umd2c1JpcVVQenF2d0VuenNKTVFGVnp5cUcxZlR1M2toR01HRHBD?=
 =?utf-8?B?cmN1K053cE01R1gzMkVkMTdwN3BwaG1oNUw0ckN1WjhZSDR5bEg2Z3FtQjlm?=
 =?utf-8?B?YlhQU256NERzZmRaMktzRzE5M0VqZnVrWHNaWktWVHN5emUrZWM4NzF3ZUl1?=
 =?utf-8?B?b2NxQXVVbnlCYTJCMERWS0FtSmJIc01ieFoxSkJwWkVTMHRITG1STEs3Z0dC?=
 =?utf-8?B?NGU0WHNRMGdrZlJQOC9LZkRVU3VOcjJkTjhZNnJJQ2ZRT2NjakxlOCtld1p1?=
 =?utf-8?B?N0szcU1LQVloRkxqb01hT3didmVqQlFrREdFa2ZQT2w3Zkp4M2pUWGovTDRs?=
 =?utf-8?B?V2tBWjdJQ08wQnJCSlRxRnlPamtzMzVMa3dTOEtZbGZvOE10ZnFZMWRQUEFx?=
 =?utf-8?B?eXNLVDlVeDZELzlmWXZzWk4zazBORGYyTGtvN1FSS0ZKSHdQTzdPT2xyKzY3?=
 =?utf-8?B?dS84bUtMMHBEUFNRdTQrekY2cnppUDVnUG1IRWZ1UG16VFdNdDNzR2trOW1j?=
 =?utf-8?B?NUZkZi9VbzZ1NjBad1RURFlVVTdzRDFKd2tYTjVYcjBHSXpIeU1uWUR6TDcx?=
 =?utf-8?B?U0R6OThGZE14TG9iaUJ6MDhzcHJGdytkL2lxWi80UlVrNzN4S3FoSldTY2c3?=
 =?utf-8?B?RXVQcWwrbjB2aTZ4TkpibVlMYklacUVRUnBEdzdDZ3BPQlU1Y3NnTXJBRTlz?=
 =?utf-8?B?QUtxbms4cnVSMlpqQlFYZGVNWlNMMTlZRmdvVDE0aW9EL3pQNkI3UmFtNXlR?=
 =?utf-8?B?MEs4L3FmMnpnc3oxWXEzOUt5bDJ5ZmJLVExKM0FaQXYybmM5QjlhM2xDVDZr?=
 =?utf-8?B?LzN0Ky9wU3V0OEhXUFh1cCtWNGtZaG4xdUowTGV1SlJmYkpZd3FQcEd6L0lV?=
 =?utf-8?B?emtDeS9FT3JibnRPc2xCMnI0T3dFNnNnMzFlWUFiZWNMZGxJQm90aGpWL0lZ?=
 =?utf-8?B?bkRXVkZpWWVTSzY4YTAzZmdNYkpXSkxMZ1B6NittazlycHdQZ0pCeHR3Z1Bj?=
 =?utf-8?B?eGI1Rjk3eHNXTWU3NnNmR0w2S3p0VE1RWkYzSi81VWNibG9wRUdzbUs0VGM2?=
 =?utf-8?B?dzNRK1REMHdrdGhXU0U4c0ZMYVFPM241cVBzbHJrblpsdDEvWWNucXRWbjA2?=
 =?utf-8?B?Q1FCTXA0YklWV0J6RVZpcTBPOVUrZDV0dTBWVmVMWG5VL2xNSXVOQjdQblJk?=
 =?utf-8?B?UHdsQWlxc3B0bzV3ZlNzL2RDQzdxQ3FvMEdRaHVydGM4ZU1BUFJ2cWI1VnFR?=
 =?utf-8?B?TWo1NHhKUVdRV0lBQmFMaXY0aDFJanRPT1NzbFpKWHRJZUttZXdnNXppQ0g0?=
 =?utf-8?B?YmtqRjdVQjArSnRTUm90bEVsaWpxZTZGdzRmOTkvQlBNS0lNRHZJS2gyZXIx?=
 =?utf-8?B?T3NBUkJvak4xM1IzczlWRHVCUU4yaldyMXg2UXkwOEgwaXlHR2FhS3hTZzI4?=
 =?utf-8?B?VjJrVlNhTDkzb3ZjNjN6ejVNWmVheG5zSHhEUUhDZWViTTlHREZ5YS9FdDJa?=
 =?utf-8?B?R1haQ1BxaEFpYzBxZ2J6d095SjFUTHlPSS92b1l5OHE4Mi90STc3K0tiTm41?=
 =?utf-8?B?cnpvRzZKSTZqTkhLekwxTjNRbjFhazA0Tkg0U2VZV2liZG1lVS9zZ2dqYm0x?=
 =?utf-8?B?d3QzZ1V6amV0NENQRUNxbktFTWFwSDNRYXRLZXFKbUN4Mnc5dVZsL1V3Tm8r?=
 =?utf-8?B?SkdhYktFdlFjZkI5eStITy93QUhta2hwYndxV0VVaVNTR0lIbXRuY1VxdnBm?=
 =?utf-8?B?RUlwdjc0TlhWOHhmWFVoSldwVFl6bFhLME13TXA5TjRFMEZ3Q3c5VytHVXdH?=
 =?utf-8?B?bjU5RW05ZkIyQUFSb2FHcFRqcmhjYXM5R2Z0QUZPZjVWME8vanJ3ZTFaMlo0?=
 =?utf-8?B?NG9iUjFvT2t4K01TNlJYL0x2SXl6cmtNYmNhd1NmSG5wUmM3K094Mm4rRHM2?=
 =?utf-8?B?YVdZRzQwQ051WnlTb2k1ajlNdFZSWlhJdXZSUkwrUkMzS0tISFFWQkdTcjdP?=
 =?utf-8?B?enZkTytVbC9zWU5hdXVHSm9BeWJLWFI0SEZxV09KZXVSMGU2TE5mZmpSaU1m?=
 =?utf-8?B?ZXBUdVBFR2YwYXd3VlBicyt3aGxxSEhobmZjSzA2ZTBVYmNNeU16bWpPMUt1?=
 =?utf-8?B?K0I2dGxnc3R3OWFCQ1lYdzZrNFd5RlBTcFpDQW5ZSGNnbzdEY3hiaXYyUVg1?=
 =?utf-8?B?Sjh6R3l4NzFHV3p2SzYrbUh2TDh4R0JROUN3SVVxSGZNaEhhRy96NHpQNW45?=
 =?utf-8?Q?+fJ14STUyWuAW+5SBMw1ROpIqSpdyLBKTvbSZHtuBT5bD?=
x-ms-exchange-antispam-messagedata-1: rRQBVn7Icsowk6TPzA598UD94BnRyM12+sY=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-Gs5UWRXM+KIZmsOTkq2A"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Be5l/cldJ09P+FJqAiMdRPwWCI8apB5JJu8qoCDXqtRa1DjLGNCwB6r5pdhEMiRJ/EgUTakXGcek1puy2zdYzINHp8y2s46SP5jxIsUxvccyecu/Nm9ttPuN8OBEndHUTlogrVjlUFgCxQqa/iPYcz5WuEjo63OPPRNrIG1vUyG/yoIdqzhvZw3cbUVRJfyNEnfzXDDiZaisLHKPdbXe4ae89G9jVV68NX07VeX+X+YvTxRs7UjIFHNsz/s2Aro4+S+XDUg6+fkpMm5gXL7De1h4HY25jztEnOtdLmyAxQhdxClEdhAEEsGRqkD0GOAlBtj0KEC7J7snl0GjKBYT2w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RK3qD/nuYQ4AHv8rW1TTOOGVnH01C2+gjvdcp63vhk1LgwUGs6Al+cVSBD5Yl4csDbI/u+rEYuaLJm8JalI9tXJUo26X836Orw0tIpdipfSforuVQlBGYtzh01nxUu7GJQR6FBMsLMg+BR721rB942DxG/GOXVJQU3/yHvtjjtPrQ7DT699PDk9WnKIg9QVdn9LhsnbivJcm2Dy5CEKN46xI1EWi2qQaGLQPRxhTpe9HxWKpirQIIX92dI6VhitwAy5QlSMPyBNnrD74hlc86ESCxNMeeth5QGTOQbmdVuFBpb8+QfsY77hl0Kf0l3/ySRkRFnIibg89u+MdfKeSX196QlNRSsOErkiZcHxtICTGxAF+UPGYlCyB0RDZDHy2V4YVUSddH2ULRgvNvltT9FPlbkJ/hIOfXotD4lb6Se2jhzVtje/i6yoMCbwqPE8HmpJsaIehokpY4mgvype05+A8ajEagVIfseL2GsxOvk3/QRPfyUKZbFZJnxyvEsUxvW9ov5759xZsYW/8uQ9ycEkPUbNXld+96O6TpN9UiBIGv7JBNxXNUHYcioLYVmUo58xv47qGeijgJPwukQsIRRUkB6eS391ZtwveMcJIU4E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a205f2-60d4-496d-7f40-08deddaab329
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 11:10:35.2488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EYEBiX00PYdmE6bfPemVtGctFA89h8NGbcUQBZUcEWTjGLV41NyONzjD4Nu+CDUxKlYyn816D1k2XKN9cjQj7fDHKLiCrbfnRUi3c4i1vwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607090107
X-Authority-Analysis: v=2.4 cv=BMaDalQG c=1 sm=1 tr=0 ts=6a4f81b3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=4ueCcf8Ae8Bajcbl8LEA:9 a=QEXdDO2ut3YA:10
 a=PBWkXEPnnw1BImiHNCAA:9 a=FfaGCDsud1wA:10
X-Proofpoint-GUID: I_z1q5DL4atKzAK8lGgsg8WFOjcLCsuZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwNyBTYWx0ZWRfXwkvargvkDw5E
 wuzNwbUy8cMMKXNSwp+OmewRmqVTH0PVGEVQJPd1920n3nPEECDKR89WZtZ1TGV4/70pK+0BIJK
 XrNaDT3x40ILoAk0O9txiHQdeVpnM/+0cFZjs8/HFck4QeBEp/cV
X-Proofpoint-ORIG-GUID: I_z1q5DL4atKzAK8lGgsg8WFOjcLCsuZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwNyBTYWx0ZWRfX21YqZC65qErp
 u2W7Z+j35arPDzvbxAwCst41hpwq5pErd7FNtfPHARxz3Vdy2PM31ZMbSzq4sNisOw77vKa6/U/
 Ez906boFtfq0wKy2PK4qjKMlw+aetH8i/0EzYebWeLWe9LPpOtp2IrftbY7bEasYTQua50r19F4
 y9SfFms0EeVB7K7Y2OHzVdrfttvdW1+H/I1gmdodSXmK2bUb/R2nMTIve6HnCHhJvNHyzlh5g+5
 Pc75GVz8LoaZj5alM4/bITv6VaNgY94dFYv0IDBzGMxU2rfQcEDGTFVK84hSSkdygUiIuWN7zPL
 RN4BvyjmP8wRlarvpUQZ6R9wiYVZCR9pyjOIRk2+8h0GLVGIql/DJmU8PwS9U1ptPl5zc5KpgqI
 UDYB+I6yaeQncLFBGFZVFuEtJo2X/gMieJ8RSKpDIlhp/B2zJgCUlI1GR/Psa+RoJL12cPQc3Jm
 obvD7B7IefbLGtwzZ8g==

--=-Gs5UWRXM+KIZmsOTkq2A
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Going by no response, I assume this is NACK'd then?

Thanks,
Siddh

On Wed, Jun 24 2026 at 15:23:23 +0530, Siddh Raman Pant wrote:
> On Wed, Jun 24 2026 at 13:19:26 +0530, Johannes Sixt wrote:
> > > One solution to this is to move the freshness policy out of git so th=
at
> > > it is someone else's problem. We can have a realtime fetch or faster
> > > updation via external helper means. But unfortunately we lose the
> > > coherence in the display of information, and so the user would end up
> > > reinventing git log in his quest to have same workflow.
> >=20
> > You are presenting one solution here. But a more obvious solution would
> > have been to make Git's notes implementation capable enough to keep up
> > with the volume of notes that are produced by your team.
>=20
> Git storage is inherently based on refs, so that would require massive
> changes IMO. The actual fundamental problem here is that only the
> latest state is useful at any given point of time, and not the past
> history.
>=20
> > Another solution would be to track the information outside of Git notes
> > entirely, similar to how pull requests, issues, reviews, and
> > conversations are tracked by Git hosters in databases outside of Git.
>=20
> This is precisely what this allows for. The information is tracked
> outside of Git, and the notes path just shows it along with the commit.
>=20
> A developer works on the code using Git. An external website doesn't
> allow the same level of coherence in display of information as a note.
> The commit is a fundamental unit of change. IMO it makes sense for Git
> to be able to show a note about it from a provided external medium.
>=20
> > > Let's add support for notes.externalCommand, a protected-configuratio=
n
> > > command that git runs as a long-lived helper when displaying notes. g=
it
> > > sends commit IDs to the helper and displays any returned text through
> > > the existing notes formatting path. This keeps presentation in git
> > > while letting the helper decide how fresh note text is obtained.
> >=20
> > To my eyes, this looks like an overengineered solution that helps one
> > user of a niche feature of Git.
>=20
> This can also allow for other uses too. For example, searching lore I
> just found out that a colleague in Oracle Linux (Vegard) was trying to
> solve a related problem in 2022:
>=20
> https://lore.kernel.org/git/20220802075401.2393-1-vegard.nossum@oracle.co=
m/
>=20
> I think it was for achieving something like this more generally:
> https://git.kernel.org/pub/scm/linux/kernel/git/vegard/linux.git/commit/?=
id=3D339f83612f3a569b194680768b22bf113c26a29d
>=20
> An external notes command can be a solution for it.
>=20
> Thanks,
> Siddh

--=-Gs5UWRXM+KIZmsOTkq2A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmpPgZ0ACgkQBwq/MEwk
8ipuRg//Ya+Ht5YFJ9IGZp5KMtABdmnz3adkD4qfu3vyjMEpYUmY04XfCKt9+rRA
mG8Nd9FvTbvH5C3PBWYuOLQNAms61ZH0Kcq4sIsrGuVrBC7iVANVrXYgzTFy2iFI
r16yM3Ex9eFRLkXPalPMAQprThMNZyS0sm0mLuHn5E7iu1Y2mSC+S49vMmnbRz1w
Kj6ugFYNXpEinEiEUx9zMPlWBReyT8q59Mrw/zISfouN/2Wp825TT35XoF7JvVdr
fZ4BGG7abVERUam5hX5l0WXI3HQhykdJHUx1ynljj7y/d1GHF0461yGJgiuWwyGh
WEmZ8F92u475mHzhyY4ypLBtZIb+yifqrakyaX28BlbCpSlab99+ypoYiObsv244
WO+GoqkMlQdZXkvh7R6sXME4ogTYryWRkWoUMKdM0sFSTHrL5FKOTKezcNGSRK2C
70YPreygoZMHJVB3QThFh9Eurna1WKawln1eoY7YwZuYF+srZpokVSZeM9gy3JV3
p5srwL031tfYuBR44GqYPs8ZPpJmgheztHBcAxR9ejscDKE7v3cMEM9HRNFCa0vp
PI4+0LvYNSMQyXnCQBsEiIOgNkHFCiIyCuPJf9zJLCfRLrcRyaOI2670dX8KzHFj
KSaSkGUVLp8DCTaPfCgyCqmkFFX9tcLSdkyXwxdqNDpgsf6pmzA=
=KN2h
-----END PGP SIGNATURE-----

--=-Gs5UWRXM+KIZmsOTkq2A--
