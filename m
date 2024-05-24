Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CB0136E1A
	for <git@vger.kernel.org>; Fri, 24 May 2024 23:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716592959; cv=fail; b=nlpSaZlqyh62qkpUn+8yLNzEo/k3+UBDNvU4bCRfl0WDzMPEeqgKWmTlcePVFeJsEv4GIkqlH9NJdfajQlQZB40cygU/3Nbt/uux+jbPAzhwp42ailWKAYUiWjJEHCbMdCQ/FCHRJH6pWrNQj4yKzTCgLTrEyQSnHjiWB88X19E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716592959; c=relaxed/simple;
	bh=07LaaMMK57j/U57X+rL4X7gg/do6TjDhXCHqQpSgaU8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uc1+SuNd64M4+JvMw17iRCUWwpUNPtS+fZqREFGqOum8ru3gZzNtlQXwhplKzylVHK7kdopwvt5bguqjZt1GdLrScNY9B+Wa3BewfoykfH37Wax3204J562zeQx3n5TidfNTwcdE/H7fIEoadmdZQwwh+zGWnDjOBRXoGqS6lNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nice.com; spf=pass smtp.mailfrom=nice.com; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nice.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nice.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmSMGqyaFgHXUKPSg24p73xmag/MS7u/Vg2yJXE/lJF2Iuq09SocXCI5Fm786ZYQ8aijo8J+vkhDYdHlKpPM9d/qFJqwJgLk5seyUewpnnpGpe2yD3maYHBKb5IxZZoYzSLLgzuITPx/H/TtsqdpL+EJJmPx8ecqzkWCVp5YxVhogw4CuRL9FTG5YzpzrQdbFbG5wWUx8YqttzM2uwLNR2opYq09osIQbWLpwQNCV2AruUd695olXMIV36vIxCfIidmypS70tPRiR4gf83Ffsj39Ou6f0CLybqyh3pyUaKKecKXfvGs6ow1sCmW8ENGWQ/5iUfjL9t1H8i9/mWPEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07LaaMMK57j/U57X+rL4X7gg/do6TjDhXCHqQpSgaU8=;
 b=m4q7qM4KpzsrnzIcZ/ethX5b9jmk7h5xtMGm67/nZB6Xh/NNt6zHFLWrit+1RbPumTwr9ZShV0doa2LkR2OQ3lj6GBW00ZGqULn+CytpJzpe3o1SApB36IfSPbjaGNWXYbyijNgSVEWCOe7Ze9aPmfnEJwJAuqSEoIH87QloVJln0PwBBela5hSTMLw8pwZ5RmFilB7cFkL91kNBlyA3+fQKEaaY48SyMwJyMjB9bpP83Nptd2CK1TSdrTlZK+L+giIAuuj2cH4xzkwOdLXMB39OCXXKIT9yVuvnZR63wuQdMNwLuIsMVPxBrbVgnCo6TPPCdfzrtNpgboinh9IhUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nice.com; dmarc=pass action=none header.from=nice.com;
 dkim=pass header.d=nice.com; arc=none
Received: from CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 24 May
 2024 23:22:35 +0000
Received: from CH3PR12MB9121.namprd12.prod.outlook.com
 ([fe80::c66c:3a4e:a090:a427]) by CH3PR12MB9121.namprd12.prod.outlook.com
 ([fe80::c66c:3a4e:a090:a427%6]) with mapi id 15.20.7587.035; Fri, 24 May 2024
 23:22:35 +0000
From: Kattia Soliz <Kattia.Soliz@nice.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: To get the exe, msi and dmg be properly clone to the Jenkins
 workspace
Thread-Topic: To get the exe, msi and dmg be properly clone to the Jenkins
 workspace
Thread-Index: AdquMQdi9drD/GmHQYyklMHL1tlxzwAAC3RQ
Date: Fri, 24 May 2024 23:22:35 +0000
Message-ID:
 <CH3PR12MB9121B91B7D9ECFEF0C6C798AFBF52@CH3PR12MB9121.namprd12.prod.outlook.com>
References:
 <CH3PR12MB9121BAD73E23844BAD614B70FBF52@CH3PR12MB9121.namprd12.prod.outlook.com>
In-Reply-To:
 <CH3PR12MB9121BAD73E23844BAD614B70FBF52@CH3PR12MB9121.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nice.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB9121:EE_|IA0PR12MB8086:EE_
x-ms-office365-filtering-correlation-id: c9d16c3b-3254-4534-7a03-08dc7c486510
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BFK+KQQ2xm8ln+iE1ZB+RM/WKsHmDBlfLmA00GrnuIgXwfAMneQlSThn9pjh?=
 =?us-ascii?Q?WVowg3I5yzw+VQXLMunNVRWixLQ7oHdtKGP3HStGxoTxdokmJNSO2gKI1ySI?=
 =?us-ascii?Q?MiGAGQk8X0mFefFekpLR3TwWEaDET2hpzjdB6dvHe1Z4nLkSoQq/HSAJKRz/?=
 =?us-ascii?Q?/+lCqUUgY4S0I7e5fOw/UClHDnT7ohlJEwbyl3mA4rh7LvBRFWVI7j+aTdtR?=
 =?us-ascii?Q?31OOsQiCO7/oXfwXlQjrbKz/fe/XkCm6XcC2vXQQqzzdPqAhoe27jEPc4Fkx?=
 =?us-ascii?Q?Jjv4t7F+xQBf39G4Iqr4cYyk9G9WCEegpJUJmazWReiXMgVzvQxtM7L9UsSE?=
 =?us-ascii?Q?aZPTbCtWfAGHPOz/AvDz+RRQktxSa04rFmuK3xw9jsK0xJwQee3yPpqPDU0o?=
 =?us-ascii?Q?HL7zUXVDKHD+xiaTyRo+hdzCI52fg2ouU6F40m2izuwK8DUoVjkQ+kmFkFop?=
 =?us-ascii?Q?2jGZagcH5rbZhv5o3U2Qy55UKJvgeipTiyS6KgP4+NYGvbCmDV89uzdoSxz7?=
 =?us-ascii?Q?G9EitKHGnfNuyctGZuo2lTmprPkv6DAHZsHx8DRuZI5RZkNDuzy6IKV8tPMN?=
 =?us-ascii?Q?CWv9m4804BXWLwo2r9BJ3SAVpvn45E7OhaFIDSu/E1cAklpW9+HOzWOTxxLt?=
 =?us-ascii?Q?OcPwxdv0YssYr2tEYwgdl457HVCCTZzXomlGIMsmtPyZ9BfVLq479wR92jA1?=
 =?us-ascii?Q?nrvabyCHI+iKh7ZL1G5fn1uvM++BLy+vcITob1rKFyFUbYPdl6JI0f2gmNHd?=
 =?us-ascii?Q?R83lt4TU4Fd6KCLd+bme+aauF/aI8hsc3ZN1VUtrKEt9N0zhwCFvEyobpRre?=
 =?us-ascii?Q?nHUjveg9vE8Jf2TnslbMZvI3IPPlHHZ1QBOQdEuK+bKMnAfAPNHUTts0yQEz?=
 =?us-ascii?Q?hzegifywzL/ITHGZ2OY5lfA3I0Co1iLkAYr/ObnX89vrlKsGQ5J09eyLNLBG?=
 =?us-ascii?Q?7W6hWR+92qSGNyNp9X2B5iYysyWJDxVs6sjRfNSO/5NuAxt/OYiH1TSWcOHF?=
 =?us-ascii?Q?dbMl7aqHSW8W1chYDx/rYzckyYAaMpkC+5wRVHuDvSqHxNo08rBaRo3l/+mC?=
 =?us-ascii?Q?ObA8O++LUINOD4Mn08hjifSOueOJwtmlkPloUlnPLTcfEEu0gImN0Gu0bGek?=
 =?us-ascii?Q?W513mFwf+yJo506s4XvrlvxOXudUoiL+G87aE+DHFpnfNphABS+AXi5wtxk3?=
 =?us-ascii?Q?IBrGiLyrS885RvBTjkTaInyiklQcXx4UAG7CE+A18k1jGVosFGUjuOW4hOho?=
 =?us-ascii?Q?s5IlJN61624Nnfje9HmilJD2x9W35vbbD9Vy8vTEcN3CqVnH0CLa1pe1APso?=
 =?us-ascii?Q?HBHJOzgb/M+4OGDCboNgWvwyOmCstapVDXuBgQ0msWD8lw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9121.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WM5Er2nS4YIJO4AclQ6h7QkptvrqBv7rGqaJKAMQ1BB6hVQvNxVa9UMg2fP+?=
 =?us-ascii?Q?/YkZ3XIZKG/BVd9A+rF8vajRpOidF1fMZjEL1lnWpXwheyuqDDuE4shawo83?=
 =?us-ascii?Q?zmi5BCi5An6EPUqu4ktaN8mjwPaMw3CVIyZvnT4D+QoHpCwq23Nq1YJUVOSm?=
 =?us-ascii?Q?frmbaRqX8fVuO1OstUs4AOcck4Ev8mWbfrJFMQHOtJRjSTCnMgD8iZuCnfXG?=
 =?us-ascii?Q?eMEP/dy1qagzkHLEawKMD3thru0EtcgnRvA64DGAwBnmXCNN9pREZ9iA4JOi?=
 =?us-ascii?Q?TMV8H5dHqEifLDqmwD7W7bv+5iBsguJ3c9IRQkZexsXp6UIhNh0PpOtdlAoQ?=
 =?us-ascii?Q?0v53OQJplfWMk6j/cZlqN1yctZf5Xl81q+FK+RAZ5lzteFiZGpLwiEJQvYGh?=
 =?us-ascii?Q?2L/hRl2HAQ82HACGn8Rq/7QTh6SYCmIkb0c4+xjsqIX26qQh8ndgX7kSJoXs?=
 =?us-ascii?Q?6zsVrNbl3uirL1H68RhlRr/QNbX9FopHFwW81k5XsKMD3RG2fppsKkXRcfIc?=
 =?us-ascii?Q?VDH3wv5KhfxrqfWTpp0ey6n9eQ+yrRWLdI39GJZDYH3vdq2HlTsdDZXayZPH?=
 =?us-ascii?Q?eSSLy9PBpiPV1LS55XBEK7peMHf/FF4eeXFp1czdC06AJytTEqKav7/rD6IE?=
 =?us-ascii?Q?Ly+6u1XplEhtnrUhevymaOjBu5cTb6uCRWHwIaBINrL39kV/eiQ7eeGeHrqT?=
 =?us-ascii?Q?WaZPDzYWddCnS7Ne3uij+GWUe83EQ/sKgn58ftxHn8CsPvhEgNbkX8SzFKwH?=
 =?us-ascii?Q?HAZ/eaMit55xTL2ldlpssJhBnITyPOMGdgEZRnK0BDFz7w9EFwTuSxp++FiC?=
 =?us-ascii?Q?3ToHj1/uN4fSJWPOm6n7ejnigVdczZjR6DUCDDokyH3GDGLeWMangqJOp0dS?=
 =?us-ascii?Q?2bRR5TqcQvbSzKqeulU3bS9sQtFcZZTZe75Mj5NHH/EoEaF22QRRSxh8Vobb?=
 =?us-ascii?Q?EWGCNRWWSuAKJwbWfl1uoALaNa9iIEFPc6dnZApmeLllRdicUUvzsIlhuDRz?=
 =?us-ascii?Q?BBP3s9ZoWUbSTEbZriD5UpENALtHC42dV1awUqyu5pkX9+2SVhXaI7+RMRp0?=
 =?us-ascii?Q?dLntGHGJPD16oKHbJ5GWJhJtegwTsjAgXSjJZp7peHtT5DJLX7I+6SxaFeio?=
 =?us-ascii?Q?sQWjSXWUHF+kxUrbsILfiOUgJPSLbIDl9BoCrCCUrjQseD6KO2dL7XP4X2ks?=
 =?us-ascii?Q?JO8qzY6vQUnxmQpT3Z9JczKoJwF43jt/gWyDS9DvMm/1/LxXrt6txN7eLJWb?=
 =?us-ascii?Q?A8lWncsLxEP+Lx7H3DEQo7ukGb6Ehpw1d3vpZ7Pser+3wIvHHtiHGSmsP4rR?=
 =?us-ascii?Q?MkHJLk7Ly5f/oZAjc8diYWuehHzfxrarcpe/Fogob3ppjFNwXBrFxDGx2RWj?=
 =?us-ascii?Q?C2kThWR2qjrXqqIL0SzV101j8Cq9sD3KFZ7hxXsiuqJdSQZWlfC2iUi+BiHP?=
 =?us-ascii?Q?HY2l9YHlTi0I8kyI4+omAu6a3SNDGuqBB8cfxrrB0WAt/8rGlB6boXvPd+nv?=
 =?us-ascii?Q?CMHRP89uJtinoAEemApGWawcD36OScCBoCvvrBTg3By9gyOoY8mGB1caX0iC?=
 =?us-ascii?Q?YUg+9BDzGBbn4JL4IBFFvmWhIaKJOvlE5oapMvI4+DznEHhwcUPavvgutMZk?=
 =?us-ascii?Q?hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nice.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9121.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d16c3b-3254-4534-7a03-08dc7c486510
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 23:22:35.4675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7123dabd-0e87-4da9-9cb9-b7ec82011aad
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6TVxmoL7Zfb1d6CWdDa6I9F2t+heIoj6zEEEDH4B/aDlvx+iXDKumaqIFy15YONt1NcEXGMTf/Rbf+c1PU99kDOoqylIdYxOjhx4jXFgaLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086

Hello!

Does anybody know how can I get the exe, msi and dmg be properly clone to t=
he Jenkins workspace? Currently the files are copied but the file size is l=
ess than the original size save in the repo.

Regards,
Kattia.
