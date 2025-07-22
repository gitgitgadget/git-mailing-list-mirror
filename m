Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011033.outbound.protection.outlook.com [52.103.68.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5FA27EFFA
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205192; cv=fail; b=bkWWQB1i1CTUlWV7OyXb+SRAdjN9wZUD0qTF67MLSz4M/FRGm72hTG20yjrHnY2vLI9ZYsQYEzoA0vkoPp4AuVDwQ7FFFXg6ANgUp7VSk1jAEapzDkkY0ghtQLfTefZtuIupAF7DLQRNN2EqVG7NjXSRX95b5lge+PpwA2AXGIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205192; c=relaxed/simple;
	bh=eFG/Kwx8L+PeLMx/XV6LyQsDq1KhsIxLQkC1AdggoB0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=EU+jSNQVyE3zpEO18QZHK2diaeOf4ndty0ZMREiCHKl5SjeTJErbFTu+cAsam0Ca6uwyW9JCVb5EN2YaLRrNDVIsMcNP5bTq4z3T02jQf3lmU2H/IyFRTku4TCosBNEEWk9S+Rqb4+UrbNaVZw1hVJc82G1OrI/TQg7DCner6jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=O94P9FZW; arc=fail smtp.client-ip=52.103.68.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="O94P9FZW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVLAah248N2hgM+B5OD5Uv5i6TkzitMk3Jhk88JfZA4/5uqaBi/dH+zJ/4VRDgs570WffxOMklABSrvNL59V41EAN5bp2ZaXuykaEczqj01fZMma0d0jZJ7NH1qQl/oWRTgAYE8uZsypv0S50BS6x2rCiv6qATx9tQbrZ4LrZ+NkNzhMFHFuM8TRH4V2SnPLwh5rIcr4pmZhas1CPBY5n2jGwt2i6UjTt8hb5VoMK365w9fz0PgOjHu6jIT1qnOiPTuIUoiWZiCL1qMJ3MEfPwLUCA05/UTmiL/L/AEhMHqU7AmpCHYdwAxieRiKJfqkM390dYiqdmLmwwykF5FXRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qO/w0JzBt6vb12iA5FZcnTZMFpcoEwO3rV9aoKxx9Y=;
 b=YaANEne86N7DmyU9ItATKQrLYAUd38oaEVWgSxDhqToi3gViSxbXJ/P4/wPhVn1Xdr3jA+T+Q220Qz6D/J2+riVepoaTbEiErnvUKlGlb4DeKSZFhb+7aqYC2a+25uBah542SpUaIaQg7cKdV69Acajt7zlmeoJUQ/9rFXdC6mn/5SuTxeDMDQ21bmDl5IYHckafED+rUWosXe4qvY89S/6i7X9mvmL1eQj94LykrlS3u4nL2LuZiZtB2XpiqJB9ExyX3jKQnyqidd+3yPkpxAIuTpkpC3sHINr70G2CGMTMSUame+g0PpUdcZbnTg33F/DQN5bZsZAfqiKS0TIvVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qO/w0JzBt6vb12iA5FZcnTZMFpcoEwO3rV9aoKxx9Y=;
 b=O94P9FZW0wl3wsiBx0/FdTjCJtkO9bHxnFAvI/tsT4H8pWQx3Q6XRm6jqX9bFisxHNv3iwiOLTQ6oizMmHq38r3FecIYioS7Mw2b7ElLNaUK2cNV2YSQg52GMGtCnVOz24InFQt4ecLnVlOONLFA44ZtH73a98/A/na/Y4VWrVbuxBoZ1LjjuYX2Nu6BPnCzdaUS9lz/2xxWT9jllG9vHla3Gt2RGeZrXF2fv8CXpMOo4Mm8BFf0p8Jn6N+HPX/xCZTxslCZ+nIZpp6ZuoFAH2EprwS8qilqCrmljQooEzfwJH5r9AWuHjjh5gWWelusy/7eob2bNujFm2j/iFB2/Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA1PR01MB4226.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 17:26:25 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:26:24 +0000
Date: Tue, 22 Jul 2025 22:56:21 +0530
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Ben Knoble <ben.knoble@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_send-email=3A_add_ability_to_s?=
 =?US-ASCII?Q?end_a_copy_of_sent_emails_to_an_IMAP_folder?=
User-Agent: Thunderbird for Android
In-Reply-To: <xmqqqzy8rvgn.fsf@gitster.g>
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com> <87a890182591c9c21061e85834fc99a766252611.1753092192.git.gargaditya08@live.com> <xmqqpldtxsp7.fsf@gitster.g> <PN3PR01MB95976A7BE0F9A54E836FA2F5B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <xmqq4iv4x15e.fsf@gitster.g> <PN3PR01MB9597B8D3D84D9F7660F15E94B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <PN3PR01MB95973B291F0A52A19DA8BD49B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <xmqqo6tctez2.fsf@gitster.g> <8596251B-7A3F-4220-8759-B75FF63964C0@live.com> <xmqqqzy8rvgn.fsf@gitster.g>
Message-ID:
 <PN3PR01MB9597B5A115C48F6E1BD44026B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BM1P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::23) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <A03AE53D-86F0-49D6-AF85-90E1DCEADBFD@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA1PR01MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 49bde28b-3060-48c8-23fd-08ddc944e22b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799012|6090799003|5072599009|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RW9IeVpybTdJK0FtbWc3bmJNdHVIekNPZG05ZGRqdzZMTm5UQjlSLy9Jdk41?=
 =?utf-8?B?VEtHSGVaeDR4VlREUzVJam11UkpZWDA2cHRoV2pIQnFMV0U0b2tVS2RDQWpy?=
 =?utf-8?B?aFN3NTJ5d29FSTBWQXBBMUc4YUpiQXBpNFg4dzVmeG1aZTV1VmZFUDBGNkFk?=
 =?utf-8?B?ditKUXk0T0lzWmIwdGxHV2NpMVhYY00vOHMrT0JTUWFYSmFFTis0RS95blkz?=
 =?utf-8?B?cmgyaTNVZ3dRcXZBWW5LUVd2Z01XbzlKczRVR3RzdlVqT05lUXN1M0JuaklS?=
 =?utf-8?B?WUtBZTA5Z0VXS3BBbEo5eFRvREJOQ2pGZEpZaXRMeTlKU2RqRitKRzZ6K2sy?=
 =?utf-8?B?QWZSZWpJcXBMREVYT0JJdlVacG1nWG1yTURpZzhQUWtUR3MzY0E5a2lDSSsy?=
 =?utf-8?B?dzJYbWVsRGNKV2xrd1cwOWxKNGRXRHEzVjBDZUlnV21iQmFYT2c1SGRvQzVr?=
 =?utf-8?B?bUlYTHZOcElCc2MrVHR6aFRSYmsyTnRBY0QxWHRFUk52dCtGV3U2ODBCOExj?=
 =?utf-8?B?djU2M3NoVGtmVGVFYWZIVWdidDRYQ2NRRytGQWpzTVliakdTR01iYjI3dlJ4?=
 =?utf-8?B?d2ZUd3BSVlM5SUgrREU5ZG9XMnZXTVp2Q1dOZThmcThlZzlISnk2V1d1dHJ2?=
 =?utf-8?B?ZHd1UmVLQ2FHU2NhYTlXeDNQNzlsY3l5ZnlHdnEzL0FPanJTOUduYTA2ODdh?=
 =?utf-8?B?TjVzcS95enZ2OFlzbk1uVE5IVm5yOVRGZ2ZEU0s3Q1QwZi84RW42Y2k1NnBm?=
 =?utf-8?B?ZWhlMy9wVGtaVkF0REt4bEVzekxSYTJOSGRrM05MK1g5YjhHZjMzM3VXQ0xD?=
 =?utf-8?B?UDBwV1pwUzR1Z1JCSVV2ZTNSV0dyVUxxZEYzbGtQZzRoVDlMckNTQ2JzMnll?=
 =?utf-8?B?TFhKUG5QZEFpTGxQRjZ3U2FQN2lUT01DY2ltNXEvVG43QWxkNHExVFJjWDhw?=
 =?utf-8?B?aHk0amJlWWJ1VUlrVUcwS1BaL2dYUkhTQXc2MC85TmE1Y3VPMlhka0VEdHQ2?=
 =?utf-8?B?RUYyd0E4WTBGZWVjRXVpdEMvQVphSzRrUnhkdHV5UXdlb0ZtSjdNUThxdjhq?=
 =?utf-8?B?ZWtFTDF5Qm5vM2NCaVNtNXRCaXRPbDhUNmJPU2JVSnhXTjRqL0t2dVQ5alhh?=
 =?utf-8?B?SDBJM2RZR0IrcU1POXJpZnpZb1IvTVljMHlsc3J0MUpub3d5eEREUm9KdWk0?=
 =?utf-8?B?TVhacmR1cWQraUkxMXhTN2N0cExIcEo4dG9uQ2NvNENCR21yRXZFWkdJRWxx?=
 =?utf-8?B?YUdlMjA0UkM5TGo0QTRpVGt0SXJ4dHBodXVQRmo4bDhYRi9INDZxUXpqb3lO?=
 =?utf-8?B?Wk94VUkwQVh6Wnh6VlNScEhTLzZ1cWVZYlN3MTIvYytoZEhUSk1uWU1HeEhQ?=
 =?utf-8?B?bXZFQmN5aS9mRzRtd2E3ZGNqbE1QMlJka0tVVWdLZDhWaUYwdG54YnFNRWgy?=
 =?utf-8?B?YmtxOFBNSm9VelM1c2RkY3hqOWxhbm1VdlBhd3ZBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXFEOXBMcHBkajNOVUNRRXVKMXZTZmlmeHdlbEN2ZGhHSjV6MG1PV3RNa09o?=
 =?utf-8?B?bGtOT0lsOXBYVmZubHBtOGJkTkN3YWt3Vlc1Zmx5RXNNcFFBUVJqM3FNOVZo?=
 =?utf-8?B?N1VjQjBTekswTGlZV1FFOVRSaGlZYmp4a3NpNjJlQWljU3o1Rm9QSGg3NnJP?=
 =?utf-8?B?bytReERqTGJGUERCMXFuSHpkdWVIc2F5YTJ5ZjV4NlNIcUFmUVVMbXhabElk?=
 =?utf-8?B?aVdzR3MyOFFmVTBHLzQyMWc1ZGwybVlNMHJTdkw5ZWNZTEZNL0RtU1lDUnBF?=
 =?utf-8?B?SWs5Q2lTaTVrVXRRUjZwZVViMWFYLzVYNUVPaVN4TFg2UVh2SVpXazU1NnM0?=
 =?utf-8?B?bjhJVExENzZiaFIyZVFackQ2eHZqK0dQY2FpYmhQOU9MblczRjg0V2l1cVVq?=
 =?utf-8?B?ZUQ4ZXM0VGo3U0lhYVV6TVZRT0hhcE5qdjRjNS9Wb0RWNUhrdGdYZWM1dmFB?=
 =?utf-8?B?azZQRzRlbjdoRFM1d2l1ZmQvYi94aWt5NkVPZjV0cDZ0Q040SlJXc1FjMnlm?=
 =?utf-8?B?SkFFVFltdzJiQ3ZNUXRSbG5QL3hZRDBmbnUrc0lWcEFmNWFKUlBGMjNVZWpE?=
 =?utf-8?B?Sm1FeVVNNFV0RVRWTFRWa1pUMXQreWZDWmVjbDJQSWpWUzNCMXlkTkJ2WDU1?=
 =?utf-8?B?aGI1cFJadVA3bTgwNERITHlmZDI5TzkxQ09DTGZyQlUyOVZMMVI5RGdyY0lk?=
 =?utf-8?B?QXp1enRTSEFVcUdmTzdEbU1VcHl6OUp4cm1sNHYwTm9DNSsvbFNJMSsxMEcz?=
 =?utf-8?B?TytpSEtwNnY4SFdvN2RpVGE5N2JZYTBCT1Z3QmNrRitiWm02Z3cwdkZoSGZZ?=
 =?utf-8?B?Z1kydUVkelYvaG45NDFYRkFpMlhzMzI5enVtYWhYTHVMK0M1SysrUUUrSlhr?=
 =?utf-8?B?dEFIRUUxc3hzY0M3TW5QanFFTCtGY2R4NEFuUXJNNitGZmVybGhOLzVKNjM0?=
 =?utf-8?B?dmNqS3dZVVZINnRSRlNSVTdSU01EdHFzdzhaTWV3UnBuR3hkZlVYZnJuWkJk?=
 =?utf-8?B?elgwbk5UcHBhNkhaUjRrZnlwWTNiRjNqUlpWSEtVYk1xQ3hxblpDdmJ5TTda?=
 =?utf-8?B?Q1NyRmZrbTVTemhQcGxvY3B3L2puZmxPTVdPRlFBa01ZejIrUEMvU2NJd2Nx?=
 =?utf-8?B?MGpjQzZNc0lnK2RTWkUrS0k2Um40NmNhMlY2TUlDM2Vrejl1VUZ2bS9wMVJJ?=
 =?utf-8?B?R2hrbE5uS29VTXduRlJ3N2hKbXNyclBQZ2pEakNjaHY4YkdCbThSNWE1NVM1?=
 =?utf-8?B?bnljZVJOek40NUpKNS9tTjh2QW5oMENVVi9BdE1CdVdaaER0Yk03RlRvMDJE?=
 =?utf-8?B?bjFzVnc0V1NmazMxWjBTSm5FOGV5NWtVbHpKZUxkSW5lWVNISU53V0dpMjk3?=
 =?utf-8?B?bjZMMzNDeFRrV0NtblFpLy9hbTBKYWhVZ0JXUXlLRXJLelJsU0dKVUdLdm41?=
 =?utf-8?B?WUVTOTRBSUJSbE1Fb0l0TjNYRVh1dDZhUWNleVpZQ1NQYjJwWS9OYjNydXVV?=
 =?utf-8?B?TVBNeVlqR1R1SkNPeFNwUW5zUlVXVWRRdXJBMUpLTkVDN0JXaUZCeDFaeFdG?=
 =?utf-8?B?ZzBMbVpyMHlnR1BXclllbm1JeUJYWVJCdkw5SWl4ak8zemdpeXF1RTZWZkVk?=
 =?utf-8?B?L3ZMVzJQV3VGd1J2dFQwbVg3eDRoQUI1QVJnRzl0dktNcGRpanRlYjZOS05y?=
 =?utf-8?B?b1BCbXk2TTh4WGdKR0lKVkI1MS90S29UMGllQlZZcTFWU0t6UjFoYVl1MXBP?=
 =?utf-8?Q?ZxJa0bjC0aqHZMOUnmzTBfz/UFJuBMY7INNUXTG?=
X-OriginatorOrg: sct-15-20-8769-5-msonline-outlook-acae4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bde28b-3060-48c8-23fd-08ddc944e22b
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 17:26:24.8265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR01MB4226



On 22 July 2025 10:53:04=E2=80=AFpm IST, Junio C Hamano <gitster@pobox.com>=
 wrote:
>Aditya Garg <gargaditya08@live.com> writes:
>
>> Hmm, yes it does, but is this functionality in the scope of this patch?
>
>No, it is not.
>
>But it is your responsibility to make sure that you leave the door
>open for somebody who will want to do so later.  And you do so by
>not squatting on a way more generic option and configuration
>variable name than what the feature you are adding, which is more
>specific than its name.

I got that. I was not against renaming, I was just hoping for a better name=
. Anyways, I hope v3 sent already has addressed this concern.
