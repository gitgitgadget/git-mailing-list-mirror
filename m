Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38DF392825
	for <git@vger.kernel.org>; Fri, 22 May 2026 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779437051; cv=fail; b=G6XvmO05EvN+Rrw+1TC7iFK8SDfSqjxK/CNGCgvMh/LcESrXH9/vTT9Duj+KSgAjpgMkpo7bMD1/LZDgJr7Pqbh6MI0L9phLH1vNSKFO+RC1UIt+UC4UvncdxYrd2KDd20TpFORPYWw48wlEUgA+bUnWYeg6IZ21uhUKap5eKUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779437051; c=relaxed/simple;
	bh=w37ZUKD/5TecUwYTnGMGDSLeMwRjdVzZKUzNNieSc8Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jzvAHbJUWxT+nV6K4tm0LCemkDj0VzBY2nDjt8Q1gjD5OOpodM4wcoO6wS9tuqntYOqO3Sd2721IC/0XZdRCPG9AEWYMjujQhdJDGK6YYaZ26EMyFkdxEobEaB550Z0ABSQjav4XdX4Ilz7BMfnKLeyRjNBml8eD1BYWnbUryV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IqmUD0ZF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oiztp56Q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IqmUD0ZF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oiztp56Q"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M4Ih8n4160996;
	Fri, 22 May 2026 08:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jpTtHeYeb3UGNc8TuD
	kEmBmo8Y8uu56jUK8PAQ4JxwI=; b=IqmUD0ZFNmFgXrUNH7sKBBcLELF3lCN6rq
	BbICT6d/vUjDcdWVcB0PzXg2/EVpvvNOlE6cv1qMWnuQ4HSl7O4H0+NNkvdHXTuu
	AFDVeFo/S64e5tn17qTJDSvRW1gABRmqQ3atdj3+v9pzw7RPWhTGT+/eaZKwTMxQ
	PK8a0/GKKA+Sa3UbJD7A+t6lhBIPHZ+3FbhsqlKkmTlxaflrbn0FotrpAwzAY7Fe
	itz0bxDGY44PFuo920YuPmw7bMgZFJMs3RJE163J4vGXg7qZIb0MQjCX6ZEfYuH+
	sWWuEdr9mvdM/mXkS43Nk+f9WRdb3EMkNrnTLy6IRrdHmrB1Kf7Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h2sjffg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 08:04:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64M7sluE024352;
	Fri, 22 May 2026 08:04:00 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1kg11k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 08:04:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/ccl4NySLQGdfAurA1dQFZpUgwDRSisRXqMJ3LlCt62R91rFzK1qKKHlwarXoWzXGKBOpDlPT63ZnDnKSPv2IpG5HppKDqwA8pAdf7+3g9PQQYNbOl1X9rmrK8esJlLsj3jRt4zIarvO2tpNsMX7i7B9vxRsDUFRgSRvT05TWlGBw6v+6Pqj5zVj3CRfNsMdDfWmsRcJBUcKT0sBTNZN6KbSMgp9YDcTP7gzvHng2uN30FWR3bzy3P2cU0mRtSRgd3OIcOcUiPWVcn+YruqtJKpkELsnEQ9Nk/9SRBxZynCLJGUzcosrNArgorR7xmZsG4vGsGyZwkmlmwYruFOPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpTtHeYeb3UGNc8TuDkEmBmo8Y8uu56jUK8PAQ4JxwI=;
 b=GVItokPNgSbaTTwW7jHjYeL4jBVhKQGinDPYst7A//cuIulfvKGflhcetA9hN5mr9A05Vl9KP2/iE2DC1V9QfFPtMhCJBNK+KDDPn7r0ukEBm+tUu3Ai91DiYbmXncmtJoA5Dm5sUJIvnzZ2sZiwmobgu9vLzrEdLNZOlLS3Oy4tA89JrS9jtrwqJdnUHfn5tPYNsXjTkRAzPAIXSz4JcqySaI4MRrdkqpMja6UKXZbdIZNrbnvHBSrOWIo4OvNd2HiLGacNQQLR0k4CYPvNi3RuUHcXX03FdLZ3doyQ9N7fxZAun8ScVi9Z/Bxed2wa2nNGlUB6vLxewxZi9iU1qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpTtHeYeb3UGNc8TuDkEmBmo8Y8uu56jUK8PAQ4JxwI=;
 b=oiztp56Q7miumJmjXIwsjD5gZXQRYdRTmYZVunF6VR80x+zH/eOwfFEPGcPo8hIMEk61wm787KuimcFU0VKPpl0W8ze+C3Rnx90sAJgBJPsorxQwR1zCBn96H+/DMMa4B+V8aiDkvKKhPM4EHZM2saHiT/MuNw7HI1YNrg2REF8=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH3PPF9212BFFB8.namprd10.prod.outlook.com (2603:10b6:518:1::7b8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 22 May
 2026 08:03:56 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 08:03:56 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "j6t@kdbg.org" <j6t@kdbg.org>, "gitster@pobox.com" <gitster@pobox.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
CC: "git@vger.kernel.org" <git@vger.kernel.org>,
        "code@khaugsbakk.name"
	<code@khaugsbakk.name>,
        "newren@gmail.com" <newren@gmail.com>, "ps@pks.im"
	<ps@pks.im>
Subject: Re: [PATCH] compat/mingw: Allow SIGKILL to kill in mingw_kill.
Thread-Topic: [PATCH] compat/mingw: Allow SIGKILL to kill in mingw_kill.
Thread-Index: AQHc6cGJatvyU10g80emrHfYCaEOGg==
Date: Fri, 22 May 2026 08:03:56 +0000
Message-ID: <0b5d9c3c81a4ca078ea5d05d3ac9f6fa2aaafa28.camel@oracle.com>
References: <20260522061652.50078-1-siddh.raman.pant@oracle.com>
		 <xmqqwlwwt0mj.fsf@gitster.g>
In-Reply-To: <xmqqwlwwt0mj.fsf@gitster.g>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|PH3PPF9212BFFB8:EE_
x-ms-office365-filtering-correlation-id: d86d8e97-4920-4b9e-68d3-08deb7d8ac32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|6049299003|1800799024|10070799003|366016|38070700021|5023799004|4143699003|56012099003|22082099003|18002099003|4053099003;
x-microsoft-antispam-message-info:
 Ei4HCBeqZK9dDd8S7QjGwM4oG9+PP5Jc/HItrmpAViE+3c9yZKY/BmoVugOdoXWkBiWOutBDQvGSC9T0eTS6QB0ZWu52iOFghLVOuzfBAWwzPp4fblYOnMR6W/fp4SG0K21dtEg79q5VylAKlGwiurNqaP6pDoSor4MUSDyKxsokN4m+ODmwJeVZ6J7BRIbgHWflAguzqW51C60x2fa3IG2dBREJm5NsvsiGoQLyRKHlM+NjPvKPUjX9DNJ3J14eDqmVjhFEdgc+8NHOCxai/fvJeQu5C3Bz+a3lKLZb9rQiDaaQv6pDh7SqOrBADikf5mbQVvr942rhLfzaQjWTBiYWf0CqW9j5dUVPu+0eq53YfNIUz+6sKxONEET1id1dNP+1usSLt72UHfKXJPmM4Rhrnv5ofFC1KMNOz3HVkJG0XJP5IY96mWpzHLgVeTO3j0uLVAF9zvwFW09Q5qn09I+gSweYo+CiXSHpSlmDe8DuLaotChElExlWsjtwe/k6zVGpUKD2UUZK0JuwxYEnRx3ZEvbacaMGeWIUd5xCF4idq43l4+e71IBkzvmPFUQAJJksbJVQTtj8+/z2v3IjxPwpy1NBr5HDCLN0pDGTZVKDWvVesbIaEYDq8W+OdAvAHCvZOgKRJid8AoVQuZpvaTKklzAGL8PRb4yiyrIpzI6buyotSV0qoaG0laARorSSRBs4HrdK4HHzLllSf8VlOSHt+QQ9hf0pg+5DqbChz61gGPdA9v2uSuaX02cqTihsTETtuookjIi2FGpqSFYmZw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(6049299003)(1800799024)(10070799003)(366016)(38070700021)(5023799004)(4143699003)(56012099003)(22082099003)(18002099003)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2p0NDlyRmsyNFcwNUlSUkZmTnhqZXVJam4veldyL04rSDRIT2hQOC9XM3M4?=
 =?utf-8?B?dnNpaHN1M1hnTDFxbWFWL3BrVzJJaHUwSEJCcnptZ0tCYXhzYkJncE9LbmVu?=
 =?utf-8?B?eE1mc3hIem52bG42K0t5M1VRMmhhbW5CT3B1WWxpUnl0cUdGTXkwemNEV0Jy?=
 =?utf-8?B?U2MvcFNWblRza0VYS3N4ZGFidGpCaU43RzFuRG9JdERHeDNJU3JKd05IWUlE?=
 =?utf-8?B?MUxCR3ZmQ0gwdFoxcU9DQXFEWHQwUlNnYjcvSytSVzNXcGJCNVJGK2xkRVFh?=
 =?utf-8?B?UXU4azZGWDhYeW5YbUZLUGRYSlZRZ1dmZ3lGMmJSVGNvR01aOGt0MUNlSkQ5?=
 =?utf-8?B?UktlaXU2Mlo2SC9SK2pTVHFXSmRjQmE5Tnk4WHYzelZteExGTVdlL3NBYzBa?=
 =?utf-8?B?MTk5NUx5ZFRLeXkrcjVVV0JmYXQ5YUVzMnBySTNjY1QrWnlxZjlnZ25BRmRD?=
 =?utf-8?B?aEZ4SzM3S1pHc3VwOWN3V1ZPOXZReXluQit1NXJnS2dYUndyV3hWZjcyREpl?=
 =?utf-8?B?QkptbXdqeEszTWE0L2VTVFRoekwvLzRvcUhBZHhtS09veWJlemUxWTdtUWx2?=
 =?utf-8?B?TW5WdW1KN3JRTDRCN01ZV2ZxZXNoVHVmdmxkZTlLbmhXcWtFbzVGOHRvVnhz?=
 =?utf-8?B?d2lBaitZL2w4dHFNY1FIbnB6N3Avc3JFSTZLT2wveUtSd056eEJZWWpZbmVO?=
 =?utf-8?B?bUxBN2NuMU5jcUovYjlhQXRmbDVqaUd2SGc5cEt3anBrQnNOL3BSREZQZ3R5?=
 =?utf-8?B?L3hCYVRVSDdmOTc2dXRGN3E3QzBJeVJFRllZNS9BSkNjS2FVcEdmU3R3c0xn?=
 =?utf-8?B?bXg0ZkNLRTJrR1p4S1IvT2NlS1lXTjVnK0VRWDJaTzBsdFZlM3dJNVlHWXZ5?=
 =?utf-8?B?M3kyaC8zMmpEY0sxbnhVQzRjQi9KclJETGNKNDFONnZkZGxIaDI5ay9qc0tR?=
 =?utf-8?B?TUJzakVhUWczakxFdTlyM1dsQmtXeExyczc5ZkxPQitaMm5iNkVQa245RVRW?=
 =?utf-8?B?WFdyU0k4K3hXN3RMMHpEVjFLSG9iWWpwRzdGU3kxTlhvQkg2VWxCUHB3SEt5?=
 =?utf-8?B?dW1EUjE2SmhkYXFuYWxKNGdUUjZBS1RQaGJNYW9ZSFNlTDdjWUIwMTJMdFEy?=
 =?utf-8?B?MGxNZ0xOUVlMa2ZsaFNmYWJIVFRNMFhmQlNEaDl2N3pQdGM5aW1ldnJxOG1O?=
 =?utf-8?B?UnFFRlJWVFkzVU5QN2YwM2VJRDVsRUF0aVNTOGJDWDhlSnVvaUlXR3RwRzdz?=
 =?utf-8?B?cU1xT3NHaDJMNXorRzd4b3hRSVQweVllY0pkMEE4VWp3YkIza2tOekIxOEFQ?=
 =?utf-8?B?ajJ3YzV3ZVNndXhDbm1aWEhkMEEwWGFQcFRFQ1J1UmkyMmlBdHNMT1B3VFBp?=
 =?utf-8?B?eUNkMU5vSXpXVDBTcFVlcWgvVnpBRFU5U0NRbDcvbmc3V3BnY09BZ3RIWWts?=
 =?utf-8?B?Ni8yUC9hNVJnUVMySXNkbkJVbGNMWENValhlcmNqaHk0dmVUbElMUHc2Mm0r?=
 =?utf-8?B?SWlHSkxscmYyS2podzlqSFljZjRxMmN4emJTK1ZCTTZjYXFrN0txMVRuV2Q2?=
 =?utf-8?B?ZFdqWXdFRTVHdFo2ZndkbmhCLytoUUNoVXZtdnpTMFdjY3hPaHBjMjUzZEtV?=
 =?utf-8?B?TzByWFdYN3JraWx1czlwOU9memJXenV6aGI2WkphbzgxK3lacm9yZmNqS0p3?=
 =?utf-8?B?MFJOb2c3Wk9ib21kYzJhQ1NNc2E3NS9nR1pSK2ZJdWppRm1yaXc2M0VkUWd1?=
 =?utf-8?B?dUIrQ3pWeDZTbTIrNFg3RVU0WkNQN0RzMVNRdGpUMTFvQkw1YlJRTjlpRHVt?=
 =?utf-8?B?ekdWZlU2elloUER5WW5NMWt1MXlTekJ1c0c0UkNHTElxYlZyWFlrclMrK3BS?=
 =?utf-8?B?Vm1XR2ZTa09Gc0tsWnBjblJ2SG9XZllmNWNpOExnRkREalZnL3lRajNuK3hH?=
 =?utf-8?B?aGVSYWkybW44aWh2ZGF4YmttUlV6VW1aYk9vWnIyaUpSMUFKZTJzY2tHTDNF?=
 =?utf-8?B?RXg4Z0tJWFRJVE1aOWRsM0hHc0VDbXZsbjVQUTBCbzkvZ0EyUDd4ZG5DMGxI?=
 =?utf-8?B?R3I0VE1neXlFbXBPN3RVYWp6cDdRZFRSL05pQjRJZllJcVdKNXVGY1BLM09E?=
 =?utf-8?B?Q3ZmWjRzU2FyWldhODh1ZXBFUGRWbi9QeDd1ZVBSZHNFcDIybkZkSHd2eDV5?=
 =?utf-8?B?a3NwdWgySkVIR2pNWTZPekV4WGZSVC9EK05MeGtvU3pjSTZvdlVwdEFreFF1?=
 =?utf-8?B?TDI1dGZ2dW1WcklxbEhpaGpYeHVCQk96czVmWS9oT1FYSm9ZR1ZUS01YV252?=
 =?utf-8?B?Q2M3ZVM1dnk4cHRBZC9CdmlPcVZmMlA4VFlkZGsyNGY5Mi9HTzNTWW5zQjcr?=
 =?utf-8?Q?4PX0RXXnNw0Yv74JYY9JkpnJTN6RGxL882rYaeMotthEu?=
x-ms-exchange-antispam-messagedata-1: VirXZrj4P95Y4WDqR8/HVKu7YRhgwDo4KRI=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-5+sbxfPXQt1W5NPBVWU5"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Al721PfBSSVOqP63sgoiUgI6t3/d+cPfgOEYk9RchiqN6m0WQ26KbjM6gpvOby6WG0x/zaKCfAxaAsYHMW1qKY38zvRNJoeahQanQFZbbii/+ixuIPnSqtCGhTzViwS+94gQ8IU932xr1rpuH6pIajfT7YbJdLsFGZ2GndrAKrYOG0qtX3IX3Xh35EUXlJAAftcRj9u/pO3ee0MUG8TgnMXqk9A7YNH66xV4E80rh8vzj8+G6WHy1ATC1PzhTIu5c4f5KMymUfxG+QLcVu0tR5GCVKYWG+ckUNV3JvpEULk8r9V+LLbSvcIszNuPHLZHuwDaflbQH/d1WE+pOwU8bQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YZEbSXDQf3kFdF7HTQARR6aPIfH+flcItEEl2VoumLu34oEg4uD0PDBnDtk619UYaK9b4v702N5M2mS+XuAtiTGGoYhiZplXhG8FRvvpeN2Z5DTq6PRDOB2fwLVNZDEpShvFkHVO3irZ6vvp1QetTBRBU/frh01iFD3yAN1l8ibIJAw2X4IqQDpaFi86Uihu+VdQoB6ro6djo9DHJCOVlxrs/wEv1f9IA8ZHKG3r1rdqVi4/tMS8Uvt8CC38xZt9larDQEx0Hs4Ed9U6yvktKOU4efEbm4IzHIU+rX7ME+QyHXiKv/4Vsrj2APQnBCvssH5ftTYXrOZjEW0fEwtGuAJR0jASoFwg/GIfEXpzKeLyahmUGYuDVeGqsiA11Z2M/oaSyuvloE7et6CERtrpV47lIz1uXd1NmMWUPwYSmzxJzW7khv3JLXUuJ/KJZmtvju6r3sIGhdmSgOZazVSR8FJjr6+5eYsorJ0d6Eq2oIe/g03qu5HP9iMRocEC+Szu4Dm2EBPLeCXnS9Ivf5HweODPwyeCQfB8ipkjLGBAljDLVX85R/ecubIeqE7/kjq8ywV7jwyLZAAo3zy5Q2a9srSS4CgIWhWsGy36zdejLiE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86d8e97-4920-4b9e-68d3-08deb7d8ac32
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 08:03:56.2559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F79B6IV+ZnLJXa4k+FSIzrOUFWWhS43ObtLM2A1kwv36oFqc1V7PlYVmmz6jwqYKj6l1xTw3Eg+vNdY62GixPnP9rV6aazd+d7O6m+jjXvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF9212BFFB8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605220078
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA3OSBTYWx0ZWRfX0h8SENGqw6dr
 CAETWoDyJ6iYJ0bQNYNZbQLzuseBOsa4d7WCaM1PgrGfYdAf/X8uo8PTFsJkxT4nZd+tMSoLhUw
 +m3dKZ2JhjfLu7au4163PETnarpqOUGXlc5Kw646Yj0qGPZ4Irq35E2/OXugCBhjIi63gkDv1pJ
 vOobWPHDT3Bq8aM88Zs0XycNqMuAj+U4QIDwWAPBKH/pZfbOtUC/XthU1fJ13jw8TESsl4SprH/
 prbsPWf/R1JVgSc/q1AnSN0k0tQ86MjabR9wuuumME3nbh44G4J3/MpDvVwckKMJ8uwfZVInUhK
 pf7UsghHBccUCtH96foJBF8E72l78s3MyuAFfVjDRV9G46AtGhOe5UWYJdMf7HFxTW/w05sE53Q
 xGUcpUN0g2/AHCDIhfJJieEadTc34+dekNiZXWxUwSy07AjAe22TERjS7E5tXGV9swDXBn72cJJ
 w+6vBezoBnqeQXJH610/07KiHGoIj13SnI344vpc=
X-Proofpoint-ORIG-GUID: 2utjuuDpQcdixf3XUJfSfhTSIVHJf-xA
X-Authority-Analysis: v=2.4 cv=dc6wG3Xe c=1 sm=1 tr=0 ts=6a100df1 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22
 a=yMhMjlubAAAA:8 a=pnX5vi2y6lk6Mu_92hgA:9 a=QEXdDO2ut3YA:10
 a=2oWRWPYD00_ieuJCkZ0A:9 a=FfaGCDsud1wA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12298
X-Proofpoint-GUID: 2utjuuDpQcdixf3XUJfSfhTSIVHJf-xA

--=-5+sbxfPXQt1W5NPBVWU5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22 2026 at 12:02:52 +0530, Junio C Hamano wrote:
> I do not do windows, so I'd like to ask those much more clueful than
> I am to see if they see any downsides.
>=20
> The current code only handles TERM (to terminate) or 0 (to probe)
> and everything else results in EINVAL, so the updated behaviour is
> to pretend as if TERM is sent and do whatever PROCESS_TERMINATE
> does, instead of doing nothing and erroring with EINVAL.  Which does
> sound like an improvement over the status quo.
>=20
> What I am wondering is if there are different kind of "kill" in the
> Windows land, just like there are distinction between TERM and KILL.
> For example, the program ought to be able to block TERM but not
> KILL.  There are other termination-inducing signals like SIGQUIT but
> until we start using them in our code, this emulation layer does not
> have to know about them, I think.

=46rom what I can see from the docs, there is no SIGTERM on Windows
either. So I did this change since the SIGTERM handling just looks
like a compatibility change in our code.

The docs at [1] says:
	The SIGILL and SIGTERM signals aren't generated under Windows.
	They're included for ANSI compatibility. Therefore, you can set
	signal handlers for these signals by using signal, and you can
	also explicitly generate these signals by calling raise.

Our helper uses TerminateProcess(). The docs at [2] says:
	The TerminateProcess function is used to unconditionally cause
	a process to exit.
	[...]
	A process cannot prevent itself from being terminated.

which is like SIGKILL.

So currently SIGTERM on Windows is behaving like a SIGKILL.

Thanks,
Siddh

[1] https://learn.microsoft.com/en-us/cpp/c-runtime-library/reference/signa=
l
[2] https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/n=
f-processthreadsapi-terminateprocess

--=-5+sbxfPXQt1W5NPBVWU5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmoQDeYACgkQBwq/MEwk
8ipH3BAAimWC15VTBILcRFCmBj5F4AqbAUJN+lA7WfGh1dnPvTsjBnpqnxSkWLcC
WH5pWQ49+wv9zFV5GLlVYH+/9FbyO72v0aeyrpbNdkcsB3JuDVjjMQOYctJNolHl
uhja9fyCE+emK6xhf/NMsmfanznf8kaM5jioYi4yvk28fFagHgHs1betul8E9SKZ
fU9QMFgbF6IJKSB4hGCw1vdxgvW5GwbVvtpE7hcun3FXVdHV02gAat4ith82cLV5
8DpGm4LV1HRz3dI/95QjIZ936EZ9FhZ6QbnjdYGpOBxByw2/mlSX+m5Tc7MT5yGA
NNb1MwunRCbtSW8Y6iprwxzH0MwF1tCxzUwDzm6U3kXiFMQLq73ky70kuq7OGLzM
Fx/csvKsbSH3UKk26lpMUhwLq0pQBBK6/6oPo7t3KqQ0yZxwsBm7WBqNRsS77efI
7T2XndacPxPzwM76F7I1PNotdEuWeUAcKCN22bONlFgi6rSO8Ml7dVa2JZHlqRqz
e1PWkC5L1kS7BhT95pfYczfjdi3rXQQ2KkCtGENjqRDUJwyUXABpzIaJEqj1c/Q7
FhpVhdU0s1X6DvkNgkxwe+hWlrWNwUsc15bc7ioVzTo5qMvOvOsdc84ReYRQ+2gd
mV8LfVK/+/de4nDigO3rx79do7TD7qrVo2G1ZAexCQ99tKUx1H0=
=0v96
-----END PGP SIGNATURE-----

--=-5+sbxfPXQt1W5NPBVWU5--
