Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7003336655D
	for <git@vger.kernel.org>; Wed, 20 May 2026 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779260874; cv=fail; b=SaaYeMEYWCRPf2oOjhrsFlpGcmlqU4zoc3ULYirQSIwyRs3nNfzotMBwv0KBZdl/N9OQaLMDDKOyAmLkVfZa62K2gb/S+OPQn+7R0hUpSoZ7N8ky9K5GbVNuyn2RQYo7jrcrxYUcKk0U3DNc5PzWbRruix8LLuN1bsaYZ1VoPVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779260874; c=relaxed/simple;
	bh=pNmg09DZmLmeAq1fEfkj9ItEg+sA71CwUarMizU6bM8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ne5vu2XAQCqb8tco56yEr91AVa6QupCh2l6TsofoWIYRzRj7WsReIQkIFJ/UbxR9uxe6CskkS+LIltDnHILS1d9aJYPS1Ke0SRir1jYGBF+1DHHkd3v/5++ztiXRetDFP73fQMJng6HQvZgIHTZfTyV5tJQXeIunCROaOtJfB78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G975nE+N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EZB+w7iv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G975nE+N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EZB+w7iv"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JLCxEe2322921;
	Wed, 20 May 2026 07:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=pNmg09DZmLmeAq1fEf
	kj9ItEg+sA71CwUarMizU6bM8=; b=G975nE+NulUvPX9B0pi2Xk5pj3Le7hWqGp
	K21nNEZh/sBKBW9phIc83vbQdtWOnaGxXOQhUHCkU98JC581R+YOkkHg3xoKgZlV
	LkF6SwJ3aIr4rdSj+eL+t7rfi7YL9pMUYXeTDY0f11N2siU1WIF3d2b5Q2ShAjct
	rVaLhnd4csEjgz17skjxNRCru6sdfsLkZnZS6fuLGxb6zCnbObQi3Irz+Xd6u5z2
	tysLgqaQK6/He5YU6Kl0z2qIA0/Av2xoOPh97Gxy2n8PiIkZhviJOrdKJ6C5WX8A
	0bfWfQ47/Gkdr2HIPlwLVC/rxEjBkHH/mC8x/p32B+agrMqJHE0g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6gxwxa9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 07:07:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64K6t16E011170;
	Wed, 20 May 2026 07:07:46 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1bs61m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 07:07:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlctqLLLdSVg+1P6DoSaVbovx+iEw1iaAqj2//041JSTUe9vAUexSAZzIdOfx3Q3b7sIwT8MCXLApjjl9vLrD2kqwna5IAkWsvIhuz+bNXFW+aMmVCFGv5vLrbujxMOMGSo2XibNF5Fw26iSq4tZaYtk6FVLBL9NUzBy4WPEGGTLwzu5hfvv2x0j81VPWKRK7qN06DsQcfKBb5W6N3lJtqxahsmKtKfTwZ3/zrrW1ogFAuZQvX7wOZgRKWyYIBsTzrhKLPIv1+cskRJ7atWeYKKv6hEadMOQ0xkY+TbCuQQLBis/TnQRHHJ6YoUIWmAnEchwm+ig+Qf6jKqzKwel5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNmg09DZmLmeAq1fEfkj9ItEg+sA71CwUarMizU6bM8=;
 b=IFBUP1qJniiD+9psdnUlGstQRDrcnjtOPxZC0LJAzC19B2TQzpOpa3wK7ZJo01uIAWWb6sIkg3ICb/5dmytKQ5SvWuWMPUyHQWEiUGxZDdCQJAWjcyt4Km2MDBtMG7jF0MbFYHYxKfQajLD8l6cTIjq9tjqXj9vvx8Kro+PbAs+SxhjU0VLWDkry8TEnUh+GxKgJQUAVndm26TwYwppcs1flsJZWH3LhQvJhuTiSEypR6RxST5PZUCPjBg5m4QNz71M5S1Etm/orenKOqkYeGjT1givuRZvdf97CNmQmxFYzZvABnM9+etQUqoJt+WL7lVw4grcDdDuoODygmsMMOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNmg09DZmLmeAq1fEfkj9ItEg+sA71CwUarMizU6bM8=;
 b=EZB+w7ivZob/2DymF3XDoY3zYZcek/2Fz9R0fpRZNXebnl1YExN9wCgAebzbA36NxItqaE1ohp816bF+XakqzZRy3GANDPZ2aW+/ouOexA9cZGiQwBP2MeN9klnU9HK702gD0Xycg+OABcyjnm0SYEjp4E6SuZkaNIcdnELJnlU=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS4PPF26D9E501B.namprd10.prod.outlook.com (2603:10b6:f:fc00::d11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Wed, 20 May
 2026 07:07:41 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 07:07:41 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gitster@pobox.com" <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>,
        "calvinwan@google.com"
	<calvinwan@google.com>,
        "newren@gmail.com" <newren@gmail.com>, "ps@pks.im"
	<ps@pks.im>,
        "code@khaugsbakk.name" <code@khaugsbakk.name>
Subject: Re: [PATCH 3/9] wrapper: add sleep_nanosec
Thread-Topic: [PATCH 3/9] wrapper: add sleep_nanosec
Thread-Index: AQHc6CdZTcyhEo47OUqGqyRgmZjDYg==
Date: Wed, 20 May 2026 07:07:41 +0000
Message-ID: <56552f593c7fed411af24413e4d3e77a34828451.camel@oracle.com>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
		<6a8c2093643a385641ef0b2cde33839dc98d8678.1779207350.git.siddh.raman.pant@oracle.com>
	 <87qzn7q7qj.fsf@gitster.g>
In-Reply-To: <87qzn7q7qj.fsf@gitster.g>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|DS4PPF26D9E501B:EE_
x-ms-office365-filtering-correlation-id: 1b9682d8-e777-483a-9215-08deb63e7bb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|6049299003|376014|1800799024|4053099003|18002099003|22082099003|56012099003|38070700021|4143699003;
x-microsoft-antispam-message-info:
 fW7piSeD/kJoRAo8SRxbvShAiefsDe7V/0Hmt9OYRQLVgaMq4DRm50q52Upn6Q3uzMGLQG0BokXm68EIy4rzb6ZgCxG+SXAxF4Vmfis4Huh+jzt9A0QrrwGRy2NfaAImGmM9E7qi7qPEoIP9Db+vY/etbiEyyH4A2I5BFW8zRPF/8LhqWzhac15aW+QtErvGk88YzEGuTo84/hSYJW34E0i3gX20qO5L9KPnvGNF+e0IXgFiKkxpYUfyYMTzFLbQ/L/lBfjDrY1RtF/ggDpCZrCL/6Hv+0YkrkSHy6HZUjbEIkTLd5UUDBSuqv9CaR0AnHSY2AguOZyT0MoBWWQEjFIL3jXiH6kIzLOwzJPLXk48fMBzlUFYnm6MHM0a5H9V78de1EIxOH4c1QvqYVtVMA4Qn4/Ja/KR33bx03tQhbE+49jAgI24lh7fUDe8CjqLIfyIx08A0D2f9yduOZ1BBEUkFEiRLPzjwq29WwasYQAA3SL8EM0vz9ODLehy8tq3Z9j1N0R+lmJujApNLt34o6wlGhfdRZ+gsmToPlaG0lQ1ANiKk14k5PzFyeU6tEwGujhmjxQt1sqHORtXuBE3GYFubqG6zlxud8SWZVedclymE33VRZLF+H3RbZ/RLs8QKh3FnVjFwOm55Ed11TBUbfFCxyVgiAKfhT/YObMZthryMCAYEv/XBUSjgAgn/Y1MpeGiDVDx3tXq2OrKAaFxY90nSsF6ZRW8XB+0rExce2juGKVZMVdFUE7ri5pMYZL8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(6049299003)(376014)(1800799024)(4053099003)(18002099003)(22082099003)(56012099003)(38070700021)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmJ1MFdaZWRpVmVRVk5Pd0NlblN0TG55TnRSOWdWRVpOLzUrUmI0NWl2UGNM?=
 =?utf-8?B?dEdTQTZaazNRdFJjOVpTTHpUdkpNdk9mKzNaWklTNmhHOEJ3N2U4aGx2SEx1?=
 =?utf-8?B?MDBSQmV0MmFEN0UvR0JMeTlqL09EK0tQb2w2QVlRWklRZFJBekZmRzFFeVhH?=
 =?utf-8?B?cFpraWRRSkxiVkxkTkhWblc2bEwzUEhNTkJtelZWdUtISWRsTDNGRytDS1g3?=
 =?utf-8?B?eW1KazVDN0dyS2t6eDlsNG90RnY2anR0U0tUNDN4MFY1aytNdWtndk5EL3hz?=
 =?utf-8?B?ek12dWJwdFplSFJiQm84UTk3V2doVFlsSlB5UGxBbkRzVVBHOXI0RDJ6Z2hs?=
 =?utf-8?B?UVFNZk1MajkvQXl6WDJycXo0QUdHME9ySUU0Z3lYUklvNk50Um45cWx2MXg1?=
 =?utf-8?B?VSs2eGNidmxLdUNVVWkwN0g0OFJaRnNmcVdncC9OMmpDYjhoTnByd2hFQ0wr?=
 =?utf-8?B?enlMamF6VXF2UFgzM0luK2xnc0ZCa2IveDdZcXZEbVc2NlpLMXBHWEdYS3RX?=
 =?utf-8?B?TlcvaThBWjM2bUMzMGdTSXZjNnQ5WXBwcnFrT1I2R2UwdEJRY1BXQXJjc3hD?=
 =?utf-8?B?TjhIQnRNcSt6NjFCKzh2Y1ZWU1BnWThxQ1RIOCtlZEZCaVE3OUFsRW5kRDNN?=
 =?utf-8?B?V0Q2aFZEcm1YVDk2VkRCWnljVStRZkJ0ZWlzWlBrQ1c0bHdkOGpldFM3MVBJ?=
 =?utf-8?B?WTRVSDJYU05Kc1RJVVV1V1RUNVBaWHFtY21pY3FMUVF0NnFXUHZqLzJab0p6?=
 =?utf-8?B?WCsrZkJzL3BNSXc3K2cyYkhmbktvaVVuRElJMWVIZzlYeVNVaURyaEhjeWRM?=
 =?utf-8?B?cFlkOTZmZG1xcVpYdEpFZjh4b0themplZ3BycGlMeHFHWFdkT2pzVWFTS3Vz?=
 =?utf-8?B?eWZCNGdmZERaZExEcGhNa0N0MEhNNnAzdGxMY1NJN2xSZ2hEenN6aTk3ZUt2?=
 =?utf-8?B?SXZMeXg1UTAyTHhOeEpUOVBVQVdyWXlZTFBPbUp3bGkxcGtoZ3YyYzFTYW5Q?=
 =?utf-8?B?Y2Y1OXNERlZVaDYxOEQvUTlNNWRWUm55c005ck5VdWV1MXUwM1AzWlJJS1ly?=
 =?utf-8?B?dDNFaHBBWncySWkxcHFyNGFJL2JCczQyNmFmdkZqaTRkSXhqWGkyTzBKeURU?=
 =?utf-8?B?U1ZscEpqdWU1ZDFnVzJUWW92cVhqbjhiOUJJdUR5QU1iSllCOWRkSjRIM0FR?=
 =?utf-8?B?dHNyOUppb0twQ3MzVzdNUG9jc0xEUjhuUlJhRC9KQXFpcGtFdkwwa2VxR3Vz?=
 =?utf-8?B?RlBiM0JxV3V6QXdLYjdYVmw1aU9sbHZTcGU5VXQ2VFpod1ExRFhhRUVKdDc4?=
 =?utf-8?B?T3pVOHpkenBhTXIwaEZQbVlWaU01eEpTbnB5MEF4N1pHbzh3b25HeGkwSS9J?=
 =?utf-8?B?NHVLMEwycG5SSDE0UU5vUE11b0p6ckVGR28zZjVNVngzbmkydkZoaUJtUFRx?=
 =?utf-8?B?MFR6eFdGbGdNSWNHWHloRFJ4OGc1Y0psbkwrL2ZUTHBaSXU3ZG5PNVlBVTdl?=
 =?utf-8?B?ZitITEMwQjh5Zm5NZDNXNUpGR1Y1UUJwSThKeDR2d3BBaHJyeFQvMzJETlNY?=
 =?utf-8?B?RFo5RlI0T2MvMWlDcmVaVnlMS0swWWw3aHBCTUlyYWNnLzhZc2lGMENSdktj?=
 =?utf-8?B?K2c0TklzVmc5cDJaM0JreTdPQzM5K2NkaUpJckNtS1IwSHJNOEtyYXMrZStK?=
 =?utf-8?B?WXprMGo4K080TWxVQ1F3dklyVzRQYVlRak5LWE9uVjRuUm16Z0hpb2k4UFJk?=
 =?utf-8?B?Z1VaVG9ranVjZDRINlpRc3hyMkZDU2p3b3ZxU21xVE12WUVVbldVemZWT2RC?=
 =?utf-8?B?d1JUOWs5OGFCMnFtY0Z3WnVWdW81aTNub29ENmI1SlJWaEwxMm5xbjhFVWNH?=
 =?utf-8?B?Sk5jcE9aU1pJblIzOTlza2N4akk0c0s0N1VPYVZGSmlPVE5mNGhGM01ZdnYw?=
 =?utf-8?B?c0dKamtTbm9FdlVlVEpwTWVlUHJQcUpReGZvR05BZkJtMEpSTHdOVllQbjN0?=
 =?utf-8?B?QTVEcUIwNC9pRWRBSUNrMERQMEF5REp5UFRYSHgyY2xIekVNbXhFcm1HYjUw?=
 =?utf-8?B?L2dZVEpFSkN0czVzTlkrdlo4ZUxlZi9STFp1cW5hVjVNYjYvcSs2NndzVHYv?=
 =?utf-8?B?dGVFZDViNVNxdlVSeHd4LzNheVIrQWtYMWNNd2hKUktubFpQRlVUbHErendL?=
 =?utf-8?B?bkVaVVlBc3NVc0pCeml4dXhzZXJtM1ZRYmRwaU0wQjdQa1JmYzd6eU5pQjRC?=
 =?utf-8?B?cUp3UGhTeGpZbDRqdGZxaUtTNjBPeDNnOUVsK1F2TkE0czZhZkFpVGtCcWRn?=
 =?utf-8?B?dU16Yk1ENis4eitVRzMySnozWlMrbFZkU0JvRVRFckcxZnR4aVF5WFBESno3?=
 =?utf-8?Q?95IdnB2ZH+87js2rOJuybxsFMgpRlbFxzkmS0xeG7uRk/?=
x-ms-exchange-antispam-messagedata-1: Qr5GG/mrWfc9OWyGJxlzRPl0x+eiVUREjF4=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-CA5ymLm+v+DeP4m74IVR"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	MHr6uuH9FEp0sbSSQJqgmsrJgE/43x8NrY3YuAXvF097GyvR9SnQQdzEomIq+QeNk5evgLv8z2+s2kTAR0x9VhsVhL7ztwoSYtGzz/kv9dAufTyZyeFkgH3dYgEhlxuS2x9yisOv6RU29JKCIYyI6r9iDkY6N4nw/kAVcdbxK7Z/ZQD7UBWEo92JOUHP20Chat4f2nFPK73Jlj512q5g3yIf70RwbHu/eJFZfkp3tM8m/g7i9+x8ZXU72//PfrpY7SfPq8XrgXSUUtCtRqvr9I4GUlUqDYrzlpct3JOSEkJSOIMYbxpGb83hOvTmEZvJ+ylRFH1XgvUbJctiSGegWg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sZKOHtqKNEhI4FMw7YnalWaZa1hEKrdSshuMrTI4wU3sdkoUkrGZ0NTZlat8U5ZenvrwRcbL+Rkh4s2NqcNbsunXO70rMSGkK74L58z39Y6NSETEZl52pxaM/dcIMjo6fLCqePdvf/wbQHDEfdZNa+nGCIfq2tqszK7qGhuGYHWgcrvKZ3e1jm+k1GIzKCnshK1fFCR4dXcVy8tzJOTvtB18TM5IoegjmPFl8kBeupkVADIBfsHe2QVmm7HKzIqsXZgMbiou7rDUVPUR4O/7Qm4x8b+XM8LR3WgkpIp8Weno8iHnD/Nm1WBG3x6ED0JYY/+vfUuS4QaFn8FT58/LcSR8RiZBmKAZcDc/dk0BKzaVlj1dbkEEtbdHOKVgq3aun25CHBBZoQeJWjk4i6WzGG04zSqnom/JoZFHhQHXVJIW5JpTcVAek3b/USjo6sWW6Tw9T+U2G46jqpMoDJENL9HG/sV429FWGrvUARGRLF6Hs34j5QG33rPDzA/tkZEI35ZjHiWvNe3aGZPpaEccoKzFRXM/LXrFhwYbH3YcwQ1P31PCdOXNktvgcHartEWPzKdMuImqlQfn/y8NCWM+MyR82UUuw5nd0YibsWoyNhE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9682d8-e777-483a-9215-08deb63e7bb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 07:07:41.2455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: efhq8X7BYqM22CbaEvF8cM1CHlIwvDbtYX3tYvZmi2R6gnVx3ypbFm9Dswjj/Ewr6+sdrnveEjg2Kd8FsIOIxZqL5qEKKApQyocoB1Ikyrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF26D9E501B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605200065
X-Authority-Analysis: v=2.4 cv=UOjt2ify c=1 sm=1 tr=0 ts=6a0d5dc4 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22
 a=_pKaQ02JBWD2B97E2GIA:9 a=QEXdDO2ut3YA:10 a=ibTeimOxOrsA:10
 a=zZCYzV9kfG8A:10 a=VBG-TZeYWIC2wFJsi3IA:9 a=FfaGCDsud1wA:10
X-Proofpoint-ORIG-GUID: J7pJ7sNFN0cG3kHBfF1DcjS1hko_BDc4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA2NiBTYWx0ZWRfX1DDsYfwLP61M
 oRr9qfmutybICMqIn3i5bjHNBPcZkzQlsOVCCR6qZu6AKGnL8tIobrSEnsPZlWCftdhZUBYHFBo
 Ly6umngazK4ugP7o+lAUTZVjDfKYiUpTSHjv5w/IAAZAas3Ddl29rk/LHc1KHIhzv/yJiHAR3ut
 CpoCCIjjqPUOle+nSuCHc7vou4LhIKgMK91ZjU4jQb83LqVxvUPfSMW95RSzTSERbR2b/tfTARN
 lWg5SDeOvVANfY0z9jdMhx487FDsO5FkhDuPi2F6VC29FJUQqFEf/ADmov7K4VbRm8WY5xf1MCs
 Icey1JbVMURdAQzKZL4+jkbiSOhRadMTjfTU7MCisO2cW+PGArh2SXeLX+/xMsn9Md+6G4OxQKI
 3TI121a720DQ6tRgUCgbGfaFT3lzjjUXxo9blr+qoykK0CW+Jo6BUchPbOY7kD6ar4QsadeT6IN
 kn1tQQa/A/YXEKTlheg==
X-Proofpoint-GUID: J7pJ7sNFN0cG3kHBfF1DcjS1hko_BDc4

--=-CA5ymLm+v+DeP4m74IVR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20 2026 at 05:20:44 +0530, Junio C Hamano wrote:
> The space above the signed-off-by line should be utilized to explain
> why we want this change.=C2=A0 For the purpose of this series, why do we
> want to sleep at nanosecond precision?

The current time returned by getnanotime() is in nanoseconds which is
used for deadline, so to avoid re-casting in helper code path we try to
stay in nanosecond world. The caller can store in ns once and reuse it
everytime.

Thanks,
Siddh

--=-CA5ymLm+v+DeP4m74IVR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmoNXbUACgkQBwq/MEwk
8irf/g/+KIHaKlM4uv3H1DgZQlyKk/oT7Inu3LQnO4iF09+TYkskRiBEq/Z6/95S
gblnERJEEutADlgvm88mpZZKV2YYdtuKpDPGAoVd5hPFws94bC8yxhz7+ijxN3cd
pSS7kHQR9fLJXQgSCgdWNWJpiRrZMUp9dX0WNrDTDnlB1wGqdQZr91q4GAgZYEZr
mpWGXN7eT7b9A2SP+894SUX2Ys3OCj4aNhQqcZ2ofE+zm72KArsOU380FB938RJN
J6zyjqpEH2TP8szOfeDjzaW3cPZG91cApMvHoByX7OC3QxNdecXIyxqwWKjff/eY
xPJ7f7GeC3Tl44iBMF9sUQ5FLJ/Na2v43SAK15X0BxEzsVHOR/eKTcMH1gmdQsNq
waBYXxNjfkSM+VOH0GlW//qtj59oTv7kyXVhAbjXf+e9+cgywkqFNAlb/RKIm8ps
HGr2iglEjFy5F+SWrrDzE8eFISf7WUptBXE0Twbmiv1ORZLShy61us+l2QZ6g+Wr
l88mH/VBCyX0phOTxXcQxUgJ80Z/n+6kn8jloVZb/jDxF2e0Ulox6t/eyc85eLJ0
vXrGO7z2xv8eRMSW8iQ2KYfFf9ftMmjdFtXN9JqPOOxJ00tCuHXXrZOPDFfonPsV
i/FqV13uACprwzknASSwDulXEIQZhvFGlglkASFvD7GKI9oR6jk=
=yGji
-----END PGP SIGNATURE-----

--=-CA5ymLm+v+DeP4m74IVR--
