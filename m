Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F6537BE6A
	for <git@vger.kernel.org>; Thu, 21 May 2026 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357566; cv=fail; b=X1bEF2B2UityCFxWIqtd7d0a6PhvkP6SGPh6YcipQDQjGekTX+Z6hCSZ0nDRcmGx9Bo/pazUWrvnnxjn4A81xqwSfO1SMnApL8dS5aU7jf8kVGkYyOrI9gJCTPAsyRP+8CoqZYNZlKyNA+fVhRcwdc/tTh6Y3ux7UXaU4vOuOug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357566; c=relaxed/simple;
	bh=2lYY1cU/OQqh5TwwtpTPe/eN+WRVNGMW8c0emdpM62o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uRZRiEGBT5wKhR+kPockcm3ID+0VZBuL0HuTnwOijQw+vkpxl5sZiS9GW6skEnDwjBTPqUcwlRFM4viZJ3N3wkQ6He7dszVMoabn2e/AvdidpZhAu2JdLEwaSwTFtLzVuXrE6UtQuYcfM1UeMPu1Ao5CqjuFieFtmyw/B09DoQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=plGzTcf6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bt2n2KUq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="plGzTcf6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bt2n2KUq"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L1Mw5G1504370;
	Thu, 21 May 2026 09:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2lYY1cU/OQqh5Twwtp
	TPe/eN+WRVNGMW8c0emdpM62o=; b=plGzTcf6FyWiHEt3c4uuhT+483wjBg8JGl
	8BrJGErTYKRxCeTuwuWRKitUR4b2KokicZ4j2CAzL4NpuFIVcPrIy0oyPT43p7LX
	7kPt4VhFzLMqVlsB8oGPIpoLBFS4uaXc6iRgeBQc4dT4zmevsw+O0/4gCu00ElBS
	lOvgUmCtLEUXqUpPvFctlNxueyloZ45mXxyXBCofx9ZFtHAl0adP4IBz0mQQ25Ez
	CgdqBmBOTF9iDHNtcaVXzGSwKIh8lUWqilSGc1CeTf9yM+oj3uCdvDzY68BmyzjK
	VTyrKDdkxFJXzKtoeypEy/5HMlEXwwrCDdLIhqYnpwOxVHlUbX4w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h87118b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 09:59:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64L9skXI030014;
	Thu, 21 May 2026 09:59:13 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1jfg1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 09:59:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7h/cbHdQ3G53adz4B+Baxx3vScO+gkE/YIZg2rbSPkW3PRs+EaUkKDOsaa60isZtwTKNyfb+XRHSislTcjRU5+HXPKoNK56Q/eFFSiid292i4UaNzFqDJZ3n5HS1sMxhtjQBZp3ZIEtASRZMhBhPDudpJ94aAkiIQr/x0Tik62fo7jUQz7QVqaFzTIdXhPQp+dlvWaQQ5Um4HKK1KPvh1yPlMb5WDVrEJrw/0ZJi6U3qqg0uR1OGe8lrpr5Y0V/AnZDv7oKAA1ZJ+ocx/Z4yHw/fO1p0g/0i7NyP8x9vpOBKswQtudZj0XtndMCnp4vtNgQy9Umw4xdfMSTKCjbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lYY1cU/OQqh5TwwtpTPe/eN+WRVNGMW8c0emdpM62o=;
 b=kHWmMuoXTydHOkIxguHGh5F9EiK6UJIWQIcwRNAy1zuOxBo0XEjvxQGJtzp5so8b9kaXIf5pI8ttbgWKI+ztHy8/TIcG24683QfykHZTlVlTV63XjyIDMPVjItA4Ms4iTk0BG0hwgMetI9E+YQCJYLQGj1lOVoPd/ZO0d7qxBAX/umy4LEH1WxAw/GUYrq0W9KC0ipeVrA03dWqEs2Rd1ByK1NcTsqNNx3EcmNitLUJZQdQrRJ5nhAZAsS6ZAavyQbDOvnomoPf1Jau8PIR9J1VVizHCmAzefJyypXdNYQtiEYY6dTPyf5Gjysj76+C+ryQoYoRliL0WiVvCntdAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lYY1cU/OQqh5TwwtpTPe/eN+WRVNGMW8c0emdpM62o=;
 b=Bt2n2KUqCpKBrs2svRezKiLJkiJGX31ssRHB/q3GE4lKWbLm/mlHGyOid3EM6UQ19ytje5D4oRVR5TGv1ndx3tYJjf+182bhjSmvmNPlRl0z419AEFSMOyuIg4XH2SwUGEvDFy5X8103f+tZp6xrUoVbOd46+yc4oJFi8ZGj6+I=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 SA2PR10MB4490.namprd10.prod.outlook.com (2603:10b6:806:f9::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Thu, 21 May 2026 09:59:10 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 09:59:09 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "j6t@kdbg.org" <j6t@kdbg.org>
CC: "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com"
	<gitster@pobox.com>,
        "newren@gmail.com" <newren@gmail.com>, "ps@pks.im"
	<ps@pks.im>,
        "oswald.buddenhagen@gmx.de" <oswald.buddenhagen@gmx.de>,
        "code@khaugsbakk.name" <code@khaugsbakk.name>
Subject: Re: [PATCH 4/9] run-command: add support for timeout in command
 finisher
Thread-Topic: [PATCH 4/9] run-command: add support for timeout in command
 finisher
Thread-Index: AQHc6Qh4F8g4gQtFSkWY4yUj0M8kkw==
Date: Thu, 21 May 2026 09:59:09 +0000
Message-ID: <2f7eea03273ffaacc50a9ae186673da88fc3345f.camel@oracle.com>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
	 <f58c8c522814dce9257f64733e9fbc9bd9f446c0.1779207350.git.siddh.raman.pant@oracle.com>
	 <b69605a6-e841-47b9-a899-a57e184d3c8b@kdbg.org>
In-Reply-To: <b69605a6-e841-47b9-a899-a57e184d3c8b@kdbg.org>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|SA2PR10MB4490:EE_
x-ms-office365-filtering-correlation-id: cab0a81c-ba80-48e6-7a27-08deb71f9a9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|6049299003|366016|376014|1800799024|10070799003|3023799007|22082099003|56012099003|18002099003|4053099003|38070700021|4143699003;
x-microsoft-antispam-message-info:
 1WueJMopcbxoUsFgWy5eUg3Gfh7AFNjhbi0lTsIHuLkBfOoC8Kb9ep6+JFvZkIWTBIfR88+X2KcNEfaji7+/sbl8OwcK+nR03Ruzl6hwXe0CUQeC9g9vFcPoWEWfU2LJCPLtC8+psgE49iPFMdVUDlyqFoIpkPw1LkCXUMPo/dEW/AlpjmE+LP5/6V6cZ4Ki63FXytltXNukC2AexxBoZ+C9v0+PAmRbIM3h6b0g2zwDv5bp1abzLUhQJe9iSrLj79cStP7rpUjp5j6d6lxrVwkDXIRi5rq7u8aC2dG+xDmmcP6vKSKXLZsLJA4B9yz/csPnnT3xzxoB8Etc3pCKWKPrgIpS/CSz4MXJUbQ8NYc4ZnQrviqoIqhbPbglK4CGEu2FCidS/yIGhWxw0VHQ3Vd0l4bgXHwpm+1nj8g5PZZQFi2L9UCYQg69ii+KQkzyni9OvInij6CoRG6sSilWfAYZ0BfmCU7FGGnsYsBh64ewQ9E+0NqYpLUAANaknOVkfwK4S7O0WiSakearwyzyrniN0JVYHOAQNW7ymU4y4r9de5SvBtZaDbWFD7fj4dAlLYwbh3KOK2sZ5vBiiK6pVtKGsWLc5WCRWyvcm39KdA3OvHWbyFn0pI7SCTKp3WunoGKMh361qLPvERZZP5bufnYg+AmRYkTSUF3y6cyKV7KFYAxZbS4bGGwlRllQEYH+h5d+jhWJGwgHEnbQwMf0KHdsRiOcpUJdaPrP3dMDUeQhRJL9DxIypAFFi7WPERHq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(366016)(376014)(1800799024)(10070799003)(3023799007)(22082099003)(56012099003)(18002099003)(4053099003)(38070700021)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3ZLUElpT0Z2ZkE2TGhYWU81b3BQT2g5RFU1azIyM0ZJOTdtdzY1Z0xQN3Uw?=
 =?utf-8?B?NGpoeFR0NkVmYXNHV2luVG9GK0VhUXhGM3ZXbld0THZhcVpWTmNvUVlSZmJE?=
 =?utf-8?B?ZHM0dElHY3c3VzNra2U1aGkzZ3pFUzRrQnlrMzZPZkFmZS9UWE9QbW5HNXN4?=
 =?utf-8?B?M1BUTkNYMVF2YURER1ovdFZBK1R4NjVMdVNZRXNXd296TE1JK1laeHRmdUJj?=
 =?utf-8?B?dXFBRU8zY1JmWGdIYVB0aDFVbmJiUC9CbS9OMER3NjJNSEd3b1FramhGM3lq?=
 =?utf-8?B?Vi9ZbTdwQmlRVzNYZWtsNVJFUGNiL25VUUhWWnh0N2xMZkFMaFpWR1l6bFpQ?=
 =?utf-8?B?WDJZdmJJSjJQZ041NXAzRTBNa0xHTEYrSlVWZUtoYUFDZkRjL3UwV1o5Y3Ry?=
 =?utf-8?B?VVdNL1VWSnBRU0ZaaWdNbnh0V2tMNEpNWlFOQkVFT0FQZGdHY28xREpXWDlT?=
 =?utf-8?B?Q0Iyb1BEYWNLbGYvQzQ3ZThpV1JzRGFheUxQczBic092dHJmYzlIbTVPdkM0?=
 =?utf-8?B?WmFyTTZUVncxTnZVNGg2cUJSY091VWhSMHRyTlNVcTF1TThuWkpmbHR1dGdk?=
 =?utf-8?B?MzROakZYaHIxMy9ENFh4OFBab1c3V04xcEx3dXQ4QlBOL1dYMzNzbDQzVnBo?=
 =?utf-8?B?Sm8wSzJMMjd0TGpLeCtWRXdYM1puR056eXF5bmtuM201ek9Cb0p6Y1l3Zm5i?=
 =?utf-8?B?Q3VOMWwyMlpIYTV4UmtoS3JIdmY3TnVhOURxdUt3WFVaYTNyMlZxOXJ0eDFE?=
 =?utf-8?B?bWk3TURvNUJ0dStGeGJzMnVyL2lVTStvUHJwRjNzb1N3Y1NGaEE0WFFIZ2xv?=
 =?utf-8?B?aXNMV3E3UlI2T21RQXVOTEREU1E1eXlDek4zUU9WRHBSdTEvM01SdjVZYkxq?=
 =?utf-8?B?elZSa2ptZmQ4c0JITWJ3YlpEY3puN2ZBY1BGYlpOSmxxNzBZamFUK0lFUk1y?=
 =?utf-8?B?RDRDU0Y4QUVuaDNvRVJqQ0pWdlNVRllXalZVaUJNcEJsc3FQUFJSWTU1Zmd5?=
 =?utf-8?B?bXQ4UGtrK29XWHJSeVNja2tZV3JvZEpaa3cxMVZPUWQyM2NLNUJHOVBMRzE1?=
 =?utf-8?B?YUFEby9qTmhZNldaanpqeno5Y0FmUWtzRzM4S0U5eEcyWWdzdDQ4U1pDMGI0?=
 =?utf-8?B?OGYydmpOT2dNZ3VlOHp1SVQ2RjJoNm5oZ0VINzVyVkdDbWJyTW9NRktSSjBv?=
 =?utf-8?B?U3l0c01PUTNMZFExcTgwOStVM3k4R0pXdDhuU1hNTmtQMFJEMHFJdDNvMnpK?=
 =?utf-8?B?MTVYQTlONEFOYWJmVjFyY2JVcjlHU1N4c0NMdk94dlZDYWRaUkl2ZThBL1o1?=
 =?utf-8?B?blJsc2ZTd3RRcUxRL3ZTTGlBbklldXQxcnVsY0RSd0Jtell0aHIyYUpFaEQw?=
 =?utf-8?B?U2R4RFdMdE9CUVBOejlFZExuUVlOaXE3RmZkSFVSUmJrQ2ltc2pMYTM5dFhR?=
 =?utf-8?B?Z0xLZFVPOEFPZCtuQ21hQ0tJQjFPZVhwV3NzeEh1akY2OG5DelBTeHduN3Bt?=
 =?utf-8?B?YmhVNThoTEtTcU12d2IvZnVRamM5NFR4MldLYTlSb3ZLdFp1U0VBUngrSE9M?=
 =?utf-8?B?NlVjU2tzRG51OWxqOWxzY1V2aEFtTElSQlhOcWpGZVNKSldwWTBsbVRaK3ZP?=
 =?utf-8?B?UFBpZUdaS0xRMGFSZkl6ZzVmZytpY2xOQ2tkdGYraTRWMzdaeXRUa05Xbkpp?=
 =?utf-8?B?QjlmWHFrQTYyckltUDQxMUF2M3lyaHR1elo5UDRlQW5QSEhjMTUrNTdlcUdh?=
 =?utf-8?B?UWhvL1owb282VW5tU0JPZW5YWDh1bUJ2Sy9UV0t4Uy9VQm1wejFVZ29YMnlS?=
 =?utf-8?B?WE5rSHpsQzVjOVZKQU45OWdjQzU2UGQ1ZVJSazMxVWJVK1QxeFZiVWxaeW0v?=
 =?utf-8?B?RFlUM2RDQkc5clZqSGgyZkZRRk16YVY5ajA2VnQ1RFdIa2Y2bFI5WE9iNmYy?=
 =?utf-8?B?a0VYcXFVWFpvZjJGSERiOFdzRWhYeVljeU5xQ3kzUjR6YjRkcWROdUFualpH?=
 =?utf-8?B?UXp3WEIvZ2hrbzRYVUh2c3hjSGlvVjVkdmxaTWxWT1ZuOUlnT3NRc3J1bExy?=
 =?utf-8?B?bWI1QkJSd2xuNVRRSUEyYWU4ZW5xNytQMy9XTUpZaTB3ZVp3dWtFU1gxTWlp?=
 =?utf-8?B?OHlxa0o1SmxYQm8wY3ZLZUtKelJlZ1JCd0ZINVVHSGpGa2FDRklDL2NIVXJk?=
 =?utf-8?B?MEVlTUhIMVdjNVVVeHkxMnNVeFpFYVRNUVA1NnhPMTloZnQ4YTVSQ1l5clNM?=
 =?utf-8?B?NCsyV1ZPcFZsOGFWQXR2b25GZzNJWkV0QjhlZldhaXkwVWY0QkFiRXRyQ3NG?=
 =?utf-8?B?cEpacDNSY3lJU0F6ZFFYY3VzZllpUlZXNTV1a0h4Mi9zMks1ZGNteUZFNlhl?=
 =?utf-8?Q?b858fNZ8fvjBsXVaCRRVW/XeVYMr2hveahlg+h60i873Q?=
x-ms-exchange-antispam-messagedata-1: Ay2Hy1lDSWPRfM3D+0Pdgvqve/mGTJsn+Sw=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-hqk73e4PbmyH5c4j1KWP"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	IfkGVAw5Q3AmAxC0AQHgCEYzKYnFhcN1GrxmcLW+Etm48VyPn4/yqm8VUKyrMNYuQVaBUmSxAjQ4FuJzugldByWIIiIrtLDarSTzJGc98L2vYiBEWXS8fRuqwPE22AztqiNq/575USnXS1XL8Wjgqed9OwLyNzOuc6nK0/2a58lNTV/NObanaIApavEFBaHdmQAQCVAevgEwfctydHmcV1mIrezbxz2MlExjstc5mtO3gUcXsPo1wO8+wxQvO76Z49vMmjOH5RXU40rdCrbYnT5nSzJpHKzWqlDsT7aOTEixHhaS+AEvn/mUG6DMoBGMwG3R6NxJv9LO2HUNNe8K3w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cHOCj89ILeJPow5eXrW0dD5yksfOT7u+Sp8oo6levU/b8tdmTneJZml56kDlXx53lc9ejWRxoYS9/jB3DmZL/Ce0lM1IfhaUoZnvCDZoLM/IWC8dGeYXK5eDfsCcmkVf32Ui1NF1GKOSlhxLEHElcThLsNnVtTnMul9+rPz/aqIUD4k7azpbZKyt+YPplM7UqiLnCy4vL5abpgy4SnueMCPIvgK3mGhtwJcYz1QuF2nIszbyv34cne8FDtxmjSC/AjbvbW1F9PmG2bj/RYoQkEbYHVnt+I9sQ3CqqIsjPoKcrksZvjk+Qf4KET8qQNYUCmWa+10+iY9eYdFEY4YIfYCo767wo/+mqB6kx0wHqreBESCtApGoVDHdbGJ4xwxJuY4dMTjHfAfK+3R2poI2uHC4zOfTWQHp458nOpcte9doRSAQIAikORPYJDtFgCFogdWsTjeRkz/6QMaIusrDLIxLBnxiEPsDkhFmJfLfaETFhjAA592a9QFGparY5POzaXVdluuPE3CMPHgcjMNcPmWP2ieKDZvWpguEfqfBIRZs+4SxYPRixiUVY6GCaogKdTFl7TkZQUlWAzMNPMBoCuyNRSoxW35rse7QibVzyq4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab0a81c-ba80-48e6-7a27-08deb71f9a9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 09:59:09.8437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36yfByJtj/ryXQYn2490tKcl5DGz1Y/gz96GetNa8MduclWbkYwKKh77EsFK8TTOCDDjeYRRPqmoOZ8xemd3NQzH28QK8hEdzAKFfu6bJXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4490
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605210098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA5OSBTYWx0ZWRfXy/su++6r0Pu7
 WIqP703DokiFcuIVBznIviSrt92mo802tAsrmMT59W8vsofo/z3/o6BEp2bmxxA1ImHOk/bumyg
 tAOlQY56j4mQIvibgMj3rwyNEhoRvgAKFYr2jAznlQfyQXBhIl5CoVsvtM07appmkMFwVD73FtA
 JnXj3JKC/+KwjrcLR59rZtmKquC3lMQHve2pGMw+X/JT2M9EcCJ7DEqDB5Z5XmeW9KyAo2p/06H
 NyULrwSEEV3oOY9sUClfiPuVrksj+V9pBD4+GbE/asYdyOu52ZXwTcu0lY4Zds3OjvCUGPubXhy
 kthIYEgcyKELQagt/1/BmneOBGt4mqoYSZMUDMv09y91JwuyUkW0gqE9maCN9QoIO05D0NbjevV
 94HOV/B4FCC5IAKaI3pljItkgbS8575OWeJBiyh6CNhusNERzKWzAxgtjbXt5yBkza36xAMHit7
 5qwPezyxqcDsehFEL8OMPu6yWxtZ+oqw7C1bn6j4=
X-Proofpoint-GUID: Pokvqgs1ktd4OzGWrU5UUqFODzlD9hqw
X-Proofpoint-ORIG-GUID: Pokvqgs1ktd4OzGWrU5UUqFODzlD9hqw
X-Authority-Analysis: v=2.4 cv=TLN1jVla c=1 sm=1 tr=0 ts=6a0ed774 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22
 a=yZLfN6KVfSylwm2PAZIA:9 a=QEXdDO2ut3YA:10 a=vqO12s-HgtJfW_Ssb1UA:9
 a=FfaGCDsud1wA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12299

--=-hqk73e4PbmyH5c4j1KWP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21 2026 at 12:51:51 +0530, Johannes Sixt wrote:
> This is extremely suspicious. A communication protocl with a child
> program that requires to kill the child looks like a design error. A
> band-aid like this timeout should not be necessary for a well-behaved
> child process.

I do not think this is a protocol design error. The normal protocol does
not require killing the helper: git sends one object id, the helper
sends one bounded response, and the helper exits when git closes its
pipes.

The timeout is for the failure path, where the external helper has
already stopped following that protocol or is blocked on something
outside git's control. Since git starts the helper and puts it on the
log/grep path, git also needs a bounded way to recover when that helper
does not make progress. Otherwise an optional note source can prevent
the main git command from completing.

> If the (your?) problem is that the child process is actually not
> well-behaved, then I suggest to use a middle-man as child process that
> behaves well from the point of view of the git process, but can punish
> the ill-behaved downstream process when needed.

A middle-man would need the same timeout/termination/reaping logic, and
git would still need to handle the middle-man itself hanging / failing.
So I don't think it removes the problem, it just makes each user or
deployment carry that process-supervision logic outside git.

External notes are additive. If the helper misbehaves, the intended
behavior is to warn once, disable that source for the rest of the
process, and let git continue without those notes. That seems
preferable to leaving git stuck in finish_command().

Thanks,
Siddh

--=-hqk73e4PbmyH5c4j1KWP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmoO12cACgkQBwq/MEwk
8iowBxAAlKaEKKHT8bU+MDXdXpTlGx4FKk/6tRHZm8dmMXFbZVK4b+zGu32B2Ur6
GJZz0MuZqufcHyjsXjBuPJFBN+zrM8XicT+kZjtSDXyKPqZRtiZ3AaYrG+iCnH0k
dOioEmCd0BzzHPWiroIAPSvUMMzSq5QpTxNWMwxIOb/hzq3WeKPjVSO9IhED4gVN
3q0746c1lqCr3ZKyqi4X1nVAzqlVsg/j2zWcKrp09aCCvXcCidisXMpDziKxXUDF
OyN7iTyxCgjpAG64tstuMPQ2MM3DSjxgzn/KxBMfBdSVlXBmbPeSX3ywiPjdkF1U
vgCY1bl7uYqaMkOBnVi4OHXMOT8QIJsBGQk0jyR3nnJ+3I0KXqI8T1iz/ZsB9aBn
Yd6PGTIiT/mTWJ/JaprktrEJP/2dd5IxBWigbDYF3IFb0BVmMRZ19nYjIpj1784X
6CgNmYwpRyX7yOS+5MVmBDm5nt07chV7U2q65e+PONRakSyB63K6eu6RnrPoB60M
SzQyuEiS4XDtdscGjZkqoSMppYGW5jMOMN04CMehpC684rZ+fekgGScR5C89owvk
4ITs9mkDWu2Ufog9lr47o2xvPyflemOU2RYkIzY3q673eKCZNCpyJM98gDCi5hVr
GhaOmHToWasmBaUzN91xHMrwh6G6aZdgAtYiV+7FdUpuj2ro/SU=
=JsWF
-----END PGP SIGNATURE-----

--=-hqk73e4PbmyH5c4j1KWP--
