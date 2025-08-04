Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011034.outbound.protection.outlook.com [52.103.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC12231839
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 19:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754336749; cv=fail; b=ZLbSwwoLHEGO7jCa6FV/2vK50atnHk7SItKobhnbAbvCyuHURtsKtpx9ZYrH17zRfQARWzKXYzz4ROpIiY4ZSLSlZ9hVWjRu+S/Sg8wNuWle+2lxARdACdWrpCtiB/1DhTMplfQ+buAX82U4bfws4wqb62JQpyiSiWHGeiPO7NE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754336749; c=relaxed/simple;
	bh=9N742zVgrPwfB95BdTEH5Iwh2BKVDBRIUa3unecqevo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=B5HqagnfypyfsR+3ibXZIyoVSCBfgd/Jc9KJjXBl7DrAO8GZM1Tul4/cd9+1MhaiULzL+qR2BnFP35SrGV7vhoo4AoRKH9nn0MJEOD0KORP8IXIm92Ke+CpIcLKR3olB7LLjMErWkcKf9n3Dg8o2Wc/nljBPir4fz719FaTO//g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=E5I/7MPv; arc=fail smtp.client-ip=52.103.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="E5I/7MPv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QaTYfUAGxmGYmni6LPrgEtlbr2yQ9P69RhG3nMFuZwulNewEWGTkLN80FQFaGWm9QuGSOwhRiMUeHG4BiNhlpgIylDbADGphPVdCJeByPDYz+75mu4u04cEPhX+RRXBNP/UtEzFNoyCNZ4UGB5QMbzuG6qoaBMT9/YfX8JpeAwsHCegwnzpPk0r1RJnjWCB+tc0SddvhGcRM9tOyk1k5D8mD5ywEAISm5EcsX/L2ZCyOUak9gGDLIPgaVHCutyqJ6Hn4lKvjWD5edh3PzUvPksmQjYW5cfFZi8233TOypJMh0b1p9PLjwrcy19ZSFtTvCqSUtevl52A0AjJTohB1Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zm2GbzKK0SUxMtnGK0/c0wn0y7/aPcq3esxtZHKkAPs=;
 b=uP4ynYYPx4mjBt6LLN6D77OI5zFg+fgNP5J81OZyadpwESgIBkvCu//vAKAUdU1YZXS/L3ranFz5fXOh9lHSWCibI4gf9NBgDEQiT5SI79FeND3WoL51ds2cYJWWgdy9qYjK9bYLnv4KFLTnj8vU8ZvVNorIxnOszglQM5We9QSiNuN0AyxiR+rKUE6XczLq3g/ZHQBkYkZPZPvhJiD17LUlgCY21sgpgM5AZkBtUKwu3ErSvJSDNL3dezxqpKKsm2CNN715COsYsHn6h6N/Nefy159rrOBYoXHXQXLzHt2sOTPqYQFRXpek8hxBIfZgMJA7o6Uf48BeqpDK3ECqWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zm2GbzKK0SUxMtnGK0/c0wn0y7/aPcq3esxtZHKkAPs=;
 b=E5I/7MPv8ZIZnsxHzFtB9E0An9hjWTel+ybdi9kX8JRTilqCEV/ak/Pc/+9UbOkmd+GEtCg2TB+ie3hye6EGeUZUGq95hjVSrtKkvOgrCwBJeJuy5Hgfi2tfHv3flif1dpY+bwXW+SEMZ69FNMC0DKrb2T8ADwcjOleu7ogXzkNkln34IJJfcO4VB8NfpnHc5rR6eytV+CUj5zw0ATe4eHbsl12X+WLuDZKQXkvx2cqiMeDV9igUMa0OvlvNfYwV8bkCaQXMAw7K46ckIdeIZxaJabSPRsryqdmPRDn7GZrUx6MACZXXlkGVaGi94gqXsnLRvm73vTCybuGW+mzXtw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB8932.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Mon, 4 Aug
 2025 19:45:42 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 19:45:41 +0000
Date: Tue, 05 Aug 2025 01:15:37 +0530
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>
CC: Eric Sunshine <sunshine@sunshineco.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Ben Knoble <ben.knoble@gmail.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_send-email=3A_add_--get-sm?=
 =?US-ASCII?Q?tp-server_option_to_fetch_SMTP_settings?=
User-Agent: Thunderbird for Android
In-Reply-To: <DBTME8R0DCOH.2E8WOTO3STJ4L@swagemakers.org>
References: <20250730151227.12389-1-gargaditya08@live.com> <DBSU01804YQB.2JA3KHG5FDV55@swagemakers.org> <1ABB6EBC-7CA0-4108-94AC-F38E96BC7673@live.com> <DBTME8R0DCOH.2E8WOTO3STJ4L@swagemakers.org>
Message-ID:
 <PN3PR01MB9597F827535A46AB78988642B823A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BMXP287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::29) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <152DBA52-F36E-4C6D-8AB2-907F5FF80E1F@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 740e9443-bdb1-4b2d-762e-08ddd38f7e9f
X-MS-Exchange-SLBlob-MailProps:
	30ekHghIwFqaH0tvbveIA/eJwtvhOZkhCileZ+ymGKGC0sNJKcskYyIDi+b+1YiCK7XSF4FKsUnJwDCDiNIzjs8b9zaZSOv4FG00/mJCpAIoLhJ9IrudLYNyGP1NohaOmwbSApn35J5SRCQ8XvBGDwHI+Xm6VPpPNgGEnWmMiw12lbtWY4t14RdksnesRbDHGZiMG3m3aBXq/UJlkC/xv/JXBRz801OlkJrAsXecKHLuTOkRLZdTft1paIQxJgNGLS89d3zZ2O3EPFgBAKtmbjPseS4cVuNEZMu0vRb5Z1eJ37SB/oFtIL/Zgjx5VPFvnW9N8o1fm8Bm0y9NHDLR1ulWKVozc3PuG0wSkFUG2zncGpcDgfKew8XfnyvhYeGGUdkOaAHVAFWFb3+sZfqYorf/6j+8niD+zrNzRHg6g6+lBBM+9XzPaH90A24gpu534ZqoeB750oYLdbQmkFkv6ojGMlgYmBvhrIyNjfWoC/xWHgSmLxFxDMjLQJ3feNPq2WAjL2yKtt6mvD8e7+YWUYUMOM2rUxuw7L+G4QeQwG0Y5drYbbqx4qVP2ogk6N662FrE7sFFWJk8rKi5narNHtdO68/lVd8NmDzneDBoMZraiiaoLsuYqAd2qlXYVr7upEwbKR4uamIM71h2kv0x4+KMPsLp2EG+qNFHiHquZHZ+PPS3vRHcdqLgvYrWdp0tsUveLsPD6TT3v6S1vY/jmdLyV+Pso9ZO71xLU5bYZnTJVg9PzL2Hds2VjOUiXCZh
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|461199028|41001999006|8060799015|19110799012|15080799012|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHdvY0t2T1NHaHo5VE1HVS9zSDFURG1COGlvUldFeW1SREk0elI4dXE4ajIy?=
 =?utf-8?B?NzRnWm9XaExwSjNWc2xESGQ4ZVZJc2ExNUlSenFQNXNpeE5sbWNnb0xtMmIw?=
 =?utf-8?B?NDNSMVZmcEFLWnVLdHd4SkJzTlVGaU1NUmN4bWNMaWw2R0Qxd3ZaSG40OHFM?=
 =?utf-8?B?TWNmQ0d4SGh1bU5MS1g3WVFoSTlZZUk5SzVmU0V2RUtmWjF2M0tiQ0ViaFBI?=
 =?utf-8?B?RlFqaXhLdDQySS9wTElHTlRCTU54REhxYTl3KzFtZE04UDQ3UjNheEs5ZFdl?=
 =?utf-8?B?aTgwRU9hSzBpZUl3R0JvdkI1S1Vwdkxzd1pOS1Z0UDViRHNFT0xLQmNIU0tz?=
 =?utf-8?B?d0dLd0dDUTFqOE5MeWo4V2dFU01TaVQxb2dzTFFtdGs3dVkvVHZ3dnBSS05s?=
 =?utf-8?B?eWE1ODJ6bHZWRE9RZWZ3ZlVGRjcvZHNDMHBYcmFxbk92NEQ4LzM0YnVNZlpu?=
 =?utf-8?B?YWk1T3Bkb3ZQSzhtbWhPa3grZ3FQQ29USFh0V1l3djM5ZmJrOEptRlkrSi9W?=
 =?utf-8?B?ajdORXVOdE5wS2NJSmlSM0NzWGErakNMQkI2Y2J1bmFxTHdOd1BvUWdnU0hR?=
 =?utf-8?B?bHhGQThUYkV1ejRjTGo4eFZpZjBEYVpNZzZJNGdiQ1d1MGhWeFVXaGxXV2Zs?=
 =?utf-8?B?WU03blcxQk5CbzlhVDF5eURQdy81dWZrRjlHVk1mdHVZSU5hLzBBenNxWTBR?=
 =?utf-8?B?QjR1U21SVlpXWkFYbFhtaWxKQXJ4UitNSy9XbFlmLzhtQWdYdDQwMXBLTitl?=
 =?utf-8?B?OWNVZS9Nc3l3WUJibndmT0xwQVVubUdqTXFqamNESEVzb2FnUS9HWWt4dWU2?=
 =?utf-8?B?b3lFcXVFOUdkWFFnQngyaEtTZnZmZHhhMzZKZ2VEYjZFL3RTU09zZDBBWCtH?=
 =?utf-8?B?aytVeGs0OWphOEd5eHFaTDFZYmQrKzB1VEhZdmpWaEt2MVdmT2ZsdlQzVktC?=
 =?utf-8?B?b0hDVEFqRzRmelI3YW9HYUh6YzFZanQvRTlTcXMrUmxPUXVQVXdkYTE2N04y?=
 =?utf-8?B?K2lTYUJCS2diVmdKTlNMWFIrOWw1eThoKzFzN0dGbVNjblFtenl1YlBGbGo1?=
 =?utf-8?B?MGxMK1Fmd1d5NzFuMHloSFhlTHZLMWtmZ1JIMk1laGg4azhsVHI4aEFiYWM3?=
 =?utf-8?B?VW5zMFZIWC8zRUJPcGZTOGJndXVhajNhcHpDTjZwZlZhZmRIeGEySGJaaHhs?=
 =?utf-8?B?a1lLay9GUUtFYXNxRkdnRWhjdmRVQkJJVmswK3EvWmNsNW9KWUNXdmlSOWNV?=
 =?utf-8?B?YUpkbXpzVWpibzJCRHdLWmJjTVovM2Mwd1djTnk4eHJqZXpOWWFJdURWdkNJ?=
 =?utf-8?B?ME1NR3VKRTZ5Sm4yeUJoOFZ6eGxrakdrU0tCZTAwSWVwWTh2S09wcFMrM1cw?=
 =?utf-8?B?NXNhNTErREJZYlp3SkRGMlBIY3poK3NyaW1OL2xQaWQxanVZQUM2ckl2aUM2?=
 =?utf-8?B?Ymh2NWRnRm5FNW12NlFEOUVTcitKZUFvRU5CcUd4TFQ2YmNHak15M29SOWdw?=
 =?utf-8?B?YzNmVjEvdmxLbmxQckRwMTExT3UyVUZXTXQweFBPTGpUUTYwaGkwc1pVSlZq?=
 =?utf-8?Q?RadlK95Zy3fQZVvlIIasmlmhU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDlSb2RiNzlTTEtLVVR4d09jYWFMUGxPQ1RPM21NWVJhTGZJVGtOTy9rbVkz?=
 =?utf-8?B?ZmNlNVQvcC8zemZqdXo2eitHay9TYU1na1ppa1ZNU2lUZVdlcDhTenNGcjlt?=
 =?utf-8?B?MzdxbXB1V0JoekZoRUFkb1dtUVYxREU4cDU5bHJGc2cvVlIrbXhRV0VOWnVM?=
 =?utf-8?B?U2JmWUlscTBqUy9vd0dPemdiK2MxVmdJT0tDaWlwR1E4c3NBTGwrM3o0R2pU?=
 =?utf-8?B?a0ZHenpkUUlhSjJ1b0IwV3dtWFloZ3lpZEZoNkZ0eHgySzFMUDhlbnNMZi95?=
 =?utf-8?B?RDU2VitlZThMbkkxTXA2dkRLL3dpNUJmMzhHa1VpeU1qZ2dPbWtvRFUxSk5M?=
 =?utf-8?B?ZlVIQ3RmdjJ2SlVLM2FYYTcvUEFJSFExNDBTajhSZTJWNXY5L1RUTWdiZkVL?=
 =?utf-8?B?bGZGdkZHUzk2dUhjd1QxK0UyWEQ3aHAvczJvZ0VqSGtUa2dBWHk0eUxya3px?=
 =?utf-8?B?c2NJT3h4bE5ZVHQ3a1RxWEdhcy9sRzVmZzBRVGtsMElkYXhaZ09oellkck16?=
 =?utf-8?B?STlEUDZjUjMxeU9YQXpmZ2ROTVRpSWdMWjRRT0Nyd05vN1U5RHdsVmtNZGpJ?=
 =?utf-8?B?aVZhR3JENC9aUE1CUkNRSGt1dHNUZzg3bHpPRGN5Q09yZWlOV01YMFBFVzli?=
 =?utf-8?B?dzhqeVRoSmlWYjJ2YmtmeHVZM1hFcExhUS9jOE9zKzdaTDdMZG9MbTdPa3Y0?=
 =?utf-8?B?Kzgya1B0bldCeFM1MGp4RHVlaGVkM013ZExhcG9KVTl5VUlTUmhuNlJmVXRX?=
 =?utf-8?B?ZTNvVnB4TVdGWTZaNE1uaFNWZWhURDhtYmN1b29MNUsxNExrSFZIZUZNL0wz?=
 =?utf-8?B?QXUyaWgzVjEwVmJSVlVOblMvVTJsMW5ZRzVWMnNoODlSZTgzdytXVHdWWCtu?=
 =?utf-8?B?WVVua3RkU1lxR0dJRnZTYVNFdUh2NGtLWExxaWpkUXBXQk9Dak9FRlFQRk83?=
 =?utf-8?B?S25VMFNHZzJNckw2TnNZYUdSaU44QXNKTWkraDdPT2k3Lzd2OGtjR0tpRlZr?=
 =?utf-8?B?Njh2ZUp3V0FkcG1QaFNrMXhjam5KZWUzVEJud01kM3Y2NThxendCZzdjODc1?=
 =?utf-8?B?dzJjcVg1OEVTcXBvRmw1ZjZyZFlnc2dlWWpFQTZMY3J6OGpIUVpGSHFKdXI1?=
 =?utf-8?B?MHc3bzlnbUFpK3BOQlZkMW9zWDdYU1JmKzJvN2h5N2VkeEx1T2dhYzRnOEwy?=
 =?utf-8?B?TG5oZi9GTk1nMlZZdzB5Y0tuQVhNMGVxOGZNN3FETkFXM0s0cjBQWGdmalpo?=
 =?utf-8?B?WXhGZjBPa1VWVXpPaGtnOHNuYmp6ZGVicEV4VlZnVFNDWGYvdk5aRDRnVGF4?=
 =?utf-8?B?Y1RUYVFPSlU0cjBrR2Z0Tm84K0ViMzhqQVdyZWdQK2pSanNmRDRYbENaV0dX?=
 =?utf-8?B?QTAxN0F4K0hjczluWnZNT0RJeWhqc0F0ZVhOMmY0TzVUUWJyUXBPeXJrdDQ3?=
 =?utf-8?B?cDZlc2xOalIwSUtlaG5Kb3dMMWtuSnUzNHg1bUV0VkJqWDBjV0Z2Tk8xSTNs?=
 =?utf-8?B?UjNvc3BFZ205Z211UmRpUExrT3B4VTY0STNHZ2pOL0RZNU8yOE8rYlpqd3Bm?=
 =?utf-8?B?eVFwaThOSzRWMFN4WnZnMEdialg5YjlvNnhtdCtwU3JpTWJKSm5KU2dxRmx6?=
 =?utf-8?B?S2FZZHJ5NW5zbHpzaEtWZXp2TmxRZEZKQWtwSTlSRXRkdUQwVU5FTy9MRGl3?=
 =?utf-8?B?bnIzMEVYZTFkTE1sZU9LbFZOZDh0OXE5eCtQRjJwcXY0MjhpSDBOVW9VNnd0?=
 =?utf-8?Q?kgY8/b4zEyl5JrzpPF9mSpbp9vT5m0m8WMm+80g?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 740e9443-bdb1-4b2d-762e-08ddd38f7e9f
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 19:45:41.8212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8932



On 4 August 2025 5:21:52=E2=80=AFpm IST, Julian Swagemakers <julian@swagema=
kers.org> wrote:
>On Sun Aug 3, 2025 at 3:59 PM CEST, Aditya Garg wrote:
>> On 03/08/25 7:06 pm, Julian Swagemakers wrote:
>>> On Wed Jul 30, 2025 at 5:12 PM CEST, Aditya Garg wrote:
>>>>=20
>>>> 2. If that fails, it attempts to fetch the autoconfig file from the em=
ail
>>>>   provider's autoconfig URL, which is typically in the format
>>>>   `https://autoconfig.[domain]/mail/config-v1.1.xml?emailaddress=3D[em=
ail]`.
>>>=20
>>> The documentation mentions using `DOMAIN/.well-known/autoconfig/mail/`
>>> as an alternative to the autoconfig subdomain, what do you think about
>>> supporting that?
>>
>> Can be supported, but I unfortunately didn't find any email provider hav=
ing
>> that sort of server to test. Do you have any in mind? Nevertheless, and =
untested
>> implementation can be done.
>>
>
>I also don't know any hosts supporting this.
>
>>>> +sub parse_config {
>>>> +	require XML::LibXML;
>>>> +	my ($xml, $email) =3D @_;
>>>> +	my $parser =3D XML::LibXML->new;
>>>> +	my $doc =3D eval { $parser->load_xml(string =3D> $xml) };
>>>> +	die "Failed to parse XML\n" unless $doc;
>>>> +	my $config_num =3D 0;
>>>> +	my $smtp_encryption_config;
>>>> +	my $smtp_user_config;
>>>> +
>>>> +	foreach my $outgoing ($doc->findnodes('//outgoingServer')) {
>>>> +		$config_num++;
>>>> +		if ($outgoing->findvalue('./socketType') eq 'SSL') {
>>>> +			$smtp_encryption_config =3D 'ssl';
>>>> +		} elsif ($outgoing->findvalue('./socketType') eq 'STARTTLS') {
>>>> +			$smtp_encryption_config =3D 'tls';
>>>> +		} else {
>>>> +			$smtp_encryption_config =3D 'plain';
>>>=20
>>> 'plain' is unencrypted, I think this should be accompanied by a big
>>> warning.
>>
>> Any ideas on how you want that to be displayed?
>
>How about something like this:
>
>    Found SMTP server settings for example@tiscali.cz:
>
>    Configuration 1:
>      Server: smtp.mail.tiscali.cz
>      Port: 25
>      Encryption: plain
>      Username: example@tiscali.cz
>
>    Warning: Encryption plain is unencrypted!

Looks good!

>
>>>> +		}
>>>> +
>>>> +		if ($outgoing->findvalue('./username') eq '%EMAILADDRESS%') {
>>>> +			$smtp_user_config =3D $email;
>>>> +		} elsif ($outgoing->findvalue('./username') eq '%EMAILLOCALPART%') =
{
>>>> +			$smtp_user_config =3D (split /@/, $email)[0];
>>>> +		} elsif ($outgoing->findvalue('./username') eq '%EMAILDOMAIN%') {
>>>> +			$smtp_user_config =3D (split /@/, $email)[1];
>>>> +		} else {
>>>> +			$smtp_user_config =3D $outgoing->findvalue('./username');
>>>> +		}
>>>> +
>>>> +		print "\nConfiguration $config_num:\n";
>>>> +		print "  Server: ", $outgoing->findvalue('./hostname'), "\n";
>>>> +		print "  Port: ", $outgoing->findvalue('./port'), "\n";
>>>> +		print "  Encryption: ", $smtp_encryption_config, "\n";
>>>> +		print "  Username: ", $smtp_user_config, "\n";
>>>=20
>>> The new option only gives you the needed SMTP configuration, as a
>>> user you still need to apply them and to do that you will need to
>>> look up how. We could help the user here and give them copy and
>>> paste commands similar to when trying to commit without having an
>>> identity set.
>>
>> Git allows you to set it as global config or repo specific config.
>> I'm not sure how to give a copy/paste command for different needs.
>
>How about something like this:
>
>    Found SMTP server settings for example@pobox.com:
>
>    Configuration 1:
>      Server: smtp.pobox.com
>      Port: 465
>      Encryption: ssl
>      Username: example@pobox.com
>
>    Configuration 2:
>      Server: smtp.pobox.com
>      Port: 587
>      Encryption: tls
>      Username: example@pobox.com
>
>    To apply the settings use:
>
>      git config --global sendmail.smtpServer VALUE
>      git config --global sendmail.smtpServerPort VALUE
>      git config --global sendmail.smtpEncryption VALUE
>      git config --global sendmail.smtpUser VALUE
>
>    Omit --global to set the configuration only in this repository.
>

I will implement this.

>>> The XML file also contains authentication details, what do you think
>>> about processing those? That would also allow adding references to the
>>> documentation in case it is OAuth2.
>>
>> Honestly, app passwords remain as a preferred way to use git send-email.
>> Outlook I guess is just an exception due to obvious reasons. Plus, OAuth=
2
>> does not tell if the Auth is XOAUTH2 or OAUTHBEARER. Not sure if its wor=
th
>> adding here. I am open to ideas on use cases though, and may try to
>> implement.
>>
>
>I was thinking of something as simple as rendering a message if oauth2
>is one of the options. Something like:
>
>    Found SMTP server settings for example@gmail.com:
>
>    Configuration 1:
>      Server: smtp.gmail.com
>      Port: 465
>      Encryption: ssl
>      Username: example@gmail.com
>
>    The SMTP server supports OAuth2 authentication. If you want to use OAu=
th2,
>    please review the git-send-email man pages for more details.
>

I think this will become crowdy if there are more than 1 configurations.

>>>> +	}
>>>> +}
>>>> +
>>>> +if ($get_smtp_server) {
>>>> +	require URI::Escape;
>>>> +	print "Enter your email address: ";
>>>> +	chomp(my $email =3D <STDIN>);
>>>=20
>>> Someone sending out emails will most likely already have set up
>>> `user.email` in their gitconfig. We could just use that instead of
>>> prompting for user input, or at least suggest it as a default.
>>
>> Suggesting as a default is better then not prompting. Although I think
>> it won't be easy to read the config since all this exits before the conf=
ig
>> is parsed (I guess?).>
>>> If you don't have an SMTP server configured then `git send-email`
>>> will default to `localhost` and fail if you are not running a
>>> local SMTP server with: `Unable to initialize SMTP properly.
>>> Check config and use --smtp-debug.`. I would suggest altering the
>>> message pointing the user to the new option.
>>
>> "Unable to initialize SMTP properly. Check config and use
>> --smtp-debug. Use --get-smtp-server to get the correct settings for
>> you SMTP server if needed."
>>
>> What do you think about that?
>
>Looks good.
>
>Regards Julian
