Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021101.outbound.protection.outlook.com [52.101.76.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B022D97B9
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 07:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776757161; cv=fail; b=MOHZUuooJdbhZtAQiPVYTr3o22IFKcpiI1DdflfqDFVj5E2q5xaDvirA+xnAwluyPe8wGhODTwMu2TzcXcnEIpTyg7doPlFIH7gt8MX5kGRkYSTAnBUWPpuGFDhClmlDuSgKZ3Xi3tFH7DrqeDzopDPR/AGGWY9qy4FUxC3ptcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776757161; c=relaxed/simple;
	bh=NqHetpyUxeyX/ihMdSvBNeBM4Ky6fBB69bqXJ0njPK4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p+KCoENyKe6onxgrCZ5Gu13mIABKsa/mVLkF+1N6fj8/fFIfgaLnvtrY8NdyOeoUOECf/ram9DW6z4z0o5+4kGKjtDwK4IqN0HUaYt4B1CAUCBqmFIgv1haEgMueAaUVG6xiLBdrBgzkX9i/7ndM/5CzPVvn+K8wxRxSyCB1ISI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sunet.se; spf=pass smtp.mailfrom=sunet.se; dkim=pass (2048-bit key) header.d=sunet.se header.i=@sunet.se header.b=ZNZN8o4h; arc=fail smtp.client-ip=52.101.76.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sunet.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sunet.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sunet.se header.i=@sunet.se header.b="ZNZN8o4h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SStesXjUAyQlgVtuWQWPi0yATq7FVQ7a2OkwrCibj4ry/wXd5mZ3f/4amNM0cQRzsmYuC+3ek5lTROEkkZoiP1h9ipuCgtvK5fYkNH7JjFYDOjFvs2grxwTvUobuQweqqb06XzWnSB1zpDjPWSs9F7FPFeY4Fh/65PCz0G5D/bC9ClWbz6NyE/Iy7YUDh1ussUfhmFS1wVsv4hEQQvjmauf0JhTvvk1I+QSSCjktLyeRPDu7Sn+qx0a0v5EV5hJlP7c2zcZlAVk3dIAOZehkTCOidGb6rZsyN0lCFWvZh7Z2ckbCBok+4pVYDCzpHzvfeJ+EqB8R7lhVdJ8A5Z6Ysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ke1IH6ZehECeSxu3ees5885hnf4KQPC10+9u+Uji5k=;
 b=TjI60Jb2wW88UmTE/5BqdGR321N0ethmn3IIeNNwQVZsLYEp3oKu202q8pXGRPt5Cn813B2OcC6UKIhlAa5PhmTwXV/Oqz35xlb3xTxIfOjcZFNnjDukMV9V3UeIJVlBj7DUCdHY1xkmEDB3DuM9Xv4n+Hin5mGPngDe2fXe/cWyy8u5b/1hnyge3eQrPKMKO2UnHc5jepmvoQxjB31fLGHEt35Hhc8rG3nfVWocwP/I2RglFbx9yWIce1J4ykSwBsOhDlydZEsPHqBbFbTU/3t0mm8rQb1ThfJxgAnm5Kll1GXiQlqU9xsm8tD1Fbec9QyQvQZ9GtbyySZrgMgNRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sunet.se; dmarc=pass action=none header.from=sunet.se;
 dkim=pass header.d=sunet.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sunet.se; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ke1IH6ZehECeSxu3ees5885hnf4KQPC10+9u+Uji5k=;
 b=ZNZN8o4hNkNnK4IoR52ktob6n3sqG1xTiaXydnyn222XGs0ZLgAt+ioduh1/c2j1IUeuM4XxkBt1MRL4p5LSlAUeKy3E/d1Mvwz2avXDnbzZDrXd/Knkto+bM3CK0SdMciLaOp/p6iiIHP/9S/1k5MgO/ZlU4Ixve9nqGjeA6huaGgfFp3T0G9RBDa8arH2JX+kPilXx2yl97ldrQsEIghQwgphOTmL57T3qjsi+Jr49LohR6Wd6MVbuZrfD9yPcRVXTxvNmKGvkxmnoT2Ob13klghv05Mce8sY3arGMYIryDodnSOO0t+ytGGpGMEqsgN6jAlWa54UTPQXj1t2QIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sunet.se;
Received: from GVTP280MB2179.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:370::13)
 by GVYP280MB1974.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 21 Apr
 2026 07:39:12 +0000
Received: from GVTP280MB2179.SWEP280.PROD.OUTLOOK.COM
 ([fe80::9ab4:ee3a:7036:5a27]) by GVTP280MB2179.SWEP280.PROD.OUTLOOK.COM
 ([fe80::9ab4:ee3a:7036:5a27%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:39:12 +0000
Message-ID: <c0df6dbd-47f9-4a2d-b68d-cb0c1e19ca5a@sunet.se>
Date: Tue, 21 Apr 2026 09:39:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] v2.45+: git commit -S invalidates signature for non-UTF-8
 messages
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <4d5d04e2-49c4-4781-a289-f8cf79570643@sunet.se>
 <aeakf0xcjSteTMZp@fruit.crustytoothpaste.net>
Content-Language: en-US
From: Kushal Das <kushal@sunet.se>
In-Reply-To: <aeakf0xcjSteTMZp@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00023A18.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::21b) To GVTP280MB2179.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:370::13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVTP280MB2179:EE_|GVYP280MB1974:EE_
X-MS-Office365-Filtering-Correlation-Id: c88dd3b9-ac4b-4254-372e-08de9f7914f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|786006|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aJjCrvpXkdApdzI8R20mX5syHLo6H/unqlkMYR12ZKb2ONNveWlR0RVcXpRQyV/fJUQPeqOvol2hJnHkdO8Ehm/j5PZnYuc13fMsr40k6eA+nyyDmff4XTYVM3I6SVTstOn2AY0ew4pLZDudoHaMlkdt9Nld1MFktl89k/g72fq3Wjc6nemxt/BYS1jhfN8Nms1QKvkzkrQXEP7rf+ZTcTyvQk9gvsF7mLv5x26InaMj3elAS6y+69YvuVIJpOahPzMgaCZUAKWezx5oSS8G0mot3hrpUq7F/tzd3IYEhioFeILMN3tLr6RbNnuw+KtoEEWHYsfJsOIC5sU4wd4Y9sUivwvh+aePs9lVcNleJaPEtK6+X+KnheYObhWUsCnnmDd3V4ASq4S+sWiJriI2X+aTVGf2HkGwOgoMcdxSshyCbgXHcGIjOzSHNQKJW/NStRTUy8Xj9fIHvRdlWlAWKBNXUP2/AJhpkGybAnwwPLEaEjApSQ7YLFen67o516+qZ6Ggr8nlTSMG9lc+eAkUXKpcT2vcdfc+ehCoxSPe92Qx5GwThyhAljQfvqvEJ6sp8WqKEIPMQoxttfsT/zvpHfOxUD5qB835thANkXF1DqAJNN5lLIOqJqrCkb2IQh3yJnLOMphBOKCI3tqrU6jarPtB8blM3irvo+k17LO6jrXlF7n1U0xTlLs+t6AQIMZj3b0h4mW743adBoKHgpRaPCGyxmrtw9OTJInvg38dESk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVTP280MB2179.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(786006)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjRPRE1Db2pNNlFoaEc1T3Qxc0ZzS3djd204M2plTi9tWnJUNnNMcyt4TnRU?=
 =?utf-8?B?ak45YU4rRXFvTiszV2NFdy9LaHpJcTRlNCt5dUF2OXQrSHlFNkdUOTRFdGlh?=
 =?utf-8?B?UDJEUmNnK2VoRnFXbEs5a3ZxT1pEZHVCTE9rWVE3TFBRbnRBUlFmWi80dWJs?=
 =?utf-8?B?OTBzdlgzUUJZV0R0czE4NlZONDEzSi9vc3RvcThMMmRreEJtTUxVdTRjVWtX?=
 =?utf-8?B?ODFtNDRHaWtVUWp4YkwwQlR3WGlQMUpTQ0ZlQ1pkaHUxdC9JcFBXMEpWTktR?=
 =?utf-8?B?TE54L3RLQUJ2NEl2a3VjaEZFYWIwQ0ZMQUZERkdjbk5lWWViWVR3dlFZbW9P?=
 =?utf-8?B?b1J1eHJwdnBHZ1FTOTlrY2oxM1NPWmJoUVlmWmR6UlgydWZHQWNSeVM2SHJC?=
 =?utf-8?B?bVViWkI3dE9yQjlKZGtKcm5QTDVGMGp0cjhLd1NOUjlwcEh5Z09QVms2VHlY?=
 =?utf-8?B?UnlkSjdQdHJyVXgzL3pQc081YWxUTVprMFBpM21OdGZlNTl6TzBwU0UrWmRQ?=
 =?utf-8?B?WFFEL2R5Rm5XQlo2Q1E5emtQemhrdmUwUU8yVWJFY2hRWTNIWHhodkdsS1V5?=
 =?utf-8?B?ZEpiYy9mTG9HQ0FLOE5ZMzdsekZyR1BOeGtUOVNMR3dnaVQ3RHdYR2EwM2tQ?=
 =?utf-8?B?c2ZnVTlZNEU4QXVnUGNGc0JZc3RVQVlQZjNxc2gza0srVHRZWkpYNjFsVHc3?=
 =?utf-8?B?Ym5TSUkyQWlmazYyRE96bjZvdmFjTGlaK0trZHZjUzUzQmZqU0lmNFZFWVlJ?=
 =?utf-8?B?S2NaTmIwVW56YU13QVhLcVRNdXVlYTJtQUZ1L3lrcGNVWUlQZXkvNmpSREFt?=
 =?utf-8?B?c21DSEEzVnhVS3BwbGNQOHM5V0dTSk1JRzk5Z1UrZzVvVVFoa0toeHgycDNs?=
 =?utf-8?B?WVdTU0drREZ3RTVjc3NGYUNvUkhXVzNCRDdjODF1L3JJTFFoU0tHUGFuUUhZ?=
 =?utf-8?B?RWpjOXZNdG1OTXFPM29ZSFEwNTRVeElyL3FiVUgvY0N2Wmc1YU90T0IyNVlU?=
 =?utf-8?B?MW1hZjhUanBSbWxUdXhRZjY1RmVBZUJzRVF4ejFxb2RtQlZLK2NpVUVpMkZ2?=
 =?utf-8?B?ekJsR2Nzb3hnUk80V1EyNTdqQTFmNHhsRHFTaW5hcm5HSm5VdWRHQkZ3QlZD?=
 =?utf-8?B?QjgzNzIxVGQwRzU4RG53UVpJN29oMXBpNm1qUEdUYndsUDhWSjM5RlFIVmJh?=
 =?utf-8?B?TFduYVVNTGhKcGVrSEgyQzZPZ3JId2lkU045Y0RDWmU4Y3BHbjZaRlpxTVJk?=
 =?utf-8?B?NG1pZFIwcnRtRXBMbTF5T0QzZmNLek1jZ3hWR1Rhd3FrUVZTTUtETGQrNXJt?=
 =?utf-8?B?RWhKZnhOMUZaYVNVNVBSN0E4RVMwZnlyRzBFbzV3akpmc3NIRXowNFdlRUVT?=
 =?utf-8?B?MGlreWxLT2kzMElpU1J3bEpzK1Qwc3kwdStVWHhNQTNpKzhsR1pGVXBDVVZ4?=
 =?utf-8?B?QUw0RTdDQ3BVMmJBa3ZZQVgyVDlkc1Nmb2NZSWhNNmZRN3Zyc3VzZnNjWHZm?=
 =?utf-8?B?ejMyVUxka05KMGhCOXRUSjZCRzBKK3BvTTNnMmsyVVVlT3YrM1FHK3g2bWRl?=
 =?utf-8?B?VElMTG9Tb3JISjUvWUlQZmJkOXB4QnFIMm1QZnVSb05CeE9tdTlPSHBabnA0?=
 =?utf-8?B?Qml4c2lQT1lCOWU5QXpyWmpOckNpL2N6dFdLTzZ0L3JRQnI0RDlYSTljbU1u?=
 =?utf-8?B?Y29xTU5SOUI3ODhZLzFzVmlKN3JSQ1VKZy9hUmlCMDdMTUd0WUpqY3ZnejMx?=
 =?utf-8?B?VVFXN1Zzd2hZT21TbkxKNGw5ZzRDR3dNNlVMeUJVQlowUi9zTHBYZUNqMHdG?=
 =?utf-8?B?cTBMUElXWEVBWU9ReUZWWGJTTjYwRm1oU1A2dzQ4ME9mZktsK2lmWXRuNVJW?=
 =?utf-8?B?VXA4WXFjMEZFMkVsRTJLMlBiUlYwYXoxOFlnZFJVdjE4VWlRcUdhc25GbTEx?=
 =?utf-8?B?WGEvSjRCbE4zU3phV0F1WVQ0cWU2Z0g5dU4yY3BBRHdmbFhOaUx2NEhDQUhZ?=
 =?utf-8?B?YUpOeG5zdGxQUUxVNE5zVXU2RXp4ci8xTXgrL09OVldUMGxOMm5YL2xpSlVr?=
 =?utf-8?B?VnRuc0VZUWdXb2xDSkJWV2FBWExzYU16SXNXZEZSaUFqQWw4ZUh4MDB4cFRY?=
 =?utf-8?B?L2hnbHNqdGg2dDRVV2J6bGJoY2swZUFRWlE0Wi90K2pmcXpOMFhiK0YwaTVJ?=
 =?utf-8?B?c0xvQmgzd1M2R3ZNbkkyc2NETkR2YVlXSm04NExGbWsxcFh5UFhuWVZPTE9v?=
 =?utf-8?B?bGJhb2h5Vi9RZVEwdGNpODRTcFVOc0RVcjFaV2RXWjNHQTUvOGd0WGRlN3pV?=
 =?utf-8?B?S2g0N0VVcHFKeldXMkpvWVZEZDRjV0N0WmNmWStHVzdBSGxleExUQT09?=
X-OriginatorOrg: sunet.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c88dd3b9-ac4b-4254-372e-08de9f7914f7
X-MS-Exchange-CrossTenant-AuthSource: GVTP280MB2179.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:39:12.6076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: beb73af0-54c3-4c95-886a-3e6de3a76471
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcW5dbCuRxkkxIh6Y6XKdJqmUvWUflX1Cxo1izxsQ9xOs/KmFQeVfXKJ0vw4Fxva
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB1974

Hi,

On 4/21/26 12:11 AM, brian m. carlson wrote:
> On 2026-04-20 at 08:59:05, Kushal Das wrote:
>> Hi all,
>>
>> Every `git commit -S` since v2.45.0 produces a permanently-BAD
>> signature when the commit message contains bytes that are not valid
>> UTF-8 AND `i18n.commitEncoding` is unset (i.e. the default case).
>> Verification fails under both `gpg --verify` and any non-GnuPG signer.
>> The failure is deterministic: it happens every time, on every
>> non-UTF-8 commit, no card or external tooling needed.
> 
> I'm not sure that's a valid configuration.  The commit message either
> needs to be UTF-8 or you need to declare the encoding so Git can convert
> it.
> 

It is not a valid configuration, but I am guessing there are more people 
like me who never knew this configuration and just freaked out by seeing 
bad signatures over own commits :)

Thank you for quick fix.

I am also wondering in the test harness for git signing, if you want to 
include other tools than gnupg for testing.

Kushal

