Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020072.outbound.protection.outlook.com [52.101.69.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A08415445D
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731886797; cv=fail; b=aOJA5+giN6qEqbTvOuvjyP2ZQ+B01XoGpPIMU3i44RG/gjvYkkEOyQRrMxcKHPuxj8tDv7ak8MlkFkyGu/UpJiBsD2Mg2vRD+741oAbrzZbAJZ8KSGiF3RjN1vt0BqFgS2gupobl21at5xN7TKAUCK4C4TZJRlmNDyZdqrSPFfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731886797; c=relaxed/simple;
	bh=qAn1RpDkyoQVbmfdA1zcd89Is/CXjMMmwBVVyfILqN0=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=GdYtDnt6KGwA16Tkqzxku2c+j3jcvxWMwpoIYzLBua5UtR/h5mBsAPB/T00NzbxvB8LJTlgatEeu/1/7A9Zhyi9dXElJM4vbajsRSNsnNvsECD4ShgiYWYoYQ2KObiuYemKzsGSeQO/4YFz1MgLJeggpfKED+sJVZMLTx+N7shk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttk.elte.hu; spf=pass smtp.mailfrom=ttk.elte.hu; dkim=pass (1024-bit key) header.d=ttk.elte.hu header.i=@ttk.elte.hu header.b=Zzdfi30h; arc=fail smtp.client-ip=52.101.69.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttk.elte.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttk.elte.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ttk.elte.hu header.i=@ttk.elte.hu header.b="Zzdfi30h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiT6nIRvC5tBjSiETln+0Mz6ZdpUt7Mw1QWd+Q7erD9RbuqMsBArbzvauMCNca4Ma5zy1L4KvqtfAVvTmgJ1+oYuonARfeOcrMD5DgVpTK0RXmQoBzSWQbLRXUgN5WSNWUdKEW6rEKCymOrOcyGNOtR7SBjKx36cKaWEtYask69fAhHfRfHaB4wTsEkjB0EUYxkZo/cyFKgfQNelm02c4FO8Toq5Pqn3UWnA5PLGZMrmRbPdWGHMgexzjWF7y6Yw+CqfUX5rk8hNbVjkBsZeAIy6rhmNw4hogEYFoRp27xmVJ5EdKGemU6OlxOim3JNKDGs/G/PoFWmlbBQL7OUY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54wb3853B3bRuk1bp6CJZhcyq8DrtYul6jIZSuq5qCI=;
 b=cob+POfBtoHZzVasdCPNUEnQkGNhiyiEEgzFo4cER4+PbQr10XvKc07TI1crOZsWfpH3ba691zcShsCA+wsBS1voURnuW9eF+kpn6sMVIzHJpyYn0E9Kb7KhLcidA/EpIWJNzuD6EPfeN6j4GkISKzGoKoVQGBEG77r4La8qzN3zz12VA0k5YQFUCCLiNvQeH33KiWlpTdzSHSEa9gTLPR7B2IlsmsCsrE3oDdpDpEoBBUCzUI/IczeOpZ471edWINLrTgMGC5Y42zvkUr9g1CoGGvYc4boCxDbSiywDsjLZ7zN0iw+k+Xj/DbU5I823DVo7aWzlCK9CbvxOXN6bfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ttk.elte.hu; dmarc=pass action=none header.from=ttk.elte.hu;
 dkim=pass header.d=ttk.elte.hu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ttk.elte.hu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54wb3853B3bRuk1bp6CJZhcyq8DrtYul6jIZSuq5qCI=;
 b=Zzdfi30h9da+ifwY7bk45mTmBxvm/fe5L8B3xzBCu05b+okHIPRGwwx1pUC4AGRfDDBvd9ZH9ru3/0DRuyCnlBXw3VCck8J1lUcU5qT8OhgevHQ5fd93IMSAln7jWyRxYArXurUWdILwFZmgqby4dhbp0FTefJZECCuNxG65zdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ttk.elte.hu;
Received: from AS8PR09MB6187.eurprd09.prod.outlook.com (2603:10a6:20b:5b7::11)
 by VI1PR09MB4174.eurprd09.prod.outlook.com (2603:10a6:800:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Sun, 17 Nov
 2024 23:39:46 +0000
Received: from AS8PR09MB6187.eurprd09.prod.outlook.com
 ([fe80::2f43:26fd:10b:64f4]) by AS8PR09MB6187.eurprd09.prod.outlook.com
 ([fe80::2f43:26fd:10b:64f4%6]) with mapi id 15.20.8158.021; Sun, 17 Nov 2024
 23:39:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Nov 2024 00:39:43 +0100
Message-Id: <D5OUMKNX6UU5.23Y4V7NHKGUWX@ttk.elte.hu>
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, "Johannes Schindelin"
 <Johannes.Schindelin@gmx.de>, <karthik.188@gmail.com>, "Taylor Blau"
 <me@ttaylorr.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Bence Ferdinandy"
 <bence@ferdinandy.com>
From: "Bence Ferdinandy" <ferdinandy.bence@ttk.elte.hu>
Subject: Re: [PATCH v12 2/8] refs: atomically record overwritten ref in
 update_symref
X-Mailer: aerc 0.18.2-99-g1a3b2b24eb51
References: <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241023153736.257733-1-bence@ferdinandy.com>
 <20241023153736.257733-3-bence@ferdinandy.com> <xmqqr07d11wt.fsf@gitster.g>
In-Reply-To: <xmqqr07d11wt.fsf@gitster.g>
X-ClientProxiedBy: VI1PR0502CA0007.eurprd05.prod.outlook.com
 (2603:10a6:803:1::20) To AS8PR09MB6187.eurprd09.prod.outlook.com
 (2603:10a6:20b:5b7::11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR09MB6187:EE_|VI1PR09MB4174:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce924cc-22d1-49be-e059-08dd07611e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnJlZXlzZGE2M3hEMDYxSDFZa1hwdFFUSzlZN251clQveWRnNHAyWVRtVGhh?=
 =?utf-8?B?ODV1ZHhjT0swTktqY3dGdXUvMG9acDJ4NkIyOTZqb052NmM0WmNkVjFFQmtK?=
 =?utf-8?B?TEFiSkFPZGFIKytjbDdaYm1sWjMxL2NOa2ZXd29YS1Y5d3RxYmc2dDV6UU5x?=
 =?utf-8?B?WTc1Nk9lZC82ZFpOcE9aS2tQSjl4aEJyQWxWMHFDeHJHanlNYnFLa3FBU0Nv?=
 =?utf-8?B?RkJlb1ZpMzhCWFJLbUROdWU1Yy9VQzRCMUxXR2RyM3BXQ20wTjEwK0JCYlk0?=
 =?utf-8?B?KzBYOXVab0daVTBHNDRyZlV5bDhCK0dpdzQvL0Z4aVVhUmV1bXZNcnU5WmdC?=
 =?utf-8?B?bXZvOXBSd0lma0czYjF3UmFHL3RlRTJzVVhOQldzVjNNbE9oNEt2K1FFZTgx?=
 =?utf-8?B?RDhNcWtpcTM2M3BDQjkyVW8veHJ2N2RWam0wSUhBV05LcERDaGFlUHJzZ0F5?=
 =?utf-8?B?Umtkb3pkcndpZGRZT3Z4SURjQ3VzanFyODd4d0Q1TVN4dEdJcjhseFdzQWNY?=
 =?utf-8?B?Wko2QWEwRk5YVXlodWtHeXFIM2dDaTVUN2g5a3c0V0lqYUhtbGI1WEU1eStP?=
 =?utf-8?B?a3ZWVUZpcjVWRVhrYURmMEJ5ZlppREljZ2Y0QWVmRUxqRFZ4OHF0OXE0RlpN?=
 =?utf-8?B?QmNPQ3NzVEJobzBOMXRWYll4SEt5VW1yMHNMTU80T1hhZk5oNE5KOHErdzZZ?=
 =?utf-8?B?SWExemhhVHVSY3ZhdzJpZGxzZ2Y1NzArV1BtWnRWTFBiZTBrRitjZ0tjNUxm?=
 =?utf-8?B?ZUxCalFTSHBMUVh1bzUvVnF2T3NnNGF0R0d3Tm5mZFAxQmhHS0hDY05CS3ls?=
 =?utf-8?B?SExDL2oydE95N0Q5WVd3VEhnRjdhU3dKb3YvOEpMMzBQc1A2M1U0Y2dsMXRZ?=
 =?utf-8?B?N3I2cGRlNjRyYUUvMlZXQi9HZ3dNUEM3V1VjNmRaVGlvdkZmWjF2RTZHd0tk?=
 =?utf-8?B?SW14RElJUzJRa0c3ZnJVU2JXaFBqblRmRUhPNWZrVlMvT2xKUm5YVUsvY1d6?=
 =?utf-8?B?alBPUkpnTGdSM1VkcGdrK0dZdGJobVlXZjliL01pYy8vNkVzTVQ0S3ZDUWRH?=
 =?utf-8?B?UytNb2RhU1JtME9heU9qckx2ZUpYcVI4enJSYUZiLzhPMnlpVitoT0J5MytK?=
 =?utf-8?B?RVBWczZUdXZKejhzZFZNMDYwb08xdlpvQ29EL1JZY3NlbDlkcmxGM05RNkZy?=
 =?utf-8?B?cG5TcWU5elliZEFKOFIrREd1UGpaSlVqREVRL1hCY0pWTnFqdEpwVEw3eDRs?=
 =?utf-8?B?VXZyM2ZFQ1UxMDBFMEkyM1NmQWJLaERYN2RKQmJqbm9GMDAxdWpsZjFQcmdJ?=
 =?utf-8?B?dmpSWmY0ZDRhb2xsZzRVanRkL3NLbDhBNkNqK1llL2p0U3R4WnU4cE5ySmZ5?=
 =?utf-8?B?WXptQm0rSUEvSFhmbUF3QVJDOW5ETkdMRkhpbW56YVAzWnFJVDFqU2FWdHVO?=
 =?utf-8?B?WjE3dUduVWxITjhCZXJ1emtoRlVqWmtkVmlSZk91UXdIWXpHUmFVWlZncjRo?=
 =?utf-8?B?S0NUOXA5N3NSOHZSYUV2dlN2ZUFtQUVDYzJWcERJNFpTRFVrLzhsQk5nam9E?=
 =?utf-8?B?Z2N6TmlEcFRpL1htVGpEV0JIem1hQ001d2hOSDNtWktVdkt1ZHVOZ2pHUDRi?=
 =?utf-8?B?Tko5c1JQWEN0QkVMRWVDcVlYejdMNUdnVnRRSG9VVzhwcWpDbFFXTkFMTEQ1?=
 =?utf-8?B?SVVmZmUwWVVoS2FKN0pLY1VxSytuWHNKTDIwc2NGK0VaL0hNOXZSY0U4Y1d6?=
 =?utf-8?Q?Fiu3m/2rABq25fMICfLh9OF5aKUbCWF2SnVklAy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR09MB6187.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0dnbG1jcmlUUjZtUnZGbXUrZk4wZzJtVExqMm95RzFDRldOVUdLaWYvd0RX?=
 =?utf-8?B?MUZyNWx4b0E5aWZzN1lLM2Z6bWZSWHhCS0tRV0FSdytUSldhR0ZYSE80cDB4?=
 =?utf-8?B?WjFqcCtjQXdwRXRUa21icVlHcFArMklGMlFSMjJhcUxlVUlpeUo3T0NVT1RT?=
 =?utf-8?B?K05OMzVEUjl0Ym8rOFpiWHBMVnV0Qkdwb0lDWmp5Nm1mTHNXcHEyU0tjcks4?=
 =?utf-8?B?ZDVqNXh1WDRBbzg3Tk1BQS83MDZ3WDd2MUNSVVVheDRZb25udk15UUc1TUJh?=
 =?utf-8?B?SmhWc2ZKWGJiRllodW5oZW9BMXBWYVNrU1Y4T0NWRld0Q3ZQRzgzOXdIbjZN?=
 =?utf-8?B?UXVXalRUd21IQTJIR3ZjWmpNVkRoUkhWb3ptTWlSaWpBdlpMWldTQmIxZmhz?=
 =?utf-8?B?enNhN0w4V1dLVlRYK280SkJ6T0RCUUVmZ1Q0dzFkTWdtZ0s5OEF4Zko4U2Vp?=
 =?utf-8?B?WUFiK0RBdlJkYmJtMFZkTU54ZXM2ZWlRdU90ekVGUXNvWEZNaXhnb1FxYXJJ?=
 =?utf-8?B?blNqVzFlVEtZSnhOVGs0SStIWU54UEp5VjJPY3o5OE1TL0dReFB0WU9rcmlG?=
 =?utf-8?B?Kyt2TjlpZUd0UHdORnFna2ZZM0NxU2JUQlBZY2NHQnZUY0c1blc2T3lWYTJK?=
 =?utf-8?B?UlR6RnQ4MXNERHN1YjV4YmRObWNCUFZ0UngzQmVEQnRJYkU5Vm8xb1FCTi9i?=
 =?utf-8?B?UTdkL0RkL2dncjNDM1doZXN1akxQZDM2YUI2T0RrdDNjZnUxVlhoNDRZRDFj?=
 =?utf-8?B?RllYbGh2L2UzTlJMWnU0NUpsNUZCdXZ5QWlrZFdBdlBxRUZBZVpBeDdhVkox?=
 =?utf-8?B?UnJhL1kwajVjM1NUdXE2N2d6RHJwOUtEYjdOemhhRHBjN1ZPNmtLN1c1V2xM?=
 =?utf-8?B?SURacitwMU9CcHl2eWpOaGd0Sm0wQVIraDRTSllwUFVGRUlLLzF1TXFaZ2pM?=
 =?utf-8?B?N2FGMkRuNDRid0g5UjlqbENkMkF2eS8xeWJna1Z3K1pNaWtvYy8vL0U5SGFn?=
 =?utf-8?B?am12SEs1S1FaaTd0ekJZb0J3NkE2a3hISkhSN1hRU1RIbHdaUXcrdTZXZjNo?=
 =?utf-8?B?U3JiTDZvRzNIbUhEY2p1Rm1vNWRzaHZOSzh0ZU5QUk9FZjVOdzhlSy9jSGJt?=
 =?utf-8?B?STAya2hBTnBlUTlPTzVDWEJram13YVB1OWwrSkRZTWtqdHIwM25xbVQ3bFBY?=
 =?utf-8?B?Qk1uK2hycVJYeGlsVStIZitTN2Y0Q09tNGMrVE5XQzduQ0xuRUFDZWNCc0tk?=
 =?utf-8?B?eVJpeVprbERndkczdkVTUEN2YWJ4dmVkWVJpTG9kcFZOR3dUMXlYRlRmZ0VI?=
 =?utf-8?B?djlIcDJyVVhGZm4xWENNblpMTnl3UGh5eG1HY3UrZnFHMWJENFJucXFGbk9K?=
 =?utf-8?B?aFE0VzhnNnQxVHk2RExpekRydUxJN0x4bzlGY20xclhkVUpqUGw1TXdvYWZn?=
 =?utf-8?B?Z2tWaFRnRlpIcjRuVkRvSmJMdkRQQ3ZCbDBrdHhGYTlqY3U4YUswaW9TMnU5?=
 =?utf-8?B?NXFBQytaUjVPZVNhNlA3cElNVG1TWmgvZFJKVmh2VS9MQTZuN3NlUmJoUURB?=
 =?utf-8?B?NEczY3BzWS8xYW1veGxLanNsUVZ6TkF0dTRNRnRVbkJVZUFqWmZOVG1UTktR?=
 =?utf-8?B?UHhnVStweXNBc29VdjQ4bjFVR0RBenVPRXJQNkZ3VUNIYm1LQ2FFWFkzZmZo?=
 =?utf-8?B?YnI4R0ZEcTFnTTJHOGtMNmpOTGMrcDhGUUovT1lOdDB1UWQrc2o1UTNJaVp5?=
 =?utf-8?B?SXh4eENIUjBmTkJCYS9kMlIvRGJ5SWYrb3A5cWdVd0txY1FiYXYwV3FXc3RG?=
 =?utf-8?B?c1BYMURta1pNR3BaSTlUQkJLS3c0bVFDZzgwNEt1SnZrVmVPRDlwNUU2VHdO?=
 =?utf-8?B?Sm15b0F2QUxKbk41c2t0WW5qMnRBTzIzRjJXUzN5WmRaNU1rRm9CMEQrWVhV?=
 =?utf-8?B?WUZtOWtOd3cxNEJWaTVYUmxNci9LbXVpenpiYTlvWWRiajhGRTdKcGcrNmFI?=
 =?utf-8?B?Z1dtZXlHUkwzQkQ2Zlpsc1FHTER3Tnd1UlkzYlVMaDlydzZxWTcvRFllcTRM?=
 =?utf-8?B?UDAvZzZzWndPdTZVQ21pSWJXVldIYVBnTlZkS2t2c205OXU4YmEya0JmKy9V?=
 =?utf-8?B?Z2oyUEVCU2VFTmxsLzREYzZZU3M1SDVDdCtCK2l3eldQVTlHNStxaUxTdW5R?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: ttk.elte.hu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce924cc-22d1-49be-e059-08dd07611e92
X-MS-Exchange-CrossTenant-AuthSource: AS8PR09MB6187.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2024 23:39:46.4267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b366dbcd-4fc3-4451-82d2-e239564302c3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16aDY+lGH/6grQSsTaFiU8qXswYfz/IG/fZntcWURzPMg5YY5be5WMY57511A/N918ZwZOGYiELe+8FLy7wFb7eVxoAggnymKPHC2xymMqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4174

>
>>  	} +	if (referent) +		refs_read_symbolic_ref(refs, ref,
>>  	referent);


So I've been working on detecting a detached remote/HEAD, and it seems that
"refs_read_symbolic_ref" behaves differently for the files and the reftable=
s
backend. These are the exit codes in the various states:


	     reftables files
detached	-1	 1=09
doesn't exist   -1	-1

I would assume this is a bug in reftables? At least the behaviour of files =
is
more useful for this case ...

This now works fine with the files backend:

	if (referent && refs_read_symbolic_ref(refs, ref, referent) =3D=3D 1) {
		struct object_id oid;
		refs_read_ref(refs, ref, &oid);
		strbuf_addstr(referent, oid_to_hex(&oid));
		ret =3D -1;
	}

And 4/8 can now also detect being detached, by checking the return value us=
ing
the test you suggested, but this fails for reftables. Just in case it might=
 be
something about the test not being correct:


test_expect_success 'set-head --auto to update a non symbolic ref' '
	(
		cd test &&
		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
		git update-ref refs/remotes/origin/HEAD HEAD &&
		HEAD=3D$(git log --pretty=3D"%H") &&
		git remote set-head --auto origin >output &&
		echo "${SQ}origin/HEAD${SQ} was detached at ${SQ}${HEAD}${SQ} and now poi=
nts to ${SQ}main${SQ}" >expect &&
		test_cmp expect output
	)
'

Should I fix the reftables problem or should I mark the above test as a kno=
wn
breakage? Can that be done for just reftables somehow? The only problem
reftables suffers this way is to incorrectly report "creation" instead of
correctly saying it was a detached head.


> We could write the whole thing as a single "do these and leave as
> soon as we see any failure" ||-cascade,
>
> 	if (!(transaction =3D ref_store_transaction_begin(refs, &err)) ||
>
> 	    ref_transaction_update(transaction, ref, NULL, NULL,
> 				   target, NULL, REF_NO_DEREF,
> 				   logmsg, &err) ||
>
> 	    ref_transaction_prepare(transaction, &err)) ||
>
> 	    (referent
> 	    ? refs_read_symbolic_ref(refs, ref, referent)
> 	    : 0) ||
>
> 	    ref_transaction_commit(transaction, &err)) {
> 		if (!err.len)
> 			... stuff default error message to err ...;
> 		ret =3D error("%s", err.buf);
> 	}
>
> which may not necessarily easier to follow (and in fact it is rather
> ugly), but at least, the resulting code does not have to special
> case the "optionally peek into the symref" step.

I realised I misread the above snippet the last time I looked at it, but at
a first glance that would make 6/8 painful.

Thanks,
Bence

--=20
bence.ferdinandy.com

