Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010013.outbound.protection.outlook.com [52.103.68.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337032DAFDB
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183501; cv=fail; b=ezNbqdyIlBa8pKSUZmUM/WL/pgCaqcosEObDJ/N2pSGebcMHNZBrxcLqEEHn5PasI4+tGckyD0lMEbrjN+5kWD7KwXd+3MeEYa2MGYB5vRy1Wm778ebAcUVsmgusedYZLnhQ0O6o+xiFxC43JXIQq10MnCil0dFk67JsXvwLEVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183501; c=relaxed/simple;
	bh=aSNBJg40MWcMUFrJ504W33OIaqZL32oo/QPo/CKFT5E=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pb/sKvDlRmzkQUWsUdxQWmJXbC4El7eKEPWxIYgfuDef46Bd5Y1en16mH/4irmkZ0pGFNH93ooLRMxwGLOdHq3XKVmBqK8MsQ+dpZZdDPXxMe3sTElD+5GCY4xJsXPt6TnaC9EXkaHuaVQ+ununzvkKJDcyaMY1eC+VqwNzRokU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=pezIsZeg; arc=fail smtp.client-ip=52.103.68.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="pezIsZeg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cv4XCt+Osvw0BlZI+238KQjEySb69F6CCgetsLpxAFGIX9XWdnnZBBaw9pwXT+nscafHq56bfW4IWAK2zrViy78yRXpujtVUpdzzdz8IBdh01aB9Btfk3UAH/wlpzpDxtp0V77Z4g3WCI5w69EVNPYgBuV6EweN2PsklqxsvwB875s4BcypWHxoqk+FJVwf5ZS+sG1xNniwJDD2qhpcdqFpcA/JnmbXQpDfDH7UqHtsjFIsaES8swW513I0taJSB4JurDJjb4TSHJLFoGg1OpgMH5oJMowEezpiFfOaq5In4nPgdrfv1pI8c+eldDcYoYfF4jgWhaq+bb4ExBadW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olsu+719CJwSgKOPEGSSHDY/FEyFRGZuygVNwzj0wkg=;
 b=cReQ7KKDM8XhZE1VlGXCab03r+v/zgbzpQ/EWI0vfOr/RqQ6iYX+WUp1HqlMRSpojQ87tyUdxtEm6IMaIEYoEVeRiJ4hFrb4iwYOahv2NFkB7naiILeMNWzWAGIkb4GiXQSsYccC/BSlGatifzrnEeaiIzpST6wgqJ6R48hHXqTeAOPHp0lzSkSx5DAbZ5+Uo17HIKG/eFTuvHwfOL8cqTvG1fM9h36o8lZhNDZijei938IgaAC/++z1eCbBcUoOOiUqRy1/1ojn+L/K/ObPNAExSLDriOle1q7eYDAAfiAW6/rOCOBxdklb3/YW7eS7NQQB7J6JCIzClMYIGFQQvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olsu+719CJwSgKOPEGSSHDY/FEyFRGZuygVNwzj0wkg=;
 b=pezIsZegWi9IwVpsVt9ZSS7t3aahOnAFF3Vq0eD3PQ6c8Q/3zx6K3bK5rfNV0VDeWowKwgdb0i6v9xwjR/3IdR4iw4u24IKXTJuPGSM8nCgyQXsOG3drzC97blqobAVMuqG78iy2Udv7FTZRXCrlwZaFm27mbRAfsT9lKvTq9Y+DtQIGHjAFzMuyq0eP6O08kp/BqUz5k2V6wIla63jHRHGUSs+Bug8ZzJcfYXGhJpdm+5qFiZF+TqvLvVZIdzPyj/63tlEIwiEkBu4sH0iLMm4q2oXMlDwVDrdg0vRseji4b8q7Ay59f+BDOFtvhRGRs+0RJQr0dXZZ+pJUv99ouQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7016.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 11:24:54 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:24:54 +0000
Message-ID:
 <PN3PR01MB95973B291F0A52A19DA8BD49B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 22 Jul 2025 16:54:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] send-email: add ability to send a copy of sent emails
 to an IMAP folder
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Ben Knoble <ben.knoble@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
 <87a890182591c9c21061e85834fc99a766252611.1753092192.git.gargaditya08@live.com>
 <xmqqpldtxsp7.fsf@gitster.g>
 <PN3PR01MB95976A7BE0F9A54E836FA2F5B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqq4iv4x15e.fsf@gitster.g>
 <PN3PR01MB9597B8D3D84D9F7660F15E94B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <PN3PR01MB9597B8D3D84D9F7660F15E94B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <947de1ba-061c-44f1-9b26-66ebb0cc13ef@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 173ba8b6-33d0-4a44-5efe-08ddc912618d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|6090799003|461199028|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUtSV0VMeU5PVlBPK2FkZHhrTmtSL3RLMFJ2V3ppZ2J2bzcyT0ZqMHVwSUdJ?=
 =?utf-8?B?bWFucXRvVlQvZGRXK2tMZytZckcvTUtHdFg1bk5ub2RZYjc4UHE1eEw2dURF?=
 =?utf-8?B?OGh0Sm5HSHRSanREaEJodU44OWFRKytib0s3TTNUaW10REx3dHNndWtDYUFw?=
 =?utf-8?B?NmpvNGlnSTJBdFJtYlJnS2JYS21OY1R3eDNqdzBhTHBoR1VOZ0lSZWg5MkVZ?=
 =?utf-8?B?L3Q4ZVprMUlGUVRCcTA1M05idkNDcXlCNk9TNnlUbXpoc3RkT1lhVkdtWUZp?=
 =?utf-8?B?MEVNYXRIQ3NETXR3YzZvSW9oZ016b2RJMzhPOERzMjFNNVlXWWxSdjl6RmZ2?=
 =?utf-8?B?Z3hQYmJadWMwYU00SFA0N1d6ZW9xYVdzVmN4dklpeHZRTmlxWHNvQThIR1hE?=
 =?utf-8?B?NGROZTBxMW53bVB2Y1ViOXRZVE9mbXpNdGVxZlppM2RNOUVZNFovZXh2TVNn?=
 =?utf-8?B?bzRjWTdmU1NyMXFSdlB0eVJld1VGTVh5WnVpdEQ3MmNKbXlFbDFTSzNPZ0pm?=
 =?utf-8?B?OWNQTHhoVmVSTmJaRHNsaHhMUitiTkx6RWxoRENnN2YwU1pjSGUxNzJPMU4y?=
 =?utf-8?B?eWpEbUFLWjFRMkh0OG0rUTVSQS9PVjZTY0x4QWd4NUo1SjRZUWR3Z1BVNVo2?=
 =?utf-8?B?bXdKTk9jMUhVSVc2akh5ajh2ZVl3aEtFV2tGeExMUXhNN3JwVTYxOXlaeDZE?=
 =?utf-8?B?YkVVMHJpTHdmMnJYZDlEQlRMQ2ExeGRKR1BKcUNPUG1MY3h3bUduTEtYOVRq?=
 =?utf-8?B?TWFsb0RSVXJpcThvL25oU2NDaGZVcEsxZGFCeUpPblFYZkZ0ZFA0V1h1QlZj?=
 =?utf-8?B?ZjRUQUd6T05ObUlTK0VKQ1hGQmFSYTMwQjg1WDdoTG1jM1hzWGxobStEakFq?=
 =?utf-8?B?VXFvRHBud1ZCcGNERkhRclJuU0ZVTTU1b3lDZjhnaEFmdzJKK1VhUW9NY1FI?=
 =?utf-8?B?VXE3Q1lvNFJuMkxQeGVYUk9DNG1sMmFyZ290N2tTRXhsdWJQb3lQNEJCZmVT?=
 =?utf-8?B?T1gzTjcyWS9DMDZOZFg2WWxlcGpkbUlsNGtGcTdTbk5TR05sY3JMV2U2Q2VB?=
 =?utf-8?B?NWhoTTJMODZxdExMS0dFdjJ1b2NpUjEwUDNiS1BJQlVJYUl5YSt5eGRRakh6?=
 =?utf-8?B?TEUrMjdOcjFXRkF6Ky9MZmxkQTF6cTBNdm1WeWxFUEVmYVVEblNnbElNRXpq?=
 =?utf-8?B?alZxRWNIbmVKWndLdHpJRDBoeE0wejFZOGFPQURWVDFWZjVqZmd5QjRlUlNF?=
 =?utf-8?B?QmFiMWUxekdoSll1NUl3eUlIbXlZT1VZRHhXaEMzaXllbjNpVE04U21TWXRK?=
 =?utf-8?B?NnE2b05xREw0UTFwVjQyS3pQOW1RaDBqMC9WS1dWd0ZpS0lIcU1QcHljd1B6?=
 =?utf-8?B?ZnJqQ3B1bUNyVjAvS2hNbEdoL1pnMXJtVUFrMnJic0c3aGd1R3E0UUlkNlRm?=
 =?utf-8?B?b0xlZFBjTWh1MTA1ZDhyRFpodU53a0wwS3BIR0VnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXhwOTJqbnpyRG55Q2hlNWE5cGNXb214cEk3Y2JBSXlKb1BuUHBoOTFjN1lm?=
 =?utf-8?B?eHIrUXhaelRQQWlUWlJ2SElrdmxFK3J2cVJXNzJuM1QxOWFQbzV4ZVRBOXZ1?=
 =?utf-8?B?ZkFST2YraVVGelpiRFl5UXdwRGVCNVJjU1FtWjI5NE1BQy85MzVHNGxMNGtP?=
 =?utf-8?B?bGQzaTd4alZmSWZ3N1hXc1NTbFNFMDFNSXkyQStaMVdNR2VlTklVRE1kV1dS?=
 =?utf-8?B?K3QrSEVkek5wbTREVmdneFZyaHFxN3dnUmRJN1B3SUpKNmhxOTZScE52THUv?=
 =?utf-8?B?U0hmanptSFhhS1BxcVFNZ1BQdnNmRk5GOXFxWExzUnozamdTRWVhSlZLRnZQ?=
 =?utf-8?B?Qkw1dnF3dUFoWkZiWUlBWE1aUUg0T3VFNStmd0dVM2w2VUd5MlM1ZnJYRkNO?=
 =?utf-8?B?Z2R2TSsxeGtQMzhtL2EvbmhlNTBYZjhFd0JEb2ZPS09HeVFDYURuTFEvQ1Zj?=
 =?utf-8?B?MkpycEdkU09SendCcEpCRDgwL2swWHc1TTd5RHJ1d3Y0R2pSOFV1VWQ1UkpJ?=
 =?utf-8?B?V3JGV3NjNkJqZGRHbUtObW9RSjBoRFhJMHFDckFBdk5rRWhmRVdxaTIzKzBu?=
 =?utf-8?B?OEZnd0R6UzlocnorRVI3ZHFLd3VLTU5wTWV1aGU4ZDdmOEhoUHJ0eFdoQk5C?=
 =?utf-8?B?OGpSb0dNMis5SGZaV3RwMnMrcmZIMDlncERNMzdIckV0Zy9yOVRsRHpucmY1?=
 =?utf-8?B?K1g2aXFtTjBDSWhZVlMvNDhOYWtJblF5S1E5S0ZtQTdhclZWK3ZKVmhnMjJP?=
 =?utf-8?B?Vk1LZ0xvUlZaajBHcXpRYURrUkFBd2x3ZWk0MWw0amxoaWVEOGVsYXlEaEhF?=
 =?utf-8?B?cmR2cXlEOUZOMU04YnJlekNsVFR0TWtuV2ZCK3hUbnNVWUVhM1g4eHhRVFVy?=
 =?utf-8?B?dDRwODIxWFgvRVBTbHdIWVkxRWk5WVJ3QzBseDdhMWM1MkUwOU5tcHRKamRY?=
 =?utf-8?B?TGREeG53MXQ3ODZ0Ky9IL0JXNUZ1VjRGclhXVk1zZHpuK3RIZFF5N0cwR1o1?=
 =?utf-8?B?QXE2MGZIcWJqcGtYemFPQmU0dURoQzZkby92TUkvbnFscUs4NVZaUEs1bHZt?=
 =?utf-8?B?TFlGZE1kTXc1MVQyNDR0RzUyZlorMkxwVUg1cHpwM3NJMEhrQnhjSU5yKzRl?=
 =?utf-8?B?U21WZTFMWEpjekRsZEcyZW00QmlUQkxTemg3QlJRTTdUcndsMGd3Q0c5cWZu?=
 =?utf-8?B?MUE2M2F6eEFtSXdIRXhyZW9Fd0p3MDRlcUZyVEtIUUw2TzlBOXJUeXlGUndM?=
 =?utf-8?B?RVdsbWpqcDdxMUI1ZWdxNHlVcFZjUUtVN2h0WXY3TS92YXpoeVJFbHNXVS9j?=
 =?utf-8?B?WDAvbVR2c09JT1ZhUjczcHRsR0hhQ0J3cXJEWW9RV3Q0MHBSeVRHbVVrYUdH?=
 =?utf-8?B?cHJScVgxL3QzL0UyK3IvVlZwd1VjRGxZZEdEM0hHTEZXdGlua2RIUTJaVlpI?=
 =?utf-8?B?R1RMUFNuOEVscC81Q2phQWlvRU9oR3J1czVYSHgzOWd1RTlWRTFDUE96OExs?=
 =?utf-8?B?cWprUlQ0Y0JqMGtwU1FicEwxMytBekhPS0tkZGY3eWFJbXp1MHJmWVp1TUUy?=
 =?utf-8?B?R3NYdkE3TC80dHA5S2lxd0NpQXlmM0FjbnRZMTRIUnZxYVpxSGNPa0QvSEZi?=
 =?utf-8?B?cmNJcXlrajhXUU9ZZlVzR1REblFFbXFudUdpVDN2cjYxek1BQ1ZGcmhZMEVw?=
 =?utf-8?B?dUVEdGNKd2djdlZqQkdwNDg1b292VUN5VXJtcWxIUWhnWXZNUFJBc3FBckhy?=
 =?utf-8?Q?w0FqE7SDqgvmb9HbY2fGIu3GYwvwbjnr8I6tXqE?=
X-OriginatorOrg: sct-15-20-8769-5-msonline-outlook-acae4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 173ba8b6-33d0-4a44-5efe-08ddc912618d
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:24:54.3359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7016



On 22/07/25 11:44 am, Aditya Garg wrote:
> 
> 
> 
> 
> On 22 July 2025 10:39:01 am IST, Junio C Hamano <gitster@pobox.com> wrote:
>> Aditya Garg <gargaditya08@live.com> writes:
>>
>>> Or maybe you mean, ONLY send via imap and don't use SMTP? Like
>>> this users can use their email clients to send emails?
>>
>> Exactly.  You sold this feature as "have send-email send the
>> message, and keep an extra copy you sent in your Sent imap folder".
>>
>> I pointed out that "have send-email do everything it would normally
>> do before it talks to MSA or talk SMTP to send messages out, and
>> instead drive imap-send to store these messages in a folder like
>> imap-send users have used the program so far---as the user will send
>> the messages out of their draft folder as was traditionally done by
>> any imap-send users, send-email will *not* send anything out itself"
>> as a possible different way send-email may want to use imap-send.
>>
>> These are two very different use cases.  We could organize things
>> this way:
>>
>> A1. When imap-folder is specified, that IMAP folder will get an extra
>>     copy, in addition to what send-email sends out;
>>
>> A2. When yet another new option, --send-email-no-send, is
>>     specified, send-email would not send any messages out.  Even
>>     when this option is in effect, if --imap-folder is specified,
>>     that IMAP folder will get an extra copy, in addition to what
>>     send-email would send out (which is nothing).
>>
>> Or alternatively, we can have two very different operation modes
>> that both involve imap-send:
>>
>> B1. When --imap-sent-folder is specified, that IMAP folder will get
>>     an extra copy, in addition to what send-email sent out via its
>>     usual route (like by invoking MSA or talking SMTP)
>>
>> B2. When --imap-outgo-folder is specified, that IMAP folder will
>>     get the outgo copy, later to be sent by the user (just like a
>>     user of imap-send would usually use), and send-email would not
>>     send out anything by its usual route.
>>
>> I thought the latter would be easier to explain to end-users, which
>> is why "sent" or "fcc" or something like that should be in the name
>> of the option when operating in the mode the patch implements.
>>
>> This brings up a yet another possibility.  Invoking imap-send can be
>> a new third way send-email uses to send out the messages, in addition
>> to existing (1) invoking a local "/usr/lib/sendmail" program, or (2)
>> talking SMTP to smarthost.  That would be very easy to explain the
>> operating mode B2 to users of send-email or users of imap-send, but
>> it would be a bit awkward to find where B1 conceptually fits.
>>
> 
> Honestly, B2 looks like a doable thing, but I don't think people would really want to use this mode. Considering the fact that using an MSA or SMTP is much better, and commonly used. Also, imap-send was definitely not in use, especially looking that the fact that it was broken for a very long time.
> 
> I'll rename it to imap-sent-folder, but the name looks more like it is only for "Sent" folder, and no other folder can be used. For example I like to keep a copy of the emails I send to git mailing list in a seperate 'git' folder in my mailbox. I can set the folder name as git, and thus have a copy saved there. What do you think about that?

Also, as far as B2 is concerned, users can already do something like:

git format-patch -2 HEAD --to=someone@example.com --stdout | git imap-send

Which is more or less the same what git-send-email would do. The objective to add imap-send to send-email was not
to add another feature for sending emails, but rather keep to copy of the sent emails at the desired correct place
in their own mailbox.

