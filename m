Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010004.outbound.protection.outlook.com [52.103.68.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8567B2749DF
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143815; cv=fail; b=CCHYcER6o56NWhb29vlcai4J1pvrlq2Gq9zmGApNiKCwXAwfPRyJlQU2C29unUFPfHXMe7k3RonXM7Soc5bhhdmjZhiX8+vPNePD+gLDmHDwhDcF+OgaAyxAq/y78eBuJTmqrmghnQkPLsVr1zsPOBxef7PrX9EWtxXd4M3ubn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143815; c=relaxed/simple;
	bh=8oQgy3fsEROte/ET8nbpihHHs7U3hPUocZePa2t9TmA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=qHmfIu8wUSLCD5rflYLZhwju8kDs19JL4L7Z6Q5rgxediGtg3vSfZoUZu52gAq6o+TmZtJIIFk4FUsJrZaD78Uhf8gAD8xmOiuKXlD0smzqYdN9D96mHceieEJg0OYHfZCBDNsLXF/ETuBhSrKu6NlK5xaY34zRSMetQhGMV92Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=szTGEdGq; arc=fail smtp.client-ip=52.103.68.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="szTGEdGq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hu1fjtQOiYethUk+yy31lHZbJuFmC1ko7gDkBBPTM54fwudJFebAThFmhJGc4I6XP3jf6CURifGQskpKyJcknzyeHF/WyrqHEk/Zrn0n+Br0BZwx7qIdWKvgEzg0pRNoQqxDwtCsU/LJx3J0SFx5JU9UG5lj7orsmMXtSMjuwATpHZllKTmaVF+TpveOdwxIxRqvIBxnZZIg6kU31QxVfVzluR4KZQyJ+hXlrkeUm+FsWt8QSJHEUduOwlYWPzRWKBZv0EhmZNmhdWbMycGXKYqPWK/85Zd+kWIlhfj/aamhgH94DDbjpN9GuvDjkz/emCEV7oqfpihv0n/IAEhOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/fgRn4gpAHyyciUH+fnJjqKSeVj3zN8MtSH91zmkT8=;
 b=tiwZjYtU7B2K7O+r6lMJvuCIbw5+n8cD8BYH/7i4bMs+IgIzpgqFgy72usl6XSQxVO5hx0eYbjNY35kWgeMzHqrLCTsSEwT4z8jSgSvkdVtgUH98WlHHsuNW7nP7VH1UtVyaYshfPuDEnGFVAsH2P0Jx08rosz5tJGhUqdYNP94G9zWpgb03B6Mr2fXQuV7lMw6BA9H3J1etamIlQGDlRb3gP9oxlug7lrx/4f3JyoywVhDVSwIx9T11CUPyhfEqAEsPiHfxU2kyiDh0ZJgaozdTju+IifDhV24Ts0TEy5VYH02pXo3bttjuAZhbS5lXCQceoPDTfLyux8MBIRBjYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/fgRn4gpAHyyciUH+fnJjqKSeVj3zN8MtSH91zmkT8=;
 b=szTGEdGqUzyZcHh4lsZjLAukjCBO5HMOdxYqkXULftUdDUr3HT8Ml9JHbdEdwhT7BlQK3L2ufDewGmDfyojJF6dkpmsAsPYobWFMixpv041auVQqwAVcLG/Qhu0qJ9nwJU1jCFxigxUT3rF+MXOthUeVQPgNB5Uzo3zLpnbpDlAzouXQrWftgdn1tgHr/+wIvSpSveJPPfDPOUjK95aNvrOiWc4uHXWpUEyEI+2sJ2hcQI/1NXR5fJL6o5XX4+jrFkeRSUAsn/wqOX/HkccqRYV05DQas/ziVpJYiiNDJRbCfbVuVeMDSyVJi9BIQg3jdu7jV67fB/gdRwktLlIuxQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PPF50418EDA4.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::594) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 17:16:48 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 17:16:48 +0000
Date: Thu, 05 Jun 2025 22:46:45 +0530
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>,
 Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Jeff King <peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v13_02/10=5D_imap-send=3A_add?=
 =?US-ASCII?Q?_support_for_OAuth2=2E0_authentication?=
User-Agent: Thunderbird for Android
In-Reply-To: <xmqqy0u687ww.fsf@gitster.g>
References: <cover.1749112640.git.gargaditya08@live.com> <0d28e337cfe7ce3c52490544875474b3502d2081.1749112640.git.gargaditya08@live.com> <xmqqy0u687ww.fsf@gitster.g>
Message-ID:
 <PN3PR01MB9597EA16029BEBBF4B966212B86FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PN4P287CA0127.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <08FBB11C-CBA6-4CC4-8363-F2CE776AAF37@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PPF50418EDA4:EE_
X-MS-Office365-Filtering-Correlation-Id: de4b5ee2-a31a-4b50-4158-08dda454c105
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|7092599006|8060799009|19110799006|15080799009|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXVDaEFWRzVvWC85YW5vSmlPUW01YUwvRC9ZUDE2RjkwNnFyYndiYXJQTmlw?=
 =?utf-8?B?YWI3R0pyM2FHWFVQTmJTMzFWL01RVm5PTVhjbE1jYU1aeVUxTkwwSHY2eVdx?=
 =?utf-8?B?dzlzUFp5S0NiVThvRzRzQnp3YjlvbUVlNGVmWjlITmxrNkdXTWVTMjl1VmNo?=
 =?utf-8?B?WVBSQWdhUWprRUZ0R2tOTjBaSFBrVTNLVWRrMXZjZW9CTzBSVEpyZjJ2bWFw?=
 =?utf-8?B?bjZuYmRWQW9adko3N2dlaUtXVDNWZEI1QzdXR25UYmF1dWVRTUNlN1JLZllp?=
 =?utf-8?B?cVJvaTZDY2tDcEZoT2VrNDFhd2RpMG5EUGJMamlRSWFCNmh2QXJpQ0FNc1BM?=
 =?utf-8?B?aXcyODBYZ3pZR0lFY2RvcVFHNCtXSVZCY1NBYTlRbGpQOHZLQUhxa2RXSUg3?=
 =?utf-8?B?dHNXS0lDMGxZS1ZuU0FoSHBqQUNUb3hwMTF4WTJRL3hvMEs5NjhKUENFWGVR?=
 =?utf-8?B?TUtjSzBGZHVOaHZSVkNSc2VJbUZ6NVIzMUxqa0paOUtYRXpPanJENTc5ZitO?=
 =?utf-8?B?cVUrMEVIQktGVXY0dm44TlI5WjFFYnZROWc0M3lXOXdFbFMxcitlWlNUcXBw?=
 =?utf-8?B?Y2tSMjFaV25DQnFXSmQ0dHNEN2dnRkNES0RvRWhaaEkxSm1uK0tvenRlQTZr?=
 =?utf-8?B?K2lJQzdrNE1TdzlKTndtb3pyZlBZd1ZlMDlsU3laZnVSbVBob1k2KzR2ajZz?=
 =?utf-8?B?UGc2bHowYXpyS2pHa1RVOC9VeTAvTmVHUVdQZVF0SjE5cFJnRGRDaHRCSGJB?=
 =?utf-8?B?enErLzlJZXZSSTZlYmI1VjVTaS9Ta25tSEVWSm9IN3RXaVdCdW0wNTJqMWFp?=
 =?utf-8?B?M1Z5OUY2ZUNxY3orZi9VQTdnMDRmbFQ4UTNGSFE1QVR0bDFqejg0anI3aWxF?=
 =?utf-8?B?T2Yxck43RXNJRnR0Q0RVMDM2UVcwYW10UFR0ZE5NZFBoTUU0cVdnTGJxMUpV?=
 =?utf-8?B?ZEx5eEpQRFpXSXFZUGZzOG9wMXBPOTdkZWppY2s1S1UwWFhCQnBzbGkyN1Uw?=
 =?utf-8?B?TDN2SGNhaEdrak8rdWJhZGFheXhTZnV5YnFKMXVZTFY2bURWWXJSSDh2cGJm?=
 =?utf-8?B?MkRnRnNQYk44MFVTdVBHQWNsbURWN2pqOUVQR2NJNVNvL2N3YWs5RElZQjJt?=
 =?utf-8?B?RnNpYVFDOXZseHd3S3d5cllLaVR6V0xpQ1ZKNlFzdVY2cGNtMGFSMWVKRUIz?=
 =?utf-8?B?dGRGMHN3NndSbW91dkdncXdkZnpYSHliQXlyTzV0cHhVY2toczVBRlJIK0RW?=
 =?utf-8?B?ZC9OYXBoTkpDc1JPM2d1SHRaNzdlVHhNKzVqb04xdFRUT0txTFI4dGczTmdj?=
 =?utf-8?B?aHRQUUM2OXQyTDBYSHZMaVVxdHBqUm5YeE93T3drWkdEVk8yWHJjZis5ZDU5?=
 =?utf-8?B?aXJqdmYwNkhWTC9rYVg1RDhwV3h4RnU4WkUwd0g5QmcrelFDN00zbFBEVVU3?=
 =?utf-8?B?c1hhZEt5OVI5ZU9nTTNHTkROWGk2dEhrdk9nMnRZT1orM3hmdy93cGtrb0tu?=
 =?utf-8?B?L1V6QmRyWnk4ZFdXWWVWZjVDRHBkTTNoZ3Q5WFB1cGw4cEdhNUJwUDJxRml6?=
 =?utf-8?B?Uy9tQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTkrWjVUTis5NW9TdlpVaC9ndVJlZ3Y4eFBxUWtOdTRyZ1ptemUvRm9rVjFv?=
 =?utf-8?B?SjAxaGdmOWJsTUthWkl6WmdJQlhOT0dVeWVtYTBWbWFHZ0RHbC9pVW5Edmtt?=
 =?utf-8?B?OS8xZ3FTalNUTmxYM1ViZHUyM3pmclk0Y0Izc2Q3WmdpUzM0elRpQllnK2xM?=
 =?utf-8?B?MlpTaHl5T3Q2U283ZVRYanhYVmdqY1JjbGZvRDhZTTVBNU9US1VOYWdTc0Vu?=
 =?utf-8?B?N3RxOFdhSGpBUERNZHZ6V0k4ajk4YXE3cmFLU1RjdFQ0VUxYdWZESUMwamI5?=
 =?utf-8?B?cXNUUU5OdWVpK0YvMUo3T0U5aHdHMnhTTTlUbG11Ymo2eGYvemx1OVBNYW9y?=
 =?utf-8?B?bVpNaWZ2TkRkdVVVUFZ6YnJ2WFdVL25LWFhwcjNQSE9Ea0dxWFA4V2FmdG5q?=
 =?utf-8?B?NDFaeGhvQlNHaTNDUXFoU0dHK0V3RS9DT0R0YUZyQU1WdDlhc1BiMzZDMVA5?=
 =?utf-8?B?L2cvWEp1T0RWSUV4cW93ZEZBQTRKYmE5UGJFNkMwRHc0ZDZ2UUE5a3dTQyto?=
 =?utf-8?B?MWxubHhTeUlYaCtWOUFpcnk4djdRdWFYSmExZmRSTzVYbWd6dkdCa3VPcHRV?=
 =?utf-8?B?YnM2dVh0d0ZUSzg1Y0QwdFJ3dVJBTVZJQ0h1MllnUkZ5L2xjODFyWThCdndM?=
 =?utf-8?B?Ry9hNHNKclF4L0Z5RE1ZWFpFa0s5NzZhZlF1cFpDQzljRzZPN01Sb3IxRVdk?=
 =?utf-8?B?eTVINTFkeHg3MUFIVGFzT1pyTFhDQSs2OXpXTm5nS1Rmcmt3aDZTeVBjYktu?=
 =?utf-8?B?NUYyRUZNVGgwSDZUNlNkVmsyS0QyOEhvTFdZTWo4RTl4bXZXWFh5cmJxa05z?=
 =?utf-8?B?bXpkYnN5YmsvWEY4SzVpWjg5Z0E3T1VvU2xrWXZWR2hYcDVZQlkxOWlieW44?=
 =?utf-8?B?UEptTXN5VGhCZHo0cjJVMW9OMm5PTWV4YzcrV1RKZUpVMnd4NmM5NU1UU29N?=
 =?utf-8?B?Z2t2dGVFeldQOWRVd2Q3N0FOQ1gzYXI4VDVvUXVXZERURSt5RDU1OEhCdTZn?=
 =?utf-8?B?d3JRdnRtdDRoTGd1elRNSWkvU21CL1hjbm9RUDRrdmszNGdCajR1RXBEQjVa?=
 =?utf-8?B?dmJEanlkajRDa3p2d0lCT3k2b1pmd3JTVFZRMVBVZ1l0VGZxVUNvRFR0OTBv?=
 =?utf-8?B?dUwrQ3hTVXVpVEtRSUZMTjhXMWlIL0pNeWRsYUhzbkthemU5REM4cnQ2NWZ5?=
 =?utf-8?B?SUdnUUtoZnJtZmxhMTBIVnpGQ0EvOVMrQ1l6ayt0Z2xVbXNKcDlENGtvd1FW?=
 =?utf-8?B?R0hUbHQrRnRCRUwxY3o0aHoweVJzZ3V2RmNrNCs4MytUOXhBOVM5U3lOU0ZV?=
 =?utf-8?B?MkVvWXJvcXNJSUJQTVZNcmxIby92clRPUXpMNVA1aHA2UldjaVN2MTlBOWV4?=
 =?utf-8?B?WW5HZEJvbkgvcGhuQVVjSXlXd1U1WlA4SVArYTliMWRWdkxJU2R5bWk5bXBK?=
 =?utf-8?B?THRBUllCMW4yOFdYRlUrOGZYS05DTk9jczRzaVVKK2M5WTNyMWo0REJxQVkr?=
 =?utf-8?B?SUxsUkwyMzM2OFpXOHgrRU9NTlI0aWl1Q084Qk1UMC9xZGQwRHk1N2pUMzBH?=
 =?utf-8?B?U0tjRy9UOGxvRURod0kwMC8wZkw3MGZWSTlHT29hK25PbEJPeDNDMXhDWGVw?=
 =?utf-8?B?MFlmL0pwNm83cElFcGRRWDB2bnJPdlBaekZTNENCanJYd1VYaGI2YndoQ0hy?=
 =?utf-8?B?TkREd1ZjRFZnc3BlWTZseEp3TUNvNXRNbWU3aHpvRkl1M0sxUVFlNUdXZXBu?=
 =?utf-8?Q?snLDWe56IlSZzufOtg=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: de4b5ee2-a31a-4b50-4158-08dda454c105
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 17:16:48.1848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPF50418EDA4



On 5 June 2025 10:03:51=E2=80=AFpm IST, Junio C Hamano <gitster@pobox.com> =
wrote:
>Aditya Garg <gargaditya08@live.com> writes:
>
>> +			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
>> +				if (!CAP(AUTH_OAUTHBEARER)) {
>> +					fprintf(stderr, "You specified "
>> +						"OAUTHBEARER as authentication method, "
>> +						"but %s doesn't support it.\n", srvc->host);
>> +					goto bail;
>> +				}
>> +
>> +				#ifdef NO_OPENSSL
>> +				fprintf(stderr, "You are trying to use OAUTHBEARER authentication m=
echanism "
>> +					"with OpenSSL library, but its support has not been compiled in.")=
;
>> +				goto bail;
>> +				#endif
>
>Ugly.  Can we avoid #ifdef/#endif in the middle of such a main flow
>of the logic?  Hiding such ugliness by indenting the #ifdef/#endif
>directives as if they are just one of the code lines is doubly ugly.
>

RESENDING AS PLAIN TEXT


Your suggestion in a previous review said:

           if (!auth_oauthbearer) {
               ... we do not support ...
               goto bail;
           }

Might look less ugly, but will result in a compiler warning that this will =
always
be true if compiled with NO_OPENSSL. If you are fine with that, good. Else =
tbh
I am out of ideas :(.

>>  	server_fill_credential(srvc, cred);
>>  	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
>> -	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
>> +
>> +	if (!srvc->auth_method ||
>> +	    (strcmp(srvc->auth_method, "XOAUTH2") &&
>> +	    strcmp(srvc->auth_method, "OAUTHBEARER")))
>> +		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
>
>Can we clarify this part, possibly with an in-code comment?
>
>"Unless XOAUTH2 or OAUTHBEARER, use the password" sounds a bit
>strange.  What about methods other than these two that are not a
>plain simple password authentication?  Will we remember extending
>this code when we add yet another one to exclude it like XOAUTH2 and
>OAUTHBEARER are excluded with this patch?
>

Let me answer this first. CURLOPT_PASSWORD is for plain or login type
authentication, and if srvc->auth_method is not defined, curl's behaviour
defaults to them. OAUTHBEARER and XOAUTH2 use CURLOPT_XOAUTH2_BEARER
in curl, which can use either of them based on what server says. Other auth=
 methods
are not supported yet in this code, and this is the reason CRAM_MD5 is supp=
orted
by only OpenSSL.
