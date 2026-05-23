Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2D925B0AA
	for <git@vger.kernel.org>; Sat, 23 May 2026 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779532401; cv=fail; b=eChHsFIGmMFRgp5Qf1HSl44PdextY/sq4ik6BUcqVyA8nmKBhJkDlE1M9hXK2B+ELxBVU3jxxhXWIk+pfk/DYedlNleWFCD6NJOrGlnMAFknrneOoO3q3QTX4sV89cYXMiWTsQZA+6B8Wf853Pk/NCdUBcknYCeyC4zwr8MlxvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779532401; c=relaxed/simple;
	bh=bzLOUVCAOfNnq8BcrzS2PmbqK/VztEDG7djwrUtzxsc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uEn4R0CI38repuwxZfdZcCyadpwB0Ss5utM5MUGnJIhO5xqzVB2EXqr1ZwG3CTMxzCOOj4iXOy2Togxxyra9qQbhZPEWP51GNBJSZHH5ez+s3ige9I/zTxrBZhMPRcckmv92bDpgIvnpmZ2XbnWcM+RkaeWq7J92kjbrrfX744M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KtyKmIOt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pyf9GKDt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KtyKmIOt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pyf9GKDt"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64N99ekB3617572;
	Sat, 23 May 2026 10:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=bzLOUVCAOfNnq8Bcrz
	S2PmbqK/VztEDG7djwrUtzxsc=; b=KtyKmIOt8aWLWdwbDUkASsmkUmxsAPg/z4
	TN1mKsdpL4Ay2MOJDrb7h1vsIjnEBkWSrX3fipnVqsRXbzbaunCGBsWk+Xw4AN5+
	ZorWVy4F2Rm4DZ4t2sAf8aZ7Ny9+Jf3E/9r6PSfHI+W6DR7TnzsJuIYROTu/pY5T
	0xGYnc3WTVRUsDQ7VNCwZdhBhgmQP0KSCjVG52Pc5kbmI5y7lG4Ct8i5Ik8xEU0U
	n09zfmL1ykMPYg4Q+tfmy8HNYmLlCgTP20cgHP4wD1wRL4Ol/En5YHjWw9DB42Bm
	ZHHUz9nebGRXgO2Butl5q7W+Nq7zx7gjGbCnM7ePTCmCqFlwkJpw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eb495g6qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 10:33:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64NAJkf5029241;
	Sat, 23 May 2026 10:33:03 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4eb2pcru5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 10:33:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChvtuHjkwcUldw8Kqodv1oytK9TV8O6qx7sbngeIfCM4bL0lolgektQfMu0wuCNt25d5k7a8xy83V7meOZ1fzX8Y1jtRjBN57wry1xE8Sdu8R71mx7ffCt4spJNEng1kq8qz1tyFq6SC/QzVUfyEK2Pt2yUOumcsf/V8fHQ0AqAnUt6kAXWnZuFudQViAErF/pK2iaxreaKFb7QZRGUyIDA6+K52m9I8EC2roO1y8ESXSqtN5nNhLNLvrAJA/H2bXtxU75j7J9JfJ6Zh7/I2nOnI73S/9pKjqz1B4I67Iyu3lQnfE6gDYbGV7TeOAZS2C4mgrALkBW6I5hQnMEg5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzLOUVCAOfNnq8BcrzS2PmbqK/VztEDG7djwrUtzxsc=;
 b=V23Xztl82DMsGqXQJqCJ9h3WOm7K57Trp7flOG4RVx6E/CINCT5KfAP1HnYtBjC8WsOJF8B+rShY4LIxO179sg3PE4dXZOEFXq7BAJ411chU2eW7eAlbQGZb223umrFJdWAUu2s8MRmzoO2wtJe/6sKocoTsOE8/u8bsTIG9ZeN/sYtEV6vMl6b7YVMIoIKU7smoHFsY5LXJbwbg4RDVerDqVNfuNKIzMQq0ajZMoIIErjjmOfLOfSeX9rz91fXQ2qpuSRrlEMfElmsOeyiuMC+k20M/WG8isiiGylGQlILK+VQ9LXkJ7Xm465/b3isKeZYN5kd1WHDKjtqZLZ+QPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzLOUVCAOfNnq8BcrzS2PmbqK/VztEDG7djwrUtzxsc=;
 b=pyf9GKDtvn39uBUmqgcfVDWhiSdH4MngDhRUXkHgz8dxLBmaHsoDhhLiYezP8fAtNlpdVSS+ICatrvdyLfMZln/jYSs8sHSdbCVMUHvdffGkNlOM8HY4mtR7R+TOe4IhRD0YcPbQo6EV0Ny8MJsj9PIXB233+gi2FCm5KGIOZkk=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 SN4PR10MB5573.namprd10.prod.outlook.com (2603:10b6:806:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 10:32:59 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 10:32:58 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: "oswald.buddenhagen@gmx.de" <oswald.buddenhagen@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "code@khaugsbakk.name"
	<code@khaugsbakk.name>,
        "j6t@kdbg.org" <j6t@kdbg.org>, "peff@peff.net"
	<peff@peff.net>,
        "newren@gmail.com" <newren@gmail.com>, "ps@pks.im"
	<ps@pks.im>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 4/4] notes: support an external command to display
 notes
Thread-Topic: [PATCH v2 4/4] notes: support an external command to display
 notes
Thread-Index: AQHc6gV0sMDDJSR+JkW1l/4UF50GW7Ybau6A
Date: Sat, 23 May 2026 10:32:58 +0000
Message-ID: <4b9f978d907b897fe8458116542decdcd10d1329.camel@oracle.com>
References: <cover.1779464886.git.siddh.raman.pant@oracle.com>
	 <1fb0666e0d950a06f605a5af4fe5555c9b1008d2.1779464886.git.siddh.raman.pant@oracle.com>
In-Reply-To:
 <1fb0666e0d950a06f605a5af4fe5555c9b1008d2.1779464886.git.siddh.raman.pant@oracle.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|SN4PR10MB5573:EE_
x-ms-office365-filtering-correlation-id: 4acfedae-b107-44b0-5994-08deb8b6a8b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|6049299003|1800799024|376014|366016|10070799003|4053099003|38070700021|22082099003|56012099003|18002099003|4143699003;
x-microsoft-antispam-message-info:
 9bgaFqzOTmorRTztOuQanEU7Lcdlrd9zlyBWegIkodHEdD2SAYuJmaYECaCmAiyHhcAf+fuVKP6EjfsS9MMOmunmJMYrrCANBdmmSrSMBgMCFGY0RT/zm+YIGmK/i8Tt2C8umqPI2/r+fg4EoAnPbj6GneIYehuWCRmcWhsyxCxkkAsDijGIG29uokd+cTFonqc/vq5KREdJGi8pACJ1FE6KOUB2huik2WacZqqeHBYU0BeaNN04+2PGVlT5clnrsdsBNrFPjCT/RbCCb+gXaaeiukjlKZfD7Ya4cl4sCmVKytJqt+RAVn2Rs6pnovaT04i//dVWioQZEvi6FJoacyqswDRhA5/qy26d1h4Bot7k1H0opBSZYHrmtgpRTj/Z9cQPxj3EOpGVykLSeuBe1+aoOSamMs6s3yW0ygrk4RPoTMhK+Jr+htSVLoki579kbY7DdNXyW/m3Y+wRtLJr7lprXoBrorBmbtXNyct2iwJ9zWONk47kw0+CLbhWTeMdLfggh3c7Rf97Bmro5ydIIx1hMmEzztAzogUM/cnEYg0anx2Vj4D5nlSu+V6P8PEaz93hxc5XJrMoAsKfFYm8byZtow9GpDTfap73kOuP8OxMLI03COv1VuVGdLs7AiiLp7Ryuoqt2rG5fXVyeI+EAeUTcU4vsL5f2ZXM9uDJE8H6wut12QLhbKY75Rit35UHv6vWsCPh3eal5eHXiNnRNHBag0I+STf5YEGHP4JJtlOySH1xXss7gSK4HQ8wtS/c
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(1800799024)(376014)(366016)(10070799003)(4053099003)(38070700021)(22082099003)(56012099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1ZyMWtBL3FMRjhRYkNVdkh2YjZxS3kxdDRLZlY5L2Q5YWZxbXgwK1Z4ZEV3?=
 =?utf-8?B?ckU2Tm1KdFZBWFhvRjVRb0NLSDBRNVJ1a3hxZWs3b0MyYXRseTBYUlVEQm1W?=
 =?utf-8?B?MXhJeWRCaVc1bzlkRDJhaUdqeDN0b093dnRyNEcwVlVOTW9TQStRRHFWcERR?=
 =?utf-8?B?d1dhMXgvMlpZdkNnbEppSktVRUdJVkphK3k3RFJscGNQRXFtUUl1c2tWUEFM?=
 =?utf-8?B?TTlkU1ArMHBkR25YaS9jZmwyZlZMcVBlV0dhVW1pYU9RdDNSK09zZ3Q1REdh?=
 =?utf-8?B?blFzT1FSak82RUdlZjZJQjNUKyt1VGY1T3ZRZWxuWDR0a1BkSmZBQm96ZW5j?=
 =?utf-8?B?WEsxSklWS2ZHMHYwb3BLb0tsY0pxYXkwd2hoUUNIWXBnOXJHeHZIek1vSHRV?=
 =?utf-8?B?UU1peEllRVQ1MzdKaWFDMWFBUU1SVm9QbER5VlduMnM4YmxsR0NPZk8rbnZh?=
 =?utf-8?B?OWg0RkljczgrbkFTS1pWSXM2L0wzbGRQNTZxN05uekIyYVU3U1dheC9SbHdo?=
 =?utf-8?B?ZFc5TFMwZ0daTjVsR0pibVpQcGpBL1RCWk9ZZmkrZDVYYWRyRGptYVhiOVBr?=
 =?utf-8?B?bGYwYlkrUXJCZi9BdEtkQUsyVFFoN2lyUnZWTkF0Z1Y5TEZNSXdxaHJrQlVv?=
 =?utf-8?B?TjJaTEgybkFSSXNQT1daQlNMR3pVdFYvN242Nld2NU02V1FLdzdzYzh3SE9u?=
 =?utf-8?B?bWJvS01RSnJPTDJFc3pVU01HREh4bmUyUmFJYUxVTHA1QTVVenM4QlRKdURV?=
 =?utf-8?B?UmN3bmtlYjZ5WU9DNk9QWFZoUytqS0pXWU8rcHAxMzVQU2g0TFhDUXhSNFZm?=
 =?utf-8?B?dm5nZ1JiZWZjcGZhaElTbzdYakN4cTF5VytUd016WVMyTk1LNzVlU3RIUDhR?=
 =?utf-8?B?NVNyenV6YVV5bW5UckV5bHRMMEV4RGRqSit5WThEZWMxc0lNd0RQcmdZemJk?=
 =?utf-8?B?cnd2RkVXV2FaTVB2ZTNIUUxyUklxVXhrU1lQR3hwNDM5cUx5QlRTajB4R0hr?=
 =?utf-8?B?TldLeE42c0ZlWnZIWUxyYWszaFE1S05YR0ZKNnl5c3hPM2o2b2dXNzl2cnVy?=
 =?utf-8?B?QVlWdHRveldIa0o0dlNURGErYUg0eVpZcXA3YlZqekhpeDAxU0tINFczaFdn?=
 =?utf-8?B?QUZnR0FkeHY5T2UrR1BOYURIaEdxV1Q0WE9FSFcxMk0wd0czNVI3Sm1HdTFq?=
 =?utf-8?B?NlNaM1c4L1BmTnRUNWU3VU1KcURDYk5FMUNYRlpSUEl0ZUVub3VSTklPcW1v?=
 =?utf-8?B?dXg4T1N0NG1Qa0xpZlRuS0xNNGU0NmxjaFZmalljemRQcHVJWm5ZMVcvTzYy?=
 =?utf-8?B?WFh0bmFReFJFUmF5SFBySW1HZVJRT0R5T2NmVUZLVGxocVRrVit3RlhtSjFI?=
 =?utf-8?B?NWFhOFNlZTdqZ1pKVVl4V2x5VWNsWStRZUdtWlVWL2p4T0RNd3hBek1MNzRO?=
 =?utf-8?B?TXl3Skxtay9OeDVxaU5XWkJnamxyamZTc0FRMnd2aUZhS3ZrTVlDYUhyWEpi?=
 =?utf-8?B?dFE2SS90c1lRMXI3eU1VUy9Mc01NZURhb1J4UlE5L1NaU0ovK2RtSC9BZ0p2?=
 =?utf-8?B?eFhMQ25Kalc0U1MvL2xXTlZyVGVIQkhYT2ZHaHRzeGlzNm5HNHNsOWhGRzJh?=
 =?utf-8?B?ZW80WGFwblIzMWhWci9Ha2ZRNXN2QWduV2VGejV1eExEcHVtK3dBS1ZxY09i?=
 =?utf-8?B?cVRZdnpHb3FlYTMvaWlhaFhLSzR6d1pWa0JNby9xc3NBY1lmR3B2RjN2VjZr?=
 =?utf-8?B?L0Vsc3RIamJEMDM3RlNNTkhzMTVjRFlmMmdtSGhvdDd0Q3RzMFMvNXk5TVRH?=
 =?utf-8?B?WnQrbHdSUk9yQnFXazhRZXc1N1h3N1F6Q25zYk1yQ3o2RkEzRGFrWUt4dGVP?=
 =?utf-8?B?bTlqZDBsOWR0dWVCWmZPRmZzUXNPRnZIZUo5WWdqZWVKOWNvbkNoUzlkK1ZC?=
 =?utf-8?B?bmVqaGRLQUhCdjQ2MjQxeWU1VUtIV2NtZmN5VW5oakxaZmxIYysxa01DWVdM?=
 =?utf-8?B?NW1CVUYzS3hnZ0p3eHNVTGtnM3FvOEl6dS81RjRyb0lkUnBTeFo1dmRaUmVW?=
 =?utf-8?B?KzNYQkRxMFdvTmFudER2Z3hOcjFRVmVsNzM1ZU5jbGszSVEvbUFRR0NjMW5i?=
 =?utf-8?B?VjNBTVNMNGZLYVV2TzNicXRrU1plZ0oreG95YVh3ZkNzNlhCN3BKd28rSzF3?=
 =?utf-8?B?Q2ZlUzJIMFlvVzdLMW9aNVJ3NmpxUS9nZ0tXeDM0clVxd2VxU3VkL0FzWExk?=
 =?utf-8?B?MHVieFhXRnU1Y0drc080eUQrOTAvNWRwWVFPY1I5R0dCMXZoU0pxcGJZbGNE?=
 =?utf-8?B?MXo5Q204d1g4WUVzc2xDcjJDVTNwR2pJeThSdzJLbmljWFdQZWtRVE9UWWhI?=
 =?utf-8?Q?PwSdUH4WV3hHT/96YZGz4dCdxiNHQS6azwMq3csizyw48?=
x-ms-exchange-antispam-messagedata-1: jqfV7rZ9z3QoxqM0wXQapBTDT79orUobwrY=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-unq7VJYviLEWY82JO3XW"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	EzAd1HoANv9KA9/x0ETaG3P5ZyfNkBcDnmsuzfK2Xa3M3NKOjjDCUvYou2qRrr1B4mVJM1ncTu4jaLArr7sSl7Meh9kLwQRevGVZjwo29oXmHv9Dm/DsEnbTw9/roMI+6iDQPkWS24oGCWCO04yTT/CS0Kwpcax3gIIyD+UhDDpGUeYuZgpqWqc/n6WAqCasjl6jvfyi33UmJHWQyB4squaOMEGkwcBvKQt46u4OawGnxtDHkxV54pnmMHro6euvwNbzwqyD3TN0LzcsSEUS7a3+wSSGvm2pGhGnB8fEzc11uC8hYsjrBZ8OK9Z1l3iOQ6OyPu0Tgys1gZQiH6P7BQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z+LhZIhIvATrZGHQbIyRhP2YMPSlyxUTB/KE4BogTZGDrjhpPCB3Wxw5C1nOTu5igQdpfOcPknisyswlzpw7DDxQst2dvmD6KJAR4fR/GSrI8s8EOjcguAkf77/JQcxx9tnxy9EXH0LckpVqi7lzWF39NBVwERtZ3NaKXvWaj9RoXulLL2T8LfGSU2+JxzqI+n4P61QeBwArMEyO/1HEsJVXKJg74EVCzxfv5JMN/OR2bTWkItYFBa7vpAuw82Yp4NX5SsdJuoXpamI4OmT1oxmYgWcG0YPKEoFNkSGMs1DoOuBgcxVI3jNYrbhQOiHhU1UG2gxXZtkZkUwfRfRSx8RT1joGHcmH5W+uvumFPnshVidClZNF56a/YK49BIxMua9OEj1VMdOFNG0eJkwvBy4cc1rQwKoqfTbfV13W8K396c0PaLZkIb4GxHL+B2AqO4dilmh4Ku3r0HygTZS08OwqLwhd8zNd73MacYpQun1kDBO9RJRENU5rvWLVyMOoMU4mastUWyzFYuZepXFn1kv9oMZnuBEG6KO/UuT5I8mY0i0uHfKrwbBEpIEj2Otq9mrXxJ11uI0RLd4iySoJr0g7PQXlRCBL1MwT3/qZUhw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acfedae-b107-44b0-5994-08deb8b6a8b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2026 10:32:58.6821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 12RfOxUQoCKwncADGBkgs+RJNZSdlooJ8NPrgNsIgQNtlY4/RHkpxXsbGlqszCfYVNXvxZebu9aT++JiUM5SpZdHJGPILVY9w/xB10HQ3DM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=969 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605230104
X-Proofpoint-GUID: k2xtHQwniESJuQIG4Dc4t6cbT4DkhZp2
X-Proofpoint-ORIG-GUID: k2xtHQwniESJuQIG4Dc4t6cbT4DkhZp2
X-Authority-Analysis: v=2.4 cv=Ld8MLDfi c=1 sm=1 tr=0 ts=6a118260 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22
 a=u2Ydlq-bOv_XbDfeqewA:9 a=QEXdDO2ut3YA:10 a=FcS6YCTaMz_4ZOCK8kwA:9
 a=FfaGCDsud1wA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12301
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDEwNiBTYWx0ZWRfX6JzEf51iEELA
 0Ok3R/TYCVRPU8ehbpwfmGSl6dHodE564WXSefynuFG43o9mliIQF8iu4jX2gN/FARgySRFH9Z0
 WQrcXtdMjAaWmNJgNb9lnpnox87efmTgnAKLJdNoJAbh5okPOBl5Ylf9lYqqiAen9NyS7D8n72M
 sDgiF++jSrFidPVl6h1TbldkpdBdrjcoSROuFm47KwZRfPFzQFqOxfTf6oGzmXDiRTKUJsKIxty
 O3RbKe2EyyF+QqPOFmyhWZ4eD19HWTsBuQSHEYxRlHCQImIqJsOBy5L0mWBAK+STg5JWB7FImMy
 qty9T40ixHGcjKJJKFAxBsEu4+nL1Fu7padz2qotRewl6FccfQZABkn6lYL5XzD4HSauQIavK2H
 tQwngxXbRayWnTfW5aGbVOpxkiNjeZmEwOikjfxvRacsUeDE5P4DWZ1NRXCeaP0WhQq6Q0lTdYE
 SWiGyvpfH5U2dU3iYKYwt44ujNupyi84uecfu6vU=

--=-unq7VJYviLEWY82JO3XW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I had updated the help text and then later dropped the force-kill
commits, but forgot to update the help text.

I'll send a v3, sorry about that.

Thanks,
Siddh

--=-unq7VJYviLEWY82JO3XW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmoRgksACgkQBwq/MEwk
8io/Wg/+LCBHKGXP5gAlezSCDe4Lh63JLY2Eqb+Uf9Apk5IsU3M8Ra1Nyh2cOBxe
wlD2MuTzPlTGccumQdP8TbTVzA4m2bEmHDdjTFbRsgEKWkIDWqaQBwwoem0yamE0
zDHZWnjGSLmoZNtus7v3u+RvdP1Nb3jI2cUGA0OCV8XUMn0mHoPonHzqWFd9KjXa
wATVStCK2ebm5lhN2bWdYqiZVrQ4PG2LXkOGa0aOSDx4eq7AQoPCf8ZxfwfLC569
CTHnXsJApNDB4dlGAzZyZyf5wLqG6vJ5Cj0PV6198bno9zJi3nEQdPPb7Dxe5yPL
6CK+Wvu9L3qmwIEGnz5JGqACBkFLGbPfWvV8X/ZaYQLnRpGNxwgCCQS2tBk52x5x
oAyu+2rdseICwnvYZdEQWWiwvDNHfs4pHhqg12/AKbXJK2HA6nVWOdopGNOix/34
AZNgUvOq4PxnZigpkG6tYe1UaDCHxk/Id/Nct4ZhFNsS+HTX57Mqb0xA1eLDXRDX
kEtIpjEDJATajKy6+H0Cz6AoHiUFh+WeSLh87J3/pIwO7DqwHstM9Nvh0qOp7jRP
MhlkLw1tHDo8w/WyhR1NrcirboJg/+QhyqImj3mwLiTR44B3YGIyaqI63ucYdMfb
YPs5w1a0Bx7cHYATtM2LkoQnk3SOThFV8hhuNTPAe5Dmy/cCC5w=
=OVa+
-----END PGP SIGNATURE-----

--=-unq7VJYviLEWY82JO3XW--
