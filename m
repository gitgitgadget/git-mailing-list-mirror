Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010005.outbound.protection.outlook.com [52.101.84.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5A91922FD
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759147844; cv=fail; b=uwNKwh/zkoqlrsDkSqstW8tGrP+vHJz+EIwaXSEBfJJL7m1kdjzyy2grEXPj92uaV/NpMIkyHVAZgQ68nW/S/BSi/nxBd/m+vy3wfMoo11h9bXL0KQ5xxjqIyaPz0gZS/Tmmcw8OMSMlsyXScD8+oaxAnyjydiXrGwvWfI9wggA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759147844; c=relaxed/simple;
	bh=TPAZbOEMP06v039R0/bE+RyKhqBNaQjcXg+OZpQwr4s=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ki/uQlnVyWLOIF0vgaJwrc8rTxOGewJTBOZqoGUHvl30cCHv/nVNlJYVyz1cT9aRVQI0pzESiF7XQ3D5LUQul2ch8EzMN+DBUEHnnJ8cKObJEo0OKmchU3WlcqJLLSX5iKX6hlFMbc0agkNpB0SDOa69oD2ZZSNfMVYAqI8/ZOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=I9z8umUJ; arc=fail smtp.client-ip=52.101.84.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="I9z8umUJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMo0sgsFBOLwPespkoPYIhX+vkh9ZM6Ph3nnWagTlz2PRujzNfsjW0hh2hPXZxtfx1OgxKY4/EVuDe00tquhBvyhF22AwAK0uoi2vWJ9DNhM1vEBI4LpKb7eCqoRgy2Ko8reg2lscAEnpUbZXlamEJH6iPbOqQneuGgpJOkMQ7ZPvPsuYz5CUe6bY2xSJ3znJAth0HZVH+R/j+pHprsrToUvn+y71ikpoIMMADLQJl6fZoKf5wu3RUPnwmO/tHcKXjD0goc/KTkFQvPdsLVLsXz5CGsv0nKODcQ0ApJzES7UGxEEi++AkXlQ59/pKQ+vnQ//JN+drx5KahwtmS03dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8j8d9J0Wb01puZi5AAq6wcZrdebw6thkzVnW/Jk5k24=;
 b=vpgUl/ganCQibwQMcOLsvEmcs9F5rpR7cJ0UnRXk4/S9H7tYPu2SKAGaiQy0IrpI0zQyA/Umb2IoZuDknRTrQXUfHKUHimY91rECnC60g4FtKeNSFYKwhtJUOv6vPNQf3WXibWP11db4EMdGAS+shrrKzh+mYMpIJQi/qf4KUo1bnR7O4OC6hzI4j5cLbE+z5vz63KVhYJN48pwFeKGvNdTRg6XMwTVRbqD3DrDnhfRkNI/6gdjqkVA0C99ClpdcM4UGnhJ6CTDq11NNNlr4BtfGntIOUGQ4qbuP1LCdGMAd/bwrSR/joGny0Xi4ZGP8gQHs8iWZ0xrTPd2JotbDEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8j8d9J0Wb01puZi5AAq6wcZrdebw6thkzVnW/Jk5k24=;
 b=I9z8umUJdgY1fR5MlgV4+Uaa3YkHh0l77AaU9LrE6qKBdxLjp0GCgXOZZE7NQYUYSmAoxMgcBLZhI+j9ymNCJUqsONitYwRINm7sGZ1+XBu/z0hWmyjKEgUjlleQj5hw8C5mlC7m/DOto9oRuuipkL7GToHl+HADXyNoi3f4O78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS2PR10MB7778.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:62f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 12:10:33 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 12:10:33 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: git@vger.kernel.org
Subject: customizing "cherry picked from commit abcd" comment
Date: Mon, 29 Sep 2025 14:10:30 +0200
Message-ID: <87v7l18nnt.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0031.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::19) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS2PR10MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ec55fc-3136-4e90-708e-08ddff5130b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q8DoEQ+3bgJXF5x0IEXkNXUBJcjaS0ybjf7d6sKPCDP2/yBFd+gsbO8ecK4T?=
 =?us-ascii?Q?ckCvDzvjmN2zEiOt08Wno1mxSsPsNdAR94lzZQoDbFfVK8QdGD2ObW/4G1H3?=
 =?us-ascii?Q?Azhj+Urowfmzo0szJsl5jjw94nl9vqMORp1zvEJfLGuK2VNQbEi8PXATDwVO?=
 =?us-ascii?Q?Dx2pUtlAIKnHCpUll4pgwSB5xOCzyyvitfh2TrQiMXXkiofNAJBy1taIxiTy?=
 =?us-ascii?Q?i8zxDZycT9jg088J7TF7kB0Tc7tVG5IM3xUY0DDVSAiC7FVRmx+LlWNYvtQ5?=
 =?us-ascii?Q?3r2y79qfdRY5zupMj8KfbwOo8cAL2CZx/w83XFf59Ioo2hRvf0+SmiLcl79c?=
 =?us-ascii?Q?vepjvCx4NowF0KPyaqu3PmtO5yD7APEipFMubyRI3Xw85JGgBN4rZ6VUE7cy?=
 =?us-ascii?Q?QqYlB2weNNLJb/BfXSO5mEQJT84gM0p5hOm2G7JAXrayDWM4AOdKK+dBctq2?=
 =?us-ascii?Q?VQLQ3G5gMswWrxw5RiWVte4aVpBmFf+B+Z1pfzjsbNu4Yrd2f7N5QinRQIAN?=
 =?us-ascii?Q?a/1KqLQ3ZH60XnmQyVqXEuVKZa+jGLVZpnxCmp3zWe4t/IOGqCNpDPaoNhjc?=
 =?us-ascii?Q?WCzElKSn4V9IrXYivNqdHy6l+Juk2DoNBWqx9moEdiT/Mb+PKzjhU60gqXOs?=
 =?us-ascii?Q?82k1hSsWrH0ooIBfwR7FfrmVMpjvn/DNkLCIxfZNFpkaU+8RnPw4bQMzXmZI?=
 =?us-ascii?Q?vODjhLm0g9CkT4OExx+/axft/aqjp5uD8b6CxzBVRMdxF88zxFG6NKT0Gmpi?=
 =?us-ascii?Q?8DKzkrVofN9fwo3WnZYGo0AGP0RFMb68ciCDSQtyGQ9yQZk46K74w4CIFbwG?=
 =?us-ascii?Q?ekPbdWAQmjh1+FyH9kwQrBG7LpKT0VAiP33MRtOIDnpK5F3lFG8Hk+SSgAgr?=
 =?us-ascii?Q?Hw25UWxdBEgSbzto0hhYvFbH5wvdHGDTJgXSxo5XSE9o0ChN5hC9d54PBYjs?=
 =?us-ascii?Q?o3gR7XZU/TiMGJyQYmDobeLIPZgd8ltjpkvTtlEd58BGkg9TST0mNDxlozzu?=
 =?us-ascii?Q?TJ9wXV2yXMDTMhEPSYnp0D9FvZZy10POLsiXkuG5DW+BMFVxAzP7JlH33cBC?=
 =?us-ascii?Q?wTbL7qPJY6DZcoYnyglul/WK9z2VqAAvNTfKwH+3VyzynQ+cpuGXw4oTGK+K?=
 =?us-ascii?Q?SLM9m9pv+wxd304zoePx9ZHRPrmmhIY9efEnil74qYgQUITcZd3zZ+QkcqDv?=
 =?us-ascii?Q?l430CYphLIhF8ZmgOMWBUTLaQrUgrsBX8iqIIzHBLcGzSkqN7p9vLQ0I6UWA?=
 =?us-ascii?Q?+Kue4WNlE3sXyLijrWRBblPqdso84ffDs0SKfqNyMrVExxVDrGRAfQrh4xxZ?=
 =?us-ascii?Q?BTAd7uH461p85LN20mngcKrpZtD6Bs4CIgrupPFwoBjM3pC4+KMwcqcqvx2v?=
 =?us-ascii?Q?KF/Q/MeGy1jqLxro4DchRaF5CCPSxCSlfLAK7NXz6I1vCNjNDUgGKW9CLAnU?=
 =?us-ascii?Q?XZbaFNGEdOj1sM54fM6btZWgDM92u2cc7Qt8JJ4CCu8UBgRhEcSO6ZtBr+MT?=
 =?us-ascii?Q?T6AxImfu2/CJMXlGtMQTFWprTMKAEai+ui1c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O14ctipC9UBNJjL/Z+hPQC2IjzAbTzbiEMm3JPHEYpsoNE6MWXSC5Ha9hhhB?=
 =?us-ascii?Q?y8pcjhXCC5pg1FVgLB2jXMd1XKw8mS9cWdry2BbOAQDgpa9pLQR8Gr0MO9Gt?=
 =?us-ascii?Q?LNSVuvRx3WwfdeaS015isEqPCKhMBEusUhFevQCKJ0Vl4mdkrBdz3YZNNaid?=
 =?us-ascii?Q?Bznn3xyosYqqaEmO9pODkLWPLszl13GSrBRp7GS5hnLrA1N464PPZuCdYi8i?=
 =?us-ascii?Q?+1knqHWd2lAB5AevQCTsg3Bfs1wdJbwVmeVH9N8efocZ+fNkV74OGJRrf4Tx?=
 =?us-ascii?Q?mxZjOew0FGSVeC5SFL1AC8MJSshP+YJIy0VjxDijcjyWTgUwyNbQV+Z3hoH9?=
 =?us-ascii?Q?VJzlM8ou6vJ3Xt9S7wmzO8FYnPUxx7BG2llIXqwlNBedKitveLi4QSSfHrVK?=
 =?us-ascii?Q?M3d3ApVeM9ifSeldy/djbCeJmBWpN7WvIIGW61cXDbu4yzYiUUWvuF5Y/CqO?=
 =?us-ascii?Q?MNr61iLEFCZZOINYbVVMMmo+TWpHoscr4L6VrV3S+VzdcX2gWbXnsm/KQ9ic?=
 =?us-ascii?Q?nJ+4TQF3LqpsAZHPoNvkXJQUh29yXKYcO5rJkc8NP7hazNOUnSa23CO3qSYu?=
 =?us-ascii?Q?uN8HOHVoQJRi00DQut1vCkbE9lMXSUm4mnuHWCMM+w/Xxx07MkdV31Dy3l4V?=
 =?us-ascii?Q?eUycO9/8fvjxo+cc+E0PwBcEt0hK74pPucQ2K1t+9M2LA2MqxsNytgYHJHkv?=
 =?us-ascii?Q?oohQyyMY5ZFx4vaviCBZFLEq0rJnWXeG63hc5oYwxsTO4y3gTVq4E5P2EW/I?=
 =?us-ascii?Q?qxRydQYsDTD1fuUzqiBqYk06pGanZkBTgq6OOTfKaPeuWDPrHZt6xL9wM6o0?=
 =?us-ascii?Q?KSzXxTa/BGXrzX9u+wSC7QIIIGvSvY8pleAUj1CrG2FxcHEviW5wn8P18XUk?=
 =?us-ascii?Q?W+8MTaLGDuumsvOWNb2/khmvQ0XNDv7SahbTqquME5QFKdXU2XSg0nCxpCcx?=
 =?us-ascii?Q?72GcVeS8BKEbpR5FVDP0TSxcJJxYn6+83rXbboN1cQog9k7fKXquYhfBH17I?=
 =?us-ascii?Q?aV8dD39B4a0I31+zL0cRyYzO9uefmN5n+FKwiX8COcp1m3+HUR8PVj6nhBAL?=
 =?us-ascii?Q?pDdQyV4LdKGVduwNQghOWcWiR+z9Ro5LLL1C2nsT1Nu/+1NYqhqdmzJXrbSB?=
 =?us-ascii?Q?VkErbktPAVWGkeuX0t8GMvDrrlb4VbfSSh9QtlyXfqhkbm1HmlxHsosz/AEX?=
 =?us-ascii?Q?cQCt770aXcNDS5c7PpMKCEQrXzfQfz0fHDS5fhsT2y2Jzu11WPCQA+i91xyJ?=
 =?us-ascii?Q?ZAbHP31mdkNtFV6OHADZj7cQEKOwOlTQMb/M9hLXYw27W+GyUlEX6Y+gqMBh?=
 =?us-ascii?Q?VBLN7AKuUj8ZM8Y30vTKP8uiJlIpHMSaEuvbhQLWYCQjjO4b808UfHYpoyYz?=
 =?us-ascii?Q?ZHioDfHh/4PaQMfiGsUS40rgqSdXyDwSImDZ4G1UOZiUnXb4TJSomCU+vW96?=
 =?us-ascii?Q?mq3LWK21n5skNLDx9SqsVqhQiubfCwl0mlbgy6Mo2QQW6DdwrYJ3VI0XFy3W?=
 =?us-ascii?Q?d8qYAePu1ceDLLlYEdjPmeRP0glSlCtACqJU23wCjA1RGjzXkyghqTk0Qy7f?=
 =?us-ascii?Q?zgfgOXKafCeSRYvbWUkQvbq8ZsrGC8tYHF3LrMDeCM0fV/PGmN9go2JxvXdp?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ec55fc-3136-4e90-708e-08ddff5130b1
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 12:10:33.3488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9kakm2NxBBEqskoxCBIU+ZFCX0XN8wsGmFHAz5w+gXkQR6Sv6YT0PHQe5yDo5aGQ5haeTnawOt60X9iYKxeZcn4a7VKBtYvgiT4kqwe/a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7778

Hi,

When working on a custom U-Boot or linux kernel based of some vX.Y, I often end up
cherry-picking fixes from upstream. Using "cherry-pick -x" is nice, but
I usually amend the commit so that it doesn't just say

    (cherry picked from commit bfbbd8472edbcff1f530ef8e1d74c56af74ecf13)

but instead

    (cherry picked from commit bfbbd8472edbcff1f530ef8e1d74c56af74ecf13 aka v2025.01-rc2~35^2~5)

This makes it easier, when porting to v+1, to know if that commit still
needs to be cherry-picked or is already included, and also makes it
obvious to anyone reading the current history to know the "upstream
status" of that commit.

Now editing in that, which I get from "git describe --contains
--match=v*", is not too onerous, but I'd still like a way to automate
it. What I imagine is some config knob indicating an executable to call
with a single argument, the full sha1 of the cherry-picked commit, and
using that executable's stdout in lieu of the default -x message.

Of course, it's quite possible that the script cannot find anything
meaningful to say. So one would have to define what it means if it
prints nothing on stdout, and/or what it means if it exits
unsuccessfully. I'm leaning on saying "exit 0 => use stdout as-is, even
if empty; exit != 0 => fail the cherry pick operation", but I can
certainly be convinced that some other behaviour is more sensible,
e.g. having some combination indicate "fall back to the default
message".

Is this something that others could find useful, or is it too niche? If
the former, I'll try to cook up a patch, but I'd also like some input on
what the semantics should be, or if there's some other idea for
achieving the same thing without a custom callback.

Rasmus
