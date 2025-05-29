Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010000.outbound.protection.outlook.com [52.103.68.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA991C1F22
	for <git@vger.kernel.org>; Thu, 29 May 2025 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535538; cv=fail; b=eepWKVEHNPZAuzQNgnQiqT09vOFz/52A6FJWphxPxJpLIxMh4EMYp0vFYvW9s7JH/lFcHePHOT9QnbvkMOocoKJPOVUsN3U/AFXuHAFiRvNW9h9otCW/qdocpdl3EH/Z91wZUgC66tVyz0i1zwdkvP7DiVf50qyZkPGnNlhWBaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535538; c=relaxed/simple;
	bh=lz4ZTDeKij9HV630Nl5korKBfsFxl9eLTyU3DHU/wLU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rorr/m5Ir4ZbckXAXdKLdzW9gyG6xHlLPJkgJ1Q9GGihQpgbfuwHd1h8LuCgdg4cp09FBHqIYYCSqwRlOjtyoHLDNV9TJCa8NEgYiWQOUXY0Ig+TmIeVjXNBBTRMD3hV1wnBxX8flDWQFhNgRi7/qJj8jIOextTV1OtJUdIaho0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=u9XMjjZI; arc=fail smtp.client-ip=52.103.68.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="u9XMjjZI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnzffRuLrBs+aO6Hegs7OZa9StQeDHq3V8Y8ncBQnHFy4R/xCfVc6d1ti2AtmBk/b0YY12DIEbaGzpHwYIXDLazyIRhVK1c8BizTxw6XdILp5ll0nFLnM704pqtS7wPJQXvLz6mAMx8kybZ+yZQzDPxtxy9lCgW7X4YjMWdyvaisrCGKpS95z3F0hwP1GK6t964i9E1Z+djlP2nnHzWHHQ3c69ygc7o9apPm825AT00o6TJEsdZb331wNTytZ43Zx70WuBR5W2QZuOqzWJLmkZUFNLO8XFudMd+fl2D4cFg3GqHAcV94CPgLfMJaUyofheBQQKUvYyRPd8KlcX8k9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bV4Mv7SenSE8A8RbtFtSKEMOTtRy8cn+1K6QhgsciR0=;
 b=CziB8jlpRxUdscPN9RvF2wV1sv0FC60q/kG9k//hFawC+BL6czH2QgUKTuLdm1AUPbyciRVu7j00q4OTJY3yPwrCE5+nQyIbLyGTkMWToB5VZB/df51KipWtrQWEGsU2u941bFHyy5qv/ELhpmvbFWlzd1Y4HmMmlLZKDH9gxCHoanXx7lCP+dQrUjAE2ZU/7aLZvDN82B+/1rU1S3Spxpv9sLl4gDUspAtHBG8L10Hl6HXX7VWQ8ANupzezZ+bnVLGbPKM6f0MalpWZeteBUbzkajTkeqicTpaYzKfhPeIZ4YXzTuRNuLY/qKUiS3KXoXv6Sac2m7mM7WWWgMCguw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bV4Mv7SenSE8A8RbtFtSKEMOTtRy8cn+1K6QhgsciR0=;
 b=u9XMjjZIgEfGXQlnz/88qVPJ+BZNNo4YdqNRhsT6fmIoyehJPvdrW7gDNEveQ1ZK1tLAaj9qNDBXVVbPQNJyLrCNWCog2Y1AQxqB98CAamYY8zX6V6fS+a7psRs0kWfLNLBLpm/I1ee5MygdkfE/VQrr9dDkbQHE5g2s0N80jqeKx9DyJEVxs7h8WmVojpUI4klEvZdAlr7vuEeOfGcabt7KkFEeA8dty8AOGY2utfbbWvZ0fPJm4kAoxBBsTj5kWEcsCDhfW2W90l0FlXfE32uY0yO+tqAan3olCTQOQNW7HGS+rjWr9rkAIuiIRQWeGmJi+dsyB57L3QW+XyDW9g==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by MA0PR01MB7067.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 16:18:49 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 16:18:49 +0000
Message-ID:
 <PN0PR01MB9588AF2A370D8A1F50745C97B866A@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 29 May 2025 21:48:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] send-email: show the new message id assigned by
 outlook in the logs
To: Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 Eric Sunshine <sunshine@sunshineco.com>,
 "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
 Julian Swagemakers <julian@swagemakers.org>, Jeff King <peff@peff.net>,
 Jacob Keller <jacob.e.keller@intel.com>, Zi Yao <ziyao@disroot.org>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <cover.1748529954.git.gargaditya08@live.com>
 <caf46596a709df7205495b75da569baef2c7c9a2.1748529954.git.gargaditya08@live.com>
 <xmqq5xhjmmno.fsf@gitster.g>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <xmqq5xhjmmno.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::19) To PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:10c::9)
X-Microsoft-Original-Message-ID:
 <dd3b2fa5-680b-4760-8ef2-52dc61782db2@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9588:EE_|MA0PR01MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: f0fa6bf6-77a9-4b6a-6bd6-08dd9ecc7eaa
X-MS-Exchange-SLBlob-MailProps:
	30ekHghIwFpWJZJ/S7H67WW7FVejyf+CTqqRbHRCj+dxWpS5/cbMCS2NDGg6FZISUPuNI3l04BKQgIP8M6L/fCwnpCqz0cwF0hjaqJvajsDypvhDxDvIZAEm9xrXO7EXUVJddjFjnqvxyBr5Jb489+axFJN5cHnDL2iJ1NRXdt6uklERjJ6SkZNCH3ERzk1+PYXUnsYjois8PSjqdrPLKiNHDANvZvVhbfcoxiyWoflqt/iNbbl5W9aJ1fLbUiBUrw4hpoGddrmNv7VWY2OnPeKRHndG4/6T7FbSKmXDKLjF4t4c6ZC/BMXQOWROu61c+GZfCqJ7ev/ULHFDAYQ5+blpYDHcRwd8pFLGSJ0073xI9X1JHAa88aEguSc4NhOs9yIQiXxsVTXTD0EIPy+4IFC8YEnpfimEHDnc9OTlrD/Ymt+VRjJFRp6vUlUd3td+jYjmwUrC2N/EPyGcbDd8NlG37P6SZYwWEqRN8J+F1rVbem4njHTd7AnUHlxk1M+oFWDOeD8oxlRaAq6HZq5G/gBzxHfz/u/UrokT1VvCuwCWS0ewlFfnTSR5LrhFAdVo9x5QciraOzx+C6GVsbWrOK6FQbW56qqhb3BLIPI2aXjy+4CQRMCySCDbfx2ePQaChMtbWqi08tlZ9arDkx4gViNAqj5LyiQIdprVgY5ZN7Hdob71Zj7nBJkSdfHuJ/uDnJ4KDSmFkMkVPtwuWLQUuQV+9fdaVHn4tBJz0sgHuiFuns6EUvrG4zN0YG1aOVT2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|461199028|7092599006|8060799009|6090799003|15080799009|5072599009|19061999003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d01OOTYwcWNYTWhvNVhRZTZqaExEWHJIczMraWlkdU1rRVY2L3dHOE4yc2gx?=
 =?utf-8?B?a0toZFVIeEZCeFdDeHdTZXQ2NFRBTkhpNEhtdGZYa2tPTmRRL1FtSm0zOVAy?=
 =?utf-8?B?RUVSb0FwNGFlTUJGMUdlbW95ZjdYbndvTTYyQmVkNG03QmlPUi9SL0txUEJP?=
 =?utf-8?B?eDY4VUo1VmtDTEU5RVVZV2FrdVR4eVNPNnZ5Tjkza2duSk96TjN1T2w2UUZI?=
 =?utf-8?B?Zlc2ZUdSWmU3d3hFN29qK2wwRTVDWXVzSTZBRWxvcXA1dEQ0d1ppUmhlTmVN?=
 =?utf-8?B?TitmL2diQnN0MDA4cjA3Q1A2QmlEeEZCK3ZrbEtXM0hUTEFkTEZtTDRJQ2tM?=
 =?utf-8?B?aWFTd1RINW9lQmEvZ0lEVVg0c25MMUo1b1QzZ1NORGRaNXdNVDFCL0pWRjhy?=
 =?utf-8?B?bC9rbUZGcFNGdzNDNktrWTk3QU10TGR0bjA1a1VxdEU2eGNqRjVEeHZTUkpR?=
 =?utf-8?B?ZDhVQ0pCY1I5ZFNkTk9LZllZZjZ4ZmlrdG1WR2h0bTNCOFM4Zlpvc3N1Vlkz?=
 =?utf-8?B?anpIbUJKK0ZYSERsTDhQTW9UQm9zZkh2ejlzSUk3ZnNBc1hkbWkrR2l3T1NU?=
 =?utf-8?B?TVNvbjdleUdOeUZ3OVlYbE5jVm1MSUdFRWFseUlHY29xSDlIcUN5d2RiblRQ?=
 =?utf-8?B?c2d3dm4yMzJQUE9SMFpxempJZ3FoT1VLcjhwOWtXd08rMUVnT1Z2YTYzaVpK?=
 =?utf-8?B?T3pVU0hwc0xoSFRUVTVja2xvNmxESjhEV3BtTjlUekc2YllhQUZmK3FJeTVl?=
 =?utf-8?B?S0ZxeTNuNVNvMVBwaU9ob0xMbFBWRkdQN254QnRTTEdvbHlqQVoxNWdYcFVl?=
 =?utf-8?B?Vzc5YlQvSkdpcTJuR2pVU01OR1ltQTlJYmV0TkRIdXpnazNVeHdRN1NkVUgx?=
 =?utf-8?B?Rm9jVUc5dGk2MUxKa1ZRYUV2V0orZDg0eVgyMFFoVjh1WGJlVFgvajhXcWsr?=
 =?utf-8?B?aDQ3Q2tIOUlkVytDQllEZkJ0MGhyTEthbGs1Uzh1dDZRYWFqZ2lkTjZ3c3dE?=
 =?utf-8?B?TU5Dc0QxUlNkM3pYUElIdVFXaUJXM3JhVlBMK01aanVWclk5UnlXOVFkRkM4?=
 =?utf-8?B?c3pGdFdyM09VL1VVR1U5azgzN1JCSFpIb1RuRHpwRlFKUGIreEdtOGFzNW9n?=
 =?utf-8?B?Tzk4WmIwck55bjk5S0o5Kzl2bkYwemV2NnRrZ0N0V2xkN2t2SFUvRElkRTRI?=
 =?utf-8?B?aFArbTcvc0tobitDd25XVG13b3RrZVpsdGN4REhUVThsdnJ4YWtjdVNCUGVN?=
 =?utf-8?B?NUxTS0pkSkUzcmZUQ3ZaMm4zVS9FVVd1cEoybjRZdnp3NjQwYyszak5rVGtU?=
 =?utf-8?B?T005WGR1WFMvRVFpa0hNaTVoVDJTV1pRT0k4NVdtajRXUllPRTRtWHJhM3cw?=
 =?utf-8?B?bS9sUlJFdkJaQ1BNS0FxMnEycG5nN05SNDEzZ2twS3kzUUMxUTN6LzZvYWsy?=
 =?utf-8?B?UUJiOXVBOE45V2ZoUkcxbVlXbHZYUVFiS0t6aFNJTzFtTUlldmZBdzJPS2My?=
 =?utf-8?B?MTZkWWtqUWRENjg0TDFtN3hwU3FpUEp4UWtYY09BdTVFa1BmSzYxVG93bTAy?=
 =?utf-8?Q?Pw2FFBQ2njuefpR9tPg6xgABY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2JBd0c0YzFydEVoRC9JVnlqbllEcENXeURpYy9SYWZkTmluK3dhQ3EvU1NC?=
 =?utf-8?B?Q0szcTlZWlNOWXNHRFk2YWptOGFINUNYWEt0Y0hCbkhRZlJRSUZKNngyaVp4?=
 =?utf-8?B?Sy9tUWlzUjhJaElublZlQmZVOUNwMzhzMW1QSnNoTXFWUENQaEptTnVEcmRF?=
 =?utf-8?B?MjU1NVhKdWVKOWEwQzhvN0xKSDZyWWJuVnVyUGY3UWdBTVBDYkhpZ0JOcEww?=
 =?utf-8?B?a2JwbWc2dEtGaklJWEpCZWJxeU9LT29lL252N1JqSUpQZE9yN1daRUNBcGFr?=
 =?utf-8?B?a3lxWjM1aHB2c01tekd3eHNpQU8weWFIZWU5WlBlRmhwMWlrczcrSVZzQVl2?=
 =?utf-8?B?Z1pjWlJuTmYzUDRoc1B0eWNMdnhIUnFFMitKTnd6TWhRK3U0UGY0RlROQ1ZK?=
 =?utf-8?B?bnY2V1NmS3JENmdaZ0tOaTNiWTNxVlV3RFRZR0hNemdZOWdNamFmcDVUUnI1?=
 =?utf-8?B?S0crZFc0Vk5SaWVUWVhXRkVweXh3V29KYklVKzlDQXRFVGV0eGMwQkNGZnlt?=
 =?utf-8?B?WnIrTFBlRTUxT3NNcXFKeHhnUWs1VWo4YXE2Ymorek1iZFhmeCt0bjRuL2NX?=
 =?utf-8?B?V2d0aGYzTDl0N0M3TkdTTXNJekNnbzl0QnEyRmFpZDJXYW9BN25pK3REODBU?=
 =?utf-8?B?bHVBeFBsYTJuYTEzSTVxc1pZWmxOaG9WMkp5VlJLZmRmMStlbVQ5WVJIYXBr?=
 =?utf-8?B?STlaWGxTTURscmF1cDNOaTBEa3czVkNrMTBwcERVcmtxOTZ6elhIZDJvaTZ4?=
 =?utf-8?B?Nng5b0gvajZYc0VFRk9QYVRrQU1VWW5zSmpBdTRrV0piZlZVeHNuZXdHa2dJ?=
 =?utf-8?B?MlFKM2dzUWtsUk9OTUJHOFJYMkVCc2lEaDhmOUM5MzNTOFN6Z2lRNmxJMWtR?=
 =?utf-8?B?V0Q0TC83UTdOemNnTUJrRnl3Tis0cVJjWVVZRUUrU2x4UGs4RytNd1NJeGwv?=
 =?utf-8?B?WHhFUHF3eVRtV2p5Lzh3a0wzSkZGak5zK1FXVXRPdkR0enl1UlgvdmhYcXZN?=
 =?utf-8?B?aFV1NGFnSVJQdm8rUERnRjhMT1NSUnpYR2E0MVNiNFNkbEUxNGNoYkJzZFZy?=
 =?utf-8?B?OTdwci9TZGhDK1haWFRXa08rYmVaNG9ObFBJZnFKZEFLMloraEFiMFh2eDJX?=
 =?utf-8?B?VTk0ZDFaRG9LbUd0bkMxSUxHZC9SVkFscHQyaVdlL0tPRWhIV1lITmZybWlG?=
 =?utf-8?B?b1U2T05hWWlXZWRuYVRDRTI0c1BqVWZ1NTZyRk5NZGt5NXNBTTZPWks3ZXdw?=
 =?utf-8?B?dWI0L1ZRTzE1WVRKRE9tTlQraUc3b3JZL3c4b2NxNkUzNXdFZiswdXdXZGxl?=
 =?utf-8?B?dWZyMXl0M0l6VDlsSHZ6alg4Qk9jaENlQnV2WUs1VE9DRkZvRTlOdU4vZ3lM?=
 =?utf-8?B?c01JSzBOR0R3a0E2NkdEcXlmUHZFdTloYlZaMFlYL2xxeFkvbXVrV1J6b0hm?=
 =?utf-8?B?cFgxVmRjREM5QU9GajV0Ti9WNGJ0TlNoazVFVHVDbUdWZ3Y3MkpGZWd4VjI3?=
 =?utf-8?B?TitnRE10TmRBMHlSQktMQzRXVGl4TWxHZVNpNyswWlUxK1djdUpkSC9BL0J2?=
 =?utf-8?B?cGZDUVdBVklhNUI3SmNkNGx2NklhT0FFTzEyUkFFOE1yeTRTeVNML0JWd0ZD?=
 =?utf-8?B?U2ZjMlIzejFFMG9zcUQ4MTdUVDQ1em9vVGFhaDNJNy9iNjJRM1M4NkQvMGd0?=
 =?utf-8?B?eFFKaFh6UTJ2V3hIK2FldmdlTnF4K0ZmN1FVdUpqZC82SWExcVE1OENUVm5D?=
 =?utf-8?Q?bFUbxGWCyZc2Xptijz1EtH/ia+kHAZ+GPHDUoT8?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fa6bf6-77a9-4b6a-6bd6-08dd9ecc7eaa
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 16:18:49.5726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7067



On 29/05/25 9:31 pm, Junio C Hamano wrote:
> Aditya Garg <gargaditya08@live.com> writes:
> 
>> This patch fixes this by modifying the $header variable, which is
>> responsible for showing the logs at the end. Also, the log which states
>> that the Message-ID has been changed will now be shown only when
>> smtp-debug is enabled, since the main log having all of the headers is
>> anyways displaying the new Message-ID. It should look like this after
>> this patch:
> 
> We do not say "This patch does X" or "I do Y" when describing a
> change.  Rather, you give an order to somebody who is modifying the
> codebase to "make it so".  Something like ...
> 
>     Fix this by updating the $header variable, which has the message
>     ID we internally assigned on the "Message-ID:" header, with the
>     message ID the Outlook server assigned.

Ok. Want me to send another revision, or we good for now?

> 
> The change itself looks good, but ...
> 
>> +				# Replace the original Message-ID in $header with the new one
>> +				$header =~ s/^(Message-ID:\s*).*\n/${1}$message_id\n/m;
> 
> ... is the comment adding any useful information over what the code
> already says?

Considering the fact that making this regex what itself a pain, a small
comment for readers doesn't hurt right?

> 
> Will queue, with a typofix to "incrmented" in [1/2].
> 
> Thanks.

