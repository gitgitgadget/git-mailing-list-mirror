Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B062727816B
	for <git@vger.kernel.org>; Wed, 28 May 2025 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748425017; cv=fail; b=O7ZNZjHQPd2H24hWTRl0YPZ25/UGlNJiXaAuvYNciEVVRQ3JMjBR7NEt/r9z2aEw72DXeP37Hnu+9/lr9smPm7ABbPVyvWfGY5jx40yYD68w7/CFFxnCUM6Th6sdjGHwhFfhWhlq3Oar6GA+6j7wcf5PcZMIMDHlnVzWAB0flGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748425017; c=relaxed/simple;
	bh=28ddKhsN6ZD4NzP2vV24WoeKBVm1fYnqr6sQe9N0WiY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=arDvYkinz9OTgg75dNMsHvkhDGvkbsEclRzvVkflI6s9SL/MgrZuhI7Oa1s3slSLeWbvwMMu0Ag1UpJ0IXAyOWCOpw8oQChdWJ0WccRFrY8j2rsz3IqWsT3L37lj2UMgNd2rgJGF20ZhSoBnM+d4Y1uANTUvzdmw7JHJaCsrBKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=KoTExFWr; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="KoTExFWr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLkiEz07DqCn4e8curY/wQODN7tcQvWMXNgmEXcx4wW2kb3VZGiFoPgzIJD93n7Q0OInUFASyeif0NMM3tKtXI1qkcqE9JZ9yqlelI+aQOtvVE1KYgmdVXrlX1GnOufcH+L/LTJXncj+raEvudFDaBgKo3FT8KctlKtLxK20VbDZpjz43EX4Zhxa6vYBhamudUsZrw2ONOg8GS047R3HD5UgbyQmydPEiwcK6i6LMyodyyibSzJAbOxQltJk9lG79rypYx2u9MQvjnWl68mOEwngG/Dqm0iuaaO6nmQtfjxo0KTDv3m1YMSgvY54hSjYc1YexxBwvuXEWJCAd3cCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RK4Gi6dmv0nlUp30KXUkrOAePBEiIdG6uDYE5FlgTY=;
 b=OZpT18fVjEfCO1qxHHDQ08g/IZLnGV3HYYzy/ycAudCnEMtbdmrbM0PgEX3COA3FLupBYKFgPk3WIapLMIw92Qs+u7kDNvbppAgwe+10l/wX0/M59KLeK933BPqFV+x3Xcoo/C++icwkwMhSaO44DwkDNCA2oZm2f9r12B848K+5Se/RKGFUI84iN91+PWdq+Sf2MOg+7N8zxfBZIfpgRJq8QM0oCwDqNyCooi8Sm2CPKknRStDff6330T8OyzZqGf7n9GviqxhG3ur/c8O1EyaDq3v58cp6q4vUc4YjLM7VPkYRBb8wpBzXAwJQXCs8K1gKa6SpGOPyMh4+X4xkqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RK4Gi6dmv0nlUp30KXUkrOAePBEiIdG6uDYE5FlgTY=;
 b=KoTExFWrsScscN95qZgAQaKW93FQdyM4es0J/uByqY+FfGP22VA3KnfNM4m1Dxbm2gKA8Roxf9RycEz3ifNwKUuENvKf4Nf7GOi+j82REt7exzGTjGwAAt2CRFJbBdwPPV6MDWNynFg6czZ1vF1ug5souNrZwg63/NzMA7p71ikVaRGldvwP9IaF+MRNAE8KENoBqRgT92fZGjUyrMJKRWRlw/Vxxtgc91EAyimEeugA+1SmATxOnOEV74NboYu16EJSPf+ImOa7HrdUbegut6r0Ismo/FSVUAmip6p7IDnWMfYUmDAm89ZpEQg/Usmqn1xn6JchDQGUQpME6GAH5g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB6632.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:76::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 09:36:51 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 09:36:50 +0000
Message-ID:
 <PN3PR01MB9597EBE360893FA638B17952B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 28 May 2025 15:06:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] docs: update email credential helpers and improve
 formatting
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Julian Swagemakers <julian@swagemakers.org>, Zi Yao <ziyao@disroot.org>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250528070521.17379-1-gargaditya08@live.com>
 <CAPig+cTs0+AUPp1euxqKkX0iFTdw9zGuMU-Qnp+ywhcyP8gxfA@mail.gmail.com>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <CAPig+cTs0+AUPp1euxqKkX0iFTdw9zGuMU-Qnp+ywhcyP8gxfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::25) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <a06e344e-e555-4947-a9eb-9329f44ff341@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: 06bc1e27-1c1c-4e22-7736-08dd9dcb2c3c
X-MS-Exchange-SLBlob-MailProps:
	30ekHghIwFpWJZJ/S7H67WW7FVejyf+CelZlAGH5pkRuPTMvMjw4895HMHU8Hein46L1CNPdarRu6b0XCISr5SQxyrByX4eCApGaFE3I0UFOVvS+VLAVz4djdEGPe1vBoGgvzQfPEhhKPPEfClJIYQtgouau8j5lZqU0Eb5zqNZCRBWG4RwpuZn48b8Cv8HxsVE6SmEe15/AN0uynCIQK85SXlPFD0mcUuGWDIXvOs7FGDMVi87A0uxCmTCpmFRPJpj7nOtCddVc8seJ4WownnvWjm5NFkCArHJ5WVHd7D+zTAduWLcezVrAOYHh/zY6vrULALJGEFdwfgZS0iuRCPHPS0vwyC3mFrgdAm9rCMZiEippOJmO/UUJwvOW+sDGYMNVNTWNtsxA8Nnsel28Y3DTQ5MSrc9TG+vQz6KUhqh0ejjeu80m+dR4gsCxHvgj7lTrTB0ffhGIrfKIdeEh7b1h/7a1gMNknIcBVM78ZPP72HXHLmxSbnvpJJIRqiBgpZ4VRAuIYnlU9Uxyv3zWVcukj0SZSKrz0bC27kd+FQHlPfqXvl97SNPveymM3UX6lg4/Co8BsEcDHgetSqsYcHKIOyjLE8uwWTc5mp29Rmg12NTzu98F0W1DNOx3lRNdAKP7XnV42pfJeSCSCXiShFSt5G2ypZUJeEDYhXKhNUayhJ+PTtKp4qJAUjl4MzgIe+fRN57JemQwWdvKiwPHKT0zmsNWjAPMMBbJNPOT2068Yhjdp67uzYlh8ikTHdWq
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|21061999006|8060799009|7092599006|6090799003|15080799009|19110799006|5072599009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2U4Y0VEdFUwK2ZPeW14NDNMOENqT3pWM2hDZW9JWTYrK1VZMThxdlJkckdH?=
 =?utf-8?B?dkdqR002ZldDdzhPbXNsQTRTQzl2RE9ITXV2eFFUNHRUNld1SEtNM0EwVDRD?=
 =?utf-8?B?LyszdFR4Smxqa2lmbUg3eWF2SGdmTVhKVm1aR2lDeFNMMTFMczlzQzM0eHpj?=
 =?utf-8?B?eUoyMDdXODczZ0N3YXRCM1FsMFBCTE14V3dvcHoybVJqeWMrY0lvN3c2Z3FS?=
 =?utf-8?B?S2UwaXFXU1dseE90RzhBcGZESFVFQnZlTERnenloQ2FMaG9kcUZISGU0M1o2?=
 =?utf-8?B?VUV5bjFEb1ZkVjFtQVBTaVRDNkhHU1d1M1IxeFJLNys5MERNVHZYRTVFcjNL?=
 =?utf-8?B?M3I0Mnh5UE0wQzZvNWdMaUcxaWI0N2w0a0FpOW4wMVIyRVhMYjdOcSt3aldX?=
 =?utf-8?B?R01UR2FrN0dlL29YRDlPUlI1MmdudElMRVNRWDdycXpScFdXSkhkVDI0Q3VN?=
 =?utf-8?B?TmJza1A2S2pJaFhXSWkzaHZOOU9XdzBoUG9MZmhJRXNzZlVBenZsaTlEYUxh?=
 =?utf-8?B?THdORkt2ZWp4eSsxdzZCUDF2WVI2VS9xdGFON2d5d3hwbWZVMzd4MWlJVjJ4?=
 =?utf-8?B?MHl6Z1NpeVYweTJwZnV3ZkFUTDA1a3V5N2cvVXlaT25HV2IvNUJvdXNRMDJZ?=
 =?utf-8?B?ei84ZWhBcGhneXFJNk1LNXdjNnpTMW5lWnBmbkovdGVFTnNDQVl1RWs1d3c0?=
 =?utf-8?B?WmUxRk1FTTZlRk95OWNXYzA2cUdxODN1amNJYXpVRzhhMnBMWjRiU1VGOTVW?=
 =?utf-8?B?ajNMNmVPcUczQ0Jicm9OWndjV2c4NkNRWHd6eEcvckZPdnZNN1d4WHVQbWMx?=
 =?utf-8?B?TFU3VGxRcjE5VVRCZzBTRnhWQ1UzSTN6eWdOMElMV28zRFR0eWdnQ2Q3NlFN?=
 =?utf-8?B?MjRRQ3RhVnRIWmpPZzE2SFIrTDdCTG1lbjF0VkZsOGIwamFpdUdEUi9QNUky?=
 =?utf-8?B?QlZtSVBjYW5IR1VISGYzeEFyWW9tazlsQzZla0cxNFQxSWI2Y1BTYVJXbVRI?=
 =?utf-8?B?S2ZTVEFhcTBUVmZWRHN1UGtNQThCSXhHRUlUaXFjaFZSOGs0NWFvQVFaeTIw?=
 =?utf-8?B?SzViRTk2Rll5d1NqNmZyenk0eFlmWmVwUXk2QVVsczArOFNSZlo5ZHRDRSs3?=
 =?utf-8?B?T0RLc29rNUJrN0E4TnFBaUVXcDdOMDVjdzMzR0dXN0kzOThxT2YzL1dGOW9Q?=
 =?utf-8?B?N1JWUHg1VysrWDdZcEdJQnU2MHgwa25hcXVlemd5anpvanNsUjMyeUZnRGtm?=
 =?utf-8?B?aGJFQTZZZk50VHpkMWdrcHJjalJXSWpjZURTVmJySHJmMnVpYlovWE9nYW0y?=
 =?utf-8?B?dWFFVFNMTG1nVGZ3VVFwSzJ6dTZteUJCZXVOV3pWS2puK29EVi9BTmRBSVlJ?=
 =?utf-8?B?d01rREVEY1IrbXlheThRMDVFNHRFS2R3ZkZDR1lUc1U5dmNJK0l2VjlSejlu?=
 =?utf-8?B?OHFUb1Z0dEhsUmZlRXdreSt5RWZ4QWZueG1zTmppRUZDQm9vMnRkZHRGZjJI?=
 =?utf-8?B?c1o0REU1dWx6cWFPdWdNa1NRR2lSR3NFbUp3aGp1R0hWL3I5SGlVc2djUS9S?=
 =?utf-8?Q?3OQjY76rRINmk+1axAZTX9f9A=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NktGTFF3OUhUK2hwb2VYZE5KaDlCVHE3OXpmdXh2d01hT0ZOelc3aHFORmgy?=
 =?utf-8?B?YjdIa2ZHZ1hXSTlnSWwyUXRya2JtQy81U0FWR0UxYzF2aTdXelFWeW5mYmpx?=
 =?utf-8?B?ZWpHWTU0L0llcWlxZEEyZWlzS0t2TE4wY0FXS0pLdDBZbFVOZlFWYzVUaXBY?=
 =?utf-8?B?WlpOcjgvL2VxM3pHVmVxeEIvd21Ma1ZyYXB1T2hQR2tzVTlHR2gzZkkyMzFB?=
 =?utf-8?B?K0YyYnZlVkpsSEF4SEdwcDJyRytrMTBqcldxNzJOeFlpcERpSk5IejlRNThT?=
 =?utf-8?B?d2FuK3d0WnE4N3BXMmwvMXh2UERuRyt5aUZ2bHY2UU5QRDRPVFdrK1Q1QmtE?=
 =?utf-8?B?TGRhWkNpdTRQOE9PakozZWJpMWtVekhuaUhjN0QrUmtWT2gxVGpNeEVVMmRD?=
 =?utf-8?B?M0NScDBLbC95OEZFdVVROGNWbXhFdVlKckpvd3ljTDNZdEV5VUYrK2dNZHVO?=
 =?utf-8?B?RXVvTzM0QkUxYUE1ZFVibnRtZThMRndHT0JoWEE0NnpMeTF2MUxodmpmb0R3?=
 =?utf-8?B?bnBvOGl6SEgvR09ZTmtCTWJxQi9Xc21SdmFsQ0xBVkNoaTJib1RwTGF2MUQy?=
 =?utf-8?B?ZnE1SXVmdjNhS0t5S0RuOXRLSGJCNWVQNlA3UTIxVDY5T2lhZ3cwNU04akhF?=
 =?utf-8?B?TFNhME9uRFppU0Y3ODJpZ0J0QklDS2lMdUNQdWs5djM2cDNMRFRzMHRuVVhr?=
 =?utf-8?B?OEsvTEs5Z3NVc3VJQjJId281bG9nZXFvZVlTSTErV3lzeVF2WEs3NVlwT0FP?=
 =?utf-8?B?R01YVUFacDlPZS9UWis1WGhZUkFDUEp0TjhvL2h5c1RWTE5uaFNCY1M4SFhx?=
 =?utf-8?B?R3dRYVc2Y3JaNG0vSlpCcWVnQ0JBbi9LTzQ0bXhBY1pwNjB4UUl6YmZyNDcr?=
 =?utf-8?B?NUx3STVLaUZzLzNiTWo4cys2ZDZBeU9idmd0Q2RYcnZmenpyWXdndUcxNHlp?=
 =?utf-8?B?ZFV6cXZndi9EaTJZNmNDdzJUSStYT3phV1hyaXhKSUJFMVFyd3ZNUTBzdWFO?=
 =?utf-8?B?c253ZnZwVG1QWUNIeWlPQmpJVGdUZTB3SUVpSk4yLzFYQ2JYelNteVc5eHVC?=
 =?utf-8?B?Ry84Q05rMlk0bjRvY0NzYTZJeUIwNWo3OHNSSjhXWGRXS1huWWl1TERqeXpT?=
 =?utf-8?B?NGJCbHpNdExkVDFrdis4MmgyWE5ldCtyWlc4cFlBbWdDTWZzSFlNZWZwTVZU?=
 =?utf-8?B?ZGJ1REtkK2MvbTZwaG5aMTZlWE42T0FBWHE5QTFMK1hzMEVuZnRDZ3QrSElw?=
 =?utf-8?B?cWw2dFplSGJqRyt1N3ZGZDZDeEZqdmZBS2xPNFR2TjNKa1RoVWhyVng0cjQ5?=
 =?utf-8?B?bUQwVlNneFEvRzI3Z2dLK3BlenY0RjZINEJoNndHSjZtSHBaRXBydk0zd1Uv?=
 =?utf-8?B?dGU4QXdVZFlxclNSNXFBUVRsdUxubHU5YzNjL2RJbXY3Zkg2cXp5V2czMjdI?=
 =?utf-8?B?UWZadHI0Zys5YmpxQzBsdnBRbnkrb0ZvMDdBYzM2NVU5SW1hd0VBMmRHTHBZ?=
 =?utf-8?B?Y3VmOXl2d1hsZ2tKY1g0VzErSlFlZ2Z4dDkvQTdjZHVaemZadGliUzVpa0w1?=
 =?utf-8?B?U3AyK1F1ZUNtTEVkWkNMR3IrNnJzZkxqN3J6OEs1cWxPMTBvY1h1N1dKMnUz?=
 =?utf-8?B?ZkY0VzdEQUd6SWJLbzFRVjhVaDAzVEFJbFVDbXJTSXlmd2xIUGtYRnc3bUJP?=
 =?utf-8?B?My9KQkZDclo5azlKdDc2WTMvR1RveVp4SVJmS0t2RkNnMUZic0ZLbmtuaVlE?=
 =?utf-8?Q?3UMirEyomIBRh2Xj+E=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bc1e27-1c1c-4e22-7736-08dd9dcb2c3c
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 09:36:50.5256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6632



On 28-05-2025 12:53 pm, Eric Sunshine wrote:
> On Wed, May 28, 2025 at 3:05 AM Aditya Garg <gargaditya08@live.com> wrote:
>> v5: Added a patch to make the purpose of using app password for Gmail
>>     more clear in `send-email` documentation.
>>
>> Range-diff:
>> -:  ---------- > 1:  2c47cc5396 docs: add credential helper for yahoo and link Google's sendgmail tool
>> -:  ---------- > 2:  bc1d0471ca docs: improve formatting in git-send-email documentation
>> -:  ---------- > 3:  b9e41e2492 docs: remove credential helper links for emails from gitcredentials
>> -:  ---------- > 4:  a6ad7ac810 docs: make the purpose of using app password for Gmail more clear in send-email
> 
> Strange range-diff.

I think because I used git version 2.43. When I compiled my branch with changes, git format-patch over there
had a very different range-diff from this.
