Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010013.outbound.protection.outlook.com [52.103.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2355919ABD4
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749407502; cv=fail; b=EAEQATs6hGqHdyXKHaWCt79XUtejr4og3vkcIomSCK8InUtdx7JKoXF54SGKIVu4HX4fAJWwzu5JuAKMVl72LnchtNsRcPPEYukRnDJ8dNYA9bx1gModw3oMuVWtBfqrsMEyBvflucaTYI/dLcwkVltPUDkd59vlAvLCGjH0UiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749407502; c=relaxed/simple;
	bh=blW3J7CCnlr2pXahZSeUKbKonR3FVgnyXO80QiTjk6w=;
	h=Date:From:To:Subject:Message-ID:Content-Type:MIME-Version; b=TE0GcFxo6eobynZphBne7wex/h1/77SYcI2w/8ZoEqy/g18+53DRvG+vNJN+3CvDXvJETTwWZe2yo80J1R1WWkqx+pkKupeIwqT/hvGY0hZDTlmh6gV579yH+aSt9hrPzPvhXWKrqskBnfJnTk6KNT+hunbtMSBaLya0AI63qfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Keb+S8Df; arc=fail smtp.client-ip=52.103.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Keb+S8Df"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOJL/JFilLDAJYypmH8qFPLYgTmOHZTE2eOm4BHQihbsfN33KnlO1gKFjqCmw2Oh74kTQYg4/qzOvK8Abn3dNl3yY5SiEI/cI8WaYKH4OkoRYrFp8C2JPKe0dJI0TvgLXfoOTknFnCsHUQKp6eQRUN7fNO05kMlNeR+9Qd32mJrehQwqYHQDAsW+MqHh6UIwApTG7JRDQdsZs55BRLa2sT9uuc4xxyrecJ5PWK9lASRD0N9lchTC1tt0IxYgIG1GOLjT5dKA0wIRBQunRzJVrz3I54rQSdV4wukAls+ER+MGxU6dGo8go+PqCCvwHIbVPEIxWXkAWYYiX8PkqwgTHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blW3J7CCnlr2pXahZSeUKbKonR3FVgnyXO80QiTjk6w=;
 b=eJ3Jaa96zuKfKgHHmaFrmwtY6//BtV1p4UqGFwc3dfgbt172ioVVIsrntonDfKBWdbxwS41CK1f0eRLcs+g+jiJmAn3x5oBjFZXZ72QyjT+l13xzvmyt8nHQFcFZjOd2Kl0Ox7a9jgzD0GMAR57Rg7bjXM0DATt2S7nxMICGnE/AvSwamsaEY5t9dyXXEJKDKiMon/a9/sdsTjKGBo5GvTJA/dA84mCCHzqoSyPsQlRGaNNf3klanyyoTzhb1Ki0Q888GqZ3pvC+ARVenv6r6TkxuihnjTksu3Qz3r++q11NMBJzUblVxpybxijIfrSrH/thNwmZUZAR7MiOAuuF2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blW3J7CCnlr2pXahZSeUKbKonR3FVgnyXO80QiTjk6w=;
 b=Keb+S8DfBwG0zav9FrFuNsaUE/oMxaBZ/SI1rsIfOJowzphqqs+m3fbpxiII+Ju0btJ0YpM5W8PKKikPDx8Qb8pYaT88oTJpBLU0pzRox42cLOTOzR4uoiHMAVcmc/bY243Od89i8IdmAmG/R1iCzDTXP4nPICShRw7N4cjAbuNlVGMdu/q1jzvcGYeIjOe7Fnqfy+qIplWA6q8XB3sqX0kDCBfZbPVGbpd+ST3qMF3MuO/8OE+9xlclaXowqE/MC3irX8uJEZVuvxY0QLC7CVt963SCuh8UuVTsXqHSeoLPJw6IaJfl3kv0EyTgyY/gmvIFB1oPQ9l6cw/oBgh3mw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB8163.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:84::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Sun, 8 Jun
 2025 18:31:33 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Sun, 8 Jun 2025
 18:31:33 +0000
Date: Mon, 09 Jun 2025 00:00:30 +0530
From: Aditya Garg <gargaditya08@live.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: =?US-ASCII?Q?Question=3A_is_there_a_short_way_to_merge?=
 =?US-ASCII?Q?_the_last_commit_to_the_second_last_one=3F?=
User-Agent: Thunderbird for Android
Message-ID:
 <PN3PR01MB959708ED22FE7FE70C17C852B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BMXPR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::27) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <86406B94-B7D7-4CF0-876F-B8A922C83EE4@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: ba52281a-e254-4028-e3ea-08dda6bab1cd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|461199028|6090799003|5072599009|15080799009|19110799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFdpeElFK0svUmV1aGJvcXpTS0FydkJCWm1pclNHamxycjEzTWpLT0J5em5w?=
 =?utf-8?B?SWF4c2VlazJXNUp0UFVXdlcwaUloNHJWRGhwc1dyTUI4cy9YdEpQWkltd2Jo?=
 =?utf-8?B?Qm5FajJMaUh3RkRxM2VUQnFGTW96YnJhR2xKQktLdjdGUjdiaGJLalBlamQ3?=
 =?utf-8?B?cFdvd1Rjby8xZHEybE80a3V6N0ZwVnVxVEplZVBmVWtmQzBBcmpqcXF3ZmE3?=
 =?utf-8?B?K3R6YmxtdW1UaHE4TkE2ZnlTMWhNdkI5TjJrQTF6UHdPNjl2a2krVlRCVkl6?=
 =?utf-8?B?TThaR3FyVDJ3NXh4TnpmdWt1bUJ3dzVUUnU5alNPMFJFS1hYS29BeERqR0xT?=
 =?utf-8?B?VUx1KzJQaDRsMjhZR01XTGh6Wm1wT0ZMdUljYlp6SDFhZm4xRWxXSXFHMFN2?=
 =?utf-8?B?Z2FLcUYyVHVDNG4rRjJRUjRyTU5SRjdnYW5ncStRL0JzSHVGMDBCdUprRmVj?=
 =?utf-8?B?czVEZHBBVllaU1laMkovWGludnpTL2VibEx6RDJjdGd2U2NXVGMvZHlIekJY?=
 =?utf-8?B?VWs1R1kvQnl4UHpmcnhseHYxSjlQTlJ6NU9rWjIyNVlQRDhGNU5Xb1BnU0V3?=
 =?utf-8?B?SDlUUjY1a28xeDJJNlgwdWNRSXpaeWdFRURyb3JwRGkwMERVb1huZUcwWnMr?=
 =?utf-8?B?eCtkUk1sRk41REFRbCtsUXd2Q09jU2wxakhueXFyMDcwR1QrWnFLK1p2aW5u?=
 =?utf-8?B?TVB5MUNVTnZhZzR3MFE3ODF2U3JJc3JrNnpRNnJGQ3F5ZFNsMTJZZU5RM0JK?=
 =?utf-8?B?aHppQ0JFUUJ4bWZDQTQrMURIc0U4Q1ZZS3VFTGYrOFdKV1FzbkhqTms5dDZS?=
 =?utf-8?B?QlUyMk1HV1pFRXhrMDlXRXM0UnV5eDBheHVxVDN0OGJDdkhubCt6Y1RxZmZq?=
 =?utf-8?B?dHcyMHRHS2VJa2g2bGovKy9PN2dVSDU4REpyNDE2R0pkV3pEUTVpZTV3VG00?=
 =?utf-8?B?dC95RzJGQW5XNDRTK2FzMXZqdUJDckhNVUZ6R0xWMWZDckoyVXpnMUIwSGcv?=
 =?utf-8?B?bVhXTmh1SWw1VXVqU1oxdFRYRkcvRjQ1WjJvSmZUVW5jbFVnK09Iell1aFZh?=
 =?utf-8?B?S1N0NTVVQmRnd0ZUSlJwVFRXMHpqR2xCWUtqWHh3dkpNelhiT2xiOXpqb2dP?=
 =?utf-8?B?N05KdUJnUlhNRXpienAybjBjS3FzYzAyZ0habStwVEdBUHJqcjZXOVVBd0tp?=
 =?utf-8?B?bnl5bmZoS3NGVXVReHVFRVhjQlJuV3pjYjdxMUZGbGoyUXQ4RXZ2SWFGV01J?=
 =?utf-8?B?UUd3V2hQN25CSTJkM3RmYVhleXRDajd0Q1VhTDlxeHgwWFBVSTFjOXZmQVph?=
 =?utf-8?B?Z1R0ckY5UkNMRDBub2U3QjVoRkQwT0t5OWJwT0VQblhtZUJHbW1IWGp5MTRn?=
 =?utf-8?B?azJzKzdFVDVpbkxEdGQ0RTllbkFMQitRNVp2aDRvTW5TQ1QycXBmVEdnVGJi?=
 =?utf-8?B?YU1tSUZZeVNDR2VuYjhhcDI3QjZFdWhCN05IMUhHS3ZlTk9EbFF3Q1ZGNGRT?=
 =?utf-8?B?YU5acGVSeHJFSUpCTFhJQkN3QzJtQ2xrVWxWUkd5dVI1Z0dsb2tjTGpLL243?=
 =?utf-8?B?aXRJQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUk2OWpqUVJ2cncxWnlSOGZSYzlGVWlOdmQrU1N3SUFvdXdVYVNEQ0FOdmJq?=
 =?utf-8?B?YVNVM2ZGdWdhcCtwZVdXRlA0Zms3a3h6LzI1R0VkTXpES2RJR0dIVWNxUmZF?=
 =?utf-8?B?Y1dmR1dqRUxuRzM3OTJWcXdFUU1KU3RNdEczeTEzdHZ6QllVWGZMZ0FkbUxI?=
 =?utf-8?B?TFpBRy9KVzFEZnFGT2UydUhYZmRJQytqeGViR2xaMWk1M0IzRmJjeFY1QTFW?=
 =?utf-8?B?cDVjYVFtOG96d0FPbllURE91bGlwNWszT29ZaCsvZUpQcDlmTlZFbXk4QXZQ?=
 =?utf-8?B?UmtOdnhyMVFURHIzYUFwNlU1eVNYek1Xa1daUlVoTnlhZXFKeW5QOUZwamVp?=
 =?utf-8?B?K2gzRTZ4ekUvODJ2djk2aXNWSy9ZblRCT0xvNjRrbWRXbHNpdEZSQ0VHZEpw?=
 =?utf-8?B?MEhZYW02cm85NGtqMGwvMkFwY1Y3MnVua2dXbDJ0ZUNMcUN4UUJUS0VIK29F?=
 =?utf-8?B?ZU5rcERZbHdPcXhLNkZsblNRelB4bDRKQVpaV29OQVBRTFQ1ajNoYzZkSzJ1?=
 =?utf-8?B?anZEdlp0NFhaM0dIOWdYQ2ZKMmFDbE5xU0JsQ3hPUC9lSE9peHlnV1NNNHBD?=
 =?utf-8?B?VlZSUnU4aHR1bnBRcWgwZXpRRk9Vc09RaDlNZEI5WTlDQ1E5aUI5bFZxTFpC?=
 =?utf-8?B?aFNjbmxKcitCLzFhZUJBUXl0blJrK1RUTjc3VmRuK1JUbUVZWDUyemVrS1Vj?=
 =?utf-8?B?bnhWTGVkTTlZa01sU2QxUFZDeGt5Szg0dEJkYTcvK0Q5Q0dsRTVtVndOdUVy?=
 =?utf-8?B?Zms5cHplN01yaXp5WVY3b3hqaVcrT0F0N0U2YkZ3NVM4bDB3UjJ6dVN6blBn?=
 =?utf-8?B?MC9Oc0FnbWVhVEhZOVh5TS9vQnNqeG9VM3dDVGVZYmdWVk51dm5zYS9LTWZn?=
 =?utf-8?B?SEg1c1QwRUE3S2x1Zk96Y3BGL1FqK0pNdWljcER5ZEYwaURtZ0QwTjZwdGhH?=
 =?utf-8?B?LzhRRXJsM3dVKzMrL1gybmxSV1o0aWZ6cUtHaUxDbWYvYTV5UTlzWGl4N2JR?=
 =?utf-8?B?QlhWdTJJUzdqSXhJbHlVN2NXMnIrUW5lWEdHNUVDcDZKMWc5ZmlUZ1l1RkFy?=
 =?utf-8?B?OHdDY1ovOTFKZHovS3FpRXFaT3JQN2loOVJSY2dKSHVlUVU0Nkp2QjBXb0wr?=
 =?utf-8?B?ZVpnMVBHY1JBUXhXb2FtekdjZjVld2VWc3VUa2QwbTFqK0hoS1ZBZmlJZkpr?=
 =?utf-8?B?Y2xRemdXc0ZFTnZOQmJJc2VnK1hCNGsxR1M1SExoM05yVnV3Qi85NzMwU3lC?=
 =?utf-8?B?UnZUdDNZRDM2Z1Qwc0EzWlRlVG9wU2NZQW1reFZuT3RzNWVFU0w2d1IvREQz?=
 =?utf-8?B?Z2NjNndaajNURkRXWXlNTnN3aUdSa092MWZ2Ukw4cnl5Uk16MHM5endDekxy?=
 =?utf-8?B?R2JTMVppaUNMYTRPdkw3eGJzT21EQm5OUy9Mazg1bnJ2N0tIc0wzQ0RDOGNs?=
 =?utf-8?B?OUhqMG9wK3Y0cVU1TlJSQlg0UUQ1MHg5Mk5EUFBWUW1LQmNiVURhRTZjUGFT?=
 =?utf-8?B?UUJvVlo1ZklveGI4NEoyeFBzcG5XWEpqWHJ4dHNscWhuSUdGdmx1RUwwWXQy?=
 =?utf-8?B?Q0pRdjZjdks1eUVHc1prS3A0bXR2TEJkVmN0bWxheFpYVWlTZUVHVEJObDls?=
 =?utf-8?B?Z0JGeTJkamN2MzV6UW0rMStMZW5uNysyTU9oZ3hnellWRm5rTlJHVGZRTUlG?=
 =?utf-8?B?bkpCNTdvNVlKSXU1UkNwTGtubHpxdnJqWnRpL3ZnLzJIbWtFRkN5UnVRbkdV?=
 =?utf-8?Q?dPWe/E5CMOEGZIpeAE=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ba52281a-e254-4028-e3ea-08dda6bab1cd
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 18:31:33.6509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8163

Hi all

This is something I usually come across. Sometimes I make a mistake in a co=
mmit, and then I create a new commit with a correction. After that I git re=
base -i and use the fixup option to make the fixup commit a part of the mai=
n commit.

I was wondering if there is a command, like git fixup or something that cou=
ld make this process easier? I know about git squash but I prefer doing fix=
up.

Sorry If I didn't notice any docs.

Thanks
Aditya
