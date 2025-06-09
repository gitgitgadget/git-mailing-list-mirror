Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011024.outbound.protection.outlook.com [52.103.68.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14BBB67F
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749487621; cv=fail; b=KFPoCeMXvBAw8K7Op0htmISCWQY2l6UQtWFQ6UQI7GujySqOJVmRotlExdLa0tXImbjP5bx/LC77jZrQNz1wWQeKaDuCc48Opy57bhEEzLu3Wxb/IshoPo4MvBvwag+oa+bMimEQI2p3eEZodFAY3TOz2Zw5XTzoULLGx5WIORA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749487621; c=relaxed/simple;
	bh=riopfsP2tsUcGij9LwVrKNXcuUcRrmCkeVW3fe8MvUQ=;
	h=Date:From:To:Subject:Message-ID:Content-Type:MIME-Version; b=CjAQ6cgIZxjukKZn5G1dnE/A81UrzwswCMz312zZZClwft34+bYubWBvJRYrs+foxZJXU5wbELWx92Fr8PAJk/jxYkHdZE+fyEc96IyDKF9907968FsMxO4Qf8CO428yHxd6VyhITNVzT/Ze2p7mCEzyE6ts2P8Kz0wMVW7oC5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=qZ+U6bIR; arc=fail smtp.client-ip=52.103.68.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="qZ+U6bIR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gd8rQAoT9GpcvuKlzvV0VuTbdJVg2Rddx8zCFZCshsVNeZnjcXk+30QX007zrXNpyusah6en6lEjLq7wU4NVqoPIfHri3coi9hZQN1LXnZRY4atZ6+THITOE3vqnVrPvDKkcqy/Kl4JtpOO8vGRfdcEYxTkyNH2bOd7K+xam3OsgzQs7HtQ27vwo2XIQDZu8aC2zS8GHEMmrTYXjtWEmUGkhBs2bsCXCBDqy8/w7sJvNRcsgFK+sabj6H/3Ml2+CePtOExJmN/CF37rUjvReetlKxRjMysXjNJeC+pPfdMPKlpTMAJ8tyx7RsNsXqMak1RBRHsKjM7567FHFYOfJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riopfsP2tsUcGij9LwVrKNXcuUcRrmCkeVW3fe8MvUQ=;
 b=fWh17WNkCvqFEIntTS8cECmt138y+y9uW8C+2MMmMYe15acdMrHDez/SuRzoJ2uR8y+hME+7mqMuu3CDx5POQoqZbCVAl6MLtsxxImfzkIFbTZ7U5lDIj6e+x4zT4m2/8fWChh+slWPBxBqKkFpbYqjHgYNbpoJtu/LDdkACQ3ADMtBcHkauWXW9HgG6t7aJhgikD3GGEn+sezfi87hX2S37L5zcHBdLrGu2/xXzKqR9TDr2VRoAo8CH2OKC+x6KSne2RfnGknLYpLumeYH+YRU0rU7dxGtSsll2ao7AAltWMJo2AsaKq96V0BR78i6KAWakiVQG1l5n9ZGvX1sp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riopfsP2tsUcGij9LwVrKNXcuUcRrmCkeVW3fe8MvUQ=;
 b=qZ+U6bIRuK/j2xMxvqcu2EN0TAZMxse6Zd24ekT0rVZXHxadkvk1bVrqWEiIx1/iU+XJsAPoxpTRCTQCBR3sDCl6QZnVh9UrGT8LyQaUgkLxe6fZb2Wlu7zjSQobHV8MCzuTNZp7w5Vyu1l//PELjKsBLeAtULKDgtavN8/uaW29aAMare4yZLs+Iy8kbY6p2M1x5fyMYxLs6zzwuqwgj4wlBlhfnQNzPlQ8x9hnKiKAujw4YG6jwPlGb0TGvcIWO8ZmrQ6StD5vYWgMBky1HoF4vqvfqkWCmQ6v3myzdaQNs/AWiT6yc2Tkw237eaaFL3b0cBLR9EMjGVNKFoxoww==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PNYPR01MB10789.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:280::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 16:46:56 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 16:46:56 +0000
Date: Mon, 09 Jun 2025 22:16:52 +0530
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org
Subject: =?US-ASCII?Q?Question=3A_is_there_a_possibility_of_g?=
 =?US-ASCII?Q?etting_a_warning_before_a_git_push_-f?=
User-Agent: Thunderbird for Android
Message-ID:
 <PN0PR01MB95880EAA98466C9AB049BA44B86BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BMXP287CA0019.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::31) To PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:10c::9)
X-Microsoft-Original-Message-ID:
 <E1185A9D-3E83-474F-AF03-361F6043004F@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9588:EE_|PNYPR01MB10789:EE_
X-MS-Office365-Filtering-Correlation-Id: 681d4843-0733-48c2-d513-08dda7753e50
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799009|7092599006|461199028|6090799003|15080799009|19110799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDFMSlI3OW9ZU05GSnR5S2oxamZtRTBhcjRQbFNiMDUvTmhVOTVoOUovV0Ux?=
 =?utf-8?B?ZFJOaldsY1NQeGNYNHF2cXFQb2pGazY2WDVSdTB6WUVvbGh1M1d3N2Q3d2xI?=
 =?utf-8?B?Q1dzUDlRWU9KNGJ1WDhGczdueWkzR3R5TW9BdnovaFJoeUlQRVJHU25oOWdJ?=
 =?utf-8?B?VWREL05sNE02aUFFOTArNlFDNjlrcWpJMks3VGhZdGVVZElETXhPQTBVNGcx?=
 =?utf-8?B?L2c5MnJvR2g1YitxWWdTNzFodzRwajEzVTFObVZmNGtVTnd5bGdLVTdweEFl?=
 =?utf-8?B?VWlHOXF6bnFETzhMelZHT1E0azc3eFFTZGRBVGx2cXJaOEtjR1BYdDVzNzVm?=
 =?utf-8?B?RVNrNVBlTGduR290Q3NaaGpiaEtVTmpMc0VHUk1tcnBpYVcxelV6ZUwrVzhY?=
 =?utf-8?B?bS91enB1NUpCc1BHSE55VFNkYmM0aktIT2drMi9FcDBMSUZxMzFjV0FqdXo1?=
 =?utf-8?B?NGVUYURSRkJHSHM2R004WnRVRjY0d3ZJNFJnV253NzRzVCt4ZlhPRW1vdnRy?=
 =?utf-8?B?SUZSZUdVeVhkc09zWHFCTHZBTHRuTWtsY0kvb253MzU4Z0JGOFg3TFpveWxt?=
 =?utf-8?B?U1NJN3ZlOTl0dFVzRGtoTWU0M29kTmZMcWozVFpEQjVNcTU3Q0hnSmUyYllI?=
 =?utf-8?B?ZytNbHF4R2xIbXdsYStIWE1ab2Rkb0I3MThYYzNNU1E0QWNEelpibUo5MkY0?=
 =?utf-8?B?RWVNWC9ZVThjckVZczhKbGYzZDgzSlJwKzJrd1U5bk9GU1FlN3RpYTlMbDYw?=
 =?utf-8?B?SE1RZlpnNHcxdnRwOVF0MzJ6d1BWVFR0Zy8vamFNYXhFaUJJZzNmOHVlWm1S?=
 =?utf-8?B?dWZRWTZrcGJZWUJyZ2JTRE9KVEY5THhWRjZld0wvcXVINzhOdzFLVzRVanBK?=
 =?utf-8?B?WG4yeFNaQ2NFcExFdE1HTkM4U3VnZDN5Z2pNaVE0QVhJYTJyd1F4a1VweUMy?=
 =?utf-8?B?bEV3Tm41eVEzN0p3N0F1NE0yckw1NlVKTUtBOTFFcjFGSWhOa2RPQ1pqdXgw?=
 =?utf-8?B?Rjh3VkYxSTU5Z25kOFc5STJxc0NoSXNmUGxyU05XcGZsc0ROY3ZoazhhSDls?=
 =?utf-8?B?UXlSU0hsK09yb3ZwNWE5U0s5cXFHSlUyeGpBT2JWT0dWbXJFUHhraDI0QjZS?=
 =?utf-8?B?Y2F5Z2hiRlhTV2lpQlhua3RTVTRDcmdmTUtieUYyWWNjVnpib3h2eU5WbnJW?=
 =?utf-8?B?eGlOcjlRZ29weEJyTlBlbEFQNlNIaS9xMUFFVjR6Q0FNQzJGaW84VDdHc0lU?=
 =?utf-8?B?YWVjUytvNmtrZkg3M3FkYWFMNFBoeG5SNHV4dzQ1Rlg2U1U0dWxtVmQ5SmVB?=
 =?utf-8?B?Wm9GbkI2UHJKeUpLNDFZKzc4ZmsyVjhNdmNBWGR4YkN5SkM4cFM2emNCeWp0?=
 =?utf-8?B?NXVIaVZtTEJsV1Z1cmxwN1VSenNoUUVJeUNPa0h2cnBUOGNvR0ZYTVNsVGcw?=
 =?utf-8?B?NnNvMXlYMEpqVTFCT3M3K05keSs5K2dyY2ZvdXJUZCtHanNqVkVlY29qUkZo?=
 =?utf-8?B?RXVoQ29Lem5vSGZOL0FsQ1Nwdkd1ZG1hc29VMFJ4VVdmZFl1cnFTdDMxdFBo?=
 =?utf-8?B?VnJEUT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dytUanc2SnZ6dG40OXlsRWEyUkRkenFGTzdGeWJ5ODFWdzcybitiVVBiblBs?=
 =?utf-8?B?THpyTThBTEpmeUszYlR5OUNvYmwvL2lpOWp2NE5DUGNmWlVoaVBZSjlXTGZw?=
 =?utf-8?B?WWxyU3ordnNPNTRiMUNmWksyYjdtRlkrS1RwRnY0VDJoc0tsdzJPWEswNDlz?=
 =?utf-8?B?TU9kczlHODIxdmVFajJJbkNTWkprUThibExPZkVnRlRNdTdzdWFTSGhIeDZw?=
 =?utf-8?B?emhqYkFVUGhQMS9ybUZsUzZNSS9nRWZVTC9IMjhhcWdOM1BSYnpORGFqUlB4?=
 =?utf-8?B?b1dyQW9IWGN6RkdpQk9QQ1QvMWxkWmRnR0pYWGFsRll6aWxQYVdXcmFKMGFo?=
 =?utf-8?B?SGZBalpaOXhKT2RDMHpKT3ZadDdGSVhwT0NKbmlWbzhBYjY5VTVFQ1ZlOERN?=
 =?utf-8?B?U3duQnFiY3EyT0ZUZG45U2ZqbGk3aU5qUWpVS1VBZHN4UHRrV0dabHI2VVJu?=
 =?utf-8?B?MUpuSXNVSUVaRXp3UEE0bVlUMGdKSDR1Wk1FYU1vVmRCb2xLMUNaM29LZDNS?=
 =?utf-8?B?WldFMlVmMkxMVm5NL0hYbGZ1RWtINGhOUFNJdm5FWjRZL0Zoekp6TmNmZGwy?=
 =?utf-8?B?a0tTREw1MnlqbWdUTWRwc1hOOW5lZnY0MksrS3BoTDArOFAxR00rdWttQ3pT?=
 =?utf-8?B?TGdXWlFlMUhwVmhsci91WEtValFaa0ZqN1JRNndrdTJTYWJPZkJGMXRHVGVS?=
 =?utf-8?B?ZncwRWlrVHBtMnB6Q05ZcFBsSVZ0eG1xZGRYSUViQXRJK1o2QWsxQnA2M3hy?=
 =?utf-8?B?aU00YysrWkJCcSsxZlM4SGdQTDZ4alJQVVl6UDdnUnVXc2cyUU9YaTJzUW1I?=
 =?utf-8?B?bnZWMTdnYVU0R3AvNzl1cHhnWlRHQ3pQS2pDSXAwN1ErQ3ZYZUdwOWljQmpR?=
 =?utf-8?B?NkpuT0pJdnNYUThaZDNKb3VDcis1Q2d3YlZKWG9KVmVDUm9aZkJuaEp3TzY2?=
 =?utf-8?B?Z2U3SXA5UzFiTGFTMmhkWGxISmd6RzhPbm1QSTdRbzRpYVhBeWlYc0FVNjJz?=
 =?utf-8?B?aFkranpZajJ3NW5YMXhqT25wUlBmSDhQZ013RGw1RlYvaEtuRDQ3WnV5VUlP?=
 =?utf-8?B?bWl4dDVaaEVUYlZlY1NUUTJyL3FOeFY5aGFJSCtncHhXUXhjOHlMQkIvR2I5?=
 =?utf-8?B?MXUwU0pvT2lmbTljVms3UTdDTlNaUE52NGZncGVKWGJjWVl6QWVjYlV4SkpU?=
 =?utf-8?B?U3g3cVVHUVc2ejR3bDBzeFp0MDlNN2RLazl1b29IOTRPaGRxT3U3RkMwVEtt?=
 =?utf-8?B?d1owbnBxVDc4OFM1ZlZ3ZHJLQ3NqQy9qNy9IWnI4Sis2OTZBZXE5VThJUFV0?=
 =?utf-8?B?MTZlV0lRanlsSlZGS0t0bWhZQVZnd1Bka1p6NTFGZzZuQUU5L1hoWVZDZjhM?=
 =?utf-8?B?dTdLaUdSa1dZT3dSQ2tJNWgxamtSWkd1TGI4SmRiRGpZd0lERFUyOG1Sdytq?=
 =?utf-8?B?Zzc1NTN0cWpGc3NSUlh0Zmh1STlZbFdHSkZEek95Z2ZOdjJMcVVTWE1DT1Vy?=
 =?utf-8?B?Mk0zWDB6Z0lGTm0wQjhSZS9keXd2c1BOOXprS2FxYW8vRXNFTnJYbTFXZGNp?=
 =?utf-8?B?Mk95eWlkVXZzQ1dCMnBzNkhpRU5abjNzQmRUZVRVdFNZS2xsRDVIMmNMOG5m?=
 =?utf-8?B?akMvNm5oUHJmYWo3L0EzWXhJN2pTU1JwQU1PTnh0YkJvOGt5WCs2M1hWejdC?=
 =?utf-8?B?VDJjUjNQMS8rK1dCSEtGZVdQVW55eHh2S3BQSEZnRVUyNUk5QjJWdWJvVmxE?=
 =?utf-8?Q?GjI/65aF5U3a5E02wDwN1Od5OMlqzIQKO8Pv0u5?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 681d4843-0733-48c2-d513-08dda7753e50
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:46:55.9488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB10789

One thing I sometimes encounter is that I sometimes git push -f and moments=
 later I realise I did it at the wrong time, result being a disaster. I was=
 wondering if a little [y/N] warning could be possible before the risky com=
mand gets executed. I saw the code for push superficially and I don't think=
 it's implemented. I think it would be a nice feature though.
