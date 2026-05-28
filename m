Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED6E2C15AC
	for <git@vger.kernel.org>; Thu, 28 May 2026 05:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779947968; cv=fail; b=dBftVVALSul1qQeI0ac625mzq57r70euHfv97gYfS1Wz0B0bUNqG4MoyN5pMUmmCBTcFJjsmYc/bqcCdW2u2KA2xX0D9H9J018l6KqoEcClmAlGPCBEhUpMgh3Hl/XcuJUw56ogsOOmu7/RR6Itf5JzG00whJzkb93GJsPJWvlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779947968; c=relaxed/simple;
	bh=q/r3YYZJkD6sQ+C7y+u4qKR8dkxFZ2y+/7VjRdXAttE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PR/fGil3ks8jM/N9mRp52Ly77uooruzvnK3vXxcTbKi5debH3Y6FTo9OkHKYXKglDg9FgFE8Dh2N2znBCyGU4I8VB+HMwQj1eTFg3eDsx3RBd/3R86LzNEKnMSfpleu2Gwb1QfYFGLRD1A2glKDTEwrcsT7me0mlW5OxG2PSZCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qKPHkz6a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ENVx6JbC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qKPHkz6a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ENVx6JbC"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKiwvq1534025;
	Thu, 28 May 2026 05:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=rtLamJ5AxZTeUR0e4s
	8uaw9Wbp037yPE/8q1xBQHI8w=; b=qKPHkz6aIztrvHyQu+1oEqhhwmOPvk6UIf
	qh0PCxWrSVyyaM2onAVCAZqsrp01fqaVeEdK6D8K9ZHfUeF4rwOuVwmoTSOFNZAk
	F+1O3zOjuK5eguJeZ/90KCoKj/TloTmz7RI7luqzGSMyCuBNhadCa2UwOy6/IQxg
	wkQg8Jwvse7rbgdpsUH6HNIu7L0gRSCAzA13sjPxGek27BVwKR+MHdN8AhWuAFRq
	0dgt558oPQmn2VEzAAKWLngFierftsryQL6Nb9dNVgxbZjBD1DAsIExnGIP/ZDtO
	CRjT38ffNUQWOJqtq/7+U2lugxMV1K4kauaQ5cDkrM5us+B86iBA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ee7ws8dj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 05:59:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64S5st1B034269;
	Thu, 28 May 2026 05:59:07 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4edjs2mg9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 05:59:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X56jZQXYpAuXUtrO1dgcZb3oycwIeMm7dFoe/LLG1uiGsLgVgSguEm0tdIuBXjYlHhSmjDkRudXLKRK65cPgwbJHynYZMa/zalFbMXy/WLxPu/cq0LAmaNUw1U47lAZ3rpwm2pb3oKsQynKyc852PQIJLttih7wzjD461duI25ewqv/Db0f3tUTPx5yzNY+BOjHi8ihvrmnejM6dqXPwpkao7C99iCx4kBOgUV2m1Y9OTcCGTtkJv6k+bkrjsQzOlgZpx82UZvF/4I4TxmYXKjKT53OawDHwISJyvCBPtAmuGh4YRUc0Hk6J+Ehqgsbrvj0O44ooADCQdu0EjwrOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtLamJ5AxZTeUR0e4s8uaw9Wbp037yPE/8q1xBQHI8w=;
 b=YHqDEOSAKokM06TFDu6tXlAQkqcc+IB9uUrv/9z5UyzTmqVwXnglRlaX/bWJ/PlIo4qlj8cJ79j8GRw5qk7zeVMhTLiNBstSBkfroMaXHY4wH1sFlTOsDNrXzeTxCBrq4qAmfm2BUENJoawBoH7GN3ji/nAOnGjmDBBCRI2thR7DnskwFFG1DWBQDEDGwMCA81Ty5vGL8hEHdMgmbceoUlcPXIcsIsfQFfDl9va4ZbkfpIVUQVqBaydzg2UizUQWyIUYgs2V0Hok21Qx0FdnYHTUV2DBw60h1LAhZAY3BQQja+eOd/BZ7QDM9ZxmO7cKJPj4uGWbtmQPuDIuST8Ahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtLamJ5AxZTeUR0e4s8uaw9Wbp037yPE/8q1xBQHI8w=;
 b=ENVx6JbCwgAE68oXqgcw4NM+5Vy9EzcKTam6qhmRgYmZTw36ZweH2i0ru1u4AAi4qXJaIPKbvw05DaaWbXqI1hREWPZYMXaSPZHjKoYAJbE1WOmyZBcJZFW6yMoF8nqAIYXv77VjwG6Z9LyIkCHJhx/PmcFusRMk2G3Zu9a6xTA=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 MW4PR10MB6629.namprd10.prod.outlook.com (2603:10b6:303:22e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 05:59:02 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 05:59:02 +0000
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
Thread-Index: AQHc6qBfXizhJ6cAakOZoOY3SLPW5bYi+OIA
Date: Thu, 28 May 2026 05:59:02 +0000
Message-ID: <963cf0c8667a2f3cc286988a4ca01284c14a90be.camel@oracle.com>
References: <cover.1779532562.git.siddh.raman.pant@oracle.com>
In-Reply-To: <cover.1779532562.git.siddh.raman.pant@oracle.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|MW4PR10MB6629:EE_
x-ms-office365-filtering-correlation-id: 9468f887-7eae-47bf-ffa9-08debc7e37f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|6049299003|376014|1800799024|366016|56012099006|22082099003|18002099003|38070700021|4053099003;
x-microsoft-antispam-message-info:
 WZfXK2FweMBVqwPsRCKgI4wZNX4K9g3v2EbMKKH0ii5Ku7KwgUQVmswUjzayR9cLOpuOWEoDBTMWG/xPfcXMUC5IrPGD+kHWIUp6ZzEmTjQmbT+UwH/F9clyj7vOkiapUqVKa+0y5uFk+4ydxzDxPDDw7cXZ7kGaWOI6ciNx4h9fl6FRCZqcoFhn8zOyCVRAFxDc0gA4Sa0euhe9XesKZLPC2OoZiG8GaNu7wU9YTuGchdQCYALjgME+nUalIZXf0ekT11mCRhKeSjIAk8BMKK3Kums/ldYhFHgPeneAs2IbJ4DdSgTbKY12aKMdPIlg1p3RJDBfww/OphgoFg7G2v0LPLlrwCUUoKZC9WlmfJ4ijxENYD+C6DXqa6KTCCtdT1lYBLXOQx7J/HB8Gi4f/kcyqr+kldRf/q8vBWbqBqVfCjuyAHljbAUV07OuxPbEIB2Q79ueemiA6iP07o1CU/QTWwT2XjD+wbM+ReiuS1xSFlvzYC+5pJFJU7rT929Wj9hkfF9dmE7x5e4Zl0DAQ/EL/fh11o1pQM3xVPPmVZCY3EB7nSC2RA+5sdtSOC3c5axFsh7LYBjn/QSUlexdQo+eM2wc4oI6MaVBxi2U1vVWLOwrSh24uR78VvXi+XelDxPjCH+aMyI6lLqCJhDvSxH638C09c9gDmMHnsJmkMsgRa9ybwuB7JVfoovu08W3BHemIyINUAxmotFYE8cjtA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(6049299003)(376014)(1800799024)(366016)(56012099006)(22082099003)(18002099003)(38070700021)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVhXMUZBbEMxY1RmeWJvbGxDaTBqNmN6RzNrenBWMXcvT2NFS3dPZXlNVVd4?=
 =?utf-8?B?a1RYUmVvWndXbFpDSk0zUThYV1hCS1ZLbnV3ejF5OG9STjhWS2VaaDNHZDR4?=
 =?utf-8?B?UWwxN21EcmJUSmorb29LM05aNXRVUVdXL1pRajRjbTFaNVFXTktMTTg3alIx?=
 =?utf-8?B?bkQ2Y3A3ODlPZXFuQjZzaytEcVRsOWxYaVhhTWZmVW4wVFc2UjVBYmNlUjFL?=
 =?utf-8?B?c1cybGx3Tlp4QXBwVmM1ZmNkTjB5dUVwdDJEcGd0SnltMkhwMVpPSHppUm5S?=
 =?utf-8?B?bThxZnhNVUd4QnhjSU11QVRhWWlPOXMzc3g2SERpMnhMQURkUitmYTUvUXdM?=
 =?utf-8?B?SmRGREsxcXYvTHRTTDl1NWljMmxUanVwUWQ4R0hMeFYzNUhuUWJzZDhxeWgz?=
 =?utf-8?B?cVFSMENaME9nSXRlWTZhTFJuT2thT0pDaEcxYlVFUHhGSm05dWJaRm5kTHhh?=
 =?utf-8?B?K1RrcCtkeDZtTWtSMFdrTlhVZ2xsMFFOYlFXVGF0bFJiU0dKWGkvNlF2OUR5?=
 =?utf-8?B?c21RYzliVWViUjk1NlFLcE5GTkxucVVzcUlmK0dFb2YvZXFKK3RaS1VpVG5w?=
 =?utf-8?B?bE1wYWNQbU5weHUwaG9DTzY4Qkw5U1BGTFNTVjhQckJDS2VRSzBjenJVRlov?=
 =?utf-8?B?WjlzTnhXMVFsYi9yYTlkLytiaU1kc2tPV0M4NDcvQ1VIYlU0Z0pFdHpzQzNE?=
 =?utf-8?B?SHFYMXhnWk5udnpXb2lNdWg4TDNDNDBDRUxWT0E2Ny9FRDBPOHExQWRhdlht?=
 =?utf-8?B?cjhjR1h4aE5FeVNLb2RjaGFaVEFoMzNsOFE3dUh2UE02aVhJbWZlaGk5UU1t?=
 =?utf-8?B?NjFLMXArTVAxckhsY0VrRnAyODBFVFN6M0trZ0djRlpWZWRZdEZRbk03ekxP?=
 =?utf-8?B?UWFZbjlUNzhudllIWG1CRkdIRWE0dldNV09VV2lSRWUvQjVaTGtLTFkxYkxu?=
 =?utf-8?B?dnlEWEFiWmZsNERDVkdmaWlFRlA1UFF5K0JYTWhXd3lrZ3ZTUXB6VGNhVlgv?=
 =?utf-8?B?elgybFM5Nlc5SVhoVzBuK1J3ajNHc3ZGdnNNMnZDU2NFZ2NyQlpraXJZTkJh?=
 =?utf-8?B?aEdzMUFqNm5pT3huQkk3TXZCUSsxLzZHT2NuT2wyVUV2M29zVzB6ZzV4Rlhy?=
 =?utf-8?B?K3RqRmdrbDNFZlVLbmswSGlyN05veUdqM3RSb1lNMFQ3ZUdxSGVCOWdiNVFD?=
 =?utf-8?B?bGh6TkVKeUJHM0lWRTNjQjVNeStINXdIdnV0L3FhWmNqK2gwRStuTUovdGI4?=
 =?utf-8?B?OENVY2xFMURtcFBpaU9EVXBXcGVuVlMrLzdacnZ4M3RVd005TGJRUjBEdUU4?=
 =?utf-8?B?dTJHbFgrb0U5RzRWSW9pRDdsc1lzMGRXeHZiaG1Tbk5aRFRFVFhpeU5WdUcx?=
 =?utf-8?B?bkRTcDdad1hWQUZzK2hkL0VTZm95UDNPd0s1d3I3Mm1kN2ozNWZ2NjNxK21L?=
 =?utf-8?B?Yk5CaG1wd3JEbU5KZFBUUGtsc0prZDNrc0FPdlU1SEw5RmovdzV2WFk5Qkd3?=
 =?utf-8?B?ZnhqOXVvSmZ3OTJxZDJPVHhJN1VRb3pZYWtNWm9xdzh6Y1o0dzJYcmRaTEhv?=
 =?utf-8?B?cllUWWtiWjZTanY1OGREajVUNGhXczNQdkhtS2hIZFp5L3oyeHNKVlpVMk9j?=
 =?utf-8?B?aTNVdWFzelRtTmkzMHd3bVhBWFhHV3A2a095Mk5EQXVScmVYd2ZkZlJzU2tK?=
 =?utf-8?B?aUorZmdHQlJZQzVCMThqcE56SWZwMkhqN1RIVE82NEVxVHN2WG9qaHQwak9Y?=
 =?utf-8?B?NXZMSFVCNWlhMnEyOWQyeGVwVEhZaFdFQnBjQXRodlBjQU41Rk0zTVFHZnZK?=
 =?utf-8?B?UDdTcC80OCs2cXhrVExJdXBGN2xwYXdPNmxvUHpKQzZ2Q2ZHbnlmZENab1FO?=
 =?utf-8?B?WXVuK05mK1ZPL1VOcmtTN3ByTzh2MjJlVjdZSnJFVDR1WCtFOEZQblJvK1dK?=
 =?utf-8?B?NmUzcFdLektjZWY2dlNNTHRUQWg3dlVQWGNQQ1V6b2hROTJvSkVQQkpSaUdx?=
 =?utf-8?B?bVQ2OG9DYVRvZU94VlJhem1KUlEzSy9yWW9XcGVLMkVvV0RoR3Q5SmdDQzIy?=
 =?utf-8?B?d1lia1FFbmxJY0VBWnZUdFdDOXpwR2E4YUN3WVZmSG9UaFVSZGtVT29TdTJV?=
 =?utf-8?B?N3A1QnMvMjF4UDhPZmpBS09DUGNCcnhJOEZrTzNVS3c2YVR0MDNwT3ArdmFK?=
 =?utf-8?B?dmdXSVBUVUNvd3haK2gvcjgvVkdZL1ZoREhpVTVtaENEenBnN3ZWMktvM1hW?=
 =?utf-8?B?cXc0dHZTVitHcjhBVUZ5Q1UzM3IrREZ6MU4zVi9wUUxDOXhjNjdYbVZMK0p3?=
 =?utf-8?B?VjlheHE5NHBWVU83d1V1K2FXMHZKWmN3Qld4MlJIUjE5TDBnK3IvSWZwckhw?=
 =?utf-8?Q?bgqqqEEPCdlG8Y6rjyqrWLl+vxCe083IaSr0nQzIPE/1F?=
x-ms-exchange-antispam-messagedata-1: UroG2wsg5UuQ02hetSnxLeXj4QqCK6tWROU=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-iNkscf+DX84fWfTd44gl"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	oP1EXKDVYzTcI0oua03oS6nkmNfG1ltgta8MrYfo84hrwubeyfjoipyYzW7wxdsONYepe6BZ/FkUPazJA9sozw5kls6NbdwhPk60JqeYXyUGye2g9v2uFezgQSAvQzmaqyYE3yyrJ2v4pExI1TB+1OGojQ6cM7qmyq2q/o0A3HMoSC+eMDlXkxNTDKUHjNNEE0PTZX6OT96tGQjSrouuiWnvkvCDv7wyKlgwGSwPkV1VtKap8pk+EWPCxRgMP0KzldJi9rvGMVGfH3ff5OtmgHGSs1TsRurznTbA6B7mEc1E4VSdpF7Mfe8OXTjk2uJkmutSOKKw7UzIeVywKptuSw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MpLAqsQKhBKnMEplvc1i5ftfQPDLnx639XZWzOm0uMu89lfNfDhTkj0gkBDZdVSmvI3bks7lucByvLme+dnsJ4877ErUKCQWwOZdaE/Q+nLNvK3mqiQuZIOnIZi/G8b4Eit4JJr4HT69BDWdaPgNFLSXLOhm8/AOdngZRUmb3n64rUAnYaBopCRCbQQTpVO5ttY1JmiXY0gcCI5GA3IWyiv4/F+Rga4zT83hLsELjk5jYoxwrIKsx5BwLJqq15D3U1DNU6U2UcIMY+/kAL5BT8v45SPEYYhNu4VkGaYGLzW+T5gegH4gaF892anPMkThYOA7xRhk7f1o5rxfEGiQBAuY62XGnXxUi8b/qK9TM80VtER32OoTzNto8Gj9U2fqTM1VNEfg1zJokFFtf2Zf3bnZWGny8Jj5eyCvtxoJL9J1kO1nSdE4kfhi6x3TTOFiufde7DyHTyJMw42scF3IiRqK0RMJxqqaA6ReOSKL+0cwSj3RsGZMAXz+Dq7cld/SyAmBN4Mwf4wyj22ynI/BOK5e+SRh8Ys/J7lXGl6DrWWzAXasBTLadm02ppyqU07U0EqwZ+8uWy5yOBH8nV0JGjgXmd+gXfwEESl51IEHrH8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9468f887-7eae-47bf-ffa9-08debc7e37f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 05:59:02.3490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dx+BXkvuqYLQBPuOUuPKie1urwBGIiBuUXwNNnkznsBss+3SFj8tcsuKSWTPVGiZE0KTFoSI6gbKxcpsSNCH8nFcFheBpH+GT/M0hUij/Bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605280056
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA1NyBTYWx0ZWRfX7YREA9PSxNag
 1HjnT9Nr2dnmmVe8YAX2cClnIV773yxqnuXqcDiwFxeTLvc6EnUiDT/jO8nevkthurTK6Z27ESo
 siRnIrP3QmNCXC/jNC0DzXEkp7cyw8fZzIJDJxxpaau695scwuHmonlLU7n4YcB45VFQZbWcmmS
 PyR1AtQ3pKTYGZF61tplZhTTn7THX0lDi8NDsP/WHhBts5ovv3//kxbt6P7OMBKIDHCG2ow0cnA
 MvktjhncrkCMoCgvoT1YkAQy/CE7gwGP5DofRxrr/+0j+zd79IkvDna+Hc63Hfe839o/mgfSdEz
 aMynY45Eq6OspVFMDKStw3xL85DFpko7sk2/Q1pZY2/0BTb8h+W0jefgiQ9na+1KOtjXObgOAZ+
 w+qLcnsNf/CsOWwyIrkrWH7XpIdnp4INvRty7RAalpoWgIiocR9vODuLpU367By/d+XpnkL63Kx
 RmSJM19I6oOyt3ecGZQ==
X-Proofpoint-ORIG-GUID: TdI4j7xrgadXihlzp71VOb_4xJ6GXNai
X-Proofpoint-GUID: TdI4j7xrgadXihlzp71VOb_4xJ6GXNai
X-Authority-Analysis: v=2.4 cv=O6wJeh9W c=1 sm=1 tr=0 ts=6a17d9ad cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=kjtO8AbF9QlfHcqC9bMA:9 a=QEXdDO2ut3YA:10
 a=u4YFaho6sLZpgfVMwjoA:9 a=FfaGCDsud1wA:10

--=-iNkscf+DX84fWfTd44gl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Pinging since it's been almost a week (v2 was sent on Fri)...=20
I sent close/during the weekend, so I think this fell through.

Sorry if this bothers. Just curious as I haven't heard back like the
last time.

Thanks,
Siddh

On Sat, May 23 2026 at 16:08:08 +0530, Siddh Raman Pant wrote:
> v2: https://lore.kernel.org/git/cover.1779464886.git.siddh.raman.pant@ora=
cle.com/
> v1: https://lore.kernel.org/git/cover.1779207350.git.siddh.raman.pant@ora=
cle.com/
>=20
> <...insert text from v1 cover here...>
>=20
> Changes since v2:
> - Removed stale help text talking about force-killing helper process.
>=20
> Changes since v1:
> - Removed Documentation commit and sent as a standalone patch.
> - Removed finish_command_with_timeout addition (and thus sleep_nanosec).
> - Squashed the external notes command code, doc, and test commits.
> - Removed horizontal separators from note-external.c.
> - Removed global variables from translation unit and instead store config=
 in
>   a dedicated new struct member in struct display_notes_opt.
> - Reworded the main commit to have better explanation of the motivation.
>=20
> Siddh Raman Pant (4):
>   notes: convert raw arg in format_display_notes() to bool
>   wrapper: add support for timeout and deadline in read helpers
>   t3301: cover generic displayed notes behavior
>   notes: support an external command to display notes
>=20
>  Documentation/config/notes.adoc             |  59 +++
>  Documentation/git-format-patch.adoc         |  11 +-
>  Documentation/git-range-diff.adoc           |   6 +
>  Documentation/pretty-options.adoc           |   9 +
>  Makefile                                    |   2 +
>  builtin/log.c                               |  17 +-
>  builtin/name-rev.c                          |   9 +-
>  builtin/range-diff.c                        |   2 +
>  contrib/completion/git-completion.bash      |   4 +-
>  log-tree.c                                  |  10 +-
>  meson.build                                 |   1 +
>  notes-external.c                            | 414 ++++++++++++++++++
>  notes-external.h                            |  53 +++
>  notes.c                                     | 266 +++++++++---
>  notes.h                                     |  33 +-
>  revision.c                                  |  36 +-
>  strbuf.c                                    |  26 +-
>  strbuf.h                                    |   4 +
>  t/helper/meson.build                        |   1 +
>  t/helper/test-external-notes                |  64 +++
>  t/helper/test-notes-external-config-reset.c |  24 ++
>  t/helper/test-tool.c                        |   1 +
>  t/helper/test-tool.h                        |   1 +
>  t/lib-notes.sh                              |  19 +
>  t/t3206-range-diff.sh                       |  68 +++
>  t/t3301-notes.sh                            | 448 ++++++++++++++++++++
>  t/t6120-describe.sh                         |  17 +
>  wrapper.c                                   | 139 +++++-
>  wrapper.h                                   |  23 +
>  29 files changed, 1691 insertions(+), 76 deletions(-)
>  create mode 100644 notes-external.c
>  create mode 100644 notes-external.h
>  create mode 100755 t/helper/test-external-notes
>  create mode 100644 t/helper/test-notes-external-config-reset.c
>  create mode 100644 t/lib-notes.sh

--=-iNkscf+DX84fWfTd44gl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmoX2Z8ACgkQBwq/MEwk
8iphGA/+LQkgdrEkUgNC56kv9msIgqc+PdsqZZhPg/GEtFNJR2xQn6FoLOBLZqsC
ai6Z5rg+sDjgx/SNLR3xGYqnK0clsrROD1QWGiCBLSiU7ZpUNoaBm7LvBG4m0U41
PUfcVStJOlooYhFsb88Bki8yCdSweICKe6jaasENjQWDiYUBfw2jhrBEgOwXuAww
VVt0JvpSex0TVLzUk0LRCjyzahzXEmnd7EJ5OPQW9NiMieCY9KMLJTKgKgfQEjjI
Sz+DQL7FjXQ03LpUwcMhYRXWnrg+L2shHtAP2JQiBjvzO77NrUrvz6t0t1VXxrM/
eCJEDB7pBpusil4pX+tl4IjNF6bCObG/VDZjruEgI6rIhi6A/xwP8c4aJuaMdLo9
RHH9zCaDXG+yu1ZtrLMv/qzD5gF0HeRJYRpu/vMMPKufF84aS8ZHrLe+G90qjVLq
nkMxYG+teqfWxB4ZgaITbzV9cb2I9l1QXGq5cJRgJDPjxUDRvEZVjFCZSyccBqUc
mNXfZQFRh1OUqxklka2N0zqiQLDe3UlwuUJ9/NodF90YaYsW0rhpXbjB/F9GTDll
w5klJ2msMAZmomQyk2HoOhAQlQUuCQNfy3AAIulwwuP+KZjkmVjcXJ203MctK07M
0ezMF48N/ij6jo0Hh51kPKG33y9N9qkxNKxf/rqjE9uP69+BhOE=
=sreM
-----END PGP SIGNATURE-----

--=-iNkscf+DX84fWfTd44gl--
