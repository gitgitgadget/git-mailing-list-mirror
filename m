Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010008.outbound.protection.outlook.com [52.103.67.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905341A262A
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 04:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749443377; cv=fail; b=SL8PmZ0g/bo+X2K5LHEej6JOOU2USTGSPC+KDR4KhpXf4Dg8wvzYbp6kcavxPheNISSVSxQ46u0XPT53HnvGGMzeIPnuCXVttOhCw6yBtT5lq73u7kPN/u9K5CWQdtKbmJ+h6Eel+7RdLejf3NgHGFFGFkRKQPiZaZzCHineHKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749443377; c=relaxed/simple;
	bh=HBfnrjQMMXcVwjATTS+Ca6/bRHKNiUfwNIySa0qgbqw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=qs5ZmS23XMBm9RLz/8s/Bsu5RIBuuhY2jXODekwOItPmC573R7pCDoKmd5ErgfP7l5J72mShRcMTc2BuIJF3C8B4kNwC21/uPJvQdmJTidFPawpuSIMrQqHz5TIUgciIeLK0rsOUlSSkhdrvx3KWXrjkYmfuoyy64Q56I8o536c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=V9cm7fip; arc=fail smtp.client-ip=52.103.67.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="V9cm7fip"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aibhdtc3UWLfCLrXbT5dCmq8aoCGAzxD0uDuXZiin9fjFP/YbaKMvSe5Bku+KFAE70B3ldRd8vcuPgOAJs+uTzvO41E66io9AFuUWcsNJ9ixmnmFj/6I+ogdpfOjnxgieVUm+xwt2elGC0HhtdWX8zi/7KBIZtHV3vxzJwL0FTpQVSlIQmVMhRqvNht8KC2gMJC7wg1kp9mliNwRaGaouMXe6L42sXgTQ964tdBj05dxISbW/6Sie+rg3GN2Y0/dho40/zzI+3buXes6l92jg5oy/n0s8AIQYHDy02BRoYU+96tELcXLfUVFmQa46UTL2s36MWQ4mhAzKYhPlYth0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ee09n+JAbGCPyhb1gQyt/nicJ0NvPWIIDq51jkUu/js=;
 b=gkdPdk0sIotMqyY1ULf88nkdoQrrsLgV3z0tiLhVRRqa6Yx3xw95501L4jkmPh8kimAuk+FiTXtQJPhO4ZSJ7EwlonnYEcu2C5ta5YkMI3heuWN1at8TCyvr0IPasrebXG2FTq0yTyIh6MCDbnsX3GDDidnXVowiI/VcgUhSN/aF3S3e7s2ZtOjMYOue3oML/LarEHy5WIeGq2OeJHems9HGtwvMY3iHLhwx+62VXtk874GIw8T0iQLmYl8SAWEp+kJuduDJpmVbv+ztlBSsGKDcslS7LnLdzCsPsB0Kl6AQX3dgZTRnlT8x1rx/Voa73ra1OCevs+zN3WIIStz0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ee09n+JAbGCPyhb1gQyt/nicJ0NvPWIIDq51jkUu/js=;
 b=V9cm7fipCW4drmJkhV7xb86wOZ9Vy9ZeL5do+VSoROmPL/7XPBQAa9VwVWqhEzC103h7pfKfKwuBAVjvnKEq6poGnyWWheMwTH3+mRjvqQ8K7dpbaK9tCMNetzL6MREBv65CiJ+9GfOY/KzhfNGggaGsrZD/ggryhzsyHn/U2BpfJfBbp48DX5Q78pojS/wNePxUPwjWQmYFt4YOQ8ec2qR/g4ZOzfLmC6qjZpLxQ2dXfEBQEI3H20S1XBErhf7yP22JV4RGJvhSISLkDCMhMCsgoyu3tZeLiNoiYL7oxgu2ADYGlAKXtrRMvfkWkPz1LmO3TgKi1jc/PNgHFhTRSQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB9103.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:109::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Mon, 9 Jun
 2025 04:29:31 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 04:29:30 +0000
Date: Mon, 09 Jun 2025 09:59:27 +0530
From: Aditya Garg <gargaditya08@live.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: phillip.wood@dunelm.org.uk, Phillip Wood <phillip.wood123@gmail.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_Question=3A_is_there_a_short_way_to_mer?=
 =?US-ASCII?Q?ge_the_last_commit_to_the_second_last_one=3F?=
User-Agent: Thunderbird for Android
In-Reply-To: <aEYD5X940Li_H7KU@tapette.crustytoothpaste.net>
References: <PN3PR01MB959708ED22FE7FE70C17C852B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <aEXdKMjAbry1aTXe@tapette.crustytoothpaste.net> <993914f7-5023-459c-b1e8-ebec2646e243@gmail.com> <PN3PR01MB9597D380178A875C6FFA90E0B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <aEYD5X940Li_H7KU@tapette.crustytoothpaste.net>
Message-ID:
 <PN3PR01MB9597CBB77CE3EAF054A67223B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PN4PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::9) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <0E8D0AD8-E5A7-4CC5-A6A6-C510EE4BDF94@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 508736db-d6ac-463c-4c0e-08dda70e39e2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|5072599009|19110799006|15080799009|7092599006|8060799009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3hhTS83aUtzV2RrT3NheDRSa2FpcnUzOTlxbGo0ZnEzV1JWdEU5SGxONlF4?=
 =?utf-8?B?RS8vNG5Md3hTTS9YTDBPVlFoOStNMEd3amxSUjY4cDZ4eE1jNURac1QxY3dl?=
 =?utf-8?B?cmcvai9hVE5RYXpBKzE4TjZJTDlwcm9RK0UvR2FUMW1ZMzl1TGhXYjZERENO?=
 =?utf-8?B?a0ZqNS80YmhRRUw4eVRpT0llZWNEbjRKcFRMcE50NjQ5dXo1VUxTei9CbU5X?=
 =?utf-8?B?Y01FMVlkbmFBRVlmMVdXZzIvWWtzcURRV2xqSDFJUU16ZW93d08wWnJPN1k1?=
 =?utf-8?B?TmRLei9FeHdMWjFiMGtWazZhME5BbDdDekd3N1Yzd2h1cWdhbUVzMW8yQkx4?=
 =?utf-8?B?Mi9QMkhmbEo4b2hXMTNJK1Y4RThXUlBRaEYxdXU2ZXUrMy8xejFaTVJjQzF6?=
 =?utf-8?B?cXc5MmZoZnlYYm41ZURGR3JHdllPTWdjVDRKYnYxR3d5NGpyVmxpbmEvVHZ6?=
 =?utf-8?B?ZEVFRFlmU1NUaHRJQ3BBcW9xN2FPUDIyS3pobGVHU0VmTE40ZkhNazl1RDFJ?=
 =?utf-8?B?cVVhNjhXKzlzdmZvSG5EYk5yeVRXcjhoSDBaVjhjaXcwMldxYTJxTDlBUEJm?=
 =?utf-8?B?UjVvaHhZRkhKT2g0M1VManN1QzFWd3JHZ1JXNjM4Z0JianJ2MHo3N2lBMjFT?=
 =?utf-8?B?L2dEMVJXalBhMlBwalVZcUtYWjhaR2lMdWVQdzBKbWJLaEcrbjluOEJGeElF?=
 =?utf-8?B?SUVHN09nREo2RTJ1MnRpbXRuU3I0Vzc2SE1EUkZuVmhlUzhUQkNkOWhNMGlE?=
 =?utf-8?B?M3pIbUFSeTg3RWxFckFpQ1hRcTRjbCtGRHJSQ1drNHNPdW50ODlLdEJxa3VZ?=
 =?utf-8?B?TXF6NWhnZUhIRTNVYnVSQ1kzc055Y3Bob0U5Z013VFJ1UXNwYnVQeWFySUsv?=
 =?utf-8?B?UDJ4Z2FrbklqM3VYd1p6YWs4OXdlWnN0QnZnU083SFFNL0ViYlFLcldMQURJ?=
 =?utf-8?B?SU1TUE1QMllEWnV3YVIwb04zMm1ZQUFuY0czTVFKVUdTbDZONUJJcXp3OFFk?=
 =?utf-8?B?WjBxTjhnREVVenB0ekM3VlJzMWlUb2dtV2REZHRSUEtsRGdKbGkvNmFPZDk0?=
 =?utf-8?B?cGJHOTBPd2pqbmUyRHBVK2FhQ09kRFI3eXdwTjVtSjJXQUNVbXJ3YzNUSXB0?=
 =?utf-8?B?aVpzQ0VSN0F4NTg3UmNkM1FnQVJnT3BjNHhwY1liZDlXd00rRDR1MXVNcnMz?=
 =?utf-8?B?WlpuWHNTUThDTUNjS0U0MXRTdUhHV2dBK2lHK0JLelNSSGk0aHB5Y08xMGZY?=
 =?utf-8?B?ZENjSVB4TDZzZ0lHRDgyY2w1ZmRpNHlwRHFmM2Zwa0laTklETXZLK215WWdB?=
 =?utf-8?B?MVJWOWlrUm1rQ2tvL0VZYXZjTzhvMkhSdGtUcDR1ank0U0oxZHVEcGNWTVVQ?=
 =?utf-8?B?TUNSWENjZUZaRTMzZWZHK1F1eStNcXZ5aUNCamxOai9JKzJ6ZS9UU1lxWFc1?=
 =?utf-8?B?aVQ0NFJPYjhHbmpsQzQzMHc1K1orcWhqUXFUQlB6S2lBaExha0dKcUVrWlhw?=
 =?utf-8?B?YmVFclVwVXlWa3Y2cmdlQ1N3Y1o3YmV4MUUyQXVSMDhSRXpyNEk4U0xZcnRk?=
 =?utf-8?B?ZXo1QT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejE4U0V6ZkRLdzFObEhnM2I3aitPd01vaElPSGQxblFUaFZzc3BielNWZWdP?=
 =?utf-8?B?UlRQemZyNy9NbjlSUjZuN3JKWjFsN3BDRXVpeWlzUkg4aVBIeWFqTFJHcWVs?=
 =?utf-8?B?TkdrQWdCMTBYa3VuY2JjLzZTeFpDdkF0c3d0czRya0pVeHc2bVkvWTk2VU5r?=
 =?utf-8?B?dUdPVTlaNGg4YXd1dUozSXdqTisyR2tVVjZnTnVIY0tnYW11bEtibUFaZVZ1?=
 =?utf-8?B?bCtUNlUyVFJVK0pFT3JvWmdwZmZSTVNhaWJhLzFYT2lrU092WnY2QWJZMm5V?=
 =?utf-8?B?ZEcvN2syNS9naFU1QVl4RlNjKzFCMEhLbWt2cjZ5cmNTelpvWnk4YVdvMUlx?=
 =?utf-8?B?RnMwZ25UNW9EeXVYMXlveDhoSTJWdStWZUpQTGpxSFdYYTZiY2dCcEZJNTBq?=
 =?utf-8?B?dEl2cXpkZFBuZVZlblBYeW9xaXZQa0hYaVR3SHhUVzYzeTJ3NTJybW9LeTlS?=
 =?utf-8?B?TTdrUEdyYXg4NFIzTWV2a2ZETDlycU9jVEV3aEVoenE5SXhoYXdWMTk0SFdw?=
 =?utf-8?B?RTErOHRFeXFlK0NIazNSZ3JvaFYwOC9naEpoUk9LSzloYTNYeUpudFMvQi82?=
 =?utf-8?B?K08zK2g4TWRsbXBKVTRmcGg5V3NJQzlZNmcrWmZkejZKZWUycFErZ0ovZzh5?=
 =?utf-8?B?UjRhbFpSRk5PR3djamdmV05Wa1grT1BqUmd3NUR1QnRDQ0RVZU5zTTFMZWFR?=
 =?utf-8?B?bU9OTHBma1V3WGN4RjJYQ05ZVWM3WEFZbjFxV09NaUhlVStzMUduVnZDeEZy?=
 =?utf-8?B?dHcwV3lFeTBpeWc5ZzJDTEpFc0h6L3Z0cDRNalQ4UFkrWm1pRHBya1c2Qk9C?=
 =?utf-8?B?cHNXL01CUjZsdFI2Kzc3eW4wWDFPM0pJSnRwL0F6RWVnYUxkOTdqNGFOdjQ1?=
 =?utf-8?B?ekJtdlpYc1o5WGg1VUVVMCs2ZEJabkxmT1ZFRjJHOVlMUW80c1NVUVpJek13?=
 =?utf-8?B?emtXMjZ0RzA1OUZvbkRYVWl0R2x5K2NHb3l6TE1yV0kzanJqbGU5VG45bTV6?=
 =?utf-8?B?RGNRSXNJQ3NRajQrd1NNNHAyZ1Q3dk1DSURnMDN1aDJweU5RSjlweXZGSXM0?=
 =?utf-8?B?N0k5T0o0QmhVWlh0Q09vN3NNM1IxaGMvbzB4VW11VEt5K2RQWktUci9kZExZ?=
 =?utf-8?B?dzR1cStJb1JnVXk2aVViT1ZhWUxBekRVenZZWVZKM0hqb09La3JLUUlabmtX?=
 =?utf-8?B?OFZaSWtKcG0rU0dSbzZLR2tEaFprRERZT1Q1Q1lYZWwvdlE1ejVIT3REcWUz?=
 =?utf-8?B?UDhwUXk0TU9ERGdFOHcvQjVZWFp0S3Q5ZlZFS0gzbVRGVU5nY2V5RzcydFhI?=
 =?utf-8?B?OVhqaHNtdDkxRTZjdnM3eWc5WVZrdWxPanR3bmNod1NWRUU2Q3NaeExzQU9a?=
 =?utf-8?B?S1R4WHF4Q2pnWHpEWEtuUjZrYldUdkh6RTNtdm1JTWgvbDBFTVhIL3pmREhP?=
 =?utf-8?B?cCtGYTB6MTRBdUpDZm1OYzF1VTNrcVZ6QW9VVHhMNUs2a2VDSGkybERIR1Rh?=
 =?utf-8?B?ZHB1ZXJ5Y2hpR28wMjZJUFBuY1dxT2lFQlRQMVNacXZtQ3B5SmNjTUV1RWJo?=
 =?utf-8?B?aS84YUlHWS9iVEVUb1lrbWhYUXFkQUhmNXY1ZlE1TTNHQVE4and4UHdkUnZw?=
 =?utf-8?B?NHdOK1A0RUFqNUZBbGltSkhhNlhVVGJqZlZVc0pQcXVEUzNxWGIwT1czbmw0?=
 =?utf-8?B?SVY3dW1NSlp0ZU9Gb1dQWnl6bnhUbFRyVnhQN25pdWR6ckRKNmhqV001Ty9m?=
 =?utf-8?Q?68exJ6KSuw28IB6VIg=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 508736db-d6ac-463c-4c0e-08dda70e39e2
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 04:29:30.2842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB9103



On 9 June 2025 3:13:01=E2=80=AFam IST, "brian m. carlson" <sandals@crustyto=
othpaste.net> wrote:
>On 2025-06-08 at 19:35:24, Aditya Garg wrote:
>>=20
>>=20
>> On 9 June 2025 1:01:19=E2=80=AFam IST, Phillip Wood <phillip.wood123@gma=
il.com> wrote:
>> >On 08/06/2025 19:57, brian m. carlson wrote:
>> >>=20
>> >> If your goal is to just do the fixups and squash and not anything els=
e
>> >> interactive, then you can do this:
>> >>=20
>> >>      GIT_SEQUENCE_EDITOR=3Dtrue git rebase -i --autosquash
>> >
>> >Just a quick note to say that since git v2.44.0 you can just run
>> >
>> >	git rebase --autosquash
>> >
>>=20
>> Silly question but how does it get to know what is the fixup commit?
>
>That's actually a great question.  When you do `git commit --squash
>REVISION`, it takes the summary of the commit specified by `REVISION`
>and precedes it with `squash! `, and for `--fixup`, it does `fixup! `.
>
>Then, it's just a matter of re-ordering the squash or fixup commits in
>order after the commit with the corresponding summary.
>
>So with this shell script:
>
>----
>#!/bin/sh
>
>git init --object-format=3Dsha256 test-repo
>cd test-repo
>
>echo abc >file.txt
>git add file.txt
>git commit -m 'Initial commit'
>
>echo def >file.txt
>git add file.txt
>git commit --fixup HEAD
>git show
>----
>
>You get something like this:
>
>----
>Initialized empty Git repository in /tmp/user/1000/test-repo/.git/
>[dev (root-commit) 7327102] Initial commit
> 1 file changed, 1 insertion(+)
> create mode 100644 file.txt
>[dev 8bdd271] fixup! Initial commit
> 1 file changed, 1 insertion(+), 1 deletion(-)
>commit 8bdd271b6d4e22b7ca697c2d4499fd3e0825977d7d2c917b92e1f1f12383f52c
>Author: brian m. carlson <sandals@crustytoothpaste.net>
>Date:   Sun Jun 8 21:41:43 2025 +0000
>
>    fixup! Initial commit
>
>diff --git a/file.txt b/file.txt
>index e0ef420..559afde 100644
>--- a/file.txt
>+++ b/file.txt
>@@ -1 +1 @@
>-abc
>+def
>----
>
>Of course, `--autosquash` does require using `--fixup` and `--squash` or
>otherwise naming the commits that way.

Now it's clear. Thanks a lot brian and Junio!
