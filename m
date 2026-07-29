Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF74411F82
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319143; cv=fail; b=C4cnAJn2z8TqAEYE0FcZACfJqz/LNNLNEmbmk8voXDlrzG7EbbcqGinIe9v7NP63ahiz5HxI9dP8bQOJPOeriimWBZgygo2P4Fl2RnqY7eR8jY5pRnu2/21hGp2gQD7UTg1WdnS3IJHNfMv3lwAd8kcejf8f0MqMsCijUbNqBV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319143; c=relaxed/simple;
	bh=WnjyHq4wui932P7xPAqVbF5fICBcvJvpTMSeRI/63S0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fgRxo5K2JMZmup34rbjZPvr3gOW6eLZouj2zQqxIwVB/EHwDaDgU3h3BaW8f84KefbHrFVqj4kz8pZh+gMqqP3/X8LzYnqXxggnCsvmmujOLsMBTO9AUI6T/pmuynKqL3E+1xA8/m446mqvEQytO6UOzNPZ7/R9CsA48O/nm2iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KDrbwhaI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qi0e+fuD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KDrbwhaI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qi0e+fuD"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T9rlZ11094298;
	Wed, 29 Jul 2026 09:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=WnjyHq4wui932P7xPA
	qVbF5fICBcvJvpTMSeRI/63S0=; b=KDrbwhaIS/I0+AEWawYvokvVU624a4qflG
	Q4rDpvetL106HrIrpRoLgscdMvSitgYbRkKXDwWn55Gb3o9ljMuFyJ7HU42Hej2h
	1P05Inp6R+4JkX4wdN8lREQVWmIspmSAhH6dm4Hei0PwcDXt4dCB0vyy/B/XRmXB
	zIXOiE5dtl6hP7VJvxu7FibbIrVPDSQXO3l/cmd3fJDoxdPxGCOx/0IsCRWYsrps
	xCdRhSYNX2JtruxmCcHwh/w+e/WuJM9xlwZcDHeGM/XckgOOpWVH94nOkymOFpRB
	mvylefsTOTbht7DOOBYNqkULtLZvBqDgJ4wiRZUI/ffp4AUPBK3g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmqym5h6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 09:58:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66T9tiSZ017939;
	Wed, 29 Jul 2026 09:58:43 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010067.outbound.protection.outlook.com [52.101.193.67])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fnh8jkec6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 Jul 2026 09:58:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkfxmsqiB0Ip2oC8Q4FWOl1hIMsHnw9oyq9n53nTsD9Nf64xW0nRVntpbrM3ApSj9qpgOKBxDD1fbaj+/PDdBqiKklDaIzh1eiqxcB7jyBSjoscazEN8I8fyq/La16CO0CyX+RYpfPMtdN1L6gsUPM2c58WIp4kSvJULINJQtOBuGHjPFhL/YUWy7xPw07WYKjFmMaAaCJMxeQC/AlNF3P1Q3lBYkBQYK+oN7YKAZqvy6YvdFiGLYpwkpy0h39Vj9PHWmRzZzLwuqzFZfA+2rXWhxhkIS1AS1F0wivzDP7UHV93B1UypgEgWVeyTeRvRtI/mcarBkA8o3aFgQzO6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnjyHq4wui932P7xPAqVbF5fICBcvJvpTMSeRI/63S0=;
 b=AVfhDZOPSX1VThw0Tg+GfhwF37aK1yOt2O8rMLNdGY01EgEeZlxMOqc+BgXKPEjrM5iM4nLpPCpAPDkEd68Vqbw0XZcvlrm7/U1ptTjBUcniaFYnh41z72uMsxpBEWHYXrZGXvl5YBzWm4U0Io1YnuKVEyYDa3tbWEvJDZxbkhptFDIEZsDfFjI/7Dvt+js73K2kdbKFIwaqZQ4COUj7bWzF5Jh9JC5utE3tNwlmT5uqMFS0/dZKNF0FJPavLXflKCSKxlzn0w/NUGNx+zIrvU3PhPVxrrmL1gC4BZXq27rYtkVZvEdsC+SS5MSj4LlQxvWkG926llxMIlXN9EiPUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnjyHq4wui932P7xPAqVbF5fICBcvJvpTMSeRI/63S0=;
 b=Qi0e+fuDxDhgnHnaXvyG2mMACQkJ++jLREV2VwpvaBILHHpX2oIWkNFcmS6uvRT1agVzoGaAsckbr9qZP2WjeA6MATOf3qN8x17xDyfknYSCdKlO8KaqVsB/CVQxTABZlg3CyhZlutfCf1EHHI4pcE6gFFln9qktLSsSZfkZjtY=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS0PR10MB7089.namprd10.prod.outlook.com (2603:10b6:8:142::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.12; Wed, 29 Jul 2026 09:58:40 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 09:58:39 +0000
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
Subject: Re: [PATCH v3 4/4] notes: support an external command to display
 notes
Thread-Topic: [PATCH v3 4/4] notes: support an external command to display
 notes
Thread-Index: AQHdA79PzBPlUtUocUSnOOEhBtTP57ZlH5GAgB9aiQA=
Date: Wed, 29 Jul 2026 09:58:39 +0000
Message-ID: <60e92e7331e64d13eff2aabd91fe8baf3a761ef7.camel@oracle.com>
References: <cover.1779532562.git.siddh.raman.pant@oracle.com>
					 <7284a8bccb6bfb5734adb09f05ae4b61a63da2df.1779532562.git.siddh.raman.pant@oracle.com>
					 <3a2ba6c0-4ced-4d2c-820e-401c2dff1dd1@kdbg.org>
		 <76cc093d2835a7b3ed110e20f1480dbe5fc2ecbb.camel@oracle.com>
	 <65e2e9f6f30b74725ca4516424e8d7116383e368.camel@oracle.com>
In-Reply-To: <65e2e9f6f30b74725ca4516424e8d7116383e368.camel@oracle.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|DS0PR10MB7089:EE_
x-ms-office365-filtering-correlation-id: c2b9dc6b-d658-409d-8edc-08deed57f73e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|6049299003|10070799003|23010399003|376014|366016|10067099003|56012099006|4143699003|22082099003|18002099003|4053099003|38070700021;
x-microsoft-antispam-message-info:
 1zdT9ou98WWwUuAMN9h5Q4YgHhZatr2hhMBu/+z4hiqave+VjuEOxzKxNpq5BxB5tNqDQCnINICzTzrFrxY33jN+HXvVluhqfUs8R1PAV73QCjCfevEpvHSNIk5p6KNgBTVKmKxSJyvmmHgH4gCRV5b+fP87edwLcvmkPZobaWdxLlR040D5fLNiWfX8shLYqo6DEHgorKK5aIyi9TVp+zuLjne+wj0IRuOC5ORybrkxAAtOGA9dXmdsAFyBOQjOQ+wu0As2L6eP564/1o/DqZzZB687jb0ivMb5vVOz+Jx1Yav8JCZS/hxfYz55eXs5nZRJxXNCqZBD6mdeRnZFnEuBybSZOaWbUyqPO1V70P7ChLKFo/Upp8/nfX0rFNiJ+xbI9K5r/e2I99PCY1ma47FV4452E6KMy20+0gV1S0pMlgP0K4qwQSIyWPyqKjKjas0sIXks0sAtCkQInBThNycopYub9Ns0Z3n+TIP8I4R0MHn7pgYj/8L7bbJxbpZOhYJtK9q0UeObCOq6VL4LdOCWAgtbLMu8jq3V81+qsgiMZw4bubxPIcTAlBE/hpprfSfWg4nZskG3t+AZHA3b/ZBbzNjD6UoTDLuoSrpTgt0VHpMI3PoF4oQlhWFqHuubFeTMVjEgjms+vQ4yx25YSDCKB6QZ2A7p4r+8usxjcp+3LqDHLp1+MrcDUkwtQ5Z0JzXPWT6ZG3WHpd74Bxatw9hRIB21XH6Pj9MjCnk0N2o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(6049299003)(10070799003)(23010399003)(376014)(366016)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(4053099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azF3TU4yeDdac1dyN0NWUGI4RjJvSHVqY294QXFDVlZodHFUY0crUmowZlNx?=
 =?utf-8?B?a2dPSmIzSHFzQzIvbmNnUjRtRzNLQzB3ZGRwY1A0VFpRYU5hZHd6MnQzOXZ5?=
 =?utf-8?B?Z1VpWEFzUitpS0RFc2JLdUJTSFhXdHRqZnBzNEJxeWE5VHBsQmd6ekF1WXpi?=
 =?utf-8?B?TjdyNldON1dHc3FZd2V0RXRvdjVyWkV3WmJ5RFB3TWlacWZsRWNlNzM5c2dt?=
 =?utf-8?B?RXVkRkxPdDM3cUlMTlR1ZXRDa1ladlFlYUpLZTJPbkhGQXlGcFl4dXhWNFN3?=
 =?utf-8?B?M3NnK1BsUzE2V0NaTWp4Z3p2d1ZOdklDSHljUGNYWE4wNGtERnptOGtoVnU5?=
 =?utf-8?B?ZGVDYTlBaEZlSlJmdkR5c0h2ZjBaRjJXUWdWWUxrakRQN2VmcVhmcEJUZGt2?=
 =?utf-8?B?RHFaVjBuN3FBZGRCZUV1Zzg0Qm5HakljUlRBVURtemN2bzRGZlRRbERNUVZY?=
 =?utf-8?B?Z3Mxc1JuNGtWc1lYK05jbFJYMFo2SnN5YWZaV0Ftdk5VbmJNUWpwNGlON1dW?=
 =?utf-8?B?VzhKWXo1dVUycTFDZXdYTGQya0ZObVJJVVNLUEEzb2RuM0p2eGUvQVdVYmhF?=
 =?utf-8?B?Mi80L212eE5YclpjOW5XRGtQVFV2QWw3MWtSQk5LNDZrSzlCL0JYR1k0b0xn?=
 =?utf-8?B?ZitHaGhZbnJNV1RidFBWdkJPaEhOYi9QYlBwbW1WU3hHbWFndkVhZGprQzhH?=
 =?utf-8?B?K3hXWVprUDVlVFFlZytNckY2Tk1YampMeDJZYWpLMkxQcWNyU1RXVm1RQksx?=
 =?utf-8?B?ZDAyaDBZMVlFWE41anRpMFAxMmJ4b25VcTA4WFlaTzZKVjlDNDJ2OWJjbGRZ?=
 =?utf-8?B?aWxSSDR2bXIxQ1VGTzV3Qktjd0pwQ2ZJQm1zRENudW9jUmh4YzRDaXdWdlJH?=
 =?utf-8?B?cnczUGY3MUF3WmxpYTI3NDhLZGJ6eTdZejdkendFbU5BYlZxS3RTM2ZwcExa?=
 =?utf-8?B?ekhxblJIUUVnSi9nSDdBZU8wc2xueVVVRlEwdkZxcWZDVVJJUjRReXg5Z1dp?=
 =?utf-8?B?YUxRRmlnUWpJSE9sK0wxV0hVWDl2VlVvZnlkZE5xZVlIeG5uTFNkaWdZdm5x?=
 =?utf-8?B?SXBXOFM2QWViNXBhS21kOHgxZ1laaFVDc2czMGRNdTdkc3JNNUVUQ0ZFazAy?=
 =?utf-8?B?Zjd5N1IrSWpRRUhqN2ZjZXNqWFM3L0dVaTNHbEYxZUFMby9zazZObS9NOTN5?=
 =?utf-8?B?d3duckFMcXovdkhlVUpBaE0rRmhGeWZTMkJWSHp1azdjN1BsVU5ENkh0K2hv?=
 =?utf-8?B?d2FScFEvZlZoclFYVXJqbVVuWUIzdncxMmxJc3ZvdGxuYjhkSnpIMGJSb2l0?=
 =?utf-8?B?K0J3di9wOW5rQXNLMkFiR2N6bkR4a2JEcSt4MkdoVUJ1UzZFb0pqNmcwbllC?=
 =?utf-8?B?bkVpcXZzY0d4dm01dTUxT1Q1c09za3M2UWRFWktyOFlvQW56S1VSdXNOWWlQ?=
 =?utf-8?B?TmE3T1ljeGdoU3lGaHpQQlErOThWZlFpNHZuTVdtTUVhN0dVL0VqOVFSOUov?=
 =?utf-8?B?Q05JUUtRbVpBdGhpWmZUSFJ6bDZINktXWmMzZVFNZXRYNk0zclY2djVjSnRr?=
 =?utf-8?B?eUhUZWMrMHArbFNTa2FLR0ZONkV4Q3lUMjdZczMzQStQOExBaWR4Skh2TUdl?=
 =?utf-8?B?N3QzemM1ekM2YWphR1BZd3N3SEFJZlJzb2tSQWg5WHFITGtkY09jU2ZYd3k4?=
 =?utf-8?B?U1hXU09rSU1jNEduWTlUNEREMW1HaHdpeTM1RnZvQkVyRUk0NUNFSnNJL0xP?=
 =?utf-8?B?WlAvckR5UTYvenRBaWs3NmU1Y3hCTnAyd0dLSEoyVllJb3dVRCtqS1o0NlFP?=
 =?utf-8?B?RFp4QWV2OGxPekFkSmprelZSYU42eGtsdXZ0dkNiNzBLUS8rSmNyQXBPaFNR?=
 =?utf-8?B?YmdSbGdlcEI5TXpnN3VEZVFzaDZsK1ByVHRJQTNqOW1JRnlFMU05TmN3Wk1D?=
 =?utf-8?B?SGlWWS9TUEVYUDA4VC9pZGNpZ2pkVTFlUXRmSm5NLzRGaTgrMFZ5ZGZQSk5m?=
 =?utf-8?B?TDg3cTNvVHdMVXlKS2dKd3lrdzl3T2p0cktLWFd4QjYrUnkrTjc5cUc3ai83?=
 =?utf-8?B?ZXJkd3E4Y0xCSHlHeWZuYkZNN2pjZTM1QVppcENlN0Z0RG5odFhFYTVJOEZm?=
 =?utf-8?B?V0FYb0VCbTBhS2hUOW5FOUlSUUhGNXduaVBTWXNtTXdiV1FWMU1JT2NwM0lQ?=
 =?utf-8?B?SnE5ejRkQWdvT3ZKZjFDNXVWNFFYSnFsUEJoQXlhZi8yWTc1VWJyZ3ZRdHhz?=
 =?utf-8?B?WnR0eC9ic3VybjJTaUV6SVRKT3V3QWJXNDdwcG5CbisrbjdPVnJvK3cvc0Vh?=
 =?utf-8?B?S3dUaUhmaVJoN2RFWjZxTG4reTFkais4QmticVRxUy9ZK2NnaXRmY2QzK3A5?=
 =?utf-8?Q?Na0lEvUuIP1+9VyGx7QayzoMnyFaayf/amoLMeDINoqHc?=
x-ms-exchange-antispam-messagedata-1: A7X+m9ooxxUepg2O7Gvu3/mW1bQeBY5zGlc=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-L3jQUsNKcfw/ic3DEbFq"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	LiZuUSCX8X+FpeRDjm6am0Q6oFoxg7pcXbu7ZPRQF1G2koOyGJ75etW8+2lDnr/x/5gnBmaX1Kxr6lldIZf5xhL5jEzQYCgLe4tBrUBRdTGeRyw7x/m1R2HPEf5Lt8uzcsuwMBVcavZKWYKWbLCZJytnKoarRykGAkcH9VQz9+5DFIoWVHEBfGISwY0wfJGWPjpRfyorj6Cb/5PUYBF9N/WeOz3ntLhYwemhDu2oo6mNlOaPXwo0K1jLJ1C3GeHGwLL/3p5brK7fJw/quMxXJ6rWhI/oXz5uvLz4q2DjhICIWPy9yYNUz5FDQmpZiV9XjPHcoLHMwMXPnO5VBB+OHw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2wJJkhZvfjW+gF1SBi841aUKh2RWN5pPiVOD3RAmU41WA7pyfBV+cILF5ob26mrZP4Sm1cDXkAKIyrTqxdJEMJVeBMr1LB6U9GzZ8vx0iwYIEg0fD40Yd5xEXEBtj9qtdTQy+dlMdhVcDv744Ly7QOsjE218oSPmG7jHywmJJvFo7RBtIkOUQwTBiyLqVnso/fzuatstVz36/e4PEvF69tsaz/b1lTatTurcsgXvOFMeMW8rM7Bh8db4cHnqeeC/fEjcOjmnImz7YiODB3FcU+2LARuk/OuSTj8jOkwNRSoakCL7T1mKy/XYAGP6g/KwT98oxdCcDJIDKEo8R2Brtd4bzSpmcNXLjf0WSf2iU5KLSQXubppYUBwyTQgrvaFk+k3SQGenhxiUM1zK3xl40A3XHaOQuIA+qDoDZTBKAinFKckN76f+eAoccquZvEUvGD2x2y78Up0kII2cF1UlRoRxWfEZzc3afd9CxXSnbgnIWXuN0aZ6bp8W8HCJ1qnmp55+ITacwHiPEHVsCXqOh0v8ZL/8NSNMNYWqHWSV31mVRhRwtylugTu0kl5X2RmeQDASdFBF+0UCr7wjWv0z/esgYla6rV1Ekew0Mx/xGyQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b9dc6b-d658-409d-8edc-08deed57f73e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 09:58:39.9058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8oE+OmlNtIXuSenV1moqsZkEq+GOb/61tAYJV2zJPTjgfP7FTZEqQGXz9+YKNVgflDFDkxsksI2YwYF6NwSqP9mEIKOhYQ0OSzkrCCj0XE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607290081
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4MiBTYWx0ZWRfXzsL2B4q6rSz6
 6lnzlK30UkM3F1VYKNm53LE+ors3MU297UGhr1lFFeXPgSFU9tgLRVgAQQaZNZ55dAviuVWrTTB
 LNDjbztLOC3BfISL9kFW3//uhEHB9rSKPZq373/hNcnM5f2+q5/M
X-Proofpoint-ORIG-GUID: RgbWdw2htMbdnggsxbzPBgISpkCz89gm
X-Proofpoint-GUID: RgbWdw2htMbdnggsxbzPBgISpkCz89gm
X-Authority-Analysis: v=2.4 cv=UOrt2ify c=1 sm=1 tr=0 ts=6a69ced5 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22
 a=aD2PFzZxucPvgRz49JcA:9 a=QEXdDO2ut3YA:10 a=BqHg7QJ9xNwA:10
 a=5JwZHJQ4pVFduBucL0wA:9 a=FfaGCDsud1wA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4MiBTYWx0ZWRfX/MQeZrC3ELu/
 H042R2sS4+q2VmiNfeG5kQxkK01zx7+kBzS+T3pX4JwwYDfGsWHH4K5jBO2TUxE46ze66oPX4u2
 6ahXiIX5qwmI25czZzez+e4tSw5jz/S23pYKZ+IjR3Xb89Tw3EDDLVenspkf5DxPpzd8OKDKCB0
 bbr5q5SMAbTGZyoOeRHrleaUM1m3G+3VarK2vP0k7QVoySshiZgQzVW6w/5yk52ZrmEaqOTclsB
 bg5uckIjaC4ohJU1fyjHEhxuRA4llXKAn9KcM0eUXdhhIQo08YPsRiPc/LHij0J8G8eh3YYbDML
 Y8eQ0aWaW/p8XeWNAgbHrwobF6vwZJjvKIpo/vEF7w7zp9NShJfpZ69MaGwki87mypCAQTWoY01
 2I4uKHV2pnsjnzUkpmxofDmXhrkwYGtl4lUOG89NqHubyPfPBlWDwyYQD1jOUQMljLU7Zyr0SS/
 GFngf6FaeVs60mh/ShvLhvZKs9BniJHPe4T/xzRU=

--=-L3jQUsNKcfw/ic3DEbFq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09 2026 at 16:40:21 +0530, Siddh Raman Pant wrote:
> Going by no response, I assume this is NACK'd then?

Assuming a NACK then.

Would have preferred if maintainer was explicit about why.

--
Siddh

--=-L3jQUsNKcfw/ic3DEbFq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmppzsEACgkQBwq/MEwk
8ipwbA//alv3RVrO9tZI7ylSW7yT5Q4SqSVMSU5BCY1aU392YFzeg5oe9b72rkh2
OPJQ4INc+aIkTzJx/KnigLQyTd2+68nh6VWVZOxJX5BDP7U8C/2JF3I3E1CUdEs0
fM88Y2XzE7Bp5jZyPZOm4L+II12gnfpS9QJJa9N5vgU2TJbRolQZw+cAhoQgSfFa
ez1Dmkk7Lcv6F9ESQ8hC/RXs+KlJ7kcu4DktNySIlmw9uSo2SoVjoBY2pohxi9z4
jw1yr0+mhtpJGwMmRqrZHLPbhzTSg/d++4pnpSNHko9pz21nXbubo4iKUrVcwhpZ
8rLoIhmzyrS5hQ5EoHjst/a7ay32jHBuAcYSrpzzzqON04wQ1xqnshtglBstVgmh
qy8lkzCkIEgB7h3gLc1U9+lyp5SqFg0Zjm5Rk6Mj1mnLMPz4zZg8DA/pqTyIjsWS
ZsyZUXd2e6/dVyTatVxvlIheE7hcgx+rSwQEnV7VdiObbtAe7f5k/2uQOYv/6IW/
12DltAAK65be7Ic7nlb0Q0kG8B9Hivm9h6VJs8yd9cLXR8+6S7WSwolJzAQSouHD
RRT5c33U+w2pzyQjU9GmHb75ZJ+HEgrcQEgN6P6UQv7KIyskVugsWbiEovdt55oT
sU4pVbtjtNstcLAUrsvu9aG771M9xFboCRVXsBgVF2IXBt95aeQ=
=0j/p
-----END PGP SIGNATURE-----

--=-L3jQUsNKcfw/ic3DEbFq--
