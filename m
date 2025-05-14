Received: from cathaymailout.linyuan.com.tw (cathaymailout.linyuan.com.tw [202.154.200.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D455F136337
	for <git@vger.kernel.org>; Wed, 14 May 2025 02:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=202.154.200.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747188241; cv=fail; b=RWBvlrBdt3dre30l0ERCK5iJhDHauUuWWA3X4vLLrfAI/Cc0vzjVZdhK83//tDTaDIW4QcEP1QLfo+msK3i/rXP80yAAK3OhcQsSWzJ8fZ4Q+5o1M+p4HDgJ/a6fBwgR8G2xsGzh4VPPHR7H9u+R/2DMx0yqRRJdOSQhfSPlLGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747188241; c=relaxed/simple;
	bh=KTz9OVXqlIrzOGUYTFQcww2SMMsMM5k+KPGVEdtdLXI=;
	h=Message-Id:From:To:CC:Subject:Date:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bOnu1jkauXbrxBQ/2DdL0K7ZkoTHtTab/TIauJlwTxrZULsB1jIAE0qffydL5JjFFtmRARwFUnWFlibv8SkGagLqihM3gIVY92Q/weS84/df0um1LLqw4rTUg75tq9KLw/IIP7tTMBjHRG63LCLPhalxZfJAYdyvrUDi7eVsRco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cathayholdings.com.tw; spf=pass smtp.mailfrom=cathayholdings.com.tw; dkim=pass (2048-bit key) header.d=cathayholdings.com.tw header.i=@cathayholdings.com.tw header.b=BDVJn75u; arc=fail smtp.client-ip=202.154.200.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cathayholdings.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cathayholdings.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cathayholdings.com.tw header.i=@cathayholdings.com.tw header.b="BDVJn75u"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cathayholdings.com.tw;
	s=cathayholdings; t=1747188243;
	bh=KTz9OVXqlIrzOGUYTFQcww2SMMsMM5k+KPGVEdtdLXI=; l=6212; h=From;
	b=BDVJn75u8lV4zR9XWQ/l6f7H7fMyh2qzRcX6w0KwiIS7yaOs+TSR1J2iJZpSuOq+o
	 zOyTQYD4f0Uq0V6qDrVzKQv3yej6ehQyZ8pjKNjwIjzPXWnIVx5V9qLdAnjE+7hvXu
	 sIx/Kly38WXwSsWO3LR099DMOo5/s5TwRMV6a2G9XaA30AjaQAOt+xD3HUT27frTz7
	 0oF4b80X9RLby8XLs4s2NpVoDlF3skcFuv2ioDOqIBI6SHBGmqHEQY6NSKPdm2g2gL
	 bKPM+PYkc9lGJTdAsh3aM2e9WMIEUJBR5xcChpUHt8WMC+sfMwIxCbosiSLyS5S5Zx
	 YqEsmogTEbHFQ==
Received: from 365mse02.symphox.net (unknown [172.16.20.144])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by Forcepoint Email with ESMTPS id 7C003985941B14FDC447;
	Wed, 14 May 2025 09:48:12 +0800 (CST)
Received: (from root@localhost)
	by 365mse02.symphox.net id 54E1m51Z028606;
	Wed, 14 May 2025 09:48:05 +0800 (+08)
	(envelope-from VanessaKuang@cathayholdings.com.tw)
Message-Id: <202505140148.54E1m51Z028606@365mse02.symphox.net>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by 365mse02.symphox.net with ESMTP id 54E1m0Ip028462;
	Wed, 14 May 2025 09:48:01 +0800 (+08)
	(envelope-from VanessaKuang@cathayholdings.com.tw)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSny58rN196RE0ncB4XKJ3BuJU+AnEmH1Fs/k4AuD7EtdDwbzIH3WYUrH1L8rujdDkbxG+xD//ODUGfG2AjpMq7kFwp5YO7xJTDklQ8XqbjXyukpYsIpmo3y3CqyzX7pKkYg6kxU3TuTbqdEBuw8dotauhu+10BqpyNKM21pID3RF+V7z3Xs3OIa2m5KuYrsSOzRTHPO3xyDnwiRh7eemYbOK7oAZN7zw/KVxOOcGqGXQVjD4zC1XZ150zqNxhJaUGNW0IafCaOFbceoF8fOKKV+GXWkWOypjKNmhgcCKZQZRwPjS1PgyeSEvtC2yG8vonnqoRBUguvDr6g46Xfe4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTz9OVXqlIrzOGUYTFQcww2SMMsMM5k+KPGVEdtdLXI=;
 b=JToqsgrB5PAqr+URt0fdirzGIaLwABRmSm0SaflChvM6eV02f5zq/RWfFFG+HLbi6NUrAv71t43FOI0MV1MVFNb+XWP6c15pXDTjLRq3Z5mHx/79FiiKimYDtgZ+iufdsmnsppr8YcJ+rZA7iSexuPAHOZfedAbE38cyRg0tI77cgQYpS6pFjEr0FXWgBbbpZuhcpl19pr9NhUB6kjq6sEzDQ3TyvE6yvqobD7GmPv4+pMtI23kyqOFxEP1jzWpV1dhXEblR2Bx3aMZVYe2N3u+7gDEbA44tY9OzjmcLIhEShO5IPN6/snCdvm9v1DM3gi6AwlLLQzhBPaeMAqJ+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cathayholdings.com.tw; dmarc=pass action=none
 header.from=cathayholdings.com.tw; dkim=pass header.d=cathayholdings.com.tw;
 arc=none
Received: from LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21)
 by PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 01:47:57 +0000
Received: from LV2PR12MB5966.namprd12.prod.outlook.com
 ([fe80::7c1b:5fa1:7929:fd81]) by LV2PR12MB5966.namprd12.prod.outlook.com
 ([fe80::7c1b:5fa1:7929:fd81%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 01:47:57 +0000
From: =?utf-8?B?6Zai6Kmp56mOIFZBTkVTU0E=?=
	<VanessaKuang@cathayholdings.com.tw>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC: "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5by156eA56mOIEtJVFRZ?= <kittychang@cathayholdings.com.tw>
Subject: RE: [External] Re: Get support
Thread-Topic: [External] Re: Get support
Thread-Index: AQHbtRh/BI1w0PW7ZEStYLyKl01WmbPReXcg
Date: Wed, 14 May 2025 01:47:57 +0000
References: <1744786449-14024-mlmmj-0f30ebef@vger.kernel.org>
 <202504160735.53G7ZjeU083840@365mse01.symphox.net>
 <dc58a9ce-3d02-bb52-bfe1-7427333d6128@gmx.de>
In-Reply-To: <dc58a9ce-3d02-bb52-bfe1-7427333d6128@gmx.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cathayholdings.com.tw;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5966:EE_|PH0PR12MB5679:EE_
x-ms-office365-filtering-correlation-id: 31ed03f8-f5ec-4bd4-1234-08dd928959e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?amphNDF0VHROTEtGdXJna0Erd0FNcVZSbHZqUy9sQTN5ZzJ4Ynlkb1dvWTNX?=
 =?utf-8?B?Rkx0T3dLQk1iR0hVYVdxU2U4cDEwWE9pYm5JUzhkMk9Bemt5c1BRaTI0OWs4?=
 =?utf-8?B?T3pvdmxKbWhWRlJYUlJIK3IyaDQwTHN0V09HQ3ZBMHB0SzVRWnVMTm1IVUVJ?=
 =?utf-8?B?Vk90NTZBYlZKbUUvNW8xaERNYWxmQUQyZHIxK2VpODE0K2p3d0R0SDB1azU4?=
 =?utf-8?B?bFlWS25nT0lLdFZJR2phZ1hpNmJ0WXp4d09xakRMc285UkYxcG9LNFZBY25B?=
 =?utf-8?B?dFM5ZEt4UkZ2MG9TNnRlWURCRHJJVlcyZG81b0VtTVluMzMxbWlHZm9DdmVo?=
 =?utf-8?B?N1JJRGlySTdpZGlHZDJ5K2FhMURmNjE4TVd2OEdPcXFZWjFDMjZlY0ZDK1Zn?=
 =?utf-8?B?c2xJN2VQeDRIcDEwVE1EUmVFck5pVG0xUVJnWTBhTklmTm0zeEQxT1JmNlF3?=
 =?utf-8?B?WTVYeVArZGYwZ0o5TWgvY1VmMTN4RnpJN0Zyc3N4aFB2c1ZIUkVVOC9xc20r?=
 =?utf-8?B?anJkMzJYQXJPTEwwbUw1ODFJT3Y4cUsxSDdmdjdXNzlLZGgxMWxnRmhMTTV6?=
 =?utf-8?B?SlFKeEtMdTBMWHNCNkdFVjRMNzBjc28yelkvMk5kNmI0V0Y0VklpMEo2NkFH?=
 =?utf-8?B?NER6UDQ5cG1ERHptMkJUckdCUmtuUWs3VEI5bEtwbnVaekdzSlNnTXlrekRM?=
 =?utf-8?B?N1I1MVZOdDh0aFowUndScDZaS1RqVjY0MEVYME43cS82WmYzSTlUaWkvUktN?=
 =?utf-8?B?dlhveXQvTDk4M0hyOXI0UUd1ZlEvYlZhZnFiMXE1RGxOQjVOd2JYNXB4amt1?=
 =?utf-8?B?NWJkcTdKMlRwWlJTL3ZyVHBaa2FBZjh2Nk0wRmVYbVFtem8xbmNjTk5FdWps?=
 =?utf-8?B?WkdRSHN3YkRBZUNpcXFFcnZtMUQyeEFvSlpDRGNSWVdHRXp0Rit0ZWx3ZTZI?=
 =?utf-8?B?OTlLTzJLbjB1ZjBIbVh4eFgxand4T0o4ZU9FNmE3dy82M01pa3ljaVYyNGly?=
 =?utf-8?B?WTlvN0F2SW40WlpvTmNjRUViQVRBYUx4bnR6ZlJvUVg4WnBwRG5RenUzWkdu?=
 =?utf-8?B?ellva25PNFhQN3l4amZvZ0pMVTNwZzFoY3F5Ykl4SFh6cEpRWWpsTFZ3eVhP?=
 =?utf-8?B?ekdEaURjVTJNazdva08vWWNKaUo4UHVvcmZUVkszZllWaW5FWHZJV05ndVRx?=
 =?utf-8?B?cE5uYnFGQWcvVENqb2dGWlhweE81NUxOYUhxUlhjRHdCL2pBOHFFNUVXbm00?=
 =?utf-8?B?SXl3UHp1MFVhQkVaVmJmM2ZYRFNTQTNZcnc4TzRHdEhuRklxTTR3VlJBellE?=
 =?utf-8?B?dUVURHhsS3d2UFBNZ2NZUDU5NXFLNkd1aEpSTC8raVRHdk9XZnpwWmUzVm1v?=
 =?utf-8?B?V0xRWVNzODhOajlFdW1oSWRQc2Z5bkR6UFg3QmUrbktldWlHTXdnY2grK1Ay?=
 =?utf-8?B?UnlaTVc5RUtRTXBaUjNRK20xOGNLVUFQTU1JTStFL2NadDhkRHRLakJEK3M5?=
 =?utf-8?B?Y3czQXdjRFI2aStJdHN3YnJ2bk9DU1ZObHRJY0pPY3pqSWcyeVVEbVp4OW52?=
 =?utf-8?B?QjExUDQ4Q3dXV3VndG1IdUoxTFI4OG1kRXd6QzdFcVlzeEhCMWpFazZFSThu?=
 =?utf-8?B?amJCdWVjdVpaNzVGcHIyem1QVzF1VUttRXA4amduQ2VvSXhuQzcycnN1akoz?=
 =?utf-8?B?ZkxkVE40dnBXdysySURZZUF0SWtwS1hkQktxN3VDMVB3ckliendDdUlDZjJa?=
 =?utf-8?B?d1EzMVV4TURtQUJwMFdmTWlUeTFTVWZmcmk4RXNtMzRKQ1NFMUR6UHFNMEVq?=
 =?utf-8?B?aklqeDJCVTZsWUFmek1RL05iWGJwcXNEZXhXMTlyMmIyMTNmNnhBaWpTbUFS?=
 =?utf-8?B?dXBYemNWejFpbkdDT3Q5bDBreDFwS1ZuNURweDA2aHh1K0Z6REs0RVQ5TGNV?=
 =?utf-8?Q?UXYb7UQ/3RSiO61cIe0Ryp//bwgGnPde?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5966.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RHUvTFJiQXlEM1pEU3pzQWpRdEZDUGtQYXN0cGN4emV2LzllNHJUV202c2du?=
 =?utf-8?B?T1FnZkl0SWQwT3Jmb3Q5TEpwK0JFT3VXalhyMUFHdXZIcWlEUnFpaGNmdVpJ?=
 =?utf-8?B?aFdGRU1Fc2F2dXhNc0NHZHlRcEpSbGpZNGJjSGlZbHZJbXlTWm1BbWExK2JE?=
 =?utf-8?B?VUpBS1lkdnFlcDlRUzFUc091ZzF3WSs4MSt4dXlVdWVjRnRZNmExTDBCaUZW?=
 =?utf-8?B?eFpXblJMU0dQNHRrNnpIK2NDTDNZT3M0TWlVWjFMRUJqRFYzc1VDOEgwbzl6?=
 =?utf-8?B?WldKTUx0NjQ4cG9DVktWYTg2dCtkbU1wYlVlajR3ME51QTAzYnljN3AyZVpa?=
 =?utf-8?B?VDIvL21valRhSVlqOEErN2I0Vk4zVWwyZnpUa1g1dEFCUU1ObkxuM3BhM2N0?=
 =?utf-8?B?V2JWQWtHbXM0MmltTU5WVWxJaFgwT3pNanhhbFYvVnhxYlBDV1ByeEwxMnN4?=
 =?utf-8?B?STgyUmxad3NzNmMyRWtEczhIZWxrYi9TMjY5OHJFTktJd0lNdEdFUTRWL3N3?=
 =?utf-8?B?Q1B5V2tubExNUXd2cWlrVzM4YTF0MDNZQVRzcmUxbm9ZM0lpemltd0FtSHB3?=
 =?utf-8?B?V01VcnZIOUNTSjZ3R0FkMzQ1bUg2ZTlBUWhSRDAvTWhXYlhlUEpVM1BJbDNM?=
 =?utf-8?B?VEZOdEVGNXJiU2JmamN2SjJFWUVTdkZHQjVydmxIcEUyYjFNL1FwSDBlS1ds?=
 =?utf-8?B?S2JOOXk4ZGxSaVdIdXVHR204VXZRTmZsVE1TTWU4V1FIa3NMYUlvNkdrL3Vl?=
 =?utf-8?B?RFcwWFdRdUl2UTcrdC83SVFzU1Q3ei80NU1BQ3p4SzB0c3VLaU91SmJ4RjRO?=
 =?utf-8?B?Z29sZlJZTXJUYzZrNDNwTzQrRnZDV012VVFRK3lPUXB0Yyt3YmhnNEVBeVpT?=
 =?utf-8?B?VXRIQUhURmdRWGZQd2t0aXVEUHFzQzRXRi9ZbFRMQUdVd3hPWU9qSTVySHVN?=
 =?utf-8?B?ZlRrZTdFM1VmTUpXY0tUT0pJL3BiclFHVHRVcFhxN1hFb3JqUHBXaFpWdHdz?=
 =?utf-8?B?aEk3U3ZPSVNZblRRRjRxQ3dlQ0N6UVdxQ3ZzY0Q1MTk3RmNDSk81L3NFRGE4?=
 =?utf-8?B?R2dkaHc4YWNpdGlJbHRQeS9LTys3VW9FU3BIZlNoVWdQV0RXbDRzMkZ0amFH?=
 =?utf-8?B?YVZLQ3Q5UzIvQ2Nnam1DdFliK2R0RmYzQTdBMlNUM3JuWGh3YmRhRUJBRFM3?=
 =?utf-8?B?WWdDR3k1N05SeUtPZ1JzSGlNVVdxc2dWaWJBajVoNVZlc1VZRTAzL3Baa244?=
 =?utf-8?B?ZWgyNGNvUTJSdXdOaEVkQ3Q1b29ISjZpNTArQkNUU3VFWmY3bm9iTjIxZkcx?=
 =?utf-8?B?L0NxbC9IbkFvay9acnVFVnRFTUIxSG04M2dlS1p0Rlk2bmkrNnJrNzU4Qzk5?=
 =?utf-8?B?dDQwblNZU25sWmgrdlQvZmYxNDg2VWZCNjBNQW9qRk0wSjZoa1l3T1FITEoz?=
 =?utf-8?B?MFdZT0hWQkNGMzBSd05odk44ZHRTTHFnbno5dHBXT0NiUGRUQ0NJY0dNZGNj?=
 =?utf-8?B?Qyt6NU5uLytvQlBzMlgrUldVbVUxUGxXZUl6akxSNmVMd095cFB2bkFPU1dm?=
 =?utf-8?B?MDk5UlB0eTFGekVBOWtnM0FrZ3BWY09zR0lhamRDMWZkaXFzRGphOXZkUTh1?=
 =?utf-8?B?dng3UEtENTkxbnpPelpmaVJWWE0xZDRvNEtEdWRXdXBRZElvdnVMcURvWnRZ?=
 =?utf-8?B?UFpGZGxUVDVZVUVXY2U3VWxPcWErY3k4RzdOaEhmV0FuUy9VS2t0YmdsK3BT?=
 =?utf-8?B?ZmhwUFIwbUl1TlRBYkZVK1J2aGZrL1ZSaFk1VXNFanYwdmRUV0NxdFh2V0dF?=
 =?utf-8?B?LzhEb2RDcDdPUDQyQUNpeEZrYkRzZ05KL2Q0dHpzbUpYeWFJQytzbGhqdVg3?=
 =?utf-8?B?RW40T0NqQXlndi83ZlN6ZC9seStwbDRQOWVIK2g5dFRSbGh4OGpsOTRRbWp4?=
 =?utf-8?B?OEdmdURValI1UzUxRWVNR1RER3BsWm5aakplV3lrRXE5bjV6M01MVE9sVGQ1?=
 =?utf-8?B?ZVlzeS9NQ1p5eXhnclhtQ3FRWnAzYml0K1lTVFVxdXZhaWFBYXdsYkhuSURh?=
 =?utf-8?B?dFRacGk2RDltYU1hcGRlNzNDbWJ5bnVqbkxxVzA2STdIMzVjdE42ZGdDWDFW?=
 =?utf-8?B?aEFlem1PQktHZmhkVVlLdTRxWE9pY2gxZG1ZK2dMY1RMRU1CSmVvMFpGWUc3?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XjY9IL8TIQVJgAak4zeBIHQWaBvhQd1rNpxLF7Qae72IsLyNpq18TvVKpWcqB0ipwG99dAOvWE46GfMU1PPmZ2LzB6xXMUMzmeLkW7ZSwCBfJ4cKUtm5K9B5vUqrpMQGEGaqnGpvs1jBc3hrPKdZN4UjdVyjAJd0jivRROQ5Grr/hvVF/2BfnDs2+lSBMHqzfwkD9CahLyZ3AFIeD8PKlczcIPI8mt9pVzBwmmHY3TbEp5o84PWfkgFERrmb8xy4qOOan0LNGmgdCFeWxsUSJcj6R8rbYOtF1QHYj6pA86GUDeU6qfWKMJtXimXylIhkqav4TohgO/09iFs4VS5bPcakuYV0m5/DTYPZkzsJdDF7o0tdRNRmdrYnrP2aXeG37hpXqly1rJxXJwF67LIoF36qBFJlFzXU3LkGz2fyiBjweQAHsEVh/Dv1bMZSIyOmKmzehz04rxYs9NbZN89DjbGxz7swYt1rY2tAxf9WCgArUvbGPVxuwdRv2AzdxJt8me/jsBKClpNgtL0LTjlU2660liGoZBtMjlc3++70btVMglouHD1bdZD3mgd0O14g3Wx4DRo/K73AGsaqKqRrJiDUM/MgTQqGJfq+bp7/Z9k=
X-OriginatorOrg: cathayholdings.com.tw
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5966.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ed03f8-f5ec-4bd4-1234-08dd928959e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 01:47:57.2716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9a3c2dd5-a013-42f3-beb9-ee956e5222fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e33XxMOobZJt22dNjkR9Z81odif0/22fy0QXprVHeqjA0LxtW0jtwCeMrqj7VzRttk+SE5ElDySHIQg+Op3QiEdDgX7i0RknK/8uqcD8g2wA5uSevdDBLgnxyBn0BcyV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679
X-MAIL:365mse02.symphox.net 54E1m51Z028606
X-SNFILTER: =?utf-8?B?6YeR5o6nRExQfHzph5HmjqdETFA=?=
X-MSS: RELAYRELEASE@365mse02.symphox.net

SGkgSm9oYW5uZXMsDQpXaGF0IGRvZXMgdGhlICIuLi4iIGF0IHRoZSBlbmQgb2YgdGhlIGNvbW1h
bmQgImdpdCAtYyBodHRwLnNzbGJhY2tlbmQ9c2NoYW5uZWwgY2xvbmUgLi4uIiByZWZlciB0bz8N
ClRoYW5rcy4NCg0KDQpCZXN0LA0KVmFuZXNzYQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogSm9oYW5uZXMgU2NoaW5kZWxpbiA8Sm9oYW5uZXMuU2NoaW5kZWxpbkBnbXguZGU+
DQpTZW50OiBUaHVyc2RheSwgQXByaWwgMjQsIDIwMjUgODo1OCBQTQ0KVG86IOW8teengOepjiBL
SVRUWSA8a2l0dHljaGFuZ0BjYXRoYXlob2xkaW5ncy5jb20udHc+DQpDYzogZ2l0QHZnZXIua2Vy
bmVsLm9yZzsg6Zai6Kmp56mOIFZBTkVTU0EgPFZhbmVzc2FLdWFuZ0BjYXRoYXlob2xkaW5ncy5j
b20udHc+DQpTdWJqZWN0OiBbRXh0ZXJuYWxdIFJlOiBHZXQgc3VwcG9ydA0KDQoNCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0NCkNBVVRJT046IFRoaXMgaXMgYW4gRVhURVJOQUwgZW1haWwuDQpEbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUg
c2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCg0KPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KSGkgS2l0dHksDQoNCk9uIFdlZCwgMTYgQXByIDIwMjUsIOW8teengOepjiBLSVRUWSB3cm90
ZToNCg0KPiBIaSBnaXQgc3VwcG9ydCwNCj4NCj4gV2UgaGF2ZSBwcm9ibGVtIOKAmGNsb25pbmcg
cmVwb3MgZnJvbSBBenVyZURldk9wcyB2aWEgU291cmNlVHJlZSBvciB2aWEgY29tbWFuZCBsaW5l
LuKAmQ0KPiBXZSBndWVzcyB0aGlzIGlzIGEgTWljcm9zb2Z0IGlzc3VlIGJlZm9yZSwgYnV0IGxh
dGVyIHdlIGZpbmQgdGhhdCB0aGlzIGlzc3VlIGNvbWVzIHdpdGggc3BlY2lmaWMgZ2l0IHZlcnNp
b24uIChNaWNyb3NvZnQgY2FzZTogMjQxMjI0MDA0MDAwMDc3MikNCj4NCj4gRGlmZmVyZW50IGdp
dCB2ZXJzaW9uIGdvdCBkaWZmZXJlbnQgcmVzdWx0Lg0KPg0KPiBHaXQgZm9yIFdpbmRvd3MgdjIu
MzAuMi1yYzAud2luZG93cy4xIH4gMi40MyAtLS0+IENsb25lIHN1Y2Nlc3MNCj4NCj4gR2l0IGZv
ciBXaW5kb3dzIHYyLjQ0LjAtcmMwLndpbmRvd3MuMSBvciBhYm92ZSAtLS0+IENsb25lIGZhaWxl
ZA0KPg0KPg0KPiBUbyBwcmV2ZW50IGdpdCB2ZXJzaW9uIDIuMzAuMn4yLjQzIGZyb20gcmVhY2hp
bmcgRU9MLCB3ZSBuZWVkIHRvIGtub3cgaG93IHRvIHN1Y2Nlc3NmdWxseSBjbG9uZSByZXBvcyBh
ZnRlciB1cGdyYWRpbmcgZ2l0IHZlcnNpb24gdG8gMi40NCBvciBhYm92ZS4NCj4gQW55IHN1Z2dl
c3Rpb24gaXMgYXBwcmVjaWF0ZS4NCj4NCj4gVGhlIEVycm9yIE1lc3NhZ2U6DQo+DQo+IC0tLS1j
bG9uZSBieSBTb3VyY2V0cmVlLS0tLQ0KPiBnaXQgLWMgZmlsdGVyLmxmcy5zbXVkZ2U9IC1jIGZp
bHRlci5sZnMucmVxdWlyZWQ9ZmFsc2UgLWMgZGlmZi5tbmVtb25pY3ByZWZpeD1mYWxzZSAtYyBj
b3JlLnF1b3RlcGF0aD1mYWxzZSAtLW5vLW9wdGlvbmFsLWxvY2tzIGNsb25lIC0tYnJhbmNoIGRl
dmVsb3AgaHR0cHM6Ly9jZmhkZXZvcHNAZGV2LmF6dXJlLmNvbS9jZmhkZXZvcHMvSVQtQ0Jvb2tp
bmcvX2dpdC9jYXRoYXltZWV0aW5ncm9vbSAiXFxDRkhWRElGU1ZJUFxDRkhfVkRJX1VzZXJEYXRh
JFwwMDkwNDgxMy5DRkhET01cTXkgRG9jdW1lbnRzXGNhdGhheW1lZXRpbmdyb29tIg0KPiBDbG9u
aW5nIGludG8gJ1xcQ0ZIVkRJRlNWSVBcQ0ZIX1ZESV9Vc2VyRGF0YSRcMDA5MDQ4MTMuQ0ZIRE9N
XE15IERvY3VtZW50c1xjYXRoYXltZWV0aW5ncm9vbScuLi4NCj4gZXJyb3I6IFJQQyBmYWlsZWQ7
IGN1cmwgNTYgT3BlblNTTCBTU0xfcmVhZDogU1NMX0VSUk9SX1NZU0NBTEwsIGVycm5vIDAgQ29t
cGxldGVkIHdpdGggZXJyb3JzLCBzZWUgYWJvdmUuDQo+DQo+IC0tLS1jbG9uZSBieSBjb21tYW5k
IGxpbmUgLS0tLQ0KPiAkIGdpdCBjbG9uZSBodHRwczovL2NmaGRldm9wc0BkZXYuYXp1cmUuY29t
L2NmaGRldm9wcy9JVC1Db250cmFjdC9fZ2l0L0lULUNvbnRyYWN0DQo+IENsb25pbmcgaW50byAn
SVQtQ29udHJhY3QnLi4uDQo+IHJlbW90ZTogQXp1cmUgUmVwb3MNCj4gcmVtb3RlOiBGb3VuZCAx
MCBvYmplY3RzIHRvIHNlbmQuICgyNSBtcykNCj4gZXJyb3I6IFJQQyBmYWlsZWQ7IGN1cmwgNTYg
T3BlblNTTCBTU0xfcmVhZDogU1NMX0VSUk9SX1NZU0NBTEwsIGVycm5vIDAgVW5wYWNraW5nIG9i
amVjdHM6IDEwMCUgKDEwLzEwKSwgMi4xOCBHaUIgfCA2LjEyIE1pQi9zLCBkb25lLg0KDQpDb3Vs
ZCB5b3UgdHJ5IHdpdGggYGdpdCAtYyBodHRwLnNzbGJhY2tlbmQ9c2NoYW5uZWwgY2xvbmUgLi4u
YD8NCg0KQ2lhbywNCkpvaGFubmVzDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18NCg0KDQoNCg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KDQrmnKzpgJroqIrlj4rlhbbmiYDmnInpmYTku7bmiYDlkKvkuYvos4foqIrl
nYflsazmqZ/lr4bvvIzlg4XkvpvmjIflrprkuYvmlLbku7bkurrkvb/nlKjvvIzmnKrntpPlr4Tk
u7bkurroqLHlj6/kuI3lvpfmj63pnLLjgIHopIfoo73miJbmlaPluIPmnKzpgJroqIrjgILoi6Xm
gqjkuKbpnZ7mjIflrprkuYvmlLbku7bkurrvvIzoq4vli7/kvb/nlKjjgIHkv53lrZjmiJbmj63p
nLLmnKzpgJroqIrkuYvku7vkvZXpg6jku73vvIzkuKboq4vljbPpgJrnn6Xlr4Tku7bkurrkuKbl
rozlhajliKrpmaTmnKzpgJroqIrjgILmnKzpgJroqIrlg4Xkvpvlj4PogIPvvIzkuJTkuI3mh4no
ppbngrrku7vkvZXopoHntITjgIHopoHntITkuYvlvJXoqpjjgIHmiJbnt6DntZDlpZHntITmiJbk
uqTmmJPkuYvnorroqo3miJbmib/oq77jgILlr4Tku7bkurrkuKbkuI3kv53orYnmnKzpgJroqIrl
hafmiYDovInmlbjmk5ros4fmlpnmiJblhbbku5bos4foqIrkuYvlrozmlbTmgKflj4rmraPnorrm
gKfvvIzoqbLnrYnos4fmlpnmiJbos4foqIrkuKblvpfpmqjmmYLkuI3ntpPpgJrnn6XogIzororm
m7TjgILlj4jmnKzpgJroqIrkuYvoqZXoq5bmiJbpmbPov7DkuI3nlbbnhLblj43mmKDlnIvms7Dp
h5HmjqfmiJblhbbpl5zkv4LkvIHmpa3kuYvmhI/opovmiJbnnIvms5XjgILntrLot6/pgJroqIrl
j6/og73lkKvmnInnl4Xmr5LvvIzmlLbku7bkurrmh4noh6rooYznorroqo3mnKzpg7Xku7bmmK/l
kKblronlhajvvIzoi6Xlm6DmraTpgKDmiJDmkI3lrrPvvIzlr4Tku7bkurrmgZXkuI3osqDosqzj
gIINCg0KVGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlzIGNvbW11bmljYXRpb24gYW5k
IGF0dGFjaG1lbnQgaXMgY29uZmlkZW50aWFsIGFuZCBpcyBmb3IgdGhlIHVzZSBvZiB0aGUgaW50
ZW5kZWQgcmVjaXBpZW50IG9ubHkuIEFueSBkaXNjbG9zdXJlLCBjb3B5aW5nIG9yIGRpc3RyaWJ1
dGlvbiBvZiB0aGlzIGNvbW11bmljYXRpb24gd2l0aG91dCB0aGUgc2VuZGVy4oCZcyBjb25zZW50
IGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNp
cGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBhbmQgZGVsZXRlIHRoaXMgY29tbXVuaWNh
dGlvbiBlbnRpcmVseSB3aXRob3V0IHVzaW5nLCByZXRhaW5pbmcsIG9yIGRpc2Nsb3NpbmcgYW55
IG9mIGl0cyBjb250ZW50cy4gVGhpcyBjb21tdW5pY2F0aW9uIGlzIGZvciBpbmZvcm1hdGlvbiBw
dXJwb3NlcyBvbmx5IGFuZCBzaGFsbCBub3QgYmUgY29uc3RydWVkIGFzIGFuIG9mZmVyIG9yIHNv
bGljaXRhdGlvbiBvZiBhbiBvZmZlciBvciBhbiBhY2NlcHRhbmNlIG9yIGEgY29uZmlybWF0aW9u
IG9mIGFueSBjb250cmFjdCBvciB0cmFuc2FjdGlvbi4gQWxsIGRhdGEgb3Igb3RoZXIgaW5mb3Jt
YXRpb24gY29udGFpbmVkIGhlcmVpbiBhcmUgbm90IHdhcnJhbnRlZCB0byBiZSBjb21wbGV0ZSBh
bmQgYWNjdXJhdGUgYW5kIGFyZSBzdWJqZWN0IHRvIGNoYW5nZSB3aXRob3V0IG5vdGljZS4gQW55
IGNvbW1lbnRzIG9yIHN0YXRlbWVudHMgbWFkZSBoZXJlaW4gZG8gbm90IG5lY2Vzc2FyaWx5IHJl
ZmxlY3QgdGhvc2Ugb2YgQ2F0aGF5IEZpbmFuY2lhbCBIb2xkaW5nIENvbXBhbnkgb3IgYW55IG9m
IGl0cyBhZmZpbGlhdGVzLiBJbnRlcm5ldCBjb21tdW5pY2F0aW9ucyBjYW5ub3QgYmUgZ3VhcmFu
dGVlZCB0byBiZSB2aXJ1cy1mcmVlLiBUaGUgcmVjaXBpZW50IGlzIHJlc3BvbnNpYmxlIGZvciBl
bnN1cmluZyB0aGF0IHRoaXMgY29tbXVuaWNhdGlvbiBpcyB2aXJ1cyBmcmVlIGFuZCB0aGUgc2Vu
ZGVyIGFjY2VwdHMgbm8gbGlhYmlsaXR5IGZvciBhbnkgZGFtYWdlcyBjYXVzZWQgYnkgdmlydXMg
dHJhbnNtaXR0ZWQgYnkgdGhpcyBjb21tdW5pY2F0aW9uLg0K
