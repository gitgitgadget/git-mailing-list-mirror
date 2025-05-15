Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021093.outbound.protection.outlook.com [40.107.192.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C00F146593
	for <git@vger.kernel.org>; Thu, 15 May 2025 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747330805; cv=fail; b=B7tGlYa08rIyywOWxT0KPUfkfQECpTmgK9fkAhJXQ5tNrULBCZtX9w9mGDbHQB9Xa4yCjbG7q5PH4hKBDU+7JS2BZG+2m3E8AK1Ps27qGcz7sCTDQMXWIncMnc/xn0cDCs49dwKHZ4ijUjRsy7XD2REX0tltMABxjsqQrd75ArE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747330805; c=relaxed/simple;
	bh=Rl0k5m6Bkve4X4X1ADxnmvnnAbS5g40vOEB2poYyZDs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GMObIp64fPgU7HPkBdd8d0DSNG7vQ0CVeYuzY+bML9IZq6zsNSwynLjChKAVx4Wzq3S5DBzOTRiYBKMoTj82G7P059uuSIjUhdBsTb1RKYNsL80TnHvgNrO6A4jco1zzjcC6CrPA7+RX/I9ySy4ZsMOUv5+KuRCgxElj96HiO1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=f6J2B8Vl; arc=fail smtp.client-ip=40.107.192.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="f6J2B8Vl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfX+Jb4oNnBkmslN9k1AsVi5/Gor2lqRGKBY7E+09IVaj+niL+oIyPJLgkzOKpOXQd1YrcorRkNdzKOePpXokXQmgPHw4ciKM0kp9Xf/RJdWfdd05HSrrafRMWh/dsjJ28qf0eiy7F11pSP8Ogi3c/KXr4SHkc/MLZ6bLhVyQV/Gm8DFDC0QNX7YANsc7/qKSWle/jmaSNRbbZ9YnJplq+9u4Vr1wWu5+AQJph24d6jUod0JBZuSu+BcfrUmZUNAuRXUPS8/nss7G4vn6fjzsJ9LDX1tqbQc9Upe9/d7GWzOyH4U/4N3wcYSjnID6n6CDJwQYPtCiKVakYRNoSkRPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJF7uP0z3udtelaqVhPhoFInqdtwxDhWtNmCC9TPhYM=;
 b=uYvTXSAkojMrShqxPLX56WjGlOBQIil9V48hluERUeIxs59bsmrlGxXG0x5KZM64ESK0UAHW0a0IDUhxvfH0ZouB3OTs3Fvw17E0hRw2/O0pubOdHkOH3uwbqGxP1USxoGgVUx3AZa6FN60g6pVzeQcLAZ1Q8gL4Yx6EAdQyuB03YFsRSm8Sz6eFTuaBuuGoOAtH8C46e/L2qLAbefSe4e23FTmgNM2xz1kco57ibU5ZweFhLgypPn2T9DQu7gnlUrQSILJ4v12iyI6EUeFTkL8/yR+BVOu8Z6fROh958JnSW0k4vXbnpH27AJwrp/XX0DyGEbN6qmXlsQWxt3TznQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJF7uP0z3udtelaqVhPhoFInqdtwxDhWtNmCC9TPhYM=;
 b=f6J2B8Vl63RiuTG/jlUTd0QXa2BBOCR4bvi8P1NMUv8lSn4BJq5e59Hitwtmlj8Iq9zSEAqP3R1b9uvOTCfk5Hv+CrptjQ2yzyaNkyYETGYrDCJcahuSH47E2psQpXSBKtJ+ZFMP8ZT3F1upPE8FpkJD1Z2qVMpwoPSdK/YjcH3nc2UoA/VmefugGPZOqs0iCO4djxcBaXeQ+rMVJ4gODKYpJTE1B7u+tbBdWZzXNwGs3FeL3aeEjA+PnmqpxVtjG6cDHVlzJJjwvGuKHoBG0E2fjoiDuA+hvXeVWmF56MAjcB1aDVh5YWMsv8nRlN86ag3ttzj6rqrB8LIrrc+o0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::10)
 by YT3PR01MB11312.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 15 May
 2025 17:40:00 +0000
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3]) by YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3%2]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 17:40:00 +0000
Message-ID: <a97db895-5121-427a-b64f-df225309f429@xiplink.com>
Date: Thu, 15 May 2025 13:39:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
 Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee <stolee@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?=
 =?UTF-8?Q?mason?= <avarab@gmail.com>
References: <69a10929-0e44-4ce9-af91-048b8404c752@xiplink.com>
 <87ecx0ijqt.fsf@iotcl.com> <323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com>
 <xmqqjz6sb15u.fsf@gitster.g>
 <7a6afafc-6dee-4a09-8779-83748a4d3fc4@xiplink.com>
 <xmqqldr789gr.fsf@gitster.g>
 <9109a8ab-d4b2-4ada-8969-bc72edac5ecd@xiplink.com> <874ixnjltf.fsf@iotcl.com>
 <xmqqy0uz7zzh.fsf@gitster.g>
 <0f491261-bbe1-474d-a240-0ddbf22cc754@xiplink.com> <aCXsKHiP4uIzCMrt@pks.im>
 <xmqqa57d3k1d.fsf@gitster.g>
Content-Language: en-US
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <xmqqa57d3k1d.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::43) To YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB10537:EE_|YT3PR01MB11312:EE_
X-MS-Office365-Filtering-Correlation-Id: 4413d984-52ee-43e7-892a-08dd93d78426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVFqV3ZJTEp4VzhBU1JwRlh2c3g1bTlpU3pPOXFzTGtZZHIzR1hWUmwvRDk0?=
 =?utf-8?B?c3pxYS9LQmtZcGJ0SWk1dzBmQmp5OVA5Mlo3SW80UnZNNVZtRUdzWlZTNFBM?=
 =?utf-8?B?Q1hDcjlOWmVrQkJBbVdpbHkxWldzUVRmWFA3anRIWXJrRUlQTXRvbklRa3R5?=
 =?utf-8?B?T0RuV3BJY2NEeHVCVTc0elNrSisrdUZYWXJHQlhocVgrclhYbktHOTBFRDNC?=
 =?utf-8?B?SkFuZW11QVR3WkEvSXQ3WGc2aTFKb2prVlkyQ2Q5cFlnVWJzWUhjZEhIL2s1?=
 =?utf-8?B?S2NHdThYdDI5OS9iU0FKT1NQcW96MzJLYm9hSVN6Y25pUU5VSVhPOHRvM1Bj?=
 =?utf-8?B?b0NYSWxvSFlDei9mUk5aRHlDTWdPdUN1NHJtbDNxVzRBeGFSd2NCaHFjRkY2?=
 =?utf-8?B?VTkwdW1JL29CWG1GdzIvZmhjMHcxUTNuQjRnU0VhTUt6dERaMitzbVJYNzMy?=
 =?utf-8?B?RW5yVlZ1YWJXKy84QWJMajduUFcxaG1tVit5Q3k3MURuUURFTWxLUGJEVnpR?=
 =?utf-8?B?d3RFdEwwWTFIZXN2Vmcrc21mVER2ZjI0eXdIcU9EbUMrcGFBNy8yekFvUi9Y?=
 =?utf-8?B?NjM0QkJEaURqenlsWG16UlJyUUhwcHkwczNlclFUMzdUNXpaeVN0SW42bGNn?=
 =?utf-8?B?RHpiSGNhaFBPbEltK0wzd2tYNTdxdldpbS9UY1NaMEhBR21tUXpYdmlRV013?=
 =?utf-8?B?N0JuSXZUekpiM1dhbThXT2sxTWNRNDM5NlVUbzYxTG0rN3BvZXN2RThWUXpL?=
 =?utf-8?B?VWdSakl6bktPVFdxN3JWVzl1R1dVM0dZNStPREI3MlArODROemY1ZTVZWUdX?=
 =?utf-8?B?RGJwQVpYKzJSWnVWbFRpbU5OcWhCQTVEcDlGLzQ0b0kvazFLeS9VOTRxRXdS?=
 =?utf-8?B?aFUvN00yR2E0Z2VNVzBIU0pOSm9BckpsTHFLMDVVaURTVnBCRlVsbWlEZjA5?=
 =?utf-8?B?L2VQdkZTOUtOQ1VXSE9aMDNCQmpMWVpWb0RHb1p3NFY2c1I0U2syZjlacTNX?=
 =?utf-8?B?MmlYMDkzQVUwc3I2VXFBTmhxSDA0YlZiM1lMVVNXRlpDY25uNC9jNUpZU2pn?=
 =?utf-8?B?bGIrN21ES0JJaFN6S3czWFQ3YUhTbDRTMjhYUTVCMHRZajRsSFpBQW1TTmFW?=
 =?utf-8?B?RjdiNURJSTdyS2F0NUs5Wnd5SDNXRXZ5TW9QVHM0bkhEdTN3Vm9RSzZxdTRT?=
 =?utf-8?B?VlBHNlF0V0pFSlB3WDhEUUtiR1Bza2NrWU5QbGw5US9OWFdSN3p3eXVuOUxq?=
 =?utf-8?B?d2dhWjE5Wm5xcFo1S1VldUc3N0hjZW85RW92TENadktYMnpMa3EzREdUZUJD?=
 =?utf-8?B?RFZ5TGtYSm4xc1FzV21acGpPL0oyU1E0bWI4dlhJbmhzdkdmY2svc2labEln?=
 =?utf-8?B?YitNU2xGOEozYkEzRCtic0loU0F2dUFDejVsRnpaV01CMmI2aVd3aktxcHZI?=
 =?utf-8?B?cTQ3SEN5bWpoZUgyVkRKVUIzUXI5aktOVlVqckE3WUUxQmNhV1NhazdTQXND?=
 =?utf-8?B?WEZRRXRjdURVMkU3cHRMN2hvL2puWHpTMm9STE5hZWQ4Rzd0SWMrOVlRak9Y?=
 =?utf-8?B?NXUwSXhra2x6Sm9BV3VsTWVWQjlQeDRoWlRwK0xRbWg1ZzhBVU5HREliUCtv?=
 =?utf-8?B?blRUQXlsQTI1OEloYlkveUNzTko0N3ZZZlpNWk5FU0V1T3Z1a3M0azVKb0M0?=
 =?utf-8?B?dWlxZ3VIenlqWDZCUjFHUUN3clAvSDI1MGZkRjRKc1o2cXpxd2ZGQ25JNjNC?=
 =?utf-8?B?RmRXeEVPQURXKzhFZE9vb1oyUXVtWVExclBtbjd4R1pUdzRSTlExQlJHYzVs?=
 =?utf-8?B?MXZTOW9lUmNWeDluS09nVWtqZUhNNEpXM2wyOUZ6SHh1emx2Uml2NXk1dExY?=
 =?utf-8?B?ZExjR0daS1FxdXg3UE82Z0s3OHIvTHBQbVpXQlAyR3lpUGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnBoTDg0N2VjeWJhWTh6Q25WV0JvSWQ2OHNqajRiVHRSZUZORkV0UmROMXlx?=
 =?utf-8?B?b0RaNndhU1NzbjVHRkZkN1hNVFB6K2RxT3Vac21xTGhqYzlQZTZka0hOeWU0?=
 =?utf-8?B?OVp5TG9KMFA5TmRBWUJjamd2MkV3OEdFcXZBVFRLeTAybmdMbEprWC85SnZm?=
 =?utf-8?B?NktXOXFBMmtHSFd0RUlxRUloc0tlWWxHSi9SMkxmZU10Z3l2VUlpbkFqWGxJ?=
 =?utf-8?B?Z1U2MWRqYklIWjdxMEk0R1JoTEJlK0lXNzkvai9pRXNWdlpnVHB6UDNXWWN1?=
 =?utf-8?B?K3VvQlREVng5YzhaNUYvbVIreFZGb2IvNUIxODF2Z0FBSmc2c2xWbk05azU4?=
 =?utf-8?B?cWdZU21tOGNGZmZaT1I5cXl5cXZXd3pCKzdGYjhJOFFWWEVhb2FkUlNGazhX?=
 =?utf-8?B?WVZqVjhKMVJsZDEzNVh5SndjMDRTWEh0QXVwblcreFMzckNqZWk1U0JMbUZY?=
 =?utf-8?B?MWJURHp3SWdOb3F1QjZ2T0sxL1pJb2hUZUxpekcwRHZZOWkza2pNT2JiQ3Na?=
 =?utf-8?B?OEF1clFLS0RjTnd6YTVtUmhVa3dqaWgxM2VrRG5Ja0w2bEIrZkEvMDcvL2dC?=
 =?utf-8?B?MytJUHBPS3RGMTU1V1hOeEUwbVFaRkU1R1lvV1daYmZpeGF3TTVHWGNOT0FU?=
 =?utf-8?B?OWpTNGJpV1dhWU1Gdm9ZZzJJWmprNU1NdnJjRndFeUs0V284NGR6Qk5rcEti?=
 =?utf-8?B?WG15L1ZjMFZya3J6N091WWxFL3F1R0Y4bE04ZnB6R1g2VXdveUlROXFrVWVh?=
 =?utf-8?B?aTBwM1E5eFlKMWF0QkdQZGdLZ1VlRkNpZUlWU2dtamg4L1VVRnhxcGphRmRj?=
 =?utf-8?B?WjdqdldzdHo5ZktmcFpUaW9kaGJNc1lzOUNKaDhVSnJ6UFNrQlNxbkVzUXlr?=
 =?utf-8?B?TmFoVlQremVTb2ZqUE5EMWNzbExWNHNNaEJsdC9JbXIrY2JQcmU2ZUR1RjVp?=
 =?utf-8?B?dmlMeUpoRXJmOEVIR3pzV3RWd2prcnhZNDJ0aE85bEtYSzBjLyt2OExpUCto?=
 =?utf-8?B?Qnh4RXFubERaWHYrZEVmQUxNdEJscHkvL3E3KzhuZ09YZEdHRkozR3lKUGYx?=
 =?utf-8?B?MEhGOUZVWldZK1lLUmoxWDZXaGdOSEhTbWpSQVJERXRTSFFiRGFXeGFWK2Uv?=
 =?utf-8?B?eVZJbXhtU05rdUcrWVloTWFkSUdpMUVRRVJjTDMzR1EyS3R5VGo5Q3g2SFoz?=
 =?utf-8?B?VDlVRE9TekRmVFJVU3d5eFFvODVRMFFGWWE0cjVpa255SlpqNS92eVBJWmFD?=
 =?utf-8?B?eXVQMjhoNDdPOHJWUEpSSmFxNHFtQlhWWllRUW5xeXhLQkRmL0UxSW4rTisv?=
 =?utf-8?B?cE5ocFpZRVZmYzZmR1NMaE1uVDNPZUlxTlhIM25WRk8wT2M1RWtQcjY3UW5C?=
 =?utf-8?B?TzJiZnZJOEhRZ0FpWUM5cWFZOFpLcXluYTNoZ3gxTVU5OGxVYWh5VXo3dEFk?=
 =?utf-8?B?OUprOWtxbE1DVFc1cXozRWZkS0xMSmpHWVprRGlCd0FEVEFhakgvb3hoVmJH?=
 =?utf-8?B?WHV6UXlmQ3BwMXZpUVFNNDhoOEZtd2Y1cVBnaE50Zk9LYkV5RjJKaG9vZHZB?=
 =?utf-8?B?QXRvNGJXSm9yU2x2UU1pWkljN1Q0K0ZENk5zcG0vcWFpRHJMRW9YUXd0Yi9k?=
 =?utf-8?B?SDNvNk56YlJ3NjFaTjl1Q0tnMkp1aHY1SFVEbk1NNDZpY3BLeDdxblY3NDla?=
 =?utf-8?B?bEdjQjJXRVJ2aVlsUjBUTmsyYzF1MmwyRGI0V1c3QlpObGdBRjg2djdtWUFC?=
 =?utf-8?B?eTNXcFllVUNvNzhnaXBqTzcvMEVtQVVUNnlBQTNWL0xZYXVLczVnUjNFelR1?=
 =?utf-8?B?YjlHRndtRFpuZ3I1UFF5dkh4RUhQTzI2MmZINUdtbDRYNEozaVJjUFppdW42?=
 =?utf-8?B?ZkhPS1BnaW9sUnNUNXlRLzRCN0xMcU5YQ3pya0hPZ1EwTm5QZW9Pck82MlJ6?=
 =?utf-8?B?SUdZNk5VK2hRSWYwUTluRkFMMWJjK21sdDVSSnRxay8rSEVRYktnODVKSUti?=
 =?utf-8?B?b2ZTbHo1aXg1M0RzSlBOVHgyM0kxTDhIRU4yODNKQlJNcldWRHdkdThmaU9j?=
 =?utf-8?B?S2Z0MFNUZW8yYm1BRGVjUVdXVHJENURQOVhPUT09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4413d984-52ee-43e7-892a-08dd93d78426
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 17:40:00.2244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74/iI7PvF7YxqvCSkOPwbnhdiURXtBn0grM7LECvKv6A9cvL5DXPPCbWWb4dNSGoJWTEH3eMuSiuSDhnMD1iTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB11312



On 2025-05-15 12:39, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> Curious. Isn't it exactly the same what git-blame(1) does though? Taken
>> the textual representation of a tree object, we figure out when each of
>> the lines has last been changed. That to me sounds like exactly the same
>> thing as git-blame(1), but just for trees instead of for blobs.
> 
> That's mechanical worldview from the viewpoint of those who know the
> internal representation and workings of Git, I would have to say.

I interpreted Patrick's statement in the exact opposite way!  I thought 
he was speaking as a normal Git user, who is just considering the 
semantics of the outputs: both are fundamentally just lines of a 
Something (a file or a directory listing), each prefixed by a commit ID.

> As an end-user, I view "where does the body of this function came
> from" and "when did I touch this file the last time" quite different
> and unrelated kind of queries.

I can see them either way, depending on how I squint.  I have no 
objection if people want to think of this new operation as 
something-that-is-not-a-blame.  But then don't call it blame-tree!

How about last-touch?

		M.

