Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010002.outbound.protection.outlook.com [52.103.68.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C3F13BAF1
	for <git@vger.kernel.org>; Thu, 22 May 2025 19:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747943371; cv=fail; b=MAhqymMo3VMvhmjNMqMl/rASBRLoPlgvW/xrYP9OY1X8g0VhWjqjanWrR2cazF1jyhPfVDWN58+v+hU/6S3I9KXpvg0Z0tHBBTIz44HW4CAhkwkiFF5mTlm2C5Kj/EXikVij+mGsba0dL7AJ0n1utNk3nAFfIX3oFS0RtPGW02Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747943371; c=relaxed/simple;
	bh=yf+q9439XiYIqk90ZHoZXfJeuF++RvWzKeKipcZ2Lgg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Osdj09smMz938W3x4a/jzjfuXmbqyUGsN5xHBPWR102lK8/l9l3IphrtmI2oIajeuM6ha7v7+IRrirPkLt0+s+o0cyM1/IndLuXo5TXcVF/T5U8ZEaacZeA9JECXcBFixycSQ2K3ZWaKYcfB92/PkTMYcM202z/l9/vFIqwoGVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=afEw4Zya; arc=fail smtp.client-ip=52.103.68.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="afEw4Zya"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3JtrfDhA3i2EScyXqi5+P7LytPreizUjtSec7rTN6zS9Zh2bVXGVF0Jf/SJgFEwD3ZiT9NRuMYIUe7121fh8833a3/Tnl9BuM0CO8RdMB54xm/RHEuvrvC2PMnWJEYPrcusPFwnmI3XnLenQA8eeJu2LntR+S3nJCrXHGdJT/A4wsWXBwgg8NumG9Ih9lVJP98iwVwFLi5Cjie8ay94IrOZ0Xw9V3wsOWrP2I0Bv+AiCJr5kePzAQCcDK7ObFqWH664LkaylCPm0t/80VvhTHNumcfKaDlJtl04DLykf90ScMSlXJrllcpv66KM/geDj/2zJvexAUHnar79VgwhGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kf+ALj1AA9aX2Fv7tM0Rzl21zbEwXsIGHj3wCPzZp2A=;
 b=Zf6burlL85KcmvOC0710nFfhmMSDHbUo7jgRivv6qmc78sXWjiGvfUeXwrtgI4XO4iyC/oYlndvL/I4YN3LeSdIyKwYb2ucm7tUqMI9J9TrIOqOAy5M8iWp/bHljVPn+ITd4pS7wAY5rYj2sUYi3/cpHV8CbZ3UGziDD7V7hrGiVskYnFcI2Js8eNBm07KKunzJgkLl/Z4NYV15CNnkyxGy2tVw2Zn97TMiqba7q8USlwD840ZfYGHDZG1Q/j7Bw4I0L9gbwNsIsZVmPwrEbl2+FvdeUXnE6DZolS8eoszXUIMyQy9ZGpDgj4vX3I45NY/XMJWDp+k9lumGyywiDBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kf+ALj1AA9aX2Fv7tM0Rzl21zbEwXsIGHj3wCPzZp2A=;
 b=afEw4ZyaBQogx3RDTz6Ps4nJI+2avQExTlByYk2jqoqAgCtR6dTap3aQCYRNq4K3PlGAs0j9RwQlZtzgx/EVZg6JpZBPR3BHZpPK+55P22IL4w6s2+lHUfQJr2NgMFULze69pgNcgQ6oGhGj1TPvxfMT4SRPQNKf8AFdoYMX+prqyZz33XSfJkKjEICTqRFaKsfDH6zEVYLTINtJc4+g/yNqBiLiEtMvIB7LgkiJNBLZeIFKNOzKv1Wp57uX7VMUvN97irDo7nbmonz0dGNEaBCiw0HbpQrg8mUddRpV4axFWPDKRo29nhGB8WFAoml3p9e4ygjQEnvgI2o7a5V1aQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6385.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 19:49:24 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 19:49:24 +0000
Message-ID:
 <PN3PR01MB959796C61678ED1857C9B476B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 23 May 2025 01:19:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] imap-send: add support for OAuth2.0 authentication
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Eric Sunshine <sunshine@sunshineco.com>,
 Julian Swagemakers <julian@swagemakers.org>,
 Shengyu Qu <wiagn233@outlook.com>, Zi Yao <ziyao@disroot.org>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB959744EC6D19FEB8D197C434B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <aC9-7Z4VW7gXw_l8@tapette.crustytoothpaste.net>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <aC9-7Z4VW7gXw_l8@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::28) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <ef946332-6196-47fc-a122-894b3f1febfc@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: ece3123b-c395-47ba-d8cc-08dd9969c0a9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|461199028|8060799009|15080799009|7092599006|41001999006|19110799006|1602099012|440099028|3412199025|4302099013|10035399007|12091999003|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEcxeSsvaDZ3R0FMZzNoOE9wREtKZlJTdncraDhoemFtVldRdFVUK2MzOERK?=
 =?utf-8?B?ODNZWEs2cnBJRE82WXhYcmdJdW8vbE5vclRwZmE3dXM2RGtPV0pBdHBiQzY4?=
 =?utf-8?B?OXc4WGhrWFE3WUlhZjF0NkxBbWwwSkNibGd5azEwOGN4ZlMzL3g2d3lTL2RE?=
 =?utf-8?B?U0w0ZVdUOWhFT1JrV3ZzRUhjdnY1ZUpWV2dOeVBJdlN2VnNwQ2hxNndHOHJv?=
 =?utf-8?B?Q3YrbkdQdk53UGE4NGdaTmlMMVJjSnhPNkZjY0tRUmU2SmhnellKRGxJcWZt?=
 =?utf-8?B?Snd2NlFiR2luaFhEQ3BhdWZFV2dPRnhEZ0tHUUMyZ2Y2Vm1vT0E2WnNUS1ls?=
 =?utf-8?B?YldDT3hsUXZONGdCWHVqZS9SMlVVajRDNXJHa1BCNk8rRkJyR2xQTkJZMk9S?=
 =?utf-8?B?VXNjcW0ySy9Ja29uUFl4NVppSC9DVVFTeXkrQ1Y0MmZ4SWZZdThId1BsT21h?=
 =?utf-8?B?c2RvaFlzQ21UWTI3N21ySERtWGNUWWVGa0ZpK1o5aGlzK1NkeEN2Zmltem9u?=
 =?utf-8?B?bmhSeS9aMmdnOHNyVytyOTVvVGw5eVJ0S0dieWVadG9HbnZ0Qk1sYUpLRm5W?=
 =?utf-8?B?bGJuWklVUFEyakt5VVdYeEFSRTZQcjArMnZKc2w4ckJGMG1Gd0lLNzZyd3V0?=
 =?utf-8?B?RWphUGY2cVk3T2Q4UHpuUjRGUjdHNFd4ZWZxQS90eEV6SHpuOVNORllZS3h3?=
 =?utf-8?B?Z2N6OEhpbnc4K1k5djVVMlZ5MUJ3TTJQUDMwZm15M1phZzBTVWcxNGlVNllK?=
 =?utf-8?B?bnRpWEg4bTRhVmNuUUl5VjdGamR2TEJyeWhvd0lDTnF1Uk9KejF5TkM3ZlJX?=
 =?utf-8?B?bkJvTGJOUFlFZHdOTjBDMHlyMTVuUTZhQWV3bXRpY2lJdHNrL0hhK25IY08r?=
 =?utf-8?B?VWJlZGZ6T2hEWjgyRlpoNDJveDgvdGgrbzd3cmhhbDREOHI4eUc0K05wTmxI?=
 =?utf-8?B?UWpHcXhnYVJaTkFPdk9NM3JSRDJOc3Z6bmtaV0RxL3Y5N2RoYlpXaHF0RVhM?=
 =?utf-8?B?eVU4cjNKUVpBTVZMUWdBRy8wZjRpNDdNdnJCd0VqNEQ3c2F0b1lCNkFibGdj?=
 =?utf-8?B?VUdNQ2tXa1dQbXpndFdwa3pnQUZ6WGFlWk0vbFJrZUtBVEt1SVhqWW9PQ24v?=
 =?utf-8?B?Q0hTeDBQaHpjQmZHRHpnczNXeGlhVDZaWUVoYi8rM21kOGk4cU04dE41V0Zm?=
 =?utf-8?B?aG81THVxY1J5Y3d2cnNaMm1SSmMwOXVlVm45UjAxdzJPdjBWRzRRZldmNUVT?=
 =?utf-8?B?S2tNT0NWS2dLaTNraWpPZTVwRmFsUkc1aFM1N3RHb0NzdUh0N3JVSTRmQllX?=
 =?utf-8?B?V3RnRXBQZTNHMlQ3MDM5a3pYNzNEVFJJK21jTXRueWYvTEVUWUZJbm81NHlB?=
 =?utf-8?B?bTE5d1BjY2ZwWHNOa0FqbDQvSVQ3RWdtemVoeW5Qc3ZKaE9XOVV1eHQ4YUVJ?=
 =?utf-8?B?dXNFNjcyZ0NSaSttTS9CSWIvWHNtM00vektZMGxkQ2dkYThBMjZ5M2twdHFu?=
 =?utf-8?B?NkpvTlJiTmV1UU1aZjIyZVd1Mml3TVBVVW02enJhd3puNURwOVRtQkIvZmRo?=
 =?utf-8?B?bHlWOWRkaldSMU5tT2VIaG1Qc2M1SjJyTk96bS9CQWdST0VkaHgvUC9KWjFy?=
 =?utf-8?B?OG5Da1BleTdMbElScnZxOFVLMzB6YTJMaWtmTDJCZlJDcTNUUkxkR2xLSWFs?=
 =?utf-8?B?ckNWVkdCWXd2RU9RcEYwMklGZ1ZCeEVQYStJRXZndXFZb1NlNjlMa212dTc0?=
 =?utf-8?B?cWZ3NVNYbTk3T3hVUGtZVkdZRVJKRDBDTmtGTHVaejJsZWNqZnpaNG03OXZo?=
 =?utf-8?Q?KL3Nlm/wteqhlHtGUmLO9/ovtWJv78evvVngQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ykh2cnNrV0xNM2JOUG1nLzRvZm9wZnIyUkdCSTZiTnlSNVA3WDhKL010aTY2?=
 =?utf-8?B?ZDZYeVpMNGRJWEV0RmRLRkluQk1VejB3WkRobE1FUEpjdTR2eXc2cVVRejVi?=
 =?utf-8?B?dzNnelljS0l4U3N5MnpnOEhUTm1zRm1FQTRSNFZWems4cHBLSk02ZTk0MFRM?=
 =?utf-8?B?OWNoY2Y1MitDVnFheUVGUjhYdE0zM1A5N2tCTXhjME82bU9EaGkxcVJ1Q1pz?=
 =?utf-8?B?Q0JVYU9yY0laUHU3R0I0ZUxuQzdZQktYQzY4bHY4WWk3TE5qWWIrYm84YnF0?=
 =?utf-8?B?THFkU29VeGZMY2pZNHRtdHRpbzdXYVQ4MzFrcFJJeGFDSXF2cGxxenNna2RK?=
 =?utf-8?B?YUJqUGY5ZTV1ZTFvVjBQblVkL0hFMjFjNlpUL3RmcXdDSnNiNnFrVXdBR3o1?=
 =?utf-8?B?ejQ0aTJoS2ZuYmhaOStMb3lvajhBVHcycCsyNTU4bUZFbUJheHc5NmZmdGpx?=
 =?utf-8?B?K0FGbmxiQ1MyMFA2SE9UU3BzTlJZbm55YzNRT3ZVVyt5TDlENnVwN0tXSE9R?=
 =?utf-8?B?NTM4YTdsWjlFU2k5WFZzYTUvZXJLWGpyN1FpZXQxQ2FHY3dTWkZzWEpOUE90?=
 =?utf-8?B?ekRrc0JmRUVOTUIyWnlNV0tOZlBmc21JQlZXV2RkM3lHQlIvckFWVHRzSzkw?=
 =?utf-8?B?aVB5VWRlS2hSMHFhWHVHaUdMWDFIZjlQR2Z1STJtR3ZRemtTZm84bkVHVFFE?=
 =?utf-8?B?M3R2YWpYaldZRnlzTkhrdFZWdE5TbUQxYmsyNkEvUWVwdGUxbEF3WnpudUkx?=
 =?utf-8?B?K0w3a25OZWdwVkEvN3gyR0pJZ3ZMKzI3NGpUTFpyR1NINTdTV1lzK2lyVUVj?=
 =?utf-8?B?emUvYVdWNnZmSTh3WDB6Z1VUR1djYUZyazR4ZDNWQStabzZrZTFCQ0hiOTM2?=
 =?utf-8?B?alFrbHhmQ2hSa3BydExaNlM5VThuMHdoaEVSSy9kcnNINkM0c3pLT1NsMk5l?=
 =?utf-8?B?ZWlkUC9lUERyeGxWM1orT3ZWdkdhSkk2V1VLMDJ4a2ttV0pMSTJPWHNDNzh4?=
 =?utf-8?B?R0taTUJ1bVZqM09hMkNrZHY1SkFUUlhPaEcvUTFwT0xTNkhwTVprdWMxUFkx?=
 =?utf-8?B?akZpcTFLOEc3QXNyM1hqSldxaTlwVC9lUTNmUWJkQi9GNWVESFlOZHNkU0hr?=
 =?utf-8?B?QWgzWnFUUFlUUUZzeVA2Tm5ualZXb2hmVDdjMFFzRiszczNBRkpBcnUyOXFh?=
 =?utf-8?B?SmpzamZsMzVhb3o3OFh2UDdydThaeXdIUGtIQUVVQ2Q1OTZ1ZGhTeTVMVXBv?=
 =?utf-8?B?UEJ3SThjbHZnMElFeFBKeE9hL21xc3NtSkJBVGNLVVFDSVI0Z01rNnhuSndt?=
 =?utf-8?B?WG1XZVBDcGRxLzFZSkxQTWVEeFBNRHpYaDBIYU9GM2puMGEyRTNRQ0U5Snhq?=
 =?utf-8?B?dFA2dlJTWGwwczVjeHREN3J6dTJ5V0JUMVlKR0xZNVZOakVoNTVMQmlXaEFi?=
 =?utf-8?B?aXJmNE5hVUh1L3FzcitvN2VwNU0rRUxMUmcrTTBya0RXTGhSN2RobjFNdVhs?=
 =?utf-8?B?VE9OUGJTK1J2eDFPZGR6ajlxU2F0NkE5ay9pVUlGdzNZNTd1Q2NyU0FER0w4?=
 =?utf-8?B?RWdKTTFZNmV1QWVWM1RMY2M1czVqN2dzNEw2VUdmSFBLbFRGbEhaVjdnV2Uw?=
 =?utf-8?B?bnJOcTh6ZW8xTXVaR2xZd29vM1RFN3hFZy9KaFpDRDMvRGUraHEzZUF3a0dx?=
 =?utf-8?B?NDZWUjFxbUYwaVNMUWw0c2I4ZldlTHhpVzQxdXhsQmdhcVJBUlQ4WkNoNVZ1?=
 =?utf-8?Q?zUtFDEfnu5eLBU5cO8=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ece3123b-c395-47ba-d8cc-08dd9969c0a9
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 19:49:24.4125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6385



On 23-05-2025 01:15 am, brian m. carlson wrote:
> On 2025-05-22 at 17:27:16, Aditya Garg wrote:
>> +static char *xoauth2_base64(const char *user, const char *access_token)
>> +{
>> +	int raw_len, b64_len;
>> +	char *raw, *b64;
>> +
>> +	/* Compose the XOAUTH2 string
>> +	 * "user=" {User} "^Aauth=Bearer " {Access Token} "^A^A"
>> +	 * https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response
>> +	 */
>> +	raw_len = strlen(user) + strlen(access_token) + 20;
>> +	raw = xmallocz(raw_len + 1);
>> +	snprintf(raw, raw_len + 1, "user=%s\001auth=Bearer %s\001\001", user, access_token);
>> +
>> +	/* Base64 encode */
>> +	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
>> +	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, strlen(raw));
>> +	free(raw);
>> +
>> +	if (b64_len < 0) {
>> +		free(b64);
>> +		return NULL;
>> +	}
>> +	return b64;
>> +}
>> +
>>  #else
>>  
>>  static char *cram(const char *challenge_64 UNUSED,
>> @@ -895,6 +959,20 @@ static char *cram(const char *challenge_64 UNUSED,
>>  	    "you have to build git-imap-send with OpenSSL library.");
>>  }
>>  
>> +static char *oauthbearer_base64(const char *user UNUSED,
>> +		  const char *access_token UNUSED)
>> +{
>> +	die("If you want to use OAUTHBEARER authenticate method, "
>> +	    "you have to build git-imap-send with OpenSSL library.");
>> +}
> 
> I don't think this is a good idea.  Linux distros and other parties who
> distribute OpenSSL cannot legally distribute Git linked against it and
> we should not require people to use OpenSSL for this.  It looks like all
> you need here is a base64 encoder and it should be pretty easy to write
> such an encoder.  There's a minimal decoder as part of decode_b_segent
> in mailinfo.c and I'm pretty sure we could just add a suitable encoder
> that writes to a strbuf like we have for percent-encoding.
> 
> Alternatively, you could just push this into the credential helper with
> the new credential helper extensions by adding support for that to git
> imap-send and let the helper implement the base64 encoding.  That's kind
> of the reason I implemented it in the first place.

We can still use curl to use these. Curl has a dedicated API for OAuth2.0.

That is what I am doing with v2.

