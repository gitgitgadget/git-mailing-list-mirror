Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020142.outbound.protection.outlook.com [52.101.191.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC1E278E6F
	for <git@vger.kernel.org>; Thu,  8 May 2025 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746717180; cv=fail; b=FYxS5UE+i4cvPfHIfeumVQa239iKy2yIQ1jOZGuz5P32MQXFBAwRCXtn48KlwoSY536jtKU46UaGYWCn856ptNagaVPhzPxNSzO+ev9fI95PXLmFX2lU1Djb4De92kWag1N5BKqzI4xHZdD4OQKXpHPUof7xkEdcZbZ9H0uyqNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746717180; c=relaxed/simple;
	bh=3eJEnLnLTY//ie4rgsFSkxHxErmKya0gIUJvDp5BNFg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tcqLh3sCbvlHZqNasbZPAvvj9ebzs7tKUWQDGm9byll9biBAFSa7KSxWQymsr9zu1WlpOI6Pj4BOdKEB8kZ7VgSyI/qCYjXU4czes8OtDNC992T41PmdjxGUezK86MQ0brwyTxqfJx1uhjR5mHp8OhO5HyoOdZW2/wrXhHy2BbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=fmC7jV9S; arc=fail smtp.client-ip=52.101.191.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="fmC7jV9S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6Qsg64dbHuGCztU9Wu1mLDmJO4z2zV3ZkqD+sD1icKUvCBZ/q/Zoo9/ZTMUhGn3cMg0ZqjbH/CghY7xZgrt4+kzDZFxfzhsh3Bqn0V72OrYgU1kznoZ2T+zA+pOo4v4gvvoglytD7gFkLpt9QyiHMkMwO3jALiuIgAY4e54OUVta0rhUR40XQwsuIJ96EtA6osAS0jvz4FUE0xAj4lxUovfGqdWyE6LO5cGaxfVq2qmXXqBcADcbuqXLJq2cr2ghRA6yIMuB0chV6W/PF4c7ImdFyS3EYORc3qtNRd9ItvqcANfBTZ1rs8BGK5b/sWP/ElGN6E1D2uUQ5AmDhVCPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZVL3WVTw/kMSaN1DtzRvWyMn4Y5Q3rFL3OznFQBI20=;
 b=wfQ47QF9eAH86QDcrMtlsvdllKCNNSCgZSInfLbVS6nwJC7JrzOawbSRNu1MOqL6T9kPwSp2fhWjvJXDNS79dbRM8hlSOwzu+ZPAUILkh9DuVsqP4uTL0FtzqPDGbXskaOudMM4DctAE9FI3svi2iBYVDBds0Y8msuim5L3aLMDUBEECZGx4sx5ExPvjM2EhqvMN0PojP9MRXBnrR4xymbog/KA9wezATP7qlXU5UA8udCikYBseMCS0KXdREZ6RZPdsrusuxFAqg6/tT9erHA4fyXIHKYf3WJEFk+0bCkPm3fYa3XIhAUZo+6AGIoqcr6CcWug5L4G1uVv/mTz9xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZVL3WVTw/kMSaN1DtzRvWyMn4Y5Q3rFL3OznFQBI20=;
 b=fmC7jV9S5yUBWSs97MTBLz9tgas2Wj+c16xeoSx1WQThLs5yT9jj5pzRCPukNz836fkKXA3DOhwUgE61iCxO/D+TStJ7xQcC/f6xq6d6YE0UAkwgeW7ZxFfmmJBVDpNvFdAOgMBOL/lVNwUa5VcsmqWYGmvgD7lBnl0xm25FitpVAdrF3/UGG3JSgY9FIwCFE29q1W72XSELHgBJJ97irwpuEvlonIShTDm5ZZGHEf93jH6xtXhleXWNpXRulrwVllJUU3ekJXCTFLfSXOeaJxtfxUwPXuVGo7XnFfzpJvNjHUdiIpuofvqTF+GSYtoaIzS4wU4cHud3J2roOQ6qjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::10)
 by YT2PPF3953F431E.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::42c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 15:12:52 +0000
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3]) by YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3%2]) with mapi id 15.20.8699.030; Thu, 8 May 2025
 15:12:52 +0000
Message-ID: <9109a8ab-d4b2-4ada-8969-bc72edac5ecd@xiplink.com>
Date: Thu, 8 May 2025 11:12:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
 Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee <stolee@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?=
 =?UTF-8?Q?mason?= <avarab@gmail.com>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
 <69a10929-0e44-4ce9-af91-048b8404c752@xiplink.com> <87ecx0ijqt.fsf@iotcl.com>
 <323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com>
 <xmqqjz6sb15u.fsf@gitster.g>
 <7a6afafc-6dee-4a09-8779-83748a4d3fc4@xiplink.com>
 <xmqqldr789gr.fsf@gitster.g>
Content-Language: en-US
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <xmqqldr789gr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::27) To YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB10537:EE_|YT2PPF3953F431E:EE_
X-MS-Office365-Filtering-Correlation-Id: d59929cc-8c92-4a49-8b17-08dd8e42cd54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXFDZVJreFE1RHMwNm1DcWFYekliK0ZESllFWENYWC8zUTgwOTJBK0JQakU3?=
 =?utf-8?B?Z0orZ2NIZ2o1MndadGg2NkFVYzBwYkZaVWF3N1pUSUkrNVZSUHhwK3dURWcy?=
 =?utf-8?B?QmNlWFVGdERHaStHSncyWTkrWW1oYmRaTlJvSUxkd05UaWdrdnRBUGpWK2Qx?=
 =?utf-8?B?Mm1jMHVqTXdxV0FoaWxPRldqaFMrR2ZxQXZ3cUZrMnIyV3I5TnNQcDk1VUZP?=
 =?utf-8?B?NUxUT3dheW5RMmRDb2o5c0w1TkxnN3N4Z3hnTENMZFlTWW1FZnVPYWtMU2FV?=
 =?utf-8?B?NUJoNUFhQzMwZm45UkVCbW9lY1p2eEczZUdZNm5pSEwrU2k0OHEwTFpRSkJT?=
 =?utf-8?B?UjBvK3hycWh6ZXJJcExGQlJWS0FzWW5xckw4OEVNTGdTYlFnUEVISFJJWWs2?=
 =?utf-8?B?U3hqb3hIOXFFa1RtbXVtTU5wbWRjNVpvV3RpZjJLYkZ5cndjNUxJZHQ1ZURv?=
 =?utf-8?B?ZmJGa1ptS3VqVXhYOHpqQmVOTUpUOWxzV1RkbnExMWp0emhkWVpzcVdaUUx6?=
 =?utf-8?B?RCtmNnJIZCtjR3ZnMjRmcForOWJiVGJSZENIVjR3SGJ6a01aMm16MEVFSEIv?=
 =?utf-8?B?WHBvS3NhMmZobWM3SzBpM2lJNkVDQU5sQnhneVZkU0tRUno5TDNjdmIzZm9V?=
 =?utf-8?B?djYxRWxRNE9LS3JiOXRMZTc1VVhmNG80bTkxUTJsQzFqTk95NDVWOHYvWXdX?=
 =?utf-8?B?bmFZSmxUZ25mMm5nN0ZpSC9uUlJ2U1hIYVROM1BGR00ybU9GQ1Rrb09VNUJG?=
 =?utf-8?B?WHBvVnNWNEVQTWUwek1PTW5xUTAyWWN2K2NqUmJQWW5MTFpFenNpNmRoTHNw?=
 =?utf-8?B?NDE1c0lqZW96Sml2amZPdDNzRzUyQ2VBS01wQ3VJelFTY0J6ZHdCR3UxL2lk?=
 =?utf-8?B?ZERuWitha3lTS3lSRlV1VnM5SFVUU0FBaEJPM2VKaTBjREJ2MjhSdWFLeDJZ?=
 =?utf-8?B?WWU1QStETG5QSFEzN1NmRmo2dUhORGRVQUtPZTFLQi9SdXVERVRjb0pOcGVD?=
 =?utf-8?B?Q0x0VGVZWDRYdUs5ajFpbUdSMkdGMDRUdTZDVHdPbnowQ3F4QVJuM0dCTjAr?=
 =?utf-8?B?S1dRU3ozRTdBZDhJRzBXL3E1NGpYY0hndjVSTHVsT0lLZFhJVUYwK09pRmRG?=
 =?utf-8?B?dFpVcGJuYldINmVtdWo4NmN3Y0N5dUw4cm8rR2ticm1BQzVmZUF0bUVBSW5n?=
 =?utf-8?B?N3JnTGdsbjU1SDc2Ky93eDNMd01IaHQzR29LREJpREFqUDFNK0pqbWVuc0Vx?=
 =?utf-8?B?OEhzY3BPVTlCaHJrNmp3QWJZd3VDNmwxTk41bW1LUkhuQzFwTUJlQ2paeW01?=
 =?utf-8?B?MnE4ekNYRWhXYmNTRjFFdWtrVmQ4eGlpUVZuazZqQ1FoRlB6TlJIZm90dzNy?=
 =?utf-8?B?OWtyQkdQcjFwSSs5Q2ZnVFdKc01WaHR1VDFVdlhCT1M1ZGpnOWhSY3Q4b0Rx?=
 =?utf-8?B?R2hkbDRkNWx1ZzRrOC9tSm1pdnJjeHAzMmJncXNxb09xUGQrUFlLZkpTZStB?=
 =?utf-8?B?cXE5dFhQbjNPQ282ZFU3Z0JyY0xsTmdLK3FMSmh1UjBNZmx5bU53ZTlTY1J3?=
 =?utf-8?B?VEVzbVlKL3FrQjhubGFCcEExTjh2Z1B4Mit0UmFzY3VLNjBKQjl4UFFWMXh0?=
 =?utf-8?B?bEp2Yyt6YkcxRW9aY1Zxd1VKbkRyenJIZ003MjhyQVIybjZkSm53cFVLaDV3?=
 =?utf-8?B?VTI1UGlBWFpqYU4wOTJJSGZXK2NOd0xNT1JaOWZ1VUxBb3BnVjJwRW5ROEU4?=
 =?utf-8?B?OVp4U0ZBYXcrQ0RTbHkzMjJ0Y0FtYkZkazVEeEFIb3lsZjFqcWRBR1NFU05C?=
 =?utf-8?B?dERHRjcwK0ZIR1QyemhYejg4TEJwMnBJbTZNTVBpdGhmZUQzS3JMOFBoQnRh?=
 =?utf-8?B?RlM3K1pocGhlQ1QrVTVkbDdKb2EvL2FIcDFDNkJhN1hEMTVUS1N1Q2ZXMXhw?=
 =?utf-8?Q?nh7+lbkp0Ug=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0lBelQ5U2RDWkxFUEJtbVlMbzBXOUdEMXd6UUwyWDhTYmZ4UDNjV3hTbGxO?=
 =?utf-8?B?T2JYbzJHUnhYa1BUVlZSSDc2NXBMUUYva3Q2Yk9XTzFnbFNlNUFkVFRiaUNO?=
 =?utf-8?B?cXpDQW1TY3BWcUM5cUthMHJzN1ZhSTNIL2pNRTZPaUoveDg5WGVqb0dQN1Zp?=
 =?utf-8?B?WVExNnNya21mY0lWcDdJMGp5NGx3QU1LcDFxblBISXA1Q1AxZm0zU2ZEUGZo?=
 =?utf-8?B?VVB0dVU1VXdITk1DRytENmpLWDJVcC9rQzRQWHJScGl5N0xJTWpmT0VQMnRP?=
 =?utf-8?B?UHpZeXRsR0FYMkcyU2J4eDBncFhqbStJY294Z0ZVWTdURmlJa0hrdHFZOTI2?=
 =?utf-8?B?dm9QV0tHNVVUV2V4bW9OdUVucE9POUUzK3ZJb3lSSDRkUExYYnZEelBkNkpQ?=
 =?utf-8?B?Q0ZXamlqUUxVMG9qNE4yc0NEb000MlVpVnQ2cUZwNFVaWlVMODkvM2tQZVB4?=
 =?utf-8?B?UW43V2V2c1VJYXErWGtPdWdBcjU3QU50emhiQVJOQUlIR2phc3N1RmRsUUJx?=
 =?utf-8?B?STZIS3phMm1rTlNUNmxwKzRVbURETEJxRDIyeGpUUWJKVThVMDJGQ1kyYzgx?=
 =?utf-8?B?OVBTSmhMa2tLR0lneFVpMGtHdFNRTElqM2xRWXA2M2UxWlIxdWF1a1hCc0x0?=
 =?utf-8?B?dmR4REhydnVFeWxKVWVFYkFyL1FJdEdKTDRIVUxCR04zTmx5R2o5S0UzOXN4?=
 =?utf-8?B?TGY1aWlIaFg3Wk9tWmw4QVZFcHFBWlNOSzJSYm1VOWlEU1k1L0VkYXRWV2F2?=
 =?utf-8?B?Q1RMaytEcFlEKzZPY1czT0pIaHFFQkI5OFdkQ3ZJR043R2ZKcVRzVGp1MXdR?=
 =?utf-8?B?VTd5Q3luaGQzTnFpSWNTNVcrM2FHZlVFa3NzRzZLbWZ4QklZU0RHOFZpbExt?=
 =?utf-8?B?cHc4a29CRWVVUjloVko1eHM1ek5kR0RtZDZkQU81cmtzUG9rTEpERXkyVkd3?=
 =?utf-8?B?dDJjL2p0SXlaYkVVZk5VMHFvWjUrWEgwb3hnNzN2ek1SdExlQ3MxSmJPQkVz?=
 =?utf-8?B?amZSQTcxVDBsOEkxelMxd3hNQmZVdXdlcGhFbkY5Rk44ekthM0J5Y2orcWsx?=
 =?utf-8?B?Y1QwTndnSUJLQjE2RnlYV3VtcjZENVJyS2lTOVdGTkp4L3U5ZHhjTkhCSjBU?=
 =?utf-8?B?T2xLTUNoMHhnUDVYWG5CNWd5ZjAvdXpRRGM5M0NTai9BUU5MMzU5N0RkVEpa?=
 =?utf-8?B?SU84NXhGNkw0OWNXT3NSMWJHVUtyMkttVXMvZFAvU2JNOWVzZUdheWxoWjFh?=
 =?utf-8?B?eXFzdTIzRVQvNU1nYlFKd3c3aVBKNHNOdjlIMnQzcDZyakhBWVcwVmw4TGNi?=
 =?utf-8?B?TGxJM0Z1NFZ5STU5VVpMalJMK0o4TFJvbG1vZ2I0bTNXYzh1WkRtUTZwVUhH?=
 =?utf-8?B?UEpkS3hUMVBOSFpDZlR4eW9iRUNPd1VFWWNHNlZiVWFQblN4emRsNmRIa3Jt?=
 =?utf-8?B?WkZ2UWhBMHY3eVlKVmNoMmNUUjk4Wk1DcVRvQjN5SGpsLzBPTUtlOUFydUsx?=
 =?utf-8?B?dWVMNGJ1MzJCaklxRDhNYmo2akJQRmE4dDE0Vk1lbEQ3WXlCYmRiUytBeW8v?=
 =?utf-8?B?N2VhNSs3WnVNOGM1STFROGFESjYyZjY3ejViTVFWOUd6ajZUZkg3TXh4ejdS?=
 =?utf-8?B?bndQdlBZbDdxTERnWTNHbU1PMWhENmg2NnZTMldjMCtPUmNGcVBjQStwRkl1?=
 =?utf-8?B?NE1YbnF3RWJGS2ttdUg0V09vTFdxR2FtWS81RXh1NjRob09mdVpvaFNua3E5?=
 =?utf-8?B?d2ltejQ1Ri9mTU9mUTR1dCtZSEIzOFJhaENJdmczSndlcTZvZnk5cDNXUGU0?=
 =?utf-8?B?bFViWlNrcWFtMFNaM2FNWXo3a01ydm0vbVBSNVEwTnBTSTUxQUY1N0pReGMw?=
 =?utf-8?B?TE9RMmpNRlprN2Jac3RibnpBV0t2Y2d3bWJWM0FkMmhrWEEzR3d4cDJsSlRZ?=
 =?utf-8?B?bUFsSXpLUWlFbUloZktxV2NZc0ZzaU84TDlCZXp2ZEk1ako2dG5EaXRIVDFZ?=
 =?utf-8?B?NTBsRmNzblpjY3RTWGJVTHQvMlFZbFltTEtGRHU0Y2RFdGl6Y1g1V1Q1cVdi?=
 =?utf-8?B?ckdzSHJ6ZnlYL2ZPN0Y1dThFMmcwOHBpbTNVQT09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59929cc-8c92-4a49-8b17-08dd8e42cd54
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 15:12:52.2485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /v9VnUFBZV+BYKhp3UdeINTt8+ELLOazzWk3rQqe9rSLHBxHSdWr6YRuCxnhbSeCGHyGMvN56KKYNmRU6do8zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PPF3953F431E


On 2025-05-08 10:26, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> This distinction brings up a wrinkle in my proposed DWIMery: should
>> 	git blame path/to/file
>> show the annotated blamed lines of the file, or simply display the
>> last commit that changed the file?
> 
> I thought you switch to blame-at-the-file-level only when you are
> given a directory (or a tree)?  "git blame path/to/file" has ALWAYS
> done "blame these lines that appear in this file", and cannot change.
> 
> Of course you can say "git blame path/to/ | grep file"; as you said
> yourself,
> 
>> 	git log -1 path/to/file
> 
> is so obvious, we do not need to introduce yet another way to get to
> the same information, I think.

Fine by me.  I personally don't think of "git blame" when I want to see 
a file's commit history.

>> It also occurs to me that
>> 	git blame path/to/directory
>> might need a way to toggle recursion.  I suggest recursion be off by
>> default.
> 
> I do not have strong opinion on this part; I've somehow assumed
> while reading your message that you wanted it to always recurse
> (like `git ls-files` does) and I thought it made sense, but not
> recursing and just showing a single level (like `git ls-tree` does)
> with an option to make it recurse is certainly a possibility.

I also don't feel strongly either way.  It just seemed that defaulting 
to recursion could end up creating a lot of processing (and output), and 
that making the user explicitly ask for it seems friendly.

But whatever the default is, it does seem useful to have an option to 
control recursion.

		M.

