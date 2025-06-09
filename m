Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011033.outbound.protection.outlook.com [52.103.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954FE192B75
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 04:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749443609; cv=fail; b=WpcFEjzf582E+TL+ppx8gsFAZa5OQGWcNaTtrJuxzBaPA2qcbc1JHFzjgmJKS1/xKwY4rEt+JrKpsNuX3cwUGuwaS9C3mvwMag4qM755wNlwdTzNec2WpNvnqX1J47a/Y0xKZbvZ89i7sAoFQ1kaPRtyEfsncQLtubCpf9hIhOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749443609; c=relaxed/simple;
	bh=9jHcmHh98AcE7x8W3jTwKfvmowKFbZp1W42SPFrX0Tw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=EWn+TDyzAKFLUnVnghSMHLcMWMFLxZ3M+JfgwToCmPyDd0fI4NGKrY4y83my9Nh1Ds1Rr3f0StuCEhXAZlB0I1lJa9wMVK6YRx4zXPNB/1LzBcVad273lgbJHnvg7x2fQkL8tZBZUwwm98vNa2F42hvXs2DylzV6wXOknBhVIgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=vGKz2jSR; arc=fail smtp.client-ip=52.103.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="vGKz2jSR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k76zzmGEepq4kwkT9rE+Tb3uA20+4EB501SPgSERYYGARX75UkreCN7JykPHGWhWnPC2aoQEyu0K7xDoiukzGh8F+BB9KKG5F1sG2PQSHLRdY7mFSuJPztV8fYt7oqv/NxMZzSxhJohl0GKbQuIo36qquz/hUooXoeZfP97LCdKhlPhojZxhIxD+aA22++vWVm0RGq347rHWUrFVfYrEgvv6rPiaBD4xJozd/HihpxLaDQ95ggGTVgbMMCr9ZdoyyxHOAi1SCCEOX74IH4JwLA8uzchuAV7UvPStoaHAE2dBIFp9VbslUcO0bxWqX2xh5SOSvJKgRxI2NQGkf1icnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2aBiejdVRdYJ5VGi0+AsBIL/IRBtXTK2G4cuVO1hQk=;
 b=OfLmS4qu/ukfdF8CErapjsYgLDt6zdLD33vtDYnWZvbP0Rg6TTLMmdY6RudHCIzihuEPcLmuk9SafvK/Qjuz3n4CGccwKTHOWDsryOr7dMnZ0abuhLz332YsuvI5QLCAWBkuhhHrHC/VZXkpGpulw86sZ/qJKtXDuE0je/eGui8lhHfdJvGZbaOqii+MVhklseTh/OkutU9bZJ3jRR7uu3JpJGiLESfUK2hMhnPlagzHJuqg1k5muIqsucFnaYt/sj+K0b6BhtSJwB3rcPjI6Z2tuZg273swHtE/BEQiHNZzKTnRHWOgImf9oORBTS6G/IuGaCwh8jc810AGPwvkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2aBiejdVRdYJ5VGi0+AsBIL/IRBtXTK2G4cuVO1hQk=;
 b=vGKz2jSRxnD8q3hBMScXOg76N5kb7Z4jNSbORrEkW44VYaCCnDQk4rrBZnzEf2T2uOvhPnDHGhDaWVTlBdMLVYJuphsSHi+8yqMzZfBEx+AjOU/Ol2WMIPo6zGfvojEOsYRcfgpRyMugAFFaYCPaB/L3L+00C0a7CYBhf4gm1o9Q6ob6IS3MfnmcKSKXU9jteaCkCpmjOiBc3+WFr42dlG+4v997WB4FChm/Ro194V94FaoVuc/UJHrXH9tegjwIYaNdL4c9YQdkygJbC2m23gEmE7itT9HD4h0Rf5p4/UFXvM8Vakztu/755VcCYLjMVsOPq3ICZY0cCoLMXg4QMQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB7564.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 04:33:21 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 04:33:21 +0000
Date: Mon, 09 Jun 2025 10:01:18 +0530
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 Zi Yao <ziyao@disroot.org>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Jeff King <peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v15_00/10=5D_imap-send=3A_make_i?=
 =?US-ASCII?Q?t_usable_again_and_add_OAuth2=2E0_support?=
User-Agent: Thunderbird for Android
In-Reply-To: <xmqqcybevtxw.fsf@gitster.g>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <PN3PR01MB95975598E2CF61CA5DE050BAB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <xmqqcybevtxw.fsf@gitster.g>
Message-ID:
 <PN3PR01MB9597BEDC25A1A5C2C37CC9F1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PN4P287CA0027.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::16) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <7AE46166-7F89-4B6A-A58A-2B221453440D@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 467dc82c-e94b-46d8-ed96-08dda70ec3cd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|461199028|6090799003|5072599009|19110799006|15080799009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEI3S2VoYXlYcXAvNSt1M0VFbndjZXlvNlRlN1N6TXhOT3NXeTRDYW5kNUJq?=
 =?utf-8?B?QS8vUElKWmFuQ0prZU9kekdvUDd2NC9QVnlnUjZpREJ1OXViM3RIeXBIVW9q?=
 =?utf-8?B?QXl5R1EwUVRZTWVMdEQwRE5LbjB4ZCtMRzlITDJMY2JsaXYrNyt2cUJ5M1V1?=
 =?utf-8?B?TXQ2cDFCVllzeXNZUUh3ejNnM2FxNHlWejR4SGRzZi8xN3ZadkovbUJqTnpW?=
 =?utf-8?B?TkVLYjVFZnB2QmZJcHFQSWJ5dThlcEloTEFCR25FeFhYOFhEdStadWlSSHFm?=
 =?utf-8?B?L095aXlXSmVwZ0dGcG1ob2doekFwN214U09aaWV3RytWRGtFNjFMcStyUUp1?=
 =?utf-8?B?UnQrQi9DQW9WcGRUMkNkbFZmdHJQVFBkeS9RRUNPN3ZDc3Njc3g5ZlVrSzRs?=
 =?utf-8?B?Wmhua1ZPUWs5NzFPSWVqeHFDeU5oaDRjM3l3UGZRUElWYWl4QzZvSVdxQ2RN?=
 =?utf-8?B?WFN0Vjk2eTQ3WlJzUUJ6SnM5d21pUVowTTRjSlYwak9HVUtobFJwVGhiK0kr?=
 =?utf-8?B?Sm1xZ3o2WUFveGFwUUcxTU9CdzNXMC9qc0dDL2pFSGJ0NGxKZE5odnk1bUZp?=
 =?utf-8?B?Y3I4NGp3aEhtK0RkcXo3VlBkcUd1MFFaaVVqT3pSUDJLRzhOVDFxRVpPYXB1?=
 =?utf-8?B?Wjh2OG0rR3dYYmluaEd4eG91dlI3Mm5RNGFCNnMzdkN5OHNJSDZpT3hHVlJh?=
 =?utf-8?B?Qk05Sng4SWI5TWZMUFo2SnU1Zk1sVm10eThXdXhDeGlzTFBlLzE2cDk5aWwx?=
 =?utf-8?B?YkNZeG5rT0N6ajZDNUNPeXRHQ29HZ3RiMEIxMmdnOVJRb2ovelRpVU5kdzJE?=
 =?utf-8?B?ZUlMMC9HWHN3NWxxdDlqeFhVQ3Bhbm51QnJwcCtRRW5IZ0kzeVhBNDFvTkMw?=
 =?utf-8?B?MlhJcEg4WkVpYXVWR3h6S3lkcTA3VEdjVElzbmI3aXdiTHRHVG1Uay9SVzcv?=
 =?utf-8?B?YXJOa2l4YXRLZUZnbk9mVXozQkNkMkM3c2tRaTdjMnF0c3JoR3RUSGIxei83?=
 =?utf-8?B?cUZXMkN6UHZOQ2pULzhQK0JnMnhVcUFLN1M5NEdhVlRnNnNZKzVXUmJYemNX?=
 =?utf-8?B?VE9MRWVGOVFmemZNczFFWE9WZEpESVNyb05VOW9CNGQxeDBrL0Z3bHZvN3hV?=
 =?utf-8?B?SmF6UDZOd21yU2FTKzZWazBkNWVIZ201TjMxM0QwTllDaFc1czIrTTNIREtC?=
 =?utf-8?B?Mm5zQVJSRW9mK2Yrc2FlS1VvVlhFb1dpcngwZXRaeUxuczVSb3BBY1dOdWJM?=
 =?utf-8?B?Tkk3VjY4aXJHSGZyUjR3R2p5d0JBL3dPbVVWYUhYMC9oaEZkZVExdFN6ZlZE?=
 =?utf-8?B?UldnSnZ1MXdnQTE1VVgvendKYmtTUXBYZWJwc2c2Y0R3a0kzK2xraWdlbHI2?=
 =?utf-8?B?QTdjODBYVFBCOFlsSGlzVERKa1dRQWc5QkpWMEc4bTEzd1R6dmxnWXhWbzhH?=
 =?utf-8?B?dnNzUjZnU3VwRHRuYyttMUJydlBEbVpncGYyU1RoSnR4UndtNWU5SW9JTVZG?=
 =?utf-8?B?dWcxK1RBYXB6YUJMMGFFaFZqSWdla0hiaG9xdVRoUXFjTUE2TjBOOGN6Yis0?=
 =?utf-8?B?SHFCdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3Y1VHd2UmlwOWI3R2JWQmVCOG90TDR1aVpTWXAvZDl2aHdVbUYrcnFPSU1J?=
 =?utf-8?B?SXNLZG1qR3QrOWZRcWthY1ZOUlh5L2V5eXZuRmpUVmRzZFA5YUZQNjZXNGtM?=
 =?utf-8?B?T3Vycm9WL2JLeVJXZzlxN241MHJvVTZ3cEFHSlBWRTQ3VEZTc2Z1Y0lkdXpC?=
 =?utf-8?B?bDNuc3JUY0hPbUNkZUg4cmUwUDZpSjdjQnE1bktsTzRmSDVaZit2OFdxOTJ4?=
 =?utf-8?B?MGc4RWlMelFRbGVBVzgyZlFWbEM2eFEwVGI0elRzbzIxbDRPYjZ4dlFtTUxt?=
 =?utf-8?B?MEVoR3E5cGoyNDBqbkp3ZzBkSWRNYVRUSU5QVTBRdXNDbnpCQ1ozbzhNcW9K?=
 =?utf-8?B?MmNHMnNlR2h4UlVheWZHcXBhWTRML1dXNERQUzZBWTBna0EzMzlyWjgvYzVM?=
 =?utf-8?B?ZC8zMUpZUjByc2JlejN6STZaS2x1Vzg0WFoxUnF0OW4zV3VHeDIzemNDVTdk?=
 =?utf-8?B?Y0VkV2JKZGJKQWxrcUhndkIrUnFNcEFJemVybFRsTGJaNCs0dE5ib3l3SUIz?=
 =?utf-8?B?VjZlSWFOemtUTEFjY1VvenlqQmNZTFozM3JtbEIzczlrSHZQWTVYL25QZDlQ?=
 =?utf-8?B?U3FySXBUSWxma2Z2SnZna3JiNlpiQ25BQ0h0UUQ2VDczZTR1amQ3SUdkRmhy?=
 =?utf-8?B?cVd0RS9kQkswalE5NHNJWUtWZlVOQlA4TWs1amF1dE95Y0ZJcktaa0Q3VnJX?=
 =?utf-8?B?WDB5eXRtQmxmbm01bitYUGUyTk9MelNJNThoRXA3MXRGa1dVTnl2TjhvTG5h?=
 =?utf-8?B?Y2hMM255MTgvMEFUZGxYbXdPbzJFZ1FYWmtPUUM4Uys5VmZFd3E2RlZ0cDFG?=
 =?utf-8?B?K3Yzck1DYWsxMXpRNXU5RXdRcDltUWlqVzNVWHZsYmp5RitHaWo2cFRPQTdk?=
 =?utf-8?B?Ly8vS1VYamdQWjlvVnRMNEdVR0c5bzZGWjZsY1BHYU1BdFpTQXhkOHNkalZN?=
 =?utf-8?B?V1greUpjblhPZExmT0ZsdHp3eHVZZFRmYXF5UEE3OTVFQmZSMFo1NDVXNk52?=
 =?utf-8?B?ayswY25CZ3pEWXJpYkovdGYzTEowaHpZaUJEci81dm90enJTK2tLNzhmK3pO?=
 =?utf-8?B?akRDU0NXMmN4WGkyeWxJbWJ6ZjFJQVFGdHVCcmMzZlRQNW9sSnhlRk4zelV0?=
 =?utf-8?B?QTNqTlhoODVpZzN0cUpDWm5TS3o0VUFvNTltREpuaFJSTzYzSEVLTE0xYkhH?=
 =?utf-8?B?OWQxeE8zM0JxWTRSaUtxSUxrc1ZSUDBHcERKMTdDZjZFaEszc3hiVWpNaWdU?=
 =?utf-8?B?SWdrMzRaeWdWdFFPMWZmc29kQ3pqN0poUTUwWkoxd1NDbEV6NlVNekd0UUNF?=
 =?utf-8?B?YjRzVC9jZlFPcWs0ZUVWVVJsRFN5SStnRmVOeVNyd1ZNWDhmYWttYUU0em9Q?=
 =?utf-8?B?UkFiN0JzN2p2eWJZYkRBeVFqdGhINkFKNW5qYlBWTnhMakF5N1Bjb0tmWmd3?=
 =?utf-8?B?Q01JZ1J0QzU1VGZsbUNxbXg5SWxaMkswQUZHOG9oT1FqV3o2aG1KazBYaDBW?=
 =?utf-8?B?cDlLZEhlUFhmanJQbFE2UjdtRXlaWXg5Umd1MTNsL21uOEVpTWRsZjRmRG1J?=
 =?utf-8?B?MS9xaE03OVBXSW5STUJWYUFWSmhaaG9lR2dySW9rb1UvNkZ3ZVdLK1BwTlB6?=
 =?utf-8?Q?5b6b1kSTdW41/5FyuACqlB4enK+tZdLNKzDzprNDQE8M=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 467dc82c-e94b-46d8-ed96-08dda70ec3cd
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 04:33:21.5475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7564



On 9 June 2025 2:20:51=E2=80=AFam IST, Junio C Hamano <gitster@pobox.com> w=
rote:
>Aditya Garg <gargaditya08@live.com> writes:
>
>> Aditya Garg (10):
>>   imap-send: fix bug causing cfg->folder being set to NULL
>>   imap-send: fix memory leak in case auth_cram_md5 fails
>>   imap-send: gracefully fail if CRAM-MD5 authentication is requested
>>     without OpenSSL
>>   imap-send: add support for OAuth2.0 authentication
>>   imap-send: add PLAIN authentication method to OpenSSL
>>   imap-send: enable specifying the folder using the command line
>>   imap-send: fix minor mistakes in the logs
>>   imap-send: display port alongwith host when git credential is invoked
>>   imap-send: display the destination mailbox when sending a message
>>   imap-send: add ability to list the available folders
>
>Very nicely organized, starting from obvious fixes and usability
>polishing at the beginning of the series, followed by feature
>enhancements to add new variants to the existing framework, followed
>by three new features.  The "ok"->"OK" change seems somewhat out of
>place (I would have done it early if the changes are not controversial,
>or very late after the series if the changes looked merely subjective,
>and not in the middle either case), but other than that the series is
>now organized perfectly.

Let's shift it at the last then.

>
>I think the "fixes" and "auth method enhancements" in the earlier
>part are the same as before and I was happy with the resulting code.
>
>I didn't seriously read the last three or four patches during the
>previous round, so I would say they still need reviews, but the
>early part of the series now looks very well.
>
>Thanks.
>
