Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19010017.outbound.protection.outlook.com [52.103.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DF948BD52
	for <git@vger.kernel.org>; Mon, 18 May 2026 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123432; cv=fail; b=VH9DS/TtWBelq1gKVs21wCzK88PX9Ro8c3fyswwDEEr6bHNkq7je+cpibbixG7Yr5PqfSZzIu41pqqZKClNhBMBpZtiA/Eetaeu0d5FiIcd3cyt/OaEwT3HJfsTdwK9Kz+rm39hiNaI26KEwGQWZyDf9BZZBVQsAnrsOJVhiDvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123432; c=relaxed/simple;
	bh=t8UAltHYkN1z45eKff8tYygcSxzTrx5sAmEVNSko3h4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ey63r+TVxkr7pRRDsssZRAuq7Bbv2jSYFxufcUk1K0QdftZkAJyg2bZAojgm7ANcgyAtk977AYumb2eby7AjsvQTfdMad/RzTD8DOOZJgp7XddU5FOhjyUR1P6qstwJaqLU5pBHSKPOWG42DIFLv02fADYocNVQGeX/0RNxoUZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=scmGDkZQ; arc=fail smtp.client-ip=52.103.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="scmGDkZQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2Jh4WBXt21u8KXyk8zdmVtNHC8mVYSWUMLNrOeI3uu1u2+nxsIySckgU+EmIfgza2VIfhyXHj4mkHhAzCiuLUKyNCZ1Z3UC2l4S16OXlKJgR3746pXTHZUF59pYcsCX9RyPcVHDIpZSAR8B2akNaIsvTeLnETm7BBadWhB/vvEjkx1Z9LoSikgMAk/2GfwH0Ey2T9UsB5nRC7HZA3a6fjBy7KI2sTDKzPvaUFMiTNrapcCLkZlu1EHRTbdykrTwouMG2RHkIjeAxDRPD6vc2tL2AQ4duRm+m46u4D72HwfQfSP5/RCEhW/0YLYKnODuXeydlMAtlRU5slB9jlt+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMwcr9/q5UZVYlWZxOWrg+BC9Hah+u7RTh353uIYJd8=;
 b=jsW+KoQM4/JTDqHAiIBReY3NnPEc7lxWkBSAZaZmjbgB85FlCB3zuriLXywIzI3OTSfoJ+SydtXCuPcWIZN96Cl9XYkWESTH2Ys2RlgGsTqyEY2WVKQniMBpVE00/5NOxriM7SqqnhAN6mGITD0pTA5LIyykIWNEQDphjREC8UikIOh4/2NtaD2AGns64kf7y5WdnYyKpAOzj3NidnU0BnCWwJbKJ9yyHqZLTeLM0AvnzxNbssyAlV/bKEAydOjeX+9YT+8cqyAyjSzwUSs7YS5SJNU1L0k5H+KyX3rLzvDXJhXhjbTTQO/AlUbldOuTNYfyBMc5eaOSuMn2Ut/xuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMwcr9/q5UZVYlWZxOWrg+BC9Hah+u7RTh353uIYJd8=;
 b=scmGDkZQvHmbBTVUDax0BdT7TO5S5gRawY33XN8GLaF2WY3rPGJjcTb21OtXF+V2iTebk8e0a17mgi7lgpkdPZCk3khTorx1i5t7fzn2TPZ2Pnf3wcDvwpdsYAOA8C/dQ3bB49kW/eAwwe8jJ2jwdcKUoPDRkn3LVQpGTkvPc6TBNjk+lIpV0uYQwsE3eKdmL49E2AsYRHe9dEvlF3zlAHhA5kyimZgUnwdw201pg67qmcMyxXjPklhBcl8OoTTIGTc5mblHkZtXv3lgJqaIPqCKK1LmfxntZnky8rtLJapflU5H4iUuo+Fcku1gx+LywmOgXjyFQQDzkyvupqwFwA==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by DB5PR03MB9927.eurprd03.prod.outlook.com
 (2603:10a6:10:48b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 16:57:08 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 16:57:08 +0000
Message-ID:
 <VI0PR03MB11634279CBA717D6C6B977C3EC0032@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Mon, 18 May 2026 17:57:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] negotiator: add have_sent() interface
Content-Language: en-GB
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Derrick Stolee <stolee@gmail.com>
References: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
 <94b79784fe6a4f22dba32a2e1d44316b3e84da48.1778762495.git.gitgitgadget@gmail.com>
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <94b79784fe6a4f22dba32a2e1d44316b3e84da48.1778762495.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0528.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::10) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <56645074-0b42-4c62-9266-26b3b573a7fb@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|DB5PR03MB9927:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4e8968-9520-4c65-8c1b-08deb4fe7f06
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrNTtvVDcHpkNORC46SFnKishlgwBsDAmnWnZthi2/cMLWoJxizRbv8nJNzHdxAd8+ualYrOAesOBqmz9DDMz9I3KCHU8SlvaQFOZCuZonYMnvt/vFliw1H/pWCMGti7WR90LnWMRA1ro1dS/pfpBk0h8/ow4eTLCb7Lfs+/zw+wevlV4NoyErSD/he8iU0waYxlmw00cWTANL2a3CmrNwZb8NI3tAFjVrRUnzgEvG7dUZstuDuQUiw9TW/ep1zP0mFtKbi3QV3gJi/pGbMttQ2K4HfGxy/P8e3ZD51cwUwJP6m6wZ1qGL7/imPjp5N3g1ko4TpCkoq5VS+2rSjxLELcl2VszIiNs+ENDX3gQ4gpDwJA7tostvGZ/JhHgOwpy0i+jofxjRC3x6zi5nkBJ12r1clHRmXRaMesiu/JnCquySnZSAddYl25wEWaE/ocXkbZJA5GSkLWI/qwJCbuFvKDiuJjUdUkdM1lZXZmK77+yOVPxRn83mTas7o1ya8INIWAnEaQ8mnDYhPwlvNQ2RKPeiMEPe/21iR9nxplPJCezzgFT2Kq9awXICRBHi557CklkhlR2UQ57pj2Zb9JBVAHrRodAmrDyOwFBmZHZS3jlCvm5//8nqBfLtF4iDNlvW9ITcpC/GXb8DrsS7pUxIB4s971H47G8VarpT7JXspNMOr+V9t+FvG+yeYr/JD5C8c1RrQsINlo+cxQM6i8QjjlqfELfV2YiauUMtzBwT8fLRnWf+IgA8zcWv+46/ogxgs=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799012|8060799015|23021999003|6090799003|15080799012|41001999006|51005399006|37011999003|24021099003|440099028|3412199025|56899033|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a09Rc2VwVmJVR25kUjIxcmIvTnl4S0lOTm9ZdnBFejVTUUhYSDMrUHg4L3VJ?=
 =?utf-8?B?QmxVTVIyVVZ1MGVidU0zZjlwamZpc3ZaWlkwSG5WVCtJSmc4cUkzcElONzY4?=
 =?utf-8?B?QTVjM2JVVE9Od3ZKcjlJaEY4YkpMTytnYWRUSG1la09LRnp6aHhldFlGd201?=
 =?utf-8?B?WEV6KzBKSlVPZ0lTUXZVSHBvVkxjMWl3T2pmYzN6NFU4NjlKK0lxTVl2aGlT?=
 =?utf-8?B?ZXlsU3FEaTdaclpWWVZzNXZZSk55YTRIckJac1ZEZ04zczNWSEE0TlpSZVpM?=
 =?utf-8?B?Q212TFN2NmNwbVY5VGJYM3hsdjVydmE2OUQ2RmlHNEFybDhYVDQrbTArUlUx?=
 =?utf-8?B?aHZzNTB2MHV4MDFZMC9EVWhtTzMzR3VlbTgwSHFSTHQrMEpOUEZnNWg2N3Iy?=
 =?utf-8?B?L1RQYzVBQUZGc3ZEa3FDM0xNbnZHSVlFRlVYNmZXYkNsUkQzb2o5MThVN2FM?=
 =?utf-8?B?RWg3a1pGMitaMUxTZlhlRFBMYWdTajkxQ3ZDUlZRcDVMM1VFbW1nOXBVMzJn?=
 =?utf-8?B?MTVRWGlPWTh6eWYyRUpiYmRXUmViMTd3YkU0ek0vYm53dDJpSHZHdEtKVkhO?=
 =?utf-8?B?Q2NydzFaZjZ1amhFbDJWaXYzTDltNXEvbndUbXo0MGFBQW1EcU45TGt6VUo1?=
 =?utf-8?B?Y1RNbElnVkdCSXN6cEpqd0lBQlZCa3FpU1RSYzNSQVYzRXc4dkU0d3RUUy9G?=
 =?utf-8?B?aWtFK2tjOHZxOG5pOEl3UVF3RGxFTkpDZ0JtdTlGN3VNYXFPRHI4Vzk2ZnBL?=
 =?utf-8?B?QkFRM0NFZHlMMlAySWszMmJja0tuUHNkVnIxZk4yeEhKZmZHa255d2M1RWVT?=
 =?utf-8?B?RldHd3VOaGNMaFkrc01NcGh5TUJGYkt6VzUrbjkvaGs3Wk02VE9BWWRJdXFS?=
 =?utf-8?B?SWlEYXF4RklQbTdUVnBKamhvN1RwVHh4VkM1L1NUa1ZhcEtlZXB3STlwTjdo?=
 =?utf-8?B?TlE1NStXcldIMlJWT3hjZVB4SDRSelBOekdoV29wblZOaXIwZUVGR29WMkhB?=
 =?utf-8?B?bW94bnJMZnJZa3pFRWRISHZ0RllhMkNxdUFmVU1LRTNjeW9yUVJBTGh0NHdM?=
 =?utf-8?B?WlZMSDM1bGlZSTZ5MWJkbGVZMWNqUFlaVXI5VHpzb08reUVXUktoVWpNZHdH?=
 =?utf-8?B?TlozQ1NCTlM5UWhaK3NYdGJNUUJ2aFBnTGtnZmhuME5PbFBDZkIyRytoUlNo?=
 =?utf-8?B?T1NHU1lXc0RwSmh1ODAvODEyenVUSXZxM0oyMEdXMFRab2luVCtWMWZQVlYr?=
 =?utf-8?B?aG9CYTRsRThZR1p2YVZjWWlieWlEWlZ0TzBUQ3VoMVlGUmdzNDZrWlNZQUVs?=
 =?utf-8?B?aWlRY0xHOG5yZGZ0R1ZhUW1pMzJSMTFseWhZcW5WcDFGelJTVVVqdGE0L2Jz?=
 =?utf-8?Q?3TCSGED79c5uUu4i9xJ73EzjP2qWBAZQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0xsd2V5aXdsUHRGN3RBbHRvT25zTlE4UGloOXBuRlBFWmx4QWlkQm1CSU9I?=
 =?utf-8?B?KzZ4N2hxcjVFVnVyR3ZmRzF4cElqMWpSTjZza1d3WTdlL2YzdHRTRE9Eb3V5?=
 =?utf-8?B?MjM3czNaSVdGenJ6OFR5dlgyZzZZU0J5T2VjQWhpbzhkakN4WmtiTW5yaDBp?=
 =?utf-8?B?NTJnYTlDeXEyT3ovMTBpN2puZUlDbmtIK1RyS2E4b2ZJNFlQRnc4MmNrVGZ6?=
 =?utf-8?B?RTFjNFVibCt0K0h5OVQ2UzBCWG1YbEFPbWM0S3hwT0lMLzZhN2pwajBwMXhV?=
 =?utf-8?B?dEl3QTlheGoxQzFjUjc4bk1GcjlCTDg4b05qVGExS2xTS3lPQXZDb0hDdGNL?=
 =?utf-8?B?bllqVE5aQUhpSm5mM3pHNWZ4NjlVNjN2b0Jtd0RuL2hnb1k0eVhPQjNuNERK?=
 =?utf-8?B?VmdVdWRqS2RJY1JGQWFFd3l0MnRDeVVlVklVUzVPbnMvZmFyQkQ0MkNrNFhD?=
 =?utf-8?B?WGU2MEkyVE9KY1VIcEZCZVJLbUYyYXV0bSs0SW9FYTJISzRyMjhqSmFJZjZx?=
 =?utf-8?B?a3BEZ2NBYmZaTEhhWUF3RmdnTkg2YVkxWWZQczhOeU9OUkxYQS9sYUJndThl?=
 =?utf-8?B?bk1CTlFybG9Ob0RtdjFQY29IcjJFQmlUenpQTk96UzZaZmplM09Nb09WMHIv?=
 =?utf-8?B?RnNraW1NUy9KVXpxSnNlOUM5Q3NpY1RJQjlsdFhmWUFtUkNKTGllbTdFY3lC?=
 =?utf-8?B?Nk50SHhnZ0UwUEIrS0drTGpOVDkwZ0hNdkpzd2JnSDdEOHlnQ04xOXBqVWhh?=
 =?utf-8?B?NzdTRDBHamN2ays1cmE2Y0NNNjh0dDlWRkJaR2xDWUVEQmdITi8xRy9McXBi?=
 =?utf-8?B?OHYwQTAzaCtDdjRyS1ZSRDhOMmh4K3VzNGdlelhKUFZKeEtpNUNkZXVBN0tN?=
 =?utf-8?B?dVBreXZsN2g3MnIwTW9DWlRiRmx4bXFsb2lpSTNsVzl4a05KQVI2OVRXa2ZO?=
 =?utf-8?B?OGt2VDRiZUNiZmI5RDAwL1RrNWowMFArZWpDQzNLWGVCY2RGWlNlT1I2Zmxq?=
 =?utf-8?B?aWw1cERGNFczSkFsYURKdS8vaEsyTnNjYlZJcUpndmRyYXFQSXdnQjY0aW9T?=
 =?utf-8?B?enJsUWdnODV0YmFqRDdydnpTRXlSaTY0c3JJaGdWTEJ0b0ZGaXBuOU1UNEE5?=
 =?utf-8?B?bUR4c05ZQ0lwblUzSDJzbFpEUXpkZm5NVEFqVHlJWTNLUkRvVlNsR3lJTGZk?=
 =?utf-8?B?NklRZ1NObXNvS1MxY2hYSTdMcEI4ejNHT2JjdHh6SHROSWdzemY4Z1VaRWdX?=
 =?utf-8?B?ZzZjeHU0bkJSVm9jK2c4cFd4QVVsV3h0U3lmblVOQU9ERktDZVVUa1U3dWVO?=
 =?utf-8?B?cWNwUHQ0RDF2bHdHV0pKMHV2cDNaTU5tUHJZTnY5UC9VMDYycG9SQjB4RHMy?=
 =?utf-8?B?aUJqcHh1Z0RwVW1kaExvcmV3R1NINFlGeFVKekhPSXR3YXZtWDFMZjFMaGov?=
 =?utf-8?B?TitBRGJxTHVFZE5WemxKZVBGdFlFTzdiaS9HSjdId1JPTmlmZjVMaWJlbmlG?=
 =?utf-8?B?c0FNd1ZhVlB5WVUzdHN6RGsyV0ttT00yMW1lMzFjWXg1K1JFWnhlT3FvVXRL?=
 =?utf-8?B?aGQwQ2wrWDZjb09IbTJWSXV3WkVnQVhnaXU4Z2dPYnl0bVprYmo3SG9lc1da?=
 =?utf-8?B?ZTFiK3gxdHQxU2pyK3lUUExjdTdPU2RkcTJJZTRmYlR1di9XUnFVN3ZhZnZ1?=
 =?utf-8?B?MHh1cjIvOWpZMVhFU3BXQzNoV2JWNnRDMjJtSmwyWjlhejRlUDZJWHVBSjE3?=
 =?utf-8?B?UmlST29rbktGcitSaTJVV1RGNXQ3R3FXRGtlT3lnK2hCU1lsR3NGaGdnOW9x?=
 =?utf-8?B?T0VkT2x2UmJWbllMbDdHVVQ1ajUwd2ZaUU9MemlGa2daNVQ4ZFFQbFJYSXVv?=
 =?utf-8?Q?xCafguN/kJLB4?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4e8968-9520-4c65-8c1b-08deb4fe7f06
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:57:08.1119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR03MB9927

On 2026-05-14 13:41, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <stolee@gmail.com>
> 
> In a future change, we will introduce a capability to choose specific commit
> OIDs as 'have's in fetch negotiation, with the ability to have the
> negotiator choose more 'have's to increase coverage beyond that required
> core set. The negotiator works to avoid emitting 'have's that can reach each
> other, but that logic is hidden beneath the negotiator's iterator function
> pointer ('next'). We need a way to communicate to the negotiator that we
> have picked a 'have' so it could incorporate that into its logic.
> 
> Add a have_sent() method to the fetch_negotiator interface. This is the
> signal that allows the negotiator to track the commit as already shown and
> can perform the proper bookkeeping to avoid emitting those objects or
> anything they can reach.
> 
> For our non-trivial negotiators, it is sufficient to mark these commits as
> common, so the implementation is quite simple. This logic will be exercised
> in the next change.
> 
> Signed-off-by: Derrick Stolee <stolee@gmail.com>

This is a new patch in v4, and is in response to the COMMON (bit 2) vs
COMMON (bit 6) issue of v3.

Having a defined have_sent() API on the negotiator, and letting the
negotiator handle its own book-keeping is much nicer and safer.

> ---
>   fetch-negotiator.h    | 9 +++++++++
>   negotiator/default.c  | 8 ++++++++
>   negotiator/noop.c     | 7 +++++++
>   negotiator/skipping.c | 8 ++++++++
>   4 files changed, 32 insertions(+)
> 
> diff --git a/fetch-negotiator.h b/fetch-negotiator.h
> index e348905a1f..6ca422a064 100644
> --- a/fetch-negotiator.h
> +++ b/fetch-negotiator.h
> @@ -47,6 +47,15 @@ struct fetch_negotiator {
>   	 */
>   	int (*ack)(struct fetch_negotiator *, struct commit *);
>   
> +	/*
> +	 * Inform the negotiator that this commit has already been sent as
> +	 * a "have" line outside of the negotiator's control. The negotiator
> +	 * should avoid outputting it from next() and may use it to optimize
> +	 * further negotiation (e.g., by treating it and its ancestors as
> +	 * common).
> +	 */
> +	void (*have_sent)(struct fetch_negotiator *, struct commit *);
> +

Doc comment captures the contract well.

>   	void (*release)(struct fetch_negotiator *);
>   
>   	/* internal use */
> diff --git a/negotiator/default.c b/negotiator/default.c
> index 116dedcf83..05ab616f39 100644
> --- a/negotiator/default.c
> +++ b/negotiator/default.c
> @@ -175,6 +175,13 @@ static int ack(struct fetch_negotiator *n, struct commit *c)
>   	return known_to_be_common;
>   }
>   
> +static void have_sent(struct fetch_negotiator *n, struct commit *c)
> +{
> +	if (repo_parse_commit(the_repository, c))
> +		return;
> +	mark_common(n->data, c, 0, 0);
> +}
> +
>   static void release(struct fetch_negotiator *n)
>   {
>   	clear_prio_queue(&((struct negotiation_state *)n->data)->rev_list);
> @@ -188,6 +195,7 @@ void default_negotiator_init(struct fetch_negotiator *negotiator)
>   	negotiator->add_tip = add_tip;
>   	negotiator->next = next;
>   	negotiator->ack = ack;
> +	negotiator->have_sent = have_sent;
>   	negotiator->release = release;
>   	negotiator->data = CALLOC_ARRAY(ns, 1);
>   	ns->rev_list.compare = compare_commits_by_commit_date;

I traced this through default.c's mark_common() to confirm this does
what we want.. sets the COMMON bit (bit 2) and propogates COMMON to
the ancestors correctly. Good!

> diff --git a/negotiator/noop.c b/negotiator/noop.c
> index 65e3c20008..edf1b456f3 100644
> --- a/negotiator/noop.c
> +++ b/negotiator/noop.c
> @@ -29,6 +29,12 @@ static int ack(struct fetch_negotiator *n UNUSED, struct commit *c UNUSED)
>   	return 0;
>   }
>   
> +static void have_sent(struct fetch_negotiator *n UNUSED,
> +		      struct commit *c UNUSED)
> +{
> +	/* nothing to do */
> +}
> +
>   static void release(struct fetch_negotiator *n UNUSED)
>   {
>   	/* nothing to release */
> @@ -40,6 +46,7 @@ void noop_negotiator_init(struct fetch_negotiator *negotiator)
>   	negotiator->add_tip = add_tip;
>   	negotiator->next = next;
>   	negotiator->ack = ack;
> +	negotiator->have_sent = have_sent;
>   	negotiator->release = release;
>   	negotiator->data = NULL;
>   }

Trivial implementation of the noop negotiator. Good.

> diff --git a/negotiator/skipping.c b/negotiator/skipping.c
> index 0a272130fb..69472c58e1 100644
> --- a/negotiator/skipping.c
> +++ b/negotiator/skipping.c
> @@ -243,6 +243,13 @@ static int ack(struct fetch_negotiator *n, struct commit *c)
>   	return known_to_be_common;
>   }
>   
> +static void have_sent(struct fetch_negotiator *n, struct commit *c)
> +{
> +	if (repo_parse_commit(the_repository, c))
> +		return;
> +	mark_common(n->data, c);
> +}
> +
>   static void release(struct fetch_negotiator *n)
>   {
>   	struct data *data = n->data;
> @@ -259,6 +266,7 @@ void skipping_negotiator_init(struct fetch_negotiator *negotiator)
>   	negotiator->add_tip = add_tip;
>   	negotiator->next = next;
>   	negotiator->ack = ack;
> +	negotiator->have_sent = have_sent;
>   	negotiator->release = release;
>   	negotiator->data = CALLOC_ARRAY(data, 1);
>   	data->rev_list.compare = compare;

I traced this too, to skipping.c's mark_common(), and it sets the COMMON
bit correctly.

This patch is a welcome addition and LGTM!

Thanks,
Matthew

