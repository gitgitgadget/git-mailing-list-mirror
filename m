Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011030.outbound.protection.outlook.com [52.103.67.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0B81940A2
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389466; cv=fail; b=CucG5Ic/Qs45ALD+TwoA2Dlnh5YGfb2d2p3HL74STo4kp2CQ+4KQzK1YhOT3fZJrnKjDLxYtxucko4A9v44aNiy9eAWp9rTJmX85XfIm3/mwZQBnCllVFxb2sW8T7igpV62+akTChjgpgdN7oo41ZKJvhlGEjEt5oIoEgcG7T+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389466; c=relaxed/simple;
	bh=Lg94Mb2OZXvkz+4lV/e/GfyG9zQUpGGQp7BTehgroTE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fqPBJQ1b4oJUx+4nUGg3hp7p5dBNxVcRAnV41zRQbVNAneXzoSxNLwdxPG9jUs44bZPW692letDwRGyX0Fy7wt3TVoTyGSiz3tqTNasJUxDUAT5dtNEtBz2D3ZcAiBxNSxs71gMgcbocKP0Iy00RAeLcB7+ba0d7yCEtB3rpC88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=WtbG/L7y; arc=fail smtp.client-ip=52.103.67.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="WtbG/L7y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JT4TwFOBVOVRzcWAOlyxyIVKuL1EovC+Q1g+6h1AmJyz+O0o4LVbW4qXRo3dVSNOFV8jWGvkfMXphQoAKtN+SoDz5l3vm8y24EfGNHtis+NpAa/RvIhFKYnHWZmX92AQWQ2K+S2EvOUd6zfi0Z9iiy9aGz3nyRUb0yxZmNAS5uXmP6N9D7dZxegcJ7Jw9rrBEwGd8E07IATfJ3iUZQnC4XMz8/Kefu6j+TqEN8njOIF2qqBy1W7z3vrU/7LG7m/pse+zGI59oCepWk+pn4/19QDVDfgbJqE/kZjAxb6zBk0eaukWojfddRqcxvHMgVt8vpeIjTPVzboe0rEpYOKuzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csoGzxr5DeilbkTe+ClVvkN5EfdpNyF/wTiSZNg8m6s=;
 b=riSyugtg4E5f+oaNh5KAm7tJFWb9hb8qa8fybj6oaAnWqAznGMT+cPlD1GTnMM5UsKTLKCygIwbcRzEaEckGzETI77z3/wuSFoAN1VGRnzK77PcXAUcR50aw6yF2UJyYfoEoiC8FaMVnF4LogYrh75HU4VjqPzTtJ2w5tCcVCDL9b+bcusS638Q7tRXmQVsn4s/Y8KJPZ9FiwMevZeLYS+9p9QU6gfOWo3AGNHVIVvYYclEjFNElOOFxMG3Rz6u7fkvLfzi58zH3uLwKPemLTVcm0YwvlYL08L3T1iedl4f/8zzFl70+q5iJNXYJgnUd1axa0H1tCSeS0hDTmrxBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csoGzxr5DeilbkTe+ClVvkN5EfdpNyF/wTiSZNg8m6s=;
 b=WtbG/L7yP0ZnYlrbTKf7GeLNLdL8lkFUtQBmXSL2H6q6Jqe6sgLMfWxDpvL64vMdkrB8GBMgtlkkailRUq88NQ8wPwzTpbFkBRlWcK9+ZtBIWTc2W2LH0pj1yRcJ6XRiBZYxFrQOlvssuXWt+z9vETqeUsiCAAQyFJvfddPUxFsmrQQ8aGzzjzzOHLp5sxYw8YT9OTrT0zAhFIp9oIuqhHTZEJ7l1HVS/litI/BjQrZIhwgYVIOWfb2hiSqpWwUEYyuUuiIYFz/gcpAbMjguzLw33zmPTPU0AkjsIqm1nrNLaa29J/xtramkQ9xSnMrlrsWtyfeWiGe8ZXKTqs76xQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB4186.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:11::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 17:04:21 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%3]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 17:04:21 +0000
Message-ID:
 <PN3PR01MB95975D219D59AA2C2F89FC84B841A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 1 Jul 2025 22:34:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Why git on windows pops up Git Credential Manager inspite of
 having set a credential helper in .gitconfig
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
References: <PN3PR01MB959737CFDDC39898364CBE34B841A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <610f64a5-015e-b2d8-03ea-78bb623f6af0@gmx.de>
 <PN3PR01MB95976A4B664ECB1EEB80D215B841A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <aefd8c42-f9ba-9af8-c0ab-a341a690fae1@gmx.de>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <aefd8c42-f9ba-9af8-c0ab-a341a690fae1@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::14) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <6418e7e1-519e-4b35-b1a5-149b1aaa0fc2@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ccd817-cf07-484c-c646-08ddb8c15280
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|461199028|6090799003|15080799009|7092599006|8060799009|5072599009|440099028|3412199025|40105399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T01ueXJsOW1SL1VScm1DRm5rRGRkRzVHcERCS2hGS2Zmd0ZOeEI1dGRFUUQv?=
 =?utf-8?B?Q3p4UkR5SFNaVlBIdWJTWjRvZjZrMDZGZlRZVUVwcXVzYVZkem80RTlGNGlz?=
 =?utf-8?B?SE4zc2J2cHhYOU8yQlF2TzdSbWxkUUc5OXZYODBnTHhKbm0xVFlCUXpDY2Rt?=
 =?utf-8?B?cVdpRTF2bzFGTHBwcHRTQUxhM2lXTEFzcUt0VDNwMUh6N1VMaU55OU0wbkty?=
 =?utf-8?B?VFJDSjhkUHVBZlhDeHVwdFFvdEtTbkxUV29VcThlN1N4SjVCM1pQY3JBa2RN?=
 =?utf-8?B?OWZ4NktGUW51a2E3ZFY5NUlGUFNUenAxdXpQd3VCVXBJRGJ1Y1JvYTQ2ZWk2?=
 =?utf-8?B?SVFzdzBDUlU1d1Z4K1kxUm1nRkpSbE41RkQ1RnNKb3JPN3FDUk9sZTZNT1l1?=
 =?utf-8?B?Z3diUVYwSUg0UjltNTRWdGdKK1lsVllVelgrTDh0dmh5NklDU3haL1JvZmtu?=
 =?utf-8?B?NzhZbVNRejBrZVJLbGovZGQrSitXbVNDYVU3Y0wrOTVXTXdOUnh2Y3pjSVBw?=
 =?utf-8?B?blJBREEvMWt3TktGT3lFaStSbCtpeWk5MTdGVWdmNzlqWmhROHBYeUlUSnFl?=
 =?utf-8?B?RHMwTTZPMVlGQzNzcThJSHNSU0t1clc4NFZWUkc2d2VSMWxNWFZTYmNnVlRx?=
 =?utf-8?B?NXNHeEo4SzlaY056ekR1NnZzdCtwUjRLbUQxMlNockhVTENFRHNWUis2SlVr?=
 =?utf-8?B?Nm5xSGdueE91VHV2N0ZOM1p4TTEvUWVhNjJoaThZS1FCaTBncFNrT2lkaDJz?=
 =?utf-8?B?ZnFjN1cxckZEUU1RcmN3MEF3K2hNZnJ1TEp3bWxPaW02WlFocThrTjhFc05N?=
 =?utf-8?B?bjgyS2djSDVabzRyTDluUHEzRzlvVno5bWNnRUxYcExrNTZZQUdua25DUE1p?=
 =?utf-8?B?SFRydngrOXFobit4UWlUZ1FqRlp5TWtMVmJrN0JRU25UbTBjWTRBcjZqMFlz?=
 =?utf-8?B?TmkzUzlKUTRsKzlxcjJlSU9uUGtOZ252d3ZpYTNiRGFXb3p2aStsaHNxa29K?=
 =?utf-8?B?V09sL3FHdW8zaFFCZnRJV09uOUtBRjVUeHRyemNhS2FCN2lYWHpCRnlEa1d0?=
 =?utf-8?B?ejZGbVlwaXVUdW4xU2x2SlY1LzlGMExvY2VralZDTDMzR29xblJOOTRHbWhM?=
 =?utf-8?B?UWZsMFlNQVQ5L1lLTkJpbFZ1S01YRU1EVTBQWElpSjQvSWZ3bDJ1ekdxWHFx?=
 =?utf-8?B?ZXI2UzJUa0FRNzArbjRlaVBtSVNqVURCZWxrRG8vc3RUcEFUVjVpNUlNV2JB?=
 =?utf-8?B?cUhsTEM2UXExdlQzTmZGcEE5SmFNSU9vWkQzbSt4SzVXb0NjMjFKb2xIQnlP?=
 =?utf-8?B?ZHB5aFMwQk5hVXJteVd4dm50cnBUQ0hVdkFmenBFcDdrVEt5UzdxdnNzMWxB?=
 =?utf-8?B?Tzlxei83M0xxY29zTmdCT0d4cnFaQ2IxTVUva1lSS3d4ZTVwMnFsVWd3b1Mx?=
 =?utf-8?B?S2tQV2VoV1F3T2tVWFNkVER2U1cvN1p1K3daNG12VDJ6ZjZnWWdqLzlwVTNQ?=
 =?utf-8?B?Q1pvMHlQbXMraG9LVkQxRHlOWFpUK2NwQWFiVDNTeVg3VUFrd2F2MzBXeEV1?=
 =?utf-8?Q?7Eta3DsbCgXcm9fzJapFC1MdY0RcdU985Kb1fS1GYw/Tl4?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTExdi9zZjY1b3JIQ01GUUFnT1N1eUlITCtCWjRXUVFab29rcjBReEJtN1NG?=
 =?utf-8?B?M0ZqQ1RTZG5TU2hDS3BVUDBXR0U0YUJ1OHJONDM3WmxONm5SZnlOQTRmQXdX?=
 =?utf-8?B?b2l2ZUxGNlRMNzY4bUpwZXRmdXVDZ05WQ1ltUFlpSkJHQVI1MXBPbmoyT1ZI?=
 =?utf-8?B?YktOYVB1MFRMVk1LeDY2dnVWTk5NdWtGWHBERHJvWitGdVpET2grQ1pnN1Bs?=
 =?utf-8?B?R1ViZW81RVBteFhBZUdHKzBHTGNVMlE0L0ZmNEhUSUNQa3V3dm44TG12Ym9z?=
 =?utf-8?B?MURJUlZYYmV1Rmk3SVM1TS9hbUcwUHZ1K0Q3VEhqbm12TEZjWHJhUHdFN0ph?=
 =?utf-8?B?QW03bUo4VjJ3R0pjVWI2SkorMXJXbVluU1ZOQ2FYNkxGRXJCdTdZZHB4T1F1?=
 =?utf-8?B?NnhTU0lKQzBGWGtJM3hRdXRXUmZVWHdBWTdCaHR2K1FPVFZvV2RoOTgvUTNB?=
 =?utf-8?B?cEhqUjNQL2tuTEsrVXZVR2txb0p0bDdXZGI1OEswTzJ3Vndpc1JqSmxkd0M2?=
 =?utf-8?B?VHZ2OExZMHJIME9jbU9MNnBYOTd0blIvU1VhTUpHb3pCUVZEdSs3aU9iQW9Z?=
 =?utf-8?B?RTBhcEZUSlFtZURLVHpSb3ZiNmFNTitBaGNvc21adUQvRUdBUzJMRWpOcm9Q?=
 =?utf-8?B?bURaaWhOajh5RmVOWE1yKzN2WWRUL29ibmxOaVhsMXdyT1ZyOWpMMlovTDFu?=
 =?utf-8?B?K0VUQW1KUGh5YWg4aEc4bnVoNFJBQUJJSld2clgrVFk5NHNOSHlIcWRLZ1B1?=
 =?utf-8?B?MjZMU0Z5dSsxUldzdjhrQ29XNzhHZVZJR0Fuenc4cmxSYjlqTzMzVnU0Nlkz?=
 =?utf-8?B?RzJ3ZHFZOW5GaXp6M3NnM1RoYzNQQXhWcVdtcjdxZ3U5U1NRMGxPa2VPYnRq?=
 =?utf-8?B?NVNSaHlPQmI0ZW1wMUtBVlpRMVR6ZGE5UGxSdWNRTHRaYWpJNWI4eitCQlMw?=
 =?utf-8?B?eTlGTVp5L1o0dnBUc29WYkpDVkhKRFgrRk1tZ212eUdaeFdSTTNLRDJad3JY?=
 =?utf-8?B?NFNrQm9IbUNNbVllTWgwVUxuM09iZjk1QTZvV1NmOHcwZjU5czBKTlpYMlZO?=
 =?utf-8?B?cVdiM0dMc1U4MzNqeUl0M2xOQmNsOVR3Uk5NOWYyZzZRYUI2QndvL0NMaG1z?=
 =?utf-8?B?bHVoZGp5cFR5ZUZkUG9DcW9sc0ZibytyTTVjaHQremQ2NHA2MERsaGJmalVB?=
 =?utf-8?B?TnZPVU55eUw0ak1mQktkak8yOGtpcjZjdXdHdG1LMmdubE5jalNqWFZHWVph?=
 =?utf-8?B?Q1p3aXFsaU8rSG9zSW9MekNEM1VCMHl1TjM3c3NLZk5Ga2RhR1BkUFFINDNo?=
 =?utf-8?B?YW1VSUlGYTk0WkxaVWp4SlFLRm1lTWJOZE1HVWMwN2xTVW1FamYzQ2lkL3RY?=
 =?utf-8?B?TEU2THd5dzdYYjRHTDBFL0ZxTVl0R2JRK1YrdjB1NXk3L1FtNjNoNUpqVnQ3?=
 =?utf-8?B?alJuZVNROTh1SENWYXR6R2dGczEwQ0RWK2FlS1dYY0p0d040OUlySk5JK1lR?=
 =?utf-8?B?dFZPTjBVeGRza2h0bXg4Zi9OVjV0K0pDWExKZ0svdEpLQ084SnRjWThqMUIv?=
 =?utf-8?B?NzRFeWxuYzdLcTEvSjdzL091S0xEdHQweHROdlN1Wm5veUcrSG5hdXNwTEZC?=
 =?utf-8?B?a1VXT0JnNzFwTDdDUDBXendWdUxCZXNJMWdTUWIxNzkvdmdGRGZpNW5WN3Zk?=
 =?utf-8?B?UmFFOWkzbHBDdEpRdG40OGtEQjZiQ3JudHlFTFphenhRRWpwYU1ON0dYZVhl?=
 =?utf-8?Q?7dVxL+O+t7dgILMnsTotbfw+ANiJ0frHALvTSFa?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ccd817-cf07-484c-c646-08ddb8c15280
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 17:04:21.2668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4186



On 01-07-2025 10:33 pm, Johannes Schindelin wrote:
> Hi Aditya,
> 
> On Tue, 1 Jul 2025, Aditya Garg wrote:
> 
>> On 01-07-2025 10:11 pm, Johannes Schindelin wrote:
>>
>>> So the trick is to call `git config set --global --add
>>> credential.helper ''`
>>
>> I wonder if this is a bug in git for windows?
> 
> No, the actual trick is for me to read the manual page myself ;-) The
> option is called `--append`:
> https://git-scm.com/docs/git-config#Documentation/git-config.txt---append
> 
> Ciao,
> Johannes
> 
>>
>> PS C:\Users\Aditya\git> git config set --global --add credential.helper ''
>> error: unknown option `add'
>> usage: git config set [<file-option>] [--type=<type>] [--comment=<message>] [--all] [--value=<value>] [--fixed-value] <name> <value>
>>
>> Config file location
>>     --[no-]global         use global config file
>>     --[no-]system         use system config file
>>     --[no-]local          use repository config file
>>     --[no-]worktree       use per-worktree config file
>>     -f, --[no-]file <file>
>>                           use given config file
>>     --[no-]blob <blob-id> read config from given blob object
>>
>> Type
>>     -t, --[no-]type <type>
>>                           value is given this type
>>     --bool                value is "true" or "false"
>>     --int                 value is decimal number
>>     --bool-or-int         value is --bool or --int
>>     --bool-or-str         value is --bool or string
>>     --path                value is a path (file or directory name)
>>     --expiry-date         value is an expiry date
>>
>> Filter
>>     --[no-]all            replace multi-valued config option with new value
>>     --[no-]value <pattern>
>>                           show config with values matching the pattern
>>     --[no-]fixed-value    use string equality when comparing values to value pattern
>>
>> Other
>>     --[no-]comment <value>
>>                           human-readable comment string (# will be prepended as needed)
>>     --[no-]append         add a new line without altering any existing values
>>
>>
>> Or you meant by --append as per https://git-scm.com/docs/git-config

I thought so

>>
>> I anyways manually added `helper = ` line and now it works well! Thanks a lot.
>>
>>

