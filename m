Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011030.outbound.protection.outlook.com [52.103.68.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905741E5B7B
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745608116; cv=fail; b=Q4wtifEWCipjEODB4BhmvJ/76Yn9DnNhyZljHLiUTWP5oh0ua4porKb+BVlgALSjCl9DkD/wIVGH9BVIxAHT++B1Ul+8WL+0XljN9qMN4XMLaJ675z1qkch1s49mKQtA0XHUhUH4EY4M2HcWEIaNCQvoMAEpqXRlI2/XdQtDTsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745608116; c=relaxed/simple;
	bh=jeq9Em7l8KUOy969BGhGhpZ+QjftIKnKVXrevkj0LpQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U4aaXDMgQ16m8KIILMGfXva3vRBgteMzfKIJIPk55uzk6TLuf6da+kwwckZWCOAAPaOwPsMinv32Xwh2m16t78E/JqZHD/+9D2iuj0unJjvewmV5A79kY0Zh/B+S4j8uRGNyeeJMzxJ32wF//Qj/JiZz6JSNHVebHh2oea+xs54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=s6fn6dA7; arc=fail smtp.client-ip=52.103.68.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="s6fn6dA7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+hqBs8piHPzEcf+P2/GIVXe7WR7Bq6c8byx3MuxWzwHEa0oYOccFzTiKv4Ee45QbAjgi3qYn1a68+qYjf6LoVrIjXmMxJj+OjsFdldsY4KfZ0qdZ/s4C/c2V8YocQDikJRrT+NaI3c5Ef4MvSDRN9FemUcPXCsqOIzJQ+eZKqrsX8p4FVbQlCEZ9rm5/FZeXN0np3VtEk/FHVIle1XHd9jI0LQMfw+Lc7Hsz/i7laTm0XSoHr2nGN+Kmaaif14YjGPHZSU325Oi2JEYELIHJ6iz4vRKP6+JkU3SoUXtklCEerNNsj0giu7oh7X4WHBBtuuM6plBf6E7FrNTfs6Q+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbT9zFSpwyVpMcpKq+WNMLj1ADydwq59Q0LELKZ27z0=;
 b=p376lfyY2nJerMWYcReX8uMQYw3Ko0VIUe2gZTf5IzCT31i5K1wqyXYuUQQaYKacHxeXzxTVLd4rfuLBPgbVCpaKQnUMvHWg+rwrjr6rCN/uursGtwtTDUH//YCuyoJHvF1DZOVBipCzVqwof16qj96U5gWt7fF3Rha5S1N2GRENTjcPvfntEhxNRPTAKf3yq1NO+ViJIneJ6nDBhkt1FPCU5Rvy4VlWgh+MBcYldPftOV2578EyYJrNFPLyoGldlNBn1U11g/sJWhDzdG96oBZunM+hQJditJNX0eUE/TapY3yoyBxV9GqFXY6vExttHaIiGIMTpU+3gIALKIt48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbT9zFSpwyVpMcpKq+WNMLj1ADydwq59Q0LELKZ27z0=;
 b=s6fn6dA7UWpGwy9ZXtqoyHqX9UcxFPd/fWHFC/P8K1B0xqHEwT0KY7cmlFN7iPViPHmQHn62Q6oEQ72SAOhPSd/KaLYKn9YjIOc6l20rQZD7PjYpEQfr2SbRpN/OwIFEuQVz55/Dixmw0WH5FCCZdrFOkvcsBdc9e8riqFVAKPvFkCAq6AeFuxPKS0lnSWOnBUbwM71FQYCp4rJmzjwOLDlG/jhuyAmWnaAPpLIKjvX+2lD0HZlzZwV/vBDT2BnGwlpsgzfkPLmLtQc4J/jBHB+tlybwmzVgTYgsCJsVKlY4o9ot96+QYGAxYLaU0FTZl3eQtD2dlrbQunUH+KYS8g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB8995.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 19:08:26 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.038; Fri, 25 Apr 2025
 19:08:26 +0000
Message-ID:
 <PN3PR01MB9597693A0419435C31606636B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Sat, 26 Apr 2025 00:38:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] send-email: retrieve Message-ID from outlook SMTP
 server
To: Erik Huelsmann <ehuels@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org,
 M Hickford <mirth.hickford@gmail.com>, sandals@crustytoothpaste.net,
 Shengyu Qu <wiagn233@outlook.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95973F4B26A8CE2BF17A3AB1B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597A549B8A6752F2F828266B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597D4949EF555E2A96CE745B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CACOoB6irNaLLsRRf-aEsRbAmnvLJPFhDGnD0j_D9fY_ZbgAL6w@mail.gmail.com>
 <xmqqtt6ctbim.fsf@gitster.g>
 <CACOoB6hh_jWqC3pxiVVAkKN9+mPVUeUodKqFRmMe_Da65a6Bdw@mail.gmail.com>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <CACOoB6hh_jWqC3pxiVVAkKN9+mPVUeUodKqFRmMe_Da65a6Bdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0126.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::9) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <de58e5d2-ecdf-424a-a7f3-4fe1a2529e03@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3cc5f9-662f-4563-b6b9-08dd842c8e94
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLQowKaVx7aWRf9b2EXVRKJlE/zJN0Yhm7N+IQgWbLHEAzVSXfJOsD1vzXyke2VkD2M6J5KBf55VZdevOSMF0+XpZsCAvfiaEAYUcn8H8STlLE7E5b04aHS8UyUAHKcvJypNGjZp8EO4qKlop20PVnkXSLuX6Yn9lxXXr43u8VZk2Q7u790J4X3niifxKexzXS2s3h0xnRYVfqToMJNrmWIXdEOdZP1Ui5e19hkyaEwWouqKNrQJhoGGUlFTSFfKpmq8ykQRvFltdpGsxyxiWSlUS4kndfoD05bgd6n5uDcncbGB6gkmI+mTLAauLb7ictnkuSUtic7T/JWHIhApvTalhoq9nfEGBS3OMMPM68pFP6OPAhklN32OsumDsnIC9ID4R78AyeTFKhZ7/DuTfiaDmpAIdnaWDdqEUYlL2ILaHQnFYauzOga7Ns/fva9oW4TYHGhOtYRyXuAzyzHeykOjmFn3zon7rteViBgKC4a+m0v9w92Mo+h4aM+4PRL3bZrdu1B56OGHMBJTMPGcgX2VZOxo4EgcAVbPBh9wvvb6/4sUCEu5DZX52bQyqfKBg8eOYEiDcU6A5APscp1xyosU/fugg6KAzDvDBj4t428zPna3l3qVJo4Vr2sGN1+6nHqMTLO1pKXL5AakTOW+lvyh0liTH9yO+dHMa8ivGGe/1xyrMgSYJk9wX56+ZLijy9/kKiHFrlIa5wlirendd735GMfNS8meEIlotX6rF6/51A5gVPYRn4DeO8pV8aHp80T8mKBeonwnHsXXo+gG5Kbu
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|15080799006|7092599003|461199028|8060799006|19110799003|10035399004|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmE1MzFPUjlqWmdIK1I2ZCtiTDhJYkwxb1VsVkw0UjV1VmkzV1Q2OGVUcnJD?=
 =?utf-8?B?MjRhSkRoMm9XTkRURnhXNEpqSmVabVB5NFhNdFNpaTBERHRKRGtrVGpTQk9l?=
 =?utf-8?B?OXB0OWRKcENaUDU0WGdVKytOekwvcGYzWVJub29kU0tmYVZ1cXNOL2VoVDJU?=
 =?utf-8?B?QVcxUThOZWxBSEdQTkNUelE2TUk5ZmxUTFo2cnZudjNjU1Q2QWJJcjg0WldG?=
 =?utf-8?B?clc0ejE3c20vL0hCMlp3SVRwWWJNSGlxbHlVVlFkT1dNVXg5UUJpampiMy9T?=
 =?utf-8?B?TlJwODVXbmt4eXNHQS9obTFyWndYMjVvYWJ1MCtKUnBzYTZ4bkVaWGpoMHEx?=
 =?utf-8?B?SWdVZXB0MUp6SHZsQlZ0QW1wR3kxeUhkNk5IVHlBR2NYODNGKzVsRjZyaVJH?=
 =?utf-8?B?ZWUyRG5ZSWhJYUtKbXAxc0tuZzlJYU9JbE9QejMwMVdQUWxObGNIM1pHSEpL?=
 =?utf-8?B?QVVpWE0yT0RIdXQ0MzJiTWE4d1JMRzdKVCtTMGhWdkVwQThWUUhZZ01NanJS?=
 =?utf-8?B?alN0eWw5Z3JkWkNPWk54N1AzcE1TSU4vK05razJ0cStFSSt2VXdSa284d04y?=
 =?utf-8?B?UU41RzZ2ZG5tZ3E4TVFoWDRidi9pK2M0Um85eUIvSEdCS1A1bGsyUUFoV3NX?=
 =?utf-8?B?TDR6L3cycjNyMmVrSnIzak5BUTlYU0xENk9lNkpFUzVCLzZkYmIvdWJYM3Ba?=
 =?utf-8?B?ZHo5YURNZG1CUFFPYS9vdmRoRVRqRXZBRFBiOXVlekh0ZnRISVdzTTBhbGU3?=
 =?utf-8?B?ZW42SjU0WUZaSFJtVEs0c1RScy9JTTJDRHlOYWdZME9KU2xnMmJVNUFySURn?=
 =?utf-8?B?UzAyc2tlSUpodDhySzYyU2JOS2dUOTFwMGFCTEh4eWJjcWk5Wjc1Uk15L3o5?=
 =?utf-8?B?RzJUeThXblpINWxQT2prY1E1TzRwa3NsQjEvbGxhdmRkbnpxZ1FHVmdlTm9u?=
 =?utf-8?B?ZWtKUC94bzFpdnU2T2x2d1F1T3pYeTFmQVZseWJjRjI0WlhTMUpRNzNSS255?=
 =?utf-8?B?UUNna0FxTkN3RkNFaG9WR1JmTVhRNm5XMStFWjlpYXJhRWt6eSs3V1BuYThk?=
 =?utf-8?B?Y1BTRTJEaWdSZ1QzelNncEVDTHIwblBBSjAzaGZpaFVxODNKeXdyNjQyOUFZ?=
 =?utf-8?B?UVhKWTdxT0czM0tKVGcvY2tUQXBSNk1MY1cyODZzQmZnYmVOOVVnbnM3RGRC?=
 =?utf-8?B?SWYvNmdVL2tiOXo0bThkbVBNdlNlK29DZFV5UU02b3dEU3UyT1RIR1JOZHE1?=
 =?utf-8?B?UkRnMkNOQjgwV2hIaEN2NU1FM1R0VU9WK2E5dUpWemdlbHdqZnB5RWNMY2FY?=
 =?utf-8?B?Z1k3QzRoUFlQUWtJWldqRVI0WFZ1bitpMzI1TTRkQTR6REVyZHpLSVRrMlNi?=
 =?utf-8?B?b2RyQVQrNE12cjRSR0JRQnhCUzlsbk5FYjI5WGZXeUFrSUVjNVJ2RlhlMGdx?=
 =?utf-8?B?MW0zQnlaY25zSkcvd1ZWdmFmSTFBTnRnYWlOeTg2b0w0M2xsTjh2UCtLVi8z?=
 =?utf-8?B?M0wxZ3N3ek4yV1lCNnBhMWJYVDUvWE5sbGVMeGlqM1ViS0pOc3lreFNDSVFS?=
 =?utf-8?B?S1dlOXMyL3d5dExBMHBDbEUwNHhrUWFxbGEzVWZ6UGhPSjBZd2VpWnhHcWg4?=
 =?utf-8?B?WnV5R0lwZWRzWHRJdkttR1VpdWRhNGc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlBTdktSdEZHSTQ3L0xLTHM5dHdRRWJxSGx4RW1DeGI4QitSNmM5YmtPNDVM?=
 =?utf-8?B?OUEvdHA5RzBLMFhRNVhSN2tmSDVaeHh2UGtSNXJGVERzU0pHVnJuSzU0cVlX?=
 =?utf-8?B?cGRTZ1YxYjNzRnh5NmpQVDNkVGl1YmZKREhNVWtlTTVQOTJGWENjVmVpaVdy?=
 =?utf-8?B?VlpISkcvbVAwMGtGOHJYRlVGOU8vc3FLWHMzZFdlaS9KYktaQUlwZ050NXU1?=
 =?utf-8?B?VktUNWozTnZ1eHEvWkU4WTJZYUN6ZE5zNUVGMk1nNXlUUTA5TVBvczIyUU9m?=
 =?utf-8?B?WENwUXFiMnkwR1FVK1VDcW5iZ1RNZ1pDQng0YStwN0JNNEh6K3huSUNCdHRX?=
 =?utf-8?B?d1kwUGw2dU5WS0FhaTNSc2Jmbnp0ekMvdDd3cUdlbUdTWlkybk9TMTNVWENy?=
 =?utf-8?B?c1M4bkNqWEcvL0pnV3h6S2VGZTFSTHR1K290SC8zQTU2anF1TDQ3czJzS0Y2?=
 =?utf-8?B?ZjBqVFFaTmlua0lHQkswTUJaTk9jbE1FTVpWdTJaYU9oT1lMOTVnM3NvWnRW?=
 =?utf-8?B?amlxcGFXaUN1K1NvT1Z4c0tzdFYwTSs0Nkl6MVIvME5Yd044ZmhuSkJZUG1m?=
 =?utf-8?B?ZjVjazErd2NqSXFTWjA1ZU5ocGtCM3FnYzY2T0dzY2NYYjNjUWNCWjg5bkNO?=
 =?utf-8?B?bDY3aWtHQW1TQVBHcGg3QXpRMUc2KzQyaTlKY3JVdEh1Y3E2TUkwZjNvTFAw?=
 =?utf-8?B?UDQ2aEUwL29ldkJpNklReW1NeGdMT21DdjRIRzgrc3M3MEVqYkFnNURoUmR2?=
 =?utf-8?B?NjkxVm1ZY3VvVnNGeTNubUxobkhEeUtzTVJHYVN1QXNDQVp5SE9mbllUWG05?=
 =?utf-8?B?N0d3akxhTUZTN0NMUTVwMUlObFJSWXd4Z3ZZa1BmdUNnN1VMSTA3R0hqOVYy?=
 =?utf-8?B?cUNiM1FTaUc5SDJ1TTBEazF5YlZWbEh5WFpXdk9TR1c1NEFBcjc1TVpLK1FX?=
 =?utf-8?B?WVkzL2dIRjNBZDdVQk1WL2EvY3d1Qk5OY1dFUnU3b0lPc3Vvc0dGTnNOOFda?=
 =?utf-8?B?Vzl1eDQ2TmtNamMwVjdGWjA4U3JmV1BaUGhySXFPQ0pUYzBBQnVBaytrMEZz?=
 =?utf-8?B?dVZUK3hyaW5ud2VSQnJNQ3NNT0M4MUhUU2VGaU5SOWZVcG1rbXN4S3hXaTdP?=
 =?utf-8?B?dFVJREsvZHBUdkpoRW16UXMrSkl5MlNXaWc0ZnFjN3Z5QWYyeE1TaW9RWXNw?=
 =?utf-8?B?SHh0ZXdidkNnUVU1QlFzQ2Q4RnQzOXZIOFU1NFpMc3NuSitYVkViaDlQSWY4?=
 =?utf-8?B?U0VTUHBZRHlyamVpL08yN2UrWlhjQUx6TTRhbk9jbjRxZnBwdVNsbWppdnB3?=
 =?utf-8?B?R2NWMHFqS3RSU1d5SHBhS0VLNEc1RENLVkg1TG1LMUZCaFQrQ2toTWtDa1U1?=
 =?utf-8?B?SFYzS2xuY3lPWWRxeTlSWHE0T1RwU2xXUU1tYld1aW5iblY2QWJsaFozU1Fx?=
 =?utf-8?B?eDYrdnBpbG1jdUdLb2VvRCtuQVJFSlREVTN4eEc5Mm91L29EVkNGU2FtL1ZO?=
 =?utf-8?B?ckFGT3JZK2ptZEdSTGFsL1daZklIb2pIUTJwcG16bDR4NVJlbzNjai9nTyt6?=
 =?utf-8?B?ZlZRUW1sOGdkT1o0blpTaDFZR1lyMU50VWhGNXd6d3IzTXl4d3orK1d1OEQx?=
 =?utf-8?B?U3VZY2pTMmowZW94d1ZyR1R3bHIvUWk2Rk5KeUo4dzBrc0J6QjlzNVBZZXVC?=
 =?utf-8?B?eXVYSHdFNW1ORk9Ya1gyRS9QWGFBek1WSmtSV0xLVER3QktqcHFBSHVFZ3Bq?=
 =?utf-8?Q?iNMyvmug/At3Kot8Es=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3cc5f9-662f-4563-b6b9-08dd842c8e94
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 19:08:26.5783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB8995



On 26-04-2025 12:35 am, Erik Huelsmann wrote:
> On Fri, Apr 25, 2025 at 7:08 PM Junio C Hamano <gitster@pobox.com> wrote:
> 
>>>> Authen::SASL now finally supports XOAUTH2 and OAUTHBEARER thanks to Erik
>>>> and Julian! (Link: https://github.com/gbarr/perl-authen-sasl/commit/958a3aa165d30cf4e3cbb36dc45306de627aa13f)
>>>
>>> And it's official: https://metacpan.org/release/EHUELS/Authen-SASL-2.1800
>>
>> Wonderful.
>>
>> We tend to, however, try to cater to those whose distros are slow to
>> adjust to upstream changes.  What's the ETA for the updated module
>> to major distros?
> 
> To be honest, I have *no* idea. I think Debian is stabilizing Trixie
> now, so maybe it's in the one that will be after that (in 2 years?).
> 
> You could however decide to support XOAUTH2 and OAUTHBEARER only when
> they are available? Then you don't need to increase the minimum
> library requirement: there's no API difference between 2.1700 (the
> current version until today) and 2.1800 (the newly released version).
> So if you were to probe existence of Authen::SASL::Perl::XOAUTH2
> and/or Authen::SASL::Perl::OAUTHBEARER, you could conditionally
> disable the feature if the probe fails. (Using "eval { require
> Authen::SASL::Perl::XOAUTH2; 1 }" should do what you need: return
> false if the probe fails; true if it succeeds.)

Even if we modify the send-email script, distros slow to adjust
will also not update this so soon :). Its more of a wait and watch thing tbh.

