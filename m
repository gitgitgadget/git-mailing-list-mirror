Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750223B5305
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294833; cv=fail; b=szz/d1EWfLVvJ1Woo5LuNae1zzbyC62e5uzTduwWyDqrFdJ59xFCm1fINFY+UwKSUIjz5YU4QqsVOjxsuqNSTUkIXs82S452HxFtzn8nYrWNzYOj9lFMiIfACmrMysLnB1yih/EMCQPCRU2mXcXTc/rbI1dX3bsHr/9Ojj3b1sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294833; c=relaxed/simple;
	bh=2hopxAPQ87uxJ/ne0gNvlEzTRzTXzX5UD51moYDSe8A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=reglAS51gVDq4u+dC6Z80+w7RTQxiRSfSbuSJ0TUW5eLklLCidbdhqdRtvL6KvStP+Qg1B9Uo9IhmlL9HlVbziEdWClyu69GAjAja1Z/4m8hM5BmomykocVqXB4wrTSXcXxYZtGHe2JHAgZlMgvh8PizR5vFGa0Mix4WIiz8dqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k4mf0xGA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OD9i4Drq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k4mf0xGA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OD9i4Drq"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O0hPeJ1129630;
	Wed, 24 Jun 2026 09:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2hopxAPQ87uxJ/ne0g
	NvlEzTRzTXzX5UD51moYDSe8A=; b=k4mf0xGAsQvgBwvTfCVMGGP5GpGaa28eyF
	E1FUPiPys/Vp9fqJuWOCmKe9ukpZiaFAZPHWuayW1662YSqAlmlZKiSL1j/V0jwf
	fatECWtxzZZCAfY90C5InLqJVrO3CXYfdsuNx1IWW8U48EmjuUr2QQ+CwPGccptY
	N5t126Is5F2aVBDeMNByB3gQkxmqpcDQLwSf5OHAPSu8qRPV9Y93hmYI492KepbW
	AVBpMavH61iWpdkeECoYYitxJzGLLkrhDROQW8gZL4fgv2hJl6/9CJrjqhFLFivE
	njN/MDlILPHGFxN3g11KfETSQSkQmE6bSXL4TyRgWYI7v/I08+WA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewhn2w71f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 09:53:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65O9rBmJ000612;
	Wed, 24 Jun 2026 09:53:32 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ewhadbfbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 09:53:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSyXs4uO/WaOXPNdm5uhFoUgQx7190eayk3St7VfP5FY2ecs47AE9L00ax9fz82/PQf4DJjND6DEzpidz3cZZPA1vMohBLSl9qRQ56SzH1BDagzImyfqdqisgBZ9ziXLv7/a/hsJgVR0pmr/0Tf5yCH9iew1FYQpEyPSbnexWys/8F/tCFZszXQ4P79bT3X5Dx/Cpz3nMZlJBF7YG91Z0l+df3ZpaQZTTwnpoBaHoXh6Hz7zyHMC99VmSmRTSza7mTgsbfOKWyM0ELbC2VIK3Z/2IBzt0Q2kIEQ36vT1aYVztKMcN4UV8gfdKSVi+CIAnNNRaDT9eBLgpi8wK/WXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hopxAPQ87uxJ/ne0gNvlEzTRzTXzX5UD51moYDSe8A=;
 b=hC9SERbvfPb/73Rwyww4YtQEtY2ToMLVuwgGFoujd1XFFAgduHwj1WrhfJKd9uBtqsByjj29rUvg2iL8PJZI1ySJrxg1/Ex2lwAU9azxDap0eVarn1V67mJFCRAvgA6F/eNZ8EL5uyxHJcLhQrfx8bU7unNHJIeeTXF0Zxtd84YLa4c+HJRsi9FFavog6if5455/S6muO4f1T7lGELSC60kusb6p7lOlmJURtRORsNrUgfS+jveAtc8YDGVslVe7i221lcENuEh4csowqzO9dxnD842oVuiswBWw65op2cQF+dyFtG0QMo7RQnFy24FDbWhqD3XDddk/SsVjyNozVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hopxAPQ87uxJ/ne0gNvlEzTRzTXzX5UD51moYDSe8A=;
 b=OD9i4Drq1W7isJwmjul02VusT7LVMgnysBUxKNfL7S0VxpdKs1akdWr5yCNKZ5OTTSgyJj9JlmdaDdI/CAdvvk+2ZRP2dE0uQS0Y2KA1PzoY0+ncXF/MUy9oOGF6EaFQMfwEMADsxa1uWu0DIAiXisuXQEaMdOp90mFojdupfZ0=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 IA0PR10MB7133.namprd10.prod.outlook.com (2603:10b6:208:400::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 09:53:29 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 09:53:29 +0000
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
Thread-Index: AQHdA79OU/oyYA61J0u6ARzS/32hcQ==
Date: Wed, 24 Jun 2026 09:53:28 +0000
Message-ID: <76cc093d2835a7b3ed110e20f1480dbe5fc2ecbb.camel@oracle.com>
References: <cover.1779532562.git.siddh.raman.pant@oracle.com>
			 <7284a8bccb6bfb5734adb09f05ae4b61a63da2df.1779532562.git.siddh.raman.pant@oracle.com>
			 <3a2ba6c0-4ced-4d2c-820e-401c2dff1dd1@kdbg.org>
In-Reply-To: <3a2ba6c0-4ced-4d2c-820e-401c2dff1dd1@kdbg.org>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|IA0PR10MB7133:EE_
x-ms-office365-filtering-correlation-id: 01b31897-33cf-40d9-af6c-08ded1d67170
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|6049299003|56012099006|5023799004|6133799003|18002099003|22082099003|4143699003|38070700021|4053099003;
x-microsoft-antispam-message-info:
 YJBHbK0Z1SK37jXEFL9xe4hqrNepATlUzOX0j6TXOT2ry0b4A/qwlnWDVwpjeXzP1J+pg19xlzrv+GnQgIG+AIA/S5DkvDCi+TBN4F1Ot9YTHfzyZF4bYRTvtjXJhqUx3UhJjFvOAy9GWHh7aWPkkEHnSGHA1ma2S0dFS5jUecJdZ1IEroVUVdSSO3w8JU2dwvCdibipBKER5HDWaPlGkLnwuwRyoAGUE6WdqbNFCVymXE8tfCNV2ZYZj7XCv1LT2/RIOEkFzeiS9FpMlEDr8BFUoY6DOtHJIAtIo+xTdHxtLROK0hsIUk4EUGpwm4j2AAdobiEcZtjoLJASA7SqjCg7SLuiqTW0Pr18+jT+IG8bJ95lBr+4qREWcuVb7omVV5ldGezsux7ywvYxMxDiN2v93WY4VoX+AK3dSJ0G3hRxVkGOQxEn1ZL+tdkjgolEbHWUReqAuxSYWkI0nRu/epvJO4+JnmgQzbWXIDlgK8SSoy9OT8P6GTuZBSsjOyE1mbZtfzeWtMdcYukT3M0CmY4yLPqlvN3m/+gXKUnuEPgKeZDqHG1Eq9WqK8pNhv8bMAxPVm49bdSJlCM38NQM/y+HyojRBmTyPHNVEuWdONK8HvngfyRtTFunRxhrF9EWWGijXmweNho9URdNnjW65f9zuHCsb4M2qF8ORMNdgjZXaDKSXZuPOPox66611eBxbOwj7OMUORzv0flBE+0fAndmqHSgWB8GXgeaBKms3VQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(6049299003)(56012099006)(5023799004)(6133799003)(18002099003)(22082099003)(4143699003)(38070700021)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YW5pdEQyYnUrWWYzYnhpK1R6aENrdk45VE5KZXlUdm1DM2kzYWpwWWNSQ244?=
 =?utf-8?B?dGE0TFRsb2lWTFNrbVRCdmlVZmVzTkhUbHJHcmRLS2VDYU5Rd25SakZvWUwv?=
 =?utf-8?B?dXMrUkt5ZW1ZT0xwS1dEem8rWmU5ZlV5MjFGZFJMMGFORlRjaGplY1Z5VDAz?=
 =?utf-8?B?MkVjVHBGZVZvaHRyN1JkaG5rTFl2anBReVczTytTb2h1a2pBVmR5clExOUpG?=
 =?utf-8?B?b3lSS2hTSHBRa3Y4MzFSbzRKNUZMdW9PU1ltK0VydUxqMVZzUlZUOE1FR0sv?=
 =?utf-8?B?NldVd1QwK2RWQk1DSTlhRllKbGlnU0RMRHNPUmtMYWFZQXlwUTZDVGpVM2pC?=
 =?utf-8?B?ZHd4bUFIQndLOHNvcDhEL1hvMGg1TjUxVFVITnc1ZmRmdDVUUEdDTVY3RytD?=
 =?utf-8?B?R0RVdXg4NVdvRlZ0cUVNbDVmWjNqam1zRHNOd0dxQ1QveGtHc1I1cTVFN2Q3?=
 =?utf-8?B?djBzSGY5QmlEa1ZORnJ6M0E1YzJGc3gzMjZzcVh3YnllcU1XV05qTGtDeW1j?=
 =?utf-8?B?VTVhYjQwS3FNWUUzaTgxdmVmRGF2UnJ4RHNpbmkzemhnajZQckxVWmZlemdE?=
 =?utf-8?B?YVV0WDNzb1Bmd0VCZjlGeWxyTElhcWN5SHZrWUE5Z3ZQTHpPWTlEK1I2ck1L?=
 =?utf-8?B?eDJwc0RjSXZJUFNHUmpiMVFTSUJtTWpheVYyNkgvYjIxUnNySDlzS2lRajdr?=
 =?utf-8?B?NlY3SXZTTXJGd3FLbWNDYStXdWcyOXV5WFY2ajczNlJGb25TMjhhdlltYWlv?=
 =?utf-8?B?L01OWHZLU0dGMnpkRDU5N2huWGZNeENUK25aUHNiV2NKeFpocmFEbVlFZGZH?=
 =?utf-8?B?dy9YSTRrUEZLVkFZY3dIMlZBU2JYZk94TGxXZitXMjJ6NXhsK1k0UXVyWlZr?=
 =?utf-8?B?b1UwVmhSbWZ1Qm1qWGVKUG1zWXp4NHl0SHpMQVNXcFRtVnZkSm5idTJ5cWYz?=
 =?utf-8?B?TElxeVVaOHRIQ3lFOHREQTlPMUhOb3J5RXBYY3Q4T29KZ3RQYzk4b3MwTDJW?=
 =?utf-8?B?dkhOVjAweXVWZHl5emNVOHZxTGJQTmVXRmJ0ajE2WmVKN1YyK0daZ0RsbTg4?=
 =?utf-8?B?Nk5aaUxlaG5STy9BMGVJeW9kd3E0WForNHJ2VmFtMmRlaEJnSnMyOWxzaEtY?=
 =?utf-8?B?UC8zMWIydytEb21Id3lRNUl6Z25rVGdBaE5ZM2ZldVZHeUt4NHZXK09lWVht?=
 =?utf-8?B?NkNvc1hFV3JqOEhOTFdHM2JHVDduV0FkZWJ1THVqMkRSdjF5SExXSnJJbjRa?=
 =?utf-8?B?WWlPb29zaFI3M1prRDkwaW43dXZFT05idWJaTE1HalpEeHlZakY3OG83S3Yx?=
 =?utf-8?B?dlBXbjhta01lNnlXOUoybGlmdktmdzd2VDZsVFJFcXJGRGhOTms1ZGVYUlNw?=
 =?utf-8?B?QlRxK0p1NW5Zd0p3c3NxOC96YmNGM241aDhwazdrY25KZXBzZXlsQWhweFFW?=
 =?utf-8?B?NXliSVdRR1VEVVErTElSZ3FBS2NKQitpek5pbThNODhOM3AxRzlnaktDOVZx?=
 =?utf-8?B?NkMxRXZxSGVnUXhVNWVsR2d5cU1QWC9PYmMyV3kwMXluNzFCOVU3cHdzdWFm?=
 =?utf-8?B?RTZXQm5PN0RPRzFNSzVFamEyNituOG1hSjVlVGptVDMzL004cXc4ajJFQ1dJ?=
 =?utf-8?B?aTRkb3g0YkFVYVFXd3hiSWJlMFExWjNJdHB4RlpLWU1Fc040bWJKSDZnRGxR?=
 =?utf-8?B?SUFBSWQ1WHVwa2hPcm9MSDduamFaZW9TeVc1YWc2eHl1aGlIWE5tU0dHLzVR?=
 =?utf-8?B?RjJsVCtFc1NTSklxcjFTMEw3ZFBMSmR5K3BQQjV5RS8xK2pEWHh1NTlVYkkx?=
 =?utf-8?B?Z1NzT2hxa0VlcjFkYlRqeURrcGN0cGpTSFhhbkRjR09QdkRoUVlTWGtza0xu?=
 =?utf-8?B?cXBNR0VoWHV5bXNObVNtcFVjd2NkVVg5UVR2TjlMSWxMNm1BTmpkeHMxNkdn?=
 =?utf-8?B?djFlTUk2VnJCZjJRZFlIQWszRGpKWTBMYUN2TTRYeGFPRk1ER1dIaC92SUhO?=
 =?utf-8?B?OERQMVpHak5ja1hqejF5aVQrRm9rRGZRMkk0M0hSWnh0OGxFNGUwRHltNHRq?=
 =?utf-8?B?Z0tRbU9mekVXaDNWQSt5V2NMejVWbG4vdDBFZ21hMlR5R05qMitxNUVkcUcv?=
 =?utf-8?B?MnZFTEhWQWhWOVJDYm9nckNoM3RCTE9JN1hCYVp5WXlidk9aaEFUTkFBbk1j?=
 =?utf-8?B?akU2VUpTa3VsNHRzSkNWcmRkdWRzQ2szSmRmZklDN1FLZlg0NVVGN0FpRmJj?=
 =?utf-8?B?YUFiRk1jVUxmQlBHMXQ0bmRnRG0zUlBrWkQ2MkhFeTZPSjY4dENQRzVSZHFm?=
 =?utf-8?B?REk4TDVrVDNyTEIxM2hPbUR5MXlpOS9mREFxZ1JkbEVaMUZycENQb3lRdGdB?=
 =?utf-8?Q?5kx0NkvvrAATXiNGQbg1CHC5Y96Cbg+jOvqfvVYWIkdD6?=
x-ms-exchange-antispam-messagedata-1: a6UuD+7RcGuDhTgQZIfc0jeqEYSiq66UXUg=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-cqPQZnsYMOoNTUuSIjuN"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	LxhgVkxBHzOn5/xh9y7ZvqrRvBYYNKWVz6M+wI1z58S1LtZDqpYqYqY2X156blrVL1pEoxl/HyLT8NQoB73iRk2yG4xb820YbGCJfiFPL0YGq6aiZqHMYFdlo0nZ++m8Vr0X/KNq8COsq7WUrhEVNO6sAjOBpJ3xCkUnlsmoxD3zRq4wkz43lRv7Z/EnDQ38ns5xQxyFqtCRrx0//TesjDtb7p5ICfhHcT8LylkYcYDvvg/Br3GKYiMJLu7TcK8AX190OngKtPzxXxYWMTrWu5fMTaFW1+zN1ESFycAff+fdFYxzF54kVaMXrGjnVKrPvoBuFYd65oqh20ohUJtkxg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9X/NeP40OggGBS5FoPnBlN5cKnDppEJmac85XBFFZLDlZQ0ohY1Kj+d1AmqUYFEZUaxI2kxEQmaidl0Pzam3o1XMr9uSD904v1nPPFsWUm4uJgCIEHHIS382poXT8gVDb5TgaJlppL2eWcqCsbQsdnftysFc+OqFWBD/vAXJlOyPyUYdvf6m0OOaJcgS49aqLpZeDoBSsJt/LAyh9pBd0cIe2yTG14SvSOS1L52duVjG43g1jcTz7gG30VY5oYvZb3NSIYE1zm9vy1GUvs18Q7T/z4i5k9BF8N3AxEgTL9ipemlGcFuKnviXFb98NrDYT/Dp1+2DBodoFMIG2QYGSoLT3YB2SUBfGkZ5HEVGEfu09Krz3SwGS3Moy+wR8U9HUDi54bkgqOS52aXQeAAXmFUoUYtRk2e/vuS7gf41Ma/l3kWxU5ROzKLUtA7qq6g8kh58aNUlKgV4PrfHIwp4DRqShMjU3XehFo7Bq439K995ty2NOTS02efRFw5Hh4SWVxREWs+79kvvY2Eaj4c+E3n43x0HBvtqYI+slHGUoJ2Lvr0KslLmvg8pB+7Cut59conHz2m6Q9YnVr8i6AQmG0By0KyUR1jZlV5gnVkiPnQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b31897-33cf-40d9-af6c-08ded1d67170
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 09:53:28.9387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5XWFrau23RtaP7T7OF5BBtPyZnv5ZPTddZm9Xr4JTy9cpjFcu5TERjfHgYSOoAJyDi2AORd+Nc50ymsfB91ZFIvJvcnto+vZID5eyYYem30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2606240082
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA4MSBTYWx0ZWRfX3b4pQtAqhuAK
 r78G9lxy2mdaIrxkwQIn7hG0PxO4JFLOoxpxvkdtEUASSdEb5pq/97ZITCe5k9wK6SOCxYwn4UO
 nNrjEHJoJNzfLZMd6uRJj3x+LhIq+CCR2WiJDWC8tk4MfV3wqYzk9TRSd+wjDEIZ1HYFkII5uwd
 K34TtdvIUKak9YVyQwW/ly9nFUPnB3slDBKb1QXxOTgjqivQSNwEMJGyJAFi3pU9DGW++LtwoT+
 Ghhkz/S0xSgXKlHfj/gRH5keDCVZSvcj6MVPX0oBDBLoC+TDxAGKgkAguKH+lL2hnBb2Kk85CUU
 AjT/gltjAijB9OGbLLaiOraYMBUF4Szw+j+2cxUpMqlEqoG20V45r33WS7Gr8k2ydutbdGIhrF+
 JiJVAfoGQBSykhneTdZukqbkOFLpxcijcmcvxRUZMdhnmxmmNaV4kUMwRpHrh2Yg5YxOVRTBXvK
 SUNJdVuCrT07fJ1LnMw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA4MSBTYWx0ZWRfXy0DZREjj5OQc
 uCXhpod211HWEX17VjEwJa7A+pc0N+JDTYOnedwVc35m1Fve3T9bE4BwVKIj6C0kFVfaMOyiw/l
 BZ2+5g8I2+A0BCe2uRLLwcHvkRGW35QLyPbcmM3SRU99CtsF1BTJ
X-Proofpoint-GUID: TCB6WSk4BbQYl_sSaM0Qudc27y0PiYFK
X-Authority-Analysis: v=2.4 cv=E479Y6dl c=1 sm=1 tr=0 ts=6a3ba91e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=tOsAJwSAg3DC0y_-OWUA:9 a=QEXdDO2ut3YA:10
 a=CV5CBI9184-RZIMfmyMA:9 a=FfaGCDsud1wA:10
X-Proofpoint-ORIG-GUID: TCB6WSk4BbQYl_sSaM0Qudc27y0PiYFK

--=-cqPQZnsYMOoNTUuSIjuN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24 2026 at 13:19:26 +0530, Johannes Sixt wrote:
> > One solution to this is to move the freshness policy out of git so that
> > it is someone else's problem. We can have a realtime fetch or faster
> > updation via external helper means. But unfortunately we lose the
> > coherence in the display of information, and so the user would end up
> > reinventing git log in his quest to have same workflow.
>=20
> You are presenting one solution here. But a more obvious solution would
> have been to make Git's notes implementation capable enough to keep up
> with the volume of notes that are produced by your team.

Git storage is inherently based on refs, so that would require massive
changes IMO. The actual fundamental problem here is that only the
latest state is useful at any given point of time, and not the past
history.

> Another solution would be to track the information outside of Git notes
> entirely, similar to how pull requests, issues, reviews, and
> conversations are tracked by Git hosters in databases outside of Git.

This is precisely what this allows for. The information is tracked
outside of Git, and the notes path just shows it along with the commit.

A developer works on the code using Git. An external website doesn't
allow the same level of coherence in display of information as a note.
The commit is a fundamental unit of change. IMO it makes sense for Git
to be able to show a note about it from a provided external medium.

> > Let's add support for notes.externalCommand, a protected-configuration
> > command that git runs as a long-lived helper when displaying notes. git
> > sends commit IDs to the helper and displays any returned text through
> > the existing notes formatting path. This keeps presentation in git
> > while letting the helper decide how fresh note text is obtained.
>=20
> To my eyes, this looks like an overengineered solution that helps one
> user of a niche feature of Git.

This can also allow for other uses too. For example, searching lore I
just found out that a colleague in Oracle Linux (Vegard) was trying to
solve a related problem in 2022:

https://lore.kernel.org/git/20220802075401.2393-1-vegard.nossum@oracle.com/

I think it was for achieving something like this more generally:
https://git.kernel.org/pub/scm/linux/kernel/git/vegard/linux.git/commit/?id=
=3D339f83612f3a569b194680768b22bf113c26a29d

An external notes command can be a solution for it.

Thanks,
Siddh

--=-cqPQZnsYMOoNTUuSIjuN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmo7qRIACgkQBwq/MEwk
8ioZXw/+M8rzgN+Ypv21LfPK8Jbxn4zVRb/wCxfDgsnVAIi0S5tiUsrpnI81rdph
94oH15f530X4HLzF9H6MIkclgmd3t5YTUTMTaoJzwZPhL9TvVEV8Tx71Uq1FdhPI
KDBQikSF15faxJy5I1t0mwAIaHDqjtPPBo2AJZTMuFf5rpYQHRQpG/vBgT+wS6dV
a/AfhtGtQVbNhx/XZLknmM2/edwKGvt6Sn1/otpbS2x2dBWnyY8CEHVCcr1usIiW
CcrZrphfUJiwKZwz60HqIemg/N2lW++piYLvNBdBSCP/rPBWQGwSAiMj7kH5SDlu
vZgWLj0GRz7ezx5PXm8TkTQQ6Cww+36f5yuM4GTMf5lsbcoH3GOphfO6TlCiqcqQ
teYG7uvG1eymbDk0X0dbfZ4b4RmwLUCyb9/bF/tfUH+Qb+jo9V0dyKOt7irpg4W4
LkuBUurS8ciphC9HbeoeNKOr7z2tPhvb0ztNFMYdzqgifmwkOicg5mcLmUFj4WRb
sphfMI37d7dV02Rt/8dM+7auyUNsNtAJhj2OvlwVwRC8xLjfjVsyjakFd1qZ/ags
M7K5LXwFzu/NL5ZFNXKsIdUUkmHieZDF6Tpfyui38S36RXL7YRD5jgt9Somrw9v3
ueXy6oT4ZVomNlSDtI2U/rZdN2mxuYcgm82RYYpBcNBgjCY+ouU=
=FLWV
-----END PGP SIGNATURE-----

--=-cqPQZnsYMOoNTUuSIjuN--
