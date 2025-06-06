Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010015.outbound.protection.outlook.com [52.103.67.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D4221E08A
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 20:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240549; cv=fail; b=AKcxRdHoTaojZtjIpIhOxK+YhYIOusnAbhn2vP7kKgaDKHG3KPJe92okpbohFm4PWHSYcgJ3N97SL9hHXR3qkK/RLTgb3OPwt4tRTCv9jeSvGkcAySPF/vmy5PPsKD5Ny5TQXIgOFvJsyNRAkmZlWnJCahNp9Qh688Mg9G04Vz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240549; c=relaxed/simple;
	bh=Fe8LMwED4V3yOyFrEKVtaCrEitEuOEvka8m9saa+Xmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kysTf/J2OS8J9+J0sp48FUY82qSw50K+J0UgdIVnbJ0nFH33EqT+Yyh1SyXNqD91edk7ThF+PwnZpoS60PzrIXVfJ2rsbpVoHvPKOLWazI9mMYG8KrjN3sj+dYl7OUcs4uZ0s+7Uk7oAqDy5H5zHoG6XFGjSTg4yRvo0Dvx09gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=d+r7cN+n; arc=fail smtp.client-ip=52.103.67.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="d+r7cN+n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6c/x0fFUjBMI4YSdMGe5nT+GuWOiM63swt0BFiTrDWoBgTWi4+rCPlZSGdxeHl81xyaM7628M6V1AqHOBeJAKvvBABFs9nxO3GnsctGs/U2YLXXq1wrZcrTLw6FKGRJMp5U196StmG4m1LUDGEtoO3Zbwr3pHem0cvxPCVpMYg1K/u+n8crgPVO0SLaxC6DbL2AOPgr+vVXQNV15lhJvoMcD+UnQdj2UeJJCoQ5/ED+7AkZ8thtbJMbe1HnHLl/LDj44FE8ZuY0O2yvnfZETmeY+WVj+Z0JijfQa0KzdsK46VXKxTuPo18xISVM7r4O0zhCmmQKiF4zGPp2+VK79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEF5TeQEpluE/gkTErOYtqC9UHlY11Vvit16iF2x9jM=;
 b=UertgtL1JGzt8l/V9fRf0Rf6cl4S4QlWfHeM3NYrG3g0D0/NiLoSxRJWldrnvvMYkZyGKpbZbGCzxq8RVgWGkVFkU5k0MTJ92dSGE3GMyvFh4sbw3PbNCWgUyhvgs2COrsCvIxYO4nynkgg7LlJUAl5MNV1WifAej4W2XpMkNhKRoE3dm3RmlFBdz3jbaqT8WLufpCVqv83j57o6X0SXoN8tKSIiwKUdhJJcav2E8s8mOtCXdfDMJazbpawqCKZSe0vXcWJkIuxlaJFGEvmvbTwxZggl+RFIJagKiv8DZD3vcyXsaEUIswX/ZhWYNQ1LsVv8mQAm3ZeLG3fvJswdHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEF5TeQEpluE/gkTErOYtqC9UHlY11Vvit16iF2x9jM=;
 b=d+r7cN+nZ/LQhi1s8P6pghA9w+qAjn5sDAPf7tyN5E6OMnsS/hEzqf78UTkTywy1oJBq8q4jEsgr6XEE7H4XZ8Vp3pOAryXamsI2vzbLRW5luWS1y02hpkjgYMCRpVBt41GM3kOtMQ0kf1spo1gIGAkl7LuieiaK7ZpbjhBXfaxQDs5tBdbl5/jO7dxzcqpmjDCSrlgZuu3Vjd7uJ02JgNgOXwKR2u1cz0WUbVoyoBvMOY12SD9BV8ND+uyRDnbM2uq1jPcrfgaAbpSfaxKRQKfS5vlXmmkcBVTLSsOsrwRz6UfwhnNJoDQ0DLXWU3R7i5zet1Pv/1AEES5WIhtthQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB8841.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 20:08:56 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 20:08:56 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v14 10/10] imap-send: add ability to list the available folders
Date: Fri,  6 Jun 2025 20:06:32 +0000
Message-ID:
 <PN3PR01MB9597C1380DD16748C886984DB86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g0975df9fc0
In-Reply-To: <PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25e::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250606200632.43298-11-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 9266b1a1-aecd-4a2f-89f2-08dda535f48e
X-MS-Exchange-SLBlob-MailProps:
	+b2+gf+2pHRbqC1i4C47eOyZpIxmtSrJ/vJZ1D4HKQiP1jg7Z6IhWHd25oNamO4FqwshOvTgHvRL5HWskHih08zw7LcSBWCj1WGdh/axTbVVx/vno9YbLSp4TcwcG6WVAjf0BRVOLkKKVepAxI6pY/33DW1b8PFvSck9MgRrRKptRYt0TYPNot2NxhZjsiUM9sHtEERs71HCII/8QGNYWoVVLq9D+MSP8lItfa6bNfsssUih16OSYsz+Rr/he4zY2ZwKk/cZpPEWolHTFKSTqjiEse7PB8teaho+APPCwMf3mvStHrDs50FlJ1xICdwztR5lCdAZS8Bx/Xch6Fetrf6cMHvEEFpqPMpGvqLKuLyZhRcuPIwqWoy4P0coVAcgtKqp2zebf1QDz6ON6NoFDdPCwMXhNxtrolgjgiL56isK46jV9uz71wDUn/21ek8NuGehl5H9Z72hwy+4O7SSyJaw25CUsLipwathVf2aYyndjUP9Zv/775fcVuDDuYCh/QQxRkQt7fd5cHnMyLp2IehI5m6Shf/QZufJbcKqRXG8fszjvHva4bvA6++cLGXHLRsRE+hTOHVhc2fFUfr0g16Gx+1LJiZI9s0jr6d5pFRI4y9tKqUuuNDz7iE2tTey42fUKTvr/LBpDqJr0x8Q15MjicBabil73m5XVQGHzaTASs3gM9CoRZxB2K3zzfM3/rmyVLm6sd/Vfy5Qu2B6pd0c3Cy7Oscz+FSyZpBUPgDAUHtpSXuOX805+sz1P76wQ/AktYVUmDZY3cyeUaIXJjdKpCIdloen64qGXRzDfPuzOO3g5GbvJ7WWDZ8W8NX5RD+RDIzSEvCYIGPP6/6n3rUJ5dxMUCJFUHaxihLkjlcYPN1VUjlKNA==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999007|461199028|41001999006|5072599009|15080799009|19110799006|8060799009|7092599006|1602099012|440099028|3412199025|4302099013|10035399007|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ngbouD6cSTMMBJU1/VsfkLo6CTt8EVGUW2M3chDBu5L8yLu7jJg/oMTpDNVA?=
 =?us-ascii?Q?Qbp5JIY++fnpRxVxcKDIcKida8Vutkhhapb8vucvh/xJ1DX6eiaxRfkZPZJZ?=
 =?us-ascii?Q?8tL/bHdY4eOkxjEv1I2ors04xZS0QX2jPdbAyYB+CawXnloJ70agYF07G+AA?=
 =?us-ascii?Q?jGeRAtKwa2mhYxYKrQZSqApTD+olTjdYx9uoHZBMt/PHfKy/jU8muvEI7k4k?=
 =?us-ascii?Q?wFsioCHtX9UdBSg0Xm8QgxBo/58063Ni+FdKtd5+fFpdKrb5xshyfOcFDCQ/?=
 =?us-ascii?Q?ZGTuM+9bbL4ty5ICNxQAR+jfVNsRNSBMCpyief8xGGc9znv8ajpKbgIG3rKI?=
 =?us-ascii?Q?jEvIypTuvhYlrrLSg3Dzi9/GK2UqvFDsexb4kxBaXpGf+UNs6YnjCQ7Ai+CS?=
 =?us-ascii?Q?uG+YOnAXZVL4cu3RYYzVHuNJWCJgOX7SWrm5rogW5Ab34+MXlSgACUDiZ2j3?=
 =?us-ascii?Q?w+SQ2TJ/pKOgXXA5/HwrLj4iC5jTiyKqiLcijvz0sqephyHwifNl94gorkxf?=
 =?us-ascii?Q?fDUjD23vZ91TFN4OxcCv5hm9bFHTduu4zNLcX/xJtMB0b0HsfE/+v4QIla0x?=
 =?us-ascii?Q?+i3yP/PqQbDDOTeteBmuJlbpqXnADpjdWCray3MWSsTc4iiShR2qbyPZhRAE?=
 =?us-ascii?Q?rXlTvh8MpfkxR8SWZwbk/Kqliz41CWuAOfGawXNaUnWLxJGxjtaQLiJYSHhm?=
 =?us-ascii?Q?AnxMeEtxZJxi9NU4lYKjt8f6Hp6pPrCxwQGUGJkPV3Sx97VMgFA1bYQ9zKgx?=
 =?us-ascii?Q?HTCiNjrGKYdFSkI9tTi0ieANXFx0IKqr5MGV1dDi7wFrHTJriBReeVyhKC9N?=
 =?us-ascii?Q?8/t8pyn6CENHzKZ14aVrfRSbFgz2XorXQ2p7HvxydMkTxUTidOA5dnBtHRYi?=
 =?us-ascii?Q?a9GvgGz/lVAmDhNGD0CZymOXlH0UMzWhaMl6DGyyE7IyYSDoO/zbEfT/SjvX?=
 =?us-ascii?Q?AJwdnnEqnvgEuM07RI7WxQSDLasbzkKMBb+COGYczxYoq1xsthUw0CYbN+67?=
 =?us-ascii?Q?SM3hWWOTzXSfEo04A7Evgzr4lBDrLD2FD4OVM1SrR2KyeewSFYeWr2Th+G1J?=
 =?us-ascii?Q?DOJYW/FmD0TKyvIV64pcc10CWo/QhFMLXGA/VHSXOQDN+fbnV8lno1o7K74g?=
 =?us-ascii?Q?j6yUvrukQhHPsLgyHT8cylXdGf+KylgDdZ2BURyG80GqnKef0w8NWzhsPz2Y?=
 =?us-ascii?Q?R+5P9KSFZ4C3c2T9LkE2FxvshEio/HwyoSjby1SEuxphKzTIj/hk0WgH3C/1?=
 =?us-ascii?Q?ofZi+a9yo2fc6V7//iCAEEhlQuWoOpsOkVLbjleX6o5tT9Upd7tXeozA5Sex?=
 =?us-ascii?Q?IkneukQxmB+q7J9OgxGJzHdvPEInMVxj9AJ3MSjdaY6bmg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2GghKkLxZ/L0b9BPdry+b2xZ0dejJcm5POjUX5dhrsHSvOCIiS+BA9QkI1+u?=
 =?us-ascii?Q?Ny0Gs5SSv5Ei2Dx2AY57+v9NSKmalIfTnpetNkoB/NMuzN07LzVP4/rJ8Zi0?=
 =?us-ascii?Q?hKsJPBmpv5iRAyU1bXyccAu0M23JlZSlQ7hU0dStRULEq9ch1nbiwZUeoghr?=
 =?us-ascii?Q?L4r7mqNJM2qL79TK9zmBlcKwJqe5g3LP0glrbxNBP+lzevKJ8rCZqLfDp1ws?=
 =?us-ascii?Q?4luMjpaq4WudbfkSRhNQdFMheYJ0Kki6/P1VGPAM3UtqOubC98dH2PuavRPv?=
 =?us-ascii?Q?trWd4Mp55OJDRaoydIls8WwCxT6ZUe2A8gnWei4sMuy52YQC9QV3SLlruX0f?=
 =?us-ascii?Q?DHgQMU5IrOggtebw9qN1iYLyAxEB32+FZIGp17mkPmdD8zCs9yBFntjw9fUB?=
 =?us-ascii?Q?yhVF2t5XKY6SUgaP12TgCXlUQOlNkpaa5iczvTQ1Wj1geL4t9UT98I8P+4t9?=
 =?us-ascii?Q?Vf1gvBGl19SHbkfrGSSoy+KXdojUUBnRviNQOtxm83m/ZHOnibJRy9vYVhJt?=
 =?us-ascii?Q?HS49zgilmyCSC5teIBofEt+pDGJIM5daSI9jNre4UXICT0QQdFkXcJioFBIe?=
 =?us-ascii?Q?hK5O520wGcA5o8bYgYqvQufwlDinsLsAJm6zC3+MAI2pM18NqPb2u5u4rXC/?=
 =?us-ascii?Q?DNIUNFURNBl+fsnAUSzsQdCBi2DKSMJiaS7/dPdU8MFWY+HKfXf27slBIvCX?=
 =?us-ascii?Q?IncMg8kSmJy0yCoFk/poXjnq4TcEPsuR7JavyteaY6Mgtl+PAWgTZ5IkzUNh?=
 =?us-ascii?Q?aLSUK8Ppef6pGSaUHRlZ9yuDx1jzfbqVxrFFigGYRUTMyHE43i3udD1tAtPt?=
 =?us-ascii?Q?SeP0RfxjnG38Ccuoo1S1uSYFljJ4K9vgnAsxl1mMiObqlVAgx7q302cdARVc?=
 =?us-ascii?Q?w1/XY3rXsr+Ng6/1ZxAIh1MQn4rPEL8tSa7FhvBPJ89kAE9ieajQ2B0mgeYO?=
 =?us-ascii?Q?0mrq14+q1bg84nVRZK4fnqNTHJ55kLL8AoI0XqMimFG+VEzMEMMrphDRUecS?=
 =?us-ascii?Q?h5/Qz7cxqB3rz03tx6oakRgH+j7ED9Dkvy7BSsbvSPB1gszc6EzMf9KZWJZn?=
 =?us-ascii?Q?oAWzxZ3RLSsyqygXswrASVl2u30NyYldWD4L0oOAeU+yM9Ql63GXSqLbZYKN?=
 =?us-ascii?Q?ydaL9vBrGv9g+6+i3gAgNmspKdmZJ0XSOc3BU6/ExocHZMmtYZoJtPMzAKko?=
 =?us-ascii?Q?ooDzbHd7mrJX5ihvLdkCnmhmSRO6I6nbbyQ6qONpkcTLYHStDPCkHiJQSnI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9266b1a1-aecd-4a2f-89f2-08dda535f48e
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 20:08:51.3607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8841

Various IMAP servers have different ways to name common folders.
For example, the folder where all deleted messages are stored is often
named "[Gmail]/Trash" on Gmail servers, and "Deleted" on Outlook.
Similarly, the Drafts folder is simply named "Drafts" on Outlook, but
on Gmail it is named "[Gmail]/Drafts".

This commit adds a `--list` command to the `imap-send` tool that lists
the available folders on the IMAP server, allowing users to see
which folders are available and how they are named. A sample output
looks like this when run against a Gmail server:

    Fetching the list of available folders...
    * LIST (\HasNoChildren) "/" "INBOX"
    * LIST (\HasChildren \Noselect) "/" "[Gmail]"
    * LIST (\All \HasNoChildren) "/" "[Gmail]/All Mail"
    * LIST (\Drafts \HasNoChildren) "/" "[Gmail]/Drafts"
    * LIST (\HasNoChildren \Important) "/" "[Gmail]/Important"
    * LIST (\HasNoChildren \Sent) "/" "[Gmail]/Sent Mail"
    * LIST (\HasNoChildren \Junk) "/" "[Gmail]/Spam"
    * LIST (\Flagged \HasNoChildren) "/" "[Gmail]/Starred"
    * LIST (\HasNoChildren \Trash) "/" "[Gmail]/Trash"

For OpenSSL, this is achived by running the 'IMAP LIST' command and
parsing the response. This command is specified in RFC6154:
https://datatracker.ietf.org/doc/html/rfc6154#section-5.1

For libcurl, the example code published in the libcurl documentation
is used to implement this functionality:
https://curl.se/libcurl/c/imap-list.html

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-imap-send.adoc |  6 +-
 imap-send.c                      | 98 ++++++++++++++++++++++++++------
 2 files changed, 87 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 4a0487b66e..17147f93c3 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git imap-send' [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]
+'git imap-send' --list
 
 
 DESCRIPTION
@@ -54,6 +55,8 @@ OPTIONS
 	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
 	set.
 
+--list::
+	Run the IMAP LIST command to output a list of all the folders present.
 
 CONFIGURATION
 -------------
@@ -123,7 +126,8 @@ it. Alternatively, use OAuth2.0 authentication as described below.
 
 [NOTE]
 You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
-that the "Folder doesn't exist".
+that the "Folder doesn't exist". You can also run `git imap-send --list` to get a
+list of available folders.
 
 [NOTE]
 If your Gmail account is set to another language than English, the name of the "Drafts"
diff --git a/imap-send.c b/imap-send.c
index 9281112bea..16c2e641ac 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -45,15 +45,21 @@
 #endif
 
 static int verbosity;
+static int list_folders = 0;
 static int use_curl = USE_CURL_DEFAULT;
 static char *opt_folder = NULL;
 
-static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbox>", NULL };
+static char const * const imap_send_usage[] = {
+	N_("git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbox>"),
+	"git imap-send --list",
+	NULL
+};
 
 static struct option imap_send_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
 	OPT_STRING('f', "folder", &opt_folder, "folder", "specify the IMAP folder"),
+	OPT_BOOL(0, "list", &list_folders, "list all folders on the IMAP server"),
 	OPT_END()
 };
 
@@ -429,7 +435,7 @@ static int buffer_gets(struct imap_buffer *b, char **s)
 			if (b->buf[b->offset + 1] == '\n') {
 				b->buf[b->offset] = 0;  /* terminate the string */
 				b->offset += 2; /* next line */
-				if (0 < verbosity)
+				if ((0 < verbosity) || (list_folders && strstr(*s, "* LIST")))
 					puts(*s);
 				return 0;
 			}
@@ -1580,6 +1586,26 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 	return 0;
 }
 
+static int list_imap_folders(struct imap_server_conf *server)
+{
+	struct imap_store *ctx = imap_open_store(server, "INBOX");
+	if (!ctx) {
+		fprintf(stderr, "failed to connect to IMAP server\n");
+		return 1;
+	}
+
+	fprintf(stderr, "Fetching the list of available folders...\n");
+	/* Issue the LIST command and print the results */
+	if (imap_exec(ctx, NULL, "LIST \"\" \"*\"") != RESP_OK) {
+		fprintf(stderr, "failed to list folders\n");
+		imap_close_store(ctx);
+		return 1;
+	}
+
+	imap_close_store(ctx);
+	return 0;
+}
+
 #ifdef USE_CURL_FOR_IMAP_SEND
 static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 {
@@ -1613,11 +1639,13 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	if (!path.len || path.buf[path.len - 1] != '/')
 		strbuf_addch(&path, '/');
 
-	uri_encoded_folder = curl_easy_escape(curl, srvc->folder, 0);
-	if (!uri_encoded_folder)
-		die("failed to encode server folder");
-	strbuf_addstr(&path, uri_encoded_folder);
-	curl_free(uri_encoded_folder);
+	if (!list_folders) {
+		uri_encoded_folder = curl_easy_escape(curl, srvc->folder, 0);
+		if (!uri_encoded_folder)
+			die("failed to encode server folder");
+		strbuf_addstr(&path, uri_encoded_folder);
+		curl_free(uri_encoded_folder);
+	}
 
 	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
 	strbuf_release(&path);
@@ -1648,10 +1676,6 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, srvc->ssl_verify);
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, srvc->ssl_verify);
 
-	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
-
-	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
-
 	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
 		http_trace_curl_no_data();
 	setup_curl_trace(curl);
@@ -1670,6 +1694,10 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	struct credential cred = CREDENTIAL_INIT;
 
 	curl = setup_curl(server, &cred);
+
+	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
+
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
 	fprintf(stderr, "Sending %d message%s to %s folder...\n",
@@ -1716,6 +1744,31 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 
 	return res != CURLE_OK;
 }
+
+static int curl_list_imap_folders(struct imap_server_conf *server)
+{
+	CURL *curl;
+	CURLcode res = CURLE_OK;
+	struct credential cred = CREDENTIAL_INIT;
+
+	fprintf(stderr, "Fetching the list of available folders...\n");
+	curl = setup_curl(server, &cred);
+	res = curl_easy_perform(curl);
+
+	curl_easy_cleanup(curl);
+	curl_global_cleanup();
+
+	if (cred.username) {
+		if (res == CURLE_OK)
+			credential_approve(the_repository, &cred);
+		else if (res == CURLE_LOGIN_DENIED)
+			credential_reject(the_repository, &cred);
+	}
+
+	credential_clear(&cred);
+
+	return res != CURLE_OK;
+}
 #endif
 
 int cmd_main(int argc, const char **argv)
@@ -1756,11 +1809,6 @@ int cmd_main(int argc, const char **argv)
 	if (!server.port)
 		server.port = server.use_ssl ? 993 : 143;
 
-	if (!server.folder) {
-		fprintf(stderr, "no IMAP store specified\n");
-		ret = 1;
-		goto out;
-	}
 	if (!server.host) {
 		if (!server.tunnel) {
 			fprintf(stderr, "no IMAP host specified\n");
@@ -1770,6 +1818,24 @@ int cmd_main(int argc, const char **argv)
 		server.host = xstrdup("tunnel");
 	}
 
+	if (list_folders) {
+		if (server.tunnel)
+			ret = list_imap_folders(&server);
+#ifdef USE_CURL_FOR_IMAP_SEND
+		else if (use_curl)
+			ret = curl_list_imap_folders(&server);
+#endif
+		else
+			ret = list_imap_folders(&server);
+		goto out;
+	}
+
+	if (!server.folder) {
+		fprintf(stderr, "no IMAP store specified\n");
+		ret = 1;
+		goto out;
+	}
+
 	/* read the messages */
 	if (strbuf_read(&all_msgs, 0, 0) < 0) {
 		error_errno(_("could not read from stdin"));
-- 
2.49.0

