Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F982AE7A
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 04:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782103552; cv=fail; b=JcyybAS8w6bwFJn2+NyRFXEgP4ksYXVCMI7ieqvDQ8Pq1NRB1Ca78hPVc5GYbTkKx1ZqdGQHuX9PaNcsK7WCamVQ/T/fBZSEYvcHlltcTuLRBwMXeXbKcSSqfkUbvNDZHnaptQlJO/DxYsoBMxmCE8LJR6WqLyFAjFClJ/zC9Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782103552; c=relaxed/simple;
	bh=AuGMhYfgG1+S9XcK+lI2A50RNC+yAM+rDv1L4IqwtDA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hYEhuJkKpg1Z4t3hmR4CWcdAp7WyLLLR0nzRaFV8q3O0h1u86iETmraASJPzeWK00wpp3aktwBMRiEW/X8hQy8L/cA5z58AUSu9eUF1H9CavotsxfBeGusgQ45LAc3RC68jlstgWn6j0q6FkAoDzkrY0lh9myu489l6uISpD/YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YM3xrsEN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fUrfc0Dt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YM3xrsEN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fUrfc0Dt"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M4U1NQ937482;
	Mon, 22 Jun 2026 04:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=AuGMhYfgG1+S9XcK+l
	I2A50RNC+yAM+rDv1L4IqwtDA=; b=YM3xrsENXaYTcgzH83W5GKw+y7x3+//KgJ
	pmrJYMoykCNsNnELeeT3jW4Lgl6PJsJN7KaDNjD9f1KmY9NhQVHEQHI64T28oVDL
	h1dkY8YbZtXzXwacTFHj0x5npBuGbF0Kn8plLduojzRh9KlEvB7gsz7pTOGSCo2t
	2xURyfTRzrbt+wz1EoED72mL+Z0CyXxkZg2JmtL2ZCPij4WVvpMKe3TVSVJI1i9p
	WHMkc4TgyuilW7S/+XKfHrM7nX0QwsD6zpr0DxSyhF1F+JaUcGftsA2utEIY527r
	LwkL9A/iKhAxj1FYjirF/OCqbg34y9vI6eyh9DA8a/bNSJXa2LEA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewhs91bnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 04:45:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65M4c7Oi039883;
	Mon, 22 Jun 2026 04:45:31 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ewhaa8srb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 04:45:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmK9KmxU7EtDYpUuNYRcocnd7Hz9L1/isl3/XOzpAQ0d8Y7JgVdKtAm7Xx8cUAPbl6IZ25rhTSYtafYQxC7druMcbfDstBnpSlx1C61tSgdFZe6L5mywgop1uBVuFliN5zO7ifNjUpqyG93RGbldx7WgWHSj9oWnn/wAQl6wdg4qYGCI+z1AjxLBcwJ+pQEAMTQ2XYz6pzEwld7MGqrT5lrMXdj7jcQTcJcjeA09sDiZhShlTws8j0GYkvZFShDxOKn5+IPUnEtuxYQtw9K7nmAN8Vj3Du0EM7PLW4i7ZbQeTkGpZK9eJNzcT/DI8H8dI7znqe5WPDOEnJ9HQkPGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuGMhYfgG1+S9XcK+lI2A50RNC+yAM+rDv1L4IqwtDA=;
 b=oETmFNsp6GFDTa1jevkTrHQvHFB7mRFzbVnRGpMBG3HXHyRj1hpba2gQPWQf56YmuM5DaUKcTeN3OsNSMclQ7TgHlrRuJRNfQn6YRK5fWDP59OO5w3Hzs6A5kONnsyPDG1BKj+i+sD23XznhfVja3RF15kY0rAVBUx8BRM/SFQBHVZqStNMPoDViBHulJfJ9T7Z5yAwlLonIBYjKIEwNtlkn1x0yNNa/0B1nR6UAdnVyeUmZMHXvaxBdXcdtQacHuCaqfnbaLOndwFKrpKGbJ7YGCNf3h/c1OALgFdL1XWXeuJDSkDXT/1uXAOFdyZlAfLXhKm7VStA3bG2Pa855yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuGMhYfgG1+S9XcK+lI2A50RNC+yAM+rDv1L4IqwtDA=;
 b=fUrfc0DtaJqSlsI52wrHeYlI2i76hVGgJA4xTpw9VhAU4EpmdVg2wvcdcm7MmZ1ZISbXTXQY1m14rDOcoJfzgwMd0ZQvtAeXh8/+SU0TorNop3acqgx1sXB23xKT2lKPdYt7zfqGhmN8h/kzR7WUvQtBHsiaUSRg4BCra+e7e8U=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 LV8PR10MB7872.namprd10.prod.outlook.com (2603:10b6:408:1e7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.16; Mon, 22 Jun 2026 04:45:27 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 04:45:27 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: "oswald.buddenhagen@gmx.de" <oswald.buddenhagen@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "code@khaugsbakk.name"
	<code@khaugsbakk.name>,
        "j6t@kdbg.org" <j6t@kdbg.org>, "peff@peff.net"
	<peff@peff.net>,
        "ps@pks.im" <ps@pks.im>,
        "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>,
        "newren@gmail.com" <newren@gmail.com>
Subject: Re: [PATCH v3 0/4] Add support for an external command for fetching
 notes
Thread-Topic: [PATCH v3 0/4] Add support for an external command for fetching
 notes
Thread-Index: AQHc6qBfXizhJ6cAakOZoOY3SLPW5bZBKS8AgAkFawA=
Date: Mon, 22 Jun 2026 04:45:26 +0000
Message-ID: <770c0163b9958e703faf6d9e4f2d47df6c93c37f.camel@oracle.com>
References: <cover.1779532562.git.siddh.raman.pant@oracle.com>
	 <d266c22f90d7140d14fe5dd84d91601d8fad7d73.camel@oracle.com>
In-Reply-To: <d266c22f90d7140d14fe5dd84d91601d8fad7d73.camel@oracle.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|LV8PR10MB7872:EE_
x-ms-office365-filtering-correlation-id: da2ad61f-17bf-47d4-2d9e-08ded0191485
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|6049299003|23010399003|366016|1800799024|10070799003|4143699003|56012099006|22082099003|18002099003|4053099003|38070700021;
x-microsoft-antispam-message-info:
 I7CajeM/WrrpSSnYjv3qeClAz+TKjZtFmTMBSsR06LR2livKVyNlKpWVK3B3Vbk5mhr3zcprFD26WUpeAWsImBJUpyKtBH11UeKqxrXwe0zCrjTVlC3zqqHQnjgR5rHmBVc1Rv2vJ/PxMTh8Myw3schzdnJgJhNgCq7BBGnUEdyBm8iRv5UlyQhvq95oz3/ZTbi7aIV9FvFcqYsve6jiOiBqXWd0eGgXgZTViipMErRHtLbacWoZ8WY+8RYu2TenSVsxlDdwZuqDzRmyYww5vFbm0ZCDeu7K71sJt5MNKOvpoNzr3NnKuizub2tLxfPdWqWLuuJbDKamE0sGkcWPHxulwRjbTYyu4isQ166kTaY59tqyMsVD6yyr4v2R/cXAnP3b1j8Ql44jnjl3P0B/qmT9mvbKDGBpavPjDfnZhHuFXNu1HiuB56hX0CpONxqE1MYG5Z0gAaSPXQv5/6GxaBuZMenjXb3gAfYNGHq1tO8JyLHiB5l+xzlosr7lqWzwXs9kJZ74+Zfn9N8c5Qs6td509ZaQUaI6pnx7YaaGUEtS2iCUSpNbUHhdUHpTHb5+PJ9WgQGiLplW3063DS2YbgDmJw2oR9Leg9F7TBY2T1IqgnD/3sWZ9dzZAaDXJFZzjAtuLBPvSwGoUS/GnZtvobv2cGEegxkPQfoVaEWq8tTI3xg7ToaAloQGM1JMLkwlO2F4o/NE9JC/UCYIC/nqh5GY283vl54N+wl1V3LBGHU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(6049299003)(23010399003)(366016)(1800799024)(10070799003)(4143699003)(56012099006)(22082099003)(18002099003)(4053099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0JWTG5adXQrNHBvUzMwWGtqS0MrcXVMQ0ZyQTR4ajRoZzhFRHgvaXEvNjNv?=
 =?utf-8?B?SUJwOXB0WDhxOEVtVGdueEtsSUZRd1hEOCszTFd6M3phZTlZVUVSSVJjWGFn?=
 =?utf-8?B?RlN5dlc0YzAyVm9ub1JZMFNPWHJmeXF0K3dHRFBHeXFhaXphbnprclhLQkZE?=
 =?utf-8?B?am9Ybnl1a2g1bU1yaTZ3RmJ4V1AyVk5jVjJHWGVuYVZHQjVYQkgraTN5L1hE?=
 =?utf-8?B?aVFKSVM2TytSaFQ5dElqWklyZitSS1ZwYXJBNWdxTDNPZXdMV3BxeGdrcUhn?=
 =?utf-8?B?TlZBbHppZUQyejFqcWlnM2FHSTByUkNhSW4rL0poU2lkOEdTemZDd29mbUor?=
 =?utf-8?B?THpLR3hjbWxqQmkzWTBXQXZ5V3BJOFhTeVpyUVJRUlJmWWc0VWVNQmt5VExr?=
 =?utf-8?B?ZXRQaWlveExWdDRnMUIyS3RES3NOdEttc3kxUW12R0RkcTNzdUg1UGFTRExp?=
 =?utf-8?B?RGcyQUZFUDNSUWYyOFM5Q0JORVdnNDdUbXlIR0l0blFwSUN2QktSUys3Tyt0?=
 =?utf-8?B?ckRzTTN1aUxrODZ6QWJPbGlsQVkyK1J1US9mMTF3TmRPWm9DZ1J6djdxRGJZ?=
 =?utf-8?B?ejEybGdQRlNLSzZVVHVMZEhxcHgxUEY3eEdZMHY4S2FwaXd0Z3BUZkhNeGty?=
 =?utf-8?B?K3lWNlM3UDB0ZXJHQmtPV0NSNHNXR2M5T0UyekhNVVQ1a3dxKys0TDhCaDlO?=
 =?utf-8?B?OEhoenlXa2dYdDA1VG5IZi9aSm1lTkF0VlVYSjJTc3ArdFFiZGh1VHZTekd1?=
 =?utf-8?B?enFMRzErbXFxOVZjdU9JekJOWDFKaFdhdUhzekxqa2NicTQzZWhRb1BCbysy?=
 =?utf-8?B?S1pTK2hZZjNIUldPZ2xCaTBTTFV2N0luZUxLYlhrWWlVQ1pUdUZhaFhZL3BQ?=
 =?utf-8?B?eUVESHU2cWZDYWhTeG1OUnhFeUxyb1I0czVEZEJHWjVTWmxEdy9HMUpFSXJI?=
 =?utf-8?B?Y0YrbzlwZzB2NmNLSzRRZEVYa0tQN1pVbVNIUC9yYXNMeGpWdlkxSitRa1FJ?=
 =?utf-8?B?d0tkY2pQVVFGdHR6eHV6TnM0eWx2VkRZOTZJTzBuTzF6Y0Q4Q0ZpVmlrcnVF?=
 =?utf-8?B?dDZUamMvR24rRmU5aE5Od09TYVVCL1B6ZTZoL3VSN3lHVldFV3JTL21hR2hq?=
 =?utf-8?B?ZFIyNi9QR01CVjZPWVU0eWdFZ3NyRERxb0RVYUp4enZNWEt4VXBrWW0zM1RW?=
 =?utf-8?B?YW9scm1wY3ZoYlhLc3FENk5acW5tNFhaQkhpbi9rdGdCa1c3M2NuNG1SUHls?=
 =?utf-8?B?R3FDNWZWQWl2dG5VL0VjMDc4WCtTR08rV015Y0l6dFMzc2JqcVNYdEtnYWpW?=
 =?utf-8?B?UHJpRDZXZEozMVZvbzk5ODg5QVd0eWMraFhUZnFKbDJBMFl4NjVYcndQcUM2?=
 =?utf-8?B?NXBFLzNDODc3T0VmblJKN3FhVnc3Z3ZvNmRKVjU4cWp1RUdrWXFDcW9QRmdU?=
 =?utf-8?B?SFFsRGJOWllUdDZwTWFTZGNWWWFPUW10TVhvLzYxa3gvdy9pL1pRZWVYaG8w?=
 =?utf-8?B?UThObVZ5YWRKSWRZNWdYckRZZnJVUVh1bVpuRTF1b2hMZjJ5TGdVUG0zSDhW?=
 =?utf-8?B?U3JpRjYyWWF2ZGFOdi9JNE56VWxiWWttQnNPeEpFWlU0VCtMeTRGWlVkeEVh?=
 =?utf-8?B?QVA3bHJEZldwT3dLQTgwT0VQczQ2cXY1dHViM3RSaTNMaFpiM3B1cjY2QnRX?=
 =?utf-8?B?bWs2MWc2WFFWMkhwMGhxM1MwSmhKMy84cjYvSG9td3FRNHJYd0FKUE94RWtZ?=
 =?utf-8?B?cEF3aUwvdFdPSHpFazNrNlNHc3U2ZDZpdlNMRmtsaTdSY1NSYnA0VGRiSWZY?=
 =?utf-8?B?ZmRITHYvTFRYV3lyU1ZydzF2clJoZCtMVG1XaVpZakJ1VXcyUlJ4UUNFRXFw?=
 =?utf-8?B?djk0K3RXY1I5YWFFY0NQWWl5YXF4M0tQa3JzZGw5VTk3dmtKcTJ4VzhlTUsx?=
 =?utf-8?B?WlBjb0FBRWp6ZXRwZDViQjk2Q2prZ1FQSmRPcTRKQzZXNHZOcU1oN2g5bVA0?=
 =?utf-8?B?WUw5RFlPaXNPa05OR0EwTDRUamZjN0NtNElwVml0QjZRYVpHdjRzaEEzcUI0?=
 =?utf-8?B?ZTBKbVRKWFBXb3FwKzZhenBSeFgxeGFFS2FpbWdFZW1mOWVVNjJmRWQyb0xp?=
 =?utf-8?B?Zk9ZU2ZEdkdLZzBHMG1QYlFMV0I5SkQvYnE1UnJEYVZPR3dCY2lLWFBTODJt?=
 =?utf-8?B?bmFqSk4ydVJESmF2QktTSWk1ckYyVlNvMFJHZGMrZ1BCcldDYi80aWxUMjZU?=
 =?utf-8?B?S1FGdWgveURXRlU5bktwWXdIamlOTmllK0JndTdReXFuamtLbVRXaGQ5MXFm?=
 =?utf-8?B?SHpiOUN4MTZSYUsyZyszMjV2Qlh4UFpUU0p1WEdTQnl1bTltZThpZXNJaHc1?=
 =?utf-8?Q?Rym4G5c1Nc6fUxP7E47EjJ7AUJDua5j12FNAcvd/N/bUS?=
x-ms-exchange-antispam-messagedata-1: m7WX8ymBQYkmeK4HRXHd2cSgDEiI6FY6fUI=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-G8A5TitkJjQpLUBhs5o7"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	cjtAWAW23dMHcitWsyg8Y+wcBZ5usc26CNY6JDWvulLt8g5XCMVe3b3VOLbGYN5YloGjdlhX9pSASRCAS6M0sByI1wIY8sv11HXM6M0KX8UzwoXXG/5+Cl6NO79kCSzyLfoqPQeyleQfSUqr5EjVIVCgG5oaMqx+X8VVjNBjTA4SrhgQgAHpfKHkpNqDZ6/M9SLMl+2cU8mGd6kjE9F/ssPy8dDVt0+TPaR/18VlJecoEf3LZnU6axwu1priIDvxZViWihUUr3fnAHTt0LP7wIhHbMJQHU+K+eXv664t9kC7GTAWobSlPPnMa2YmjiBBjZn/wQ8lH1RrmCBdVt8e7Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jB+uAaT/XtGKBbYXj90wQsws47zgQhrR1gAgy6xeldAtTy0NHH1paMPCkkbTSPR0qlctI3nEC48Dwuv/4ngZeqdDJuNwMt4UZPgeBLH0smfQl0FAT6fSDl2MBXxNdwI7Dv2WQEJF6bJ/e6vtiFpXv0ZHHPzpTmS5PX12aOIxPX7XUcoyDGLeSy7slp90RiVLVj6hLMGHyW1TcoRyd0YbiJeUv0qD4fFAuGy4REui/Ks7f56THRC/KkmILwkB/R33GB6OIrO/NB2mNFi7wkuTgpeOy7TLEllFJuqAZsc3fR/6Js21ZAmFIGqEgqUYsu28ufNl+rj/SuXoWfk9msVRGfOl1/EKRc7xzUJ+xnbsnGTnw+JQTlzU9up/ifOKNhqy/A/TrxSUjmXDLY3t4wp0ZMCX5W8vn/FtxNlzgSQzWjs3Fypem8cWegX14y1SDS92DvqYFmS7GOyX2eaoqX9NqQzmA0PPVQp8pRhkIUGpbzQ5OJVKd+NlC1Jcy5aIu4KUI3gzCFBZjTBdvGptdjR+2D4Nnp8QAy9VK2TDhJUDdgWg254I3ae2nWX3c5xoDX7Jk3cuAI0fLqsJg+YpoX1T3W4A2ssx1EJFtTkeLHjm+DY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2ad61f-17bf-47d4-2d9e-08ded0191485
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 04:45:26.9905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2o2E5A/n4q4vekZ70us+bOgxKcXShJdBGRwE0CW0b2yzdZXgrlJVn0oMAz8DS23S/kXmMXitV2IwKSi0WNTfLbqcn1M2HDQP6c7h2fjhnbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7872
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-21_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2606220042
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA0MyBTYWx0ZWRfXygpTI2cxhqoG
 68TEz6iO/1hb2cO+i9TWFvDLGEHfTB5nDnYy2xHN2G91M/w0bv0ms2KwXNrUeBxs2Jt5qTQqCbg
 GnaOkzbROM7L1/tL/1OHTdoHu/zmL4zdpE89NfQ1kNrTzqwX+UU70ZjhrpPOvhijI6ecszKYQ9I
 8IOhjXa6NcLae+BZ9erNl+aC/9BMgZON36TdHM2J8amkuIXH7ahPr2QuznveqQKrOyOfJ/HOpXa
 rEHPWExpJwYqjybpoMqmaEIg5TaP66VCBx/Qz8OD+pmfoUe5aajtbsfhBga09u6+f+aZwJflFRT
 bc2YatOy5bjFEiAN5JTF93RBlBFljJjkfzbKYs8a2yz9J8OwMrExm7jNaK8yEhFZojlAxC0Mr0/
 +TB6rUEmaeHIS66H+ejdWH6SRKxsaUKBcFXX595FZLeHtb7QsQOOHeR/8uIJMIJlOw4Z9vencGL
 PD7sF3OPua04yQQbTmw==
X-Proofpoint-ORIG-GUID: bcLtarL590tRy5-0ZhLditOsMgII8bsw
X-Authority-Analysis: v=2.4 cv=Wokb99fv c=1 sm=1 tr=0 ts=6a38bded b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=mPojP5I2er5pLrY4V_cA:9 a=QEXdDO2ut3YA:10
 a=H8o58S67mFkA:10 a=3AstpMzsqJ8A:10 a=a0ZJG9PpACwt1PQ4UfoA:9
 a=FfaGCDsud1wA:10 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: bcLtarL590tRy5-0ZhLditOsMgII8bsw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA0MyBTYWx0ZWRfXwWmqFTz4pVUq
 a0ff+YYG9PtNmeLQi4uEPw0VvYfqc/k/9qdQF1bdVCNmfEoLEjCWyyaFW44+CYgR9lu8JJFXuHm
 Y8sEzezXs8WjUZSOl+8TvyWvlwrZF8ys+/rbxRba9NidAJ9SfkNI

--=-G8A5TitkJjQpLUBhs5o7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Pinging again...

Thanks,
Siddh

On Tue, Jun 16 2026 at 16:29:36 +0530, Siddh Raman Pant wrote:
> Ping...
>=20
> Thread link:
> https://lore.kernel.org/git/cover.1779532562.git.siddh.raman.pant@oracle.=
com/
>=20
> Thanks,
> Siddh

--=-G8A5TitkJjQpLUBhs5o7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmo4vd8ACgkQBwq/MEwk
8iqZqhAAj8mT2fMQFdDdSP92ZZD1s3JaOd77itTaa0xq1DOGdAJEuXGLSB21yeOo
EW5TT2VvAZoV4tYmJxH1j88EVpcqJxDiemVXz9VagW16JlfD7EWOJ7/R6xR+zLMU
WAiEVh5JJmEAmJdC3NRtNE+Cvpg65Kh8BbxSfExryK/np99O3YbfnZDBkEWXUX6n
I+K5Zc1bOJRvsChukQKJGG7sMzHIMjUGpYvOv6CDLeBt/LbzMQlPNdP1diXYwiM2
txHBqFjGsVcPhF21PbNqbQtWfRc4rfyrngK+OuaBwezk2DDB1Z4rTRDjqhC9Y9Ei
03GAjKMpJHcB7Uo7OO6Q3Un9xs1RdDNE9TRYzLMfgIY09pTMBAx343xJixiodzlX
YlBBIRPaxlmgAj7SMUTNxZ4iirFNXO+baV7aLnhwgDlxOaRzCnHfaA+xY2HMU4xj
/vwnmUWtKvvU0eTXsnghkLM6QCCC51DHzdwE5abV89ptbVsQjHa0TZaHTCLn3gbd
x1TGE63LVeMy4UAWYEyo+s6AASQSidjHDFQRt1faRjm/BiLNtZu5zYjyZ+WCjJHY
p/TfbIyc5Skq/Gsx9P4B0RNorNjXcbFXnanStFpLqmMFNjntiBmjVBwXXKAd4SXZ
DfwUtcAJDAa2PDqYQ9Bqm9ya64WZLVFSEgM0yJd0qvr4AAe5Nac=
=hKIN
-----END PGP SIGNATURE-----

--=-G8A5TitkJjQpLUBhs5o7--
