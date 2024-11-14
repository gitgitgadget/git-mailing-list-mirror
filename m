Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2123.outbound.protection.outlook.com [40.107.21.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB2818C930
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615845; cv=fail; b=FTClVwbk+qHwviCQKgJmm2PCO7bbNMsjn4ygWwXR9pkWbAcpS8j29pc7QHJuHu4hJ29TQJcCb4iXpPaYhdeF2lKGJSnnNaoKNoxHgrS05tacfem3QbbS2w1hXRfZy5kvKbZZ7n+P+6t1gJVT+mBDLkhH0jrrDTnpwwjhui+4Afo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615845; c=relaxed/simple;
	bh=DdC3pQJGefWHLiWyNpdrsu6nv/WW9OiPXFUnT4b6A2A=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=G2xikljTHgJ/2pnjb7b3noWRvhQkWZmXSS8QbDbqR6PKHbL4MZjeXIAGJTq4qlDwYvwq/bBiiUXyY4zjPoDA1GpubFNLEMNPggl1PYdvrnq8RVRDhBSprne2TwqUvx03OXpadm8yP8gKJS5rnjaxuB4ThOhXmL1bJsQaDamE8NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttk.elte.hu; spf=pass smtp.mailfrom=ttk.elte.hu; dkim=pass (1024-bit key) header.d=ttk.elte.hu header.i=@ttk.elte.hu header.b=fSnqJ120; arc=fail smtp.client-ip=40.107.21.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttk.elte.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttk.elte.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ttk.elte.hu header.i=@ttk.elte.hu header.b="fSnqJ120"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xW1tBYNMzsfzyM8fY3S78qnxH4VtvKsbUgZzIlVCiiEVxvUkRrGLkfXI8e9Mw776QkxR8o0ajI9uq2aoRPOppLg6UzLW/RepSL/YjNQz5mRVQN/Uyo/PVmy2iprrZRaE7N5me24Xgzu4RyooT8DrLQ1By8BJtmPriJQKtIf2Qe0gE1t/nuNvW2iAPn6JCH0jMrZdIFaA0hd4+Rtd1em/0u9zu98mhQ/XPDRIdT7h11T7+q3vAuUP6LNhBNDM1S40eJz78Cw3DWYjWV8jtF98qn6WDKD+ucQ0Sh4UCzx744lpsCC+L42om4TVUOPnaeWo37XdbINvhYymG/3DXoMQwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g33qHdVTjLYrWp1WNzlGsLyD65EATrInmuZZl2r21Gg=;
 b=mMrd/aDovXVLtDjCOu1HsYRGzejrHr7TzpSz1hfQVFo9m5+g5x6Q/FkkX/twJESBaYSyIREEC7D24mOK9cX1SVHeHmMSdmUd0gsNrSgG0HQFGs1xJPDalA2wNgD8TLbkfuwNUgwXjt6D+l8Y/ukiTs3syyIJqaWG1eoNEVyy+S7H9N2qHL2uTn7QEm7cgTCWAEpElJwuxwo35VJG31cC62THXMcqWLhun3AaqxsIEXrRjjEIw68sbPYFyIWHnVFC0RT4Xvgga3vLAZgYh/RUDuorjo3HbT4H2kGD93J4043/DsBt8Qj8rOaWeJ7zm4oNksQYteDaz9FgWyakYxsPlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ttk.elte.hu; dmarc=pass action=none header.from=ttk.elte.hu;
 dkim=pass header.d=ttk.elte.hu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ttk.elte.hu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g33qHdVTjLYrWp1WNzlGsLyD65EATrInmuZZl2r21Gg=;
 b=fSnqJ120YquMbB1lKb+4C2ZMfJrAs/MDRMdaFKewNaq/deTNEWVWiL182X9NzOJiDZ0/LpgQJdSw/oK04/QRnfyHf1klkin+tMhyKPLMc5kCmF0teAAOdSSEgf3lvdjGGhLJh1NI1UOsyfotft6QoVUNp1BdfYpl3azNS3S1OO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ttk.elte.hu;
Received: from AS8PR09MB6187.eurprd09.prod.outlook.com (2603:10a6:20b:5b7::11)
 by AS2PR09MB6077.eurprd09.prod.outlook.com (2603:10a6:20b:558::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Thu, 14 Nov
 2024 20:23:58 +0000
Received: from AS8PR09MB6187.eurprd09.prod.outlook.com
 ([fe80::2f43:26fd:10b:64f4]) by AS8PR09MB6187.eurprd09.prod.outlook.com
 ([fe80::2f43:26fd:10b:64f4%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 20:23:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Nov 2024 21:23:53 +0100
Message-Id: <D5M6L00O65SC.RBYI3PG7KBDX@ttk.elte.hu>
Subject: Re: [PATCH v12 0/8] set-head/fetch remote/HEAD updates
Cc: <phillip.wood@dunelm.org.uk>, =?utf-8?q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, "Junio
 C Hamano" <gitster@pobox.com>, <karthik.188@gmail.com>, "Taylor Blau"
 <me@ttaylorr.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>, <git@vger.kernel.org>
From: "Bence Ferdinandy" <ferdinandy.bence@ttk.elte.hu>
X-Mailer: aerc 0.18.2-96-g9db6156cc521
References: <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241023153736.257733-1-bence@ferdinandy.com>
In-Reply-To: <20241023153736.257733-1-bence@ferdinandy.com>
X-ClientProxiedBy: FR0P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::9) To AS8PR09MB6187.eurprd09.prod.outlook.com
 (2603:10a6:20b:5b7::11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR09MB6187:EE_|AS2PR09MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 58554561-993c-4b21-b8e7-08dd04ea44f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXBDOEFDOFgzSkp3SGRscHphckhJY0xoRW8zL014QTN1QWJiYm1NcW5hc0Fj?=
 =?utf-8?B?dmlJWDd3YXI2QytEVjlHb1RIdzN1bkdJamRpTzJrWExrZHlKT2JPbDl0bW9F?=
 =?utf-8?B?QXRQRVgzWTNhS1RaTlV6V3IyRG9oK2V3WE42THBZai85ejU5ampGRGxZYWhz?=
 =?utf-8?B?NzhKaWpmRXlFZzJ5d0JtQWE2SFdlQ2luZHc0Ri9MSFVKNTJNRTB1TWZFWTVU?=
 =?utf-8?B?RWdpekpaZFFxRzQ2U1BMbHRVQ25wTzRkZElUMG9KRmErNUlJRTF3STdVTUVM?=
 =?utf-8?B?YXlLU3pJdGt1NzdyeFNDYUp4QUdkNWhjR25IZU5FY3hMYTUrRUFNeFhJSW9O?=
 =?utf-8?B?S2pSd3dsYi9Dc0ZnOUdwdkZmY3ZuK0U1SEJTTHJDT2lTUmdCMU5INVVDV1RL?=
 =?utf-8?B?bmtJbHN6blVISFZHMWtjb0F3bkxhYmMyOUtnSEFMWTBBUlN3MzB2WnFnUFl5?=
 =?utf-8?B?RnhYbHI5NFVGRjVvb2hzRzZxWSt2V0Z6NHZpNWp1dnZiUnVuTEVvY0pGck83?=
 =?utf-8?B?UFJveldRa2hnQnVxMlAyRWRqUUE4aGdLalMxQTI0RzRnVnd3bU45Y3paNU5z?=
 =?utf-8?B?blcxeDJhOGRuWGtHYlFYV2pzT2lQOG1jSzRnSkhOa2p6cXRSY2FOSFJxcnRj?=
 =?utf-8?B?MU1ma0dwUzl6RWZUYXJya2pLWVpzRDVveENwSFdMZjV0RnBqRHZvQXN4RDR4?=
 =?utf-8?B?aE1Cc0dEQ1dLNXJLZGVCZ3NxUGxFN3FDaXNrMmYzM0FQQmNBRDd3S3FNdlFh?=
 =?utf-8?B?NHhablVBbFhFSGp0aWkxMVRYbFRtelNodFJXVVVWRG5hVVFGRUtEMm5rQy93?=
 =?utf-8?B?eW9TWXpDM3J5ZktVZFA2VExpeXZKaXIwNmNYVW9mZ0RhSWRmRlFuQW1BUTlZ?=
 =?utf-8?B?SkwwM3NBbFMxeHo3U3NZVTlLSFRVQ01kbDROdmRQREx6VFVFbUI1LzFvMms4?=
 =?utf-8?B?bTYySmFtMEd2SVBaL0xJaFpZdWpXR29OQkgzN1cxQ0Zjb281eEdpdUtRdU1O?=
 =?utf-8?B?dzJXYjMzUUovUUdQS2tCZ0l5bEwzRHVMaUxQbnluSkoxVXhCZDA4aDkxVHd5?=
 =?utf-8?B?L3oxQjFjRmZVNmY3WGlWeWE4THEwaXVHNlhmbHVFQnlid29TKzN3ZzlNd1l4?=
 =?utf-8?B?OWRla0RVSEpXY00xNG01MzIzeDFBZXRmejFiSlQ4bDhHMC9JRjVVenNYeVRR?=
 =?utf-8?B?U056VnBNN2hsTzRPZER4aDdCdnRtajlUdVY3YTB4YnRsMDBGZXpWVUZJN21r?=
 =?utf-8?B?SmV6UlM3TXB2R2tiT3paN2Z5cnpDZFU3NVhuaWNTaEliK0pQdWNWM3ZnSXRC?=
 =?utf-8?B?NG42TEROKzNjeXlMQS9VUjdwN1hRVENKZjl2RUZtUVBIOVRKQXZoenhYWVJH?=
 =?utf-8?B?ZGFTOUpHSHdUaVMvVmt5NHBSSkRvYlVWWUFldmd6bmpkckkvUDZ6UmdrUElq?=
 =?utf-8?B?NVZ2aUg1ck9GdmhHQklPOGl2MFhyb1YveWFUSzRMRkZKZ0RiU3dZYmZMNkk0?=
 =?utf-8?B?QjVRTDlqWWVXWTB4dmkxbDN2bGNXc3ZQcEhBLy8rQnVybUI5bVhOU1lYZ29l?=
 =?utf-8?B?cmN4U2JYNmdWTkVMMGk5Mmcva2M3cWRHdW9JbTFyVDVwRmpVSStMbFpQbDll?=
 =?utf-8?B?MDU5MlZGMFU3VTAzcFlwdUdkQjlwUEQvVEpBVW5UQlUyaWUxUzlPdTBBQUdh?=
 =?utf-8?Q?Vauq5ewis5a8BLQtKUeX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR09MB6187.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEN5ZUd0VWswTTZqWDl1dmRjZ0NEODNZa293TWV6dXpURStPdmtMMWRhYVAr?=
 =?utf-8?B?eTQwVDMzcXhodEhueVpwYWdFMGc5cHlzR2NRNm5XU0wzTmtWTWhoakhHTG02?=
 =?utf-8?B?MGNWT0k5UEU0RHN3eXdhQWllUEJGcEFxV05GY2FyMkpzdm4zb1diN1pXRWoy?=
 =?utf-8?B?YmJJb21FZmorOWtCNHpES0NqbWpTRmdjRnZhZGhSVG1Tdi8vcTVKR0lQOGJ6?=
 =?utf-8?B?TjRVSXltaFdqbWRmeExraTZ1NHZQNmtRVDB5bGZZNWRlbWpOY0lGRDd3Qndp?=
 =?utf-8?B?eVdiRkVrdnZCTG5KNm0wT3JSS251aU5NcEc3TmpZRERHZTdjdkF6TW8xelg2?=
 =?utf-8?B?Qy90enhUQkM1VzJKQTRWekpJejQxOWE4M3lzNlFXTlZQcFNmeUcwV21TNkgz?=
 =?utf-8?B?dkt0ellrZU9hRVE4YXBpakdPVnF2SVhxWURtWXQrb050NjVIVXZJeFErcGow?=
 =?utf-8?B?aUdiTHA3alEyNlNkNlVhbXZsSGpYTVBrMGhrMjFqSWVHakpXNnhXMDRaK2ZT?=
 =?utf-8?B?amVJbW1oaVlyNk84amhvNWlVY0d4UVV0ZURRVVp3YmI1MjAwV2JLUTJEUVRI?=
 =?utf-8?B?QjByUlBleitTbWIvQVdVT1k4dzRTcC9JenRockRHVHNyL3BVSCtlSmxMZFpj?=
 =?utf-8?B?MnRqb3Z3dFFzZ3V6dUp3OEUvV3ExS2NFc21rM3krMnFXQVFvcDllM09GUnho?=
 =?utf-8?B?MmdjNW9uUGNZSm9rUnZ1d25BMEhocnBnV1FlUmpIUWtWYUVYZVZuTTB6eVND?=
 =?utf-8?B?YStKQmtIbk9IZlZNZ0xyY3dRUldlcnlWSVZpWWZYV2ljUWdjNWtiMWhCeFdL?=
 =?utf-8?B?RzA2WlhOcWl4ZG9ZRU00YlhSbFlmSmF6N3pXRHNiSXZ5enIxL084WWV6VUZq?=
 =?utf-8?B?Y29CQVU0NEZ6ZlVpQ1h1S2Y1SEsrMlRhaGJQV3BFZDBwbjBRUVBHaVhuK3hE?=
 =?utf-8?B?U0wyZTV6cXNSQnVPNVhYek5GVTFoVmJheis5d1IzVnBLZnZjSmZYZHI2Z3Zz?=
 =?utf-8?B?aVZlR2hnWC9MWUs1YXhlMUNNZHczcklaSkRKcUxnOW9mY0VlbzBvTHZYc3Zw?=
 =?utf-8?B?Y1R4aG9sSkRuT3F4cGdSVGpxREhVSmlGSDJOZWk4b012Wjh1Vk1QbUsrUEJ1?=
 =?utf-8?B?ejVnMkJrZHdaSFM5YTA5Z2loOGN2MkJKWXV0eW8vaFJlckNwVlB2aVZNN2Rn?=
 =?utf-8?B?NlF3ZGhFU1F4bjdiM0lYbWRoNFZpWGNBcjhQWDNESmU0dndFY1lTRUw3QkMz?=
 =?utf-8?B?MXNSZFFzZU5nZjA0OHZjdnpBaDBOTkx4b1B2V2czRE0zU202ckJJcHZrdlUv?=
 =?utf-8?B?S1Fia3ZvYytFS1JFbFpZTWdBU1I3bm54T1RzZEtqaTRLc2p0OHN1blU0NGhH?=
 =?utf-8?B?UHZzY1FUcWoySDk3WWE1Qy9VOWl6MkJXL0ViY09rN0lxZE83SnJQZ2w4YzVQ?=
 =?utf-8?B?OUdGUndVa0Z5OU9kTGt5RW9Fd3ZUWkNRVU10eXVqeXFaN0RHb0w5c0w1MWRV?=
 =?utf-8?B?ZkZsSXNSb3JzOGJ0T0xFVEpNY2M4cnYxOE90S3Z0dGxOUnBuajVVM0czeGlK?=
 =?utf-8?B?ck1oTzI0c0psYk1uOVJsUithR0g1VjhpK1RwOVRMQUhwVmIxeXlNY2VsTmYz?=
 =?utf-8?B?SS83Q1J5Y2ZPTzhrcXkvY1hpV1huemRwcUxvT0s3V3lBaGdkaW03TkZINEs1?=
 =?utf-8?B?RjVhVGl5ellFU2ZoVys2T0ZqbGtWcDA0cU85SE1qaUZFZ09JN1RZYmtDTmw1?=
 =?utf-8?B?Sk1hY0tTUTBKOGhSdmMzWXY0d1grR3lWY0RQOUpJcFBsZmFMak5IMVJ3QkRs?=
 =?utf-8?B?YUJHSkxZV1gzQytDMURENS9BYkorTmZIZGhJTUloSFM0RDBaL05WVzRnL1hZ?=
 =?utf-8?B?VjJtMFpHY3duamxJY2dUWkdISzdCanduZ3Rid2ROMFFZaHN2eFZwQmNFcVpw?=
 =?utf-8?B?WXFxaUV1NmYrZ3N5ZzlFOWF5OHFCdElzdG0vK2JTaEd6SEZYYUVkNlhrWTNW?=
 =?utf-8?B?d2RjSkxDNEdqTVAxY0YzVmZMOXo1Tkd5TTNBajdEeEhlRmxubEprdy92eHY1?=
 =?utf-8?B?VjducUpqNjAwZ0VtS0Rnam5SaVRYN0R2TzExUStzTmxxSVZabzdhVjRxME96?=
 =?utf-8?B?azhrb3dIVlh3by9QVlRNL3AzMUtxMzg3amRtK2tOT3l4cStHblBGeXV6Mkk4?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: ttk.elte.hu
X-MS-Exchange-CrossTenant-Network-Message-Id: 58554561-993c-4b21-b8e7-08dd04ea44f9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR09MB6187.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 20:23:58.4327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b366dbcd-4fc3-4451-82d2-e239564302c3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tor129ujsKeuRcTCP/Ro9dugRO+9oB8Cn88nkvqfG52TPm2/Da9ed/8dmizrNzikYznvG2NCIQirytEFqNNI0mk728el4gWQKYWomli6JFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR09MB6077

Hi all,

I just wanted to ping this thread in hopes of another round of reviews.

Aside from some smaller fixes, the main things that have not yet been revie=
wed are:

- the new patches 1/8 and 8/8
  (https://lore.kernel.org/git/Zw8IKyPkG0Hr6%2F5t@nand.local/, but see
  https://lore.kernel.org/git/D4ZAELFWJMKN.S88LJ6YK31LZ@ferdinandy.com/)
- changes to 2/8 (refs_update_symref -> refs_update_symref_extended change
  reflecting on Phillip's comments see
  https://lore.kernel.org/git/a7cb48e5-d8ba-44c1-9dbe-d1e8f8a63e3c@gmail.co=
m/)

Regarding the latter name: reading another thread about code style here I w=
as
wondering if refs_update_symref_1 would be a better choice.

I'm hoping that otherwise the series is mature now.

Thanks,
Bence
