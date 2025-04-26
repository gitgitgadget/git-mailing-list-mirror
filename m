Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011038.outbound.protection.outlook.com [52.103.67.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194221547FF
	for <git@vger.kernel.org>; Sat, 26 Apr 2025 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745656629; cv=fail; b=LS8+gRJdqhJXe6j5CE9/pspHIsSOPqj2BsvBQicd8cbMckI4LHNtz8lh2d6kpEnBnPEBNxey9EBxNKd0TqXx+JDwmB+HjyDCmn6gpmtmBMJ91q798jUCuKM75rf386y8RbxRS3alMuqdwhn/FdrgroOmWUf5AYEZld+szxUvbJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745656629; c=relaxed/simple;
	bh=imsCU422pr+nwtKDFoR7aB96GpDv8EQOlcxwSeyl7IY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F/uixgDHM7k18hMZ91zQG8fA9/7wlRMWJCs4wXt3Du2Kbje/oLeG4FwNOcrsrLmrXaaD9SWD/aiVpn+9GzOjlkuNXhBxVPQuW5NtDX1mM1keWcNIueN3SoCA3nL1Krf8UuVcrkzvlXaPk0xvaHBkOEJRPEuBlXD9ST0EIZsVMAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=HpHGvNGH; arc=fail smtp.client-ip=52.103.67.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="HpHGvNGH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FH1fp6dNQCn+1NDH8k/mdwtYbAQj/n5OdEjlFBxseu/4Ic7jLjRFx+0d0w8K/23B47ykkjPO/fMpqwZIzqBCaz2Gh9AOwSABlta4tztIFBLGwOksVoBWMT8uH6cnx5WvU6EKnmDrqEwasn28/gQkoaMe/pdStsHGlsx7ejf7ePfGr9ppKEApKcmzcNiDAd82ikaDYkenH3/MRr2JQxW+upcgX71OjObSWuHzmxfx/0tpQhxjCdl1gy7UdV/3ZtBbQEL7QIUMqu/3C2/lJjYaERT7J7KL8MRnpuq3DjBRxPChryXoAf1S2GXSlJAhkYJV0pUKpVndFsnr8uN4DW3Gaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8Nk4NowxMxRX9LCJQsZPPPGylybHfC2sjaGrY9ip0c=;
 b=ch6I+R/9nd6ZofjvxflbZvAIize820NX4y6mdqPDHgc3SHTxqyBG1oYQTphuzgg2TjVbAOIkiUHmVbyz+hBPQ3gwHWpjLotJZNVXZX4yeL6c5W8PMHit22lqA1DaxmPHK1rOBCCJZmnURZ5WaI3jQCpc/ZyUPwPT3jjgUeLHaNN7t6eoA3SD8nz8t4iIHamPW+X4oPkekd/msQBGsipTTQeTbz7H7OmnG0S960UEexHY4/h2Wsa8hjNSrMERJBdFX9ExvbOfj3kECcZPeQksositXt9Znl3vcap83Ari+m3tr1haayU5lN/FI33QLqhXYtCrCWUOxDvxUFVLmGFL2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8Nk4NowxMxRX9LCJQsZPPPGylybHfC2sjaGrY9ip0c=;
 b=HpHGvNGHaUDcMta99ZWJroJV0RXVVTpueHqarCgKpSgrWDzn5qIq3jawTg/FLcrIlqH5f0unr+u5NDqt7s8I4tMWIf0Sw6L3xnH+PpXmQfvTakm9SfAZIPdpESH9a2Hg51IHi7IyjNyd43/jOv2TV7BvAja5IzNDfhgRcT3KvmlZNglqFwmK4VIaxi13H+AfUl5wwLuydSFreRPFZFEQ6fAnxDaKIvptSbsmT7QFUqaKmHcOMR+ea1QwwSFk8aEW6luVW7/d5INnXX+OgpY8aZIFXThnxAnUpiEbFaCEMhWFkiCnNukS7RD+ZVP15tqoTSya+LDjV29BQv1zYm1jpg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB8773.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Sat, 26 Apr
 2025 08:37:01 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.038; Sat, 26 Apr 2025
 08:37:01 +0000
Message-ID:
 <PN3PR01MB95973B932F4961FFFA9786CBB8872@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Sat, 26 Apr 2025 14:06:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] send-email: retrieve Message-ID from outlook SMTP
 server
To: Junio C Hamano <gitster@pobox.com>
Cc: Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org,
 M Hickford <mirth.hickford@gmail.com>, sandals@crustytoothpaste.net,
 Shengyu Qu <wiagn233@outlook.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Erik Huelsmann <ehuels@gmail.com>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95973F4B26A8CE2BF17A3AB1B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597A549B8A6752F2F828266B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqikmstatc.fsf@gitster.g>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <xmqqikmstatc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0124.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::10) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <cdb2e924-90d9-4015-ab4d-6dc2fa2fbf62@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d477da-1aaf-4d9c-f532-08dd849d83f8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|5072599009|461199028|6090799003|19110799003|8060799006|7092599003|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDgzR0VkT25ibDEwSWpEWHhBL05ySHZ6U0poSmFGTmx4U3U3dy9VVXJ6ZzBE?=
 =?utf-8?B?c3lBRk8zL3czMWYwU1FxWHI4ajdEMmdOcXlxZFFJRFJ1LzFKcWhaeDZpYUw3?=
 =?utf-8?B?SmVCdnhiL0FFb29rT0taY3kyZ3Jrc0I3eXplM2gzckJDMTBlVGs1bytGZERx?=
 =?utf-8?B?ekd1Mlg5eFIyVUliNG1lT2Q5SjA3SGlyUCtFeHdYbUJwSldHcHdoSWN4eUhL?=
 =?utf-8?B?N1YrZHJWTWVDS0t3SVhsODBWampXY1FLYnA3bXE2VWt4TkoyTENhTDNyR3pm?=
 =?utf-8?B?OGhKdkFsSS8xRG1uc0FVQjVLREpOMFdYTzV4ZUZJODZmWFpDaVRKbHk4UnZ2?=
 =?utf-8?B?WkVnT0R2a3dYSzZJekxtalZqQ0dwL1BUWDJ5dndDM0ExNDVsVnFqYWlTV2hV?=
 =?utf-8?B?MGRQRldQRjJoQnROM1JEbTdkcmdqM2RjdjRhekJYdFFUSWRRcmRtWnNtQ3o5?=
 =?utf-8?B?NDlORmRyOE5RM21HUmNOaXNEcHdZc1dpMWFJOFhSSXNRZHN5SHlSdXNpcGR6?=
 =?utf-8?B?aDhScGpjZ0RzL0NPcFFFamxKcUIrOW5QcG84Y05PZE1YZGVWN21NcTg3UXV6?=
 =?utf-8?B?RnRVeEU1b1F4dlZ1QzFheXJzWkFQK0pGYmNMYldNcTFQbG1CRHpuSVptNEk0?=
 =?utf-8?B?SDBTSDh3MkhjTHcrRXhSTy9xUi9UTkRwT2k0cGt1OXhhMFlhVW9YUlUvUW81?=
 =?utf-8?B?Vkg0RW8zc0NnRTI5V290Q2VsdkVwTWxnVDN0Zk1DRjNZdnZvOU5wQ1drditY?=
 =?utf-8?B?VU9mWnJsTnBMdFl5VzhDc0lFdURvMVhUUkhrL1dkbzg4NjhoOU15a3BlakxG?=
 =?utf-8?B?ZDZPV2dCVTR3RkxMWjZtUThhSzdhY2FVSU9uZW56M0dKN0p0azY0TFZwcTZq?=
 =?utf-8?B?VFV3Q2J0SFhlMk5DNnFOR25acmJyT2N6TVgrSFhrT0xaWkN3U0ZkSjRPOTlL?=
 =?utf-8?B?K1Frc3BqN3FsNElHOHBtamdqdkU2dU5uQkkxNVF4YzNqcmZrWEY3aEh0eXdp?=
 =?utf-8?B?NzZhMGlGNkdsRnFJQ2Z3WkIyZUlUVkpITmdjbGFUYnduSm5vZWR5TVpqZmtG?=
 =?utf-8?B?S1YwTmJweWN1OXhIOE95N0Q4aTNZWVJTVGV4U1pTckxlRnhDaS9TQXRvMlhF?=
 =?utf-8?B?UVZ1Y016ZHlscGdlbUk5dTdVVDNBWndjaDhxNDVJWmtpeFc1WTZRckhDNUFO?=
 =?utf-8?B?WG9kOU1FSWdZdkt5eWZISDIzbzlUWlNrM2lUaXJZT3g1NmRYN2FpRkx3UnZM?=
 =?utf-8?B?dklSaHk3Q3pBZjBKUTVjUHkwMTA4dXdRQ1h0bWI4akptSFd4KzBtc1VzM2g4?=
 =?utf-8?B?UTArellTOGJPMVpUcjRQQ1hKTU9hWXFncnJVOHdDVEJzSHRjaUZCWHdzTTlD?=
 =?utf-8?B?ZXlVenhrOWU3R1ZVTktucVB0RmUrVFkzTEFGZmwvcUxaSVVDMkNZVHI2Rk1B?=
 =?utf-8?B?SGd0d1NkUm1NRzZXN2IyZHdjTEJFeUR5d20rN1RCblhvemJaRlJSbGorazRL?=
 =?utf-8?B?TkRBUWdCOEJtNHNEZ2hTM0oxalFwZHJ6ejRTdFlLVytBWU9qWkFKZlBLVFhE?=
 =?utf-8?Q?F2ro4WWx54s6FWTeZ5q/ttGic=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG9tLzFkMzNFTTRhSW1nMzhsUXYwcVEzOGZONWNobWgwZnZGRmVtVmc0bnlt?=
 =?utf-8?B?TWFFdEF5c2gyby9WMllFdjJPOGsxK1lBZ0xsZ1ZXN3VqeUdqTWlnc0hCSm1H?=
 =?utf-8?B?OC9SVTM2WjFRRjAwRHpScEp4U1pOOXZ0Wmg5d0hMM0Exc0xxRnNlbnp4OHh2?=
 =?utf-8?B?Zm1qWkJ3THZSUkoxNlE4SHZhMExsS2M3TUpteGZVazc1a3hkSXd5YlU5NDV6?=
 =?utf-8?B?b3hoeW9EVC84SEl5dGJqVlY0MC9GWlppMHV0b213c1dLMEVUTS9LSFliYWlo?=
 =?utf-8?B?cTh0UmNCMFkzQ3VxVW9oZFdPS1pmNkkrT3NTMFBqWDZleU5PNEsxR0ZNdklW?=
 =?utf-8?B?cjFwcHNlOUl0Ny9jeVBLRThuQ3RrMlBreDhUWUtyY1NsU2hNdG5RQUIvU1dV?=
 =?utf-8?B?Z3R3ZmNJdWdkNC9POXlsbFhvMHBsRXlqWlhUakdnV0xCekRWaVpWRzJFYmZC?=
 =?utf-8?B?YnJQbWxUallPaWtvNHA1TjV4b2VJK0g5cHROc1FqMGwrTjZ3VFNIeGNQR1Vq?=
 =?utf-8?B?QUhGZ2FXVm1Yd3ErNHR6WWRzREJpSmpaUlBZaTF3d2JxRUVOazhDUVZEaExZ?=
 =?utf-8?B?Szg2bm5QNWlWcjJmQmh6R1hKVnFySFZQV3JwTnJvd3oySVhRL0JnWGdUa1Z4?=
 =?utf-8?B?TzhTT3ZwKy92eGFJekZlMHVpQkp4bW1wWnZkU3lhd1FvWmlJQVRETzFsM0Y3?=
 =?utf-8?B?YXo0T1V2ODRTd1crVXNrcm5ZQ3pVaGNPRTVleEYwL0FxWVlFYWN3dTlSeWkw?=
 =?utf-8?B?ZkZ1Rkx6aXpQSW12TmlTRzZIT3lDM29oUC9JZThEc0k2aDdXb2tvZGY2eGNY?=
 =?utf-8?B?Sy9UdlQyd0tHWC9HVE5aaHd6c0l1eGJlNTZGOEdSYzJRalh2dXJRWHgxUTJK?=
 =?utf-8?B?YU5lem5SS3A5S015bDJYRk1wcXhrMC9wQlVhOGsvbXF6U3NCKzNndHAxNFF3?=
 =?utf-8?B?Q1E4MUM0eDJWeWFLeFFadEVkOE1nN0xxZGRhMnhRTjlxUlcyTk02d3luZ0lH?=
 =?utf-8?B?S1F2OG9UZzY4OEF3Y0dtaUJDbEJMMGxzbEpWLysvbTlNMmgzUEVDMUFYRzdv?=
 =?utf-8?B?Y0M0ZkdDSEExY2RZU05OTllUUFNNOUdNWU1qZ2RNaExPYmpKS2pPN1FzSW1w?=
 =?utf-8?B?N3A3dmt1NTRGaVVCWjRXL3N1bjJNS05YNERlbyszMnZTVUFMWHY0a3pNa0pm?=
 =?utf-8?B?S0xWMHRkd0N3NHVQUXduNm1sQnNlSGhBRzlrN1BBenZSYllzRVhZditSUVZ5?=
 =?utf-8?B?azBqTDl3K2EyYXhzdkc3OTUveS9Ca2ZMbE5WZ09HUk9jZ0kwcEFHWG1SWFVr?=
 =?utf-8?B?ajlVbGYrQWZ6M3FFUDQyeWgzRGpINng4QTQwRnYvOVI5MnJrOGNNYTl3c2hU?=
 =?utf-8?B?WFFINVJBWk1Fbm02cHJpY0NWWEJTamJhbXF6OTRYNlVmeW1SSkNrRHVYOGd5?=
 =?utf-8?B?czJoQ2V5Rndac0dSZkZMdHJlb3YvY0FkTTdBTUFHcE12K0NsdFcwVXo2ZFJK?=
 =?utf-8?B?Z0ZMUm84bHc3ZWREa1RlRXRYbnViWlpiUTR1MHNBVVgvTXhWUCt3eG1nNC9M?=
 =?utf-8?B?cHlWZDhUWFlPdjJTbGVvaEtiS3NBL1AzQmJpNjZhVGwzc3A5OVM5Z1JVZzVa?=
 =?utf-8?B?L0JvdE1lWElOd1pzVnFYSCtUYmU0MG9SSTJmakxEU1J3SnUrZ21yVmZVOVJ1?=
 =?utf-8?B?eDBDNjFVaEtvcXRUYnFHQ0dPZ0MwZVZBTkxBdEJuZnZvbldGSzJxVm5jYnYv?=
 =?utf-8?Q?0KgVYrrSBurhuxZTYA=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d477da-1aaf-4d9c-f532-08dd849d83f8
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 08:37:01.7460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8773

Hi Junio

> There were a few messages that raised concerns with respect to
> on-prem installations of Outlook based servers, where the hostname
> cannot be used to tell if we need this message-id tweaking.
> 
> The following is a completely untested patch, but it should be
> sufficient to illustrate how simple it would be to support an
> option to do so, if we cared about the issue enough.

I tested this patch and it works well. I've added some docs as well and it now looks like the one below.

--->8---
From e06ccabb5a0cef100e50e2b9d6d3c0a1769bda59 Mon Sep 17 00:00:00 2001
From: Aditya Garg <gargaditya08@live.com>
Date: Sat, 26 Apr 2025 08:25:25 +0000
Subject: [PATCH] send-email: add --[no-]smtp-outlook-id-tweak option

From: Junio C Hamano <gitster@pobox.com>

Add an option to allow users to specifically enable or disable
retrieving the Message-ID from the Outlook SMTP server. This can be
for other hosts mimicking the behaviour of Outlook, or for users who set
a custom domain to be a CNAME for the Outlook SMTP server.

Co-authored-by: Aditya Garg <gargaditya08@live.com>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc | 15 +++++++++++++++
 git-send-email.perl               | 11 ++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 7f223db42d..8a84fd4342 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -421,6 +421,21 @@ recipient's MUA.
 	`sendemail.mailmap.file` or `sendemail.mailmap.blob` configuration
 	values. Defaults to `sendemail.mailmap`.
 
+--[no-]smtp-outlook-id-tweak::
+	Outlook servers discard the Message-ID sent via email and assign a
+	new random Message-ID, thus breaking threads.
++
+--
+- '--smtp-outlook-id-tweak' will attempt to retrieve the ID from the server
+  irrespective of the SMTP server being used. Use only if Microsoft is your
+  email provider.
+- '--no-smtp-outlook-id-tweak' will disable this tweak irrespective of the
+  SMTP server being used.
+--
++
+If not sepcified, the default behaviour will be to enable the tweak only if the
+SMTP server is 'smtp.office365.com' or 'smtp-mail.outlook.com'.
+
 Administering
 ~~~~~~~~~~~~~
 
diff --git a/git-send-email.perl b/git-send-email.perl
index 618474916e..0fb3ee98cf 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -60,6 +60,8 @@ sub usage {
     --smtp-user             <str>  * Username for SMTP-AUTH.
     --smtp-pass             <str>  * Password for SMTP-AUTH; not necessary.
     --smtp-encryption       <str>  * tls or ssl; anything else disables.
+    --smtp-outlook-id-tweak <0|1>  * This server munges Message-ID. Retrive it from
+                                     the server and assign to \$message_id.
     --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
     --smtp-ssl-cert-path    <str>  * Path to ca-certificates (either directory or file).
                                      Pass an empty string to disable certificate
@@ -290,6 +292,7 @@ sub do_edit {
 my $mailmap = 0;
 my $target_xfer_encoding = 'auto';
 my $forbid_sendmail_variables = 1;
+my $outlook_id_tweak = -1;
 
 my %config_bool_settings = (
     "thread" => \$thread,
@@ -305,6 +308,7 @@ sub do_edit {
     "xmailer" => \$use_xmailer,
     "forbidsendmailvariables" => \$forbid_sendmail_variables,
     "mailmap" => \$mailmap,
+    "outlookidtweak" => \$outlook_id_tweak,
 );
 
 my %config_settings = (
@@ -518,6 +522,7 @@ sub config_regexp {
 		    "smtp-pass:s" => \$smtp_authpass,
 		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
 		    "smtp-encryption=s" => \$smtp_encryption,
+		    "smtp-outlook-id-tweak!" => \$outlook_id_tweak,
 		    "smtp-ssl-cert-path=s" => \$smtp_ssl_cert_path,
 		    "smtp-debug:i" => \$debug_net_smtp,
 		    "smtp-domain:s" => \$smtp_domain,
@@ -1576,7 +1581,11 @@ sub gen_header {
 
 sub is_outlook {
 	my ($host) = @_;
-	return ($host eq 'smtp.office365.com' || $host eq 'smtp-mail.outlook.com');
+	if ($outlook_id_tweak < 0) {
+		$outlook_id_tweak =
+			($host eq 'smtp.office365.com' ||
+			 $host eq 'smtp-mail.outlook.com') ? 1 : 0;
+	}	return $outlook_id_tweak;
 }
 
 # Prepares the email, then asks the user what to do.
-- 
2.49.0

------


If you want I can officially submit this as well. Would also have to add your Signed-off-by?

Cheers!
Aditya
