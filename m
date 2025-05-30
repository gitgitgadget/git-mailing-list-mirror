Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011030.outbound.protection.outlook.com [52.103.67.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80152367A9
	for <git@vger.kernel.org>; Fri, 30 May 2025 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748625571; cv=fail; b=sFnw7Sff8EaCZNKNDZKTtlAi7UKo4lB33WLvRAfh5HLfBLmisi/s9UQgYcJVOrspphXtF8AM+iW/LfsJrSnafoGXZNogIPe2SJLq/kFBQWimMlxqmcwbxOEzHkDPljLF0FVO909gLYAZue5WcOt84jz94r0lv2VPiZLDx2fLFwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748625571; c=relaxed/simple;
	bh=QtDB7n3GxRemZ8QernnFCwWOigaXzOBsEyNJMW/GSTM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N9S+EVk7mogp2uXrIfFQADIfsHbDsqwkHSQ0AWyQYH2L55atMNHkxouIaI7/vDG8jV54M1Sro7g77ehmyK8oKJ/Po5Rx84tePZKI7yuDCOnzdpenKfNyOs3sJZ9hPOrFpkPH/dz2lDWc0eAW/YZ374jmRqBfAeQTtGv5cJANU80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=MLr1sBZg; arc=fail smtp.client-ip=52.103.67.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="MLr1sBZg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1XAN0YeCDxtWNMrtx9qByhLRCFMUHWTL7VgHYH3om8Hc3tl54bKQupRcd/VTLVaGSu1jCHrWc4S6zLrYGkNiz4ok7BecwPzAbm3b7E0VrdpEh0f5ICC3MKyaER7W5xd7qQVGLdcqaz0nanG8rmmv9ZR6epSzucOIo+M0jEUzmLwS+n2YhUCvgP49h4bwyebYfm0LHqJU0SbXGp6tnVCi1OtgA0Qc4YejFu/K6O4jQZQgpVzO35XqL8VVTjaB6xXEXhfELzSqYIXQObSJxcXgCssfxD9EpihGuqIMCsoOdWYmwqM1sny8nqzVXf/MM77BYvon7vvNQVRhCSkLFHpog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qx5HdQdU+0MUyTuEgahT+WOf6VTkpcrfsO1gOc3KvSQ=;
 b=Xt7ON7czLGW4lV5nMt6wGwVJuWTOtjoifgXrAw916083yfLWMbGGvbXwnAFpNIv3cqdbPblpUPeSQMfeD3LBKq36czboWkdzjYxV6v8WRvlF/gxnFZcGhQzf+JfuaF8lit+wxYeh7VWZI/+4lNC5PKs91fFmM1q/eMKQ0xstHBeHp4tVtqTVialpQSs0DQfe3TyMYESqRtxpk1Mb9uco508XfyVFeHVfzlXGy7R+g98ehA3EiYkaKeE6Ou5tPY7+QvzAf2kKkk8lL1DdEswiR5O2D5WxTk/qS5IYdFWqZZB8HMYmegJORINGBOOum1XkK28Ob2enjVI6dIu5b5Kz+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qx5HdQdU+0MUyTuEgahT+WOf6VTkpcrfsO1gOc3KvSQ=;
 b=MLr1sBZgd8p6iWsKosndbKLtb3IEowxHccj9C2GsaWuPjhDFdGHmL8S5HzBFMezyCK4cKv4NyLRoYksLPtvKel3Un0PuzhdwXyY6GiZKYjiqFkDd+K/uk1D1yMOyjdaJ9LODfTWN1z8zSmrTjbabpDZJBlzZaoLCUnDQidJk5NT6MyGyusIrEehKRAef08pHCAh4JXeT8829uENsvWe7So4a0QlWSLezhIcRxz9yLoi+8CXEYVlTpqgeWeSsSmVWLVqOAIc3Ucc5FZNi6V7OYNyWobTNXqErVg4Bu7V49072xza/gZJIBhkpOQtASvW8Y2m6gw7Zewk2DvDwUQTdrA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Fri, 30 May
 2025 17:19:24 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 17:19:24 +0000
Message-ID:
 <PN3PR01MB95974BABA153882DE494D06EB861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 30 May 2025 22:49:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] docs: improve formatting in git-send-email
 documentation
To: Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 Julian Swagemakers <julian@swagemakers.org>,
 Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250528070521.17379-1-gargaditya08@live.com>
 <20250528070521.17379-3-gargaditya08@live.com> <xmqqa56vl1uq.fsf@gitster.g>
 <PN3PR01MB9597008B30AB91C9539E7C8CB866A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <877c1yb53w.fsf@gitster.g>
 <PN3PR01MB9597DEE8C41CB1599B9A97CEB861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqbjraf29c.fsf@gitster.g>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <xmqqbjraf29c.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::14) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <8a7196a8-c78c-4501-a1f1-342054b3d222@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 6636dc79-f206-44ad-088a-08dd9f9e1fb6
X-MS-Exchange-SLBlob-MailProps:
	Mga27o8vReFQO+5d6ofa7WPjBVpSbrYu2mbaRurGGCB1dv/fpEcvw6hZtPf8rVruYnwwfUCvXpj8kkwekT+1pz95pa2UiokEa9JCr5jcbasQC40h+t2FdS+w3sP/kGSyepyIhU6VHkd4iQmvMmKYFR9zt2Qtzt4Ukyn0+dubbHBrwRqg9MlCRT9svjRrVpLIurKEgjg14K0oSExoNXfHNlFCn3Cfcb2a1icspoj0PsigF16+CpmsNLAkWgE5juEVX7tN74rodyuazc6to9Oc9M/iHRNG8OIbDSdlYe+R9AMPueIMFOaP+cf4S561G8xAMY6OXwjqXdcQKZGi43cKQjkK9WwHpDOhKX+xQ1WjM9KxLdbzIZ5BvBBqoc6vjoSbfg2q/Oi+W3Sy6wMwKPNg72QklA1pyRPddirEfdp/4xO4pFNkoAob9QXmwWjtMawG9fR5DkBv1brO4GQ1mVMEqraumYlIib2BPsoW4k6iSZJJWMI9RjswRcNzc3TpnEayCCpHGnVHdKKgdGNeq8hoIqaydLUOU4Qka+l8TfeD9JFbY33aASKT2wFqGYoLhrPFWniCdVXUmEQIPZ+ODfU7IqFu/WjKkDjkBWGV96sCPLGiMVTFNSeapOPBw5UVzLywrk8ptRSuo29iBjcUvcX5cu1dcFLNi0mwjUubHToo/MG/jzGLOPGjdAwW4xoYoM750kXMjNfCxco5nB7WWSJhuqiv7T054i/K4vAbz9QjZJhYgYLbReCCCtQd6J9xQMmtz22L/inphgX+dPfC/PEXfVJ73bhA6Cd8V+jc3rrJsIMY6RufuLIObg==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799009|461199028|7092599006|8060799009|5072599009|19110799006|6090799003|440099028|3412199025|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2xTSGdpamlGMzZ2VGM2Y2d4UlpaTXVnbWxMOUhOWFB2cmZUclQrb2hNMndr?=
 =?utf-8?B?SFJVeEVYNHJyMFFVUE9hTVJ4WGRqR0Y0bkRBYTlMNjFONTN6N0FQY2ViWVQy?=
 =?utf-8?B?MVlTUTdiQlduT2dCd2hMcWlsK2ZhOTlPT3JRWm9udHI1QXJJdlpPK1dnVWxs?=
 =?utf-8?B?L3E4R0FVS240azhpNHNScXJaMzZyQkhoN0Z4YzFvRjJObXkvbmkva3BzLzJx?=
 =?utf-8?B?TGFmZTZpTUVKdG16MmRneWNma3RrTWlDcmdxT1dTVnNOWlBhMkF4REJzOVlN?=
 =?utf-8?B?UFdEdE1mTXpkV21XSWVORFFwYVY2VmdwWk9EZnFuNVVwMlEvUUlmR0RvOEsw?=
 =?utf-8?B?TGtxdmtvM0hwV25xUmlOWHRjZ3RxTnAxWDBLdVZLUjdFYThsaHEzTTArRmVX?=
 =?utf-8?B?ZmNqRi9xUzM1emRSY09LalhVbTM3blRPeEY2RDhrVGVTTlRzclRYLzFsWThR?=
 =?utf-8?B?RDA1QkJ2VVZtOUdCMnhhYkMvZjFEdU85SEV5NjBsblpycGJPelhJQWZTNnhl?=
 =?utf-8?B?eW1hRDN5TVdEYTVYR0ZQL1k2N3J6ZU9LdlhLWnFaMWg2NjVURTNuRUphS3k3?=
 =?utf-8?B?M0FXZWd1V0NxUmMvRDI0U010UTEzUVJOUjZETEVlaGtObjd1NWNSOVNWRXNI?=
 =?utf-8?B?MWYyR1ZTQ3V2RmRTdFZPTzlLZDJyZUMybHQxb2NLOVFiM1VwZmhLQXlvN1Av?=
 =?utf-8?B?R0VjWVFvOUxEYm9CZGwwN2dYdlBGbWtrQUZwOFZKL2xWTGwxaThpc3NJbGZk?=
 =?utf-8?B?aGVSaTQyVG5qT3MwS0tvU0laWUpoeHdJcS9vcWlKY2d4cXByckVydU1nVUk2?=
 =?utf-8?B?Mmt2dUYwRHFvTDd6RU56VDVvUFpJU0d2QmtRaks2MFhKeGs3QmY5MCtkUEo3?=
 =?utf-8?B?R1JTVVVzeXNBSXZoTFBiTFU1anJwR29Vbm0wVmp6R1pDVlNLZXVzR2c3bkc4?=
 =?utf-8?B?Tyt5Q2JtcnJpNEVQMW52eTVaTWxKWDE5WC9ZRHlMQktMY3VhdUZleXdwVjF6?=
 =?utf-8?B?azdXa2p4dWphUGduUlBQdElFMVZ5dnliOEV5RTF2SjRuY0lEeWc4S1R1L0Q5?=
 =?utf-8?B?eGkwdHRuSXZQazNGUXlNS0I2ZmY1anRzYU1OelNkSGxqN0s2cVFqS0N0RlFa?=
 =?utf-8?B?Rk8zdU84L1Byb0lwWjFodG9OTmw5R1hNdHYyZUlyREh2b0Z2MC9EaEl2a1FZ?=
 =?utf-8?B?RjJubEREcTB0bmErSEJsdGdjbTQyVi91NVB4bTlMdURwU1ZxWFA1TDI1Q2Ra?=
 =?utf-8?B?S0dnQSt1TEVtZFZpR3d0TkJ4UENFUnMyNFBOV1AvaTdHeDZpd2I2TThHTW1E?=
 =?utf-8?B?cXo5bE9DYjI2aEdaT1UwWGZhckI0ZHhvdWNESmMxOHBmU3grd2I4a0lpZ0hB?=
 =?utf-8?B?OXU2Qm0vM254YjNxZlZJWnQzQzI1YVRxb0NBUlRNcGZEYVZBNFVFMlpIejlG?=
 =?utf-8?B?Vjh3eUpzZXl2V2t4RHlBMkZWb0w1elhtSmZMR3NMOENTR2JyVHJwT21rRURH?=
 =?utf-8?B?cndyK2xIR1lDYjN2QjlRWkk1V0M5VG1CNDBJQmNnR2VDKzI3am0wNVZBaTRQ?=
 =?utf-8?Q?iurtsn77AF8PyPk5QM9Y5Uq9DC0LD9jikO1/e6KhlZJGSl?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2tJd1NUVjFmOEZPOEE0aFRwQ1h4YUlLckdHMjFScC9QZUVRU25YOS9qcEh5?=
 =?utf-8?B?R2RjaUJMMUZ2aGV0NEswOUYyNnZlSXZUUzl6VzZPYkt5MlZ5Zzc4QlpMN3pE?=
 =?utf-8?B?OWFFb3QxWnpQeDdMQ1JJc0s3STNQdmI4aDhNTy9KV1B2K2t2Wkh2d25VaCtE?=
 =?utf-8?B?a05kY3VYU2x3aUluYWVtM0hkMHVPQk1vbjN1NjdIOTdlMnEzWjRLTjZ0U1Zv?=
 =?utf-8?B?N04yZElWa0Q4eHE3dEhSU0JnbWp5YU9EN1ozc0ZiK1JuTnB1WUdYZmRtTU9m?=
 =?utf-8?B?NVZyZVl6WXpNOEoxNk5BK21RTWMxRFVrbnpXaVh1V25PK0tWSnJOSllCU1A2?=
 =?utf-8?B?WlJtYlNJV1lMK3QvZEZLS3c3TlNPWG41QUVBREJZLzcwRm1kUUV1S1ExYkVi?=
 =?utf-8?B?V2NNdmhDNmtCWlVBK1dwSDdHT3ZCUjdGS0F1M0kzSVpLMjNXZ0pwZkZOQzg1?=
 =?utf-8?B?Nkl2elpNazB2ZlpqbEczUis1aDIwcCtsZU5qcmJ1dTVOWXVzRzZmVEppVHhj?=
 =?utf-8?B?N29lMDZaSS9pL0RhY1NlOTBpYmtndmZSUEluemE0ZGFiZGRQZ2JoTEo4M08z?=
 =?utf-8?B?ZTUzQzZtMDBSS3lxUTUxTit0aW45V2lpcmo3Qjc4Y1RvYjdZaWxpS3NKLzU1?=
 =?utf-8?B?bUI3d0xDK1l2K0VDdVNGK1loZGtqdXAycGxnUmNEUThGVWNJTWhWWitFYTVW?=
 =?utf-8?B?T2d0SE1URnZ2aEpYV0F3UkpOTElJRGpRVGhzN245TDBlMXJua3hXYVRpN3hx?=
 =?utf-8?B?VVp1MEFjY2JZa0dVcUZDUDZHVEJsRC9nZUJMNC90Y3g4Zy9WcVRmK1EzMHBo?=
 =?utf-8?B?MWQyemQ2d3dZK0R0Zmw1MTJlUndRa0E3WjZDdStqRXllSEFGMTFHUytQVzVZ?=
 =?utf-8?B?K0M3a0RQL3BJeDA3cHdYdXJ4SDBiaFZ5eDhuVEx4dnVlWWFxMVFSOTZGUm0w?=
 =?utf-8?B?QnFkOERyb1NzWHBhMXlFd2V3Y0NyVm1mWlVSNThpcTNzeEdwZXBDUGJGa1hH?=
 =?utf-8?B?V0hCR2VDUll1bkowZEtXb2RPNTVrS2dGUXMrWXJVc2dJWlA1OCt1Y05NMm1I?=
 =?utf-8?B?dlVieWE2djZobk56bW5ITnVoenhzNEs4OW1MM2toZFlsKzZ1ZHZjWnJRaCto?=
 =?utf-8?B?cWNVUGo5YkNhem1rbFFZaUs1NFFETm0zWExTQVdqdGU3TlJ3VE9CMWhxM1E4?=
 =?utf-8?B?SEZYbEsxRGt6OGZQZFByZnhCMENXUUs2UTZHWm1ZTUNGMVZLcHEwY3Buendr?=
 =?utf-8?B?MTQ3TklJVk5NcGE5ZVNxWkJmbHlVYU1oWTlBNFplQThkYTI1cmZsMlJNS1pu?=
 =?utf-8?B?K2pzaHRqaHNXYkJsY2JkZGpxSzE4OE52YUpzRm51d3JYeU5xaWpaZFBPZWI1?=
 =?utf-8?B?WTBONUk3ampwU2t5aGRHN2pnOFNBMlpkZmZwVHpTbHBZcDR1WmRBSDZORDN6?=
 =?utf-8?B?RnBNRW4vdTR4Yy81dzRHMFp1RnYrZ3BNZFhDNVdBRXlDenpNdjVBc2tvT0FD?=
 =?utf-8?B?WVNGaDJKU1BLOXNlNlZzYVB5a1JZaWRXT2ZaSkFKZVFBbWZaR1l1aUo2RXRv?=
 =?utf-8?B?dk81S255MDdzV0JqUzBreUdoY09uOG5Ga3pqdGtkOVlPUnlDNWhKNHVXbHVh?=
 =?utf-8?B?eWVOUDh4Y2hBbDBBMTYrbHNyQTJxVUJvWWc4MTZqeWZUbTBxL3R6RnlQaTlu?=
 =?utf-8?B?YVVDSGpJYnhVNDcvQ2hmTHlPUGdmcmtEYnlkQWdMZUJMTlpqMGhtdDFyMk5Y?=
 =?utf-8?Q?VRgfXjfGRNw+BErl1JaXRydYqtWW/fxTgW2cDvd?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6636dc79-f206-44ad-088a-08dd9f9e1fb6
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:19:24.5524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7415



On 30/05/25 10:45 pm, Junio C Hamano wrote:
> Aditya Garg <gargaditya08@live.com> writes:
> 
>>> But I do not see any link in ...
>>>
>>>>>> -    by 'c_rehash', or a single file containing one or more PEM format
>>>>>> -    certificates concatenated together: see verify(1) -CAfile and
>>>>>> -    -CApath for more information on these). Set it to an empty string
>>>
>>> ... the text that was removed.  The reference to verify(1) is a
>>> command in the OpenSSL suite, right?
>>
>> If this is a command, its not phrased nicely imo. I'll just leave it as is.
> 
> In any case, there isn't an link in the document that is dangling,
> is there?  It is not like I am trying to prove you wrong.  I am
> trying to see if the change you made is still addressing a valid
> concern, and if so if there is a way to make the result better,
> possibly in some other ways.
> 
> I agree with you that this passage is not nice to expect that the
> readers are familiar with what appears in
> 
>     https://docs.openssl.org/master/man1/openssl-verify/
> 
> where `-CAfile` and `-CApath` are two of the command line options
> described there and has "more information on these".  The
> description of these options on that page redirects us to
> 
>     https://docs.openssl.org/master/man1/openssl-verification-options/
> 
> and expects us to scroll down to #trusted-certificate-options
> anchor, which is doubly unnice, but that part is not a fault of our
> own documentation ;-).
> 
> Perhaps something like this would clarify the description?

Thats definitely much better. Although, not really in the scope
of this patch series ;)

Maybe you could just append this alongwith v7 (the latest version
of this patch series at the time of writing)?

> 
>  Documentation/git-send-email.adoc | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git c/Documentation/git-send-email.adoc w/Documentation/git-send-email.adoc
> index 7f223db42d..53f30fccf9 100644
> --- c/Documentation/git-send-email.adoc
> +++ w/Documentation/git-send-email.adoc
> @@ -267,8 +267,10 @@ must be used for each option.
>  	Path to a store of trusted CA certificates for SMTP SSL/TLS
>  	certificate validation (either a directory that has been processed
>  	by 'c_rehash', or a single file containing one or more PEM format
> -	certificates concatenated together: see verify(1) -CAfile and
> -	-CApath for more information on these). Set it to an empty string
> +	certificates concatenated together: see the description of the
> +	`-CAfile` _<file>_ and the `-CApath` _<dir>_ options of OpenSSL's
> +	`verify(1)` manual page for more information on these).
> +	Set it to an empty string
>  	to disable certificate verification. Defaults to the value of the
>  	`sendemail.smtpSSLCertPath` configuration variable, if set, or the
>  	backing SSL library's compiled-in default otherwise (which should
> 
> 

