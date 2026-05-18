Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011039.outbound.protection.outlook.com [52.103.33.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6126B3672A5
	for <git@vger.kernel.org>; Mon, 18 May 2026 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121195; cv=fail; b=Im4EysvR5G6p4PMfZozJTLUxWMxBTor1wnh3fsM+D3ldLdScB7W7dUjLFIYh4rh3Z6x6/N6PS+pzo0ZSrODyOqhAfJy3PTDwVHE8wNAG5xhzBMI53kIh/xNzjq29r19D3tlX34REW3ilrE6Zq4BqOHqh+SZpjFqzLAGD6hfz040=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121195; c=relaxed/simple;
	bh=TVvBFGLk7SlGyuRzSYqXPWARjHTgV4GjxPGdW33GmXk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pxQhCV5GR15Twqbiii6P6W5rDFL0q2buZEZwRbVR3uic8JOh16HdcmzKLs3MwaUejQnrt31/z5y0ojz/nJ2pFC7BlUHkZXCeKLfxkMtRVRWaxNI70qX+v6gCA9UkiAy1kfZ+ugjbw5+A98g5/b1/Ay4iTgK4VUJnLXDYxuGu++k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aQusm4bd; arc=fail smtp.client-ip=52.103.33.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aQusm4bd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjH9POkiDaZZAJhdWGqEKJ7mpgh7K08BgpnSogTp3Qb+A59WuVo2H5HQaJJmS9y2hCsi0NixydKmg71zsyL5+O4I+Fa2WaZDLV0/iDwC5gHLafJOEuhWGn0LWWtp07TmmcefXTDVuoLA2ytBYCUXxrdM2aHGj5HZCQz7M4REyJDI4+Gd/OfsUfM29bOle94eDygvu17LUVkGEuhhpM8hO2jdgn1LKz/bFFyNifKkh4zNpENjvjlqXy808ZVJz8opJJ7n9geOvSkljfwv7UeJR7WhE7AY9n8rTpEWaPWTILTMP7m2GoPRr033nJEWLHAVi5m8WQZvZzYRDmOSMcNU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GA5lKQVCQ15dxhIf0kuVPxEd3F/jfALfZiz7igpuOYk=;
 b=nVtW4ZVZDnwOB0sHoGttKzjoDmcn2ulDa//wA4xVFmSj/ce9Q1IYIWi194TriWHCvasRsDWWVA23uitYNRws0RIOeatEg0wWTRLdBEto23yz5/anFCCpSlUJDkOgGAdtIm+KLm9Jug1BsC6GZ78e12U3VEsG3N1p5aE2UO9sS+Hnudh5Owjs0KdLLxAPp7KAfmHRzqtAGcZ3UoHPBpl7oHppxQq00l5NyhDhhcivSlHsb7wM9jZXa2OHG8X20kUSRW54A2efOY5I1aDXuT3+DGuWSwznzJONILixWJCvp1BH8TLrgGT+bwI5O0WY8JpuSFA5atGvtvjhxDfo5UOIZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GA5lKQVCQ15dxhIf0kuVPxEd3F/jfALfZiz7igpuOYk=;
 b=aQusm4bdXDZGXnFWJYL7L9PLarmp6YGfcSu0E29/E3V7ms5VDu9BPtVKYf2QGqJY77HGjzsrhLnc/N55cPEB2knnLrHiqZZEQ3Y4cf1XdIjmxUQuPvpaykpFJDqg6Bcsbe1N/LIE8n8bQgH3jdCuzowxEs33itF2gJqMR7R1PRGaaz8HyIGXXKJccmHbzIkLkGh2rSwxXzs/+8/QCeYl9nlu0qeG6UZmrUtudDe6gwsT4g+G3RqsGcKcOnB+1batYXpC6PL+nbJ1UZGHMBUb2w343tRV0R2Qt6cSBhnurHEI7SZ0wyHOHO7jWz2v9hgOTiDXehbwMyxvTUW3I9ogNw==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by AS8PR03MB9935.eurprd03.prod.outlook.com
 (2603:10a6:20b:628::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 16:19:46 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 16:19:46 +0000
Message-ID:
 <VI0PR03MB11634189E6F42F47E58C88318C0032@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Mon, 18 May 2026 17:19:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] t5516: fix test order flakiness
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Derrick Stolee <stolee@gmail.com>
References: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
 <7409a479d67eefed4b8958be83c55f8636233b4f.1778762495.git.gitgitgadget@gmail.com>
Content-Language: en-GB
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <7409a479d67eefed4b8958be83c55f8636233b4f.1778762495.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0104.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cf::15) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <66d8ec26-3acd-4afe-8a78-747c83901c2b@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|AS8PR03MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: da61407b-8db7-4d98-4f3f-08deb4f9465f
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrNTtvVDcHpkNORC46SFnKisd5OMS3j9T3GvIjejPzpUjwTk5ENAoGalcRfUl/7yogS+VPBMz/b9gNsHqhp3WGsphb62VuT1hQEB/UyTV3uS1I3eqj86MVVZJtVZNDbq6TZ0qCBnH6LEdMRUCaQx/hOhXEqQ19pqIxxa3u8iGSuFluUnbwHxmj68/6KWODeFLsxYKpYxwC6XX5rOaOt+VvTAPRgV7wZqxzDRSWX87Cr9j/pykusYTBnSUAvWfGpHR1Jrx/LhP6bsDUPJdmFQrvvIHH75fmwJWoZbTcAq6hVIkkIJiCgXFJyKen8UKD97L0hka6qKxP0gjXUdvhsZkk8BhWwla094NVRYAHDbMyAdZr7tmzfsMrZh4XCTQstRAzFvh4Sq137Hu15xAp9eatO6KAG3VJnd3oPtdMthemqPKj+W2cQMHB9dNit0P+Do7u3FkuPyal5glx1LLx6E/aAw0WyNCKtgs2r++la7Cr9aEWCXX7JMbjhDAwtXL2gyzHU9ZnzP3OlGyzuaJKMpm4cXMWWpsv8nle281QPQnPs34yCI29kbRnEOvC5DJfey35LhOH0njOkYA+eECQGAnUzD+ZXVoXqhGD8EKCqnlkxpdQbnd+tvjbGlHNZHzKEwx+EJKfY3JLpuMddjhJih/lpqf0FYRKu60kjtIoHU1u2QZk4fXBkChJaMckOHgIsx3Y26gQKsn/5WowG14BB5IUvlAYhtBry5lwHf4YHjXfqJbX4I5A8vCJQVMPly1ABmfYI=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799012|8060799015|23021999003|6090799003|15080799012|51005399006|37011999003|24021099003|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWhLclhvdEhJY0tUN3k0RFBHZTdNS0hHMnk2aVNZMC8wRDdhWENRTXpsN0Jy?=
 =?utf-8?B?SC9USzRocGpjTGg5Y1ROZ3BqNG1PdGJzQUluMkFxb1lGQkdUTDBUOENFM3Aw?=
 =?utf-8?B?cVBGUFUyVGl2cVlXVlgxOTlJSWlSN1g2aExkUU5NU1o3d29sbXprUllUb0Rp?=
 =?utf-8?B?RUhUcnJZbUppRmRGREdrRjRnR3hEL0ticjFpNDhONjgrakVsRDJZQjZuTFJD?=
 =?utf-8?B?WTJVZjlqcTFacm4vTHZZdUFNcXBNM0N4VnlVL3pMbTZwQVBMTVlyNy9EZzh0?=
 =?utf-8?B?bk1GSzVPaTd1dm1ocHpYUTQvaUh1OUxmMGxrZ0U2cHRSaWU5ZEZsaG8zNEJq?=
 =?utf-8?B?UVN6bDZtREZCam5JV0pXRVBFQTd0R0tYN29nQ0Q1RXgwZTBwRXcyQStZRCtR?=
 =?utf-8?B?QTRZTDZBRk8wMThGeG8yUHRZWTFSRWFjQXpvWEg3YlhEUmIxSlU1WEQzaEhp?=
 =?utf-8?B?WTJTMXgxSFNpd2hyM2NKYTFUWE8xbWYxM2RJRURTZjVyczRpb25hUkxtdkZh?=
 =?utf-8?B?M0s2RGxZY0g5MXdWU2s4Wk12ZHJ5ZXUxNitDNTMrZW1XNWU0MjRkbk10WXNK?=
 =?utf-8?B?MVI4aHcyVC9yVG11UVordHlnNnRoZGVmZW45eVBzWFEzMnZWR1hBekpKUDU5?=
 =?utf-8?B?L0lCdXl0dXJib2FCcHdsZ2p3MjJhRk9zTVl4OFd4QVlDaW43TUpRRTc0VmxY?=
 =?utf-8?B?RzBqOGg5aTVxWmY1U2JjTkJnK2xycGFnNHUvc2Y2QmoyWjU5bVNWS1ROb3Q3?=
 =?utf-8?B?S1hYeXg5VUV0OTR1dGlIcHl0aXhNemY3TmRhdkxhYzFaclczRVJ3cTM5ejlI?=
 =?utf-8?B?UzRWUzBFbGVBNXkyQzVJUG5Bb1RwUW5YYlF6L2JJM0NFNUN3OWozTkc2M0Nr?=
 =?utf-8?B?M3RQWmxhV202U3NSM0xpY1JGTnRZdkgxSnQrRyt6cVp6bEsvNXl3eXEvNStl?=
 =?utf-8?B?OTRHbkNBMXdlaTVrT0NwalQwbFdtTEUwRTJ6WWFGb0VIVUwveHZZZTBnTGR6?=
 =?utf-8?B?QjRxYlFQUlI3MDg4UTJtZzYrYURYc0drVWZiYUhwTDlCdlhBOWRCNzFkUzZm?=
 =?utf-8?B?TzhsOGUzZFVGb2duMys4Ukx5TS9lUVpLVCtkVkh6RExFTEJDNVRPWmJRc0pI?=
 =?utf-8?B?T2NLcXF0Mks3YzlVUk96SFcvRm1Yd0tNZ0hzeFB1Q2JKNHNEd3hNSEdnekxU?=
 =?utf-8?B?N2RwanhWdGNsR3pwS1JIQmh4a2piNGRlcHFxT2RuRzBYNVB4MStaL3hQZFNP?=
 =?utf-8?B?L3ZDTW9DR1RkcWJ6M1FaS2JPUm1sNHg5YVVIUlpRNkFBREF4TU9aNlBIbTVL?=
 =?utf-8?Q?D7qdw8dhYzrfPK8osVF4i6vxsqNjelX/4M?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0NtWUNQS1RvTmxaK3EyQytLRlkzOXpGMWZ6RWxjSVZSQWxSeERncWtGY1Ri?=
 =?utf-8?B?cWFpNXd0ejBkNWk1aDhPZ2FPenRHRFl0djVlb1hTUlFJd3U3UU9sZHdqK2JZ?=
 =?utf-8?B?VWg3eDBlRGs3dVkvUmxLbC8vbkx0ZlpDY0lxa085R2NmbzFUNFpaWCtuSjJR?=
 =?utf-8?B?R1NpSTZkWFVYRmlLd29keGhPczlBSmRkTzVqaXZiR211eHl3clFBWUMyeHB4?=
 =?utf-8?B?K3o5cWp6QnAra1NDVkMxKzkzVmlKNXZ3OEQyZldjaEZ1bGtQdWNzcGVFT2ZM?=
 =?utf-8?B?cjdLYzhaM1QvK2lvdmNibWQ5OGNJQ1JjY0RoeDRPUk50MERvT3FPdnNVNzlK?=
 =?utf-8?B?aUwrc1JKKytmTHNadUVwVkVBWDdqZVV3am9OVU1hRlZxbXdBZ0NESzE3Vzkr?=
 =?utf-8?B?cGlHTnpjS2lKVjMvQ25FKzRDbXNyUzJYU2JjZWFiUHFac1BHTzZFVEdTQTEw?=
 =?utf-8?B?MHdrZ3N1LzRMM2gzbE9zVm93eW00R0xocWZtaGdUVVFBL2lxejhzbDFhclQ0?=
 =?utf-8?B?dURQR0dEYTRMbVNwUlpvb2dWMUpVVTJvWG9CODAvaHY1dEhsLy9MY3ZHOHB6?=
 =?utf-8?B?bUt2UUR0U05rT1VhUUozVmx6N1pESGJXci9EdTlCZk1hbWpBZWl2STgxTVgx?=
 =?utf-8?B?UWRPU1VLbEdyUWRGVG1zSW1wazRyUzNWUmMzcjlVMnM4K01BMzJ0YnNQNDgx?=
 =?utf-8?B?eFVmODIrNkZWbFJNSWtyY0V3MlZTaGJIZzFtcG9Sa1NUNlcxY0k1SzRTRnRJ?=
 =?utf-8?B?ZkMyWGtuQWRhbEE5TGVyb3AzY1M0c1czYUZ2Wk5KTW9Vam92cGNZUDh1VEhY?=
 =?utf-8?B?VDJpSHhxRUQyK0I2ZHBGS2JnY3RGdHRsY2szU0hXTWl0VmEyRG1NVzV0WWVH?=
 =?utf-8?B?MWtOenFzRFhIaHMvN1BJT0F5TG51WHRFRFR0V2ZTOTd5bHc4bUFoUVkxRHNm?=
 =?utf-8?B?cFBxTXBYaFNIVHhmRUdocERVM2p0YmdQK3dRd2NZMVhrL1h1VUtUZFllOGZY?=
 =?utf-8?B?Uy82YlR6cThmNTRPd2ZiYnlOMzdNSWlhdkhKOXhIWkthUVp0WUVaSjBXMzkr?=
 =?utf-8?B?Y2FvdGRoZHJHamtjWkNHV1VXcWdXdDRqbHpQU0pKemFRRjcrM1gwS1BkRjBW?=
 =?utf-8?B?TWJhVzROWWpMODlDZi9vVjVyMElhSFd1Vkk2NWFLd3BCR1VTcmZ6MzE1UkpK?=
 =?utf-8?B?MC9JcUk5RXJjM3pnKzFoTjNTTlprWlB6MVdkMTRHTXBrQkdXelNhSklmNXkz?=
 =?utf-8?B?SHNLdHJoQ1c3azBTa0tLZTZ3Mmx3Wm9JS0NNUnVFM3NMelU1UmVLbU5NVWM0?=
 =?utf-8?B?YWZkeldsdjNFall4V3Y5RjQrSmF0ZTRzVkEzSUE2UGhOVEVBcGV6NXVSVlZP?=
 =?utf-8?B?QTFKVWV6eklweWZDK2RqTFlqZGM4WWx3RENKVmFLMk1abEVTeldFRVE1bUdI?=
 =?utf-8?B?d2dhVXlJZlNjYmFpMnNKNndOMXFZbW96TzFESHR3VFJVRkw1RENUYVFHakVk?=
 =?utf-8?B?bGYyNGNFUnFxdXZiQVgvYlRDNVNTSkF1djYzcGRMNmtsdENjeWcrbnNOUHdD?=
 =?utf-8?B?NFhJOWlEZ1RDWGxWK0ExY0RGTE9KTjFtK1BZVlZZVmNtejRyNVIvWmZYa2ZP?=
 =?utf-8?B?SHd4bWtyWGxaa29iYW14TVpSVjdOL0lFWDFPNEJQeWhTK3FDNEZ6ZWdYa21P?=
 =?utf-8?B?cmI4OStGTWkrV0VRbmh2M3c1V2d5QUdiNkRCenJMRDArb0U3dVoySHYxZHZG?=
 =?utf-8?B?MzVBUHNxRVZ2dXU1aStaUW1rQ3JuWjg5UHVaTTB3ZUdSMFcyajg2S2NHbXdN?=
 =?utf-8?B?aGF4OGZOcXJKaGRvUksxZWhHOXk5U0hvcG8vYXcwRFk5RG9MQkJveGwyTHBV?=
 =?utf-8?Q?toYfDmqulF4z4?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da61407b-8db7-4d98-4f3f-08deb4f9465f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:19:45.9624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9935

On 2026-05-14 13:41, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <stolee@gmail.com>
> 
> The 'fetch follows tags by default' test sorts using 'sort -k 4', but
> for-each-ref output only has 3 columns. This relies on sort treating records
> with fewer fields as having an empty fourth field, which may produce
> unstable results depending on locale. This appears to be an accident added
> in 3f763ddf28 (fetch: set remote/HEAD if it does not exist, 2024-11-22).
> 
> Use 'sort -k 3' to match the actual number of columns in the output.

Expanding the message to back reference 3f763ddf28 is a nice change.
Makes it easier for future people reading the history to follow back.

> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>   t/t5516-fetch-push.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 29e2f17608..ac8447f21e 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1349,7 +1349,7 @@ test_expect_success 'fetch follows tags by default' '
>   		git for-each-ref >tmp1 &&
>   		sed -n "p; s|refs/heads/main$|refs/remotes/origin/main|p" tmp1 |
>   		sed -n "p; s|refs/heads/main$|refs/remotes/origin/HEAD|p"  |
> -		sort -k 4 >../expect
> +		sort -k 3 >../expect
>   	) &&
>   	test_when_finished "rm -rf dst" &&
>   	git init dst &&

Unchanged from v3 and still LGTM!

Thanks,
Matthew

